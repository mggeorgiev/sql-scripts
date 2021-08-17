SELECT TOP (1000) [Departure]
      ,[BusName]
      ,[Destination]
  FROM [data_science].[network].[Trip]
  GO

DECLARE @departure AS VARCHAR(255) = 'San Francisco';
DECLARE @busname as VARCHAR(255) = 'Bus 1';
DECLARE @maxlevel as INT = 5;

WITH cte_route AS (
    SELECT       
        [Departure] 
        ,[BusName]
        ,[Destination]
        ,0 as lvl
    FROM       
        [data_science].[network].[Trip] tp
    WHERE [Departure] = @departure AND  [BusName] = @busname and [Destination] <> @departure
    UNION ALL
    SELECT 
        e.[Departure] 
        ,e.[BusName]
        ,e.[Destination]
        ,o.lvl+1 
    FROM 
        cte_route AS o 
        INNER JOIN [data_science].[network].[Trip] AS e
            ON o.[Destination] = e.[Departure]
     WHERE o.[Destination] <> @departure
     AND o.lvl<@maxlevel
)

SELECT 
    * 
    FROM cte_route
    ORDER BY lvl 
    OPTION (MAXRECURSION 100);
GO