SET NOCOUNT ON;

USE tempdb;
DROP TABLE IF EXISTS dbo.Employees;
GO
 
CREATE TABLE dbo.Employees
(
  empid INT NOT NULL
    CONSTRAINT PK_Employees PRIMARY KEY,
  mgrid INT NULL     
    CONSTRAINT FK_Employees_Employees REFERENCES dbo.Employees,
  empname VARCHAR(25) NOT NULL,
  salary  MONEY       NOT NULL,
  CHECK (empid <> mgrid)
);
 
INSERT INTO dbo.Employees(empid, mgrid, empname, salary)
  VALUES(1,  NULL, 'David'  , $10000.00),
        (2,     1, 'Eitan'  ,  $7000.00),
        (3,     1, 'Ina'    ,  $7500.00),
        (4,     2, 'Seraph' ,  $5000.00),
        (5,     2, 'Jiru'   ,  $5500.00),
        (6,     2, 'Steve'  ,  $4500.00),
        (7,     3, 'Aaron'  ,  $5000.00),
        (8,     5, 'Lilach' ,  $3500.00),
        (9,     7, 'Rita'   ,  $3000.00),
        (10,    5, 'Sean'   ,  $3000.00),
        (11,    7, 'Gabriel',  $3000.00),
        (12,    9, 'Emilia' ,  $2000.00),
        (13,    9, 'Michael',  $2000.00),
        (14,    9, 'Didi'   ,  $1500.00);
 
CREATE UNIQUE INDEX idx_unc_mgrid_empid
  ON dbo.Employees(mgrid, empid)
  INCLUDE(empname, salary);


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