    CREATE VIEW CelkoFirstMedian AS 
      SELECT MIN(part_wgt)    -- smallest value in upper half
        FROM Parts
       WHERE part_wgt 
             IN (SELECT P1.part_wgt
                   FROM Parts AS P1, Parts AS P2
                  WHERE P2.part_wgt >= P1.part_wgt
                  GROUP BY P1.part_wgt
                HAVING COUNT(*) 
                       <= (SELECT CEILING(COUNT(*) / 2.0)
                             FROM Parts)
      UNION
      SELECT MAX(part_wgt)    -- largest value in lower half
        FROM Parts
       WHERE part_wgt IN (SELECT P1.part_wgt
                          FROM Parts AS P1, Parts AS P2
                         WHERE P2.part_wgt <= P1.part_wgt
                         GROUP BY P1.part_wgt
                        HAVING COUNT(*) <=
                                 (SELECT CEILING(COUNT(*) / 2.0)
                                    FROM Parts)));
    GO
