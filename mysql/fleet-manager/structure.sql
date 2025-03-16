DROP DATABASE IF EXISTS cars;
CREATE DATABASE `cars` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE cars;

-- cars.cars definition

DROP TABLE IF EXISTS `cars`;

CREATE TABLE `cars` (
  `id_car` int NOT NULL AUTO_INCREMENT,
  `make` varchar(45) DEFAULT NULL,
  `model` varchar(45) DEFAULT NULL,
  `DKN` char(8) DEFAULT NULL,
  `ACTIVE` decimal(22,0) DEFAULT NULL,
  `VALID_FROM` date DEFAULT NULL,
  `VALID_TILL` date DEFAULT NULL,
  `OWNER_ID` bigint DEFAULT NULL,
  PRIMARY KEY (`id_car`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb3;

-- cars.classification definition

DROP TABLE IF EXISTS `classification`;

CREATE TABLE `classification` (
  `ID_CLASSIFICATION` int NOT NULL,
  `CLASSIFICATION` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID_CLASSIFICATION`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- cars.currency definition

DROP TABLE IF EXISTS `currency`;

CREATE TABLE `currency` (
  `ID` bigint NOT NULL,
  `CURRENCY` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- cars.drive_type definition

DROP TABLE IF EXISTS `drive_type`;

CREATE TABLE `drive_type` (
  `ID_DRIVE_TYPE` int NOT NULL,
  `DRIVE_TYPE` varchar(100) DEFAULT NULL,
  `DRIVE_TYPE_BG` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID_DRIVE_TYPE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- cars.fuel definition

DROP TABLE IF EXISTS `drive_type`;

CREATE TABLE `fuel` (
  `ID_FUEL` int NOT NULL,
  `ID_CAR` int DEFAULT NULL,
  `DATE_COL` date DEFAULT NULL,
  `KM` int DEFAULT NULL,
  `AMOUNT` decimal(10,2) DEFAULT NULL,
  `PRICE` decimal(10,2) DEFAULT NULL,
  `TOTAL` decimal(10,2) DEFAULT NULL,
  `ID_BRAND` int DEFAULT NULL,
  `ID_DRIVE_TYPE` int DEFAULT NULL,
  `YEAR_COL` int DEFAULT NULL,
  `MONTH_COL` int DEFAULT NULL,
  `DAY_COL` int DEFAULT NULL,
  `WEEKDAY_COL` int DEFAULT NULL,
  `MILEAGE` int DEFAULT NULL,
  `PERIOD` int DEFAULT NULL,
  `LKM` decimal(10,2) DEFAULT NULL,
  `CURRENCY` bigint DEFAULT NULL,
  `PRICE_IN_BGN` bigint DEFAULT NULL,
  PRIMARY KEY (`ID_FUEL`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- cars.maintenance definition

DROP TABLE IF EXISTS `maintenance`;

CREATE TABLE `maintenance` (
  `id_maintenance` int NOT NULL AUTO_INCREMENT,
  `id_car` int DEFAULT NULL,
  `date_col` date DEFAULT NULL,
  `mileage` int DEFAULT NULL,
  `reference` varchar(255) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `interval_col` int DEFAULT NULL,
  `id_classification` int DEFAULT NULL,
  `PRICE_PER_KM` decimal(10,0) DEFAULT NULL,
  `INTERVAL_DAYS` bigint DEFAULT NULL,
  `TOTAL_IN_BGN` bigint DEFAULT NULL,
  PRIMARY KEY (`id_maintenance`)
) ENGINE=InnoDB AUTO_INCREMENT=2250 DEFAULT CHARSET=utf8mb3;

-- cars.owner definition

DROP TABLE IF EXISTS `owner`;

CREATE TABLE `owner` (
  `ID` bigint NOT NULL,
  `FIRST_NAME` varchar(255) DEFAULT NULL,
  `LAST_NAME` varchar(255) DEFAULT NULL,
  `MAKE` varchar(45) DEFAULT NULL,
  `MODEL` varchar(45) DEFAULT NULL,
  `DKN` varchar(8) DEFAULT NULL,
  `ACTIVE` bigint DEFAULT NULL,
  `VALID_FROM` date DEFAULT NULL,
  `VALID_TILL` date DEFAULT NULL,
  `OWNER_ID` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- cars.supplier_fuels definition

DROP TABLE IF EXISTS `supplier_fuels`;

CREATE TABLE `supplier_fuels` (
  `ID_BRAND` int NOT NULL,
  `SUPPLIER_NAME` varchar(100) DEFAULT NULL,
  `FUEL_BRAND` varchar(100) DEFAULT NULL,
  `FUEL_NAME` char(50) DEFAULT NULL,
  `TYPE` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID_BRAND`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- cars.CONSUMPTIONREPORT source

CREATE OR REPLACE VIEW `cars`.`CONSUMPTIONREPORT` AS
select
    cars.fuel.YEAR_COL AS `year`,
    `cars`.`fuel`.`MONTH_COL` AS `month`,
    `cars`.`cars`.`make` AS `make`,
    `cars`.`cars`.`model` AS `model`,
    `cars`.`cars`.`DKN` AS `dkn`,
    sum(`cars`.`fuel`.`AMOUNT`) AS `amount`,
    sum(`cars`.`fuel`.`MILEAGE`) AS `mileage`,
    round(((sum(`cars`.`fuel`.`AMOUNT`) / sum(`cars`.`fuel`.`MILEAGE`)) * 100), 2) AS `kpl`
from
    (`cars`.`fuel`
join `cars`.`cars` on
    ((`cars`.`fuel`.`ID_CAR` = `cars`.`cars`.`id_car`)))
group by
    `cars`.`fuel`.`YEAR_COL`,
    `cars`.`fuel`.`MONTH_COL`,
    `cars`.`cars`.`make`,
    `cars`.`cars`.`model`,
    `cars`.`cars`.`DKN`
order by
    `cars`.`fuel`.`YEAR_COL` desc,
    `cars`.`fuel`.`MONTH_COL`;

-- cars.MAINTENANCE_SORT source

CREATE OR REPLACE
ALGORITHM = UNDEFINED VIEW `cars`.`MAINTENANCE_SORT` AS
select
    `cars`.`maintenance`.`id_maintenance` AS `id_maintenance`,
    `cars`.`cars`.`make` AS `make`,
    `cars`.`cars`.`model` AS `model`,
    `cars`.`cars`.`DKN` AS `DKN`,
    `cars`.`maintenance`.`date_col` AS `date_col`,
    `cars`.`maintenance`.`mileage` AS `mileage`,
    `cars`.`maintenance`.`reference` AS `reference`,
    `cars`.`maintenance`.`total` AS `total`,
    `cars`.`maintenance`.`interval_col` AS `interval_col`,
    `cars`.`maintenance`.`id_classification` AS `id_classification`,
    year(`cars`.`maintenance`.`date_col`) AS `year`,
    month(`cars`.`maintenance`.`date_col`) AS `month`,
    dayofmonth(`cars`.`maintenance`.`date_col`) AS `day`,
    dayname(`cars`.`maintenance`.`date_col`) AS `weekday`,
    quarter(`cars`.`maintenance`.`date_col`) AS `Q`
from
    (`cars`.`maintenance`
join `cars`.`cars` on
    ((`cars`.`cars`.`id_car` = `cars`.`maintenance`.`id_car`)))
order by
    `cars`.`maintenance`.`date_col` desc;

-- cars.REFUEL source

CREATE OR REPLACE
ALGORITHM = UNDEFINED VIEW `cars`.`REFUEL` AS
select
    `cars`.`fuel`.`ID_FUEL` AS `ID_FUEL`,
    concat(concat(`cars`.`cars`.`make`, ' '), `cars`.`cars`.`model`) AS `CAR`,
    `cars`.`fuel`.`DATE_COL` AS `DATE`,
    `cars`.`fuel`.`KM` AS `KM`,
    `cars`.`fuel`.`AMOUNT` AS `AMOUNT`,
    `cars`.`fuel`.`PRICE` AS `PRICE`,
    `cars`.`fuel`.`TOTAL` AS `TOTAL`,
    `cars`.`supplier_fuels`.`FUEL_NAME` AS `BRAND`,
    `cars`.`drive_type`.`DRIVE_TYPE` AS `DRIVE_TYPE`,
    `cars`.`fuel`.`YEAR_COL` AS `YEAR`,
    `cars`.`fuel`.`MONTH_COL` AS `MONTH`,
    `cars`.`fuel`.`DAY_COL` AS `DAY`,
    `cars`.`fuel`.`WEEKDAY_COL` AS `WEEKDAY`,
    `cars`.`fuel`.`MILEAGE` AS `MILEAGE`,
    `cars`.`fuel`.`PERIOD` AS `PERIOD`
from
    (((`cars`.`fuel`
join `cars`.`cars` on
    ((`cars`.`fuel`.`ID_CAR` = `cars`.`cars`.`id_car`)))
join `cars`.`drive_type` on
    ((`cars`.`fuel`.`ID_DRIVE_TYPE` = `cars`.`drive_type`.`ID_DRIVE_TYPE`)))
join `cars`.`supplier_fuels` on
    ((`cars`.`supplier_fuels`.`ID_BRAND` = `cars`.`fuel`.`ID_BRAND`)))
order by
    `cars`.`fuel`.`DATE_COL` desc;

-- cars.V_FUEL_DST_FROM_AVERAGE source

CREATE OR REPLACE
ALGORITHM = UNDEFINED VIEW `cars`.`V_FUEL_DST_FROM_AVERAGE` AS
select
    `f`.`YEAR_COL` AS `YEAR`,
    `f`.`MONTH_COL` AS `MONTH`,
    round(((sum(`f`.`AMOUNT`) - (select `cars`.`vfms`.`AVG_AMOUNT` from `cars`.`V_FUEL_MONTHLY_STATS` `vfms` where (`cars`.`vfms`.`MONTH` = `f`.`MONTH_COL`))) / (select `cars`.`vfms`.`STD_AMOUNT` from `cars`.`V_FUEL_MONTHLY_STATS` `vfms` where (`cars`.`vfms`.`MONTH` = `f`.`MONTH_COL`))), 2) AS `DST_AMOUNT`,
    round(((sum(`f`.`MILEAGE`) - (select `cars`.`vfms`.`AVG_MILEAGE` from `cars`.`V_FUEL_MONTHLY_STATS` `vfms` where (`cars`.`vfms`.`MONTH` = `f`.`MONTH_COL`))) / (select `cars`.`vfms`.`STD_MILEAGE` from `cars`.`V_FUEL_MONTHLY_STATS` `vfms` where (`cars`.`vfms`.`MONTH` = `f`.`MONTH_COL`))), 2) AS `DST_MILEAGE`,
    round(((sum(`f`.`TOTAL`) - (select `cars`.`vfms`.`AVG_TOTAL` from `cars`.`V_FUEL_MONTHLY_STATS` `vfms` where (`cars`.`vfms`.`MONTH` = `f`.`MONTH_COL`))) / (select `cars`.`vfms`.`STD_TOTAL` from `cars`.`V_FUEL_MONTHLY_STATS` `vfms` where (`cars`.`vfms`.`MONTH` = `f`.`MONTH_COL`))), 2) AS `DST_TOTAL`
from
    `cars`.`fuel` `f`
group by
    `f`.`YEAR_COL`,
    `f`.`MONTH_COL`
order by
    `f`.`YEAR_COL` desc,
    `f`.`MONTH_COL`;

-- cars.V_FUEL_MONTHLY_STATS source

CREATE OR REPLACE
ALGORITHM = UNDEFINED VIEW `cars`.`V_FUEL_MONTHLY_STATS` AS
select
    `t1`.`MONTH` AS `MONTH`,
    round(avg(`t1`.`AMOUNT`), 3) AS `AVG_AMOUNT`,
    round(std(`t1`.`AMOUNT`), 3) AS `STD_AMOUNT`,
    round(avg(`t1`.`MILEAGE`), 3) AS `AVG_MILEAGE`,
    round(std(`t1`.`MILEAGE`), 3) AS `STD_MILEAGE`,
    round(avg(`t1`.`TOTAL`), 3) AS `AVG_TOTAL`,
    round(std(`t1`.`TOTAL`), 3) AS `STD_TOTAL`
from
    (
    select
        `f`.`YEAR_COL` AS `YEAR`,
        `f`.`MONTH_COL` AS `MONTH`,
        sum(`f`.`AMOUNT`) AS `AMOUNT`,
        sum(`f`.`MILEAGE`) AS `MILEAGE`,
        sum(`f`.`TOTAL`) AS `TOTAL`
    from
        `cars`.`fuel` `f`
    group by
        `f`.`YEAR_COL`,
        `f`.`MONTH_COL`
    order by
        `f`.`YEAR_COL` desc,
        `f`.`MONTH_COL`) `t1`
group by
    `t1`.`MONTH`
order by
    `t1`.`MONTH`;