-- Adminer 4.8.1 MySQL 5.5.5-10.6.11-MariaDB-0ubuntu0.22.04.1 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `notes` varchar(45) DEFAULT NULL,
  `weight` int(11) NOT NULL,
  `id_fish` int(11) NOT NULL,
  `id_consumer` int(11) NOT NULL,
  PRIMARY KEY (`id`,`id_fish`,`id_consumer`),
  KEY `fk_ordering_fish1_idx` (`id_fish`),
  KEY `fk_ordering_consumer1_idx` (`id_consumer`),
  CONSTRAINT `fk_ordering_consumer1` FOREIGN KEY (`id_consumer`) REFERENCES `consumer` (`id`),
  CONSTRAINT `fk_ordering_fish1` FOREIGN KEY (`id_fish`) REFERENCES `fish` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `consumer`;
CREATE TABLE `consumer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `password` varchar(100) NOT NULL,
  `phone_number` varchar(45) NOT NULL,
  `address` varchar(45) NOT NULL,
  `photo_url` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

INSERT INTO `consumer` (`id`, `name`, `email`, `password`, `phone_number`, `address`, `photo_url`) VALUES
(12,	'test',	'test@mail.com',	'sdsdsdd',	'34324',	'dss',	NULL);

DROP TABLE IF EXISTS `detail_ordering`;
CREATE TABLE `detail_ordering` (
  `notes` varchar(45) DEFAULT NULL,
  `weight` int(11) NOT NULL,
  `id_consumer` int(11) NOT NULL AUTO_INCREMENT,
  `id_fish` int(11) NOT NULL,
  `id_ordering` int(11) NOT NULL,
  PRIMARY KEY (`id_consumer`,`id_fish`,`id_ordering`),
  KEY `fk_detail_ordering_consumer1_idx` (`id_consumer`),
  KEY `fk_detail_ordering_fish1_idx` (`id_fish`),
  KEY `fk_detail_ordering_ordering_idx` (`id_ordering`),
  CONSTRAINT `fk_detail_ordering_consumer1` FOREIGN KEY (`id_consumer`) REFERENCES `consumer` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_detail_ordering_fish1` FOREIGN KEY (`id_fish`) REFERENCES `fish` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

INSERT INTO `detail_ordering` (`notes`, `weight`, `id_consumer`, `id_fish`, `id_ordering`) VALUES
(NULL,	22,	12,	5,	12);

DROP TABLE IF EXISTS `fish`;
CREATE TABLE `fish` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `weight` int(11) NOT NULL,
  `description` varchar(45) DEFAULT NULL,
  `price` int(11) NOT NULL,
  `id_seller` int(11) NOT NULL,
  `photo_url` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`,`id_seller`),
  KEY `fk_fish_seller_idx` (`id_seller`),
  CONSTRAINT `fk_fish_seller` FOREIGN KEY (`id_seller`) REFERENCES `seller` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

INSERT INTO `fish` (`id`, `name`, `weight`, `description`, `price`, `id_seller`, `photo_url`) VALUES
(5,	'fish',	44,	NULL,	3000,	1,	NULL);

DROP TABLE IF EXISTS `ordering`;
CREATE TABLE `ordering` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

INSERT INTO `ordering` (`id`, `name`, `address`, `poi`, `latitude`, `longitude`, `mobile_number`, `goods`, `date`, `status`, `invoice_url`) VALUES
(12,	'order 1',	'wewe',	'qe',	'wqe',	'we',	'545',	'erw',	'2023-06-07 16:36:13.000000',	'pending',	'http:tsts');

DROP TABLE IF EXISTS `seller`;
CREATE TABLE `seller` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `password` varchar(100) NOT NULL,
  `phone_number` varchar(45) NOT NULL,
  `location` varchar(45) NOT NULL,
  `roles` varchar(45) NOT NULL,
  `nama_pemilik_rekening` varchar(45) DEFAULT NULL,
  `nomor_rekening` varchar(45) DEFAULT NULL,
  `my_wallet` decimal(12,2) NOT NULL DEFAULT 0.00,
  `nama_bank` varchar(45) DEFAULT NULL,
  `photo_url` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

INSERT INTO `seller` (`id`, `name`, `email`, `password`, `phone_number`, `location`, `roles`, `nama_pemilik_rekening`, `nomor_rekening`, `my_wallet`, `nama_bank`, `photo_url`) VALUES
(1,	'test',	'test@mail.com',	'qwerty',	'08322323232',	'wakanda',	'seller',	'test',	'34234234234',	228222.00,	'BNI',	NULL);

DROP TABLE IF EXISTS `transaction`;
CREATE TABLE `transaction` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_external` varchar(20) NOT NULL,
  `id_consumer` int(11) NOT NULL,
  `dates_transaction` datetime NOT NULL,
  `dates_payed` datetime NOT NULL,
  `id_ordering` int(11) NOT NULL,
  `status` enum('pending','paid','settled','expired') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ordering_idx` (`id_ordering`),
  KEY `id_consumer_idx` (`id_consumer`),
  CONSTRAINT `id_consumer` FOREIGN KEY (`id_consumer`) REFERENCES `consumer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

