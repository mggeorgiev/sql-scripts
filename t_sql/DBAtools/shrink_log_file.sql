--USE [db_name]

-- ALTER DATABASE [db_name] SET RECOVERY SIMPLE WITH NO_WAIT

-- DBCC SHRINKFILE([log_file_name]/log_file_number, wanted_size)

-- ALTER DATABASE [db_name] SET RECOVERY FULL WITH NO_WAIT
USE [data_science]
GO

SELECT * FROM sys.database_files;
GO

ALTER DATABASE [data_science] SET RECOVERY SIMPLE WITH NO_WAIT

DBCC SHRINKFILE(2, 50)

ALTER DATABASE [data_science] SET RECOVERY FULL WITH NO_WAIT

GO

DBCC LOGINFO;
GO