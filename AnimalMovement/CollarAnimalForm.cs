﻿using System;
using System.Linq;
using DataModel;

namespace AnimalMovement
{
    internal partial class CollarAnimalForm : BaseForm
    {
        private Animal Animal { get; set; }
        private AnimalMovementDataContext Database { get; set; }
        private LookupCollarManufacturer Manufacturer { get; set; }
        private string CurrentUser { get; set; }

        internal CollarAnimalForm(AnimalMovementDataContext database, Animal animal, string user)
        {
            InitializeComponent();
            RestoreWindow();
            Database = database;
            Animal = animal;
            CurrentUser = user;
            LoadForm();
        }

        private void LoadForm()
        {
            //read the defaults before setting the combobox, because changing the selection saves the default
            string manufacturerId = Settings.GetDefaultCollarManufacturer();
            ManufacturerComboBox.DataSource = from m in Database.LookupCollarManufacturers select m;
            ManufacturerComboBox.DisplayMember = "Name";
            SelectDefaultManufacturer(manufacturerId);
            CollarComboBox.DisplayMember = "CollarId";
        }

        private void SelectDefaultManufacturer(string manufacturerId)
        {
            if (manufacturerId != null)
                Manufacturer = Database.LookupCollarManufacturers.FirstOrDefault(m => m.CollarManufacturer == manufacturerId);
            if (Manufacturer == null)
                Manufacturer = (LookupCollarManufacturer)ManufacturerComboBox.SelectedItem;
            else
                ManufacturerComboBox.SelectedItem = Manufacturer;
        }

        private void ManufacturerComboBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            Manufacturer = (LookupCollarManufacturer)ManufacturerComboBox.SelectedItem;
            if (Manufacturer != null)
                Settings.SetDefaultCollarManufacturer(Manufacturer.CollarManufacturer);
            LoadCollarList();
        }

        private void LoadCollarList()
        {
            var collarsInMfgr = from collar in Database.Collars
                                where collar.LookupCollarManufacturer == Manufacturer &&
                                      collar.Manager == CurrentUser
                                select collar;
            var collars = collarsInMfgr.ToList();
            var collarsDeployed = from deploy in Database.CollarDeployments
                                     where deploy.RetrievalDate == null
                                     select deploy.Collar;
            foreach (var collar in collarsDeployed)
                collars.Remove(collar);
            CollarComboBox.DataSource = collars;
            EnableForm();
        }

        private void DeployDateTimePicker_ValueChanged(object sender, EventArgs e)
        {
            EnableForm();
        }

        private void CollarComboBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            EnableForm();
        }

        private void EnableForm()
        {
            //Can only pick from collars that the CurrentUser can Manage
            CreateButton.Enabled = ManufacturerComboBox.SelectedItem != null && CollarComboBox.SelectedItem != null && CollarAndAnimalFreeOnDate(DeployDateTimePicker.Value);
        }

        private bool CollarAndAnimalFreeOnDate(DateTime dateTime)
        {
            var collar = (Collar)CollarComboBox.SelectedItem;
            return !Database.CollarDeployments.Any(d => d.DeploymentDate < dateTime && dateTime < d.RetrievalDate && (d.Animal == Animal || d.Collar == collar));
        }

        private void CreateButton_Click(object sender, EventArgs e)
        {
            var collar = (Collar)CollarComboBox.SelectedItem;
            var deployment = new CollarDeployment
                                    {
                                        //Using the objects in this cases causes a primary key problem in the dbml code
                                        AnimalId = Animal.AnimalId,
                                        ProjectId = Animal.ProjectId,
                                        CollarId = collar.CollarId,
                                        CollarManufacturer = collar.CollarManufacturer,
                                        DeploymentDate = DeployDateTimePicker.Value.Date
                                    };
            //FIXME deploying a collar can cause creation of fixes/location - Ensure timeout is increases, and put up progress indicator
            Database.CollarDeployments.InsertOnSubmit(deployment);
        }
    }
}
