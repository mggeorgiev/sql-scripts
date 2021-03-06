UPDATE UTILITIES.CEZ
SET ACTIVE_DAYTIME = ROUND(CONSUMPTION_DAYTIME * 
(SELECT cp.ACTIVE_DAYTIME 
	FROM UTILITIES.CEZ_PRICES cp 
	WHERE TIME_STAMP BETWEEN cp.DATE_EFF AND cp.DATE_DEP),2)
WHERE ID_CEZ = 201902;

SELECT 
	:new.DATE_EFF -1
	INTO :NEW.DATE_DEP
	FROM DUAL;

SELECT ROUND(:new.CONSUMPTION_TOTAL
        * (SELECT cp.ACCESS_ERP 
	        FROM UTILITIES.CEZ_PRICES cp 
	        WHERE :new.TIME_STAMP BETWEEN cp.DATE_EFF AND cp.DATE_DEP),2)
  INTO :new.ACCESS_ERP
  FROM dual;