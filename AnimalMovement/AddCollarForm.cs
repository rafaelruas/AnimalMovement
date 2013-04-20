﻿using System;
using System.Linq;
using System.Windows.Forms;
using DataModel;

namespace AnimalMovement
{
    internal partial class AddCollarForm : BaseForm
    {
        private AnimalMovementDataContext Database { get; set; }
        private bool IndependentContext { get; set; }
        private string CurrentUser { get; set; }
        private ProjectInvestigator ProjectInvestigator { get; set; }
        private bool IsProjectInvestigator { get; set; }
        internal event EventHandler DatabaseChanged;

        internal AddCollarForm(string user)
        {
            IndependentContext = true;
            CurrentUser = user;
            SetupForm();
        }

        internal AddCollarForm(AnimalMovementDataContext database, string user)
        {
            IndependentContext = false;
            Database = database;
            CurrentUser = user;
            SetupForm();
        }

        private void SetupForm()
        {
            InitializeComponent();
            RestoreWindow();
            LoadDataContext();
            EnableCreate();
        }

        private void LoadDataContext()
        {
            if (IndependentContext)
            {
                Database = new AnimalMovementDataContext();
                //gets repointed when we requery Database.ProjectInvestigators later on.
                //ProjectInvestigator = Database.ProjectInvestigators.FirstOrDefault(pi => pi.Login == CurrentUser);
            }
            if (Database == null || CurrentUser == null)
            {
                MessageBox.Show("Insufficent information to initialize form.", "Form Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                Close();
                return;
            }
            ManagerComboBox.DataSource = Database.ProjectInvestigators;
            ProjectInvestigator = Database.ProjectInvestigators.FirstOrDefault(pi => pi.Login == CurrentUser);
            IsProjectInvestigator = ProjectInvestigator != null;
            ManagerComboBox.DisplayMember = "Name";
            ManagerComboBox.SelectedItem = ProjectInvestigator;
            //  first get the default, then set the datasource, then set the selection to the default.
            //    this order is required because setting the datasource sets the selected index to 0 triggering the selectedindex_changed event
            //    the selectedindex_changed event saves the user's selection, which when setting the datasource, overwrites the user's previous
            //    default with the item at index 0, so initialization deletes the user's preference.
            string manufacturerId = Settings.GetDefaultCollarManufacturer();
            SetUpModelList(manufacturerId);
            ManufacturerComboBox.DataSource = Database.LookupCollarManufacturers;
            ManufacturerComboBox.DisplayMember = "Name";
            SelectDefaultManufacturer(manufacturerId);
        }

        private void SetUpModelList(string mfgr)
        {
            string model = Settings.GetDefaultCollarModel(mfgr);
            ModelComboBox.DataSource = Database.LookupCollarModels.Where(m => m.CollarManufacturer == mfgr);
            ModelComboBox.DisplayMember = "CollarModel";
            SelectDefaultModel(mfgr, model);
        }

        private void SelectDefaultModel(string mfgr, string modelCode)
        {
            if ( mfgr == null || modelCode == null)
                return;
            var model = Database.LookupCollarModels.FirstOrDefault(m => m.CollarManufacturer == mfgr && m.CollarModel == modelCode);
            if (model != null)
                ModelComboBox.SelectedItem = model;
        }

        private void SelectDefaultManufacturer(string manufacturerId)
        {
            if (manufacturerId == null)
                return;
            var manufacturer = Database.LookupCollarManufacturers.FirstOrDefault(m => m.CollarManufacturer == manufacturerId);
            if (manufacturer != null)
                ManufacturerComboBox.SelectedItem = manufacturer;
        }

        private void EnableCreate()
        {
            CreateButton.Enabled = IsProjectInvestigator && ProjectInvestigator != null && !string.IsNullOrEmpty(CollarIdTextBox.Text);
        }

        private void CreateButton_Click(object sender, EventArgs e)
        {
            var mfgr = (LookupCollarManufacturer)ManufacturerComboBox.SelectedItem;
            string collarId = CollarIdTextBox.Text.NullifyIfEmpty();

            if (Database.Collars.Any(c => c.LookupCollarManufacturer == mfgr && c.CollarId == collarId))
            {
                MessageBox.Show("The collar Id is not unique.  Try again", "Database Error", MessageBoxButtons.OK,
                                MessageBoxIcon.Error);
                CollarIdTextBox.Focus();
                CreateButton.Enabled = false;
                return;
            }
            var collar = new Collar
                {
                    CollarId = CollarIdTextBox.Text.NullifyIfEmpty(),
                    Frequency = FrequencyTextBox.Text.DoubleOrNull(),
                    HasGps = HasGpsCheckBox.Checked,
                    DisposalDate = DisposalDateTimePicker.Checked ? DisposalDateTimePicker.Value : (DateTime?)null,
                    LookupCollarManufacturer = (LookupCollarManufacturer)ManufacturerComboBox.SelectedItem,
                    LookupCollarModel = (LookupCollarModel)ModelComboBox.SelectedItem,
                    Notes = NotesTextBox.Text.NullifyIfEmpty(),
                    Owner = OwnerTextBox.Text.NullifyIfEmpty(),
                    ProjectInvestigator = (ProjectInvestigator)ManagerComboBox.SelectedItem,
                    SerialNumber = SerialNumberTextBox.Text.NullifyIfEmpty(),
                };
            Database.Collars.InsertOnSubmit(collar);
            if (IndependentContext)
            {
                try
                {
                    Database.SubmitChanges();
                }
                catch (Exception ex)
                {
                    Database.Collars.DeleteOnSubmit(collar);
                    MessageBox.Show(ex.Message, "Database Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    CollarIdTextBox.Focus();
                    CreateButton.Enabled = false;
                    return;
                }
            }
            OnDatabaseChanged();
            DialogResult = DialogResult.OK;
        }

        private void CollarIdTextBox_TextChanged(object sender, EventArgs e)
        {
            EnableCreate();
        }

        private void ManagerComboBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            ProjectInvestigator = ManagerComboBox.SelectedItem as ProjectInvestigator;
            EnableCreate();
        }

        private void ManufacturerComboBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            var mfgr = (LookupCollarManufacturer)ManufacturerComboBox.SelectedItem;
            if (mfgr != null)
            {
                Settings.SetDefaultCollarManufacturer(mfgr.CollarManufacturer);
                SetUpModelList(mfgr.CollarManufacturer);
            }
        }

        private void ModelComboBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            var model = (LookupCollarModel)ModelComboBox.SelectedItem;
            if (model != null)
                Settings.SetDefaultCollarModel(model.CollarManufacturer, model.CollarModel);
        }


        private void DisposalDateTimePicker_ValueChanged(object sender, EventArgs e)
        {
            DisposalDateTimePicker.CustomFormat = DisposalDateTimePicker.Checked ? "yyyy-MM-dd HH:mm" : " ";
        }


        private void OnDatabaseChanged()
        {
            EventHandler handle = DatabaseChanged;
            if (handle != null)
                handle(this,EventArgs.Empty);
        }

        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            var now = DateTime.Now;
            DisposalDateTimePicker.Value = new DateTime(now.Year, now.Month, now.Day, 12, 0, 0);
            DisposalDateTimePicker.Checked = false;
            DisposalDateTimePicker.CustomFormat = " ";
        }

    }
}
