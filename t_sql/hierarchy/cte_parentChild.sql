USE [hierarchy]
GO

DECLARE @root AS INT = 1945;
DECLARE @maxlevel AS INT = 4;
 
WITH C AS
(
  SELECT [Parent]
      ,[Child]
      ,[BirthYear]
      , 0 as generations_below
  FROM [hierarchy].[Parents].[ParentOf]
  WHERE BirthYear = (SELECT MAX(BirthYear) FROM [hierarchy].[Parents].[ParentOf]) 

  UNION ALL

  SELECT S.[Parent]
      ,S.[Child]
      ,S.[BirthYear]
      , M.generations_below + 1
  FROM C as M
  INNER JOIN [hierarchy].[Parents].[ParentOf] AS S
  on S.Child = M.Parent
  AND M.generations_below < @maxlevel
)
SELECT Parent, Child, BirthYear, generations_below
FROM C
ORDER by BirthYear, generations_below
OPTION (MAXRECURSION 15);
GO