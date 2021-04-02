use data_science
go

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'probability')
BEGIN
    EXEC('CREATE SCHEMA probability')
END
Go

-- Create a new table called '[Trip]' in schema '[probability]'
-- Drop the table if it already exists
IF OBJECT_ID('[probability].[coin_toss]', 'U') IS NOT NULL
DROP TABLE [probability].[coin_toss]
GO
-- Create the table in the specified schema
CREATE TABLE [probability].[coin_toss]
(
    I BIT
    ,II BIT
    ,III BIT
    ,IV BIT
    ,V BIT
    ,VI BIT
    ,VII BIT
    ,VIII BIT
    ,IX BIT
    ,X BIT
    ,XI BIT
    ,XII BIT
    ,XIII BIT
    ,XIV BIT
    ,XV BIT
    ,XVI BIT
    ,XVII BIT
    ,XVIII BIT
    ,XIX BIT
    ,XX BIT
    -- Specify more columns here
);
GO

DECLARE @i INT = 0;
DECLARE @ii INT = 0;
DECLARE @iii INT = 0;
DECLARE @iv INT =0;
DECLARE @v INT =0;
DECLARE @vi INT =0;
DECLARE @vii INT =0;
DECLARE @viii INT =0;
DECLARE @ix INT =0;
DECLARE @x INT =0;
DECLARE @xi INT =0;
DECLARE @xii INT =0;
DECLARE @xiii INT =0;
DECLARE @xiv INT =0;
DECLARE @xv INT =0;
DECLARE @xvi INT =0;
DECLARE @xvii INT =0;
DECLARE @xviii INT =0;
DECLARE @xix INT =0;
DECLARE @xx INT =0;

WHILE @i < 2
BEGIN
    WHILE @ii < 2
    BEGIN
        WHILE @iii < 2
        BEGIN
            WHILE @iv < 2
            BEGIN
                WHILE @v < 2
                BEGIN
                    WHILE @vi < 2
                    BEGIN
                        WHILE @vii < 2
                        BEGIN
                            WHILE @viii < 2
                            BEGIN
                                WHILE @ix < 2
                                BEGIN
                                    WHILE @x < 2
                                    BEGIN
                                        WHILE @xi < 2
                                        BEGIN
                                            WHILE @xii < 2
                                            BEGIN
                                                WHILE @xiii < 2
                                                BEGIN
                                                    WHILE @xiv < 2
                                                    BEGIN
                                                        WHILE @xv < 2
                                                        BEGIN
                                                            WHILE @xvi < 2
                                                            BEGIN
                                                                WHILE @xvii < 2
                                                                BEGIN
                                                                    WHILE @xviii < 2
                                                                    BEGIN
                                                                        WHILE @xix < 2
                                                                        BEGIN
                                                                            WHILE @xx < 2
                                                                            BEGIN
                                                                                INSERT INTO [probability].[coin_toss] (I, II, III, IV,V, VI, VII, VIII, IX, X, XI, XII, XIII, XIV, XV, XVI, XVII, XVIII, XIX, XX) 
                                                                                                            VALUES (@i, @ii, @iii, @iv, @v, @vi, @vii, @viii, @ix, @x, @xi, @xii, @xiii, @xiv, @xv, @xvi, @xvii, @xviii, @xix ,@xx);
                                                                                SET @xx = @xx+1;
                                                                            END;
                                                                            SET @xx = 0;
                                                                            SET @xix = @xix+1;
                                                                        END;
                                                                        SET @xix = 0;
                                                                        SET @xviii = @xviii+1;
                                                                    END;
                                                                    SET @xviii = 0;
                                                                    SET @xvii = @xvii+1;
                                                                END;
                                                                SET @xvii = 0;
                                                                SET @xvi = @xvi+1;
                                                            END;
                                                            SET @xvi = 0;
                                                            SET @xv = @xv+1;
                                                        END;
                                                        SET @xv = 0;
                                                        SET @xiv = @xiv+1;
                                                    END;
                                                    SET @xiv = 0;
                                                    SET @xiii = @xiii+1;
                                                END;
                                                SET @xiii=0;
                                                SET @xii=@xii+1;
                                            END;
                                            SET @xii=0;
                                            SET @xi=@xi+1;
                                        END;
                                        SET @xi=0;
                                        SET @x=@x+1;

                                    END;
                                    SET @x=0;
                                    SET @ix=@ix+1;
                                END;
                                SET @ix=0;
                                SET @viii=@viii+1;
                            END;
                            SET @viii=0;
                            SET @vii=@vii+1;
                        END;
                        SET @vii=0;
                        SET @vi=@vi+1;
                    END;
                    SET @vi=0;
                    SET @v=@v+1;    
                END;
                SET @v=0;
                SET @iv=@iv+1; 
            END;
            SET @iv=0;
            SET @iii=@iii+1;     
        END;
        SET @iii=0;
        SET @ii=@ii+1;     
    END;
    SET @ii=0;
    SET @i=@i+1;     
END;
SELECT COUNT(*) FROM [probability].[coin_toss];

SELECT TOP 1000 * FROM [probability].[coin_toss]
ORDER BY I DESC;