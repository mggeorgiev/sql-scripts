use data_science
go

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


INSERT INTO [probability].[coin_toss] (I, II, III, IV,V, VI, VII, VIII, IX, X, XI, XII, XIII, XIV, XV, XVI, XVII, XVIII, XIX, XX) 
                            VALUES (ROUND(RAND(),0)
                                   ,ROUND(RAND(),0)
                                   ,ROUND(RAND(),0)
                                   ,ROUND(RAND(),0)
                                   ,ROUND(RAND(),0)
                                   ,ROUND(RAND(),0)
                                   ,ROUND(RAND(),0)
                                   ,ROUND(RAND(),0)
                                   ,ROUND(RAND(),0)
                                   ,ROUND(RAND(),0)
                                   ,ROUND(RAND(),0)
                                   ,ROUND(RAND(),0)
                                   ,ROUND(RAND(),0)
                                   ,ROUND(RAND(),0)
                                   ,ROUND(RAND(),0)
                                   ,ROUND(RAND(),0)
                                   ,ROUND(RAND(),0)
                                   ,ROUND(RAND(),0)
                                   ,ROUND(RAND(),0));
SELECT COUNT(*) FROM [probability].[coin_toss];

SELECT TOP 1000 * FROM [probability].[coin_toss]
ORDER BY I DESC;