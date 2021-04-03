USE hackerrank;
GO
-- Create a new table called '[city]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[city]', 'U') IS NOT NULL
DROP TABLE [dbo].[city]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[city]
(
    [Id] INT, -- Primary Key column
    [NAME] VARCHAR(17) NOT NULL,
    [COUNTRYCODE] VARCHAR(3) NOT NULL,
    [DISTRICT] VARCHAR(20) NOT NULL,
    [POPULATION] INT
    -- Specify more columns here
);
GO


-- Create a new table called '[english]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[english]', 'U') IS NOT NULL
DROP TABLE [dbo].[english]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[english]
(
    [Id] INT, -- Primary Key column
    [rank] INT,
    [word] VARCHAR(30) NOT NULL,
    [part_of_speech] VARCHAR(1) NOT NULL,
    [frequency] INT,
    [dispersion] INT
    -- Specify more columns here
);
GO