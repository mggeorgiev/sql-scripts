-- Drop the database 'DatabaseName'
-- Connect to the 'master' database to run this snippet
USE master
GO
-- Uncomment the ALTER DATABASE statement below to set the database to SINGLE_USER mode if the drop database command fails because the database is in use.
-- ALTER DATABASE DatabaseName SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
-- Drop the database if it exists
IF EXISTS (
    SELECT [name]
        FROM sys.databases
        WHERE [name] = N'masterrestore'
)
DROP DATABASE masterrestore
GO

CREATE DATABASE masterrestore
GO

RESTORE DATABASE [masterrestore] FROM  DISK = N'/var/opt/mssql/data/master/master_20190718.bak' WITH REPLACE
GO