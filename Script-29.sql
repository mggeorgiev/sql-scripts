SELECT
        DISTINCT mx.ID_CAR,
        DKN,
        MAX_DATE AS PREVIOUS_DATE,
        MAX_DATE+ROUND(AMOUNT/PER_DIEM,0) AS PREDICTED_DATE,
        ROUND(AMOUNT/PER_DIEM,0) AS EXPECTED_PERIOD,
        FUEL_CONSUMPTION,
        MAX_KM AS KM,
        MAX_KM + ROUND(AMOUNT/FUEL_CONSUMPTION*100,0) as PREDICTED_KM
        FROM
            (SELECT 
                ID_CAR,
                MAX(KM) as MAX_KM,
                MAX(DATE_COL) as MAX_DATE
                FROM FUEL
                GROUP BY ID_CAR) mx
            JOIN
            (SELECT 
                ID_CAR,
                KM,
                AMOUNT
                FROM FUEL) kms
            ON mx.ID_CAR = kms.ID_CAR
            JOIN
            (SELECT 
                ID_CAR,
                ROUND(SUM(AMOUNT)/SUM(PERIOD),2) as PER_DIEM,
                ROUND(SUM(AMOUNT)/SUM(MILEAGE)*100,2) as FUEL_CONSUMPTION
                FROM FUEL
                WHERE DATE_COL > SYSDATE-120
                AND PERIOD != 0
                GROUP BY ID_CAR
            ) prdm 
            ON prdm.ID_CAR = mx.ID_CAR
            JOIN CARS ON mx.ID_CAR = CARS.ID_CAR
        WHERE mx.MAX_KM = kms.KM
        AND mx.ID_CAR = kms.ID_CAR
        AND CARS.ACTIVE=1;
