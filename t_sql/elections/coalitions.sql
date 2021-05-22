SELECT TOP (1000) [Id]
      ,[Name]
  FROM [elections].[dbo].[party]
GO

SELECT TOP (1000) parl.[Id]
      ,[assemmbly]
      ,[Name]
      ,[representatives]
  FROM [elections].[dbo].[parliament_db] parl
  JOIN [elections].[dbo].[party] p ON p.[Id] = parl.[party]
Go

select [1],[2],[3],[4],[5],[6]
from
(
  select representatives, [party]
  FROM [elections].[dbo].[parliament_db]
) d
pivot
(
  max(representatives)
  for [party] in ([1],[2],[3],[4],[5],[6] )
) piv;
GO

select [ГЕРБ-СДС],[ИТН],[БСП],[ДПС],[ДБ],[Изправи се]
from
(
  select representatives, [Name]
  FROM [elections].[dbo].[parliament_db] parl
  JOIN [elections].[dbo].[party] p ON p.[Id] = parl.[party]
) d
pivot
(
  max(representatives)
  for [Name] in ([ГЕРБ-СДС],[ИТН],[БСП],[ДПС],[ДБ],[Изправи се] )
) piv;
GO

