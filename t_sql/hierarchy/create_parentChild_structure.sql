use data_science;
go

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'Parents')
BEGIN
    EXEC('CREATE SCHEMA Parents')
END

-- Create a new table called '[Trip]' in schema '[network]'
-- Drop the table if it already exists
IF OBJECT_ID('[Parents].[ParentOf]', 'U') IS NOT NULL
DROP TABLE [Parents].[ParentOf]
GO
-- Create the table in the specified schema
CREATE TABLE [Parents].[ParentOf]
(
    Parent VARCHAR(255) NOT NULL,
    Child VARCHAR(255) NOT NULL,
    BirthYear INT
);
GO

INSERT INTO [Parents].[ParentOf] VALUES ('Alice', 'Carol', 1945);
INSERT INTO [Parents].[ParentOf] VALUES ('Bob', 'Carol', 1945);
INSERT INTO [Parents].[ParentOf] VALUES ('Carol', 'Dave', 1970);
INSERT INTO [Parents].[ParentOf] VALUES ('Carol', 'George', 1972);
INSERT INTO [Parents].[ParentOf] VALUES ('Dave', 'Mary', 2000);
INSERT INTO [Parents].[ParentOf] VALUES ('Eve', 'Mary', 2000);
INSERT INTO [Parents].[ParentOf] VALUES ('Mary', 'Frank', 2020);