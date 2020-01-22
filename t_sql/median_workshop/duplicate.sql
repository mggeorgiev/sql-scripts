    CREATE VIEW Temp1
    AS SELECT part_wgt FROM Parts
       UNION ALL
       SELECT part_wgt FROM Parts;
    go
    CREATE VIEW Temp2
    AS SELECT part_wgt
         FROM Temp1
        WHERE (SELECT COUNT(*) FROM Parts)
               <= (SELECT COUNT(*)
                     FROM Temp1 AS T1
                    WHERE T1.part_wgt >= Temp1.part_wgt)
          AND (SELECT COUNT(*) FROM Parts)
                <= (SELECT COUNT(*)
                      FROM Temp1 AS T2
                     WHERE T2.part_wgt <= Temp1.part_wgt);
    go
