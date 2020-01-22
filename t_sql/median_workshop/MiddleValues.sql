CREATE VIEW MiddleValues(part_wgt)
    AS SELECT part_wgt
         FROM ValueSet AS VS1
        WHERE (SELECT SUM(VS2.occurrence_cnt)/2.0 + 0.25
                 FROM ValueSet AS VS2) >
              (SELECT SUM(VS2.occurrence_cnt)
                 FROM ValueSet AS VS2
                WHERE VS1.part_wgt <= VS2.part_wgt) - VS1.occurrence_cnt
          AND (SELECT SUM(VS2.occurrence_cnt)/2.0 + 0.25
                 FROM ValueSet AS VS2) >
              (SELECT SUM(VS2.occurrence_cnt)
                 FROM ValueSet AS VS2
                WHERE VS1.part_wgt >= VS2.part_wgt) - VS1.occurrence_cnt;
    go
    SELECT AVG(part_wgt) AS median FROM MiddleValues;
