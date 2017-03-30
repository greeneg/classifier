-- MySQL dump 10.13  Distrib 5.7.17, for macos10.12 (x86_64)
--
-- Host: localhost    Database: hostdb
-- ------------------------------------------------------
-- Server version	5.7.17

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `AuditLog`
--

DROP TABLE IF EXISTS `AuditLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AuditLog` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `EventType` int(11) NOT NULL,
  `EventAction` json NOT NULL,
  `CTime` int(11) NOT NULL,
  `MTime` int(11) NOT NULL,
  `Polcy` json NOT NULL,
  `LastChangedBy` int(11) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AuditLog`
--

LOCK TABLES `AuditLog` WRITE;
/*!40000 ALTER TABLE `AuditLog` DISABLE KEYS */;
/*!40000 ALTER TABLE `AuditLog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GroupMemberships`
--

DROP TABLE IF EXISTS `GroupMemberships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `GroupMemberships` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `GroupId` int(11) NOT NULL,
  `UserId` int(11) NOT NULL,
  `CTime` int(11) NOT NULL,
  `MTime` int(11) NOT NULL,
  `Policy` json NOT NULL,
  `LastChangedBy` int(11) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GroupMemberships`
--

LOCK TABLES `GroupMemberships` WRITE;
/*!40000 ALTER TABLE `GroupMemberships` DISABLE KEYS */;
/*!40000 ALTER TABLE `GroupMemberships` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Groups`
--

DROP TABLE IF EXISTS `Groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Groups` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `GroupName` varchar(24) NOT NULL,
  `CTime` int(11) NOT NULL,
  `MTime` int(11) NOT NULL,
  `Polcy` json NOT NULL,
  `LastChangedBy` int(11) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Id_UNIQUE` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Groups`
--

LOCK TABLES `Groups` WRITE;
/*!40000 ALTER TABLE `Groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `Groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Users` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `UserName` varchar(24) NOT NULL,
  `PrimaryGroupID` int(11) NOT NULL,
  `CTime` int(11) NOT NULL,
  `MTime` int(11) NOT NULL,
  `Policy` json NOT NULL,
  `LastChangedBy` int(11) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Id_UNIQUE` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `class_registry`
--

DROP TABLE IF EXISTS `class_registry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `class_registry` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `computer` int(11) NOT NULL,
  `class` int(11) NOT NULL,
  `CTime` int(11) NOT NULL,
  `MTime` int(11) NOT NULL,
  `Policy` json NOT NULL,
  `LastChangedBy` int(11) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class_registry`
--

LOCK TABLES `class_registry` WRITE;
/*!40000 ALTER TABLE `class_registry` DISABLE KEYS */;
/*!40000 ALTER TABLE `class_registry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `class_supports`
--

DROP TABLE IF EXISTS `class_supports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `class_supports` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `class_name` int(11) NOT NULL,
  `os` int(11) NOT NULL,
  `distribution` int(11) NOT NULL,
  `CTime` int(11) NOT NULL,
  `MTime` int(11) NOT NULL,
  `Policy` json NOT NULL,
  `LastChangedBy` int(11) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class_supports`
--

LOCK TABLES `class_supports` WRITE;
/*!40000 ALTER TABLE `class_supports` DISABLE KEYS */;
/*!40000 ALTER TABLE `class_supports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classes`
--

DROP TABLE IF EXISTS `classes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `classes` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `ClassName` varchar(64) NOT NULL,
  `CTime` int(11) NOT NULL,
  `MTime` int(11) NOT NULL,
  `Policy` json NOT NULL,
  `LastChangedBy` int(11) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `ClassName_UNIQUE` (`ClassName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classes`
--

LOCK TABLES `classes` WRITE;
/*!40000 ALTER TABLE `classes` DISABLE KEYS */;
/*!40000 ALTER TABLE `classes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `computers`
--

DROP TABLE IF EXISTS `computers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `computers` (
  `ComputerId` int(11) NOT NULL AUTO_INCREMENT,
  `Hostname` varchar(255) NOT NULL,
  `OS` int(11) NOT NULL,
  `Distribution` int(11) NOT NULL,
  `Environment` int(11) NOT NULL,
  `SecurityZone` int(11) NOT NULL,
  `CTime` int(11) NOT NULL,
  `MTime` int(11) NOT NULL,
  `Policy` json NOT NULL,
  `Owner` int(11) NOT NULL,
  `LastChangedBy` int(11) NOT NULL,
  PRIMARY KEY (`ComputerId`),
  UNIQUE KEY `Hostname_UNIQUE` (`Hostname`),
  KEY `Id_idx` (`OS`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `computers`
--

LOCK TABLES `computers` WRITE;
/*!40000 ALTER TABLE `computers` DISABLE KEYS */;
/*!40000 ALTER TABLE `computers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `distributions`
--

DROP TABLE IF EXISTS `distributions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `distributions` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `DistributionName` varchar(32) NOT NULL,
  `OS` int(11) NOT NULL,
  `CTime` int(11) NOT NULL,
  `MTime` int(11) NOT NULL,
  `Policy` json NOT NULL,
  `LastChangedBy` int(11) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `DistributionName_UNIQUE` (`DistributionName`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `distributions`
--

LOCK TABLES `distributions` WRITE;
/*!40000 ALTER TABLE `distributions` DISABLE KEYS */;
/*!40000 ALTER TABLE `distributions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `environments`
--

DROP TABLE IF EXISTS `environments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `environments` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(64) NOT NULL,
  `CTime` int(11) NOT NULL,
  `MTime` int(11) NOT NULL,
  `Policy` json NOT NULL,
  `LastChangedBy` int(11) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Name_UNIQUE` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `environments`
--

LOCK TABLES `environments` WRITE;
/*!40000 ALTER TABLE `environments` DISABLE KEYS */;
/*!40000 ALTER TABLE `environments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operatingsystems`
--

DROP TABLE IF EXISTS `operatingsystems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `operatingsystems` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(24) NOT NULL,
  `CTime` int(11) NOT NULL,
  `MTime` int(11) NOT NULL,
  `Policy` json NOT NULL,
  `LastChangedBy` int(11) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Name_UNIQUE` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operatingsystems`
--

LOCK TABLES `operatingsystems` WRITE;
/*!40000 ALTER TABLE `operatingsystems` DISABLE KEYS */;
/*!40000 ALTER TABLE `operatingsystems` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-03-30 17:56:54
