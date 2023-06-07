-- --------------------------------------------------------
-- Host:                         35.240.236.134
-- Server version:               8.0.26-google - (Google)
-- Server OS:                    Linux
-- HeidiSQL Version:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for fishku
CREATE DATABASE IF NOT EXISTS `fishku` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `fishku`;

-- Dumping structure for table fishku.consumer
CREATE TABLE IF NOT EXISTS `consumer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `password` varchar(100) NOT NULL,
  `phone_number` varchar(45) NOT NULL,
  `address` varchar(45) NOT NULL,
  `photo_url` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb3;


-- Dumping structure for table fishku.seller
CREATE TABLE IF NOT EXISTS `seller` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `password` varchar(100) NOT NULL,
  `phone_number` varchar(45) NOT NULL,
  `location` varchar(45) NOT NULL,
  `roles` varchar(45) NOT NULL,
  `nama_pemilik_rekening` varchar(45) DEFAULT NULL,
  `nomor_rekening` varchar(45) DEFAULT NULL,
  `nama_bank` varchar(45) DEFAULT NULL,
  `photo_url` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb3;


-- Dumping structure for table fishku.fish
CREATE TABLE IF NOT EXISTS `fish` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `weight` int NOT NULL,
  `description` varchar(45) DEFAULT NULL,
  `price` int NOT NULL,
  `id_seller` int NOT NULL,
  `photo_url` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`,`id_seller`),
  KEY `fk_fish_seller_idx` (`id_seller`),
  CONSTRAINT `fk_fish_seller` FOREIGN KEY (`id_seller`) REFERENCES `seller` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb3;

-- Dumping structure for table fishku.cart
CREATE TABLE IF NOT EXISTS `cart` (
  `id` int NOT NULL AUTO_INCREMENT,
  `notes` varchar(45) DEFAULT NULL,
  `weight` int NOT NULL,
  `id_fish` int NOT NULL,
  `id_consumer` int NOT NULL,
  PRIMARY KEY (`id`,`id_fish`,`id_consumer`),
  KEY `fk_ordering_fish1_idx` (`id_fish`),
  KEY `fk_ordering_consumer1_idx` (`id_consumer`),
  CONSTRAINT `fk_ordering_consumer1` FOREIGN KEY (`id_consumer`) REFERENCES `consumer` (`id`),
  CONSTRAINT `fk_ordering_fish1` FOREIGN KEY (`id_fish`) REFERENCES `fish` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb3;


-- Dumping structure for table fishku.ordering
CREATE TABLE IF NOT EXISTS `ordering` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `address` varchar(100) NOT NULL,
  `poi` varchar(45) NOT NULL,
  `latitude` varchar(45) NOT NULL,
  `longitude` varchar(45) NOT NULL,
  `mobile_number` varchar(45) NOT NULL,
  `goods` varchar(45) NOT NULL,
  `date` datetime(6) NOT NULL,
  `status` varchar(45) NOT NULL,
  `invoice_url` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk.id_ordering` FOREIGN KEY (`id`) REFERENCES `detail_ordering` (`id_ordering`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb3;



-- Dumping structure for table fishku.detail_ordering
CREATE TABLE IF NOT EXISTS `detail_ordering` (
  `notes` varchar(45) DEFAULT NULL,
  `weight` int NOT NULL,
  `id_consumer` int NOT NULL AUTO_INCREMENT,
  `id_fish` int NOT NULL,
  `id_ordering` int NOT NULL,
  PRIMARY KEY (`id_consumer`,`id_fish`,`id_ordering`),
  KEY `fk_detail_ordering_consumer1_idx` (`id_consumer`),
  KEY `fk_detail_ordering_fish1_idx` (`id_fish`),
  KEY `fk_detail_ordering_ordering_idx` (`id_ordering`),
  CONSTRAINT `fk_detail_ordering_consumer1` FOREIGN KEY (`id_consumer`) REFERENCES `consumer` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_detail_ordering_fish1` FOREIGN KEY (`id_fish`) REFERENCES `fish` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb3;



-- Dumping structure for table fishku.transaction
CREATE TABLE IF NOT EXISTS `transaction` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_external` varchar(20) NOT NULL,
  `id_consumer` int NOT NULL,
  `dates_transaction` datetime NOT NULL,
  `dates_payed` datetime NOT NULL,
  `id_ordering` int NOT NULL,
  `status` enum('pending','paid','settled','expired') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ordering_idx` (`id_ordering`),
  KEY `id_consumer_idx` (`id_consumer`),
  CONSTRAINT `id_consumer` FOREIGN KEY (`id_consumer`) REFERENCES `consumer` (`id`),
  CONSTRAINT `id_ordering` FOREIGN KEY (`id_ordering`) REFERENCES `order_old` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb3;


/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
