-- Drop the database 'DatabaseName'
-- Connect to the 'master' database to run this snippet
-- USE master
-- GO

-- DROP DATABASE [ec-th]
-- GO

-- DROP USER IF EXISTS ec_admin;
-- DROP LOGIN ec_admin;
-- Create a new database called 'ec-th'
-- Connect to the 'master' database to run this snippet
USE master
GO
-- Create the new database if it does not exist already
IF NOT EXISTS (
    SELECT [name]
        FROM sys.databases
        WHERE [name] = N'ec-th'
)
CREATE DATABASE [ec-th]
GO

USE [ec-th]
GO

-- Creates the login AbolrousHazem with password '340$Uuxwp7Mcxo7Khy'.  
CREATE LOGIN ec_admin   
    WITH PASSWORD = '340$Uuxwp7Mcxo7Khy';  
GO  

-- Creates a database user for the login created above.  
CREATE USER ec_admin FOR LOGIN ec_admin;  
GO 



-- Create User ec_admin For Login ec_admin with Default_Schema= [dbo];
-- go
-- USE [ec-th]
-- GO
-- EXEC sp_addrolemember 'db_ddladmin', N'ec_admin'
-- go