USE [master]
GO
/****** Object:  Database [elections]    Script Date: 12/1/2019 9:01:54 PM ******/
CREATE DATABASE [elections]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'myDatabase', FILENAME = N'/var/opt/mssql/data/elections.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'myDatabase_log', FILENAME = N'/var/opt/mssql/data/elections.ldf' , SIZE = 13632KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [elections] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
    EXEC [elections].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

USE elections
GO

-- Create a new table called '[parliament_db]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[parliament_db]', 'U') IS NOT NULL
DROP TABLE [dbo].[parliament_db]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[parliament_db]
(
    [Id] INT NOT NULL PRIMARY KEY, -- Primary Key column
    [party] INT,
    [representatives] INT,
    [assemmbly] INT
    -- Specify more columns here
);
GO

-- Create a new table called '[party]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[party]', 'U') IS NOT NULL
DROP TABLE [dbo].[party]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[party]
(
    [Id] INT NOT NULL PRIMARY KEY, -- Primary Key column
    [Name] NVARCHAR(255)
    -- Specify more columns here
);
GO

INSERT INTO elections.dbo.party (Id, [Name]) VALUES ('1',N'ГЕРБ-СДС');
INSERT INTO elections.dbo.party (Id, [Name]) VALUES ('2',N'ИТН');
INSERT INTO elections.dbo.party (Id, [Name]) VALUES ('3',N'БСП');
INSERT INTO elections.dbo.party (Id, [Name]) VALUES ('4',N'ДПС');
INSERT INTO elections.dbo.party (Id, [Name]) VALUES ('5',N'ДБ');
INSERT INTO elections.dbo.party (Id, [Name]) VALUES ('6',N'Изправи се');
GO

INSERT INTO elections.dbo.parliament_db(Id,assemmbly, party, representatives) VALUES(1,45,1,75);
INSERT INTO elections.dbo.parliament_db(Id,assemmbly, party, representatives) VALUES(2,45,2,51);
INSERT INTO elections.dbo.parliament_db(Id,assemmbly, party, representatives) VALUES(3,45,3,43);
INSERT INTO elections.dbo.parliament_db(Id,assemmbly, party, representatives) VALUES(4,45,4,30);
INSERT INTO elections.dbo.parliament_db(Id,assemmbly, party, representatives) VALUES(5,45,5,27);
INSERT INTO elections.dbo.parliament_db(Id,assemmbly, party, representatives) VALUES(6,45,6,14);
GO

-- Create a new table called '[matrix]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[matrix]', 'U') IS NOT NULL
DROP TABLE [dbo].[matrix]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[matrix]
(
    [I] INT,
    [II] INT,
    [III] INT,
    [IV] INT,
    [V] INT,
    [VI] INT
    -- Specify more columns here
);
GO

Declare @ind as INT;
Declare @n as INT;

SET @n = 0;
SET @ind = 0;
while @n<2*2*2*2*2
BEGIN
    WHILE @ind < 2
    BEGIN
        INSERT INTO [dbo].[matrix] (VI) VALUES(@ind)
        SET @ind = @ind+1;
    END;
    SET @ind = 0;
    SET @n = @n+1;
END;
Go