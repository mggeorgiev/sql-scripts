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

use occupations
GO

-- Create a new table called '[Abilities]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[abilities]', 'U') IS NOT NULL
DROP TABLE [dbo].[abilities]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[abilities]
(
    [Id] INT NOT NULL PRIMARY KEY, -- Primary Key column
    [Ability] NVARCHAR(50) NOT NULL,
    [Description] NVARCHAR(250) NOT NULL
    -- Specify more columns here
);
GO

use occupations
GO

-- Create a new table called '[tasks]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[tasks]', 'U') IS NOT NULL
DROP TABLE [dbo].[tasks]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[tasks]
(
    [Id] INT NOT NULL PRIMARY KEY, -- Primary Key column
    [Task] NVARCHAR(250) NOT NULL,
    -- Specify more columns here
);
GO

use occupations
GO

use occupations
GO

-- Create a new table called '[work_activities]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[work_activities]', 'U') IS NOT NULL
DROP TABLE [dbo].[work_activities]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[work_activities]
(
    [Id] INT NOT NULL PRIMARY KEY, -- Primary Key column
    [Work_activity] NVARCHAR(50) NOT NULL,
    [Description] NVARCHAR(250) NOT NULL
    -- Specify more columns here
);
GO

-- Create a new table called '[detailed_work_activities]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[detailed_work_activities]', 'U') IS NOT NULL
DROP TABLE [dbo].[tasks]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[detailed_work_activities]
(
    [Id] INT NOT NULL PRIMARY KEY, -- Primary Key column
    [detailed_work_activity] NVARCHAR(250) NOT NULL,
    -- Specify more columns here
);
GO