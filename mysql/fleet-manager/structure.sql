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