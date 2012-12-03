-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.5.28 - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL version:             7.0.0.4217
-- Date/time:                    2012-12-03 07:56:42
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping database structure for eve
CREATE DATABASE IF NOT EXISTS `eve` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `eve`;


-- Dumping structure for table eve.agtagents
CREATE TABLE IF NOT EXISTS `agtagents` (
  `agentID` int(10) NOT NULL,
  `divisionID` int(11) DEFAULT NULL,
  `corporationID` int(10) DEFAULT NULL,
  `locationID` int(10) DEFAULT NULL,
  `level` int(11) DEFAULT NULL,
  `quality` smallint(5) DEFAULT NULL,
  `agentTypeID` int(10) DEFAULT NULL,
  `isLocator` int(11) DEFAULT NULL,
  PRIMARY KEY (`agentID`),
  KEY `agtAgents_IX_corporation` (`corporationID`),
  KEY `agtAgents_IX_station` (`locationID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.agtagenttypes
CREATE TABLE IF NOT EXISTS `agtagenttypes` (
  `agentTypeID` int(10) NOT NULL,
  `agentType` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`agentTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.agtresearchagents
CREATE TABLE IF NOT EXISTS `agtresearchagents` (
  `agentID` int(10) NOT NULL,
  `typeID` int(10) NOT NULL,
  PRIMARY KEY (`agentID`,`typeID`),
  KEY `agtResearchAgents_IX_type` (`typeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.auth_group
CREATE TABLE IF NOT EXISTS `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.auth_group_permissions
CREATE TABLE IF NOT EXISTS `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_425ae3c4` (`group_id`),
  KEY `auth_group_permissions_1e014c8f` (`permission_id`),
  CONSTRAINT `group_id_refs_id_3cea63fe` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `permission_id_refs_id_5886d21f` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.auth_permission
CREATE TABLE IF NOT EXISTS `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  KEY `auth_permission_1bb8f392` (`content_type_id`),
  CONSTRAINT `content_type_id_refs_id_728de91f` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.auth_user
CREATE TABLE IF NOT EXISTS `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(75) NOT NULL,
  `password` varchar(128) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `last_login` datetime NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.auth_user_groups
CREATE TABLE IF NOT EXISTS `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`group_id`),
  KEY `auth_user_groups_403f60f` (`user_id`),
  KEY `auth_user_groups_425ae3c4` (`group_id`),
  CONSTRAINT `group_id_refs_id_f116770` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `user_id_refs_id_7ceef80f` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.auth_user_user_permissions
CREATE TABLE IF NOT EXISTS `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_403f60f` (`user_id`),
  KEY `auth_user_user_permissions_1e014c8f` (`permission_id`),
  CONSTRAINT `permission_id_refs_id_67e79cb` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `user_id_refs_id_dfbab7d` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.chrancestries
CREATE TABLE IF NOT EXISTS `chrancestries` (
  `ancestryID` int(11) NOT NULL,
  `ancestryName` varchar(100) DEFAULT NULL,
  `bloodlineID` int(11) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `perception` int(11) DEFAULT NULL,
  `willpower` int(11) DEFAULT NULL,
  `charisma` int(11) DEFAULT NULL,
  `memory` int(11) DEFAULT NULL,
  `intelligence` int(11) DEFAULT NULL,
  `iconID` int(10) DEFAULT NULL,
  `shortDescription` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`ancestryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.chrattributes
CREATE TABLE IF NOT EXISTS `chrattributes` (
  `attributeID` int(11) NOT NULL,
  `attributeName` varchar(100) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `iconID` int(10) DEFAULT NULL,
  `shortDescription` varchar(500) DEFAULT NULL,
  `notes` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`attributeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.chrbloodlines
CREATE TABLE IF NOT EXISTS `chrbloodlines` (
  `bloodlineID` int(11) NOT NULL,
  `bloodlineName` varchar(100) DEFAULT NULL,
  `raceID` int(11) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `maleDescription` varchar(1000) DEFAULT NULL,
  `femaleDescription` varchar(1000) DEFAULT NULL,
  `shipTypeID` int(10) DEFAULT NULL,
  `corporationID` int(10) DEFAULT NULL,
  `perception` int(11) DEFAULT NULL,
  `willpower` int(11) DEFAULT NULL,
  `charisma` int(11) DEFAULT NULL,
  `memory` int(11) DEFAULT NULL,
  `intelligence` int(11) DEFAULT NULL,
  `iconID` int(10) DEFAULT NULL,
  `shortDescription` varchar(500) DEFAULT NULL,
  `shortMaleDescription` varchar(500) DEFAULT NULL,
  `shortFemaleDescription` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`bloodlineID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.chrfactions
CREATE TABLE IF NOT EXISTS `chrfactions` (
  `factionID` int(10) NOT NULL,
  `factionName` varchar(100) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `raceIDs` int(10) DEFAULT NULL,
  `solarSystemID` int(10) DEFAULT NULL,
  `corporationID` int(10) DEFAULT NULL,
  `sizeFactor` double DEFAULT NULL,
  `stationCount` smallint(5) DEFAULT NULL,
  `stationSystemCount` smallint(5) DEFAULT NULL,
  `militiaCorporationID` int(10) DEFAULT NULL,
  `iconID` int(10) DEFAULT NULL,
  PRIMARY KEY (`factionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.chrraces
CREATE TABLE IF NOT EXISTS `chrraces` (
  `raceID` int(11) NOT NULL,
  `raceName` varchar(100) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `iconID` int(10) DEFAULT NULL,
  `shortDescription` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`raceID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.crpactivities
CREATE TABLE IF NOT EXISTS `crpactivities` (
  `activityID` int(11) NOT NULL,
  `activityName` varchar(100) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`activityID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.crpnpccorporationdivisions
CREATE TABLE IF NOT EXISTS `crpnpccorporationdivisions` (
  `corporationID` int(10) NOT NULL,
  `divisionID` int(11) NOT NULL,
  `size` int(11) DEFAULT NULL,
  PRIMARY KEY (`corporationID`,`divisionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.crpnpccorporationresearchfields
CREATE TABLE IF NOT EXISTS `crpnpccorporationresearchfields` (
  `skillID` int(10) NOT NULL,
  `corporationID` int(10) NOT NULL,
  PRIMARY KEY (`skillID`,`corporationID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.crpnpccorporations
CREATE TABLE IF NOT EXISTS `crpnpccorporations` (
  `corporationID` int(10) NOT NULL,
  `size` char(1) DEFAULT NULL,
  `extent` char(1) DEFAULT NULL,
  `solarSystemID` int(10) DEFAULT NULL,
  `investorID1` int(10) DEFAULT NULL,
  `investorShares1` int(11) DEFAULT NULL,
  `investorID2` int(10) DEFAULT NULL,
  `investorShares2` int(11) DEFAULT NULL,
  `investorID3` int(10) DEFAULT NULL,
  `investorShares3` int(11) DEFAULT NULL,
  `investorID4` int(10) DEFAULT NULL,
  `investorShares4` int(11) DEFAULT NULL,
  `friendID` int(10) DEFAULT NULL,
  `enemyID` int(10) DEFAULT NULL,
  `publicShares` bigint(19) DEFAULT NULL,
  `initialPrice` int(10) DEFAULT NULL,
  `minSecurity` double DEFAULT NULL,
  `scattered` int(11) DEFAULT NULL,
  `fringe` int(11) DEFAULT NULL,
  `corridor` int(11) DEFAULT NULL,
  `hub` int(11) DEFAULT NULL,
  `border` int(11) DEFAULT NULL,
  `factionID` int(10) DEFAULT NULL,
  `sizeFactor` double DEFAULT NULL,
  `stationCount` smallint(5) DEFAULT NULL,
  `stationSystemCount` smallint(5) DEFAULT NULL,
  `description` varchar(4000) DEFAULT NULL,
  `iconID` int(10) DEFAULT NULL,
  PRIMARY KEY (`corporationID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.crpnpccorporationtrades
CREATE TABLE IF NOT EXISTS `crpnpccorporationtrades` (
  `corporationID` int(10) NOT NULL,
  `typeID` int(10) NOT NULL,
  PRIMARY KEY (`corporationID`,`typeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.crpnpcdivisions
CREATE TABLE IF NOT EXISTS `crpnpcdivisions` (
  `divisionID` int(11) NOT NULL,
  `divisionName` varchar(100) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `leaderType` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`divisionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.crtcategories
CREATE TABLE IF NOT EXISTS `crtcategories` (
  `categoryID` int(11) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `categoryName` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`categoryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.crtcertificates
CREATE TABLE IF NOT EXISTS `crtcertificates` (
  `certificateID` int(10) NOT NULL,
  `categoryID` int(11) DEFAULT NULL,
  `classID` int(10) DEFAULT NULL,
  `grade` int(11) DEFAULT NULL,
  `corpID` int(10) DEFAULT NULL,
  `iconID` int(10) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`certificateID`),
  KEY `crtCertificates_IX_category` (`categoryID`),
  KEY `crtCertificates_IX_class` (`classID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.crtclasses
CREATE TABLE IF NOT EXISTS `crtclasses` (
  `classID` int(10) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `className` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`classID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.crtrecommendations
CREATE TABLE IF NOT EXISTS `crtrecommendations` (
  `recommendationID` int(10) NOT NULL,
  `shipTypeID` int(10) DEFAULT NULL,
  `certificateID` int(10) DEFAULT NULL,
  `recommendationLevel` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`recommendationID`),
  KEY `crtRecommendations_IX_certifica` (`certificateID`),
  KEY `crtRecommendations_IX_shipType` (`shipTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.crtrelationships
CREATE TABLE IF NOT EXISTS `crtrelationships` (
  `relationshipID` int(10) NOT NULL,
  `parentID` int(10) DEFAULT NULL,
  `parentTypeID` int(10) DEFAULT NULL,
  `parentLevel` int(11) DEFAULT NULL,
  `childID` int(10) DEFAULT NULL,
  PRIMARY KEY (`relationshipID`),
  KEY `crtRelationships_IX_child` (`childID`),
  KEY `crtRelationships_IX_parent` (`parentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.dgmattributecategories
CREATE TABLE IF NOT EXISTS `dgmattributecategories` (
  `categoryID` int(11) NOT NULL,
  `categoryName` varchar(50) DEFAULT NULL,
  `categoryDescription` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`categoryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.dgmattributetypes
CREATE TABLE IF NOT EXISTS `dgmattributetypes` (
  `attributeID` smallint(5) NOT NULL,
  `attributeName` varchar(100) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `iconID` int(10) DEFAULT NULL,
  `defaultValue` double DEFAULT NULL,
  `published` int(11) DEFAULT NULL,
  `displayName` varchar(100) DEFAULT NULL,
  `unitID` int(11) DEFAULT NULL,
  `stackable` int(11) DEFAULT NULL,
  `highIsGood` int(11) DEFAULT NULL,
  `categoryID` int(11) DEFAULT NULL,
  PRIMARY KEY (`attributeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.dgmeffects
CREATE TABLE IF NOT EXISTS `dgmeffects` (
  `effectID` smallint(5) NOT NULL,
  `effectName` varchar(400) DEFAULT NULL,
  `effectCategory` smallint(5) DEFAULT NULL,
  `preExpression` int(10) DEFAULT NULL,
  `postExpression` int(10) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `guid` varchar(60) DEFAULT NULL,
  `iconID` int(10) DEFAULT NULL,
  `isOffensive` int(11) DEFAULT NULL,
  `isAssistance` int(11) DEFAULT NULL,
  `durationAttributeID` smallint(5) DEFAULT NULL,
  `trackingSpeedAttributeID` smallint(5) DEFAULT NULL,
  `dischargeAttributeID` smallint(5) DEFAULT NULL,
  `rangeAttributeID` smallint(5) DEFAULT NULL,
  `falloffAttributeID` smallint(5) DEFAULT NULL,
  `disallowAutoRepeat` int(11) DEFAULT NULL,
  `published` int(11) DEFAULT NULL,
  `displayName` varchar(100) DEFAULT NULL,
  `isWarpSafe` int(11) DEFAULT NULL,
  `rangeChance` int(11) DEFAULT NULL,
  `electronicChance` int(11) DEFAULT NULL,
  `propulsionChance` int(11) DEFAULT NULL,
  `distribution` int(11) DEFAULT NULL,
  `sfxName` varchar(20) DEFAULT NULL,
  `npcUsageChanceAttributeID` smallint(5) DEFAULT NULL,
  `npcActivationChanceAttributeID` smallint(5) DEFAULT NULL,
  `fittingUsageChanceAttributeID` smallint(5) DEFAULT NULL,
  PRIMARY KEY (`effectID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.dgmtypeattributes
CREATE TABLE IF NOT EXISTS `dgmtypeattributes` (
  `typeID` int(10) NOT NULL,
  `attributeID` smallint(5) NOT NULL,
  `valueInt` int(10) DEFAULT NULL,
  `valueFloat` double DEFAULT NULL,
  PRIMARY KEY (`typeID`,`attributeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.dgmtypeeffects
CREATE TABLE IF NOT EXISTS `dgmtypeeffects` (
  `typeID` int(10) NOT NULL,
  `effectID` smallint(5) NOT NULL,
  `isDefault` int(11) DEFAULT NULL,
  PRIMARY KEY (`typeID`,`effectID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.django_content_type
CREATE TABLE IF NOT EXISTS `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_label` (`app_label`,`model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.django_session
CREATE TABLE IF NOT EXISTS `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_3da3d3d8` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.django_site
CREATE TABLE IF NOT EXISTS `django_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.evegraphics
CREATE TABLE IF NOT EXISTS `evegraphics` (
  `graphicID` int(10) NOT NULL,
  `graphicFile` varchar(500) NOT NULL,
  `description` text,
  `obsolete` int(11) NOT NULL DEFAULT '0',
  `graphicType` varchar(100) DEFAULT NULL,
  `collidable` int(11) DEFAULT NULL,
  `explosionID` int(10) DEFAULT NULL,
  `directoryID` int(10) DEFAULT NULL,
  `graphicName` varchar(64) NOT NULL,
  PRIMARY KEY (`graphicID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.eveicons
CREATE TABLE IF NOT EXISTS `eveicons` (
  `iconID` int(10) NOT NULL,
  `iconFile` varchar(500) NOT NULL,
  `description` text,
  PRIMARY KEY (`iconID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.eveunits
CREATE TABLE IF NOT EXISTS `eveunits` (
  `unitID` int(11) NOT NULL,
  `unitName` varchar(100) DEFAULT NULL,
  `displayName` varchar(50) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`unitID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.invblueprinttypes
CREATE TABLE IF NOT EXISTS `invblueprinttypes` (
  `blueprintTypeID` int(10) NOT NULL,
  `parentBlueprintTypeID` int(10) DEFAULT NULL,
  `productTypeID` int(10) DEFAULT NULL,
  `productionTime` int(10) DEFAULT NULL,
  `techLevel` smallint(5) DEFAULT NULL,
  `researchProductivityTime` int(10) DEFAULT NULL,
  `researchMaterialTime` int(10) DEFAULT NULL,
  `researchCopyTime` int(10) DEFAULT NULL,
  `researchTechTime` int(10) DEFAULT NULL,
  `productivityModifier` int(10) DEFAULT NULL,
  `materialModifier` smallint(5) DEFAULT NULL,
  `wasteFactor` smallint(5) DEFAULT NULL,
  `maxProductionLimit` int(10) DEFAULT NULL,
  PRIMARY KEY (`blueprintTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.invcategories
CREATE TABLE IF NOT EXISTS `invcategories` (
  `categoryID` int(10) NOT NULL,
  `categoryName` varchar(100) DEFAULT NULL,
  `description` varchar(3000) DEFAULT NULL,
  `iconID` int(10) DEFAULT NULL,
  `published` int(11) DEFAULT NULL,
  PRIMARY KEY (`categoryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.invcontrabandtypes
CREATE TABLE IF NOT EXISTS `invcontrabandtypes` (
  `factionID` int(10) NOT NULL,
  `typeID` int(10) NOT NULL,
  `standingLoss` double DEFAULT NULL,
  `confiscateMinSec` double DEFAULT NULL,
  `fineByValue` double DEFAULT NULL,
  `attackMinSec` double DEFAULT NULL,
  PRIMARY KEY (`factionID`,`typeID`),
  KEY `invContrabandTypes_IX_type` (`typeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.invcontroltowerresourcepurposes
CREATE TABLE IF NOT EXISTS `invcontroltowerresourcepurposes` (
  `purpose` int(11) NOT NULL,
  `purposeText` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`purpose`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.invcontroltowerresources
CREATE TABLE IF NOT EXISTS `invcontroltowerresources` (
  `controlTowerTypeID` int(10) NOT NULL,
  `resourceTypeID` int(10) NOT NULL,
  `purpose` int(11) DEFAULT NULL,
  `quantity` int(10) DEFAULT NULL,
  `minSecurityLevel` double DEFAULT NULL,
  `factionID` int(10) DEFAULT NULL,
  PRIMARY KEY (`controlTowerTypeID`,`resourceTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.invflags
CREATE TABLE IF NOT EXISTS `invflags` (
  `flagID` smallint(5) NOT NULL,
  `flagName` varchar(200) DEFAULT NULL,
  `flagText` varchar(100) DEFAULT NULL,
  `orderID` int(10) DEFAULT NULL,
  PRIMARY KEY (`flagID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.invgroups
CREATE TABLE IF NOT EXISTS `invgroups` (
  `groupID` int(10) NOT NULL,
  `categoryID` int(10) DEFAULT NULL,
  `groupName` varchar(100) DEFAULT NULL,
  `description` varchar(3000) DEFAULT NULL,
  `iconID` int(10) DEFAULT NULL,
  `useBasePrice` int(11) DEFAULT NULL,
  `allowManufacture` int(11) DEFAULT NULL,
  `allowRecycler` int(11) DEFAULT NULL,
  `anchored` int(11) DEFAULT NULL,
  `anchorable` int(11) DEFAULT NULL,
  `fittableNonSingleton` int(11) DEFAULT NULL,
  `published` int(11) DEFAULT NULL,
  PRIMARY KEY (`groupID`),
  KEY `invGroups_IX_category` (`categoryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.invitems
CREATE TABLE IF NOT EXISTS `invitems` (
  `itemID` bigint(19) NOT NULL,
  `typeID` int(10) NOT NULL,
  `ownerID` int(10) NOT NULL,
  `locationID` bigint(19) NOT NULL,
  `flagID` smallint(5) NOT NULL,
  `quantity` int(10) NOT NULL,
  PRIMARY KEY (`itemID`),
  KEY `items_IX_Location` (`locationID`),
  KEY `items_IX_OwnerLocation` (`ownerID`,`locationID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.invmarketgroups
CREATE TABLE IF NOT EXISTS `invmarketgroups` (
  `marketGroupID` int(10) NOT NULL,
  `parentGroupID` int(10) DEFAULT NULL,
  `marketGroupName` varchar(100) DEFAULT NULL,
  `description` varchar(3000) DEFAULT NULL,
  `iconID` int(10) DEFAULT NULL,
  `hasTypes` int(11) DEFAULT NULL,
  PRIMARY KEY (`marketGroupID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.invmetagroups
CREATE TABLE IF NOT EXISTS `invmetagroups` (
  `metaGroupID` smallint(5) NOT NULL,
  `metaGroupName` varchar(100) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `iconID` int(10) DEFAULT NULL,
  PRIMARY KEY (`metaGroupID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.invmetatypes
CREATE TABLE IF NOT EXISTS `invmetatypes` (
  `typeID` int(10) NOT NULL,
  `parentTypeID` int(10) DEFAULT NULL,
  `metaGroupID` smallint(5) DEFAULT NULL,
  PRIMARY KEY (`typeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.invnames
CREATE TABLE IF NOT EXISTS `invnames` (
  `itemID` bigint(19) NOT NULL,
  `itemName` varchar(200) NOT NULL,
  PRIMARY KEY (`itemID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.invpositions
CREATE TABLE IF NOT EXISTS `invpositions` (
  `itemID` bigint(19) NOT NULL,
  `x` double NOT NULL DEFAULT '0',
  `y` double NOT NULL DEFAULT '0',
  `z` double NOT NULL DEFAULT '0',
  `yaw` float DEFAULT NULL,
  `pitch` float DEFAULT NULL,
  `roll` float DEFAULT NULL,
  PRIMARY KEY (`itemID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.invtypematerials
CREATE TABLE IF NOT EXISTS `invtypematerials` (
  `typeID` int(10) NOT NULL,
  `materialTypeID` int(10) NOT NULL,
  `quantity` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`typeID`,`materialTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.invtypereactions
CREATE TABLE IF NOT EXISTS `invtypereactions` (
  `reactionTypeID` int(10) NOT NULL,
  `input` int(11) NOT NULL,
  `typeID` int(10) NOT NULL,
  `quantity` smallint(5) DEFAULT NULL,
  PRIMARY KEY (`reactionTypeID`,`input`,`typeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.invtypes
CREATE TABLE IF NOT EXISTS `invtypes` (
  `typeID` int(10) NOT NULL,
  `groupID` int(10) DEFAULT NULL,
  `typeName` varchar(100) DEFAULT NULL,
  `description` varchar(3000) DEFAULT NULL,
  `mass` double DEFAULT NULL,
  `volume` double DEFAULT NULL,
  `capacity` double DEFAULT NULL,
  `portionSize` int(10) DEFAULT NULL,
  `raceID` int(11) DEFAULT NULL,
  `basePrice` decimal(19,4) DEFAULT NULL,
  `published` int(11) DEFAULT NULL,
  `marketGroupID` int(10) DEFAULT NULL,
  `chanceOfDuplicating` double DEFAULT NULL,
  `iconID` int(10) DEFAULT NULL,
  PRIMARY KEY (`typeID`),
  KEY `invTypes_IX_Group` (`groupID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.invuniquenames
CREATE TABLE IF NOT EXISTS `invuniquenames` (
  `itemID` int(10) NOT NULL,
  `itemName` varchar(200) NOT NULL,
  `groupID` int(10) DEFAULT NULL,
  PRIMARY KEY (`itemID`),
  UNIQUE KEY `invUniqueNames_UQ` (`itemName`),
  KEY `invUniqueNames_IX_GroupName` (`groupID`,`itemName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.mapcelestialstatistics
CREATE TABLE IF NOT EXISTS `mapcelestialstatistics` (
  `celestialID` int(10) NOT NULL,
  `temperature` double DEFAULT NULL,
  `spectralClass` varchar(10) DEFAULT NULL,
  `luminosity` double DEFAULT NULL,
  `age` double DEFAULT NULL,
  `life` double DEFAULT NULL,
  `orbitRadius` double DEFAULT NULL,
  `eccentricity` double DEFAULT NULL,
  `massDust` double DEFAULT NULL,
  `massGas` double DEFAULT NULL,
  `fragmented` int(11) DEFAULT NULL,
  `density` double DEFAULT NULL,
  `surfaceGravity` double DEFAULT NULL,
  `escapeVelocity` double DEFAULT NULL,
  `orbitPeriod` double DEFAULT NULL,
  `rotationRate` double DEFAULT NULL,
  `locked` int(11) DEFAULT NULL,
  `pressure` double DEFAULT NULL,
  `radius` double DEFAULT NULL,
  `mass` double DEFAULT NULL,
  PRIMARY KEY (`celestialID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.mapconstellationjumps
CREATE TABLE IF NOT EXISTS `mapconstellationjumps` (
  `fromRegionID` int(10) DEFAULT NULL,
  `fromConstellationID` int(10) NOT NULL,
  `toConstellationID` int(10) NOT NULL,
  `toRegionID` int(10) DEFAULT NULL,
  PRIMARY KEY (`fromConstellationID`,`toConstellationID`),
  KEY `mapConstellationJumps_IX_fromRe` (`fromRegionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.mapconstellations
CREATE TABLE IF NOT EXISTS `mapconstellations` (
  `regionID` int(10) DEFAULT NULL,
  `constellationID` int(10) NOT NULL,
  `constellationName` varchar(100) DEFAULT NULL,
  `x` double DEFAULT NULL,
  `y` double DEFAULT NULL,
  `z` double DEFAULT NULL,
  `xMin` double DEFAULT NULL,
  `xMax` double DEFAULT NULL,
  `yMin` double DEFAULT NULL,
  `yMax` double DEFAULT NULL,
  `zMin` double DEFAULT NULL,
  `zMax` double DEFAULT NULL,
  `factionID` int(10) DEFAULT NULL,
  `radius` double DEFAULT NULL,
  PRIMARY KEY (`constellationID`),
  KEY `mapConstellations_IX_region` (`regionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.mapdenormalize
CREATE TABLE IF NOT EXISTS `mapdenormalize` (
  `itemID` int(10) NOT NULL,
  `typeID` int(10) DEFAULT NULL,
  `groupID` int(10) DEFAULT NULL,
  `solarSystemID` int(10) DEFAULT NULL,
  `constellationID` int(10) DEFAULT NULL,
  `regionID` int(10) DEFAULT NULL,
  `orbitID` int(10) DEFAULT NULL,
  `x` double DEFAULT NULL,
  `y` double DEFAULT NULL,
  `z` double DEFAULT NULL,
  `radius` double DEFAULT NULL,
  `itemName` varchar(100) DEFAULT NULL,
  `security` double DEFAULT NULL,
  `celestialIndex` int(11) DEFAULT NULL,
  `orbitIndex` int(11) DEFAULT NULL,
  PRIMARY KEY (`itemID`),
  KEY `mapDenormalize_IX_constellation` (`constellationID`),
  KEY `mapDenormalize_IX_groupConstell` (`groupID`,`constellationID`),
  KEY `mapDenormalize_IX_groupRegion` (`groupID`,`regionID`),
  KEY `mapDenormalize_IX_groupSystem` (`groupID`,`solarSystemID`),
  KEY `mapDenormalize_IX_orbit` (`orbitID`),
  KEY `mapDenormalize_IX_region` (`regionID`),
  KEY `mapDenormalize_IX_system` (`solarSystemID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.mapjumps
CREATE TABLE IF NOT EXISTS `mapjumps` (
  `stargateID` int(10) NOT NULL,
  `celestialID` int(10) DEFAULT NULL,
  PRIMARY KEY (`stargateID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.maplandmarks
CREATE TABLE IF NOT EXISTS `maplandmarks` (
  `landmarkID` smallint(5) NOT NULL,
  `landmarkName` varchar(100) DEFAULT NULL,
  `description` varchar(7000) DEFAULT NULL,
  `locationID` int(10) DEFAULT NULL,
  `x` double DEFAULT NULL,
  `y` double DEFAULT NULL,
  `z` double DEFAULT NULL,
  `radius` double DEFAULT NULL,
  `iconID` int(10) DEFAULT NULL,
  `importance` int(11) DEFAULT NULL,
  PRIMARY KEY (`landmarkID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.maplocationscenes
CREATE TABLE IF NOT EXISTS `maplocationscenes` (
  `locationID` int(10) NOT NULL,
  `graphicID` int(10) DEFAULT NULL,
  PRIMARY KEY (`locationID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.maplocationwormholeclasses
CREATE TABLE IF NOT EXISTS `maplocationwormholeclasses` (
  `locationID` int(10) NOT NULL,
  `wormholeClassID` int(11) DEFAULT NULL,
  PRIMARY KEY (`locationID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.mapregionjumps
CREATE TABLE IF NOT EXISTS `mapregionjumps` (
  `fromRegionID` int(10) NOT NULL,
  `toRegionID` int(10) NOT NULL,
  PRIMARY KEY (`fromRegionID`,`toRegionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.mapregions
CREATE TABLE IF NOT EXISTS `mapregions` (
  `regionID` int(10) NOT NULL,
  `regionName` varchar(100) DEFAULT NULL,
  `x` double DEFAULT NULL,
  `y` double DEFAULT NULL,
  `z` double DEFAULT NULL,
  `xMin` double DEFAULT NULL,
  `xMax` double DEFAULT NULL,
  `yMin` double DEFAULT NULL,
  `yMax` double DEFAULT NULL,
  `zMin` double DEFAULT NULL,
  `zMax` double DEFAULT NULL,
  `factionID` int(10) DEFAULT NULL,
  `radius` double DEFAULT NULL,
  PRIMARY KEY (`regionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.mapsolarsystemjumps
CREATE TABLE IF NOT EXISTS `mapsolarsystemjumps` (
  `fromRegionID` int(10) DEFAULT NULL,
  `fromConstellationID` int(10) DEFAULT NULL,
  `fromSolarSystemID` int(10) NOT NULL,
  `toSolarSystemID` int(10) NOT NULL,
  `toConstellationID` int(10) DEFAULT NULL,
  `toRegionID` int(10) DEFAULT NULL,
  PRIMARY KEY (`fromSolarSystemID`,`toSolarSystemID`),
  KEY `mapSolarSystemJumps_IX_fromCons` (`fromConstellationID`),
  KEY `mapSolarSystemJumps_IX_fromRegi` (`fromRegionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.mapsolarsystems
CREATE TABLE IF NOT EXISTS `mapsolarsystems` (
  `regionID` int(10) DEFAULT NULL,
  `constellationID` int(10) DEFAULT NULL,
  `solarSystemID` int(10) NOT NULL,
  `solarSystemName` varchar(100) DEFAULT NULL,
  `x` double DEFAULT NULL,
  `y` double DEFAULT NULL,
  `z` double DEFAULT NULL,
  `xMin` double DEFAULT NULL,
  `xMax` double DEFAULT NULL,
  `yMin` double DEFAULT NULL,
  `yMax` double DEFAULT NULL,
  `zMin` double DEFAULT NULL,
  `zMax` double DEFAULT NULL,
  `luminosity` double DEFAULT NULL,
  `border` int(11) DEFAULT NULL,
  `fringe` int(11) DEFAULT NULL,
  `corridor` int(11) DEFAULT NULL,
  `hub` int(11) DEFAULT NULL,
  `international` int(11) DEFAULT NULL,
  `regional` int(11) DEFAULT NULL,
  `constellation` int(11) DEFAULT NULL,
  `security` double DEFAULT NULL,
  `factionID` int(10) DEFAULT NULL,
  `radius` double DEFAULT NULL,
  `sunTypeID` int(10) DEFAULT NULL,
  `securityClass` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`solarSystemID`),
  KEY `mapSolarSystems_IX_constellation` (`constellationID`),
  KEY `mapSolarSystems_IX_region` (`regionID`),
  KEY `mapSolarSystems_IX_security` (`security`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.mapuniverse
CREATE TABLE IF NOT EXISTS `mapuniverse` (
  `universeID` int(10) NOT NULL,
  `universeName` varchar(100) DEFAULT NULL,
  `x` double DEFAULT NULL,
  `y` double DEFAULT NULL,
  `z` double DEFAULT NULL,
  `xMin` double DEFAULT NULL,
  `xMax` double DEFAULT NULL,
  `yMin` double DEFAULT NULL,
  `yMax` double DEFAULT NULL,
  `zMin` double DEFAULT NULL,
  `zMax` double DEFAULT NULL,
  `radius` double DEFAULT NULL,
  PRIMARY KEY (`universeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.marketgroups
CREATE TABLE IF NOT EXISTS `marketgroups` (
  `marketGroupID` int(11) NOT NULL AUTO_INCREMENT,
  `parentGroupID` int(11) DEFAULT NULL,
  `marketGroupName` varchar(100) NOT NULL,
  `description` varchar(1000) NOT NULL,
  `iconID` int(11) NOT NULL,
  `hasTypes` tinyint(1) NOT NULL,
  PRIMARY KEY (`marketGroupID`),
  KEY `marketgroups_5c26cd08` (`parentGroupID`),
  KEY `marketgroups_6177d12f` (`iconID`),
  CONSTRAINT `iconID_refs_iconID_7db04963` FOREIGN KEY (`iconID`) REFERENCES `eveicons` (`iconID`),
  CONSTRAINT `parentGroupID_refs_marketGroupID_7f75578b` FOREIGN KEY (`parentGroupID`) REFERENCES `marketgroups` (`marketGroupID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.market_currprice
CREATE TABLE IF NOT EXISTS `market_currprice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL,
  `bid` tinyint(1) NOT NULL,
  `price` decimal(25,4) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `type_id` (`type_id`,`station_id`,`bid`),
  CONSTRAINT `type_id_refs_typeID_707cbf1d` FOREIGN KEY (`type_id`) REFERENCES `invtypes` (`typeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.market_information
CREATE TABLE IF NOT EXISTS `market_information` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` int(11) NOT NULL,
  `price` decimal(25,4) DEFAULT NULL,
  `volume` bigint(20) DEFAULT NULL,
  `relevance` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index 3` (`type_id`),
  KEY `market_information_777d41c8` (`type_id`),
  CONSTRAINT `type_id_refs_typeID_380ad4de` FOREIGN KEY (`type_id`) REFERENCES `invtypes` (`typeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.market_markethistory
CREATE TABLE IF NOT EXISTS `market_markethistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `orders` int(11) NOT NULL,
  `low` decimal(25,4) NOT NULL,
  `high` decimal(25,4) NOT NULL,
  `average` decimal(25,4) NOT NULL,
  `quantity` bigint(20) NOT NULL,
  `type_id` int(11) NOT NULL,
  `region_id` int(11) NOT NULL,
  `time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `date` (`date`,`type_id`,`region_id`),
  KEY `market_markethistory_777d41c8` (`type_id`),
  KEY `market_markethistory_9574fce` (`region_id`),
  KEY `Index 5` (`date`,`type_id`),
  CONSTRAINT `region_id_refs_regionID_52faca77` FOREIGN KEY (`region_id`) REFERENCES `mapregions` (`regionID`),
  CONSTRAINT `type_id_refs_typeID_35c09972` FOREIGN KEY (`type_id`) REFERENCES `invtypes` (`typeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.market_order
CREATE TABLE IF NOT EXISTS `market_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` bigint(20) NOT NULL,
  `price` decimal(25,4) NOT NULL,
  `type_id` int(11) NOT NULL,
  `volRemaining` int(11) NOT NULL,
  `range` int(11) NOT NULL,
  `volEntered` int(11) NOT NULL,
  `minVolume` int(11) NOT NULL,
  `bid` tinyint(1) NOT NULL,
  `issueDate` datetime NOT NULL,
  `duration` int(11) NOT NULL,
  `station_id` int(11) NOT NULL,
  `solarSystem_id` int(11) NOT NULL,
  `time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `market_order_777d41c8` (`type_id`),
  KEY `market_order_15e3331d` (`station_id`),
  KEY `market_order_272e372d` (`solarSystem_id`),
  CONSTRAINT `solarSystem_id_refs_solarSystemID_23a79698` FOREIGN KEY (`solarSystem_id`) REFERENCES `mapsolarsystems` (`solarSystemID`),
  CONSTRAINT `station_id_refs_stationID_2cf5c6a4` FOREIGN KEY (`station_id`) REFERENCES `stastations` (`stationID`),
  CONSTRAINT `type_id_refs_typeID_7923350e` FOREIGN KEY (`type_id`) REFERENCES `invtypes` (`typeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.planetschematics
CREATE TABLE IF NOT EXISTS `planetschematics` (
  `schematicID` smallint(5) NOT NULL,
  `schematicName` varchar(255) DEFAULT NULL,
  `cycleTime` int(10) DEFAULT NULL,
  PRIMARY KEY (`schematicID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.planetschematicspinmap
CREATE TABLE IF NOT EXISTS `planetschematicspinmap` (
  `schematicID` smallint(5) NOT NULL,
  `pinTypeID` int(10) NOT NULL,
  PRIMARY KEY (`schematicID`,`pinTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.planetschematicstypemap
CREATE TABLE IF NOT EXISTS `planetschematicstypemap` (
  `schematicID` smallint(5) NOT NULL,
  `typeID` int(10) NOT NULL,
  `quantity` smallint(5) DEFAULT NULL,
  `isInput` int(11) DEFAULT NULL,
  PRIMARY KEY (`schematicID`,`typeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.ramactivities
CREATE TABLE IF NOT EXISTS `ramactivities` (
  `activityID` int(11) NOT NULL,
  `activityName` varchar(100) DEFAULT NULL,
  `iconNo` varchar(5) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `published` int(11) DEFAULT NULL,
  PRIMARY KEY (`activityID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.ramassemblylines
CREATE TABLE IF NOT EXISTS `ramassemblylines` (
  `assemblyLineID` int(10) NOT NULL,
  `assemblyLineTypeID` int(11) DEFAULT NULL,
  `containerID` int(10) DEFAULT NULL,
  `nextFreeTime` datetime DEFAULT NULL,
  `UIGroupingID` int(11) DEFAULT NULL,
  `costInstall` double DEFAULT NULL,
  `costPerHour` double DEFAULT NULL,
  `restrictionMask` int(11) DEFAULT NULL,
  `discountPerGoodStandingPoint` double DEFAULT NULL,
  `surchargePerBadStandingPoint` double DEFAULT NULL,
  `minimumStanding` double DEFAULT NULL,
  `minimumCharSecurity` double DEFAULT NULL,
  `minimumCorpSecurity` double DEFAULT NULL,
  `maximumCharSecurity` double DEFAULT NULL,
  `maximumCorpSecurity` double DEFAULT NULL,
  `ownerID` int(10) DEFAULT NULL,
  `activityID` int(11) DEFAULT NULL,
  PRIMARY KEY (`assemblyLineID`),
  KEY `ramAssemblyLines_IX_container` (`containerID`),
  KEY `ramAssemblyLines_IX_owner` (`ownerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.ramassemblylinestations
CREATE TABLE IF NOT EXISTS `ramassemblylinestations` (
  `stationID` int(10) NOT NULL,
  `assemblyLineTypeID` int(11) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  `stationTypeID` int(10) DEFAULT NULL,
  `ownerID` int(10) DEFAULT NULL,
  `solarSystemID` int(10) DEFAULT NULL,
  `regionID` int(10) DEFAULT NULL,
  PRIMARY KEY (`stationID`,`assemblyLineTypeID`),
  KEY `ramAssemblyLineStations_IX_owner` (`ownerID`),
  KEY `ramAssemblyLineStations_IX_regi` (`regionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.ramassemblylinetypedetailpercategory
CREATE TABLE IF NOT EXISTS `ramassemblylinetypedetailpercategory` (
  `assemblyLineTypeID` int(11) NOT NULL,
  `categoryID` int(10) NOT NULL,
  `timeMultiplier` double DEFAULT NULL,
  `materialMultiplier` double DEFAULT NULL,
  PRIMARY KEY (`assemblyLineTypeID`,`categoryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.ramassemblylinetypedetailpergroup
CREATE TABLE IF NOT EXISTS `ramassemblylinetypedetailpergroup` (
  `assemblyLineTypeID` int(11) NOT NULL,
  `groupID` int(10) NOT NULL,
  `timeMultiplier` double DEFAULT NULL,
  `materialMultiplier` double DEFAULT NULL,
  PRIMARY KEY (`assemblyLineTypeID`,`groupID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.ramassemblylinetypes
CREATE TABLE IF NOT EXISTS `ramassemblylinetypes` (
  `assemblyLineTypeID` int(11) NOT NULL,
  `assemblyLineTypeName` varchar(100) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `baseTimeMultiplier` double DEFAULT NULL,
  `baseMaterialMultiplier` double DEFAULT NULL,
  `volume` double DEFAULT NULL,
  `activityID` int(11) DEFAULT NULL,
  `minCostPerHour` double DEFAULT NULL,
  PRIMARY KEY (`assemblyLineTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.raminstallationtypecontents
CREATE TABLE IF NOT EXISTS `raminstallationtypecontents` (
  `installationTypeID` int(10) NOT NULL,
  `assemblyLineTypeID` int(11) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`installationTypeID`,`assemblyLineTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.ramtyperequirements
CREATE TABLE IF NOT EXISTS `ramtyperequirements` (
  `typeID` int(10) NOT NULL,
  `activityID` int(11) NOT NULL,
  `requiredTypeID` int(10) NOT NULL,
  `quantity` int(10) DEFAULT NULL,
  `damagePerJob` double DEFAULT NULL,
  `recycle` int(11) DEFAULT NULL,
  PRIMARY KEY (`typeID`,`activityID`,`requiredTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.staoperations
CREATE TABLE IF NOT EXISTS `staoperations` (
  `activityID` int(11) DEFAULT NULL,
  `operationID` int(11) NOT NULL,
  `operationName` varchar(100) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `fringe` int(11) DEFAULT NULL,
  `corridor` int(11) DEFAULT NULL,
  `hub` int(11) DEFAULT NULL,
  `border` int(11) DEFAULT NULL,
  `ratio` int(11) DEFAULT NULL,
  `caldariStationTypeID` int(10) DEFAULT NULL,
  `minmatarStationTypeID` int(10) DEFAULT NULL,
  `amarrStationTypeID` int(10) DEFAULT NULL,
  `gallenteStationTypeID` int(10) DEFAULT NULL,
  `joveStationTypeID` int(10) DEFAULT NULL,
  PRIMARY KEY (`operationID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.staoperationservices
CREATE TABLE IF NOT EXISTS `staoperationservices` (
  `operationID` int(11) NOT NULL,
  `serviceID` int(10) NOT NULL,
  PRIMARY KEY (`operationID`,`serviceID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.staservices
CREATE TABLE IF NOT EXISTS `staservices` (
  `serviceID` int(10) NOT NULL,
  `serviceName` varchar(100) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`serviceID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.stastations
CREATE TABLE IF NOT EXISTS `stastations` (
  `stationID` int(10) NOT NULL,
  `security` smallint(5) DEFAULT NULL,
  `dockingCostPerVolume` double DEFAULT NULL,
  `maxShipVolumeDockable` double DEFAULT NULL,
  `officeRentalCost` int(10) DEFAULT NULL,
  `operationID` int(11) DEFAULT NULL,
  `stationTypeID` int(10) DEFAULT NULL,
  `corporationID` int(10) DEFAULT NULL,
  `solarSystemID` int(10) DEFAULT NULL,
  `constellationID` int(10) DEFAULT NULL,
  `regionID` int(10) DEFAULT NULL,
  `stationName` varchar(100) DEFAULT NULL,
  `x` double DEFAULT NULL,
  `y` double DEFAULT NULL,
  `z` double DEFAULT NULL,
  `reprocessingEfficiency` double DEFAULT NULL,
  `reprocessingStationsTake` double DEFAULT NULL,
  `reprocessingHangarFlag` int(11) DEFAULT NULL,
  PRIMARY KEY (`stationID`),
  KEY `staStations_IX_constellation` (`constellationID`),
  KEY `staStations_IX_corporation` (`corporationID`),
  KEY `staStations_IX_operation` (`operationID`),
  KEY `staStations_IX_region` (`regionID`),
  KEY `staStations_IX_system` (`solarSystemID`),
  KEY `staStations_IX_type` (`stationTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.stastationtypes
CREATE TABLE IF NOT EXISTS `stastationtypes` (
  `stationTypeID` int(10) NOT NULL,
  `dockEntryX` double DEFAULT NULL,
  `dockEntryY` double DEFAULT NULL,
  `dockEntryZ` double DEFAULT NULL,
  `dockOrientationX` double DEFAULT NULL,
  `dockOrientationY` double DEFAULT NULL,
  `dockOrientationZ` double DEFAULT NULL,
  `operationID` int(11) DEFAULT NULL,
  `officeSlots` int(11) DEFAULT NULL,
  `reprocessingEfficiency` double DEFAULT NULL,
  `conquerable` int(11) DEFAULT NULL,
  PRIMARY KEY (`stationTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.translationtables
CREATE TABLE IF NOT EXISTS `translationtables` (
  `sourceTable` varchar(200) NOT NULL,
  `destinationTable` varchar(200) DEFAULT NULL,
  `translatedKey` varchar(200) NOT NULL,
  `tcGroupID` int(10) DEFAULT NULL,
  `tcID` int(10) DEFAULT NULL,
  PRIMARY KEY (`sourceTable`,`translatedKey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.trntranslationcolumns
CREATE TABLE IF NOT EXISTS `trntranslationcolumns` (
  `tcGroupID` smallint(5) DEFAULT NULL,
  `tcID` smallint(5) NOT NULL,
  `tableName` varchar(256) NOT NULL,
  `columnName` varchar(128) NOT NULL,
  `masterID` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`tcID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.trntranslationlanguages
CREATE TABLE IF NOT EXISTS `trntranslationlanguages` (
  `numericLanguageID` int(10) NOT NULL,
  `languageID` varchar(50) DEFAULT NULL,
  `languageName` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`numericLanguageID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.trntranslations
CREATE TABLE IF NOT EXISTS `trntranslations` (
  `tcID` smallint(5) NOT NULL,
  `keyID` int(10) NOT NULL,
  `languageID` varchar(50) NOT NULL,
  `text` text,
  PRIMARY KEY (`tcID`,`keyID`,`languageID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.warcombatzones
CREATE TABLE IF NOT EXISTS `warcombatzones` (
  `combatZoneID` int(10) NOT NULL DEFAULT '-1',
  `combatZoneName` varchar(100) DEFAULT NULL,
  `factionID` int(10) DEFAULT NULL,
  `centerSystemID` int(10) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`combatZoneID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eve.warcombatzonesystems
CREATE TABLE IF NOT EXISTS `warcombatzonesystems` (
  `solarSystemID` int(10) NOT NULL,
  `combatZoneID` int(10) DEFAULT NULL,
  PRIMARY KEY (`solarSystemID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
