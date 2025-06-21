-- MySQL dump 10.13  Distrib 8.0.42, for Linux (x86_64)
--
-- Host: localhost    Database: dog_walkingservice
-- ------------------------------------------------------
-- Server version	8.0.42-0ubuntu0.22.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `DOGS`
--

DROP TABLE IF EXISTS `DOGS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DOGS` (
  `DogId` int NOT NULL AUTO_INCREMENT,
  `OwnerID` int NOT NULL,
  `Name` varchar(50) NOT NULL,
  `Size` enum('small','medium','large') NOT NULL,
  PRIMARY KEY (`DogId`),
  KEY `OwnerID` (`OwnerID`),
  CONSTRAINT `DOGS_ibfk_1` FOREIGN KEY (`OwnerID`) REFERENCES `USERS` (`UserID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DOGS`
--

LOCK TABLES `DOGS` WRITE;
/*!40000 ALTER TABLE `DOGS` DISABLE KEYS */;
INSERT INTO `DOGS` VALUES (1,1,'Max','medium'),(2,3,'Bella','small'),(3,5,'Juni','large'),(4,4,'Taro','large'),(5,2,'Moon','medium');
/*!40000 ALTER TABLE `DOGS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USERS`
--

DROP TABLE IF EXISTS `USERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USERS` (
  `UserID` int NOT NULL AUTO_INCREMENT,
  `Username` varchar(50) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Password_Hash` varchar(255) NOT NULL,
  `Role` enum('owner','walker') NOT NULL,
  `Created_At` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`UserID`),
  UNIQUE KEY `Username` (`Username`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USERS`
--

LOCK TABLES `USERS` WRITE;
/*!40000 ALTER TABLE `USERS` DISABLE KEYS */;
INSERT INTO `USERS` VALUES (1,'alice123','alice@example.com','hashed123','owner','2025-06-20 23:26:26'),(2,'bobwalker','bob@example.com','hashed456','walker','2025-06-20 23:27:53'),(3,'carol123','carol@example.com','hashed789','owner','2025-06-20 23:29:17'),(4,'sarahlee','leesarah@example.com','hashed888','owner','2025-06-20 23:30:40'),(5,'leoleo','leo2805@example.com','hashed546','walker','2025-06-20 23:32:20');
/*!40000 ALTER TABLE `USERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `WALKAPPLICATIONS`
--

DROP TABLE IF EXISTS `WALKAPPLICATIONS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `WALKAPPLICATIONS` (
  `ApplicationID` int NOT NULL AUTO_INCREMENT,
  `RequestID` int NOT NULL,
  `WalkerID` int NOT NULL,
  `AppliedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Status` enum('pending','accepted','rejected') DEFAULT 'pending',
  PRIMARY KEY (`ApplicationID`),
  UNIQUE KEY `UniqueApplication` (`RequestID`,`WalkerID`),
  KEY `WalkerID` (`WalkerID`),
  CONSTRAINT `WALKAPPLICATIONS_ibfk_1` FOREIGN KEY (`RequestID`) REFERENCES `WALKREQUESTS` (`RequestID`),
  CONSTRAINT `WALKAPPLICATIONS_ibfk_2` FOREIGN KEY (`WalkerID`) REFERENCES `USERS` (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WALKAPPLICATIONS`
--

LOCK TABLES `WALKAPPLICATIONS` WRITE;
/*!40000 ALTER TABLE `WALKAPPLICATIONS` DISABLE KEYS */;
/*!40000 ALTER TABLE `WALKAPPLICATIONS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `WALKRATINGS`
--

DROP TABLE IF EXISTS `WALKRATINGS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `WALKRATINGS` (
  `RatingID` int NOT NULL AUTO_INCREMENT,
  `RequestID` int NOT NULL,
  `WalkerID` int NOT NULL,
  `OwnerID` int NOT NULL,
  `Rating` int DEFAULT NULL,
  `Comments` text,
  `RatedAT` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`RatingID`),
  UNIQUE KEY `UniqueRatingPerWalk` (`RequestID`),
  KEY `WalkerID` (`WalkerID`),
  KEY `OwnerID` (`OwnerID`),
  CONSTRAINT `WALKRATINGS_ibfk_1` FOREIGN KEY (`RequestID`) REFERENCES `WALKREQUESTS` (`RequestID`),
  CONSTRAINT `WALKRATINGS_ibfk_2` FOREIGN KEY (`WalkerID`) REFERENCES `USERS` (`UserID`),
  CONSTRAINT `WALKRATINGS_ibfk_3` FOREIGN KEY (`OwnerID`) REFERENCES `USERS` (`UserID`),
  CONSTRAINT `WALKRATINGS_chk_1` CHECK ((`Rating` between 1 and 5))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WALKRATINGS`
--

LOCK TABLES `WALKRATINGS` WRITE;
/*!40000 ALTER TABLE `WALKRATINGS` DISABLE KEYS */;
/*!40000 ALTER TABLE `WALKRATINGS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `WALKREQUESTS`
--

DROP TABLE IF EXISTS `WALKREQUESTS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `WALKREQUESTS` (
  `RequestID` int NOT NULL AUTO_INCREMENT,
  `DogID` int NOT NULL,
  `RequestedTime` datetime NOT NULL,
  `DurationMinutes` int NOT NULL,
  `Location` varchar(255) NOT NULL,
  `Status` enum('open','accepted','completed','cancelled') DEFAULT 'open',
  `CreatedAT` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`RequestID`),
  KEY `DogID` (`DogID`),
  CONSTRAINT `WALKREQUESTS_ibfk_1` FOREIGN KEY (`DogID`) REFERENCES `DOGS` (`DogId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WALKREQUESTS`
--

LOCK TABLES `WALKREQUESTS` WRITE;
/*!40000 ALTER TABLE `WALKREQUESTS` DISABLE KEYS */;
INSERT INTO `WALKREQUESTS` VALUES (1,1,'2025-06-10 08:00:00',30,'Parklands','open','2025-06-20 23:57:13'),(2,3,'2025-06-10 09:30:00',45,'Beachside Ave','accepted','2025-06-20 23:58:20'),(3,4,'2025-06-10 12:30:00',40,'Henley Road','cancelled','2025-06-20 23:59:59'),(4,2,'2025-06-10 07:00:00',60,'Docklands','completed','2025-06-21 00:01:27'),(5,5,'2025-06-10 16:00:00',50,'Oaklands Park','open','2025-06-21 00:03:09');
/*!40000 ALTER TABLE `WALKREQUESTS` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-21  0:11:45
