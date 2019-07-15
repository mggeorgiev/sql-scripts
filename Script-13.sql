INSERT INTO CARS.MAINTENANCE
(
ID_MAINTENANCE,
ID_CAR,
DATE_COL,
MILEAGE, 
REFERENCE,
TOTAL,
INTERVAL_COL,
ID_CLASSIFICATION,
PRICE_PER_KM)
SELECT
	ID, 
	CASE CAR
		WHEN 'Seat Toledo' THEN '11'
  		WHEN 'Ford Focus' THEN '31'
  		WHEN 'Renault Megane' THEN '21'
  		WHEN 'Opel Vectra' THEN '41'
  		ELSE '0'
	END,
	ДАТА, 
	КИЛОМЕТРИ, 
	ЗАБЕЛЕЖКА, 
	REPLACE(ЦЕНА, ' лв.'), 
	ИНТЕРВАЛ,
	CASE КЛАСИФИКАЦИЯ
		WHEN 'Обслужване' THEN '7'
		WHEN 'Администрация' THEN '1'
		WHEN 'Резервни части' THEN '2'
		WHEN 'Консумативи' THEN '3'
		WHEN 'Финанси' THEN '4'
		WHEN 'Oil' THEN '5'
		WHEN 'Ремонт' THEN '6'
	END,
    ROUND(ЦЕНА/КИЛОМЕТРИ,2)
FROM CARS.MAINTENANCE_PRP
WHERE ДАТА < SYSDATE
ORDER BY ДАТА DESC;