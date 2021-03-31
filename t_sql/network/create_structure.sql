use data_science
go

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'network')
BEGIN
    EXEC('CREATE SCHEMA network')
END
Go

-- Create a new table called '[Trip]' in schema '[network]'
-- Drop the table if it already exists
IF OBJECT_ID('[network].[Trip]', 'U') IS NOT NULL
DROP TABLE [network].[Trip]
GO
-- Create the table in the specified schema
CREATE TABLE [network].[Trip]
(
    Departure VARCHAR(255) NOT NULL,
    BusName VARCHAR(255) NOT NULL,
    Destination VARCHAR(255) NOT NULL 
    -- Specify more columns here
);
GO

INSERT INTO network.Trip VALUES ('San Francisco', 'Bus 1', 'Toronto');
INSERT INTO network.Trip VALUES ('San Francisco', 'Bus 2', 'Texas');
INSERT INTO network.Trip VALUES ('San Francisco', 'Bus 3', 'Washington');
INSERT INTO network.Trip VALUES ('New York', 'Bus 4', 'Florida');
INSERT INTO network.Trip VALUES ('New York', 'Bus 5', 'Texas');
INSERT INTO network.Trip VALUES ('New York', 'Bus 6', 'Washington');
INSERT INTO network.Trip VALUES ('Florida', 'Bus 7', 'New York');
INSERT INTO network.Trip VALUES ('Florida', 'Bus 8', 'Toronto');
INSERT INTO network.Trip VALUES ('Florida', 'Bus 9', 'San Francisco');
INSERT INTO network.Trip VALUES ('Toronto', 'Bus 10', 'Texas');
INSERT INTO network.Trip VALUES ('Toronto', 'Bus 11', 'San Francisco');
INSERT INTO network.Trip VALUES ('Toronto', 'Bus 12', 'Washington');
INSERT INTO network.Trip VALUES ('Washington', 'Bus 13', 'Florida');
INSERT INTO network.Trip VALUES ('Washington', 'Bus 14', 'San Francisco');
INSERT INTO network.Trip VALUES ('Washington', 'Bus 15', 'Toronto');
INSERT INTO network.Trip VALUES ('Washington', 'Bus 15', 'New York');