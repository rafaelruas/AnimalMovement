/****** Script for SelectTopNRows command from SSMS  ******/
SELECT  [LocationDate]
      ,avg([Latitude])
      ,avg([Longitude])
      --,[LocationClass]
  FROM [Animal_Movement].[dbo].[CollarDataArgosEmail] where PlatformId = '93525' and LocationDate is not null group by LocationDate
  
SELECT  [LocationDate]
      ,[Latitude]
      ,[Longitude]
      ,[LocationClass]
  FROM [Animal_Movement].[dbo].[CollarDataArgosEmail] where PlatformId = '93525' and LocationDate is not null group by LocationDate, Latitude, Longitude, LocationClass
  
  select P.Manager, d2.ProjectId, d2.AnimalId, f.PlatformId, COUNT(*) from [CollarDataArgosEmail] as f
  join ArgosPlatforms as A on A.PlatformId = f.PlatformId
  join ArgosPrograms as P on P.ProgramId = A.ProgramId
  join ArgosDeployments as D on D.PlatformId = f.PlatformId
  join CollarDeployments as d2 on d2.CollarId = d.CollarId
  group by P.Manager, f.PlatformId, d2.ProjectId, d2.AnimalId order by COUNT(*) desc