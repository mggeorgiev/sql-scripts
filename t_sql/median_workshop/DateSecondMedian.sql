CREATE VIEW DateSecondMedian as 
    SELECT AVG(DISTINCT Parts.part_wgt) AS median
      FROM Parts
     WHERE Parts.part_wgt IN
            (SELECT MIN(part_wgt)
               FROM Parts
              WHERE Parts.part_wgt 
                    IN (SELECT P2.part_wgt
                          FROM Parts AS P1, Parts AS P2
                         WHERE P2.part_wgt <= P1.part_wgt
                         GROUP BY P2.part_wgt
                        HAVING COUNT(*)
                            <= (SELECT CEILING(COUNT(*) / 2.0)
                                  FROM Parts))
            UNION
            SELECT MAX(part_wgt)
              FROM Parts
             WHERE Parts.part_wgt 
                   IN (SELECT P2.part_wgt
                         FROM Parts AS P1, Parts AS P2
                        WHERE P2.part_wgt >= P1.part_wgt
                        GROUP BY P2.part_wgt
                       HAVING COUNT(*)
                           <= (SELECT CEILING(COUNT(*) / 2.0)
                                 FROM Parts)));
GO
