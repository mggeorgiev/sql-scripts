SELECT BUILDING_ID, SUM(IDEAL_PART) as sm, min(IDEAL_PART) as mn FROM APARTMENTS
        WHERE BUILDING_ID = :P5_BUILDING_ID
        AND ENTRANCE_ID = :P5_ENTRANCE_ID
        GROUP BY BUILDING_ID
        
SELECT 
	ID, 
	YEAR_EXP,
	MONTH_EXP,
	DATE_EXP,
	REFERENCE,
	ID_SUPPLIER,
	TOTAL,
	METHOD_ID,
	HABITANTS_NUMBER,
	HABITANTS,
	BUILDING_ID
	FROM EC.EXPENSES_LOG
	WHERE BUILDING_ID = 1359515;