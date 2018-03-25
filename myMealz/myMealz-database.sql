/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table ar_internal_metadata
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ar_internal_metadata`;

CREATE TABLE `ar_internal_metadata` (
  `key` varchar(255) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `ar_internal_metadata` WRITE;
/*!40000 ALTER TABLE `ar_internal_metadata` DISABLE KEYS */;

INSERT INTO `ar_internal_metadata` (`key`, `value`, `created_at`, `updated_at`)
VALUES
	('environment','development','2018-03-25 13:06:03','2018-03-25 13:06:03');

/*!40000 ALTER TABLE `ar_internal_metadata` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table diet-client-plan
# ------------------------------------------------------------

DROP TABLE IF EXISTS `diet-client-plan`;

CREATE TABLE `diet-client-plan` (
  `dietitianid` int(11) NOT NULL AUTO_INCREMENT,
  `userid` bigint(11) NOT NULL,
  `totalCalorieRestriction` int(11) NOT NULL,
  `protein` int(11) NOT NULL,
  `carbohydrates` int(11) NOT NULL,
  `fats` int(11) NOT NULL,
  `grains` int(11) NOT NULL,
  `vegetables` int(11) NOT NULL,
  PRIMARY KEY (`dietitianid`,`userid`),
  KEY `diet-client-user-foreign` (`userid`),
  CONSTRAINT `diet-client-diet-foreign` FOREIGN KEY (`dietitianid`) REFERENCES `dietitian` (`dietitianid`),
  CONSTRAINT `diet-client-user-foreign` FOREIGN KEY (`userid`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table dietitian
# ------------------------------------------------------------

DROP TABLE IF EXISTS `dietitian`;

CREATE TABLE `dietitian` (
  `dietitianid` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` text NOT NULL,
  `lastname` text NOT NULL,
  `practiceid` int(11) NOT NULL,
  PRIMARY KEY (`dietitianid`),
  KEY `PracticeID` (`practiceid`),
  CONSTRAINT `dietitian_ibfk_1` FOREIGN KEY (`practiceid`) REFERENCES `practice` (`practiceid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table dietitian-client
# ------------------------------------------------------------

DROP TABLE IF EXISTS `dietitian-client`;

CREATE TABLE `dietitian-client` (
  `dietitianid` int(11) NOT NULL,
  `userid` bigint(11) NOT NULL,
  PRIMARY KEY (`userid`,`dietitianid`),
  KEY `dietitianid` (`dietitianid`),
  CONSTRAINT `dietitian-client_ibfk_1` FOREIGN KEY (`dietitianid`) REFERENCES `dietitian` (`dietitianid`),
  CONSTRAINT `userForeign` FOREIGN KEY (`userid`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table dietitian-practice
# ------------------------------------------------------------

DROP TABLE IF EXISTS `dietitian-practice`;

CREATE TABLE `dietitian-practice` (
  `practiceid` int(11) NOT NULL,
  `dietitianid` int(11) NOT NULL,
  PRIMARY KEY (`practiceid`,`dietitianid`),
  KEY `dietitianForeign` (`dietitianid`),
  CONSTRAINT `dietitianForeign` FOREIGN KEY (`dietitianid`) REFERENCES `dietitian` (`dietitianid`),
  CONSTRAINT `practiceForeign` FOREIGN KEY (`practiceid`) REFERENCES `practice` (`practiceid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table practice
# ------------------------------------------------------------

DROP TABLE IF EXISTS `practice`;

CREATE TABLE `practice` (
  `practiceid` int(11) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `suburb` text NOT NULL,
  `postcode` int(11) NOT NULL,
  `number` int(11) NOT NULL,
  `address` text NOT NULL,
  PRIMARY KEY (`practiceid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table product-list
# ------------------------------------------------------------

DROP TABLE IF EXISTS `product-list`;

CREATE TABLE `product-list` (
  `productid` int(11) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `protein` int(11) NOT NULL,
  `fibre` int(11) NOT NULL,
  `fat` int(11) NOT NULL,
  `sugar` int(11) NOT NULL,
  `oneServing` int(11) NOT NULL,
  `servingType` text NOT NULL,
  `minExpireTime` int(11) DEFAULT NULL,
  PRIMARY KEY (`productid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table saved_meals
# ------------------------------------------------------------

DROP TABLE IF EXISTS `saved_meals`;

CREATE TABLE `saved_meals` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `content` text,
  `user_id` bigint(20) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_saved_meals_on_user_id` (`user_id`),
  KEY `index_saved_meals_on_user_id_and_created_at` (`user_id`,`created_at`),
  CONSTRAINT `fk_rails_61b460d581` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

LOCK TABLES `saved_meals` WRITE;
/*!40000 ALTER TABLE `saved_meals` DISABLE KEYS */;

INSERT INTO `saved_meals` (`id`, `content`, `user_id`, `created_at`, `updated_at`)
VALUES
	(1,'content',1,'2018-03-25 13:13:40','2018-03-25 13:13:40'),
	(2,'content',1,'2018-03-25 13:13:49','2018-03-25 13:13:49'),
	(3,'content',1,'2018-03-25 13:13:59','2018-03-25 13:13:59');

/*!40000 ALTER TABLE `saved_meals` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table schema_migrations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `schema_migrations`;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;

INSERT INTO `schema_migrations` (`version`)
VALUES
	('20180318074748'),
	('20180318081813'),
	('20180318082821'),
	('20180318082830'),
	('20180325062458');

/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table user-fridge
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user-fridge`;

CREATE TABLE `user-fridge` (
  `userid` bigint(11) NOT NULL AUTO_INCREMENT,
  `productid` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `dateAdded` int(11) NOT NULL,
  `dateDueToExpire` int(11) DEFAULT NULL,
  PRIMARY KEY (`userid`),
  KEY `fridge-food-foreign` (`productid`),
  CONSTRAINT `fridge-food-foreign` FOREIGN KEY (`productid`) REFERENCES `product-list` (`productid`),
  CONSTRAINT `fridge-user-foreign` FOREIGN KEY (`userid`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) NOT NULL DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) DEFAULT NULL,
  `last_sign_in_ip` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `dietitianID` int(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_users_on_email` (`email`),
  UNIQUE KEY `index_users_on_reset_password_token` (`reset_password_token`),
  UNIQUE KEY `index_users_on_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;

INSERT INTO `users` (`id`, `email`, `encrypted_password`, `reset_password_token`, `reset_password_sent_at`, `remember_created_at`, `sign_in_count`, `current_sign_in_at`, `last_sign_in_at`, `current_sign_in_ip`, `last_sign_in_ip`, `created_at`, `updated_at`, `username`, `firstname`, `lastname`, `dietitianID`)
VALUES
	(1,'mysqltest@email.com','$2a$11$YaujfQ9m5XPQAFvLPxRAgux7dt4RkvPXu79H2JJfMdNp93bHpgn3S',NULL,NULL,NULL,1,'2018-03-25 13:13:35','2018-03-25 13:13:35','::1','::1','2018-03-25 13:13:35','2018-03-25 13:13:35','mysqlworking','123','123456',NULL);

/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
