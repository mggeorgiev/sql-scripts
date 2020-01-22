    SELECT AVG(part_wgt)
      FROM Parts AS P1
     WHERE EXISTS
          (SELECT COUNT(*)
             FROM Parts AS P2
            WHERE CAST(part_wgt AS CHAR(5)) + P2.part_nbr >=
                  CAST(part_wgt AS CHAR(5)) + P1.part_nbr
           HAVING COUNT(*) = (SELECT FLOOR(COUNT(*) / 2.0)
                                FROM Parts)
               OR COUNT(*) = (SELECT CEILING((COUNT(*) / 2.0))
                                FROM Parts));
