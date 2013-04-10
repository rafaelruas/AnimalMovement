﻿using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using DataModel;
using Telonics;

namespace FileLibrary
{
    public class FileLoader
    {

        #region Public API

        #region Static Methods

        #region AWS loaders

        internal static CollarFile LoadProgram(ArgosProgram program, int days,
                                               ArgosWebSite.ArgosWebResult results, string errors)
        {
            //if results is null, then errors should be non-null (database rule, insert will fail if false)
            CollarFile file = null;
            var database = new AnimalMovementDataContext();
            //Linq to SQL wraps the changes in a transaction so file will not be created if log cannot be written
            if (results != null)
            {
                file = new CollarFile
                    {
                        Owner = program.Manager,
                        FileName = "program_" + program.ProgramId + "_" + DateTime.Now.ToString("yyyyMMdd") + ".aws",
                        Status = 'A',
                        Contents = results.ToBytes()
                    };
                database.CollarFiles.InsertOnSubmit(file);
            }
            var log = new ArgosDownload
                {
                    ProgramId = program.ProgramId,
                    CollarFile = file,
                    Days = days,
                    ErrorMessage = errors
                };
            database.ArgosDownloads.InsertOnSubmit(log);
            database.SubmitChanges();
            //Linq TO SQL Insert with SPROC dos not set associations, and provides not partial methods to expand
            if (file != null)
                file.LookupCollarFileFormat = database.LookupCollarFileFormats.First(l => l.Code == file.Format);
            return file;
        }

        internal static CollarFile LoadPlatfrom(ArgosPlatform platform, int days,
                                                ArgosWebSite.ArgosWebResult results, string errors)
        {
            //if results is null, then errors should be non-null (database rule, insert will fail if false)
            CollarFile file = null;
            var database = new AnimalMovementDataContext();
            //Linq to SQL wraps the changes in a transaction so file will not be created if log cannot be written
            if (results != null)
            {
                file = new CollarFile
                    {
                        Owner = platform.ArgosProgram.Manager,
                        FileName = "platform_" + platform.PlatformId + "_" + DateTime.Now.ToString("yyyyMMdd") + ".aws",
                        Status = 'A',
                        Contents = results.ToBytes()
                    };
                database.CollarFiles.InsertOnSubmit(file);
            }
            var log = new ArgosDownload
                {
                    PlatformId = platform.PlatformId,
                    CollarFile = file,
                    Days = days,
                    ErrorMessage = errors
                };
            database.ArgosDownloads.InsertOnSubmit(log);
            database.SubmitChanges();
            //Linq TO SQL Insert with SPROC dos not set associations, and provides not partial methods to expand
            if (file != null)
                file.LookupCollarFileFormat = database.LookupCollarFileFormats.First(l => l.Code == file.Format);
            return file;
        }

        #endregion

        public static void LoadPath(string path, Action<Exception, string, Project, ProjectInvestigator> handler = null,
                                    Project project = null, ProjectInvestigator manager = null, Collar collar = null,
                                    char status = 'A', bool allowDups = false)
        {
            if (path == null)
                throw new ArgumentNullException("path", "A path must be provided");
            if (project != null && manager != null)
                throw new InvalidOperationException(
                    String.Format("Project: {0} and Manager: {1} cannot both be non-null.", project.ProjectId,
                                  manager.Login));

            if (File.Exists(path))
            {
                LoadFilePath(path, project, manager, collar, status, allowDups);
            }
            else
            {
                if (Directory.Exists(path))
                {
                    foreach (var file in Directory.EnumerateFiles(path))
                        try
                        {
                            LoadFilePath(file, project, manager, collar, status, allowDups);
                        }
                        catch (Exception ex)
                        {
                            if (handler == null)
                                throw;
                            handler(ex, file, project, manager);
                        }
                }
                else
                {
                    throw new InvalidOperationException(path + " is not a folder or file");
                }
            }
        }


        #endregion

        #region Public Properties

        public Project Project { get; set; }
        public ProjectInvestigator Owner { get; set; }
        public Collar Collar { get; set; }
        public char Status { get; set; }
        public bool AllowDuplicates { get; set; }

        public AnimalMovementDataContext Database { get; private set; }
        public string FilePath { get; private set; }
        public Byte[] Contents { get; private set; }
        public Lazy<char?> Format { get; private set; }

        #endregion

        #region Constructors

        public FileLoader(string filePath)
        {
            Contents = File.ReadAllBytes(filePath);
            if (Contents == null || Contents.Length == 0)
                throw new ArgumentException("File contents is empty or unavailable","filePath");
            Database = new AnimalMovementDataContext();
            FilePath = filePath;
            Status = 'A';
            Format = new Lazy<char?>(() => GetFormat(Contents));
        }

