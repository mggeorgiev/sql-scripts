-- Create a new database called 'occupations'
-- Connect to the 'master' database to run this snippet
USE master
GO
-- Create the new database if it does not exist already
IF NOT EXISTS (
    SELECT [name]
        FROM sys.databases
        WHERE [name] = N'occupations'
)
CREATE DATABASE occupations
GO

use occupations
GO

-- Create a new table called '[skills]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[skills]', 'U') IS NOT NULL
DROP TABLE [dbo].[skills]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[skills]
(
    [Id] INT NOT NULL PRIMARY KEY, -- Primary Key column
    [Skill] NVARCHAR(50) NOT NULL,
    [Description] NVARCHAR(250) NOT NULL
    -- Specify more columns here
);
GO