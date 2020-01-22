    CREATE VIEW CelkoFirstMedianCASE AS
    SELECT AVG(DISTINCT CAST(part_wgt AS FLOAT)) AS median
      FROM (SELECT MAX(part_wgt)
              FROM Parts AS B1
            WHERE (SELECT COUNT(*) + 1
                     FROM Parts
                    WHERE part_wgt < B1.part_wgt)
                 <= (SELECT CEILING (COUNT(*) / 2.0)
                       FROM Parts)
           UNION ALL
           SELECT MAX(part_wgt)
             FROM Parts AS B
            WHERE (SELECT COUNT(*) + 1
                     FROM Parts
                    WHERE part_wgt < B.part_wgt)
                  <= CASE (SELECT (COUNT(*)% 2)
                             FROM Parts)
                     WHEN 0
                     THEN (SELECT CEILING (COUNT(*)/2.0) + 1
                             FROM Parts)
                     ELSE (SELECT CEILING (COUNT(*)/2.0)
                             FROM Parts)
                     END) AS medians(part_wgt);
    GO