        #endregion

        #region Public Instance Methods

        public CollarFile Load()
        {
            Validate();
            // The entity objects I got from the callers (i.e. Project, Owner, Collar)
            // came from a foreign DataContext, so they cannot be used to create a new
            // entity in this datacontext.
            var file = new CollarFile
            {
                ProjectId = Project == null ? null : Project.ProjectId,
                FileName = Path.GetFileName(FilePath),
                CollarManufacturer = Collar == null ? null : Collar.CollarManufacturer,
                CollarId = Collar == null ? null : Collar.CollarId,
                Owner = Owner == null ? null : Owner.Login,
                Status = Status,
                Contents = Contents,
            };
            Database.CollarFiles.InsertOnSubmit(file);
            Database.SubmitChanges();
            //Linq TO SQL Insert with SPROC dos not set associations, and provides not partial methods to expand
            file.LookupCollarFileFormat = Database.LookupCollarFileFormats.First(l => l.Code == file.Format);
            return file;
        }

        #endregion

        #endregion

        #region Private methods

        // This is a template for client side usage
        private static void LoadFilePath(string filePath, Project project, ProjectInvestigator owner, Collar collar,
                                         char status, bool allowDups)
        {
            var fileLoader = new FileLoader(filePath)
                {
                    Project = project,
                    Owner = owner,
                    Collar = collar,
                    Status = status,
                    AllowDuplicates = allowDups
                };
            var file = fileLoader.Load();
            if (file.LookupCollarFileFormat.ArgosData == 'Y')
                FileProcessor.ProcessFile(file);
        }


        private void Validate()
        {
            //Do client side validation to save a round trip to the database if we know the insert will fail
            //This logic should be consistent with the database rules

            // one and only one of Project and Owner must be specified
            if (Owner == null && Project == null)
                throw new InvalidOperationException("One of project or owner must be specified.");
            if (Owner != null && Project != null)
                throw new InvalidOperationException("Both project and owner cannot be specified simultaneously.");

            //Check Status
            if (Status != 'A' && Status != 'I')
                throw new InvalidOperationException(
                    String.Format("A status of '{0}' is not acceptable.  Acceptable values are 'A' and 'I'.", Status));

            //Deny duplicates
            if (!AllowDuplicates)
            {
                var duplicate = GetDuplicate();
                if (duplicate != null)
                    throw new InvalidOperationException(
                        String.Format("The contents have already been loaded as file '{0}' {1} '{2}'.",
                                      duplicate.FileName, duplicate.Project == null ? "for manager" : "in project",
                                      duplicate.Project == null ? duplicate.Owner : duplicate.Project.ProjectName));
            }

            //Unknown format
            if (Format.Value == null)
                throw new InvalidOperationException("The contents are not in a recognizable format.");

            //Try and guess the collar if one is required and not provided 
            if (CollarIsRequired)
            {
                if (Collar == null)
                    Collar = GetCollarFromFile();
                if (Collar == null)
                    throw new InvalidOperationException(
                            "The format requires a valid collar but none was provided " +
                            "nor could it be determined from the filename or contents.");
            }
        }


        private CollarFile GetDuplicate()
        {
            var fileHash = (new SHA1CryptoServiceProvider()).ComputeHash(Contents);
            return Database.CollarFiles.FirstOrDefault(f => f.Sha1Hash == fileHash);
        }


        #region Collar from file

        private Collar GetCollarFromFile()
        {
            if (!Format.Value.HasValue)
                return null;

            string argosId = null;
            if (Format.Value.Value == 'B')
                argosId = GetArgosFromFormatB();
            if (Format.Value.Value == 'D')
                argosId = GetArgosFromFormatD();

            //If we have an ArgosId and it maps to one and only one collar, then use it.
            if (argosId != null)
            {
                try
                {
                    return Database.ArgosDeployments.Single(d => d.PlatformId == argosId).Collar;
                }
                catch (Exception)
                {
                   return null;
                }
            }

            if (Format.Value.Value == 'C')
            {
                string ctn = GetCtnFromFormatC();
                if (ctn == null)
                    return null;
                var collar = Database.Collars.FirstOrDefault(c => c.CollarManufacturer == "Telonics" && c.CollarId == ctn);
                if (collar != null)
                    return collar;
                //Try without the Alpha suffix
                if (ctn.Length != 7 && !Char.IsUpper(ctn[6]))
                    return null;
                ctn = ctn.Substring(0, 6);
                return Database.Collars.FirstOrDefault(c => c.CollarManufacturer == "Telonics" && c.CollarId == ctn);
            }
            return null;
        }