INSERT INTO `transaction` (`id`, `id_external`, `id_consumer`, `dates_transaction`, `dates_payed`, `id_ordering`, `status`) VALUES
(13,	'sdsd',	12,	'2010-00-00 00:00:00',	'2010-00-00 00:00:00',	12,	'paid'),
(14,	'sdsd',	12,	'2010-00-00 00:00:00',	'2010-00-00 00:00:00',	12,	'paid'),
(15,	'sdsd',	12,	'2010-00-00 00:00:00',	'2010-00-00 00:00:00',	12,	'paid'),
(16,	'sdsd',	12,	'2010-00-00 00:00:00',	'2010-00-00 00:00:00',	12,	'paid'),
(17,	'sdsd',	12,	'2010-00-00 00:00:00',	'2010-00-00 00:00:00',	12,	'paid'),
(18,	'sdsd',	12,	'2010-00-00 00:00:00',	'2010-00-00 00:00:00',	12,	'paid'),
(19,	'sdsd',	12,	'2010-00-00 00:00:00',	'2010-00-00 00:00:00',	12,	'paid'),
(20,	'sdsd',	12,	'2010-00-00 00:00:00',	'2010-00-00 00:00:00',	12,	'paid'),
(21,	'sdsd',	12,	'2010-00-00 00:00:00',	'2010-00-00 00:00:00',	12,	'paid'),
(22,	'sdsd',	12,	'2010-00-00 00:00:00',	'2010-00-00 00:00:00',	12,	'paid'),
(23,	'sdsd',	12,	'2010-00-00 00:00:00',	'2010-00-00 00:00:00',	12,	'paid'),
(24,	'sdsd',	12,	'2010-00-00 00:00:00',	'2010-00-00 00:00:00',	12,	'paid'),
(25,	'sdsd',	12,	'2010-00-00 00:00:00',	'2010-00-00 00:00:00',	12,	'paid'),
(26,	'sdsd',	12,	'2010-00-00 00:00:00',	'2010-00-00 00:00:00',	12,	'paid'),
(27,	'sdsd',	12,	'2010-00-00 00:00:00',	'2010-00-00 00:00:00',	12,	'paid'),
(28,	'sdsd',	12,	'2010-00-00 00:00:00',	'2010-00-00 00:00:00',	12,	'paid'),
(29,	'sdsd',	12,	'2010-00-00 00:00:00',	'2010-00-00 00:00:00',	12,	'paid'),
(30,	'sdsd',	12,	'2010-00-00 00:00:00',	'2010-00-00 00:00:00',	12,	'paid'),
(31,	'sdsd',	12,	'2010-00-00 00:00:00',	'2010-00-00 00:00:00',	12,	'paid'),
(32,	'sdsd',	12,	'2010-00-00 00:00:00',	'2010-00-00 00:00:00',	12,	'paid'),
(33,	'sdsd',	12,	'2010-00-00 00:00:00',	'2010-00-00 00:00:00',	12,	'paid'),
(34,	'sdsd',	12,	'2010-00-00 00:00:00',	'2010-00-00 00:00:00',	12,	'paid'),
(35,	'sdsd',	12,	'2010-00-00 00:00:00',	'2010-00-00 00:00:00',	12,	'paid'),
(36,	'sdsd',	12,	'2010-00-00 00:00:00',	'2010-00-00 00:00:00',	12,	'paid'),
(37,	'sdsd',	12,	'2010-00-00 00:00:00',	'2010-00-00 00:00:00',	12,	'paid'),
(38,	'sdsd',	12,	'2010-00-00 00:00:00',	'2010-00-00 00:00:00',	12,	'paid'),
(39,	'sdsd',	12,	'2010-00-00 00:00:00',	'2010-00-00 00:00:00',	12,	'paid'),
(40,	'sdsd',	12,	'2010-00-00 00:00:00',	'2010-00-00 00:00:00',	12,	'paid'),
(41,	'sdsd',	12,	'2010-00-00 00:00:00',	'2010-00-00 00:00:00',	12,	'paid'),
(42,	'sdsd',	12,	'2010-00-00 00:00:00',	'2010-00-00 00:00:00',	12,	'paid'),
(43,	'sdsd',	12,	'2010-00-00 00:00:00',	'2010-00-00 00:00:00',	12,	'paid'),
(44,	'sdsd',	12,	'2010-00-00 00:00:00',	'2010-00-00 00:00:00',	12,	'paid'),
(45,	'sdsd',	12,	'2010-00-00 00:00:00',	'2010-00-00 00:00:00',	12,	'paid');

-- 2023-06-07 11:00:00
