-----------------------------------------------------
-- Export to 'WACH Animal List.csv'
-----------------------------------------------------
SELECT A.[ProjectId]
      ,A.[AnimalId]
      ,[Species]
      ,[Gender]
      ,[MortalityDate]
      ,[GroupName]
      ,[Description] AS [Animal Notes]
      ,C.[CollarManufacturer]
      ,C.[CollarId]
      ,[CollarModel]
      ,[Manager] AS [Collar Manager]
      ,[Owner] AS [Collar Owner]
      ,[SerialNumber] AS [Collar Serial Number]
      ,[Frequency] AS [Collar Frequency]
      ,[HasGps] AS [Collar has GPS?]
      --,C.[Notes] AS [Collar Notes]
      ,C.[DisposalDate] AS [Collar Disposal]
      ,[DeploymentDate] AS [Collar Start on Animal]
      ,[RetrievalDate] AS [Collar End on Animal]
      ,P.[ProgramId] AS [Argos Program]
	  ,P.[PlatformId] AS [Argos ID]
      ,P.[Notes] AS [Argos Notes]
      ,P.[Active] AS [Argos Download Active?]
      ,P.[DisposalDate] AS [Argos Disposal]
	  ,AD.[StartDate] AS [Argos Start on Collar]
      ,AD.[EndDate] AS [Argos End on Collar]
  FROM [Animal_Movement].[dbo].[CollarDeployments] AS D
  LEFT JOIN [Animal_Movement].[dbo].[ArgosDeployments] AS AD
  on AD.CollarManufacturer = D.CollarManufacturer AND AD.CollarId = D.CollarId
  LEFT JOIN [Animal_Movement].[dbo].[Collars] as C
  on D.CollarManufacturer = C.CollarManufacturer AND D.CollarId = C.CollarId
  LEFT JOIN [Animal_Movement].[dbo].[Animals] as A
  on D.AnimalId = A.AnimalId AND D.ProjectId = A.ProjectId
  LEFT JOIN [Animal_Movement].[dbo].[ArgosPlatforms] AS P
  on AD.PlatformId = P.PlatformId
  where A.ProjectId = 'WACH' AND A.[AnimalId] NOT LIKE '12L%' AND [Owner] <> 'ADFG'

-----------------------------------------------------
-- Create a temp table of collar ids
-----------------------------------------------------
SELECT C.[CollarId] INTO wach_cfiles
  FROM [Animal_Movement].[dbo].[CollarDeployments] AS D
  LEFT JOIN [Animal_Movement].[dbo].[ArgosDeployments] AS AD
  on AD.CollarManufacturer = D.CollarManufacturer AND AD.CollarId = D.CollarId
  LEFT JOIN [Animal_Movement].[dbo].[Collars] as C
  on D.CollarManufacturer = C.CollarManufacturer AND D.CollarId = C.CollarId
  LEFT JOIN [Animal_Movement].[dbo].[Animals] as A
  on D.AnimalId = A.AnimalId AND D.ProjectId = A.ProjectId
  LEFT JOIN [Animal_Movement].[dbo].[ArgosPlatforms] AS P
  on AD.PlatformId = P.PlatformId
  where A.ProjectId = 'WACH' AND A.[AnimalId] NOT LIKE '12L%' AND [Owner] <> 'ADFG'

-----------------------------------------------------
-- Export to 'WACH CSV Files.csv'
-----------------------------------------------------
SELECT F.[FileId] -- INTO wach_cfiles
      ,F.[FileName]
      --,F.[UploadDate]
      --,F.[ProjectId]
      --,F.[UserName]
      --,F.[CollarManufacturer]
      ,F.[CollarId]
      --,F.[Format]
      ,F.[Status]
      --,F.[Owner]
      --,F.[ArgosDeploymentId]
      --,F.[CollarParameterId]
	  ,F2.[FileName] AS [Parent FileName]
      ,F2.[Format] AS [Parent Format]
	  --,AD.[DeploymentId]
      ,AD.[PlatformId] AS [Argos ID]
      --,AD.[CollarManufacturer]
      --,AD.[CollarId]
      --,AD.[StartDate] AS [Argos Start]
      --,AD.[EndDate] AS [Argos End]
	  --,CP.[ParameterId]
      --,CP.[CollarManufacturer]
      --,CP.[CollarId]
      ,CP.[FileId] AS [Parameter File ID] -- INTO wach_pfiles
      --,CP.[Gen3Period]
      --,CP.[StartDate] AS [Parameter Start]
      --,CP.[EndDate] AS [Parameter End]
  FROM [dbo].[CollarFiles] as F
  left join ArgosDeployments as AD on AD.DeploymentId = F.ArgosDeploymentId
  left join CollarParameters as CP on CP.ParameterId = F.CollarParameterId
  left join CollarFiles as F2 on F.ParentFileId = F2.FileId
  where F.[format] = 'C' and (F.CollarId in (select collarid from wach_collars))-- or F.ProjectId = 'WACH')
GO

-----------------------------------------------------
-- Create a temp table of collar File ids
-----------------------------------------------------
SELECT [FileId] INTO wach_cfiles
  FROM [dbo].[CollarFiles]
  where [Format] = 'C' and (CollarId in (select CollarId from wach_collars))
GO

-----------------------------------------------------
-- Create a temp table of collar File ids
-----------------------------------------------------
SELECT CP.[FileId] INTO wach_pfiles
  FROM [dbo].[CollarFiles] as F
  left join CollarParameters as CP on CP.ParameterId = F.CollarParameterId
  where F.[format] = 'C' and (F.CollarId in (select CollarId from wach_collars))
  AND CP.FileId IS NOT NULL
  GROUP BY CP.FIleID
  ORDER BY CP.FileID

-----------------------------------------------------
-- Export to 'WACH Parameter Files.csv'
-----------------------------------------------------
SELECT [FileId], [FileName], [Format], [Status]
  FROM [dbo].[CollarParameterFiles]
 WHERE FileId in (select FileId from wach_pfiles)


-----------------------------------------------------
-- Create Views to be used by a C# program
-----------------------------------------------------
CREATE VIEW [dbo].[wach_cfile_data]
AS
    SELECT A.FileID, B.Contents FROM wach_cfiles as A Join CollarFiles as B on A.Fileid = B.fileid

CREATE VIEW [dbo].[wach_pfile_data]
AS
    SELECT [FileId],[Contents]
      FROM [dbo].[CollarParameterFiles] where fileid in (select * from wach_pfiles)

-----------------------------------------------------
-- Run a C# program to read the queries and write the files into a folder
-----------------------------------------------------

-----------------------------------------------------
-- Clean up
-----------------------------------------------------
DROP VIEW [dbo].[wach_cfile_data];
DROP VIEW [dbo].[wach_pfile_data];

DROP TABLE wach_pfiles;
DROP TABLE wach_cfiles;
DROP TABLE wach_collars;
