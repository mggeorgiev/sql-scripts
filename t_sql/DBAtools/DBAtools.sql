USE [master]
GO
/****** Object:  Database [DBAtools]    Script Date: 12/1/2019 5:26:46 PM ******/
CREATE DATABASE [DBAtools]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DBAtools', FILENAME = N'/var/opt/mssql/data/DBAtools.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DBAtools_log', FILENAME = N'/var/opt/mssql/data/DBAtools_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [DBAtools] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DBAtools].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DBAtools] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DBAtools] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DBAtools] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DBAtools] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DBAtools] SET ARITHABORT OFF 
GO
ALTER DATABASE [DBAtools] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DBAtools] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DBAtools] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DBAtools] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DBAtools] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DBAtools] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DBAtools] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DBAtools] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DBAtools] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DBAtools] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DBAtools] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DBAtools] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DBAtools] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DBAtools] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DBAtools] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DBAtools] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DBAtools] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DBAtools] SET RECOVERY FULL 
GO
ALTER DATABASE [DBAtools] SET  MULTI_USER 
GO
ALTER DATABASE [DBAtools] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DBAtools] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DBAtools] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DBAtools] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DBAtools] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'DBAtools', N'ON'
GO
ALTER DATABASE [DBAtools] SET QUERY_STORE = OFF
GO
USE [DBAtools]
GO
/****** Object:  User [powerbi]    Script Date: 12/1/2019 5:26:47 PM ******/
CREATE USER [powerbi] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [georgiem]    Script Date: 12/1/2019 5:26:47 PM ******/
CREATE USER [georgiem] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_datareader] ADD MEMBER [powerbi]
GO
/****** Object:  Table [dbo].[BlitzFirst_FileStats]    Script Date: 12/1/2019 5:26:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BlitzFirst_FileStats](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ServerName] [nvarchar](128) NULL,
	[CheckDate] [datetimeoffset](7) NULL,
	[DatabaseID] [int] NOT NULL,
	[FileID] [int] NOT NULL,
	[DatabaseName] [nvarchar](256) NULL,
	[FileLogicalName] [nvarchar](256) NULL,
	[TypeDesc] [nvarchar](60) NULL,
	[SizeOnDiskMB] [bigint] NULL,
	[io_stall_read_ms] [bigint] NULL,
	[num_of_reads] [bigint] NULL,
	[bytes_read] [bigint] NULL,
	[io_stall_write_ms] [bigint] NULL,
	[num_of_writes] [bigint] NULL,
	[bytes_written] [bigint] NULL,
	[PhysicalName] [nvarchar](520) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[BlitzFirst_FileStats_Deltas]    Script Date: 12/1/2019 5:26:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[BlitzFirst_FileStats_Deltas] AS 
WITH RowDates as
(
        SELECT 
                ROW_NUMBER() OVER (ORDER BY [CheckDate]) ID,
                [CheckDate]
        FROM [dbo].[BlitzFirst_FileStats]
        GROUP BY [CheckDate]
),
CheckDates as
(
        SELECT ThisDate.CheckDate,
               LastDate.CheckDate as PreviousCheckDate
        FROM RowDates ThisDate
        JOIN RowDates LastDate
        ON ThisDate.ID = LastDate.ID + 1
)
     SELECT f.ServerName,
            f.CheckDate,
            f.DatabaseID,
            f.DatabaseName,
            f.FileID,
            f.FileLogicalName,
            f.TypeDesc,
            f.PhysicalName,
            f.SizeOnDiskMB,
            DATEDIFF(ss, fPrior.CheckDate, f.CheckDate) AS ElapsedSeconds,
            (f.SizeOnDiskMB - fPrior.SizeOnDiskMB) AS SizeOnDiskMBgrowth,
            (f.io_stall_read_ms - fPrior.io_stall_read_ms) AS io_stall_read_ms,
            io_stall_read_ms_average = CASE
                                           WHEN(f.num_of_reads - fPrior.num_of_reads) = 0
                                           THEN 0
                                           ELSE(f.io_stall_read_ms - fPrior.io_stall_read_ms) /     (f.num_of_reads   -           fPrior.num_of_reads)
                                       END,
            (f.num_of_reads - fPrior.num_of_reads) AS num_of_reads,
            (f.bytes_read - fPrior.bytes_read) / 1024.0 / 1024.0 AS megabytes_read,
            (f.io_stall_write_ms - fPrior.io_stall_write_ms) AS io_stall_write_ms,
            io_stall_write_ms_average = CASE
                                            WHEN(f.num_of_writes - fPrior.num_of_writes) = 0
                                            THEN 0
                                            ELSE(f.io_stall_write_ms - fPrior.io_stall_write_ms) /         (f.num_of_writes   -       fPrior.num_of_writes)
                                        END,
            (f.num_of_writes - fPrior.num_of_writes) AS num_of_writes,
            (f.bytes_written - fPrior.bytes_written) / 1024.0 / 1024.0 AS megabytes_written
     FROM   [dbo].[BlitzFirst_FileStats] f
            INNER HASH JOIN CheckDates DATES ON f.CheckDate = DATES.CheckDate
            INNER JOIN [dbo].[BlitzFirst_FileStats] fPrior ON f.ServerName =                 fPrior.ServerName
                                                              AND f.DatabaseID = fPrior.DatabaseID
                                                              AND f.FileID = fPrior.FileID
                                                              AND fPrior.CheckDate =   DATES.PreviousCheckDate

     WHERE  f.num_of_reads >= fPrior.num_of_reads
            AND f.num_of_writes >= fPrior.num_of_writes
            AND DATEDIFF(MI, fPrior.CheckDate, f.CheckDate) BETWEEN 1 AND 60;
GO
/****** Object:  Table [dbo].[BlitzFirst_PerfmonStats]    Script Date: 12/1/2019 5:26:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BlitzFirst_PerfmonStats](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ServerName] [nvarchar](128) NULL,
	[CheckDate] [datetimeoffset](7) NULL,
	[object_name] [nvarchar](128) NOT NULL,
	[counter_name] [nvarchar](128) NOT NULL,
	[instance_name] [nvarchar](128) NULL,
	[cntr_value] [bigint] NULL,
	[cntr_type] [int] NOT NULL,
	[value_delta] [bigint] NULL,
	[value_per_second] [decimal](18, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[BlitzFirst_PerfmonStats_Deltas]    Script Date: 12/1/2019 5:26:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[BlitzFirst_PerfmonStats_Deltas] AS 
WITH RowDates as
(
        SELECT 
                ROW_NUMBER() OVER (ORDER BY [CheckDate]) ID,
                [CheckDate]
        FROM [dbo].[BlitzFirst_PerfmonStats]
        GROUP BY [CheckDate]
),
CheckDates as
(
        SELECT ThisDate.CheckDate,
               LastDate.CheckDate as PreviousCheckDate
        FROM RowDates ThisDate
        JOIN RowDates LastDate
        ON ThisDate.ID = LastDate.ID + 1
)
SELECT
       pMon.[ServerName]
      ,pMon.[CheckDate]
      ,pMon.[object_name]
      ,pMon.[counter_name]
      ,pMon.[instance_name]
      ,DATEDIFF(SECOND,pMonPrior.[CheckDate],pMon.[CheckDate]) AS ElapsedSeconds
      ,pMon.[cntr_value]
      ,pMon.[cntr_type]
      ,(pMon.[cntr_value] - pMonPrior.[cntr_value]) AS cntr_delta
 ,(pMon.cntr_value - pMonPrior.cntr_value) * 1.0 / DATEDIFF(ss, pMonPrior.CheckDate, pMon.CheckDate) AS cntr_delta_per_second
  FROM [dbo].[BlitzFirst_PerfmonStats] pMon
  INNER HASH JOIN CheckDates Dates
  ON Dates.CheckDate = pMon.CheckDate
  JOIN [dbo].[BlitzFirst_PerfmonStats] pMonPrior
  ON  Dates.PreviousCheckDate = pMonPrior.CheckDate
      AND pMon.[ServerName]    = pMonPrior.[ServerName]   
      AND pMon.[object_name]   = pMonPrior.[object_name]  
      AND pMon.[counter_name]  = pMonPrior.[counter_name] 
      AND pMon.[instance_name] = pMonPrior.[instance_name]
    WHERE DATEDIFF(MI, pMonPrior.CheckDate, pMon.CheckDate) BETWEEN 1 AND 60;
GO
/****** Object:  View [dbo].[BlitzFirst_PerfmonStats_Actuals]    Script Date: 12/1/2019 5:26:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[BlitzFirst_PerfmonStats_Actuals] AS 
WITH PERF_AVERAGE_BULK AS
(
    SELECT ServerName,
           object_name,
           instance_name,
           counter_name,
           CASE WHEN CHARINDEX('(', counter_name) = 0 THEN counter_name ELSE LEFT (counter_name, CHARINDEX('(',counter_name)-1) END    AS   counter_join,
           CheckDate,
           cntr_delta
    FROM   [dbo].[BlitzFirst_PerfmonStats_Deltas]
    WHERE  cntr_type IN(1073874176)
    AND cntr_delta <> 0
),
PERF_LARGE_RAW_BASE AS
(
    SELECT ServerName,
           object_name,
           instance_name,
           LEFT(counter_name, CHARINDEX('BASE', UPPER(counter_name))-1) AS counter_join,
           CheckDate,
           cntr_delta
    FROM   [dbo].[BlitzFirst_PerfmonStats_Deltas]
    WHERE  cntr_type IN(1073939712)
    AND cntr_delta <> 0
),
PERF_AVERAGE_FRACTION AS
(
    SELECT ServerName,
           object_name,
           instance_name,
           counter_name,
           counter_name AS counter_join,
           CheckDate,
           cntr_delta
    FROM   [dbo].[BlitzFirst_PerfmonStats_Deltas]
    WHERE  cntr_type IN(537003264)
    AND cntr_delta <> 0
),
PERF_COUNTER_BULK_COUNT AS
(
    SELECT ServerName,
           object_name,
           instance_name,
           counter_name,
           CheckDate,
           cntr_delta / ElapsedSeconds AS cntr_value
    FROM   [dbo].[BlitzFirst_PerfmonStats_Deltas]
    WHERE  cntr_type IN(272696576, 272696320)
    AND cntr_delta <> 0
),
PERF_COUNTER_RAWCOUNT AS
(
    SELECT ServerName,
           object_name,
           instance_name,
           counter_name,
           CheckDate,
           cntr_value
    FROM   [dbo].[BlitzFirst_PerfmonStats_Deltas]
    WHERE  cntr_type IN(65792, 65536)
)

SELECT NUM.ServerName,
       NUM.object_name,
       NUM.counter_name,
       NUM.instance_name,
       NUM.CheckDate,
       NUM.cntr_delta / DEN.cntr_delta AS cntr_value
       
FROM   PERF_AVERAGE_BULK AS NUM
       JOIN PERF_LARGE_RAW_BASE AS DEN ON NUM.counter_join = DEN.counter_join
                                          AND NUM.CheckDate = DEN.CheckDate
                                          AND NUM.ServerName = DEN.ServerName
                                          AND NUM.object_name = DEN.object_name
                                          AND NUM.instance_name = DEN.instance_name
                                          AND DEN.cntr_delta <> 0

UNION ALL

SELECT NUM.ServerName,
       NUM.object_name,
       NUM.counter_name,
       NUM.instance_name,
       NUM.CheckDate,
       CAST((CAST(NUM.cntr_delta as DECIMAL(19)) / DEN.cntr_delta) as decimal(23,3))  AS cntr_value
FROM   PERF_AVERAGE_FRACTION AS NUM
       JOIN PERF_LARGE_RAW_BASE AS DEN ON NUM.counter_join = DEN.counter_join
                                          AND NUM.CheckDate = DEN.CheckDate
                                          AND NUM.ServerName = DEN.ServerName
                                          AND NUM.object_name = DEN.object_name
                                          AND NUM.instance_name = DEN.instance_name
                                          AND DEN.cntr_delta <> 0
UNION ALL

SELECT ServerName,
       object_name,
       counter_name,
       instance_name,
       CheckDate,
       cntr_value
FROM   PERF_COUNTER_BULK_COUNT

UNION ALL

SELECT ServerName,
       object_name,
       counter_name,
       instance_name,
       CheckDate,
       cntr_value
FROM   PERF_COUNTER_RAWCOUNT;
GO
/****** Object:  Table [dbo].[BlitzFirst_WaitStats]    Script Date: 12/1/2019 5:26:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BlitzFirst_WaitStats](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ServerName] [nvarchar](128) NULL,
	[CheckDate] [datetimeoffset](7) NULL,
	[wait_type] [nvarchar](60) NULL,
	[wait_time_ms] [bigint] NULL,
	[signal_wait_time_ms] [bigint] NULL,
	[waiting_tasks_count] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BlitzFirst_WaitStats_Categories]    Script Date: 12/1/2019 5:26:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BlitzFirst_WaitStats_Categories](
	[WaitType] [nvarchar](60) NOT NULL,
	[WaitCategory] [nvarchar](128) NOT NULL,
	[Ignorable] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[WaitType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[BlitzFirst_WaitStats_Deltas]    Script Date: 12/1/2019 5:26:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[BlitzFirst_WaitStats_Deltas] AS 
WITH RowDates as
(
        SELECT 
                ROW_NUMBER() OVER (ORDER BY [CheckDate]) ID,
                [CheckDate]
        FROM [dbo].[BlitzFirst_WaitStats]
        GROUP BY [CheckDate]
),
CheckDates as
(
        SELECT ThisDate.CheckDate,
               LastDate.CheckDate as PreviousCheckDate
        FROM RowDates ThisDate
        JOIN RowDates LastDate
        ON ThisDate.ID = LastDate.ID + 1
)
SELECT w.ServerName, w.CheckDate, w.wait_type, COALESCE(wc.WaitCategory, 'Other') AS WaitCategory, COALESCE(wc.Ignorable,0) AS Ignorable
, DATEDIFF(ss, wPrior.CheckDate, w.CheckDate) AS ElapsedSeconds
, (w.wait_time_ms - wPrior.wait_time_ms) AS wait_time_ms_delta
, (w.wait_time_ms - wPrior.wait_time_ms) / 60000.0 AS wait_time_minutes_delta
, (w.wait_time_ms - wPrior.wait_time_ms) / 1000.0 / DATEDIFF(ss, wPrior.CheckDate, w.CheckDate) AS wait_time_minutes_per_minute
, (w.signal_wait_time_ms - wPrior.signal_wait_time_ms) AS signal_wait_time_ms_delta
, (w.waiting_tasks_count - wPrior.waiting_tasks_count) AS waiting_tasks_count_delta
FROM [dbo].[BlitzFirst_WaitStats] w
INNER HASH JOIN CheckDates Dates
ON Dates.CheckDate = w.CheckDate
INNER JOIN [dbo].[BlitzFirst_WaitStats] wPrior ON w.ServerName = wPrior.ServerName AND w.wait_type = wPrior.wait_type AND Dates.PreviousCheckDate = wPrior.CheckDate
LEFT OUTER JOIN [dbo].[BlitzFirst_WaitStats_Categories] wc ON w.wait_type = wc.WaitType
WHERE DATEDIFF(MI, wPrior.CheckDate, w.CheckDate) BETWEEN 1 AND 60
AND [w].[wait_time_ms] >= [wPrior].[wait_time_ms];
GO
/****** Object:  Table [dbo].[BlitzCache]    Script Date: 12/1/2019 5:26:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BlitzCache](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ServerName] [nvarchar](258) NULL,
	[CheckDate] [datetimeoffset](7) NULL,
	[Version] [nvarchar](258) NULL,
	[QueryType] [nvarchar](258) NULL,
	[Warnings] [varchar](max) NULL,
	[DatabaseName] [sysname] NOT NULL,
	[SerialDesiredMemory] [float] NULL,
	[SerialRequiredMemory] [float] NULL,
	[AverageCPU] [bigint] NULL,
	[TotalCPU] [bigint] NULL,
	[PercentCPUByType] [money] NULL,
	[CPUWeight] [money] NULL,
	[AverageDuration] [bigint] NULL,
	[TotalDuration] [bigint] NULL,
	[DurationWeight] [money] NULL,
	[PercentDurationByType] [money] NULL,
	[AverageReads] [bigint] NULL,
	[TotalReads] [bigint] NULL,
	[ReadWeight] [money] NULL,
	[PercentReadsByType] [money] NULL,
	[AverageWrites] [bigint] NULL,
	[TotalWrites] [bigint] NULL,
	[WriteWeight] [money] NULL,
	[PercentWritesByType] [money] NULL,
	[ExecutionCount] [bigint] NULL,
	[ExecutionWeight] [money] NULL,
	[PercentExecutionsByType] [money] NULL,
	[ExecutionsPerMinute] [money] NULL,
	[PlanCreationTime] [datetime] NULL,
	[PlanCreationTimeHours]  AS (datediff(hour,[PlanCreationTime],sysdatetime())),
	[LastExecutionTime] [datetime] NULL,
	[PlanHandle] [varbinary](64) NULL,
	[Remove Plan Handle From Cache]  AS (case when [PlanHandle] IS NOT NULL then ('DBCC FREEPROCCACHE ('+CONVERT([varchar](128),[PlanHandle],(1)))+');' else 'N/A' end),
	[SqlHandle] [varbinary](64) NULL,
	[Remove SQL Handle From Cache]  AS (case when [SqlHandle] IS NOT NULL then ('DBCC FREEPROCCACHE ('+CONVERT([varchar](128),[SqlHandle],(1)))+');' else 'N/A' end),
	[SQL Handle More Info]  AS (case when [SqlHandle] IS NOT NULL then ('EXEC sp_BlitzCache @OnlySqlHandles = '''+CONVERT([varchar](128),[SqlHandle],(1)))+'''; ' else 'N/A' end),
	[QueryHash] [binary](8) NULL,
	[Query Hash More Info]  AS (case when [QueryHash] IS NOT NULL then ('EXEC sp_BlitzCache @OnlyQueryHashes = '''+CONVERT([varchar](32),[QueryHash],(1)))+'''; ' else 'N/A' end),
	[QueryPlanHash] [binary](8) NULL,
	[StatementStartOffset] [int] NULL,
	[StatementEndOffset] [int] NULL,
	[MinReturnedRows] [bigint] NULL,
	[MaxReturnedRows] [bigint] NULL,
	[AverageReturnedRows] [money] NULL,
	[TotalReturnedRows] [bigint] NULL,
	[QueryText] [nvarchar](max) NULL,
	[QueryPlan] [xml] NULL,
	[NumberOfPlans] [int] NULL,
	[NumberOfDistinctPlans] [int] NULL,
	[MinGrantKB] [bigint] NULL,
	[MaxGrantKB] [bigint] NULL,
	[MinUsedGrantKB] [bigint] NULL,
	[MaxUsedGrantKB] [bigint] NULL,
	[PercentMemoryGrantUsed] [money] NULL,
	[AvgMaxMemoryGrant] [money] NULL,
	[MinSpills] [bigint] NULL,
	[MaxSpills] [bigint] NULL,
	[TotalSpills] [bigint] NULL,
	[AvgSpills] [money] NULL,
	[QueryPlanCost] [float] NULL,
 CONSTRAINT [PK_6BD3C59F-E93A-441F-A5A1-6E5CBB06956C] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BlitzFirst]    Script Date: 12/1/2019 5:26:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BlitzFirst](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ServerName] [nvarchar](128) NULL,
	[CheckDate] [datetimeoffset](7) NULL,
	[CheckID] [int] NOT NULL,
	[Priority] [tinyint] NOT NULL,
	[FindingsGroup] [varchar](50) NOT NULL,
	[Finding] [varchar](200) NOT NULL,
	[URL] [varchar](200) NOT NULL,
	[Details] [nvarchar](4000) NULL,
	[HowToStopIt] [xml] NULL,
	[QueryPlan] [xml] NULL,
	[QueryText] [nvarchar](max) NULL,
	[StartTime] [datetimeoffset](7) NULL,
	[LoginName] [nvarchar](128) NULL,
	[NTUserName] [nvarchar](128) NULL,
	[OriginalLoginName] [nvarchar](128) NULL,
	[ProgramName] [nvarchar](128) NULL,
	[HostName] [nvarchar](128) NULL,
	[DatabaseID] [int] NULL,
	[DatabaseName] [nvarchar](128) NULL,
	[OpenTransactionCount] [int] NULL,
	[DetailsInt] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_ServerName_wait_type_CheckDate_Includes]    Script Date: 12/1/2019 5:26:48 PM ******/
