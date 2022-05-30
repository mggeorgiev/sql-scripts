/* From Pragmatic works*/

-- Create a new table called '[DDLEvemnts]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[DDLEvemnts]', 'U') IS NOT NULL
DROP TABLE [dbo].[DDLEvemnts]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[DDLEvemnts]
(
    [EventDate] DatETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    [EventType] NVARCHAR(64),
    [EventDDL] NVARCHAR(MAX),
    [EventXML] XML,
    [DatabaseName] NVARCHAR(255),
    [SchemaName] NVARCHAR(255),
    [ObjectName] NVARCHAR(255),
    [HostName] VARCHAR(64),
    [IPAdress] VARCHAR(32),
    [ProgramName] NVARCHAR(255),
    [LoginName] NVARCHAR(255)
    -- Specify more columns here
);
GO

GRANT SELECT, INSERT on OBJECT::[sqldb-azuresql-eus1-t].[dbo].[DDLEvemnts] to [public];
GO

USE [sqldb-azuresql-eus1-t]
GO

/*
If this was not an azure SQL I would be tempted to create the On All Server scope
Consider filtering the noisy events
*/

DROP TRIGGER IF EXISTS [DDL_Trigger_Azure_sample];
GO 
CREATE OR ALTER TRIGGER [DDL_Trigger_Azure_sample]
ON DATABASE
FOR DDL_DATABASE_LEVEL_EVENTS
AS
BEGIN
    SET NOCOUNT oN;
    Declare @EventData XML = EVENTDATA();
    DECLARE @ip VARCHAR(32) = (
        SElECT client_net_address
    from sys.dm_exec_connections
    WhERE session_id = @@SPID);

    INSERT into [dbo].[DDLEvemnts]
        (
        [EventType],
        [EventDDL],
        [EventXML],
        [DatabaseName],
        [SchemaName],
        [ObjectName],
        [HostName],
        [IPAdress],
        [ProgramName],
        [LoginName]
        )
    SELECT
        @EventData.value('(/EVENT_INSTANCE/EventType)[1]', 'NVARCHAR(100)')
        , @EventData.value('(/EVENT_INSTANCE/TSQLCommand)[1]', 'NVARCHAR(MAX)')
        , @EventData
        , DB_NAME()
        , @EventData.value('(/EVENT_INSTANCE/SchemaName)[1]', 'NVARCHAR(255)')
        , @EventData.value('(/EVENT_INSTANCE/ObjectName)[1]', 'NVARCHAR(255)')
        , HOST_NAME()
        , @ip
        , PROGRAM_NAME()
        , SUSER_SNAME();
END
GO

/*
USE [sqldb-azuresql-eus1-t]
GO

DISABLE TRIGGER [DDL_Trigger_Azure_sample] ON DATABASE;
GO
ENABLE TRIGGER [DDL_Trigger_Azure_sample] ON DATABASE;
GO
*/

/*Query*/
SELECT * FROM [dbo].[DDLEvemnts]
where EventType = 'ALTER_PROCEDURE'
ORDER by EventDate;
go

/*Query*/
SELECT * FROM [dbo].[DDLEvemnts]
ORDER by EventDate;
go

