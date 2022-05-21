use warmathematics
GO

-- Create a new table called '[blotto]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[blotto]', 'U') IS NOT NULL
DROP TABLE [dbo].[blotto]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[blotto]
(
    [Id] INT IDENTITY(1,1) PRIMARY KEY, -- Primary Key column
    [Army1] int,
    [Army2] int,
    [Outcome] int
    -- Specify more columns here
);
GO

DECLARE @cnt INT = 0;
DEClARE @cnt2 INT = 0;

WHILE @cnt < 161
BEGIN
    WHILE @cnt2 < 101
    BEGIN
        INSERT INTO [dbo].[blotto] (Army1, Army2) VALUES (@cnt, @cnt2);
        SET @cnt2=@cnt2+1;     
    END;
    SET @cnt2=0;
    SET @cnt=@cnt+1;
END;
SELECT COUNT(*) FROM [warmathematics].[dbo].[blotto];

UPDATE [warmathematics].[dbo].[blotto]
SET Outcome =  
CASE  
     WHEN [Army1]>[Army2] THEN 1   
     WHEN [Army2]>[Army1] THEN 2
     ElSE 0
END

SELECT
	Outcome ,
	COUNT(*) as OutcomeCnt
FROM
	[warmathematics].[dbo].[blotto]
group by
	Outcome ;