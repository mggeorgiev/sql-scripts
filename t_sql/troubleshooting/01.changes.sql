/*Shortcut - what has changed*/

/*does not work on Azure SQL DB*/
exec sp_configure;
GO

select * from sys.configurations;
GO

select * from sys.databases;
GO

select * from sys.configurations;
GO

-- Create a new table called '[changes]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[changes]', 'U') IS NOT NULL
DROP TABLE [dbo].[changes]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[changes]
(
    [Id] INT IDENTITY(1,1) PRIMARY KEY, -- Primary Key column
    [scfg_sha1] varbinary(500)
    -- Specify more columns here
);
GO

/*What is the size of the sha1 column*/
/*Some people want to use binary instead o varbinary. It is fine*/
SELECT  DATALENGTH(HASHBYTES('MD2', 'Testing')) AS [MD2Length],
        DATALENGTH(HASHBYTES('MD4', 'Testing')) AS [MD4Length],
        DATALENGTH(HASHBYTES('MD5', 'Testing')) AS [MD5Length],
        DATALENGTH(HASHBYTES('SHA', 'Testing')) AS [SHALength],
        DATALENGTH(HASHBYTES('SHA1', 'Testing')) AS [SHA1Length],
        /* 2012 only: */
        DATALENGTH(HASHBYTES('SHA2_256', 'Testing')) AS [SHA2_256Length],
        DATALENGTH(HASHBYTES('SHA2_512', 'Testing')) AS [SHA2_512Length];

INSERT INTO [dbo].[changes] ([scfg_sha1])
SELECT HASHBYTES
('SHA1',
    (select CONVERT(VARCHAR(18), CONVERT(varbinary(8),value_in_use),1)
        FROM sys.configurations
        ORDER BY configuration_id ASC
        FOR XML PATH(''),TYPE
    ).value('(./text()[1])','varchar(MAX)')
) as scfg_sha1;
go

SELECT TOP (1000) [Id]      ,[scfg_sha1]
  FROM [dbo].[changes]
GO

create or alter view v_scfg_sha1 as 
SELECT TOP (1000)
    [Id]      , [scfg_sha1]
FROM [dbo].[changes]
where [scfg_sha1] in (
   SELECT HASHBYTES
('SHA1',
    (select CONVERT(VARCHAR(18), CONVERT(varbinary(8),value_in_use),1)
    FROM sys.configurations
    ORDER BY configuration_id ASC
    FOR XML PATH(''),TYPE
    ).value('(./text()[1])','varchar(MAX)')
) as scfg_sha1 
)
GO

select value_in_use from sys.configurations ORDER BY configuration_id ASC;
GO

select * from v_scfg_sha1