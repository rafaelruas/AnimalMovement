USE [Animal_Movement]
GO
CREATE USER [INPAKROMS53AIS\repl_distribution] FOR LOGIN [INPAKROMS53AIS\repl_distribution] WITH DEFAULT_SCHEMA=[dbo]
GO
CREATE USER [INPAKROMS53AIS\repl_logreader] FOR LOGIN [INPAKROMS53AIS\repl_logreader] WITH DEFAULT_SCHEMA=[dbo]
GO
CREATE USER [INPAKROMS53AIS\repl_merge] FOR LOGIN [INPAKROMS53AIS\repl_merge] WITH DEFAULT_SCHEMA=[dbo]
GO
CREATE USER [INPAKROMS53AIS\repl_snapshot] FOR LOGIN [INPAKROMS53AIS\repl_snapshot] WITH DEFAULT_SCHEMA=[dbo]
GO
CREATE USER [NPS\BAMangipane] FOR LOGIN [NPS\BAMangipane] WITH DEFAULT_SCHEMA=[dbo]
GO
CREATE USER [NPS\BBorg] FOR LOGIN [NPS\BBorg] WITH DEFAULT_SCHEMA=[dbo]
GO
CREATE USER [NPS\Domain Users] FOR LOGIN [NPS\Domain Users]
GO
CREATE USER [NPS\GColligan] FOR LOGIN [NPS\GColligan] WITH DEFAULT_SCHEMA=[dbo]
GO
CREATE USER [NPS\JPLawler] FOR LOGIN [NPS\JPLawler] WITH DEFAULT_SCHEMA=[dbo]
GO
CREATE USER [NPS\JWBurch] FOR LOGIN [NPS\JWBurch] WITH DEFAULT_SCHEMA=[dbo]
GO
CREATE USER [NPS\KCJoly] FOR LOGIN [NPS\KCJoly] WITH DEFAULT_SCHEMA=[dbo]
GO
CREATE USER [NPS\MLJohnson] FOR LOGIN [NPS\MLJohnson] WITH DEFAULT_SCHEMA=[dbo]
GO
CREATE USER [NPS\PAOwen] FOR LOGIN [NPS\PAOwen] WITH DEFAULT_SCHEMA=[dbo]
GO
CREATE USER [NPS\RESarwas] FOR LOGIN [NPS\RESarwas] WITH DEFAULT_SCHEMA=[dbo]
GO
CREATE USER [NPS\SDMiller] FOR LOGIN [NPS\SDMiller] WITH DEFAULT_SCHEMA=[dbo]
GO
CREATE ROLE [Editor] AUTHORIZATION [dbo]
GO
CREATE ROLE [Investigator] AUTHORIZATION [dbo]
GO
CREATE ROLE [MSReplPAL_7_1] AUTHORIZATION [dbo]
GO
CREATE ROLE [MStran_PAL_role] AUTHORIZATION [dbo]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LookupCollarManufacturers](
	[CollarManufacturer] [varchar](16) NOT NULL,
	[Name] [nvarchar](200) NULL,
	[Website] [nvarchar](200) NULL,
	[Description] [nvarchar](2000) NULL,
 CONSTRAINT [PK_CollarManufacturers] PRIMARY KEY CLUSTERED 
(
	[CollarManufacturer] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LookupCollarFileFormats](
	[Code] [char](1) NOT NULL,
	[CollarManufacturer] [varchar](16) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](255) NULL,
	[TableName] [sysname] NOT NULL,
	[HasCollarIdColumn] [char](1) NOT NULL,
 CONSTRAINT [PK_CollarFileFormats] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectInvestigators](
	[Login] [sysname] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Email] [nvarchar](200) NOT NULL,
	[Phone] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_ProjectInvestigators] PRIMARY KEY CLUSTERED 
(
	[Login] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Projects](
	[ProjectId] [varchar](16) NOT NULL,
	[ProjectName] [nvarchar](150) NOT NULL,
	[ProjectInvestigator] [sysname] NOT NULL,
	[UnitCode] [char](4) NULL,
	[Description] [nvarchar](2000) NULL,
 CONSTRAINT [PK_Projects] PRIMARY KEY CLUSTERED 
(
	[ProjectId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LookupCollarFileStatus](
	[Code] [char](1) NOT NULL,
	[Name] [nvarchar](32) NOT NULL,
	[Description] [nvarchar](255) NULL,
 CONSTRAINT [PK_CollarFileStatus] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CollarFiles](
	[FileId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[FileName] [nvarchar](255) NOT NULL,
	[UploadDate] [datetime2](7) NOT NULL,
	[Project] [varchar](16) NOT NULL,
	[UserName] [sysname] NOT NULL,
	[CollarManufacturer] [varchar](16) NOT NULL,
	[CollarId] [varchar](16) NULL,
	[Format] [char](1) NOT NULL,
	[Status] [char](1) NOT NULL,
	[Contents] [varbinary](max) NOT NULL,
	[ParentFileId] [int] NULL,
 CONSTRAINT [PK_CollarFiles] PRIMARY KEY CLUSTERED 
(
	[FileId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LookupCollarModels](
	[CollarModel] [varchar](24) NOT NULL,
 CONSTRAINT [PK_LookupCollarModels] PRIMARY KEY CLUSTERED 
(
	[CollarModel] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Collars](
	[CollarManufacturer] [varchar](16) NOT NULL,
	[CollarId] [varchar](16) NOT NULL,
	[CollarModel] [varchar](24) NOT NULL,
	[Manager] [sysname] NOT NULL,
	[Owner] [nvarchar](100) NULL,
	[AlternativeId] [varchar](16) NULL,
	[SerialNumber] [varchar](100) NULL,
	[Frequency] [float] NULL,
	[DownloadInfo] [varchar](200) NULL,
	[Notes] [nvarchar](max) NULL,
	[DisposalDate] [datetime2](7) NULL,
 CONSTRAINT [PK_Collars] PRIMARY KEY CLUSTERED 
(
	[CollarManufacturer] ASC,
	[CollarId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CollarFixes](
	[FixId] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[HiddenBy] [bigint] NULL,
	[FileId] [int] NOT NULL,
	[LineNumber] [int] NOT NULL,
	[CollarManufacturer] [varchar](16) NOT NULL,
	[CollarId] [varchar](16) NOT NULL,
	[FixDate] [datetime2](7) NOT NULL,
	[Lat] [float] NOT NULL,
	[Lon] [float] NOT NULL,
 CONSTRAINT [PK_CollarFixes] PRIMARY KEY CLUSTERED 
(
	[FixId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [IX_CollarFixes_Collar] ON [dbo].[CollarFixes] 
(
	[CollarManufacturer] ASC,
	[CollarId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_CollarFixes_FileId] ON [dbo].[CollarFixes] 
(
	[FileId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_CollarFixes_FixDate] ON [dbo].[CollarFixes] 
(
	[FixDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_CollarFixes_HiddenBy] ON [dbo].[CollarFixes] 
(
	[HiddenBy] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: March 2, 2012
-- Description:	Deletes the fixes for a CollarFile
--              Useful when changing status.
-- =============================================
CREATE PROCEDURE [dbo].[CollarFixes_Delete] 
	@FileId int = NULL
AS
BEGIN
	SET NOCOUNT ON;

	-- This is not executed directly, only by CollarFile_Delete & CollarFile_UpdateStatus 

	DELETE FROM [dbo].[CollarFixes] WHERE [FileID] = @FileId;
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Location_Added] 
	@Project NVARCHAR(255), 
	@Animal  NVARCHAR(255), 
	@Time    DATETIME2
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE
		@PrevTime DATETIME2,
		@NextTime DATETIME2;
		
	-- Typically an inserted location (new or updated) does not have any ajoining movements (it's new)
	-- however, if this location is part of a larger operation, then a prior location may connect a movement
	-- to this point.  We can safely delete any connected movements, before begining the standard process.
	EXEC [dbo].[Location_Deleted] @Project, @Animal, @Time
	
	SET @PrevTime = [dbo].[StartOfOverlappingMovement](@Project, @Animal, @Time);
	SET @NextTime = [dbo].[EndOfMovement](@Project, @Animal, @PrevTime);
	
	EXEC [dbo].[Movement_Delete] @Project, @Animal, @PrevTime, @NextTime;
	 
	IF @PrevTime IS NULL
	BEGIN
		SET @PrevTime = [dbo].[PreviousLocationTime](@Project, @Animal, @Time);
		SET @NextTime = [dbo].[NextLocationTime](@Project, @Animal, @Time);
	END
	
	EXEC [dbo].[Movement_Insert] @Project, @Animal, @PrevTime, @Time; 
	EXEC [dbo].[Movement_Insert] @Project, @Animal, @Time, @NextTime; 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Location_Deleted] 
	@Project NVARCHAR(255), 
	@Animal  NVARCHAR(255), 
	@Time    DATETIME2
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE
		@PrevTime DATETIME2,
		@NextTime DATETIME2;
	
	SET @PrevTime = [dbo].[StartOfPriorConnectedMovement](@Project, @Animal, @Time);
	SET @NextTime = [dbo].[EndOfFollowingConnectedMovement](@Project, @Animal, @Time);
	
	EXEC [dbo].[Movement_Delete] @Project, @Animal, @PrevTime, @Time; 
	EXEC [dbo].[Movement_Delete] @Project, @Animal, @Time, @NextTime; 
	EXEC [dbo].[Movement_Insert] @Project, @Animal, @PrevTime, @NextTime; 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Locations](
	[ProjectId] [varchar](16) NOT NULL,
	[AnimalId] [varchar](16) NOT NULL,
	[FixDate] [datetime2](7) NOT NULL,
	[Location] [geography] NOT NULL,
	[FixId] [bigint] NOT NULL,
	[Status] [char](1) NULL,
 CONSTRAINT [PK_Locations] PRIMARY KEY CLUSTERED 
(
	[ProjectId] ASC,
	[AnimalId] ASC,
	[FixDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Locations_FixId] ON [dbo].[Locations] 
(
	[FixId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE SPATIAL INDEX [SIndex_Locations_Location] ON [dbo].[Locations] 
(
	[Location]
)USING  GEOGRAPHY_GRID 
WITH (
GRIDS =(LEVEL_1 = MEDIUM,LEVEL_2 = MEDIUM,LEVEL_3 = MEDIUM,LEVEL_4 = MEDIUM), 
CELLS_PER_OBJECT = 16, PAD_INDEX  = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LookupGender](
	[Sex] [varchar](7) NOT NULL,
 CONSTRAINT [PK_LookupSex] PRIMARY KEY CLUSTERED 
(
	[Sex] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LookupSpecies](
	[Species] [varchar](32) NOT NULL,
 CONSTRAINT [PK_LookupSpecies] PRIMARY KEY CLUSTERED 
(
	[Species] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Animals](
	[ProjectId] [varchar](16) NOT NULL,
	[AnimalId] [varchar](16) NOT NULL,
	[Species] [varchar](32) NULL,
	[Gender] [varchar](7) NOT NULL,
	[MortalityDate] [datetime2](7) NULL,
	[GroupName] [nvarchar](500) NULL,
	[Description] [nvarchar](2000) NULL,
 CONSTRAINT [PK_Animals] PRIMARY KEY CLUSTERED 
(
	[ProjectId] ASC,
	[AnimalId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CollarDeployments](
	[ProjectId] [varchar](16) NOT NULL,
	[AnimalId] [varchar](16) NOT NULL,
	[CollarManufacturer] [varchar](16) NOT NULL,
	[CollarId] [varchar](16) NOT NULL,
	[DeploymentDate] [datetime2](7) NOT NULL,
	[RetrievalDate] [datetime2](7) NULL,
 CONSTRAINT [PK_CollarDeployments] PRIMARY KEY CLUSTERED 
(
	[ProjectId] ASC,
	[AnimalId] ASC,
	[CollarManufacturer] ASC,
	[CollarId] ASC,
	[DeploymentDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[CurrentDeployments]
AS
SELECT     dbo.CollarDeployments.*
FROM         dbo.CollarDeployments
WHERE     (DeploymentDate < GETDATE()) AND (RetrievalDate > GETDATE() OR
                      RetrievalDate IS NULL)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[CollarsWithConflictingFixes]
AS
SELECT DISTINCT CollarManufacturer, CollarId
FROM         dbo.CollarFixes
GROUP BY CollarManufacturer, CollarId, FixDate
HAVING      (COUNT(FixDate) > 1)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[FixesNotHiddenInDeployment]
AS
SELECT CF.FixId
      ,CF.FixDate 
	  ,CD.*
  FROM CollarDeployments AS CD
       LEFT JOIN CollarFixes AS CF
	   ON CF.CollarManufacturer = CD.CollarManufacturer
	   AND CF.CollarId = CD.CollarId
	   AND CF.FixDate > CD.DeploymentDate
	   AND (CF.FixDate < CD.RetrievalDate OR CD.RetrievalDate IS NULL)
 WHERE CF.HiddenBy IS NULL
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[FixesNotHiddenAndNotDeployed]
AS
SELECT CF.FixId
  FROM CollarFixes as CF
       LEFT JOIN FixesNotHiddenInDeployment AS FD
       ON CF.FixId = FD.FixId
 WHERE FD.FixId IS NULL
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[FixesByLocation]
AS
SELECT     dbo.CollarFixes.FixDate
FROM         dbo.CollarFixes INNER JOIN
                      dbo.Locations ON dbo.CollarFixes.FixDate = dbo.Locations.FixDate INNER JOIN
                      dbo.CollarDeployments ON dbo.CollarFixes.CollarManufacturer = dbo.CollarDeployments.CollarManufacturer AND 
                      dbo.Locations.ProjectId = dbo.CollarDeployments.ProjectId AND dbo.Locations.AnimalId = dbo.CollarDeployments.AnimalId AND 
                      dbo.CollarFixes.CollarId = dbo.CollarDeployments.CollarId AND dbo.CollarFixes.FixDate > dbo.CollarDeployments.DeploymentDate AND 
                      (dbo.CollarFixes.FixDate < dbo.CollarDeployments.RetrievalDate OR
                      dbo.CollarDeployments.RetrievalDate IS NULL)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ERROR_LocationsOutsideBoundsOfDeployments]
AS
SELECT L.*
  FROM Locations as L
       LEFT JOIN FixesNotHiddenAndNotDeployed AS FND
       ON L.FixId = FND.FixId
 WHERE FND.FixId IS NOT NULL
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ERROR_LocationsAfterAnimalsMortality]
AS
SELECT L.*
  FROM Locations AS L
       INNER JOIN Animals AS A
       ON A.ProjectId = L.ProjectId
       AND A.AnimalId = L.AnimalId
 WHERE L.FixDate > A.MortalityDate
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ERROR_FixesWhichShouldBeLocations]
AS
SELECT FD.*, A.MortalityDate
  FROM FixesNotHiddenInDeployment AS FD
       INNER JOIN Animals AS A
       ON A.ProjectId = FD.ProjectId
       AND A.AnimalId = FD.AnimalId
       LEFT JOIN Locations AS L
       ON L.FixId = FD.FixId
 WHERE FD.FixId IS NOT NULL
   AND L.FixId IS NULL
   AND (A.MortalityDate IS NULL OR FD.FixDate < A.MortalityDate)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ERROR_CollarsWithOverlappingDeployments]
AS
SELECT CD1.*, CD2.DeploymentDate AS DeploymentDate2, CD2.RetrievalDate AS RetrievalDate2 
  FROM CollarDeployments AS CD1
       INNER JOIN CollarDeployments AS CD2
       ON CD1.CollarManufacturer = CD2.CollarManufacturer
       AND CD1.CollarId = CD2.CollarId
 WHERE CD1.DeploymentDate < CD2.DeploymentDate
   AND CD1.RetrievalDate >= CD2.DeploymentDate
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[NextLocationTime] 
(
	@Project VARCHAR(16)   = NULL, 
	@Animal  VARCHAR(16)   = NULL, 
	@Time    DATETIME2 = NULL
)
RETURNS DATETIME2
AS
BEGIN
	DECLARE @Result DATETIME2
	SET @Result = (SELECT TOP 1 [FixDate] 
					 FROM [dbo].[Locations]
					WHERE [ProjectId] = @Project
					  AND [AnimalId] = @Animal
					  AND [Status] IS NULL
					  AND [FixDate] > @Time
			     ORDER BY [FixDate]);
	RETURN @Result
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Movements](
	[ProjectId] [varchar](16) NOT NULL,
	[AnimalId] [varchar](16) NOT NULL,
	[StartDate] [datetime2](7) NOT NULL,
	[EndDate] [datetime2](7) NOT NULL,
	[Duration] [float] NOT NULL,
	[Distance] [float] NOT NULL,
	[Speed] [float] NOT NULL,
	[Shape] [geography] NOT NULL,
 CONSTRAINT [PK_Movement] PRIMARY KEY CLUSTERED 
(
	[ProjectId] ASC,
	[AnimalId] ASC,
	[StartDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Movements_EndDate] ON [dbo].[Movements] 
(
	[ProjectId] ASC,
	[AnimalId] ASC,
	[EndDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_Movements_StartDate_EndDate] ON [dbo].[Movements] 
(
	[StartDate] ASC,
	[EndDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE SPATIAL INDEX [SIndex_Movements_Shape] ON [dbo].[Movements] 
(
	[Shape]
)USING  GEOGRAPHY_GRID 
WITH (
GRIDS =(LEVEL_1 = MEDIUM,LEVEL_2 = MEDIUM,LEVEL_3 = MEDIUM,LEVEL_4 = MEDIUM), 
CELLS_PER_OBJECT = 16, PAD_INDEX  = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[EndOfMovement]
(
	@Project VARCHAR(32)   = NULL, 
	@Animal  VARCHAR(32)   = NULL, 
	@Time    DATETIME2 = NULL
)
RETURNS DATETIME2
AS
BEGIN
	DECLARE @Result DATETIME2
	SET @Result = (SELECT [EndDate] 
	                 FROM [dbo].[Movements]
					WHERE [ProjectId] = @Project
					  AND [AnimalId] = @Animal
					  AND [StartDate] = @Time);
	RETURN @Result
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[EndOfFollowingConnectedMovement] 
(
	@Project VARCHAR(32)   = NULL, 
	@Animal  VARCHAR(32)   = NULL, 
	@Time    DATETIME2 = NULL
)
RETURNS DATETIME2
AS
BEGIN
	DECLARE @Result DATETIME2
	SET @Result = (SELECT [EndDate] 
					 FROM [dbo].[Movements]
					WHERE [ProjectId] = @Project
					  AND [AnimalId] = @Animal
					  AND [StartDate] = @Time);
	RETURN @Result
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Movement_Insert_Sub] 
	@Project    NVARCHAR(255), 
	@Animal     NVARCHAR(255), 
	@StartTime  DATETIME2,
	@EndTime    DATETIME2,
	@StartPoint GEOGRAPHY,
	@EndPoint   GEOGRAPHY
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE
		@Vector   GEOGRAPHY,
		@Duration FLOAT,
		@Distance FLOAT,
		@Speed    FLOAT;

	IF @StartPoint.STEquals(@EndPoint) = 0   -- 0 is False
		BEGIN
			SET @Vector = GEOGRAPHY::STLineFromText('LINESTRING(' +
									 STR(@StartPoint.Long,13,8) + ' ' +
									 STR(@StartPoint.Lat,13,8) + ', ' +
									 STR(@EndPoint.Long,13,8)  + ' ' +
									 STR(@EndPoint.Lat,13,8)  + ')', 4326);
			SET @Distance = @Vector.STLength();
			--Alternative methods - TODO test which is fastest
			--SET @Vector = geography::Parse(geometry::Parse(@StartPoint.STUnion(@EndPoint).ToString()).STConvexHull().ToString())
			--SET @Distance = @StartPoint.STDistance(@EndPoint);
		END
	ELSE
		BEGIN
			SET @Vector = @StartPoint;
			SET @Distance = 0;			
		END;
	
	SET @Duration = DATEDIFF(second, @StartTime, @EndTime)/60.0/60.0;
	-- since datediff returns an int, this may round twords zero
	IF @Duration = 0
		BEGIN
			SET @Duration = DATEDIFF(nanosecond, @StartTime, @EndTime)/60.0/60.0/1000000000.0;
		END
	ELSE
	-- Since times come from locations they must be unique for an animal, therefore @StartTime != @EndTime
	-- The max precision of datetime2 is 7 digits (100 ns), therefore, it is impossible for the delta to be less than 1 nanosecond.
	-- I'm keeping this check in here for extra safety.	
	IF @Duration = 0
		BEGIN
			SET @Speed = -1;
		END
	ELSE
		BEGIN
			SET @Speed = @Distance/@Duration;
		END
	
	INSERT INTO [dbo].[Movements]
				([ProjectId], [AnimalId], [StartDate], [EndDate], [Duration], [Distance], [Speed], [Shape])
		 VALUES (@Project, @Animal, @StartTime, @EndTime, @Duration, @Distance, @Speed, @Vector);
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Movement_Delete] 
	@Project NVARCHAR(255), 
	@Animal  NVARCHAR(255), 
	@PrevTime DATETIME2,
	@NextTime DATETIME2
AS
BEGIN
	SET NOCOUNT ON;
	
	DELETE FROM [dbo].[Movements]
	   	  WHERE [ProjectId] = @Project
		    AND [AnimalId] = @Animal
	        AND [StartDate] = @PrevTime
	        AND [EndDate] = @NextTime;
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[InsteadOfCollarFixesInsert] 
ON [dbo].[CollarFixes] 
INSTEAD OF INSERT AS
BEGIN
	SET NOCOUNT ON;
	-- inserted is a virtual table of inserted fixes.
	-- Multiple fixes can be inserted at once. inserted is not updateable.
	
	--Logic for adding a SINGLE CollarFix
	--  1) If the new fix has the same collar id/fixdate as an existing unhidden fix
	--     then hide the existing fix, else nothing.  hiding the fix will trigger
	--     a removal of the cooresponding location.
	--  2) Add a location for the new fix.
	--
	-- Can I add multiple fixes in one operation?
	--   For step 2, yes, as there is no changes to the fixes table.
	--   For Step 1, NO!
	--   Consider adding three fixes, 1,2,3 which have the same fixdate.
	--   two must be hidden, and one must be unhidden.  This is ambiguous
	--   when the fixes are inserted 'simultaneously'.  In order to maintain
	--   the chaining of fixes hiding one another, they must be processed
	--   sequentially.

	-- Another problem:
	--   We may need to modify some of the fixes in the inserted set.
	--   We cannot modify the virtual 'inserted' table.  Therefore some of
	--   our state will be in the CollarFixes table, and some in the inserted
	--   table.  This is very difficult to manage.
	
	-- Solution:
	--  Use a cursor to insert fixes one by one
	--  Use a 'instead of insert' trigger to cure the problem with
	--  modifying the virtual inserted table
	
	
	DECLARE
		@HiddenFixId		bigint,
		@FixId				bigint,
		@HiddenBy			bigint,
		@FileId				INT,
		@LineNumber			INT,
		@CollarManufacturer VARCHAR(16),
		@CollarId			VARCHAR(16),
		@FixDate			DATETIME2(7),
		@Lat				FLOAT,
		@Lon				FLOAT;
	  
	DECLARE insf_cursor CURSOR FOR 
		SELECT HiddenBy, FileId, LineNumber, CollarManufacturer, CollarId, FixDate, Lat, Lon
		  FROM inserted
	-- I cannot select FixId (Identity column) from inserted, because it is set to zero in the cursor

	OPEN insf_cursor;

	FETCH NEXT FROM insf_cursor INTO @HiddenBy, @FileId, @LineNumber, @CollarManufacturer, @CollarId, @FixDate, @Lat, @Lon;
	
	WHILE @@FETCH_STATUS = 0
	BEGIN

		-- Step 1) Get the id of the fix we will hide (if it is null, then we are not hiding anything)
		SET @HiddenFixId = NULL  -- The assignment below does not occur if no record is found
		SELECT @HiddenFixId = FixId FROM CollarFixes
		 WHERE CollarFixes.CollarManufacturer = @CollarManufacturer
		   AND CollarFixes.CollarId = @CollarID
		   AND CollarFixes.FixDate = @FixDate
		   AND CollarFixes.HiddenBy IS NULL
		
		-- Step 2) Add new fix to table (do the insert that fired this trigger)
		INSERT CollarFixes (HiddenBy, FileId, LineNumber, CollarManufacturer, CollarId, FixDate, Lat, Lon)
		VALUES (@HiddenBy, @FileId, @LineNumber, @CollarManufacturer, @CollarId, @FixDate, @Lat, @Lon)
		SET @FixId = SCOPE_IDENTITY();

		-- PRINT N'  FixDate:' + cast(@FixDate as nvarchar(30)) + N';  HiddenFixId:' + isnull(cast(@HiddenFixId as nvarchar(30)), N'null') + N';  NewFixId:' + isnull(cast(@FixId as nvarchar(30)), N'null')

		-- IF @HiddenFixId IS NOT NULL We are temporarily unstable becasue we have two active & conflicting fixes
		
		-- Step3) Hide the hidden fix (the update trigger will remove the associated location)
		IF @HiddenFixId IS NOT NULL
		BEGIN
			UPDATE CollarFixes SET HiddenBy = @FixId WHERE FixId = @HiddenFixId;
		END
		
		
		-- Step 4) Add new record to Locations table
		-- This should not create a Location if there is no matching deployment
		-- The new fix is never hidden.
		-- there must be zero or one deployment/animal for this fixdate
		INSERT INTO Locations (ProjectId, AnimalId, FixDate, Location, FixId)
			 SELECT C.ProjectId, C.AnimalId, @FixDate, geography::Point(@Lat, @Lon, 4326) AS Location, @FixId
			   FROM CollarDeployments as C 
         INNER JOIN dbo.Animals AS A
 	             ON A.ProjectId = C.ProjectId
		    	AND A.AnimalId = C.AnimalId
			  WHERE C.CollarManufacturer = @CollarManufacturer AND C.CollarId = @CollarId
				AND C.DeploymentDate <= @FixDate
				AND (C.RetrievalDate IS NULL OR @FixDate <= C.RetrievalDate)
	    	    AND (A.MortalityDate IS NULL OR @FixDate <= A.MortalityDate)

		FETCH NEXT FROM insf_cursor INTO @HiddenBy, @FileId, @LineNumber, @CollarManufacturer, @CollarId, @FixDate, @Lat, @Lon;
	END
	CLOSE insf_cursor;
	DEALLOCATE insf_cursor;
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[InsteadOfCollarFixesDelete] 
ON [dbo].[CollarFixes] 
INSTEAD OF DELETE AS
BEGIN
	SET NOCOUNT ON;
	
	-- deleted is a virtual table of fixes that are to be deleted.
	-- Multiple fixes can be deleted at once. deleted is not updateable.

	--Logic for removing a SINGLE CollarFix
	--  1) If the fix is hidden do nothing else remove the related location
	--  2) If this fix hides another fix (that is not being deleted)
	--		 then Replace hiddenby on hidden fix with hiddenby from deleted/hiding fix
	--       else do nothing.  Changing hiddenby will trigger changes to Locations
	--  3) Delete the fixes
	--  step 1 must be done before step 2, else there may be overlapping fixes
	--    which will cause a integrity error in the Locations table.
	
	-- Can I delete multiple fixes in one operation?
	--   For step 1, yes, as there is no changes to the fixes table.
	--   For step 2, NO!
	--   For step 3, Yes.
	--   Consider three fixes, 1,2,3 where 2 hides 1 and 3 hides 2.
	--   If I delete 2 and 3 at the same time, then there is no easy way to
	--   unwind the hidden-ness of fix 1 in a bulk operation.
	--   If it is done sequentially: removing 3 unhides 2 then removing 2 unhides 1
	--   alternatively, removing 2 first makes 1 hidden by 3, then removing 3 unhides 1.
	
	-- Step 1) remove record from Locations table
	DELETE L FROM Locations as L
	   INNER JOIN deleted as D
			   ON L.FixId = D.FixId
		    WHERE D.HiddenBy is NULL

	DECLARE
		@FixId    bigint,
		@HiddenBy bigint;
	  
	DECLARE delf_cursor CURSOR FOR 
		SELECT [FixId] FROM deleted;

	OPEN delf_cursor;

	FETCH NEXT FROM delf_cursor INTO @FixId;
	WHILE @@FETCH_STATUS = 0
	BEGIN

		-- must be done in this order to maintain uniqueness of CollarId/FixDate/HiddenBy Tuple
		
		-- Step 2) Get the Id of the Fix that hid this fix
		-- get hiddenby from CollarFixes, not deleted, since previous records may
		-- have CollarFixes.
		SET @HiddenBy = (Select HiddenBy from CollarFixes where FixId = @FixId)
		
		-- Step 3) Delete the requested Fix
		DELETE CollarFixes WHERE FixId = @FixId
		
		-- Step 4) What ever was hiding the fix being deleted should now be hiding
		-- the fix that the deleted fix was hiding.
		-- FIXME - searching the CollarFixes by HiddenBy (even when indexed) is slow
		-- PROBLEM - unhiding a fix creates a location, thereby prohibiting the deletion of the fix
		-- SOLUTION - do not unhide fixes in the deleted list  
		UPDATE C SET HiddenBy = @HiddenBy
		  FROM CollarFixes AS C
     LEFT JOIN deleted as D
		    ON D.FixId = C.FixId
		 WHERE C.HiddenBy = @FixId
		   AND D.FixId IS NULL;

		FETCH NEXT FROM delf_cursor INTO @FixId;
	END
	CLOSE delf_cursor;
	DEALLOCATE delf_cursor;
	
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetLocationGeography]
(
	@Project VARCHAR(32)   = NULL, 
	@Animal  VARCHAR(32)   = NULL, 
	@Time    DATETIME2 = NULL
)
RETURNS GEOGRAPHY
AS
BEGIN
	DECLARE @Result GEOGRAPHY
	SET @Result = (SELECT [Location] 
	                 FROM [dbo].[Locations]
					WHERE [ProjectId] = @Project
					  AND [AnimalId] = @Animal
	                  AND [FixDate] = @Time);
	RETURN @Result
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetMovementEndGeography]
(
	@Project VARCHAR(32)   = NULL, 
	@Animal  VARCHAR(32)   = NULL, 
	@Time    DATETIME2 = NULL
)
RETURNS GEOGRAPHY
AS
BEGIN
	DECLARE @Result GEOGRAPHY
	SET @Result = (SELECT [Shape].STEndPoint() 
	                 FROM [dbo].[Movements]
					WHERE [ProjectId] = @Project
					  AND [AnimalId] = @Animal
	                  AND [EndDate] = @Time);
	RETURN @Result
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetMovementStartGeography]
(
	@Project VARCHAR(32)   = NULL, 
	@Animal  VARCHAR(32)   = NULL, 
	@Time    DATETIME2 = NULL
)
RETURNS GEOGRAPHY
AS
BEGIN
	DECLARE @Result GEOGRAPHY
	SET @Result = (SELECT [Shape].STStartPoint() 
	                 FROM [dbo].[Movements]
					WHERE [ProjectId] = @Project
					  AND [AnimalId] = @Animal
	                  AND [StartDate] = @Time);
	RETURN @Result
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Movement_Insert] 
	@Project NVARCHAR(255), 
	@Animal  NVARCHAR(255), 
	@PrevTime DATETIME2,
	@NextTime DATETIME2
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE
		@PrevPoint GEOGRAPHY,
		@NextPoint GEOGRAPHY;
		
	IF @Animal IS NOT NULL AND @PrevTime IS NOT NULL AND @NextTime IS NOT NULL
	BEGIN
		SET @PrevPoint = [dbo].[GetLocationGeography](@Project, @Animal, @PrevTime);
		SET @NextPoint = [dbo].[GetLocationGeography](@Project, @Animal, @NextTime);
		-- In some cases, the location we need may be deleted (Ah, the joys of processing a multirow trigger)
		-- In these cases, we can use the yet to be deleted movement,
		-- if there is still no point, then we do not need to add a movement
		IF @PrevPoint IS NULL
			SET @PrevPoint = [dbo].[GetMovementEndGeography](@Project, @Animal, @PrevTime);
		IF @NextPoint IS NULL
			SET @NextPoint = [dbo].[GetMovementStartGeography](@Project, @Animal, @NextTime);
		IF @PrevPoint IS NOT NULL AND @NextPoint IS NOT NULL
			EXEC [dbo].[Movement_Insert_Sub] @Project, @Animal, @PrevTime, @NextTime, @PrevPoint, @NextPoint;
	END
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: April 3, 2012
-- Description:	Add/Remove Locations when Deployment is updated
-- =============================================
CREATE TRIGGER [dbo].[AfterCollarDeploymentUpdate] 
   ON  [dbo].[CollarDeployments] 
   AFTER UPDATE
AS 
BEGIN
	SET NOCOUNT ON;
	
	--Retrevial date is the only thing that can change.
	IF UPDATE ([RetrievalDate])
	BEGIN
	
		-- triggers always execute in the context of a transaction
		-- so the following code is all or nothing.



  		-- When new retrevial date < old retrevial date we may lose some Locations
		-- Delete records from locations fix date is greater than the new retrieval date
/*
Example:  Time --->

  *-----D1-----* *------D2--------------->
      *              *               *
      L1             L2              L3
  *-----D1-----* *------D2-----*
                             
L1 is part of D1 but not D2,
L2 and L3 are part of original D2, but not D1
L3 is not part of either deploymnet after changing retrieval date on D2
*/
		DELETE L FROM dbo.Locations as L
				   -- Join to the deployment that created this location
		   INNER JOIN deleted as D
				   ON L.ProjectId = D.ProjectId
				  AND L.AnimalId = D.AnimalId
				  AND D.DeploymentDate < L.FixDate
				  AND (L.FixDate < D.RetrievalDate OR D.RetrievalDate IS NULL)
		   INNER JOIN inserted as I
				   ON I.ProjectId = D.ProjectId
				  AND I.AnimalId = D.AnimalId
				  AND I.CollarManufacturer = D.CollarManufacturer
				  AND I.CollarId = D.CollarId
				  AND I.DeploymentDate = D.DeploymentDate
				   -- These are the Locations to delete:
				WHERE I.RetrievalDate < L.FixDate 
				
				
		-- When new retrevial is null, or is greater than the old retrevial date we may gain some Locations
		-- Add locations for fixes that are now deployed, but were not before
/*
Example:  Time --->

  *-----D1-----* *------D2-----*
      *              *               *
      F1             F2              F3
  *-----D1-----* *------D2-----------------*  or --->
                             
Add Location for F3, but not F1 or F2
*/
		INSERT INTO Locations (ProjectId, AnimalId, FixDate, Location, FixId)
			 SELECT I.ProjectId, I.AnimalId, F.FixDate, geography::Point(F.Lat, F.Lon, 4326), F.FixId
			   FROM dbo.CollarFixes AS F
				 -- Join to the fixes that are covered by the new deployment dates
		 INNER JOIN inserted AS I
				 ON F.CollarManufacturer = I.CollarManufacturer
				AND F.CollarId = I.CollarId
	     INNER JOIN deleted as D
				 -- To get the old retrieval date, we need to link inserted and deleted deployments by PK
			     ON I.ProjectId = D.ProjectId
			    AND I.AnimalId = D.AnimalId
			    AND I.CollarManufacturer = D.CollarManufacturer
			    AND I.CollarId = D.CollarId
				AND I.DeploymentDate = D.DeploymentDate
         INNER JOIN dbo.Animals AS A
 	             ON A.ProjectId = I.ProjectId
		    	AND A.AnimalId = I.AnimalId
			  WHERE F.HiddenBy IS NULL
			    AND D.RetrievalDate < F.FixDate -- wasn't included before, note: NULL < F.FixDate is always false (good) 
				AND I.DeploymentDate < F.FixDate
				AND (I.RetrievalDate IS NULL OR F.FixDate < I.RetrievalDate)
	    	    AND (A.MortalityDate IS NULL OR F.FixDate < A.MortalityDate)

		/*
		These stored procedures would be clean, but they would require a cursor,
		stored procedures cannot be used in a set based solution.
		EXEC [dbo].[AddLocationForDeployment] @CollarManufacturer, @CollarId, @ProjectId, @AnimalId, @StartDate, @EndDate
		EXEC [dbo].[DeleteLocationForAnimalAndDateRange] @ProjectId, @AnimalId, @StartDate, @EndDate
		*/
	END
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: April 3, 2012
-- Description:	Adds Locations when Deployment is inserted
-- =============================================
CREATE TRIGGER [dbo].[AfterCollarDeploymentInsert] 
   ON  [dbo].[CollarDeployments] 
   AFTER INSERT
AS 
BEGIN
	SET NOCOUNT ON;
	
	-- Add locations for fixes that are now deployed
	INSERT INTO Locations (ProjectId, AnimalId, FixDate, Location, FixId)
		 SELECT I.ProjectId, I.AnimalId, F.FixDate, geography::Point(F.Lat, F.Lon, 4326), F.FixId
		   FROM dbo.CollarFixes AS F
	 INNER JOIN inserted AS I
		     ON F.CollarManufacturer = I.CollarManufacturer
		    AND F.CollarId = I.CollarId
	 INNER JOIN dbo.Animals AS A
			 ON A.ProjectId = I.ProjectId
			AND A.AnimalId = I.AnimalId
		  WHERE F.HiddenBy IS NULL
			AND I.DeploymentDate < F.FixDate
			AND (I.RetrievalDate IS NULL OR F.FixDate < I.RetrievalDate)
		    AND (A.MortalityDate IS NULL OR F.FixDate < A.MortalityDate) 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: April 3, 2012
-- Description:	Remove Locations when Deployment is deleted
-- =============================================
CREATE TRIGGER [dbo].[AfterCollarDeploymentDelete] 
   ON  [dbo].[CollarDeployments] 
   AFTER DELETE
AS 
BEGIN
	SET NOCOUNT ON;
	-- Delete records from locations that are no longer deployed
	DELETE L FROM dbo.Locations as L
	   INNER JOIN deleted as D
			   ON L.ProjectId = D.ProjectId
			  AND L.AnimalId = D.AnimalId
			  AND L.FixDate > D.DeploymentDate
			  AND (D.RetrievalDate IS NULL OR L.FixDate < D.RetrievalDate)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: June 3, 2012
-- Description:	Add/Remove Locations when Mortality Date is updated
-- =============================================
CREATE TRIGGER [dbo].[AfterAnimalUpdate] 
   ON  [dbo].[Animals] 
   AFTER UPDATE
AS 
BEGIN
	SET NOCOUNT ON;
	
	--Mortality date is the change that this trigger cares about.
	--Note: this just means that MortalityDate was included in the update statement,
	--      it does not mean that the value in this column has changed for all the
	--      rows updated. 
	IF UPDATE ([MortalityDate])
	BEGIN
	
		-- triggers always execute in the context of a transaction
		-- so the following code is all or nothing.

/* LOGIC:
   If old mortality date is null then
     if new mortality date is null
       no change, so do nothing
     else new mortality date is NOT null
       we may lose locations, but never gain any.
       delete locations where new mortality date < fix date 
   else
     if new mortality date is null
       if old mortality date is null
         no change, so do nothing     
       else old mortality date is NOT null
         we may gain some locations, but never lose any.
         add location where old mortality date < fix date
     else
       if new mortality date = old mortality date
         no change, so do nothing     
       else 
         delete locations where new mortality date < fix date and fix date < old mortality date
         add locations where old mortality date < fix date and fix date < new mortality date

  This can be simplified to:
    delete locations where new mortality date < fix date AND (fix date < old mortality date OR old mortality date is null) 
       add locations where old mortality date < fix date AND (fix date < new mortality date OR new mortality date is null)
*/
    
		DELETE L FROM dbo.Locations as L
				   -- Join to the animal that owns this location
		   INNER JOIN deleted as D
				   ON L.ProjectId = D.ProjectId
				  AND L.AnimalId = D.AnimalId
		   INNER JOIN inserted as I
				 -- To get the new mortality date, we need to link inserted and deleted animals by PK
				   ON I.ProjectId = D.ProjectId
				  AND I.AnimalId = D.AnimalId
				   -- These are the Locations to delete:
				WHERE I.MortalityDate < L.FixDate AND (L.FixDate < D.MortalityDate OR D.MortalityDate IS NULL) 
				

		INSERT INTO Locations (ProjectId, AnimalId, FixDate, Location, FixId)
			 SELECT I.ProjectId, I.AnimalId, F.FixDate, geography::Point(F.Lat, F.Lon, 4326), F.FixId
			   FROM dbo.CollarFixes AS F
			     -- Join to CollarDeployments to get to the animal
		 INNER JOIN CollarDeployments AS C
				 ON F.CollarManufacturer = C.CollarManufacturer
				AND F.CollarId = C.CollarId
				AND C.DeploymentDate < F.FixDate
				AND (F.FixDate < C.RetrievalDate OR C.RetrievalDate IS NULL)
				 -- Join these deployments to the animal being updated
		 INNER JOIN inserted AS I
				 ON C.ProjectId = I.ProjectId
				AND C.AnimalId = I.AnimalId
	     INNER JOIN deleted as D
				 -- To get the new mortality date, we need to link inserted and deleted animals by PK
			     ON I.ProjectId = D.ProjectId
			    AND I.AnimalId = D.AnimalId
				 -- These are the Fixes to add:
			  WHERE F.HiddenBy IS NULL
				AND D.MortalityDate < F.FixDate AND (F.FixDate < I.MortalityDate OR I.MortalityDate IS NULL) 
	END
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[PreviousLocationTime] 
(
	@Project VARCHAR(16)   = NULL, 
	@Animal  VARCHAR(16)   = NULL, 
	@Time    DATETIME2 = NULL
)
RETURNS DATETIME2
AS
BEGIN
	DECLARE @Result DATETIME2
	SET @Result = (SELECT TOP 1 [FixDate] 
					 FROM [dbo].[Locations]
					WHERE [ProjectId] = @Project
					  AND [AnimalId] = @Animal
					  AND [Status] IS NULL
					  AND [FixDate] < @Time
			     ORDER BY [FixDate] DESC);
	RETURN @Result
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[UpdateMovementAfterLocationUpdate] 
ON [dbo].[Locations]
AFTER UPDATE AS
IF UPDATE ([Status])
	BEGIN
		SET NOCOUNT ON;
		DECLARE
			@Project   VARCHAR(32),
			@Animal    VARCHAR(32),
			@Time      DATETIME2,
			@OldStatus CHAR(1),
			@NewStatus CHAR(1);
		  
		-- In an update, the old row is in 'deleted', and the new row is in 'inserted'.

		DECLARE up_cursor CURSOR FOR 
			SELECT [ProjectId], [AnimalId], [FixDate], [Status] FROM deleted ORDER BY [ProjectId], [AnimalId], [FixDate];

		OPEN up_cursor;

		FETCH NEXT FROM up_cursor INTO @Project, @Animal, @Time, @OldStatus;

		WHILE @@FETCH_STATUS = 0
		BEGIN
			SET @NewStatus = (SELECT [Status] FROM inserted WHERE [ProjectId] = @Project AND [AnimalId] = @Animal AND [FixDate] = @Time);
			
			IF @OldStatus IS NULL and @NewStatus IS NOT NULL
				EXEC [dbo].[Location_Deleted] @Project, @Animal, @Time;
			
			IF @OldStatus IS NOT NULL and @NewStatus IS NULL
				EXEC [dbo].[Location_Added] @Project, @Animal, @Time; 
			
			FETCH NEXT FROM up_cursor INTO @Project, @Animal, @Time, @OldStatus;
		END
		CLOSE up_cursor;
		DEALLOCATE up_cursor;
	END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[UpdateMovementAfterLocationInsert] 
ON [dbo].[Locations] 
AFTER INSERT AS
BEGIN
	SET NOCOUNT ON;
	DECLARE
		@Project VARCHAR(32),
		@Animal  VARCHAR(32),
		@Time    DATETIME2;
	  
	DECLARE ins_cursor CURSOR FOR 
		SELECT [ProjectId], [AnimalId], [FixDate]
		  FROM inserted
		 WHERE [Status] IS NULL  -- Inserting a location with a non-null status will not change the movements
	  ORDER BY [ProjectId], [AnimalId], [FixDate];

	OPEN ins_cursor;

	FETCH NEXT FROM ins_cursor INTO @Project, @Animal, @Time;

	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC [dbo].[Location_Added] @Project, @Animal, @Time ;
		FETCH NEXT FROM ins_cursor INTO @Project, @Animal, @Time;
	END
	CLOSE ins_cursor;
	DEALLOCATE ins_cursor;
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Microsoft Says: We do not recommend using cursors in triggers because they could potentially reduce performance. 
--                 To design a trigger that affects multiple rows, use rowset-based logic instead of cursors
-- However, the rowset based logic was too difficult to manage:
--   Because I think procedurally, and I needed to break the problem up into procedures to understand/code, however
--   while I can put a function in rowset logic, a function cannot use an INSERT/DELETE
--   while I can put an INSERT/DELETE in a stored procedure, I can't put a stored procedure in rowset logic.
--   Therefore I need to abandon my procedure based thinking, or I can use cursors. 
--   Example rowset logic with multi-column key in deleted and inserted virtual tables
--     DELETE m from [dbo].[Movement] as m inner join deleted as d on m.AnimalID = d.AnimalID and (d.fixdate = m.startdate or d.fixdate = m.enddate);
--     SELECT * FROM Movements as m Where Exists(Select 1 from inserted as i where i.AnimalID = m.AnimalID and (i.FixDate = m.StartDate or i.FixDate = m.EndDate)) 

-- I do not delete all movements in one operation (possible and faster),
--   because it is too hard to then figure out how to close all possible gaps
--   with new movements - the new locations may be in sequence, or random.


CREATE TRIGGER [dbo].[UpdateMovementAfterLocationDelete] 
ON [dbo].[Locations] 
AFTER DELETE AS
BEGIN
	SET NOCOUNT ON;
	DECLARE
		@Project VARCHAR(32),
		@Animal  VARCHAR(32),
		@Time    DATETIME2;
	  
	DECLARE del_cursor CURSOR FOR 
		SELECT [ProjectId], [AnimalId], [FixDate]
		  FROM deleted
		 WHERE [Status] IS NULL  --Deleting a location with a non-null status will not change the movements
	  ORDER BY [ProjectId], [AnimalId], [FixDate];

	OPEN del_cursor;

	FETCH NEXT FROM del_cursor INTO @Project, @Animal, @Time;

	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC [dbo].[Location_Deleted] @Project, @Animal, @Time;
		FETCH NEXT FROM del_cursor INTO @Project, @Animal, @Time;
	END
	CLOSE del_cursor;
	DEALLOCATE del_cursor;
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[UpdateLocationAfterCollarFixesUpdate] 
ON [dbo].[CollarFixes]
AFTER UPDATE AS
IF UPDATE ([HiddenBy])
	-- HiddenBy is the only field that is allowed to be updated (all other changes must
	-- be done with a delete/insert.  This is managed with permissions on the table and
	-- the functionality of permitted stored procedures
	BEGIN
		SET NOCOUNT ON;

		-- In an update, the old rows are in 'deleted', and the new rows are in 'inserted'.
		-- deleted/inserted are tables, since multiple records can be changed at once.
		-- All updated rows are included, even those that didn't update hiddenby
		
		-- Basic logic for a changing a SINGLE CollarFix:
		--   if HiddenBy goes from NULL to NOT NULL then remove record from Locations table
		--   if HiddenBy goes from NOT NULL to NULL then add new record to Locations table
		
		-- Can I change multiple fixes at once?
		--  Yes.  Since changes to CollarFixes are managed, and only done by routines
		--        that honor the requirements of the HiddenBy relationship between
		--        records in the table, I do not need to worry about how these changes
		--        effect other records in the table.  I only need to manage the changes
		--        to the locations table.
		
		-- if HiddenBy goes from NULL to NOT NULL then
		-- remove record from Locations table
		DELETE L FROM Locations as L
		   INNER JOIN deleted as D
				   ON L.FixId = D.FixId
		   INNER JOIN inserted as I
				   ON L.FixId = I.FixId
				WHERE D.HiddenBy IS NULL AND I.HiddenBy IS NOT NULL
		
		-- if HiddenBy goes from NOT NULL to NULL then
		-- Add new record to Locations table, if FixDate is acceptable 
		INSERT INTO Locations (ProjectId, AnimalId, FixDate, Location, FixId)
			 SELECT C.ProjectId, C.AnimalId, I.FixDate, geography::Point(I.Lat, I.Lon, 4326) AS Location, I.FixId
			   FROM inserted as I
		 INNER JOIN deleted as D
				 ON D.FixId = I.FixId
		 INNER JOIN dbo.CollarDeployments as C
				 ON C.CollarManufacturer = I.CollarManufacturer
				AND C.CollarId = I.CollarId
         INNER JOIN dbo.Animals AS A
 	             ON A.ProjectId = C.ProjectId
		    	AND A.AnimalId = C.AnimalId
			  WHERE D.HiddenBy IS NOT NULL AND I.HiddenBy IS NULL
			    AND C.DeploymentDate <= I.FixDate
			    AND (C.RetrievalDate IS NULL OR I.FixDate <= C.RetrievalDate)
	    	    AND (A.MortalityDate IS NULL OR I.FixDate <= A.MortalityDate) 

	END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[StartOfPriorConnectedMovement] 
(
	@Project VARCHAR(16)   = NULL, 
	@Animal  VARCHAR(16)   = NULL, 
	@Time    DATETIME2 = NULL
)
RETURNS DATETIME2
AS
BEGIN
	DECLARE @Result DATETIME2
	SET @Result = (SELECT [StartDate] 
					 FROM [dbo].[Movements]
					WHERE [ProjectId] = @Project
					  AND [AnimalId] = @Animal
					  AND [EndDate] = @Time);
	RETURN @Result
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[StartOfOverlappingMovement] 
(
	@Project VARCHAR(16)   = NULL, 
	@Animal  VARCHAR(16)   = NULL, 
	@Time    DATETIME2 = NULL
)
RETURNS DATETIME2
AS
BEGIN
	DECLARE @Result DATETIME2
	SET @Result = (SELECT TOP 1 [StartDate]
	                 FROM [dbo].[Movements]
					WHERE [ProjectId] = @Project
					  AND [AnimalId] = @Animal
	                  AND [StartDate] < @Time
	                  AND [EndDate] > @Time
	             ORDER BY [StartDate] DESC);
	RETURN @Result
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: June 15, 2012
-- Description:	Test the CollarDeployments DeleteTrigger
-- =============================================
CREATE PROCEDURE [dbo].[Test_Trigger_CollarDeployments_Delete] 
AS
BEGIN
	SET NOCOUNT ON
	
	PRINT 'Test_Trigger_CollarDeployments_Delete'
	PRINT '  See Test_Trigger_CollarDeployments_Insert'

END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: June 11, 2012
-- Description:	Test the Animals UpdateTrigger
-- =============================================
CREATE PROCEDURE [dbo].[Test_Trigger_Animals_Update] 
AS
BEGIN
	SET NOCOUNT ON
	
	PRINT 'Test_Trigger_Animals_Update'
	PRINT '  Test not written yet'

END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: June 11, 2012
-- Description:	Test the Locations UpdateTrigger
-- =============================================
CREATE PROCEDURE [dbo].[Test_Trigger_Locations_Update] 
AS
BEGIN
	SET NOCOUNT ON
	
	PRINT 'Test_Trigger_Locations_Update'
	PRINT '  Test not written yet'

END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: June 15, 2012
-- Description:	Test the Locations InsertTrigger
-- =============================================
CREATE PROCEDURE [dbo].[Test_Trigger_Locations_Insert] 
AS
BEGIN
	SET NOCOUNT ON
	
	PRINT 'Test_Trigger_Locations_Insert'
	PRINT '  Test not written yet (some testing in CollarFixes_Insert)'

END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: June 11, 2012
-- Description:	Test the Locations DeleteTrigger
-- =============================================
CREATE PROCEDURE [dbo].[Test_Trigger_Locations_Delete] 
AS
BEGIN
	SET NOCOUNT ON
	
	PRINT 'Test_Trigger_Locations_Delete'
	PRINT '  Test not written yet'

END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Create the stored procedure to generate an error using 
-- RAISERROR. The original error information is used to
-- construct the msg_str for RAISERROR.
-- must be called from a CATCH block
-- pilfered from http://msdn.microsoft.com/en-us/library/ms179296.aspx
CREATE PROCEDURE [dbo].[Utility_RethrowError] AS
    -- Return if there is no error information to retrieve.
    IF ERROR_NUMBER() IS NULL
        RETURN;

    DECLARE 
        @ErrorMessage    NVARCHAR(4000),
        @ErrorNumber     INT,
        @ErrorSeverity   INT,
        @ErrorState      INT,
        @ErrorLine       INT,
        @ErrorProcedure  NVARCHAR(200);

    -- Assign variables to error-handling functions that 
    -- capture information for RAISERROR.
    SELECT 
        @ErrorNumber = ERROR_NUMBER(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE(),
        @ErrorLine = ERROR_LINE(),
        @ErrorProcedure = ISNULL(ERROR_PROCEDURE(), '-');

    -- Build the message string that will contain original
    -- error information.
    SELECT @ErrorMessage = 
        N'Error %d, Level %d, State %d, Procedure %s, Line %d, ' + 
            'Message: '+ ERROR_MESSAGE();

    -- Raise an error: msg_str parameter of RAISERROR will contain
    -- the original error information.
    RAISERROR 
        (
        @ErrorMessage, 
        @ErrorSeverity, 
        1,               
        @ErrorNumber,    -- parameter: original error number.
        @ErrorSeverity,  -- parameter: original error severity.
        @ErrorState,     -- parameter: original error state.
        @ErrorProcedure, -- parameter: original error procedure name.
        @ErrorLine       -- parameter: original error line number.
        );
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Settings](
	[Username] [sysname] NOT NULL,
	[Key] [nvarchar](30) NOT NULL,
	[Value] [nvarchar](500) NULL,
 CONSTRAINT [PK_Settings] PRIMARY KEY CLUSTERED 
(
	[Username] ASC,
	[Key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LookupQueryLayerServers](
	[Location] [nvarchar](128) NOT NULL,
	[Connection] [nvarchar](255) NOT NULL,
	[Database] [sysname] NULL,
 CONSTRAINT [PK_QueryLayerServers] PRIMARY KEY CLUSTERED 
(
	[Location] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[DoDateRangesOverlap] 
(
	@StartDate1		DATETIME2 = NULL, 
	@EndDate1		DATETIME2 = NULL,
	@StartDate2		DATETIME2 = NULL, 
	@EndDate2		DATETIME2 = NULL
)
RETURNS BIT
AS
BEGIN
	-- A StartDate of NULL means the begining of time
	-- A EndDate of NULL means the ending of time
	
	-- There are nine cases: (NULL2DATE, DATE2DATE, DATE2NULL)^2
	
	IF @StartDate1 IS NULL and @EndDate1 IS NOT NULL
	BEGIN
		IF @StartDate2 IS NULL and @EndDate2 IS NOT NULL
		BEGIN
			RETURN 1
		END
		IF @StartDate2 IS NOT NULL and @EndDate2 IS NOT NULL
		BEGIN
			IF @EndDate1 < @StartDate2 RETURN 0 ELSE RETURN 1
		END	
		IF @StartDate2 IS NOT NULL and @EndDate2 IS NULL
		BEGIN
			IF @EndDate1 < @StartDate2 RETURN 0 ELSE RETURN 1
		END	
	END
	
	IF @StartDate1 IS NOT NULL and @EndDate1 IS NOT NULL
	BEGIN
		IF @StartDate2 IS NULL and @EndDate2 IS NOT NULL
		BEGIN
			IF @EndDate2 < @StartDate1 RETURN 0 ELSE RETURN 1
		END
		IF @StartDate2 IS NOT NULL and @EndDate2 IS NOT NULL
		BEGIN
			IF @EndDate2 < @StartDate1 OR @EndDate1 < @StartDate2  RETURN 0 ELSE RETURN 1
		END	
		IF @StartDate2 IS NOT NULL and @EndDate2 IS NULL
		BEGIN
			IF @EndDate1 < @StartDate2 RETURN 0 ELSE RETURN 1
		END	
	END	

	IF @StartDate1 IS NOT NULL and @EndDate1 IS NULL
	BEGIN
		IF @StartDate2 IS NULL and @EndDate2 IS NOT NULL
		BEGIN
			IF @EndDate2 < @StartDate1 RETURN 0 ELSE RETURN 1
		END
		IF @StartDate2 IS NOT NULL and @EndDate2 IS NOT NULL
		BEGIN
			IF @EndDate2 < @StartDate1 RETURN 0 ELSE RETURN 1
		END	
		IF @StartDate2 IS NOT NULL and @EndDate2 IS NULL
		BEGIN
			RETURN 1
		END	
	END
	-- We should never get here
	RETURN 1
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* Converts a datetime to the ordinal date (day of the year)
 * commonly confused with the Julian date (days sine 1/1/4713BC)
 */
CREATE FUNCTION [dbo].[DateTimeToOrdinal] (
    @Date DATETIME2  
)   
	RETURNS INT
    WITH SCHEMABINDING -- This is a deterministic function.

AS
BEGIN
    RETURN 1 + DATEDIFF (day,
                         CONVERT(DATETIME2,
                                 CAST(YEAR(@Date) AS CHAR(4))+'0101',
                                 112), -- format 112 (yyyymmdd) is deterministic
                         @Date)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[CollarsNotCurrentlyDeployed]
AS
SELECT     dbo.Collars.CollarId, dbo.Collars.CollarModel, dbo.Collars.Frequency, dbo.Collars.DownloadInfo, dbo.LookupCollarManufacturers.CollarManufacturer, 
                      dbo.LookupCollarManufacturers.Name, dbo.LookupCollarManufacturers.Website, dbo.LookupCollarManufacturers.Description, dbo.Collars.Notes, 
                      dbo.Collars.SerialNumber, dbo.Collars.AlternativeId, dbo.Collars.Owner, dbo.Collars.Manager
FROM         dbo.Collars INNER JOIN
                      dbo.CollarDeployments ON dbo.Collars.CollarManufacturer = dbo.CollarDeployments.CollarManufacturer AND 
                      dbo.Collars.CollarId = dbo.CollarDeployments.CollarId INNER JOIN
                      dbo.LookupCollarManufacturers ON dbo.Collars.CollarManufacturer = dbo.LookupCollarManufacturers.CollarManufacturer LEFT OUTER JOIN
                      dbo.CurrentDeployments ON dbo.CollarDeployments.ProjectId = dbo.CurrentDeployments.ProjectId AND 
                      dbo.CollarDeployments.AnimalId = dbo.CurrentDeployments.AnimalId AND 
                      dbo.CollarDeployments.CollarManufacturer = dbo.CurrentDeployments.CollarManufacturer AND 
                      dbo.CollarDeployments.CollarId = dbo.CurrentDeployments.CollarId
WHERE     (dbo.CurrentDeployments.ProjectId IS NULL)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[CollarsNeverDeployed]
AS
SELECT     dbo.Collars.CollarModel, dbo.Collars.Frequency, dbo.Collars.DownloadInfo, dbo.LookupCollarManufacturers.Name, dbo.LookupCollarManufacturers.Website, 
                      dbo.LookupCollarManufacturers.Description, dbo.Collars.Manager, dbo.Collars.Owner, dbo.Collars.AlternativeId, dbo.Collars.SerialNumber, dbo.Collars.Notes, 
                      dbo.CollarDeployments.ProjectId, dbo.CollarDeployments.AnimalId, dbo.CollarDeployments.DeploymentDate, dbo.CollarDeployments.RetrievalDate, 
                      dbo.Collars.CollarManufacturer, dbo.Collars.CollarId
FROM         dbo.Collars INNER JOIN
                      dbo.LookupCollarManufacturers ON dbo.Collars.CollarManufacturer = dbo.LookupCollarManufacturers.CollarManufacturer LEFT OUTER JOIN
                      dbo.CollarDeployments ON dbo.Collars.CollarManufacturer = dbo.CollarDeployments.CollarManufacturer AND 
                      dbo.Collars.CollarId = dbo.CollarDeployments.CollarId
WHERE     (dbo.CollarDeployments.CollarId IS NULL)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[CollarsCurrentlyDeployed]
AS
SELECT     dbo.CollarDeployments.ProjectId, dbo.CollarDeployments.AnimalId, dbo.CollarDeployments.CollarManufacturer AS Expr1, dbo.CollarDeployments.CollarId AS Expr2, 
                      dbo.CollarDeployments.DeploymentDate, dbo.CollarDeployments.RetrievalDate, dbo.LookupCollarManufacturers.Name, dbo.LookupCollarManufacturers.Website, 
                      dbo.LookupCollarManufacturers.Description, dbo.Collars.CollarModel, dbo.Collars.Frequency, dbo.Collars.DownloadInfo, dbo.Collars.Manager, dbo.Collars.Owner, 
                      dbo.Collars.AlternativeId, dbo.Collars.SerialNumber, dbo.Collars.Notes
FROM         dbo.CollarDeployments INNER JOIN
                      dbo.Collars ON dbo.CollarDeployments.CollarManufacturer = dbo.Collars.CollarManufacturer AND dbo.CollarDeployments.CollarId = dbo.Collars.CollarId INNER JOIN
                      dbo.LookupCollarManufacturers ON dbo.Collars.CollarManufacturer = dbo.LookupCollarManufacturers.CollarManufacturer
WHERE     (dbo.CollarDeployments.DeploymentDate < GETDATE()) AND (dbo.CollarDeployments.RetrievalDate > GETDATE() OR
                      dbo.CollarDeployments.RetrievalDate IS NULL)
GO
CREATE FUNCTION [dbo].[LocalTime](@utcDateTime [datetime])
RETURNS [datetime] WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SqlServerExtensions].[SqlServerExtensions.AnimalMovementFunctions].[LocalTime]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: May 30, 2012
-- Description:	Returns a table of conflicting fixes for a specific collar.
-- Example:     SELECT * FROM ConflictingFixes('Telonics', '96007')
-- Modified:    Aug 15, 2012, filtered conflicts only include series that have different locations 
-- =============================================
CREATE FUNCTION [dbo].[ConflictingFixes] 
(
	@CollarManufacturer NVARCHAR(255), 
	@CollarId           NVARCHAR(255)
)
RETURNS TABLE 
AS
	RETURN
		SELECT FixId, HiddenBy, FileId, LineNumber, dbo.LocalTime(C.FixDate) AS LocalFixTime, Lat, Lon
		FROM CollarFixes AS C
		INNER JOIN 
			(SELECT   CollarManufacturer, CollarId, FixDate 
			 FROM
				(SELECT DISTINCT CollarManufacturer, CollarId, FixDate, Lat, Lon
				 FROM CollarFixes
			     WHERE CollarManufacturer = @CollarManufacturer AND CollarId = @CollarId) AS T
			 GROUP BY CollarManufacturer, CollarId, FixDate
			 HAVING   COUNT(FixDate) > 1) AS D
		ON  C.CollarManufacturer = D.CollarManufacturer
		AND C.CollarId = D.CollarId
		AND C.FixDate = D.FixDate
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: May 30, 2012
-- Description:	Returns a row of fix information for a specific collar.
-- Example:     SELECT * FROM CollarFixSummary('Telonics', '96007')
-- Modified:    Aug 16, 2012, added Unique field
-- =============================================
CREATE FUNCTION [dbo].[CollarFixSummary] 
(
	@CollarManufacturer NVARCHAR(255), 
	@CollarId           NVARCHAR(255)
)
RETURNS @summary TABLE
(
	[Count] int,
	[Unique] int,
	[First] datetime2,
	[Last] datetime2
) 
AS
BEGIN
	DECLARE @temp int;
	
	SELECT @temp = 1 
	FROM [dbo].[CollarFixes]
	WHERE CollarManufacturer = @CollarManufacturer AND CollarId = @CollarId
	GROUP BY FixDate
	
	INSERT @summary
	SELECT  COUNT(*) AS [Count],
			@@ROWCOUNT AS [Unique],
			dbo.LocalTime(MIN(FixDate)) AS [First],
			dbo.LocalTime(MAX(FixDate)) AS [Last]
	FROM [dbo].[CollarFixes]
	WHERE CollarManufacturer = @CollarManufacturer AND CollarId = @CollarId
	GROUP BY CollarManufacturer, CollarId
	
	RETURN
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: May 30, 2012
-- Description:	Returns a row of location information for a specific animal.
-- Example:     SELECT * FROM AnimalLocationSummary('LACL_Sheep', '0501')
-- =============================================
CREATE FUNCTION [dbo].[AnimalLocationSummary] 
(
	@ProjectId	NVARCHAR(255), 
	@AnimalId	NVARCHAR(255)
)
RETURNS TABLE 
AS
	RETURN
		SELECT	COUNT(*) as [Count],
				MIN(Location.Long) as [Left], MAX(Location.Long) as [Right],
				MIN(Location.Lat) as [Bottom], MAX(Location.Lat) as [Top],
				dbo.LocalTime(MIN(FixDate)) AS [First], dbo.LocalTime(MAX(FixDate)) as [Last]
		 FROM     [dbo].[Locations]
		 WHERE    ProjectId = @ProjectId AND AnimalId = @AnimalId AND Status IS NULL
		 GROUP BY ProjectId, AnimalId
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LookupCollarParameterFileFormats](
	[Code] [char](1) NOT NULL,
	[CollarManufacturer] [varchar](16) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](255) NULL,
 CONSTRAINT [PK_LookupCollarParameterFileFormats] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VelocityVectors]
AS
    SELECT M.[ProjectId]
          ,M.[AnimalId]
          --,M.[StartDate]
          --,M.[EndDate]
          ,dbo.LocalTime(M.[StartDate]) as [LocalDateTime]
          ,dbo.LocalTime(M.[EndDate]) as [EndLocalDateTime]
          ,YEAR(M.[StartDate]) as [Year]
          ,dbo.DateTimeToOrdinal(dbo.LocalTime(M.[StartDate])) as [OrdinalDate]
          ,M.[Duration]
          ,M.[Distance]
          ,M.[Speed]
          ,P.[UnitCode]
          ,A.[Species]
          ,A.[Gender]
          ,A.[GroupName]
          ,M.[Shape]
      FROM dbo.Movements AS M
INNER JOIN dbo.Animals   AS A  ON M.ProjectId = A.ProjectId
							  AND M.AnimalId  = A.AnimalId
INNER JOIN dbo.Projects  AS P  ON A.ProjectId = P.ProjectId
     WHERE M.Distance <> 0
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ValidLocations]
AS
    SELECT L.FixId
          ,L.ProjectId
          ,L.AnimalId
          ,L.[FixDate]
          ,dbo.LocalTime(L.[FixDate]) as [LocalDateTime]
          ,YEAR(L.[FixDate]) as [Year]
          ,dbo.DateTimeToOrdinal(dbo.LocalTime(L.[FixDate])) as [OrdinalDate]
          ,P.[UnitCode]
          ,A.[Species]
          ,A.[Gender]
          ,A.[GroupName]
          --,L.[Status]
          ,L.[Location] AS [Shape]
      FROM dbo.Locations AS L
INNER JOIN dbo.Animals   AS A  ON L.ProjectId = A.ProjectId
							  AND L.AnimalId  = A.AnimalId
INNER JOIN dbo.Projects  AS P  ON A.ProjectId = P.ProjectId
     WHERE L.Status IS NULL
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[NoMovement]
AS
    SELECT M.[ProjectId]
          ,M.[AnimalId]
          --,M.[StartDate]
          --,M.[EndDate]
          ,dbo.LocalTime(M.[StartDate]) as [LocalDateTime]
          ,dbo.LocalTime(M.[EndDate]) as [EndLocalDateTime]
          ,YEAR(M.[StartDate]) as [Year]
          ,dbo.DateTimeToOrdinal(dbo.LocalTime(M.[StartDate])) as [OrdinalDate]
          ,M.[Duration]
          --,M.[Distance]
          ,M.[Speed]
          ,P.[UnitCode]
          ,A.[Species]
          ,A.[Gender]
          ,A.[GroupName]
          ,M.[Shape]
      FROM dbo.Movements AS M
INNER JOIN dbo.Animals   AS A  ON M.ProjectId = A.ProjectId
							  AND M.AnimalId  = A.AnimalId
INNER JOIN dbo.Projects  AS P  ON A.ProjectId = P.ProjectId
     WHERE M.Distance = 0
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[NextAnimalId] 
(
	@ProjectId VARCHAR(32)   = NULL 
)
RETURNS VARCHAR(16)
AS
BEGIN
	-- Check that project exists
	IF NOT EXISTS( SELECT 1 FROM Projects WHERE ProjectId = @ProjectId)
	BEGIN
			-- You can't raise errors in a function, so you can either do an illegal operation to
			-- stop the process, or in may case I will just return a safe result
			RETURN NULL
	END
	
	DECLARE @Year CHAR(2)
	DECLARE @Count int
	DECLARE @Id VARCHAR(16)

	--Get the prefix for the current year (i.e. 2012 -> '12')
	SELECT @Year  = SUBSTRING(CONVERT(CHAR(4),YEAR(GETDATE())),3,2)
	SELECT @Count =	convert(varchar(10),(max(id) + 1))
	  from (select case WHEN ISNUMERIC(SUBSTRING(AnimalId, 3, 9)) = 1
	                    then convert(int,SUBSTRING(AnimalId, 3, 9))
	                    ELSE 0 END as id
	          from Animals
	         where ProjectId = @ProjectId AND AnimalId LIKE @Year+'%') as t
	if (@Count < 100)
		SELECT @Id = @Year + REPLACE(STR(@Count, 2, 0), ' ', '0')
	else
		SELECT @Id = @Year + REPLACE(STR(@Count, 6, 0), ' ', '')
	If @Id is null
		SET @Id = @Year + '01'
	RETURN @id
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[InvalidLocations]
AS
    SELECT L.FixId
          ,L.ProjectId
          ,L.AnimalId
          ,L.[FixDate]
          ,dbo.LocalTime(L.[FixDate]) as [LocalDateTime]
          ,YEAR(L.[FixDate]) as [Year]
          ,dbo.DateTimeToOrdinal(dbo.LocalTime(L.[FixDate])) as [OrdinalDate]
          ,P.[UnitCode]
          ,A.[Species]
          ,A.[Gender]
          ,A.[GroupName]
          ,L.[Status]
          ,L.[Location] AS [Shape]
      FROM dbo.Locations AS L
INNER JOIN dbo.Animals   AS A  ON L.ProjectId = A.ProjectId
							  AND L.AnimalId  = A.AnimalId
INNER JOIN dbo.Projects  AS P  ON A.ProjectId = P.ProjectId
     WHERE L.Status IS NOT NULL
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[AnimalsNotCurrentlyCollared]
AS
SELECT     dbo.Animals.AnimalId, dbo.Animals.Species, dbo.Animals.Gender, dbo.Animals.GroupName, dbo.Projects.ProjectId, dbo.Projects.ProjectName, 
                      dbo.Projects.ProjectInvestigator AS UnitCode, dbo.Projects.UnitCode AS PrincipalInvestigator, dbo.Projects.Description
FROM         dbo.Animals INNER JOIN
                      dbo.CollarDeployments ON dbo.Animals.ProjectId = dbo.CollarDeployments.ProjectId AND dbo.Animals.AnimalId = dbo.CollarDeployments.AnimalId INNER JOIN
                      dbo.Projects ON dbo.Animals.ProjectId = dbo.Projects.ProjectId LEFT OUTER JOIN
                      dbo.CurrentDeployments ON dbo.CollarDeployments.ProjectId = dbo.CurrentDeployments.ProjectId AND 
                      dbo.CollarDeployments.AnimalId = dbo.CurrentDeployments.AnimalId AND 
                      dbo.CollarDeployments.CollarManufacturer = dbo.CurrentDeployments.CollarManufacturer AND 
                      dbo.CollarDeployments.CollarId = dbo.CurrentDeployments.CollarId
WHERE     (dbo.CurrentDeployments.ProjectId IS NULL)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[AnimalsNeverCollared]
AS
SELECT     dbo.Animals.AnimalId, dbo.Animals.Species, dbo.Animals.Gender, dbo.Animals.GroupName, dbo.Projects.ProjectId, dbo.Projects.ProjectName, 
                      dbo.Projects.ProjectInvestigator AS UnitCode, dbo.Projects.UnitCode AS PrincipalInvestigator, dbo.Projects.Description
FROM         dbo.Projects INNER JOIN
                      dbo.Animals ON dbo.Projects.ProjectId = dbo.Animals.ProjectId LEFT OUTER JOIN
                      dbo.CollarDeployments ON dbo.Animals.ProjectId = dbo.CollarDeployments.ProjectId AND dbo.Animals.AnimalId = dbo.CollarDeployments.AnimalId
WHERE     (dbo.CollarDeployments.ProjectId IS NULL)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[AnimalsCurrentlyCollared]
AS
SELECT     dbo.Animals.AnimalId, dbo.Animals.Species, dbo.Animals.Gender, dbo.Animals.GroupName, dbo.Projects.ProjectId, dbo.Projects.ProjectName, 
                      dbo.Projects.ProjectInvestigator AS UnitCode, dbo.Projects.UnitCode AS PrincipalInvestigator, dbo.Projects.Description
FROM         dbo.CollarDeployments INNER JOIN
                      dbo.Animals ON dbo.CollarDeployments.ProjectId = dbo.Animals.ProjectId AND dbo.CollarDeployments.AnimalId = dbo.Animals.AnimalId INNER JOIN
                      dbo.Projects ON dbo.Animals.ProjectId = dbo.Projects.ProjectId
WHERE     (dbo.CollarDeployments.DeploymentDate < GETDATE()) AND (dbo.CollarDeployments.RetrievalDate > GETDATE() OR
                      dbo.CollarDeployments.RetrievalDate IS NULL)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[AnimalFixesByFile]
AS
SELECT     dbo.CollarFixes.FileId, dbo.LookupCollarManufacturers.Name AS Manufacturer, dbo.CollarFixes.CollarId, dbo.Projects.ProjectName AS Project, 
           dbo.CollarDeployments.AnimalId, dbo.LocalTime(MIN(dbo.CollarFixes.FixDate)) AS [First Fix],
           dbo.LocalTime(MAX(dbo.CollarFixes.FixDate)) AS [Last Fix], COUNT(dbo.CollarFixes.FixDate) AS [Number of Fixes]
FROM         dbo.CollarFixes INNER JOIN
                      dbo.CollarDeployments ON dbo.CollarFixes.CollarManufacturer = dbo.CollarDeployments.CollarManufacturer AND 
                      dbo.CollarFixes.CollarId = dbo.CollarDeployments.CollarId AND dbo.CollarFixes.FixDate > dbo.CollarDeployments.DeploymentDate AND 
                      (dbo.CollarFixes.FixDate < dbo.CollarDeployments.RetrievalDate OR
                      dbo.CollarDeployments.RetrievalDate IS NULL) INNER JOIN
                      dbo.LookupCollarManufacturers ON dbo.CollarFixes.CollarManufacturer = dbo.LookupCollarManufacturers.CollarManufacturer LEFT OUTER JOIN
                      dbo.Projects ON dbo.CollarDeployments.ProjectId = dbo.Projects.ProjectId
GROUP BY dbo.Projects.ProjectName, dbo.CollarDeployments.AnimalId, dbo.CollarFixes.FileId, dbo.LookupCollarManufacturers.Name, dbo.CollarFixes.CollarId
GO
CREATE FUNCTION [dbo].[ParseFormatD](@fileId [int])
RETURNS  TABLE (
	[LineNumber] [int] NULL,
	[TXDate] [nvarchar](50) NULL,
	[TXTime] [nvarchar](50) NULL,
	[PTTID] [nvarchar](50) NULL,
	[FixNum] [nvarchar](50) NULL,
	[FixQual] [nvarchar](50) NULL,
	[FixDate] [nvarchar](50) NULL,
	[FixTime] [nvarchar](50) NULL,
	[Longitude] [nvarchar](50) NULL,
	[Latitude] [nvarchar](50) NULL
) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SqlServerExtensions].[SqlServerExtensions.AnimalMovementFunctions].[ParseFormatD]
GO
CREATE FUNCTION [dbo].[ParseFormatC](@fileId [int])
RETURNS  TABLE (
	[LineNumber] [int] NULL,
	[AcquisitionTime] [nvarchar](50) NULL,
	[AcquisitionStartTime] [nvarchar](50) NULL,
	[Ctn] [nvarchar](50) NULL,
	[ArgosId] [nvarchar](50) NULL,
	[ArgosLocationClass] [nvarchar](50) NULL,
	[ArgosLatitude] [nvarchar](50) NULL,
	[ArgosLongitude] [nvarchar](50) NULL,
	[ArgosAltitude] [nvarchar](50) NULL,
	[GpsFixTime] [nvarchar](50) NULL,
	[GpsFixAttempt] [nvarchar](50) NULL,
	[GpsLatitude] [nvarchar](50) NULL,
	[GpsLongitude] [nvarchar](50) NULL,
	[GpsUtmZone] [nvarchar](50) NULL,
	[GpsUtmNorthing] [nvarchar](50) NULL,
	[GpsUtmEasting] [nvarchar](50) NULL,
	[GpsAltitude] [nvarchar](50) NULL,
	[GpsSpeed] [nvarchar](50) NULL,
	[GpsHeading] [nvarchar](50) NULL,
	[GpsHorizontalError] [nvarchar](50) NULL,
	[GpsPositionalDilution] [nvarchar](50) NULL,
	[GpsHorizontalDilution] [nvarchar](50) NULL,
	[GpsSatelliteBitmap] [nvarchar](50) NULL,
	[GpsSatelliteCount] [nvarchar](50) NULL,
	[GpsNavigationTime] [nvarchar](50) NULL,
	[UnderwaterPercentage] [nvarchar](50) NULL,
	[DiveCount] [nvarchar](50) NULL,
	[AverageDiveDuration] [nvarchar](50) NULL,
	[MaximumDiveDuration] [nvarchar](50) NULL,
	[LayerPercentage] [nvarchar](50) NULL,
	[MaximumDiveDepth] [nvarchar](50) NULL,
	[DiveStartTime] [nvarchar](50) NULL,
	[DiveDuration] [nvarchar](50) NULL,
	[DiveDepth] [nvarchar](50) NULL,
	[DiveProfile] [nvarchar](50) NULL,
	[ActivityCount] [nvarchar](50) NULL,
	[Temperature] [nvarchar](50) NULL,
	[RemoteAnalog] [nvarchar](50) NULL,
	[SatelliteUplink] [nvarchar](50) NULL,
	[ReceiveTime] [nvarchar](50) NULL,
	[SatelliteName] [nvarchar](50) NULL,
	[RepetitionCount] [nvarchar](50) NULL,
	[LowVoltage] [nvarchar](50) NULL,
	[Mortality] [nvarchar](50) NULL,
	[SaltwaterFailsafe] [nvarchar](50) NULL,
	[HaulOut] [nvarchar](50) NULL,
	[DigitalInput] [nvarchar](50) NULL,
	[MotionDetected] [nvarchar](50) NULL,
	[TrapTriggerTime] [nvarchar](50) NULL,
	[ReleaseTime] [nvarchar](50) NULL,
	[PredeploymentData] [nvarchar](50) NULL,
	[Error] [nvarchar](250) NULL
) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SqlServerExtensions].[SqlServerExtensions.AnimalMovementFunctions].[ParseFormatC]
GO
CREATE FUNCTION [dbo].[ParseFormatB](@fileId [int])
RETURNS  TABLE (
	[LineNumber] [int] NULL,
	[CollarID] [nvarchar](255) NULL,
	[AnimalId] [nvarchar](255) NULL,
	[Species] [nvarchar](255) NULL,
	[Group] [nvarchar](255) NULL,
	[Park] [nvarchar](255) NULL,
	[FixDate] [nvarchar](255) NULL,
	[FixTime] [nvarchar](255) NULL,
	[FixMonth] [int] NULL,
	[FixDay] [int] NULL,
	[FixYear] [int] NULL,
	[LatWGS84] [float] NULL,
	[LonWGS84] [float] NULL,
	[Temperature] [float] NULL,
	[Other] [nvarchar](255) NULL
) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SqlServerExtensions].[SqlServerExtensions.AnimalMovementFunctions].[ParseFormatB]
GO
CREATE FUNCTION [dbo].[ParseFormatA](@fileId [int])
RETURNS  TABLE (
	[LineNumber] [int] NULL,
	[Fix #] [nvarchar](50) NULL,
	[Date] [nvarchar](50) NULL,
	[Time] [nvarchar](50) NULL,
	[Fix Status] [nvarchar](50) NULL,
	[Status Text] [nvarchar](150) NULL,
	[Velocity East(m s)] [nvarchar](50) NULL,
	[Velocity North(m s)] [nvarchar](50) NULL,
	[Velocity Up(m s)] [nvarchar](50) NULL,
	[Latitude] [nvarchar](50) NULL,
	[Longitude] [nvarchar](50) NULL,
	[Altitude(m)] [nvarchar](50) NULL,
	[PDOP] [nvarchar](50) NULL,
	[HDOP] [nvarchar](50) NULL,
	[VDOP] [nvarchar](50) NULL,
	[TDOP] [nvarchar](50) NULL,
	[Temperature Sensor(deg )] [nvarchar](50) NULL,
	[Activity Sensor] [nvarchar](50) NULL,
	[Satellite Data] [nvarchar](150) NULL
) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SqlServerExtensions].[SqlServerExtensions.AnimalMovementFunctions].[ParseFormatA]
GO
CREATE FUNCTION [dbo].[UtcTime](@localDateTime [datetime])
RETURNS [datetime] WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [SqlServerExtensions].[SqlServerExtensions.AnimalMovementFunctions].[UtcTime]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Test_Function_DoDateRangesOverlap] 

AS
BEGIN
	SET NOCOUNT ON
	
	PRINT 'Test_Function_DoDateRangesOverlap'
	
	DECLARE @StartDate1 DATETIME2
	DECLARE @StartDate2 DATETIME2
	DECLARE @EndDate1 DATETIME2
	DECLARE @EndDate2 DATETIME2
	DECLARE @OVERLAP NVARCHAR(32)
	DECLARE @RESULT NVARCHAR(32)
	
	-- NULL to DATE
	
	SET @StartDate1 = NULL
	SET @EndDate1 = '2000-01-01'
	SET @StartDate2 = NULL
	SET @EndDate2 = '2001-01-01'
	IF dbo.DoDateRangesOverlap(@StartDate1,@EndDate1,@StartDate2,@EndDate2) = 1
		SET @OVERLAP = 'Overlaps' ELSE SET @OVERLAP = 'Is disjointed'
	IF @OVERLAP = 'Overlaps'
		SET @RESULT = 'Pass' ELSE SET @RESULT = 'Fail'
	print '  1  (' + ISNULL(CONVERT(NVARCHAR(32),Year(@StartDate1)),'NULL') +',' + ISNULL(CONVERT(NVARCHAR(32),Year(@EndDate1)),'NULL') + ') TO (' + ISNULL(CONVERT(NVARCHAR(32),Year(@StartDate2)),'NULL') +',' + ISNULL(CONVERT(NVARCHAR(32),Year(@EndDate2)),'NULL') + ') '+ @OVERLAP + '.  ' + @RESULT
	
	
	
	SET @StartDate1 = NULL
	SET @EndDate1 = '2000-01-01'
	SET @StartDate2 = '2001-01-01'
	SET @EndDate2 = '2002-01-01'
	IF dbo.DoDateRangesOverlap(@StartDate1,@EndDate1,@StartDate2,@EndDate2) = 1
		SET @OVERLAP = 'Overlaps' ELSE SET @OVERLAP = 'Is disjointed'
	IF @OVERLAP <> 'Overlaps'
		SET @RESULT = 'Pass' ELSE SET @RESULT = 'Fail'
	print '  2a (' + ISNULL(CONVERT(NVARCHAR(32),Year(@StartDate1)),'NULL') +',' + ISNULL(CONVERT(NVARCHAR(32),Year(@EndDate1)),'NULL') + ') TO (' + ISNULL(CONVERT(NVARCHAR(32),Year(@StartDate2)),'NULL') +',' + ISNULL(CONVERT(NVARCHAR(32),Year(@EndDate2)),'NULL') + ') '+ @OVERLAP + '.  ' + @RESULT
	
	SET @StartDate1 = NULL
	SET @EndDate1 = '2001-01-01'
	SET @StartDate2 = '2000-01-01'
	SET @EndDate2 = '2002-01-01'
	IF dbo.DoDateRangesOverlap(@StartDate1,@EndDate1,@StartDate2,@EndDate2) = 1
		SET @OVERLAP = 'Overlaps' ELSE SET @OVERLAP = 'Is disjointed'
	IF @OVERLAP = 'Overlaps'
		SET @RESULT = 'Pass' ELSE SET @RESULT = 'Fail'
	print '  2b (' + ISNULL(CONVERT(NVARCHAR(32),Year(@StartDate1)),'NULL') +',' + ISNULL(CONVERT(NVARCHAR(32),Year(@EndDate1)),'NULL') + ') TO (' + ISNULL(CONVERT(NVARCHAR(32),Year(@StartDate2)),'NULL') +',' + ISNULL(CONVERT(NVARCHAR(32),Year(@EndDate2)),'NULL') + ') '+ @OVERLAP + '.  ' + @RESULT
	
	
	
	SET @StartDate1 = NULL
	SET @EndDate1 = '2000-01-01'
	SET @StartDate2 = '2001-01-01'
	SET @EndDate2 = NULL
	IF dbo.DoDateRangesOverlap(@StartDate1,@EndDate1,@StartDate2,@EndDate2) = 1
		SET @OVERLAP = 'Overlaps' ELSE SET @OVERLAP = 'Is disjointed'
	IF @OVERLAP <> 'Overlaps'
		SET @RESULT = 'Pass' ELSE SET @RESULT = 'Fail'
	print '  3a (' + ISNULL(CONVERT(NVARCHAR(32),Year(@StartDate1)),'NULL') +',' + ISNULL(CONVERT(NVARCHAR(32),Year(@EndDate1)),'NULL') + ') TO (' + ISNULL(CONVERT(NVARCHAR(32),Year(@StartDate2)),'NULL') +',' + ISNULL(CONVERT(NVARCHAR(32),Year(@EndDate2)),'NULL') + ') '+ @OVERLAP + '.  ' + @RESULT
	
	SET @StartDate1 = NULL
	SET @EndDate1 = '2001-01-01'
	SET @StartDate2 = '2000-01-01'
	SET @EndDate2 = NULL
	IF dbo.DoDateRangesOverlap(@StartDate1,@EndDate1,@StartDate2,@EndDate2) = 1
		SET @OVERLAP = 'Overlaps' ELSE SET @OVERLAP = 'Is disjointed'
	IF @OVERLAP = 'Overlaps'
		SET @RESULT = 'Pass' ELSE SET @RESULT = 'Fail'
	print '  3b (' + ISNULL(CONVERT(NVARCHAR(32),Year(@StartDate1)),'NULL') +',' + ISNULL(CONVERT(NVARCHAR(32),Year(@EndDate1)),'NULL') + ') TO (' + ISNULL(CONVERT(NVARCHAR(32),Year(@StartDate2)),'NULL') +',' + ISNULL(CONVERT(NVARCHAR(32),Year(@EndDate2)),'NULL') + ') '+ @OVERLAP + '.  ' + @RESULT
	
	
	-- DATE to DATE
	
	SET @StartDate1 = '2000-01-01'
	SET @EndDate1 =  '2002-01-01'
	SET @StartDate2 = NULL
	SET @EndDate2 = '2001-01-01'
	IF dbo.DoDateRangesOverlap(@StartDate1,@EndDate1,@StartDate2,@EndDate2) = 1
		SET @OVERLAP = 'Overlaps' ELSE SET @OVERLAP = 'Is disjointed'
	IF @OVERLAP = 'Overlaps'
		SET @RESULT = 'Pass' ELSE SET @RESULT = 'Fail'
	print '  4a (' + ISNULL(CONVERT(NVARCHAR(32),Year(@StartDate1)),'NULL') +',' + ISNULL(CONVERT(NVARCHAR(32),Year(@EndDate1)),'NULL') + ') TO (' + ISNULL(CONVERT(NVARCHAR(32),Year(@StartDate2)),'NULL') +',' + ISNULL(CONVERT(NVARCHAR(32),Year(@EndDate2)),'NULL') + ') '+ @OVERLAP + '.  ' + @RESULT
	
	SET @StartDate1 = '2001-01-01'
	SET @EndDate1 =  '2002-01-01'
	SET @StartDate2 = NULL
	SET @EndDate2 = '2000-01-01'
	IF dbo.DoDateRangesOverlap(@StartDate1,@EndDate1,@StartDate2,@EndDate2) = 1
		SET @OVERLAP = 'Overlaps' ELSE SET @OVERLAP = 'Is disjointed'
	IF @OVERLAP <> 'Overlaps'
		SET @RESULT = 'Pass' ELSE SET @RESULT = 'Fail'
	print '  4b (' + ISNULL(CONVERT(NVARCHAR(32),Year(@StartDate1)),'NULL') +',' + ISNULL(CONVERT(NVARCHAR(32),Year(@EndDate1)),'NULL') + ') TO (' + ISNULL(CONVERT(NVARCHAR(32),Year(@StartDate2)),'NULL') +',' + ISNULL(CONVERT(NVARCHAR(32),Year(@EndDate2)),'NULL') + ') '+ @OVERLAP + '.  ' + @RESULT
	
	
	
	SET @StartDate1 = '2001-01-01'
	SET @EndDate1 =  '2003-01-01'
	SET @StartDate2 = '2000-01-01'
	SET @EndDate2 = '2002-01-01'
	IF dbo.DoDateRangesOverlap(@StartDate1,@EndDate1,@StartDate2,@EndDate2) = 1
		SET @OVERLAP = 'Overlaps' ELSE SET @OVERLAP = 'Is disjointed'
	IF @OVERLAP = 'Overlaps'
		SET @RESULT = 'Pass' ELSE SET @RESULT = 'Fail'
	print '  5a (' + ISNULL(CONVERT(NVARCHAR(32),Year(@StartDate1)),'NULL') +',' + ISNULL(CONVERT(NVARCHAR(32),Year(@EndDate1)),'NULL') + ') TO (' + ISNULL(CONVERT(NVARCHAR(32),Year(@StartDate2)),'NULL') +',' + ISNULL(CONVERT(NVARCHAR(32),Year(@EndDate2)),'NULL') + ') '+ @OVERLAP + '.  ' + @RESULT
	
	SET @StartDate1 = '2002-01-01'
	SET @EndDate1 =  '2003-01-01'
	SET @StartDate2 = '2000-01-01'
	SET @EndDate2 = '2001-01-01'
	IF dbo.DoDateRangesOverlap(@StartDate1,@EndDate1,@StartDate2,@EndDate2) = 1
		SET @OVERLAP = 'Overlaps' ELSE SET @OVERLAP = 'Is disjointed'
	IF @OVERLAP <> 'Overlaps'
		SET @RESULT = 'Pass' ELSE SET @RESULT = 'Fail'
	print '  5b (' + ISNULL(CONVERT(NVARCHAR(32),Year(@StartDate1)),'NULL') +',' + ISNULL(CONVERT(NVARCHAR(32),Year(@EndDate1)),'NULL') + ') TO (' + ISNULL(CONVERT(NVARCHAR(32),Year(@StartDate2)),'NULL') +',' + ISNULL(CONVERT(NVARCHAR(32),Year(@EndDate2)),'NULL') + ') '+ @OVERLAP + '.  ' + @RESULT
	
	SET @StartDate1 = '2000-01-01'
	SET @EndDate1 =  '2004-01-01'
	SET @StartDate2 = '2001-01-01'
	SET @EndDate2 = '2003-01-01'
	IF dbo.DoDateRangesOverlap(@StartDate1,@EndDate1,@StartDate2,@EndDate2) = 1
		SET @OVERLAP = 'Overlaps' ELSE SET @OVERLAP = 'Is disjointed'
	IF @OVERLAP = 'Overlaps'
		SET @RESULT = 'Pass' ELSE SET @RESULT = 'Fail'
	print '  5c (' + ISNULL(CONVERT(NVARCHAR(32),Year(@StartDate1)),'NULL') +',' + ISNULL(CONVERT(NVARCHAR(32),Year(@EndDate1)),'NULL') + ') TO (' + ISNULL(CONVERT(NVARCHAR(32),Year(@StartDate2)),'NULL') +',' + ISNULL(CONVERT(NVARCHAR(32),Year(@EndDate2)),'NULL') + ') '+ @OVERLAP + '.  ' + @RESULT
	
	SET @StartDate1 = '2000-01-01'
	SET @EndDate1 =  '2002-01-01'
	SET @StartDate2 = '2001-01-01'
	SET @EndDate2 = '2003-01-01'
	IF dbo.DoDateRangesOverlap(@StartDate1,@EndDate1,@StartDate2,@EndDate2) = 1
		SET @OVERLAP = 'Overlaps' ELSE SET @OVERLAP = 'Is disjointed'
	IF @OVERLAP = 'Overlaps'
		SET @RESULT = 'Pass' ELSE SET @RESULT = 'Fail'
	print '  5d (' + ISNULL(CONVERT(NVARCHAR(32),Year(@StartDate1)),'NULL') +',' + ISNULL(CONVERT(NVARCHAR(32),Year(@EndDate1)),'NULL') + ') TO (' + ISNULL(CONVERT(NVARCHAR(32),Year(@StartDate2)),'NULL') +',' + ISNULL(CONVERT(NVARCHAR(32),Year(@EndDate2)),'NULL') + ') '+ @OVERLAP + '.  ' + @RESULT
	
	SET @StartDate1 = '2000-01-01'
	SET @EndDate1 =  '2001-01-01'
	SET @StartDate2 = '2002-01-01'
	SET @EndDate2 = '2003-01-01'
	IF dbo.DoDateRangesOverlap(@StartDate1,@EndDate1,@StartDate2,@EndDate2) = 1
		SET @OVERLAP = 'Overlaps' ELSE SET @OVERLAP = 'Is disjointed'
	IF @OVERLAP <> 'Overlaps'
		SET @RESULT = 'Pass' ELSE SET @RESULT = 'Fail'
	print '  5e (' + ISNULL(CONVERT(NVARCHAR(32),Year(@StartDate1)),'NULL') +',' + ISNULL(CONVERT(NVARCHAR(32),Year(@EndDate1)),'NULL') + ') TO (' + ISNULL(CONVERT(NVARCHAR(32),Year(@StartDate2)),'NULL') +',' + ISNULL(CONVERT(NVARCHAR(32),Year(@EndDate2)),'NULL') + ') '+ @OVERLAP + '.  ' + @RESULT
	
	
	
	SET @StartDate1 = '2000-01-01'
	SET @EndDate1 =  '2001-01-01'
	SET @StartDate2 = '2002-01-01'
	SET @EndDate2 = NULL
	IF dbo.DoDateRangesOverlap(@StartDate1,@EndDate1,@StartDate2,@EndDate2) = 1
		SET @OVERLAP = 'Overlaps' ELSE SET @OVERLAP = 'Is disjointed'
	IF @OVERLAP <> 'Overlaps'
		SET @RESULT = 'Pass' ELSE SET @RESULT = 'Fail'
	print '  6a (' + ISNULL(CONVERT(NVARCHAR(32),Year(@StartDate1)),'NULL') +',' + ISNULL(CONVERT(NVARCHAR(32),Year(@EndDate1)),'NULL') + ') TO (' + ISNULL(CONVERT(NVARCHAR(32),Year(@StartDate2)),'NULL') +',' + ISNULL(CONVERT(NVARCHAR(32),Year(@EndDate2)),'NULL') + ') '+ @OVERLAP + '.  ' + @RESULT

	SET @StartDate1 = '2000-01-01'
	SET @EndDate1 =  '2002-01-01'
	SET @StartDate2 = '2001-01-01'
	SET @EndDate2 = NULL
	IF dbo.DoDateRangesOverlap(@StartDate1,@EndDate1,@StartDate2,@EndDate2) = 1
		SET @OVERLAP = 'Overlaps' ELSE SET @OVERLAP = 'Is disjointed'
	IF @OVERLAP = 'Overlaps'
		SET @RESULT = 'Pass' ELSE SET @RESULT = 'Fail'
	print '  6b (' + ISNULL(CONVERT(NVARCHAR(32),Year(@StartDate1)),'NULL') +',' + ISNULL(CONVERT(NVARCHAR(32),Year(@EndDate1)),'NULL') + ') TO (' + ISNULL(CONVERT(NVARCHAR(32),Year(@StartDate2)),'NULL') +',' + ISNULL(CONVERT(NVARCHAR(32),Year(@EndDate2)),'NULL') + ') '+ @OVERLAP + '.  ' + @RESULT


	-- NULL to DATE

	SET @StartDate1 = '2002-01-01'
	SET @EndDate1 =  NULL
	SET @StartDate2 = NULL
	SET @EndDate2 = '2001-01-01'
	IF dbo.DoDateRangesOverlap(@StartDate1,@EndDate1,@StartDate2,@EndDate2) = 1
		SET @OVERLAP = 'Overlaps' ELSE SET @OVERLAP = 'Is disjointed'
	IF @OVERLAP <> 'Overlaps'
		SET @RESULT = 'Pass' ELSE SET @RESULT = 'Fail'
	print '  7a (' + ISNULL(CONVERT(NVARCHAR(32),Year(@StartDate1)),'NULL') +',' + ISNULL(CONVERT(NVARCHAR(32),Year(@EndDate1)),'NULL') + ') TO (' + ISNULL(CONVERT(NVARCHAR(32),Year(@StartDate2)),'NULL') +',' + ISNULL(CONVERT(NVARCHAR(32),Year(@EndDate2)),'NULL') + ') '+ @OVERLAP + '.  ' + @RESULT
	
	SET @StartDate1 = '2000-01-01'
	SET @EndDate1 =  NULL
	SET @StartDate2 = NULL
	SET @EndDate2 = '2002-01-01'
	IF dbo.DoDateRangesOverlap(@StartDate1,@EndDate1,@StartDate2,@EndDate2) = 1
		SET @OVERLAP = 'Overlaps' ELSE SET @OVERLAP = 'Is disjointed'
	IF @OVERLAP = 'Overlaps'
		SET @RESULT = 'Pass' ELSE SET @RESULT = 'Fail'
	print '  7b (' + ISNULL(CONVERT(NVARCHAR(32),Year(@StartDate1)),'NULL') +',' + ISNULL(CONVERT(NVARCHAR(32),Year(@EndDate1)),'NULL') + ') TO (' + ISNULL(CONVERT(NVARCHAR(32),Year(@StartDate2)),'NULL') +',' + ISNULL(CONVERT(NVARCHAR(32),Year(@EndDate2)),'NULL') + ') '+ @OVERLAP + '.  ' + @RESULT
	
	
	
	SET @StartDate1 = '2001-01-01'
	SET @EndDate1 =  NULL
	SET @StartDate2 = '2000-01-01'
	SET @EndDate2 = '2002-01-01'
	IF dbo.DoDateRangesOverlap(@StartDate1,@EndDate1,@StartDate2,@EndDate2) = 1
		SET @OVERLAP = 'Overlaps' ELSE SET @OVERLAP = 'Is disjointed'
	IF @OVERLAP = 'Overlaps'
		SET @RESULT = 'Pass' ELSE SET @RESULT = 'Fail'
	print '  8a (' + ISNULL(CONVERT(NVARCHAR(32),Year(@StartDate1)),'NULL') +',' + ISNULL(CONVERT(NVARCHAR(32),Year(@EndDate1)),'NULL') + ') TO (' + ISNULL(CONVERT(NVARCHAR(32),Year(@StartDate2)),'NULL') +',' + ISNULL(CONVERT(NVARCHAR(32),Year(@EndDate2)),'NULL') + ') '+ @OVERLAP + '.  ' + @RESULT
	
	SET @StartDate1 = '2002-01-01'
	SET @EndDate1 =  NULL
	SET @StartDate2 = '2000-01-01'
	SET @EndDate2 = '2001-01-01'
	IF dbo.DoDateRangesOverlap(@StartDate1,@EndDate1,@StartDate2,@EndDate2) = 1
		SET @OVERLAP = 'Overlaps' ELSE SET @OVERLAP = 'Is disjointed'
	IF @OVERLAP <> 'Overlaps'
		SET @RESULT = 'Pass' ELSE SET @RESULT = 'Fail'
	print '  8b (' + ISNULL(CONVERT(NVARCHAR(32),Year(@StartDate1)),'NULL') +',' + ISNULL(CONVERT(NVARCHAR(32),Year(@EndDate1)),'NULL') + ') TO (' + ISNULL(CONVERT(NVARCHAR(32),Year(@StartDate2)),'NULL') +',' + ISNULL(CONVERT(NVARCHAR(32),Year(@EndDate2)),'NULL') + ') '+ @OVERLAP + '.  ' + @RESULT
	
	
	
	SET @StartDate1 = '2001-01-01'
	SET @EndDate1 =  NULL
	SET @StartDate2 = '2000-01-01'
	SET @EndDate2 = NULL
	IF dbo.DoDateRangesOverlap(@StartDate1,@EndDate1,@StartDate2,@EndDate2) = 1
		SET @OVERLAP = 'Overlaps' ELSE SET @OVERLAP = 'Is disjointed'
	IF @OVERLAP = 'Overlaps'
		SET @RESULT = 'Pass' ELSE SET @RESULT = 'Fail'
	print '  9  (' + ISNULL(CONVERT(NVARCHAR(32),Year(@StartDate1)),'NULL') +',' + ISNULL(CONVERT(NVARCHAR(32),Year(@EndDate1)),'NULL') + ') TO (' + ISNULL(CONVERT(NVARCHAR(32),Year(@StartDate2)),'NULL') +',' + ISNULL(CONVERT(NVARCHAR(32),Year(@EndDate2)),'NULL') + ') '+ @OVERLAP + '.  ' + @RESULT
	
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: April 11, 2012
-- Description:	Updates a project investigator
-- =============================================
CREATE PROCEDURE [dbo].[ProjectInvestigator_Update] 
	@Login sysname       = NULL,
	@Name  NVARCHAR(255) = NULL, 
	@Email NVARCHAR(255) = NULL, 
	@Phone NVARCHAR(255) = NULL 
AS
BEGIN
	SET NOCOUNT ON;
	
	IF @Login IS NULL
		SET @Login = ORIGINAL_LOGIN();

	-- Verify this is an existing project investigator
	IF NOT EXISTS (SELECT 1 FROM [dbo].[ProjectInvestigators] WHERE [Login] = @Login)
	BEGIN
		DECLARE @message1 nvarchar(100) = 'There is no project investigator with a login of ' + @Login + '.';
		RAISERROR(@message1, 18, 0)
		RETURN 1
	END
	
	-- You must be the ProjectInvestigator to update the ProjectInvestigator
	IF @Login <> ORIGINAL_LOGIN()
	BEGIN
		DECLARE @message2 nvarchar(100) = 'You can only update your own record.';
		RAISERROR(@message2, 18, 0)
		RETURN 1
	END
	
	-- If a parameter is not provided, use the existing value.
	-- (to put null in a field the user will need to pass an empty string)
	IF @Name IS NULL
	BEGIN
		SELECT @Name = [Name] FROM [dbo].[ProjectInvestigators] WHERE [Login] = @Login;
	END
	
	IF @Email IS NULL
	BEGIN
		SELECT @Email = [Email] FROM [dbo].[ProjectInvestigators] WHERE [Login] = @Login;
	END
	
	IF @Phone IS NULL
	BEGIN
		SELECT @Phone = [Phone] FROM [dbo].[ProjectInvestigators] WHERE [Login] = @Login;
	END
	
	-- Do the update, replacing empty strings with NULLs
	UPDATE [dbo].[ProjectInvestigators] SET [Name]	= nullif(@Name,''),
											[Email] = nullif(@Email,''),
											[Phone] = nullif(@Phone,'')
									  WHERE [Login] = @Login

END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[ProjectInvestigator_Insert_SA]
	@Login sysname, 
	@Name  NVARCHAR(255), 
	@Email NVARCHAR(255),
	@Phone NVARCHAR(255)
AS
BEGIN
	SET NOCOUNT ON

	-- This can only be run be the Sysadmin
	-- This script is mostly to remind the SA of the steps, so there is no error checking.

	-- create a login
	IF NOT EXISTS (select 1 from sys.server_principals where name = @Login)
	BEGIN
		EXEC ('CREATE LOGIN [' + @Login + '] FROM WINDOWS')
	END

	-- create a db user
	IF NOT EXISTS (select 1 from sys.database_principals WHERE type = 'U' AND name = @Login)
	BEGIN
		EXEC ('CREATE USER ['  + @Login + ']') --  LOGIN defaults to the same name
	END

	-- Add the user to the Investigator role
	IF NOT EXISTS (SELECT 1 from sys.database_role_members as U 
				   INNER JOIN sys.database_principals AS P1  
				   ON U.member_principal_id = P1.principal_id
				   INNER JOIN sys.database_principals AS P2 
				   ON U.role_principal_id = p2.principal_id 
				   WHERE p1.name = @Login AND p2.name = 'Investigator' )
	BEGIN
		EXEC sp_addrolemember 'Investigator', @Login
	END

	-- Add the user to the Investigator table
	INSERT INTO dbo.ProjectInvestigators ([Login],[Name],[Email],[Phone])
		 VALUES (@Login, @Name, @Email, @Phone);
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: March 20, 2012
-- Description:	Updates the settings table
-- =============================================
CREATE PROCEDURE [dbo].[Settings_Update] 
	@Key   nvarchar(30)  = Null,
	@Value nvarchar(500) = Null
AS
BEGIN
	SET NOCOUNT ON;

	-- Get the name of the caller
	DECLARE @Caller sysname = ORIGINAL_LOGIN();
	
	IF @Key = 'project' AND NOT EXISTS (SELECT 1 FROM [dbo].[Projects] WHERE ProjectId = @Value)
	BEGIN
		DECLARE @message1 nvarchar(100) = 'Project (' + @Value + ') is not an existing project';
		RAISERROR(@message1, 18, 0)
		RETURN 1
	END
	IF @Key in ('project', 'collar_manufacturer', 'filter_projects', 'species', 'file_format', 'collar_model', 'parameter_file_format', 'othervalidkeys...') --Add valid keys to this list
	BEGIN
		BEGIN TRY
			BEGIN TRAN
				DELETE dbo.Settings WHERE [Username] = @Caller AND [Key] = @Key 
				INSERT dbo.Settings ([Username], [Key], [Value]) VALUES (@Caller, @Key, @Value) 
			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			IF XACT_STATE() <> 0
				ROLLBACK TRANSACTION;
			EXEC [dbo].[Utility_RethrowError]
			RETURN 1
		END CATCH
	END
	ELSE
	BEGIN
		DECLARE @message2 nvarchar(100) = 'Invalid key (' + @Key + ') for settings';
		RAISERROR(@message2, 18, 0)
		RETURN 1
	END
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: March 28, 2012
-- Description:	Adds a new project to the database.
-- =============================================
CREATE PROCEDURE [dbo].[Project_Insert] 
	@ProjectId NVARCHAR(255)= NULL,
	@ProjectName NVARCHAR(255) = NULL, 
	@ProjectInvestigator sysname = NULL, 
	@UnitCode NVARCHAR(255) = NULL, 
	@Description NVARCHAR(4000) = NULL 
AS
BEGIN
	SET NOCOUNT ON;

	-- Get the name of the caller
	DECLARE @Caller sysname = ORIGINAL_LOGIN();
		
	--default PI is the calling user
	IF nullif(@ProjectInvestigator,'') IS NULL
	BEGIN
		SET @ProjectInvestigator = @Caller;
	END

	-- If the caller is not a PI then error and return
	IF NOT EXISTS (SELECT 1 FROM [dbo].[ProjectInvestigators] WHERE [Login] = @Caller)
	BEGIN
		DECLARE @message1 nvarchar(100) = 'You ('+@Caller+') must be a principal investigator to create a project';
		RAISERROR(@message1, 18, 0)
		RETURN 1
	END

	INSERT INTO dbo.Projects ([ProjectId], [ProjectName], [ProjectInvestigator], [UnitCode], [Description])
		 VALUES (nullif(@ProjectId,''), nullif(@ProjectName,''), nullif(@ProjectInvestigator,''),
		         nullif(@UnitCode,''), nullif(@Description,''))

END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProjectEditors](
	[ProjectId] [varchar](16) NOT NULL,
	[Editor] [sysname] NOT NULL,
 CONSTRAINT [PK_ProjectEditors] PRIMARY KEY CLUSTERED 
(
	[ProjectId] ASC,
	[Editor] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: March 2, 2012
-- Description:	Updates the Status of a Location
-- =============================================
CREATE PROCEDURE [dbo].[Location_UpdateStatus] 
	@ProjectId NVARCHAR(255) = NULL, 
	@AnimalId  NVARCHAR(255) = NULL, 
	@FixDate   DATETIME2     = NULL,
	@Status    CHAR          = NULL
AS
BEGIN
	SET NOCOUNT ON;

	-- Get the name of the caller
	DECLARE @Caller sysname = ORIGINAL_LOGIN();

	-- Validate permission for this operation
	-- The caller must be the PI or editor on the project
	IF NOT EXISTS (SELECT 1 FROM dbo.Projects WHERE ProjectId = @ProjectId AND ProjectInvestigator = @Caller)
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM dbo.ProjectEditors WHERE ProjectId = @ProjectId AND Editor = @Caller)
		BEGIN
			DECLARE @message1 nvarchar(200) = 'You ('+@Caller+') must be the principal investigator or editor on this project ('+@ProjectId+') to update this location.';
			RAISERROR(@message1, 18, 0)
			RETURN (1)
		END
	END
	
	UPDATE [Locations]
	   SET [Status] = @Status
	 WHERE [ProjectId] = @ProjectId
	   AND [AnimalId] = @AnimalId
	   AND [FixDate] = @FixDate;
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: April 2, 2012
-- Description:	Adds a new Collar Deployment.
-- =============================================
CREATE PROCEDURE [dbo].[CollarDeployment_UpdateRetrievalDate] 
	@ProjectId			NVARCHAR(255) = NULL,
	@AnimalId			NVARCHAR(255) = NULL, 
	@CollarManufacturer NVARCHAR(255) = NULL,
	@CollarId			NVARCHAR(255) = NULL, 
	@DeploymentDate		DATETIME2 = NULL, 
	@RetrievalDate		DATETIME2 = NULL
AS
BEGIN
	SET NOCOUNT ON;

	-- Get the name of the caller
	DECLARE @Caller sysname = ORIGINAL_LOGIN();

	-- Validate permission for this operation
	-- The caller must be the PI or editor on the project
	IF NOT EXISTS (SELECT 1 FROM dbo.Projects WHERE ProjectId = @ProjectId AND ProjectInvestigator = @Caller)
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM dbo.ProjectEditors WHERE ProjectId = @ProjectId AND Editor = @Caller)
		BEGIN
			DECLARE @message1 nvarchar(200) = 'You ('+@Caller+') must be the principal investigator or editor on this project ('+@ProjectId+') to deploy a collar on the project.';
			RAISERROR(@message1, 18, 0)
			RETURN (1)
		END
	END

	-- Verify that the deployment exists (this is done now to avoid a confusing silent No-op)
	IF NOT EXISTS (SELECT 1 FROM dbo.CollarDeployments
				   WHERE CollarManufacturer = @CollarManufacturer AND CollarId = @CollarId
				     AND ProjectId = @ProjectId AND AnimalId = @AnimalId
				     AND DeploymentDate = @DeploymentDate
			      )
	BEGIN
		RAISERROR('The deployment you want to change was not found.', 18, 0)
		RETURN (1)
	END

	-- Verify the retrieval occurs after the deployment
	IF @RetrievalDate IS NOT NULL AND @RetrievalDate <= @DeploymentDate
	BEGIN
		RAISERROR('The retrieval must occur after the deployment.', 18, 0)
		RETURN (1)
	END

	-- Get the old retrieval date
	DECLARE @OldRetrievalDate DATETIME2 = NULL
	SELECT @OldRetrievalDate = RetrievalDate FROM dbo.CollarDeployments
			   WHERE CollarManufacturer = @CollarManufacturer AND CollarId = @CollarId
			     AND ProjectId = @ProjectId AND AnimalId = @AnimalId
			     AND DeploymentDate = @DeploymentDate;
			     
			

	IF @OldRetrievalDate = @RetrievalDate	
		Return(0) -- Nothing needs to be done.
	
	if @RetrievalDate IS NULL OR (@OldRetrievalDate IS NOT NULL AND @OldRetrievalDate < @RetrievalDate)
	BEGIN
		-- We are expanding the duration of this deployment which may cause a conflict
		
		-- Verify that the animal is not wearing another collar during the proposed date range
		IF EXISTS (SELECT 1 FROM dbo.CollarDeployments
					WHERE ProjectId = @ProjectId AND AnimalId = @AnimalId
					  AND DeploymentDate <> @DeploymentDate  -- make sure we ignore the deployment being changed
					  AND dbo.DoDateRangesOverlap(DeploymentDate, RetrievalDate, @DeploymentDate, @RetrievalDate) = 1
				  )
		BEGIN
			DECLARE @message3 nvarchar(200) = 'The new retreival date conflicts with another deployment for animal ('+@ProjectId+'-'+@AnimalId+').'
			RAISERROR(@message3, 18, 0)
			RETURN (1)
		END
	
		-- Verify that the collar is not on another animal during the proposed date range
		IF EXISTS (SELECT 1 FROM dbo.CollarDeployments
					WHERE CollarManufacturer = @CollarManufacturer AND CollarId = @CollarId
					  AND DeploymentDate <> @DeploymentDate  -- make sure we ignore the deployment being changed
					  AND dbo.DoDateRangesOverlap(DeploymentDate, RetrievalDate, @DeploymentDate, @RetrievalDate) = 1
				  )
		BEGIN
			DECLARE @message4 nvarchar(200) = 'The new retreival date conflicts with another deployment for collar ('+@CollarManufacturer+'-'+@CollarId+').'
			RAISERROR(@message4, 18, 0)
			RETURN (1)
		END
	END
	
	-- All other verification is handled by primary/foreign key and column constraints.
	UPDATE dbo.CollarDeployments SET RetrievalDate = @RetrievalDate
			   WHERE CollarManufacturer = @CollarManufacturer AND CollarId = @CollarId
			     AND ProjectId = @ProjectId AND AnimalId = @AnimalId
			     AND DeploymentDate = @DeploymentDate;
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: April 2, 2012
-- Description:	Adds a new Collar Deployment.
-- =============================================
CREATE PROCEDURE [dbo].[CollarDeployment_Insert] 
	@ProjectId			NVARCHAR(255) = NULL,
	@AnimalId			NVARCHAR(255) = NULL, 
	@CollarManufacturer NVARCHAR(255) = NULL,
	@CollarId			NVARCHAR(255) = NULL, 
	@DeploymentDate		DATETIME2 = NULL, 
	@RetrievalDate		DATETIME2 = NULL
AS
BEGIN
	SET NOCOUNT ON;

	-- Get the name of the caller
	DECLARE @Caller sysname = ORIGINAL_LOGIN();

	-- Validate permission for this operation
	-- The caller must be the PI or editor on the project
	IF NOT EXISTS (SELECT 1 FROM dbo.Projects WHERE ProjectId = @ProjectId AND ProjectInvestigator = @Caller)
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM dbo.ProjectEditors WHERE ProjectId = @ProjectId AND Editor = @Caller)
		BEGIN
			DECLARE @message1 nvarchar(200) = 'You ('+@Caller+') must be the principal investigator or editor on this project ('+@ProjectId+') to deploy a collar on the project.';
			RAISERROR(@message1, 18, 0)
			RETURN (1)
		END
	END

	-- And, the collar must belong to the PI of the project
	DECLARE @ProjectInvestigator sysname
	SELECT @ProjectInvestigator = ProjectInvestigator FROM dbo.Projects WHERE ProjectId  = @ProjectId;
	DECLARE @Manager sysname
	SELECT @Manager = Manager FROM dbo.Collars WHERE CollarManufacturer = @CollarManufacturer AND CollarId = @CollarId;
	
	IF @Manager <> @ProjectInvestigator
	BEGIN
		DECLARE @message2 nvarchar(200) = 'The collar ('+@CollarManufacturer+'/'+@CollarId+') does not belong to the PI ('+@ProjectInvestigator+') of the project ('+@ProjectId+').';
		RAISERROR(@message2, 18, 0)
		RETURN (1)
	END
	
	-- Verify the retrieval occurs after the deployment
	IF @RetrievalDate IS NOT NULL AND @RetrievalDate <= @DeploymentDate
	BEGIN
		RAISERROR('The retrieval must occur after the deployment.', 18, 0)
		RETURN (1)
	END

	-- Verify that the animal is not wearing another collar during the proposed date range
	IF EXISTS (SELECT 1 FROM dbo.CollarDeployments
				WHERE ProjectId = @ProjectId AND AnimalId = @AnimalId
				  AND dbo.DoDateRangesOverlap(DeploymentDate, RetrievalDate, @DeploymentDate, @RetrievalDate) = 1
			  )
	BEGIN
		DECLARE @message3 nvarchar(200) = 'The animal ('+@ProjectId+'-'+@AnimalId+') is already wearing a collar during your date range.'
		RAISERROR(@message3, 18, 0)
		RETURN (1)
	END
	
	-- Verify that the collar is not on another animal during the proposed date range
	IF EXISTS (SELECT 1 FROM dbo.CollarDeployments
				WHERE CollarManufacturer = @CollarManufacturer AND CollarId = @CollarId
				  AND dbo.DoDateRangesOverlap(DeploymentDate, RetrievalDate, @DeploymentDate, @RetrievalDate) = 1
			  )
	BEGIN
		DECLARE @message4 nvarchar(200) = 'The collar ('+@CollarManufacturer+'-'+@CollarId+') is already deployed during your date range.'
		RAISERROR(@message4, 18, 0)
		RETURN (1)
	END
	

	-- All other verification is handled by primary/foreign key and column constraints.
	INSERT INTO dbo.CollarDeployments
	            ([ProjectId], [AnimalId], [CollarManufacturer], [CollarId],  
	             [DeploymentDate], [RetrievalDate])
		 VALUES (nullif(@ProjectId,''), nullif(@AnimalId,''), nullif(@CollarManufacturer,''), 
				 nullif(@CollarId,''), nullif(@DeploymentDate,''), nullif(@RetrievalDate,''))
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: April 2, 2012
-- Description:	Delete a Collar Deployment.
-- =============================================
CREATE PROCEDURE [dbo].[CollarDeployment_Delete] 
	@ProjectId			NVARCHAR(255) = NULL,
	@AnimalId			NVARCHAR(255) = NULL, 
	@CollarManufacturer NVARCHAR(255) = NULL,
	@CollarId			NVARCHAR(255) = NULL, 
	@DeploymentDate		DATETIME2 = NULL 
AS
BEGIN
	SET NOCOUNT ON;

	-- Get the name of the caller
	DECLARE @Caller sysname = ORIGINAL_LOGIN();

	-- Validate permission for this operation
	-- The caller must be the PI or editor on the project
	IF NOT EXISTS (SELECT 1 FROM dbo.Projects WHERE ProjectId = @ProjectId AND ProjectInvestigator = @Caller)
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM dbo.ProjectEditors WHERE ProjectId = @ProjectId AND Editor = @Caller)
		BEGIN
			DECLARE @message1 nvarchar(200) = 'You ('+@Caller+') must be the principal investigator or editor on this project ('+@ProjectId+') to delete this collar.';
			RAISERROR(@message1, 18, 0)
			RETURN (1)
		END
	END


	-- deleting a non-existing deployment will silently succeed.
	--All other verification is handled by primary/foreign key and column constraints.
	DELETE FROM dbo.CollarDeployments
		  WHERE [ProjectId] = @ProjectId
		    AND [AnimalId] = @AnimalId
		    AND [CollarManufacturer] = @CollarManufacturer
		    AND [CollarId] = @CollarId
		    AND [DeploymentDate] = @DeploymentDate
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: March 28, 2012
-- Description:	Updates an Animal
-- =============================================
CREATE PROCEDURE [dbo].[Animal_Update] 
	@ProjectId NVARCHAR(255)= NULL,
	@AnimalId NVARCHAR(255) = NULL, 
	@Species NVARCHAR(255) = NULL, 
	@Gender NVARCHAR(7) = NULL, 
	@MortalityDate DATETIME2(7),
	@GroupName NVARCHAR(255) = NULL, 
	@Description NVARCHAR(4000) = NULL 
AS
BEGIN
	SET NOCOUNT ON;

	-- Get the name of the caller
	DECLARE @Caller sysname = ORIGINAL_LOGIN();

	-- Validate permission for this operation
	-- The caller must be the PI or editor on the project
	IF NOT EXISTS (SELECT 1 FROM dbo.Projects WHERE ProjectId = @ProjectId AND ProjectInvestigator = @Caller)
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM dbo.ProjectEditors WHERE ProjectId = @ProjectId AND Editor = @Caller)
		BEGIN
			DECLARE @message1 nvarchar(200) = 'You ('+@Caller+') must be the principal investigator or editor on this project ('+@ProjectId+') to update an animal.';
			RAISERROR(@message1, 18, 0)
			RETURN (1)
		END
	END

	-- Verify this is an existing animal
	-- Otherwise, the update will silently succeed, which could be confusing.
	IF NOT EXISTS (SELECT 1 FROM [dbo].[Animals] WHERE [ProjectId] = @ProjectId AND [AnimalId] = @AnimalId)
	BEGIN
		DECLARE @message2 nvarchar(100) = 'There is no such animal (' + @AnimalId + ') in project (' + @ProjectId + ').';
		RAISERROR(@message2, 18, 0)
		RETURN (1)
	END
		
	-- If a parameter is not provided, use the existing value.
	-- (to put null in a field the user will need to pass an empty string)
	IF @Species IS NULL
	BEGIN
		SELECT @Species = [Species] FROM [dbo].[Animals] WHERE [ProjectId] = @ProjectId AND [AnimalId] = @AnimalId;
	END
	
	IF @Gender IS NULL
	BEGIN
		SELECT @Gender = [Gender] FROM [dbo].[Animals] WHERE [ProjectId] = @ProjectId AND [AnimalId] = @AnimalId;
	END
	
	-- There is no default value for mortality date, since we can't pass '' to express null,
	
	IF @GroupName IS NULL
	BEGIN
		SELECT @GroupName = [GroupName] FROM [dbo].[Animals] WHERE [ProjectId] = @ProjectId AND [AnimalId] = @AnimalId;
	END
	
	IF @Description IS NULL
	BEGIN
		SELECT @Description = [Description] FROM [dbo].[Animals] WHERE [ProjectId] = @ProjectId AND [AnimalId] = @AnimalId;
	END
	
	-- Do the update, replacing empty strings with NULLs
	-- All other verification is handled by primary/foreign key and column constraints.

	UPDATE dbo.Animals SET [Species] = nullif(@Species,''),
						   [Gender] = nullif(@Gender,''),
						   [GroupName] = nullif(@GroupName,''),
						   [MortalityDate] = @MortalityDate,
						   [Description] = nullif(@Description,'')
					 WHERE [ProjectId] = @ProjectId AND [AnimalId] = @AnimalId;

END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: March 28, 2012
-- Description:	Adds a new animal to a project.
-- =============================================
CREATE PROCEDURE [dbo].[Animal_Insert] 
	@ProjectId NVARCHAR(255)= NULL,
	@AnimalId NVARCHAR(255) = NULL, 
	@Species NVARCHAR(255) = NULL, 
	@Gender NVARCHAR(7) = 'Unknown', 
	@MortalityDate DATETIME2(7) = NULL, 
	@GroupName NVARCHAR(255) = NULL, 
	@Description NVARCHAR(4000) = NULL 
AS
BEGIN
	SET NOCOUNT ON;
	
	-- Get the name of the caller
	DECLARE @Caller sysname = ORIGINAL_LOGIN();

	-- Validate permission for this operation
	-- The caller must be the PI or editor on the project
	IF NOT EXISTS (SELECT 1 FROM dbo.Projects WHERE ProjectId = @ProjectId AND ProjectInvestigator = @Caller)
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM dbo.ProjectEditors WHERE ProjectId = @ProjectId AND Editor = @Caller)
		BEGIN
			DECLARE @message1 nvarchar(200) = 'You ('+@Caller+') must be the principal investigator or editor on this project ('+@ProjectId+') to add an animal.';
			RAISERROR(@message1, 18, 0)
			RETURN (1)
		END
	END
	
	IF @Gender IS NULL OR @Gender = ''
		SET @Gender = 'Unknown'
	
	--All other verification is handled by primary/foreign key and column constraints.
	INSERT INTO dbo.Animals ([ProjectId], [AnimalId], [Species], [Gender], [MortalityDate], [GroupName], [Description])
		 VALUES (nullif(@ProjectId,''), nullif(@AnimalId,''), nullif(@Species,''), @Gender,
		         @MortalityDate, nullif(@GroupName,''), nullif(@Description,''));

END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LookupCollarFileHeaders](
	[Header] [nvarchar](450) NOT NULL,
	[FileFormat] [char](1) NOT NULL,
 CONSTRAINT [PK_CollarFileHeaders] PRIMARY KEY CLUSTERED 
(
	[Header] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: April 2, 2012
-- Description:	Updates a Collar
-- =============================================
CREATE PROCEDURE [dbo].[Collar_Update] 
	@CollarManufacturer NVARCHAR(255)= NULL,
	@CollarId NVARCHAR(255) = NULL, 
	@CollarModel NVARCHAR(255) = NULL, 
	@Manager sysname = NULL, 
	@Owner NVARCHAR(255) = NULL, 
	@AlternativeId NVARCHAR(255) = NULL, 
	@SerialNumber NVARCHAR(255) = NULL, 
	@Frequency FLOAT = NULL, 
	@DownloadInfo NVARCHAR(255) = NULL, 
	@Notes NVARCHAR(max) = NULL,
	@DisposalDate DATETIME2(7) = NULL
AS
BEGIN
	SET NOCOUNT ON;

	-- Get the name of the caller
	DECLARE @Caller sysname = ORIGINAL_LOGIN();

	-- Verify this is an existing collar
	-- Otherwise, the update will silently succeed, which could be confusing.
	IF NOT EXISTS (SELECT 1 FROM dbo.Collars WHERE CollarManufacturer = @CollarManufacturer AND CollarId = @CollarId)
	BEGIN
		DECLARE @message2 nvarchar(100) = 'There is no such collar ('+@CollarManufacturer+'/'+@CollarId+').';
		RAISERROR(@message2, 18, 0)
		RETURN (1)
	END
		
	-- Validate permission for this operation
	-- The caller must be the Manager of the collar
	IF NOT EXISTS (SELECT 1 FROM dbo.Collars WHERE CollarManufacturer = @CollarManufacturer AND CollarId = @CollarId AND [Manager] = @Caller)
	BEGIN
		DECLARE @message1 nvarchar(200) = 'You ('+@Caller+') must be the manager of this collar ('+@CollarManufacturer+'/'+@CollarId+') to update it.';
		RAISERROR(@message1, 18, 0)
		RETURN (1)
	END

	-- If a parameter is not provided, use the existing value.
	-- (to put null in a field the user will need to pass an empty string)
	IF @CollarModel IS NULL
	BEGIN
		SELECT @CollarModel = [CollarModel] FROM dbo.Collars WHERE CollarManufacturer = @CollarManufacturer AND CollarId = @CollarId;
	END
	
	IF @Manager IS NULL
	BEGIN
		SELECT @Manager = [Manager] FROM dbo.Collars WHERE CollarManufacturer = @CollarManufacturer AND CollarId = @CollarId;
	END
	
	IF @Owner IS NULL
	BEGIN
		SELECT @Owner = [Owner] FROM dbo.Collars WHERE CollarManufacturer = @CollarManufacturer AND CollarId = @CollarId;
	END
	
	IF @AlternativeId IS NULL
	BEGIN
		SELECT @AlternativeId = [AlternativeId] FROM dbo.Collars WHERE CollarManufacturer = @CollarManufacturer AND CollarId = @CollarId;
	END
	
	IF @SerialNumber IS NULL
	BEGIN
		SELECT @SerialNumber = [SerialNumber] FROM dbo.Collars WHERE CollarManufacturer = @CollarManufacturer AND CollarId = @CollarId;
	END
	
	IF @Frequency IS NULL
	BEGIN
		SELECT @Frequency = [Frequency] FROM dbo.Collars WHERE CollarManufacturer = @CollarManufacturer AND CollarId = @CollarId;
	END
	
	IF @DownloadInfo IS NULL
	BEGIN
		SELECT @DownloadInfo = [DownloadInfo] FROM dbo.Collars WHERE CollarManufacturer = @CollarManufacturer AND CollarId = @CollarId;
	END
	
	IF @Notes IS NULL
	BEGIN
		SELECT @Notes = [Notes] FROM dbo.Collars WHERE CollarManufacturer = @CollarManufacturer AND CollarId = @CollarId;
	END
	
	-- Do the update, replacing empty strings with NULLs
	-- All other verification is handled by primary/foreign key and column constraints.

	UPDATE dbo.Collars SET [CollarModel] = nullif(@CollarModel,''),
						   [Manager] = nullif(@Manager,''),
						   [Owner] = nullif(@Owner,''),
						   [AlternativeId] = nullif(@AlternativeId,''),
						   [SerialNumber] = nullif(@SerialNumber,''),
						   [Frequency] = nullif(@Frequency,0),
						   [DownloadInfo] = nullif(@DownloadInfo,''),
						   [Notes] = nullif(@Notes,''),
						   [DisposalDate] = @DisposalDate
					 WHERE CollarManufacturer = @CollarManufacturer AND CollarId = @CollarId;

END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: April 2, 2012
-- Description:	Adds a new Collar.
-- =============================================
CREATE PROCEDURE [dbo].[Collar_Insert] 
	@CollarManufacturer NVARCHAR(255)= NULL,
	@CollarId NVARCHAR(255) = NULL, 
	@CollarModel NVARCHAR(255) = NULL, 
	@Owner NVARCHAR(255) = NULL, 
	@AlternativeId NVARCHAR(255) = NULL, 
	@SerialNumber NVARCHAR(255) = NULL, 
	@Frequency FLOAT = NULL, 
	@DownloadInfo NVARCHAR(255) = NULL, 
	@Notes NVARCHAR(max) = NULL,
	@DisposalDate DATETIME2(7) = NULL
AS
BEGIN
	SET NOCOUNT ON;

	-- Get the name of the caller
	DECLARE @Caller sysname = ORIGINAL_LOGIN();

	-- Validate permission for this operation
	-- If the caller is not a PI then error and return
	-- This is enforced by the defaults and referential integrity,
	-- but this makes the returned error message much easier to interpret.
	IF NOT EXISTS (SELECT 1 FROM [dbo].[ProjectInvestigators] WHERE [Login] = @Caller)
	BEGIN
		DECLARE @message1 nvarchar(100) = 'You ('+@Caller+') must be a principal investigator to create a collar';
		RAISERROR(@message1, 18, 0)
		RETURN
	END
	
	--All other verification is handled by primary/foreign key and column constraints.
	INSERT INTO dbo.Collars ([CollarManufacturer], [CollarId], [CollarModel], [Owner],  
							 [AlternativeId], [SerialNumber], [Frequency], [DownloadInfo], [Notes], [DisposalDate])
			 VALUES (nullif(@CollarManufacturer,''), nullif(@CollarId,''), nullif(@CollarModel,''),
					 nullif(@Owner,''), nullif(@AlternativeId,''), nullif(@SerialNumber,''),
					 nullif(@Frequency,''), nullif(@DownloadInfo,''), nullif(@Notes,''), @DisposalDate)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: April 2, 2012
-- Description:	Delete a collar
-- =============================================
CREATE PROCEDURE [dbo].[Collar_Delete] 
	@CollarManufacturer NVARCHAR(255)= NULL,
	@CollarId NVARCHAR(255) = NULL
AS
BEGIN
	SET NOCOUNT ON;
	
	-- Get the name of the caller
	DECLARE @Caller sysname = ORIGINAL_LOGIN();

	-- Validate permission for this operation
	-- The caller must be the Manager of the collar
	IF NOT EXISTS (SELECT 1 FROM dbo.Collars WHERE CollarManufacturer = @CollarManufacturer AND CollarId = @CollarId AND [Manager] = @Caller)
	BEGIN
		DECLARE @message1 nvarchar(200) = 'You ('+@Caller+') must be the manger of this collar ('+@CollarManufacturer+'/'+@CollarId+') to delete it.';
		RAISERROR(@message1, 18, 0)
		RETURN (1)
	END

	-- deleting a non-existing collar will silently succeed.
	-- All other verification is handled by primary/foreign key and column constraints.
	DELETE FROM dbo.Collars WHERE CollarManufacturer = @CollarManufacturer AND CollarId = @CollarId;
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CollarParameterFiles](
	[FileId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Owner] [sysname] NOT NULL,
	[FileName] [nvarchar](255) NOT NULL,
	[Format] [char](1) NOT NULL,
	[UploadDate] [datetime2](7) NOT NULL,
	[UploadUser] [sysname] NOT NULL,
	[Contents] [varbinary](max) NOT NULL,
 CONSTRAINT [PK_CollarParameterFiles] PRIMARY KEY CLUSTERED 
(
	[FileId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: May 31, 2012
-- Description:	Returns a table of files with fixes for a specific collar.
-- Example:     SELECT * FROM CollarFixesByFile('Telonics', '96007')
-- =============================================
CREATE FUNCTION [dbo].[CollarFixesByFile] 
(
	@CollarManufacturer NVARCHAR(255), 
	@CollarId           NVARCHAR(255)
)
RETURNS TABLE 
AS
	RETURN
		SELECT  F.[FileId],
				F.[FileName]+'.csv' AS [File],
				S.[Name] AS [Status],
				COUNT(FixDate) AS [FixCount],
				dbo.LocalTime(MIN(FixDate)) AS [First],
				dbo.LocalTime(MAX(FixDate)) AS [Last]
		FROM [dbo].[CollarFiles] AS F
		INNER JOIN [dbo].[LookupCollarFileStatus] AS S
		ON F.[Status] = S.[Code]
		LEFT JOIN [dbo].[CollarFixes] AS X
		ON X.FileId = F.FileId
		WHERE (F.CollarManufacturer = @CollarManufacturer AND F.CollarId = @CollarId)
		   OR (X.CollarManufacturer = @CollarManufacturer AND X.CollarId = @CollarId)
		GROUP BY F.[FileId], F.[FileName], S.[Name]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: March 3, 2012
-- Description:	Adjusts which of several conflicting fixes will be the active one.
--
-- A fix may hide zero or one other fix
-- A fix may be hidden by zero or one other fix
-- A fix cannot hide itself
-- Therefore in a set of fixes that share the same collar and fixdate,
-- there is one and only one fix that is not hidden
-- there is one and only one fix that is not hidding any other fixes
-- =============================================
CREATE PROCEDURE [dbo].[CollarFixes_UpdateUnhideFix] 
	@FixId bigint = Null
AS
BEGIN
	SET NOCOUNT ON;
	
	-- Get some information about the fix to update
	DECLARE @HiddenBy  BIGINT;
	DECLARE @ProjectId NVARCHAR(255);
	 SELECT @HiddenBy  = [HiddenBy],
		    @ProjectId = [Project]
	   FROM [dbo].[CollarFixes] AS F1
	  INNER JOIN [dbo].[CollarFiles] AS F2
	     ON F1.FileId = F2.FileId
	  WHERE [FixId] = @FixId;

	IF @ProjectId IS NULL
	BEGIN
		DECLARE @message1 nvarchar(100) = 'Invalid parameter: (' + @FixId + ') was not found in the CollarFixes table';
		RAISERROR(@message1, 18, 0)
		RETURN 1
	END
	-- If ProjectId was found, then HiddenBy is guaranteed.

	-- Get the name of the caller
	DECLARE @Caller sysname = ORIGINAL_LOGIN();

	-- Validate permission for this operation
	-- The caller must be the PI or editor on the project
	IF NOT EXISTS (SELECT 1 FROM dbo.Projects WHERE ProjectId = @ProjectId AND ProjectInvestigator = @Caller)
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM dbo.ProjectEditors WHERE ProjectId = @ProjectId AND Editor = @Caller)
		BEGIN
			DECLARE @message2 nvarchar(200) = 'You ('+@Caller+') must be the principal investigator or editor of the project ('+@ProjectId+') to update this file.';
			RAISERROR(@message2, 18, 0)
			RETURN (1)
		END
	END
	
	IF  @HiddenBy IS NULL
	BEGIN
		RETURN 0  --Nothing to do.
	END
	
	-- Fix is hidden, and we have permissions, lets do it.
	DECLARE @ConflictingFixes TABLE
	(
		FixId bigint,
		HiddenBy bigint
	);
	DECLARE @NotHidden bigint;
	DECLARE @NotHider bigint;

	BEGIN TRY
		BEGIN TRAN

			INSERT INTO @ConflictingFixes 
				SELECT DISTINCT F1.FixId, F1.HiddenBy FROM dbo.CollarFixes AS F1
				INNER JOIN dbo.CollarFixes AS F2
				   ON F1.CollarManufacturer = F2.CollarManufacturer
				  AND F1.CollarId = F2.CollarId
				  AND F1.FixDate = F2.FixDate
				WHERE F1.FixId != F2.FixId AND (F1.FixId = @FixId OR F2.FixId = @FixId) ORDER BY F1.FixId;

			-- The fix in the set that is not hidden
			SET @NotHidden = (SELECT FixId FROM @ConflictingFixes WHERE HiddenBy IS NULL)
			-- The fix in the set that is not hidding any other fixes
			SET @NotHider = (SELECT FixId FROM @ConflictingFixes WHERE FixId NOT IN (SELECT HiddenBy FROM @ConflictingFixes WHERE HiddenBy IS NOT NULL))
			
			--Hide the currently Un Hidden fix with the fix not hidding any other fixes
			--(creates circlular loop of hidden-ness)
			UPDATE dbo.CollarFixes SET HiddenBy = @NotHider WHERE FixId = @NotHidden
			--Unhide the selected fix 
			UPDATE dbo.CollarFixes SET HiddenBy = NULL WHERE FixId = @FixId

		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		IF XACT_STATE() <> 0
			ROLLBACK TRANSACTION;
		EXEC [dbo].[Utility_RethrowError]
		RETURN 1
	END CATCH
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CollarDataDebevekFormat](
	[FileID] [int] NOT NULL,
	[LineNumber] [int] NOT NULL,
	[CollarID] [char](6) NULL,
	[AnimalId] [char](6) NULL,
	[Species] [nvarchar](255) NULL,
	[Group] [nvarchar](255) NULL,
	[Park] [nvarchar](255) NULL,
	[FixDate] [nvarchar](255) NULL,
	[FixTime] [nvarchar](255) NULL,
	[FixMonth] [float] NULL,
	[FixDay] [float] NULL,
	[FixYear] [float] NULL,
	[LatWGS84] [float] NULL,
	[LonWGS84] [float] NULL,
	[Temperature] [float] NULL,
	[Other] [nvarchar](255) NULL,
 CONSTRAINT [PK_CollarDataDebevekFormat] PRIMARY KEY CLUSTERED 
(
	[FileID] ASC,
	[LineNumber] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CollarDataTelonicsGen3](
	[FileId] [int] NOT NULL,
	[LineNumber] [int] NOT NULL,
	[TXDate] [varchar](50) NULL,
	[TXTime] [varchar](50) NULL,
	[PTTID] [varchar](50) NULL,
	[FixNum] [varchar](50) NULL,
	[FixQual] [varchar](50) NULL,
	[FixDate] [varchar](50) NULL,
	[FixTime] [varchar](50) NULL,
	[Longitude] [varchar](50) NULL,
	[Latitude] [varchar](50) NULL,
 CONSTRAINT [PK_CollarDataTelonicsGen3] PRIMARY KEY CLUSTERED 
(
	[FileId] ASC,
	[LineNumber] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CollarDataTelonicsGen4](
	[FileId] [int] NOT NULL,
	[LineNumber] [int] NOT NULL,
	[AcquisitionTime] [varchar](50) NULL,
	[AcquisitionStartTime] [varchar](50) NULL,
	[Ctn] [varchar](50) NULL,
	[ArgosId] [varchar](50) NULL,
	[ArgosLocationClass] [varchar](50) NULL,
	[ArgosLatitude] [varchar](50) NULL,
	[ArgosLongitude] [varchar](50) NULL,
	[ArgosAltitude] [varchar](50) NULL,
	[GpsFixTime] [varchar](50) NULL,
	[GpsFixAttempt] [varchar](50) NULL,
	[GpsLatitude] [varchar](50) NULL,
	[GpsLongitude] [varchar](50) NULL,
	[GpsUtmZone] [varchar](50) NULL,
	[GpsUtmNorthing] [varchar](50) NULL,
	[GpsUtmEasting] [varchar](50) NULL,
	[GpsAltitude] [varchar](50) NULL,
	[GpsSpeed] [varchar](50) NULL,
	[GpsHeading] [varchar](50) NULL,
	[GpsHorizontalError] [varchar](50) NULL,
	[GpsPositionalDilution] [varchar](50) NULL,
	[GpsHorizontalDilution] [varchar](50) NULL,
	[GpsSatelliteBitmap] [varchar](50) NULL,
	[GpsSatelliteCount] [varchar](50) NULL,
	[GpsNavigationTime] [varchar](50) NULL,
	[UnderwaterPercentage] [varchar](50) NULL,
	[DiveCount] [varchar](50) NULL,
	[AverageDiveDuration] [varchar](50) NULL,
	[MaximumDiveDuration] [varchar](50) NULL,
	[LayerPercentage] [varchar](50) NULL,
	[MaximumDiveDepth] [varchar](50) NULL,
	[DiveStartTime] [varchar](50) NULL,
	[DiveDuration] [varchar](50) NULL,
	[DiveDepth] [varchar](50) NULL,
	[DiveProfile] [varchar](50) NULL,
	[ActivityCount] [varchar](50) NULL,
	[Temperature] [varchar](50) NULL,
	[RemoteAnalog] [varchar](50) NULL,
	[SatelliteUplink] [varchar](50) NULL,
	[ReceiveTime] [varchar](50) NULL,
	[SatelliteName] [varchar](50) NULL,
	[RepetitionCount] [varchar](50) NULL,
	[LowVoltage] [varchar](50) NULL,
	[Mortality] [varchar](50) NULL,
	[SaltwaterFailsafe] [varchar](50) NULL,
	[HaulOut] [varchar](50) NULL,
	[DigitalInput] [varchar](50) NULL,
	[MotionDetected] [varchar](50) NULL,
	[TrapTriggerTime] [varchar](50) NULL,
	[ReleaseTime] [varchar](50) NULL,
	[PredeploymentData] [varchar](50) NULL,
	[Error] [varchar](250) NULL,
 CONSTRAINT [PK_CollarDataTelonicsGen4] PRIMARY KEY CLUSTERED 
(
	[FileId] ASC,
	[LineNumber] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CollarDataTelonicsStoreOnBoard](
	[FileId] [int] NOT NULL,
	[LineNumber] [int] NOT NULL,
	[Fix #] [varchar](50) NULL,
	[Date] [nvarchar](50) NULL,
	[Time] [nvarchar](50) NULL,
	[Fix Status] [varchar](50) NULL,
	[Status Text] [varchar](150) NULL,
	[Velocity East(m s)] [varchar](50) NULL,
	[Velocity North(m s)] [varchar](50) NULL,
	[Velocity Up(m s)] [varchar](50) NULL,
	[Latitude] [varchar](50) NULL,
	[Longitude] [varchar](50) NULL,
	[Altitude(m)] [varchar](50) NULL,
	[PDOP] [varchar](50) NULL,
	[HDOP] [varchar](50) NULL,
	[VDOP] [varchar](50) NULL,
	[TDOP] [varchar](50) NULL,
	[Temperature Sensor(deg )] [varchar](50) NULL,
	[Activity Sensor] [varchar](50) NULL,
	[Satellite Data] [varchar](150) NULL,
 CONSTRAINT [PK_CollarDataTelonicsStoreOnBoard] PRIMARY KEY CLUSTERED 
(
	[FileId] ASC,
	[LineNumber] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: March 2, 2012
-- Description:	Add the fixes for a CollarFile Data
-- =============================================
CREATE PROCEDURE [dbo].[CollarFixes_Insert] 
	@FileId INT,
	@Format CHAR
AS
BEGIN
	SET NOCOUNT ON;

	-- This is not executed directly, only by CollarFile_Insert & CollarFile_UpdateStatus 

	-- if FileId is not found, or file is Inactive, then no fixes will be added.
	
	--FIXME - CollarFile.CollarId, and CollarDataDebevekFormat.CollarId are not
	--        related to Collars.CollarId, but CollarFixes.CollarId is.
	--        therefore, we could try to insert a foreign key violation, and
	--        this entire update could fail.
	
	IF @Format = 'A'  -- Store on board
	BEGIN
		INSERT INTO dbo.CollarFixes (FileId, LineNumber, CollarManufacturer, CollarId, FixDate, Lat, Lon)
		 SELECT I.FileId, I.LineNumber, F.CollarManufacturer, F.CollarId,
		        CONVERT(datetime2, I.[Date]+ ' ' + ISNULL(I.[Time],'')),
		        CONVERT(float, I.Latitude), CONVERT(float, I.Longitude) - 360.0
		   FROM dbo.CollarDataTelonicsStoreOnBoard as I INNER JOIN CollarFiles as F 
			 ON I.FileId = F.FileId
		  WHERE F.[Status] = 'A'
		    AND I.[Fix Status] = 'Fix Available'
		    AND I.FileId = @FileId
	END
		
	IF @Format = 'B'  -- Debevek Format
	BEGIN
		INSERT INTO dbo.CollarFixes (FileId, LineNumber, CollarManufacturer, CollarId, FixDate, Lat, Lon)
		 SELECT I.FileId, I.LineNumber, F.CollarManufacturer, C.CollarId,
		        CONVERT(datetime2, I.[FixDate]+ ' ' + ISNULL(I.[FixTime],'')),
		        I.LatWGS84, I.LonWGS84
		   FROM dbo.CollarDataDebevekFormat as I
	 INNER JOIN CollarFiles as F 
			 ON I.FileId = F.FileId
	 INNER JOIN Collars as C 
			 ON C.AlternativeId = I.CollarID		 
		  WHERE F.[Status] = 'A'
		    AND I.FileId = @FileId
		    AND I.LatWGS84 IS NOT NULL AND I.LonWGS84 IS NOT NULL
		    AND I.[FixDate] IS NOT NULL
	END
	
	/*
	The use of AquisitionTime and not GpsFixTime is confusing, but apperantly correct
	of the 810,428 records collected as of 8/23/2012,
	GpsFixDate is non null in only 9205 records (GpsFixattempt = Succeeded(2D) or Succeeded(3D))
	In those cases, GpsFixDate == AcquisitionTime
	AcquisitionTime is never null when GpsFixAttempt == Succeed (110,090 records),
	but is null when GpsFixAttemp == Failed (71 records)
	
	There are some cases where Acquisition time is bogus (in the future),
	I've manually hidden those locations, but I'm not sure the correct strategy.
	*/
	
	IF @Format = 'C'  -- Telonics Gen4 Condensed Convertor Format
	BEGIN
		INSERT INTO dbo.CollarFixes (FileId, LineNumber, CollarManufacturer, CollarId, FixDate, Lat, Lon)
		 SELECT I.FileId, I.LineNumber, F.CollarManufacturer, F.CollarId,
		        CONVERT(datetime2, I.[AcquisitionTime]),
		        CONVERT(float, I.GpsLatitude), CONVERT(float, I.GpsLongitude)
		   FROM dbo.CollarDataTelonicsGen4 as I INNER JOIN CollarFiles as F 
			 ON I.FileId = F.FileId
		  WHERE F.[Status] = 'A'
		    AND I.FileId = @FileId
		    AND I.GpsLatitude IS NOT NULL AND I.GpsLongitude IS NOT NULL
		    AND I.[AcquisitionTime] IS NOT NULL
		    AND I.[AcquisitionTime] < F.UploadDate  -- Ignore some bogus (obviously future) fix dates
	END
	
	IF @Format = 'D'  -- Telonics Gen3 Format

	-- FixStatus: Bad, Good, Unavailable, Err:CCC-FFF, Invalid.
	-- Only use FixStatus = Good.
	-- Exception:  If Fix #1 has been declared Bad, fixes 2-6  must be considered Bad as well even if their status is listed as Good.
	-- This is necessary since fixes 2-6 are reconstructed using information in Fix #1.
	
	-- Date format is YYYY.MM.DD; Time Format is HH:MM, unless there is GPS error information then HH:MM:SS
	-- Lat/Long are decimal degrees with 4 decimal places, and are either signed, or have alpha (N,S,E,W) suffix - user options
	-- Lat/Long with Alpha suffix in source file are converted to signed prefix by parser during insert to CollarData table 
	
	BEGIN
		-- find valid packages (sequential fixes 1-6 at a specific date/time)
		-- turns out transmission date/time is not a unique identifier - there are multiple packages during a transmission.
		-- need to identify fixes 2-6 that need to be eliminated by location in file; i.e. do not
		-- add lines 2-6 after a bad fix 1.
		-- caution: in a package fixes 2 to 6 are optional. 
		
		-- step 1 find line numbers for valid first fixes
		SELECT LineNumber INTO #ValidFirstFix  
		  FROM [Animal_Movement].[dbo].[CollarDataTelonicsGen3]
		  WHERE FileId = @FileId and FixNum = 1 and FixQual = 'Good'
		  
		-- step 2 find line numbers associated with a good first fixes
		/*
		SELECT C.LineNumber INTO #ValidLines  
		  FROM [Animal_Movement].[dbo].[CollarDataTelonicsGen3] AS C 
		  INNER JOIN  #ValidFirstFix AS F
		    ON (C.LineNumber = F.LineNumber)
		    OR (C.LineNumber = F.LineNumber+1 AND C.FixNum = 2)
		    OR (C.LineNumber = F.LineNumber+2 AND C.FixNum = 3)
		    OR (C.LineNumber = F.LineNumber+3 AND C.FixNum = 4)
		    OR (C.LineNumber = F.LineNumber+4 AND C.FixNum = 5)
		    OR (C.LineNumber = F.LineNumber+5 AND C.FixNum = 6)
		  WHERE C.FileId = @FileId
		*/
		
	-- By my observations, if any fix is bad, then all subsequent fixes in that package (1-6) are suspect,
	-- and should be eliminated, hence the new logic below:
	
		SELECT LineNumber INTO #ValidLines FROM #ValidFirstFix  

		SELECT C.LineNumber INTO #ValidSecondFix  
		  FROM [Animal_Movement].[dbo].[CollarDataTelonicsGen3] AS C 
		  INNER JOIN  #ValidFirstFix AS F
		  ON (C.LineNumber = F.LineNumber + 1 AND C.FixNum = 2)
		  WHERE FileId = @FileId and FixQual <> 'Bad'
		INSERT INTO #ValidLines (LineNumber) SELECT LineNumber FROM #ValidSecondFix  

		SELECT C.LineNumber INTO #ValidThirdFix  
		  FROM [Animal_Movement].[dbo].[CollarDataTelonicsGen3] AS C 
		  INNER JOIN  #ValidSecondFix AS F
		  ON (C.LineNumber = F.LineNumber + 1 AND C.FixNum = 3)
		  WHERE FileId = @FileId and FixQual <> 'Bad'
		INSERT INTO #ValidLines (LineNumber) SELECT LineNumber FROM #ValidThirdFix  

		SELECT C.LineNumber INTO #ValidFourthFix  
		  FROM [Animal_Movement].[dbo].[CollarDataTelonicsGen3] AS C 
		  INNER JOIN  #ValidThirdFix AS F
		  ON (C.LineNumber = F.LineNumber + 1 AND C.FixNum = 4)
		  WHERE FileId = @FileId and FixQual <> 'Bad'
		INSERT INTO #ValidLines (LineNumber) SELECT LineNumber FROM #ValidFourthFix  

		SELECT C.LineNumber INTO #ValidFifthFix  
		  FROM [Animal_Movement].[dbo].[CollarDataTelonicsGen3] AS C 
		  INNER JOIN  #ValidFourthFix AS F
		  ON (C.LineNumber = F.LineNumber + 1 AND C.FixNum = 5)
		  WHERE FileId = @FileId and FixQual <> 'Bad'
		INSERT INTO #ValidLines (LineNumber) SELECT LineNumber FROM #ValidFifthFix  

		SELECT C.LineNumber INTO #ValidSixthFix  
		  FROM [Animal_Movement].[dbo].[CollarDataTelonicsGen3] AS C 
		  INNER JOIN  #ValidFifthFix AS F
		  ON (C.LineNumber = F.LineNumber + 1 AND C.FixNum = 6)
		  WHERE FileId = @FileId and FixQual <> 'Bad'
		INSERT INTO #ValidLines (LineNumber) SELECT LineNumber FROM #ValidSixthFix  
		
		-- step 3 add valid fixes to the fixes table.
		INSERT INTO dbo.CollarFixes (FileId, LineNumber, CollarManufacturer, CollarId, FixDate, Lat, Lon)
		 SELECT I.FileId, I.LineNumber, F.CollarManufacturer, F.CollarId,
		        CONVERT(datetime2, I.[FixDate]+ ' ' + ISNULL(I.[FixTime],'')),
		        CONVERT(float, I.Latitude), CONVERT(float, I.Longitude)
		   FROM dbo.CollarDataTelonicsGen3 as I
		     INNER JOIN CollarFiles as F 
			 ON I.FileId = F.FileId
		     INNER JOIN #ValidLines AS V
		     ON I.LineNumber = V.LineNumber
		  WHERE F.[Status] = 'A'
		    AND I.FileId = @FileId
		    AND I.[FixQual] = 'Good'
		    AND I.[FixDate] <> 'Error'
		    AND I.Latitude IS NOT NULL AND I.Longitude IS NOT NULL
		    AND I.[Longitude] <> 'Error' AND I.[Latitude] <> 'Error'
	END
	
	-- FIXME: Add other formats 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ===============================================
-- Author:		Regan Sarwas
-- Create date: March 2, 2012
-- Description:	Updates the Status of a CollarFile
-- ===============================================
CREATE PROCEDURE [dbo].[CollarFile_UpdateStatus] 
	@FileId INT  = NULL, 
	@Status CHAR = NULL
AS
BEGIN
	SET NOCOUNT ON;
	
	-- Get some information about the file to update
	DECLARE @OldStatus CHAR;
	DECLARE @Format    CHAR;
	DECLARE @ProjectId NVARCHAR(255);
	 SELECT @Format    = [Format],
		    @OldStatus = [Status],
		    @ProjectId = [Project]
	   FROM [dbo].[CollarFiles]
	  WHERE [FileId] = @FileId;

	IF @OldStatus IS NULL
	BEGIN
		DECLARE @message2 nvarchar(100) = 'Invalid parameter: (' + @FileId + ') was not found in the CollarFiles table';
		RAISERROR(@message2, 18, 0)
		RETURN 1
	END
	-- If OldStatus was found, then Format and Project are guaranteed.

	-- Get the name of the caller
	DECLARE @Caller sysname = ORIGINAL_LOGIN();

	-- Validate permission for this operation
	-- The caller must be the PI or editor on the project
	IF NOT EXISTS (SELECT 1 FROM dbo.Projects WHERE ProjectId = @ProjectId AND ProjectInvestigator = @Caller)
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM dbo.ProjectEditors WHERE ProjectId = @ProjectId AND Editor = @Caller)
		BEGIN
			DECLARE @message4 nvarchar(200) = 'You ('+@Caller+') must be the principal investigator or editor of the project ('+@ProjectId+') to update this file.';
			RAISERROR(@message4, 18, 0)
			RETURN (1)
		END
	END
		
	IF NOT EXISTS (SELECT 1 FROM [dbo].[LookupCollarFileStatus] WHERE [Code] = @Status)
	BEGIN
		DECLARE @message1 nvarchar(100) = 'Invalid parameter: (' + @Status + ') is not a recognized status';
		RAISERROR(@message1, 18, 0)
		RETURN 1
	END
	
	-- Do update	
	BEGIN TRY
		BEGIN TRAN
			IF (@OldStatus = 'I' AND @Status = 'A')
			BEGIN
				UPDATE [dbo].[CollarFiles] SET [Status] = @Status WHERE [FileId] = @FileId;
				EXEC [dbo].[CollarFixes_Insert] @FileId, @Format 
			END
			IF (@OldStatus = 'A' AND @Status = 'I')
			BEGIN
				UPDATE [dbo].[CollarFiles] SET [Status] = @Status WHERE [FileId] = @FileId;
				EXEC [dbo].[CollarFixes_Delete] @FileId
			END
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		IF XACT_STATE() <> 0
			ROLLBACK TRANSACTION;
		EXEC [dbo].[Utility_RethrowError]
		RETURN 1
	END CATCH
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[StoreOnBoardLocations]
AS
SELECT     dbo.CollarDataTelonicsStoreOnBoard.*, dbo.Animals.*, dbo.Locations.Location, dbo.CollarFiles.FileName, dbo.CollarFiles.UserName, 
                      dbo.CollarFiles.UploadDate
FROM         dbo.CollarDataTelonicsStoreOnBoard INNER JOIN
                      dbo.CollarFixes ON dbo.CollarDataTelonicsStoreOnBoard.FileId = dbo.CollarFixes.FileId AND 
                      dbo.CollarDataTelonicsStoreOnBoard.LineNumber = dbo.CollarFixes.LineNumber INNER JOIN
                      dbo.Locations ON dbo.CollarFixes.FixId = dbo.Locations.FixId INNER JOIN
                      dbo.Animals ON dbo.Locations.ProjectId = dbo.Animals.ProjectId AND dbo.Locations.AnimalId = dbo.Animals.AnimalId INNER JOIN
                      dbo.CollarFiles ON dbo.CollarDataTelonicsStoreOnBoard.FileId = dbo.CollarFiles.FileId AND dbo.CollarFixes.FileId = dbo.CollarFiles.FileId
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CollarParameters](
	[CollarManufacturer] [varchar](16) NOT NULL,
	[CollarId] [varchar](16) NOT NULL,
	[FileId] [int] NOT NULL,
	[StartDate] [datetime2](7) NULL,
	[EndDate] [datetime2](7) NULL,
 CONSTRAINT [PK_CollarParameters] PRIMARY KEY CLUSTERED 
(
	[CollarManufacturer] ASC,
	[CollarId] ASC,
	[FileId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: June 11, 2012
-- Description:	Drops a user from the database if
--              it is no longer being referenced.
-- =============================================
CREATE TRIGGER [dbo].[AfterProjectEditorDelete] 
ON [dbo].[ProjectEditors] 
AFTER DELETE AS
BEGIN
	SET NOCOUNT ON;
	DECLARE
		@ProjectId nvarchar(255) = Null,
		@Editor sysname  = Null
	
	-- Loop over all the editors to be deleted, and
	-- if 1) they are the not a PI, and
	--    2) they will no longer have a presense in the Editors table,
	-- then drop them from the DB
	
	DECLARE del_cursor CURSOR FOR 
		SELECT [ProjectId], [Editor] FROM deleted

	OPEN del_cursor;

	FETCH NEXT FROM del_cursor INTO @ProjectId, @Editor;

	WHILE @@FETCH_STATUS = 0
	BEGIN
		-- If this Editor is a project investigator, then do nothing more
		IF EXISTS(SELECT 1 FROM [dbo].[ProjectInvestigators] WHERE [Login] = @Editor)
		BEGIN
			FETCH NEXT FROM del_cursor INTO @ProjectId, @Editor;
			CONTINUE
		END

		-- If this Editor is still an editor (on this or other projects after deleting), then do nothing more
		IF EXISTS(select 1 from [dbo].[ProjectEditors] AS E
					where not exists
					     (select * from deleted as D where D.ProjectId = E.ProjectId AND D.Editor = E.Editor)
					 AND Editor = @Editor)
		BEGIN
			FETCH NEXT FROM del_cursor INTO @ProjectId, @Editor;
			CONTINUE
		END
		
		-- This editor is not an editor on any projects, so remove the user from the database
		-- This will also, obviously, remove them from the Editor role
		-- If this fails, the user will still have permissions to run the stored procedures,
		--  however the stored procedures should stop them because they are not in the
		--  ProjectEditor table
		IF EXISTS (SELECT 1 from sys.database_principals WHERE type = 'U' AND name = @Editor)
			EXEC ('DROP USER ['  + @Editor + ']') --  LOGIN defaults to the same name

		FETCH NEXT FROM del_cursor INTO @ProjectId, @Editor;		
	END
	CLOSE del_cursor;
	DEALLOCATE del_cursor;
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: November 9, 2012
-- Description:	Updates a collar parameter file in the database.
--              You cannot update the contents, upload date/user,
--              if those are wrong, delete and re-upload the file.
-- =============================================
CREATE PROCEDURE [dbo].[CollarParameterFile_Update] 
	@Owner NVARCHAR(255) = NULL, 
	@FileName NVARCHAR(255) = NULL,
	@Format CHAR = NULL, 
	@FileId INT = NULL
AS
BEGIN
	SET NOCOUNT ON;
    
	-- Get the name of the caller
	DECLARE @Caller sysname = ORIGINAL_LOGIN();

	IF @Owner IS NULL
		SET @Owner = @Caller
		
	-- Validate permission for this operation

	-- The caller must be an editor in the database - handled by execute permissions

	-- Verify that the file exists (this is done now to avoid the following check issuing a confusing error)
	IF NOT EXISTS (SELECT 1 FROM [dbo].[CollarParameterFiles] WHERE [FileId] = @FileId)
	BEGIN
		RAISERROR('The file you want to update was not found.', 18, 0)
		RETURN (1)
	END

	-- The caller must be the owner or the Uploader of the collar parameter file
	IF NOT EXISTS (SELECT 1 FROM [dbo].[CollarParameterFiles] WHERE [FileId] = @FileId AND ([Owner] = @Caller OR [UploadUser] = @Caller))
	BEGIN
		DECLARE @message1 nvarchar(200) = 'You ('+@Caller+') must be the owner or the Uploader of the collar parameter file (Id = '+str(@FileId)+') to delete it.';
		RAISERROR(@message1, 18, 0)
		RETURN (1)
	END


	-- All other verification is handled by primary/foreign key and column constraints.
	UPDATE dbo.CollarParameterFiles SET [Owner] = @Owner, [FileName] = @FileName, [Format] = @Format
		 WHERE [FileId] = @FileId

END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: October 12, 2012
-- Description:	Adds a new collar parameter file to the database.
-- =============================================
CREATE PROCEDURE [dbo].[CollarParameterFile_Insert] 
	@Owner NVARCHAR(255) = NULL, 
	@FileName NVARCHAR(255) = NULL,
	@Format CHAR = NULL, 
	@Contents VARBINARY(max) = NULL,
	@FileId INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
    
	-- Get the name of the caller
	DECLARE @Caller sysname = ORIGINAL_LOGIN();

	IF @Owner IS NULL
		SET @Owner = @Caller
		
	-- Validate permission for this operation

	-- The caller must be an editor in the database - handled by execute permissions

	-- All other verification is handled by primary/foreign key and column constraints.
	INSERT INTO dbo.CollarParameterFiles ([Owner], [FileName], [Format], [Contents])
		 VALUES (@Owner, @FileName, @Format, @Contents)

	SET @FileId = SCOPE_IDENTITY();

END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: November 9, 2012
-- Description:	Deletes a CollarParameterFile from the database
-- =============================================
CREATE PROCEDURE [dbo].[CollarParameterFile_Delete] 
	@FileId int = -1
AS
BEGIN
	SET NOCOUNT ON;
	
	-- Get the name of the caller
	DECLARE @Caller sysname = ORIGINAL_LOGIN();

	-- Validate permission for this operation

	-- The caller must be an editor in the database - handled by execute permissions

	-- Verify that the file exists (this is done now to avoid the following check issuing a confusing error)
	IF NOT EXISTS (SELECT 1 FROM [dbo].[CollarParameterFiles] WHERE [FileId] = @FileId)
	BEGIN
		RAISERROR('The file you want to delete was not found.', 18, 0)
		RETURN (1)
	END


	-- The caller must be the owner or the Uploader of the collar parameter file
	IF NOT EXISTS (SELECT 1 FROM [dbo].[CollarParameterFiles] WHERE [FileId] = @FileId AND ([Owner] = @Caller OR [UploadUser] = @Caller))
	BEGIN
		DECLARE @message1 nvarchar(200) = 'You ('+@Caller+') must be the owner or the Uploader of the collar parameter file (Id = '+str(@FileId)+') to delete it.';
		RAISERROR(@message1, 18, 0)
		RETURN (1)
	END

	-- All other verification is handled by primary/foreign key and column constraints.
	DELETE FROM dbo.CollarParameterFiles WHERE FileId = @FileId;
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[IsEditor] 
(
	@Project VARCHAR(32)   = NULL, 
	@User sysname = NULL
)
RETURNS BIT
AS
BEGIN
	-- Check that @User is in the Investigator or the Editor Role
	IF NOT EXISTS( SELECT 1 FROM sys.sysmembers WHERE (USER_NAME(groupuid) = 'Editor' AND USER_NAME(memberuid) = @user)
												   OR (USER_NAME(groupuid) = 'Investigator' AND USER_NAME(memberuid) = @user))
		RETURN 0
	
	--Check that the users is either an editor or the PI on the project
	IF EXISTS( SELECT 1 FROM dbo.Projects AS P 
				LEFT JOIN dbo.ProjectEditors AS E ON P.ProjectId = E.ProjectId 
				WHERE P.ProjectId = @Project
				  AND (E.Editor = @User OR P.ProjectInvestigator = @User))
		RETURN 1
	RETURN 0
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[IsFixEditor] 
(
	@FixId BIGINT = NULL, 
	@User sysname = NULL
)
RETURNS BIT
AS
BEGIN
	DECLARE @Result BIT
	
		SELECT @Result = [dbo].[IsEditor]([f].[Project], @User)
		  FROM [dbo].[CollarFixes] AS [x]
	INNER JOIN [dbo].[CollarFiles] AS [f]
			ON [x].[FileId] = [f].[FileId]
		 WHERE [x].[FixId] = @FixId;
		 
	RETURN @Result
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: March 2, 2012
-- Description:	Deletes an animal
-- =============================================
CREATE PROCEDURE [dbo].[Animal_Delete] 
	@ProjectId nvarchar(255) = NULL,
	@AnimalId nvarchar(255) = NULL
AS
BEGIN
	SET NOCOUNT ON;
	
	-- Get the name of the caller
	DECLARE @Caller sysname = ORIGINAL_LOGIN();

	-- Validate permission for this operation
	-- The caller must be able to edit this project
	IF NOT EXISTS (SELECT 1 WHERE [dbo].[IsEditor](@ProjectId, @Caller) = 1)
	BEGIN
		DECLARE @message1 nvarchar(200) = 'You ('+@Caller+') must be the principal investigator or editor on this project ('+@ProjectId+') to delete an animal.';
		RAISERROR(@message1, 18, 0)
		RETURN (1)
	END

	-- deleting a non-existing animal will silently succeed.
	-- All other verification is handled by primary/foreign key and column constraints.
	DELETE FROM dbo.Animals WHERE [ProjectId] = @ProjectId AND [AnimalId] = @AnimalId
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: March 2, 2012
-- Description:	Returns the name of the table with the raw collar data for a file 
-- =============================================

CREATE FUNCTION [dbo].[GetCollarDataTableName]
(
	@FileId INT = NULL
)
RETURNS sysname
AS
BEGIN
	DECLARE @Result sysname
	SET @Result = (SELECT F.[TableName]
			 	     FROM [CollarFiles] as C
			   INNER JOIN [LookupCollarFileFormats] as F
					   ON C.[Format] = F.[Code]
				    WHERE C.[FileId] = @FileId);
	RETURN @Result
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: March 2, 2012
-- Description:	Deletes a CollarFile from the database by first removing all dependent records
-- =============================================
CREATE PROCEDURE [dbo].[CollarFile_Delete] 
	@FileId int = -1
WITH EXECUTE AS OWNER -- Needed for dynamic sql
AS
BEGIN
	SET NOCOUNT ON;
	-- Get the projectId
	DECLARE @ProjectId NVARCHAR(255) = NULL
	SELECT @ProjectID = Project FROM [dbo].[CollarFiles] WHERE [FileId] = @FileId;

	IF @ProjectID IS NULL
	BEGIN
			DECLARE @message1 nvarchar(200) = 'Invalid Parameter: There is no FileId = '+@FileId+' in CollarFiles.';
			RAISERROR(@message1, 18, 0)
			RETURN (1)
	END
	
	-- Get the name of the caller
	DECLARE @Caller sysname = ORIGINAL_LOGIN();

	-- Validate permission for this operation
	-- The caller must be the PI or editor on the project
	-- Do not check the uploader. i.e. Do not allow someone who lost their privileges to remove a file. 
	IF NOT EXISTS (SELECT 1 FROM dbo.Projects WHERE ProjectId = @ProjectId AND ProjectInvestigator = @Caller)
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM dbo.ProjectEditors WHERE ProjectId = @ProjectId AND Editor = @Caller)
		BEGIN
			DECLARE @message2 nvarchar(200) = 'You ('+@Caller+') must be the principal investigator or editor on this project ('+@ProjectId+') to delete a file.';
			RAISERROR(@message2, 18, 0)
			RETURN (1)
		END
	END

	BEGIN TRY
		BEGIN TRAN
			DELETE L FROM dbo.Locations as L
			   INNER JOIN dbo.CollarFixes as C
					   ON C.FixID = L.FixId
					WHERE C.[FileId] = @FileId;

			DELETE FROM [dbo].[CollarFixes] WHERE [FileId] = @FileId;

			DECLARE @TableName sysname = [dbo].[GetCollarDataTableName](@FileId);
			DECLARE @sql NVARCHAR(500) = N'DELETE FROM ' + @TableName + '  WHERE FileId = @file';
			
			-- Execute dynamic SQL with parameters
			EXEC sp_ExecuteSQL @sql, N'@file int', @file = @FileId;
			
			DELETE FROM [dbo].[CollarFiles] WHERE [FileId] = @FileId;
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		IF XACT_STATE() <> 0
			ROLLBACK TRANSACTION;
		EXEC [dbo].[Utility_RethrowError]
		RETURN 1
	END CATCH
	
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: November 26, 2012
-- Description:	Returns a list of collar parameter file ids
--              that have a specific format and are potentially appropriate for a specified collar file
-- Example:     SELECT * FROM PotentialCollarParameterFilesForFormatAndCollarFile('A', 123)
-- =============================================
CREATE FUNCTION [dbo].[PotentialCollarParameterFilesForFormatAndCollarFile] 
(
	@Format CHAR(1), 
	@FileId INT
)
RETURNS TABLE 
AS
	RETURN
		SELECT PF.[FileId]
		FROM [dbo].[CollarParameterFiles] AS PF
		INNER JOIN [dbo].[Projects] AS P ON P.ProjectInvestigator = PF.Owner
		INNER JOIN [dbo].[CollarFiles] AS CF ON P.ProjectId = CF.Project
		WHERE CF.FileId = @fileId
		AND PF.Format = @Format
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ===============================================
-- Author:		Regan Sarwas
-- Create date: March 2, 2012
-- Description:	Updates the editable fields of a CollarFile
--              except Status.  Also see CollarFile_UpdateStatus
-- ===============================================
CREATE PROCEDURE [dbo].[CollarFile_Update] 
	@FileId INT  = NULL, 
	@FileName NVARCHAR(255) = NULL,
	@CollarId NVARCHAR(255) = NULL,
	@ParentFileId INT = NULL
AS
BEGIN
	SET NOCOUNT ON;
	
	-- Get some information about the file to update
	DECLARE @Status CHAR;
	DECLARE @CollarManufacturer NVARCHAR(255);
	DECLARE @OldFileName NVARCHAR(255);
	DECLARE @OldCollarId NVARCHAR(255);
	DECLARE @OldParentFileId INT;
	DECLARE @ProjectId NVARCHAR(255);
	 SELECT @Status = [Status],
		    @CollarManufacturer = [CollarManufacturer],
		    @OldFileName = [FileName],
		    @OldCollarId = [CollarId],
		    @OldParentFileId = [ParentFileId],
		    @ProjectId = [Project]
	   FROM [dbo].[CollarFiles]
	  WHERE [FileId] = @FileId;

	IF @ProjectId IS NULL
	BEGIN
		DECLARE @message2 nvarchar(100) = 'Invalid parameter: FileId ' + CAST(@FileId AS VARCHAR(10)) + ' was not found in the CollarFiles table';
		RAISERROR(@message2, 18, 0)
		RETURN 1
	END

	-- Get the name of the caller
	DECLARE @Caller sysname = ORIGINAL_LOGIN();

	-- Validate permission for this operation
	-- The caller must be the PI or editor on the project
	IF NOT EXISTS (SELECT 1 FROM dbo.Projects WHERE ProjectId = @ProjectId AND ProjectInvestigator = @Caller)
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM dbo.ProjectEditors WHERE ProjectId = @ProjectId AND Editor = @Caller)
		BEGIN
			DECLARE @message4 nvarchar(200) = 'You ('+@Caller+') must be the principal investigator or editor of the project ('+@ProjectId+') to update this file.';
			RAISERROR(@message4, 18, 0)
			RETURN 1
		END
	END
	
	-- Change the file name;  this should never fail.
	IF @FileName IS NOT NULL AND @FileName <> @OldFileName
	BEGIN
		BEGIN TRY
			UPDATE [dbo].[CollarFiles] SET [FileName] = @FileName WHERE [FileId] = @FileId; 
		END TRY
		BEGIN CATCH
			EXEC [dbo].[Utility_RethrowError]
			RETURN 1
		END CATCH
	END

	
	-- Can we update the CollarId?
	IF @CollarId IS NOT NULL AND @CollarId <> @OldCollarId AND @Status = 'A'
	BEGIN
		DECLARE @message1 nvarchar(100) = 'Unable to change the collar of an active file.  Change the status and try again.';
		RAISERROR(@message1, 18, 0)
		RETURN 1
	END
	
	-- If the collar was provided, make sure it is a valid collar
	IF @CollarId IS NOT NULL AND @CollarId <> @OldCollarId AND
	   NOT EXISTS (SELECT 1 FROM [dbo].[Collars] WHERE [CollarManufacturer] = @CollarManufacturer
												   AND [CollarId] = @CollarId)
	BEGIN
		DECLARE @message3 nvarchar(100) = 'Invalid parameter: CollarId (' + @CollarId + ') was not found in the Collars table';
		RAISERROR(@message3, 18, 0)
		RETURN 1
	END

	-- Update CollarId; This should never fail
	IF @CollarId IS NOT NULL AND @CollarId <> @OldCollarId
	BEGIN
		BEGIN TRY
			UPDATE [dbo].[CollarFiles] SET [CollarId] = @CollarId WHERE [FileId] = @FileId; 
		END TRY
		BEGIN CATCH
			EXEC [dbo].[Utility_RethrowError]
			RETURN 1
		END CATCH
	END
	
	-- If the ParentFileId was provided, make sure it is a valid FileId
	IF @ParentFileId IS NOT NULL AND
	   NOT EXISTS (SELECT 1 FROM [dbo].[CollarFiles] WHERE [FileId] = @ParentFileId)
	BEGIN
		DECLARE @message5 nvarchar(100) = 'Invalid parameter: ParentFileId ' + CAST(@ParentFileId AS VARCHAR(10)) + ' was not found in the CollarFiles table';
		RAISERROR(@message5, 18, 0)
		RETURN (1)
	END
	
	-- Update ParentFileId; This should never fail
	BEGIN
		BEGIN TRY
			UPDATE [dbo].[CollarFiles] SET [ParentFileId] = @ParentFileId WHERE [FileId] = @FileId; 
		END TRY
		BEGIN CATCH
			EXEC [dbo].[Utility_RethrowError]
			RETURN 1
		END CATCH
	END
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: March 27, 2012
-- Description:	Adds a new editor to a project
-- =============================================
CREATE PROCEDURE [dbo].[ProjectEditor_Insert] 
	@ProjectId nvarchar(255) = Null,
	@Editor sysname = Null
AS
BEGIN
	SET NOCOUNT ON;

	-- Get the name of the caller
	DECLARE @Caller sysname = ORIGINAL_LOGIN();
	
	--If editor is already an editor on the project, then there is nothing to do, so return
	IF EXISTS(SELECT 1 FROM [dbo].[ProjectEditors] WHERE ProjectId = @ProjectId AND Editor = @Editor)
	BEGIN
		RETURN 0
	END
	
	-- If the caller is not the PI for the project, then error and return
	IF NOT EXISTS (SELECT 1 FROM dbo.Projects WHERE ProjectId = @ProjectId AND ProjectInvestigator = @Caller)
	BEGIN
		DECLARE @message1 nvarchar(100) = 'You ('+@Caller+') are not the principal investigator for project (' + @ProjectId + ')';
		RAISERROR(@message1, 18, 0)
		RETURN 1
	END
	
	DECLARE @LoginCreated BIT = 0;
	DECLARE @UserCreated BIT = 0;
	DECLARE @RoleMemberAdded BIT = 0;
	
	BEGIN TRY
		-- If the Editor is not a database user then add them.
		IF NOT EXISTS (select 1 from sys.database_principals WHERE type = 'U' AND name = @Editor)
		BEGIN
			EXEC ('CREATE USER ['  + @Editor + ']') --  LOGIN defaults to the same name
			SET @UserCreated = 1
		END
			
		-- If the Editor user does not have the editor role, then add it.
		IF NOT EXISTS (SELECT 1 from sys.database_role_members as U 
					   INNER JOIN sys.database_principals AS P1  
					   ON U.member_principal_id = P1.principal_id
					   INNER JOIN sys.database_principals AS P2 
					   ON U.role_principal_id = p2.principal_id 
					   WHERE p1.name = @Editor AND p2.name = 'Editor' )
		BEGIN
			--EXEC ('ALTER ROLE Editor ADD MEMBER ['  + @Editor + ']')  --SQL2012 syntax
			EXEC sp_addrolemember 'Editor', @Editor
			SET @RoleMemberAdded = 1
		END
			
		-- Add them to the Project Editors table
		INSERT [dbo].[ProjectEditors] (ProjectId, Editor) VALUES (@ProjectId, @Editor)
	END TRY
	BEGIN CATCH
		-- Roleback operations
		IF @RoleMemberAdded = 1
		BEGIN
			EXEC sp_droprolemember 'Editor', @Editor
		END
		IF @UserCreated = 1
		BEGIN
			EXEC ('DROP USER ['  + @Editor + ']')
		END
		EXEC [dbo].[Utility_RethrowError]
		RETURN 1
	END CATCH
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: March 27, 2012
-- Description:	Removes an editor from a project
-- =============================================
CREATE PROCEDURE [dbo].[ProjectEditor_Delete] 
	@ProjectId nvarchar(255) = Null,
	@Editor sysname  = Null
AS
BEGIN
	SET NOCOUNT ON;

	-- Permissions only allow Investigators to execute this procedure
	-- The Invesitigator role has Alter Any User, and Alter Role 'Editor' permissions

	--If editor is not an editor on the project, then there is nothing to do, so return
	IF NOT EXISTS(SELECT 1 FROM [dbo].[ProjectEditors] WHERE ProjectId = @ProjectId AND Editor = @Editor)
	BEGIN
		RETURN
	END
		
	-- Get the name of the caller
	DECLARE @Caller sysname = ORIGINAL_LOGIN();
	
	-- If the caller is not the PI for the project, then error and return
	IF NOT EXISTS (SELECT 1 FROM dbo.Projects WHERE ProjectId = @ProjectId AND ProjectInvestigator = @Caller)
	BEGIN
		DECLARE @message1 nvarchar(100) = 'You ('+@Caller+') are not the principal investigator for project (' + @ProjectId + ')';
		RAISERROR(@message1, 18, 0)
		RETURN 1
	END

	-- This is the key step from the applications standpoint
	DELETE FROM [dbo].[ProjectEditors] WHERE ProjectId = @ProjectId AND Editor = @Editor
	
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: March 2, 2012
-- Description:	Deletes a project
-- =============================================
CREATE PROCEDURE [dbo].[Project_Delete] 
	@ProjectId NVARCHAR(255) = NULL 
AS
BEGIN
	SET NOCOUNT ON;

	-- Get the name of the caller
	DECLARE @Caller sysname = ORIGINAL_LOGIN();
	
	IF NOT EXISTS (SELECT 1 FROM [dbo].[Projects] WHERE [ProjectId] = @ProjectId)
	BEGIN
		DECLARE @message1 nvarchar(100) = 'Project (' + @ProjectId + ') is not an existing project.';
		RAISERROR(@message1, 18, 0)
		RETURN 1
	END
	
	-- You must be the ProjectInvestigator to delete the project
	IF NOT EXISTS (SELECT 1 FROM [dbo].[Projects] WHERE [ProjectId] = @ProjectId AND [ProjectInvestigator] = @Caller)
	BEGIN
		DECLARE @message2 nvarchar(100) = 'You are not the owner of the ' + @ProjectId + ' project.';
		RAISERROR(@message2, 18, 0)
		RETURN 1
	END

	DELETE FROM dbo.ProjectEditors WHERE [ProjectId] = @ProjectId
	DELETE FROM dbo.Projects WHERE [ProjectId] = @ProjectId
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: June 13, 2012
-- Description:	Test the CollarFixes UpdateTrigger
-- =============================================
CREATE PROCEDURE [dbo].[Test_Trigger_CollarFixes_Update] 
AS
BEGIN
	SET NOCOUNT ON

	PRINT 'Test_Trigger_CollarFixes_Update'
	
	DECLARE
			@sa nvarchar(16) = 'sa',
			@project nvarchar(16) = 'p1__',
			@animal nvarchar(16) = 'a1__',
			@mfgr nvarchar(16) = 'Telonics',
			@model nvarchar(16) = 'TelonicsGen4',
			@collar nvarchar(16) = 'c1__',
			@file nvarchar(16) = 'f1__',
			@format nvarchar(16) = 'A', -- Store on board format
			@test nvarchar(255) = null,
			@msg nvarchar(255) = null,
			@fileid int,
			@fix1 bigint,
			@fix2 bigint,
			@fix3 bigint,
			@fix4 bigint,
			@fix_l bigint
			
	-- This test must be run as SA, since others cannot operate on table directly
	-- This test the integrity of the tables underlying the Store Procedures available to users.
	-- Also SA can check user tables

	IF ORIGINAL_LOGIN() <> @sa
	BEGIN
		PRINT '  You must be the sa to run this test'
		RETURN 1
	END

/*
	-- Clean up mess if previous test failed; need to find and set the file id first
	SET @fileid = 140
	EXEC [dbo].[CollarFile_Delete] @fileid
	DELETE CollarDeployments Where [ProjectId] = @project 
	DELETE Collars where CollarManufacturer = @mfgr and CollarId = @collar
	Delete Animals where ProjectId = @project -- SP checks if user is in role, which sa is not
	EXEC [dbo].[Project_Delete] @project
	return 1
*/

	--Check to make sure we are not going to overwrite any data
	IF EXISTS (SELECT 1 from Projects Where [ProjectId] = @project)
    OR EXISTS (SELECT 1 from Collars Where [CollarManufacturer] = @mfgr AND [CollarId] = @collar)
	BEGIN
		PRINT '  Aborting tests.  Existing data conflicts with test data.'
		RETURN 1
	END
	
	-- Add the sa is a project investigator
	IF NOT EXISTS(SELECT 1 FROM [dbo].[ProjectInvestigators] WHERE [Login] = @sa)
	BEGIN
		INSERT [dbo].[ProjectInvestigators] ([Login],[Name],[Email],[Phone]) VALUES (@sa,@sa,@sa,@sa)
	END


	-- Setup for test
	EXEC [dbo].[Project_Insert] @project, @project, @sa
	EXEC [dbo].[Animal_Insert] @project, @animal
	EXEC [dbo].[Collar_Insert] @mfgr, @collar, @model ,@sa
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal, @mfgr, @collar, '2012-05-10 12:00'
	-- do not use the [dbo].[CollarFile_Insert] because it calls 
	-- [dbo].[CollarData_Insert] which tries to read the binary contents field to populate fixes
	-- EXEC [dbo].[CollarFile_Insert] @file, @project, @mfgr, @collar,'A','I',NULL,@fileid
	INSERT INTO dbo.CollarFiles ([FileName], [Project], [CollarManufacturer], [CollarId], [Format], [Status], [Contents])
		 VALUES (@file, @project, @mfgr, @collar, @format, 'A', convert(varbinary,'data'))  -- 'A' = Store on board
	SET @fileid = SCOPE_IDENTITY();

	-- Check initial conditions
	IF    NOT EXISTS (SELECT 1 from Animals Where [ProjectId] = @project AND [AnimalId] = @animal) 
       OR NOT EXISTS (SELECT 1 from Collars Where [CollarManufacturer] = @mfgr AND [CollarId] = @collar)
	   OR NOT EXISTS (SELECT 1 from CollarFiles Where [FileId] = @FileId)
	   OR NOT EXISTS (SELECT 1 from CollarDeployments Where [ProjectId] = @project)
	   OR     EXISTS (SELECT 1 from CollarFixes Where [FileId] = @fileid AND [CollarManufacturer] = @mfgr AND [CollarId] = @collar)
	   OR     EXISTS (SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal)
	   OR     EXISTS (SELECT 1 from Movements Where [ProjectId] = @project AND [AnimalId] = @animal)
	BEGIN
		PRINT '  Test data not initialized properly'
		RETURN 1
	END
	

	-- Do tests
	
	-- Test1
	-- Mortality is null and retrieval date is null
	SET @test = '  Test1: (3 hide 2): '
	--Action
	Delete from dbo.CollarDataTelonicsStoreOnBoard where FileId = @fileid
	INSERT INTO dbo.CollarDataTelonicsStoreOnBoard ([FileId], [LineNumber], [Date], [Latitude], [Longitude], [Fix Status])
		 VALUES (@fileid, 1, '2012-05-11', '60.1', '-154.1', 'Fix Available'),
		        (@fileid, 2, '2012-05-12', '60.2', '-154.2', 'Fix Available'),
		        (@fileid, 3, '2012-05-12', '60.3', '-154.3', 'Fix Available')
	EXEC [dbo].[CollarFixes_Insert] @fileid, @format
	
	SELECT @fix1 = FixId FROM CollarFixes Where [FileId] = @fileid AND [LineNumber] = 1
	SELECT @fix2 = FixId FROM CollarFixes Where [FileId] = @fileid AND [LineNumber] = 2
	SELECT @fix3 = FixId FROM CollarFixes Where [FileId] = @fileid AND [LineNumber] = 3

	--Test
	SET @msg = ''
	SELECT 1 from CollarFixes Where [FileId] = @fileid AND [CollarManufacturer] = @mfgr AND [CollarId] = @collar
	IF @@ROWCOUNT <> 3
		SET @msg = @msg + ' Not 3 fixes'
	SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @@ROWCOUNT <> 2
		SET @msg = @msg + ' Not 2 locations'
	SELECT 1 from Movements Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @@ROWCOUNT <> 1
		SET @msg = @msg + ' Not 1 movements'
		
	IF NOT EXISTS (SELECT 1 FROM CollarFixes where FixId = @fix2 AND HiddenBy = @fix3)
		SET @msg = @msg + ' fix 2 not hidden by fix 3'
	
	SELECT @fix_l = MIN([FixId]) FROM Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @fix1 <> @fix_l
		SET @msg = @msg + ' First location is based on wrong fix'
		
	SELECT @fix_l = MAX([FixId]) FROM Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @fix3 <> @fix_l
		SET @msg = @msg + ' Last location is based on wrong fix'
	
	IF @msg = ''
		SET @msg = 'Passed'
	ELSE
		SET @msg = 'Failed' + @msg
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	
	
	-- Test1a
	SET @test = '  Test1a: Unhide 2 (2 hide 3): '
	--Action
	EXEC [dbo].[CollarFixes_UpdateUnhideFix] @fix2
	--Test
	SET @msg = ''
	SELECT 1 from CollarFixes Where [FileId] = @fileid AND [CollarManufacturer] = @mfgr AND [CollarId] = @collar
	IF @@ROWCOUNT <> 3
		SET @msg = @msg + ' Not 3 fixes'
	SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @@ROWCOUNT <> 2
		SET @msg = @msg + ' Not 2 locations'
	SELECT 1 from Movements Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @@ROWCOUNT <> 1
		SET @msg = @msg + ' Not 1 movements'

	IF NOT EXISTS (SELECT 1 FROM CollarFixes where FixId = @fix3 AND HiddenBy = @fix2)
		SET @msg = @msg + ' fix 3 not hidden by fix 2'
	
	SELECT @fix_l = MIN([FixId]) FROM Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @fix1 <> @fix_l
		SET @msg = @msg + ' First location is based on wrong fix'

	SELECT @fix_l = MAX([FixId]) FROM Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @fix2 <> @fix_l
		SET @msg = @msg + ' Last location is based on wrong fix'
	
	IF @msg = ''
		SET @msg = 'Passed'
	ELSE
		SET @msg = 'Failed' + @msg
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	EXEC [dbo].[CollarFixes_Delete] @fileid
	
	
	
	
	
	
	-- Test2
	-- Mortality is null and retrieval date is null
	SET @test = '  Test2: (4 hide 3 hide 2): '
	--Action
	Delete from dbo.CollarDataTelonicsStoreOnBoard where FileId = @fileid
	INSERT INTO dbo.CollarDataTelonicsStoreOnBoard ([FileId], [LineNumber], [Date], [Latitude], [Longitude], [Fix Status])
		 VALUES (@fileid, 1, '2012-05-11', '60.1', '-154.1', 'Fix Available'),
		        (@fileid, 2, '2012-05-12', '60.2', '-154.2', 'Fix Available'),
		        (@fileid, 3, '2012-05-12', '60.3', '-154.3', 'Fix Available'),
		        (@fileid, 4, '2012-05-12', '60.4', '-154.4', 'Fix Available')
	EXEC [dbo].[CollarFixes_Insert] @fileid, @format
	
	SELECT @fix1 = FixId FROM CollarFixes Where [FileId] = @fileid AND [LineNumber] = 1
	SELECT @fix2 = FixId FROM CollarFixes Where [FileId] = @fileid AND [LineNumber] = 2
	SELECT @fix3 = FixId FROM CollarFixes Where [FileId] = @fileid AND [LineNumber] = 3
	SELECT @fix4 = FixId FROM CollarFixes Where [FileId] = @fileid AND [LineNumber] = 4

	--Test
	SET @msg = ''
	SELECT 1 from CollarFixes Where [FileId] = @fileid AND [CollarManufacturer] = @mfgr AND [CollarId] = @collar
	IF @@ROWCOUNT <> 4
		SET @msg = @msg + ' Not 4 fixes'
	SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @@ROWCOUNT <> 2
		SET @msg = @msg + ' Not 2 locations'
	SELECT 1 from Movements Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @@ROWCOUNT <> 1
		SET @msg = @msg + ' Not 1 movements'

	IF NOT EXISTS (SELECT 1 FROM CollarFixes where FixId = @fix2 AND HiddenBy = @fix3)
		SET @msg = @msg + ' fix 2 not hidden by fix 3'

	IF NOT EXISTS (SELECT 1 FROM CollarFixes where FixId = @fix3 AND HiddenBy = @fix4)
		SET @msg = @msg + ' fix 3 not hidden by fix 4'
	
	SELECT @fix_l = MIN([FixId]) FROM Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @fix1 <> @fix_l
		SET @msg = @msg + ' First location is based on wrong fix'
		
	SELECT @fix_l = MAX([FixId]) FROM Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @fix4 <> @fix_l
		SET @msg = @msg + ' Last location is based on wrong fix'
	
	IF @msg = ''
		SET @msg = 'Passed'
	ELSE
		SET @msg = 'Failed' + @msg
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	
	
	-- Test2a
	SET @test = '  Test2a: Unhide 2 (2 hide 4 hide 3): '
	--Action
	EXEC [dbo].[CollarFixes_UpdateUnhideFix] @fix2
	--Test
	SET @msg = ''
	SELECT 1 from CollarFixes Where [FileId] = @fileid AND [CollarManufacturer] = @mfgr AND [CollarId] = @collar
	IF @@ROWCOUNT <> 4
		SET @msg = @msg + ' Not 4 fixes'
	SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @@ROWCOUNT <> 2
		SET @msg = @msg + ' Not 2 locations'
	SELECT 1 from Movements Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @@ROWCOUNT <> 1
		SET @msg = @msg + ' Not 1 movements'

	IF NOT EXISTS (SELECT 1 FROM CollarFixes where FixId = @fix4 AND HiddenBy = @fix2)
		SET @msg = @msg + ' fix 4 not hidden by fix 2'
	
	IF NOT EXISTS (SELECT 1 FROM CollarFixes where FixId = @fix3 AND HiddenBy = @fix4)
		SET @msg = @msg + ' fix 3 not hidden by fix 4'
	
	SELECT @fix_l = MIN([FixId]) FROM Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @fix1 <> @fix_l
		SET @msg = @msg + ' First location is based on wrong fix'

	SELECT @fix_l = MAX([FixId]) FROM Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @fix2 <> @fix_l
		SET @msg = @msg + ' Last location is based on wrong fix'
	
	IF @msg = ''
		SET @msg = 'Passed'
	ELSE
		SET @msg = 'Failed' + @msg
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	
	
	-- Test2b
	SET @test = '  Test2b: Unhide 4 (4 hide 3 hide 2): '
	--Action
	EXEC [dbo].[CollarFixes_UpdateUnhideFix] @fix4
	--Test
	SET @msg = ''
	SELECT 1 from CollarFixes Where [FileId] = @fileid AND [CollarManufacturer] = @mfgr AND [CollarId] = @collar
	IF @@ROWCOUNT <> 4
		SET @msg = @msg + ' Not 4 fixes'
	SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @@ROWCOUNT <> 2
		SET @msg = @msg + ' Not 2 locations'
	SELECT 1 from Movements Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @@ROWCOUNT <> 1
		SET @msg = @msg + ' Not 1 movements'

	IF NOT EXISTS (SELECT 1 FROM CollarFixes where FixId = @fix2 AND HiddenBy = @fix3)
		SET @msg = @msg + ' fix 2 not hidden by fix 3'

	IF NOT EXISTS (SELECT 1 FROM CollarFixes where FixId = @fix3 AND HiddenBy = @fix4)
		SET @msg = @msg + ' fix 3 not hidden by fix 4'
		
	SELECT @fix_l = MIN([FixId]) FROM Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @fix1 <> @fix_l
		SET @msg = @msg + ' First location is based on wrong fix'

	SELECT @fix_l = MAX([FixId]) FROM Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @fix4 <> @fix_l
		SET @msg = @msg + ' Last location is based on wrong fix'
	
	IF @msg = ''
		SET @msg = 'Passed'
	ELSE
		SET @msg = 'Failed' + @msg
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	EXEC [dbo].[CollarFixes_Delete] @fileid
	
	
	
	
	
	
	-- Test3
	-- Mortality is not null (after hidden)  and retrieval date is null
	SET @test = '  Test3: Mort after hidden (4 hide 3 hide 2): '
	--Action
	EXEC [dbo].[Animal_Update] @project, @animal, null, null, '2012-05-12 12:00'
	Delete from dbo.CollarDataTelonicsStoreOnBoard where FileId = @fileid
	INSERT INTO dbo.CollarDataTelonicsStoreOnBoard ([FileId], [LineNumber], [Date], [Latitude], [Longitude], [Fix Status])
		 VALUES (@fileid, 1, '2012-05-11', '60.1', '-154.1', 'Fix Available'),
		        (@fileid, 2, '2012-05-12', '60.2', '-154.2', 'Fix Available'),
		        (@fileid, 3, '2012-05-12', '60.3', '-154.3', 'Fix Available'),
		        (@fileid, 4, '2012-05-12', '60.4', '-154.4', 'Fix Available'),
		        (@fileid, 5, '2012-05-13', '60.5', '-154.5', 'Fix Available')
	EXEC [dbo].[CollarFixes_Insert] @fileid, @format
	
	SELECT @fix1 = FixId FROM CollarFixes Where [FileId] = @fileid AND [LineNumber] = 1
	SELECT @fix2 = FixId FROM CollarFixes Where [FileId] = @fileid AND [LineNumber] = 2
	SELECT @fix3 = FixId FROM CollarFixes Where [FileId] = @fileid AND [LineNumber] = 3
	SELECT @fix4 = FixId FROM CollarFixes Where [FileId] = @fileid AND [LineNumber] = 4

	--Test
	SET @msg = ''
	SELECT 1 from CollarFixes Where [FileId] = @fileid AND [CollarManufacturer] = @mfgr AND [CollarId] = @collar
	IF @@ROWCOUNT <> 5
		SET @msg = @msg + ' Not 5 fixes'
	SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @@ROWCOUNT <> 2
		SET @msg = @msg + ' Not 2 locations'
	SELECT 1 from Movements Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @@ROWCOUNT <> 1
		SET @msg = @msg + ' Not 1 movements'

	IF NOT EXISTS (SELECT 1 FROM CollarFixes where FixId = @fix2 AND HiddenBy = @fix3)
		SET @msg = @msg + ' fix 2 not hidden by fix 3'

	IF NOT EXISTS (SELECT 1 FROM CollarFixes where FixId = @fix3 AND HiddenBy = @fix4)
		SET @msg = @msg + ' fix 3 not hidden by fix 4'

	SELECT @fix_l = MIN([FixId]) FROM Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @fix1 <> @fix_l
		SET @msg = @msg + ' First location is based on wrong fix'
		
	SELECT @fix_l = MAX([FixId]) FROM Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @fix4 <> @fix_l
		SET @msg = @msg + ' Last location is based on wrong fix'
	
	IF @msg = ''
		SET @msg = 'Passed'
	ELSE
		SET @msg = 'Failed' + @msg
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	
	
	-- Test3a
	SET @test = '  Test3a: Mort after hidden; Unhide 2 (2 hide 4 hide 3): '
	--Action
	EXEC [dbo].[CollarFixes_UpdateUnhideFix] @fix2
	--Test
	SET @msg = ''
	SELECT 1 from CollarFixes Where [FileId] = @fileid AND [CollarManufacturer] = @mfgr AND [CollarId] = @collar
	IF @@ROWCOUNT <> 5
		SET @msg = @msg + ' Not 5 fixes'
	SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @@ROWCOUNT <> 2
		SET @msg = @msg + ' Not 2 locations'
	SELECT 1 from Movements Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @@ROWCOUNT <> 1
		SET @msg = @msg + ' Not 1 movements'

	IF NOT EXISTS (SELECT 1 FROM CollarFixes where FixId = @fix4 AND HiddenBy = @fix2)
		SET @msg = @msg + ' fix 4 not hidden by fix 2'
	
	IF NOT EXISTS (SELECT 1 FROM CollarFixes where FixId = @fix3 AND HiddenBy = @fix4)
		SET @msg = @msg + ' fix 3 not hidden by fix 4'
	
	SELECT @fix_l = MIN([FixId]) FROM Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @fix1 <> @fix_l
		SET @msg = @msg + ' First location is based on wrong fix'

	SELECT @fix_l = MAX([FixId]) FROM Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @fix2 <> @fix_l
		SET @msg = @msg + ' Last location is based on wrong fix'
	
	IF @msg = ''
		SET @msg = 'Passed'
	ELSE
		SET @msg = 'Failed' + @msg
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	EXEC [dbo].[CollarFixes_Delete] @fileid






	-- Test4
	-- Mortality is not null and retrieval date is null
	SET @test = '  Test4: Mort before hidden (4 hide 3 hide 2): '
	--Action
	EXEC [dbo].[Animal_Update] @project, @animal, null, null, '2012-05-11 12:00'
	Delete from dbo.CollarDataTelonicsStoreOnBoard where FileId = @fileid
	INSERT INTO dbo.CollarDataTelonicsStoreOnBoard ([FileId], [LineNumber], [Date], [Latitude], [Longitude], [Fix Status])
		 VALUES (@fileid, 1, '2012-05-11', '60.1', '-154.1', 'Fix Available'),
		        (@fileid, 2, '2012-05-12', '60.2', '-154.2', 'Fix Available'),
		        (@fileid, 3, '2012-05-12', '60.3', '-154.3', 'Fix Available'),
		        (@fileid, 4, '2012-05-12', '60.4', '-154.4', 'Fix Available'),
		        (@fileid, 5, '2012-05-13', '60.5', '-154.5', 'Fix Available')
	EXEC [dbo].[CollarFixes_Insert] @fileid, @format
	
	SELECT @fix1 = FixId FROM CollarFixes Where [FileId] = @fileid AND [LineNumber] = 1
	SELECT @fix2 = FixId FROM CollarFixes Where [FileId] = @fileid AND [LineNumber] = 2
	SELECT @fix3 = FixId FROM CollarFixes Where [FileId] = @fileid AND [LineNumber] = 3
	SELECT @fix4 = FixId FROM CollarFixes Where [FileId] = @fileid AND [LineNumber] = 4

	--Test
	SET @msg = ''
	SELECT 1 from CollarFixes Where [FileId] = @fileid AND [CollarManufacturer] = @mfgr AND [CollarId] = @collar
	IF @@ROWCOUNT <> 5
		SET @msg = @msg + ' Not 5 fixes'
	SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @@ROWCOUNT <> 1
		SET @msg = @msg + ' Not 1 locations'
	SELECT 1 from Movements Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @@ROWCOUNT <> 0
		SET @msg = @msg + ' Not 0 movements'

	IF NOT EXISTS (SELECT 1 FROM CollarFixes where FixId = @fix2 AND HiddenBy = @fix3)
		SET @msg = @msg + ' fix 2 not hidden by fix 3'

	IF NOT EXISTS (SELECT 1 FROM CollarFixes where FixId = @fix3 AND HiddenBy = @fix4)
		SET @msg = @msg + ' fix 3 not hidden by fix 4'
	
	SELECT @fix_l = MIN([FixId]) FROM Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @fix1 <> @fix_l
		SET @msg = @msg + ' First location is based on wrong fix'
		
	SELECT @fix_l = MAX([FixId]) FROM Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @fix1 <> @fix_l
		SET @msg = @msg + ' Last location is based on wrong fix'
	
	IF @msg = ''
		SET @msg = 'Passed'
	ELSE
		SET @msg = 'Failed' + @msg
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	
	
	-- Test4a
	SET @test = '  Test4a: Mort before hidden; Unhide 2 (2 hide 4 hide 3): '
	--Action
	EXEC [dbo].[CollarFixes_UpdateUnhideFix] @fix2
	--Test
	SET @msg = ''
	SELECT 1 from CollarFixes Where [FileId] = @fileid AND [CollarManufacturer] = @mfgr AND [CollarId] = @collar
	IF @@ROWCOUNT <> 5
		SET @msg = @msg + ' Not 5 fixes'
	SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @@ROWCOUNT <> 1
		SET @msg = @msg + ' Not 1 locations'
	SELECT 1 from Movements Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @@ROWCOUNT <> 0
		SET @msg = @msg + ' Not 0 movements'

	IF NOT EXISTS (SELECT 1 FROM CollarFixes where FixId = @fix4 AND HiddenBy = @fix2)
		SET @msg = @msg + ' fix 4 not hidden by fix 2'
	
	IF NOT EXISTS (SELECT 1 FROM CollarFixes where FixId = @fix3 AND HiddenBy = @fix4)
		SET @msg = @msg + ' fix 3 not hidden by fix 4'
	
	SELECT @fix_l = MIN([FixId]) FROM Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @fix1 <> @fix_l
		SET @msg = @msg + ' First location is based on wrong fix'

	SELECT @fix_l = MAX([FixId]) FROM Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @fix1 <> @fix_l
		SET @msg = @msg + ' Last location is based on wrong fix'
	
	IF @msg = ''
		SET @msg = 'Passed'
	ELSE
		SET @msg = 'Failed' + @msg
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	EXEC [dbo].[CollarFixes_Delete] @fileid
	EXEC [dbo].[Animal_Update] @project, @animal, null, null, null
	
	
	
	
	
	
	-- Test5
	-- Mortality is null and retrieval date is not null (after hidden)
	SET @test = '  Test5: Retrieve after hidden (4 hide 3 hide 2): '
	--Action
	EXEC [dbo].[CollarDeployment_UpdateRetrievalDate] @project, @animal, @mfgr, @collar, '2012-05-10 12:00', '2012-05-12 12:00'
	Delete from dbo.CollarDataTelonicsStoreOnBoard where FileId = @fileid
	INSERT INTO dbo.CollarDataTelonicsStoreOnBoard ([FileId], [LineNumber], [Date], [Latitude], [Longitude], [Fix Status])
		 VALUES (@fileid, 1, '2012-05-11', '60.1', '-154.1', 'Fix Available'),
		        (@fileid, 2, '2012-05-12', '60.2', '-154.2', 'Fix Available'),
		        (@fileid, 3, '2012-05-12', '60.3', '-154.3', 'Fix Available'),
		        (@fileid, 4, '2012-05-12', '60.4', '-154.4', 'Fix Available'),
		        (@fileid, 5, '2012-05-13', '60.5', '-154.5', 'Fix Available')
	EXEC [dbo].[CollarFixes_Insert] @fileid, @format
	
	SELECT @fix1 = FixId FROM CollarFixes Where [FileId] = @fileid AND [LineNumber] = 1
	SELECT @fix2 = FixId FROM CollarFixes Where [FileId] = @fileid AND [LineNumber] = 2
	SELECT @fix3 = FixId FROM CollarFixes Where [FileId] = @fileid AND [LineNumber] = 3
	SELECT @fix4 = FixId FROM CollarFixes Where [FileId] = @fileid AND [LineNumber] = 4

	--Test
	SET @msg = ''
	SELECT 1 from CollarFixes Where [FileId] = @fileid AND [CollarManufacturer] = @mfgr AND [CollarId] = @collar
	IF @@ROWCOUNT <> 5
		SET @msg = @msg + ' Not 5 fixes'
	SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @@ROWCOUNT <> 2
		SET @msg = @msg + ' Not 2 locations'
	SELECT 1 from Movements Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @@ROWCOUNT <> 1
		SET @msg = @msg + ' Not 1 movements'

	IF NOT EXISTS (SELECT 1 FROM CollarFixes where FixId = @fix2 AND HiddenBy = @fix3)
		SET @msg = @msg + ' fix 2 not hidden by fix 3'

	IF NOT EXISTS (SELECT 1 FROM CollarFixes where FixId = @fix3 AND HiddenBy = @fix4)
		SET @msg = @msg + ' fix 3 not hidden by fix 4'

	SELECT @fix_l = MIN([FixId]) FROM Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @fix1 <> @fix_l
		SET @msg = @msg + ' First location is based on wrong fix'
		
	SELECT @fix_l = MAX([FixId]) FROM Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @fix4 <> @fix_l
		SET @msg = @msg + ' Last location is based on wrong fix'
	
	IF @msg = ''
		SET @msg = 'Passed'
	ELSE
		SET @msg = 'Failed' + @msg
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	
	
	-- Test5a
	SET @test = '  Test5a: Retrieve after hidden; Unhide 2 (2 hide 4 hide 3): '
	--Action
	EXEC [dbo].[CollarFixes_UpdateUnhideFix] @fix2
	--Test
	SET @msg = ''
	SELECT 1 from CollarFixes Where [FileId] = @fileid AND [CollarManufacturer] = @mfgr AND [CollarId] = @collar
	IF @@ROWCOUNT <> 5
		SET @msg = @msg + ' Not 5 fixes'
	SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @@ROWCOUNT <> 2
		SET @msg = @msg + ' Not 2 locations'
	SELECT 1 from Movements Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @@ROWCOUNT <> 1
		SET @msg = @msg + ' Not 1 movements'

	IF NOT EXISTS (SELECT 1 FROM CollarFixes where FixId = @fix4 AND HiddenBy = @fix2)
		SET @msg = @msg + ' fix 4 not hidden by fix 2'
	
	IF NOT EXISTS (SELECT 1 FROM CollarFixes where FixId = @fix3 AND HiddenBy = @fix4)
		SET @msg = @msg + ' fix 3 not hidden by fix 4'
	
	SELECT @fix_l = MIN([FixId]) FROM Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @fix1 <> @fix_l
		SET @msg = @msg + ' First location is based on wrong fix'

	SELECT @fix_l = MAX([FixId]) FROM Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @fix2 <> @fix_l
		SET @msg = @msg + ' Last location is based on wrong fix'
	
	IF @msg = ''
		SET @msg = 'Passed'
	ELSE
		SET @msg = 'Failed' + @msg
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	EXEC [dbo].[CollarFixes_Delete] @fileid






	-- Test6
	-- Mortality is null and retrieval date is not null (before hidden)
	SET @test = '  Test6: Retrieve before hidden (4 hide 3 hide 2): '
	--Action
	EXEC [dbo].[CollarDeployment_UpdateRetrievalDate] @project, @animal, @mfgr, @collar, '2012-05-10 12:00', '2012-05-11 12:00'
	Delete from dbo.CollarDataTelonicsStoreOnBoard where FileId = @fileid
	INSERT INTO dbo.CollarDataTelonicsStoreOnBoard ([FileId], [LineNumber], [Date], [Latitude], [Longitude], [Fix Status])
		 VALUES (@fileid, 1, '2012-05-11', '60.1', '-154.1', 'Fix Available'),
		        (@fileid, 2, '2012-05-12', '60.2', '-154.2', 'Fix Available'),
		        (@fileid, 3, '2012-05-12', '60.3', '-154.3', 'Fix Available'),
		        (@fileid, 4, '2012-05-12', '60.4', '-154.4', 'Fix Available'),
		        (@fileid, 5, '2012-05-13', '60.5', '-154.5', 'Fix Available')
	EXEC [dbo].[CollarFixes_Insert] @fileid, @format
	
	SELECT @fix1 = FixId FROM CollarFixes Where [FileId] = @fileid AND [LineNumber] = 1
	SELECT @fix2 = FixId FROM CollarFixes Where [FileId] = @fileid AND [LineNumber] = 2
	SELECT @fix3 = FixId FROM CollarFixes Where [FileId] = @fileid AND [LineNumber] = 3
	SELECT @fix4 = FixId FROM CollarFixes Where [FileId] = @fileid AND [LineNumber] = 4

	--Test
	SET @msg = ''
	SELECT 1 from CollarFixes Where [FileId] = @fileid AND [CollarManufacturer] = @mfgr AND [CollarId] = @collar
	IF @@ROWCOUNT <> 5
		SET @msg = @msg + ' Not 5 fixes'
	SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @@ROWCOUNT <> 1
		SET @msg = @msg + ' Not 1 locations'
	SELECT 1 from Movements Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @@ROWCOUNT <> 0
		SET @msg = @msg + ' Not 0 movements'

	IF NOT EXISTS (SELECT 1 FROM CollarFixes where FixId = @fix2 AND HiddenBy = @fix3)
		SET @msg = @msg + ' fix 2 not hidden by fix 3'

	IF NOT EXISTS (SELECT 1 FROM CollarFixes where FixId = @fix3 AND HiddenBy = @fix4)
		SET @msg = @msg + ' fix 3 not hidden by fix 4'
	
	SELECT @fix_l = MIN([FixId]) FROM Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @fix1 <> @fix_l
		SET @msg = @msg + ' First location is based on wrong fix'
		
	SELECT @fix_l = MAX([FixId]) FROM Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @fix1 <> @fix_l
		SET @msg = @msg + ' Last location is based on wrong fix'
	
	IF @msg = ''
		SET @msg = 'Passed'
	ELSE
		SET @msg = 'Failed' + @msg
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	
	
	-- Test6a
	SET @test = '  Test6a: Retrieve before hidden; Unhide 2 (2 hide 4 hide 3): '
	--Action
	EXEC [dbo].[CollarFixes_UpdateUnhideFix] @fix2
	--Test
	SET @msg = ''
	SELECT 1 from CollarFixes Where [FileId] = @fileid AND [CollarManufacturer] = @mfgr AND [CollarId] = @collar
	IF @@ROWCOUNT <> 5
		SET @msg = @msg + ' Not 5 fixes'
	SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @@ROWCOUNT <> 1
		SET @msg = @msg + ' Not 1 locations'
	SELECT 1 from Movements Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @@ROWCOUNT <> 0
		SET @msg = @msg + ' Not 0 movements'

	IF NOT EXISTS (SELECT 1 FROM CollarFixes where FixId = @fix4 AND HiddenBy = @fix2)
		SET @msg = @msg + ' fix 4 not hidden by fix 2'
	
	IF NOT EXISTS (SELECT 1 FROM CollarFixes where FixId = @fix3 AND HiddenBy = @fix4)
		SET @msg = @msg + ' fix 3 not hidden by fix 4'
	
	SELECT @fix_l = MIN([FixId]) FROM Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @fix1 <> @fix_l
		SET @msg = @msg + ' First location is based on wrong fix'

	SELECT @fix_l = MAX([FixId]) FROM Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @fix1 <> @fix_l
		SET @msg = @msg + ' Last location is based on wrong fix'
	
	IF @msg = ''
		SET @msg = 'Passed'
	ELSE
		SET @msg = 'Failed' + @msg
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	EXEC [dbo].[CollarFixes_Delete] @fileid
	EXEC [dbo].[CollarDeployment_UpdateRetrievalDate] @project, @animal, @mfgr, @collar, '2012-05-10 12:00', null



		
	-- Clean up
	PRINT '  Cleaning up'
	EXEC [dbo].[CollarFile_Delete] @fileid
	DELETE CollarDeployments Where [ProjectId] = @project 
	EXEC [dbo].[Collar_Delete] @mfgr, @collar
	Delete Animals where ProjectId = @project -- SP checks if user is in role, which sa is not
	EXEC [dbo].[Project_Delete] @project

	-- Check that cleanup worked
	IF    EXISTS (SELECT 1 from Animals Where [ProjectId] = @project AND [AnimalId] = @animal) 
       OR EXISTS (SELECT 1 from Projects Where [ProjectId] = @project)
       OR EXISTS (SELECT 1 from Collars Where [CollarManufacturer] = @mfgr AND [CollarId] = @collar)
	   OR EXISTS (SELECT 1 from CollarDeployments Where [ProjectId] = @project)
	   OR EXISTS (SELECT 1 from CollarFiles Where [FileId] = @fileid)
	   OR EXISTS (SELECT 1 from CollarDataTelonicsStoreOnBoard Where [FileId] = @fileid)
	   OR EXISTS (SELECT 1 from CollarFixes Where [FileId] = @fileid AND [CollarManufacturer] = @mfgr AND [CollarId] = @collar)
	   OR EXISTS (SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal)
	   OR EXISTS (SELECT 1 from Movements Where [ProjectId] = @project AND [AnimalId] = @animal)
	BEGIN
		PRINT 'Test data not completely removed'
		RETURN 1
	END

	-- Remove the sa from project investigator
	DELETE [dbo].[ProjectInvestigators] WHERE  [Login] = @sa
	
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: June 13, 2012
-- Description:	Test the CollarFixes InsertTrigger
-- =============================================
CREATE PROCEDURE [dbo].[Test_Trigger_CollarFixes_Insert] 
AS
BEGIN
	SET NOCOUNT ON

	PRINT 'Test_Trigger_CollarFixes_Insert'
	
	DECLARE
			@sa nvarchar(16) = 'sa',
			@project nvarchar(16) = 'p1__',
			@animal nvarchar(16) = 'a1__',
			@mfgr nvarchar(16) = 'Telonics',
			@model nvarchar(16) = 'TelonicsGen4',
			@collar nvarchar(16) = 'c1__',
			@file nvarchar(16) = 'f1__',
			@format nvarchar(16) = 'A', -- Store on board format
			@test nvarchar(255) = null,
			@msg nvarchar(255) = null,
			@fileid int,
			@date datetime2,
			@fix1 bigint,
			@fix2 bigint
			
	-- This test must be run as SA, since others cannot operate on table directly
	-- This test the integrity of the tables underlying the Store Procedures available to users.
	-- Also SA can check user tables

	IF ORIGINAL_LOGIN() <> @sa
	BEGIN
		PRINT '  You must be the sa to run this test'
		RETURN 1
	END

/*
	-- Clean up mess if previous test failed; need to find and set the file id first
	SET @fileid = 133
	EXEC [dbo].[CollarFile_Delete] @fileid
	DELETE CollarDeployments Where [ProjectId] = @project 
	DELETE Collars where CollarManufacturer = @mfgr and CollarId = @collar
	Delete Animals where ProjectId = @project -- SP checks if user is in role, which sa is not
	EXEC [dbo].[Project_Delete] @project
	return 1
*/

	--Check to make sure we are not going to overwrite any data
	IF EXISTS (SELECT 1 from Projects Where [ProjectId] = @project)
    OR EXISTS (SELECT 1 from Collars Where [CollarManufacturer] = @mfgr AND [CollarId] = @collar)
	BEGIN
		PRINT '  Aborting tests.  Existing data conflicts with test data.'
		RETURN 1
	END
	
	-- Add the sa is a project investigator
	IF NOT EXISTS(SELECT 1 FROM [dbo].[ProjectInvestigators] WHERE [Login] = @sa)
	BEGIN
		INSERT [dbo].[ProjectInvestigators] ([Login],[Name],[Email],[Phone]) VALUES (@sa,@sa,@sa,@sa)
	END


	-- Setup for test
	EXEC [dbo].[Project_Insert] @project, @project, @sa
	EXEC [dbo].[Animal_Insert] @project, @animal
	EXEC [dbo].[Collar_Insert] @mfgr, @collar, @model ,@sa
	-- do not use the [dbo].[CollarFile_Insert] because it calls 
	-- [dbo].[CollarData_Insert] which tries to read the binary contents field to populate fixes
	-- EXEC [dbo].[CollarFile_Insert] @file, @project, @mfgr, @collar,'A','I',NULL,@fileid
	INSERT INTO dbo.CollarFiles ([FileName], [Project], [CollarManufacturer], [CollarId], [Format], [Status], [Contents])
		 VALUES (@file, @project, @mfgr, @collar, @format, 'A', convert(varbinary,'data'))  -- 'A' = Store on board
	SET @fileid = SCOPE_IDENTITY();
	-- Load multiple Fixes Manually into the collar data table
	INSERT INTO dbo.CollarDataTelonicsStoreOnBoard ([FileId], [LineNumber], [Date], [Latitude], [Longitude], [Fix Status])
		 VALUES (@fileid, 1, '2012-05-11', '60.1', '-154.1', 'Fix Available'),
		        (@fileid, 2, '2012-05-12', '60.2', '-154.2', 'Fix Available'),
		        (@fileid, 3, '2012-05-13', '60.3', '-154.3', 'Fix Available'),
		        (@fileid, 4, '2012-05-14', '60.4', '-154.4', 'Fix Available'),
		        (@fileid, 5, '2012-05-15', '60.5', '-154.5', 'Fix Available'),
		        (@fileid, 6, '2012-05-16', '60.6', '-154.6', 'Fix Available');

	-- Check initial conditions
	IF    NOT EXISTS (SELECT 1 from Animals Where [ProjectId] = @project AND [AnimalId] = @animal) 
       OR NOT EXISTS (SELECT 1 from Collars Where [CollarManufacturer] = @mfgr AND [CollarId] = @collar)
	   OR NOT EXISTS (SELECT 1 from CollarFiles Where [FileId] = @FileId)
	   OR NOT EXISTS (SELECT 1 from CollarDataTelonicsStoreOnBoard Where [FileId] = @fileid)
	   OR     EXISTS (SELECT 1 from CollarFixes Where [FileId] = @fileid AND [CollarManufacturer] = @mfgr AND [CollarId] = @collar)
	   OR     EXISTS (SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal)
	   OR     EXISTS (SELECT 1 from Movements Where [ProjectId] = @project AND [AnimalId] = @animal)
	BEGIN
		PRINT '  Test data not initialized properly'
		RETURN 1
	END
	

	-- Do tests
		
	-- Test1
	SET @test = '  Test1: Add Fixes, no deployment: '
	--Action
	EXEC [dbo].[CollarFixes_Insert] @fileid, @format
	--Test
	SET @msg = ''
	SELECT 1 from CollarFixes Where [FileId] = @fileid AND [CollarManufacturer] = @mfgr AND [CollarId] = @collar
	IF @@ROWCOUNT <> 6
		SET @msg = @msg + ' Not 6 fixes'
	SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @@ROWCOUNT <> 0
		SET @msg = @msg + ' Not 0 locations'
	SELECT 1 from Movements Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @@ROWCOUNT <> 0
		SET @msg = @msg + ' Not 0 movements'
	IF @msg = ''
		SET @msg = 'Passed'
	ELSE
		SET @msg = 'Failed' + @msg
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	EXEC [dbo].[CollarFixes_Delete] @fileid
	
	-- Test2
	SET @test = '  Test2: 6 Fixes, Deployment starts after first fix: '
	--Action
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal, @mfgr, @collar, '2012-05-11 12:00'
	EXEC [dbo].[CollarFixes_Insert] @fileid, @format
	--Test
	SET @msg = ''
	SELECT 1 from CollarFixes Where [FileId] = @fileid AND [CollarManufacturer] = @mfgr AND [CollarId] = @collar
	IF @@ROWCOUNT <> 6
		SET @msg = @msg + ' Not 6 fixes'
	SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @@ROWCOUNT <> 5
		SET @msg = @msg + ' Not 5 locations'
	SELECT 1 from Movements Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @@ROWCOUNT <> 4
		SET @msg = @msg + ' Not 4 movements'
	SELECT @date = MIN([FixDate]) FROM Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @date <> '2012-05-12'
		SET @msg = @msg + ' First location has wrong date'
	SELECT @date = MAX([FixDate]) FROM Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @date <> '2012-05-16'
		SET @msg = @msg + ' Last location has wrong date'
	IF @msg = ''
		SET @msg = 'Passed'
	ELSE
		SET @msg = 'Failed' + @msg
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal, @mfgr, @collar, '2012-05-11 12:00'
	EXEC [dbo].[CollarFixes_Delete] @fileid
	
	
	-- Test3
	SET @test = '  Test3: 6 Fixes, Deployment starts after first fix end before last fix: '
	--Action
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal, @mfgr, @collar, '2012-05-11 12:00', '2012-05-15 12:00'
	EXEC [dbo].[CollarFixes_Insert] @fileid, @format
	--Test
	SET @msg = ''
	SELECT 1 from CollarFixes Where [FileId] = @fileid AND [CollarManufacturer] = @mfgr AND [CollarId] = @collar
	IF @@ROWCOUNT <> 6
		SET @msg = @msg + ' Not 6 fixes'
	SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @@ROWCOUNT <> 4
		SET @msg = @msg + ' Not 4 locations'
	SELECT 1 from Movements Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @@ROWCOUNT <> 3
		SET @msg = @msg + ' Not 3 movements'
	SELECT @date = MIN([FixDate]) FROM Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @date <> '2012-05-12'
		SET @msg = @msg + ' First location has wrong date'
	SELECT @date = MAX([FixDate]) FROM Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @date <> '2012-05-15'
		SET @msg = @msg + ' Last location has wrong date'
	IF @msg = ''
		SET @msg = 'Passed'
	ELSE
		SET @msg = 'Failed' + @msg
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal, @mfgr, @collar, '2012-05-11 12:00'
	EXEC [dbo].[CollarFixes_Delete] @fileid
	
	
	-- Test4
	SET @test = '  Test4: 6 Fixes, Deployment after last fix: '
	--Action
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal, @mfgr, @collar, '2012-05-20 12:00', '2012-05-25 12:00'
	EXEC [dbo].[CollarFixes_Insert] @fileid, @format
	--Test
	SET @msg = ''
	SELECT 1 from CollarFixes Where [FileId] = @fileid AND [CollarManufacturer] = @mfgr AND [CollarId] = @collar
	IF @@ROWCOUNT <> 6
		SET @msg = @msg + ' Not 6 fixes'
	SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @@ROWCOUNT <> 0
		SET @msg = @msg + ' Not 0 locations'
	SELECT 1 from Movements Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @@ROWCOUNT <> 0
		SET @msg = @msg + ' Not 0 movements'
	IF @msg = ''
		SET @msg = 'Passed'
	ELSE
		SET @msg = 'Failed' + @msg
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal, @mfgr, @collar, '2012-05-20 12:00'
	EXEC [dbo].[CollarFixes_Delete] @fileid
	
	
	-- Test5
	SET @test = '  Test5: 2 Deployment before and after middle fixes: '
	--Action
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal, @mfgr, @collar, '2012-05-05 12:00', '2012-05-12 12:00'
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal, @mfgr, @collar, '2012-05-14 12:00', '2012-05-25 12:00'
	EXEC [dbo].[CollarFixes_Insert] @fileid, @format
	--Test
	SET @msg = ''
	SELECT 1 from CollarFixes Where [FileId] = @fileid AND [CollarManufacturer] = @mfgr AND [CollarId] = @collar
	IF @@ROWCOUNT <> 6
		SET @msg = @msg + ' Not 6 fixes'
	SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @@ROWCOUNT <> 4
		SET @msg = @msg + ' Not 4 locations'
	SELECT 1 from Movements Where [ProjectId] = @project AND [AnimalId] = @animal
	-- TODO, debateable whether there should be 2 or 3 movements.  With 3 the deployments are linked
	IF @@ROWCOUNT <> 3
		SET @msg = @msg + ' Not 3 movements'
	SELECT @date = MIN([FixDate]) FROM Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @date <> '2012-05-11'
		SET @msg = @msg + ' First location has wrong date'
	SELECT @date = MAX([FixDate]) FROM Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @date <> '2012-05-16'
		SET @msg = @msg + ' Last location has wrong date'
	IF @msg = ''
		SET @msg = 'Passed'
	ELSE
		SET @msg = 'Failed' + @msg
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal, @mfgr, @collar, '2012-05-05 12:00'
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal, @mfgr, @collar, '2012-05-14 12:00'
	EXEC [dbo].[CollarFixes_Delete] @fileid
	
	
	-- Test6
	SET @test = '  Test6: Mortality before Deployment ends: '
	--Action
	EXEC [dbo].[Animal_Update] @project, @animal,null,null,'2012-05-15 12:00'
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal, @mfgr, @collar, '2012-05-11 12:00'
	EXEC [dbo].[CollarFixes_Insert] @fileid, @format
	--Test
	SET @msg = ''
	SELECT 1 from CollarFixes Where [FileId] = @fileid AND [CollarManufacturer] = @mfgr AND [CollarId] = @collar
	IF @@ROWCOUNT <> 6
		SET @msg = @msg + ' Not 6 fixes'
	SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @@ROWCOUNT <> 4
		SET @msg = @msg + ' Not 4 locations'
	SELECT 1 from Movements Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @@ROWCOUNT <> 3
		SET @msg = @msg + ' Not 3 movements'
	SELECT @date = MIN([FixDate]) FROM Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @date <> '2012-05-12'
		SET @msg = @msg + ' First location has wrong date'
	SELECT @date = MAX([FixDate]) FROM Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @date <> '2012-05-15'
		SET @msg = @msg + ' Last location has wrong date'
	IF @msg = ''
		SET @msg = 'Passed'
	ELSE
		SET @msg = 'Failed' + @msg
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal, @mfgr, @collar, '2012-05-11 12:00'
	EXEC [dbo].[CollarFixes_Delete] @fileid
	EXEC [dbo].[Animal_Update] @project, @animal,null,null,null
	
	
	-- Test7
	SET @test = '  Test7: Mortality after deployment ends: '
	--Action
	EXEC [dbo].[Animal_Update] @project, @animal,null,null,'2012-05-15 12:00'
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal, @mfgr, @collar, '2012-05-11 12:00', '2012-05-14 12:00'
	EXEC [dbo].[CollarFixes_Insert] @fileid, @format
	--Test
	SET @msg = ''
	SELECT 1 from CollarFixes Where [FileId] = @fileid AND [CollarManufacturer] = @mfgr AND [CollarId] = @collar
	IF @@ROWCOUNT <> 6
		SET @msg = @msg + ' Not 6 fixes'
	SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @@ROWCOUNT <> 3
		SET @msg = @msg + ' Not 3 locations'
	SELECT 1 from Movements Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @@ROWCOUNT <> 2
		SET @msg = @msg + ' Not 2 movements'
	SELECT @date = MIN([FixDate]) FROM Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @date <> '2012-05-12'
		SET @msg = @msg + ' First location has wrong date'
	SELECT @date = MAX([FixDate]) FROM Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @date <> '2012-05-14'
		SET @msg = @msg + ' Last location has wrong date'
	IF @msg = ''
		SET @msg = 'Passed'
	ELSE
		SET @msg = 'Failed' + @msg
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal, @mfgr, @collar, '2012-05-11 12:00'
	EXEC [dbo].[CollarFixes_Delete] @fileid
	EXEC [dbo].[Animal_Update] @project, @animal,null,null,null

	
	-- Test8
	SET @test = '  Test8: Hide first with new fix: '
	--Action
	INSERT INTO dbo.CollarDataTelonicsStoreOnBoard ([FileId], [LineNumber], [Date], [Latitude], [Longitude], [Fix Status])
		 VALUES (@fileid, 7, '2012-05-11', '60.7', '-154.7', 'Fix Available')
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal, @mfgr, @collar, '2012-05-10 12:00'
	EXEC [dbo].[CollarFixes_Insert] @fileid, @format
	--Test
	SET @msg = ''
	SELECT 1 from CollarFixes Where [FileId] = @fileid AND [CollarManufacturer] = @mfgr AND [CollarId] = @collar
	IF @@ROWCOUNT <> 7
		SET @msg = @msg + ' Not 7 fixes'
	SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @@ROWCOUNT <> 6
		SET @msg = @msg + ' Not 6 locations'
	SELECT 1 from Movements Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @@ROWCOUNT <> 5
		SET @msg = @msg + ' Not 5 movements'
	SELECT @date = MIN([FixDate]) FROM Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @date <> '2012-05-11'
		SET @msg = @msg + ' First location has wrong date'
	SELECT @date = MAX([FixDate]) FROM Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @date <> '2012-05-16'
		SET @msg = @msg + ' Last location has wrong date'
	SELECT @fix1 = MIN([FixId]) FROM CollarFixes Where [FileId] = @fileid AND [CollarManufacturer] = @mfgr AND [CollarId] = @collar
	SELECT @fix2 = MAX([FixId]) FROM CollarFixes Where [FileId] = @fileid AND [CollarManufacturer] = @mfgr AND [CollarId] = @collar
	IF NOT EXISTS (SELECT 1 FROM CollarFixes where FixId = @fix1 AND HiddenBy = @fix2)
		SET @msg = @msg + ' last fix is not hiding first fix'
	IF @msg = ''
		SET @msg = 'Passed'
	ELSE
		SET @msg = 'Failed' + @msg
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal, @mfgr, @collar, '2012-05-10 12:00'
	EXEC [dbo].[CollarFixes_Delete] @fileid

	
	-- Test9
	SET @test = '  Test9: Hide 1w/2; 2w/4; 3w/5 5w/6: '
	--Action
	Delete from dbo.CollarDataTelonicsStoreOnBoard where FileId = @fileid
	INSERT INTO dbo.CollarDataTelonicsStoreOnBoard ([FileId], [LineNumber], [Date], [Latitude], [Longitude], [Fix Status])
		 VALUES (@fileid, 1, '2012-05-11', '60.1', '-154.1', 'Fix Available'),
		        (@fileid, 2, '2012-05-11', '60.2', '-154.2', 'Fix Available'),
		        (@fileid, 3, '2012-05-13', '60.3', '-154.3', 'Fix Available'),
		        (@fileid, 4, '2012-05-11', '60.4', '-154.4', 'Fix Available'),
		        (@fileid, 5, '2012-05-13', '60.5', '-154.5', 'Fix Available'),
		        (@fileid, 6, '2012-05-13', '60.6', '-154.6', 'Fix Available');
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal, @mfgr, @collar, '2012-05-10 12:00'
	EXEC [dbo].[CollarFixes_Insert] @fileid, @format
	--Test
	SET @msg = ''
	SELECT 1 from CollarFixes Where [FileId] = @fileid AND [CollarManufacturer] = @mfgr AND [CollarId] = @collar
	IF @@ROWCOUNT <> 6
		SET @msg = @msg + ' Not 6 fixes'
	SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @@ROWCOUNT <> 2
		SET @msg = @msg + ' Not 2 locations'
	SELECT 1 from Movements Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @@ROWCOUNT <> 1
		SET @msg = @msg + ' Not 1 movements'
	SELECT @date = MIN([FixDate]) FROM Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @date <> '2012-05-11'
		SET @msg = @msg + ' First location has wrong date'
	SELECT @date = MAX([FixDate]) FROM Locations Where [ProjectId] = @project AND [AnimalId] = @animal
	IF @date <> '2012-05-13'
		SET @msg = @msg + ' Last location has wrong date'
	
	SELECT @fix1 = MIN([FixId]) FROM CollarFixes Where [FileId] = @fileid AND [CollarManufacturer] = @mfgr AND [CollarId] = @collar
	SET @fix2 = @fix1 + 1
	IF NOT EXISTS (SELECT 1 FROM CollarFixes where FixId = @fix1 AND HiddenBy = @fix2)
		SET @msg = @msg + ' fix 2 not hiding fix 1'
	
	SET @fix1 = @fix1 + 1
	SET @fix2 = @fix1 + 2
	IF NOT EXISTS (SELECT 1 FROM CollarFixes where FixId = @fix1 AND HiddenBy = @fix2)
		SET @msg = @msg + ' fix 4 not hiding fix 2'
	
	SET @fix1 = @fix1 + 1
	SET @fix2 = @fix1 + 2
	IF NOT EXISTS (SELECT 1 FROM CollarFixes where FixId = @fix1 AND HiddenBy = @fix2)
		SET @msg = @msg + ' fix 5 not hiding fix 3'
	
	SET @fix1 = @fix1 + 2
	SET @fix2 = @fix1 + 1
	IF NOT EXISTS (SELECT 1 FROM CollarFixes where FixId = @fix1 AND HiddenBy = @fix2)
		SET @msg = @msg + ' fix 6 not hiding fix 5'
	IF @msg = ''
		SET @msg = 'Passed'
	ELSE
		SET @msg = 'Failed' + @msg
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal, @mfgr, @collar, '2012-05-10 12:00'
	EXEC [dbo].[CollarFixes_Delete] @fileid
	
	
		
	-- Clean up
	PRINT '  Cleaning up'
	EXEC [dbo].[CollarFile_Delete] @fileid
	DELETE CollarDeployments Where [ProjectId] = @project 
	EXEC [dbo].[Collar_Delete] @mfgr, @collar
	Delete Animals where ProjectId = @project -- SP checks if user is in role, which sa is not
	EXEC [dbo].[Project_Delete] @project

	-- Check that cleanup worked
	IF    EXISTS (SELECT 1 from Animals Where [ProjectId] = @project AND [AnimalId] = @animal) 
       OR EXISTS (SELECT 1 from Projects Where [ProjectId] = @project)
       OR EXISTS (SELECT 1 from Collars Where [CollarManufacturer] = @mfgr AND [CollarId] = @collar)
	   OR EXISTS (SELECT 1 from CollarDeployments Where [ProjectId] = @project)
	   OR EXISTS (SELECT 1 from CollarFiles Where [FileId] = @fileid)
	   OR EXISTS (SELECT 1 from CollarDataTelonicsStoreOnBoard Where [FileId] = @fileid)
	   OR EXISTS (SELECT 1 from CollarFixes Where [FileId] = @fileid AND [CollarManufacturer] = @mfgr AND [CollarId] = @collar)
	   OR EXISTS (SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal)
	   OR EXISTS (SELECT 1 from Movements Where [ProjectId] = @project AND [AnimalId] = @animal)
	BEGIN
		PRINT 'Test data not completely removed'
		RETURN 1
	END

	-- Remove the sa from project investigator
	DELETE [dbo].[ProjectInvestigators] WHERE  [Login] = @sa
	
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: June 18, 2012
-- Description:	Test the CollarFixes DeleteTrigger
-- =============================================
CREATE PROCEDURE [dbo].[Test_Trigger_CollarFixes_Delete] 
AS
BEGIN
	SET NOCOUNT ON
	
	PRINT 'Test_Trigger_CollarFixes_Delete'
	
/*  TESTS:
	Delete hidden fix
	Delete Hidding fix
	Delete hidding & hidden fix
  Repeat with multiple fixes

	Check:
	all associated locations are deleted
	hidden fixes - nothing else
	hidding fixes - unhide hidden fixes
	hidden/hidding - hidden fixes inherit hidden by of deleted
*/

	DECLARE
			@sa nvarchar(16) = 'sa',
			@project nvarchar(16) = 'p1__',
			@animal1 nvarchar(16) = 'a1__',
			@mfgr nvarchar(16) = 'Telonics',
			@model nvarchar(16) = 'TelonicsGen4',
			@collar1 nvarchar(16) = 'c1__',
			@file nvarchar(16) = 'f1__',
			@fileid int,
			@format nvarchar(16) = 'A', -- Store on board format
			@test nvarchar(255) = null,
			@msg nvarchar(255) = null,
			@fix1 bigint,
			@fix2 bigint,
			@fix3 bigint,
			@fix4 bigint,
			@fix5 bigint,
			@fix6 bigint,
			@fix_l bigint
			
	-- This test must be run as SA, since others cannot operate on table directly
	-- This test the integrity of the tables underlying the Store Procedures available to users.
	-- Also SA can check user tables

	IF ORIGINAL_LOGIN() <> @sa
	BEGIN
		PRINT '  You must be the sa to run this test'
		RETURN 1
	END

/*
	-- Clean up mess if previous test failed; need to find and set the file id first
	SET @fileid = 203
	EXEC [dbo].[CollarFile_Delete] @fileid
	DELETE CollarDeployments Where [ProjectId] = @project 
	DELETE Collars where CollarManufacturer = @mfgr and CollarId = @collar1
	Delete Animals where ProjectId = @project -- SP checks if user is in role, which sa is not
	EXEC [dbo].[Project_Delete] @project
	return 1
*/

	--Check to make sure we are not going to overwrite any data
	IF EXISTS (SELECT 1 from Projects Where [ProjectId] = @project)
    OR EXISTS (SELECT 1 from Collars Where [CollarManufacturer] = @mfgr AND [CollarId] = @collar1)
	BEGIN
		PRINT '  Aborting tests.  Existing data conflicts with test data.'
		RETURN 1
	END
	
	-- Add the sa is a project investigator
	IF NOT EXISTS(SELECT 1 FROM [dbo].[ProjectInvestigators] WHERE [Login] = @sa)
	BEGIN
		INSERT [dbo].[ProjectInvestigators] ([Login],[Name],[Email],[Phone]) VALUES (@sa,@sa,@sa,@sa)
	END


	-- Setup for test
	EXEC [dbo].[Project_Insert] @project, @project, @sa
	EXEC [dbo].[Animal_Insert] @project, @animal1
	EXEC [dbo].[Collar_Insert] @mfgr, @collar1, @model ,@sa

	INSERT INTO dbo.CollarFiles ([FileName], [Project], [CollarManufacturer], [CollarId], [Format], [Status], [Contents])
		 VALUES (@file, @project, @mfgr, @collar1, @format, 'A', convert(varbinary,'data'))  -- 'A' = Store on board
	SET @fileid = SCOPE_IDENTITY();
	INSERT INTO dbo.CollarDataTelonicsStoreOnBoard ([FileId], [LineNumber], [Date], [Latitude], [Longitude], [Fix Status])
		 VALUES (@fileid, 1, '2012-05-11', '60.11', '-154.11', 'Fix Available'),
		        (@fileid, 2, '2012-05-12', '60.12', '-154.12', 'Fix Available'),
		        (@fileid, 3, '2012-05-11', '60.13', '-154.13', 'Fix Available'),
		        (@fileid, 4, '2012-05-11', '60.14', '-154.14', 'Fix Available'),
		        (@fileid, 5, '2012-05-15', '60.15', '-154.15', 'Fix Available'),
		        (@fileid, 6, '2012-05-11', '60.16', '-154.16', 'Fix Available')
	EXEC [dbo].[CollarFixes_Insert] @fileid,@format

	SELECT @fix1 = FixId FROM CollarFixes Where [FileId] = @fileid AND [LineNumber] = 1
	SELECT @fix2 = FixId FROM CollarFixes Where [FileId] = @fileid AND [LineNumber] = 2
	SELECT @fix3 = FixId FROM CollarFixes Where [FileId] = @fileid AND [LineNumber] = 3
	SELECT @fix4 = FixId FROM CollarFixes Where [FileId] = @fileid AND [LineNumber] = 4
	SELECT @fix5 = FixId FROM CollarFixes Where [FileId] = @fileid AND [LineNumber] = 5
	SELECT @fix6 = FixId FROM CollarFixes Where [FileId] = @fileid AND [LineNumber] = 6

	-- Check initial conditions
	IF    NOT EXISTS (SELECT 1 from Animals Where [ProjectId] = @project AND [AnimalId] = @animal1)
       OR NOT EXISTS (SELECT 1 from Collars Where [CollarManufacturer] = @mfgr AND [CollarId] = @collar1)
	   OR NOT EXISTS (SELECT 1 from CollarFiles Where [FileId] = @FileId)
	   OR NOT EXISTS (SELECT 1 from CollarFixes Where [FileId] = @fileid AND [CollarManufacturer] = @mfgr AND [CollarId] = @collar1)
	   OR     EXISTS (SELECT 1 from CollarDeployments Where [ProjectId] = @project)
	   OR     EXISTS (SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal1)
	   OR     EXISTS (SELECT 1 from Movements Where [ProjectId] = @project AND [AnimalId] = @animal1)
	BEGIN
		PRINT '  Test data not initialized properly'
		RETURN 1
	END
	
	
	-- Check initial Fixes
	IF    NOT EXISTS (SELECT 1 from CollarFixes Where [FixId] = @fix1 AND [HiddenBy] = @fix3)
       OR NOT EXISTS (SELECT 1 from CollarFixes Where [FixId] = @fix2 AND [HiddenBy] IS NULL)
       OR NOT EXISTS (SELECT 1 from CollarFixes Where [FixId] = @fix3 AND [HiddenBy] = @fix4)
       OR NOT EXISTS (SELECT 1 from CollarFixes Where [FixId] = @fix4 AND [HiddenBy] = @fix6)
       OR NOT EXISTS (SELECT 1 from CollarFixes Where [FixId] = @fix5 AND [HiddenBy] IS NULL)
       OR NOT EXISTS (SELECT 1 from CollarFixes Where [FixId] = @fix6 AND [HiddenBy] IS NULL)
	BEGIN
		PRINT '  Fixes not initialized properly'
		RETURN 1
	END

	-- Check initial Locations
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal1, @mfgr, @collar1, '2012-05-10 12:00', '2012-05-16 12:00'
	IF    NOT EXISTS (SELECT 1 from Locations Where [FixId] = @fix2)
       OR NOT EXISTS (SELECT 1 from Locations Where [FixId] = @fix5)
       OR NOT EXISTS (SELECT 1 from Locations Where [FixId] = @fix6)
	   OR     EXISTS (SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal1 AND [FixId] NOT IN (@fix2,@fix5,@fix6))
	BEGIN
		PRINT '  Locations not initialized properly'
		RETURN 1
	END

	
	-- Do tests

	-- Test1
	SET @test = '  Test1: Delete Hidden Fix: '
	--Action
	Delete [dbo].[CollarFixes] WHERE [FixId] = @fix1
	--Test
	SET @msg = ''
	IF EXISTS (SELECT 1 from CollarFixes Where [FixId] = @fix1)
		SET @msg = @msg + ' Fix1 not deleted'
	IF NOT EXISTS (SELECT 1 from CollarFixes Where [FixId] = @fix2 AND [HiddenBy] IS NULL)
		SET @msg = @msg + ' Fix2 is hidden'
	IF NOT EXISTS (SELECT 1 from CollarFixes Where [FixId] = @fix3 AND [HiddenBy] = @fix4)
		SET @msg = @msg + ' Fix3 is not hidden by Fix4'
	IF NOT EXISTS (SELECT 1 from CollarFixes Where [FixId] = @fix4 AND [HiddenBy] = @fix6)
		SET @msg = @msg + ' Fix4 is not hidden by Fix6'
	IF NOT EXISTS (SELECT 1 from CollarFixes Where [FixId] = @fix5 AND [HiddenBy] IS NULL)
		SET @msg = @msg + ' Fix5 is hidden'
	IF NOT EXISTS (SELECT 1 from CollarFixes Where [FixId] = @fix6 AND [HiddenBy] IS NULL)
		SET @msg = @msg + ' Fix6 is hidden'
	IF NOT EXISTS (SELECT 1 from Locations Where [FixId] = @fix2)
		SET @msg = @msg + ' No Location for Fix2'
	IF NOT EXISTS (SELECT 1 from Locations Where [FixId] = @fix5)
		SET @msg = @msg + ' No Location for Fix5'
	IF NOT EXISTS (SELECT 1 from Locations Where [FixId] = @fix6)
		SET @msg = @msg + ' No Location for Fix6'
	IF EXISTS (SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal1 AND [FixId] NOT IN (@fix2,@fix5,@fix6))
		SET @msg = @msg + ' Unexpected Locations'
	IF @msg = ''
		SET @msg = 'Passed'
	ELSE
		SET @msg = 'Failed' + @msg
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset


	-- Test2
	SET @test = '  Test2: Delete Hidden/Hidding Fix: '
	--Action
	Delete [dbo].[CollarFixes] WHERE [FixId] = @fix4
	--Test
	SET @msg = ''
	IF EXISTS (SELECT 1 from CollarFixes Where [FixId] = @fix1)
		SET @msg = @msg + ' Fix1 not deleted'
	IF NOT EXISTS (SELECT 1 from CollarFixes Where [FixId] = @fix2 AND [HiddenBy] IS NULL)
		SET @msg = @msg + ' Fix2 is hidden'
	IF NOT EXISTS (SELECT 1 from CollarFixes Where [FixId] = @fix3 AND [HiddenBy] = @fix6)
		SET @msg = @msg + ' Fix3 is not hidden by Fix 6'
	IF EXISTS (SELECT 1 from CollarFixes Where [FixId] = @fix4)
		SET @msg = @msg + ' Fix4 not deleted'
	IF NOT EXISTS (SELECT 1 from CollarFixes Where [FixId] = @fix5 AND [HiddenBy] IS NULL)
		SET @msg = @msg + ' Fix5 is hidden'
	IF NOT EXISTS (SELECT 1 from CollarFixes Where [FixId] = @fix6 AND [HiddenBy] IS NULL)
		SET @msg = @msg + ' Fix6 is hidden'
	IF NOT EXISTS (SELECT 1 from Locations Where [FixId] = @fix2)
		SET @msg = @msg + ' No Location for Fix2'
	IF NOT EXISTS (SELECT 1 from Locations Where [FixId] = @fix5)
		SET @msg = @msg + ' No Location for Fix5'
	IF NOT EXISTS (SELECT 1 from Locations Where [FixId] = @fix6)
		SET @msg = @msg + ' No Location for Fix6'
	IF EXISTS (SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal1 AND [FixId] NOT IN (@fix2,@fix5,@fix6))
		SET @msg = @msg + ' Unexpected Locations'
	IF @msg = ''
		SET @msg = 'Passed'
	ELSE
		SET @msg = 'Failed' + @msg
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset


	-- Test3
	SET @test = '  Test3: Delete Hidding Fix: '
	--Action
	Delete [dbo].[CollarFixes] WHERE [FixId] = @fix6
	--Test
	SET @msg = ''
	IF EXISTS (SELECT 1 from CollarFixes Where [FixId] = @fix1)
		SET @msg = @msg + ' Fix1 not deleted'
	IF NOT EXISTS (SELECT 1 from CollarFixes Where [FixId] = @fix2 AND [HiddenBy] IS NULL)
		SET @msg = @msg + ' Fix2 is hidden'
	IF NOT EXISTS (SELECT 1 from CollarFixes Where [FixId] = @fix3 AND [HiddenBy] IS NULL)
		SET @msg = @msg + ' Fix3 is hidden'
	IF EXISTS (SELECT 1 from CollarFixes Where [FixId] = @fix4)
		SET @msg = @msg + ' Fix4 not deleted'
	IF NOT EXISTS (SELECT 1 from CollarFixes Where [FixId] = @fix5 AND [HiddenBy] IS NULL)
		SET @msg = @msg + ' Fix5 is hidden'
	IF EXISTS (SELECT 1 from CollarFixes Where [FixId] = @fix6)
		SET @msg = @msg + ' Fix6 not deleted'
	IF NOT EXISTS (SELECT 1 from Locations Where [FixId] = @fix2)
		SET @msg = @msg + ' No Location for Fix2'
	IF NOT EXISTS (SELECT 1 from Locations Where [FixId] = @fix5)
		SET @msg = @msg + ' No Location for Fix5'
	IF NOT EXISTS (SELECT 1 from Locations Where [FixId] = @fix3)
		SET @msg = @msg + ' No Location for Fix3'
	IF EXISTS (SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal1 AND [FixId] NOT IN (@fix2,@fix5,@fix3))
		SET @msg = @msg + ' Unexpected Locations'
	IF @msg = ''
		SET @msg = 'Passed'
	ELSE
		SET @msg = 'Failed' + @msg
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	
	
	-- Test4
	SET @test = '  Test4: Delete Several Plain Fixes: '
	--Action
	Delete [dbo].[CollarFixes] WHERE [FixId] IN (@fix1, @fix2, @fix3, @fix4, @fix5, @fix6)
	--Test
	SET @msg = ''
	IF EXISTS (SELECT 1 from CollarFixes Where [FixId] IN (@fix1, @fix2, @fix3, @fix4, @fix5, @fix6))
		SET @msg = @msg + ' Fixes not deleted'

	IF EXISTS (SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal1)
		SET @msg = @msg + ' Unexpected Locations'
	IF @msg = ''
		SET @msg = 'Passed'
	ELSE
		SET @msg = 'Failed' + @msg
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	EXEC [dbo].[CollarFile_UpdateStatus] @fileid, 'I'
	EXEC [dbo].[CollarFile_UpdateStatus] @fileid, 'A'
	--EXEC [dbo].[CollarFixes_Insert] @fileid,@format

	SELECT @fix1 = FixId FROM CollarFixes Where [FileId] = @fileid AND [LineNumber] = 1
	SELECT @fix2 = FixId FROM CollarFixes Where [FileId] = @fileid AND [LineNumber] = 2
	SELECT @fix3 = FixId FROM CollarFixes Where [FileId] = @fileid AND [LineNumber] = 3
	SELECT @fix4 = FixId FROM CollarFixes Where [FileId] = @fileid AND [LineNumber] = 4
	SELECT @fix5 = FixId FROM CollarFixes Where [FileId] = @fileid AND [LineNumber] = 5
	SELECT @fix6 = FixId FROM CollarFixes Where [FileId] = @fileid AND [LineNumber] = 6

	-- Test5
	SET @test = '  Test5: Delete Multiple Hidden Fixes: '
	--Action
	Delete [dbo].[CollarFixes] WHERE [FixId] IN (@fix2, @fix3, @fix6)
	--Test
	SET @msg = ''
	IF EXISTS (SELECT 1 from CollarFixes Where [FixId] IN (@fix2, @fix3, @fix6))
		SET @msg = @msg + ' Fixes 2,3,6 not deleted'
	IF NOT EXISTS (SELECT 1 from CollarFixes Where [FixId] = @fix1 AND [HiddenBy] = @fix4)
		SET @msg = @msg + ' Fix1 is not hidden by Fix4'
	IF NOT EXISTS (SELECT 1 from CollarFixes Where [FixId] = @fix4 AND [HiddenBy] IS NULL)
		SET @msg = @msg + ' Fix4 is hidden'
	IF NOT EXISTS (SELECT 1 from CollarFixes Where [FixId] = @fix5 AND [HiddenBy] IS NULL)
		SET @msg = @msg + ' Fix5 is hidden'
	IF NOT EXISTS (SELECT 1 from Locations Where [FixId] = @fix4)
		SET @msg = @msg + ' No Location for Fix4'
	IF NOT EXISTS (SELECT 1 from Locations Where [FixId] = @fix5)
		SET @msg = @msg + ' No Location for Fix5'
	IF EXISTS (SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal1 AND [FixId] NOT IN (@fix4,@fix5))
		SET @msg = @msg + ' Unexpected Locations'
	IF @msg = ''
		SET @msg = 'Passed'
	ELSE
		SET @msg = 'Failed' + @msg
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset

	
	
	-- Clean up
	PRINT '  Cleaning up'
	EXEC [dbo].[CollarFile_Delete] @fileid
	DELETE CollarDeployments Where [ProjectId] = @project 
	EXEC [dbo].[Collar_Delete] @mfgr, @collar1
	Delete Animals where ProjectId = @project -- SP checks if user is in role, which sa is not
	EXEC [dbo].[Project_Delete] @project

	-- Check that cleanup worked
	IF    EXISTS (SELECT 1 from Animals Where [ProjectId] = @project AND [AnimalId] = @animal1)
       OR EXISTS (SELECT 1 from Projects Where [ProjectId] = @project)
       OR EXISTS (SELECT 1 from Collars Where [CollarManufacturer] = @mfgr AND [CollarId] = @collar1)
	   OR EXISTS (SELECT 1 from CollarDeployments Where [ProjectId] = @project)
	   OR EXISTS (SELECT 1 from CollarFiles Where [FileId] = @FileId)
	   OR EXISTS (SELECT 1 from CollarDataTelonicsStoreOnBoard Where [FileId] = @FileId)
	   OR EXISTS (SELECT 1 from CollarFixes Where [FileId] = @fileid AND [CollarManufacturer] = @mfgr AND [CollarId] = @collar1)
	   OR EXISTS (SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal1)
	   OR EXISTS (SELECT 1 from Movements Where [ProjectId] = @project AND [AnimalId] = @animal1)
	BEGIN
		PRINT 'Test data not completely removed'
		RETURN 1
	END

	-- Remove the sa from project investigator
	DELETE [dbo].[ProjectInvestigators] WHERE  [Login] = @sa
	
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: June 15, 2012
-- Description:	Test the CollarDeployments UpdateTrigger
-- =============================================
CREATE PROCEDURE [dbo].[Test_Trigger_CollarDeployments_Update] 
AS
BEGIN
	SET NOCOUNT ON	

	PRINT 'Test_Trigger_CollarDeployments_Update'

/*  TESTS:
Check locations after changing deployment
 rdate t1 -> null
 rdate null -> t1
 rdate t1 -> t2
 rdate t2 -> t1
 repeat with animal with a mortality date

Check illegal modifications of deployment
 ddate = t1, rdate null -> t1
 ddate = t2, rdate null -> t1
 same animal, same collar
 d1date =  t3, r1date = t5, d2date =  t1, r2date t2 -> t3
 d1date =  t3, r1date = t5, d2date =  t1, r2date t2 -> t4
 d1date =  t3, r1date = t5, d2date =  t1, r2date t2 -> t6
 d1date =  t3, r1date = t5, d2date =  t1, r2date t2 -> null
 same animal, different collar
 d1date =  t3, r1date = t5, d2date =  t1, r2date t2 -> t3
 d1date =  t3, r1date = t5, d2date =  t1, r2date t2 -> t4
 d1date =  t3, r1date = t5, d2date =  t1, r2date t2 -> t6
 d1date =  t3, r1date = t5, d2date =  t1, r2date t2 -> null
 different animal, same collar
 d1date =  t3, r1date = t5, d2date =  t1, r2date t2 -> t3
 d1date =  t3, r1date = t5, d2date =  t1, r2date t2 -> t4
 d1date =  t3, r1date = t5, d2date =  t1, r2date t2 -> t6
 d1date =  t3, r1date = t5, d2date =  t1, r2date t2 -> null
*/

	DECLARE
			@sa nvarchar(16) = 'sa',
			@project nvarchar(16) = 'p1__',
			@animal1 nvarchar(16) = 'a1__',
			@animal2 nvarchar(16) = 'a2__',
			@mfgr nvarchar(16) = 'Telonics',
			@model nvarchar(16) = 'TelonicsGen4',
			@collar1 nvarchar(16) = 'c1__',
			@collar2 nvarchar(16) = 'c2__',
			@file nvarchar(16) = 'f1__',
			@fileid int,
			@format nvarchar(16) = 'A', -- Store on board format
			@test nvarchar(255) = null,
			@msg nvarchar(255) = null,
			@fix1 bigint,
			@fix2 bigint,
			@fix3 bigint,
			@fix4 bigint,
			@fix5 bigint,
			@fix6 bigint,
			@fix_l bigint
			
	-- This test must be run as SA, since others cannot operate on table directly
	-- This test the integrity of the tables underlying the Store Procedures available to users.
	-- Also SA can check user tables

	IF ORIGINAL_LOGIN() <> @sa
	BEGIN
		PRINT '  You must be the sa to run this test'
		RETURN 1
	END

/*
	-- Clean up mess if previous test failed; need to find and set the file id first
	SET @fileid = 140
	EXEC [dbo].[CollarFile_Delete] @fileid
	DELETE CollarDeployments Where [ProjectId] = @project 
	DELETE Collars where CollarManufacturer = @mfgr and CollarId = @collar
	Delete Animals where ProjectId = @project -- SP checks if user is in role, which sa is not
	EXEC [dbo].[Project_Delete] @project
	return 1
*/

	--Check to make sure we are not going to overwrite any data
	IF EXISTS (SELECT 1 from Projects Where [ProjectId] = @project)
    OR EXISTS (SELECT 1 from Collars Where [CollarManufacturer] = @mfgr AND [CollarId] IN (@collar1,@collar2))
	BEGIN
		PRINT '  Aborting tests.  Existing data conflicts with test data.'
		RETURN 1
	END
	
	-- Add the sa is a project investigator
	IF NOT EXISTS(SELECT 1 FROM [dbo].[ProjectInvestigators] WHERE [Login] = @sa)
	BEGIN
		INSERT [dbo].[ProjectInvestigators] ([Login],[Name],[Email],[Phone]) VALUES (@sa,@sa,@sa,@sa)
	END


	-- Setup for test
	EXEC [dbo].[Project_Insert] @project, @project, @sa
	EXEC [dbo].[Animal_Insert] @project, @animal1
	EXEC [dbo].[Animal_Insert] @project, @animal2, null, null, '2012-05-14 12:00'
	EXEC [dbo].[Collar_Insert] @mfgr, @collar1, @model ,@sa
	EXEC [dbo].[Collar_Insert] @mfgr, @collar2, @model ,@sa

	INSERT INTO dbo.CollarFiles ([FileName], [Project], [CollarManufacturer], [CollarId], [Format], [Status], [Contents])
		 VALUES (@file, @project, @mfgr, @collar1, @format, 'A', convert(varbinary,'data'))  -- 'A' = Store on board
	SET @fileid = SCOPE_IDENTITY();
	INSERT INTO dbo.CollarDataTelonicsStoreOnBoard ([FileId], [LineNumber], [Date], [Latitude], [Longitude], [Fix Status])
		 VALUES (@fileid, 1, '2012-05-11', '60.11', '-154.11', 'Fix Available'),
		        (@fileid, 2, '2012-05-12', '60.12', '-154.12', 'Fix Available'),
		        (@fileid, 3, '2012-05-13', '60.13', '-154.13', 'Fix Available'),
		        (@fileid, 4, '2012-05-14', '60.14', '-154.14', 'Fix Available'),
		        (@fileid, 5, '2012-05-15', '60.15', '-154.15', 'Fix Available'),
		        (@fileid, 6, '2012-05-16', '60.16', '-154.16', 'Fix Available')
	EXEC [dbo].[CollarFixes_Insert] @fileid,@format

	SELECT @fix1 = FixId FROM CollarFixes Where [FileId] = @fileid AND [LineNumber] = 1
	SELECT @fix2 = FixId FROM CollarFixes Where [FileId] = @fileid AND [LineNumber] = 2
	SELECT @fix3 = FixId FROM CollarFixes Where [FileId] = @fileid AND [LineNumber] = 3
	SELECT @fix4 = FixId FROM CollarFixes Where [FileId] = @fileid AND [LineNumber] = 4
	SELECT @fix5 = FixId FROM CollarFixes Where [FileId] = @fileid AND [LineNumber] = 5
	SELECT @fix6 = FixId FROM CollarFixes Where [FileId] = @fileid AND [LineNumber] = 6

	-- Check initial conditions
	IF    NOT EXISTS (SELECT 1 from Animals Where [ProjectId] = @project AND [AnimalId] IN (@animal1, @animal2))
       OR NOT EXISTS (SELECT 1 from Collars Where [CollarManufacturer] = @mfgr AND [CollarId] IN (@collar1,@collar2))
	   OR NOT EXISTS (SELECT 1 from CollarFiles Where [FileId] = @FileId)
	   OR NOT EXISTS (SELECT 1 from CollarFixes Where [FileId] = @fileid AND [CollarManufacturer] = @mfgr AND [CollarId] = @collar1)
	   OR     EXISTS (SELECT 1 from CollarDeployments Where [ProjectId] = @project)
	   OR     EXISTS (SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] IN (@animal1, @animal2))
	   OR     EXISTS (SELECT 1 from Movements Where [ProjectId] = @project AND [AnimalId] IN (@animal1, @animal2))
	BEGIN
		PRINT '  Test data not initialized properly'
		RETURN 1
	END
	

	-- Do tests
	PRINT '  Check locations after legal changes to deployment retrieval date'

	-- Test1
	SET @test = '  Test1: rdate t1 -> null: '
	--Action
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal1, @mfgr, @collar1, '2012-05-11 12:00', '2012-05-14 12:00'
	--Test
	SET @msg = ''

	SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal1
	IF @@ROWCOUNT <> 3
		SET @msg = @msg + ' Not 3 locations at start'

	EXEC [dbo].[CollarDeployment_UpdateRetrievalDate] @project, @animal1, @mfgr, @collar1, '2012-05-11 12:00', NULL

	SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal1
	IF @@ROWCOUNT <> 5
		SET @msg = @msg + ' Not 5 locations at end'
		
	IF @msg = ''
		SET @msg = 'Passed'
	ELSE
		SET @msg = 'Failed' + @msg
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal1, @mfgr, @collar1, '2012-05-11 12:00'


	-- Test2
	SET @test = '  Test2: rdate null -> t1: '
	--Action
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal1, @mfgr, @collar1, '2012-05-11 12:00', NULL
	--Test
	SET @msg = ''

	SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal1
	IF @@ROWCOUNT <> 5
		SET @msg = @msg + ' Not 5 locations at start'

	EXEC [dbo].[CollarDeployment_UpdateRetrievalDate] @project, @animal1, @mfgr, @collar1, '2012-05-11 12:00', '2012-05-14 12:00'

	SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal1
	IF @@ROWCOUNT <> 3
		SET @msg = @msg + ' Not 3 locations at end'
		
	IF @msg = ''
		SET @msg = 'Passed'
	ELSE
		SET @msg = 'Failed' + @msg
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal1, @mfgr, @collar1, '2012-05-11 12:00'


	-- Test3
	SET @test = '  Test3: t1 -> t2: '
	--Action
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal1, @mfgr, @collar1, '2012-05-11 12:00', '2012-05-13 12:00'
	--Test
	SET @msg = ''

	SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal1
	IF @@ROWCOUNT <> 2
		SET @msg = @msg + ' Not 2 locations at start'

	EXEC [dbo].[CollarDeployment_UpdateRetrievalDate] @project, @animal1, @mfgr, @collar1, '2012-05-11 12:00', '2012-05-15 12:00'

	SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal1
	IF @@ROWCOUNT <> 4
		SET @msg = @msg + ' Not 4 locations at end'
		
	IF @msg = ''
		SET @msg = 'Passed'
	ELSE
		SET @msg = 'Failed' + @msg
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal1, @mfgr, @collar1, '2012-05-11 12:00'


	-- Test4
	SET @test = '  Test4: t2 -> t1: '
	--Action
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal1, @mfgr, @collar1, '2012-05-11 12:00', '2012-05-15 12:00'
	--Test
	SET @msg = ''

	SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal1
	IF @@ROWCOUNT <> 4
		SET @msg = @msg + ' Not 4 locations at start'

	EXEC [dbo].[CollarDeployment_UpdateRetrievalDate] @project, @animal1, @mfgr, @collar1, '2012-05-11 12:00', '2012-05-13 12:00'

	SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal1
	IF @@ROWCOUNT <> 2
		SET @msg = @msg + ' Not 2 locations at end'
		
	IF @msg = ''
		SET @msg = 'Passed'
	ELSE
		SET @msg = 'Failed' + @msg
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal1, @mfgr, @collar1, '2012-05-11 12:00'




	-- Test1a
	SET @test = '  Test1a: rdate t1 -> null; w/ mort: '
	--Action
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal2, @mfgr, @collar1, '2012-05-11 12:00', '2012-05-13 12:00'
	--Test
	SET @msg = ''

	SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal2
	IF @@ROWCOUNT <> 2
		SET @msg = @msg + ' Not 2 locations at start'

	EXEC [dbo].[CollarDeployment_UpdateRetrievalDate] @project, @animal2, @mfgr, @collar1, '2012-05-11 12:00', NULL

	SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal2
	IF @@ROWCOUNT <> 3
		SET @msg = @msg + ' Not 3 locations at end'
		
	IF @msg = ''
		SET @msg = 'Passed'
	ELSE
		SET @msg = 'Failed' + @msg
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal2, @mfgr, @collar1, '2012-05-11 12:00'


	-- Test2a
	SET @test = '  Test2a: rdate null -> t1; w/ mort: '
	--Action
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal2, @mfgr, @collar1, '2012-05-11 12:00', NULL
	--Test
	SET @msg = ''

	SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal2
	IF @@ROWCOUNT <> 3
		SET @msg = @msg + ' Not 3 locations at start'

	EXEC [dbo].[CollarDeployment_UpdateRetrievalDate] @project, @animal2, @mfgr, @collar1, '2012-05-11 12:00', '2012-05-13 12:00'

	SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal2
	IF @@ROWCOUNT <> 2
		SET @msg = @msg + ' Not 2 locations at end'
		
	IF @msg = ''
		SET @msg = 'Passed'
	ELSE
		SET @msg = 'Failed' + @msg
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal2, @mfgr, @collar1, '2012-05-11 12:00'


	-- Test3a
	SET @test = '  Test3a: t1 -> t2; w/ mort: '
	--Action
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal2, @mfgr, @collar1, '2012-05-11 12:00', '2012-05-13 12:00'
	--Test
	SET @msg = ''

	SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal2
	IF @@ROWCOUNT <> 2
		SET @msg = @msg + ' Not 2 locations at start'

	EXEC [dbo].[CollarDeployment_UpdateRetrievalDate] @project, @animal2, @mfgr, @collar1, '2012-05-11 12:00', '2012-05-15 12:00'

	SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal2
	IF @@ROWCOUNT <> 3
		SET @msg = @msg + ' Not 3 locations at end'
		
	IF @msg = ''
		SET @msg = 'Passed'
	ELSE
		SET @msg = 'Failed' + @msg
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal2, @mfgr, @collar1, '2012-05-11 12:00'


	-- Test4a
	SET @test = '  Test4a: t2 -> t1; w/ mort: '
	--Action
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal2, @mfgr, @collar1, '2012-05-11 12:00', '2012-05-15 12:00'
	--Test
	SET @msg = ''

	SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal2
	IF @@ROWCOUNT <> 3
		SET @msg = @msg + ' Not 3 locations at start'

	EXEC [dbo].[CollarDeployment_UpdateRetrievalDate] @project, @animal2, @mfgr, @collar1, '2012-05-11 12:00', '2012-05-13 12:00'

	SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal2
	IF @@ROWCOUNT <> 2
		SET @msg = @msg + ' Not 2 locations at end'
		
	IF @msg = ''
		SET @msg = 'Passed'
	ELSE
		SET @msg = 'Failed' + @msg
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal2, @mfgr, @collar1, '2012-05-11 12:00'





	print '  Checking illegal modifications of deployment'

	-- Test5
	SET @test = '  Test5: ddate = t1, rdate null -> t1: '
	--Action/Test
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal1, @mfgr, @collar1, '2012-05-11', NULL
	BEGIN TRY
		EXEC [dbo].[CollarDeployment_UpdateRetrievalDate] @project, @animal1, @mfgr, @collar1, '2012-05-11', '2012-05-11'
		SET @msg = 'Failed'
	END TRY
	BEGIN CATCH
		SET @msg = 'Passed'
	END CATCH
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal1, @mfgr, @collar1, '2012-05-11'
		
		
	-- Test6
	SET @test = '  Test6:  ddate = t2, rdate null -> t1: '
	--Action/Test
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal1, @mfgr, @collar1, '2012-05-11', NULL
	BEGIN TRY
		EXEC [dbo].[CollarDeployment_UpdateRetrievalDate] @project, @animal1, @mfgr, @collar1, '2012-05-11', '2012-05-10'
		SET @msg = 'Failed'
	END TRY
	BEGIN CATCH
		SET @msg = 'Passed'
	END CATCH
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal1, @mfgr, @collar1, '2012-05-11'


	-- Test7a
	SET @test = '  Test7a: same animal; same collar; d1date =  t3, r1date = t5, d2date =  t1, r2date t2 -> t3: '
	--Action/Test
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal1, @mfgr, @collar1, '2012-05-13', '2012-05-15'
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal1, @mfgr, @collar1, '2012-05-11', '2012-05-12'
	BEGIN TRY
		EXEC [dbo].[CollarDeployment_UpdateRetrievalDate] @project, @animal1, @mfgr, @collar1, '2012-05-11', '2012-05-13'
		SET @msg = 'Failed'
	END TRY
	BEGIN CATCH
		SET @msg = 'Passed'
	END CATCH
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal1, @mfgr, @collar1, '2012-05-13'
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal1, @mfgr, @collar1, '2012-05-11'

	-- Test7b
	SET @test = '  Test7b: same animal; same collar; d1date =  t3, r1date = t5, d2date =  t1, r2date t2 -> t4: '
	--Action/Test
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal1, @mfgr, @collar1, '2012-05-13', '2012-05-15'
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal1, @mfgr, @collar1, '2012-05-11', '2012-05-12'
	BEGIN TRY
		EXEC [dbo].[CollarDeployment_UpdateRetrievalDate] @project, @animal1, @mfgr, @collar1, '2012-05-11', '2012-05-14'
		SET @msg = 'Failed'
	END TRY
	BEGIN CATCH
		SET @msg = 'Passed'
	END CATCH
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal1, @mfgr, @collar1, '2012-05-13'
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal1, @mfgr, @collar1, '2012-05-11'

	-- Test7c
	SET @test = '  Test7c: same animal; same collar;  d1date =  t3, r1date = t5, d2date =  t1, r2date t2 -> t6: '
	--Action/Test
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal1, @mfgr, @collar1, '2012-05-13', '2012-05-15'
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal1, @mfgr, @collar1, '2012-05-11', '2012-05-12'
	BEGIN TRY
		EXEC [dbo].[CollarDeployment_UpdateRetrievalDate] @project, @animal1, @mfgr, @collar1, '2012-05-11', '2012-05-16'
		SET @msg = 'Failed'
	END TRY
	BEGIN CATCH
		SET @msg = 'Passed'
	END CATCH
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal1, @mfgr, @collar1, '2012-05-13'
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal1, @mfgr, @collar1, '2012-05-11'

	-- Test7d
	SET @test = '  Test7d: same animal; same collar; d1date =  t3, r1date = t5, d2date =  t1, r2date t2 -> null: '
	--Action/Test
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal1, @mfgr, @collar1, '2012-05-13', '2012-05-15'
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal1, @mfgr, @collar1, '2012-05-11', '2012-05-12'
	BEGIN TRY
		EXEC [dbo].[CollarDeployment_UpdateRetrievalDate] @project, @animal1, @mfgr, @collar1, '2012-05-11', NULL
		SET @msg = 'Failed'
	END TRY
	BEGIN CATCH
		SET @msg = 'Passed'
	END CATCH
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal1, @mfgr, @collar1, '2012-05-13'
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal1, @mfgr, @collar1, '2012-05-11'




	-- Test8a
	SET @test = '  Test8a: same animal; different collar; d1date =  t3, r1date = t5, d2date =  t1, r2date t2 -> t3: '
	--Action/Test
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal1, @mfgr, @collar2, '2012-05-13', '2012-05-15'
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal1, @mfgr, @collar1, '2012-05-11', '2012-05-12'
	BEGIN TRY
		EXEC [dbo].[CollarDeployment_UpdateRetrievalDate] @project, @animal1, @mfgr, @collar1, '2012-05-11', '2012-05-13'
		SET @msg = 'Failed'
	END TRY
	BEGIN CATCH
		SET @msg = 'Passed'
	END CATCH
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal1, @mfgr, @collar2, '2012-05-13'
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal1, @mfgr, @collar1, '2012-05-11'

	-- Test8b
	SET @test = '  Test8b: same animal; different collar; d1date =  t3, r1date = t5, d2date =  t1, r2date t2 -> t4: '
	--Action/Test
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal1, @mfgr, @collar2, '2012-05-13', '2012-05-15'
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal1, @mfgr, @collar1, '2012-05-11', '2012-05-12'
	BEGIN TRY
		EXEC [dbo].[CollarDeployment_UpdateRetrievalDate] @project, @animal1, @mfgr, @collar1, '2012-05-11', '2012-05-14'
		SET @msg = 'Failed'
	END TRY
	BEGIN CATCH
		SET @msg = 'Passed'
	END CATCH
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal1, @mfgr, @collar2, '2012-05-13'
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal1, @mfgr, @collar1, '2012-05-11'

	-- Test8c
	SET @test = '  Test8c: same animal; different collar;  d1date =  t3, r1date = t5, d2date =  t1, r2date t2 -> t6: '
	--Action/Test
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal1, @mfgr, @collar2, '2012-05-13', '2012-05-15'
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal1, @mfgr, @collar1, '2012-05-11', '2012-05-12'
	BEGIN TRY
		EXEC [dbo].[CollarDeployment_UpdateRetrievalDate] @project, @animal1, @mfgr, @collar1, '2012-05-11', '2012-05-16'
		SET @msg = 'Failed'
	END TRY
	BEGIN CATCH
		SET @msg = 'Passed'
	END CATCH
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal1, @mfgr, @collar2, '2012-05-13'
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal1, @mfgr, @collar1, '2012-05-11'

	-- Test8d
	SET @test = '  Test8d: same animal; different collar; d1date =  t3, r1date = t5, d2date =  t1, r2date t2 -> null: '
	--Action/Test
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal1, @mfgr, @collar2, '2012-05-13', '2012-05-15'
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal1, @mfgr, @collar1, '2012-05-11', '2012-05-12'
	BEGIN TRY
		EXEC [dbo].[CollarDeployment_UpdateRetrievalDate] @project, @animal1, @mfgr, @collar1, '2012-05-11', NULL
		SET @msg = 'Failed'
	END TRY
	BEGIN CATCH
		SET @msg = 'Passed'
	END CATCH
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal1, @mfgr, @collar2, '2012-05-13'
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal1, @mfgr, @collar1, '2012-05-11'




	-- Test9a
	SET @test = '  Test9a: different animal; same collar; d1date =  t3, r1date = t5, d2date =  t1, r2date t2 -> t3: '
	--Action/Test
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal2, @mfgr, @collar1, '2012-05-13', '2012-05-15'
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal1, @mfgr, @collar1, '2012-05-11', '2012-05-12'
	BEGIN TRY
		EXEC [dbo].[CollarDeployment_UpdateRetrievalDate] @project, @animal1, @mfgr, @collar1, '2012-05-11', '2012-05-13'
		SET @msg = 'Failed'
	END TRY
	BEGIN CATCH
		SET @msg = 'Passed'
	END CATCH
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal2, @mfgr, @collar1, '2012-05-13'
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal1, @mfgr, @collar1, '2012-05-11'

	-- Test9b
	SET @test = '  Test9b: different animal; same collar; d1date =  t3, r1date = t5, d2date =  t1, r2date t2 -> t4: '
	--Action/Test
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal2, @mfgr, @collar1, '2012-05-13', '2012-05-15'
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal1, @mfgr, @collar1, '2012-05-11', '2012-05-12'
	BEGIN TRY
		EXEC [dbo].[CollarDeployment_UpdateRetrievalDate] @project, @animal1, @mfgr, @collar1, '2012-05-11', '2012-05-14'
		SET @msg = 'Failed'
	END TRY
	BEGIN CATCH
		SET @msg = 'Passed'
	END CATCH
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal2, @mfgr, @collar1, '2012-05-13'
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal1, @mfgr, @collar1, '2012-05-11'

	-- Test9c
	SET @test = '  Test9c: different animal; same collar;  d1date =  t3, r1date = t5, d2date =  t1, r2date t2 -> t6: '
	--Action/Test
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal2, @mfgr, @collar1, '2012-05-13', '2012-05-15'
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal1, @mfgr, @collar1, '2012-05-11', '2012-05-12'
	BEGIN TRY
		EXEC [dbo].[CollarDeployment_UpdateRetrievalDate] @project, @animal1, @mfgr, @collar1, '2012-05-11', '2012-05-16'
		SET @msg = 'Failed'
	END TRY
	BEGIN CATCH
		SET @msg = 'Passed'
	END CATCH
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal2, @mfgr, @collar1, '2012-05-13'
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal1, @mfgr, @collar1, '2012-05-11'

	-- Test9d
	SET @test = '  Test9d: different animal; same collar; d1date =  t3, r1date = t5, d2date =  t1, r2date t2 -> null: '
	--Action/Test
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal2, @mfgr, @collar1, '2012-05-13', '2012-05-15'
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal1, @mfgr, @collar1, '2012-05-11', '2012-05-12'
	BEGIN TRY
		EXEC [dbo].[CollarDeployment_UpdateRetrievalDate] @project, @animal1, @mfgr, @collar1, '2012-05-11', NULL
		SET @msg = 'Failed'
	END TRY
	BEGIN CATCH
		SET @msg = 'Passed'
	END CATCH
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal2, @mfgr, @collar1, '2012-05-13'
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal1, @mfgr, @collar1, '2012-05-11'

	-- Test10
	SET @test = '  Test10: delete deployments: '
	--Test
	IF EXISTS (SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] IN (@animal1, @animal2))
		SET @msg = 'Failed'
	ELSE
		SET @msg = 'Passed'
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset



	-- Clean up
	PRINT '  Cleaning up'
	EXEC [dbo].[CollarFile_Delete] @fileid
	DELETE CollarDeployments Where [ProjectId] = @project 
	EXEC [dbo].[Collar_Delete] @mfgr, @collar1
	EXEC [dbo].[Collar_Delete] @mfgr, @collar2
	Delete Animals where ProjectId = @project -- SP checks if user is in role, which sa is not
	EXEC [dbo].[Project_Delete] @project

	-- Check that cleanup worked
	IF    EXISTS (SELECT 1 from Animals Where [ProjectId] = @project AND [AnimalId] IN (@animal1, @animal2))
       OR EXISTS (SELECT 1 from Projects Where [ProjectId] = @project)
       OR EXISTS (SELECT 1 from Collars Where [CollarManufacturer] = @mfgr AND [CollarId] IN (@collar1,@collar2))
	   OR EXISTS (SELECT 1 from CollarDeployments Where [ProjectId] = @project)
	   OR EXISTS (SELECT 1 from CollarFiles Where [FileId] = @FileId)
	   OR EXISTS (SELECT 1 from CollarDataTelonicsStoreOnBoard Where [FileId] = @FileId)
	   OR EXISTS (SELECT 1 from CollarFixes Where [FileId] = @fileid AND [CollarManufacturer] = @mfgr AND [CollarId] = @collar1)
	   OR EXISTS (SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] IN (@animal1, @animal2))
	   OR EXISTS (SELECT 1 from Movements Where [ProjectId] = @project AND [AnimalId] IN (@animal1, @animal2))
	BEGIN
		PRINT 'Test data not completely removed'
		RETURN 1
	END

	-- Remove the sa from project investigator
	DELETE [dbo].[ProjectInvestigators] WHERE  [Login] = @sa
	
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: June 13, 2012
-- Description:	Test the CollarDeployments InsertTrigger
-- =============================================
CREATE PROCEDURE [dbo].[Test_Trigger_CollarDeployments_Insert] 
AS
BEGIN
	SET NOCOUNT ON

	PRINT 'Test_Trigger_CollarDeployments_Insert'
	
	DECLARE
			@sa nvarchar(16) = 'sa',
			@project nvarchar(16) = 'p1__',
			@animal1 nvarchar(16) = 'a1__',
			@animal2 nvarchar(16) = 'a2__',
			@mfgr nvarchar(16) = 'Telonics',
			@model nvarchar(16) = 'TelonicsGen4',
			@collar1 nvarchar(16) = 'c1__',
			@collar2 nvarchar(16) = 'c2__',
			@file1 nvarchar(16) = 'f1__',
			@file1id int,
			@file2 nvarchar(16) = 'f2__',
			@file2id int,
			@format nvarchar(16) = 'A', -- Store on board format
			@test nvarchar(255) = null,
			@msg nvarchar(255) = null,
			@fix11 bigint,
			@fix12 bigint,
			@fix13 bigint,
			@fix21 bigint,
			@fix22 bigint,
			@fix23 bigint,
			@fix_l bigint
			
	-- This test must be run as SA, since others cannot operate on table directly
	-- This test the integrity of the tables underlying the Store Procedures available to users.
	-- Also SA can check user tables

	IF ORIGINAL_LOGIN() <> @sa
	BEGIN
		PRINT '  You must be the sa to run this test'
		RETURN 1
	END

/*
	-- Clean up mess if previous test failed; need to find and set the file id first
	SET @fileid = 140
	EXEC [dbo].[CollarFile_Delete] @fileid
	DELETE CollarDeployments Where [ProjectId] = @project 
	DELETE Collars where CollarManufacturer = @mfgr and CollarId = @collar
	Delete Animals where ProjectId = @project -- SP checks if user is in role, which sa is not
	EXEC [dbo].[Project_Delete] @project
	return 1
*/

	--Check to make sure we are not going to overwrite any data
	IF EXISTS (SELECT 1 from Projects Where [ProjectId] = @project)
    OR EXISTS (SELECT 1 from Collars Where [CollarManufacturer] = @mfgr AND [CollarId] IN (@collar1,@collar2))
	BEGIN
		PRINT '  Aborting tests.  Existing data conflicts with test data.'
		RETURN 1
	END
	
	-- Add the sa is a project investigator
	IF NOT EXISTS(SELECT 1 FROM [dbo].[ProjectInvestigators] WHERE [Login] = @sa)
	BEGIN
		INSERT [dbo].[ProjectInvestigators] ([Login],[Name],[Email],[Phone]) VALUES (@sa,@sa,@sa,@sa)
	END


	-- Setup for test
	EXEC [dbo].[Project_Insert] @project, @project, @sa
	EXEC [dbo].[Animal_Insert] @project, @animal1
	EXEC [dbo].[Animal_Insert] @project, @animal2, null, null, '2012-05-12 12:00'
	EXEC [dbo].[Collar_Insert] @mfgr, @collar1, @model ,@sa
	EXEC [dbo].[Collar_Insert] @mfgr, @collar2, @model ,@sa

	INSERT INTO dbo.CollarFiles ([FileName], [Project], [CollarManufacturer], [CollarId], [Format], [Status], [Contents])
		 VALUES (@file1, @project, @mfgr, @collar1, @format, 'A', convert(varbinary,'data'))  -- 'A' = Store on board
	SET @file1id = SCOPE_IDENTITY();
	INSERT INTO dbo.CollarDataTelonicsStoreOnBoard ([FileId], [LineNumber], [Date], [Latitude], [Longitude], [Fix Status])
		 VALUES (@file1id, 1, '2012-05-11', '60.11', '-154.11', 'Fix Available'),
		        (@file1id, 2, '2012-05-12', '60.12', '-154.12', 'Fix Available'),
		        (@file1id, 3, '2012-05-13', '60.13', '-154.13', 'Fix Available')
	EXEC [dbo].[CollarFixes_Insert] @file1id,@format

	INSERT INTO dbo.CollarFiles ([FileName], [Project], [CollarManufacturer], [CollarId], [Format], [Status], [Contents])
		 VALUES (@file2, @project, @mfgr, @collar2, @format, 'A', convert(varbinary,'data'))  -- 'A' = Store on board
	SET @file2id = SCOPE_IDENTITY();
	INSERT INTO dbo.CollarDataTelonicsStoreOnBoard ([FileId], [LineNumber], [Date], [Latitude], [Longitude], [Fix Status])
		 VALUES (@file2id, 1, '2012-05-11', '60.21', '-154.21', 'Fix Available'),
		        (@file2id, 2, '2012-05-12', '60.22', '-154.22', 'Fix Available'),
		        (@file2id, 3, '2012-05-13', '60.23', '-154.23', 'Fix Available')
	EXEC [dbo].[CollarFixes_Insert] @file2id,@format

	SELECT @fix11 = FixId FROM CollarFixes Where [FileId] = @file1id AND [LineNumber] = 1
	SELECT @fix12 = FixId FROM CollarFixes Where [FileId] = @file1id AND [LineNumber] = 2
	SELECT @fix13 = FixId FROM CollarFixes Where [FileId] = @file1id AND [LineNumber] = 3
	SELECT @fix21 = FixId FROM CollarFixes Where [FileId] = @file2id AND [LineNumber] = 1
	SELECT @fix22 = FixId FROM CollarFixes Where [FileId] = @file2id AND [LineNumber] = 2
	SELECT @fix23 = FixId FROM CollarFixes Where [FileId] = @file2id AND [LineNumber] = 3

	-- Check initial conditions
	IF    NOT EXISTS (SELECT 1 from Animals Where [ProjectId] = @project AND [AnimalId] IN (@animal1, @animal2))
       OR NOT EXISTS (SELECT 1 from Collars Where [CollarManufacturer] = @mfgr AND [CollarId] IN (@collar1,@collar2))
	   OR NOT EXISTS (SELECT 1 from CollarFiles Where [FileId] IN (@File1Id, @File2Id))
	   OR NOT EXISTS (SELECT 1 from CollarFixes Where [FileId] = @file1id AND [CollarManufacturer] = @mfgr AND [CollarId] = @collar1)
	   OR NOT EXISTS (SELECT 1 from CollarFixes Where [FileId] = @file2id AND [CollarManufacturer] = @mfgr AND [CollarId] = @collar2)
	   OR     EXISTS (SELECT 1 from CollarDeployments Where [ProjectId] = @project)
	   OR     EXISTS (SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] IN (@animal1, @animal2))
	   OR     EXISTS (SELECT 1 from Movements Where [ProjectId] = @project AND [AnimalId] IN (@animal1, @animal2))
	BEGIN
		PRINT '  Test data not initialized properly'
		RETURN 1
	END
	

	-- Do tests	

	-- Test1
	SET @test = '  Test1: multiple valid deployments: '
	--Action
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal1, @mfgr, @collar1, '2012-05-10 12:00', '2012-05-11 12:00'
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal1, @mfgr, @collar2, '2012-05-11 12:01'
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal2, @mfgr, @collar2, '2012-05-10 12:00', '2012-05-11 12:00'
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal2, @mfgr, @collar1, '2012-05-11 12:01'
	--Test
	SET @msg = ''

--SELECT * FROM Animals where [AnimalId] IN (@animal1, @animal2)
--SELECT * FROM CollarDeployments where [AnimalId] IN (@animal1, @animal2)
--SELECT * from CollarFixes Where [FileId] IN (@file1id, @file2id)
--SELECT * from Locations Where [ProjectId] = @project AND [AnimalId] IN (@animal1, @animal2)
--SELECT * from Movements Where [ProjectId] = @project AND [AnimalId] IN (@animal1, @animal2)

	SELECT 1 from CollarFixes Where [FileId] IN (@file1id, @file2id)
	IF @@ROWCOUNT <> 6
		SET @msg = @msg + ' Not 6 fixes'
	SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal1
	IF @@ROWCOUNT <> 3
		SET @msg = @msg + ' Not 3 locations for animal 1'
	SELECT 1 from Movements Where [ProjectId] = @project AND [AnimalId] = @animal1
	IF @@ROWCOUNT <> 2
		SET @msg = @msg + ' Not 2 movements for animal 1'
	SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] = @animal2
	IF @@ROWCOUNT <> 2
		SET @msg = @msg + ' Not 2 locations for animal 2'
	SELECT 1 from Movements Where [ProjectId] = @project AND [AnimalId] = @animal2
	IF @@ROWCOUNT <> 1
		SET @msg = @msg + ' Not 1 movements for animal 2'
		
	SELECT top 1 @fix_l = [FixId] FROM Locations Where [ProjectId] = @project AND [AnimalId] = @animal1 order by FixDate
	IF @fix11 <> @fix_l
		SET @msg = @msg + ' a1 loc1 is based on wrong fix'
		
	IF NOT EXISTS (SELECT 1 FROM Locations Where [ProjectId] = @project AND [AnimalId] = @animal1 AND FixId = @fix22)
		SET @msg = @msg + ' a1 loc2 is based on wrong fix'
	
	SELECT top 1 @fix_l = [FixId] FROM Locations Where [ProjectId] = @project AND [AnimalId] = @animal1 order by FixDate desc
	IF @fix23 <> @fix_l
		SET @msg = @msg + ' a1 loc3 is based on wrong fix'
	
	SELECT top 1 @fix_l = [FixId] FROM Locations Where [ProjectId] = @project AND [AnimalId] = @animal2 order by FixDate
	IF @fix21 <> @fix_l
		SET @msg = @msg + ' a2 loc1 is based on wrong fix'
	
	SELECT top 1 @fix_l = [FixId] FROM Locations Where [ProjectId] = @project AND [AnimalId] = @animal2 order by FixDate desc
	IF @fix12 <> @fix_l
		SET @msg = @msg + ' a2 loc2 is based on wrong fix'
	
	IF @msg = ''
		SET @msg = 'Passed'
	ELSE
		SET @msg = 'Failed' + @msg
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal1, @mfgr, @collar1, '2012-05-10 12:00'
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal1, @mfgr, @collar2, '2012-05-11 12:01'
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal2, @mfgr, @collar2, '2012-05-10 12:00'
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal2, @mfgr, @collar1, '2012-05-11 12:01'
	

	-- Test2
	SET @test = '  Test2: 2 collars on 1 animal Rdate1 = null : '
	--Action/Test
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal1, @mfgr, @collar1, '2012-05-10 12:00', NULL
	BEGIN TRY
		EXEC [dbo].[CollarDeployment_Insert] @project, @animal1, @mfgr, @collar2, '2012-05-11 12:00'
		SET @msg = 'Failed'
	END TRY
	BEGIN CATCH
		SET @msg = 'Passed'
	END CATCH
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal1, @mfgr, @collar1, '2012-05-10 12:00'
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal1, @mfgr, @collar2, '2012-05-11 12:00'

		
	-- Test3
	SET @test = '  Test3: 2 collars on 1 animal Rdate1 <> null : '
	--Action/Test
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal1, @mfgr, @collar1, '2012-05-10 12:00', '2012-05-12 12:00'
	BEGIN TRY
		EXEC [dbo].[CollarDeployment_Insert] @project, @animal1, @mfgr, @collar2, '2012-05-11 12:00'
		SET @msg = 'Failed'
	END TRY
	BEGIN CATCH
		SET @msg = 'Passed'
	END CATCH
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal1, @mfgr, @collar1, '2012-05-10 12:00'
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal1, @mfgr, @collar2, '2012-05-11 12:00'


	-- Test4
	SET @test = '  Test4: 2 collars on 1 animal Rdate1 = Ddate2 : '
	--Action/Test
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal1, @mfgr, @collar1, '2012-05-10 12:00', '2012-05-11 12:00'
	BEGIN TRY
		EXEC [dbo].[CollarDeployment_Insert] @project, @animal1, @mfgr, @collar2, '2012-05-11 12:00'
		SET @msg = 'Failed'
	END TRY
	BEGIN CATCH
		SET @msg = 'Passed'
	END CATCH
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal1, @mfgr, @collar1, '2012-05-10 12:00'
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal1, @mfgr, @collar2, '2012-05-11 12:00'


	-- Test5
	SET @test = '  Test5: 1 collar on 2 animals Rdate1 = null: '
	--Action/Test
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal1, @mfgr, @collar1, '2012-05-10 12:00', NULL
	BEGIN TRY
		EXEC [dbo].[CollarDeployment_Insert] @project, @animal2, @mfgr, @collar1, '2012-05-11 12:00'
		SET @msg = 'Failed'
	END TRY
	BEGIN CATCH
		SET @msg = 'Passed'
	END CATCH
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal1, @mfgr, @collar1, '2012-05-10 12:00'
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal2, @mfgr, @collar1, '2012-05-11 12:00'
		
		
	-- Test6
	SET @test = '  Test6: 1 collar on 2 animals Rdate1 <> null: '
	--Action/Test
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal1, @mfgr, @collar1, '2012-05-10 12:00', '2012-05-12 12:00'
	BEGIN TRY
		EXEC [dbo].[CollarDeployment_Insert] @project, @animal2, @mfgr, @collar1, '2012-05-11 12:00'
		SET @msg = 'Failed'
	END TRY
	BEGIN CATCH
		SET @msg = 'Passed'
	END CATCH
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal1, @mfgr, @collar1, '2012-05-10 12:00'
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal2, @mfgr, @collar1, '2012-05-11 12:00'
		

	-- Test7
	SET @test = '  Test7: 1 collar on 2 animals Rdate1 <> Ddate2: '
	--Action/Test
	EXEC [dbo].[CollarDeployment_Insert] @project, @animal1, @mfgr, @collar1, '2012-05-10 12:00', '2012-05-11 12:00'
	BEGIN TRY
		EXEC [dbo].[CollarDeployment_Insert] @project, @animal2, @mfgr, @collar1, '2012-05-11 12:00'
		SET @msg = 'Failed'
	END TRY
	BEGIN CATCH
		SET @msg = 'Passed'
	END CATCH
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal1, @mfgr, @collar1, '2012-05-10 12:00'
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal2, @mfgr, @collar1, '2012-05-11 12:00'


	-- Test8
	SET @test = '  Test8: Rdate = Ddate: '
	--Action/Test
	BEGIN TRY
		EXEC [dbo].[CollarDeployment_Insert] @project, @animal1, @mfgr, @collar1, '2012-05-10 12:00', '2012-05-10 12:00'
		SET @msg = 'Failed'
	END TRY
	BEGIN CATCH
		SET @msg = 'Passed'
	END CATCH
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal1, @mfgr, @collar1, '2012-05-10 12:00'


	-- Test9
	SET @test = '  Test9: Rdate < Ddate: '
	--Action/Test
	BEGIN TRY
		EXEC [dbo].[CollarDeployment_Insert] @project, @animal1, @mfgr, @collar1, '2012-05-11 12:00', '2012-05-10 12:00'
		SET @msg = 'Failed'
	END TRY
	BEGIN CATCH
		SET @msg = 'Passed'
	END CATCH
	--Report
	SET @msg = @test + @msg
	PRINT @msg
	--Reset
	EXEC [dbo].[CollarDeployment_Delete] @project, @animal1, @mfgr, @collar1, '2012-05-11 12:00'


	-- Clean up
	PRINT '  Cleaning up'
	EXEC [dbo].[CollarFile_Delete] @file1id
	EXEC [dbo].[CollarFile_Delete] @file2id
	DELETE CollarDeployments Where [ProjectId] = @project 
	EXEC [dbo].[Collar_Delete] @mfgr, @collar1
	EXEC [dbo].[Collar_Delete] @mfgr, @collar2
	Delete Animals where ProjectId = @project -- SP checks if user is in role, which sa is not
	EXEC [dbo].[Project_Delete] @project

	-- Check that cleanup worked
	IF    EXISTS (SELECT 1 from Animals Where [ProjectId] = @project AND [AnimalId] IN (@animal1, @animal2))
       OR EXISTS (SELECT 1 from Projects Where [ProjectId] = @project)
       OR EXISTS (SELECT 1 from Collars Where [CollarManufacturer] = @mfgr AND [CollarId] IN (@collar1,@collar2))
	   OR EXISTS (SELECT 1 from CollarDeployments Where [ProjectId] = @project)
	   OR EXISTS (SELECT 1 from CollarFiles Where [FileId] IN (@File1Id, @File2Id))
	   OR EXISTS (SELECT 1 from CollarDataTelonicsStoreOnBoard Where [FileId] IN (@File1Id, @File2Id))
	   OR EXISTS (SELECT 1 from CollarFixes Where [FileId] = @file1id AND [CollarManufacturer] = @mfgr AND [CollarId] = @collar1)
	   OR EXISTS (SELECT 1 from CollarFixes Where [FileId] = @file2id AND [CollarManufacturer] = @mfgr AND [CollarId] = @collar2)
	   OR EXISTS (SELECT 1 from Locations Where [ProjectId] = @project AND [AnimalId] IN (@animal1, @animal2))
	   OR EXISTS (SELECT 1 from Movements Where [ProjectId] = @project AND [AnimalId] IN (@animal1, @animal2))
	BEGIN
		PRINT 'Test data not completely removed'
		RETURN 1
	END

	-- Remove the sa from project investigator
	DELETE [dbo].[ProjectInvestigators] WHERE  [Login] = @sa
	
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: March 27, 2012
-- Description:	Removes an Investigator from the database
-- =============================================
CREATE PROCEDURE [dbo].[ProjectInvestigator_Delete_SA] 
	@Investigator sysname = Null
AS
BEGIN
	SET NOCOUNT ON;

	-- This can only be run be the Sysadmin
	-- This script is mostly to remind the SA of the steps, so there is no error checking.

	-- Remove the user to the Investigator table
	DELETE FROM [dbo].[ProjectInvestigators] WHERE [Login] = @Investigator;

	-- Remove the user from the Investigator role
	EXEC sp_droprolemember 'Investigator', @Investigator
	
	-- remove the user from the db, unless they are an editor
	IF EXISTS(SELECT 1 FROM [dbo].[ProjectEditors] WHERE [Editor] = @Investigator)
	BEGIN
		RETURN
	END
	EXEC ('DROP USER ['  + @Investigator + ']')

	-- remove the login (if it is not used anywhere else)	
	-- If the editor login does not map to a user on have any other databases, then remove the login
	DECLARE	@cmd nvarchar(500) = 'USE ?; IF EXISTS (SELECT 1 FROM sys.database_principals WHERE name = ''' + @Investigator + ''') raiserror('''',18,0)'
	DECLARE @Found int = 0
	begin try
		EXEC sp_MSforeachdb @cmd;
	end try
	BEGIN CATCH
		SET @Found = 1
	END CATCH

	IF @Found = 0
	BEGIN
		-- make sure the login does not have a server role
		IF NOT EXISTS (select 1 from sys.server_role_members AS R INNER JOIN sys.server_principals AS P 
					   ON R.member_principal_id = P.principal_id where P.name = @Investigator)
		BEGIN
			EXEC ('DROP LOGIN ['  + @Investigator + ']')
		END
	END
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: June 11, 2012
-- Description:	Test the ProjectEditor DeleteTrigger
-- =============================================
CREATE PROCEDURE [dbo].[Test_Trigger_ProjectEditor_Delete] 
AS
BEGIN
	SET NOCOUNT ON
	
	PRINT 'Test_Trigger_ProjectEditor_Delete'

	DECLARE
			@sa nvarchar(16) = 'sa',
			@p1 nvarchar(16) = 'p1',
			@p2 nvarchar(16) = 'p2',
			@e1 sysname  = 'NPS\JLPiercy',
			@e2 sysname  = 'NPS\JJCusick',
			@msg nvarchar(255) = null
			
	-- This test must be run as SA, since others cannot operate on table directly
	-- This test the integrity of the tables underlying the Store Procedures available to users.
	-- Also SA can check user tables

	IF ORIGINAL_LOGIN() <> @sa
	BEGIN
		PRINT '  You must be the sa to run this test'
		RETURN 1
	END

	-- Add the sa is a project investigator
	IF NOT EXISTS(SELECT 1 FROM [dbo].[ProjectInvestigators] WHERE [Login] = @sa)
	BEGIN
		INSERT [dbo].[ProjectInvestigators] ([Login],[Name],[Email],[Phone]) VALUES (@sa,@sa,@sa,@sa)
	END

	-- Make sure test projects/editors do not exist
	DELETE Projects Where ProjectId in (@p1, @p2)
	DELETE ProjectEditors Where Editor in (@e1, @e2)
	IF EXISTS (SELECT 1 from sys.database_principals WHERE type = 'U' AND name = @e1)
		EXEC ('DROP USER ['  + @e1 + ']')
	IF EXISTS (SELECT 1 from sys.database_principals WHERE type = 'U' AND name = @e2)
		EXEC ('DROP USER ['  + @e2 + ']')

	-- Create clean test projects
	INSERT Projects (ProjectId, ProjectName, ProjectInvestigator) VALUES (@p1, @p1, @sa)
	INSERT Projects (ProjectId, ProjectName, ProjectInvestigator) VALUES (@p2, @p2, @sa)

	-- Add Project Editors
	EXEC [dbo].[ProjectEditor_Insert] @p1, @e1
	EXEC [dbo].[ProjectEditor_Insert] @p2, @e1
	EXEC [dbo].[ProjectEditor_Insert] @p2, @e2


	-- Check that the editors exist and are in the editor role
	SELECT 1 from sys.database_role_members as M 
		     INNER JOIN sys.database_principals AS U  
		     ON M.member_principal_id = U.principal_id
		     INNER JOIN sys.database_principals AS R 
		     ON M.role_principal_id = R.principal_id 
		     WHERE R.name = 'Editor' AND U.name in (@e1, @e2)
	IF (@@ROWCOUNT <> 2)
	BEGIN
		PRINT '  Unable to initialize test'
		RETURN 1
	END
	

	-- Do tests
	PRINT '  Start with p1,e1 ; p2,e1 ; p2,e2'
	
	-- Test1
	--Action
	DELETE ProjectEditors where ProjectId = @p1 AND Editor = @e1
	--Test
	SET @msg = 'Failed (e1 or e2 is not in editor role)'
	SELECT 1 from sys.database_role_members as M 
		     INNER JOIN sys.database_principals AS U  
		     ON M.member_principal_id = U.principal_id
		     INNER JOIN sys.database_principals AS R 
		     ON M.role_principal_id = R.principal_id 
		     WHERE R.name = 'Editor' AND U.name in (@e1, @e2)
	IF (@@ROWCOUNT = 2)
		SET @msg = 'Passed'
	--Report
	SET @msg = '  Test1: delete p1,e1: ' + @msg
	PRINT @msg
	--Reset
	EXEC [dbo].[ProjectEditor_Insert] @p1, @e1

	-- Test2
	--Action
	DELETE ProjectEditors where ProjectId = @p2
	--Test
	SET @msg = 'Failed (e2 is a user, or e1 is not in editor role)'
	IF NOT EXISTS (SELECT 1 from sys.database_principals WHERE type = 'U' AND name = @e2)
	   AND EXISTS (SELECT 1 from sys.database_role_members as M 
		     INNER JOIN sys.database_principals AS U  
		     ON M.member_principal_id = U.principal_id
		     INNER JOIN sys.database_principals AS R 
		     ON M.role_principal_id = R.principal_id 
		     WHERE R.name = 'Editor' AND U.name = @e1)
		SET @msg = 'Passed'
	--Report
	SET @msg = '  Test2: delete p2, *: ' + @msg
	PRINT @msg
	--Reset
	EXEC [dbo].[ProjectEditor_Insert] @p2, @e1
	EXEC [dbo].[ProjectEditor_Insert] @p2, @e2
	
	-- Test3
	--Action
	DELETE ProjectEditors where (ProjectId = @p1 AND Editor = @e1) OR (ProjectId = @p2 AND Editor = @e2)
	--Test
	SET @msg = 'Failed (e2 is a user, or e1 is not in editor role)'
	IF NOT EXISTS (SELECT 1 from sys.database_principals WHERE type = 'U' AND name = @e2)
	   AND EXISTS (SELECT 1 from sys.database_role_members as M 
		     INNER JOIN sys.database_principals AS U  
		     ON M.member_principal_id = U.principal_id
		     INNER JOIN sys.database_principals AS R 
		     ON M.role_principal_id = R.principal_id 
		     WHERE R.name = 'Editor' AND U.name = @e1)
		SET @msg = 'Passed'
	--Report
	SET @msg = '  Test3: delete p1,e1 and p2,e2: ' + @msg
	PRINT @msg
	--Reset
	EXEC [dbo].[ProjectEditor_Insert] @p1, @e1
	EXEC [dbo].[ProjectEditor_Insert] @p2, @e2
	
	-- Test4
	--Action
	DELETE ProjectEditors where Editor = @e1
	--Test
	SET @msg = 'Failed (e1 is a user, or e2 is not in editor role)'
	IF NOT EXISTS (SELECT 1 from sys.database_principals WHERE type = 'U' AND name = @e1)
	   AND EXISTS (SELECT 1 from sys.database_role_members as M 
		     INNER JOIN sys.database_principals AS U  
		     ON M.member_principal_id = U.principal_id
		     INNER JOIN sys.database_principals AS R 
		     ON M.role_principal_id = R.principal_id 
		     WHERE R.name = 'Editor' AND U.name = @e2)
		SET @msg = 'Passed'
	--Report
	SET @msg = '  Test4: delete *, e1: ' + @msg
	PRINT @msg
	--Reset
	EXEC [dbo].[ProjectEditor_Insert] @p1, @e1
	EXEC [dbo].[ProjectEditor_Insert] @p2, @e1
	
	
	
	-- Clean up
	PRINT '  Cleaning up'
	DELETE Projects Where ProjectId in (@p1, @p2)
	DELETE ProjectEditors Where Editor in (@e1, @e2)
	IF EXISTS (SELECT 1 from sys.database_principals WHERE type = 'U' AND name = @e1)
		EXEC ('DROP USER ['  + @e1 + ']')
	IF EXISTS (SELECT 1 from sys.database_principals WHERE type = 'U' AND name = @e2)
		EXEC ('DROP USER ['  + @e2 + ']')

	-- Remove the sa from project investigator
	DELETE [dbo].[ProjectInvestigators] WHERE  [Login] = @sa
	
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: June 15, 2012
-- Description:	Run all the unit tests
-- =============================================
CREATE PROCEDURE [dbo].[Test_All] 
AS
BEGIN
	SET NOCOUNT ON
	
	IF ORIGINAL_LOGIN() <> 'sa'
	BEGIN
		PRINT 'You must be the sa to run many of these tests'
		RETURN 1
	END

	EXEC [dbo].[Test_Function_DoDateRangesOverlap]
	EXEC [dbo].[Test_Trigger_Animals_Update]
	EXEC [dbo].[Test_Trigger_CollarDeployments_Delete]
	EXEC [dbo].[Test_Trigger_CollarDeployments_Insert]
	EXEC [dbo].[Test_Trigger_CollarDeployments_Update]
	EXEC [dbo].[Test_Trigger_CollarFixes_Delete]
	EXEC [dbo].[Test_Trigger_CollarFixes_Insert]
	EXEC [dbo].[Test_Trigger_CollarFixes_Update]
	EXEC [dbo].[Test_Trigger_Locations_Delete]
	EXEC [dbo].[Test_Trigger_Locations_Insert]
	EXEC [dbo].[Test_Trigger_Locations_Update]
	EXEC [dbo].[Test_Trigger_ProjectEditor_Delete]
	
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* Protection Model
 * ================
 * All PIs and editors need permission to run this SP. - Done.
 * PIs can only modify projects for which they are the PI or an editor. - Done.
 * Editors can only modify projects for which they are an editor. - Done.
 * No one is allowed to modify the Project Id. - Done. (to change the ID you must deleted and recreate)
 * Only the PI is allowed to change the PI column. - Undone.  FIXME FIXME FIXME FIXME FIXME FIXME FIXME
 */

-- =============================================
-- Author:		Regan Sarwas
-- Create date: March 28, 2012
-- Description:	Updates a project name
-- =============================================
CREATE PROCEDURE [dbo].[Project_Update] 
	@ProjectId			 NVARCHAR(255)  = NULL,
	@ProjectName		 NVARCHAR(255)  = NULL, 
	@UnitCode			 NVARCHAR(255)  = NULL, 
	@ProjectInvestigator NVARCHAR(255)  = NULL, 
	@Description		 NVARCHAR(4000) = NULL 
AS
BEGIN
	SET NOCOUNT ON;

	-- Verify this is an existing project
	IF NOT EXISTS (SELECT 1 FROM [dbo].[Projects] WHERE [ProjectId] = @ProjectId)
	BEGIN
		DECLARE @message1 nvarchar(100) = 'Project (' + @ProjectId + ') is not an existing project.';
		RAISERROR(@message1, 18, 0)
		RETURN 1
	END
	
	-- You must be the ProjectInvestigator or and Editor on the project to update it
	--IF NOT EXISTS (SELECT 1 FROM [dbo].[Projects] WHERE [ProjectId] = @ProjectId AND [ProjectInvestigator] = ORIGINAL_LOGIN())
	IF [dbo].[IsEditor](@ProjectId, ORIGINAL_LOGIN()) = 0
	BEGIN
		DECLARE @message2 nvarchar(100) = 'You are not the owner or an editor of the ' + @ProjectId + ' project.';
		RAISERROR(@message2, 18, 0)
		RETURN 1
	END
	
	-- If a parameter is not provided, use the existing value.
	-- (to put null in a field the user will need to pass an empty string)
	IF @ProjectName IS NULL
	BEGIN
		SELECT @ProjectName = [ProjectName] FROM [dbo].[Projects] WHERE [ProjectId] = @ProjectId;
	END
	
	IF @UnitCode IS NULL
	BEGIN
		SELECT @UnitCode = [UnitCode] FROM [dbo].[Projects] WHERE [ProjectId] = @ProjectId;
	END
	
	IF @ProjectInvestigator IS NULL
	BEGIN
		SELECT @ProjectInvestigator = [ProjectInvestigator] FROM [dbo].[Projects] WHERE [ProjectId] = @ProjectId;
	END
	
	IF @Description IS NULL
	BEGIN
		SELECT @Description = [Description] FROM [dbo].[Projects] WHERE [ProjectId] = @ProjectId;
	END

	-- Do the update, replacing empty strings with NULLs
	UPDATE dbo.Projects SET [ProjectName]		  = nullif(@ProjectName,''),
							[UnitCode]			  = nullif(@UnitCode,''),
							[ProjectInvestigator] = nullif(@ProjectInvestigator,''),
							[Description]		  = nullif(@Description,'')
					  WHERE [ProjectId]			  = @ProjectId

END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: November 9, 2012
-- Description:	Updates a CollarParameter Assignment.
--              You can only edit the dates, if the
--              collar/file relationship is wrong then delete it
-- =============================================
CREATE PROCEDURE [dbo].[CollarParameter_Update] 
	@CollarManufacturer NVARCHAR(255) = NULL,
	@CollarId			NVARCHAR(255) = NULL, 
	@FileId				INT = NULL,
	@StartDate			DATETIME2 = NULL, 
	@EndDate			DATETIME2 = NULL
AS
BEGIN
	SET NOCOUNT ON;

	-- Get the name of the caller
	DECLARE @Caller sysname = ORIGINAL_LOGIN();

	-- Validate permission for this operation
	
	-- The caller must be an editor in the database, handled by execute permissions
	
	-- Verify that the relationship exists (this is done now to avoid a confusing silent No-op)
	IF NOT EXISTS (SELECT 1 FROM [dbo].[CollarParameters]
				   WHERE [CollarManufacturer] = @CollarManufacturer AND [CollarId] = @CollarId
				     AND [FileId] = @FileId
			      )
	BEGIN
		RAISERROR('The collar/file relationship you want to change was not found.', 18, 0)
		RETURN (1)
	END

	-- The caller must be the owner of the oollar or the file or the uploader of the file
	IF NOT EXISTS (SELECT 1 FROM [dbo].[CollarParameterFiles] WHERE [FileId] = @FileId AND ([Owner] = @Caller OR [UploadUser] = @Caller))
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM [dbo].[Collars] WHERE [CollarManufacturer] = @CollarManufacturer AND [CollarId] = @CollarId AND [Manager] = @Caller)
		BEGIN
			DECLARE @message1 nvarchar(200) = 'You ('+@Caller+') must be the owner of the collar, or the owner or the Uploader of the collar parameter file to add this relationship.';
			RAISERROR(@message1, 18, 0)
			RETURN (1)
		END
	END

	-- Verify the end occurs after the start
	IF @EndDate IS NOT NULL AND @EndDate <= @StartDate
	BEGIN
		RAISERROR('The end date must occur after the start date.', 18, 0)
		RETURN (1)
	END

	-- Verify that this proposed date range does not overlap with another date ranges for this collar
	-- A collar/file combo is unique.  A collar can have different files, but they must have different date ranges.
	-- You cannot have C1/F1 from D1 to D2 and then again from D3 to D4, because C1/F1 must be unique for each record.
	-- to do this, upload the same file as F2
	IF EXISTS (SELECT 1 FROM [dbo].[CollarParameters]
				WHERE [CollarManufacturer] = @CollarManufacturer AND [CollarId] = @CollarId
				  AND [FileId] <> @FileId  -- don't check for overlap with myself
				  AND [dbo].[DoDateRangesOverlap]([StartDate], [EndDate], @StartDate, @EndDate) = 1
			  )
	BEGIN
		DECLARE @message4 nvarchar(200) = 'This collar ('+@CollarManufacturer+'-'+@CollarId+') is already associated with a file during your date range.'
		RAISERROR(@message4, 18, 0)
		RETURN (1)
	END
	

	-- All other verification is handled by primary/foreign key and column constraints.
	UPDATE [dbo].[CollarParameters] SET [StartDate] = @StartDate, [EndDate] = @EndDate
		 WHERE [CollarManufacturer] = @CollarManufacturer AND [CollarId] = @CollarId AND [FileId] = @FileId

END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: November 9, 2012
-- Description:	Adds a new collar parameter to the database.
-- =============================================
CREATE PROCEDURE [dbo].[CollarParameter_Insert] 
	@CollarManufacturer NVARCHAR(255) = NULL,
	@CollarId			NVARCHAR(255) = NULL, 
	@FileId				INT = NULL,
	@StartDate			DATETIME2 = NULL, 
	@EndDate			DATETIME2 = NULL
AS
BEGIN
	SET NOCOUNT ON;
    
	-- Get the name of the caller
	DECLARE @Caller sysname = ORIGINAL_LOGIN();

	-- Validate permission for this operation

	-- The caller must be an editor in the database, handled by execute permissions
	
	-- The caller must be the owner of the oollar or the file or the uploader of the file
	IF NOT EXISTS (SELECT 1 FROM [dbo].[CollarParameterFiles] WHERE [FileId] = @FileId AND ([Owner] = @Caller OR [UploadUser] = @Caller))
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM dbo.Collars WHERE CollarManufacturer = @CollarManufacturer AND CollarId = @CollarId AND [Manager] = @Caller)
		BEGIN
			DECLARE @message1 nvarchar(200) = 'You ('+@Caller+') must be the owner of the collar, or the owner or the Uploader of the collar parameter file to add this relationship.';
			RAISERROR(@message1, 18, 0)
			RETURN (1)
		END
	END

	
	-- Verify the end occurs after the start
	IF @EndDate IS NOT NULL AND @EndDate <= @StartDate
	BEGIN
		RAISERROR('The end date must occur after the start date.', 18, 0)
		RETURN (1)
	END

	-- Verify that this proposed date range does not overlap with another date ranges for this Collar
	-- A collar/file combo is unique.  A collar can have multiple files, but they must have different date ranges.
	IF EXISTS (SELECT 1 FROM dbo.CollarParameters
				WHERE CollarManufacturer = @CollarManufacturer AND CollarId = @CollarId
				  AND dbo.DoDateRangesOverlap(StartDate, EndDate, @StartDate, @EndDate) = 1
			  )
	BEGIN
		DECLARE @message4 nvarchar(200) = 'This collar ('+@CollarManufacturer+'-'+@CollarId+') is already associated with a file during your date range.'
		RAISERROR(@message4, 18, 0)
		RETURN (1)
	END
	

	-- All other verification is handled by primary/foreign key and column constraints.
	-- You cannot have C1/F1 from D1 to D2 and then again from D3 to D4, because C1/F1 must be unique for each record.
	-- to do this, upload the same file as F2
	INSERT INTO dbo.CollarParameters ([CollarManufacturer], [CollarId], [FileId], [StartDate], [EndDate])
		 VALUES (@CollarManufacturer, @CollarId, @FileId, @StartDate, @EndDate)

END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: November 9, 2012
-- Description:	Deletes a CollarParameter from the database
-- =============================================
CREATE PROCEDURE [dbo].[CollarParameter_Delete] 
	@CollarManufacturer NVARCHAR(255)= NULL,
	@CollarId NVARCHAR(255) = NULL,
	@FileId int = -1
AS
BEGIN
	SET NOCOUNT ON;
	
	-- Get the name of the caller
	DECLARE @Caller sysname = ORIGINAL_LOGIN();

	-- Validate permission for this operation

	-- The caller must be an editor in the database - handled by execute permissions

	-- Verify that the relationship exists (this is done now to avoid the following check issuing a confusing error)
	IF NOT EXISTS (SELECT 1 FROM [dbo].[CollarParameters] WHERE [CollarManufacturer] = @CollarManufacturer AND [CollarId] = @CollarId AND [FileId] = @FileId)
	BEGIN
		RAISERROR('The collar/file relationship you want to delete was not found.', 18, 0)
		RETURN (1)
	END

	-- The caller must be
	--    the owner or the Uploader of the collar parameter file
	--    or the owner of to collar to delete the parameter assignment
	IF NOT EXISTS (SELECT 1 FROM [dbo].[CollarParameterFiles] WHERE [FileId] = @FileId AND ([Owner] = @Caller OR [UploadUser] = @Caller))
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM dbo.Collars WHERE CollarManufacturer = @CollarManufacturer AND CollarId = @CollarId AND [Manager] = @Caller)
		BEGIN
			DECLARE @message1 nvarchar(200) = 'You ('+@Caller+') must be the owner of the collar, or the owner or the Uploader of the collar parameter file (Id = '+str(@FileId)+') to delete it.';
			RAISERROR(@message1, 18, 0)
			RETURN (1)
		END
	END

	-- deleting a non-existant file will silently succeed.
	-- All other verification is handled by primary/foreign key and column constraints.
	DELETE FROM dbo.CollarParameters WHERE CollarManufacturer = @CollarManufacturer AND CollarId = @CollarId AND FileId = @FileId;
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: March 2, 2012
-- Description:	Parses the data in a Collar File
-- =============================================
CREATE PROCEDURE [dbo].[CollarData_Insert] 
	@FileId INT,
	@Format CHAR
AS
BEGIN
	SET NOCOUNT ON;
	
	-- This is not executed directly, only by CollarFile_Insert 

	IF @Format = 'A'  -- Store on board
	BEGIN
		-- only parse the data if it is not already in the file
		IF NOT EXISTS (SELECT 1 FROM [dbo].[CollarDataTelonicsStoreOnBoard] WHERE [FileId] = @FileId)
		BEGIN
			INSERT INTO [dbo].[CollarDataTelonicsStoreOnBoard] SELECT @FileId as FileId, * FROM [dbo].[ParseFormatA] (@FileId) 
		END
	END
		
	IF @Format = 'B'  -- Debevek Format
	BEGIN
		-- only parse the data if it is not already in the file
		IF NOT EXISTS (SELECT 1 FROM [dbo].[CollarDataDebevekFormat] WHERE [FileId] = @FileId)
		BEGIN
			INSERT INTO [dbo].[CollarDataDebevekFormat] SELECT @FileId as FileId, * FROM [dbo].[ParseFormatB] (@FileId) 
		END
	END
	
	IF @Format = 'C'  -- Telonics Gen4 Convertor Format
	BEGIN
		-- only parse the data if it is not already in the file
		IF NOT EXISTS (SELECT 1 FROM [dbo].[CollarDataTelonicsGen4] WHERE [FileId] = @FileId)
		BEGIN
			INSERT INTO [dbo].[CollarDataTelonicsGen4] SELECT @FileId as FileId, * FROM [dbo].[ParseFormatC] (@FileId) 
		END
	END
	
	IF @Format = 'D'  -- Telonics Gen3 Convertor Format
	BEGIN
		-- only parse the data if it is not already in the file
		IF NOT EXISTS (SELECT 1 FROM [dbo].[CollarDataTelonicsGen3] WHERE [FileId] = @FileId)
		BEGIN
			INSERT INTO [dbo].[CollarDataTelonicsGen3] SELECT @FileId as FileId, * FROM [dbo].[ParseFormatD] (@FileId) 
		END
	END
	
	-- FIXME: Add other formats
	
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Regan Sarwas
-- Create date: March 3, 2012
-- Description:	Adds a new collar file to the database.
-- =============================================
CREATE PROCEDURE [dbo].[CollarFile_Insert] 
	@FileName NVARCHAR(255) = NULL,
	@ProjectId NVARCHAR(255) = NULL, 
	@CollarManufacturer NVARCHAR(255) = NULL, 
	@CollarId NVARCHAR(255) = NULL, 
	@Format CHAR = NULL, 
	@Status CHAR = NULL, 
	@Contents VARBINARY(max) = NULL,
	@ParentFileId INT = NULL,
	@FileId INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
    
	-- Get the name of the caller
	DECLARE @Caller sysname = ORIGINAL_LOGIN();

	-- Validate permission for this operation
	-- The caller must be the PI or editor on the project
	IF NOT EXISTS (SELECT 1 FROM dbo.Projects WHERE ProjectId = @ProjectId AND ProjectInvestigator = @Caller)
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM dbo.ProjectEditors WHERE ProjectId = @ProjectId AND Editor = @Caller)
		BEGIN
			DECLARE @message4 nvarchar(200) = 'You ('+@Caller+') must be the principal investigator or editor on this project ('+@ProjectId+') to add a collar file.';
			RAISERROR(@message4, 18, 0)
			RETURN (1)
		END
	END
	
	--CollarId is not managed by referential integrity, since there may be multiple collars in a data file
	
	-- The need to provide a CollarId is determined by the file format, so check it. 	
	DECLARE @HasCollarId CHAR(1) = NULL
	SELECT @HasCollarId = HasCollarIdColumn FROM dbo.LookupCollarFileFormats WHERE Code = @Format;
	IF @HasCollarId IS NULL
	BEGIN
		DECLARE @message1 nvarchar(100) = 'Invalid parameter: Format (' + @Format + ') was not found in the LookupCollarFileFormats table';
		RAISERROR(@message1, 18, 0)
		RETURN (1)
	END

	-- If the collar is required, make sure it is provided
	IF @CollarId IS NULL AND (@HasCollarId = 'N')
	BEGIN
		DECLARE @message2 nvarchar(100) = 'Invalid parameter: CollarId must not be null with file format ' + @Format + '.';
		RAISERROR(@message2, 18, 0)
		RETURN (1)
	END
	
	-- If the collar was provided, make sure it is a valid collar
	IF @CollarId IS NOT NULL AND
	   NOT EXISTS (SELECT 1 FROM [dbo].[Collars] WHERE [CollarManufacturer] = @CollarManufacturer
												   AND [CollarId] = @CollarId)
	BEGIN
		DECLARE @message3 nvarchar(100) = 'Invalid parameter: CollarId (' + @CollarId + ') was not found in the Collars table';
		RAISERROR(@message3, 18, 0)
		RETURN (1)
	END
	
	-- If a ParentFileId was given, make sure it is valid
	IF @ParentFileId IS NOT NULL AND
	   NOT EXISTS (SELECT 1 FROM [dbo].[CollarFiles] WHERE [FileId] = @ParentFileId)
	BEGIN
		DECLARE @message5 nvarchar(100) = 'Invalid parameter: ParentFileId ' + CAST(@ParentFileId AS VARCHAR(10)) + ' was not found in the CollarFiles table';
		RAISERROR(@message5, 18, 0)
		RETURN (1)
	END
	
	
	BEGIN TRY
		BEGIN TRAN
			INSERT INTO dbo.CollarFiles ([FileName], [Project], [CollarManufacturer], [CollarId], [Format], [Status], [Contents], [ParentFileId])
				 VALUES (@FileName, @ProjectId, @CollarManufacturer, @CollarId, @Format, @Status, @Contents, @ParentFileId)

			SET @FileId = SCOPE_IDENTITY();

			EXEC [dbo].[CollarData_Insert] @FileId, @Format
			EXEC [dbo].[CollarFixes_Insert] @FileId, @Format
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		IF XACT_STATE() <> 0
			ROLLBACK TRANSACTION;
		EXEC [dbo].[Utility_RethrowError]
		RETURN (1)
	END CATCH
END
GO
ALTER TABLE [dbo].[CollarFiles] ADD  CONSTRAINT [DF_CollarFiles_UploadDate]  DEFAULT (getdate()) FOR [UploadDate]
GO
ALTER TABLE [dbo].[CollarFiles] ADD  CONSTRAINT [DF_CollarFiles_UserName]  DEFAULT (original_login()) FOR [UserName]
GO
ALTER TABLE [dbo].[CollarFiles] ADD  CONSTRAINT [DF_CollarFiles_Status]  DEFAULT ('I') FOR [Status]
GO
ALTER TABLE [dbo].[CollarParameterFiles] ADD  CONSTRAINT [DF_CollarParameterFiles_UploadDate]  DEFAULT (getdate()) FOR [UploadDate]
GO
ALTER TABLE [dbo].[CollarParameterFiles] ADD  CONSTRAINT [DF_CollarParameterFiles_UploadUser]  DEFAULT (original_login()) FOR [UploadUser]
GO
ALTER TABLE [dbo].[Collars] ADD  CONSTRAINT [DF_Collars_Manager]  DEFAULT (original_login()) FOR [Manager]
GO
ALTER TABLE [dbo].[Collars] ADD  CONSTRAINT [DF_Collars_Owner]  DEFAULT ('NPS') FOR [Owner]
GO
ALTER TABLE [dbo].[Projects] ADD  CONSTRAINT [DF_Projects_PrincipalInvestigator]  DEFAULT (original_login()) FOR [ProjectInvestigator]
GO
ALTER TABLE [dbo].[LookupCollarFileFormats]  WITH CHECK ADD  CONSTRAINT [CK_LookupCollarFileFormats] CHECK  (([HasCollarIdColumn]='Y' OR [HasCollarIdColumn]='N'))
GO
ALTER TABLE [dbo].[LookupCollarFileFormats] CHECK CONSTRAINT [CK_LookupCollarFileFormats]
GO
ALTER TABLE [dbo].[Animals]  WITH CHECK ADD  CONSTRAINT [FK_Animals_Gender] FOREIGN KEY([Gender])
REFERENCES [dbo].[LookupGender] ([Sex])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Animals] CHECK CONSTRAINT [FK_Animals_Gender]
GO
ALTER TABLE [dbo].[Animals]  WITH CHECK ADD  CONSTRAINT [FK_Animals_Projects] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[Projects] ([ProjectId])
GO
ALTER TABLE [dbo].[Animals] CHECK CONSTRAINT [FK_Animals_Projects]
GO
ALTER TABLE [dbo].[Animals]  WITH CHECK ADD  CONSTRAINT [FK_Animals_Species] FOREIGN KEY([Species])
REFERENCES [dbo].[LookupSpecies] ([Species])
GO
ALTER TABLE [dbo].[Animals] CHECK CONSTRAINT [FK_Animals_Species]
GO
ALTER TABLE [dbo].[CollarDataDebevekFormat]  WITH CHECK ADD  CONSTRAINT [FK_CollarDataDebevekFormat_CollarFiles] FOREIGN KEY([FileID])
REFERENCES [dbo].[CollarFiles] ([FileId])
GO
ALTER TABLE [dbo].[CollarDataDebevekFormat] CHECK CONSTRAINT [FK_CollarDataDebevekFormat_CollarFiles]
GO
ALTER TABLE [dbo].[CollarDataTelonicsGen3]  WITH CHECK ADD  CONSTRAINT [FK_CollarDataTelonicsGen3_CollarFiles] FOREIGN KEY([FileId])
REFERENCES [dbo].[CollarFiles] ([FileId])
GO
ALTER TABLE [dbo].[CollarDataTelonicsGen3] CHECK CONSTRAINT [FK_CollarDataTelonicsGen3_CollarFiles]
GO
ALTER TABLE [dbo].[CollarDataTelonicsGen4]  WITH CHECK ADD  CONSTRAINT [FK_CollarDataTelonicsGen4_CollarFiles] FOREIGN KEY([FileId])
REFERENCES [dbo].[CollarFiles] ([FileId])
GO
ALTER TABLE [dbo].[CollarDataTelonicsGen4] CHECK CONSTRAINT [FK_CollarDataTelonicsGen4_CollarFiles]
GO
ALTER TABLE [dbo].[CollarDataTelonicsStoreOnBoard]  WITH CHECK ADD  CONSTRAINT [FK_CollarDataTelonicsStoreOnBoard_CollarFiles] FOREIGN KEY([FileId])
REFERENCES [dbo].[CollarFiles] ([FileId])
GO
ALTER TABLE [dbo].[CollarDataTelonicsStoreOnBoard] CHECK CONSTRAINT [FK_CollarDataTelonicsStoreOnBoard_CollarFiles]
GO
ALTER TABLE [dbo].[CollarDeployments]  WITH CHECK ADD  CONSTRAINT [FK_CollarDeployments_Animals] FOREIGN KEY([ProjectId], [AnimalId])
REFERENCES [dbo].[Animals] ([ProjectId], [AnimalId])
GO
ALTER TABLE [dbo].[CollarDeployments] CHECK CONSTRAINT [FK_CollarDeployments_Animals]
GO
ALTER TABLE [dbo].[CollarDeployments]  WITH CHECK ADD  CONSTRAINT [FK_CollarDeployments_Collars] FOREIGN KEY([CollarManufacturer], [CollarId])
REFERENCES [dbo].[Collars] ([CollarManufacturer], [CollarId])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[CollarDeployments] CHECK CONSTRAINT [FK_CollarDeployments_Collars]
GO
ALTER TABLE [dbo].[CollarFiles]  WITH CHECK ADD  CONSTRAINT [FK_CollarFiles_LookupCollarFileFormats] FOREIGN KEY([Format])
REFERENCES [dbo].[LookupCollarFileFormats] ([Code])
GO
ALTER TABLE [dbo].[CollarFiles] CHECK CONSTRAINT [FK_CollarFiles_LookupCollarFileFormats]
GO
ALTER TABLE [dbo].[CollarFiles]  WITH CHECK ADD  CONSTRAINT [FK_CollarFiles_LookupCollarFileStatus] FOREIGN KEY([Status])
REFERENCES [dbo].[LookupCollarFileStatus] ([Code])
GO
ALTER TABLE [dbo].[CollarFiles] CHECK CONSTRAINT [FK_CollarFiles_LookupCollarFileStatus]
GO
ALTER TABLE [dbo].[CollarFiles]  WITH CHECK ADD  CONSTRAINT [FK_CollarFiles_LookupCollarManufacturers] FOREIGN KEY([CollarManufacturer])
REFERENCES [dbo].[LookupCollarManufacturers] ([CollarManufacturer])
GO
ALTER TABLE [dbo].[CollarFiles] CHECK CONSTRAINT [FK_CollarFiles_LookupCollarManufacturers]
GO
ALTER TABLE [dbo].[CollarFiles]  WITH CHECK ADD  CONSTRAINT [FK_CollarFiles_Projects] FOREIGN KEY([Project])
REFERENCES [dbo].[Projects] ([ProjectId])
GO
ALTER TABLE [dbo].[CollarFiles] CHECK CONSTRAINT [FK_CollarFiles_Projects]
GO
ALTER TABLE [dbo].[CollarFixes]  WITH CHECK ADD  CONSTRAINT [FK_CollarFixes_CollarFiles] FOREIGN KEY([FileId])
REFERENCES [dbo].[CollarFiles] ([FileId])
GO
ALTER TABLE [dbo].[CollarFixes] CHECK CONSTRAINT [FK_CollarFixes_CollarFiles]
GO
ALTER TABLE [dbo].[CollarFixes]  WITH CHECK ADD  CONSTRAINT [FK_CollarFixes_Collars] FOREIGN KEY([CollarManufacturer], [CollarId])
REFERENCES [dbo].[Collars] ([CollarManufacturer], [CollarId])
GO
ALTER TABLE [dbo].[CollarFixes] CHECK CONSTRAINT [FK_CollarFixes_Collars]
GO
ALTER TABLE [dbo].[CollarParameterFiles]  WITH CHECK ADD  CONSTRAINT [FK_CollarParameterFiles_LookupParameterFileFormats] FOREIGN KEY([Format])
REFERENCES [dbo].[LookupCollarParameterFileFormats] ([Code])
GO
ALTER TABLE [dbo].[CollarParameterFiles] CHECK CONSTRAINT [FK_CollarParameterFiles_LookupParameterFileFormats]
GO
ALTER TABLE [dbo].[CollarParameterFiles]  WITH CHECK ADD  CONSTRAINT [FK_CollarParameterFiles_ProjectInvestigators] FOREIGN KEY([Owner])
REFERENCES [dbo].[ProjectInvestigators] ([Login])
GO
ALTER TABLE [dbo].[CollarParameterFiles] CHECK CONSTRAINT [FK_CollarParameterFiles_ProjectInvestigators]
GO
ALTER TABLE [dbo].[CollarParameters]  WITH CHECK ADD  CONSTRAINT [FK_CollarParameters_CollarParameterFiles] FOREIGN KEY([FileId])
REFERENCES [dbo].[CollarParameterFiles] ([FileId])
GO
ALTER TABLE [dbo].[CollarParameters] CHECK CONSTRAINT [FK_CollarParameters_CollarParameterFiles]
GO
ALTER TABLE [dbo].[CollarParameters]  WITH CHECK ADD  CONSTRAINT [FK_CollarParameters_Collars] FOREIGN KEY([CollarManufacturer], [CollarId])
REFERENCES [dbo].[Collars] ([CollarManufacturer], [CollarId])
GO
ALTER TABLE [dbo].[CollarParameters] CHECK CONSTRAINT [FK_CollarParameters_Collars]
GO
ALTER TABLE [dbo].[Collars]  WITH CHECK ADD  CONSTRAINT [FK_Collars_LookupCollarManufacturers] FOREIGN KEY([CollarManufacturer])
REFERENCES [dbo].[LookupCollarManufacturers] ([CollarManufacturer])
GO
ALTER TABLE [dbo].[Collars] CHECK CONSTRAINT [FK_Collars_LookupCollarManufacturers]
GO
ALTER TABLE [dbo].[Collars]  WITH CHECK ADD  CONSTRAINT [FK_Collars_LookupCollarModels] FOREIGN KEY([CollarModel])
REFERENCES [dbo].[LookupCollarModels] ([CollarModel])
GO
ALTER TABLE [dbo].[Collars] CHECK CONSTRAINT [FK_Collars_LookupCollarModels]
GO
ALTER TABLE [dbo].[Collars]  WITH CHECK ADD  CONSTRAINT [FK_Collars_Managers] FOREIGN KEY([Manager])
REFERENCES [dbo].[ProjectInvestigators] ([Login])
GO
ALTER TABLE [dbo].[Collars] CHECK CONSTRAINT [FK_Collars_Managers]
GO
ALTER TABLE [dbo].[Locations]  WITH CHECK ADD  CONSTRAINT [FK_Locations_Animals] FOREIGN KEY([ProjectId], [AnimalId])
REFERENCES [dbo].[Animals] ([ProjectId], [AnimalId])
GO
ALTER TABLE [dbo].[Locations] CHECK CONSTRAINT [FK_Locations_Animals]
GO
ALTER TABLE [dbo].[Locations]  WITH CHECK ADD  CONSTRAINT [FK_Locations_CollarFixes] FOREIGN KEY([FixId])
REFERENCES [dbo].[CollarFixes] ([FixId])
GO
ALTER TABLE [dbo].[Locations] CHECK CONSTRAINT [FK_Locations_CollarFixes]
GO
ALTER TABLE [dbo].[LookupCollarFileFormats]  WITH CHECK ADD  CONSTRAINT [FK_LookupCollarFileFormats_LookupCollarManufacturer] FOREIGN KEY([CollarManufacturer])
REFERENCES [dbo].[LookupCollarManufacturers] ([CollarManufacturer])
GO
ALTER TABLE [dbo].[LookupCollarFileFormats] CHECK CONSTRAINT [FK_LookupCollarFileFormats_LookupCollarManufacturer]
GO
ALTER TABLE [dbo].[LookupCollarFileHeaders]  WITH CHECK ADD  CONSTRAINT [FK_CollarFileHeaders_LookupCollarFileFormats] FOREIGN KEY([FileFormat])
REFERENCES [dbo].[LookupCollarFileFormats] ([Code])
GO
ALTER TABLE [dbo].[LookupCollarFileHeaders] CHECK CONSTRAINT [FK_CollarFileHeaders_LookupCollarFileFormats]
GO
ALTER TABLE [dbo].[LookupCollarParameterFileFormats]  WITH CHECK ADD  CONSTRAINT [FK_LookupCollarParameterFileFormats_LookupCollarManufacturer] FOREIGN KEY([CollarManufacturer])
REFERENCES [dbo].[LookupCollarManufacturers] ([CollarManufacturer])
GO
ALTER TABLE [dbo].[LookupCollarParameterFileFormats] CHECK CONSTRAINT [FK_LookupCollarParameterFileFormats_LookupCollarManufacturer]
GO
ALTER TABLE [dbo].[Movements]  WITH CHECK ADD  CONSTRAINT [FK_Movements_Animals] FOREIGN KEY([ProjectId], [AnimalId])
REFERENCES [dbo].[Animals] ([ProjectId], [AnimalId])
GO
ALTER TABLE [dbo].[Movements] CHECK CONSTRAINT [FK_Movements_Animals]
GO
ALTER TABLE [dbo].[ProjectEditors]  WITH CHECK ADD  CONSTRAINT [FK_ProjectEditors_Projects] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[Projects] ([ProjectId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProjectEditors] CHECK CONSTRAINT [FK_ProjectEditors_Projects]
GO
ALTER TABLE [dbo].[Projects]  WITH CHECK ADD  CONSTRAINT [FK_Projects_ProjectInvestigators] FOREIGN KEY([ProjectInvestigator])
REFERENCES [dbo].[ProjectInvestigators] ([Login])
GO
ALTER TABLE [dbo].[Projects] CHECK CONSTRAINT [FK_Projects_ProjectInvestigators]
GO
GRANT EXECUTE ON [dbo].[Animal_Delete] TO [Editor] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[Animal_Insert] TO [Editor] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[Animal_Update] TO [Editor] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[Collar_Delete] TO [Editor] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[Collar_Insert] TO [Editor] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[Collar_Update] TO [Editor] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[CollarDeployment_Delete] TO [Editor] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[CollarDeployment_Insert] TO [Editor] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[CollarDeployment_UpdateRetrievalDate] TO [Editor] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[CollarFile_Delete] TO [Editor] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[CollarFile_Insert] TO [Editor] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[CollarFile_Update] TO [Editor] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[CollarFile_UpdateStatus] TO [Editor] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[CollarFixes_UpdateUnhideFix] TO [Editor] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[CollarParameter_Delete] TO [Editor] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[CollarParameter_Insert] TO [Editor] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[CollarParameter_Update] TO [Editor] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[CollarParameterFile_Delete] TO [Editor] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[CollarParameterFile_Insert] TO [Editor] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[CollarParameterFile_Update] TO [Editor] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[Location_UpdateStatus] TO [Editor] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[Project_Delete] TO [Investigator] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[Project_Insert] TO [Investigator] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[Project_Update] TO [Editor] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[ProjectEditor_Delete] TO [Investigator] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[ProjectEditor_Insert] TO [Investigator] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[ProjectInvestigator_Update] TO [Investigator] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[Settings_Update] TO [NPS\Domain Users] AS [dbo]
GO
GRANT SELECT ON [dbo].[AnimalLocationSummary] TO [NPS\Domain Users] AS [dbo]
GO
GRANT SELECT ON [dbo].[CollarFixesByFile] TO [NPS\Domain Users] AS [dbo]
GO
GRANT SELECT ON [dbo].[CollarFixSummary] TO [NPS\Domain Users] AS [dbo]
GO
GRANT SELECT ON [dbo].[ConflictingFixes] TO [NPS\Domain Users] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[DateTimeToOrdinal] TO [NPS\Domain Users] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[IsEditor] TO [NPS\Domain Users] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[IsFixEditor] TO [NPS\Domain Users] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[NextAnimalId] TO [Editor] AS [dbo]
GO
GRANT SELECT ON [dbo].[PotentialCollarParameterFilesForFormatAndCollarFile] TO [NPS\Domain Users] AS [dbo]
GO
GRANT ALTER ON ROLE::[Editor] TO [Investigator] AS [dbo]
GO
EXEC dbo.sp_addrolemember @rolename=N'Editor', @membername=N'NPS\SDMiller'
GO
EXEC dbo.sp_addrolemember @rolename=N'Editor', @membername=N'NPS\RESarwas'
GO
EXEC dbo.sp_addrolemember @rolename=N'Editor', @membername=N'NPS\KCJoly'
GO
EXEC dbo.sp_addrolemember @rolename=N'Editor', @membername=N'NPS\BAMangipane'
GO
EXEC dbo.sp_addrolemember @rolename=N'Editor', @membername=N'NPS\JWBurch'
GO
EXEC dbo.sp_addrolemember @rolename=N'Editor', @membername=N'NPS\BBorg'
GO
EXEC dbo.sp_addrolemember @rolename=N'Editor', @membername=N'NPS\JPLawler'
GO
EXEC dbo.sp_addrolemember @rolename=N'Editor', @membername=N'Investigator'
GO
EXEC dbo.sp_addrolemember @rolename=N'Editor', @membername=N'NPS\MLJohnson'
GO
EXEC dbo.sp_addrolemember @rolename=N'Editor', @membername=N'NPS\PAOwen'
GO
EXEC dbo.sp_addrolemember @rolename=N'Editor', @membername=N'NPS\GColligan'
GO
EXEC dbo.sp_addrolemember @rolename=N'Investigator', @membername=N'NPS\SDMiller'
GO
EXEC dbo.sp_addrolemember @rolename=N'Investigator', @membername=N'NPS\RESarwas'
GO
EXEC dbo.sp_addrolemember @rolename=N'Investigator', @membername=N'NPS\KCJoly'
GO
EXEC dbo.sp_addrolemember @rolename=N'Investigator', @membername=N'NPS\BAMangipane'
GO
EXEC dbo.sp_addrolemember @rolename=N'Investigator', @membername=N'NPS\JWBurch'
GO
EXEC dbo.sp_addrolemember @rolename=N'Investigator', @membername=N'NPS\BBorg'
GO
EXEC dbo.sp_addrolemember @rolename=N'Investigator', @membername=N'NPS\JPLawler'
GO
EXEC dbo.sp_addrolemember @rolename=N'MSReplPAL_7_1', @membername=N'INPAKROMS53AIS\repl_distribution'
GO
EXEC dbo.sp_addrolemember @rolename=N'MStran_PAL_role', @membername=N'INPAKROMS53AIS\repl_distribution'
GO
EXEC dbo.sp_addrolemember @rolename=N'MStran_PAL_role', @membername=N'MSReplPAL_7_1'
GO