CREATE NONCLUSTERED INDEX [IX_ServerName_wait_type_CheckDate_Includes] ON [dbo].[BlitzFirst_WaitStats]
(
	[ServerName] ASC,
	[wait_type] ASC,
	[CheckDate] ASC
)
INCLUDE([wait_time_ms],[signal_wait_time_ms],[waiting_tasks_count]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BlitzFirst_WaitStats_Categories] ADD  DEFAULT ((0)) FOR [Ignorable]
GO
/****** Object:  StoredProcedure [dbo].[sp_dbs_backup]    Script Date: 12/1/2019 5:26:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Create the stored procedure in the specified schema
CREATE PROCEDURE [dbo].[sp_dbs_backup]
AS
    DECLARE @name VARCHAR(50) -- database name 
    DECLARE @path VARCHAR(256) -- path for backup files
    DECLARE @fileName VARCHAR(256) -- filename for backup 
    DECLARE @fileDate VARCHAR(20) -- used for file name 

    SET @path = '/var/opt/mssql/data/' 

    SELECT @fileDate = CONVERT(VARCHAR(20),GETDATE(),112) 

    DECLARE db_cursor CURSOR FOR 
    SELECT name 
    FROM master.dbo.sysdatabases 
    WHERE name NOT IN ('model','msdb','tempdb') --'master'

    OPEN db_cursor 
    FETCH NEXT FROM db_cursor INTO @name 

    WHILE @@FETCH_STATUS = 0 
    BEGIN 
    SET @fileName = @path +'/' + @name +'/' + @name + '_' + @fileDate + '.bak' 
    BACKUP DATABASE @name TO DISK = @fileName
    with COMPRESSION

    FETCH NEXT FROM db_cursor INTO @name 
    END 

    CLOSE db_cursor 
    DEALLOCATE db_cursor



GO
/****** Object:  StoredProcedure [dbo].[sp_powerbi_log]    Script Date: 12/1/2019 5:26:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_powerbi_log]
AS
BEGIN
	EXEC sp_BlitzFirst 
	  @OutputDatabaseName = 'DBAtools', 
	  @OutputSchemaName = 'dbo', 
	  @OutputTableName = 'BlitzFirst',
	  @OutputTableNameFileStats = 'BlitzFirst_FileStats',
	  @OutputTableNamePerfmonStats = 'BlitzFirst_PerfmonStats',
	  @OutputTableNameWaitStats = 'BlitzFirst_WaitStats',
	  @OutputTableNameBlitzCache = 'BlitzCache';
END

GO
USE [master]
GO
ALTER DATABASE [DBAtools] SET  READ_WRITE 
GO
