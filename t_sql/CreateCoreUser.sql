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

CREATE USER ec_app   
    WITH PASSWORD = '340$Uuxwp7Mcxo7Khy';  
GO  