        private string GetArgosFromFormatB()
        {
            //the first column is the Argos ID, if more than one, then return none
            try
            {
                var checkForHeader = true;
                var db = new SettingsDataContext();
                string argosId = null;
                var header = db.LookupCollarFileHeaders.First(h => h.FileFormat == 'B').Header;
                foreach (var line in ReadLines(Contents, Encoding.UTF8))
                {
                    //skip the first line if it looks like the header
                    if (checkForHeader && line.Normalize().StartsWith(header, StringComparison.OrdinalIgnoreCase))
                    {
                        checkForHeader = false;
                        continue;
                    }
                    //skip empty/blank lines
                    if (string.IsNullOrEmpty(line.Replace(',', ' ').Trim()))
                        continue;
                    var newArgosId = line.Substring(0, line.IndexOf(",", StringComparison.OrdinalIgnoreCase));
                    if (argosId == null)
                    {
                        argosId = newArgosId;
                        checkForHeader = false;
                    }
                    if (newArgosId != argosId)
                        return null;
                }
                return argosId;
            }
            catch (Exception)
            {
                return null;
            }
        }


        private string GetArgosFromFormatD()
        {
            //the third column is the Argos ID, if more than one, then return none
            try
            {
                var checkForHeader = true;
                var db = new SettingsDataContext();
                string argosId = null;
                var header = db.LookupCollarFileHeaders.First(h => h.FileFormat == 'D').Header;
                foreach (var line in ReadLines(Contents, Encoding.UTF8))
                {
                    if (checkForHeader && line.Normalize().StartsWith(header, StringComparison.OrdinalIgnoreCase))
                    {
                        checkForHeader = false;
                        continue;
                    }
                    //skip empty/blank lines
                    if (string.IsNullOrEmpty(line.Replace(',', ' ').Trim()))
                        continue;
                    var newArgosId = line.Split(new[] { '\t', ',' })[2];
                    if (argosId == null)
                    {
                        argosId = newArgosId;
                        checkForHeader = false;
                    }
                    if (newArgosId != argosId)
                        return null;
                }
                return argosId;
            }
            catch (Exception)
            {
                return null;
            }
        }


        private string GetCtnFromFormatC()
        {
            //In the D format, the 7th line (approx) is 'CTN,649024A'
            var line = ReadLines(Contents, Encoding.UTF8)
                .Skip(5).Take(4).FirstOrDefault(l => l.Normalize().StartsWith("CTN,", StringComparison.OrdinalIgnoreCase));
            return line == null ? null : line.Substring(4);
        }

        private static IEnumerable<string> ReadLines(Byte[] bytes, Encoding enc)
        {
            using (var stream = new MemoryStream(bytes, 0, bytes.Length))
            using (var reader = new StreamReader(stream, enc))
                while(reader.Peek() >= 0)
                    yield return reader.ReadLine();
        }


        private bool CollarIsRequired
        {
            get { return Database.LookupCollarFileFormats.Any(f => f.Code == Format.Value && f.ArgosData == 'N'); }
        }

        #endregion

        #region File format

        //This should be kept in sync with CollarInfo.cs in the SqlServer_Files project
        private static char? GetFormat(Byte[] data)
        {
            try
            {
                //get the first line of the file
                var fileHeader = ReadHeader(data, Encoding.UTF8, 500).Trim().Normalize();
                //database for header is only 450 char
                char code = '?';
                var db = new SettingsDataContext();
                foreach (var format in db.LookupCollarFileHeaders)
                {
                    var header = format.Header.Normalize();
                    var regex = format.Regex;
                    if (fileHeader.StartsWith(header, StringComparison.OrdinalIgnoreCase) ||
                        (regex != null && new Regex(regex).IsMatch(fileHeader)))
                    {
                        code = format.FileFormat;
                        break;
                    }
                }
                if (code == '?' && (new ArgosEmailFile(data)).GetPrograms().Any())
                    // We already checked for ArgosAwsFile with the header
                    code = 'E';
                return code == '?' ? (char?)null : code;
            }
            catch (Exception)
            {
                return null;
            }
        }

        private static string ReadHeader(Byte[] bytes, Encoding enc, int maxLength)
        {
            var length = Math.Min(bytes.Length, maxLength);
            using (var stream = new MemoryStream(bytes, 0, length))
            using (var reader = new StreamReader(stream, enc))
                return reader.ReadLine();
        }

        #endregion

        #endregion
    }
}
