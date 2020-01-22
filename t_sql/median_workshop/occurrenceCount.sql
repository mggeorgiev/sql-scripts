    CREATE VIEW ValueSet(part_wgt, occurrence_cnt)
    AS SELECT part_wgt, COUNT(*)
         FROM Parts
        GROUP BY part_wgt;
    go
