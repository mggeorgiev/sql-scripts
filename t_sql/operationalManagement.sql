/*Backups*/
EXECUTE [master].[dbo].[sp_dbs_backup_log] 
GO

EXECUTE [master].[dbo].[sp_dbs_backup] 
GO

/*Logging*/
EXECUTE [master].[dbo].[sp_powerbi_log] 
GO

/*Checks*/
EXECUTE [master].[dbo].[sp_BlitzFirst] 
Go

EXECUTE [master].[dbo].[sp_BlitzCache]
Go

EXEC sp_BlitzCache @SortOrder = 'query hash'
Go

-- DBCC FREEPROCCACHE;
-- GO

EXECUTE[master].[dbo].[sp_BlitzQueryStore] @DatabaseName='covid19'
Go

EXEC [master].[dbo].[sp_Blitz]
GO

/*Enable query store*/
ALTER DATABASE [ec-th] SET QUERY_STORE = ON;

EXEC sp_Blitz @CheckServerInfo = 1
GO

/*remove users from roles*/
USE [master]
GO
EXEC sp_dropsrvrolemember [occupations_admin], 'sysadmin'
GO