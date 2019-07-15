SELECT 
	buckets,
	COUNT(buckets)
FROM
(SELECT
	CEIL(AMOUNT / 5) AS buckets
FROM CARS.FUEL) 
GROUP BY buckets
ORDER BY buckets;

SELECT 
	buckets,
	COUNT(buckets)
FROM
(SELECT
	CEIL(PRICE / 0.1) AS buckets
FROM CARS.FUEL) 
GROUP BY buckets
ORDER BY buckets;