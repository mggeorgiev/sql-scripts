-- Create a new database called 'MedianWorkbench'
-- Connect to the 'master' database to run this snippet
USE master
GO
-- Create the new database if it does not exist already
IF NOT EXISTS (
    SELECT [name]
        FROM sys.databases
        WHERE [name] = N'MedianWorkbench'
)
CREATE DATABASE MedianWorkbench
GO

USE MedianWorkbench
go

CREATE TABLE Parts 
    (part_nbr VARCHAR(5) NOT NULL PRIMARY KEY,
     part_name VARCHAR(50) NOT NULL, 
     part_color VARCHAR(50) NOT NULL, 
     part_wgt INTEGER NOT NULL, 
     city_name VARCHAR(50) NOT NULL);
go

    INSERT INTO Parts (part_nbr, part_name, part_color, part_wgt, city_name)
    VALUES ('p1', 'Nut', 'Red', 12, 'London'),
           ('p2', 'Bolt', 'Green', 17, 'Paris'),
           ('p3', 'Cam', 'Blue', 12, 'Paris'),
           ('p4', 'Screw', 'Red', 14, 'London'),
           ('p5', 'Cam', 'Blue', 12, 'Paris'),
           ('p6', 'Cog', 'Red', 19, 'London');
go
