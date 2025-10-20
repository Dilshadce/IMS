-- MySQL dump 10.13  Distrib 5.1.60, for Win64 (unknown)
--
-- Host: 169.254.228.112    Database: demoinsurance_i
-- ------------------------------------------------------
-- Server version	5.1.60-community-log

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
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `address` (
  `CODE` varchar(8) NOT NULL DEFAULT '',
  `NAME` varchar(40) NOT NULL DEFAULT '',
  `CUSTNO` varchar(12) NOT NULL DEFAULT '',
  `ADD1` varchar(35) NOT NULL DEFAULT '',
  `ADD2` varchar(35) NOT NULL DEFAULT '',
  `ADD3` varchar(35) NOT NULL DEFAULT '',
  `ADD4` varchar(35) NOT NULL DEFAULT '',
  `COUNTRY` varchar(25) NOT NULL DEFAULT '',
  `POSTALCODE` varchar(25) NOT NULL DEFAULT '',
  `ATTN` varchar(35) NOT NULL DEFAULT '',
  `PHONE` varchar(25) NOT NULL DEFAULT '',
  `FAX` varchar(25) NOT NULL DEFAULT '',
  `PHONEA` varchar(45) NOT NULL DEFAULT '',
  `E_MAIL` varchar(80) NOT NULL DEFAULT '',
  PRIMARY KEY (`CODE`,`NAME`),
  KEY `ADDRESSINFO` (`CODE`,`NAME`,`CUSTNO`,`ADD1`,`ADD2`,`ADD3`,`ADD4`,`ATTN`,`PHONE`,`FAX`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `apvend`
--

DROP TABLE IF EXISTS `apvend`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `apvend` (
  `EDI_ID` varchar(12) DEFAULT NULL,
  `CUSTNO` varchar(12) NOT NULL DEFAULT '',
  `NAME` varchar(40) DEFAULT NULL,
  `NAME2` varchar(40) DEFAULT NULL,
  `ADD1` varchar(35) DEFAULT NULL,
  `ADD2` varchar(35) DEFAULT NULL,
  `ADD3` varchar(35) DEFAULT NULL,
  `ADD4` varchar(35) DEFAULT NULL,
  `ATTN` varchar(35) DEFAULT NULL,
  `DADDR1` varchar(35) DEFAULT NULL,
  `DADDR2` varchar(35) DEFAULT NULL,
  `DADDR3` varchar(35) DEFAULT NULL,
  `DADDR4` varchar(35) DEFAULT NULL,
  `DATTN` varchar(35) DEFAULT NULL,
  `CONTACT` varchar(35) CHARACTER SET latin2 DEFAULT '',
  `PHONE` varchar(35) CHARACTER SET latin2 DEFAULT '',
  `PHONEA` varchar(25) DEFAULT NULL,
  `DPHONE` varchar(25) DEFAULT NULL,
  `FAX` varchar(25) DEFAULT NULL,
  `DFAX` varchar(25) DEFAULT NULL,
  `E_MAIL` varchar(100) DEFAULT '',
  `WEB_SITE` varchar(50) DEFAULT NULL,
  `BANKACCNO` varchar(18) DEFAULT NULL,
  `AREA` varchar(12) DEFAULT NULL,
  `AGENT` varchar(12) DEFAULT NULL,
  `BUSINESS` varchar(15) DEFAULT NULL,
  `TERM` varchar(12) DEFAULT NULL,
  `CRLIMIT` decimal(19,2) NOT NULL DEFAULT '0.00',
  `CURRCODE` varchar(10) DEFAULT NULL,
  `CURRENCY` varchar(10) DEFAULT NULL,
  `CURRENCY1` varchar(27) DEFAULT '',
  `CURRENCY2` varchar(27) DEFAULT '',
  `POINT_BF` decimal(19,2) NOT NULL DEFAULT '0.00',
  `AUTOPAY` char(1) DEFAULT NULL,
  `LC_EX` decimal(1,0) NOT NULL DEFAULT '0',
  `CT_GROUP` varchar(8) DEFAULT NULL,
  `TEMP` decimal(19,2) NOT NULL DEFAULT '0.00',
  `TARGET` decimal(19,2) NOT NULL DEFAULT '0.00',
  `MOD_DEL` varchar(2) DEFAULT NULL,
  `ARREM1` varchar(35) DEFAULT NULL,
  `ARREM2` varchar(35) DEFAULT NULL,
  `ARREM3` varchar(35) DEFAULT NULL,
  `ARREM4` varchar(35) DEFAULT NULL,
  `GROUPTO` varchar(12) DEFAULT NULL,
  `STATUS` char(1) DEFAULT NULL,
  `CUST_TYPE` varchar(3) DEFAULT NULL,
  `ACCSTATUS` char(1) DEFAULT NULL,
  `DATE` date NOT NULL DEFAULT '0000-00-00',
  `INVLIMIT` decimal(19,2) DEFAULT '0.00',
  `TERMEXCEED` char(1) DEFAULT NULL,
  `CHANNEL` varchar(20) DEFAULT NULL,
  `SALEC` varchar(12) DEFAULT NULL,
  `SALECNC` varchar(12) DEFAULT NULL,
  `TERM_IN_M` decimal(2,0) NOT NULL DEFAULT '0',
  `CR_AP_REF` varchar(20) DEFAULT NULL,
  `CR_AP_DATE` date NOT NULL DEFAULT '0000-00-00',
  `COLLATERAL` varchar(20) DEFAULT NULL,
  `GUARANTOR` varchar(20) DEFAULT NULL,
  `DISPEC_CAT` char(1) DEFAULT NULL,
  `DISPEC1` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DISPEC2` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DISPEC3` decimal(5,2) NOT NULL DEFAULT '0.00',
  `COMMPERC` decimal(5,2) NOT NULL DEFAULT '0.00',
  `OUTSTAND` decimal(19,2) NOT NULL DEFAULT '0.00',
  `NGST_CUST` enum('T','F') NOT NULL DEFAULT 'T',
  `taxincl_cust` varchar(45) DEFAULT 'F',
  `PERSONIC1` varchar(50) DEFAULT NULL,
  `POSITION1` varchar(50) DEFAULT NULL,
  `DEPT1` varchar(50) DEFAULT NULL,
  `CONTACT1` varchar(25) DEFAULT NULL,
  `SITENAME` varchar(50) DEFAULT NULL,
  `SITEADD1` varchar(40) DEFAULT NULL,
  `SITEADD2` varchar(40) DEFAULT NULL,
  `EDITED` char(1) DEFAULT NULL,
  `ACC_CODE` varchar(12) DEFAULT NULL,
  `PROV_DISC` decimal(5,2) NOT NULL DEFAULT '0.00',
  `comuen` varchar(45) DEFAULT NULL,
  `CREATED_BY` varchar(45) DEFAULT NULL,
  `UPDATED_BY` varchar(45) DEFAULT NULL,
  `CREATED_ON` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `UPDATED_ON` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `GSTNO` varchar(25) DEFAULT NULL,
  `COUNTRY` varchar(25) DEFAULT NULL,
  `POSTALCODE` varchar(25) DEFAULT NULL,
  `D_COUNTRY` varchar(25) DEFAULT NULL,
  `D_POSTALCODE` varchar(25) DEFAULT NULL,
  `END_USER` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`CUSTNO`),
  KEY `SUPPBASICINFO` (`CUSTNO`,`NAME`,`AREA`,`AGENT`,`BUSINESS`,`TERM`,`CURRCODE`,`STATUS`,`TERMEXCEED`,`SALEC`,`SALECNC`) USING BTREE,
  KEY `BILLADDINFO` (`CUSTNO`,`NAME`,`NAME2`,`ADD1`,`ADD2`,`ADD3`,`ADD4`,`ATTN`,`CONTACT`,`PHONE`,`FAX`) USING BTREE,
  KEY `DELADDINFO` (`CUSTNO`,`NAME`,`NAME2`,`DADDR1`,`DADDR2`,`DADDR3`,`DADDR4`,`DATTN`,`CONTACT`,`PHONE`,`FAX`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `apvend`
--

LOCK TABLES `apvend` WRITE;
/*!40000 ALTER TABLE `apvend` DISABLE KEYS */;
/*!40000 ALTER TABLE `apvend` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `apvend_temp`
--

DROP TABLE IF EXISTS `apvend_temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `apvend_temp` (
  `CUSTNO` varchar(12) NOT NULL DEFAULT '',
  `NAME` varchar(40) NOT NULL DEFAULT '',
  `NAME2` varchar(40) NOT NULL DEFAULT '',
  `ADD1` varchar(35) NOT NULL DEFAULT '',
  `ADD2` varchar(35) NOT NULL DEFAULT '',
  `ADD3` varchar(35) NOT NULL DEFAULT '',
  `ADD4` varchar(35) NOT NULL DEFAULT '',
  `ATTN` varchar(35) NOT NULL DEFAULT '',
  `DADDR1` varchar(35) NOT NULL DEFAULT '',
  `DADDR2` varchar(35) NOT NULL DEFAULT '',
  `DADDR3` varchar(35) NOT NULL DEFAULT '',
  `DADDR4` varchar(35) NOT NULL DEFAULT '',
  `DATTN` varchar(35) NOT NULL DEFAULT '',
  `CONTACT` varchar(15) NOT NULL DEFAULT '',
  `PHONE` varchar(25) NOT NULL DEFAULT '',
  `PHONE2` varchar(25) NOT NULL DEFAULT '',
  `FAX` varchar(25) NOT NULL DEFAULT '',
  `E_MAIL` varchar(50) NOT NULL DEFAULT '',
  `WEB_SITE` varchar(50) NOT NULL DEFAULT '',
  `AGENT` varchar(12) NOT NULL DEFAULT '',
  `TERM` varchar(12) NOT NULL DEFAULT '',
  `AREA` varchar(12) NOT NULL DEFAULT '',
  `BUSINESS` varchar(15) NOT NULL DEFAULT '',
  `CRLIMIT` decimal(19,2) NOT NULL DEFAULT '0.00',
  `CURRCODE` varchar(4) NOT NULL DEFAULT '',
  `CURRENCY` varchar(10) NOT NULL DEFAULT '',
  `CURRENCY1` varchar(17) NOT NULL DEFAULT '',
  `CURRENCY2` varchar(17) NOT NULL DEFAULT '',
  `DATE` date NOT NULL DEFAULT '0000-00-00',
  `INVLIMIT` decimal(19,2) NOT NULL DEFAULT '0.00',
  `STATUS` char(1) NOT NULL DEFAULT '',
  `CREATED_ON` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `CREATED_BY` varchar(50) NOT NULL DEFAULT '',
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `apvend_temp`
--

LOCK TABLES `apvend_temp` WRITE;
/*!40000 ALTER TABLE `apvend_temp` DISABLE KEYS */;
/*!40000 ALTER TABLE `apvend_temp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `arcust`
--

DROP TABLE IF EXISTS `arcust`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `arcust` (
  `EDI_ID` varchar(12) DEFAULT NULL,
  `CUSTNO` varchar(12) NOT NULL DEFAULT '',
  `NAME` varchar(40) DEFAULT NULL,
  `NAME2` varchar(40) DEFAULT NULL,
  `ADD1` varchar(35) DEFAULT NULL,
  `ADD2` varchar(35) DEFAULT NULL,
  `ADD3` varchar(35) DEFAULT NULL,
  `ADD4` varchar(35) DEFAULT NULL,
  `ATTN` varchar(35) DEFAULT NULL,
  `DADDR1` varchar(35) DEFAULT NULL,
  `DADDR2` varchar(35) DEFAULT NULL,
  `DADDR3` varchar(35) DEFAULT NULL,
  `DADDR4` varchar(35) DEFAULT NULL,
  `DATTN` varchar(35) DEFAULT NULL,
  `CONTACT` varchar(35) CHARACTER SET latin2 DEFAULT '',
  `PHONE` varchar(35) CHARACTER SET latin2 DEFAULT '',
  `PHONEA` varchar(25) DEFAULT NULL,
  `DPHONE` varchar(25) DEFAULT NULL,
  `FAX` varchar(25) DEFAULT NULL,
  `DFAX` varchar(25) DEFAULT NULL,
  `E_MAIL` varchar(100) DEFAULT '',
  `WEB_SITE` varchar(50) DEFAULT NULL,
  `BANKACCNO` varchar(18) DEFAULT NULL,
  `AREA` varchar(12) DEFAULT NULL,
  `AGENT` varchar(12) DEFAULT NULL,
  `BUSINESS` varchar(15) DEFAULT NULL,
  `TERM` varchar(12) DEFAULT NULL,
  `CRLIMIT` decimal(19,2) NOT NULL DEFAULT '0.00',
  `CURRCODE` varchar(10) DEFAULT NULL,
  `CURRENCY` varchar(10) DEFAULT NULL,
  `CURRENCY1` varchar(27) DEFAULT '',
  `CURRENCY2` varchar(27) DEFAULT '',
  `POINT_BF` decimal(19,2) NOT NULL DEFAULT '0.00',
  `AUTOPAY` char(1) DEFAULT NULL,
  `LC_EX` decimal(1,0) NOT NULL DEFAULT '0',
  `CT_GROUP` varchar(8) DEFAULT NULL,
  `TEMP` decimal(19,2) NOT NULL DEFAULT '0.00',
  `TARGET` decimal(19,2) NOT NULL DEFAULT '0.00',
  `MOD_DEL` varchar(2) DEFAULT NULL,
  `ARREM1` varchar(35) DEFAULT NULL,
  `ARREM2` varchar(35) DEFAULT NULL,
  `ARREM3` varchar(35) DEFAULT NULL,
  `ARREM4` varchar(35) DEFAULT NULL,
  `GROUPTO` varchar(12) DEFAULT NULL,
  `STATUS` char(1) DEFAULT NULL,
  `CUST_TYPE` varchar(3) DEFAULT NULL,
  `ACCSTATUS` char(1) DEFAULT NULL,
  `DATE` date NOT NULL DEFAULT '0000-00-00',
  `INVLIMIT` decimal(19,2) DEFAULT '0.00',
  `TERMEXCEED` char(1) DEFAULT NULL,
  `CHANNEL` varchar(20) DEFAULT NULL,
  `SALEC` varchar(12) DEFAULT NULL,
  `SALECNC` varchar(12) DEFAULT NULL,
  `TERM_IN_M` decimal(2,0) NOT NULL DEFAULT '0',
  `CR_AP_REF` varchar(20) DEFAULT NULL,
  `CR_AP_DATE` date NOT NULL DEFAULT '0000-00-00',
  `COLLATERAL` varchar(20) DEFAULT NULL,
  `GUARANTOR` varchar(20) DEFAULT NULL,
  `DISPEC_CAT` char(1) DEFAULT NULL,
  `DISPEC1` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DISPEC2` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DISPEC3` decimal(5,2) NOT NULL DEFAULT '0.00',
  `COMMPERC` decimal(5,2) NOT NULL DEFAULT '0.00',
  `OUTSTAND` decimal(19,2) NOT NULL DEFAULT '0.00',
  `NGST_CUST` enum('T','F') NOT NULL DEFAULT 'T',
  `taxincl_cust` varchar(45) DEFAULT 'F',
  `PERSONIC1` varchar(50) DEFAULT NULL,
  `POSITION1` varchar(50) DEFAULT NULL,
  `DEPT1` varchar(50) DEFAULT NULL,
  `CONTACT1` varchar(25) DEFAULT NULL,
  `SITENAME` varchar(50) DEFAULT NULL,
  `SITEADD1` varchar(40) DEFAULT NULL,
  `SITEADD2` varchar(40) DEFAULT NULL,
  `EDITED` char(1) DEFAULT NULL,
  `ACC_CODE` varchar(12) DEFAULT NULL,
  `PROV_DISC` decimal(5,2) NOT NULL DEFAULT '0.00',
  `comuen` varchar(45) DEFAULT NULL,
  `CREATED_BY` varchar(45) DEFAULT NULL,
  `UPDATED_BY` varchar(45) DEFAULT NULL,
  `CREATED_ON` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `UPDATED_ON` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `GSTNO` varchar(25) DEFAULT NULL,
  `COUNTRY` varchar(25) DEFAULT NULL,
  `POSTALCODE` varchar(25) DEFAULT NULL,
  `D_COUNTRY` varchar(25) DEFAULT NULL,
  `D_POSTALCODE` varchar(25) DEFAULT NULL,
  `END_USER` varchar(45) DEFAULT NULL,
  `NORMAL_RATE` varchar(45) DEFAULT NULL,
  `OFFER_RATE` varchar(45) DEFAULT NULL,
  `OTHERS_RATE` varchar(45) DEFAULT NULL,
  `BADSTATUS` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`CUSTNO`),
  KEY `SUPPBASICINFO` (`CUSTNO`,`NAME`,`AREA`,`AGENT`,`BUSINESS`,`TERM`,`CURRCODE`,`STATUS`,`TERMEXCEED`,`SALEC`,`SALECNC`) USING BTREE,
  KEY `BILLADDINFO` (`CUSTNO`,`NAME`,`NAME2`,`ADD1`,`ADD2`,`ADD3`,`ADD4`,`ATTN`,`CONTACT`,`PHONE`,`FAX`) USING BTREE,
  KEY `DELADDINFO` (`CUSTNO`,`NAME`,`NAME2`,`DADDR1`,`DADDR2`,`DADDR3`,`DADDR4`,`DATTN`,`CONTACT`,`PHONE`,`FAX`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `arcust`
--

LOCK TABLES `arcust` WRITE;
/*!40000 ALTER TABLE `arcust` DISABLE KEYS */;
/*!40000 ALTER TABLE `arcust` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `arcust_temp`
--

DROP TABLE IF EXISTS `arcust_temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `arcust_temp` (
  `CUSTNO` varchar(12) NOT NULL DEFAULT '',
  `NAME` varchar(40) NOT NULL DEFAULT '',
  `NAME2` varchar(40) NOT NULL DEFAULT '',
  `ADD1` varchar(35) NOT NULL DEFAULT '',
  `ADD2` varchar(35) NOT NULL DEFAULT '',
  `ADD3` varchar(35) NOT NULL DEFAULT '',
  `ADD4` varchar(35) NOT NULL DEFAULT '',
  `ATTN` varchar(35) NOT NULL DEFAULT '',
  `DADDR1` varchar(35) NOT NULL DEFAULT '',
  `DADDR2` varchar(35) NOT NULL DEFAULT '',
  `DADDR3` varchar(35) NOT NULL DEFAULT '',
  `DADDR4` varchar(35) NOT NULL DEFAULT '',
  `DATTN` varchar(35) NOT NULL DEFAULT '',
  `CONTACT` varchar(15) NOT NULL DEFAULT '',
  `PHONE` varchar(25) NOT NULL DEFAULT '',
  `PHONE2` varchar(25) NOT NULL DEFAULT '',
  `FAX` varchar(25) NOT NULL DEFAULT '',
  `E_MAIL` varchar(50) NOT NULL DEFAULT '',
  `WEB_SITE` varchar(50) NOT NULL DEFAULT '',
  `AGENT` varchar(12) NOT NULL DEFAULT '',
  `TERM` varchar(12) NOT NULL DEFAULT '',
  `AREA` varchar(12) NOT NULL DEFAULT '',
  `BUSINESS` varchar(15) NOT NULL DEFAULT '',
  `CRLIMIT` decimal(19,2) NOT NULL DEFAULT '0.00',
  `CURRCODE` varchar(4) NOT NULL DEFAULT '',
  `CURRENCY` varchar(10) NOT NULL DEFAULT '',
  `CURRENCY1` varchar(17) NOT NULL DEFAULT '',
  `CURRENCY2` varchar(17) NOT NULL DEFAULT '',
  `DATE` date NOT NULL DEFAULT '0000-00-00',
  `INVLIMIT` decimal(19,2) NOT NULL DEFAULT '0.00',
  `STATUS` char(1) NOT NULL DEFAULT '',
  `CREATED_ON` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `CREATED_BY` varchar(50) NOT NULL DEFAULT '',
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `arcust_temp`
--

LOCK TABLES `arcust_temp` WRITE;
/*!40000 ALTER TABLE `arcust_temp` DISABLE KEYS */;
/*!40000 ALTER TABLE `arcust_temp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artran`
--

DROP TABLE IF EXISTS `artran`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `artran` (
  `TYPE` varchar(4) NOT NULL DEFAULT '',
  `REFNO` varchar(50) NOT NULL DEFAULT '',
  `REFNO2` varchar(24) NOT NULL DEFAULT '',
  `OLD_REFNO` varchar(24) NOT NULL DEFAULT '',
  `REVISION` int(4) unsigned NOT NULL DEFAULT '0',
  `TRANCODE` int(4) NOT NULL DEFAULT '0',
  `CUSTNO` varchar(12) NOT NULL DEFAULT '',
  `FPERIOD` varchar(2) NOT NULL DEFAULT '',
  `WOS_DATE` date NOT NULL DEFAULT '0000-00-00',
  `TRAN_DATE` date NOT NULL DEFAULT '0000-00-00',
  `DESP` varchar(40) NOT NULL DEFAULT '',
  `DESPA` varchar(40) NOT NULL DEFAULT '',
  `AGENNO` varchar(20) NOT NULL DEFAULT '',
  `AREA` varchar(12) NOT NULL DEFAULT '',
  `SOURCE` varchar(40) DEFAULT '',
  `JOB` varchar(40) DEFAULT '',
  `CURRRATE` double(16,10) NOT NULL DEFAULT '0.0000000000',
  `GROSS_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `DISC1_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `DISC2_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `DISC3_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `DISC_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `NET_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `TAX1_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `TAX2_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `TAX3_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `TAX_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `GRAND_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `DEBIT_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `CREDIT_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `INVGROSS` double(15,5) NOT NULL DEFAULT '0.00000',
  `DISP1` double(10,5) NOT NULL DEFAULT '0.00000',
  `DISP2` double(10,5) NOT NULL DEFAULT '0.00000',
  `DISP3` double(10,5) NOT NULL DEFAULT '0.00000',
  `DISCOUNT1` double(15,5) NOT NULL DEFAULT '0.00000',
  `DISCOUNT2` double(15,5) NOT NULL DEFAULT '0.00000',
  `DISCOUNT3` double(15,5) NOT NULL DEFAULT '0.00000',
  `DISCOUNT` double(15,5) NOT NULL DEFAULT '0.00000',
  `NET` double(15,5) NOT NULL DEFAULT '0.00000',
  `TAX1` double(15,5) NOT NULL DEFAULT '0.00000',
  `TAX2` double(15,5) NOT NULL DEFAULT '0.00000',
  `TAX3` double(15,5) NOT NULL DEFAULT '0.00000',
  `TAX` double(15,5) NOT NULL DEFAULT '0.00000',
  `TAXP1` double(5,2) NOT NULL DEFAULT '0.00',
  `TAXP2` double(5,2) NOT NULL DEFAULT '0.00',
  `TAXP3` double(5,2) NOT NULL DEFAULT '0.00',
  `GRAND` double(15,5) NOT NULL DEFAULT '0.00000',
  `DEBITAMT` double(15,5) NOT NULL DEFAULT '0.00000',
  `CREDITAMT` double(15,5) NOT NULL DEFAULT '0.00000',
  `MC1_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `MC2_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `M_CHARGE1` double(15,5) NOT NULL DEFAULT '0.00000',
  `M_CHARGE2` double(15,5) NOT NULL DEFAULT '0.00000',
  `CS_PM_CASH` double(15,5) NOT NULL DEFAULT '0.00000',
  `CS_PM_CHEQ` double(15,5) NOT NULL DEFAULT '0.00000',
  `CS_PM_CRCD` double(15,5) NOT NULL DEFAULT '0.00000',
  `CS_PM_CRC2` double(15,5) NOT NULL DEFAULT '0.00000',
  `CS_PM_TT` double(15,5) NOT NULL DEFAULT '0.00000',
  `CS_PM_DBCD` double(15,5) NOT NULL DEFAULT '0.00000',
  `CS_PM_VOUC` double(15,5) NOT NULL DEFAULT '0.00000',
  `DEPOSIT` double(15,5) NOT NULL DEFAULT '0.00000',
  `CS_PM_DEBT` double(15,5) NOT NULL DEFAULT '0.00000',
  `CS_PM_WHT` double(15,5) NOT NULL DEFAULT '0.00000',
  `CHECKNO` varchar(12) NOT NULL DEFAULT '',
  `IMPSTAGE` varchar(12) NOT NULL DEFAULT '',
  `BILLCOST` double(15,5) NOT NULL DEFAULT '0.00000',
  `BILLSALE` double(15,5) NOT NULL DEFAULT '0.00000',
  `PAIDDATE` date NOT NULL DEFAULT '0000-00-00',
  `PAIDAMT` double(17,5) NOT NULL DEFAULT '0.00000',
  `REFNO3` varchar(24) NOT NULL DEFAULT '',
  `AGE` varchar(2) NOT NULL DEFAULT '',
  `NOTE` varchar(8) NOT NULL DEFAULT '',
  `TERM` varchar(12) NOT NULL DEFAULT '',
  `ISCASH` varchar(2) NOT NULL DEFAULT '',
  `VAN` varchar(8) NOT NULL DEFAULT '',
  `DEL_BY` varchar(12) NOT NULL DEFAULT '',
  `PLA_DODATE` date NOT NULL DEFAULT '0000-00-00',
  `ACT_DODATE` date NOT NULL DEFAULT '0000-00-00',
  `URGENCY` char(1) NOT NULL DEFAULT '',
  `CURRRATE2` double(16,5) NOT NULL DEFAULT '0.00000',
  `STAXACC` varchar(8) NOT NULL DEFAULT '',
  `SUPP1` varchar(8) NOT NULL DEFAULT '',
  `SUPP2` varchar(8) NOT NULL DEFAULT '',
  `PONO` varchar(350) DEFAULT '',
  `DONO` varchar(350) DEFAULT '',
  `REM0` varchar(35) NOT NULL DEFAULT '',
  `REM1` varchar(35) NOT NULL DEFAULT '',
  `REM2` varchar(35) NOT NULL DEFAULT '',
  `REM3` varchar(35) NOT NULL DEFAULT '',
  `REM4` varchar(35) NOT NULL DEFAULT '',
  `REM5` varchar(80) NOT NULL DEFAULT '',
  `REM6` varchar(80) NOT NULL DEFAULT '',
  `REM7` varchar(80) NOT NULL DEFAULT '',
  `REM8` varchar(80) NOT NULL DEFAULT '',
  `REM9` varchar(80) NOT NULL DEFAULT '',
  `REM10` varchar(35) NOT NULL DEFAULT '',
  `REM11` varchar(35) NOT NULL DEFAULT '',
  `REM12` varchar(35) NOT NULL DEFAULT '',
  `permitno` varchar(200) NOT NULL DEFAULT '',
  `FREM0` varchar(80) NOT NULL DEFAULT '',
  `FREM1` varchar(80) NOT NULL DEFAULT '',
  `FREM2` varchar(80) NOT NULL DEFAULT '',
  `FREM3` varchar(80) NOT NULL DEFAULT '',
  `FREM4` varchar(80) NOT NULL DEFAULT '',
  `FREM5` varchar(80) NOT NULL DEFAULT '',
  `FREM6` varchar(80) NOT NULL DEFAULT '',
  `FREM7` varchar(80) NOT NULL DEFAULT '',
  `FREM8` varchar(80) NOT NULL DEFAULT '',
  `FREM9` varchar(80) NOT NULL DEFAULT '',
  `COMM1` varchar(35) NOT NULL DEFAULT '',
  `COMM2` varchar(35) NOT NULL DEFAULT '',
  `COMM3` varchar(35) NOT NULL DEFAULT '',
  `COMM4` varchar(35) NOT NULL DEFAULT '',
  `ID` char(1) NOT NULL DEFAULT '',
  `GENERATED` char(1) NOT NULL DEFAULT '',
  `TOINV` varchar(100) DEFAULT '',
  `ORDER_CL` char(1) NOT NULL DEFAULT '',
  `EXPORTED` varchar(24) NOT NULL DEFAULT '',
  `EXPORTED1` date NOT NULL DEFAULT '0000-00-00',
  `EXPORTED2` varchar(24) NOT NULL DEFAULT '',
  `EXPORTED3` date NOT NULL DEFAULT '0000-00-00',
  `LAST_YEAR` char(1) NOT NULL DEFAULT '',
  `POSTED` char(1) NOT NULL DEFAULT '',
  `PRINTED` char(1) NOT NULL DEFAULT '',
  `LOKSTATUS` char(1) NOT NULL DEFAULT '',
  `VOID` char(1) NOT NULL DEFAULT '',
  `NAME` varchar(40) NOT NULL DEFAULT '',
  `PHONEA` varchar(35) NOT NULL DEFAULT '',
  `PONO2` varchar(35) NOT NULL DEFAULT '',
  `DONO2` varchar(35) NOT NULL DEFAULT '',
  `CSGTRANS` varchar(3) NOT NULL DEFAULT '',
  `TAXINCL` char(1) NOT NULL DEFAULT '',
  `TABLENO` varchar(4) NOT NULL DEFAULT '',
  `CASHIER` varchar(8) NOT NULL DEFAULT '',
  `MEMBER` varchar(20) NOT NULL DEFAULT '',
  `COUNTER` varchar(8) NOT NULL DEFAULT '',
  `TOURGROUP` varchar(3) NOT NULL DEFAULT '',
  `TRDATETIME` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `TIME` varchar(8) NOT NULL DEFAULT '',
  `XTRCOST` double(15,5) NOT NULL DEFAULT '0.00000',
  `XTRCOST2` double(15,5) NOT NULL DEFAULT '0.00000',
  `POINT` double(12,5) NOT NULL DEFAULT '0.00000',
  `USERID` varchar(50) NOT NULL DEFAULT '',
  `BPERIOD` varchar(2) NOT NULL DEFAULT '',
  `VPERIOD` varchar(2) NOT NULL DEFAULT '',
  `BDATE` date NOT NULL DEFAULT '0000-00-00',
  `CURRCODE` varchar(15) NOT NULL DEFAULT '',
  `COMM0` varchar(35) NOT NULL DEFAULT '',
  `REM13` varchar(35) NOT NULL DEFAULT '',
  `REM14` varchar(35) NOT NULL DEFAULT '',
  `MC3_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `MC4_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `MC5_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `MC6_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `MC7_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `M_CHARGE3` double(15,5) NOT NULL DEFAULT '0.00000',
  `M_CHARGE4` double(15,5) NOT NULL DEFAULT '0.00000',
  `M_CHARGE5` double(15,5) NOT NULL DEFAULT '0.00000',
  `M_CHARGE6` double(15,5) NOT NULL DEFAULT '0.00000',
  `M_CHARGE7` double(15,5) NOT NULL DEFAULT '0.00000',
  `SPECIAL_ACCOUNT_CODE` varchar(8) NOT NULL DEFAULT '',
  `CREATED_BY` varchar(50) NOT NULL DEFAULT '',
  `UPDATED_BY` varchar(50) NOT NULL DEFAULT '',
  `CREATED_ON` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `UPDATED_ON` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `consignment` varchar(45) DEFAULT '',
  `PACKED` varchar(45) DEFAULT 'N',
  `PACKED_ON` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `PACKED_BY` varchar(100) DEFAULT NULL,
  `eInvoice_Submited` varchar(45) DEFAULT NULL,
  `SUBMITED_ON` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `PONODATE` date DEFAULT NULL,
  `IRAS_POSTED` char(1) NOT NULL DEFAULT '',
  `voucher` varchar(45) DEFAULT NULL,
  `REM30` varchar(100) DEFAULT NULL,
  `REM31` varchar(100) DEFAULT NULL,
  `REM32` varchar(100) DEFAULT NULL,
  `REM33` varchar(100) DEFAULT NULL,
  `REM34` varchar(100) DEFAULT NULL,
  `REM35` varchar(100) DEFAULT NULL,
  `REM36` varchar(100) DEFAULT NULL,
  `REM37` varchar(100) DEFAULT NULL,
  `REM38` varchar(100) DEFAULT NULL,
  `REM39` varchar(100) DEFAULT NULL,
  `REM40` varchar(100) DEFAULT NULL,
  `REM41` varchar(100) DEFAULT NULL,
  `REM42` varchar(100) DEFAULT NULL,
  `REM43` varchar(100) DEFAULT NULL,
  `REM44` varchar(100) DEFAULT NULL,
  `REM45` varchar(100) DEFAULT NULL,
  `REM46` varchar(100) DEFAULT NULL,
  `REM47` varchar(100) DEFAULT NULL,
  `REM48` varchar(100) DEFAULT NULL,
  `REM49` varchar(100) DEFAULT NULL,
  `multiagent1` varchar(45) DEFAULT '',
  `multiagent2` varchar(45) DEFAULT '',
  `multiagent3` varchar(45) DEFAULT '',
  `multiagent4` varchar(45) DEFAULT '',
  `multiagent5` varchar(45) DEFAULT '',
  `multiagent6` varchar(45) DEFAULT '',
  `multiagent7` varchar(45) DEFAULT '',
  `multiagent8` varchar(45) DEFAULT '',
  `e_mail` varchar(80) NOT NULL DEFAULT '',
  `unlocked` varchar(45) NOT NULL DEFAULT '',
  `printstatus` varchar(45) DEFAULT '',
  `creditcardtype1` varchar(45) DEFAULT '',
  `creditcardtype2` varchar(45) DEFAULT '',
  `SONO` varchar(1000) DEFAULT '',
  `username` varchar(100) DEFAULT '',
  `termscondition` text,
  `cs_pm_cashCD` double(15,5) NOT NULL DEFAULT '0.00000',
  `eInvoice_generated` varchar(45) DEFAULT '',
  `d_phone2` varchar(100) DEFAULT '',
  `roundadj` double(15,5) NOT NULL DEFAULT '0.00000',
  `footercurrcode` varchar(45) DEFAULT '',
  `footercurrrate` double(16,10) NOT NULL DEFAULT '0.0000000000',
  `rem15` varchar(80) DEFAULT '',
  `rem16` varchar(80) DEFAULT '',
  `rem17` varchar(80) DEFAULT '',
  `rem18` varchar(80) DEFAULT '',
  `rem19` varchar(80) DEFAULT '',
  `rem20` varchar(80) DEFAULT '',
  `rem21` varchar(80) DEFAULT '',
  `rem22` varchar(80) DEFAULT '',
  `rem23` varchar(80) DEFAULT '',
  `rem24` varchar(80) DEFAULT '',
  `rem25` varchar(80) DEFAULT '',
  PRIMARY KEY (`TYPE`,`REFNO`,`CUSTNO`,`WOS_DATE`),
  KEY `TRANSACTION` (`TYPE`,`REFNO`,`CUSTNO`,`FPERIOD`,`WOS_DATE`,`AGENNO`,`NET`,`TOINV`,`VOID`) USING BTREE,
  KEY `CUSTREPORT` (`CUSTNO`,`TYPE`,`REFNO`,`FPERIOD`,`WOS_DATE`,`AGENNO`,`AREA`,`SOURCE`,`NET`,`TOINV`,`ORDER_CL`,`VOID`) USING BTREE,
  KEY `AGENTREPORT` (`AGENNO`,`TYPE`,`REFNO`,`CUSTNO`,`FPERIOD`,`WOS_DATE`,`AREA`,`SOURCE`,`NET`,`TOINV`,`VOID`,`NAME`) USING BTREE,
  KEY `ENDUSERREPORT` (`VAN`,`TYPE`,`REFNO`,`CUSTNO`,`FPERIOD`,`WOS_DATE`,`AGENNO`,`AREA`,`SOURCE`,`NET`,`TOINV`,`VOID`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artran`
--

LOCK TABLES `artran` WRITE;
/*!40000 ALTER TABLE `artran` DISABLE KEYS */;
INSERT INTO `artran` VALUES ('INV','INV00001','','',0,0,'3000/A01','01','2012-01-11','0000-00-00','SALES','','','','','',1.0000000000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00,0.00,0.00,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,'','',0.00000,0.00000,'0000-00-00',0.00000,'','','SR','','','','','0000-00-00','0000-00-00','',0.00000,'','','','','','','','','','','','0%','OPC','','','','','','','','','','','','','','','','','','','','','','','','','','0000-00-00','','0000-00-00','','','','','','','','','','','F','','','','','','2012-01-11 06:33:22','',0.00000,0.00000,0.00000,'ultralung','','','0000-00-00','SGD','','','',0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,'','ultralung','ultraseeyoon','2012-01-11 06:33:22','2012-01-11 06:49:26','','N','0000-00-00 00:00:00',NULL,NULL,'0000-00-00 00:00:00',NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','','','','','','','','','','','','','','','',0.00000,'','',0.00000,'',0.0000000000,'','','','','','','','','','',''),('DN','DN00001','','',0,0,'3000/A02','01','2012-01-16','0000-00-00','DEBIT NOTE','','','','','',1.0000000000,600.00000,0.00000,0.00000,0.00000,0.00000,600.00000,42.00000,0.00000,0.00000,42.00000,642.00000,0.00000,0.00000,600.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,600.00000,0.00000,0.00000,0.00000,42.00000,0.00,0.00,0.00,642.00000,642.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,642.00000,0.00000,'','',0.00000,0.00000,'0000-00-00',0.00000,'','','SR','','','','','0000-00-00','0000-00-00','',0.00000,'','','','','','','Profile','','','','','','','','','','4000/GI1','','','','','','','','','','Mr Lim','','','','','','','','','','','','0000-00-00','','0000-00-00','','','','','','Mr Lim','','','','','F','','','','','','2012-01-16 10:02:49','',0.00000,0.00000,0.00000,'Demoinsurance','','','0000-00-00','SGD','','','',0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,'','Demoinsurance','Demoinsurance','2012-01-16 10:02:49','2012-01-18 03:20:51','','N','0000-00-00 00:00:00',NULL,NULL,'0000-00-00 00:00:00',NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','','','','','','','','','','','','','','','',0.00000,'','',0.00000,'',0.0000000000,'','','','','','','','','','',''),('QUO','QUO00001','','',0,0,'3000/A02','01','2012-01-19','0000-00-00','','','','','','',1.0000000000,1000.00000,0.00000,0.00000,0.00000,0.00000,1000.00000,70.00000,0.00000,0.00000,70.00000,1070.00000,0.00000,0.00000,1000.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,1000.00000,0.00000,0.00000,0.00000,70.00000,0.00,0.00,0.00,1070.00000,1070.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,1070.00000,0.00000,'','',0.00000,0.00000,'0000-00-00',0.00000,'','','SR','','','','','0000-00-00','0000-00-00','',0.00000,'','','','PO/SO..','DO..','','','','','','hr5..','HR6..','HR7..','HR8..','HR9..','HR10..','4000/GI1','','permits #','Mr Lim','','Abc Road','','','','','Mr Lim','','','','','','','','','','','','0000-00-00','','0000-00-00','','','','','','Mr Lim','','','','','F','','','','','','2012-01-19 06:53:58','',0.00000,0.00000,0.00000,'Demoinsurance','','','0000-00-00','SGD','','','',0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,'','Demoinsurance','Demoinsurance','2012-01-19 06:53:58','2012-01-19 07:16:51','','N','0000-00-00 00:00:00',NULL,NULL,'0000-00-00 00:00:00',NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','','','','','','','','','','','','','SO..','','',0.00000,'','',0.00000,'',0.0000000000,'','','','','','','','','','','');
/*!40000 ALTER TABLE `artran` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artran_remark`
--

DROP TABLE IF EXISTS `artran_remark`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `artran_remark` (
  `TYPE` varchar(45) NOT NULL DEFAULT '',
  `REFNO` varchar(45) NOT NULL DEFAULT '',
  `REMARK1` blob,
  `REMARK2` blob,
  `REMARK3` blob,
  `REMARK4` blob,
  `REMARK5` blob,
  `REMARK6` blob,
  `REMARK7` blob,
  `REMARK8` blob,
  `REMARK9` blob,
  `REMARK10` blob,
  `USERID` varchar(50) NOT NULL DEFAULT '',
  `LASTUSERID` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`TYPE`,`REFNO`) USING BTREE,
  KEY `REMARKS_INFO` (`TYPE`,`REFNO`,`USERID`,`LASTUSERID`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Store Remarks Info';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artran_remark`
--

LOCK TABLES `artran_remark` WRITE;
/*!40000 ALTER TABLE `artran_remark` DISABLE KEYS */;
/*!40000 ALTER TABLE `artran_remark` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artranat`
--

DROP TABLE IF EXISTS `artranat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `artranat` (
  `TYPE` varchar(4) NOT NULL DEFAULT '',
  `REFNO` varchar(50) NOT NULL DEFAULT '',
  `CUSTNO` varchar(12) NOT NULL DEFAULT '',
  `FPERIOD` varchar(2) NOT NULL DEFAULT '',
  `WOS_DATE` date NOT NULL DEFAULT '0000-00-00',
  `DESP` varchar(40) NOT NULL DEFAULT '',
  `DESPA` varchar(40) NOT NULL DEFAULT '',
  `DEBITAMT` double(15,5) NOT NULL DEFAULT '0.00000',
  `CREDITAMT` double(15,5) NOT NULL DEFAULT '0.00000',
  `TRDATETIME` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `USERID` varchar(50) NOT NULL DEFAULT '',
  `REMARK` varchar(35) NOT NULL DEFAULT '',
  `CREATED_BY` varchar(50) NOT NULL DEFAULT '',
  `UPDATED_BY` varchar(50) NOT NULL DEFAULT '',
  `CREATED_ON` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `UPDATED_ON` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `OPERIOD` varchar(2) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artranat`
--

LOCK TABLES `artranat` WRITE;
/*!40000 ALTER TABLE `artranat` DISABLE KEYS */;
INSERT INTO `artranat` VALUES ('INV','INV00001','3000/A01','01','2012-01-11','SALES','',0.00000,0.00000,'2012-01-11 06:33:22','ultralung','','ultralung','ultraseeyoon','2012-01-11 06:33:22','2012-01-11 06:49:26',NULL),('DN','DN00001','3000/A02','01','2012-01-16','DEBIT NOTE','',642.00000,0.00000,'2012-01-16 10:02:49','Demoinsurance','','Demoinsurance','Demoinsurance','2012-01-16 10:02:49','2012-01-16 10:04:27',NULL),('DN','DN00001','3000/A02','01','2012-01-16','DEBIT NOTE','',642.00000,0.00000,'2012-01-16 10:02:49','Demoinsurance','','Demoinsurance','Demoinsurance','2012-01-16 10:02:49','2012-01-16 10:08:10',NULL),('QUO','QUO00001','3000/A02','01','2012-01-19','','',1070.00000,0.00000,'2012-01-19 06:53:58','Demoinsurance','','Demoinsurance','Demoinsurance','2012-01-19 06:53:58','2012-01-19 06:54:20',NULL),('QUO','QUO00001','3000/A02','01','2012-01-19','','',1070.00000,0.00000,'2012-01-19 06:53:58','Demoinsurance','','Demoinsurance','Demoinsurance','2012-01-19 06:53:58','2012-01-19 07:12:13',NULL),('QUO','QUO00001','3000/A02','01','2012-01-19','','',1391.00000,0.00000,'2012-01-19 06:53:58','Demoinsurance','','Demoinsurance','Demoinsurance','2012-01-19 06:53:58','2012-01-19 07:12:42',NULL),('QUO','QUO00001','3000/A02','01','2012-01-19','','',1391.00000,0.00000,'2012-01-19 06:53:58','Demoinsurance','','Demoinsurance','Demoinsurance','2012-01-19 06:53:58','2012-01-19 07:12:42',NULL),('QUO','QUO00001','3000/A02','01','2012-01-19','','',1070.00000,0.00000,'2012-01-19 06:53:58','Demoinsurance','','Demoinsurance','Demoinsurance','2012-01-19 06:53:58','2012-01-19 07:16:51',NULL);
/*!40000 ALTER TABLE `artranat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assmtran`
--

DROP TABLE IF EXISTS `assmtran`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assmtran` (
  `refno` varchar(150) NOT NULL DEFAULT '',
  `wos_date` date NOT NULL DEFAULT '0000-00-00',
  `created_by` varchar(150) NOT NULL DEFAULT '',
  `created_on` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`refno`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assmtran`
--

LOCK TABLES `assmtran` WRITE;
/*!40000 ALTER TABLE `assmtran` DISABLE KEYS */;
/*!40000 ALTER TABLE `assmtran` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attention`
--

DROP TABLE IF EXISTS `attention`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attention` (
  `attentionno` varchar(8) NOT NULL DEFAULT '',
  `Name` varchar(40) NOT NULL DEFAULT '',
  `Customerno` varchar(8) NOT NULL DEFAULT '',
  `Add1` varchar(40) NOT NULL DEFAULT '',
  `Add2` varchar(40) NOT NULL DEFAULT '',
  `Add3` varchar(40) NOT NULL DEFAULT '',
  `phone` varchar(50) NOT NULL DEFAULT '',
  `phonea` varchar(50) NOT NULL DEFAULT '',
  `Fax` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`attentionno`) USING BTREE,
  KEY `DRIVERINFO` (`attentionno`,`Name`,`Customerno`,`Add1`,`Add2`,`Add3`,`phone`,`phonea`,`Fax`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attention`
--

LOCK TABLES `attention` WRITE;
/*!40000 ALTER TABLE `attention` DISABLE KEYS */;
/*!40000 ALTER TABLE `attention` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `billmat`
--

DROP TABLE IF EXISTS `billmat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `billmat` (
  `ITEMNO` varchar(60) NOT NULL DEFAULT '',
  `BOMNO` varchar(2) NOT NULL DEFAULT '',
  `BMITEMNO` varchar(60) NOT NULL DEFAULT '',
  `BMQTY` varchar(17) NOT NULL DEFAULT '',
  `BMLOCATION` varchar(24) NOT NULL DEFAULT '',
  `ASSM_GROUP` varchar(40) NOT NULL DEFAULT '',
  PRIMARY KEY (`ITEMNO`,`BOMNO`,`BMITEMNO`) USING BTREE,
  KEY `BOMITEM` (`ITEMNO`,`BOMNO`,`BMITEMNO`,`BMQTY`,`BMLOCATION`,`ASSM_GROUP`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `billmat`
--

LOCK TABLES `billmat` WRITE;
/*!40000 ALTER TABLE `billmat` DISABLE KEYS */;
/*!40000 ALTER TABLE `billmat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `brand`
--

DROP TABLE IF EXISTS `brand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `brand` (
  `brand` varchar(40) NOT NULL DEFAULT '',
  `desp` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`brand`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brand`
--

LOCK TABLES `brand` WRITE;
/*!40000 ALTER TABLE `brand` DISABLE KEYS */;
/*!40000 ALTER TABLE `brand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `business`
--

DROP TABLE IF EXISTS `business`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `business` (
  `BUSINESS` varchar(15) NOT NULL DEFAULT '',
  `DESP` varchar(40) NOT NULL DEFAULT '',
  `PRICELVL` varchar(45) DEFAULT '1',
  PRIMARY KEY (`BUSINESS`),
  KEY `BUSINESSINFO` (`BUSINESS`,`DESP`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `business`
--

LOCK TABLES `business` WRITE;
/*!40000 ALTER TABLE `business` DISABLE KEYS */;
/*!40000 ALTER TABLE `business` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `collect_address`
--

DROP TABLE IF EXISTS `collect_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `collect_address` (
  `CODE` varchar(8) NOT NULL DEFAULT '',
  `NAME` varchar(40) DEFAULT NULL,
  `CUSTNO` varchar(8) DEFAULT NULL,
  `ADD1` varchar(35) DEFAULT NULL,
  `ADD2` varchar(35) DEFAULT NULL,
  `ADD3` varchar(35) DEFAULT NULL,
  `ADD4` varchar(35) DEFAULT NULL,
  `COUNTRY` varchar(25) DEFAULT NULL,
  `POSTALCODE` varchar(25) DEFAULT NULL,
  `ATTN` varchar(35) DEFAULT NULL,
  `PHONE` varchar(25) DEFAULT NULL,
  `FAX` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`CODE`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `collect_address`
--

LOCK TABLES `collect_address` WRITE;
/*!40000 ALTER TABLE `collect_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `collect_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commen1`
--

DROP TABLE IF EXISTS `commen1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commen1` (
  `TYPE` varchar(4) NOT NULL DEFAULT '',
  `REFNO` varchar(24) NOT NULL DEFAULT '',
  `TRANCODE` int(4) unsigned NOT NULL DEFAULT '0',
  `COMMENT` blob,
  PRIMARY KEY (`TYPE`,`REFNO`,`TRANCODE`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commen1`
--

LOCK TABLES `commen1` WRITE;
/*!40000 ALTER TABLE `commen1` DISABLE KEYS */;
/*!40000 ALTER TABLE `commen1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commen2`
--

DROP TABLE IF EXISTS `commen2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commen2` (
  `TYPE` varchar(4) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `REFNO` varchar(24) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `TRANCODE` int(4) unsigned NOT NULL DEFAULT '0',
  `COMMENT` blob
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commen2`
--

LOCK TABLES `commen2` WRITE;
/*!40000 ALTER TABLE `commen2` DISABLE KEYS */;
/*!40000 ALTER TABLE `commen2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commentemp`
--

DROP TABLE IF EXISTS `commentemp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commentemp` (
  `TYPE` varchar(4) NOT NULL DEFAULT '',
  `REFNO` varchar(24) NOT NULL DEFAULT '',
  `ITEMNO` varchar(60) NOT NULL DEFAULT '',
  `COMMENT` blob,
  `USERID` varchar(50) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commentemp`
--

LOCK TABLES `commentemp` WRITE;
/*!40000 ALTER TABLE `commentemp` DISABLE KEYS */;
/*!40000 ALTER TABLE `commentemp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comments` (
  `CODE` varchar(20) NOT NULL DEFAULT '',
  `DESP` varchar(20) NOT NULL DEFAULT '',
  `DETAILS` blob,
  PRIMARY KEY (`CODE`) USING BTREE,
  KEY `COMMENTINFO` (`CODE`,`DESP`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commission`
--

DROP TABLE IF EXISTS `commission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commission` (
  `commid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `commname` varchar(450) DEFAULT '',
  `commdesp` text,
  `wos_group` varchar(450) DEFAULT NULL,
  `cate` varchar(450) DEFAULT '',
  `brand` varchar(450) DEFAULT '',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(45) DEFAULT '',
  `updated_on` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by` varchar(45) DEFAULT '',
  PRIMARY KEY (`commid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commission`
--

LOCK TABLES `commission` WRITE;
/*!40000 ALTER TABLE `commission` DISABLE KEYS */;
/*!40000 ALTER TABLE `commission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commrate`
--

DROP TABLE IF EXISTS `commrate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commrate` (
  `commrateid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `commname` varchar(450) DEFAULT '',
  `rangefrom` varchar(45) DEFAULT '',
  `rangeto` varchar(45) DEFAULT '',
  `rate` varchar(45) DEFAULT '',
  `type` varchar(45) DEFAULT '',
  `typeid` varchar(450) DEFAULT '',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(45) DEFAULT '',
  `updated_on` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by` varchar(45) DEFAULT '',
  PRIMARY KEY (`commrateid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commrate`
--

LOCK TABLES `commrate` WRITE;
/*!40000 ALTER TABLE `commrate` DISABLE KEYS */;
/*!40000 ALTER TABLE `commrate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `counter`
--

DROP TABLE IF EXISTS `counter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `counter` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `counterid` varchar(450) DEFAULT '',
  `counterdesp` varchar(450) DEFAULT '',
  `bonduser` varchar(450) DEFAULT '',
  `created_by` varchar(450) DEFAULT '',
  `created_on` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by` varchar(450) DEFAULT '',
  `updated_on` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `counter`
--

LOCK TABLES `counter` WRITE;
/*!40000 ALTER TABLE `counter` DISABLE KEYS */;
/*!40000 ALTER TABLE `counter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currartran`
--

DROP TABLE IF EXISTS `currartran`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `currartran` (
  `TYPE` varchar(4) NOT NULL DEFAULT '',
  `REFNO` varchar(50) NOT NULL DEFAULT '',
  `REFNO2` varchar(24) NOT NULL DEFAULT '',
  `TRANCODE` int(4) NOT NULL DEFAULT '0',
  `CUSTNO` varchar(12) NOT NULL DEFAULT '',
  `FPERIOD` varchar(2) NOT NULL DEFAULT '',
  `WOS_DATE` date NOT NULL DEFAULT '0000-00-00',
  `DESP` varchar(40) NOT NULL DEFAULT '',
  `DESPA` varchar(40) NOT NULL DEFAULT '',
  `AGENNO` varchar(20) NOT NULL DEFAULT '',
  `AREA` varchar(12) NOT NULL DEFAULT '',
  `SOURCE` varchar(4) NOT NULL DEFAULT '',
  `JOB` varchar(4) NOT NULL DEFAULT '',
  `CURRRATE` double(16,10) NOT NULL DEFAULT '0.0000000000',
  `GROSS_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `DISC1_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `DISC2_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `DISC3_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `DISC_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `NET_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `TAX1_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `TAX2_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `TAX3_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `TAX_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `GRAND_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `DEBIT_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `CREDIT_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `INVGROSS` double(15,5) NOT NULL DEFAULT '0.00000',
  `DISP1` double(10,5) NOT NULL DEFAULT '0.00000',
  `DISP2` double(10,5) NOT NULL DEFAULT '0.00000',
  `DISP3` double(10,5) NOT NULL DEFAULT '0.00000',
  `DISCOUNT1` double(15,5) NOT NULL DEFAULT '0.00000',
  `DISCOUNT2` double(15,5) NOT NULL DEFAULT '0.00000',
  `DISCOUNT3` double(15,5) NOT NULL DEFAULT '0.00000',
  `DISCOUNT` double(15,5) NOT NULL DEFAULT '0.00000',
  `NET` double(15,5) NOT NULL DEFAULT '0.00000',
  `TAX1` double(15,5) NOT NULL DEFAULT '0.00000',
  `TAX2` double(15,5) NOT NULL DEFAULT '0.00000',
  `TAX3` double(15,5) NOT NULL DEFAULT '0.00000',
  `TAX` double(15,5) NOT NULL DEFAULT '0.00000',
  `TAXP1` double(5,2) NOT NULL DEFAULT '0.00',
  `TAXP2` double(5,2) NOT NULL DEFAULT '0.00',
  `TAXP3` double(5,2) NOT NULL DEFAULT '0.00',
  `GRAND` double(15,5) NOT NULL DEFAULT '0.00000',
  `DEBITAMT` double(15,5) NOT NULL DEFAULT '0.00000',
  `CREDITAMT` double(15,5) NOT NULL DEFAULT '0.00000',
  `MC1_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `MC2_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `M_CHARGE1` double(15,5) NOT NULL DEFAULT '0.00000',
  `M_CHARGE2` double(15,5) NOT NULL DEFAULT '0.00000',
  `CS_PM_CASH` double(15,5) NOT NULL DEFAULT '0.00000',
  `CS_PM_CHEQ` double(15,5) NOT NULL DEFAULT '0.00000',
  `CS_PM_CRCD` double(15,5) NOT NULL DEFAULT '0.00000',
  `CS_PM_CRC2` double(15,5) NOT NULL DEFAULT '0.00000',
  `CS_PM_TT` double(15,5) NOT NULL DEFAULT '0.00000',
  `CS_PM_DBCD` double(15,5) NOT NULL DEFAULT '0.00000',
  `CS_PM_VOUC` double(15,5) NOT NULL DEFAULT '0.00000',
  `DEPOSIT` double(15,5) NOT NULL DEFAULT '0.00000',
  `CS_PM_DEBT` double(15,5) NOT NULL DEFAULT '0.00000',
  `CS_PM_WHT` double(15,5) NOT NULL DEFAULT '0.00000',
  `CHECKNO` varchar(12) NOT NULL DEFAULT '',
  `IMPSTAGE` varchar(12) NOT NULL DEFAULT '',
  `BILLCOST` double(15,5) NOT NULL DEFAULT '0.00000',
  `BILLSALE` double(15,5) NOT NULL DEFAULT '0.00000',
  `PAIDDATE` date NOT NULL DEFAULT '0000-00-00',
  `PAIDAMT` double(17,5) NOT NULL DEFAULT '0.00000',
  `REFNO3` varchar(24) NOT NULL DEFAULT '',
  `AGE` varchar(2) NOT NULL DEFAULT '',
  `NOTE` varchar(8) NOT NULL DEFAULT '',
  `TERM` varchar(12) NOT NULL DEFAULT '',
  `ISCASH` varchar(2) NOT NULL DEFAULT '',
  `VAN` varchar(8) NOT NULL DEFAULT '',
  `DEL_BY` varchar(12) NOT NULL DEFAULT '',
  `PLA_DODATE` date NOT NULL DEFAULT '0000-00-00',
  `ACT_DODATE` date NOT NULL DEFAULT '0000-00-00',
  `URGENCY` char(1) NOT NULL DEFAULT '',
  `CURRRATE2` double(16,5) NOT NULL DEFAULT '0.00000',
  `STAXACC` varchar(8) NOT NULL DEFAULT '',
  `SUPP1` varchar(8) NOT NULL DEFAULT '',
  `SUPP2` varchar(8) NOT NULL DEFAULT '',
  `PONO` varchar(350) DEFAULT '',
  `DONO` varchar(350) DEFAULT '',
  `REM0` varchar(35) NOT NULL DEFAULT '',
  `REM1` varchar(35) NOT NULL DEFAULT '',
  `REM2` varchar(35) NOT NULL DEFAULT '',
  `REM3` varchar(35) NOT NULL DEFAULT '',
  `REM4` varchar(35) NOT NULL DEFAULT '',
  `REM5` varchar(35) NOT NULL DEFAULT '',
  `REM6` varchar(35) NOT NULL DEFAULT '',
  `REM7` varchar(35) NOT NULL DEFAULT '',
  `REM8` varchar(35) NOT NULL DEFAULT '',
  `REM9` varchar(35) NOT NULL DEFAULT '',
  `REM10` varchar(35) NOT NULL DEFAULT '',
  `REM11` varchar(35) NOT NULL DEFAULT '',
  `REM12` varchar(35) NOT NULL DEFAULT '',
  `FREM0` varchar(80) NOT NULL DEFAULT '',
  `FREM1` varchar(80) NOT NULL DEFAULT '',
  `FREM2` varchar(80) NOT NULL DEFAULT '',
  `FREM3` varchar(80) NOT NULL DEFAULT '',
  `FREM4` varchar(80) NOT NULL DEFAULT '',
  `FREM5` varchar(80) NOT NULL DEFAULT '',
  `FREM6` varchar(80) NOT NULL DEFAULT '',
  `FREM7` varchar(80) NOT NULL DEFAULT '',
  `FREM8` varchar(80) NOT NULL DEFAULT '',
  `FREM9` varchar(80) NOT NULL DEFAULT '',
  `COMM1` varchar(35) NOT NULL DEFAULT '',
  `COMM2` varchar(35) NOT NULL DEFAULT '',
  `COMM3` varchar(35) NOT NULL DEFAULT '',
  `COMM4` varchar(35) NOT NULL DEFAULT '',
  `ID` char(1) NOT NULL DEFAULT '',
  `GENERATED` char(1) NOT NULL DEFAULT '',
  `TOINV` varchar(24) NOT NULL DEFAULT '',
  `ORDER_CL` char(1) NOT NULL DEFAULT '',
  `EXPORTED` varchar(24) NOT NULL DEFAULT '',
  `EXPORTED1` date NOT NULL DEFAULT '0000-00-00',
  `EXPORTED2` varchar(24) NOT NULL DEFAULT '',
  `EXPORTED3` date NOT NULL DEFAULT '0000-00-00',
  `LAST_YEAR` char(1) NOT NULL DEFAULT '',
  `POSTED` char(1) NOT NULL DEFAULT '',
  `PRINTED` char(1) NOT NULL DEFAULT '',
  `LOKSTATUS` char(1) NOT NULL DEFAULT '',
  `VOID` char(1) NOT NULL DEFAULT '',
  `NAME` varchar(40) NOT NULL DEFAULT '',
  `PHONEA` varchar(35) NOT NULL DEFAULT '',
  `PONO2` varchar(35) NOT NULL DEFAULT '',
  `DONO2` varchar(35) NOT NULL DEFAULT '',
  `CSGTRANS` varchar(3) NOT NULL DEFAULT '',
  `TAXINCL` char(1) NOT NULL DEFAULT '',
  `TABLENO` varchar(4) NOT NULL DEFAULT '',
  `CASHIER` varchar(8) NOT NULL DEFAULT '',
  `MEMBER` varchar(20) NOT NULL DEFAULT '',
  `COUNTER` varchar(8) NOT NULL DEFAULT '',
  `TOURGROUP` varchar(3) NOT NULL DEFAULT '',
  `TRDATETIME` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `TIME` varchar(8) NOT NULL DEFAULT '',
  `XTRCOST` double(15,5) NOT NULL DEFAULT '0.00000',
  `XTRCOST2` double(15,5) NOT NULL DEFAULT '0.00000',
  `POINT` double(12,5) NOT NULL DEFAULT '0.00000',
  `USERID` varchar(50) NOT NULL DEFAULT '',
  `BPERIOD` varchar(2) NOT NULL DEFAULT '',
  `VPERIOD` varchar(2) NOT NULL DEFAULT '',
  `BDATE` date NOT NULL DEFAULT '0000-00-00',
  `CURRCODE` varchar(15) NOT NULL DEFAULT '',
  `COMM0` varchar(35) NOT NULL DEFAULT '',
  `REM13` varchar(35) NOT NULL DEFAULT '',
  `REM14` varchar(35) NOT NULL DEFAULT '',
  `MC3_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `MC4_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `MC5_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `MC6_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `MC7_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `M_CHARGE3` double(15,5) NOT NULL DEFAULT '0.00000',
  `M_CHARGE4` double(15,5) NOT NULL DEFAULT '0.00000',
  `M_CHARGE5` double(15,5) NOT NULL DEFAULT '0.00000',
  `M_CHARGE6` double(15,5) NOT NULL DEFAULT '0.00000',
  `M_CHARGE7` double(15,5) NOT NULL DEFAULT '0.00000',
  `SPECIAL_ACCOUNT_CODE` varchar(8) NOT NULL DEFAULT '',
  `CREATED_BY` varchar(50) NOT NULL DEFAULT '',
  `UPDATED_BY` varchar(50) NOT NULL DEFAULT '',
  `CREATED_ON` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `UPDATED_ON` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `PACKED` varchar(45) DEFAULT 'N',
  `PACKED_ON` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `PACKED_BY` varchar(100) DEFAULT NULL,
  `eInvoice_Submited` varchar(45) DEFAULT NULL,
  `SUBMITED_ON` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `PONODATE` date DEFAULT NULL,
  `IRAS_POSTED` char(1) NOT NULL DEFAULT '',
  `voucher` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`TYPE`,`REFNO`,`CUSTNO`,`WOS_DATE`),
  KEY `TRANSACTION` (`TYPE`,`REFNO`,`CUSTNO`,`FPERIOD`,`WOS_DATE`,`AGENNO`,`NET`,`TOINV`,`VOID`) USING BTREE,
  KEY `CUSTREPORT` (`CUSTNO`,`TYPE`,`REFNO`,`FPERIOD`,`WOS_DATE`,`AGENNO`,`AREA`,`SOURCE`,`NET`,`TOINV`,`ORDER_CL`,`VOID`) USING BTREE,
  KEY `AGENTREPORT` (`AGENNO`,`TYPE`,`REFNO`,`CUSTNO`,`FPERIOD`,`WOS_DATE`,`AREA`,`SOURCE`,`NET`,`TOINV`,`VOID`,`NAME`) USING BTREE,
  KEY `ENDUSERREPORT` (`VAN`,`TYPE`,`REFNO`,`CUSTNO`,`FPERIOD`,`WOS_DATE`,`AGENNO`,`AREA`,`SOURCE`,`NET`,`TOINV`,`VOID`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currartran`
--

LOCK TABLES `currartran` WRITE;
/*!40000 ALTER TABLE `currartran` DISABLE KEYS */;
/*!40000 ALTER TABLE `currartran` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currency`
--

DROP TABLE IF EXISTS `currency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `currency` (
  `CURRCODE` char(10) NOT NULL DEFAULT '',
  `CURRENCY` char(10) NOT NULL DEFAULT '',
  `CURRENCY0` char(10) NOT NULL DEFAULT '',
  `Currency1` char(27) NOT NULL DEFAULT '',
  `Currency2` char(27) NOT NULL DEFAULT '',
  `CURRRATE` double(16,10) NOT NULL DEFAULT '1.0000000000',
  `CURRP1` double(16,10) NOT NULL DEFAULT '1.0000000000',
  `CURRP2` double(16,10) NOT NULL DEFAULT '1.0000000000',
  `CURRP3` double(16,10) NOT NULL DEFAULT '1.0000000000',
  `CURRP4` double(16,10) NOT NULL DEFAULT '1.0000000000',
  `CURRP5` double(16,10) NOT NULL DEFAULT '1.0000000000',
  `CURRP6` double(16,10) NOT NULL DEFAULT '1.0000000000',
  `CURRP7` double(16,10) NOT NULL DEFAULT '1.0000000000',
  `CURRP8` double(16,10) NOT NULL DEFAULT '1.0000000000',
  `CURRP9` double(16,10) NOT NULL DEFAULT '1.0000000000',
  `CURRP10` double(16,10) NOT NULL DEFAULT '1.0000000000',
  `CURRP11` double(16,10) NOT NULL DEFAULT '1.0000000000',
  `CURRP12` double(16,10) NOT NULL DEFAULT '1.0000000000',
  `CURRP13` double(16,10) NOT NULL DEFAULT '1.0000000000',
  `CURRP14` double(16,10) NOT NULL DEFAULT '1.0000000000',
  `CURRP15` double(16,10) NOT NULL DEFAULT '1.0000000000',
  `CURRP16` double(16,10) NOT NULL DEFAULT '1.0000000000',
  `CURRP17` double(16,10) NOT NULL DEFAULT '1.0000000000',
  `CURRP18` double(16,10) NOT NULL DEFAULT '1.0000000000',
  PRIMARY KEY (`CURRCODE`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currency`
--

LOCK TABLES `currency` WRITE;
/*!40000 ALTER TABLE `currency` DISABLE KEYS */;
INSERT INTO `currency` VALUES ('SGD','S$','','DOLLAR','CENTS',1.0000000000,1.0000000000,1.0000000000,1.0000000000,1.0000000000,1.0000000000,1.0000000000,1.0000000000,1.0000000000,1.0000000000,1.0000000000,1.0000000000,1.0000000000,1.0000000000,1.0000000000,1.0000000000,1.0000000000,1.0000000000,1.0000000000),('US','US$','','US DOLLARS','',1.5285000000,1.0000000000,1.0000000000,1.0000000000,1.0000000000,1.0000000000,1.0000000000,1.0000000000,1.0000000000,1.0000000000,1.0000000000,1.0000000000,1.0000000000,1.0000000000,1.0000000000,1.0000000000,1.0000000000,1.0000000000,1.0000000000);
/*!40000 ALTER TABLE `currency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currencyrate`
--

DROP TABLE IF EXISTS `currencyrate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `currencyrate` (
  `CURRCODE` char(10) NOT NULL DEFAULT '',
  `CURRENCY` char(40) NOT NULL DEFAULT '',
  `CURRENCY0` char(40) NOT NULL DEFAULT '',
  `CURRENCY1` char(40) NOT NULL DEFAULT '',
  `CURRENCY2` char(40) NOT NULL DEFAULT '',
  `CURRRATE` double(16,10) NOT NULL DEFAULT '1.0000000000',
  `CURRP01` double(16,10) NOT NULL DEFAULT '1.0000000000',
  `CURRP02` double(16,10) NOT NULL DEFAULT '1.0000000000',
  `CURRP03` double(16,10) NOT NULL DEFAULT '1.0000000000',
  `CURRP04` double(16,10) NOT NULL DEFAULT '1.0000000000',
  `CURRP05` double(16,10) NOT NULL DEFAULT '1.0000000000',
  `CURRP06` double(16,10) NOT NULL DEFAULT '1.0000000000',
  `CURRP07` double(16,10) NOT NULL DEFAULT '1.0000000000',
  `CURRP08` double(16,10) NOT NULL DEFAULT '1.0000000000',
  `CURRP09` double(16,10) NOT NULL DEFAULT '1.0000000000',
  `CURRP10` double(16,10) NOT NULL DEFAULT '1.0000000000',
  `CURRP11` double(16,10) NOT NULL DEFAULT '1.0000000000',
  `CURRP12` double(16,10) NOT NULL DEFAULT '1.0000000000',
  `CURRP13` double(16,10) NOT NULL DEFAULT '1.0000000000',
  `CURRP14` double(16,10) NOT NULL DEFAULT '1.0000000000',
  `CURRP15` double(16,10) NOT NULL DEFAULT '1.0000000000',
  `CURRP16` double(16,10) NOT NULL DEFAULT '1.0000000000',
  `CURRP17` double(16,10) NOT NULL DEFAULT '1.0000000000',
  `CURRP18` double(16,10) NOT NULL DEFAULT '1.0000000000'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currencyrate`
--

LOCK TABLES `currencyrate` WRITE;
/*!40000 ALTER TABLE `currencyrate` DISABLE KEYS */;
INSERT INTO `currencyrate` VALUES ('SGD','S$','','DOLLAR','CENTS',1.0000000000,1.0000000000,1.0000000000,1.0000000000,1.0000000000,1.0000000000,1.0000000000,1.0000000000,1.0000000000,1.0000000000,1.0000000000,1.0000000000,1.0000000000,1.0000000000,1.0000000000,1.0000000000,1.0000000000,1.0000000000,1.0000000000),('US','US$','','US DOLLARS','',1.5285000000,0.0000000000,0.0000000000,0.0000000000,0.0000000000,0.0000000000,0.0000000000,0.0000000000,0.0000000000,0.0000000000,0.0000000000,0.0000000000,0.0000000000,0.0000000000,0.0000000000,0.0000000000,0.0000000000,0.0000000000,0.0000000000);
/*!40000 ALTER TABLE `currencyrate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currictran`
--

DROP TABLE IF EXISTS `currictran`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `currictran` (
  `TYPE` varchar(4) NOT NULL DEFAULT '',
  `REFNO` varchar(50) NOT NULL DEFAULT '',
  `REFNO2` varchar(24) DEFAULT NULL,
  `TRANCODE` int(4) NOT NULL DEFAULT '0',
  `CUSTNO` varchar(12) NOT NULL DEFAULT '',
  `FPERIOD` varchar(2) DEFAULT '0',
  `WOS_DATE` date NOT NULL DEFAULT '0000-00-00',
  `CURRRATE` double(16,10) NOT NULL DEFAULT '0.0000000000',
  `ITEMCOUNT` int(4) NOT NULL DEFAULT '0',
  `LINECODE` varchar(2) DEFAULT NULL,
  `ITEMNO` varchar(28) NOT NULL DEFAULT '',
  `DESP` varchar(450) DEFAULT NULL,
  `DESPA` varchar(450) DEFAULT NULL,
  `AGENNO` varchar(20) NOT NULL DEFAULT '',
  `LOCATION` varchar(24) DEFAULT NULL,
  `SOURCE` varchar(4) DEFAULT NULL,
  `JOB` varchar(4) DEFAULT NULL,
  `SIGN` varchar(2) DEFAULT NULL,
  `QTY_BIL` double(17,5) NOT NULL DEFAULT '0.00000',
  `PRICE_BIL` double(17,5) NOT NULL DEFAULT '0.00000',
  `UNIT_BIL` varchar(15) DEFAULT '',
  `AMT1_BIL` double(17,5) NOT NULL DEFAULT '0.00000',
  `DISPEC1` varchar(10) DEFAULT NULL,
  `DISPEC2` varchar(10) DEFAULT NULL,
  `DISPEC3` varchar(10) DEFAULT NULL,
  `DISAMT_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `AMT_BIL` double(17,5) NOT NULL DEFAULT '0.00000',
  `TAXPEC1` varchar(5) DEFAULT NULL,
  `TAXPEC2` varchar(5) DEFAULT NULL,
  `TAXPEC3` varchar(5) DEFAULT NULL,
  `TAXAMT_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `NOTE_A` varchar(8) DEFAULT NULL,
  `IMPSTAGE` char(1) DEFAULT NULL,
  `QTY` double(17,5) NOT NULL DEFAULT '0.00000',
  `PRICE` double(17,5) NOT NULL DEFAULT '0.00000',
  `UNIT` varchar(15) DEFAULT '',
  `AMT1` double(17,5) NOT NULL DEFAULT '0.00000',
  `DISAMT` double(15,5) NOT NULL DEFAULT '0.00000',
  `AMT` double(17,5) NOT NULL DEFAULT '0.00000',
  `TAXAMT` double(15,5) NOT NULL DEFAULT '0.00000',
  `FACTOR1` varchar(9) DEFAULT NULL,
  `FACTOR2` varchar(9) DEFAULT NULL,
  `DONO` varchar(40) DEFAULT NULL,
  `DODATE` date NOT NULL DEFAULT '0000-00-00',
  `SODATE` date NOT NULL DEFAULT '0000-00-00',
  `BREM1` varchar(40) DEFAULT NULL,
  `BREM2` varchar(40) DEFAULT NULL,
  `BREM3` varchar(40) DEFAULT NULL,
  `BREM4` varchar(40) DEFAULT NULL,
  `PACKING` varchar(13) DEFAULT NULL,
  `NOTE1` varchar(10) DEFAULT NULL,
  `NOTE2` varchar(10) DEFAULT NULL,
  `GLTRADAC` varchar(8) DEFAULT NULL,
  `UPDCOST` char(1) DEFAULT NULL,
  `GST_ITEM` char(1) DEFAULT NULL,
  `TOTALUP` char(1) DEFAULT NULL,
  `WITHSN` char(1) DEFAULT NULL,
  `NODISPLAY` char(1) NOT NULL DEFAULT '',
  `GRADE` varchar(10) DEFAULT NULL,
  `PUR_PRICE` double(17,5) NOT NULL DEFAULT '0.00000',
  `QTY1` double(17,5) NOT NULL DEFAULT '0.00000',
  `QTY2` double(17,5) NOT NULL DEFAULT '0.00000',
  `QTY3` double(17,5) NOT NULL DEFAULT '0.00000',
  `QTY4` double(17,5) NOT NULL DEFAULT '0.00000',
  `QTY5` double(17,5) NOT NULL DEFAULT '0.00000',
  `QTY6` double(17,5) NOT NULL DEFAULT '0.00000',
  `QTY7` double(17,5) NOT NULL DEFAULT '0.00000',
  `QTY_RET` double(17,5) NOT NULL DEFAULT '0.00000',
  `TEMPFIGI` double(15,5) NOT NULL DEFAULT '0.00000',
  `SERCOST` double(13,5) NOT NULL DEFAULT '0.00000',
  `M_CHARGE1` double(15,5) NOT NULL DEFAULT '0.00000',
  `M_CHARGE2` double(15,5) NOT NULL DEFAULT '0.00000',
  `ADTCOST1` double(15,5) NOT NULL DEFAULT '0.00000',
  `ADTCOST2` double(15,5) NOT NULL DEFAULT '0.00000',
  `IT_COS` double(17,5) NOT NULL DEFAULT '0.00000',
  `AV_COST` double(17,5) NOT NULL DEFAULT '0.00000',
  `BATCHCODE` varchar(15) DEFAULT NULL,
  `EXPDATE` date NOT NULL DEFAULT '0000-00-00',
  `POINT` double(12,4) NOT NULL DEFAULT '0.0000',
  `INV_DISC` double(17,5) NOT NULL DEFAULT '0.00000',
  `INV_TAX` double(17,5) NOT NULL DEFAULT '0.00000',
  `SUPP` varchar(12) DEFAULT NULL,
  `EDI_COU1` varchar(12) DEFAULT NULL,
  `WRITEOFF` double(17,5) NOT NULL DEFAULT '0.00000',
  `TOSHIP` double(17,5) NOT NULL DEFAULT '0.00000',
  `SHIPPED` double(17,5) NOT NULL DEFAULT '0.00000',
  `NAME` varchar(40) DEFAULT NULL,
  `DEL_BY` varchar(12) DEFAULT NULL,
  `VAN` varchar(8) DEFAULT NULL,
  `GENERATED` char(1) DEFAULT NULL,
  `UD_QTY` char(1) DEFAULT NULL,
  `TOINV` varchar(24) DEFAULT NULL,
  `EXPORTED` varchar(24) DEFAULT NULL,
  `EXPORTED1` date NOT NULL DEFAULT '0000-00-00',
  `EXPORTED2` varchar(24) DEFAULT NULL,
  `EXPORTED3` date NOT NULL DEFAULT '0000-00-00',
  `BRK_TO` char(1) DEFAULT NULL,
  `SV_PART` varchar(24) DEFAULT NULL,
  `LAST_YEAR` char(1) DEFAULT NULL,
  `VOID` char(1) DEFAULT NULL,
  `SONO` varchar(40) DEFAULT NULL,
  `MC1_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `MC2_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `USERID` varchar(50) DEFAULT NULL,
  `DAMT` double(15,5) NOT NULL DEFAULT '0.00000',
  `OLDBILL` char(1) DEFAULT NULL,
  `WOS_GROUP` varchar(25) NOT NULL DEFAULT '',
  `CATEGORY` varchar(8) DEFAULT NULL,
  `AREA` varchar(12) DEFAULT NULL,
  `SHELF` varchar(8) DEFAULT NULL,
  `TEMP` varchar(24) DEFAULT NULL,
  `TEMP1` double(17,5) NOT NULL DEFAULT '0.00000',
  `BODY` char(1) DEFAULT NULL,
  `TOTALGROUP` varchar(3) DEFAULT NULL,
  `MARK` char(1) DEFAULT NULL,
  `TYPE_SEQ` varchar(2) DEFAULT NULL,
  `PROMOTER` varchar(8) DEFAULT NULL,
  `TABLENO` varchar(4) DEFAULT NULL,
  `MEMBER` varchar(20) DEFAULT NULL,
  `TOURGROUP` varchar(3) DEFAULT NULL,
  `TRDATETIME` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `TIME` varchar(8) DEFAULT NULL,
  `BOMNO` char(1) DEFAULT NULL,
  `COMMENT` blob,
  `DEFECTIVE` char(1) DEFAULT NULL,
  `M_CHARGE3` double(15,5) NOT NULL DEFAULT '0.00000',
  `M_CHARGE4` double(15,5) NOT NULL DEFAULT '0.00000',
  `M_CHARGE5` double(15,5) NOT NULL DEFAULT '0.00000',
  `M_CHARGE6` double(15,5) NOT NULL DEFAULT '0.00000',
  `M_CHARGE7` double(15,5) NOT NULL DEFAULT '0.00000',
  `MC3_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `MC4_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `MC5_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `MC6_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `MC7_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `taxincl` varchar(45) DEFAULT NULL,
  `LOC_CURRRATE` double(16,10) NOT NULL DEFAULT '1.0000000000',
  `LOC_CURRCODE` varchar(15) NOT NULL DEFAULT '',
  `TITLE_ID` varchar(45) NOT NULL DEFAULT '',
  `TITLE_DESP` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`TYPE`,`REFNO`,`CUSTNO`,`TRANCODE`,`ITEMCOUNT`,`ITEMNO`,`WOS_DATE`),
  KEY `COSTING` (`ITEMNO`,`TYPE`,`REFNO`,`TRANCODE`,`QTY`,`AMT`,`IT_COS`,`TOINV`,`VOID`),
  KEY `ASSMITEM` (`ITEMNO`,`TYPE`,`REFNO`,`FPERIOD`,`WOS_DATE`,`LOCATION`,`SOURCE`,`QTY`,`AMT`,`IT_COS`,`VOID`,`WOS_GROUP`,`CATEGORY`,`AREA`,`SHELF`,`BOMNO`),
  KEY `BATCHITEM` (`ITEMNO`,`TYPE`,`REFNO`,`CUSTNO`,`FPERIOD`,`WOS_DATE`,`AGENNO`,`LOCATION`,`QTY`,`AMT`,`BATCHCODE`,`EXPDATE`,`TOINV`,`WOS_GROUP`,`CATEGORY`,`AREA`),
  KEY `ITEMREPORT` (`ITEMNO`,`TYPE`,`FPERIOD`,`WOS_DATE`,`AGENNO`,`LOCATION`,`SOURCE`,`QTY`,`AMT`,`IT_COS`,`WOS_GROUP`,`CATEGORY`,`AREA`,`SHELF`,`SHIPPED`,`TOINV`),
  KEY `CUSTREPORT` (`CUSTNO`,`TYPE`,`ITEMNO`,`FPERIOD`,`WOS_DATE`,`AGENNO`,`LOCATION`,`SOURCE`,`QTY`,`AMT`,`IT_COS`,`SHIPPED`,`TOINV`,`WOS_GROUP`,`CATEGORY`,`AREA`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currictran`
--

LOCK TABLES `currictran` WRITE;
/*!40000 ALTER TABLE `currictran` DISABLE KEYS */;
/*!40000 ALTER TABLE `currictran` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customized_format`
--

DROP TABLE IF EXISTS `customized_format`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customized_format` (
  `TYPE` varchar(4) NOT NULL DEFAULT '',
  `DISPLAY_NAME` varchar(50) NOT NULL DEFAULT '',
  `FILE_NAME` varchar(50) NOT NULL DEFAULT '',
  `COUNTER` int(2) NOT NULL DEFAULT '0',
  `D_OPTION` int(2) NOT NULL DEFAULT '0',
  `updated_on` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`TYPE`,`COUNTER`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customized_format`
--

LOCK TABLES `customized_format` WRITE;
/*!40000 ALTER TABLE `customized_format` DISABLE KEYS */;
INSERT INTO `customized_format` VALUES ('CN','Credit Note','ACERICH_iCBIL_CN',1,0,'0000-00-00 00:00:00',''),('DN','Debit Note','ACERICH_iCBIL_DN',1,0,'0000-00-00 00:00:00','');
/*!40000 ALTER TABLE `customized_format` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dailycounter`
--

DROP TABLE IF EXISTS `dailycounter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dailycounter` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `counterid` varchar(45) NOT NULL DEFAULT '',
  `openning` double(17,2) NOT NULL DEFAULT '0.00',
  `wos_date` date DEFAULT '0000-00-00',
  `created_on` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` varchar(450) NOT NULL DEFAULT '',
  `updated_on` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by` varchar(450) NOT NULL DEFAULT '',
  `type` varchar(45) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dailycounter`
--

LOCK TABLES `dailycounter` WRITE;
/*!40000 ALTER TABLE `dailycounter` DISABLE KEYS */;
/*!40000 ALTER TABLE `dailycounter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dealer_menu`
--

DROP TABLE IF EXISTS `dealer_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dealer_menu` (
  `COMPANY_ID` varchar(50) NOT NULL DEFAULT 'IMS',
  `KEEP_DELETED_BILLS` char(1) DEFAULT NULL,
  `NEGETIVE_STOCK_ALLOWED` char(1) DEFAULT NULL,
  `WITH_SUPER_PASSWORD` char(1) DEFAULT NULL,
  `ALLOWED_EDIT_QUANTITY_OF_INVOICE_GENERATED_FROM_DO` char(1) DEFAULT NULL,
  `ALLOWED_REPEATED_REF_NO_2_IN_SO_CN_DN` char(1) DEFAULT NULL,
  `WITH_SYSTEM_DATE_TIME` char(1) DEFAULT NULL,
  `CREATE_BACKUP_SET_AT_YEAR_END_PROCESSING` char(1) DEFAULT NULL,
  `CENTS_IN_ARABIC` char(1) DEFAULT NULL,
  `USE_USER_ID_TO_LOGIN` char(1) DEFAULT NULL,
  `SELLING_BELOW_COST` char(1) DEFAULT NULL,
  `MINIMUM_SELLING_PRICE` char(1) DEFAULT NULL,
  `SELLING_ABOVE_CREDIT_LIMIT` char(1) DEFAULT NULL,
  `FOC_ITEM` char(1) DEFAULT NULL,
  `EDIT_BILLS` char(1) DEFAULT NULL,
  `DELETE_BILLS` char(1) DEFAULT NULL,
  `SECOND_PRINT_CONTROL` char(1) DEFAULT NULL,
  `TRANS_LIMIT_DEMO` int(10) unsigned DEFAULT '0',
  `DATE_EXPIRED` date DEFAULT '0000-00-00',
  `REMOVE_AUDIT_TRAIL_OF_MODIFICATION` char(1) DEFAULT NULL,
  `CONTROL_CREDIT_LIMIT_FOR_SO` char(1) DEFAULT NULL,
  `SET_GST_TO_ZR_WHEN_TAX_0` char(1) DEFAULT NULL,
  `PASSWORD` varchar(50) DEFAULT NULL,
  `COST_ALLOWED_PIN` varchar(50) DEFAULT NULL,
  `custSuppSortBy` varchar(45) NOT NULL DEFAULT 'name,custno',
  `productSortBy` varchar(45) NOT NULL DEFAULT 'itemno,desp',
  `transactionSortBy` varchar(45) NOT NULL DEFAULT 'wos_date desc,refno desc',
  `include_SO_PO_stockcard` char(1) DEFAULT NULL,
  `customcompany` char(1) NOT NULL DEFAULT '',
  `custformat` char(1) NOT NULL DEFAULT '1',
  `itemformat` char(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`COMPANY_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dealer_menu`
--

LOCK TABLES `dealer_menu` WRITE;
/*!40000 ALTER TABLE `dealer_menu` DISABLE KEYS */;
INSERT INTO `dealer_menu` VALUES ('IMS','','Y','Y','','Y','','Y','','Y','','','','','','','',200,'3069-12-12','','','Y','UBS','01234','name,custno','itemno,desp','wos_date desc,refno desc',NULL,'','1','1');
/*!40000 ALTER TABLE `dealer_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deleted_apvend`
--

DROP TABLE IF EXISTS `deleted_apvend`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deleted_apvend` (
  `EDI_ID` varchar(12) DEFAULT NULL,
  `CUSTNO` varchar(12) NOT NULL DEFAULT '',
  `NAME` varchar(40) DEFAULT NULL,
  `NAME2` varchar(40) DEFAULT NULL,
  `ADD1` varchar(35) DEFAULT NULL,
  `ADD2` varchar(35) DEFAULT NULL,
  `ADD3` varchar(35) DEFAULT NULL,
  `ADD4` varchar(35) DEFAULT NULL,
  `ATTN` varchar(35) DEFAULT NULL,
  `DADDR1` varchar(35) DEFAULT NULL,
  `DADDR2` varchar(35) DEFAULT NULL,
  `DADDR3` varchar(35) DEFAULT NULL,
  `DADDR4` varchar(35) DEFAULT NULL,
  `DATTN` varchar(35) DEFAULT NULL,
  `CONTACT` varchar(15) DEFAULT NULL,
  `PHONE` varchar(25) DEFAULT NULL,
  `PHONEA` varchar(25) DEFAULT NULL,
  `DPHONE` varchar(25) DEFAULT NULL,
  `FAX` varchar(25) DEFAULT NULL,
  `DFAX` varchar(25) DEFAULT NULL,
  `E_MAIL` varchar(50) DEFAULT NULL,
  `WEB_SITE` varchar(50) DEFAULT NULL,
  `BANKACCNO` varchar(18) DEFAULT NULL,
  `AREA` varchar(12) DEFAULT NULL,
  `AGENT` varchar(12) DEFAULT NULL,
  `BUSINESS` varchar(15) DEFAULT NULL,
  `TERM` varchar(12) DEFAULT NULL,
  `CRLIMIT` decimal(19,2) NOT NULL DEFAULT '0.00',
  `CURRCODE` varchar(10) DEFAULT NULL,
  `CURRENCY` varchar(10) DEFAULT NULL,
  `CURRENCY1` varchar(17) DEFAULT NULL,
  `CURRENCY2` varchar(17) DEFAULT NULL,
  `POINT_BF` decimal(19,2) NOT NULL DEFAULT '0.00',
  `AUTOPAY` char(1) DEFAULT NULL,
  `LC_EX` decimal(1,0) NOT NULL DEFAULT '0',
  `CT_GROUP` varchar(8) DEFAULT NULL,
  `TEMP` decimal(19,2) NOT NULL DEFAULT '0.00',
  `TARGET` decimal(19,2) NOT NULL DEFAULT '0.00',
  `MOD_DEL` varchar(2) DEFAULT NULL,
  `ARREM1` varchar(35) DEFAULT NULL,
  `ARREM2` varchar(35) DEFAULT NULL,
  `ARREM3` varchar(35) DEFAULT NULL,
  `ARREM4` varchar(35) DEFAULT NULL,
  `GROUPTO` varchar(12) DEFAULT NULL,
  `STATUS` char(1) DEFAULT NULL,
  `CUST_TYPE` varchar(3) DEFAULT NULL,
  `ACCSTATUS` char(1) DEFAULT NULL,
  `DATE` date NOT NULL DEFAULT '0000-00-00',
  `INVLIMIT` decimal(19,2) DEFAULT '0.00',
  `TERMEXCEED` char(1) DEFAULT NULL,
  `CHANNEL` varchar(20) DEFAULT NULL,
  `SALEC` varchar(12) DEFAULT NULL,
  `SALECNC` varchar(12) DEFAULT NULL,
  `TERM_IN_M` decimal(2,0) NOT NULL DEFAULT '0',
  `CR_AP_REF` varchar(20) DEFAULT NULL,
  `CR_AP_DATE` date NOT NULL DEFAULT '0000-00-00',
  `COLLATERAL` varchar(20) DEFAULT NULL,
  `GUARANTOR` varchar(20) DEFAULT NULL,
  `DISPEC_CAT` char(1) DEFAULT NULL,
  `DISPEC1` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DISPEC2` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DISPEC3` decimal(5,2) NOT NULL DEFAULT '0.00',
  `COMMPERC` decimal(5,2) NOT NULL DEFAULT '0.00',
  `OUTSTAND` decimal(19,2) NOT NULL DEFAULT '0.00',
  `NGST_CUST` enum('T','F') NOT NULL DEFAULT 'T',
  `PERSONIC1` varchar(50) DEFAULT NULL,
  `POSITION1` varchar(50) DEFAULT NULL,
  `DEPT1` varchar(50) DEFAULT NULL,
  `CONTACT1` varchar(25) DEFAULT NULL,
  `SITENAME` varchar(50) DEFAULT NULL,
  `SITEADD1` varchar(40) DEFAULT NULL,
  `SITEADD2` varchar(40) DEFAULT NULL,
  `EDITED` char(1) DEFAULT NULL,
  `ACC_CODE` varchar(12) DEFAULT NULL,
  `PROV_DISC` decimal(5,2) NOT NULL DEFAULT '0.00',
  `comuen` varchar(45) DEFAULT NULL,
  `CREATED_BY` varchar(45) DEFAULT NULL,
  `UPDATED_BY` varchar(45) DEFAULT NULL,
  `CREATED_ON` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `UPDATED_ON` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `GSTNO` varchar(25) DEFAULT NULL,
  `COUNTRY` varchar(25) DEFAULT NULL,
  `POSTALCODE` varchar(25) DEFAULT NULL,
  `D_COUNTRY` varchar(25) DEFAULT NULL,
  `D_POSTALCODE` varchar(25) DEFAULT NULL,
  `END_USER` varchar(45) DEFAULT NULL,
  `DELETED_BY` varchar(50) DEFAULT '',
  `DELETED_ON` datetime DEFAULT '0000-00-00 00:00:00',
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ID`),
  KEY `SUPPBASICINFO` (`CUSTNO`,`NAME`,`AREA`,`AGENT`,`BUSINESS`,`TERM`,`CURRCODE`,`STATUS`,`TERMEXCEED`,`SALEC`,`SALECNC`) USING BTREE,
  KEY `BILLADDINFO` (`CUSTNO`,`NAME`,`NAME2`,`ADD1`,`ADD2`,`ADD3`,`ADD4`,`ATTN`,`CONTACT`,`PHONE`,`FAX`) USING BTREE,
  KEY `DELADDINFO` (`CUSTNO`,`NAME`,`NAME2`,`DADDR1`,`DADDR2`,`DADDR3`,`DADDR4`,`DATTN`,`CONTACT`,`PHONE`,`FAX`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deleted_apvend`
--

LOCK TABLES `deleted_apvend` WRITE;
/*!40000 ALTER TABLE `deleted_apvend` DISABLE KEYS */;
/*!40000 ALTER TABLE `deleted_apvend` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deleted_arcust`
--

DROP TABLE IF EXISTS `deleted_arcust`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deleted_arcust` (
  `EDI_ID` varchar(12) DEFAULT NULL,
  `CUSTNO` varchar(12) NOT NULL DEFAULT '',
  `NAME` varchar(40) DEFAULT NULL,
  `NAME2` varchar(40) DEFAULT NULL,
  `ADD1` varchar(35) DEFAULT NULL,
  `ADD2` varchar(35) DEFAULT NULL,
  `ADD3` varchar(35) DEFAULT NULL,
  `ADD4` varchar(35) DEFAULT NULL,
  `ATTN` varchar(35) DEFAULT NULL,
  `DADDR1` varchar(35) DEFAULT NULL,
  `DADDR2` varchar(35) DEFAULT NULL,
  `DADDR3` varchar(35) DEFAULT NULL,
  `DADDR4` varchar(35) DEFAULT NULL,
  `DATTN` varchar(35) DEFAULT NULL,
  `CONTACT` varchar(15) DEFAULT NULL,
  `PHONE` varchar(25) DEFAULT NULL,
  `PHONEA` varchar(25) DEFAULT NULL,
  `DPHONE` varchar(25) DEFAULT NULL,
  `FAX` varchar(25) DEFAULT NULL,
  `DFAX` varchar(25) DEFAULT NULL,
  `E_MAIL` varchar(50) DEFAULT NULL,
  `WEB_SITE` varchar(50) DEFAULT NULL,
  `BANKACCNO` varchar(18) DEFAULT NULL,
  `AREA` varchar(12) DEFAULT NULL,
  `AGENT` varchar(12) DEFAULT NULL,
  `BUSINESS` varchar(15) DEFAULT NULL,
  `TERM` varchar(12) DEFAULT NULL,
  `CRLIMIT` decimal(19,2) NOT NULL DEFAULT '0.00',
  `CURRCODE` varchar(10) DEFAULT NULL,
  `CURRENCY` varchar(10) DEFAULT NULL,
  `CURRENCY1` varchar(17) DEFAULT NULL,
  `CURRENCY2` varchar(17) DEFAULT NULL,
  `POINT_BF` decimal(19,2) NOT NULL DEFAULT '0.00',
  `AUTOPAY` char(1) DEFAULT NULL,
  `LC_EX` decimal(1,0) NOT NULL DEFAULT '0',
  `CT_GROUP` varchar(8) DEFAULT NULL,
  `TEMP` decimal(19,2) NOT NULL DEFAULT '0.00',
  `TARGET` decimal(19,2) NOT NULL DEFAULT '0.00',
  `MOD_DEL` varchar(2) DEFAULT NULL,
  `ARREM1` varchar(35) DEFAULT NULL,
  `ARREM2` varchar(35) DEFAULT NULL,
  `ARREM3` varchar(35) DEFAULT NULL,
  `ARREM4` varchar(35) DEFAULT NULL,
  `GROUPTO` varchar(12) DEFAULT NULL,
  `STATUS` char(1) DEFAULT NULL,
  `CUST_TYPE` varchar(3) DEFAULT NULL,
  `ACCSTATUS` char(1) DEFAULT NULL,
  `DATE` date NOT NULL DEFAULT '0000-00-00',
  `INVLIMIT` decimal(19,2) DEFAULT '0.00',
  `TERMEXCEED` char(1) DEFAULT NULL,
  `CHANNEL` varchar(20) DEFAULT NULL,
  `SALEC` varchar(12) DEFAULT NULL,
  `SALECNC` varchar(12) DEFAULT NULL,
  `TERM_IN_M` decimal(2,0) NOT NULL DEFAULT '0',
  `CR_AP_REF` varchar(20) DEFAULT NULL,
  `CR_AP_DATE` date NOT NULL DEFAULT '0000-00-00',
  `COLLATERAL` varchar(20) DEFAULT NULL,
  `GUARANTOR` varchar(20) DEFAULT NULL,
  `DISPEC_CAT` char(1) DEFAULT NULL,
  `DISPEC1` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DISPEC2` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DISPEC3` decimal(5,2) NOT NULL DEFAULT '0.00',
  `COMMPERC` decimal(5,2) NOT NULL DEFAULT '0.00',
  `OUTSTAND` decimal(19,2) NOT NULL DEFAULT '0.00',
  `NGST_CUST` enum('T','F') NOT NULL DEFAULT 'T',
  `PERSONIC1` varchar(50) DEFAULT NULL,
  `POSITION1` varchar(50) DEFAULT NULL,
  `DEPT1` varchar(50) DEFAULT NULL,
  `CONTACT1` varchar(25) DEFAULT NULL,
  `SITENAME` varchar(50) DEFAULT NULL,
  `SITEADD1` varchar(40) DEFAULT NULL,
  `SITEADD2` varchar(40) DEFAULT NULL,
  `EDITED` char(1) DEFAULT NULL,
  `ACC_CODE` varchar(12) DEFAULT NULL,
  `PROV_DISC` decimal(5,2) NOT NULL DEFAULT '0.00',
  `comuen` varchar(45) DEFAULT NULL,
  `CREATED_BY` varchar(45) DEFAULT NULL,
  `UPDATED_BY` varchar(45) DEFAULT NULL,
  `CREATED_ON` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `UPDATED_ON` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `GSTNO` varchar(25) DEFAULT NULL,
  `COUNTRY` varchar(25) DEFAULT NULL,
  `POSTALCODE` varchar(25) DEFAULT NULL,
  `D_COUNTRY` varchar(25) DEFAULT NULL,
  `D_POSTALCODE` varchar(25) DEFAULT NULL,
  `END_USER` varchar(45) DEFAULT NULL,
  `DELETED_BY` varchar(50) DEFAULT '',
  `DELETED_ON` datetime DEFAULT '0000-00-00 00:00:00',
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ID`),
  KEY `SUPPBASICINFO` (`CUSTNO`,`NAME`,`AREA`,`AGENT`,`BUSINESS`,`TERM`,`CURRCODE`,`STATUS`,`TERMEXCEED`,`SALEC`,`SALECNC`) USING BTREE,
  KEY `BILLADDINFO` (`CUSTNO`,`NAME`,`NAME2`,`ADD1`,`ADD2`,`ADD3`,`ADD4`,`ATTN`,`CONTACT`,`PHONE`,`FAX`) USING BTREE,
  KEY `DELADDINFO` (`CUSTNO`,`NAME`,`NAME2`,`DADDR1`,`DADDR2`,`DADDR3`,`DADDR4`,`DATTN`,`CONTACT`,`PHONE`,`FAX`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deleted_arcust`
--

LOCK TABLES `deleted_arcust` WRITE;
/*!40000 ALTER TABLE `deleted_arcust` DISABLE KEYS */;
/*!40000 ALTER TABLE `deleted_arcust` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deleted_icitem`
--

DROP TABLE IF EXISTS `deleted_icitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deleted_icitem` (
  `EDI_ID` int(12) NOT NULL DEFAULT '0',
  `ITEMNO` varchar(60) NOT NULL DEFAULT '',
  `AITEMNO` varchar(40) DEFAULT NULL,
  `MITEMNO` varchar(20) DEFAULT NULL,
  `SHORTCODE` varchar(6) DEFAULT NULL,
  `DESP` varchar(100) DEFAULT NULL,
  `DESPA` varchar(100) DEFAULT NULL,
  `BRAND` varchar(40) DEFAULT NULL,
  `CATEGORY` varchar(80) DEFAULT '',
  `WOS_GROUP` varchar(25) DEFAULT NULL,
  `SHELF` varchar(100) DEFAULT '',
  `SUPP` varchar(12) DEFAULT NULL,
  `PACKING` varchar(20) DEFAULT NULL,
  `WEIGHT` double(12,7) NOT NULL DEFAULT '0.0000000',
  `COSTCODE` varchar(20) DEFAULT NULL,
  `UNIT` varchar(12) DEFAULT NULL,
  `UCOST` double(17,7) NOT NULL DEFAULT '0.0000000',
  `PRICE` double(17,7) NOT NULL DEFAULT '0.0000000',
  `PRICE2` double(17,7) NOT NULL DEFAULT '0.0000000',
  `PRICE3` double(17,7) NOT NULL DEFAULT '0.0000000',
  `PRICE_MIN` double(17,7) DEFAULT '0.0000000',
  `MINIMUM` double(17,7) NOT NULL DEFAULT '0.0000000',
  `MAXIMUM` double(17,7) NOT NULL DEFAULT '0.0000000',
  `REORDER` double(17,7) NOT NULL DEFAULT '0.0000000',
  `UNIT2` varchar(12) DEFAULT NULL,
  `COLORID` varchar(10) DEFAULT NULL,
  `SIZEID` varchar(10) DEFAULT NULL,
  `FACTOR1` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FACTOR2` double(17,7) NOT NULL DEFAULT '0.0000000',
  `PRICEU2` double(17,7) NOT NULL DEFAULT '0.0000000',
  `UNIT3` varchar(12) DEFAULT NULL,
  `FACTORU3_A` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FACTORU3_B` double(17,7) NOT NULL DEFAULT '0.0000000',
  `PRICEU3` double(17,7) NOT NULL DEFAULT '0.0000000',
  `UNIT4` varchar(12) DEFAULT NULL,
  `FACTORU4_A` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FACTORU4_B` double(17,7) NOT NULL DEFAULT '0.0000000',
  `PRICEU4` double(17,7) NOT NULL DEFAULT '0.0000000',
  `UNIT5` varchar(12) DEFAULT NULL,
  `FACTORU5_A` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FACTORU5_B` double(17,7) NOT NULL DEFAULT '0.0000000',
  `PRICEU5` double(17,7) NOT NULL DEFAULT '0.0000000',
  `UNIT6` varchar(12) DEFAULT NULL,
  `FACTORU6_A` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FACTORU6_B` double(17,7) NOT NULL DEFAULT '0.0000000',
  `PRICEU6` double(17,7) NOT NULL DEFAULT '0.0000000',
  `DISPEC_A1` double(17,7) NOT NULL DEFAULT '0.0000000',
  `DISPEC_A2` double(17,7) NOT NULL DEFAULT '0.0000000',
  `DISPEC_A3` double(17,7) NOT NULL DEFAULT '0.0000000',
  `DISPEC_B1` double(17,7) NOT NULL DEFAULT '0.0000000',
  `DISPEC_B2` double(17,7) NOT NULL DEFAULT '0.0000000',
  `DISPEC_B3` double(17,7) NOT NULL DEFAULT '0.0000000',
  `DISPEC_C1` double(17,7) NOT NULL DEFAULT '0.0000000',
  `DISPEC_C2` double(17,7) NOT NULL DEFAULT '0.0000000',
  `DISPEC_C3` double(17,7) NOT NULL DEFAULT '0.0000000',
  `PRICE_CATA` double(17,7) NOT NULL DEFAULT '0.0000000',
  `PRICE_CATB` double(17,7) NOT NULL DEFAULT '0.0000000',
  `PRICE_CATC` double(17,7) NOT NULL DEFAULT '0.0000000',
  `COST_CATA` double(17,7) NOT NULL DEFAULT '0.0000000',
  `COST_CATB` double(17,7) NOT NULL DEFAULT '0.0000000',
  `COST_CATC` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QTY2` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QTY3` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QTY4` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QTY5` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QTY6` double(17,7) NOT NULL DEFAULT '0.0000000',
  `WQFORMULA` varchar(10) DEFAULT NULL,
  `WPFORMULA` varchar(10) DEFAULT NULL,
  `GRADED` char(1) DEFAULT NULL,
  `MURATIO` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QTYBF` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QTYNET` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QTYACTUAL` double(17,7) NOT NULL DEFAULT '0.0000000',
  `AVCOST` double(17,7) NOT NULL DEFAULT '0.0000000',
  `AVCOST2` double(17,7) NOT NULL DEFAULT '0.0000000',
  `BOM_COST` double(17,7) NOT NULL DEFAULT '0.0000000',
  `TQ_OBAL` double(17,7) NOT NULL DEFAULT '0.0000000',
  `TQ_IN` double(17,7) NOT NULL DEFAULT '0.0000000',
  `TQ_OUT` double(17,7) NOT NULL DEFAULT '0.0000000',
  `TQ_CBAL` double(17,7) NOT NULL DEFAULT '0.0000000',
  `T_UCOST` double(17,7) NOT NULL DEFAULT '0.0000000',
  `T_STKV` double(17,7) NOT NULL DEFAULT '0.0000000',
  `TQ_INV` double(17,7) NOT NULL DEFAULT '0.0000000',
  `TQ_CS` double(17,7) NOT NULL DEFAULT '0.0000000',
  `TQ_CN` double(17,7) NOT NULL DEFAULT '0.0000000',
  `TQ_DN` double(17,7) NOT NULL DEFAULT '0.0000000',
  `TQ_RC` double(17,7) NOT NULL DEFAULT '0.0000000',
  `TQ_PR` double(17,7) NOT NULL DEFAULT '0.0000000',
  `TQ_ISS` double(17,7) NOT NULL DEFAULT '0.0000000',
  `TQ_OAI` double(17,7) NOT NULL DEFAULT '0.0000000',
  `TQ_OAR` double(17,7) NOT NULL DEFAULT '0.0000000',
  `TA_INV` double(17,7) NOT NULL DEFAULT '0.0000000',
  `TA_CS` double(17,7) NOT NULL DEFAULT '0.0000000',
  `TA_CN` double(17,7) NOT NULL DEFAULT '0.0000000',
  `TA_DN` double(17,7) NOT NULL DEFAULT '0.0000000',
  `TA_RC` double(17,7) NOT NULL DEFAULT '0.0000000',
  `TA_PR` double(17,7) NOT NULL DEFAULT '0.0000000',
  `TA_ISS` double(17,7) NOT NULL DEFAULT '0.0000000',
  `TA_OAI` double(17,7) NOT NULL DEFAULT '0.0000000',
  `TA_OAR` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QIN11` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QIN12` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QIN13` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QIN14` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QIN15` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QIN16` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QIN17` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QIN18` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QIN19` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QIN20` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QIN21` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QIN22` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QIN23` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QIN24` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QIN25` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QIN26` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QIN27` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QIN28` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QOUT11` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QOUT12` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QOUT13` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QOUT14` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QOUT15` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QOUT16` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QOUT17` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QOUT18` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QOUT19` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QOUT20` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QOUT21` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QOUT22` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QOUT23` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QOUT24` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QOUT25` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QOUT26` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QOUT27` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QOUT28` double(17,7) NOT NULL DEFAULT '0.0000000',
  `SALEC` varchar(8) DEFAULT NULL,
  `SALECSC` varchar(8) DEFAULT NULL,
  `SALECNC` varchar(8) DEFAULT NULL,
  `PURC` varchar(8) DEFAULT NULL,
  `PURPREC` varchar(8) DEFAULT NULL,
  `TEMPFIG` double(17,7) NOT NULL DEFAULT '0.0000000',
  `TEMPFIG1` double(17,7) NOT NULL DEFAULT '0.0000000',
  `CT_RATING` char(1) DEFAULT NULL,
  `POINT` double(12,4) NOT NULL DEFAULT '0.0000',
  `QCPOINT` double(12,4) NOT NULL DEFAULT '0.0000',
  `AWARD1` double(10,7) NOT NULL DEFAULT '0.0000000',
  `AWARD2` double(10,7) NOT NULL DEFAULT '0.0000000',
  `AWARD3` double(10,7) NOT NULL DEFAULT '0.0000000',
  `AWARD4` double(10,7) NOT NULL DEFAULT '0.0000000',
  `AWARD5` double(10,7) NOT NULL DEFAULT '0.0000000',
  `AWARD6` double(10,7) NOT NULL DEFAULT '0.0000000',
  `AWARD7` double(10,7) NOT NULL DEFAULT '0.0000000',
  `AWARD8` double(10,7) NOT NULL DEFAULT '0.0000000',
  `REMARK1` varchar(50) DEFAULT NULL,
  `REMARK2` varchar(50) DEFAULT NULL,
  `REMARK3` varchar(50) DEFAULT NULL,
  `REMARK4` varchar(50) DEFAULT NULL,
  `REMARK5` varchar(50) DEFAULT NULL,
  `REMARK6` varchar(50) DEFAULT NULL,
  `REMARK7` varchar(50) DEFAULT NULL,
  `REMARK8` varchar(50) DEFAULT NULL,
  `REMARK9` varchar(50) DEFAULT NULL,
  `REMARK10` varchar(50) DEFAULT NULL,
  `REMARK11` varchar(50) DEFAULT NULL,
  `REMARK12` varchar(50) DEFAULT NULL,
  `REMARK13` varchar(50) DEFAULT NULL,
  `REMARK14` varchar(50) DEFAULT NULL,
  `REMARK15` varchar(50) DEFAULT NULL,
  `REMARK16` varchar(50) DEFAULT NULL,
  `REMARK17` varchar(50) DEFAULT NULL,
  `REMARK18` varchar(50) DEFAULT NULL,
  `REMARK19` varchar(50) DEFAULT NULL,
  `REMARK20` varchar(50) DEFAULT NULL,
  `REMARK21` varchar(50) DEFAULT NULL,
  `REMARK22` varchar(50) DEFAULT NULL,
  `REMARK23` varchar(50) DEFAULT NULL,
  `REMARK24` varchar(50) DEFAULT NULL,
  `REMARK25` varchar(50) DEFAULT NULL,
  `REMARK26` varchar(50) DEFAULT NULL,
  `REMARK27` varchar(50) DEFAULT NULL,
  `REMARK28` varchar(50) DEFAULT NULL,
  `REMARK29` varchar(50) DEFAULT NULL,
  `REMARK30` varchar(50) DEFAULT NULL,
  `COMMRATE1` double(10,4) NOT NULL DEFAULT '0.0000',
  `COMMRATE2` double(10,4) NOT NULL DEFAULT '0.0000',
  `COMMRATE3` double(10,4) NOT NULL DEFAULT '0.0000',
  `COMMRATE4` double(10,4) NOT NULL DEFAULT '0.0000',
  `WOS_DATE` date NOT NULL DEFAULT '0000-00-00',
  `QTYDEC` double(10,4) NOT NULL DEFAULT '0.0000',
  `TEMP_QTY` double(10,4) NOT NULL DEFAULT '0.0000',
  `QTY` double(10,4) NOT NULL DEFAULT '0.0000',
  `PHOTO` varchar(100) DEFAULT NULL,
  `COMPEC_A` double(12,4) NOT NULL DEFAULT '0.0000',
  `COMPEC_B` double(12,4) NOT NULL DEFAULT '0.0000',
  `COMPEC_C` double(12,4) NOT NULL DEFAULT '0.0000',
  `WOS_TIME` date NOT NULL DEFAULT '0000-00-00',
  `EXPIRED` double(12,3) NOT NULL DEFAULT '0.000',
  `WSERIALNO` char(1) DEFAULT '0',
  `PROMOTOR` varchar(8) DEFAULT NULL,
  `TAXABLE` char(1) DEFAULT NULL,
  `TAXPERC1` double(6,2) NOT NULL DEFAULT '0.00',
  `TAXPERC2` double(6,2) NOT NULL DEFAULT '0.00',
  `NONSTKITEM` char(1) DEFAULT NULL,
  `GRAPHIC` varchar(100) DEFAULT NULL,
  `PRODCODE` varchar(40) DEFAULT NULL,
  `BRK_TO` varchar(20) DEFAULT NULL,
  `COLOR` varchar(20) DEFAULT NULL,
  `SIZE` varchar(20) DEFAULT NULL,
  `qtybf_actual` varchar(10) DEFAULT NULL,
  `CREATED_BY` varchar(50) DEFAULT NULL,
  `CREATED_ON` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UPDATED_BY` varchar(50) DEFAULT NULL,
  `UPDATED_ON` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `DELETED_BY` varchar(50) DEFAULT '',
  `DELETED_ON` datetime DEFAULT '0000-00-00 00:00:00',
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ID`),
  KEY `COSTING` (`ITEMNO`,`UCOST`,`QTYBF`,`AVCOST`,`AVCOST2`),
  KEY `ITEMAGING1` (`ITEMNO`,`QTYBF`,`QIN11`,`QIN12`,`QIN13`,`QIN14`,`QIN15`,`QIN16`,`QIN17`,`QOUT11`,`QOUT12`,`QOUT13`,`QOUT14`,`QOUT15`,`QOUT16`,`QOUT17`),
  KEY `ITEMAGING2` (`ITEMNO`,`QTYBF`,`QIN18`,`QIN19`,`QIN20`,`QIN21`,`QIN22`,`QIN23`,`QIN24`,`QOUT18`,`QOUT19`,`QOUT20`,`QOUT21`,`QOUT22`,`QOUT23`,`QOUT24`),
  KEY `ITEMAGING3` (`ITEMNO`,`QTYBF`,`QIN25`,`QIN26`,`QIN27`,`QIN28`,`QOUT25`,`QOUT26`,`QOUT27`,`QOUT28`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deleted_icitem`
--

LOCK TABLES `deleted_icitem` WRITE;
/*!40000 ALTER TABLE `deleted_icitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `deleted_icitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deposit`
--

DROP TABLE IF EXISTS `deposit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deposit` (
  `depositno` varchar(45) NOT NULL DEFAULT '',
  `desp` varchar(200) DEFAULT NULL,
  `CS_PM_CASH` double(17,7) NOT NULL DEFAULT '0.0000000',
  `CS_PM_CHEQ` double(17,7) NOT NULL DEFAULT '0.0000000',
  `CS_PM_CRCD` double(17,7) NOT NULL DEFAULT '0.0000000',
  `CS_PM_CRC2` double(17,7) NOT NULL DEFAULT '0.0000000',
  `CS_PM_DBCD` double(17,7) NOT NULL DEFAULT '0.0000000',
  `CS_PM_VOUC` double(17,7) NOT NULL DEFAULT '0.0000000',
  `CS_PM_CASHCD` double(17,7) NOT NULL DEFAULT '0.0000000',
  `rem1` varchar(200) NOT NULL DEFAULT '',
  `rem2` varchar(200) NOT NULL DEFAULT '',
  `rem3` varchar(200) NOT NULL DEFAULT '',
  `rem4` varchar(200) NOT NULL DEFAULT '',
  `rem5` varchar(200) NOT NULL DEFAULT '',
  `rem6` varchar(200) NOT NULL DEFAULT '',
  `rem7` varchar(200) NOT NULL DEFAULT '',
  `rem8` varchar(200) NOT NULL DEFAULT '',
  `rem9` varchar(200) NOT NULL DEFAULT '',
  `rem10` varchar(200) NOT NULL DEFAULT '',
  `Billno` varchar(200) DEFAULT NULL,
  `chequeno` varchar(200) DEFAULT '',
  `cctype1` varchar(200) NOT NULL DEFAULT '',
  `cctype2` varchar(200) NOT NULL DEFAULT '',
  `sono` varchar(200) DEFAULT '',
  `wos_date` date NOT NULL DEFAULT '0000-00-00',
  PRIMARY KEY (`depositno`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deposit`
--

LOCK TABLES `deposit` WRITE;
/*!40000 ALTER TABLE `deposit` DISABLE KEYS */;
/*!40000 ALTER TABLE `deposit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discount`
--

DROP TABLE IF EXISTS `discount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `discount` (
  `discount` double(17,7) NOT NULL DEFAULT '0.0000000',
  `desp` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`discount`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discount`
--

LOCK TABLES `discount` WRITE;
/*!40000 ALTER TABLE `discount` DISABLE KEYS */;
/*!40000 ALTER TABLE `discount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `displaysetup`
--

DROP TABLE IF EXISTS `displaysetup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `displaysetup` (
  `bill_refno` varchar(45) DEFAULT NULL,
  `bill_refno2` varchar(45) DEFAULT '',
  `bill_custno` varchar(45) DEFAULT NULL,
  `bill_name` varchar(45) DEFAULT NULL,
  `bill_date` varchar(45) DEFAULT NULL,
  `bill_period` varchar(45) DEFAULT NULL,
  `bill_PO` varchar(45) DEFAULT NULL,
  `bill_project` varchar(45) DEFAULT NULL,
  `bill_job` varchar(45) DEFAULT NULL,
  `bill_agent` varchar(45) DEFAULT NULL,
  `bill_driver` varchar(45) DEFAULT NULL,
  `bill_created` varchar(45) DEFAULT NULL,
  `bill_user` varchar(45) DEFAULT NULL,
  `bill_currcode` varchar(45) DEFAULT NULL,
  `bill_rem5` varchar(45) DEFAULT NULL,
  `bill_rem6` varchar(45) DEFAULT NULL,
  `bill_rem7` varchar(45) DEFAULT NULL,
  `bill_rem8` varchar(45) DEFAULT NULL,
  `bill_rem9` varchar(45) DEFAULT NULL,
  `bill_rem10` varchar(45) DEFAULT NULL,
  `bill_rem11` varchar(45) DEFAULT NULL,
  `billbody_itemno` varchar(45) DEFAULT NULL,
  `billbody_aitemno` varchar(45) DEFAULT NULL,
  `billbody_desp` varchar(45) DEFAULT NULL,
  `billbody_qty` varchar(45) DEFAULT NULL,
  `billbody_price` varchar(45) DEFAULT NULL,
  `billbody_currcode` varchar(45) DEFAULT NULL,
  `billbody_taxamt` varchar(45) DEFAULT NULL,
  `billbody_amt` varchar(45) DEFAULT NULL,
  `billbody_taxcode` varchar(45) DEFAULT NULL,
  `billbody_brem1` varchar(45) DEFAULT NULL,
  `billbody_brem2` varchar(45) DEFAULT NULL,
  `billbody_brem3` varchar(45) DEFAULT NULL,
  `billbody_brem4` varchar(45) DEFAULT NULL,
  `item_itemno` varchar(45) DEFAULT NULL,
  `item_aitemno` varchar(45) DEFAULT NULL,
  `item_desp` varchar(45) DEFAULT NULL,
  `item_brand` varchar(45) DEFAULT NULL,
  `item_model` varchar(45) DEFAULT NULL,
  `item_category` varchar(45) DEFAULT NULL,
  `item_group` varchar(45) DEFAULT NULL,
  `item_material` varchar(45) DEFAULT NULL,
  `item_rating` varchar(45) DEFAULT NULL,
  `item_cost` varchar(45) DEFAULT NULL,
  `item_price` varchar(45) DEFAULT NULL,
  `item_unit` varchar(45) DEFAULT NULL,
  `cust_custno` varchar(45) DEFAULT NULL,
  `cust_name` varchar(45) DEFAULT NULL,
  `cust_add` varchar(45) DEFAULT NULL,
  `cust_tel` varchar(45) DEFAULT NULL,
  `cust_contact` varchar(45) DEFAULT NULL,
  `cust_agent` varchar(45) DEFAULT NULL,
  `cust_driver` varchar(45) DEFAULT NULL,
  `cust_currcode` varchar(45) DEFAULT NULL,
  `cust_attn` varchar(45) DEFAULT NULL,
  `cust_fax` varchar(45) DEFAULT NULL,
  `cust_term` varchar(45) DEFAULT NULL,
  `cust_area` varchar(45) DEFAULT NULL,
  `cust_business` varchar(45) DEFAULT NULL,
  `cust_createdate` varchar(45) DEFAULT NULL,
  `companyid` varchar(45) NOT NULL DEFAULT 'IMS',
  `billbody_location` varchar(45) DEFAULT NULL,
  `bill_term` varchar(45) DEFAULT NULL,
  `bill_grand` varchar(45) DEFAULT NULL,
  `itemsearch_itemno` varchar(45) DEFAULT NULL,
  `itemsearch_aitemno` varchar(45) DEFAULT NULL,
  `itemsearch_desp` varchar(45) DEFAULT NULL,
  `itemsearch_ucost` varchar(45) DEFAULT NULL,
  `itemsearch_price` varchar(45) DEFAULT NULL,
  `itemsearch_qty` varchar(45) DEFAULT NULL,
  `billbody_project` varchar(45) DEFAULT NULL,
  `billbody_job` varchar(45) DEFAULT NULL,
  `item_sizeid` varchar(45) DEFAULT NULL,
  `report_aitemno` varchar(45) DEFAULT '',
  `bill_toinv` varchar(45) DEFAULT '',
  `billbody_unit` varchar(45) DEFAULT '',
  `billbody_batch` varchar(45) DEFAULT '',
  `simple_itemno` varchar(45) DEFAULT '',
  `simple_desp` varchar(45) DEFAULT '',
  `simple_location` varchar(45) DEFAULT '',
  `simple_qty` varchar(45) DEFAULT '',
  `simple_freeqty` varchar(45) DEFAULT '',
  `simple_packing` varchar(45) DEFAULT '',
  `simple_price` varchar(45) DEFAULT '',
  `simple_disc` varchar(45) DEFAULT '',
  `simple_amt` varchar(45) DEFAULT '',
  `update_location` varchar(45) DEFAULT NULL,
  `update_unit` varchar(45) DEFAULT NULL,
  `update_bodyremark1` varchar(45) DEFAULT NULL,
  `update_bodyremark2` varchar(45) DEFAULT NULL,
  `update_bodyremark3` varchar(45) DEFAULT NULL,
  `update_bodyremark4` varchar(45) DEFAULT NULL,
  `bill_b_attn` varchar(45) DEFAULT '',
  `bill_d_attn` varchar(45) DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `displaysetup`
--

LOCK TABLES `displaysetup` WRITE;
/*!40000 ALTER TABLE `displaysetup` DISABLE KEYS */;
INSERT INTO `displaysetup` VALUES ('Y','Y','Y','Y','Y','Y','Y','N','N','N','N','N','Y','N','N','N','N','N','N','N','N','Y','N','Y','Y','Y','Y','Y','Y','Y','N','N','N','N','Y','Y','Y','Y','Y','Y','Y','Y','Y','N','Y','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','IMS','Y','N','N','Y','Y','Y','Y','Y','Y',NULL,NULL,'Y','','','','','Y','Y','Y','Y','Y','Y','Y','Y','Y',NULL,NULL,NULL,NULL,NULL,NULL,'','');
/*!40000 ALTER TABLE `displaysetup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `displaysetup2`
--

DROP TABLE IF EXISTS `displaysetup2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `displaysetup2` (
  `companyid` varchar(45) NOT NULL DEFAULT 'IMS',
  `billdate` varchar(45) DEFAULT NULL,
  `customerno` varchar(45) DEFAULT NULL,
  `descp` varchar(45) DEFAULT NULL,
  `refno2` varchar(45) DEFAULT NULL,
  `currency` varchar(45) DEFAULT NULL,
  `enduser` varchar(45) DEFAULT NULL,
  `agent` varchar(45) DEFAULT NULL,
  `terms` varchar(45) DEFAULT NULL,
  `project` varchar(45) DEFAULT NULL,
  `so` varchar(45) DEFAULT NULL,
  `po` varchar(45) DEFAULT NULL,
  `do` varchar(45) DEFAULT NULL,
  `billtoadd_code` varchar(45) DEFAULT NULL,
  `deladd_code` varchar(45) DEFAULT NULL,
  `billattn` varchar(45) DEFAULT NULL,
  `delattn` varchar(45) DEFAULT NULL,
  `deltel` varchar(45) DEFAULT NULL,
  `permitno` varchar(45) DEFAULT NULL,
  `hremark5` varchar(45) DEFAULT NULL,
  `hremark6` varchar(45) DEFAULT NULL,
  `hremark7` varchar(45) DEFAULT NULL,
  `hremark8` varchar(45) DEFAULT NULL,
  `hremark9` varchar(45) DEFAULT NULL,
  `hremark10` varchar(45) DEFAULT NULL,
  `hremark11` varchar(45) DEFAULT NULL,
  `remark30` varchar(45) DEFAULT NULL,
  `remark31` varchar(45) DEFAULT NULL,
  `remark32` varchar(45) DEFAULT NULL,
  `remark33` varchar(45) DEFAULT NULL,
  `remark34` varchar(45) DEFAULT NULL,
  `remark35` varchar(45) DEFAULT NULL,
  `remark36` varchar(45) DEFAULT NULL,
  `remark37` varchar(45) DEFAULT NULL,
  `remark38` varchar(45) DEFAULT NULL,
  `remark39` varchar(45) DEFAULT NULL,
  `remark40` varchar(45) DEFAULT NULL,
  `remark41` varchar(45) DEFAULT NULL,
  `remark42` varchar(45) DEFAULT NULL,
  `remark43` varchar(45) DEFAULT NULL,
  `remark44` varchar(45) DEFAULT NULL,
  `remark45` varchar(45) DEFAULT NULL,
  `remark46` varchar(45) DEFAULT NULL,
  `remark47` varchar(45) DEFAULT NULL,
  `remark48` varchar(45) DEFAULT NULL,
  `remark49` varchar(45) DEFAULT NULL,
  `f_misc_charg1` varchar(45) DEFAULT NULL,
  `f_misc_charg2` varchar(45) DEFAULT NULL,
  `f_misc_charg3` varchar(45) DEFAULT NULL,
  `f_misc_charg4` varchar(45) DEFAULT NULL,
  `f_misc_charg5` varchar(45) DEFAULT NULL,
  `f_misc_charg6` varchar(45) DEFAULT NULL,
  `f_misc_charg7` varchar(45) DEFAULT NULL,
  `f_acc_code` varchar(45) DEFAULT NULL,
  `f_pay_cash` varchar(45) DEFAULT NULL,
  `f_pay_cheque` varchar(45) DEFAULT NULL,
  `f_pay_cc1` varchar(45) DEFAULT NULL,
  `f_pay_cc2` varchar(45) DEFAULT NULL,
  `f_pay_gvoucher` varchar(45) DEFAULT NULL,
  `f_pay_dc` varchar(45) DEFAULT NULL,
  `f_subtotal` varchar(45) DEFAULT NULL,
  `f_discount` varchar(45) DEFAULT NULL,
  `f_tax` varchar(45) DEFAULT NULL,
  `f_grand` varchar(45) DEFAULT NULL,
  `f_net` varchar(45) DEFAULT NULL,
  `f_terms_cond` varchar(45) DEFAULT NULL,
  `body_bal_on_hand` varchar(45) DEFAULT NULL,
  `body_uom` varchar(45) DEFAULT NULL,
  `body_location` varchar(45) DEFAULT NULL,
  `body_gl_ac` varchar(45) DEFAULT NULL,
  `body_serialno` varchar(45) DEFAULT NULL,
  `body_remark2` varchar(45) DEFAULT NULL,
  `body_remark3` varchar(45) DEFAULT NULL,
  `body_remark4` varchar(45) DEFAULT NULL,
  `body_as_voucher` varchar(45) DEFAULT NULL,
  `body_cost_code` varchar(45) DEFAULT NULL,
  `body_project` varchar(45) DEFAULT NULL,
  `body_title` varchar(45) DEFAULT NULL,
  `body_job` varchar(45) DEFAULT NULL,
  `job` varchar(45) DEFAULT NULL,
  `f_pay_as_debt` varchar(45) DEFAULT NULL,
  `f_pay_deposit` varchar(45) DEFAULT NULL,
  `item_no` varchar(45) DEFAULT NULL,
  `item_descp` varchar(45) DEFAULT NULL,
  `item_comment` varchar(45) DEFAULT NULL,
  `item_productcode` varchar(45) DEFAULT NULL,
  `item_barcode` varchar(45) DEFAULT NULL,
  `item_brand` varchar(45) DEFAULT NULL,
  `item_supplier` varchar(45) DEFAULT NULL,
  `item_category` varchar(45) DEFAULT NULL,
  `item_size` varchar(45) DEFAULT NULL,
  `item_packing` varchar(45) DEFAULT NULL,
  `item_shelfno` varchar(45) DEFAULT NULL,
  `item_material` varchar(45) DEFAULT NULL,
  `item_minimum` varchar(45) DEFAULT NULL,
  `item_maximum` varchar(45) DEFAULT NULL,
  `item_group` varchar(45) DEFAULT NULL,
  `item_reorder` varchar(45) DEFAULT NULL,
  `item_rating` varchar(45) DEFAULT NULL,
  `item_defalutedtax` varchar(45) DEFAULT NULL,
  `item_changepic` varchar(45) DEFAULT NULL,
  `item_itemtype` varchar(45) DEFAULT NULL,
  `item_costcode` varchar(45) DEFAULT NULL,
  `item_uom` varchar(45) DEFAULT NULL,
  `item_ucp` varchar(45) DEFAULT NULL,
  `item_usp1` varchar(45) DEFAULT NULL,
  `item_usp2` varchar(45) DEFAULT NULL,
  `item_mur` varchar(45) DEFAULT NULL,
  `item_usp4` varchar(45) DEFAULT NULL,
  `item_msp` varchar(45) DEFAULT NULL,
  `item_discontinue` varchar(45) DEFAULT NULL,
  `item_cp` varchar(45) DEFAULT NULL,
  `item_qtyformula` varchar(45) DEFAULT NULL,
  `item_serialno` varchar(45) DEFAULT NULL,
  `item_grade` varchar(45) DEFAULT NULL,
  `item_length` varchar(45) DEFAULT NULL,
  `item_width` varchar(45) DEFAULT NULL,
  `item_thickness` varchar(45) DEFAULT NULL,
  `item_w_l` varchar(45) DEFAULT NULL,
  `item_p_w` varchar(45) DEFAULT NULL,
  `item_upformula` varchar(45) DEFAULT NULL,
  `item_relateditem` varchar(45) DEFAULT NULL,
  `item_qtybf` varchar(45) DEFAULT NULL,
  `item_commissionlevel` varchar(45) DEFAULT NULL,
  `item_creditsales` varchar(45) DEFAULT NULL,
  `item_cashsales` varchar(45) DEFAULT NULL,
  `item_salesreturn` varchar(45) DEFAULT NULL,
  `item_purchase` varchar(45) DEFAULT NULL,
  `item_purchasereturn` varchar(45) DEFAULT NULL,
  `b_add_baddresscode` varchar(45) DEFAULT NULL,
  `b_add_bname` varchar(45) DEFAULT NULL,
  `b_add_baddress` varchar(45) DEFAULT NULL,
  `b_add_battn` varchar(45) DEFAULT NULL,
  `b_add_btel` varchar(45) DEFAULT NULL,
  `b_add_btel2` varchar(45) DEFAULT NULL,
  `b_add_bfax` varchar(45) DEFAULT NULL,
  `b_add_bemail` varchar(45) DEFAULT NULL,
  `b_add_daddresscode` varchar(45) DEFAULT NULL,
  `b_add_dname` varchar(45) DEFAULT NULL,
  `b_add_daddress` varchar(45) DEFAULT NULL,
  `b_add_dattn` varchar(45) DEFAULT NULL,
  `b_add_dtel` varchar(45) DEFAULT NULL,
  `b_add_dfax` varchar(45) DEFAULT NULL,
  `b_add_dcontact` varchar(45) DEFAULT NULL,
  `billtel` varchar(45) DEFAULT 'Y',
  `f_pay_cashc` varchar(45) DEFAULT 'Y',
  `body_service` varchar(45) DEFAULT 'Y',
  `body_titledesp` varchar(45) DEFAULT 'Y',
  `body_nodisplay` varchar(45) DEFAULT 'Y',
  `body_replydate` varchar(45) DEFAULT 'Y',
  `body_deliverydate` varchar(45) DEFAULT 'Y',
  `body_requiredate` varchar(45) DEFAULT 'Y',
  `body_initial` varchar(45) DEFAULT 'Y',
  PRIMARY KEY (`companyid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `displaysetup2`
--

LOCK TABLES `displaysetup2` WRITE;
/*!40000 ALTER TABLE `displaysetup2` DISABLE KEYS */;
INSERT INTO `displaysetup2` VALUES ('IMS','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Y','Y','Y','Y','Y','Y','Y','Y','Y');
/*!40000 ALTER TABLE `displaysetup2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `driver`
--

DROP TABLE IF EXISTS `driver`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `driver` (
  `DRIVERNO` varchar(8) NOT NULL DEFAULT '',
  `NAME` varchar(40) NOT NULL DEFAULT '',
  `NAME2` varchar(40) NOT NULL DEFAULT '',
  `ATTN` varchar(40) NOT NULL DEFAULT '',
  `CUSTOMERNO` varchar(8) NOT NULL DEFAULT '',
  `ADD1` varchar(40) NOT NULL DEFAULT '',
  `ADD2` varchar(40) NOT NULL DEFAULT '',
  `ADD3` varchar(40) NOT NULL DEFAULT '',
  `DEPT` varchar(30) NOT NULL DEFAULT '',
  `CONTACT` varchar(20) NOT NULL DEFAULT '',
  `FAX` varchar(20) NOT NULL DEFAULT '',
  `commission1` double(8,5) NOT NULL DEFAULT '0.00000',
  `PHOTO` varchar(100) DEFAULT '',
  `DADD1` varchar(50) DEFAULT '',
  `DADD2` varchar(50) DEFAULT '',
  `DADD3` varchar(50) DEFAULT '',
  `DADD4` varchar(50) DEFAULT '',
  `DATTN` varchar(50) DEFAULT '',
  `DCONTACT` varchar(50) DEFAULT '',
  `remarks` varchar(200) DEFAULT '',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`DRIVERNO`) USING BTREE,
  KEY `DRIVERINFO` (`DRIVERNO`,`NAME`,`NAME2`,`ATTN`,`CUSTOMERNO`,`ADD1`,`ADD2`,`ADD3`,`DEPT`,`CONTACT`,`FAX`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `driver`
--

LOCK TABLES `driver` WRITE;
/*!40000 ALTER TABLE `driver` DISABLE KEYS */;
/*!40000 ALTER TABLE `driver` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `droplistcountry`
--

DROP TABLE IF EXISTS `droplistcountry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `droplistcountry` (
  `country` varchar(80) NOT NULL,
  PRIMARY KEY (`country`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `droplistcountry`
--

LOCK TABLES `droplistcountry` WRITE;
/*!40000 ALTER TABLE `droplistcountry` DISABLE KEYS */;
INSERT INTO `droplistcountry` VALUES ('AFGHANISTAN'),('ALBANIA'),('ALGERIA'),('AMERICAN SAMOA'),('ANDORRA'),('ANGOLA'),('ANGUILLA'),('ANTARCTICA'),('ANTIGUA AND BARBUDA'),('ARGENTINA'),('ARMENIA'),('ARUBA'),('AUSTRALIA'),('AUSTRIA'),('AZERBAIJAN'),('BAHAMAS'),('BAHRAIN'),('BANGLADESH'),('BARBADOS'),('BELARUS'),('BELGIUM'),('BELIZE'),('BENIN'),('BERMUDA'),('BHUTAN'),('BOLIVIA'),('BOSNIA AND HERZEGOVINA'),('BOTSWANA'),('BOUVET ISLAND'),('BRAZIL'),('BRITISH INDIAN OCEAN TERRITORY'),('BRUNEI DARUSSALAM'),('BULGARIA'),('BURKINA FASO'),('BURUNDI'),('CAMBODIA'),('CAMEROON'),('CANADA'),('CAPE VERDE'),('CAYMAN ISLANDS'),('CENTRAL AFRICAN REPUBLIC'),('CHAD'),('CHILE'),('CHINA'),('CHRISTMAS ISLAND'),('COCOS (KEELING) ISLANDS'),('COLOMBIA'),('COMOROS'),('CONGO'),('CONGO, THE DEMOCRATIC REPUBLIC OF THE'),('COOK ISLANDS'),('COSTA RICA'),('COTE D IVOIRE'),('CROATIA'),('CUBA'),('CYPRUS'),('CZECH REPUBLIC'),('DENMARK'),('DJIBOUTI'),('DOMINICA'),('DOMINICAN REPUBLIC'),('ECUADOR'),('EGYPT'),('EL SALVADOR'),('EQUATORIAL GUINEA'),('ERITREA'),('ESTONIA'),('ETHIOPIA'),('FALKLAND ISLANDS (MALVINAS)'),('FAROE ISLANDS'),('FIJI'),('FINLAND'),('FRANCE'),('FRENCH GUIANA'),('FRENCH POLYNESIA'),('FRENCH SOUTHERN TERRITORIES'),('GABON'),('GAMBIA'),('GEORGIA'),('GERMANY'),('GIBRALTAR'),('GREECE'),('GREENLAND'),('GRENADA'),('GUADELOUPE'),('GUAM'),('GUATEMALA'),('GUINEA'),('GUINEA-BISSAU'),('GUYANA'),('HAITI'),('HEARD ISLAND AND MCDONALD ISLANDS'),('HOLY SEE (VATICAN CITY STATE)'),('HONDURAS'),('HONG KONG'),('HUNGARY'),('ICELAND'),('INDIA'),('INDONESIA'),('IRAN, ISLAMIC REPUBLIC OF'),('IRAQ'),('IRELAND'),('ISRAEL'),('ITALY'),('JAMAICA'),('JAPAN'),('JORDAN'),('KAZAKHSTAN'),('KENYA'),('KIRIBATI'),('KOREA, DEMOCRATIC PEOPLES REPUBLIC OF'),('KOREA, REPUBLIC OF'),('KUWAIT'),('KYRGYZSTAN'),('LAO PEOPLES DEMOCRATIC REPUBLIC'),('LATVIA'),('LEBANON'),('LESOTHO'),('LIBERIA'),('LIBYAN ARAB JAMAHIRIYA'),('LIECHTENSTEIN'),('LITHUANIA'),('LUXEMBOURG'),('MACAO'),('MACEDONIA, THE FORMER YUGOSLAV REPUBLIC OF'),('MADAGASCAR'),('MALAWI'),('MALAYSIA'),('MALDIVES'),('MALI'),('MALTA'),('MARSHALL ISLANDS'),('MARTINIQUE'),('MAURITANIA'),('MAURITIUS'),('MAYOTTE'),('MEXICO'),('MICRONESIA, FEDERATED STATES OF'),('MOLDOVA, REPUBLIC OF'),('MONACO'),('MONGOLIA'),('MONTSERRAT'),('MOROCCO'),('MOZAMBIQUE'),('MYANMAR'),('NAMIBIA'),('NAURU'),('NEPAL'),('NETHERLANDS'),('NETHERLANDS ANTILLES'),('NEW CALEDONIA'),('NEW ZEALAND'),('NICARAGUA'),('NIGER'),('NIGERIA'),('NIUE'),('NORFOLK ISLAND'),('NORTHERN MARIANA ISLANDS'),('NORWAY'),('OMAN'),('PAKISTAN'),('PALAU'),('PALESTINIAN TERRITORY, OCCUPIED'),('PANAMA'),('PAPUA NEW GUINEA'),('PARAGUAY'),('PERU'),('PHILIPPINES'),('PITCAIRN'),('POLAND'),('PORTUGAL'),('PUERTO RICO'),('QATAR'),('REUNION'),('ROMANIA'),('RUSSIAN FEDERATION'),('RWANDA'),('SAINT HELENA'),('SAINT KITTS AND NEVIS'),('SAINT LUCIA'),('SAINT PIERRE AND MIQUELON'),('SAINT VINCENT AND THE GRENADINES'),('SAMOA'),('SAN MARINO'),('SAO TOME AND PRINCIPE'),('SAUDI ARABIA'),('SENEGAL'),('SERBIA AND MONTENEGRO'),('SEYCHELLES'),('SIERRA LEONE'),('SINGAPORE'),('SLOVAKIA'),('SLOVENIA'),('SOLOMON ISLANDS'),('SOMALIA'),('SOUTH AFRICA'),('SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS'),('SPAIN'),('SRI LANKA'),('SUDAN'),('SURINAME'),('SVALBARD AND JAN MAYEN'),('SWAZILAND'),('SWEDEN'),('SWITZERLAND'),('SYRIAN ARAB REPUBLIC'),('TAIWAN, PROVINCE OF CHINA'),('TAJIKISTAN'),('TANZANIA, UNITED REPUBLIC OF'),('THAILAND'),('TIMOR-LESTE'),('TOGO'),('TOKELAU'),('TONGA'),('TRINIDAD AND TOBAGO'),('TUNISIA'),('TURKEY'),('TURKMENISTAN'),('TURKS AND CAICOS ISLANDS'),('TUVALU'),('UGANDA'),('UKRAINE'),('UNITED ARAB EMIRATES'),('UNITED KINGDOM'),('UNITED STATES'),('UNITED STATES MINOR OUTLYING ISLANDS'),('URUGUAY'),('UZBEKISTAN'),('VANUATU'),('VENEZUELA'),('VIET NAM'),('VIRGIN ISLANDS, BRITISH'),('VIRGIN ISLANDS, U.S.'),('WALLIS AND FUTUNA'),('WESTERN SAHARA'),('YEMEN'),('ZAMBIA'),('ZIMBABWE');
/*!40000 ALTER TABLE `droplistcountry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `edited_bossmenu`
--

DROP TABLE IF EXISTS `edited_bossmenu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `edited_bossmenu` (
  `edittype` varchar(100) NOT NULL DEFAULT '',
  `beforeedit` varchar(200) NOT NULL DEFAULT '',
  `afteredit` varchar(200) NOT NULL DEFAULT '',
  `edited_by` varchar(100) NOT NULL DEFAULT '',
  `edited_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `editrefno` varchar(100) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `edited_bossmenu`
--

LOCK TABLES `edited_bossmenu` WRITE;
/*!40000 ALTER TABLE `edited_bossmenu` DISABLE KEYS */;
INSERT INTO `edited_bossmenu` VALUES ('changeitemno','Tokyo Marine ','Tokio Marine','Demoinsurance','2012-01-16 18:01:36',''),('changeitemno','GI','Great Eastern','Demoinsurance','2012-01-16 18:02:23','');
/*!40000 ALTER TABLE `edited_bossmenu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `einvoicelog`
--

DROP TABLE IF EXISTS `einvoicelog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `einvoicelog` (
  `logId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `logDateTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `historylogname` varchar(100) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `submitedby` varchar(45) DEFAULT NULL,
  `InvoiceList` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`logId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `einvoicelog`
--

LOCK TABLES `einvoicelog` WRITE;
/*!40000 ALTER TABLE `einvoicelog` DISABLE KEYS */;
/*!40000 ALTER TABLE `einvoicelog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `extraremark`
--

DROP TABLE IF EXISTS `extraremark`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `extraremark` (
  `COMPANYID` varchar(20) NOT NULL,
  `REM30` varchar(45) NOT NULL,
  `REM31` varchar(45) NOT NULL,
  `REM32` varchar(45) NOT NULL,
  `REM33` varchar(45) NOT NULL,
  `REM34` varchar(45) NOT NULL,
  `REM35` varchar(45) NOT NULL,
  `REM36` varchar(45) NOT NULL,
  `REM37` varchar(45) NOT NULL,
  `REM38` varchar(45) NOT NULL,
  `REM39` varchar(45) NOT NULL,
  `REM40` varchar(45) NOT NULL,
  `REM41` varchar(45) NOT NULL,
  `REM42` varchar(45) NOT NULL,
  `REM43` varchar(45) NOT NULL,
  `REM44` varchar(45) NOT NULL,
  `REM45` varchar(45) NOT NULL,
  `REM46` varchar(45) NOT NULL,
  `REM47` varchar(45) NOT NULL,
  `REM48` varchar(45) NOT NULL,
  `REM49` varchar(45) NOT NULL,
  PRIMARY KEY (`COMPANYID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `extraremark`
--

LOCK TABLES `extraremark` WRITE;
/*!40000 ALTER TABLE `extraremark` DISABLE KEYS */;
INSERT INTO `extraremark` VALUES ('IMS','Header Remark 31','Header Remark 32','Header Remark 33','Header Remark 34','Header Remark 35','Header Remark 36','Header Remark 37','Header Remark 38','Header Remark 39','Header Remark 40','Header Remark 41','Header Remark 41','Header Remark 42','Header Remark 43','Header Remark 44','Header Remark 45','Header Remark 46','Header Remark 47','Header Remark 48','Header Remark 49');
/*!40000 ALTER TABLE `extraremark` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fifoopq`
--

DROP TABLE IF EXISTS `fifoopq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fifoopq` (
  `ITEMNO` varchar(60) NOT NULL DEFAULT '',
  `FFQ11` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ12` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ13` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ14` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ15` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ16` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ17` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ18` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ19` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ20` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ21` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ22` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ23` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ24` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ25` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ26` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ27` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ28` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ29` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ30` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ31` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ32` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ33` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ34` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ35` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ36` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ37` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ38` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ39` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ40` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ41` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ42` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ43` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ44` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ45` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ46` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ47` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ48` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ49` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ50` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFC11` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC12` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC13` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC14` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC15` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC16` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC17` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC18` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC19` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC20` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC21` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC22` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC23` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC24` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC25` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC26` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC27` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC28` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC29` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC30` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC31` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC32` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC33` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC34` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC35` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC36` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC37` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC38` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC39` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC40` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC41` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC42` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC43` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC44` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC45` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC46` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC47` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC48` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC49` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC50` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFD11` date NOT NULL DEFAULT '0000-00-00',
  `FFD12` date NOT NULL DEFAULT '0000-00-00',
  `FFD13` date NOT NULL DEFAULT '0000-00-00',
  `FFD14` date NOT NULL DEFAULT '0000-00-00',
  `FFD15` date NOT NULL DEFAULT '0000-00-00',
  `FFD16` date NOT NULL DEFAULT '0000-00-00',
  `FFD17` date NOT NULL DEFAULT '0000-00-00',
  `FFD18` date NOT NULL DEFAULT '0000-00-00',
  `FFD19` date NOT NULL DEFAULT '0000-00-00',
  `FFD20` date NOT NULL DEFAULT '0000-00-00',
  `FFD21` date NOT NULL DEFAULT '0000-00-00',
  `FFD22` date NOT NULL DEFAULT '0000-00-00',
  `FFD23` date NOT NULL DEFAULT '0000-00-00',
  `FFD24` date NOT NULL DEFAULT '0000-00-00',
  `FFD25` date NOT NULL DEFAULT '0000-00-00',
  `FFD26` date NOT NULL DEFAULT '0000-00-00',
  `FFD27` date NOT NULL DEFAULT '0000-00-00',
  `FFD28` date NOT NULL DEFAULT '0000-00-00',
  `FFD29` date NOT NULL DEFAULT '0000-00-00',
  `FFD30` date NOT NULL DEFAULT '0000-00-00',
  `FFD31` date NOT NULL DEFAULT '0000-00-00',
  `FFD32` date NOT NULL DEFAULT '0000-00-00',
  `FFD33` date NOT NULL DEFAULT '0000-00-00',
  `FFD34` date NOT NULL DEFAULT '0000-00-00',
  `FFD35` date NOT NULL DEFAULT '0000-00-00',
  `FFD36` date NOT NULL DEFAULT '0000-00-00',
  `FFD37` date NOT NULL DEFAULT '0000-00-00',
  `FFD38` date NOT NULL DEFAULT '0000-00-00',
  `FFD39` date NOT NULL DEFAULT '0000-00-00',
  `FFD40` date NOT NULL DEFAULT '0000-00-00',
  `FFD41` date NOT NULL DEFAULT '0000-00-00',
  `FFD42` date NOT NULL DEFAULT '0000-00-00',
  `FFD43` date NOT NULL DEFAULT '0000-00-00',
  `FFD44` date NOT NULL DEFAULT '0000-00-00',
  `FFD45` date NOT NULL DEFAULT '0000-00-00',
  `FFD46` date NOT NULL DEFAULT '0000-00-00',
  `FFD47` date NOT NULL DEFAULT '0000-00-00',
  `FFD48` date NOT NULL DEFAULT '0000-00-00',
  `FFD49` date NOT NULL DEFAULT '0000-00-00',
  `FFD50` date NOT NULL DEFAULT '0000-00-00',
  PRIMARY KEY (`ITEMNO`),
  KEY `FIFO1` (`ITEMNO`,`FFQ11`,`FFQ12`,`FFQ13`,`FFQ14`,`FFQ15`,`FFC11`,`FFC12`,`FFC13`,`FFC14`,`FFC15`,`FFD11`,`FFD12`,`FFD13`,`FFD14`,`FFD15`) USING BTREE,
  KEY `FIFO2` (`ITEMNO`,`FFQ16`,`FFQ17`,`FFQ18`,`FFQ19`,`FFQ20`,`FFC16`,`FFC17`,`FFC18`,`FFC19`,`FFC20`,`FFD16`,`FFD17`,`FFD18`,`FFD19`,`FFD20`) USING BTREE,
  KEY `FIFO3` (`ITEMNO`,`FFQ21`,`FFQ22`,`FFQ23`,`FFQ24`,`FFQ25`,`FFC21`,`FFC22`,`FFC23`,`FFC24`,`FFC25`,`FFD21`,`FFD22`,`FFD23`,`FFD24`,`FFD25`),
  KEY `FIFO4` (`ITEMNO`,`FFQ26`,`FFQ27`,`FFQ28`,`FFQ29`,`FFQ30`,`FFC26`,`FFC27`,`FFC28`,`FFC29`,`FFC30`,`FFD26`,`FFD27`,`FFD28`,`FFD29`,`FFD30`),
  KEY `FIFO5` (`ITEMNO`,`FFQ31`,`FFQ32`,`FFQ33`,`FFQ34`,`FFQ35`,`FFC31`,`FFC32`,`FFC33`,`FFC34`,`FFC35`,`FFD31`,`FFD32`,`FFD33`,`FFD34`,`FFD35`),
  KEY `FIFO6` (`ITEMNO`,`FFQ36`,`FFQ37`,`FFQ38`,`FFQ39`,`FFQ40`,`FFC36`,`FFC37`,`FFC38`,`FFC39`,`FFC40`,`FFD36`,`FFD37`,`FFD38`,`FFD39`,`FFD40`),
  KEY `FIFO7` (`ITEMNO`,`FFQ41`,`FFQ42`,`FFQ43`,`FFQ44`,`FFQ45`,`FFC41`,`FFC42`,`FFC43`,`FFC44`,`FFC45`,`FFD41`,`FFD42`,`FFD43`,`FFD44`,`FFD45`),
  KEY `FIFO8` (`ITEMNO`,`FFQ46`,`FFQ47`,`FFQ48`,`FFQ49`,`FFQ50`,`FFC46`,`FFC47`,`FFC48`,`FFC49`,`FFC50`,`FFD46`,`FFD47`,`FFD48`,`FFD49`,`FFD50`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fifoopq`
--

LOCK TABLES `fifoopq` WRITE;
/*!40000 ALTER TABLE `fifoopq` DISABLE KEYS */;
/*!40000 ALTER TABLE `fifoopq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fifoopq_last_year`
--

DROP TABLE IF EXISTS `fifoopq_last_year`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fifoopq_last_year` (
  `ITEMNO` varchar(60) NOT NULL DEFAULT '',
  `FFQ11` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ12` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ13` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ14` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ15` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ16` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ17` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ18` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ19` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ20` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ21` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ22` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ23` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ24` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ25` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ26` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ27` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ28` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ29` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ30` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ31` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ32` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ33` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ34` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ35` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ36` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ37` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ38` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ39` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ40` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ41` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ42` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ43` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ44` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ45` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ46` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ47` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ48` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ49` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFQ50` double(15,5) NOT NULL DEFAULT '0.00000',
  `FFC11` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC12` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC13` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC14` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC15` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC16` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC17` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC18` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC19` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC20` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC21` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC22` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC23` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC24` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC25` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC26` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC27` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC28` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC29` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC30` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC31` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC32` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC33` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC34` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC35` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC36` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC37` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC38` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC39` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC40` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC41` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC42` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC43` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC44` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC45` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC46` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC47` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC48` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC49` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFC50` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FFD11` date NOT NULL DEFAULT '0000-00-00',
  `FFD12` date NOT NULL DEFAULT '0000-00-00',
  `FFD13` date NOT NULL DEFAULT '0000-00-00',
  `FFD14` date NOT NULL DEFAULT '0000-00-00',
  `FFD15` date NOT NULL DEFAULT '0000-00-00',
  `FFD16` date NOT NULL DEFAULT '0000-00-00',
  `FFD17` date NOT NULL DEFAULT '0000-00-00',
  `FFD18` date NOT NULL DEFAULT '0000-00-00',
  `FFD19` date NOT NULL DEFAULT '0000-00-00',
  `FFD20` date NOT NULL DEFAULT '0000-00-00',
  `FFD21` date NOT NULL DEFAULT '0000-00-00',
  `FFD22` date NOT NULL DEFAULT '0000-00-00',
  `FFD23` date NOT NULL DEFAULT '0000-00-00',
  `FFD24` date NOT NULL DEFAULT '0000-00-00',
  `FFD25` date NOT NULL DEFAULT '0000-00-00',
  `FFD26` date NOT NULL DEFAULT '0000-00-00',
  `FFD27` date NOT NULL DEFAULT '0000-00-00',
  `FFD28` date NOT NULL DEFAULT '0000-00-00',
  `FFD29` date NOT NULL DEFAULT '0000-00-00',
  `FFD30` date NOT NULL DEFAULT '0000-00-00',
  `FFD31` date NOT NULL DEFAULT '0000-00-00',
  `FFD32` date NOT NULL DEFAULT '0000-00-00',
  `FFD33` date NOT NULL DEFAULT '0000-00-00',
  `FFD34` date NOT NULL DEFAULT '0000-00-00',
  `FFD35` date NOT NULL DEFAULT '0000-00-00',
  `FFD36` date NOT NULL DEFAULT '0000-00-00',
  `FFD37` date NOT NULL DEFAULT '0000-00-00',
  `FFD38` date NOT NULL DEFAULT '0000-00-00',
  `FFD39` date NOT NULL DEFAULT '0000-00-00',
  `FFD40` date NOT NULL DEFAULT '0000-00-00',
  `FFD41` date NOT NULL DEFAULT '0000-00-00',
  `FFD42` date NOT NULL DEFAULT '0000-00-00',
  `FFD43` date NOT NULL DEFAULT '0000-00-00',
  `FFD44` date NOT NULL DEFAULT '0000-00-00',
  `FFD45` date NOT NULL DEFAULT '0000-00-00',
  `FFD46` date NOT NULL DEFAULT '0000-00-00',
  `FFD47` date NOT NULL DEFAULT '0000-00-00',
  `FFD48` date NOT NULL DEFAULT '0000-00-00',
  `FFD49` date NOT NULL DEFAULT '0000-00-00',
  `FFD50` date NOT NULL DEFAULT '0000-00-00',
  PRIMARY KEY (`ITEMNO`),
  KEY `FIFO1` (`ITEMNO`,`FFQ11`,`FFQ12`,`FFQ13`,`FFQ14`,`FFQ15`,`FFC11`,`FFC12`,`FFC13`,`FFC14`,`FFC15`,`FFD11`,`FFD12`,`FFD13`,`FFD14`,`FFD15`) USING BTREE,
  KEY `FIFO2` (`ITEMNO`,`FFQ16`,`FFQ17`,`FFQ18`,`FFQ19`,`FFQ20`,`FFC16`,`FFC17`,`FFC18`,`FFC19`,`FFC20`,`FFD16`,`FFD17`,`FFD18`,`FFD19`,`FFD20`) USING BTREE,
  KEY `FIFO3` (`ITEMNO`,`FFQ21`,`FFQ22`,`FFQ23`,`FFQ24`,`FFQ25`,`FFC21`,`FFC22`,`FFC23`,`FFC24`,`FFC25`,`FFD21`,`FFD22`,`FFD23`,`FFD24`,`FFD25`),
  KEY `FIFO4` (`ITEMNO`,`FFQ26`,`FFQ27`,`FFQ28`,`FFQ29`,`FFQ30`,`FFC26`,`FFC27`,`FFC28`,`FFC29`,`FFC30`,`FFD26`,`FFD27`,`FFD28`,`FFD29`,`FFD30`),
  KEY `FIFO5` (`ITEMNO`,`FFQ31`,`FFQ32`,`FFQ33`,`FFQ34`,`FFQ35`,`FFC31`,`FFC32`,`FFC33`,`FFC34`,`FFC35`,`FFD31`,`FFD32`,`FFD33`,`FFD34`,`FFD35`),
  KEY `FIFO6` (`ITEMNO`,`FFQ36`,`FFQ37`,`FFQ38`,`FFQ39`,`FFQ40`,`FFC36`,`FFC37`,`FFC38`,`FFC39`,`FFC40`,`FFD36`,`FFD37`,`FFD38`,`FFD39`,`FFD40`),
  KEY `FIFO7` (`ITEMNO`,`FFQ41`,`FFQ42`,`FFQ43`,`FFQ44`,`FFQ45`,`FFC41`,`FFC42`,`FFC43`,`FFC44`,`FFC45`,`FFD41`,`FFD42`,`FFD43`,`FFD44`,`FFD45`),
  KEY `FIFO8` (`ITEMNO`,`FFQ46`,`FFQ47`,`FFQ48`,`FFQ49`,`FFQ50`,`FFC46`,`FFC47`,`FFC48`,`FFC49`,`FFC50`,`FFD46`,`FFD47`,`FFD48`,`FFD49`,`FFD50`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fifoopq_last_year`
--

LOCK TABLES `fifoopq_last_year` WRITE;
/*!40000 ALTER TABLE `fifoopq_last_year` DISABLE KEYS */;
/*!40000 ALTER TABLE `fifoopq_last_year` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fifotemp`
--

DROP TABLE IF EXISTS `fifotemp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fifotemp` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `lastin` varchar(100) DEFAULT NULL,
  `lastamt` varchar(100) DEFAULT NULL,
  `balance` varchar(100) DEFAULT NULL,
  `useable` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fifotemp`
--

LOCK TABLES `fifotemp` WRITE;
/*!40000 ALTER TABLE `fifotemp` DISABLE KEYS */;
/*!40000 ALTER TABLE `fifotemp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ftpdetail`
--

DROP TABLE IF EXISTS `ftpdetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ftpdetail` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ftphost` varchar(100) DEFAULT '',
  `ftpuser` varchar(100) DEFAULT '',
  `ftppass` varchar(100) DEFAULT '',
  `ftpport` varchar(45) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ftpdetail`
--

LOCK TABLES `ftpdetail` WRITE;
/*!40000 ALTER TABLE `ftpdetail` DISABLE KEYS */;
/*!40000 ALTER TABLE `ftpdetail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ftpschedule`
--

DROP TABLE IF EXISTS `ftpschedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ftpschedule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `importon` varchar(45) DEFAULT 'N',
  `importstart` varchar(45) DEFAULT '',
  `exporton` varchar(45) DEFAULT 'N',
  `exportstart` varchar(45) DEFAULT '',
  `posidid` varchar(45) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ftpschedule`
--

LOCK TABLES `ftpschedule` WRITE;
/*!40000 ALTER TABLE `ftpschedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `ftpschedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `glpost9`
--

DROP TABLE IF EXISTS `glpost9`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `glpost9` (
  `ENTRY` int(8) NOT NULL AUTO_INCREMENT,
  `ACC_CODE` varchar(15) NOT NULL DEFAULT '',
  `ACCNO` varchar(12) NOT NULL DEFAULT '',
  `FPERIOD` int(2) NOT NULL DEFAULT '0',
  `DATE` date NOT NULL DEFAULT '0000-00-00',
  `BATCHNO` varchar(4) NOT NULL DEFAULT '',
  `TRANNO` varchar(8) NOT NULL DEFAULT '',
  `VOUC_SEQ` varchar(4) NOT NULL DEFAULT '',
  `VOUC_SEQ2` varchar(4) NOT NULL DEFAULT '',
  `TTYPE` varchar(2) NOT NULL DEFAULT '',
  `REFERENCE` varchar(50) NOT NULL DEFAULT '',
  `REFNO` varchar(50) NOT NULL DEFAULT '',
  `DESP` varchar(450) NOT NULL DEFAULT '',
  `DESPA` varchar(40) NOT NULL DEFAULT '',
  `DESPB` varchar(40) NOT NULL DEFAULT '',
  `DESPC` varchar(40) NOT NULL DEFAULT '',
  `DESPD` varchar(40) NOT NULL DEFAULT '',
  `DESPE` varchar(40) NOT NULL DEFAULT '',
  `TAXPEC` double(5,2) NOT NULL DEFAULT '0.00',
  `DEBITAMT` double(17,2) NOT NULL DEFAULT '0.00',
  `CREDITAMT` double(17,2) NOT NULL DEFAULT '0.00',
  `FCAMT` double(17,2) NOT NULL DEFAULT '0.00',
  `DEBIT_FC` double(17,2) NOT NULL DEFAULT '0.00',
  `CREDIT_FC` double(17,2) NOT NULL DEFAULT '0.00',
  `EXC_RATE` double(16,10) NOT NULL DEFAULT '0.0000000000',
  `ARAPTYPE` char(1) NOT NULL DEFAULT '',
  `AGE` int(2) NOT NULL DEFAULT '0',
  `SOURCE` varchar(50) NOT NULL DEFAULT '',
  `JOB` varchar(50) NOT NULL DEFAULT '',
  `SUBJOB` varchar(4) NOT NULL DEFAULT '',
  `POSTED` char(1) NOT NULL DEFAULT '',
  `EXPORTED` char(1) NOT NULL DEFAULT '',
  `EXPORTED1` char(1) NOT NULL DEFAULT '',
  `EXPORTED2` char(1) NOT NULL DEFAULT '',
  `EXPORTED3` char(1) NOT NULL DEFAULT '',
  `REM1` varchar(35) NOT NULL DEFAULT '',
  `REM2` varchar(35) NOT NULL DEFAULT '',
  `REM3` varchar(35) NOT NULL DEFAULT '',
  `REM4` varchar(35) NOT NULL DEFAULT '',
  `REM5` varchar(450) NOT NULL DEFAULT '',
  `RPT_ROW` int(4) NOT NULL DEFAULT '0',
  `AGENT` varchar(12) NOT NULL DEFAULT '',
  `STRAN` varchar(8) NOT NULL DEFAULT '',
  `TAXPUR` double(17,2) NOT NULL DEFAULT '0.00',
  `PAYMODE` varchar(4) NOT NULL DEFAULT '',
  `TRDATETIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `CORR_ACC` varchar(12) NOT NULL DEFAULT '',
  `ACCNO2` varchar(12) NOT NULL DEFAULT '',
  `ACCNO3` varchar(12) NOT NULL DEFAULT '',
  `DATE2` date NOT NULL DEFAULT '0000-00-00',
  `USERID` varchar(50) NOT NULL DEFAULT '',
  `TCURRCODE` varchar(10) NOT NULL DEFAULT '',
  `TCURRAMT` double(19,2) NOT NULL DEFAULT '0.00',
  `BPERIOD` int(2) NOT NULL DEFAULT '0',
  `BDATE` date NOT NULL DEFAULT '0000-00-00',
  `VPERIOD` int(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ENTRY`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `glpost9`
--

LOCK TABLES `glpost9` WRITE;
/*!40000 ALTER TABLE `glpost9` DISABLE KEYS */;
/*!40000 ALTER TABLE `glpost9` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `glpost91`
--

DROP TABLE IF EXISTS `glpost91`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `glpost91` (
  `ENTRY` int(8) unsigned NOT NULL AUTO_INCREMENT,
  `ACC_CODE` varchar(15) NOT NULL DEFAULT '',
  `ACCNO` varchar(12) NOT NULL DEFAULT '',
  `FPERIOD` int(2) NOT NULL DEFAULT '0',
  `DATE` date NOT NULL DEFAULT '0000-00-00',
  `BATCHNO` varchar(4) NOT NULL DEFAULT '',
  `TRANNO` varchar(8) NOT NULL DEFAULT '',
  `VOUC_SEQ` varchar(4) NOT NULL DEFAULT '',
  `VOUC_SEQ2` varchar(4) NOT NULL DEFAULT '',
  `TTYPE` varchar(2) NOT NULL DEFAULT '',
  `REFERENCE` varchar(50) NOT NULL DEFAULT '',
  `REFNO` varchar(50) NOT NULL DEFAULT '',
  `DESP` varchar(450) NOT NULL DEFAULT '',
  `DESPA` varchar(40) NOT NULL DEFAULT '',
  `DESPB` varchar(40) NOT NULL DEFAULT '',
  `DESPC` varchar(40) NOT NULL DEFAULT '',
  `DESPD` varchar(40) NOT NULL DEFAULT '',
  `DESPE` varchar(40) NOT NULL DEFAULT '',
  `TAXPEC` double(5,2) NOT NULL DEFAULT '0.00',
  `DEBITAMT` double(17,2) NOT NULL DEFAULT '0.00',
  `CREDITAMT` double(17,2) NOT NULL DEFAULT '0.00',
  `FCAMT` double(17,2) NOT NULL DEFAULT '0.00',
  `DEBIT_FC` double(17,2) NOT NULL DEFAULT '0.00',
  `CREDIT_FC` double(17,2) NOT NULL DEFAULT '0.00',
  `EXC_RATE` double(16,10) NOT NULL DEFAULT '0.0000000000',
  `ARAPTYPE` char(1) NOT NULL DEFAULT '',
  `AGE` int(2) NOT NULL DEFAULT '0',
  `SOURCE` varchar(50) NOT NULL DEFAULT '',
  `JOB` varchar(50) NOT NULL DEFAULT '',
  `JOB2` varchar(4) NOT NULL DEFAULT '',
  `SUBJOB` varchar(4) NOT NULL DEFAULT '',
  `JOB_VALUE` double(19,2) NOT NULL DEFAULT '0.00',
  `JOB_VALUE2` double(19,2) NOT NULL DEFAULT '0.00',
  `POSTED` char(1) NOT NULL DEFAULT '',
  `EXPORTED` char(1) NOT NULL DEFAULT '',
  `EXPORTED1` char(1) NOT NULL DEFAULT '',
  `EXPORTED2` char(1) NOT NULL DEFAULT '',
  `EXPORTED3` char(1) NOT NULL DEFAULT '',
  `REM1` varchar(35) NOT NULL DEFAULT '',
  `REM2` varchar(35) NOT NULL DEFAULT '',
  `REM3` varchar(35) NOT NULL DEFAULT '',
  `REM4` varchar(35) NOT NULL DEFAULT '',
  `REM5` varchar(450) NOT NULL DEFAULT '',
  `RPT_ROW` int(4) NOT NULL DEFAULT '0',
  `AGENT` varchar(12) NOT NULL DEFAULT '',
  `STRAN` varchar(8) NOT NULL DEFAULT '',
  `TAXPUR` double(17,2) NOT NULL DEFAULT '0.00',
  `PAYMODE` varchar(4) NOT NULL DEFAULT '',
  `TRDATETIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `CORR_ACC` varchar(12) NOT NULL DEFAULT '',
  `ACCNO2` varchar(12) NOT NULL DEFAULT '',
  `ACCNO3` varchar(12) NOT NULL DEFAULT '',
  `DATE2` date NOT NULL DEFAULT '0000-00-00',
  `USERID` varchar(50) NOT NULL DEFAULT '',
  `TCURRCODE` varchar(10) NOT NULL DEFAULT '',
  `TCURRAMT` double(19,2) NOT NULL DEFAULT '0.00',
  `BPERIOD` int(2) NOT NULL DEFAULT '0',
  `BDATE` date NOT NULL DEFAULT '0000-00-00',
  `VPERIOD` int(2) NOT NULL DEFAULT '0',
  `PROCESSED` char(1) DEFAULT '',
  PRIMARY KEY (`ENTRY`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `glpost91`
--

LOCK TABLES `glpost91` WRITE;
/*!40000 ALTER TABLE `glpost91` DISABLE KEYS */;
/*!40000 ALTER TABLE `glpost91` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gsetup`
--

DROP TABLE IF EXISTS `gsetup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gsetup` (
  `COMPANYID` varchar(20) NOT NULL DEFAULT '',
  `CTYCODE` varchar(10) NOT NULL DEFAULT '',
  `LASTACCYEAR` date NOT NULL DEFAULT '0000-00-00',
  `PERIOD` int(2) NOT NULL DEFAULT '0',
  `DEBTORFR` varchar(4) NOT NULL DEFAULT '',
  `DEBTORTO` varchar(4) NOT NULL DEFAULT '',
  `CREDITORFR` varchar(4) NOT NULL DEFAULT '',
  `CREDITORTO` varchar(4) NOT NULL DEFAULT '',
  `INVCODE` varchar(5) NOT NULL DEFAULT '',
  `INVNO` varchar(10) NOT NULL DEFAULT '',
  `INVNO2` varchar(5) NOT NULL DEFAULT '',
  `INVCODE_2` varchar(5) NOT NULL DEFAULT '',
  `INVNO_2` varchar(10) NOT NULL DEFAULT '',
  `INVNO2_2` varchar(5) NOT NULL DEFAULT '',
  `INVCODE_3` varchar(5) NOT NULL DEFAULT '',
  `INVNO_3` varchar(10) NOT NULL DEFAULT '',
  `INVNO2_3` varchar(5) NOT NULL DEFAULT '',
  `INVCODE_4` varchar(5) NOT NULL DEFAULT '',
  `INVNO_4` varchar(15) NOT NULL DEFAULT '',
  `INVNO2_4` varchar(5) NOT NULL DEFAULT '',
  `INVCODE_5` varchar(5) NOT NULL DEFAULT '',
  `INVNO_5` varchar(15) NOT NULL DEFAULT '',
  `INVNO2_5` varchar(5) NOT NULL DEFAULT '',
  `INVCODE_6` varchar(5) NOT NULL DEFAULT '',
  `INVNO_6` varchar(15) NOT NULL DEFAULT '',
  `INVNO2_6` varchar(5) NOT NULL DEFAULT '',
  `CNCODE` varchar(5) NOT NULL DEFAULT '',
  `CNNO` varchar(10) NOT NULL DEFAULT '',
  `CNNO2` varchar(5) NOT NULL DEFAULT '',
  `DNCODE` varchar(5) NOT NULL DEFAULT '',
  `DNNO` varchar(10) NOT NULL DEFAULT '',
  `DNNO2` varchar(5) NOT NULL DEFAULT '',
  `DOCODE` varchar(5) NOT NULL DEFAULT '',
  `DONO` varchar(10) NOT NULL DEFAULT '',
  `DONO2` varchar(5) NOT NULL DEFAULT '',
  `RCCODE` varchar(5) NOT NULL DEFAULT '',
  `RCNO` varchar(15) NOT NULL DEFAULT '',
  `RCNO2` varchar(5) NOT NULL DEFAULT '',
  `PRCODE` varchar(5) NOT NULL DEFAULT '',
  `PRNO` varchar(10) NOT NULL DEFAULT '',
  `PRNO2` varchar(5) NOT NULL DEFAULT '',
  `PONO` varchar(24) NOT NULL DEFAULT '',
  `PONO2` varchar(5) NOT NULL DEFAULT '',
  `POCODE` varchar(5) NOT NULL DEFAULT '',
  `SONO` varchar(24) NOT NULL DEFAULT '',
  `SONO2` varchar(5) NOT NULL DEFAULT '',
  `SOCODE` varchar(5) NOT NULL DEFAULT '',
  `QUONO` varchar(24) NOT NULL DEFAULT '',
  `QUONO2` varchar(5) NOT NULL DEFAULT '',
  `QUOCODE` varchar(5) NOT NULL DEFAULT '',
  `CSNO` varchar(15) NOT NULL DEFAULT '',
  `CSNO2` varchar(5) NOT NULL DEFAULT '',
  `CSCODE` varchar(5) NOT NULL DEFAULT '',
  `ASSMNO` varchar(15) NOT NULL DEFAULT '',
  `ASSMNO2` varchar(5) NOT NULL DEFAULT '',
  `ASSMCODE` varchar(5) NOT NULL DEFAULT '',
  `ISSNO` varchar(15) NOT NULL DEFAULT '',
  `ISSNO2` varchar(5) NOT NULL DEFAULT '',
  `ISSCODE` varchar(5) NOT NULL DEFAULT '',
  `TRNO` varchar(15) NOT NULL DEFAULT '',
  `TRNO2` varchar(5) NOT NULL DEFAULT '',
  `TRCODE` varchar(5) NOT NULL DEFAULT '',
  `OAINO` varchar(15) NOT NULL DEFAULT '',
  `OAINO2` varchar(5) NOT NULL DEFAULT '',
  `OAICODE` varchar(5) NOT NULL DEFAULT '',
  `OARNO` varchar(15) NOT NULL DEFAULT '',
  `OARNO2` varchar(5) NOT NULL DEFAULT '',
  `OARCODE` varchar(5) NOT NULL DEFAULT '',
  `SAMNO` varchar(15) NOT NULL DEFAULT '',
  `SAMNO2` varchar(5) NOT NULL DEFAULT '',
  `SAMCODE` varchar(5) NOT NULL DEFAULT '',
  `INVARUN` char(1) NOT NULL DEFAULT '',
  `INVARUN_2` char(1) NOT NULL DEFAULT '',
  `INVARUN_3` char(1) NOT NULL DEFAULT '',
  `INVARUN_4` char(1) NOT NULL DEFAULT '',
  `INVARUN_5` char(1) NOT NULL DEFAULT '',
  `INVARUN_6` char(1) NOT NULL DEFAULT '',
  `CSARUN` char(1) NOT NULL DEFAULT '',
  `CNARUN` char(1) NOT NULL DEFAULT '',
  `DNARUN` char(1) NOT NULL DEFAULT '',
  `DOARUN` char(1) NOT NULL DEFAULT '',
  `RCARUN` char(1) NOT NULL DEFAULT '',
  `PRARUN` char(1) NOT NULL DEFAULT '',
  `POARUN` char(1) NOT NULL DEFAULT '',
  `SOARUN` char(1) NOT NULL DEFAULT '',
  `QUOARUN` char(1) NOT NULL DEFAULT '',
  `ASSMARUN` char(1) NOT NULL DEFAULT '',
  `ISSARUN` char(1) NOT NULL DEFAULT '',
  `TRARUN` char(1) NOT NULL DEFAULT '',
  `OAIARUN` char(1) NOT NULL DEFAULT '',
  `OARARUN` char(1) NOT NULL DEFAULT '',
  `SAMARUN` char(1) NOT NULL DEFAULT '',
  `CREDITSALES` varchar(8) NOT NULL DEFAULT '',
  `CASHSALES` varchar(8) NOT NULL DEFAULT '',
  `PURCHASERECEIVE` varchar(8) NOT NULL DEFAULT '',
  `PURCHASERETURN` varchar(8) NOT NULL DEFAULT '',
  `SALESRETURN` varchar(8) NOT NULL DEFAULT '',
  `CASHACCOUNT` varchar(8) NOT NULL DEFAULT '',
  `GSTPURCHASE` varchar(8) NOT NULL DEFAULT '',
  `GSTSALES` varchar(8) NOT NULL DEFAULT '',
  `DISCSALES` varchar(8) NOT NULL DEFAULT '',
  `DISCPUR` varchar(8) NOT NULL DEFAULT '',
  `INVONESET` char(1) NOT NULL DEFAULT '',
  `DELINVOICE` char(1) NOT NULL DEFAULT '',
  `INVSECURE` char(1) NOT NULL DEFAULT '',
  `COST` varchar(15) NOT NULL DEFAULT '',
  `GPRICEMIN` char(1) NOT NULL DEFAULT '',
  `PRICEMINCTRL` char(1) NOT NULL DEFAULT '',
  `PRICEMINPASS` varchar(10) NOT NULL DEFAULT '',
  `PRINTOPTION` char(1) NOT NULL DEFAULT '',
  `SHIPVIA` char(1) NOT NULL DEFAULT '',
  `POSTVALUE` varchar(15) NOT NULL DEFAULT '',
  `COMPRO` varchar(80) NOT NULL DEFAULT '',
  `COMPRO2` varchar(80) NOT NULL DEFAULT '',
  `COMPRO3` varchar(80) NOT NULL DEFAULT '',
  `COMPRO4` varchar(80) NOT NULL DEFAULT '',
  `COMPRO5` varchar(80) NOT NULL DEFAULT '',
  `COMPRO6` varchar(80) NOT NULL DEFAULT '',
  `COMPRO7` varchar(80) NOT NULL DEFAULT '',
  `comuen` varchar(45) NOT NULL DEFAULT '',
  `gstno` varchar(45) NOT NULL DEFAULT '',
  `invoiceDataFile` varchar(45) DEFAULT NULL,
  `externalthirdparty` varchar(45) DEFAULT NULL,
  `iaft` varchar(100) DEFAULT NULL,
  `lCATEGORY` varchar(30) NOT NULL DEFAULT '',
  `lGROUP` varchar(30) NOT NULL DEFAULT '',
  `lSIZE` varchar(30) NOT NULL DEFAULT '',
  `lMATERIAL` varchar(30) NOT NULL DEFAULT '',
  `lMODEL` varchar(30) NOT NULL DEFAULT '',
  `lRATING` varchar(30) NOT NULL DEFAULT '',
  `lAGENT` varchar(45) NOT NULL DEFAULT '',
  `lTEAM` varchar(30) NOT NULL DEFAULT '',
  `serialno` varchar(45) NOT NULL DEFAULT '',
  `serialnorun` varchar(45) NOT NULL DEFAULT '',
  `printapproveamt` varchar(45) NOT NULL DEFAULT '0',
  `asvoucher` varchar(45) DEFAULT 'N',
  `suppno` varchar(45) DEFAULT '1',
  `lDRIVER` varchar(45) NOT NULL DEFAULT '',
  `lLOCATION` varchar(45) NOT NULL DEFAULT '',
  `lPROJECT` varchar(45) NOT NULL,
  `lJOB` varchar(45) NOT NULL,
  `lRC` varchar(100) NOT NULL DEFAULT 'Purchase Receive',
  `lPR` varchar(100) NOT NULL DEFAULT 'Purchase Return',
  `lDO` varchar(100) NOT NULL DEFAULT 'Delivery Order',
  `lINV` varchar(100) NOT NULL DEFAULT 'Invoice',
  `lCS` varchar(100) NOT NULL DEFAULT 'Cash Sales',
  `lCN` varchar(100) NOT NULL DEFAULT 'Credit Note',
  `lDN` varchar(100) NOT NULL DEFAULT 'Debit Note',
  `lPO` varchar(100) NOT NULL DEFAULT 'Purchase Order',
  `lRQ` varchar(100) DEFAULT 'Purchase requisition',
  `lQUO` varchar(100) NOT NULL DEFAULT 'Quotation',
  `lSO` varchar(100) NOT NULL DEFAULT 'Sales Order',
  `lSAM` varchar(100) NOT NULL DEFAULT 'Sample',
  `lconsignin` varchar(100) DEFAULT 'Consignment Return',
  `lconsignout` varchar(100) DEFAULT 'Consignment Out',
  `lBATCH` varchar(100) NOT NULL DEFAULT 'Batch',
  `taxfollowitemprofile` varchar(45) NOT NULL DEFAULT 'N',
  `po_to_rc_currrate` varchar(45) NOT NULL DEFAULT 'N',
  `itemdiscmethod` varchar(45) NOT NULL DEFAULT 'byamt',
  `NEGSTK` char(1) NOT NULL DEFAULT '',
  `proavailqty` varchar(100) DEFAULT '0',
  `REM0` varchar(30) NOT NULL DEFAULT '',
  `REM1` varchar(30) NOT NULL DEFAULT '',
  `REM2` varchar(30) NOT NULL DEFAULT '',
  `REM3` varchar(30) NOT NULL DEFAULT '',
  `REM4` varchar(30) NOT NULL DEFAULT '',
  `REM5` varchar(30) NOT NULL DEFAULT '',
  `REM6` varchar(30) NOT NULL DEFAULT '',
  `REM7` varchar(30) NOT NULL DEFAULT '',
  `REM8` varchar(30) NOT NULL DEFAULT '',
  `REM9` varchar(30) NOT NULL DEFAULT '',
  `REM10` varchar(30) NOT NULL DEFAULT '',
  `REM11` varchar(30) NOT NULL DEFAULT '',
  `dflanguage` varchar(45) DEFAULT 'english',
  `refno2` varchar(100) NOT NULL DEFAULT 'Ref No 2',
  `REM12` varchar(30) NOT NULL DEFAULT '',
  `BREM1` varchar(30) NOT NULL DEFAULT '',
  `BREM2` varchar(30) NOT NULL DEFAULT '',
  `BREM3` varchar(30) NOT NULL DEFAULT '',
  `BREM4` varchar(30) NOT NULL DEFAULT '',
  `GST` varchar(2) NOT NULL DEFAULT '',
  `df_salestax` varchar(30) DEFAULT NULL,
  `df_salestaxzero` varchar(45) NOT NULL DEFAULT 'ZR',
  `df_purchasetaxzero` varchar(45) NOT NULL DEFAULT 'ZP',
  `df_purchasetax` varchar(30) DEFAULT NULL,
  `FILTERITEM` char(1) NOT NULL DEFAULT '',
  `filteritemreport` varchar(45) DEFAULT '0',
  `limitlocation` varchar(45) NOT NULL DEFAULT 'N',
  `prefixbycustquo` varchar(45) NOT NULL DEFAULT 'N',
  `prefixbycustso` varchar(45) NOT NULL DEFAULT 'N',
  `prefixbycustinv` varchar(45) NOT NULL DEFAULT 'N',
  `filteritemAJAX` varchar(45) DEFAULT '0',
  `texteditor` char(1) DEFAULT '0',
  `suppcustdropdown` char(1) DEFAULT NULL,
  `BCURR` varchar(10) NOT NULL DEFAULT '',
  `CUSTMISC1` varchar(8) NOT NULL DEFAULT '',
  `CUSTMISC2` varchar(8) NOT NULL DEFAULT '',
  `CUSTMISC3` varchar(8) NOT NULL DEFAULT '',
  `CUSTMISC4` varchar(8) NOT NULL DEFAULT '',
  `CUSTMISC5` varchar(8) NOT NULL DEFAULT '',
  `CUSTMISC6` varchar(8) NOT NULL DEFAULT '',
  `CUSTMISC7` varchar(8) NOT NULL DEFAULT '',
  `SUPPMISC1` varchar(8) NOT NULL DEFAULT '',
  `SUPPMISC2` varchar(8) NOT NULL DEFAULT '',
  `SUPPMISC3` varchar(8) NOT NULL DEFAULT '',
  `SUPPMISC4` varchar(8) NOT NULL DEFAULT '',
  `SUPPMISC5` varchar(8) NOT NULL DEFAULT '',
  `SUPPMISC6` varchar(8) NOT NULL DEFAULT '',
  `SUPPMISC7` varchar(8) NOT NULL DEFAULT '',
  `CHEQUEACCOUNT` varchar(8) NOT NULL DEFAULT '',
  `CREDITCARDACCOUNT1` varchar(8) NOT NULL DEFAULT '',
  `CREDITCARDACCOUNT2` varchar(8) NOT NULL DEFAULT '',
  `debitcardaccount` varchar(8) NOT NULL DEFAULT '',
  `CASHVOUCHERACCOUNT` varchar(8) NOT NULL DEFAULT '',
  `DEPOSITACCOUNT` varchar(8) NOT NULL DEFAULT '',
  `WITHHOLDINGTAXACCOUNT` varchar(8) NOT NULL DEFAULT '',
  `MENUTYPE` char(1) NOT NULL DEFAULT 'v',
  `rc_oneset` char(1) NOT NULL DEFAULT '1',
  `pr_oneset` char(1) NOT NULL DEFAULT '1',
  `do_oneset` char(1) NOT NULL DEFAULT '1',
  `cs_oneset` char(1) NOT NULL DEFAULT '1',
  `cn_oneset` char(1) NOT NULL DEFAULT '1',
  `dn_oneset` char(1) NOT NULL DEFAULT '1',
  `iss_oneset` char(1) NOT NULL DEFAULT '1',
  `po_oneset` char(1) NOT NULL DEFAULT '1',
  `so_oneset` char(1) NOT NULL DEFAULT '1',
  `quo_oneset` char(1) NOT NULL DEFAULT '1',
  `assm_oneset` char(1) NOT NULL DEFAULT '1',
  `tr_oneset` char(1) NOT NULL DEFAULT '1',
  `oai_oneset` char(1) NOT NULL DEFAULT '1',
  `oar_oneset` char(1) NOT NULL DEFAULT '1',
  `sam_oneset` char(1) NOT NULL DEFAULT '1',
  `filterall` char(1) DEFAULT '0',
  `multilocation` text,
  `PERIODALFR` varchar(2) NOT NULL DEFAULT '01',
  `xqty1` varchar(60) DEFAULT NULL,
  `xqty2` varchar(60) DEFAULT NULL,
  `xqty3` varchar(60) DEFAULT NULL,
  `xqty4` varchar(60) DEFAULT NULL,
  `xqty5` varchar(60) DEFAULT NULL,
  `xqty6` varchar(60) DEFAULT NULL,
  `xqty7` varchar(60) DEFAULT NULL,
  `qtyformula` varchar(100) DEFAULT NULL,
  `priceformula` varchar(100) DEFAULT NULL,
  `wpitemtax` char(1) NOT NULL DEFAULT '',
  `EAPT` varchar(45) NOT NULL DEFAULT '1',
  `wpitemtax1` text NOT NULL,
  `editamount` char(1) NOT NULL DEFAULT '',
  `defaultenduser` varchar(45) DEFAULT NULL,
  `quoChooseItem` varchar(45) DEFAULT NULL,
  `custSuppNo` varchar(45) DEFAULT '1',
  `auom` varchar(45) DEFAULT '1',
  `projectbybill` char(1) NOT NULL DEFAULT '1',
  `keepDeletedBills` char(1) NOT NULL DEFAULT '',
  `EDControl` varchar(45) NOT NULL DEFAULT 'N',
  `appDisSupCus` varchar(45) DEFAULT 'N',
  `custsupp_limit_display` int(4) NOT NULL DEFAULT '5',
  `PPTS` varchar(45) DEFAULT 'N',
  `ASACTP` varchar(45) DEFAULT 'Y',
  `ASDA` varchar(45) NOT NULL DEFAULT 'Y',
  `APCWP` varchar(45) DEFAULT 'N',
  `PACAA` varchar(45) DEFAULT 'N',
  `PRF` varchar(45) DEFAULT 'creditor',
  `prozero` varchar(45) DEFAULT '0',
  `voucher` varchar(45) DEFAULT 'N',
  `ddlcust` varchar(45) DEFAULT NULL,
  `ddlsupp` varchar(45) NOT NULL DEFAULT '',
  `ddltran` varchar(45) NOT NULL DEFAULT '',
  `ddlbilltype` varchar(45) NOT NULL DEFAULT 'INV',
  `expressdisc` varchar(45) DEFAULT '1',
  `costformula1` varchar(10) NOT NULL DEFAULT '',
  `costformula2` varchar(1) NOT NULL DEFAULT '',
  `costformula3` varchar(10) NOT NULL DEFAULT '',
  `displaycostcode` varchar(45) NOT NULL DEFAULT 'N',
  `updatetopo` varchar(45) NOT NULL DEFAULT 'N',
  `autobom` varchar(45) NOT NULL DEFAULT 'N',
  `singlelocation` varchar(45) NOT NULL DEFAULT 'N',
  `allowedityearend` varchar(45) DEFAULT 'Y',
  `ddlitem` varchar(45) DEFAULT NULL,
  `commenttext` varchar(45) NOT NULL DEFAULT 'N',
  `commentlimit` varchar(45) NOT NULL DEFAULT '20',
  `desplimit` varchar(45) DEFAULT '60',
  `ddllocation` varchar(45) DEFAULT NULL,
  `ddlagent` varchar(45) DEFAULT NULL,
  `countryddl` varchar(45) DEFAULT 'N',
  `refnoNACC` varchar(45) DEFAULT '24',
  `refnoACC` varchar(45) DEFAULT '20',
  `refno2SAM` varchar(45) DEFAULT '0',
  `refno2inv` varchar(45) DEFAULT '0',
  `refno2SO` varchar(45) DEFAULT '0',
  `refno2PR` varchar(45) DEFAULT '0',
  `refno2RC` varchar(45) DEFAULT '0',
  `refno2DO` varchar(45) DEFAULT '0',
  `refno2CS` varchar(45) DEFAULT '0',
  `refno2CN` varchar(45) DEFAULT '0',
  `refno2DN` varchar(45) DEFAULT '0',
  `refno2PO` varchar(45) DEFAULT '0',
  `refno2QUO` varchar(45) DEFAULT '0',
  `multiagent` varchar(45) DEFAULT 'N',
  `fcurrency` varchar(45) DEFAULT 'N',
  `addonremark` varchar(45) DEFAULT 'N',
  `lastlogin` date NOT NULL DEFAULT '0000-00-00',
  `agentuserid` varchar(45) NOT NULL DEFAULT 'N',
  `agentlistuserid` varchar(45) DEFAULT 'N',
  `prodisprice` varchar(45) DEFAULT 'Y',
  `taxincluded` varchar(45) NOT NULL DEFAULT 'N',
  `postcsdebtor` varchar(45) NOT NULL DEFAULT 'N',
  `postdepdebtor` varchar(45) DEFAULT 'N',
  `jobbyitem` varchar(45) NOT NULL DEFAULT 'N',
  `ECAOTA` varchar(45) DEFAULT 'Y',
  `ECAMTOTA` varchar(45) DEFAULT 'Y',
  `deductso` varchar(45) DEFAULT 'N',
  `AECE` varchar(45) DEFAULT 'N',
  `advancebom` varchar(45) DEFAULT 'N',
  `PCBLTC` varchar(45) DEFAULT 'N',
  `enableedit` varchar(45) NOT NULL DEFAULT 'N',
  `custnamelength` varchar(45) NOT NULL DEFAULT 'N',
  `custissue` varchar(45) DEFAULT 'N',
  `chooselocation` varchar(45) DEFAULT 'N',
  `quobatch` varchar(45) DEFAULT 'N',
  `generateQuoRevision` char(1) NOT NULL DEFAULT '',
  `generateQuoRevision1` varchar(100) NOT NULL DEFAULT '',
  `revStyle` char(5) NOT NULL DEFAULT 'R',
  `disablefoc` varchar(45) DEFAULT 'N',
  `printapprove` varchar(45) NOT NULL DEFAULT 'N',
  `autonextdate` int(10) unsigned NOT NULL DEFAULT '24',
  `attnddl` varchar(45) NOT NULL DEFAULT 'N',
  `agentbycust` varchar(45) NOT NULL DEFAULT 'N',
  `disablevoid` varchar(45) NOT NULL DEFAULT 'N',
  `followlocation` varchar(45) NOT NULL DEFAULT 'N',
  `ngstcustdisabletax` varchar(45) NOT NULL DEFAULT '',
  `postingRCRefno` varchar(45) DEFAULT 'N',
  `ngstcustautotax` varchar(45) NOT NULL DEFAULT '',
  `transactiondate` varchar(45) NOT NULL DEFAULT 'N',
  `tranuserid` varchar(45) DEFAULT 'N',
  `voucherbal` varchar(45) DEFAULT 'N',
  `itempriceprior` varchar(45) DEFAULT '1',
  `remainloc` varchar(45) DEFAULT 'N',
  `enabledetectrem1` varchar(45) NOT NULL DEFAULT 'N',
  `fifocal` varchar(45) DEFAULT '1',
  `CNbaseonprice` varchar(45) DEFAULT 'N',
  `showservicepart` varchar(45) DEFAULT 'Y',
  `poapproval` varchar(45) DEFAULT 'N',
  `crcdtype` varchar(45) DEFAULT 'N',
  `dfcustcode` varchar(45) DEFAULT '',
  `dfsuppcode` varchar(45) DEFAULT '',
  `termscondition` varchar(45) DEFAULT 'N',
  `df_qty` varchar(45) DEFAULT '0',
  `lISS` varchar(45) DEFAULT 'Issue',
  `lOAI` varchar(45) DEFAULT 'Adjustment Increase',
  `lOAR` varchar(45) DEFAULT 'Adjustment Reduce',
  `df_trprice` varchar(45) DEFAULT 'cost',
  `disclimit` varchar(45) DEFAULT '100',
  `projectcompany` varchar(45) DEFAULT '',
  `voucherb4disc` varchar(45) DEFAULT 'N',
  `histpriceinv` varchar(45) DEFAULT 'N',
  `soautocreaproj` varchar(45) DEFAULT 'N',
  `locationwithqty` varchar(45) DEFAULT 'N',
  `misccharge1` varchar(100) DEFAULT 'Misc. Charges (1)',
  `misccharge2` varchar(100) DEFAULT 'Misc. Charges (2)',
  `misccharge3` varchar(100) DEFAULT 'Misc. Charges (3)',
  `misccharge4` varchar(100) DEFAULT 'Misc. Charges (4)',
  `misccharge5` varchar(100) DEFAULT 'Misc. Charges (5)',
  `misccharge6` varchar(100) DEFAULT 'Misc. Charges (6)',
  `misccharge7` varchar(100) DEFAULT 'Misc. Charges (7)',
  `df_cs_cust` varchar(45) DEFAULT '',
  `dfpos` varchar(45) DEFAULT '',
  `autooutstandingreport` varchar(45) DEFAULT 'N',
  `displaysetup` varchar(45) DEFAULT '',
  `mitemdiscountbyitem` varchar(45) DEFAULT 'N',
  `lightloc` varchar(45) DEFAULT 'N',
  `voucherasdisc` varchar(45) DEFAULT 'N',
  `simpleinvtype` varchar(45) DEFAULT '1',
  `footerexchange` varchar(45) DEFAULT 'N',
  `collectaddress` varchar(45) DEFAULT 'N',
  `reportagentfromcust` varchar(45) DEFAULT 'N',
  `capall` varchar(45) DEFAULT 'N',
  `rqarun` varchar(45) DEFAULT '',
  `rqno` varchar(45) DEFAULT '',
  `refno2rq` varchar(45) DEFAULT '',
  `rq_oneset` char(1) DEFAULT '1',
  `litemno` varchar(150) DEFAULT 'Item No',
  `laitemno` varchar(150) DEFAULT 'Product Code',
  PRIMARY KEY (`COMPANYID`) USING BTREE,
  KEY `TRANCHECK1` (`LASTACCYEAR`,`PERIOD`,`INVNO`,`CNNO`,`DNNO`,`DONO`,`RCNO`,`PRNO`,`PONO`,`SONO`) USING BTREE,
  KEY `TRANCHECK2` (`LASTACCYEAR`,`PERIOD`,`QUONO`,`CSNO`,`ASSMNO`,`ISSNO`,`TRNO`,`OAINO`,`OARNO`,`SAMNO`) USING BTREE,
  KEY `POSTING` (`CREDITSALES`,`CASHSALES`,`PURCHASERECEIVE`,`PURCHASERETURN`,`SALESRETURN`,`CASHACCOUNT`,`GSTPURCHASE`,`GSTSALES`,`DISCSALES`,`DISCPUR`,`COST`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gsetup`
--

LOCK TABLES `gsetup` WRITE;
/*!40000 ALTER TABLE `gsetup` DISABLE KEYS */;
INSERT INTO `gsetup` VALUES ('IMS','','2011-12-31',12,'3000','300Z','4000','400Z','','00000000','','','00000000','','','00000000','','','00000000','','','00000000','','','00000000','','','00000000','','','00000000','','','00000000','','','00000000','','','00000000','','00000000','','','00000000','','','00000000','','','00000000','','','00000000','','','00000000','','','00000000','','','00000000','','','00000000','','','00000000','','','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0000/000','0000/000','0000/000','0000/000','0000/000','0000/000','0000/000','0000/000','0000/000','0000/000','1','1','1','FIFO','0','0','','1','1','desp','A','','','','','','','','','','','Default','Category','Group','Size','Material','Model','Rating','Agent','Team','','N','0.00','N','1','End User','Location','Project','Job','Purchase Receive','Purchase Return','Delivery Order','Invoice','Cash Sales','Credit Note','Debit Note','Purchase Order','Purchase requisition','Quotation','Sales Order','Sample','Consignment Return','Consignment Out','Batch','N','N','byamt','1','0','Bill To Address Code','Del Address Code','Bill Attn','Delivery Attn','Bill Tel','Header Remark 5','Header Remark 6','Header Remark 7','Header Remark 8','Header Remark 9','Header Remark 10','Header Remark 11','english','Ref No 2','Delivery Tel','CLASS','POLICY NO.','PERIOD OF COVER FROM','PERIOD OF COVER TO','7','SR','ZR','NR','TX7','0','0','N','N','N','N','0','0','','SGD','0000/000','0000/000','0000/000','0000/000','0000/000','0000/000','0000/000','0000/000','0000/000','0000/000','0000/000','0000/000','0000/000','0000/000','0000/000','0000/000','0000/000','','0000/000','0000/000','0000/000','H','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','','01','No. Of Unit','Length','Width','Thickness','Weight/Length','Price/Weight','Total Weight',NULL,NULL,'1','1','','1','','','1','1','1','','N','N',5,'N','N','Y','Y','N','creditor','0','N','Customer Name','Supplier Name','Refno','INV','1','ABCDEFGHI','.','ABCDEFGHI','N','N','N','N','N','Description','N','20','60','','','N','24','20','0','0','0','0','0','0','0','0','0','0','0','N','N','N','2012-08-09','N','N','Y','N','N','N','N','Y','Y','N','N','N','N','N','N','N','','N','','','R','N','N',24,'N','N','N','N','','N','','N','N','N','1','N','N','1','0','Y','N','N','','','N','0','Issue','Adjustment Increase','Adjustment Reduce','cost','100','','N','N','N','N','Misc. Charges (1)','Misc. Charges (2)','Misc. Charges (3)','Misc. Charges (4)','Misc. Charges (5)','Misc. Charges (6)','Misc. Charges (7)','','','N','','N','N','N','1','N','N','N','N','','','','1','Item No','Product Code');
/*!40000 ALTER TABLE `gsetup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gsetup2`
--

DROP TABLE IF EXISTS `gsetup2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gsetup2` (
  `DECL_DISCOUNT` int(1) NOT NULL DEFAULT '0',
  `DECL_UPRICE` int(1) NOT NULL DEFAULT '0',
  `UPDATE_UNIT_COST` char(1) NOT NULL DEFAULT '',
  `DECL_TOTALAMT` int(1) unsigned NOT NULL DEFAULT '2',
  PRIMARY KEY (`DECL_DISCOUNT`,`DECL_UPRICE`) USING BTREE,
  KEY `DECIMAL` (`DECL_DISCOUNT`,`DECL_UPRICE`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gsetup2`
--

LOCK TABLES `gsetup2` WRITE;
/*!40000 ALTER TABLE `gsetup2` DISABLE KEYS */;
INSERT INTO `gsetup2` VALUES (2,2,'F',2);
/*!40000 ALTER TABLE `gsetup2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `icagent`
--

DROP TABLE IF EXISTS `icagent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `icagent` (
  `AGENT` varchar(20) NOT NULL DEFAULT '',
  `DESP` varchar(40) NOT NULL DEFAULT '',
  `COMMSION1` double(8,5) NOT NULL DEFAULT '0.00000',
  `HP` varchar(12) NOT NULL DEFAULT '',
  `discontinueagent` varchar(45) NOT NULL DEFAULT '',
  `agentID` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `agentlist` text,
  `TEAM` varchar(45) DEFAULT NULL,
  `PHOTO` varchar(100) DEFAULT '',
  `Email` varchar(100) DEFAULT '',
  `designation` varchar(100) DEFAULT '',
  PRIMARY KEY (`AGENT`),
  KEY `AGENTINFO` (`AGENT`,`DESP`,`COMMSION1`,`HP`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `icagent`
--

LOCK TABLES `icagent` WRITE;
/*!40000 ALTER TABLE `icagent` DISABLE KEYS */;
INSERT INTO `icagent` VALUES ('Manager','Manager owns the company',0.00000,'','','',NULL,NULL,'','',''),('Team Leader','Leads a team, has overridding.',0.00000,'','','',NULL,NULL,'','',''),('Sales Executive 1','Sales Executive 1 is under team leader',0.00000,'','','',NULL,NULL,'','',''),('Sales Executive 2','Sales Executive 1 is under team leader.',0.00000,'','','',NULL,NULL,'','','');
/*!40000 ALTER TABLE `icagent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `icarea`
--

DROP TABLE IF EXISTS `icarea`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `icarea` (
  `AREA` varchar(12) NOT NULL DEFAULT '',
  `DESP` varchar(40) NOT NULL DEFAULT '',
  PRIMARY KEY (`AREA`) USING BTREE,
  KEY `AREAINFO` (`AREA`,`DESP`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `icarea`
--

LOCK TABLES `icarea` WRITE;
/*!40000 ALTER TABLE `icarea` DISABLE KEYS */;
/*!40000 ALTER TABLE `icarea` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `icbranch`
--

DROP TABLE IF EXISTS `icbranch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `icbranch` (
  `branch` varchar(200) NOT NULL DEFAULT '',
  `desp` varchar(200) NOT NULL DEFAULT '',
  `startwith` varchar(200) NOT NULL DEFAULT '',
  PRIMARY KEY (`branch`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `icbranch`
--

LOCK TABLES `icbranch` WRITE;
/*!40000 ALTER TABLE `icbranch` DISABLE KEYS */;
/*!40000 ALTER TABLE `icbranch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `icbranchitemno`
--

DROP TABLE IF EXISTS `icbranchitemno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `icbranchitemno` (
  `branchitemno` varchar(200) NOT NULL DEFAULT '',
  `desp` varchar(200) NOT NULL DEFAULT '',
  `itemno` varchar(200) NOT NULL DEFAULT '',
  `branch` varchar(200) NOT NULL DEFAULT '',
  PRIMARY KEY (`branchitemno`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `icbranchitemno`
--

LOCK TABLES `icbranchitemno` WRITE;
/*!40000 ALTER TABLE `icbranchitemno` DISABLE KEYS */;
/*!40000 ALTER TABLE `icbranchitemno` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `iccate`
--

DROP TABLE IF EXISTS `iccate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `iccate` (
  `CATE` varchar(50) NOT NULL,
  `DESP` varchar(40) NOT NULL DEFAULT '',
  PRIMARY KEY (`CATE`),
  KEY `CATEINFO` (`CATE`,`DESP`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `iccate`
--

LOCK TABLES `iccate` WRITE;
/*!40000 ALTER TABLE `iccate` DISABLE KEYS */;
/*!40000 ALTER TABLE `iccate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `iccolor2`
--

DROP TABLE IF EXISTS `iccolor2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `iccolor2` (
  `COLORNO` varchar(10) NOT NULL DEFAULT '',
  `COLORID2` varchar(10) NOT NULL DEFAULT '',
  `DESP` varchar(40) DEFAULT NULL,
  `SIZE1` varchar(10) DEFAULT NULL,
  `SIZE2` varchar(10) DEFAULT NULL,
  `SIZE3` varchar(10) DEFAULT NULL,
  `SIZE4` varchar(10) DEFAULT NULL,
  `SIZE5` varchar(10) DEFAULT NULL,
  `SIZE6` varchar(10) DEFAULT NULL,
  `SIZE7` varchar(10) DEFAULT NULL,
  `SIZE8` varchar(10) DEFAULT NULL,
  `SIZE9` varchar(10) DEFAULT NULL,
  `SIZE10` varchar(10) DEFAULT NULL,
  `SIZE11` varchar(10) DEFAULT NULL,
  `SIZE12` varchar(10) DEFAULT NULL,
  `SIZE13` varchar(10) DEFAULT NULL,
  `SIZE14` varchar(10) DEFAULT NULL,
  `SIZE15` varchar(10) DEFAULT NULL,
  `SIZE16` varchar(10) DEFAULT NULL,
  `SIZE17` varchar(10) DEFAULT NULL,
  `SIZE18` varchar(10) DEFAULT NULL,
  `SIZE19` varchar(10) DEFAULT NULL,
  `SIZE20` varchar(10) DEFAULT NULL,
  `CREATED_BY` varchar(50) DEFAULT NULL,
  `CREATED_ON` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `UPDATED_BY` varchar(50) DEFAULT NULL,
  `UPDATED_ON` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`COLORNO`,`COLORID2`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `iccolor2`
--

LOCK TABLES `iccolor2` WRITE;
/*!40000 ALTER TABLE `iccolor2` DISABLE KEYS */;
/*!40000 ALTER TABLE `iccolor2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `iccolorid`
--

DROP TABLE IF EXISTS `iccolorid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `iccolorid` (
  `COLORID` varchar(10) NOT NULL DEFAULT '',
  `DESP` varchar(40) NOT NULL DEFAULT '',
  PRIMARY KEY (`COLORID`),
  KEY `COLORINFO` (`COLORID`,`DESP`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `iccolorid`
--

LOCK TABLES `iccolorid` WRITE;
/*!40000 ALTER TABLE `iccolorid` DISABLE KEYS */;
/*!40000 ALTER TABLE `iccolorid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `iccostcode`
--

DROP TABLE IF EXISTS `iccostcode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `iccostcode` (
  `COSTCODE` varchar(8) NOT NULL DEFAULT '',
  `DESP` varchar(40) NOT NULL DEFAULT '',
  PRIMARY KEY (`COSTCODE`),
  KEY `COSTCODEINFO` (`COSTCODE`,`DESP`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `iccostcode`
--

LOCK TABLES `iccostcode` WRITE;
/*!40000 ALTER TABLE `iccostcode` DISABLE KEYS */;
/*!40000 ALTER TABLE `iccostcode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `icgroup`
--

DROP TABLE IF EXISTS `icgroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `icgroup` (
  `WOS_GROUP` varchar(50) NOT NULL DEFAULT '',
  `DESP` varchar(40) DEFAULT NULL,
  `SALEC` varchar(8) DEFAULT '0000/000',
  `SALECSC` varchar(8) DEFAULT '0000/000',
  `SALECNC` varchar(8) DEFAULT '0000/000',
  `PURC` varchar(8) DEFAULT '0000/000',
  `PURPRC` varchar(8) DEFAULT '0000/000',
  `METER_READ` char(1) DEFAULT 'N',
  `GRADD11` varchar(15) DEFAULT NULL,
  `GRADD12` varchar(15) DEFAULT NULL,
  `GRADD13` varchar(15) DEFAULT NULL,
  `GRADD14` varchar(15) DEFAULT NULL,
  `GRADD15` varchar(15) DEFAULT NULL,
  `GRADD16` varchar(15) DEFAULT NULL,
  `GRADD17` varchar(15) DEFAULT NULL,
  `GRADD18` varchar(15) DEFAULT NULL,
  `GRADD19` varchar(15) DEFAULT NULL,
  `GRADD20` varchar(15) DEFAULT NULL,
  `GRADD21` varchar(15) DEFAULT NULL,
  `GRADD22` varchar(15) DEFAULT NULL,
  `GRADD23` varchar(15) DEFAULT NULL,
  `GRADD24` varchar(15) DEFAULT NULL,
  `GRADD25` varchar(15) DEFAULT NULL,
  `GRADD26` varchar(15) DEFAULT NULL,
  `GRADD27` varchar(15) DEFAULT NULL,
  `GRADD28` varchar(15) DEFAULT NULL,
  `GRADD29` varchar(15) DEFAULT NULL,
  `GRADD30` varchar(15) DEFAULT NULL,
  `GRADD31` varchar(15) DEFAULT NULL,
  `GRADD32` varchar(15) DEFAULT NULL,
  `GRADD33` varchar(15) DEFAULT NULL,
  `GRADD34` varchar(15) DEFAULT NULL,
  `GRADD35` varchar(15) DEFAULT NULL,
  `GRADD36` varchar(15) DEFAULT NULL,
  `GRADD37` varchar(15) DEFAULT NULL,
  `GRADD38` varchar(15) DEFAULT NULL,
  `GRADD39` varchar(15) DEFAULT NULL,
  `GRADD40` varchar(15) DEFAULT NULL,
  `GRADD41` varchar(15) DEFAULT NULL,
  `GRADD42` varchar(15) DEFAULT NULL,
  `GRADD43` varchar(15) DEFAULT NULL,
  `GRADD44` varchar(15) DEFAULT NULL,
  `GRADD45` varchar(15) DEFAULT NULL,
  `GRADD46` varchar(15) DEFAULT NULL,
  `GRADD47` varchar(15) DEFAULT NULL,
  `GRADD48` varchar(15) DEFAULT NULL,
  `GRADD49` varchar(15) DEFAULT NULL,
  `GRADD50` varchar(15) DEFAULT NULL,
  `GRADD51` varchar(15) DEFAULT NULL,
  `GRADD52` varchar(15) DEFAULT NULL,
  `GRADD53` varchar(15) DEFAULT NULL,
  `GRADD54` varchar(15) DEFAULT NULL,
  `GRADD55` varchar(15) DEFAULT NULL,
  `GRADD56` varchar(15) DEFAULT NULL,
  `GRADD57` varchar(15) DEFAULT NULL,
  `GRADD58` varchar(15) DEFAULT NULL,
  `GRADD59` varchar(15) DEFAULT NULL,
  `GRADD60` varchar(15) DEFAULT NULL,
  `GRADD61` varchar(15) DEFAULT NULL,
  `GRADD62` varchar(15) DEFAULT NULL,
  `GRADD63` varchar(15) DEFAULT NULL,
  `GRADD64` varchar(15) DEFAULT NULL,
  `GRADD65` varchar(15) DEFAULT NULL,
  `GRADD66` varchar(15) DEFAULT NULL,
  `GRADD67` varchar(15) DEFAULT NULL,
  `GRADD68` varchar(15) DEFAULT NULL,
  `GRADD69` varchar(15) DEFAULT NULL,
  `GRADD70` varchar(15) DEFAULT NULL,
  `GRADD71` varchar(15) DEFAULT '',
  `GRADD72` varchar(15) DEFAULT '',
  `GRADD73` varchar(15) DEFAULT '',
  `GRADD74` varchar(15) DEFAULT '',
  `GRADD75` varchar(15) DEFAULT '',
  `GRADD76` varchar(15) DEFAULT '',
  `GRADD77` varchar(15) DEFAULT '',
  `GRADD78` varchar(15) DEFAULT '',
  `GRADD79` varchar(15) DEFAULT '',
  `GRADD80` varchar(15) DEFAULT '',
  `GRADD81` varchar(15) DEFAULT '',
  `GRADD82` varchar(15) DEFAULT '',
  `GRADD83` varchar(15) DEFAULT '',
  `GRADD84` varchar(15) DEFAULT '',
  `GRADD85` varchar(15) DEFAULT '',
  `GRADD86` varchar(15) DEFAULT '',
  `GRADD87` varchar(15) DEFAULT '',
  `GRADD88` varchar(15) DEFAULT '',
  `GRADD89` varchar(15) DEFAULT '',
  `GRADD90` varchar(15) DEFAULT '',
  `GRADD91` varchar(15) DEFAULT '',
  `GRADD92` varchar(15) DEFAULT '',
  `GRADD93` varchar(15) DEFAULT '',
  `GRADD94` varchar(15) DEFAULT '',
  `GRADD95` varchar(15) DEFAULT '',
  `GRADD96` varchar(15) DEFAULT '',
  `GRADD97` varchar(15) DEFAULT '',
  `GRADD98` varchar(15) DEFAULT '',
  `GRADD99` varchar(15) DEFAULT '',
  `GRADD100` varchar(15) DEFAULT '',
  `GRADD101` varchar(15) DEFAULT '',
  `GRADD102` varchar(15) DEFAULT '',
  `GRADD103` varchar(15) DEFAULT '',
  `GRADD104` varchar(15) DEFAULT '',
  `GRADD105` varchar(15) DEFAULT '',
  `GRADD106` varchar(15) DEFAULT '',
  `GRADD107` varchar(15) DEFAULT '',
  `GRADD108` varchar(15) DEFAULT '',
  `GRADD109` varchar(15) DEFAULT '',
  `GRADD110` varchar(15) DEFAULT '',
  `GRADD111` varchar(15) DEFAULT '',
  `GRADD112` varchar(15) DEFAULT '',
  `GRADD113` varchar(15) DEFAULT '',
  `GRADD114` varchar(15) DEFAULT '',
  `GRADD115` varchar(15) DEFAULT '',
  `GRADD116` varchar(15) DEFAULT '',
  `GRADD117` varchar(15) DEFAULT '',
  `GRADD118` varchar(15) DEFAULT '',
  `GRADD119` varchar(15) DEFAULT '',
  `GRADD120` varchar(15) DEFAULT '',
  `GRADD121` varchar(15) DEFAULT '',
  `GRADD122` varchar(15) DEFAULT '',
  `GRADD123` varchar(15) DEFAULT '',
  `GRADD124` varchar(15) DEFAULT '',
  `GRADD125` varchar(15) DEFAULT '',
  `GRADD126` varchar(15) DEFAULT '',
  `GRADD127` varchar(15) DEFAULT '',
  `GRADD128` varchar(15) DEFAULT '',
  `GRADD129` varchar(15) DEFAULT '',
  `GRADD130` varchar(15) DEFAULT '',
  `GRADD131` varchar(15) DEFAULT '',
  `GRADD132` varchar(15) DEFAULT '',
  `GRADD133` varchar(15) DEFAULT '',
  `GRADD134` varchar(15) DEFAULT '',
  `GRADD135` varchar(15) DEFAULT '',
  `GRADD136` varchar(15) DEFAULT '',
  `GRADD137` varchar(15) DEFAULT '',
  `GRADD138` varchar(15) DEFAULT '',
  `GRADD139` varchar(15) DEFAULT '',
  `GRADD140` varchar(15) DEFAULT '',
  `GRADD141` varchar(15) DEFAULT '',
  `GRADD142` varchar(15) DEFAULT '',
  `GRADD143` varchar(15) DEFAULT '',
  `GRADD144` varchar(15) DEFAULT '',
  `GRADD145` varchar(15) DEFAULT '',
  `GRADD146` varchar(15) DEFAULT '',
  `GRADD147` varchar(15) DEFAULT '',
  `GRADD148` varchar(15) DEFAULT '',
  `GRADD149` varchar(15) DEFAULT '',
  `GRADD150` varchar(15) DEFAULT '',
  `GRADD151` varchar(15) DEFAULT '',
  `GRADD152` varchar(15) DEFAULT '',
  `GRADD153` varchar(15) DEFAULT '',
  `GRADD154` varchar(15) DEFAULT '',
  `GRADD155` varchar(15) DEFAULT '',
  `GRADD156` varchar(15) DEFAULT '',
  `GRADD157` varchar(15) DEFAULT '',
  `GRADD158` varchar(15) DEFAULT '',
  `GRADD159` varchar(15) DEFAULT '',
  `GRADD160` varchar(15) DEFAULT '',
  `GRADD161` varchar(3) DEFAULT NULL,
  `GRADD162` varchar(3) DEFAULT NULL,
  `GRADD163` varchar(3) DEFAULT NULL,
  `GRADD164` varchar(3) DEFAULT NULL,
  `GRADD165` varchar(3) DEFAULT NULL,
  `GRADD166` varchar(3) DEFAULT NULL,
  `GRADD167` varchar(3) DEFAULT NULL,
  `GRADD168` varchar(3) DEFAULT NULL,
  `GRADD169` varchar(3) DEFAULT NULL,
  `GRADD170` varchar(3) DEFAULT NULL,
  `GRADD171` varchar(3) DEFAULT NULL,
  `GRADD172` varchar(3) DEFAULT NULL,
  `GRADD173` varchar(3) DEFAULT NULL,
  `GRADD174` varchar(3) DEFAULT NULL,
  `GRADD175` varchar(3) DEFAULT NULL,
  `GRADD176` varchar(3) DEFAULT NULL,
  `GRADD177` varchar(3) DEFAULT NULL,
  `GRADD178` varchar(3) DEFAULT NULL,
  `GRADD179` varchar(3) DEFAULT NULL,
  `GRADD180` varchar(3) DEFAULT NULL,
  `GRADD181` varchar(3) DEFAULT NULL,
  `GRADD182` varchar(3) DEFAULT NULL,
  `GRADD183` varchar(3) DEFAULT NULL,
  `GRADD184` varchar(3) DEFAULT NULL,
  `GRADD185` varchar(3) DEFAULT NULL,
  `GRADD186` varchar(3) DEFAULT NULL,
  `GRADD187` varchar(3) DEFAULT NULL,
  `GRADD188` varchar(3) DEFAULT NULL,
  `GRADD189` varchar(3) DEFAULT NULL,
  `GRADD190` varchar(3) DEFAULT NULL,
  `GRADD191` varchar(3) DEFAULT NULL,
  `GRADD192` varchar(3) DEFAULT NULL,
  `GRADD193` varchar(3) DEFAULT NULL,
  `GRADD194` varchar(3) DEFAULT NULL,
  `GRADD195` varchar(3) DEFAULT NULL,
  `GRADD196` varchar(3) DEFAULT NULL,
  `GRADD197` varchar(3) DEFAULT NULL,
  `GRADD198` varchar(3) DEFAULT NULL,
  `GRADD199` varchar(3) DEFAULT NULL,
  `GRADD200` varchar(3) DEFAULT NULL,
  `GRADD201` varchar(3) DEFAULT NULL,
  `GRADD202` varchar(3) DEFAULT NULL,
  `GRADD203` varchar(3) DEFAULT NULL,
  `GRADD204` varchar(3) DEFAULT NULL,
  `GRADD205` varchar(3) DEFAULT NULL,
  `GRADD206` varchar(3) DEFAULT NULL,
  `GRADD207` varchar(3) DEFAULT NULL,
  `GRADD208` varchar(3) DEFAULT NULL,
  `GRADD209` varchar(3) DEFAULT NULL,
  `GRADD210` varchar(3) DEFAULT NULL,
  `GRADD211` varchar(3) DEFAULT NULL,
  `GRADD212` varchar(3) DEFAULT NULL,
  `GRADD213` varchar(3) DEFAULT NULL,
  `GRADD214` varchar(3) DEFAULT NULL,
  `GRADD215` varchar(3) DEFAULT NULL,
  `GRADD216` varchar(3) DEFAULT NULL,
  `GRADD217` varchar(3) DEFAULT NULL,
  `GRADD218` varchar(3) DEFAULT NULL,
  `GRADD219` varchar(3) DEFAULT NULL,
  `GRADD220` varchar(3) DEFAULT NULL,
  `GRADD221` varchar(3) DEFAULT NULL,
  `GRADD222` varchar(3) DEFAULT NULL,
  `GRADD223` varchar(3) DEFAULT NULL,
  `GRADD224` varchar(3) DEFAULT NULL,
  `GRADD225` varchar(3) DEFAULT NULL,
  `GRADD226` varchar(3) DEFAULT NULL,
  `GRADD227` varchar(3) DEFAULT NULL,
  `GRADD228` varchar(3) DEFAULT NULL,
  `GRADD229` varchar(3) DEFAULT NULL,
  `GRADD230` varchar(3) DEFAULT NULL,
  `GRADD231` varchar(3) DEFAULT NULL,
  `GRADD232` varchar(3) DEFAULT NULL,
  `GRADD233` varchar(3) DEFAULT NULL,
  `GRADD234` varchar(3) DEFAULT NULL,
  `GRADD235` varchar(3) DEFAULT NULL,
  `GRADD236` varchar(3) DEFAULT NULL,
  `GRADD237` varchar(3) DEFAULT NULL,
  `GRADD238` varchar(3) DEFAULT NULL,
  `GRADD239` varchar(3) DEFAULT NULL,
  `GRADD240` varchar(3) DEFAULT NULL,
  `GRADD241` varchar(3) DEFAULT NULL,
  `GRADD242` varchar(3) DEFAULT NULL,
  `GRADD243` varchar(3) DEFAULT NULL,
  `GRADD244` varchar(3) DEFAULT NULL,
  `GRADD245` varchar(3) DEFAULT NULL,
  `GRADD246` varchar(3) DEFAULT NULL,
  `GRADD247` varchar(3) DEFAULT NULL,
  `GRADD248` varchar(3) DEFAULT NULL,
  `GRADD249` varchar(3) DEFAULT NULL,
  `GRADD250` varchar(3) DEFAULT NULL,
  `GRADD251` varchar(3) DEFAULT NULL,
  `GRADD252` varchar(3) DEFAULT NULL,
  `GRADD253` varchar(3) DEFAULT NULL,
  `GRADD254` varchar(3) DEFAULT NULL,
  `GRADD255` varchar(3) DEFAULT NULL,
  `GRADD256` varchar(3) DEFAULT NULL,
  `GRADD257` varchar(3) DEFAULT NULL,
  `GRADD258` varchar(3) DEFAULT NULL,
  `GRADD259` varchar(3) DEFAULT NULL,
  `GRADD260` varchar(3) DEFAULT NULL,
  `GRADD261` varchar(3) DEFAULT NULL,
  `GRADD262` varchar(3) DEFAULT NULL,
  `GRADD263` varchar(3) DEFAULT NULL,
  `GRADD264` varchar(3) DEFAULT NULL,
  `GRADD265` varchar(3) DEFAULT NULL,
  `GRADD266` varchar(3) DEFAULT NULL,
  `GRADD267` varchar(3) DEFAULT NULL,
  `GRADD268` varchar(3) DEFAULT NULL,
  `GRADD269` varchar(3) DEFAULT NULL,
  `GRADD270` varchar(3) DEFAULT NULL,
  `GRADD271` varchar(3) DEFAULT NULL,
  `GRADD272` varchar(3) DEFAULT NULL,
  `GRADD273` varchar(3) DEFAULT NULL,
  `GRADD274` varchar(3) DEFAULT NULL,
  `GRADD275` varchar(3) DEFAULT NULL,
  `GRADD276` varchar(3) DEFAULT NULL,
  `GRADD277` varchar(3) DEFAULT NULL,
  `GRADD278` varchar(3) DEFAULT NULL,
  `GRADD279` varchar(3) DEFAULT NULL,
  `GRADD280` varchar(3) DEFAULT NULL,
  `GRADD281` varchar(3) DEFAULT NULL,
  `GRADD282` varchar(3) DEFAULT NULL,
  `GRADD283` varchar(3) DEFAULT NULL,
  `GRADD284` varchar(3) DEFAULT NULL,
  `GRADD285` varchar(3) DEFAULT NULL,
  `GRADD286` varchar(3) DEFAULT NULL,
  `GRADD287` varchar(3) DEFAULT NULL,
  `GRADD288` varchar(3) DEFAULT NULL,
  `GRADD289` varchar(3) DEFAULT NULL,
  `GRADD290` varchar(3) DEFAULT NULL,
  `GRADD291` varchar(3) DEFAULT NULL,
  `GRADD292` varchar(3) DEFAULT NULL,
  `GRADD293` varchar(3) DEFAULT NULL,
  `GRADD294` varchar(3) DEFAULT NULL,
  `GRADD295` varchar(3) DEFAULT NULL,
  `GRADD296` varchar(3) DEFAULT NULL,
  `GRADD297` varchar(3) DEFAULT NULL,
  `GRADD298` varchar(3) DEFAULT NULL,
  `GRADD299` varchar(3) DEFAULT NULL,
  `GRADD300` varchar(3) DEFAULT NULL,
  `GRADD301` varchar(3) DEFAULT NULL,
  `GRADD302` varchar(3) DEFAULT NULL,
  `GRADD303` varchar(3) DEFAULT NULL,
  `GRADD304` varchar(3) DEFAULT NULL,
  `GRADD305` varchar(3) DEFAULT NULL,
  `GRADD306` varchar(3) DEFAULT NULL,
  `GRADD307` varchar(3) DEFAULT NULL,
  `GRADD308` varchar(3) DEFAULT NULL,
  `GRADD309` varchar(3) DEFAULT NULL,
  `GRADD310` varchar(3) DEFAULT NULL,
  `GRADS11` varchar(3) DEFAULT NULL,
  `GRADS12` varchar(3) DEFAULT NULL,
  `GRADS13` varchar(3) DEFAULT NULL,
  `GRADS14` varchar(3) DEFAULT NULL,
  `GRADS15` varchar(3) DEFAULT NULL,
  `GRADS16` varchar(3) DEFAULT NULL,
  `GRADS17` varchar(3) DEFAULT NULL,
  `GRADS18` varchar(3) DEFAULT NULL,
  `GRADS19` varchar(3) DEFAULT NULL,
  `GRADS20` varchar(3) DEFAULT NULL,
  `GRADS21` varchar(3) DEFAULT NULL,
  `GRADS22` varchar(3) DEFAULT NULL,
  `GRADS23` varchar(3) DEFAULT NULL,
  `GRADS24` varchar(3) DEFAULT NULL,
  `GRADS25` varchar(3) DEFAULT NULL,
  `GRADS26` varchar(3) DEFAULT NULL,
  `GRADS27` varchar(3) DEFAULT NULL,
  `GRADS28` varchar(3) DEFAULT NULL,
  `GRADS29` varchar(3) DEFAULT NULL,
  `GRADS30` varchar(3) DEFAULT NULL,
  `GRADS31` varchar(3) DEFAULT NULL,
  `GRADS32` varchar(3) DEFAULT NULL,
  `GRADS33` varchar(3) DEFAULT NULL,
  `GRADS34` varchar(3) DEFAULT NULL,
  `GRADS35` varchar(3) DEFAULT NULL,
  `GRADS36` varchar(3) DEFAULT NULL,
  `GRADS37` varchar(3) DEFAULT NULL,
  `GRADS38` varchar(3) DEFAULT NULL,
  `GRADS39` varchar(3) DEFAULT NULL,
  `GRADS40` varchar(3) DEFAULT NULL,
  `GRADS41` varchar(3) DEFAULT NULL,
  `GRADS42` varchar(3) DEFAULT NULL,
  `GRADS43` varchar(3) DEFAULT NULL,
  `GRADS44` varchar(3) DEFAULT NULL,
  `GRADS45` varchar(3) DEFAULT NULL,
  `GRADS46` varchar(3) DEFAULT NULL,
  `GRADS47` varchar(3) DEFAULT NULL,
  `GRADS48` varchar(3) DEFAULT NULL,
  `GRADS49` varchar(3) DEFAULT NULL,
  `GRADS50` varchar(3) DEFAULT NULL,
  `GRADS51` varchar(3) DEFAULT NULL,
  `GRADS52` varchar(3) DEFAULT NULL,
  `GRADS53` varchar(3) DEFAULT NULL,
  `GRADS54` varchar(3) DEFAULT NULL,
  `GRADS55` varchar(3) DEFAULT NULL,
  `GRADS56` varchar(3) DEFAULT NULL,
  `GRADS57` varchar(3) DEFAULT NULL,
  `GRADS58` varchar(3) DEFAULT NULL,
  `GRADS59` varchar(3) DEFAULT NULL,
  `GRADS60` varchar(3) DEFAULT NULL,
  `GRADS61` varchar(3) DEFAULT NULL,
  `GRADS62` varchar(3) DEFAULT NULL,
  `GRADS63` varchar(3) DEFAULT NULL,
  `GRADS64` varchar(3) DEFAULT NULL,
  `GRADS65` varchar(3) DEFAULT NULL,
  `GRADS66` varchar(3) DEFAULT NULL,
  `GRADS67` varchar(3) DEFAULT NULL,
  `GRADS68` varchar(3) DEFAULT NULL,
  `GRADS69` varchar(3) DEFAULT NULL,
  `GRADS70` varchar(3) DEFAULT NULL,
  `GRADS71` varchar(3) DEFAULT '',
  `GRADS72` varchar(3) DEFAULT '',
  `GRADS73` varchar(3) DEFAULT '',
  `GRADS74` varchar(3) DEFAULT '',
  `GRADS75` varchar(3) DEFAULT '',
  `GRADS76` varchar(3) DEFAULT '',
  `GRADS77` varchar(3) DEFAULT '',
  `GRADS78` varchar(3) DEFAULT '',
  `GRADS79` varchar(3) DEFAULT '',
  `GRADS80` varchar(3) DEFAULT '',
  `GRADS81` varchar(3) DEFAULT '',
  `GRADS82` varchar(3) DEFAULT '',
  `GRADS83` varchar(3) DEFAULT '',
  `GRADS84` varchar(3) DEFAULT '',
  `GRADS85` varchar(3) DEFAULT '',
  `GRADS86` varchar(3) DEFAULT '',
  `GRADS87` varchar(3) DEFAULT '',
  `GRADS88` varchar(3) DEFAULT '',
  `GRADS89` varchar(3) DEFAULT '',
  `GRADS90` varchar(3) DEFAULT '',
  `GRADS91` varchar(3) DEFAULT '',
  `GRADS92` varchar(3) DEFAULT '',
  `GRADS93` varchar(3) DEFAULT '',
  `GRADS94` varchar(3) DEFAULT '',
  `GRADS95` varchar(3) DEFAULT '',
  `GRADS96` varchar(3) DEFAULT '',
  `GRADS97` varchar(3) DEFAULT '',
  `GRADS98` varchar(3) DEFAULT '',
  `GRADS99` varchar(3) DEFAULT '',
  `GRADS100` varchar(3) DEFAULT '',
  `GRADS101` varchar(3) DEFAULT '',
  `GRADS102` varchar(3) DEFAULT '',
  `GRADS103` varchar(3) DEFAULT '',
  `GRADS104` varchar(3) DEFAULT '',
  `GRADS105` varchar(3) DEFAULT '',
  `GRADS106` varchar(3) DEFAULT '',
  `GRADS107` varchar(3) DEFAULT '',
  `GRADS108` varchar(3) DEFAULT '',
  `GRADS109` varchar(3) DEFAULT '',
  `GRADS110` varchar(3) DEFAULT '',
  `GRADS111` varchar(3) DEFAULT '',
  `GRADS112` varchar(3) DEFAULT '',
  `GRADS113` varchar(3) DEFAULT '',
  `GRADS114` varchar(3) DEFAULT '',
  `GRADS115` varchar(3) DEFAULT '',
  `GRADS116` varchar(3) DEFAULT '',
  `GRADS117` varchar(3) DEFAULT '',
  `GRADS118` varchar(3) DEFAULT '',
  `GRADS119` varchar(3) DEFAULT '',
  `GRADS120` varchar(3) DEFAULT '',
  `GRADS121` varchar(3) DEFAULT '',
  `GRADS122` varchar(3) DEFAULT '',
  `GRADS123` varchar(3) DEFAULT '',
  `GRADS124` varchar(3) DEFAULT '',
  `GRADS125` varchar(3) DEFAULT '',
  `GRADS126` varchar(3) DEFAULT '',
  `GRADS127` varchar(3) DEFAULT '',
  `GRADS128` varchar(3) DEFAULT '',
  `GRADS129` varchar(3) DEFAULT '',
  `GRADS130` varchar(3) DEFAULT '',
  `GRADS131` varchar(3) DEFAULT '',
  `GRADS132` varchar(3) DEFAULT '',
  `GRADS133` varchar(3) DEFAULT '',
  `GRADS134` varchar(3) DEFAULT '',
  `GRADS135` varchar(3) DEFAULT '',
  `GRADS136` varchar(3) DEFAULT '',
  `GRADS137` varchar(3) DEFAULT '',
  `GRADS138` varchar(3) DEFAULT '',
  `GRADS139` varchar(3) DEFAULT '',
  `GRADS140` varchar(3) DEFAULT '',
  `GRADS141` varchar(3) DEFAULT '',
  `GRADS142` varchar(3) DEFAULT '',
  `GRADS143` varchar(3) DEFAULT '',
  `GRADS144` varchar(3) DEFAULT '',
  `GRADS145` varchar(3) DEFAULT '',
  `GRADS146` varchar(3) DEFAULT '',
  `GRADS147` varchar(3) DEFAULT '',
  `GRADS148` varchar(3) DEFAULT '',
  `GRADS149` varchar(3) DEFAULT '',
  `GRADS150` varchar(3) DEFAULT '',
  `GRADS151` varchar(3) DEFAULT '',
  `GRADS152` varchar(3) DEFAULT '',
  `GRADS153` varchar(3) DEFAULT '',
  `GRADS154` varchar(3) DEFAULT '',
  `GRADS155` varchar(3) DEFAULT '',
  `GRADS156` varchar(3) DEFAULT '',
  `GRADS157` varchar(3) DEFAULT '',
  `GRADS158` varchar(3) DEFAULT '',
  `GRADS159` varchar(3) DEFAULT '',
  `GRADS160` varchar(3) DEFAULT '',
  `GRADS161` varchar(3) DEFAULT NULL,
  `GRADS162` varchar(3) DEFAULT NULL,
  `GRADS163` varchar(3) DEFAULT NULL,
  `GRADS164` varchar(3) DEFAULT NULL,
  `GRADS165` varchar(3) DEFAULT NULL,
  `GRADS166` varchar(3) DEFAULT NULL,
  `GRADS167` varchar(3) DEFAULT NULL,
  `GRADS168` varchar(3) DEFAULT NULL,
  `GRADS169` varchar(3) DEFAULT NULL,
  `GRADS170` varchar(3) DEFAULT NULL,
  `GRADS171` varchar(3) DEFAULT NULL,
  `GRADS172` varchar(3) DEFAULT NULL,
  `GRADS173` varchar(3) DEFAULT NULL,
  `GRADS174` varchar(3) DEFAULT NULL,
  `GRADS175` varchar(3) DEFAULT NULL,
  `GRADS176` varchar(3) DEFAULT NULL,
  `GRADS177` varchar(3) DEFAULT NULL,
  `GRADS178` varchar(3) DEFAULT NULL,
  `GRADS179` varchar(3) DEFAULT NULL,
  `GRADS180` varchar(3) DEFAULT NULL,
  `GRADS181` varchar(3) DEFAULT NULL,
  `GRADS182` varchar(3) DEFAULT NULL,
  `GRADS183` varchar(3) DEFAULT NULL,
  `GRADS184` varchar(3) DEFAULT NULL,
  `GRADS185` varchar(3) DEFAULT NULL,
  `GRADS186` varchar(3) DEFAULT NULL,
  `GRADS187` varchar(3) DEFAULT NULL,
  `GRADS188` varchar(3) DEFAULT NULL,
  `GRADS189` varchar(3) DEFAULT NULL,
  `GRADS190` varchar(3) DEFAULT NULL,
  `GRADS191` varchar(3) DEFAULT NULL,
  `GRADS192` varchar(3) DEFAULT NULL,
  `GRADS193` varchar(3) DEFAULT NULL,
  `GRADS194` varchar(3) DEFAULT NULL,
  `GRADS195` varchar(3) DEFAULT NULL,
  `GRADS196` varchar(3) DEFAULT NULL,
  `GRADS197` varchar(3) DEFAULT NULL,
  `GRADS198` varchar(3) DEFAULT NULL,
  `GRADS199` varchar(3) DEFAULT NULL,
  `GRADS200` varchar(3) DEFAULT NULL,
  `GRADS201` varchar(3) DEFAULT NULL,
  `GRADS202` varchar(3) DEFAULT NULL,
  `GRADS203` varchar(3) DEFAULT NULL,
  `GRADS204` varchar(3) DEFAULT NULL,
  `GRADS205` varchar(3) DEFAULT NULL,
  `GRADS206` varchar(3) DEFAULT NULL,
  `GRADS207` varchar(3) DEFAULT NULL,
  `GRADS208` varchar(3) DEFAULT NULL,
  `GRADS209` varchar(3) DEFAULT NULL,
  `GRADS210` varchar(3) DEFAULT NULL,
  `GRADS211` varchar(3) DEFAULT NULL,
  `GRADS212` varchar(3) DEFAULT NULL,
  `GRADS213` varchar(3) DEFAULT NULL,
  `GRADS214` varchar(3) DEFAULT NULL,
  `GRADS215` varchar(3) DEFAULT NULL,
  `GRADS216` varchar(3) DEFAULT NULL,
  `GRADS217` varchar(3) DEFAULT NULL,
  `GRADS218` varchar(3) DEFAULT NULL,
  `GRADS219` varchar(3) DEFAULT NULL,
  `GRADS220` varchar(3) DEFAULT NULL,
  `GRADS221` varchar(3) DEFAULT NULL,
  `GRADS222` varchar(3) DEFAULT NULL,
  `GRADS223` varchar(3) DEFAULT NULL,
  `GRADS224` varchar(3) DEFAULT NULL,
  `GRADS225` varchar(3) DEFAULT NULL,
  `GRADS226` varchar(3) DEFAULT NULL,
  `GRADS227` varchar(3) DEFAULT NULL,
  `GRADS228` varchar(3) DEFAULT NULL,
  `GRADS229` varchar(3) DEFAULT NULL,
  `GRADS230` varchar(3) DEFAULT NULL,
  `GRADS231` varchar(3) DEFAULT NULL,
  `GRADS232` varchar(3) DEFAULT NULL,
  `GRADS233` varchar(3) DEFAULT NULL,
  `GRADS234` varchar(3) DEFAULT NULL,
  `GRADS235` varchar(3) DEFAULT NULL,
  `GRADS236` varchar(3) DEFAULT NULL,
  `GRADS237` varchar(3) DEFAULT NULL,
  `GRADS238` varchar(3) DEFAULT NULL,
  `GRADS239` varchar(3) DEFAULT NULL,
  `GRADS240` varchar(3) DEFAULT NULL,
  `GRADS241` varchar(3) DEFAULT NULL,
  `GRADS242` varchar(3) DEFAULT NULL,
  `GRADS243` varchar(3) DEFAULT NULL,
  `GRADS244` varchar(3) DEFAULT NULL,
  `GRADS245` varchar(3) DEFAULT NULL,
  `GRADS246` varchar(3) DEFAULT NULL,
  `GRADS247` varchar(3) DEFAULT NULL,
  `GRADS248` varchar(3) DEFAULT NULL,
  `GRADS249` varchar(3) DEFAULT NULL,
  `GRADS250` varchar(3) DEFAULT NULL,
  `GRADS251` varchar(3) DEFAULT NULL,
  `GRADS252` varchar(3) DEFAULT NULL,
  `GRADS253` varchar(3) DEFAULT NULL,
  `GRADS254` varchar(3) DEFAULT NULL,
  `GRADS255` varchar(3) DEFAULT NULL,
  `GRADS256` varchar(3) DEFAULT NULL,
  `GRADS257` varchar(3) DEFAULT NULL,
  `GRADS258` varchar(3) DEFAULT NULL,
  `GRADS259` varchar(3) DEFAULT NULL,
  `GRADS260` varchar(3) DEFAULT NULL,
  `GRADS261` varchar(3) DEFAULT NULL,
  `GRADS262` varchar(3) DEFAULT NULL,
  `GRADS263` varchar(3) DEFAULT NULL,
  `GRADS264` varchar(3) DEFAULT NULL,
  `GRADS265` varchar(3) DEFAULT NULL,
  `GRADS266` varchar(3) DEFAULT NULL,
  `GRADS267` varchar(3) DEFAULT NULL,
  `GRADS268` varchar(3) DEFAULT NULL,
  `GRADS269` varchar(3) DEFAULT NULL,
  `GRADS270` varchar(3) DEFAULT NULL,
  `GRADS271` varchar(3) DEFAULT NULL,
  `GRADS272` varchar(3) DEFAULT NULL,
  `GRADS273` varchar(3) DEFAULT NULL,
  `GRADS274` varchar(3) DEFAULT NULL,
  `GRADS275` varchar(3) DEFAULT NULL,
  `GRADS276` varchar(3) DEFAULT NULL,
  `GRADS277` varchar(3) DEFAULT NULL,
  `GRADS278` varchar(3) DEFAULT NULL,
  `GRADS279` varchar(3) DEFAULT NULL,
  `GRADS280` varchar(3) DEFAULT NULL,
  `GRADS281` varchar(3) DEFAULT NULL,
  `GRADS282` varchar(3) DEFAULT NULL,
  `GRADS283` varchar(3) DEFAULT NULL,
  `GRADS284` varchar(3) DEFAULT NULL,
  `GRADS285` varchar(3) DEFAULT NULL,
  `GRADS286` varchar(3) DEFAULT NULL,
  `GRADS287` varchar(3) DEFAULT NULL,
  `GRADS288` varchar(3) DEFAULT NULL,
  `GRADS289` varchar(3) DEFAULT NULL,
  `GRADS290` varchar(3) DEFAULT NULL,
  `GRADS291` varchar(3) DEFAULT NULL,
  `GRADS292` varchar(3) DEFAULT NULL,
  `GRADS293` varchar(3) DEFAULT NULL,
  `GRADS294` varchar(3) DEFAULT NULL,
  `GRADS295` varchar(3) DEFAULT NULL,
  `GRADS296` varchar(3) DEFAULT NULL,
  `GRADS297` varchar(3) DEFAULT NULL,
  `GRADS298` varchar(3) DEFAULT NULL,
  `GRADS299` varchar(3) DEFAULT NULL,
  `GRADS300` varchar(3) DEFAULT NULL,
  `GRADS301` varchar(3) DEFAULT NULL,
  `GRADS302` varchar(3) DEFAULT NULL,
  `GRADS303` varchar(3) DEFAULT NULL,
  `GRADS304` varchar(3) DEFAULT NULL,
  `GRADS305` varchar(3) DEFAULT NULL,
  `GRADS306` varchar(3) DEFAULT NULL,
  `GRADS307` varchar(3) DEFAULT NULL,
  `GRADS308` varchar(3) DEFAULT NULL,
  `GRADS309` varchar(3) DEFAULT NULL,
  `GRADS310` varchar(3) DEFAULT NULL,
  `CATEGORY` varchar(200) DEFAULT NULL,
  `CATEGORY2` varchar(200) DEFAULT NULL,
  `CATEGORY3` varchar(200) DEFAULT NULL,
  `CATEGORY4` varchar(200) DEFAULT NULL,
  `CATEGORY5` varchar(200) DEFAULT NULL,
  `CATEGORY6` varchar(200) DEFAULT NULL,
  `CATEGORY7` varchar(200) DEFAULT NULL,
  `CATEGORY8` varchar(200) DEFAULT NULL,
  `CATEGORY9` varchar(200) DEFAULT NULL,
  `CATEGORY10` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`WOS_GROUP`) USING BTREE,
  KEY `GROUPACC` (`WOS_GROUP`,`DESP`,`SALEC`,`SALECSC`,`SALECNC`,`PURC`,`PURPRC`,`METER_READ`) USING BTREE,
  KEY `GROUP1` (`WOS_GROUP`,`GRADD11`,`GRADD12`,`GRADD13`,`GRADD14`,`GRADD15`,`GRADD16`,`GRADD17`,`GRADS11`,`GRADS12`,`GRADS13`,`GRADS14`,`GRADS15`,`GRADS16`,`GRADS17`) USING BTREE,
  KEY `GROUP9` (`WOS_GROUP`,`GRADD67`,`GRADD68`,`GRADD69`,`GRADD70`,`GRADS67`,`GRADS68`,`GRADS69`,`GRADS70`) USING BTREE,
  KEY `GROUP2` (`WOS_GROUP`,`GRADD18`,`GRADD19`,`GRADD20`,`GRADD21`,`GRADD22`,`GRADD23`,`GRADD24`,`GRADS18`,`GRADS19`,`GRADS20`,`GRADS21`,`GRADS22`,`GRADS23`,`GRADS24`) USING BTREE,
  KEY `GROUP3` (`WOS_GROUP`,`GRADD25`,`GRADD26`,`GRADD27`,`GRADD28`,`GRADD29`,`GRADD30`,`GRADD31`,`GRADS25`,`GRADS26`,`GRADS27`,`GRADS28`,`GRADS29`,`GRADS30`,`GRADS31`) USING BTREE,
  KEY `GROUP8` (`WOS_GROUP`,`GRADD60`,`GRADD61`,`GRADD62`,`GRADD63`,`GRADD64`,`GRADD65`,`GRADD66`,`GRADS60`,`GRADS61`,`GRADS62`,`GRADS63`,`GRADS64`,`GRADS65`,`GRADS66`) USING BTREE,
  KEY `GROUP7` (`WOS_GROUP`,`GRADD53`,`GRADD54`,`GRADD55`,`GRADD56`,`GRADD57`,`GRADD58`,`GRADD59`,`GRADS53`,`GRADS54`,`GRADS55`,`GRADS56`,`GRADS57`,`GRADS58`,`GRADS59`) USING BTREE,
  KEY `GROUP6` (`WOS_GROUP`,`GRADD46`,`GRADD47`,`GRADD48`,`GRADD49`,`GRADD50`,`GRADD51`,`GRADD52`,`GRADS46`,`GRADS47`,`GRADS48`,`GRADS49`,`GRADS50`,`GRADS51`,`GRADS52`) USING BTREE,
  KEY `GROUP5` (`WOS_GROUP`,`GRADD39`,`GRADD40`,`GRADD41`,`GRADD42`,`GRADD43`,`GRADD44`,`GRADD45`,`GRADS39`,`GRADS40`,`GRADS41`,`GRADS42`,`GRADS43`,`GRADS44`,`GRADS45`) USING BTREE,
  KEY `GROUP4` (`WOS_GROUP`,`GRADD32`,`GRADD33`,`GRADD34`,`GRADD35`,`GRADD36`,`GRADD37`,`GRADD38`,`GRADS32`,`GRADS33`,`GRADS34`,`GRADS35`,`GRADS36`,`GRADS37`,`GRADS38`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `icgroup`
--

LOCK TABLES `icgroup` WRITE;
/*!40000 ALTER TABLE `icgroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `icgroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `icitem`
--

DROP TABLE IF EXISTS `icitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `icitem` (
  `EDI_ID` int(12) NOT NULL DEFAULT '0',
  `ITEMNO` varchar(60) NOT NULL DEFAULT '',
  `AITEMNO` varchar(40) DEFAULT NULL,
  `MITEMNO` varchar(20) DEFAULT NULL,
  `SHORTCODE` varchar(6) DEFAULT NULL,
  `DESP` varchar(100) DEFAULT NULL,
  `DESPA` varchar(100) DEFAULT NULL,
  `comment` text,
  `BRAND` varchar(40) DEFAULT NULL,
  `CATEGORY` varchar(80) DEFAULT '',
  `WOS_GROUP` varchar(50) DEFAULT '',
  `SHELF` varchar(25) DEFAULT '',
  `SUPP` varchar(12) DEFAULT NULL,
  `PACKING` varchar(20) DEFAULT NULL,
  `WEIGHT` double(12,7) NOT NULL DEFAULT '0.0000000',
  `COSTCODE` varchar(20) DEFAULT NULL,
  `UNIT` varchar(12) DEFAULT NULL,
  `UCOST` double(17,7) NOT NULL DEFAULT '0.0000000',
  `PRICE` double(17,7) NOT NULL DEFAULT '0.0000000',
  `PRICE2` double(17,7) NOT NULL DEFAULT '0.0000000',
  `PRICE3` double(17,7) NOT NULL DEFAULT '0.0000000',
  `PRICE_MIN` double(17,7) DEFAULT '0.0000000',
  `MINIMUM` double(17,7) NOT NULL DEFAULT '0.0000000',
  `MAXIMUM` double(17,7) NOT NULL DEFAULT '0.0000000',
  `REORDER` double(17,7) NOT NULL DEFAULT '0.0000000',
  `UNIT2` varchar(12) DEFAULT NULL,
  `COLORID` varchar(10) DEFAULT NULL,
  `SIZEID` varchar(20) DEFAULT NULL,
  `FACTOR1` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FACTOR2` double(17,7) NOT NULL DEFAULT '0.0000000',
  `PRICEU2` double(17,7) NOT NULL DEFAULT '0.0000000',
  `UNIT3` varchar(12) DEFAULT NULL,
  `FACTORU3_A` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FACTORU3_B` double(17,7) NOT NULL DEFAULT '0.0000000',
  `PRICEU3` double(17,7) NOT NULL DEFAULT '0.0000000',
  `UNIT4` varchar(12) DEFAULT NULL,
  `FACTORU4_A` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FACTORU4_B` double(17,7) NOT NULL DEFAULT '0.0000000',
  `PRICEU4` double(17,7) NOT NULL DEFAULT '0.0000000',
  `UNIT5` varchar(12) DEFAULT NULL,
  `FACTORU5_A` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FACTORU5_B` double(17,7) NOT NULL DEFAULT '0.0000000',
  `PRICEU5` double(17,7) NOT NULL DEFAULT '0.0000000',
  `UNIT6` varchar(12) DEFAULT NULL,
  `FACTORU6_A` double(17,7) NOT NULL DEFAULT '0.0000000',
  `FACTORU6_B` double(17,7) NOT NULL DEFAULT '0.0000000',
  `PRICEU6` double(17,7) NOT NULL DEFAULT '0.0000000',
  `DISPEC_A1` double(17,7) NOT NULL DEFAULT '0.0000000',
  `DISPEC_A2` double(17,7) NOT NULL DEFAULT '0.0000000',
  `DISPEC_A3` double(17,7) NOT NULL DEFAULT '0.0000000',
  `DISPEC_B1` double(17,7) NOT NULL DEFAULT '0.0000000',
  `DISPEC_B2` double(17,7) NOT NULL DEFAULT '0.0000000',
  `DISPEC_B3` double(17,7) NOT NULL DEFAULT '0.0000000',
  `DISPEC_C1` double(17,7) NOT NULL DEFAULT '0.0000000',
  `DISPEC_C2` double(17,7) NOT NULL DEFAULT '0.0000000',
  `DISPEC_C3` double(17,7) NOT NULL DEFAULT '0.0000000',
  `PRICE_CATA` double(17,7) NOT NULL DEFAULT '0.0000000',
  `PRICE_CATB` double(17,7) NOT NULL DEFAULT '0.0000000',
  `PRICE_CATC` double(17,7) NOT NULL DEFAULT '0.0000000',
  `COST_CATA` double(17,7) NOT NULL DEFAULT '0.0000000',
  `COST_CATB` double(17,7) NOT NULL DEFAULT '0.0000000',
  `COST_CATC` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QTY2` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QTY3` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QTY4` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QTY5` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QTY6` double(17,7) NOT NULL DEFAULT '0.0000000',
  `WQFORMULA` varchar(10) DEFAULT NULL,
  `WPFORMULA` varchar(10) DEFAULT NULL,
  `GRADED` char(1) DEFAULT NULL,
  `MURATIO` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QTYBF` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QTYNET` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QTYACTUAL` double(17,7) NOT NULL DEFAULT '0.0000000',
  `AVCOST` double(17,7) NOT NULL DEFAULT '0.0000000',
  `AVCOST2` double(17,7) NOT NULL DEFAULT '0.0000000',
  `BOM_COST` double(17,7) NOT NULL DEFAULT '0.0000000',
  `TQ_OBAL` double(17,7) NOT NULL DEFAULT '0.0000000',
  `TQ_IN` double(17,7) NOT NULL DEFAULT '0.0000000',
  `TQ_OUT` double(17,7) NOT NULL DEFAULT '0.0000000',
  `TQ_CBAL` double(17,7) NOT NULL DEFAULT '0.0000000',
  `T_UCOST` double(17,7) NOT NULL DEFAULT '0.0000000',
  `T_STKV` double(17,7) NOT NULL DEFAULT '0.0000000',
  `TQ_INV` double(17,7) NOT NULL DEFAULT '0.0000000',
  `TQ_CS` double(17,7) NOT NULL DEFAULT '0.0000000',
  `TQ_CN` double(17,7) NOT NULL DEFAULT '0.0000000',
  `TQ_DN` double(17,7) NOT NULL DEFAULT '0.0000000',
  `TQ_RC` double(17,7) NOT NULL DEFAULT '0.0000000',
  `TQ_PR` double(17,7) NOT NULL DEFAULT '0.0000000',
  `TQ_ISS` double(17,7) NOT NULL DEFAULT '0.0000000',
  `TQ_OAI` double(17,7) NOT NULL DEFAULT '0.0000000',
  `TQ_OAR` double(17,7) NOT NULL DEFAULT '0.0000000',
  `TA_INV` double(17,7) NOT NULL DEFAULT '0.0000000',
  `TA_CS` double(17,7) NOT NULL DEFAULT '0.0000000',
  `TA_CN` double(17,7) NOT NULL DEFAULT '0.0000000',
  `TA_DN` double(17,7) NOT NULL DEFAULT '0.0000000',
  `TA_RC` double(17,7) NOT NULL DEFAULT '0.0000000',
  `TA_PR` double(17,7) NOT NULL DEFAULT '0.0000000',
  `TA_ISS` double(17,7) NOT NULL DEFAULT '0.0000000',
  `TA_OAI` double(17,7) NOT NULL DEFAULT '0.0000000',
  `TA_OAR` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QIN11` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QIN12` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QIN13` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QIN14` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QIN15` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QIN16` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QIN17` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QIN18` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QIN19` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QIN20` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QIN21` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QIN22` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QIN23` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QIN24` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QIN25` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QIN26` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QIN27` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QIN28` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QOUT11` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QOUT12` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QOUT13` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QOUT14` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QOUT15` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QOUT16` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QOUT17` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QOUT18` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QOUT19` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QOUT20` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QOUT21` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QOUT22` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QOUT23` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QOUT24` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QOUT25` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QOUT26` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QOUT27` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QOUT28` double(17,7) NOT NULL DEFAULT '0.0000000',
  `SALEC` varchar(8) DEFAULT NULL,
  `SALECSC` varchar(8) DEFAULT NULL,
  `SALECNC` varchar(8) DEFAULT NULL,
  `PURC` varchar(8) DEFAULT NULL,
  `PURPREC` varchar(8) DEFAULT NULL,
  `TEMPFIG` double(17,7) NOT NULL DEFAULT '0.0000000',
  `TEMPFIG1` double(17,7) NOT NULL DEFAULT '0.0000000',
  `CT_RATING` char(1) DEFAULT NULL,
  `POINT` double(12,4) NOT NULL DEFAULT '0.0000',
  `QCPOINT` double(12,4) NOT NULL DEFAULT '0.0000',
  `AWARD1` double(10,7) NOT NULL DEFAULT '0.0000000',
  `AWARD2` double(10,7) NOT NULL DEFAULT '0.0000000',
  `AWARD3` double(10,7) NOT NULL DEFAULT '0.0000000',
  `AWARD4` double(10,7) NOT NULL DEFAULT '0.0000000',
  `AWARD5` double(10,7) NOT NULL DEFAULT '0.0000000',
  `AWARD6` double(10,7) NOT NULL DEFAULT '0.0000000',
  `AWARD7` double(10,7) NOT NULL DEFAULT '0.0000000',
  `AWARD8` double(10,7) NOT NULL DEFAULT '0.0000000',
  `REMARK1` varchar(100) DEFAULT NULL,
  `REMARK2` varchar(100) DEFAULT NULL,
  `REMARK3` varchar(100) DEFAULT NULL,
  `REMARK4` varchar(100) DEFAULT NULL,
  `REMARK5` varchar(100) DEFAULT NULL,
  `REMARK6` varchar(100) DEFAULT NULL,
  `REMARK7` varchar(100) DEFAULT NULL,
  `REMARK8` varchar(100) DEFAULT NULL,
  `REMARK9` varchar(100) DEFAULT NULL,
  `REMARK10` varchar(100) DEFAULT NULL,
  `REMARK11` varchar(100) DEFAULT NULL,
  `REMARK12` varchar(100) DEFAULT NULL,
  `REMARK13` varchar(100) DEFAULT NULL,
  `REMARK14` varchar(100) DEFAULT NULL,
  `REMARK15` varchar(100) DEFAULT NULL,
  `REMARK16` varchar(100) DEFAULT NULL,
  `REMARK17` varchar(100) DEFAULT NULL,
  `REMARK18` varchar(100) DEFAULT NULL,
  `REMARK19` varchar(100) DEFAULT NULL,
  `REMARK20` varchar(100) DEFAULT NULL,
  `REMARK21` varchar(100) DEFAULT NULL,
  `REMARK22` varchar(100) DEFAULT NULL,
  `REMARK23` varchar(100) DEFAULT NULL,
  `REMARK24` varchar(100) DEFAULT NULL,
  `REMARK25` varchar(100) DEFAULT NULL,
  `REMARK26` varchar(100) DEFAULT NULL,
  `REMARK27` varchar(100) DEFAULT NULL,
  `REMARK28` varchar(100) DEFAULT NULL,
  `REMARK29` varchar(100) DEFAULT NULL,
  `REMARK30` varchar(100) DEFAULT NULL,
  `COMMRATE1` double(10,4) NOT NULL DEFAULT '0.0000',
  `COMMRATE2` double(10,4) NOT NULL DEFAULT '0.0000',
  `COMMRATE3` double(10,4) NOT NULL DEFAULT '0.0000',
  `COMMRATE4` double(10,4) NOT NULL DEFAULT '0.0000',
  `WOS_DATE` date NOT NULL DEFAULT '0000-00-00',
  `QTYDEC` double(10,4) NOT NULL DEFAULT '0.0000',
  `TEMP_QTY` double(10,4) NOT NULL DEFAULT '0.0000',
  `QTY` double(10,4) NOT NULL DEFAULT '0.0000',
  `PHOTO` varchar(100) DEFAULT NULL,
  `COMPEC_A` double(12,4) NOT NULL DEFAULT '0.0000',
  `COMPEC_B` double(12,4) NOT NULL DEFAULT '0.0000',
  `COMPEC_C` double(12,4) NOT NULL DEFAULT '0.0000',
  `WOS_TIME` date NOT NULL DEFAULT '0000-00-00',
  `EXPIRED` double(12,3) NOT NULL DEFAULT '0.000',
  `WSERIALNO` char(1) DEFAULT '0',
  `PROMOTOR` varchar(8) DEFAULT '',
  `TAXABLE` char(1) DEFAULT NULL,
  `TAXPERC1` double(6,2) NOT NULL DEFAULT '0.00',
  `TAXPERC2` double(6,2) NOT NULL DEFAULT '0.00',
  `NONSTKITEM` char(1) DEFAULT NULL,
  `GRAPHIC` varchar(100) DEFAULT NULL,
  `PRODCODE` varchar(40) DEFAULT NULL,
  `BRK_TO` varchar(20) DEFAULT NULL,
  `COLOR` varchar(20) DEFAULT NULL,
  `SIZE` varchar(20) DEFAULT NULL,
  `fcurrcode` varchar(45) DEFAULT NULL,
  `fucost` double(17,7) DEFAULT NULL,
  `fprice` double(17,7) DEFAULT NULL,
  `qtybf_actual` varchar(10) DEFAULT NULL,
  `commlvl` varchar(45) DEFAULT '',
  `CREATED_BY` varchar(50) DEFAULT NULL,
  `CREATED_ON` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UPDATED_BY` varchar(50) DEFAULT NULL,
  `UPDATED_ON` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `costformula` varchar(45) NOT NULL DEFAULT '',
  `PRICE4` double(17,7) NOT NULL DEFAULT '0.0000000',
  `taxcode` varchar(45) DEFAULT '',
  `custprice_rate` varchar(45) DEFAULT '',
  `itemtype` varchar(45) DEFAULT '',
  `Barcode` varchar(80) DEFAULT NULL,
  `fucost2` double(17,7) NOT NULL DEFAULT '0.0000000',
  `fprice2` double(17,7) NOT NULL DEFAULT '0.0000000',
  `fcurrcode2` varchar(45) DEFAULT NULL,
  `fucost3` double(17,7) NOT NULL DEFAULT '0.0000000',
  `fprice3` double(17,7) NOT NULL DEFAULT '0.0000000',
  `fcurrcode3` varchar(45) DEFAULT NULL,
  `fucost4` double(17,7) NOT NULL DEFAULT '0.0000000',
  `fprice4` double(17,7) NOT NULL DEFAULT '0.0000000',
  `fcurrcode4` varchar(45) DEFAULT NULL,
  `fucost5` double(17,7) NOT NULL DEFAULT '0.0000000',
  `fprice5` double(17,7) NOT NULL DEFAULT '0.0000000',
  `fcurrcode5` varchar(45) DEFAULT NULL,
  `fucost6` double(17,7) NOT NULL DEFAULT '0.0000000',
  `fprice6` double(17,7) NOT NULL DEFAULT '0.0000000',
  `fcurrcode6` varchar(45) DEFAULT NULL,
  `fucost7` double(17,7) NOT NULL DEFAULT '0.0000000',
  `fprice7` double(17,7) NOT NULL DEFAULT '0.0000000',
  `fcurrcode7` varchar(45) DEFAULT NULL,
  `fucost8` double(17,7) NOT NULL DEFAULT '0.0000000',
  `fprice8` double(17,7) NOT NULL DEFAULT '0.0000000',
  `fcurrcode8` varchar(45) DEFAULT NULL,
  `fucost9` double(17,7) NOT NULL DEFAULT '0.0000000',
  `fprice9` double(17,7) NOT NULL DEFAULT '0.0000000',
  `fcurrcode9` varchar(45) DEFAULT NULL,
  `fucost10` double(17,7) NOT NULL DEFAULT '0.0000000',
  `fprice10` double(17,7) NOT NULL DEFAULT '0.0000000',
  `fcurrcode10` varchar(45) DEFAULT NULL,
  `packingdesp1` varchar(100) DEFAULT NULL,
  `packingqty1` double(17,7) NOT NULL DEFAULT '0.0000000',
  `packingfreeqty1` double(17,7) NOT NULL DEFAULT '0.0000000',
  `packingdesp2` varchar(100) DEFAULT NULL,
  `packingqty2` double(17,7) NOT NULL DEFAULT '0.0000000',
  `packingfreeqty2` double(17,7) NOT NULL DEFAULT '0.0000000',
  `packingdesp3` varchar(100) DEFAULT NULL,
  `packingqty3` double(17,7) NOT NULL DEFAULT '0.0000000',
  `packingfreeqty3` double(17,7) NOT NULL DEFAULT '0.0000000',
  `packingdesp4` varchar(100) DEFAULT NULL,
  `packingqty4` double(17,7) NOT NULL DEFAULT '0.0000000',
  `packingfreeqty4` double(17,7) NOT NULL DEFAULT '0.0000000',
  `packingdesp5` varchar(100) DEFAULT NULL,
  `packingqty5` double(17,7) NOT NULL DEFAULT '0.0000000',
  `packingfreeqty5` double(17,7) NOT NULL DEFAULT '0.0000000',
  `packingdesp6` varchar(100) DEFAULT '',
  `packingqty6` double(17,7) NOT NULL DEFAULT '0.0000000',
  `packingfreeqty6` double(17,7) NOT NULL DEFAULT '0.0000000',
  `packingdesp7` varchar(100) DEFAULT '',
  `packingqty7` double(17,7) NOT NULL DEFAULT '0.0000000',
  `packingfreeqty7` double(17,7) NOT NULL DEFAULT '0.0000000',
  `packingdesp8` varchar(100) DEFAULT '',
  `packingqty8` double(17,7) NOT NULL DEFAULT '0.0000000',
  `packingfreeqty8` double(17,7) NOT NULL DEFAULT '0.0000000',
  `packingdesp9` varchar(100) DEFAULT '',
  `packingqty9` double(17,7) NOT NULL DEFAULT '0.0000000',
  `packingfreeqty9` double(17,7) NOT NULL DEFAULT '0.0000000',
  `packingdesp10` varchar(100) DEFAULT '',
  `packingqty10` double(17,7) NOT NULL DEFAULT '0.0000000',
  `packingfreeqty10` double(17,7) NOT NULL DEFAULT '0.0000000',
  PRIMARY KEY (`ITEMNO`),
  KEY `COSTING` (`ITEMNO`,`UCOST`,`QTYBF`,`AVCOST`,`AVCOST2`),
  KEY `ITEMAGING1` (`ITEMNO`,`QTYBF`,`QIN11`,`QIN12`,`QIN13`,`QIN14`,`QIN15`,`QIN16`,`QIN17`,`QOUT11`,`QOUT12`,`QOUT13`,`QOUT14`,`QOUT15`,`QOUT16`,`QOUT17`),
  KEY `ITEMAGING2` (`ITEMNO`,`QTYBF`,`QIN18`,`QIN19`,`QIN20`,`QIN21`,`QIN22`,`QIN23`,`QIN24`,`QOUT18`,`QOUT19`,`QOUT20`,`QOUT21`,`QOUT22`,`QOUT23`,`QOUT24`),
  KEY `ITEMAGING3` (`ITEMNO`,`QTYBF`,`QIN25`,`QIN26`,`QIN27`,`QIN28`,`QOUT25`,`QOUT26`,`QOUT27`,`QOUT28`),
  KEY `ITEMINFO` (`ITEMNO`,`DESP`,`SHELF`,`COSTCODE`,`UNIT`,`COLORID`,`SIZEID`,`GRADED`,`WSERIALNO`,`NONSTKITEM`,`COLOR`,`SIZE`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `icitem`
--

LOCK TABLES `icitem` WRITE;
/*!40000 ALTER TABLE `icitem` DISABLE KEYS */;
INSERT INTO `icitem` VALUES (0,'Tokio Marine','',NULL,NULL,'Tokio Marine Motor Insurance','','','','','','','','',0.0000000,'','',0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,'','','',1.0000000,1.0000000,0.0000000,'',1.0000000,1.0000000,0.0000000,'',1.0000000,1.0000000,0.0000000,'',1.0000000,1.0000000,0.0000000,'',1.0000000,1.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,'','','N',0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,'','','','','',0.0000000,0.0000000,NULL,0.0000,0.0000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',0.0000,0.0000,0.0000,0.0000,'2012-01-16',0.0000,0.0000,0.0000,'',0.0000,0.0000,0.0000,'0000-00-00',0.000,'','',NULL,0.00,0.00,'',NULL,NULL,NULL,NULL,NULL,'',0.0000000,0.0000000,NULL,'Choose a Commission Level','Demoinsurance','2012-01-16 09:57:54','Demoinsurance','2012-01-19 06:57:50','',0.0000000,'','','',NULL,0.0000000,0.0000000,NULL,0.0000000,0.0000000,NULL,0.0000000,0.0000000,NULL,0.0000000,0.0000000,NULL,0.0000000,0.0000000,NULL,0.0000000,0.0000000,NULL,0.0000000,0.0000000,NULL,0.0000000,0.0000000,NULL,0.0000000,0.0000000,NULL,NULL,0.0000000,0.0000000,NULL,0.0000000,0.0000000,NULL,0.0000000,0.0000000,NULL,0.0000000,0.0000000,NULL,0.0000000,0.0000000,'',0.0000000,0.0000000,'',0.0000000,0.0000000,'',0.0000000,0.0000000,'',0.0000000,0.0000000,'',0.0000000,0.0000000),(0,'Great Eastern','',NULL,NULL,'Great Eastern Motor Insurance','','','','','','','','',0.0000000,'','',0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,'','','',1.0000000,1.0000000,0.0000000,'',1.0000000,1.0000000,0.0000000,'',1.0000000,1.0000000,0.0000000,'',1.0000000,1.0000000,0.0000000,'',1.0000000,1.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,'','','N',0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,1.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,'','','','','',0.0000000,0.0000000,NULL,0.0000,0.0000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',0.0000,0.0000,0.0000,0.0000,'2012-01-16',0.0000,0.0000,0.0000,'',0.0000,0.0000,0.0000,'0000-00-00',0.000,'','',NULL,0.00,0.00,'',NULL,NULL,NULL,NULL,NULL,'',0.0000000,0.0000000,NULL,'Choose a Commission Level','Demoinsurance','2012-01-16 10:00:54','Demoinsurance','2012-01-19 06:57:37','',0.0000000,'','','',NULL,0.0000000,0.0000000,NULL,0.0000000,0.0000000,NULL,0.0000000,0.0000000,NULL,0.0000000,0.0000000,NULL,0.0000000,0.0000000,NULL,0.0000000,0.0000000,NULL,0.0000000,0.0000000,NULL,0.0000000,0.0000000,NULL,0.0000000,0.0000000,NULL,NULL,0.0000000,0.0000000,NULL,0.0000000,0.0000000,NULL,0.0000000,0.0000000,NULL,0.0000000,0.0000000,NULL,0.0000000,0.0000000,'',0.0000000,0.0000000,'',0.0000000,0.0000000,'',0.0000000,0.0000000,'',0.0000000,0.0000000,'',0.0000000,0.0000000),(0,'Great Eastern Home Insurance','',NULL,NULL,'Great Eastern Home Insurance','','','','','','','','',0.0000000,'','',0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,'','','',1.0000000,1.0000000,0.0000000,'',1.0000000,1.0000000,0.0000000,'',1.0000000,1.0000000,0.0000000,'',1.0000000,1.0000000,0.0000000,'',1.0000000,1.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,'0','0','N',0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,'','','','','',0.0000000,0.0000000,NULL,0.0000,0.0000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',0.0000,0.0000,0.0000,0.0000,'2012-01-19',0.0000,0.0000,0.0000,'',0.0000,0.0000,0.0000,'0000-00-00',0.000,'F','',NULL,0.00,0.00,'',NULL,NULL,NULL,NULL,NULL,'',0.0000000,0.0000000,NULL,'Choose a Commission Level','Demoinsurance','2012-01-19 06:58:43',NULL,'0000-00-00 00:00:00','',0.0000000,'','','',NULL,0.0000000,0.0000000,NULL,0.0000000,0.0000000,NULL,0.0000000,0.0000000,NULL,0.0000000,0.0000000,NULL,0.0000000,0.0000000,NULL,0.0000000,0.0000000,NULL,0.0000000,0.0000000,NULL,0.0000000,0.0000000,NULL,0.0000000,0.0000000,NULL,NULL,0.0000000,0.0000000,NULL,0.0000000,0.0000000,NULL,0.0000000,0.0000000,NULL,0.0000000,0.0000000,NULL,0.0000000,0.0000000,'',0.0000000,0.0000000,'',0.0000000,0.0000000,'',0.0000000,0.0000000,'',0.0000000,0.0000000,'',0.0000000,0.0000000),(0,'Tokio Marine Home Insurance','',NULL,NULL,'Tokio Marine Home Insurance','','','','','','','','',0.0000000,'','',0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,'','','',1.0000000,1.0000000,0.0000000,'',1.0000000,1.0000000,0.0000000,'',1.0000000,1.0000000,0.0000000,'',1.0000000,1.0000000,0.0000000,'',1.0000000,1.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,'0','0','N',0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,'','','','','',0.0000000,0.0000000,NULL,0.0000,0.0000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',0.0000,0.0000,0.0000,0.0000,'2012-01-19',0.0000,0.0000,0.0000,'',0.0000,0.0000,0.0000,'0000-00-00',0.000,'F','',NULL,0.00,0.00,'',NULL,NULL,NULL,NULL,NULL,'',0.0000000,0.0000000,NULL,'Choose a Commission Level','Demoinsurance','2012-01-19 06:59:00',NULL,'0000-00-00 00:00:00','',0.0000000,'','','',NULL,0.0000000,0.0000000,NULL,0.0000000,0.0000000,NULL,0.0000000,0.0000000,NULL,0.0000000,0.0000000,NULL,0.0000000,0.0000000,NULL,0.0000000,0.0000000,NULL,0.0000000,0.0000000,NULL,0.0000000,0.0000000,NULL,0.0000000,0.0000000,NULL,NULL,0.0000000,0.0000000,NULL,0.0000000,0.0000000,NULL,0.0000000,0.0000000,NULL,0.0000000,0.0000000,NULL,0.0000000,0.0000000,'',0.0000000,0.0000000,'',0.0000000,0.0000000,'',0.0000000,0.0000000,'',0.0000000,0.0000000,'',0.0000000,0.0000000);
/*!40000 ALTER TABLE `icitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `icitem_last_year`
--

DROP TABLE IF EXISTS `icitem_last_year`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `icitem_last_year` (
  `EDI_ID` int(12) unsigned NOT NULL DEFAULT '0' COMMENT 'Date Of Year End',
  `ITEMNO` varchar(60) NOT NULL DEFAULT '',
  `AITEMNO` varchar(40) DEFAULT NULL,
  `MITEMNO` varchar(20) DEFAULT NULL,
  `SHORTCODE` varchar(6) DEFAULT NULL,
  `DESP` varchar(60) DEFAULT NULL,
  `DESPA` varchar(70) DEFAULT NULL,
  `BRAND` varchar(40) DEFAULT NULL,
  `CATEGORY` varchar(80) DEFAULT '',
  `WOS_GROUP` varchar(50) DEFAULT '',
  `SHELF` varchar(8) DEFAULT NULL,
  `SUPP` varchar(12) DEFAULT NULL,
  `PACKING` varchar(20) DEFAULT NULL,
  `WEIGHT` double(12,7) DEFAULT '0.0000000',
  `COSTCODE` varchar(20) DEFAULT NULL,
  `UNIT` varchar(12) DEFAULT NULL,
  `UCOST` double(17,7) DEFAULT '0.0000000',
  `PRICE` double(17,7) DEFAULT '0.0000000',
  `PRICE2` double(17,7) DEFAULT '0.0000000',
  `PRICE3` double(17,7) DEFAULT '0.0000000',
  `PRICE_MIN` double(17,7) DEFAULT '0.0000000',
  `MINIMUM` double(17,7) DEFAULT '0.0000000',
  `MAXIMUM` double(17,7) DEFAULT '0.0000000',
  `REORDER` double(17,7) DEFAULT '0.0000000',
  `UNIT2` varchar(12) DEFAULT NULL,
  `COLORID` varchar(10) DEFAULT NULL,
  `SIZEID` varchar(10) DEFAULT NULL,
  `FACTOR1` double(17,7) DEFAULT '0.0000000',
  `FACTOR2` double(17,7) DEFAULT '0.0000000',
  `PRICEU2` double(17,7) DEFAULT '0.0000000',
  `UNIT3` varchar(12) DEFAULT NULL,
  `FACTORU3_A` double(17,7) DEFAULT '0.0000000',
  `FACTORU3_B` double(17,7) DEFAULT '0.0000000',
  `PRICEU3` double(17,7) DEFAULT '0.0000000',
  `UNIT4` varchar(12) DEFAULT NULL,
  `FACTORU4_A` double(17,7) DEFAULT '0.0000000',
  `FACTORU4_B` double(17,7) DEFAULT '0.0000000',
  `PRICEU4` double(17,7) DEFAULT '0.0000000',
  `UNIT5` varchar(12) DEFAULT NULL,
  `FACTORU5_A` double(17,7) DEFAULT '0.0000000',
  `FACTORU5_B` double(17,7) DEFAULT '0.0000000',
  `PRICEU5` double(17,7) DEFAULT '0.0000000',
  `UNIT6` varchar(12) DEFAULT NULL,
  `FACTORU6_A` double(17,7) DEFAULT '0.0000000',
  `FACTORU6_B` double(17,7) DEFAULT '0.0000000',
  `PRICEU6` double(17,7) DEFAULT '0.0000000',
  `DISPEC_A1` double(17,7) DEFAULT '0.0000000',
  `DISPEC_A2` double(17,7) DEFAULT '0.0000000',
  `DISPEC_A3` double(17,7) DEFAULT '0.0000000',
  `DISPEC_B1` double(17,7) DEFAULT '0.0000000',
  `DISPEC_B2` double(17,7) DEFAULT '0.0000000',
  `DISPEC_B3` double(17,7) DEFAULT '0.0000000',
  `DISPEC_C1` double(17,7) DEFAULT '0.0000000',
  `DISPEC_C2` double(17,7) DEFAULT '0.0000000',
  `DISPEC_C3` double(17,7) DEFAULT '0.0000000',
  `PRICE_CATA` double(17,7) DEFAULT '0.0000000',
  `PRICE_CATB` double(17,7) DEFAULT '0.0000000',
  `PRICE_CATC` double(17,7) DEFAULT '0.0000000',
  `COST_CATA` double(17,7) DEFAULT '0.0000000',
  `COST_CATB` double(17,7) DEFAULT '0.0000000',
  `COST_CATC` double(17,7) DEFAULT '0.0000000',
  `QTY2` double(17,7) DEFAULT '0.0000000',
  `QTY3` double(17,7) DEFAULT '0.0000000',
  `QTY4` double(17,7) DEFAULT '0.0000000',
  `QTY5` double(17,7) DEFAULT '0.0000000',
  `QTY6` double(17,7) DEFAULT '0.0000000',
  `WQFORMULA` varchar(10) DEFAULT NULL,
  `WPFORMULA` varchar(10) DEFAULT NULL,
  `GRADED` char(1) DEFAULT NULL,
  `MURATIO` double(17,7) DEFAULT '0.0000000',
  `QTYBF` double(17,7) DEFAULT '0.0000000',
  `QTYNET` double(17,7) DEFAULT '0.0000000',
  `QTYACTUAL` double(17,7) DEFAULT '0.0000000',
  `AVCOST` double(17,7) DEFAULT '0.0000000',
  `AVCOST2` double(17,7) DEFAULT '0.0000000',
  `BOM_COST` double(17,7) DEFAULT '0.0000000',
  `TQ_OBAL` double(17,7) DEFAULT '0.0000000',
  `TQ_IN` double(17,7) DEFAULT '0.0000000',
  `TQ_OUT` double(17,7) DEFAULT '0.0000000',
  `TQ_CBAL` double(17,7) DEFAULT '0.0000000',
  `T_UCOST` double(17,7) DEFAULT '0.0000000',
  `T_STKV` double(17,7) DEFAULT '0.0000000',
  `TQ_INV` double(17,7) DEFAULT '0.0000000',
  `TQ_CS` double(17,7) DEFAULT '0.0000000',
  `TQ_CN` double(17,7) DEFAULT '0.0000000',
  `TQ_DN` double(17,7) DEFAULT '0.0000000',
  `TQ_RC` double(17,7) DEFAULT '0.0000000',
  `TQ_PR` double(17,7) DEFAULT '0.0000000',
  `TQ_ISS` double(17,7) DEFAULT '0.0000000',
  `TQ_OAI` double(17,7) DEFAULT '0.0000000',
  `TQ_OAR` double(17,7) DEFAULT '0.0000000',
  `TA_INV` double(17,7) DEFAULT '0.0000000',
  `TA_CS` double(17,7) DEFAULT '0.0000000',
  `TA_CN` double(17,7) DEFAULT '0.0000000',
  `TA_DN` double(17,7) DEFAULT '0.0000000',
  `TA_RC` double(17,7) DEFAULT '0.0000000',
  `TA_PR` double(17,7) DEFAULT '0.0000000',
  `TA_ISS` double(17,7) DEFAULT '0.0000000',
  `TA_OAI` double(17,7) DEFAULT '0.0000000',
  `TA_OAR` double(17,7) DEFAULT '0.0000000',
  `QIN11` double(17,7) DEFAULT '0.0000000',
  `QIN12` double(17,7) DEFAULT '0.0000000',
  `QIN13` double(17,7) DEFAULT '0.0000000',
  `QIN14` double(17,7) DEFAULT '0.0000000',
  `QIN15` double(17,7) DEFAULT '0.0000000',
  `QIN16` double(17,7) DEFAULT '0.0000000',
  `QIN17` double(17,7) DEFAULT '0.0000000',
  `QIN18` double(17,7) DEFAULT '0.0000000',
  `QIN19` double(17,7) DEFAULT '0.0000000',
  `QIN20` double(17,7) DEFAULT '0.0000000',
  `QIN21` double(17,7) DEFAULT '0.0000000',
  `QIN22` double(17,7) DEFAULT '0.0000000',
  `QIN23` double(17,7) DEFAULT '0.0000000',
  `QIN24` double(17,7) DEFAULT '0.0000000',
  `QIN25` double(17,7) DEFAULT '0.0000000',
  `QIN26` double(17,7) DEFAULT '0.0000000',
  `QIN27` double(17,7) DEFAULT '0.0000000',
  `QIN28` double(17,7) DEFAULT '0.0000000',
  `QOUT11` double(17,7) DEFAULT '0.0000000',
  `QOUT12` double(17,7) DEFAULT '0.0000000',
  `QOUT13` double(17,7) DEFAULT '0.0000000',
  `QOUT14` double(17,7) DEFAULT '0.0000000',
  `QOUT15` double(17,7) DEFAULT '0.0000000',
  `QOUT16` double(17,7) DEFAULT '0.0000000',
  `QOUT17` double(17,7) DEFAULT '0.0000000',
  `QOUT18` double(17,7) DEFAULT '0.0000000',
  `QOUT19` double(17,7) DEFAULT '0.0000000',
  `QOUT20` double(17,7) DEFAULT '0.0000000',
  `QOUT21` double(17,7) DEFAULT '0.0000000',
  `QOUT22` double(17,7) DEFAULT '0.0000000',
  `QOUT23` double(17,7) DEFAULT '0.0000000',
  `QOUT24` double(17,7) DEFAULT '0.0000000',
  `QOUT25` double(17,7) DEFAULT '0.0000000',
  `QOUT26` double(17,7) DEFAULT '0.0000000',
  `QOUT27` double(17,7) DEFAULT '0.0000000',
  `QOUT28` double(17,7) DEFAULT '0.0000000',
  `SALEC` varchar(8) DEFAULT NULL,
  `SALECSC` varchar(8) DEFAULT NULL,
  `SALECNC` varchar(8) DEFAULT NULL,
  `PURC` varchar(8) DEFAULT NULL,
  `PURPREC` varchar(8) DEFAULT NULL,
  `TEMPFIG` double(17,7) DEFAULT '0.0000000',
  `TEMPFIG1` double(17,7) DEFAULT '0.0000000',
  `CT_RATING` char(1) DEFAULT NULL,
  `POINT` double(12,4) DEFAULT '0.0000',
  `QCPOINT` double(12,4) DEFAULT '0.0000',
  `AWARD1` double(10,7) DEFAULT '0.0000000',
  `AWARD2` double(10,7) DEFAULT '0.0000000',
  `AWARD3` double(10,7) DEFAULT '0.0000000',
  `AWARD4` double(10,7) DEFAULT '0.0000000',
  `AWARD5` double(10,7) DEFAULT '0.0000000',
  `AWARD6` double(10,7) DEFAULT '0.0000000',
  `AWARD7` double(10,7) DEFAULT '0.0000000',
  `AWARD8` double(10,7) DEFAULT '0.0000000',
  `REMARK1` varchar(50) DEFAULT NULL,
  `REMARK2` varchar(50) DEFAULT NULL,
  `REMARK3` varchar(50) DEFAULT NULL,
  `REMARK4` varchar(50) DEFAULT NULL,
  `REMARK5` varchar(50) DEFAULT NULL,
  `REMARK6` varchar(50) DEFAULT NULL,
  `REMARK7` varchar(50) DEFAULT NULL,
  `REMARK8` varchar(50) DEFAULT NULL,
  `REMARK9` varchar(50) DEFAULT NULL,
  `REMARK10` varchar(50) DEFAULT NULL,
  `REMARK11` varchar(50) DEFAULT NULL,
  `REMARK12` varchar(50) DEFAULT NULL,
  `REMARK13` varchar(50) DEFAULT NULL,
  `REMARK14` varchar(50) DEFAULT NULL,
  `REMARK15` varchar(50) DEFAULT NULL,
  `REMARK16` varchar(50) DEFAULT NULL,
  `REMARK17` varchar(50) DEFAULT NULL,
  `REMARK18` varchar(50) DEFAULT NULL,
  `REMARK19` varchar(50) DEFAULT NULL,
  `REMARK20` varchar(50) DEFAULT NULL,
  `REMARK21` varchar(50) DEFAULT NULL,
  `REMARK22` varchar(50) DEFAULT NULL,
  `REMARK23` varchar(50) DEFAULT NULL,
  `REMARK24` varchar(50) DEFAULT NULL,
  `REMARK25` varchar(50) DEFAULT NULL,
  `REMARK26` varchar(50) DEFAULT NULL,
  `REMARK27` varchar(50) DEFAULT NULL,
  `REMARK28` varchar(50) DEFAULT NULL,
  `REMARK29` varchar(50) DEFAULT NULL,
  `REMARK30` varchar(50) DEFAULT NULL,
  `COMMRATE1` double(10,4) DEFAULT '0.0000',
  `COMMRATE2` double(10,4) DEFAULT '0.0000',
  `COMMRATE3` double(10,4) DEFAULT '0.0000',
  `COMMRATE4` double(10,4) DEFAULT '0.0000',
  `WOS_DATE` date DEFAULT '0000-00-00',
  `QTYDEC` double(10,4) DEFAULT '0.0000',
  `TEMP_QTY` double(10,4) DEFAULT '0.0000',
  `QTY` double(10,4) DEFAULT '0.0000',
  `PHOTO` varchar(100) DEFAULT NULL,
  `COMPEC_A` double(12,4) DEFAULT '0.0000',
  `COMPEC_B` double(12,4) DEFAULT '0.0000',
  `COMPEC_C` double(12,4) DEFAULT '0.0000',
  `WOS_TIME` date DEFAULT '0000-00-00',
  `EXPIRED` double(12,3) DEFAULT '0.000',
  `WSERIALNO` char(1) DEFAULT '0',
  `PROMOTOR` varchar(8) DEFAULT NULL,
  `TAXABLE` char(1) DEFAULT NULL,
  `TAXPERC1` double(6,2) DEFAULT '0.00',
  `TAXPERC2` double(6,2) DEFAULT '0.00',
  `NONSTKITEM` char(1) DEFAULT NULL,
  `GRAPHIC` varchar(100) DEFAULT NULL,
  `PRODCODE` varchar(40) DEFAULT NULL,
  `BRK_TO` varchar(20) DEFAULT NULL,
  `COLOR` varchar(20) DEFAULT NULL,
  `SIZE` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ITEMNO`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `icitem_last_year`
--

LOCK TABLES `icitem_last_year` WRITE;
/*!40000 ALTER TABLE `icitem_last_year` DISABLE KEYS */;
/*!40000 ALTER TABLE `icitem_last_year` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `icitem_temp`
--

DROP TABLE IF EXISTS `icitem_temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `icitem_temp` (
  `ITEMNO` varchar(60) NOT NULL DEFAULT '',
  `DESP` varchar(60) NOT NULL DEFAULT '',
  `DESPA` varchar(70) NOT NULL DEFAULT '',
  `AITEMNO` varchar(40) NOT NULL DEFAULT '',
  `BRAND` varchar(40) NOT NULL DEFAULT '',
  `SUPP` varchar(12) NOT NULL DEFAULT '',
  `CATEGORY` varchar(8) NOT NULL DEFAULT '',
  `WOS_GROUP` varchar(25) NOT NULL DEFAULT '',
  `SIZEID` varchar(10) NOT NULL DEFAULT '',
  `COSTCODE` varchar(20) NOT NULL DEFAULT '',
  `COLORID` varchar(10) NOT NULL DEFAULT '',
  `SHELF` varchar(8) NOT NULL DEFAULT '',
  `PACKING` varchar(20) NOT NULL DEFAULT '',
  `MINIMUM` double(17,7) NOT NULL DEFAULT '0.0000000',
  `MAXIMUM` double(17,7) NOT NULL DEFAULT '0.0000000',
  `REORDER` double(17,7) NOT NULL DEFAULT '0.0000000',
  `UNIT` varchar(12) NOT NULL DEFAULT '',
  `UCOST` double(17,7) NOT NULL DEFAULT '0.0000000',
  `PRICE` double(17,7) NOT NULL DEFAULT '0.0000000',
  `PRICE2` double(17,7) NOT NULL DEFAULT '0.0000000',
  `WSERIALNO` char(1) NOT NULL DEFAULT '',
  `GRADED` char(1) NOT NULL DEFAULT '',
  `QTY2` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QTY3` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QTY4` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QTY5` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QTY6` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QTYBF` double(17,7) NOT NULL DEFAULT '0.0000000',
  `SALEC` varchar(8) NOT NULL DEFAULT '',
  `SALECSC` varchar(8) NOT NULL DEFAULT '',
  `SALECNC` varchar(8) NOT NULL DEFAULT '',
  `PURC` varchar(8) NOT NULL DEFAULT '',
  `PURPREC` varchar(8) NOT NULL DEFAULT '',
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `STATUS` char(1) NOT NULL DEFAULT '',
  `CREATED_ON` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `unit2` varchar(100) NOT NULL DEFAULT '',
  `factor1` double(17,7) NOT NULL DEFAULT '0.0000000',
  `factor2` double(17,7) NOT NULL DEFAULT '0.0000000',
  `priceu2` double(17,7) NOT NULL DEFAULT '0.0000000',
  `remark1` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `icitem_temp`
--

LOCK TABLES `icitem_temp` WRITE;
/*!40000 ALTER TABLE `icitem_temp` DISABLE KEYS */;
/*!40000 ALTER TABLE `icitem_temp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `icl3p`
--

DROP TABLE IF EXISTS `icl3p`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `icl3p` (
  `EDI_ID` varchar(12) NOT NULL DEFAULT '',
  `ITEMNO` varchar(60) NOT NULL DEFAULT '',
  `CUSTNO` varchar(12) NOT NULL DEFAULT '',
  `AGENNO` varchar(12) NOT NULL DEFAULT '',
  `PRICE` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  `DISPEC` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DISPEC2` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DISPEC3` decimal(5,2) NOT NULL DEFAULT '0.00',
  `CI_NOTE` varchar(24) NOT NULL DEFAULT '',
  `LDATE1` date NOT NULL DEFAULT '0000-00-00',
  `LTYPE1` varchar(4) NOT NULL DEFAULT '',
  `LREFNO1` varchar(8) NOT NULL DEFAULT '',
  `LQTY1` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  `LPRICE1` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  `LDISPEC11` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDISPEC21` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDISPEC31` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDATE2` date NOT NULL DEFAULT '0000-00-00',
  `LTYPE2` varchar(4) NOT NULL DEFAULT '',
  `LREFNO2` varchar(8) NOT NULL DEFAULT '',
  `LQTY2` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  `LPRICE2` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  `LDISPEC12` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDISPEC22` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDISPEC32` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDATE3` date NOT NULL DEFAULT '0000-00-00',
  `LTYPE3` varchar(4) NOT NULL DEFAULT '',
  `LREFNO3` varchar(8) NOT NULL DEFAULT '',
  `LQTY3` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  `LPRICE3` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  `LDISPEC13` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDISPEC23` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDISPEC33` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDATE4` date NOT NULL DEFAULT '0000-00-00',
  `LTYPE4` varchar(4) NOT NULL DEFAULT '',
  `LREFNO4` varchar(8) NOT NULL DEFAULT '',
  `LQTY4` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  `LPRICE4` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  `LDISPEC14` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDISPEC24` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDISPEC34` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDATE5` date NOT NULL DEFAULT '0000-00-00',
  `LTYPE5` varchar(4) NOT NULL DEFAULT '',
  `LREFNO5` varchar(8) NOT NULL DEFAULT '',
  `LQTY5` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  `LPRICE5` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  `LDISPEC15` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDISPEC25` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDISPEC35` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDATE6` date NOT NULL DEFAULT '0000-00-00',
  `LTYPE6` varchar(4) NOT NULL DEFAULT '',
  `LREFNO6` varchar(8) NOT NULL DEFAULT '',
  `LQTY6` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  `LPRICE6` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  `LDISPEC16` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDISPEC26` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDISPEC36` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDATE7` date NOT NULL DEFAULT '0000-00-00',
  `LTYPE7` varchar(4) NOT NULL DEFAULT '',
  `LREFNO7` varchar(8) NOT NULL DEFAULT '',
  `LQTY7` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  `LPRICE7` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  `LDISPEC17` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDISPEC27` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDISPEC37` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDATE8` date NOT NULL DEFAULT '0000-00-00',
  `LTYPE8` varchar(4) NOT NULL DEFAULT '',
  `LREFNO8` varchar(8) NOT NULL DEFAULT '',
  `LQTY8` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  `LPRICE8` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  `LDISPEC18` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDISPEC28` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDISPEC38` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDATE9` date NOT NULL DEFAULT '0000-00-00',
  `LTYPE9` varchar(4) NOT NULL DEFAULT '',
  `LREFNO9` varchar(8) NOT NULL DEFAULT '',
  `LQTY9` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  `LPRICE9` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  `LDISPEC19` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDISPEC29` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDISPEC39` decimal(5,2) NOT NULL DEFAULT '0.00',
  `CI_QOB` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  `CI_QBF` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  `CI_QIN` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  `CI_QOT` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  `CI_QAJ` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  `CI_QTY` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  `CURRCODE` varchar(10) NOT NULL DEFAULT '',
  `DESP` varchar(100) DEFAULT NULL,
  `NAME` varchar(40) NOT NULL DEFAULT '',
  `NETPRICE` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  PRIMARY KEY (`ITEMNO`,`CUSTNO`),
  KEY `RECOMENTPRICE` (`ITEMNO`,`CUSTNO`,`PRICE`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `icl3p`
--

LOCK TABLES `icl3p` WRITE;
/*!40000 ALTER TABLE `icl3p` DISABLE KEYS */;
/*!40000 ALTER TABLE `icl3p` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `icl3p2`
--

DROP TABLE IF EXISTS `icl3p2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `icl3p2` (
  `EDI_ID` varchar(12) NOT NULL DEFAULT '',
  `ITEMNO` varchar(60) NOT NULL DEFAULT '',
  `CUSTNO` varchar(12) NOT NULL DEFAULT '',
  `AGENNO` varchar(12) NOT NULL DEFAULT '',
  `PRICE` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  `DISPEC` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DISPEC2` decimal(5,2) NOT NULL DEFAULT '0.00',
  `DISPEC3` decimal(5,2) NOT NULL DEFAULT '0.00',
  `CI_NOTE` varchar(24) NOT NULL DEFAULT '',
  `LDATE1` date NOT NULL DEFAULT '0000-00-00',
  `LTYPE1` varchar(4) NOT NULL DEFAULT '',
  `LREFNO1` varchar(8) NOT NULL DEFAULT '',
  `LQTY1` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  `LPRICE1` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  `LDISPEC11` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDISPEC21` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDISPEC31` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDATE2` date NOT NULL DEFAULT '0000-00-00',
  `LTYPE2` varchar(4) NOT NULL DEFAULT '',
  `LREFNO2` varchar(8) NOT NULL DEFAULT '',
  `LQTY2` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  `LPRICE2` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  `LDISPEC12` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDISPEC22` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDISPEC32` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDATE3` date NOT NULL DEFAULT '0000-00-00',
  `LTYPE3` varchar(4) NOT NULL DEFAULT '',
  `LREFNO3` varchar(8) NOT NULL DEFAULT '',
  `LQTY3` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  `LPRICE3` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  `LDISPEC13` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDISPEC23` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDISPEC33` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDATE4` date NOT NULL DEFAULT '0000-00-00',
  `LTYPE4` varchar(4) NOT NULL DEFAULT '',
  `LREFNO4` varchar(8) NOT NULL DEFAULT '',
  `LQTY4` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  `LPRICE4` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  `LDISPEC14` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDISPEC24` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDISPEC34` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDATE5` date NOT NULL DEFAULT '0000-00-00',
  `LTYPE5` varchar(4) NOT NULL DEFAULT '',
  `LREFNO5` varchar(8) NOT NULL DEFAULT '',
  `LQTY5` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  `LPRICE5` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  `LDISPEC15` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDISPEC25` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDISPEC35` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDATE6` date NOT NULL DEFAULT '0000-00-00',
  `LTYPE6` varchar(4) NOT NULL DEFAULT '',
  `LREFNO6` varchar(8) NOT NULL DEFAULT '',
  `LQTY6` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  `LPRICE6` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  `LDISPEC16` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDISPEC26` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDISPEC36` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDATE7` date NOT NULL DEFAULT '0000-00-00',
  `LTYPE7` varchar(4) NOT NULL DEFAULT '',
  `LREFNO7` varchar(8) NOT NULL DEFAULT '',
  `LQTY7` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  `LPRICE7` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  `LDISPEC17` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDISPEC27` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDISPEC37` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDATE8` date NOT NULL DEFAULT '0000-00-00',
  `LTYPE8` varchar(4) NOT NULL DEFAULT '',
  `LREFNO8` varchar(8) NOT NULL DEFAULT '',
  `LQTY8` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  `LPRICE8` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  `LDISPEC18` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDISPEC28` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDISPEC38` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDATE9` date NOT NULL DEFAULT '0000-00-00',
  `LTYPE9` varchar(4) NOT NULL DEFAULT '',
  `LREFNO9` varchar(8) NOT NULL DEFAULT '',
  `LQTY9` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  `LPRICE9` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  `LDISPEC19` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDISPEC29` decimal(5,2) NOT NULL DEFAULT '0.00',
  `LDISPEC39` decimal(5,2) NOT NULL DEFAULT '0.00',
  `CI_QOB` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  `CI_QBF` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  `CI_QIN` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  `CI_QOT` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  `CI_QAJ` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  `CI_QTY` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  `CURRCODE` varchar(10) NOT NULL DEFAULT '',
  `DESP` varchar(40) NOT NULL DEFAULT '',
  `NAME` varchar(40) NOT NULL DEFAULT '',
  `NETPRICE` decimal(17,7) NOT NULL DEFAULT '0.0000000',
  PRIMARY KEY (`CUSTNO`,`ITEMNO`),
  KEY `RECOMENTPRICE` (`ITEMNO`,`CUSTNO`,`PRICE`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `icl3p2`
--

LOCK TABLES `icl3p2` WRITE;
/*!40000 ALTER TABLE `icl3p2` DISABLE KEYS */;
/*!40000 ALTER TABLE `icl3p2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `iclink`
--

DROP TABLE IF EXISTS `iclink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `iclink` (
  `TYPE` varchar(4) NOT NULL DEFAULT '',
  `REFNO` varchar(50) NOT NULL DEFAULT '',
  `TRANCODE` int(4) NOT NULL DEFAULT '0',
  `WOS_DATE` date NOT NULL DEFAULT '0000-00-00',
  `FRTYPE` varchar(4) NOT NULL DEFAULT '',
  `FRREFNO` varchar(50) NOT NULL DEFAULT '',
  `FRTRANCODE` int(4) NOT NULL DEFAULT '0',
  `FRDATE` date NOT NULL DEFAULT '0000-00-00',
  `ITEMNO` varchar(60) NOT NULL DEFAULT '',
  `QTY` double(15,5) NOT NULL DEFAULT '0.00000',
  PRIMARY KEY (`TYPE`,`REFNO`,`FRTYPE`,`FRREFNO`,`TRANCODE`,`FRTRANCODE`,`ITEMNO`),
  KEY `LINKINFO` (`TYPE`,`REFNO`,`TRANCODE`,`WOS_DATE`,`FRTYPE`,`FRREFNO`,`FRTRANCODE`,`FRDATE`,`ITEMNO`,`QTY`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `iclink`
--

LOCK TABLES `iclink` WRITE;
/*!40000 ALTER TABLE `iclink` DISABLE KEYS */;
/*!40000 ALTER TABLE `iclink` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `iclocation`
--

DROP TABLE IF EXISTS `iclocation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `iclocation` (
  `LOCATION` varchar(24) NOT NULL DEFAULT '',
  `DESP` varchar(40) NOT NULL DEFAULT '',
  `ADDR1` varchar(40) NOT NULL DEFAULT '',
  `ADDR2` varchar(40) NOT NULL DEFAULT '',
  `ADDR3` varchar(40) NOT NULL DEFAULT '',
  `ADDR4` varchar(40) NOT NULL DEFAULT '',
  `noactivelocation` varchar(40) DEFAULT '',
  `OUTLET` char(1) NOT NULL DEFAULT '',
  `CUSTNO` varchar(12) NOT NULL DEFAULT '',
  `TEMPN1` double(17,5) NOT NULL DEFAULT '0.00000',
  `TEMPC1` varchar(40) NOT NULL DEFAULT '',
  PRIMARY KEY (`LOCATION`),
  KEY `LOCATIONINFO` (`LOCATION`,`DESP`,`ADDR1`,`ADDR2`,`ADDR3`,`ADDR4`,`OUTLET`,`CUSTNO`,`TEMPN1`,`TEMPC1`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `iclocation`
--

LOCK TABLES `iclocation` WRITE;
/*!40000 ALTER TABLE `iclocation` DISABLE KEYS */;
/*!40000 ALTER TABLE `iclocation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `icmitem`
--

DROP TABLE IF EXISTS `icmitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `icmitem` (
  `mitemno` varchar(20) NOT NULL DEFAULT '',
  `AITEMNO` varchar(40) DEFAULT NULL,
  `UITEMNO` varchar(20) DEFAULT NULL,
  `DESP` varchar(60) DEFAULT NULL,
  `DESPA` varchar(70) DEFAULT NULL,
  `UNIT` varchar(12) DEFAULT NULL,
  `UCOST` double(17,7) DEFAULT NULL,
  `PRICE` double(17,7) DEFAULT NULL,
  `BRAND` varchar(40) DEFAULT '',
  `CATEGORY` varchar(50) DEFAULT '',
  `WOS_GROUP` varchar(50) DEFAULT '',
  `SUPP` varchar(12) NOT NULL DEFAULT '',
  `COLORNO` varchar(10) DEFAULT NULL,
  `COLOR1` varchar(10) DEFAULT NULL,
  `COLOR2` varchar(10) DEFAULT NULL,
  `COLOR3` varchar(10) DEFAULT NULL,
  `COLOR4` varchar(10) DEFAULT NULL,
  `COLOR5` varchar(10) DEFAULT NULL,
  `COLOR6` varchar(10) DEFAULT NULL,
  `COLOR7` varchar(10) DEFAULT NULL,
  `COLOR8` varchar(10) DEFAULT NULL,
  `COLOR9` varchar(10) DEFAULT NULL,
  `COLOR10` varchar(10) DEFAULT NULL,
  `COLOR11` varchar(10) DEFAULT NULL,
  `COLOR12` varchar(10) DEFAULT NULL,
  `COLOR13` varchar(10) DEFAULT NULL,
  `COLOR14` varchar(10) DEFAULT NULL,
  `COLOR15` varchar(10) DEFAULT NULL,
  `COLOR16` varchar(10) DEFAULT NULL,
  `COLOR17` varchar(10) DEFAULT NULL,
  `COLOR18` varchar(10) DEFAULT NULL,
  `COLOR19` varchar(10) DEFAULT NULL,
  `COLOR20` varchar(10) DEFAULT NULL,
  `SIZE1` varchar(10) DEFAULT NULL,
  `SIZE2` varchar(10) DEFAULT NULL,
  `SIZE3` varchar(10) DEFAULT NULL,
  `SIZE4` varchar(10) DEFAULT NULL,
  `SIZE5` varchar(10) DEFAULT NULL,
  `SIZE6` varchar(10) DEFAULT NULL,
  `SIZE7` varchar(10) DEFAULT NULL,
  `SIZE8` varchar(10) DEFAULT NULL,
  `SIZE9` varchar(10) DEFAULT NULL,
  `SIZE10` varchar(10) DEFAULT NULL,
  `SIZE11` varchar(10) DEFAULT NULL,
  `SIZE12` varchar(10) DEFAULT NULL,
  `SIZE13` varchar(10) DEFAULT NULL,
  `SIZE14` varchar(10) DEFAULT NULL,
  `SIZE15` varchar(10) DEFAULT NULL,
  `SIZE16` varchar(10) DEFAULT NULL,
  `SIZE17` varchar(10) DEFAULT NULL,
  `SIZE18` varchar(10) DEFAULT NULL,
  `SIZE19` varchar(10) DEFAULT NULL,
  `SIZE20` varchar(10) DEFAULT NULL,
  `CREATED_BY` varchar(50) DEFAULT NULL,
  `CREATED_ON` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `UPDATED_BY` varchar(50) DEFAULT NULL,
  `UPDATED_ON` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `sizecolor` varchar(4) DEFAULT NULL,
  `sizeid` varchar(45) DEFAULT NULL,
  `PRICE2` double(17,7) NOT NULL DEFAULT '0.0000000',
  `PRICE3` double(17,7) NOT NULL DEFAULT '0.0000000',
  `MURATIO` double(17,7) NOT NULL DEFAULT '0.0000000',
  `PRICE4` double(17,7) NOT NULL DEFAULT '0.0000000',
  `colorid` varchar(100) DEFAULT '',
  `shelf` varchar(100) DEFAULT '',
  `photo` varchar(100) DEFAULT '',
  PRIMARY KEY (`mitemno`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `icmitem`
--

LOCK TABLES `icmitem` WRITE;
/*!40000 ALTER TABLE `icmitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `icmitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `icservi`
--

DROP TABLE IF EXISTS `icservi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `icservi` (
  `SERVI` varchar(8) NOT NULL DEFAULT '',
  `DESP` varchar(100) NOT NULL DEFAULT '',
  `SALEC` varchar(8) NOT NULL DEFAULT '',
  `SALECSC` varchar(8) NOT NULL DEFAULT '',
  `SALECNC` varchar(8) NOT NULL DEFAULT '',
  `PURC` varchar(8) NOT NULL DEFAULT '',
  `PURPRC` varchar(8) NOT NULL DEFAULT '',
  `TAXPERC1` double(9,8) NOT NULL DEFAULT '0.00000000',
  `TAXPERC2` double(9,8) NOT NULL DEFAULT '0.00000000',
  `DESPA` varchar(100) NOT NULL DEFAULT '',
  `POINT` double(12,4) NOT NULL DEFAULT '0.0000',
  `SERCOST` double(18,6) DEFAULT '0.000000',
  `SERPRICE` double(18,6) NOT NULL DEFAULT '0.000000',
  PRIMARY KEY (`SERVI`) USING BTREE,
  KEY `SERVICEINFO` (`SERVI`,`DESP`,`SALEC`,`SALECSC`,`SALECNC`,`PURC`,`PURPRC`,`TAXPERC1`,`TAXPERC2`,`DESPA`,`POINT`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `icservi`
--

LOCK TABLES `icservi` WRITE;
/*!40000 ALTER TABLE `icservi` DISABLE KEYS */;
/*!40000 ALTER TABLE `icservi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `icshelf`
--

DROP TABLE IF EXISTS `icshelf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `icshelf` (
  `SHELF` varchar(10) NOT NULL DEFAULT '',
  `DESP` varchar(40) NOT NULL DEFAULT '',
  PRIMARY KEY (`SHELF`),
  KEY `SHELFINFO` (`SHELF`,`DESP`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `icshelf`
--

LOCK TABLES `icshelf` WRITE;
/*!40000 ALTER TABLE `icshelf` DISABLE KEYS */;
/*!40000 ALTER TABLE `icshelf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `icsizeid`
--

DROP TABLE IF EXISTS `icsizeid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `icsizeid` (
  `SIZEID` varchar(20) NOT NULL,
  `DESP` varchar(40) NOT NULL DEFAULT '',
  `SIZE1` varchar(100) DEFAULT '',
  `SIZE2` varchar(100) DEFAULT '',
  `SIZE3` varchar(100) DEFAULT '',
  `SIZE4` varchar(100) DEFAULT '',
  `SIZE5` varchar(100) DEFAULT '',
  `SIZE6` varchar(100) DEFAULT '',
  `SIZE7` varchar(100) DEFAULT '',
  `SIZE8` varchar(100) DEFAULT '',
  `SIZE9` varchar(100) DEFAULT '',
  `SIZE10` varchar(100) DEFAULT '',
  `SIZE11` varchar(100) DEFAULT '',
  `SIZE12` varchar(100) DEFAULT '',
  `SIZE13` varchar(100) DEFAULT '',
  `SIZE14` varchar(100) DEFAULT '',
  `SIZE15` varchar(100) DEFAULT '',
  `SIZE16` varchar(100) DEFAULT '',
  `SIZE17` varchar(100) DEFAULT '',
  `SIZE18` varchar(100) DEFAULT '',
  `SIZE19` varchar(100) DEFAULT '',
  `SIZE20` varchar(100) DEFAULT '',
  `SIZE21` varchar(100) DEFAULT '',
  `SIZE22` varchar(100) DEFAULT '',
  `SIZE23` varchar(100) DEFAULT '',
  `SIZE24` varchar(100) DEFAULT '',
  `SIZE25` varchar(100) DEFAULT '',
  `SIZE26` varchar(100) DEFAULT '',
  `SIZE27` varchar(100) DEFAULT '',
  `SIZE28` varchar(100) DEFAULT '',
  `SIZE29` varchar(100) DEFAULT '',
  `SIZE30` varchar(100) DEFAULT '',
  PRIMARY KEY (`SIZEID`),
  KEY `SIZEINFO` (`SIZEID`,`DESP`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `icsizeid`
--

LOCK TABLES `icsizeid` WRITE;
/*!40000 ALTER TABLE `icsizeid` DISABLE KEYS */;
/*!40000 ALTER TABLE `icsizeid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `icteam`
--

DROP TABLE IF EXISTS `icteam`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `icteam` (
  `TEAM` varchar(12) NOT NULL DEFAULT '',
  `DESP` varchar(40) NOT NULL DEFAULT '',
  PRIMARY KEY (`TEAM`) USING BTREE,
  KEY `TEAMINFO` (`TEAM`,`DESP`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `icteam`
--

LOCK TABLES `icteam` WRITE;
/*!40000 ALTER TABLE `icteam` DISABLE KEYS */;
/*!40000 ALTER TABLE `icteam` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `icterm`
--

DROP TABLE IF EXISTS `icterm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `icterm` (
  `TERM` varchar(12) NOT NULL DEFAULT '',
  `DESP` varchar(40) NOT NULL DEFAULT '',
  `SIGN` char(1) NOT NULL DEFAULT '',
  `days` int(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`TERM`) USING BTREE,
  KEY `TERMINFO` (`TERM`,`DESP`,`SIGN`,`days`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `icterm`
--

LOCK TABLES `icterm` WRITE;
/*!40000 ALTER TABLE `icterm` DISABLE KEYS */;
INSERT INTO `icterm` VALUES ('07 Days','7Days','P',7),('10 DAYS','10 DAYS','P',10),('30 Days','30Days','P',30),('60 Days','60Days','P',60),('COD','Cash On Delivery','P',0),('L/C','L/C','P',0),('L/C At Sight','L/C At Sight','P',0),('T/T 30Days','T/T 30Days','P',30),('T/T 60 Days','T/T 60Days','P',60),('T/T In Adv','T/T In Advance','P',0);
/*!40000 ALTER TABLE `icterm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ictermandcondition`
--

DROP TABLE IF EXISTS `ictermandcondition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ictermandcondition` (
  `No` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `lRC` text,
  `lPR` text,
  `lDO` text,
  `lINV` text,
  `lCS` text,
  `lCN` text,
  `lDN` text,
  `lPO` text,
  `lQUO` text,
  `lSO` text,
  `lSAM` text,
  PRIMARY KEY (`No`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ictermandcondition`
--

LOCK TABLES `ictermandcondition` WRITE;
/*!40000 ALTER TABLE `ictermandcondition` DISABLE KEYS */;
/*!40000 ALTER TABLE `ictermandcondition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ictran`
--

DROP TABLE IF EXISTS `ictran`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ictran` (
  `TYPE` varchar(4) NOT NULL DEFAULT '',
  `REFNO` varchar(50) NOT NULL DEFAULT '',
  `REFNO2` varchar(24) DEFAULT NULL,
  `TRANCODE` int(4) NOT NULL DEFAULT '0',
  `CUSTNO` varchar(12) NOT NULL DEFAULT '',
  `FPERIOD` varchar(2) DEFAULT '0',
  `WOS_DATE` date NOT NULL DEFAULT '0000-00-00',
  `CURRRATE` double(16,10) NOT NULL DEFAULT '0.0000000000',
  `ITEMCOUNT` int(4) NOT NULL DEFAULT '0',
  `LINECODE` varchar(2) DEFAULT NULL,
  `ITEMNO` varchar(54) NOT NULL DEFAULT '',
  `DESP` varchar(450) DEFAULT NULL,
  `DESPA` varchar(450) DEFAULT NULL,
  `AGENNO` varchar(20) NOT NULL DEFAULT '',
  `LOCATION` varchar(24) DEFAULT NULL,
  `SOURCE` varchar(40) DEFAULT '',
  `JOB` varchar(40) DEFAULT '',
  `SIGN` varchar(2) DEFAULT NULL,
  `QTY_BIL` double(17,5) NOT NULL DEFAULT '0.00000',
  `PRICE_BIL` double(17,5) NOT NULL DEFAULT '0.00000',
  `UNIT_BIL` varchar(15) DEFAULT '',
  `AMT1_BIL` double(17,5) NOT NULL DEFAULT '0.00000',
  `DISPEC1` varchar(10) DEFAULT NULL,
  `DISPEC2` varchar(10) DEFAULT NULL,
  `DISPEC3` varchar(10) DEFAULT NULL,
  `DISAMT_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `AMT_BIL` double(17,5) NOT NULL DEFAULT '0.00000',
  `TAXPEC1` varchar(5) DEFAULT NULL,
  `TAXPEC2` varchar(5) DEFAULT NULL,
  `TAXPEC3` varchar(5) DEFAULT NULL,
  `TAXAMT_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `NOTE_A` varchar(8) DEFAULT NULL,
  `IMPSTAGE` char(1) DEFAULT NULL,
  `QTY` double(17,5) NOT NULL DEFAULT '0.00000',
  `PRICE` double(17,5) NOT NULL DEFAULT '0.00000',
  `UNIT` varchar(15) DEFAULT '',
  `AMT1` double(17,5) NOT NULL DEFAULT '0.00000',
  `DISAMT` double(15,5) NOT NULL DEFAULT '0.00000',
  `AMT` double(17,5) NOT NULL DEFAULT '0.00000',
  `TAXAMT` double(15,5) NOT NULL DEFAULT '0.00000',
  `FACTOR1` varchar(9) DEFAULT NULL,
  `FACTOR2` varchar(9) DEFAULT NULL,
  `DONO` varchar(40) DEFAULT NULL,
  `DODATE` date NOT NULL DEFAULT '0000-00-00',
  `SODATE` date NOT NULL DEFAULT '0000-00-00',
  `BREM1` varchar(40) DEFAULT NULL,
  `BREM2` varchar(40) DEFAULT NULL,
  `BREM3` varchar(40) DEFAULT NULL,
  `BREM4` varchar(40) DEFAULT NULL,
  `PACKING` varchar(13) DEFAULT NULL,
  `NOTE1` varchar(10) DEFAULT NULL,
  `NOTE2` varchar(10) DEFAULT NULL,
  `GLTRADAC` varchar(8) DEFAULT NULL,
  `UPDCOST` char(1) DEFAULT NULL,
  `GST_ITEM` char(1) DEFAULT NULL,
  `TOTALUP` char(1) DEFAULT NULL,
  `WITHSN` char(1) DEFAULT NULL,
  `NODISPLAY` char(1) NOT NULL DEFAULT '',
  `GRADE` varchar(10) DEFAULT NULL,
  `PUR_PRICE` double(17,5) NOT NULL DEFAULT '0.00000',
  `QTY1` double(17,5) NOT NULL DEFAULT '0.00000',
  `QTY2` double(17,5) NOT NULL DEFAULT '0.00000',
  `QTY3` double(17,5) NOT NULL DEFAULT '0.00000',
  `QTY4` double(17,5) NOT NULL DEFAULT '0.00000',
  `QTY5` double(17,5) NOT NULL DEFAULT '0.00000',
  `QTY6` double(17,5) NOT NULL DEFAULT '0.00000',
  `QTY7` double(17,5) NOT NULL DEFAULT '0.00000',
  `QTY_RET` double(17,5) NOT NULL DEFAULT '0.00000',
  `TEMPFIGI` double(15,5) NOT NULL DEFAULT '0.00000',
  `SERCOST` double(13,5) NOT NULL DEFAULT '0.00000',
  `M_CHARGE1` double(15,5) NOT NULL DEFAULT '0.00000',
  `M_CHARGE2` double(15,5) NOT NULL DEFAULT '0.00000',
  `ADTCOST1` double(15,5) NOT NULL DEFAULT '0.00000',
  `ADTCOST2` double(15,5) NOT NULL DEFAULT '0.00000',
  `IT_COS` double(17,5) NOT NULL DEFAULT '0.00000',
  `AV_COST` double(17,5) NOT NULL DEFAULT '0.00000',
  `BATCHCODE` varchar(15) DEFAULT NULL,
  `EXPDATE` date NOT NULL DEFAULT '0000-00-00',
  `POINT` double(12,4) NOT NULL DEFAULT '0.0000',
  `INV_DISC` double(17,5) NOT NULL DEFAULT '0.00000',
  `INV_TAX` double(17,5) NOT NULL DEFAULT '0.00000',
  `SUPP` varchar(12) DEFAULT NULL,
  `EDI_COU1` varchar(12) DEFAULT NULL,
  `WRITEOFF` double(17,5) NOT NULL DEFAULT '0.00000',
  `TOSHIP` double(17,5) NOT NULL DEFAULT '0.00000',
  `SHIPPED` double(17,5) NOT NULL DEFAULT '0.00000',
  `NAME` varchar(40) DEFAULT NULL,
  `DEL_BY` varchar(12) DEFAULT NULL,
  `VAN` varchar(8) DEFAULT NULL,
  `GENERATED` char(1) DEFAULT NULL,
  `UD_QTY` char(1) DEFAULT NULL,
  `TOINV` varchar(100) DEFAULT '',
  `EXPORTED` varchar(24) DEFAULT NULL,
  `EXPORTED1` date NOT NULL DEFAULT '0000-00-00',
  `EXPORTED2` varchar(24) DEFAULT NULL,
  `EXPORTED3` date NOT NULL DEFAULT '0000-00-00',
  `BRK_TO` char(1) DEFAULT NULL,
  `SV_PART` varchar(24) DEFAULT NULL,
  `LAST_YEAR` char(1) DEFAULT NULL,
  `VOID` char(1) DEFAULT NULL,
  `SONO` varchar(40) DEFAULT NULL,
  `MC1_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `MC2_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `USERID` varchar(50) DEFAULT NULL,
  `DAMT` double(15,5) NOT NULL DEFAULT '0.00000',
  `OLDBILL` char(1) DEFAULT NULL,
  `WOS_GROUP` varchar(50) DEFAULT '',
  `CATEGORY` varchar(80) DEFAULT '',
  `AREA` varchar(12) DEFAULT NULL,
  `SHELF` varchar(8) DEFAULT NULL,
  `TEMP` varchar(24) DEFAULT NULL,
  `TEMP1` double(17,5) NOT NULL DEFAULT '0.00000',
  `BODY` char(1) DEFAULT NULL,
  `TOTALGROUP` varchar(3) DEFAULT NULL,
  `MARK` char(1) DEFAULT NULL,
  `TYPE_SEQ` varchar(2) DEFAULT NULL,
  `PROMOTER` varchar(8) DEFAULT NULL,
  `TABLENO` varchar(4) DEFAULT NULL,
  `MEMBER` varchar(20) DEFAULT NULL,
  `TOURGROUP` varchar(3) DEFAULT NULL,
  `TRDATETIME` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `TIME` varchar(8) DEFAULT NULL,
  `BOMNO` char(1) DEFAULT NULL,
  `COMMENT` blob,
  `DEFECTIVE` char(1) DEFAULT NULL,
  `M_CHARGE3` double(15,5) NOT NULL DEFAULT '0.00000',
  `M_CHARGE4` double(15,5) NOT NULL DEFAULT '0.00000',
  `M_CHARGE5` double(15,5) NOT NULL DEFAULT '0.00000',
  `M_CHARGE6` double(15,5) NOT NULL DEFAULT '0.00000',
  `M_CHARGE7` double(15,5) NOT NULL DEFAULT '0.00000',
  `MC3_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `MC4_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `MC5_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `MC6_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `MC7_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `taxincl` varchar(45) DEFAULT NULL,
  `LOC_CURRRATE` double(16,10) NOT NULL DEFAULT '1.0000000000',
  `LOC_CURRCODE` varchar(15) NOT NULL DEFAULT '',
  `TITLE_ID` varchar(45) NOT NULL DEFAULT '',
  `TITLE_DESP` varchar(100) NOT NULL DEFAULT '',
  `consignment` varchar(45) DEFAULT '',
  `FOC` varchar(45) DEFAULT 'N',
  `voucherno` varchar(45) DEFAULT '',
  `asvoucher` varchar(45) DEFAULT 'N',
  `BOMCOSTMETHOD` varchar(45) NOT NULL DEFAULT '',
  `MANUDATE` date NOT NULL DEFAULT '0000-00-00',
  `milcert` varchar(100) DEFAULT '',
  `importpermit` varchar(100) NOT NULL DEFAULT '',
  `PHOTO` varchar(100) DEFAULT '',
  `PONO` varchar(1000) DEFAULT '',
  `countryoforigin` varchar(150) DEFAULT NULL,
  `pallet` double(17,5) NOT NULL DEFAULT '0.00000',
  `requiredate` date NOT NULL DEFAULT '0000-00-00',
  `replydate` date NOT NULL DEFAULT '0000-00-00',
  `deliverydate` date NOT NULL DEFAULT '0000-00-00',
  PRIMARY KEY (`TYPE`,`REFNO`,`CUSTNO`,`TRANCODE`,`ITEMCOUNT`,`ITEMNO`,`WOS_DATE`),
  KEY `COSTING` (`ITEMNO`,`TYPE`,`REFNO`,`TRANCODE`,`QTY`,`AMT`,`IT_COS`,`TOINV`,`VOID`),
  KEY `ASSMITEM` (`ITEMNO`,`TYPE`,`REFNO`,`FPERIOD`,`WOS_DATE`,`LOCATION`,`SOURCE`,`QTY`,`AMT`,`IT_COS`,`VOID`,`AREA`,`SHELF`,`BOMNO`) USING BTREE,
  KEY `BATCHITEM` (`ITEMNO`,`TYPE`,`REFNO`,`CUSTNO`,`FPERIOD`,`WOS_DATE`,`AGENNO`,`LOCATION`,`QTY`,`AMT`,`BATCHCODE`,`EXPDATE`,`TOINV`,`AREA`) USING BTREE,
  KEY `ITEMREPORT` (`ITEMNO`,`TYPE`,`FPERIOD`,`WOS_DATE`,`AGENNO`,`LOCATION`,`SOURCE`,`QTY`,`AMT`,`IT_COS`,`AREA`,`SHELF`,`SHIPPED`,`TOINV`) USING BTREE,
  KEY `CUSTREPORT` (`CUSTNO`,`TYPE`,`ITEMNO`,`FPERIOD`,`WOS_DATE`,`AGENNO`,`LOCATION`,`SOURCE`,`QTY`,`AMT`,`IT_COS`,`SHIPPED`,`TOINV`,`AREA`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ictran`
--

LOCK TABLES `ictran` WRITE;
/*!40000 ALTER TABLE `ictran` DISABLE KEYS */;
INSERT INTO `ictran` VALUES ('DN','DN00001',NULL,1,'3000/A02','01','2012-01-16',1.0000000000,1,'','Great Eastern','Great Eastern','','','','','',NULL,1.00000,600.00000,'',600.00000,'0.00','0.00','0.00',0.00000,600.00000,'7',NULL,NULL,42.00000,'SR',NULL,1.00000,600.00000,'',600.00000,0.00000,600.00000,42.00000,'1','1','','0000-00-00','0000-00-00','tst','yytf','hg','jhgjh','',NULL,NULL,'',NULL,NULL,NULL,NULL,'N',NULL,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,'','0000-00-00',0.0000,0.00000,0.00000,'',NULL,0.00000,0.00000,0.00000,'Mr Lim',NULL,'','',NULL,'','','0000-00-00',NULL,'0000-00-00',NULL,'',NULL,NULL,'',0.00000,0.00000,'Demoinsurance',0.00000,NULL,'','',NULL,'',NULL,0.00000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2012-01-16 10:03:21',NULL,NULL,'','',0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,NULL,1.0000000000,'','','','','','','N','','0000-00-00','','','','',NULL,0.00000,'0000-00-00','0000-00-00','0000-00-00'),('QUO','QUO00001',NULL,1,'3000/A02','01','2012-01-19',1.0000000000,1,'','Great Eastern','Great Eastern Motor Insurance','Comprehensive','','','','',NULL,1.00000,1000.00000,'',1000.00000,'0.00','0.00','0.00',0.00000,1000.00000,'7',NULL,NULL,70.00000,'SR',NULL,1.00000,1000.00000,'',1000.00000,0.00000,1000.00000,70.00000,'1','1','','0000-00-00','0000-00-00','Motor','','20 Jan 2012','19 Jan 2013','',NULL,NULL,'',NULL,NULL,NULL,NULL,'N',NULL,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,'','0000-00-00',0.0000,0.00000,0.00000,'',NULL,0.00000,0.00000,0.00000,'Mr Lim',NULL,'','',NULL,'','','0000-00-00',NULL,'0000-00-00',NULL,'',NULL,NULL,'',0.00000,0.00000,'Demoinsurance',0.00000,NULL,'','',NULL,'',NULL,0.00000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2012-01-19 07:16:01',NULL,NULL,'blah blah blah...','',0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,NULL,1.0000000000,'','','','','','','N','','0000-00-00','','','','',NULL,0.00000,'0000-00-00','0000-00-00','0000-00-00');
/*!40000 ALTER TABLE `ictran` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ictran_excel`
--

DROP TABLE IF EXISTS `ictran_excel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ictran_excel` (
  `itemno` varchar(200) NOT NULL DEFAULT '',
  `desp` varchar(200) NOT NULL DEFAULT '',
  `comment` text,
  `brem1` varchar(200) NOT NULL DEFAULT '',
  `brem2` varchar(200) NOT NULL DEFAULT '',
  `brem3` varchar(200) NOT NULL DEFAULT '',
  `brem4` varchar(200) NOT NULL DEFAULT '',
  `location` varchar(200) NOT NULL DEFAULT '',
  `price` double(17,7) NOT NULL DEFAULT '0.0000000',
  `qty` double(17,7) NOT NULL DEFAULT '0.0000000',
  `dispec1` double(17,7) NOT NULL DEFAULT '0.0000000',
  `dispec2` double(17,7) NOT NULL DEFAULT '0.0000000',
  `dispec3` double(17,7) NOT NULL DEFAULT '0.0000000',
  `note_a` varchar(200) NOT NULL DEFAULT '',
  `taxpec1` double(17,7) NOT NULL DEFAULT '0.0000000'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ictran_excel`
--

LOCK TABLES `ictran_excel` WRITE;
/*!40000 ALTER TABLE `ictran_excel` DISABLE KEYS */;
/*!40000 ALTER TABLE `ictran_excel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ictrantemp`
--

DROP TABLE IF EXISTS `ictrantemp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ictrantemp` (
  `TYPE` varchar(4) NOT NULL DEFAULT '',
  `REFNO` varchar(40) NOT NULL,
  `REFNO2` varchar(24) DEFAULT NULL,
  `TRANCODE` int(4) NOT NULL DEFAULT '0',
  `CUSTNO` varchar(12) NOT NULL DEFAULT '',
  `FPERIOD` varchar(2) DEFAULT '0',
  `WOS_DATE` date NOT NULL DEFAULT '0000-00-00',
  `CURRRATE` double(16,10) NOT NULL DEFAULT '0.0000000000',
  `ITEMCOUNT` int(4) NOT NULL DEFAULT '0',
  `LINECODE` varchar(2) DEFAULT NULL,
  `ITEMNO` varchar(28) NOT NULL DEFAULT '',
  `DESP` varchar(450) DEFAULT '',
  `DESPA` varchar(450) DEFAULT '',
  `AGENNO` varchar(20) NOT NULL DEFAULT '',
  `LOCATION` varchar(24) DEFAULT NULL,
  `SOURCE` varchar(40) DEFAULT '',
  `JOB` varchar(40) DEFAULT '',
  `SIGN` varchar(2) DEFAULT NULL,
  `QTY_BIL` double(17,5) NOT NULL DEFAULT '0.00000',
  `PRICE_BIL` double(17,5) NOT NULL DEFAULT '0.00000',
  `UNIT_BIL` varchar(12) NOT NULL DEFAULT '',
  `AMT1_BIL` double(17,5) NOT NULL DEFAULT '0.00000',
  `DISPEC1` varchar(10) DEFAULT NULL,
  `DISPEC2` varchar(10) DEFAULT NULL,
  `DISPEC3` varchar(10) DEFAULT NULL,
  `DISAMT_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `AMT_BIL` double(17,5) NOT NULL DEFAULT '0.00000',
  `TAXPEC1` varchar(5) DEFAULT NULL,
  `TAXPEC2` varchar(5) DEFAULT NULL,
  `TAXPEC3` varchar(5) DEFAULT NULL,
  `TAXAMT_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `NOTE_A` varchar(8) DEFAULT NULL,
  `IMPSTAGE` char(1) DEFAULT NULL,
  `QTY` double(17,5) NOT NULL DEFAULT '0.00000',
  `PRICE` double(17,5) NOT NULL DEFAULT '0.00000',
  `UNIT` varchar(12) DEFAULT NULL,
  `AMT1` double(17,5) NOT NULL DEFAULT '0.00000',
  `DISAMT` double(15,5) NOT NULL DEFAULT '0.00000',
  `AMT` double(17,5) NOT NULL DEFAULT '0.00000',
  `TAXAMT` double(15,5) NOT NULL DEFAULT '0.00000',
  `FACTOR1` varchar(9) DEFAULT NULL,
  `FACTOR2` varchar(9) DEFAULT NULL,
  `DONO` varchar(40) DEFAULT NULL,
  `DODATE` date NOT NULL DEFAULT '0000-00-00',
  `SODATE` date NOT NULL DEFAULT '0000-00-00',
  `BREM1` varchar(40) DEFAULT NULL,
  `BREM2` varchar(40) DEFAULT NULL,
  `BREM3` varchar(40) DEFAULT NULL,
  `BREM4` varchar(40) DEFAULT NULL,
  `PACKING` varchar(13) DEFAULT NULL,
  `NOTE1` varchar(10) DEFAULT NULL,
  `NOTE2` varchar(10) DEFAULT NULL,
  `GLTRADAC` varchar(8) DEFAULT NULL,
  `UPDCOST` char(1) DEFAULT NULL,
  `GST_ITEM` char(1) DEFAULT NULL,
  `TOTALUP` char(1) DEFAULT NULL,
  `WITHSN` char(1) DEFAULT NULL,
  `NODISPLAY` char(1) NOT NULL DEFAULT '',
  `GRADE` varchar(10) DEFAULT NULL,
  `PUR_PRICE` double(17,5) NOT NULL DEFAULT '0.00000',
  `QTY1` double(17,5) NOT NULL DEFAULT '0.00000',
  `QTY2` double(17,5) NOT NULL DEFAULT '0.00000',
  `QTY3` double(17,5) NOT NULL DEFAULT '0.00000',
  `QTY4` double(17,5) NOT NULL DEFAULT '0.00000',
  `QTY5` double(17,5) NOT NULL DEFAULT '0.00000',
  `QTY6` double(17,5) NOT NULL DEFAULT '0.00000',
  `QTY7` double(17,5) NOT NULL DEFAULT '0.00000',
  `QTY_RET` double(17,5) NOT NULL DEFAULT '0.00000',
  `TEMPFIGI` double(15,5) NOT NULL DEFAULT '0.00000',
  `SERCOST` double(13,5) NOT NULL DEFAULT '0.00000',
  `M_CHARGE1` double(15,5) NOT NULL DEFAULT '0.00000',
  `M_CHARGE2` double(15,5) NOT NULL DEFAULT '0.00000',
  `ADTCOST1` double(15,5) NOT NULL DEFAULT '0.00000',
  `ADTCOST2` double(15,5) NOT NULL DEFAULT '0.00000',
  `IT_COS` double(17,5) NOT NULL DEFAULT '0.00000',
  `AV_COST` double(17,5) NOT NULL DEFAULT '0.00000',
  `BATCHCODE` varchar(15) DEFAULT NULL,
  `EXPDATE` date NOT NULL DEFAULT '0000-00-00',
  `POINT` double(12,4) NOT NULL DEFAULT '0.0000',
  `INV_DISC` double(17,5) NOT NULL DEFAULT '0.00000',
  `INV_TAX` double(17,5) NOT NULL DEFAULT '0.00000',
  `SUPP` varchar(12) DEFAULT NULL,
  `EDI_COU1` varchar(12) DEFAULT NULL,
  `WRITEOFF` double(17,5) NOT NULL DEFAULT '0.00000',
  `TOSHIP` double(17,5) NOT NULL DEFAULT '0.00000',
  `SHIPPED` double(17,5) NOT NULL DEFAULT '0.00000',
  `NAME` varchar(40) DEFAULT NULL,
  `DEL_BY` varchar(12) DEFAULT NULL,
  `VAN` varchar(8) DEFAULT NULL,
  `GENERATED` char(1) DEFAULT NULL,
  `UD_QTY` char(1) DEFAULT NULL,
  `TOINV` varchar(24) DEFAULT NULL,
  `EXPORTED` varchar(24) DEFAULT NULL,
  `EXPORTED1` date NOT NULL DEFAULT '0000-00-00',
  `EXPORTED2` varchar(24) DEFAULT NULL,
  `EXPORTED3` date NOT NULL DEFAULT '0000-00-00',
  `BRK_TO` char(1) DEFAULT NULL,
  `SV_PART` varchar(24) DEFAULT NULL,
  `LAST_YEAR` char(1) DEFAULT NULL,
  `VOID` char(1) DEFAULT NULL,
  `SONO` varchar(40) DEFAULT NULL,
  `MC1_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `MC2_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `USERID` varchar(50) DEFAULT NULL,
  `DAMT` double(15,5) NOT NULL DEFAULT '0.00000',
  `OLDBILL` char(1) DEFAULT NULL,
  `WOS_GROUP` varchar(25) NOT NULL DEFAULT '',
  `CATEGORY` varchar(80) DEFAULT NULL,
  `AREA` varchar(12) DEFAULT NULL,
  `SHELF` varchar(8) DEFAULT NULL,
  `TEMP` varchar(24) DEFAULT NULL,
  `TEMP1` double(17,5) NOT NULL DEFAULT '0.00000',
  `BODY` char(1) DEFAULT NULL,
  `TOTALGROUP` varchar(3) DEFAULT NULL,
  `MARK` char(1) DEFAULT NULL,
  `TYPE_SEQ` varchar(2) DEFAULT NULL,
  `PROMOTER` varchar(8) DEFAULT NULL,
  `TABLENO` varchar(4) DEFAULT NULL,
  `MEMBER` varchar(20) DEFAULT NULL,
  `TOURGROUP` varchar(3) DEFAULT NULL,
  `TRDATETIME` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `TIME` varchar(8) DEFAULT NULL,
  `BOMNO` char(1) DEFAULT NULL,
  `COMMENT` blob,
  `DEFECTIVE` char(1) DEFAULT NULL,
  `M_CHARGE3` double(15,5) NOT NULL DEFAULT '0.00000',
  `M_CHARGE4` double(15,5) NOT NULL DEFAULT '0.00000',
  `M_CHARGE5` double(15,5) NOT NULL DEFAULT '0.00000',
  `M_CHARGE6` double(15,5) NOT NULL DEFAULT '0.00000',
  `M_CHARGE7` double(15,5) NOT NULL DEFAULT '0.00000',
  `MC3_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `MC4_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `MC5_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `MC6_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `MC7_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `taxincl` varchar(45) DEFAULT NULL,
  `LOC_CURRRATE` double(16,10) NOT NULL DEFAULT '1.0000000000',
  `LOC_CURRCODE` varchar(15) NOT NULL DEFAULT '',
  `TITLE_ID` varchar(45) NOT NULL DEFAULT '',
  `TITLE_DESP` varchar(100) NOT NULL DEFAULT '',
  `brem5` varchar(450) DEFAULT NULL,
  `brem6` varchar(450) DEFAULT NULL,
  `uuid` varchar(50) NOT NULL DEFAULT '',
  `driver` varchar(200) DEFAULT '',
  `rem9` varchar(1000) DEFAULT '',
  `onhold` varchar(45) DEFAULT '',
  `promotion` varchar(45) DEFAULT '',
  `consignment` varchar(45) DEFAULT '',
  PRIMARY KEY (`TYPE`,`REFNO`,`CUSTNO`,`TRANCODE`,`ITEMCOUNT`,`ITEMNO`,`WOS_DATE`,`uuid`) USING BTREE,
  KEY `COSTING` (`ITEMNO`,`TYPE`,`REFNO`,`TRANCODE`,`QTY`,`AMT`,`IT_COS`,`TOINV`,`VOID`),
  KEY `ASSMITEM` (`ITEMNO`,`TYPE`,`REFNO`,`FPERIOD`,`WOS_DATE`,`LOCATION`,`SOURCE`,`QTY`,`AMT`,`IT_COS`,`VOID`,`WOS_GROUP`,`CATEGORY`,`AREA`,`SHELF`,`BOMNO`),
  KEY `BATCHITEM` (`ITEMNO`,`TYPE`,`REFNO`,`CUSTNO`,`FPERIOD`,`WOS_DATE`,`AGENNO`,`LOCATION`,`QTY`,`AMT`,`BATCHCODE`,`EXPDATE`,`TOINV`,`WOS_GROUP`,`CATEGORY`,`AREA`),
  KEY `ITEMREPORT` (`ITEMNO`,`TYPE`,`FPERIOD`,`WOS_DATE`,`AGENNO`,`LOCATION`,`SOURCE`,`QTY`,`AMT`,`IT_COS`,`WOS_GROUP`,`CATEGORY`,`AREA`,`SHELF`,`SHIPPED`,`TOINV`),
  KEY `CUSTREPORT` (`CUSTNO`,`TYPE`,`ITEMNO`,`FPERIOD`,`WOS_DATE`,`AGENNO`,`LOCATION`,`SOURCE`,`QTY`,`AMT`,`IT_COS`,`SHIPPED`,`TOINV`,`WOS_GROUP`,`CATEGORY`,`AREA`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ictrantemp`
--

LOCK TABLES `ictrantemp` WRITE;
/*!40000 ALTER TABLE `ictrantemp` DISABLE KEYS */;
/*!40000 ALTER TABLE `ictrantemp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `igrade`
--

DROP TABLE IF EXISTS `igrade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `igrade` (
  `TYPE` varchar(4) NOT NULL DEFAULT '',
  `REFNO` varchar(24) NOT NULL DEFAULT '',
  `TRANCODE` varchar(4) NOT NULL DEFAULT '',
  `ITEMNO` varchar(60) NOT NULL DEFAULT '',
  `WOS_DATE` date NOT NULL DEFAULT '0000-00-00',
  `FPERIOD` varchar(2) NOT NULL DEFAULT '',
  `SIGN` varchar(2) NOT NULL DEFAULT '',
  `DEL_BY` varchar(12) NOT NULL DEFAULT '',
  `LOCATION` varchar(24) NOT NULL DEFAULT '',
  `VOID` char(1) NOT NULL DEFAULT '',
  `GENERATED` char(1) NOT NULL DEFAULT '',
  `CUSTNO` varchar(12) NOT NULL DEFAULT '',
  `EXPORTED` char(1) NOT NULL DEFAULT '',
  `FACTOR1` double(17,7) DEFAULT '1.0000000',
  `FACTOR2` double(17,7) DEFAULT '1.0000000',
  `GRD11` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD12` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD13` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD14` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD15` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD16` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD17` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD18` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD19` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD20` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD21` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD22` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD23` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD24` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD25` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD26` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD27` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD28` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD29` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD30` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD31` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD32` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD33` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD34` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD35` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD36` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD37` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD38` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD39` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD40` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD41` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD42` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD43` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD44` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD45` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD46` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD47` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD48` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD49` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD50` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD51` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD52` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD53` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD54` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD55` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD56` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD57` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD58` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD59` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD60` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD61` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD62` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD63` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD64` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD65` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD66` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD67` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD68` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD69` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD70` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD71` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD72` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD73` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD74` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD75` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD76` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD77` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD78` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD79` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD80` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD81` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD82` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD83` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD84` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD85` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD86` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD87` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD88` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD89` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD90` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD91` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD92` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD93` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD94` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD95` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD96` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD97` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD98` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD99` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD100` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD101` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD102` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD103` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD104` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD105` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD106` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD107` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD108` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD109` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD110` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD111` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD112` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD113` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD114` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD115` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD116` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD117` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD118` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD119` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD120` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD121` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD122` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD123` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD124` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD125` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD126` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD127` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD128` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD129` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD130` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD131` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD132` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD133` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD134` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD135` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD136` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD137` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD138` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD139` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD140` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD141` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD142` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD143` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD144` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD145` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD146` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD147` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD148` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD149` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD150` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD151` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD152` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD153` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD154` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD155` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD156` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD157` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD158` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD159` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD160` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD161` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD162` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD163` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD164` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD165` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD166` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD167` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD168` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD169` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD170` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD171` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD172` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD173` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD174` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD175` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD176` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD177` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD178` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD179` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD180` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD181` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD182` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD183` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD184` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD185` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD186` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD187` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD188` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD189` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD190` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD191` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD192` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD193` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD194` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD195` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD196` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD197` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD198` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD199` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD200` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD201` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD202` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD203` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD204` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD205` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD206` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD207` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD208` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD209` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD210` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD211` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD212` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD213` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD214` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD215` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD216` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD217` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD218` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD219` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD220` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD221` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD222` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD223` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD224` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD225` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD226` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD227` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD228` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD229` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD230` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD231` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD232` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD233` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD234` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD235` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD236` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD237` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD238` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD239` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD240` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD241` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD242` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD243` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD244` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD245` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD246` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD247` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD248` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD249` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD250` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD251` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD252` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD253` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD254` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD255` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD256` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD257` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD258` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD259` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD260` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD261` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD262` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD263` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD264` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD265` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD266` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD267` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD268` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD269` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD270` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD271` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD272` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD273` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD274` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD275` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD276` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD277` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD278` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD279` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD280` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD281` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD282` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD283` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD284` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD285` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD286` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD287` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD288` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD289` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD290` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD291` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD292` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD293` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD294` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD295` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD296` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD297` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD298` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD299` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD300` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD301` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD302` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD303` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD304` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD305` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD306` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD307` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD308` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD309` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD310` double(11,5) NOT NULL DEFAULT '0.00000',
  PRIMARY KEY (`TYPE`,`REFNO`,`TRANCODE`,`ITEMNO`,`CUSTNO`),
  KEY `GRADECUST` (`CUSTNO`,`TYPE`,`REFNO`,`ITEMNO`,`WOS_DATE`,`FPERIOD`,`LOCATION`),
  KEY `GRADEDITEM` (`ITEMNO`,`TYPE`,`REFNO`,`CUSTNO`,`WOS_DATE`,`FPERIOD`,`LOCATION`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `igrade`
--

LOCK TABLES `igrade` WRITE;
/*!40000 ALTER TABLE `igrade` DISABLE KEYS */;
/*!40000 ALTER TABLE `igrade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `iserial`
--

DROP TABLE IF EXISTS `iserial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `iserial` (
  `TYPE` varchar(4) NOT NULL DEFAULT '',
  `REFNO` varchar(50) NOT NULL,
  `REFNO2` varchar(24) DEFAULT NULL,
  `TRANCODE` int(4) NOT NULL DEFAULT '0',
  `CUSTNO` varchar(12) NOT NULL DEFAULT '',
  `FPERIOD` varchar(2) NOT NULL DEFAULT '',
  `WOS_DATE` date NOT NULL DEFAULT '0000-00-00',
  `DEL_BY` varchar(12) NOT NULL DEFAULT '',
  `ITEMNO` varchar(60) NOT NULL DEFAULT '',
  `DESP` varchar(30) NOT NULL DEFAULT '',
  `DESPA` varchar(30) NOT NULL DEFAULT '',
  `SERIALNO` varchar(30) NOT NULL DEFAULT '',
  `SEQ` varchar(4) NOT NULL DEFAULT '',
  `AGENNO` varchar(12) NOT NULL DEFAULT '',
  `LOCATION` varchar(24) NOT NULL DEFAULT '',
  `SOURCE` varchar(4) NOT NULL DEFAULT '',
  `JOB` varchar(4) NOT NULL DEFAULT '',
  `CURRRATE` varchar(13) NOT NULL DEFAULT '',
  `SIGN` varchar(2) NOT NULL DEFAULT '',
  `VOID` char(1) NOT NULL DEFAULT '',
  `PRICE` double(17,7) NOT NULL DEFAULT '0.0000000',
  `EXPORTED` char(1) NOT NULL DEFAULT '',
  `GENERATED` char(1) NOT NULL DEFAULT '',
  PRIMARY KEY (`TYPE`,`REFNO`,`TRANCODE`,`CUSTNO`,`ITEMNO`,`SERIALNO`,`LOCATION`) USING BTREE,
  KEY `SERIALINFO` (`TYPE`,`REFNO`,`REFNO2`,`TRANCODE`,`CUSTNO`,`FPERIOD`,`WOS_DATE`,`ITEMNO`,`SERIALNO`,`AGENNO`,`LOCATION`,`SOURCE`,`CURRRATE`,`SEQ`,`PRICE`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `iserial`
--

LOCK TABLES `iserial` WRITE;
/*!40000 ALTER TABLE `iserial` DISABLE KEYS */;
/*!40000 ALTER TABLE `iserial` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issuetemp`
--

DROP TABLE IF EXISTS `issuetemp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issuetemp` (
  `TYPE` varchar(4) NOT NULL DEFAULT '',
  `REFNO` varchar(40) NOT NULL,
  `REFNO2` varchar(24) DEFAULT NULL,
  `TRANCODE` int(4) NOT NULL DEFAULT '0',
  `CUSTNO` varchar(12) NOT NULL DEFAULT '',
  `FPERIOD` varchar(2) DEFAULT '0',
  `WOS_DATE` date NOT NULL DEFAULT '0000-00-00',
  `CURRRATE` double(16,10) NOT NULL DEFAULT '0.0000000000',
  `ITEMCOUNT` int(4) NOT NULL DEFAULT '0',
  `LINECODE` varchar(2) DEFAULT NULL,
  `ITEMNO` varchar(28) NOT NULL DEFAULT '',
  `DESP` varchar(450) DEFAULT '',
  `DESPA` varchar(450) DEFAULT '',
  `AGENNO` varchar(20) NOT NULL DEFAULT '',
  `LOCATION` varchar(24) DEFAULT NULL,
  `SOURCE` varchar(40) DEFAULT '',
  `JOB` varchar(40) DEFAULT '',
  `SIGN` varchar(2) DEFAULT NULL,
  `QTY_BIL` double(17,5) NOT NULL DEFAULT '0.00000',
  `PRICE_BIL` double(17,5) NOT NULL DEFAULT '0.00000',
  `UNIT_BIL` varchar(12) NOT NULL DEFAULT '',
  `AMT1_BIL` double(17,5) NOT NULL DEFAULT '0.00000',
  `DISPEC1` varchar(10) DEFAULT NULL,
  `DISPEC2` varchar(10) DEFAULT NULL,
  `DISPEC3` varchar(10) DEFAULT NULL,
  `DISAMT_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `AMT_BIL` double(17,5) NOT NULL DEFAULT '0.00000',
  `TAXPEC1` varchar(5) DEFAULT NULL,
  `TAXPEC2` varchar(5) DEFAULT NULL,
  `TAXPEC3` varchar(5) DEFAULT NULL,
  `TAXAMT_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `NOTE_A` varchar(8) DEFAULT NULL,
  `IMPSTAGE` char(1) DEFAULT NULL,
  `QTY` double(17,5) NOT NULL DEFAULT '0.00000',
  `PRICE` double(17,5) NOT NULL DEFAULT '0.00000',
  `UNIT` varchar(12) DEFAULT NULL,
  `AMT1` double(17,5) NOT NULL DEFAULT '0.00000',
  `DISAMT` double(15,5) NOT NULL DEFAULT '0.00000',
  `AMT` double(17,5) NOT NULL DEFAULT '0.00000',
  `TAXAMT` double(15,5) NOT NULL DEFAULT '0.00000',
  `FACTOR1` varchar(9) DEFAULT NULL,
  `FACTOR2` varchar(9) DEFAULT NULL,
  `DONO` varchar(40) DEFAULT NULL,
  `DODATE` date NOT NULL DEFAULT '0000-00-00',
  `SODATE` date NOT NULL DEFAULT '0000-00-00',
  `BREM1` varchar(40) DEFAULT NULL,
  `BREM2` varchar(40) DEFAULT NULL,
  `BREM3` varchar(40) DEFAULT NULL,
  `BREM4` varchar(40) DEFAULT NULL,
  `PACKING` varchar(13) DEFAULT NULL,
  `NOTE1` varchar(10) DEFAULT NULL,
  `NOTE2` varchar(10) DEFAULT NULL,
  `GLTRADAC` varchar(8) DEFAULT NULL,
  `UPDCOST` char(1) DEFAULT NULL,
  `GST_ITEM` char(1) DEFAULT NULL,
  `TOTALUP` char(1) DEFAULT NULL,
  `WITHSN` char(1) DEFAULT NULL,
  `NODISPLAY` char(1) NOT NULL DEFAULT '',
  `GRADE` varchar(10) DEFAULT NULL,
  `PUR_PRICE` double(17,5) NOT NULL DEFAULT '0.00000',
  `QTY1` double(17,5) NOT NULL DEFAULT '0.00000',
  `QTY2` double(17,5) NOT NULL DEFAULT '0.00000',
  `QTY3` double(17,5) NOT NULL DEFAULT '0.00000',
  `QTY4` double(17,5) NOT NULL DEFAULT '0.00000',
  `QTY5` double(17,5) NOT NULL DEFAULT '0.00000',
  `QTY6` double(17,5) NOT NULL DEFAULT '0.00000',
  `QTY7` double(17,5) NOT NULL DEFAULT '0.00000',
  `QTY_RET` double(17,5) NOT NULL DEFAULT '0.00000',
  `TEMPFIGI` double(15,5) NOT NULL DEFAULT '0.00000',
  `SERCOST` double(13,5) NOT NULL DEFAULT '0.00000',
  `M_CHARGE1` double(15,5) NOT NULL DEFAULT '0.00000',
  `M_CHARGE2` double(15,5) NOT NULL DEFAULT '0.00000',
  `ADTCOST1` double(15,5) NOT NULL DEFAULT '0.00000',
  `ADTCOST2` double(15,5) NOT NULL DEFAULT '0.00000',
  `IT_COS` double(17,5) NOT NULL DEFAULT '0.00000',
  `AV_COST` double(17,5) NOT NULL DEFAULT '0.00000',
  `BATCHCODE` varchar(15) DEFAULT NULL,
  `EXPDATE` date NOT NULL DEFAULT '0000-00-00',
  `POINT` double(12,4) NOT NULL DEFAULT '0.0000',
  `INV_DISC` double(17,5) NOT NULL DEFAULT '0.00000',
  `INV_TAX` double(17,5) NOT NULL DEFAULT '0.00000',
  `SUPP` varchar(12) DEFAULT NULL,
  `EDI_COU1` varchar(12) DEFAULT NULL,
  `WRITEOFF` double(17,5) NOT NULL DEFAULT '0.00000',
  `TOSHIP` double(17,5) NOT NULL DEFAULT '0.00000',
  `SHIPPED` double(17,5) NOT NULL DEFAULT '0.00000',
  `NAME` varchar(40) DEFAULT NULL,
  `DEL_BY` varchar(12) DEFAULT NULL,
  `VAN` varchar(8) DEFAULT NULL,
  `GENERATED` char(1) DEFAULT NULL,
  `UD_QTY` char(1) DEFAULT NULL,
  `TOINV` varchar(24) DEFAULT NULL,
  `EXPORTED` varchar(24) DEFAULT NULL,
  `EXPORTED1` date NOT NULL DEFAULT '0000-00-00',
  `EXPORTED2` varchar(24) DEFAULT NULL,
  `EXPORTED3` date NOT NULL DEFAULT '0000-00-00',
  `BRK_TO` char(1) DEFAULT NULL,
  `SV_PART` varchar(24) DEFAULT NULL,
  `LAST_YEAR` char(1) DEFAULT NULL,
  `VOID` char(1) DEFAULT NULL,
  `SONO` varchar(40) DEFAULT NULL,
  `MC1_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `MC2_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `USERID` varchar(50) DEFAULT NULL,
  `DAMT` double(15,5) NOT NULL DEFAULT '0.00000',
  `OLDBILL` char(1) DEFAULT NULL,
  `WOS_GROUP` varchar(25) NOT NULL DEFAULT '',
  `CATEGORY` varchar(80) DEFAULT NULL,
  `AREA` varchar(12) DEFAULT NULL,
  `SHELF` varchar(8) DEFAULT NULL,
  `TEMP` varchar(24) DEFAULT NULL,
  `TEMP1` double(17,5) NOT NULL DEFAULT '0.00000',
  `BODY` char(1) DEFAULT NULL,
  `TOTALGROUP` varchar(3) DEFAULT NULL,
  `MARK` char(1) DEFAULT NULL,
  `TYPE_SEQ` varchar(2) DEFAULT NULL,
  `PROMOTER` varchar(8) DEFAULT NULL,
  `TABLENO` varchar(4) DEFAULT NULL,
  `MEMBER` varchar(20) DEFAULT NULL,
  `TOURGROUP` varchar(3) DEFAULT NULL,
  `TRDATETIME` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `TIME` varchar(8) DEFAULT NULL,
  `BOMNO` char(1) DEFAULT NULL,
  `COMMENT` blob,
  `DEFECTIVE` char(1) DEFAULT NULL,
  `M_CHARGE3` double(15,5) NOT NULL DEFAULT '0.00000',
  `M_CHARGE4` double(15,5) NOT NULL DEFAULT '0.00000',
  `M_CHARGE5` double(15,5) NOT NULL DEFAULT '0.00000',
  `M_CHARGE6` double(15,5) NOT NULL DEFAULT '0.00000',
  `M_CHARGE7` double(15,5) NOT NULL DEFAULT '0.00000',
  `MC3_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `MC4_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `MC5_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `MC6_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `MC7_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `taxincl` varchar(45) DEFAULT NULL,
  `LOC_CURRRATE` double(16,10) NOT NULL DEFAULT '1.0000000000',
  `LOC_CURRCODE` varchar(15) NOT NULL DEFAULT '',
  `TITLE_ID` varchar(45) NOT NULL DEFAULT '',
  `TITLE_DESP` varchar(100) NOT NULL DEFAULT '',
  `brem5` varchar(450) DEFAULT NULL,
  `brem6` varchar(450) DEFAULT NULL,
  `uuid` varchar(50) NOT NULL DEFAULT '',
  `driver` varchar(200) DEFAULT '',
  `rem9` varchar(1000) DEFAULT '',
  `onhold` varchar(45) DEFAULT '',
  `promotion` varchar(45) DEFAULT '',
  PRIMARY KEY (`TYPE`,`REFNO`,`CUSTNO`,`TRANCODE`,`ITEMCOUNT`,`ITEMNO`,`WOS_DATE`,`uuid`) USING BTREE,
  KEY `COSTING` (`ITEMNO`,`TYPE`,`REFNO`,`TRANCODE`,`QTY`,`AMT`,`IT_COS`,`TOINV`,`VOID`),
  KEY `ASSMITEM` (`ITEMNO`,`TYPE`,`REFNO`,`FPERIOD`,`WOS_DATE`,`LOCATION`,`SOURCE`,`QTY`,`AMT`,`IT_COS`,`VOID`,`WOS_GROUP`,`CATEGORY`,`AREA`,`SHELF`,`BOMNO`),
  KEY `BATCHITEM` (`ITEMNO`,`TYPE`,`REFNO`,`CUSTNO`,`FPERIOD`,`WOS_DATE`,`AGENNO`,`LOCATION`,`QTY`,`AMT`,`BATCHCODE`,`EXPDATE`,`TOINV`,`WOS_GROUP`,`CATEGORY`,`AREA`),
  KEY `ITEMREPORT` (`ITEMNO`,`TYPE`,`FPERIOD`,`WOS_DATE`,`AGENNO`,`LOCATION`,`SOURCE`,`QTY`,`AMT`,`IT_COS`,`WOS_GROUP`,`CATEGORY`,`AREA`,`SHELF`,`SHIPPED`,`TOINV`),
  KEY `CUSTREPORT` (`CUSTNO`,`TYPE`,`ITEMNO`,`FPERIOD`,`WOS_DATE`,`AGENNO`,`LOCATION`,`SOURCE`,`QTY`,`AMT`,`IT_COS`,`SHIPPED`,`TOINV`,`WOS_GROUP`,`CATEGORY`,`AREA`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issuetemp`
--

LOCK TABLES `issuetemp` WRITE;
/*!40000 ALTER TABLE `issuetemp` DISABLE KEYS */;
/*!40000 ALTER TABLE `issuetemp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `itemgrd`
--

DROP TABLE IF EXISTS `itemgrd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `itemgrd` (
  `ITEMNO` varchar(60) NOT NULL DEFAULT '',
  `GRD11` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD12` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD13` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD14` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD15` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD16` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD17` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD18` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD19` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD20` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD21` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD22` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD23` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD24` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD25` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD26` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD27` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD28` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD29` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD30` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD31` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD32` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD33` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD34` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD35` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD36` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD37` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD38` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD39` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD40` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD41` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD42` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD43` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD44` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD45` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD46` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD47` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD48` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD49` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD50` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD51` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD52` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD53` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD54` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD55` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD56` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD57` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD58` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD59` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD60` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD61` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD62` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD63` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD64` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD65` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD66` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD67` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD68` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD69` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD70` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD71` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD72` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD73` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD74` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD75` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD76` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD77` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD78` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD79` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD80` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD81` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD82` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD83` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD84` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD85` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD86` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD87` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD88` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD89` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD90` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD91` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD92` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD93` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD94` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD95` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD96` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD97` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD98` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD99` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD100` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD101` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD102` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD103` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD104` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD105` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD106` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD107` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD108` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD109` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD110` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD111` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD112` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD113` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD114` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD115` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD116` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD117` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD118` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD119` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD120` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD121` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD122` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD123` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD124` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD125` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD126` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD127` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD128` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD129` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD130` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD131` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD132` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD133` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD134` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD135` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD136` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD137` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD138` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD139` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD140` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD141` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD142` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD143` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD144` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD145` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD146` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD147` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD148` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD149` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD150` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD151` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD152` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD153` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD154` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD155` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD156` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD157` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD158` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD159` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD160` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD161` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD162` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD163` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD164` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD165` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD166` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD167` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD168` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD169` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD170` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD171` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD172` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD173` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD174` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD175` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD176` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD177` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD178` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD179` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD180` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD181` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD182` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD183` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD184` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD185` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD186` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD187` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD188` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD189` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD190` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD191` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD192` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD193` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD194` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD195` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD196` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD197` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD198` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD199` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD200` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD201` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD202` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD203` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD204` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD205` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD206` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD207` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD208` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD209` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD210` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD211` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD212` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD213` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD214` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD215` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD216` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD217` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD218` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD219` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD220` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD221` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD222` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD223` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD224` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD225` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD226` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD227` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD228` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD229` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD230` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD231` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD232` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD233` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD234` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD235` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD236` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD237` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD238` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD239` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD240` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD241` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD242` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD243` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD244` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD245` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD246` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD247` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD248` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD249` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD250` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD251` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD252` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD253` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD254` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD255` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD256` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD257` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD258` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD259` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD260` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD261` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD262` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD263` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD264` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD265` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD266` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD267` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD268` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD269` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD270` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD271` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD272` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD273` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD274` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD275` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD276` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD277` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD278` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD279` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD280` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD281` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD282` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD283` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD284` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD285` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD286` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD287` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD288` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD289` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD290` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD291` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD292` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD293` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD294` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD295` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD296` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD297` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD298` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD299` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD300` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD301` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD302` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD303` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD304` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD305` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD306` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD307` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD308` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD309` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD310` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD11` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD12` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD13` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD14` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD15` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD16` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD17` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD18` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD19` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD20` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD21` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD22` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD23` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD24` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD25` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD26` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD27` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD28` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD29` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD30` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD31` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD32` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD33` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD34` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD35` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD36` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD37` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD38` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD39` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD40` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD41` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD42` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD43` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD44` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD45` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD46` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD47` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD48` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD49` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD50` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD51` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD52` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD53` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD54` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD55` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD56` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD57` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD58` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD59` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD60` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD61` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD62` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD63` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD64` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD65` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD66` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD67` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD68` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD69` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD70` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD71` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD72` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD73` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD74` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD75` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD76` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD77` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD78` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD79` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD80` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD81` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD82` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD83` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD84` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD85` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD86` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD87` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD88` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD89` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD90` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD91` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD92` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD93` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD94` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD95` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD96` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD97` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD98` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD99` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD100` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD101` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD102` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD103` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD104` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD105` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD106` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD107` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD108` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD109` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD110` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD111` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD112` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD113` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD114` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD115` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD116` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD117` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD118` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD119` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD120` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD121` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD122` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD123` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD124` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD125` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD126` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD127` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD128` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD129` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD130` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD131` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD132` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD133` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD134` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD135` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD136` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD137` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD138` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD139` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD140` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD141` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD142` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD143` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD144` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD145` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD146` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD147` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD148` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD149` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD150` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD151` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD152` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD153` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD154` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD155` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD156` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD157` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD158` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD159` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD160` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD161` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD162` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD163` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD164` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD165` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD166` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD167` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD168` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD169` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD170` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD171` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD172` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD173` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD174` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD175` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD176` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD177` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD178` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD179` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD180` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD181` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD182` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD183` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD184` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD185` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD186` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD187` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD188` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD189` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD190` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD191` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD192` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD193` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD194` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD195` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD196` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD197` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD198` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD199` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD200` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD201` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD202` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD203` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD204` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD205` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD206` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD207` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD208` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD209` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD210` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD211` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD212` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD213` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD214` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD215` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD216` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD217` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD218` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD219` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD220` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD221` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD222` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD223` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD224` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD225` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD226` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD227` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD228` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD229` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD230` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD231` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD232` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD233` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD234` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD235` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD236` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD237` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD238` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD239` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD240` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD241` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD242` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD243` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD244` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD245` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD246` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD247` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD248` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD249` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD250` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD251` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD252` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD253` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD254` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD255` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD256` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD257` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD258` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD259` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD260` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD261` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD262` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD263` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD264` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD265` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD266` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD267` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD268` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD269` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD270` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD271` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD272` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD273` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD274` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD275` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD276` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD277` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD278` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD279` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD280` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD281` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD282` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD283` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD284` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD285` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD286` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD287` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD288` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD289` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD290` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD291` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD292` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD293` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD294` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD295` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD296` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD297` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD298` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD299` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD300` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD301` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD302` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD303` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD304` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD305` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD306` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD307` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD308` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD309` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD310` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD11` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD12` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD13` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD14` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD15` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD16` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD17` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD18` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD19` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD20` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD21` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD22` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD23` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD24` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD25` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD26` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD27` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD28` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD29` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD30` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD31` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD32` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD33` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD34` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD35` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD36` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD37` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD38` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD39` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD40` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD41` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD42` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD43` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD44` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD45` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD46` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD47` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD48` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD49` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD50` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD51` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD52` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD53` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD54` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD55` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD56` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD57` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD58` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD59` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD60` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD61` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD62` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD63` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD64` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD65` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD66` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD67` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD68` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD69` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD70` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD71` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD72` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD73` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD74` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD75` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD76` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD77` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD78` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD79` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD80` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD81` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD82` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD83` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD84` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD85` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD86` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD87` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD88` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD89` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD90` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD91` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD92` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD93` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD94` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD95` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD96` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD97` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD98` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD99` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD100` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD101` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD102` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD103` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD104` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD105` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD106` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD107` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD108` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD109` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD110` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD111` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD112` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD113` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD114` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD115` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD116` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD117` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD118` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD119` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD120` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD121` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD122` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD123` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD124` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD125` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD126` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD127` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD128` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD129` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD130` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD131` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD132` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD133` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD134` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD135` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD136` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD137` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD138` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD139` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD140` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD141` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD142` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD143` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD144` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD145` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD146` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD147` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD148` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD149` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD150` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD151` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD152` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD153` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD154` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD155` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD156` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD157` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD158` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD159` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD160` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD161` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD162` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD163` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD164` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD165` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD166` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD167` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD168` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD169` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD170` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD171` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD172` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD173` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD174` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD175` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD176` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD177` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD178` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD179` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD180` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD181` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD182` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD183` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD184` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD185` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD186` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD187` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD188` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD189` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD190` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD191` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD192` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD193` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD194` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD195` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD196` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD197` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD198` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD199` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD200` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD201` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD202` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD203` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD204` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD205` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD206` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD207` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD208` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD209` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD210` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD211` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD212` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD213` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD214` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD215` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD216` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD217` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD218` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD219` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD220` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD221` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD222` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD223` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD224` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD225` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD226` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD227` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD228` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD229` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD230` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD231` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD232` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD233` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD234` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD235` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD236` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD237` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD238` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD239` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD240` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD241` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD242` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD243` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD244` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD245` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD246` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD247` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD248` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD249` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD250` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD251` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD252` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD253` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD254` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD255` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD256` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD257` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD258` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD259` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD260` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD261` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD262` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD263` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD264` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD265` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD266` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD267` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD268` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD269` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD270` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD271` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD272` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD273` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD274` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD275` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD276` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD277` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD278` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD279` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD280` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD281` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD282` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD283` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD284` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD285` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD286` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD287` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD288` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD289` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD290` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD291` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD292` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD293` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD294` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD295` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD296` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD297` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD298` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD299` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD300` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD301` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD302` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD303` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD304` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD305` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD306` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD307` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD308` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD309` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD310` double(11,5) NOT NULL DEFAULT '0.00000',
  PRIMARY KEY (`ITEMNO`),
  KEY `ITEMGRADE1` (`ITEMNO`,`GRD11`,`GRD12`,`GRD13`,`GRD14`,`GRD15`,`GRD16`,`GRD17`,`BGRD11`,`BGRD12`,`BGRD13`,`BGRD14`,`BGRD15`,`BGRD16`,`BGRD17`),
  KEY `ITEMGRADE2` (`ITEMNO`,`GRD18`,`GRD19`,`GRD20`,`GRD21`,`GRD22`,`GRD23`,`GRD24`,`BGRD18`,`BGRD19`,`BGRD20`,`BGRD21`,`BGRD22`,`BGRD23`,`BGRD24`),
  KEY `ITEMGRADE3` (`ITEMNO`,`GRD25`,`GRD26`,`GRD27`,`GRD28`,`GRD29`,`GRD30`,`GRD31`,`BGRD25`,`BGRD26`,`BGRD27`,`BGRD28`,`BGRD29`,`BGRD30`,`BGRD31`),
  KEY `ITEMGRADE4` (`ITEMNO`,`GRD32`,`GRD33`,`GRD34`,`GRD35`,`GRD36`,`GRD37`,`GRD38`,`BGRD32`,`BGRD33`,`BGRD34`,`BGRD35`,`BGRD36`,`BGRD37`,`BGRD38`),
  KEY `ITEMGRADE5` (`ITEMNO`,`GRD39`,`GRD40`,`GRD41`,`GRD42`,`GRD43`,`GRD44`,`GRD45`,`BGRD39`,`BGRD40`,`BGRD41`,`BGRD42`,`BGRD43`,`BGRD44`,`BGRD45`),
  KEY `ITEMGRADE6` (`ITEMNO`,`GRD46`,`GRD47`,`GRD48`,`GRD49`,`GRD50`,`GRD51`,`GRD52`,`BGRD46`,`BGRD47`,`BGRD48`,`BGRD49`,`BGRD50`,`BGRD51`,`BGRD52`),
  KEY `ITEMGRADE7` (`ITEMNO`,`GRD53`,`GRD54`,`GRD55`,`GRD56`,`GRD57`,`GRD58`,`GRD59`,`BGRD53`,`BGRD54`,`BGRD55`,`BGRD56`,`BGRD57`,`BGRD58`,`BGRD59`),
  KEY `ITEMGRADE8` (`ITEMNO`,`GRD60`,`GRD61`,`GRD62`,`GRD63`,`GRD64`,`GRD65`,`GRD66`,`BGRD60`,`BGRD61`,`BGRD62`,`BGRD63`,`BGRD64`,`BGRD65`,`BGRD66`),
  KEY `ITEMGRADE9` (`ITEMNO`,`GRD67`,`GRD68`,`GRD69`,`GRD70`,`BGRD67`,`BGRD68`,`BGRD69`,`BGRD70`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `itemgrd`
--

LOCK TABLES `itemgrd` WRITE;
/*!40000 ALTER TABLE `itemgrd` DISABLE KEYS */;
/*!40000 ALTER TABLE `itemgrd` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lobthob`
--

DROP TABLE IF EXISTS `lobthob`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lobthob` (
  `LOCATION` varchar(24) NOT NULL DEFAULT '',
  `BATCHCODE` varchar(15) NOT NULL DEFAULT '',
  `ITEMNO` varchar(60) NOT NULL DEFAULT '',
  `TYPE` varchar(4) NOT NULL DEFAULT '',
  `REFNO` varchar(8) NOT NULL DEFAULT '',
  `BTH_QOB` double NOT NULL DEFAULT '0',
  `BTH_QIN` double NOT NULL DEFAULT '0',
  `BTH_QUT` double NOT NULL DEFAULT '0',
  `RPT_QOB` double NOT NULL DEFAULT '0',
  `RPT_QIN` double NOT NULL DEFAULT '0',
  `RPT_QUT` double NOT NULL DEFAULT '0',
  `EXPDATE` date NOT NULL DEFAULT '0000-00-00',
  `manudate` date NOT NULL DEFAULT '0000-00-00',
  `countryoforigin` varchar(200) NOT NULL DEFAULT '',
  `pallet` double(17,7) NOT NULL DEFAULT '0.0000000',
  `RC_TYPE` varchar(4) NOT NULL DEFAULT '',
  `RC_REFNO` varchar(8) NOT NULL DEFAULT '',
  `RC_EXPDATE` date NOT NULL DEFAULT '0000-00-00',
  `milcert` varchar(100) NOT NULL DEFAULT '',
  `importpermit` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`LOCATION`,`BATCHCODE`,`ITEMNO`) USING BTREE,
  KEY `LOCTIONBATCHINFO` (`LOCATION`,`BATCHCODE`,`ITEMNO`,`TYPE`,`REFNO`,`BTH_QOB`,`BTH_QIN`,`BTH_QUT`,`RPT_QOB`,`RPT_QIN`,`RPT_QUT`,`EXPDATE`,`RC_TYPE`,`RC_REFNO`,`RC_EXPDATE`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lobthob`
--

LOCK TABLES `lobthob` WRITE;
/*!40000 ALTER TABLE `lobthob` DISABLE KEYS */;
/*!40000 ALTER TABLE `lobthob` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locqdbf`
--

DROP TABLE IF EXISTS `locqdbf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locqdbf` (
  `ITEMNO` varchar(60) NOT NULL DEFAULT '',
  `LOCATION` varchar(24) NOT NULL DEFAULT '',
  `LOCQFIELD` double(17,7) NOT NULL DEFAULT '0.0000000',
  `LOCQACTUAL` double(17,7) NOT NULL DEFAULT '0.0000000',
  `LOCQTRAN` double(17,7) NOT NULL DEFAULT '0.0000000',
  `LMINIMUM` double(17,7) NOT NULL DEFAULT '0.0000000',
  `LREORDER` double(17,7) NOT NULL DEFAULT '0.0000000',
  `QTY_BAL` double(17,7) NOT NULL DEFAULT '0.0000000',
  `VAL_BAL` double(17,7) NOT NULL DEFAULT '0.0000000',
  `PRICE` double(17,7) NOT NULL DEFAULT '0.0000000',
  `WOS_GROUP` varchar(50) DEFAULT '',
  `CATEGORY` varchar(80) DEFAULT '',
  `SHELF` varchar(8) NOT NULL DEFAULT '',
  `SUPP` varchar(12) NOT NULL DEFAULT '',
  `desp` varchar(100) DEFAULT '',
  PRIMARY KEY (`ITEMNO`,`LOCATION`) USING BTREE,
  KEY `LOCATION_ITEM_INFO` (`ITEMNO`,`LOCATION`,`LOCQFIELD`,`LOCQACTUAL`,`LOCQTRAN`,`LMINIMUM`,`LREORDER`,`QTY_BAL`,`VAL_BAL`,`PRICE`,`WOS_GROUP`,`CATEGORY`,`SHELF`,`SUPP`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locqdbf`
--

LOCK TABLES `locqdbf` WRITE;
/*!40000 ALTER TABLE `locqdbf` DISABLE KEYS */;
/*!40000 ALTER TABLE `locqdbf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logrdob`
--

DROP TABLE IF EXISTS `logrdob`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logrdob` (
  `ITEMNO` varchar(60) NOT NULL DEFAULT '',
  `LOCATION` varchar(24) NOT NULL DEFAULT '',
  `GRD11` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD12` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD13` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD14` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD15` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD16` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD17` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD18` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD19` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD20` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD21` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD22` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD23` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD24` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD25` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD26` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD27` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD28` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD29` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD30` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD31` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD32` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD33` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD34` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD35` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD36` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD37` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD38` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD39` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD40` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD41` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD42` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD43` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD44` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD45` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD46` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD47` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD48` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD49` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD50` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD51` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD52` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD53` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD54` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD55` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD56` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD57` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD58` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD59` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD60` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD61` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD62` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD63` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD64` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD65` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD66` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD67` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD68` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD69` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD70` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD71` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD72` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD73` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD74` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD75` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD76` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD77` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD78` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD79` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD80` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD81` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD82` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD83` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD84` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD85` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD86` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD87` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD88` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD89` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD90` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD91` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD92` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD93` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD94` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD95` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD96` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD97` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD98` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD99` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD100` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD101` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD102` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD103` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD104` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD105` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD106` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD107` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD108` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD109` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD110` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD111` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD112` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD113` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD114` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD115` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD116` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD117` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD118` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD119` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD120` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD121` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD122` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD123` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD124` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD125` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD126` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD127` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD128` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD129` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD130` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD131` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD132` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD133` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD134` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD135` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD136` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD137` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD138` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD139` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD140` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD141` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD142` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD143` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD144` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD145` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD146` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD147` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD148` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD149` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD150` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD151` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD152` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD153` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD154` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD155` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD156` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD157` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD158` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD159` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD160` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD161` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD162` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD163` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD164` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD165` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD166` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD167` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD168` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD169` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD170` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD171` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD172` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD173` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD174` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD175` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD176` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD177` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD178` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD179` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD180` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD181` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD182` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD183` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD184` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD185` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD186` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD187` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD188` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD189` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD190` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD191` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD192` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD193` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD194` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD195` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD196` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD197` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD198` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD199` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD200` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD201` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD202` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD203` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD204` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD205` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD206` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD207` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD208` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD209` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD210` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD211` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD212` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD213` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD214` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD215` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD216` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD217` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD218` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD219` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD220` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD221` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD222` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD223` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD224` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD225` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD226` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD227` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD228` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD229` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD230` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD231` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD232` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD233` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD234` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD235` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD236` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD237` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD238` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD239` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD240` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD241` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD242` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD243` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD244` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD245` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD246` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD247` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD248` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD249` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD250` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD251` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD252` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD253` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD254` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD255` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD256` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD257` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD258` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD259` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD260` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD261` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD262` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD263` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD264` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD265` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD266` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD267` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD268` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD269` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD270` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD271` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD272` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD273` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD274` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD275` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD276` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD277` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD278` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD279` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD280` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD281` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD282` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD283` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD284` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD285` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD286` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD287` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD288` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD289` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD290` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD291` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD292` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD293` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD294` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD295` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD296` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD297` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD298` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD299` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD300` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD301` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD302` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD303` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD304` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD305` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD306` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD307` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD308` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD309` double(11,5) NOT NULL DEFAULT '0.00000',
  `GRD310` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD11` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD12` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD13` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD14` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD15` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD16` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD17` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD18` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD19` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD20` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD21` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD22` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD23` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD24` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD25` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD26` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD27` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD28` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD29` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD30` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD31` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD32` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD33` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD34` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD35` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD36` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD37` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD38` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD39` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD40` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD41` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD42` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD43` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD44` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD45` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD46` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD47` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD48` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD49` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD50` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD51` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD52` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD53` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD54` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD55` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD56` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD57` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD58` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD59` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD60` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD61` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD62` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD63` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD64` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD65` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD66` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD67` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD68` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD69` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD70` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD71` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD72` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD73` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD74` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD75` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD76` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD77` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD78` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD79` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD80` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD81` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD82` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD83` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD84` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD85` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD86` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD87` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD88` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD89` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD90` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD91` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD92` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD93` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD94` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD95` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD96` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD97` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD98` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD99` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD100` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD101` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD102` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD103` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD104` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD105` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD106` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD107` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD108` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD109` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD110` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD111` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD112` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD113` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD114` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD115` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD116` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD117` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD118` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD119` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD120` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD121` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD122` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD123` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD124` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD125` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD126` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD127` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD128` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD129` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD130` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD131` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD132` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD133` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD134` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD135` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD136` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD137` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD138` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD139` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD140` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD141` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD142` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD143` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD144` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD145` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD146` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD147` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD148` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD149` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD150` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD151` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD152` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD153` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD154` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD155` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD156` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD157` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD158` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD159` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD160` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD161` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD162` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD163` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD164` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD165` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD166` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD167` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD168` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD169` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD170` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD171` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD172` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD173` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD174` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD175` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD176` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD177` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD178` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD179` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD180` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD181` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD182` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD183` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD184` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD185` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD186` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD187` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD188` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD189` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD190` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD191` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD192` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD193` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD194` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD195` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD196` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD197` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD198` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD199` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD200` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD201` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD202` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD203` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD204` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD205` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD206` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD207` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD208` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD209` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD210` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD211` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD212` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD213` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD214` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD215` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD216` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD217` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD218` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD219` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD220` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD221` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD222` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD223` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD224` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD225` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD226` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD227` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD228` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD229` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD230` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD231` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD232` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD233` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD234` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD235` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD236` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD237` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD238` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD239` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD240` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD241` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD242` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD243` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD244` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD245` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD246` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD247` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD248` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD249` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD250` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD251` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD252` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD253` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD254` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD255` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD256` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD257` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD258` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD259` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD260` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD261` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD262` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD263` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD264` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD265` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD266` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD267` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD268` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD269` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD270` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD271` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD272` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD273` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD274` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD275` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD276` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD277` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD278` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD279` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD280` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD281` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD282` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD283` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD284` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD285` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD286` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD287` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD288` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD289` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD290` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD291` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD292` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD293` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD294` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD295` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD296` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD297` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD298` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD299` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD300` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD301` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD302` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD303` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD304` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD305` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD306` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD307` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD308` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD309` double(11,5) NOT NULL DEFAULT '0.00000',
  `BGRD310` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD11` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD12` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD13` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD14` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD15` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD16` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD17` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD18` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD19` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD20` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD21` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD22` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD23` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD24` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD25` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD26` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD27` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD28` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD29` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD30` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD31` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD32` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD33` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD34` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD35` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD36` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD37` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD38` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD39` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD40` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD41` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD42` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD43` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD44` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD45` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD46` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD47` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD48` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD49` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD50` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD51` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD52` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD53` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD54` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD55` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD56` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD57` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD58` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD59` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD60` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD61` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD62` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD63` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD64` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD65` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD66` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD67` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD68` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD69` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD70` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD71` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD72` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD73` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD74` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD75` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD76` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD77` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD78` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD79` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD80` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD81` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD82` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD83` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD84` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD85` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD86` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD87` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD88` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD89` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD90` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD91` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD92` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD93` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD94` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD95` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD96` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD97` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD98` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD99` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD100` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD101` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD102` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD103` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD104` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD105` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD106` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD107` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD108` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD109` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD110` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD111` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD112` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD113` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD114` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD115` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD116` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD117` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD118` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD119` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD120` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD121` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD122` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD123` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD124` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD125` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD126` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD127` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD128` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD129` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD130` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD131` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD132` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD133` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD134` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD135` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD136` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD137` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD138` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD139` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD140` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD141` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD142` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD143` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD144` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD145` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD146` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD147` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD148` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD149` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD150` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD151` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD152` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD153` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD154` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD155` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD156` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD157` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD158` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD159` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD160` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD161` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD162` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD163` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD164` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD165` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD166` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD167` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD168` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD169` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD170` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD171` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD172` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD173` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD174` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD175` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD176` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD177` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD178` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD179` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD180` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD181` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD182` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD183` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD184` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD185` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD186` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD187` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD188` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD189` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD190` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD191` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD192` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD193` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD194` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD195` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD196` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD197` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD198` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD199` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD200` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD201` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD202` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD203` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD204` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD205` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD206` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD207` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD208` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD209` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD210` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD211` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD212` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD213` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD214` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD215` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD216` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD217` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD218` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD219` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD220` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD221` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD222` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD223` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD224` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD225` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD226` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD227` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD228` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD229` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD230` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD231` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD232` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD233` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD234` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD235` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD236` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD237` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD238` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD239` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD240` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD241` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD242` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD243` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD244` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD245` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD246` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD247` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD248` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD249` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD250` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD251` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD252` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD253` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD254` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD255` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD256` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD257` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD258` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD259` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD260` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD261` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD262` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD263` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD264` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD265` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD266` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD267` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD268` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD269` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD270` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD271` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD272` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD273` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD274` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD275` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD276` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD277` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD278` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD279` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD280` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD281` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD282` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD283` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD284` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD285` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD286` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD287` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD288` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD289` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD290` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD291` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD292` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD293` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD294` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD295` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD296` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD297` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD298` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD299` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD300` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD301` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD302` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD303` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD304` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD305` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD306` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD307` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD308` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD309` double(11,5) NOT NULL DEFAULT '0.00000',
  `CGRD310` double(11,5) NOT NULL DEFAULT '0.00000',
  PRIMARY KEY (`ITEMNO`,`LOCATION`),
  KEY `LOCATIONGRAD1` (`ITEMNO`,`LOCATION`,`GRD11`,`GRD12`,`GRD13`,`GRD14`,`GRD15`,`GRD16`,`GRD17`,`BGRD11`,`BGRD12`,`BGRD13`,`BGRD14`,`BGRD15`,`BGRD16`,`BGRD17`),
  KEY `LOCATIONGRAD2` (`ITEMNO`,`LOCATION`,`GRD18`,`GRD19`,`GRD20`,`GRD21`,`GRD22`,`GRD23`,`GRD24`,`BGRD18`,`BGRD19`,`BGRD20`,`BGRD21`,`BGRD22`,`BGRD23`,`BGRD24`) USING BTREE,
  KEY `LOCATIONGRAD3` (`ITEMNO`,`LOCATION`,`GRD25`,`GRD26`,`GRD27`,`GRD28`,`GRD29`,`GRD30`,`GRD31`,`BGRD25`,`BGRD26`,`BGRD27`,`BGRD28`,`BGRD29`,`BGRD30`,`BGRD31`) USING BTREE,
  KEY `LOCATIONGRAD4` (`ITEMNO`,`LOCATION`,`GRD32`,`GRD33`,`GRD34`,`GRD35`,`GRD36`,`GRD37`,`GRD38`,`BGRD32`,`BGRD33`,`BGRD34`,`BGRD35`,`BGRD36`,`BGRD37`,`BGRD38`) USING BTREE,
  KEY `LOCATIONGRAD5` (`ITEMNO`,`LOCATION`,`GRD39`,`GRD40`,`GRD41`,`GRD42`,`GRD43`,`GRD44`,`GRD45`,`BGRD39`,`BGRD40`,`BGRD41`,`BGRD42`,`BGRD43`,`BGRD44`,`BGRD45`) USING BTREE,
  KEY `LOCATIONGRAD6` (`ITEMNO`,`LOCATION`,`GRD46`,`GRD47`,`GRD48`,`GRD49`,`GRD50`,`GRD51`,`GRD52`,`BGRD46`,`BGRD47`,`BGRD48`,`BGRD49`,`BGRD50`,`BGRD51`,`BGRD52`) USING BTREE,
  KEY `LOCATIONGRAD7` (`ITEMNO`,`LOCATION`,`GRD53`,`GRD54`,`GRD55`,`GRD56`,`GRD57`,`GRD58`,`GRD59`,`BGRD53`,`BGRD54`,`BGRD55`,`BGRD56`,`BGRD57`,`BGRD58`,`BGRD59`) USING BTREE,
  KEY `LOCATIONGRAD8` (`ITEMNO`,`LOCATION`,`GRD60`,`GRD61`,`GRD62`,`GRD63`,`GRD64`,`GRD65`,`GRD66`,`BGRD60`,`BGRD61`,`BGRD62`,`BGRD63`,`BGRD64`,`BGRD65`,`BGRD66`) USING BTREE,
  KEY `LOCATIONGRAD9` (`ITEMNO`,`LOCATION`,`GRD67`,`GRD68`,`GRD69`,`GRD70`,`BGRD67`,`BGRD68`,`BGRD69`,`BGRD70`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logrdob`
--

LOCK TABLES `logrdob` WRITE;
/*!40000 ALTER TABLE `logrdob` DISABLE KEYS */;
/*!40000 ALTER TABLE `logrdob` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `modulecontrol`
--

DROP TABLE IF EXISTS `modulecontrol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `modulecontrol` (
  `companyid` varchar(45) NOT NULL DEFAULT 'IMS',
  `postran` varchar(45) DEFAULT '0',
  `matrixtran` varchar(45) DEFAULT '',
  `simpletran` varchar(45) DEFAULT '0',
  `project` varchar(45) DEFAULT '',
  `auto` varchar(45) DEFAULT '',
  `location` varchar(45) DEFAULT '1',
  `serialno` varchar(45) DEFAULT '1',
  `grade` varchar(45) DEFAULT '1',
  `matrix` varchar(45) DEFAULT '1',
  `manufacturing` varchar(45) DEFAULT '1',
  PRIMARY KEY (`companyid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modulecontrol`
--

LOCK TABLES `modulecontrol` WRITE;
/*!40000 ALTER TABLE `modulecontrol` DISABLE KEYS */;
/*!40000 ALTER TABLE `modulecontrol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `monthcost`
--

DROP TABLE IF EXISTS `monthcost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `monthcost` (
  `ITEMNO` varchar(60) NOT NULL DEFAULT '',
  `COST0` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `QTY0` int(10) NOT NULL DEFAULT '0',
  `AMT0` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `OQTY0` int(10) NOT NULL DEFAULT '0',
  `COST1` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `QTY1` int(10) NOT NULL DEFAULT '0',
  `AMT1` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `OQTY1` int(10) NOT NULL DEFAULT '0',
  `COST2` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `QTY2` int(10) NOT NULL DEFAULT '0',
  `AMT2` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `OQTY2` int(10) NOT NULL DEFAULT '0',
  `COST3` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `QTY3` int(10) NOT NULL DEFAULT '0',
  `AMT3` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `OQTY3` int(10) NOT NULL DEFAULT '0',
  `COST4` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `QTY4` int(10) NOT NULL DEFAULT '0',
  `AMT4` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `OQTY4` int(10) NOT NULL DEFAULT '0',
  `COST5` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `QTY5` int(10) NOT NULL DEFAULT '0',
  `AMT5` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `OQTY5` int(10) NOT NULL DEFAULT '0',
  `COST6` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `QTY6` int(10) NOT NULL DEFAULT '0',
  `AMT6` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `OQTY6` int(10) NOT NULL DEFAULT '0',
  `COST7` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `QTY7` int(10) NOT NULL DEFAULT '0',
  `AMT7` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `OQTY7` int(10) NOT NULL DEFAULT '0',
  `COST8` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `QTY8` int(10) NOT NULL DEFAULT '0',
  `AMT8` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `OQTY8` int(10) NOT NULL DEFAULT '0',
  `COST9` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `QTY9` int(10) NOT NULL DEFAULT '0',
  `AMT9` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `OQTY9` int(10) NOT NULL DEFAULT '0',
  `COST10` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `QTY10` int(10) NOT NULL DEFAULT '0',
  `AMT10` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `OQTY10` int(10) NOT NULL DEFAULT '0',
  `COST11` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `QTY11` int(10) NOT NULL DEFAULT '0',
  `AMT11` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `OQTY11` int(10) NOT NULL DEFAULT '0',
  `COST12` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `QTY12` int(10) NOT NULL DEFAULT '0',
  `AMT12` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `OQTY12` int(10) NOT NULL DEFAULT '0',
  `COST13` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `QTY13` int(10) NOT NULL DEFAULT '0',
  `AMT13` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `OQTY13` int(10) NOT NULL DEFAULT '0',
  `COST14` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `QTY14` int(10) NOT NULL DEFAULT '0',
  `AMT14` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `OQTY14` int(10) NOT NULL DEFAULT '0',
  `COST15` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `QTY15` int(10) NOT NULL DEFAULT '0',
  `AMT15` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `OQTY15` int(10) NOT NULL DEFAULT '0',
  `COST16` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `QTY16` int(10) NOT NULL DEFAULT '0',
  `AMT16` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `OQTY16` int(10) NOT NULL DEFAULT '0',
  `COST17` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `QTY17` int(10) NOT NULL DEFAULT '0',
  `AMT17` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `OQTY17` int(10) NOT NULL DEFAULT '0',
  `COST18` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `QTY18` int(10) NOT NULL DEFAULT '0',
  `AMT18` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `CUMAMT` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `CUMQTY` int(10) NOT NULL DEFAULT '0',
  `CUMCOST` double(20,10) NOT NULL DEFAULT '0.0000000000',
  PRIMARY KEY (`ITEMNO`),
  KEY `MONTHCOST0` (`ITEMNO`,`COST0`,`QTY0`,`AMT0`,`OQTY0`,`CUMAMT`,`CUMQTY`,`CUMCOST`),
  KEY `MONTHCOST1` (`ITEMNO`,`COST1`,`QTY1`,`AMT1`,`OQTY1`,`CUMAMT`,`CUMQTY`,`CUMCOST`),
  KEY `MONTHCOST2` (`ITEMNO`,`COST2`,`QTY2`,`AMT2`,`OQTY2`,`CUMAMT`,`CUMQTY`,`CUMCOST`),
  KEY `MONTHCOST3` (`ITEMNO`,`COST3`,`QTY3`,`AMT3`,`OQTY3`,`CUMAMT`,`CUMQTY`,`CUMCOST`),
  KEY `MONTHCOST4` (`ITEMNO`,`COST4`,`QTY4`,`AMT4`,`OQTY4`,`CUMAMT`,`CUMQTY`,`CUMCOST`),
  KEY `MONTHCOST5` (`ITEMNO`,`COST5`,`QTY5`,`AMT5`,`OQTY5`,`CUMAMT`,`CUMQTY`,`CUMCOST`),
  KEY `MONTHCOST6` (`ITEMNO`,`COST6`,`QTY6`,`AMT6`,`OQTY6`,`CUMAMT`,`CUMQTY`,`CUMCOST`),
  KEY `MONTHCOST7` (`ITEMNO`,`COST7`,`QTY7`,`AMT7`,`OQTY7`,`CUMAMT`,`CUMQTY`,`CUMCOST`),
  KEY `MONTHCOST8` (`ITEMNO`,`COST8`,`QTY8`,`AMT8`,`OQTY8`,`CUMAMT`,`CUMQTY`,`CUMCOST`),
  KEY `MONTHCOST9` (`ITEMNO`,`COST9`,`QTY9`,`AMT9`,`OQTY9`,`CUMAMT`,`CUMQTY`,`CUMCOST`),
  KEY `MONTHCOST10` (`ITEMNO`,`COST10`,`QTY10`,`AMT10`,`OQTY10`,`CUMAMT`,`CUMQTY`,`CUMCOST`),
  KEY `MONTHCOST11` (`ITEMNO`,`COST11`,`QTY11`,`AMT11`,`OQTY11`,`CUMAMT`,`CUMQTY`,`CUMCOST`),
  KEY `MONTHCOST12` (`ITEMNO`,`COST12`,`QTY12`,`AMT12`,`OQTY12`,`CUMAMT`,`CUMQTY`,`CUMCOST`),
  KEY `MONTHCOST13` (`ITEMNO`,`COST13`,`QTY13`,`AMT13`,`OQTY13`,`CUMAMT`,`CUMQTY`,`CUMCOST`),
  KEY `MONTHCOST14` (`ITEMNO`,`COST14`,`QTY14`,`AMT14`,`OQTY14`,`CUMAMT`,`CUMQTY`,`CUMCOST`),
  KEY `MONTHCOST15` (`ITEMNO`,`COST15`,`QTY15`,`AMT15`,`OQTY15`,`CUMAMT`,`CUMQTY`,`CUMCOST`),
  KEY `MONTHCOST16` (`ITEMNO`,`COST16`,`QTY16`,`AMT16`,`OQTY16`,`CUMAMT`,`CUMQTY`,`CUMCOST`),
  KEY `MONTHCOST17` (`ITEMNO`,`COST17`,`QTY17`,`AMT17`,`OQTY17`,`CUMAMT`,`CUMQTY`,`CUMCOST`),
  KEY `MONTHCOST18` (`ITEMNO`,`COST18`,`QTY18`,`AMT18`,`CUMAMT`,`CUMQTY`,`CUMCOST`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `monthcost`
--

LOCK TABLES `monthcost` WRITE;
/*!40000 ALTER TABLE `monthcost` DISABLE KEYS */;
/*!40000 ALTER TABLE `monthcost` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `monthcost_last_year`
--

DROP TABLE IF EXISTS `monthcost_last_year`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `monthcost_last_year` (
  `ITEMNO` varchar(60) NOT NULL DEFAULT '',
  `COST0` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `QTY0` int(10) NOT NULL DEFAULT '0',
  `AMT0` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `OQTY0` int(10) NOT NULL DEFAULT '0',
  `COST1` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `QTY1` int(10) NOT NULL DEFAULT '0',
  `AMT1` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `OQTY1` int(10) NOT NULL DEFAULT '0',
  `COST2` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `QTY2` int(10) NOT NULL DEFAULT '0',
  `AMT2` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `OQTY2` int(10) NOT NULL DEFAULT '0',
  `COST3` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `QTY3` int(10) NOT NULL DEFAULT '0',
  `AMT3` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `OQTY3` int(10) NOT NULL DEFAULT '0',
  `COST4` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `QTY4` int(10) NOT NULL DEFAULT '0',
  `AMT4` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `OQTY4` int(10) NOT NULL DEFAULT '0',
  `COST5` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `QTY5` int(10) NOT NULL DEFAULT '0',
  `AMT5` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `OQTY5` int(10) NOT NULL DEFAULT '0',
  `COST6` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `QTY6` int(10) NOT NULL DEFAULT '0',
  `AMT6` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `OQTY6` int(10) NOT NULL DEFAULT '0',
  `COST7` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `QTY7` int(10) NOT NULL DEFAULT '0',
  `AMT7` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `OQTY7` int(10) NOT NULL DEFAULT '0',
  `COST8` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `QTY8` int(10) NOT NULL DEFAULT '0',
  `AMT8` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `OQTY8` int(10) NOT NULL DEFAULT '0',
  `COST9` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `QTY9` int(10) NOT NULL DEFAULT '0',
  `AMT9` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `OQTY9` int(10) NOT NULL DEFAULT '0',
  `COST10` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `QTY10` int(10) NOT NULL DEFAULT '0',
  `AMT10` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `OQTY10` int(10) NOT NULL DEFAULT '0',
  `COST11` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `QTY11` int(10) NOT NULL DEFAULT '0',
  `AMT11` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `OQTY11` int(10) NOT NULL DEFAULT '0',
  `COST12` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `QTY12` int(10) NOT NULL DEFAULT '0',
  `AMT12` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `OQTY12` int(10) NOT NULL DEFAULT '0',
  `CUMAMT` double(20,10) NOT NULL DEFAULT '0.0000000000',
  `CUMQTY` int(10) NOT NULL DEFAULT '0',
  `CUMCOST` double(20,10) NOT NULL DEFAULT '0.0000000000',
  PRIMARY KEY (`ITEMNO`),
  KEY `MONTHCOST0` (`ITEMNO`,`COST0`,`QTY0`,`AMT0`,`OQTY0`,`CUMAMT`,`CUMQTY`,`CUMCOST`),
  KEY `MONTHCOST1` (`ITEMNO`,`COST1`,`QTY1`,`AMT1`,`OQTY1`,`CUMAMT`,`CUMQTY`,`CUMCOST`),
  KEY `MONTHCOST2` (`ITEMNO`,`COST2`,`QTY2`,`AMT2`,`OQTY2`,`CUMAMT`,`CUMQTY`,`CUMCOST`),
  KEY `MONTHCOST3` (`ITEMNO`,`COST3`,`QTY3`,`AMT3`,`OQTY3`,`CUMAMT`,`CUMQTY`,`CUMCOST`),
  KEY `MONTHCOST4` (`ITEMNO`,`COST4`,`QTY4`,`AMT4`,`OQTY4`,`CUMAMT`,`CUMQTY`,`CUMCOST`),
  KEY `MONTHCOST5` (`ITEMNO`,`COST5`,`QTY5`,`AMT5`,`OQTY5`,`CUMAMT`,`CUMQTY`,`CUMCOST`),
  KEY `MONTHCOST6` (`ITEMNO`,`COST6`,`QTY6`,`AMT6`,`OQTY6`,`CUMAMT`,`CUMQTY`,`CUMCOST`),
  KEY `MONTHCOST7` (`ITEMNO`,`COST7`,`QTY7`,`AMT7`,`OQTY7`,`CUMAMT`,`CUMQTY`,`CUMCOST`),
  KEY `MONTHCOST8` (`ITEMNO`,`COST8`,`QTY8`,`AMT8`,`OQTY8`,`CUMAMT`,`CUMQTY`,`CUMCOST`),
  KEY `MONTHCOST9` (`ITEMNO`,`COST9`,`QTY9`,`AMT9`,`OQTY9`,`CUMAMT`,`CUMQTY`,`CUMCOST`),
  KEY `MONTHCOST10` (`ITEMNO`,`COST10`,`QTY10`,`AMT10`,`OQTY10`,`CUMAMT`,`CUMQTY`,`CUMCOST`),
  KEY `MONTHCOST11` (`ITEMNO`,`COST11`,`QTY11`,`AMT11`,`OQTY11`,`CUMAMT`,`CUMQTY`,`CUMCOST`),
  KEY `MONTHCOST12` (`ITEMNO`,`COST12`,`QTY12`,`AMT12`,`OQTY12`,`CUMAMT`,`CUMQTY`,`CUMCOST`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `monthcost_last_year`
--

LOCK TABLES `monthcost_last_year` WRITE;
/*!40000 ALTER TABLE `monthcost_last_year` DISABLE KEYS */;
/*!40000 ALTER TABLE `monthcost_last_year` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `myfavorite`
--

DROP TABLE IF EXISTS `myfavorite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `myfavorite` (
  `FAVORITE_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `MENU_ID` varchar(45) NOT NULL DEFAULT '',
  `MENU_NAME` varchar(45) NOT NULL DEFAULT '',
  `MENU_URL` varchar(254) NOT NULL DEFAULT '',
  `CREATED_BY` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`FAVORITE_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `myfavorite`
--

LOCK TABLES `myfavorite` WRITE;
/*!40000 ALTER TABLE `myfavorite` DISABLE KEYS */;
/*!40000 ALTER TABLE `myfavorite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `obbatch`
--

DROP TABLE IF EXISTS `obbatch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `obbatch` (
  `BATCHCODE` varchar(45) NOT NULL DEFAULT '',
  `ITEMNO` varchar(60) NOT NULL DEFAULT '',
  `TYPE` varchar(45) NOT NULL DEFAULT '',
  `REFNO` varchar(45) NOT NULL DEFAULT '',
  `BTH_QOB` double NOT NULL DEFAULT '0',
  `BTH_QIN` double NOT NULL DEFAULT '0',
  `BTH_QUT` double NOT NULL DEFAULT '0',
  `RPT_QOB` double NOT NULL DEFAULT '0',
  `RPT_QIN` double NOT NULL DEFAULT '0',
  `RPT_QUT` double NOT NULL DEFAULT '0',
  `EXP_DATE` date NOT NULL DEFAULT '0000-00-00',
  `manu_date` date NOT NULL DEFAULT '0000-00-00',
  `RC_TYPE` varchar(45) NOT NULL DEFAULT '',
  `RC_REFNO` varchar(45) NOT NULL DEFAULT '',
  `RC_EXPDATE` date NOT NULL DEFAULT '0000-00-00',
  `milcert` varchar(100) NOT NULL DEFAULT '',
  `importpermit` varchar(100) NOT NULL DEFAULT '',
  `countryoforigin` varchar(150) DEFAULT '',
  `pallet` double(17,5) NOT NULL DEFAULT '0.00000',
  `pallet_in` double(17,5) NOT NULL DEFAULT '0.00000',
  `pallet_out` double(17,5) NOT NULL DEFAULT '0.00000',
  PRIMARY KEY (`BATCHCODE`,`ITEMNO`) USING BTREE,
  KEY `BATCHINFO` (`BATCHCODE`,`ITEMNO`,`TYPE`,`REFNO`,`BTH_QOB`,`BTH_QIN`,`BTH_QUT`,`RPT_QOB`,`RPT_QIN`,`RPT_QUT`,`EXP_DATE`,`RC_TYPE`,`RC_REFNO`,`RC_EXPDATE`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `obbatch`
--

LOCK TABLES `obbatch` WRITE;
/*!40000 ALTER TABLE `obbatch` DISABLE KEYS */;
/*!40000 ALTER TABLE `obbatch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `obbatch_last_year`
--

DROP TABLE IF EXISTS `obbatch_last_year`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `obbatch_last_year` (
  `BATCHCODE` varchar(45) NOT NULL DEFAULT '',
  `ITEMNO` varchar(60) NOT NULL DEFAULT '',
  `TYPE` varchar(45) NOT NULL DEFAULT '',
  `REFNO` varchar(45) NOT NULL DEFAULT '',
  `BTH_QOB` double NOT NULL DEFAULT '0',
  `BTH_QIN` double NOT NULL DEFAULT '0',
  `BTH_QUT` double NOT NULL DEFAULT '0',
  `RPT_QOB` double NOT NULL DEFAULT '0',
  `RPT_QIN` double NOT NULL DEFAULT '0',
  `RPT_QUT` double NOT NULL DEFAULT '0',
  `EXP_DATE` date NOT NULL DEFAULT '0000-00-00',
  `RC_TYPE` varchar(45) NOT NULL DEFAULT '',
  `RC_REFNO` varchar(45) NOT NULL DEFAULT '',
  `RC_EXPDATE` date NOT NULL DEFAULT '0000-00-00' COMMENT 'Date Of Year End',
  `manu_date` date NOT NULL DEFAULT '0000-00-00',
  `milcert` varchar(100) NOT NULL DEFAULT '',
  `importpermit` varchar(100) NOT NULL DEFAULT '',
  `countryoforigin` varchar(150) DEFAULT '',
  `pallet` double(17,5) NOT NULL DEFAULT '0.00000',
  `pallet_in` double(17,5) NOT NULL DEFAULT '0.00000',
  `pallet_out` double(17,5) NOT NULL DEFAULT '0.00000',
  PRIMARY KEY (`BATCHCODE`,`ITEMNO`) USING BTREE,
  KEY `BATCHINFO` (`BATCHCODE`,`ITEMNO`,`TYPE`,`REFNO`,`BTH_QOB`,`BTH_QIN`,`BTH_QUT`,`RPT_QOB`,`RPT_QIN`,`RPT_QUT`,`EXP_DATE`,`RC_TYPE`,`RC_REFNO`,`RC_EXPDATE`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `obbatch_last_year`
--

LOCK TABLES `obbatch_last_year` WRITE;
/*!40000 ALTER TABLE `obbatch_last_year` DISABLE KEYS */;
/*!40000 ALTER TABLE `obbatch_last_year` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `outreporttemp`
--

DROP TABLE IF EXISTS `outreporttemp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `outreporttemp` (
  `type` varchar(150) DEFAULT NULL,
  `wos_date` varchar(150) DEFAULT NULL,
  `refno` varchar(150) DEFAULT NULL,
  `pono` varchar(150) DEFAULT NULL,
  `customer` varchar(150) DEFAULT NULL,
  `qtyorder` varchar(150) DEFAULT NULL,
  `deliverydate` varchar(150) DEFAULT NULL,
  `writeoff` varchar(150) DEFAULT NULL,
  `qtyoutstand` varchar(150) DEFAULT NULL,
  `price` varchar(150) DEFAULT NULL,
  `amount` varchar(150) DEFAULT NULL,
  `counter_1` varchar(150) DEFAULT NULL,
  `counter_2` varchar(150) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `outreporttemp`
--

LOCK TABLES `outreporttemp` WRITE;
/*!40000 ALTER TABLE `outreporttemp` DISABLE KEYS */;
/*!40000 ALTER TABLE `outreporttemp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `package`
--

DROP TABLE IF EXISTS `package`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `package` (
  `packcode` varchar(100) NOT NULL DEFAULT '',
  `packdesp` varchar(150) DEFAULT '',
  `grossamt` double(17,7) NOT NULL DEFAULT '0.0000000',
  PRIMARY KEY (`packcode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `package`
--

LOCK TABLES `package` WRITE;
/*!40000 ALTER TABLE `package` DISABLE KEYS */;
/*!40000 ALTER TABLE `package` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `packdet`
--

DROP TABLE IF EXISTS `packdet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `packdet` (
  `packcode` varchar(100) NOT NULL DEFAULT '',
  `trancode` int(4) unsigned NOT NULL DEFAULT '0',
  `itemno` varchar(100) NOT NULL DEFAULT '',
  `desp` varchar(100) NOT NULL DEFAULT '',
  `qty_bil` double(17,5) NOT NULL DEFAULT '0.00000',
  `price_bil` double(17,5) NOT NULL DEFAULT '0.00000',
  `dispec1` varchar(10) NOT NULL DEFAULT '0',
  `dispec2` varchar(10) NOT NULL DEFAULT '0',
  `dispec3` varchar(10) NOT NULL DEFAULT '0',
  `disamt_bil` varchar(45) NOT NULL DEFAULT '0',
  `amt_bil` double(17,5) NOT NULL DEFAULT '0.00000',
  `taxpec1` varchar(10) NOT NULL DEFAULT '0',
  `taxpec2` varchar(10) NOT NULL DEFAULT '0',
  `taxpec3` varchar(10) NOT NULL DEFAULT '0',
  `taxamt_bil` double(17,5) NOT NULL DEFAULT '0.00000',
  `despa` varchar(100) NOT NULL DEFAULT '',
  `note_a` varchar(100) DEFAULT '',
  PRIMARY KEY (`packcode`,`trancode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `packdet`
--

LOCK TABLES `packdet` WRITE;
/*!40000 ALTER TABLE `packdet` DISABLE KEYS */;
/*!40000 ALTER TABLE `packdet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `packlist`
--

DROP TABLE IF EXISTS `packlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `packlist` (
  `packID` varchar(100) NOT NULL,
  `driver` varchar(200) DEFAULT NULL,
  `totalbill` text,
  `created_on` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` varchar(200) DEFAULT NULL,
  `updated_on` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by` varchar(200) DEFAULT NULL,
  `assigned_on` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `assigned_by` varchar(200) DEFAULT NULL,
  `delivery_on` date DEFAULT NULL,
  `reftype` varchar(4) NOT NULL DEFAULT '',
  `trip` varchar(45) NOT NULL DEFAULT '',
  `delivered_on` datetime DEFAULT NULL,
  `delivered_by` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`packID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `packlist`
--

LOCK TABLES `packlist` WRITE;
/*!40000 ALTER TABLE `packlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `packlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `packlistbill`
--

DROP TABLE IF EXISTS `packlistbill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `packlistbill` (
  `packListBillID` double NOT NULL AUTO_INCREMENT,
  `packID` varchar(100) DEFAULT NULL,
  `billRefno` varchar(200) DEFAULT NULL,
  `reftype` varchar(4) NOT NULL DEFAULT '',
  `delivered_on` datetime DEFAULT NULL,
  `delivered_by` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`packListBillID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `packlistbill`
--

LOCK TABLES `packlistbill` WRITE;
/*!40000 ALTER TABLE `packlistbill` DISABLE KEYS */;
/*!40000 ALTER TABLE `packlistbill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `poschannel`
--

DROP TABLE IF EXISTS `poschannel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `poschannel` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `posid` varchar(100) DEFAULT '',
  `posfolder` varchar(100) DEFAULT '',
  `lastwork_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_on` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` varchar(100) DEFAULT '',
  `updated_on` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by` varchar(100) DEFAULT '',
  `posbill` varchar(45) DEFAULT '',
  `custno` varchar(45) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `poschannel`
--

LOCK TABLES `poschannel` WRITE;
/*!40000 ALTER TABLE `poschannel` DISABLE KEYS */;
/*!40000 ALTER TABLE `poschannel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `postlog`
--

DROP TABLE IF EXISTS `postlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `postlog` (
  `postid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Action` varchar(45) DEFAULT NULL,
  `billtype` varchar(45) DEFAULT NULL,
  `actiontype` varchar(45) DEFAULT NULL,
  `actiondata` text,
  `user` varchar(45) DEFAULT NULL,
  `timeaccess` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`postid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `postlog`
--

LOCK TABLES `postlog` WRITE;
/*!40000 ALTER TABLE `postlog` DISABLE KEYS */;
/*!40000 ALTER TABLE `postlog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `poststatus`
--

DROP TABLE IF EXISTS `poststatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `poststatus` (
  `system` varchar(45) NOT NULL,
  `armstatus` varchar(45) DEFAULT NULL,
  `armedon` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `armedby` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`system`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `poststatus`
--

LOCK TABLES `poststatus` WRITE;
/*!40000 ALTER TABLE `poststatus` DISABLE KEYS */;
/*!40000 ALTER TABLE `poststatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `print_barcode_setting`
--

DROP TABLE IF EXISTS `print_barcode_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `print_barcode_setting` (
  `no_copies` varchar(45) DEFAULT NULL,
  `id` int(11) NOT NULL DEFAULT '1',
  `wide_version` varchar(45) DEFAULT NULL,
  `bar_code` varchar(45) DEFAULT NULL,
  `format_2` varchar(45) DEFAULT NULL,
  `format_3` varchar(45) DEFAULT NULL,
  `spacing` varchar(45) DEFAULT NULL,
  `top_spacing` varchar(45) DEFAULT NULL,
  `left_spacing` varchar(45) DEFAULT NULL,
  `font_size` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `print_barcode_setting`
--

LOCK TABLES `print_barcode_setting` WRITE;
/*!40000 ALTER TABLE `print_barcode_setting` DISABLE KEYS */;
/*!40000 ALTER TABLE `print_barcode_setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project` (
  `SOURCE` varchar(40) NOT NULL,
  `PROJECT` varchar(40) NOT NULL DEFAULT '',
  `PORJ` char(1) NOT NULL DEFAULT '',
  `COMPLETED` decimal(1,0) NOT NULL DEFAULT '0',
  `CONTRSUM` decimal(19,2) NOT NULL DEFAULT '0.00',
  `DETAIL1` varchar(80) NOT NULL DEFAULT '',
  `DETAIL2` varchar(80) NOT NULL DEFAULT '',
  `DETAIL3` varchar(80) NOT NULL DEFAULT '',
  `creditsales` varchar(45) DEFAULT NULL,
  `cashsales` varchar(45) DEFAULT NULL,
  `salesreturn` varchar(45) DEFAULT NULL,
  `purchase` varchar(45) DEFAULT NULL,
  `purchasereturn` varchar(45) DEFAULT NULL,
  `completedproject` varchar(45) DEFAULT 'N',
  PRIMARY KEY (`SOURCE`),
  KEY `PROJECTINFO` (`SOURCE`,`PROJECT`,`PORJ`,`COMPLETED`,`CONTRSUM`,`DETAIL1`,`DETAIL2`,`DETAIL3`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project`
--

LOCK TABLES `project` WRITE;
/*!40000 ALTER TABLE `project` DISABLE KEYS */;
/*!40000 ALTER TABLE `project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_temp`
--

DROP TABLE IF EXISTS `project_temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_temp` (
  `source` varchar(150) NOT NULL DEFAULT '',
  PRIMARY KEY (`source`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_temp`
--

LOCK TABLES `project_temp` WRITE;
/*!40000 ALTER TABLE `project_temp` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_temp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promoitem`
--

DROP TABLE IF EXISTS `promoitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `promoitem` (
  `promoitemid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `promoid` varchar(45) DEFAULT NULL,
  `itemno` varchar(100) DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `desp` varchar(450) DEFAULT NULL,
  `itemprice` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`promoitemid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promoitem`
--

LOCK TABLES `promoitem` WRITE;
/*!40000 ALTER TABLE `promoitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `promoitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promotion`
--

DROP TABLE IF EXISTS `promotion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `promotion` (
  `promoID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(45) DEFAULT NULL,
  `periodfrom` datetime DEFAULT NULL,
  `periodto` datetime DEFAULT NULL,
  `priceamt` varchar(45) DEFAULT NULL,
  `rangeFrom` varchar(45) DEFAULT NULL,
  `rangeto` varchar(45) DEFAULT NULL,
  `discby` varchar(45) DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` varchar(45) DEFAULT NULL,
  `updated_on` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `pricedistype` varchar(45) DEFAULT NULL,
  `buydistype` varchar(45) DEFAULT NULL,
  `customer` varchar(45) NOT NULL DEFAULT '',
  `description` varchar(100) DEFAULT '',
  PRIMARY KEY (`promoID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promotion`
--

LOCK TABLES `promotion` WRITE;
/*!40000 ALTER TABLE `promotion` DISABLE KEYS */;
/*!40000 ALTER TABLE `promotion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `r_icbil_m`
--

DROP TABLE IF EXISTS `r_icbil_m`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `r_icbil_m` (
  `B_NAME` varchar(40) NOT NULL DEFAULT '',
  `B_NAME2` varchar(40) NOT NULL DEFAULT '',
  `B_ADD1` varchar(40) NOT NULL DEFAULT '',
  `B_ADD2` varchar(40) NOT NULL DEFAULT '',
  `B_ADD3` varchar(40) NOT NULL DEFAULT '',
  `B_ADD4` varchar(40) NOT NULL DEFAULT '',
  `B_ATTN` varchar(35) NOT NULL DEFAULT '',
  `B_TEL` varchar(25) NOT NULL DEFAULT '',
  `B_FAX` varchar(25) NOT NULL DEFAULT '',
  `B_HP` varchar(25) NOT NULL DEFAULT '',
  `D_NAME` varchar(40) NOT NULL DEFAULT '',
  `D_NAME2` varchar(40) NOT NULL DEFAULT '',
  `D_ADD1` varchar(40) NOT NULL DEFAULT '',
  `D_ADD2` varchar(40) NOT NULL DEFAULT '',
  `D_ADD3` varchar(40) NOT NULL DEFAULT '',
  `D_ADD4` varchar(40) NOT NULL DEFAULT '',
  `D_ATTN` varchar(35) NOT NULL DEFAULT '',
  `D_TEL` varchar(25) NOT NULL DEFAULT '',
  `D_FAX` varchar(25) NOT NULL DEFAULT '',
  `CUSTNO` varchar(8) NOT NULL DEFAULT '',
  `PREFIX` varchar(5) NOT NULL DEFAULT '',
  `REFNO` varchar(50) NOT NULL DEFAULT '',
  `REFNO2` varchar(24) DEFAULT NULL,
  `PONO` varchar(35) NOT NULL DEFAULT '',
  `DONO` varchar(700) DEFAULT '',
  `DATE` date NOT NULL DEFAULT '0000-00-00',
  `TERMS` varchar(12) NOT NULL DEFAULT '',
  `TERMDESP` varchar(80) NOT NULL DEFAULT '',
  `AGENT` varchar(20) NOT NULL DEFAULT '',
  `AGENTDESP` varchar(40) NOT NULL DEFAULT '',
  `AGENTHP` varchar(12) NOT NULL DEFAULT '',
  `PROJECT` varchar(45) NOT NULL DEFAULT '',
  `JOB` varchar(45) NOT NULL DEFAULT '',
  `REM0` varchar(35) NOT NULL DEFAULT '',
  `REM1` varchar(35) NOT NULL DEFAULT '',
  `REM2` varchar(35) NOT NULL DEFAULT '',
  `REM3` varchar(35) NOT NULL DEFAULT '',
  `REM4` varchar(35) NOT NULL DEFAULT '',
  `REM5` varchar(80) NOT NULL DEFAULT '',
  `REM6` varchar(80) NOT NULL DEFAULT '',
  `REM7` varchar(80) NOT NULL DEFAULT '',
  `REM8` varchar(80) NOT NULL DEFAULT '',
  `REM9` varchar(80) NOT NULL DEFAULT '',
  `REM10` varchar(35) NOT NULL DEFAULT '',
  `REM11` varchar(35) NOT NULL DEFAULT '',
  `REM12` varchar(35) NOT NULL DEFAULT '',
  `TOTAL` double(17,7) NOT NULL DEFAULT '0.0000000',
  `DISP1` double(10,5) NOT NULL DEFAULT '0.00000',
  `DISP2` double(10,5) NOT NULL DEFAULT '0.00000',
  `DISP3` double(10,5) NOT NULL DEFAULT '0.00000',
  `DISAMT_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `NET_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `TAXP1` double(15,5) NOT NULL DEFAULT '0.00000',
  `TAXAMT_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `CURRCODE` varchar(10) NOT NULL DEFAULT '',
  `CURRRATE` double(16,10) NOT NULL DEFAULT '0.0000000000',
  `GROSS_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `Deposit` double(15,5) NOT NULL DEFAULT '0.00000',
  `HComment` varchar(255) NOT NULL DEFAULT '',
  `UserName` varchar(50) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `r_icbil_m`
--

LOCK TABLES `r_icbil_m` WRITE;
/*!40000 ALTER TABLE `r_icbil_m` DISABLE KEYS */;
INSERT INTO `r_icbil_m` VALUES ('Mr Lim','','Abc Road','','','','','','','','Mr Lim','','','','','','','','','3000/A02','','QUO00001',NULL,'PO/SO..','DO..','2012-01-19','','','','','','','','','','','S$','','hr5..','HR6..','HR7..','HR8..','HR9..','HR10..','4000/GI1','1070',1070.0000000,0.00000,0.00000,0.00000,0.00000,1000.00000,0.00000,70.00000,'SGD',1.0000000000,1000.00000,0.00000,'','');
/*!40000 ALTER TABLE `r_icbil_m` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `r_icbil_s`
--

DROP TABLE IF EXISTS `r_icbil_s`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `r_icbil_s` (
  `SREFNO` varchar(50) NOT NULL DEFAULT '',
  `NO` decimal(3,0) NOT NULL DEFAULT '0',
  `ITEMNO` varchar(60) NOT NULL DEFAULT '',
  `DESP` varchar(450) DEFAULT '',
  `DESPA` varchar(450) DEFAULT '',
  `SN_NO` varchar(255) NOT NULL DEFAULT '',
  `COMMENT` blob,
  `UNIT` varchar(12) NOT NULL DEFAULT '',
  `QTY` double(17,7) NOT NULL DEFAULT '0.0000000',
  `PRICE` double(17,7) NOT NULL DEFAULT '0.0000000',
  `AMT` double(17,7) NOT NULL DEFAULT '0.0000000',
  `DISPEC1` double(17,7) NOT NULL DEFAULT '0.0000000',
  `DISPEC2` double(17,7) NOT NULL DEFAULT '0.0000000',
  `DISPEC3` double(17,7) NOT NULL DEFAULT '0.0000000',
  `SGD_PRICE` double(17,7) NOT NULL DEFAULT '0.0000000',
  `SGD_AMT` double(17,7) NOT NULL DEFAULT '0.0000000',
  `BREM1` varchar(45) NOT NULL DEFAULT '',
  `BREM2` varchar(45) NOT NULL DEFAULT '',
  `BREM3` varchar(45) NOT NULL DEFAULT '',
  `BREM4` varchar(45) NOT NULL DEFAULT '',
  `QTY1` double(17,5) NOT NULL DEFAULT '0.00000',
  `QTY2` double(17,5) NOT NULL DEFAULT '0.00000',
  `QTY3` double(17,5) NOT NULL DEFAULT '0.00000',
  `QTY4` double(17,5) NOT NULL DEFAULT '0.00000',
  `QTY5` double(17,5) NOT NULL DEFAULT '0.00000',
  `QTY6` double(17,5) NOT NULL DEFAULT '0.00000',
  `QTY7` double(17,5) NOT NULL DEFAULT '0.00000',
  `COUNTER_1` varchar(45) NOT NULL DEFAULT '',
  `COUNTER_2` varchar(45) NOT NULL DEFAULT '',
  `COUNTER_3` varchar(45) NOT NULL DEFAULT '',
  `COUNTER_4` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`NO`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `r_icbil_s`
--

LOCK TABLES `r_icbil_s` WRITE;
/*!40000 ALTER TABLE `r_icbil_s` DISABLE KEYS */;
INSERT INTO `r_icbil_s` VALUES ('QUO00001','1','Great Eastern','Great Eastern Motor Insurance','','',NULL,'',1.0000000,1000.0000000,1000.0000000,0.0000000,70.0000000,0.0000000,0.0000000,0.0000000,'','','','',0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,'1','','',''),('QUO00001','2','','Comprehensive','','',NULL,'',0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,'','','','',0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,'','','',''),('QUO00001','3','','blah blah blah...','','',NULL,'',0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,'','1','','',0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,0.00000,'','','','');
/*!40000 ALTER TABLE `r_icbil_s` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `receivetemp`
--

DROP TABLE IF EXISTS `receivetemp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `receivetemp` (
  `TYPE` varchar(4) NOT NULL DEFAULT '',
  `REFNO` varchar(40) NOT NULL,
  `REFNO2` varchar(24) DEFAULT NULL,
  `TRANCODE` int(4) NOT NULL DEFAULT '0',
  `CUSTNO` varchar(12) NOT NULL DEFAULT '',
  `FPERIOD` varchar(2) DEFAULT '0',
  `WOS_DATE` date NOT NULL DEFAULT '0000-00-00',
  `CURRRATE` double(16,10) NOT NULL DEFAULT '0.0000000000',
  `ITEMCOUNT` int(4) NOT NULL DEFAULT '0',
  `LINECODE` varchar(2) DEFAULT NULL,
  `ITEMNO` varchar(28) NOT NULL DEFAULT '',
  `DESP` varchar(450) DEFAULT '',
  `DESPA` varchar(450) DEFAULT '',
  `AGENNO` varchar(20) NOT NULL DEFAULT '',
  `LOCATION` varchar(24) DEFAULT NULL,
  `SOURCE` varchar(40) DEFAULT '',
  `JOB` varchar(40) DEFAULT '',
  `SIGN` varchar(2) DEFAULT NULL,
  `QTY_BIL` double(17,5) NOT NULL DEFAULT '0.00000',
  `PRICE_BIL` double(17,5) NOT NULL DEFAULT '0.00000',
  `UNIT_BIL` varchar(12) NOT NULL DEFAULT '',
  `AMT1_BIL` double(17,5) NOT NULL DEFAULT '0.00000',
  `DISPEC1` varchar(10) DEFAULT NULL,
  `DISPEC2` varchar(10) DEFAULT NULL,
  `DISPEC3` varchar(10) DEFAULT NULL,
  `DISAMT_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `AMT_BIL` double(17,5) NOT NULL DEFAULT '0.00000',
  `TAXPEC1` varchar(5) DEFAULT NULL,
  `TAXPEC2` varchar(5) DEFAULT NULL,
  `TAXPEC3` varchar(5) DEFAULT NULL,
  `TAXAMT_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `NOTE_A` varchar(8) DEFAULT NULL,
  `IMPSTAGE` char(1) DEFAULT NULL,
  `QTY` double(17,5) NOT NULL DEFAULT '0.00000',
  `PRICE` double(17,5) NOT NULL DEFAULT '0.00000',
  `UNIT` varchar(12) DEFAULT NULL,
  `AMT1` double(17,5) NOT NULL DEFAULT '0.00000',
  `DISAMT` double(15,5) NOT NULL DEFAULT '0.00000',
  `AMT` double(17,5) NOT NULL DEFAULT '0.00000',
  `TAXAMT` double(15,5) NOT NULL DEFAULT '0.00000',
  `FACTOR1` varchar(9) DEFAULT NULL,
  `FACTOR2` varchar(9) DEFAULT NULL,
  `DONO` varchar(40) DEFAULT NULL,
  `DODATE` date NOT NULL DEFAULT '0000-00-00',
  `SODATE` date NOT NULL DEFAULT '0000-00-00',
  `BREM1` varchar(40) DEFAULT NULL,
  `BREM2` varchar(40) DEFAULT NULL,
  `BREM3` varchar(40) DEFAULT NULL,
  `BREM4` varchar(40) DEFAULT NULL,
  `PACKING` varchar(13) DEFAULT NULL,
  `NOTE1` varchar(10) DEFAULT NULL,
  `NOTE2` varchar(10) DEFAULT NULL,
  `GLTRADAC` varchar(8) DEFAULT NULL,
  `UPDCOST` char(1) DEFAULT NULL,
  `GST_ITEM` char(1) DEFAULT NULL,
  `TOTALUP` char(1) DEFAULT NULL,
  `WITHSN` char(1) DEFAULT NULL,
  `NODISPLAY` char(1) NOT NULL DEFAULT '',
  `GRADE` varchar(10) DEFAULT NULL,
  `PUR_PRICE` double(17,5) NOT NULL DEFAULT '0.00000',
  `QTY1` double(17,5) NOT NULL DEFAULT '0.00000',
  `QTY2` double(17,5) NOT NULL DEFAULT '0.00000',
  `QTY3` double(17,5) NOT NULL DEFAULT '0.00000',
  `QTY4` double(17,5) NOT NULL DEFAULT '0.00000',
  `QTY5` double(17,5) NOT NULL DEFAULT '0.00000',
  `QTY6` double(17,5) NOT NULL DEFAULT '0.00000',
  `QTY7` double(17,5) NOT NULL DEFAULT '0.00000',
  `QTY_RET` double(17,5) NOT NULL DEFAULT '0.00000',
  `TEMPFIGI` double(15,5) NOT NULL DEFAULT '0.00000',
  `SERCOST` double(13,5) NOT NULL DEFAULT '0.00000',
  `M_CHARGE1` double(15,5) NOT NULL DEFAULT '0.00000',
  `M_CHARGE2` double(15,5) NOT NULL DEFAULT '0.00000',
  `ADTCOST1` double(15,5) NOT NULL DEFAULT '0.00000',
  `ADTCOST2` double(15,5) NOT NULL DEFAULT '0.00000',
  `IT_COS` double(17,5) NOT NULL DEFAULT '0.00000',
  `AV_COST` double(17,5) NOT NULL DEFAULT '0.00000',
  `BATCHCODE` varchar(15) DEFAULT NULL,
  `EXPDATE` date NOT NULL DEFAULT '0000-00-00',
  `POINT` double(12,4) NOT NULL DEFAULT '0.0000',
  `INV_DISC` double(17,5) NOT NULL DEFAULT '0.00000',
  `INV_TAX` double(17,5) NOT NULL DEFAULT '0.00000',
  `SUPP` varchar(12) DEFAULT NULL,
  `EDI_COU1` varchar(12) DEFAULT NULL,
  `WRITEOFF` double(17,5) NOT NULL DEFAULT '0.00000',
  `TOSHIP` double(17,5) NOT NULL DEFAULT '0.00000',
  `SHIPPED` double(17,5) NOT NULL DEFAULT '0.00000',
  `NAME` varchar(40) DEFAULT NULL,
  `DEL_BY` varchar(12) DEFAULT NULL,
  `VAN` varchar(8) DEFAULT NULL,
  `GENERATED` char(1) DEFAULT NULL,
  `UD_QTY` char(1) DEFAULT NULL,
  `TOINV` varchar(24) DEFAULT NULL,
  `EXPORTED` varchar(24) DEFAULT NULL,
  `EXPORTED1` date NOT NULL DEFAULT '0000-00-00',
  `EXPORTED2` varchar(24) DEFAULT NULL,
  `EXPORTED3` date NOT NULL DEFAULT '0000-00-00',
  `BRK_TO` char(1) DEFAULT NULL,
  `SV_PART` varchar(24) DEFAULT NULL,
  `LAST_YEAR` char(1) DEFAULT NULL,
  `VOID` char(1) DEFAULT NULL,
  `SONO` varchar(40) DEFAULT NULL,
  `MC1_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `MC2_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `USERID` varchar(50) DEFAULT NULL,
  `DAMT` double(15,5) NOT NULL DEFAULT '0.00000',
  `OLDBILL` char(1) DEFAULT NULL,
  `WOS_GROUP` varchar(25) NOT NULL DEFAULT '',
  `CATEGORY` varchar(80) DEFAULT NULL,
  `AREA` varchar(12) DEFAULT NULL,
  `SHELF` varchar(8) DEFAULT NULL,
  `TEMP` varchar(24) DEFAULT NULL,
  `TEMP1` double(17,5) NOT NULL DEFAULT '0.00000',
  `BODY` char(1) DEFAULT NULL,
  `TOTALGROUP` varchar(3) DEFAULT NULL,
  `MARK` char(1) DEFAULT NULL,
  `TYPE_SEQ` varchar(2) DEFAULT NULL,
  `PROMOTER` varchar(8) DEFAULT NULL,
  `TABLENO` varchar(4) DEFAULT NULL,
  `MEMBER` varchar(20) DEFAULT NULL,
  `TOURGROUP` varchar(3) DEFAULT NULL,
  `TRDATETIME` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `TIME` varchar(8) DEFAULT NULL,
  `BOMNO` char(1) DEFAULT NULL,
  `COMMENT` blob,
  `DEFECTIVE` char(1) DEFAULT NULL,
  `M_CHARGE3` double(15,5) NOT NULL DEFAULT '0.00000',
  `M_CHARGE4` double(15,5) NOT NULL DEFAULT '0.00000',
  `M_CHARGE5` double(15,5) NOT NULL DEFAULT '0.00000',
  `M_CHARGE6` double(15,5) NOT NULL DEFAULT '0.00000',
  `M_CHARGE7` double(15,5) NOT NULL DEFAULT '0.00000',
  `MC3_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `MC4_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `MC5_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `MC6_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `MC7_BIL` double(15,5) NOT NULL DEFAULT '0.00000',
  `taxincl` varchar(45) DEFAULT NULL,
  `LOC_CURRRATE` double(16,10) NOT NULL DEFAULT '1.0000000000',
  `LOC_CURRCODE` varchar(15) NOT NULL DEFAULT '',
  `TITLE_ID` varchar(45) NOT NULL DEFAULT '',
  `TITLE_DESP` varchar(100) NOT NULL DEFAULT '',
  `brem5` varchar(450) DEFAULT NULL,
  `brem6` varchar(450) DEFAULT NULL,
  `uuid` varchar(50) NOT NULL DEFAULT '',
  `driver` varchar(200) DEFAULT '',
  `rem9` varchar(1000) DEFAULT '',
  `onhold` varchar(45) DEFAULT '',
  `promotion` varchar(45) DEFAULT '',
  PRIMARY KEY (`TYPE`,`REFNO`,`CUSTNO`,`TRANCODE`,`ITEMCOUNT`,`ITEMNO`,`WOS_DATE`,`uuid`) USING BTREE,
  KEY `COSTING` (`ITEMNO`,`TYPE`,`REFNO`,`TRANCODE`,`QTY`,`AMT`,`IT_COS`,`TOINV`,`VOID`),
  KEY `ASSMITEM` (`ITEMNO`,`TYPE`,`REFNO`,`FPERIOD`,`WOS_DATE`,`LOCATION`,`SOURCE`,`QTY`,`AMT`,`IT_COS`,`VOID`,`WOS_GROUP`,`CATEGORY`,`AREA`,`SHELF`,`BOMNO`),
  KEY `BATCHITEM` (`ITEMNO`,`TYPE`,`REFNO`,`CUSTNO`,`FPERIOD`,`WOS_DATE`,`AGENNO`,`LOCATION`,`QTY`,`AMT`,`BATCHCODE`,`EXPDATE`,`TOINV`,`WOS_GROUP`,`CATEGORY`,`AREA`),
  KEY `ITEMREPORT` (`ITEMNO`,`TYPE`,`FPERIOD`,`WOS_DATE`,`AGENNO`,`LOCATION`,`SOURCE`,`QTY`,`AMT`,`IT_COS`,`WOS_GROUP`,`CATEGORY`,`AREA`,`SHELF`,`SHIPPED`,`TOINV`),
  KEY `CUSTREPORT` (`CUSTNO`,`TYPE`,`ITEMNO`,`FPERIOD`,`WOS_DATE`,`AGENNO`,`LOCATION`,`SOURCE`,`QTY`,`AMT`,`IT_COS`,`SHIPPED`,`TOINV`,`WOS_GROUP`,`CATEGORY`,`AREA`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `receivetemp`
--

LOCK TABLES `receivetemp` WRITE;
/*!40000 ALTER TABLE `receivetemp` DISABLE KEYS */;
/*!40000 ALTER TABLE `receivetemp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recurrgroup`
--

DROP TABLE IF EXISTS `recurrgroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recurrgroup` (
  `groupID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `desp` varchar(450) DEFAULT '',
  `recurrtype` varchar(45) DEFAULT '',
  `lastdate` date DEFAULT NULL,
  `nextdate` date DEFAULT NULL,
  `lastgeneratedby` varchar(45) DEFAULT '',
  `lastgeneratedon` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(45) DEFAULT '',
  `created_on` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by` varchar(45) DEFAULT '',
  `updated_on` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`groupID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recurrgroup`
--

LOCK TABLES `recurrgroup` WRITE;
/*!40000 ALTER TABLE `recurrgroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `recurrgroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `refnoset`
--

DROP TABLE IF EXISTS `refnoset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `refnoset` (
  `type` varchar(4) NOT NULL DEFAULT '',
  `refnocode` varchar(50) DEFAULT NULL,
  `refnocode2` varchar(50) DEFAULT NULL,
  `lastUsedNo` varchar(50) DEFAULT NULL,
  `refnoused` char(1) DEFAULT NULL,
  `presuffixuse` char(1) NOT NULL DEFAULT '',
  `counter` int(2) NOT NULL DEFAULT '0',
  `refnotitle` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`type`,`counter`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `refnoset`
--

LOCK TABLES `refnoset` WRITE;
/*!40000 ALTER TABLE `refnoset` DISABLE KEYS */;
INSERT INTO `refnoset` VALUES ('ASSM','','','ASSM00000','1','',1,NULL),('CN','','','CN00000','1','',1,NULL),('CS','','','CS00000','1','',1,NULL),('DN','','','DN00001','1','',1,NULL),('DO','','','DO00000','1','',1,NULL),('INV','','','INV00001','1','',1,NULL),('INV','','','00000000','0','',2,NULL),('INV','','','00000000','0','',3,NULL),('INV','','','00000000','0','',4,NULL),('INV','','','00000000','0','',5,NULL),('INV','','','00000000','0','',6,NULL),('ISS','','','ISS00000','1','',1,NULL),('OAI','','','AJI00000','1','',1,NULL),('OAR','','','AJR00000','1','',1,NULL),('PO','','','PO00000','1','',1,NULL),('PR','','','PRN00000','1','',1,NULL),('QUO','','','QUO00001','1','',1,NULL),('RC','','','PR00000','1','',1,NULL),('SAM','','','SAM00000','1','',1,NULL),('SO','','','SO00000','1','',1,NULL),('TR','','','TR00000','1','',1,NULL),('CUST',NULL,NULL,'A02','0','',1,NULL),('SUPP',NULL,NULL,'GI1','0','',1,NULL),('PACK','','','PK00000','0','',1,NULL),('RQ','','','RQ00000','1','',1,NULL);
/*!40000 ALTER TABLE `refnoset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `relitem`
--

DROP TABLE IF EXISTS `relitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `relitem` (
  `ITEMNO` varchar(60) NOT NULL DEFAULT '',
  `RELITEMNO` varchar(60) NOT NULL DEFAULT '',
  `CREATED_BY` varchar(50) NOT NULL DEFAULT '',
  `CREATED_ON` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UPDATED_BY` varchar(50) NOT NULL DEFAULT '',
  `UPDATED_ON` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`ITEMNO`,`RELITEMNO`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relitem`
--

LOCK TABLES `relitem` WRITE;
/*!40000 ALTER TABLE `relitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `relitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salesmonthreport`
--

DROP TABLE IF EXISTS `salesmonthreport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salesmonthreport` (
  `uuid` varchar(100) DEFAULT '',
  `reportime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `subject` varchar(450) DEFAULT '',
  `desp` varchar(100) DEFAULT '',
  `desp2` varchar(100) DEFAULT '',
  `p01` double(15,5) DEFAULT '0.00000',
  `p02` double(15,5) DEFAULT '0.00000',
  `p03` double(15,5) DEFAULT '0.00000',
  `p04` double(15,5) DEFAULT '0.00000',
  `p05` double(15,5) DEFAULT '0.00000',
  `p06` double(15,5) DEFAULT '0.00000',
  `p07` double(15,5) DEFAULT '0.00000',
  `p08` double(15,5) DEFAULT '0.00000',
  `p09` double(15,5) DEFAULT '0.00000',
  `p10` double(15,5) DEFAULT '0.00000',
  `p11` double(15,5) DEFAULT '0.00000',
  `p12` double(15,5) DEFAULT '0.00000',
  `p13` double(15,5) DEFAULT '0.00000',
  `p14` double(15,5) DEFAULT '0.00000',
  `p15` double(15,5) DEFAULT '0.00000',
  `p16` double(15,5) DEFAULT '0.00000',
  `p17` double(15,5) DEFAULT '0.00000',
  `p18` double(15,5) DEFAULT '0.00000',
  `totalrow` double(15,5) DEFAULT '0.00000'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salesmonthreport`
--

LOCK TABLES `salesmonthreport` WRITE;
/*!40000 ALTER TABLE `salesmonthreport` DISABLE KEYS */;
/*!40000 ALTER TABLE `salesmonthreport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipvia`
--

DROP TABLE IF EXISTS `shipvia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shipvia` (
  `SHIPVIA` varchar(35) NOT NULL DEFAULT '',
  `DESP` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`SHIPVIA`),
  KEY `SHIPINFO` (`SHIPVIA`,`DESP`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipvia`
--

LOCK TABLES `shipvia` WRITE;
/*!40000 ALTER TABLE `shipvia` DISABLE KEYS */;
/*!40000 ALTER TABLE `shipvia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `special_setting_location`
--

DROP TABLE IF EXISTS `special_setting_location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `special_setting_location` (
  `entryno` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `trans_type` varchar(4) NOT NULL DEFAULT '',
  `default_location` varchar(24) NOT NULL DEFAULT '',
  PRIMARY KEY (`entryno`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `special_setting_location`
--

LOCK TABLES `special_setting_location` WRITE;
/*!40000 ALTER TABLE `special_setting_location` DISABLE KEYS */;
/*!40000 ALTER TABLE `special_setting_location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `symbol`
--

DROP TABLE IF EXISTS `symbol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `symbol` (
  `idSymbol` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `symbol1` varchar(45) NOT NULL,
  `symbol2` varchar(45) NOT NULL,
  `symbol3` varchar(45) NOT NULL,
  `symbol4` varchar(45) NOT NULL,
  `symbol5` varchar(45) NOT NULL,
  `symbol6` varchar(45) NOT NULL,
  `symbol7` varchar(45) NOT NULL,
  `symbol8` varchar(45) NOT NULL,
  `symbol9` varchar(45) NOT NULL,
  `symbol10` varchar(45) NOT NULL,
  `symbol11` varchar(45) NOT NULL,
  `symbol12` varchar(45) NOT NULL,
  `symbol13` varchar(45) NOT NULL,
  `symbol14` varchar(45) NOT NULL,
  `symbol15` varchar(45) NOT NULL,
  `symbol16` varchar(45) NOT NULL,
  `symbol17` varchar(45) NOT NULL,
  `symbol18` varchar(45) NOT NULL,
  `symbol19` varchar(45) NOT NULL,
  `symbol20` varchar(45) NOT NULL,
  PRIMARY KEY (`idSymbol`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `symbol`
--

LOCK TABLES `symbol` WRITE;
/*!40000 ALTER TABLE `symbol` DISABLE KEYS */;
/*!40000 ALTER TABLE `symbol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taxtable`
--

DROP TABLE IF EXISTS `taxtable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taxtable` (
  `entryno` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(30) NOT NULL DEFAULT '',
  `desp` varchar(100) DEFAULT NULL,
  `rate1` decimal(5,4) NOT NULL DEFAULT '0.0000',
  `rate2` decimal(5,4) NOT NULL DEFAULT '0.0000',
  `corr_accno` varchar(12) DEFAULT NULL,
  `tax_type` varchar(2) NOT NULL DEFAULT 'F',
  `tax_type2` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`entryno`,`code`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taxtable`
--

LOCK TABLES `taxtable` WRITE;
/*!40000 ALTER TABLE `taxtable` DISABLE KEYS */;
/*!40000 ALTER TABLE `taxtable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `temptrx`
--

DROP TABLE IF EXISTS `temptrx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temptrx` (
  `TRXBILLNO` varchar(50) NOT NULL DEFAULT '',
  `ACCNO` varchar(10) NOT NULL DEFAULT '',
  `ITEMNO` varchar(60) NOT NULL DEFAULT '',
  `TRXBTYPE` varchar(10) NOT NULL DEFAULT '',
  `TRXDATE` date NOT NULL DEFAULT '0000-00-00',
  `PERIOD` int(2) NOT NULL DEFAULT '0',
  `CURRRATE` double(15,10) NOT NULL DEFAULT '0.0000000000',
  `CUSTNO` varchar(8) NOT NULL DEFAULT '',
  `AMOUNT` double(15,5) NOT NULL DEFAULT '0.00000',
  `AMOUNT2` double(15,5) NOT NULL DEFAULT '0.00000',
  `GST` double(15,5) NOT NULL DEFAULT '0.00000',
  `GSTAMT` double(15,5) NOT NULL DEFAULT '0.00000',
  `GSTAMT2` double(15,5) NOT NULL DEFAULT '0.00000',
  `GSTTYPE` varchar(35) NOT NULL DEFAULT '',
  `SOURCE` varchar(50) NOT NULL DEFAULT '',
  `JOB` varchar(15) NOT NULL DEFAULT '',
  `JOB2` varchar(15) NOT NULL DEFAULT '',
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `temppostinfo` (`TRXBILLNO`,`ACCNO`,`ITEMNO`,`TRXBTYPE`,`TRXDATE`,`PERIOD`,`CURRRATE`,`CUSTNO`,`AMOUNT`,`AMOUNT2`,`GST`,`GSTAMT`,`GSTAMT2`,`GSTTYPE`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `temptrx`
--

LOCK TABLES `temptrx` WRITE;
/*!40000 ALTER TABLE `temptrx` DISABLE KEYS */;
/*!40000 ALTER TABLE `temptrx` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `title`
--

DROP TABLE IF EXISTS `title`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `title` (
  `TITLE_ID` varchar(45) NOT NULL DEFAULT '',
  `DESP` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`TITLE_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `title`
--

LOCK TABLES `title` WRITE;
/*!40000 ALTER TABLE `title` DISABLE KEYS */;
/*!40000 ALTER TABLE `title` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_menu`
--

DROP TABLE IF EXISTS `transaction_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transaction_menu` (
  `COMPANY_ID` varchar(50) NOT NULL DEFAULT '',
  `INCREASE_PERIOD_BY_ONE_ON_AFTER_DAY` int(2) DEFAULT '0',
  `USE_ONLY_1_SET_INVOICE_NO` char(1) DEFAULT NULL,
  `USE_ONLY_1_SET_DO_NO` char(1) DEFAULT NULL,
  `ALLOWED_EDIT_EXPORTED_BILL` char(1) DEFAULT NULL,
  `STANDARD_AUTO_RUNNING` char(1) DEFAULT NULL,
  `PROJECT_BY_BILL` char(1) DEFAULT NULL,
  `WITH_BILL_AGENT` char(1) DEFAULT NULL,
  `WITH_SITE` char(1) DEFAULT NULL,
  `SEARCH_TRANSACTION_DATE` char(1) DEFAULT NULL,
  `ALLOW_EDIT_NAME` char(1) DEFAULT NULL,
  `SO_HAS_TO_BE_VERIFY` char(1) DEFAULT NULL,
  `WITH_PER_ITEM_TAX` char(1) DEFAULT NULL,
  `WITH_PER_ITEM_TAX_FORMULA` varchar(50) DEFAULT NULL,
  `WITH_PER_ITEM_DISCOUNT` char(1) DEFAULT NULL,
  `3_LEVEL_DISCOUNT` char(1) DEFAULT NULL,
  `WITH_PRICE_IN_DO` char(1) DEFAULT NULL,
  `DEFAULT_SERVICE` char(1) DEFAULT NULL,
  `DEFAULT_CHANGE_UNIT` char(1) DEFAULT NULL,
  `ROUND_OFF_ON_ITEM_DISCOUNT` char(1) DEFAULT NULL,
  `ROUND_DOWN_ON_ITEM_AMOUNT` char(1) DEFAULT NULL,
  `UPDATE_LATEST_PRICES` char(1) DEFAULT NULL,
  `UPDATE_LATEST_PRICES_FORMULA` varchar(50) DEFAULT NULL,
  `COMPULSORY_LOCATION` char(1) DEFAULT NULL,
  `ALLOW_EDIT_AMOUNT` char(1) DEFAULT NULL,
  `BATCH_CODE_OTHER_CHARGES` char(1) DEFAULT NULL,
  `ALLOW_CHANGE_IN_2ND_UNIT_FACTOR` char(1) DEFAULT NULL,
  `ALLOW_CREATE_CODE_DURING_TRANSACTION` char(1) DEFAULT NULL,
  `DISPLAY_COST_CODE_DURING_TRANSACTION` char(1) DEFAULT NULL,
  `TRANSFER_NOTE_BASED_ON_SELLING_PRICE` char(1) DEFAULT NULL,
  `COMPULSORY_SERIAL_NO` char(1) DEFAULT NULL,
  `ALLOW_QTY_RC_EXCEED_QTY_OUTSTAND_PO` char(1) DEFAULT NULL,
  `CATEGORY_OF_DISCOUNT` int(2) DEFAULT '0',
  `COMPULSORY_FOOTER` char(1) DEFAULT NULL,
  `EXCHANGE_RATE_ON_INVOICE_TOTAL` char(1) DEFAULT NULL,
  `DIS2_DISCOUNT_ON_INVOICE_NET_DISCOUNT` char(1) DEFAULT NULL,
  `TAX2_TAX_ON_INVOICE_NET_TAX` char(1) DEFAULT NULL,
  `CONDITION_FOR_UPDATING_STOCK_BALANCE_FORMULA` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`COMPANY_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_menu`
--

LOCK TABLES `transaction_menu` WRITE;
/*!40000 ALTER TABLE `transaction_menu` DISABLE KEYS */;
INSERT INTO `transaction_menu` VALUES ('IMS',0,'Y','Y','','Y','','','','','Y','','','','','','','','','Y','','','RC DN DO INV','','','','Y','Y','','','','Y',0,'','','','','TYPE =\'INV\' AND (GENERATED =\'Y\' OR UD_QTY =\'N\')');
/*!40000 ALTER TABLE `transaction_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unit`
--

DROP TABLE IF EXISTS `unit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unit` (
  `UNIT` varchar(25) NOT NULL DEFAULT '',
  `DESP` varchar(60) NOT NULL DEFAULT '',
  PRIMARY KEY (`UNIT`),
  KEY `UNITINFO` (`UNIT`,`DESP`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unit`
--

LOCK TABLES `unit` WRITE;
/*!40000 ALTER TABLE `unit` DISABLE KEYS */;
/*!40000 ALTER TABLE `unit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unlocktran`
--

DROP TABLE IF EXISTS `unlocktran`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unlocktran` (
  `type` varchar(50) NOT NULL,
  `refno` varchar(50) NOT NULL,
  `unlockby` varchar(50) NOT NULL,
  `unlockon` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`type`,`refno`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unlocktran`
--

LOCK TABLES `unlocktran` WRITE;
/*!40000 ALTER TABLE `unlocktran` DISABLE KEYS */;
/*!40000 ALTER TABLE `unlocktran` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userpin`
--

DROP TABLE IF EXISTS `userpin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpin` (
  `CODE` varchar(4) NOT NULL DEFAULT '',
  `DESP` varchar(50) NOT NULL DEFAULT '',
  `SUPER` char(1) NOT NULL DEFAULT '',
  `ADMIN` char(1) NOT NULL DEFAULT '',
  `STANDARD` char(1) NOT NULL DEFAULT '',
  `GENERAL` char(1) NOT NULL DEFAULT '',
  `LIMITED` char(1) NOT NULL DEFAULT '',
  `MOBILE` char(1) NOT NULL DEFAULT '',
  PRIMARY KEY (`CODE`),
  KEY `PININFO` (`CODE`,`DESP`,`SUPER`,`ADMIN`,`STANDARD`,`GENERAL`,`LIMITED`,`MOBILE`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userpin`
--

LOCK TABLES `userpin` WRITE;
/*!40000 ALTER TABLE `userpin` DISABLE KEYS */;
INSERT INTO `userpin` VALUES ('1000','Maintenance','T','T','T','T','T',''),('1100','Supplier Profile','T','T','T','T','T',''),('1110','Create New Supplier','T','T','T','F','F',''),('1111','Edit/Delete Supplier','T','T','F','F','F',''),('1120','List All Supplier','T','T','T','F','F',''),('1130','Search Supplier','T','T','T','T','T',''),('1140','Supplier Listing','T','T','T','T','T',''),('1200','Customer Profile','T','T','T','T','T',''),('1210','Create New Customer','T','T','T','F','F',''),('1211','Edit/Delete Customer','T','T','F','F','F',''),('1220','List All Customer','T','T','T','F','F',''),('1230','Search Customer','T','T','T','T','T',''),('1240','Customer Listing','T','T','T','T','T',''),('1250','View Own Customer','F','F','F','F','F',''),('1300','Product Profile','T','T','F','T','T',''),('1310','Create New Item','T','T','F','F','F',''),('1311','Edit/Delete Item','T','T','F','F','F',''),('1320','List All Item','T','T','F','T','T',''),('1330','Search For Item','T','T','F','T','T',''),('1340','Item Listing','T','T','F','T','T',''),('1350','Print Barcode','T','T','T','T','T',''),('1360','Item Cost','T','T','T','T','T','T'),('1361','Selling Price','T','F','F','F','F',''),('1370','Supplier/Item Price','T','T','T','T','T',''),('1380','Customer/Item Price','T','T','T','T','T',''),('1390','Item/Supplier Price','T','T','T','T','T',''),('13A0','Item/Customer Price','T','T','T','T','T',''),('13B0','Price in more setting','T','T','T','T','T',''),('13C0','Supplier Code','T','T','T','T','T',''),('13D0','Edit Item Express','T','T','T','T','T',''),('1400','Category Profile','T','T','F','F','F',''),('1410','Create New Category','T','T','F','F','F',''),('1411','Edit/Delete Category','T','T','F','F','F',''),('1420','List All Category','T','T','F','F','F',''),('1430','Search Category','T','T','F','F','F',''),('1500','Group Profile','T','T','F','F','F',''),('1510','Create New Group','T','T','F','F','F',''),('1511','Edit/Delete Group','T','T','F','F','F',''),('1520','List All Group','T','T','F','F','F',''),('1530','Search For Group','T','T','F','F','F',''),('1540','Group Listing','T','T','F','F','F',''),('1600','Size Profile','T','T','F','F','F',''),('1610','Creating a New Size','T','T','F','F','F',''),('1611','Edit/Delete Size','T','T','F','F','F',''),('1620','List All Size','T','T','F','F','F',''),('1630','Search For Size','T','T','F','F','F',''),('1700','Rating Profile','T','T','F','F','F',''),('1710','Create New Rating','T','T','F','F','F',''),('1711','Edit/Delete Rating','T','T','F','F','F',''),('1720','List All Rating','T','T','F','F','F',''),('1730','Search Rating','T','T','F','F','F',''),('1800','Material Profile','T','T','F','F','F',''),('1810','Create New Material','T','T','F','F','F',''),('1811','Edit/Delete Material','T','T','F','F','F',''),('1820','List All Material','T','T','F','F','F',''),('1830','Search Material','T','T','F','F','F',''),('1900','Model Profile','T','T','F','F','F',''),('1910','Create New Model','T','T','F','F','F',''),('1911','Edit/Delete Model','T','T','F','F','F',''),('1920','List All Model','T','T','F','F','F',''),('1930','Search For Model','T','T','F','F','F',''),('1A00','Unit of Measurement','T','T','F','F','F',''),('1A10','Create New Unit of Measurement','T','T','F','F','F',''),('1A11','Edit/Delete Unit of Measurement','T','T','F','F','F',''),('1A20','List All Unit of Measurement','T','T','F','F','F',''),('1A30','Search For Unit of Measurement','T','T','F','F','F',''),('1B00','Agent Profile','T','T','F','F','F',''),('1B10','Create New Agent','T','T','F','F','F',''),('1B11','Edit/Delete Agent','T','T','F','F','F',''),('1B20','List All Agent','T','T','F','F','F',''),('1B30','Search For Agent','T','T','F','F','F',''),('1B40','Automate Agent','F','F','F','F','F',''),('1C00','End User Profile','T','T','F','F','F',''),('1C10','Create New End User','T','T','F','F','F',''),('1C11','Edit/Delete End User','T','T','F','F','F',''),('1C20','List All End User','T','T','F','F','F',''),('1C30','Search For End User','T','T','F','F','F',''),('1C40','End User Listing','T','T','F','F','F',''),('1D00','Location Profile','T','T','F','F','F',''),('1D10','Create New Location','T','T','F','F','F',''),('1D11','Edit/Delete Location','T','T','F','F','F',''),('1D20','List All Location','T','T','F','F','F',''),('1D30','Search For Location','T','T','F','F','F',''),('1E00','Comment Profile','T','T','F','F','F',''),('1E10','Create New Comment','T','T','F','F','F',''),('1E11','Edit/Delete Comment','T','T','F','F','F',''),('1E20','List All Comment','T','T','F','F','F',''),('1E30','Search For Comment','T','T','F','F','F',''),('1F00','Address Profile','T','T','F','F','F',''),('1F10','Create New Address','T','T','F','F','F',''),('1F11','Edit/Delete Address','T','T','F','F','F',''),('1F20','List All Address','T','T','F','F','F',''),('1F30','Search For Address','T','T','F','F','F',''),('1G00','Service Profile','T','T','F','F','F',''),('1G10','Create New Service','T','T','F','F','F',''),('1G11','Edit/Delete Service','T','T','F','F','F',''),('1G20','List All Service','T','T','F','F','F',''),('1G30','Search For Service','T','T','F','F','F',''),('1H00','Project Profile','T','T','F','F','F',''),('1H10','Create New Project','T','T','F','F','F',''),('1H11','Edit/Delete Project','T','T','F','F','F',''),('1H20','List All Project','T','T','F','F','F',''),('1H30','Search For Project','T','T','F','F','F',''),('1I00','Term Profile','T','T','F','F','F',''),('1I10','Create New Term','T','T','F','F','F',''),('1I11','Edit/Delete Term','T','T','F','F','F',''),('1I20','List All Term','T','T','F','F','F',''),('1I30','Search For Term','T','T','F','F','F',''),('1J00','Bill of Material','T','T','F','F','F',''),('1J10','Create Bill of Material','T','T','F','F','F',''),('1J20','List Bill of Material','T','T','F','F','F',''),('1J30','Search Bill of Material','T','T','F','F','F',''),('1J40','Generate Cost','T','T','F','F','F',''),('1J50','Check Material','T','T','F','F','F',''),('1J60','Use In Where','T','T','F','F','F',''),('1K00','Opening Qty Maintenance','T','T','F','F','F',''),('1K10','Edit Item Opening Quantity/Cost','T','T','T','T','T',''),('1K20','Edit Batch Opening Quantity','T','T','T','T','T',''),('1K30','Edit Location Opening Quantity','T','T','T','T','T',''),('1K40','Edit Location - Item Batch Opening Quantity','T','T','T','T','T',''),('1K50','Edit Serial No. Opening Quantity','T','T','T','T','T',''),('1K60','Edit Item - Grade Opening Quantity','T','T','T','T','T',''),('1K70','Enquiry Opening Value','T','T','T','T','T',''),('1L00','Color - Size Maintenance','T','T','T','T','T',''),('1L10','Create New Color - Size','T','T','T','T','T',''),('1L11','Edit/Delete Color - Size','T','T','T','T','T',''),('1L20','List All Color - Size','T','T','T','T','T',''),('1L30','Search For Color - Size','T','T','T','T','T',''),('1M00','Matrix Item Maintenance','T','T','T','T','T',''),('1M10','Create New Matrix Item','T','T','T','T','T',''),('1M11','Edit/Delete Matrix Item','T','T','T','T','T',''),('1M20','List All Matrix Item','T','T','T','T','T',''),('1M30','Search For Matrix Item','T','T','T','T','T',''),('1N00','Title Maintenance','T','T','T','T','T',''),('1N10','Create New Title','T','T','T','T','T',''),('1N11','Edit/Delete Title','T','T','T','T','T',''),('1N20','List All Title','T','T','T','T','T',''),('1N30','Search For Title','T','T','T','T','T',''),('1O00','Symbol Maintenance','T','T','T','T','T',''),('1P00','Brand Profile','T','T','T','T','T',''),('1P10','Create New Brand','T','T','T','T','T',''),('1P11','Edit/Delete Brand','T','T','T','T','T',''),('1P20','List All Brand','T','T','T','T','T',''),('1P30','Search For Brand','T','T','T','T','T',''),('1Q00','Vehicles Profile','T','T','T','T','T',''),('1Q10','Capacity','T','T','T','','',''),('1Q20','Colour','T','T','T','','',''),('1R00','Vouchers Profile','T','T','F','F','F','F'),('1R10','Voucher Approve','T','T','F','F','F',''),('1S00','Business Profile','T','T','F','F','F','F'),('1T00','View Own Agent','F','F','F','F','F','F'),('1U00','Attention Profile','T','T','F','F','F',''),('1V00','Recurr Group','T','T','F','F','F',''),('1X00','Language Profile','T','T','T','T','T',''),('1Y00','Terms and condition Profile','T','T','T','T','T',''),('1Z00','Other Maintenance','T','T','F','F','F',''),('1Z10','Team Profile','T','T','F','F','F',''),('1Z20','','T','T','T','T','F',''),('1Z30','Promotion','T','T','F','F','F',''),('1Z40','Commission','T','T','F','F','F',''),('1Z50','counter','T','T','F','F','F',''),('1Z60','Discount Profile','T','T','F','F','F',''),('1Z70','Area Profile','T','T','F','F','F',''),('2000','Transaction','T','T','T','T','F',''),('2100','Purchase Receive','T','T','T','T','F',''),('2101','Print GRN Note','T','T','F','F','F',''),('2102','Create Purchase Receive','T','T','F','T','F',''),('2103','Edit Purchase Receive','T','T','T','T','F',''),('2104','Delete Purchase Receive','T','T','F','F','F',''),('2105','View Own Purchase Receive','F','F','F','F','F',''),('2106','Print Purchase Receive','T','T','T','T','T',''),('2107','Edit Purchase Receive Header Only','F','F','F','F','',''),('2108','Simple Purcahse Receive','T','T','T','','',''),('2200','Purchase Return','T','T','T','F','F',''),('2201','Create Purchase Return','T','T','F','F','F',''),('2202','Edit Purchase Return','T','T','T','F','F',''),('2203','Delete Purchase Return','T','T','F','F','F',''),('2204','View Own Purchase Return','F','F','F','F','F',''),('2205','Print Purchase Return','T','T','T','T','T',''),('2206','Edit Purchase Return Header Only','F','F','F','F','',''),('2207','Simple Purcahse Return','T','T','T','','',''),('2300','Delivery Order','T','T','F','T','F',''),('2301','Create Delivery Order','T','T','F','T','F',''),('2302','Edit Delivery Order','T','T','F','T','F',''),('2303','Delete Delivery Order','T','T','F','F','F',''),('2304','View Own Delivery Order','F','F','F','F','F',''),('2305','Update To Invoice','T','T','F','T','F',''),('2306','Print Delivery Order','T','T','T','T','T',''),('2307','Edit Delivery order Header Only','F','F','F','F','',''),('2308','Simple Delivery Order','T','T','T','','',''),('2400','Invoice','T','T','T','T','F',''),('2401','Create Invoice','T','T','T','T','F',''),('2402','Edit Invoice','T','T','T','T','F',''),('2403','Delete Invoice','T','T','F','F','F',''),('2404','View Own Invoice','F','F','F','F','F',''),('2405','Print Invoice','T','T','T','T','T',''),('2406','Edit Invoice Header Only','F','F','F','F','',''),('2407','Simple Invoice','T','T','T','','',''),('2500','Cash Sales','T','T','F','F','F',''),('2501','Create Cash Sales','T','T','F','F','F',''),('2502','Edit Cash Sales','T','T','F','F','F',''),('2503','Delete Cash Sales','T','T','F','F','F',''),('2504','View Own Cash Sales','F','F','F','F','F',''),('2505','Print Cash Sales','T','T','T','T','T',''),('2506','Edit Cash Sales Header Only','F','F','F','F','',''),('2507','Simple Cash Sales','T','T','T','','',''),('2600','Credit Note','T','T','T','F','F',''),('2601','Create Credit Note','T','T','T','F','F',''),('2602','Edit Credit Note','T','T','T','F','F',''),('2603','Delete Credit Note','T','T','F','F','F',''),('2604','View Own Credit Note','F','F','F','F','F',''),('2605','Print Credit Note','T','T','T','T','T',''),('2606','Edit Credit Note Header Only','F','F','F','F','',''),('2607','Simple Credit Note','T','T','T','','',''),('2700','Debit Note','T','T','T','F','F',''),('2701','Create Debit Note','T','T','T','F','F',''),('2702','Edit Debit Note','T','T','T','F','F',''),('2703','Delete Debit Note','T','T','F','F','F',''),('2704','View Own Debit Note','F','F','F','F','F',''),('2705','Print Debit Note','T','T','T','T','T',''),('2706','Edit Debit Note Header Only','F','F','F','F','',''),('2707','Simple Debit Note','T','T','T','','',''),('2800','Other Transaction','T','T','T','T','F',''),('2810','Item Assembly','T','T','F','F','F',''),('2820','Issue','T','T','T','F','F',''),('2821','Create Issue','T','T','F','F','F',''),('2822','Edit Issue','T','T','F','F','F',''),('2823','Delete Issue','T','T','F','F','F',''),('2824','View Own Issue','F','F','F','F','F',''),('2825','Print Issue','T','T','T','T','T',''),('2830','Adjustment Increase','T','T','F','F','F',''),('2831','Create Adjustment Increase','T','T','F','F','F',''),('2832','Edit Adjustment Increase','T','T','F','F','F',''),('2833','Delete Adjustment Increase','T','T','F','F','F',''),('2834','View Own Adjustment Increase','F','F','F','F','F',''),('2835','Print Adjustment Increase','T','T','T','T','T',''),('2840','Adjustment Reduce','T','T','F','F','F',''),('2841','Create Adjustment Reduce','T','T','F','F','F',''),('2842','Edit Adjustment Reduce','T','T','F','F','F',''),('2843','Delete Adjustment Reduce','T','T','F','F','F',''),('2844','View Own Adjustment Reduce','F','F','F','F','F',''),('2845','Print Adjustment Reduce','T','T','T','T','T',''),('2850','Sample','T','T','F','T','F',''),('2851','Create Sample','T','T','F','T','F',''),('2852','Edit Sample','T','T','F','T','F',''),('2853','Delete Sample','T','T','F','F','F',''),('2854','View Own Sample','F','F','F','F','F',''),('2855','SAM Update To SO','T','T','T','T','T',''),('2856','Print Sample','T','T','T','T','T',''),('2857','Edit Sample Header Only','F','F','F','F','',''),('2858','Simple Sample','T','T','T','','',''),('2860','Purchase Order','T','T','T','T','F',''),('2861','Create Purchase Order','T','T','T','T','F',''),('2862','Edit Purchase Order','T','T','T','T','F',''),('2863','Delete Purchase Order','T','T','F','F','F',''),('2864','View Own Purchase Order','F','F','F','F','F',''),('2865','Update To Purchase Receive','T','T','F','T','F',''),('2866','Update To Delivery Order','F','F','F','F','F',''),('2867','Print Purchase Order','T','T','T','T','T',''),('2868','Edit Purchase Order Header Only','F','F','F','F','',''),('2869','Simple Purchase Order','T','T','T','','',''),('2870','Quotation','T','T','F','F','F',''),('2871','Create Quotation','T','T','F','F','F',''),('2872','Edit Quotation','T','T','F','F','F',''),('2873','Delete Quotation','T','T','F','F','F',''),('2874','View Own Quotation','F','F','F','F','F',''),('2875','Update To Sales Order','T','T','F','F','F',''),('2876','Update To Invoice','T','T','F','F','F',''),('2877','Update To Delivery Order','T','T','T','T','T',''),('2878','Update To Purchase Order','T','T','T','T','T',''),('2879','Update To Cash Sales','T','T','T','T','T',''),('287A','Print Quotation','T','T','T','T','T',''),('287B','Edit Quotation Header Only','F','F','F','F','',''),('287C','Simple Quotation','T','T','T','','',''),('2880','Sales Order','T','T','T','T','T',''),('2881','Create Sales Order','T','T','F','T','F',''),('2882','Edit Sales Order','T','T','F','T','F',''),('2883','Delete Sales Order','T','T','F','F','F',''),('2884','View Own Sales Order','F','F','F','F','T',''),('2885','Update To Delivery Order','T','T','F','T','F',''),('2886','Update To Invoice','T','T','F','T','F',''),('2887','Update To Purchase Order','T','T','F','T','F',''),('2888','Print Sales Order','T','T','T','T','T',''),('2889','Edit Sales Order Header Only','F','F','F','F','',''),('288A','Simple Sales order','T','T','T','','',''),('2890','Copy Bill','T','T','F','F','F',''),('2891','Invoice','T','T','T','T','',''),('2892','Purchase Receive','T','T','T','T','',''),('2893','Purcahse Return','T','T','T','T','',''),('2894','Delivery Order','T','T','T','T','',''),('2895','Cash Sales','T','T','T','T','',''),('2896','Credit Note','T','T','T','T','',''),('2897','Debit Note','T','T','T','T','',''),('2898','Issue','T','T','T','T','',''),('2899','Purchase Order','T','T','T','T','',''),('289A','Sales Order','T','T','T','T','',''),('289B','Quotation','T','T','T','T','',''),('289C','Transfer','T','T','T','T','',''),('289D','Sample','T','T','T','T','',''),('289E','Adjustment Increase','T','T','T','','',''),('289F','Adjustment Reduce','T','T','T','','',''),('28A0','Transfer','T','T','F','F','F',''),('28A1','Create Transfer','T','T','F','F','F',''),('28A2','Edit Transfer','T','T','F','F','F',''),('28A3','Delete Transfer','T','T','F','F','F',''),('28A4','View Own Transfer','F','F','F','F','F',''),('28A5','Print Transfer','T','T','T','T','T',''),('28A6','Simple Transfer','T','T','T','','',''),('28B0','Historical Records','T','T','F','F','F',''),('28C0','Write Off Purchase Order','T','T','T','T','T',''),('28D0','Write Off Sales Order','T','T','T','T','T',''),('28E0','Consignment Out','T','T','T','T','T',''),('28F0','Consignment Return','T','T','T','T','T',''),('28G0','Purchase Requisition','T','T','F','F','F',''),('28G1','Create Purchase Requisition','T','T','F','F','F',''),('28G2','Edit Purchase Requisition','T','T','F','F','F',''),('28G3','Delete Purchase Requisition','T','T','F','F','F',''),('28G4','View Own Purchase Requisition','F','F','F','F','F',''),('28G5','Update Purchase Order','T','T','F','F','F',''),('28G6','Print Purchase Requisition','T','T','F','F','F',''),('28G7','Edit Purchase Requisition Header Only','F','F','F','F','F',''),('2900','General Update','T','T','T','T','T','F'),('2901','Distribute Misc. Charges Into Cost','T','T','T','T','T','F'),('2902','Generate Full Payment Date','T','T','T','T','T','F'),('2903','Generate Customer Outstanding Balance','T','T','T','T','T','F'),('2A00','E-Invoicing','T','T','T','T','T',''),('2B00','Packing List','T','T','T','T','T',''),('2C00','Recurring Transaction','T','T','T','T','T',''),('2D00','Bill Item Combine','T','T','T','T','T',''),('2E00','Only allow bill to edit on the date of creation','F','F','F','F','F',''),('2F00','Enable User to Edit Price','T','T','T','T','T',''),('2G00','Enable add item when credit limit over','T','T','F','F','F',''),('2H00','Express Bill','T','T','T','T','T',''),('3000','Enquiries','T','T','F','T','T',''),('3100','Inventory Balance Check','T','T','T','T','T',''),('3110','Stock Balance','T','T','T','T','T',''),('3120','Related Item Balance','T','T','T','T','T',''),('3130','Location Stock Balance','T','T','T','T','T',''),('3200','Outstanding And Tracking','T','T','F','T','T',''),('3210','Delivery Order','T','T','F','T','F',''),('3220','Quotation','T','T','F','F','F',''),('3230','Purchase Order','T','T','F','T','T',''),('3240','PO Details','T','T','F','T','F',''),('3250','Sales Order','T','T','F','T','T',''),('3260','SO Details','T','T','F','T','F',''),('3270','SO To PO','T','T','F','T','T',''),('3280','View Own Enquiries','F','F','F','F','T',''),('3290','SO To INV','T','T','F','F','F','F'),('32A0','SO To PO','T','T','F','F','F','F'),('32B0','Quotation','T','T','F','F','F','F'),('32C0','PO To RC','T','T','F','F','F','F'),('32D0','DO To INV','T','T','F','F','F','F'),('3300','Delivery Forecast','T','T','F','F','F',''),('3400','Inventory Forecast','T','T','F','F','F',''),('3500','History Price Enquiry','T','T','F','T','T',''),('3600','Trace Item Cost & Value ','T','T','F','F','F',''),('4000','Reports','T','T','T','T','T',''),('4100','Bill Listing','T','T','T','F','F',''),('4110','Purchase Receive','T','T','T','F','F',''),('4120','Purchase Return','T','T','T','F','F',''),('4130','Delivery Order','T','T','T','F','F',''),('4140','Invoice','T','T','T','F','F',''),('4150','Quotation','T','T','F','F','F',''),('4160','Credit Note','T','T','T','F','F',''),('4170','Debit Note','T','T','T','F','F',''),('4180','Cash Sales','T','T','T','F','F',''),('4190','Purchase Order','T','T','T','F','F',''),('41A0','Sales Order','T','T','F','F','F',''),('41B0','Issue','T','T','F','F','F',''),('41C0','Sample','T','T','F','F','F','F'),('41D0','Adjustment Increase','T','T','F','F','F','F'),('41E0','Adjustment Reduce','T','T','F','F','F','F'),('41F0','Transfer Note','T','T','F','F','F','F'),('4200','Inventory Report','T','T','T','T','T',''),('4210','Stock Card','T','T','T','T','T',''),('4220','Reorder Advice','T','T','F','F','F',''),('4230','Item Status And Value','T','T','T','F','F',''),('4240','Group Status And Value','T','T','F','F','F',''),('4250','Stock Aging Report','T','T','T','F','F',''),('4260','Stock Aging','T','T','F','F','F','F'),('4270','Physical Worksheet','T','T','F','F','F','F'),('4280','Transaction Summary By Quantity','T','T','F','F','F','F'),('4290','Transaction Summary By Value','T','T','F','F','F','F'),('42A0','Display Unit Cost','T','T','T','T','T',''),('4300','Sales Report','T','T','F','F','F',''),('4310','Product Sales By Type','T','T','F','F','F',''),('4320','Customer Sales By Type','T','T','F','F','F',''),('4330','Agent Sales By Type','T','T','F','F','F',''),('4340','Group Sales By Type','T','T','F','F','F',''),('4350','End User Sales By Type','T','T','F','F','F',''),('4360','Product Sales By Month','T','T','F','F','F',''),('4370','Customer Sales By Month','T','T','F','F','F',''),('4380','Agent Sales By Month','T','T','F','F','F',''),('4390','Group Sales By Month','T','T','F','F','F',''),('43A0','End User Sales By Month','T','T','F','F','F',''),('43B0','Profit Margin By Product','T','T','F','F','F',''),('43C0','Profit Margin By Bill','T','T','F','F','F',''),('43D0','Profit Margin By Agent','T','T','F','F','F',''),('43E0','Profit Margin By Project','T','T','F','F','F',''),('43F0','Sales Listing By Customer','T','T','F','F','F',''),('43G0','Sales Listing By Product','T','T','F','F','F',''),('43H0','Sales Listing By Agent','T','T','F','F','F',''),('43I0','Fixed Cost','T','T','T','T','T',''),('43J0','First In First Out','T','T','T','T','T',''),('43K0','Last In First Out','T','T','T','T','T',''),('43L0','Month Average','T','T','T','T','T',''),('43M0','Moving Average','T','T','T','T','T',''),('43N0','PROFIT MARGIN REPORT - By Bill Item','T','T','T','T','T',''),('43O0','PROFIT MARGIN REPORT - By Customer','T','T','T','T','T',''),('43P0','Sales Listing - By Area','T','T','T','T','T',''),('43Q0','Top Product Sales','T','T','T','T','T',''),('43R0','Bottom Product Sales','T','T','T','T','T',''),('43S0','Top Sales By Customers','T','T','T','T','T',''),('43T0','Top Sales By Agent','T','T','T','T','T',''),('43U0','Top Sales By Area','T','T','T','T','T',''),('43V0','Agent Sales Commision Report','T','T','T','T','T',''),('43W0','Only Allow Agent To view Own Report','F','F','F','F','F',''),('4400','Purchase Report','T','T','F','F','F',''),('4410','Product Purchase By Type','T','T','F','F','F',''),('4420','Vendor Supply By Type','T','T','F','F','F',''),('4430','Product Purchase By Month','T','T','F','F','F',''),('4440','Vendor Supply By Month','T','T','F','F','F',''),('4450','Customer - Product Sales - By Type','T','T','F','F','F',''),('4460','Customer - Product Sales - By Month','T','T','F','F','F',''),('4470','Agent - Customer Sales - By Month','T','T','F','F','F',''),('4500','Location Report','T','T','F','F','F',''),('4510','Item - Location Sales','T','T','F','F','F',''),('4520','Item - Location Purchase','T','T','F','F','F',''),('4530','Stock Card','T','T','F','T','T',''),('4540','Forecast','T','T','F','F','F',''),('4550','Location Physical Worksheet','T','T','F','F','F',''),('4560','Location Item Status and Value','T','T','F','F','F',''),('4570','Location Opening Qty Check','T','T','F','F','F',''),('4600','Serial Report','T','T','F','F','F',''),('4610','Transaction Listing By Ref No','T','T','F','F','F',''),('4620','Transaction Listing By Item','T','T','F','F','F',''),('4630','Item - Serial No Status','T','T','F','F','F',''),('4640','Serial No Sales Listing','T','T','F','F','F',''),('4700','View Own Agent Report','F','F','F','F','F',''),('4800','Cust/Supp/Agent/Area Item Report','T','T','F','F','F',''),('4900','Batch Code Report','T','T','T','T','T',''),('4910','Item Batch Opening','T','T','T','T','T',''),('4920','Item Batch Sales','T','T','T','T','T',''),('4930','Item Batch Status','T','T','T','T','T',''),('4940','Item Batch Stock Card','T','T','T','T','T',''),('4950','Batch Item Listing','T','T','T','T','T',''),('4960','Location Item Batch Opening','T','T','T','T','T',''),('4970','Location Item Batch Sales','T','T','T','T','T',''),('4980','Location Item Batch Status','T','T','T','T','T',''),('4990','Location Item Batch Stock Card','T','T','T','T','T',''),('4A00','Graded Item Report','T','T','T','T','T',''),('4A10','Graded Item Physical Worksheet','T','T','T','T','T',''),('4A20','Graded Item Opening','T','T','T','T','T',''),('4A30','Graded Item Sales','T','T','T','T','T',''),('4A40','Graded Item Status','T','T','T','T','T',''),('4A50','Graded Item Stock Card','T','T','T','T','T',''),('4A60','Graded Item - Location Opening','T','T','T','T','T',''),('4A70','Graded Item - Location Sales','T','T','T','T','T',''),('4A80','Graded Item - Location Status','T','T','T','T','T',''),('4A90','Location - Graded Item Physical Worksheet','T','T','T','T','T',''),('4AA0','Location - Graded Item Opening','T','T','T','T','T',''),('4AB0','Location - Graded Item Sales','T','T','T','T','T',''),('4AC0','Location - Graded Item Status','T','T','T','T','T',''),('4AD0','Location - Graded Item Stock Card','T','T','T','T','T',''),('4B00','Matrix Item Report','T','T','T','T','T',''),('4B10','Matrix Item Opening','T','T','T','T','T',''),('4B20','Matrix Item Sales','T','T','T','T','T',''),('4B30','Matrix Item Purchase','T','T','T','T','T',''),('4B40','Matrix Stock Balance','T','T','T','T','T',''),('4C00','Project Report','T','T','T','T','T',''),('4C10','List By Project Item','T','T','T','T','T',''),('4C20','Project Sales & Issue','T','T','T','T','T',''),('4C30','Project - Item Issue','T','T','T','T','T',''),('4C40','Item - Project Issue','T','T','T','T','T',''),('4D00','Service Report','T','T','T','T','T',''),('4D10','List By Service Item ','T','T','T','T','T',''),('4D20','Service Income report','T','T','T','T','T',''),('4D30','Customer - ServiceReport','T','T','T','T','T',''),('4D40','Agent - ServiceReport','T','T','T','T','T',''),('4D50','Supplier - ServiceReport','T','T','T','T','T',''),('4D60','Service Profit Margin - Transactions','T','T','T','T','T',''),('4D70','Service Profit Margin - Service Code','T','T','T','T','T',''),('4D80','Service Part Report - By Month','T','T','T','T','T',''),('4D90','Productivity Report','T','T','T','T','T',''),('4E00','StoreKeeper Report','T','T','T','T','T',''),('4E10','Stock Card','T','T','T','T','T',''),('4E20','Customer Item Sales Listing','T','T','T','T','T',''),('4E30','Customer Invoice Detail Listing','T','T','T','T','T',''),('4E40','Supplier Item Transaction Listing','T','T','T','T','T',''),('4E50','Supplier Bill Detail Listing','T','T','T','T','T',''),('4F00','Manufacturing Report','T','T','T','T','T',''),('4G00','View Only','','','','','',''),('4H00','Customized Report','T','T','T','T','T',''),('4I00','Cash Sales Reports','T','T','T','','',''),('5000','General Setup','T','T','F','F','F',''),('5100','General Information Setup','T','T','F','F','F',''),('5110','Company Profile','T','T','T','T','T','T'),('5120','Last Used No','T','T','T','T','T','T'),('5130','Transaction Setup','T','T','T','T','T','T'),('5140','UBS Accounting Default Setup','T','T','T','T','T','T'),('5150','User Defined','T','T','T','T','T','T'),('5160','Dealer Menu','T','T','T','T','T','T'),('5170','Transaction Menu','T','T','T','T','T','T'),('5180','User Define - Formula','T','T','T','T','T','T'),('5200','Year-End Processing','T','T','F','F','F',''),('5300','User Administration','T','T','F','F','F',''),('5400','Currency Table','T','T','F','F','F',''),('5500','User Defined Menu','T','T','F','F','F',''),('5600','Posting To UBS','T','T','F','F','F',''),('5610','Posted Transaction','T','T','T','T','T',''),('5620','Posting Check','T','T','T','T','T',''),('5630','List Not Exported','T','T','T','T','T',''),('5640','Unpost Bill','T','T','T','T','T',''),('5650','Import to AMS','T','T','T','T','T',''),('5700','With Price In Delivery Order','T','T','T','T','T','T'),('5800','View Audit Trail','F','F','F','F','F',''),('5900','Boss Menu','T','T','T','T','T',''),('5910','Change Item No.','T','T','T','T','T',''),('5920','Change Category','T','T','T','T','T',''),('5930','Change Group','T','T','T','T','T',''),('5940','Change Service Code','T','T','T','T','T',''),('5950','Change Customer No.','T','T','T','T','T',''),('5960','Change Supplier No.','T','T','T','T','T',''),('5970','Change Agent','T','T','T','T','T',''),('5980','Change Reference No.','T','T','T','T','T',''),('5990','Change Brand','T','T','F','F','F',''),('59A0','Change Project','T','T','F','F','F',''),('59B0','Change Job Code','T','T','F','F','F',''),('59C0','Recover Transaction','T','T','F','F','F',''),('59D0','Change End User No','T','T','F','F','F',''),('59E0','Enable Edit Of Transaction That are updated','T','T','F','F','F',''),('59F0','Change Date','T','T','F','F','F',''),('59G0','Update Cost Code','T','T','F','F','F',''),('59H0','Change Term','T','T','F','F','F',''),('59I0','Unvoid Transaction','T','T','F','F','F',''),('59J0','Change Business','T','T','F','F','F',''),('59K0','Change Area','T','T','F','F','F',''),('59L0','Change Team','T','T','F','F','F',''),('59M0','Change Material','T','T','F','F','F',''),('5A00','Update Transaction Project','T','Y','F','F','F',''),('5B00','Sync Agent & Project','T','Y','F','F','F',''),('5C00','Monthly Backup','T','Y','F','F','F',''),('5D00','Import CSV File to IMS ','T','T','T','T','T','T'),('5E00','Import Excel File to IMS ','T','T','T','T','T','T'),('5F00','Export To CSV File ','T','T','T','T','T','T'),('6000','Print Bills','T','T','T','T','T',''),('6100','Invoice','T','T','T','T','T',''),('6200','Cash Bills','T','T','T','T','T',''),('6300','Credit Note','T','T','T','T','T',''),('6400','Debit Note','T','T','T','T','T',''),('6500','Receive','T','T','T','T','T',''),('6600','Purchase Return','T','T','T','T','T',''),('6700','Delivery Order','T','T','T','T','T',''),('6800','Packing List','T','T','T','T','T',''),('6900','Purchase Order','T','T','T','T','T',''),('6A00','Sales Order','T','T','T','T','T',''),('6B00','Quotation','T','T','T','T','T',''),('6C00','Issue','T','T','T','T','T',''),('6D00','Adjustment Increase','T','T','T','T','T',''),('6E00','Adjustment Reduce','T','T','T','T','T',''),('6F00','Transfer Note','T','T','T','T','T',''),('6G00','Transfer Note 2','T','T','T','T','T',''),('6H00','Consignment Note','T','T','T','T','T',''),('6I00','Consignment Return','T','T','T','T','T','');
/*!40000 ALTER TABLE `userpin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userpin2`
--

DROP TABLE IF EXISTS `userpin2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpin2` (
  `H1000` char(1) NOT NULL DEFAULT '',
  `H1100` char(1) NOT NULL DEFAULT '',
  `H1110` char(1) NOT NULL DEFAULT '',
  `H1111` char(1) NOT NULL DEFAULT '',
  `H1120` char(1) NOT NULL DEFAULT '',
  `H1130` char(1) NOT NULL DEFAULT '',
  `H1140` char(1) NOT NULL DEFAULT '',
  `H1200` char(1) NOT NULL DEFAULT '',
  `H1210` char(1) NOT NULL DEFAULT '',
  `H1211` char(1) NOT NULL DEFAULT '',
  `H1220` char(1) NOT NULL DEFAULT '',
  `H1230` char(1) NOT NULL DEFAULT '',
  `H1240` char(1) NOT NULL DEFAULT '',
  `H1250` char(1) NOT NULL DEFAULT 'F',
  `H1300` char(1) NOT NULL DEFAULT '',
  `H1310` char(1) NOT NULL DEFAULT '',
  `H1311` char(1) NOT NULL DEFAULT '',
  `H1320` char(1) NOT NULL DEFAULT '',
  `H1330` char(1) NOT NULL DEFAULT '',
  `H1340` char(1) NOT NULL DEFAULT '',
  `H1350` char(1) NOT NULL DEFAULT '',
  `H1400` char(1) NOT NULL DEFAULT '',
  `H1410` char(1) NOT NULL DEFAULT '',
  `H1411` char(1) NOT NULL DEFAULT '',
  `H1420` char(1) NOT NULL DEFAULT '',
  `H1430` char(1) NOT NULL DEFAULT '',
  `H1500` char(1) NOT NULL DEFAULT '',
  `H1510` char(1) NOT NULL DEFAULT '',
  `H1511` char(1) NOT NULL DEFAULT '',
  `H1520` char(1) NOT NULL DEFAULT '',
  `H1530` char(1) NOT NULL DEFAULT '',
  `H1540` char(1) NOT NULL DEFAULT '',
  `H1600` char(1) NOT NULL DEFAULT '',
  `H1610` char(1) NOT NULL DEFAULT '',
  `H1611` char(1) NOT NULL DEFAULT '',
  `H1620` char(1) NOT NULL DEFAULT '',
  `H1630` char(1) NOT NULL DEFAULT '',
  `H1700` char(1) NOT NULL DEFAULT '',
  `H1710` char(1) NOT NULL DEFAULT '',
  `H1711` char(1) NOT NULL DEFAULT '',
  `H1720` char(1) NOT NULL DEFAULT '',
  `H1730` char(1) NOT NULL DEFAULT '',
  `H1800` char(1) NOT NULL DEFAULT '',
  `H1810` char(1) NOT NULL DEFAULT '',
  `H1811` char(1) NOT NULL DEFAULT '',
  `H1820` char(1) NOT NULL DEFAULT '',
  `H1830` char(1) NOT NULL DEFAULT '',
  `H1900` char(1) NOT NULL DEFAULT '',
  `H1910` char(1) NOT NULL DEFAULT '',
  `H1911` char(1) NOT NULL DEFAULT '',
  `H1920` char(1) NOT NULL DEFAULT '',
  `H1930` char(1) NOT NULL DEFAULT '',
  `H1A00` char(1) NOT NULL DEFAULT '',
  `H1A10` char(1) NOT NULL DEFAULT '',
  `H1A11` char(1) NOT NULL DEFAULT '',
  `H1A20` char(1) NOT NULL DEFAULT '',
  `H1A30` char(1) NOT NULL DEFAULT '',
  `H1B00` char(1) NOT NULL DEFAULT '',
  `H1B10` char(1) NOT NULL DEFAULT '',
  `H1B11` char(1) NOT NULL DEFAULT '',
  `H1B20` char(1) NOT NULL DEFAULT '',
  `H1B30` char(1) NOT NULL DEFAULT '',
  `H1B40` char(1) NOT NULL DEFAULT '',
  `H1C00` char(1) NOT NULL DEFAULT '',
  `H1C10` char(1) NOT NULL DEFAULT '',
  `H1C11` char(1) NOT NULL DEFAULT '',
  `H1C20` char(1) NOT NULL DEFAULT '',
  `H1C30` char(1) NOT NULL DEFAULT '',
  `H1C40` char(1) NOT NULL DEFAULT '',
  `H1D00` char(1) NOT NULL DEFAULT '',
  `H1D10` char(1) NOT NULL DEFAULT '',
  `H1D11` char(1) NOT NULL DEFAULT '',
  `H1D20` char(1) NOT NULL DEFAULT '',
  `H1D30` char(1) NOT NULL DEFAULT '',
  `H1E00` char(1) NOT NULL DEFAULT '',
  `H1E10` char(1) NOT NULL DEFAULT '',
  `H1E11` char(1) NOT NULL DEFAULT '',
  `H1E20` char(1) NOT NULL DEFAULT '',
  `H1E30` char(1) NOT NULL DEFAULT '',
  `H1F00` char(1) NOT NULL DEFAULT '',
  `H1F10` char(1) NOT NULL DEFAULT '',
  `H1F11` char(1) NOT NULL DEFAULT '',
  `H1F20` char(1) NOT NULL DEFAULT '',
  `H1F30` char(1) NOT NULL DEFAULT '',
  `H1G00` char(1) NOT NULL DEFAULT '',
  `H1G10` char(1) NOT NULL DEFAULT '',
  `H1G11` char(1) NOT NULL DEFAULT '',
  `H1G20` char(1) NOT NULL DEFAULT '',
  `H1G30` char(1) NOT NULL DEFAULT '',
  `H1H00` char(1) NOT NULL DEFAULT '',
  `H1H10` char(1) NOT NULL DEFAULT '',
  `H1H11` char(1) NOT NULL DEFAULT '',
  `H1H20` char(1) NOT NULL DEFAULT '',
  `H1H30` char(1) NOT NULL DEFAULT '',
  `H1I00` char(1) NOT NULL DEFAULT '',
  `H1I10` char(1) NOT NULL DEFAULT '',
  `H1I11` char(1) NOT NULL DEFAULT '',
  `H1I20` char(1) NOT NULL DEFAULT '',
  `H1I30` char(1) NOT NULL DEFAULT '',
  `H1J00` char(1) NOT NULL DEFAULT '',
  `H1J10` char(1) NOT NULL DEFAULT '',
  `H1J20` char(1) NOT NULL DEFAULT '',
  `H1J30` char(1) NOT NULL DEFAULT '',
  `H1J40` char(1) NOT NULL DEFAULT '',
  `H1J50` char(1) NOT NULL DEFAULT '',
  `H1J60` char(1) NOT NULL DEFAULT '',
  `H1K00` char(1) NOT NULL DEFAULT '',
  `H1K10` char(1) NOT NULL DEFAULT '',
  `H1K20` char(1) NOT NULL DEFAULT '',
  `H1K30` char(1) NOT NULL DEFAULT '',
  `H1K40` char(1) NOT NULL DEFAULT '',
  `H1K50` char(1) NOT NULL DEFAULT '',
  `H1K60` char(1) NOT NULL DEFAULT '',
  `H1K70` char(1) NOT NULL DEFAULT '',
  `H1L00` char(1) NOT NULL DEFAULT '',
  `H1L10` char(1) NOT NULL DEFAULT '',
  `H1L11` char(1) NOT NULL DEFAULT '',
  `H1L20` char(1) NOT NULL DEFAULT '',
  `H1L30` char(1) NOT NULL DEFAULT '',
  `H1M00` char(1) NOT NULL DEFAULT '',
  `H1M10` char(1) NOT NULL DEFAULT '',
  `H1M11` char(1) NOT NULL DEFAULT '',
  `H1M20` char(1) NOT NULL DEFAULT '',
  `H1M30` char(1) NOT NULL DEFAULT '',
  `H1N00` char(1) NOT NULL DEFAULT '',
  `H1N10` char(1) NOT NULL DEFAULT '',
  `H1N11` char(1) NOT NULL DEFAULT '',
  `H1N20` char(1) NOT NULL DEFAULT '',
  `H1N30` char(1) NOT NULL DEFAULT '',
  `H1O00` char(1) NOT NULL,
  `H1P00` char(1) NOT NULL DEFAULT '',
  `H1P10` char(1) NOT NULL DEFAULT '',
  `H1P11` char(1) NOT NULL DEFAULT '',
  `H1P20` char(1) NOT NULL DEFAULT '',
  `H1P30` char(1) NOT NULL DEFAULT '',
  `H1Q00` varchar(45) NOT NULL,
  `H1Q10` char(1) NOT NULL DEFAULT 'T',
  `H1Q20` char(1) NOT NULL DEFAULT 'T',
  `H1R00` varchar(45) DEFAULT NULL,
  `H5990` varchar(45) DEFAULT 'T',
  `H59A0` char(1) NOT NULL DEFAULT 'T',
  `H59B0` char(1) NOT NULL DEFAULT 'T',
  `H59C0` char(1) NOT NULL DEFAULT 'T',
  `H59D0` char(1) NOT NULL DEFAULT 'T',
  `H59E0` char(1) NOT NULL DEFAULT 'T',
  `H59F0` char(1) NOT NULL DEFAULT 'T',
  `H59G0` char(1) NOT NULL DEFAULT 'T',
  `H59H0` char(1) NOT NULL DEFAULT 'T',
  `H59I0` char(1) NOT NULL DEFAULT 'T',
  `H59J0` char(1) NOT NULL DEFAULT 'T',
  `H59K0` char(1) NOT NULL DEFAULT 'T',
  `H59L0` char(1) NOT NULL DEFAULT 'T',
  `H59M0` char(1) NOT NULL DEFAULT 'T',
  `H41C0` varchar(45) DEFAULT 'T',
  `H41D0` varchar(45) DEFAULT 'T',
  `H41E0` varchar(45) DEFAULT 'T',
  `H41F0` varchar(45) DEFAULT 'T',
  `H1S00` varchar(45) DEFAULT 'T',
  `H1T00` char(1) NOT NULL DEFAULT 'F',
  `H3290` varchar(45) DEFAULT 'T',
  `H32A0` varchar(45) DEFAULT 'T',
  `H32B0` varchar(45) DEFAULT 'T',
  `H32C0` varchar(45) DEFAULT 'T',
  `H32D0` varchar(45) DEFAULT 'T',
  `H4260` varchar(45) DEFAULT 'T',
  `H4270` varchar(45) DEFAULT 'T',
  `H4280` varchar(45) DEFAULT 'T',
  `H4290` varchar(45) DEFAULT 'T',
  `H1360` varchar(45) DEFAULT 'T',
  `H2000` char(1) NOT NULL DEFAULT '',
  `H2100` char(1) NOT NULL DEFAULT '',
  `H2101` char(1) NOT NULL DEFAULT '',
  `H2102` char(1) NOT NULL DEFAULT '',
  `H2103` char(1) NOT NULL DEFAULT '',
  `H2104` char(1) NOT NULL DEFAULT '',
  `H2105` char(1) NOT NULL DEFAULT '',
  `H2200` char(1) NOT NULL DEFAULT '',
  `H2201` char(1) NOT NULL DEFAULT '',
  `H2202` char(1) NOT NULL DEFAULT '',
  `H2203` char(1) NOT NULL DEFAULT '',
  `H2204` char(1) NOT NULL DEFAULT '',
  `H2300` char(1) NOT NULL DEFAULT '',
  `H2301` char(1) NOT NULL DEFAULT '',
  `H2302` char(1) NOT NULL DEFAULT '',
  `H2303` char(1) NOT NULL DEFAULT '',
  `H2304` char(1) NOT NULL DEFAULT '',
  `H2305` char(1) NOT NULL DEFAULT '',
  `H2400` char(1) NOT NULL DEFAULT '',
  `H2401` char(1) NOT NULL DEFAULT '',
  `H2402` char(1) NOT NULL DEFAULT '',
  `H2403` char(1) NOT NULL DEFAULT '',
  `H2404` char(1) NOT NULL DEFAULT '',
  `H2500` char(1) NOT NULL DEFAULT '',
  `H2501` char(1) NOT NULL DEFAULT '',
  `H2502` char(1) NOT NULL DEFAULT '',
  `H2503` char(1) NOT NULL DEFAULT '',
  `H2504` char(1) NOT NULL DEFAULT '',
  `H2600` char(1) NOT NULL DEFAULT '',
  `H2601` char(1) NOT NULL DEFAULT '',
  `H2602` char(1) NOT NULL DEFAULT '',
  `H2603` char(1) NOT NULL DEFAULT '',
  `H2604` char(1) NOT NULL DEFAULT '',
  `H2700` char(1) NOT NULL DEFAULT '',
  `H2701` char(1) NOT NULL DEFAULT '',
  `H2702` char(1) NOT NULL DEFAULT '',
  `H2703` char(1) NOT NULL DEFAULT '',
  `H2704` char(1) NOT NULL DEFAULT '',
  `H2800` char(1) NOT NULL DEFAULT '',
  `H2810` char(1) NOT NULL DEFAULT '',
  `H2820` char(1) NOT NULL DEFAULT '',
  `H2821` char(1) NOT NULL DEFAULT '',
  `H2822` char(1) NOT NULL DEFAULT '',
  `H2823` char(1) NOT NULL DEFAULT '',
  `H2824` char(1) NOT NULL DEFAULT '',
  `H2830` char(1) NOT NULL DEFAULT '',
  `H2831` char(1) NOT NULL DEFAULT '',
  `H2832` char(1) NOT NULL DEFAULT '',
  `H2833` char(1) NOT NULL DEFAULT '',
  `H2834` char(1) NOT NULL DEFAULT '',
  `H2840` char(1) NOT NULL DEFAULT '',
  `H2841` char(1) NOT NULL DEFAULT '',
  `H2842` char(1) NOT NULL DEFAULT '',
  `H2843` char(1) NOT NULL DEFAULT '',
  `H2844` char(1) NOT NULL DEFAULT '',
  `H2850` char(1) NOT NULL DEFAULT '',
  `H2851` char(1) NOT NULL DEFAULT '',
  `H2852` char(1) NOT NULL DEFAULT '',
  `H2853` char(1) NOT NULL DEFAULT '',
  `H2854` char(1) NOT NULL DEFAULT '',
  `H2860` char(1) NOT NULL DEFAULT '',
  `H2861` char(1) NOT NULL DEFAULT '',
  `H2862` char(1) NOT NULL DEFAULT '',
  `H2863` char(1) NOT NULL DEFAULT '',
  `H2864` char(1) NOT NULL DEFAULT '',
  `H2865` char(1) NOT NULL DEFAULT '',
  `H2866` char(1) NOT NULL DEFAULT 'F',
  `H2870` char(1) NOT NULL DEFAULT '',
  `H2871` char(1) NOT NULL DEFAULT '',
  `H2872` char(1) NOT NULL DEFAULT '',
  `H2873` char(1) NOT NULL DEFAULT '',
  `H2874` char(1) NOT NULL DEFAULT '',
  `H2875` char(1) NOT NULL DEFAULT '',
  `H2876` char(1) NOT NULL DEFAULT '',
  `H2877` char(1) NOT NULL DEFAULT '',
  `H2878` char(1) NOT NULL DEFAULT '',
  `H2879` char(1) NOT NULL,
  `H2880` char(1) NOT NULL DEFAULT '',
  `H2881` char(1) NOT NULL DEFAULT '',
  `H2882` char(1) NOT NULL DEFAULT '',
  `H2883` char(1) NOT NULL DEFAULT '',
  `H2884` char(1) NOT NULL DEFAULT '',
  `H2885` char(1) NOT NULL DEFAULT '',
  `H2886` char(1) NOT NULL DEFAULT '',
  `H2887` char(1) NOT NULL DEFAULT '',
  `H2890` char(1) NOT NULL DEFAULT '',
  `H28A0` char(1) NOT NULL DEFAULT '',
  `H28E0` char(1) NOT NULL DEFAULT 'T',
  `H28F0` char(1) NOT NULL DEFAULT 'T',
  `H28A1` char(1) NOT NULL DEFAULT '',
  `H28A2` char(1) NOT NULL DEFAULT '',
  `H28A3` char(1) NOT NULL DEFAULT '',
  `H28A4` char(1) NOT NULL DEFAULT '',
  `H28B0` char(1) NOT NULL DEFAULT '',
  `H28C0` char(1) NOT NULL DEFAULT '',
  `H28D0` char(1) NOT NULL DEFAULT '',
  `H2900` char(1) NOT NULL DEFAULT '',
  `H2A00` char(1) NOT NULL,
  `H2B00` char(1) NOT NULL,
  `H2C00` char(1) NOT NULL DEFAULT 'T',
  `H2D00` char(1) NOT NULL DEFAULT 'T',
  `H2855` char(1) NOT NULL DEFAULT 'T',
  `H2901` char(1) NOT NULL DEFAULT '',
  `H2902` char(1) NOT NULL DEFAULT '',
  `H2903` char(1) NOT NULL DEFAULT '',
  `H3000` char(1) NOT NULL DEFAULT '',
  `H3100` char(1) NOT NULL DEFAULT '',
  `H3110` char(1) NOT NULL DEFAULT '',
  `H3120` char(1) NOT NULL DEFAULT '',
  `H3200` char(1) NOT NULL DEFAULT '',
  `H3210` char(1) NOT NULL DEFAULT '',
  `H3220` char(1) NOT NULL DEFAULT '',
  `H3230` char(1) NOT NULL DEFAULT '',
  `H3240` char(1) NOT NULL DEFAULT '',
  `H3250` char(1) NOT NULL DEFAULT '',
  `H3260` char(1) NOT NULL DEFAULT '',
  `H3270` char(1) NOT NULL DEFAULT '',
  `H3280` char(1) NOT NULL DEFAULT '',
  `H3300` char(1) NOT NULL DEFAULT '',
  `H3400` char(1) NOT NULL DEFAULT '',
  `H3500` char(1) NOT NULL DEFAULT '',
  `H4000` char(1) NOT NULL DEFAULT '',
  `H4100` char(1) NOT NULL DEFAULT '',
  `H4110` char(1) NOT NULL DEFAULT '',
  `H4120` char(1) NOT NULL DEFAULT '',
  `H4130` char(1) NOT NULL DEFAULT '',
  `H4140` char(1) NOT NULL DEFAULT '',
  `H4150` char(1) NOT NULL DEFAULT '',
  `H4160` char(1) NOT NULL DEFAULT '',
  `H4170` char(1) NOT NULL DEFAULT '',
  `H4180` char(1) NOT NULL DEFAULT '',
  `H4190` char(1) NOT NULL DEFAULT '',
  `H41A0` char(1) NOT NULL DEFAULT '',
  `H41B0` char(1) NOT NULL DEFAULT '',
  `H4200` char(1) NOT NULL DEFAULT '',
  `H4210` char(1) NOT NULL DEFAULT '',
  `H4220` char(1) NOT NULL DEFAULT '',
  `H4230` char(1) NOT NULL DEFAULT '',
  `H4240` char(1) NOT NULL DEFAULT '',
  `H4250` char(1) NOT NULL DEFAULT '',
  `H4300` char(1) NOT NULL DEFAULT '',
  `H4310` char(1) NOT NULL DEFAULT '',
  `H4320` char(1) NOT NULL DEFAULT '',
  `H4330` char(1) NOT NULL DEFAULT '',
  `H4340` char(1) NOT NULL DEFAULT '',
  `H4350` char(1) NOT NULL DEFAULT '',
  `H4360` char(1) NOT NULL DEFAULT '',
  `H4370` char(1) NOT NULL DEFAULT '',
  `H4380` char(1) NOT NULL DEFAULT '',
  `H4390` char(1) NOT NULL DEFAULT '',
  `H43A0` char(1) NOT NULL DEFAULT '',
  `H43B0` char(1) NOT NULL DEFAULT '',
  `H43C0` char(1) NOT NULL DEFAULT '',
  `H43D0` char(1) NOT NULL DEFAULT '',
  `H43E0` char(1) NOT NULL DEFAULT '',
  `H43F0` char(1) NOT NULL DEFAULT '',
  `H43G0` char(1) NOT NULL DEFAULT '',
  `H43H0` char(1) NOT NULL DEFAULT '',
  `H43I0` char(1) NOT NULL DEFAULT 'T',
  `H43J0` char(1) NOT NULL DEFAULT 'T',
  `H43K0` char(1) NOT NULL DEFAULT 'T',
  `H43L0` char(1) NOT NULL DEFAULT 'T',
  `H43M0` char(1) NOT NULL DEFAULT 'T',
  `H43N0` char(1) NOT NULL DEFAULT 'T',
  `H43O0` char(1) NOT NULL DEFAULT 'T',
  `H43P0` char(1) NOT NULL DEFAULT 'T',
  `H43Q0` char(1) NOT NULL DEFAULT 'T',
  `H43R0` char(1) NOT NULL DEFAULT 'T',
  `H43S0` char(1) NOT NULL DEFAULT 'T',
  `H43T0` char(1) NOT NULL DEFAULT 'T',
  `H43U0` char(1) NOT NULL DEFAULT 'T',
  `H43V0` char(1) NOT NULL DEFAULT 'T',
  `H4400` char(1) NOT NULL DEFAULT '',
  `H4410` char(1) NOT NULL DEFAULT '',
  `H4420` char(1) NOT NULL DEFAULT '',
  `H4430` char(1) NOT NULL DEFAULT '',
  `H4440` char(1) NOT NULL DEFAULT '',
  `H4450` char(1) NOT NULL DEFAULT '',
  `H4460` char(1) NOT NULL DEFAULT '',
  `H4470` char(1) NOT NULL DEFAULT '',
  `H4500` char(1) NOT NULL DEFAULT '',
  `H4510` char(1) NOT NULL DEFAULT '',
  `H4520` char(1) NOT NULL DEFAULT '',
  `H4530` char(1) NOT NULL DEFAULT '',
  `H4540` char(1) NOT NULL DEFAULT '',
  `H4550` char(1) NOT NULL DEFAULT 'T',
  `H4560` char(1) NOT NULL DEFAULT 'T',
  `H4570` char(1) NOT NULL DEFAULT 'T',
  `H4600` char(1) NOT NULL DEFAULT '',
  `H4610` char(1) NOT NULL DEFAULT '',
  `H4620` char(1) NOT NULL DEFAULT '',
  `H4630` char(1) NOT NULL DEFAULT '',
  `H4640` char(1) NOT NULL DEFAULT '',
  `H4700` char(1) NOT NULL DEFAULT '',
  `H4800` char(1) NOT NULL DEFAULT '',
  `H4900` char(1) NOT NULL DEFAULT '',
  `H4910` char(1) NOT NULL DEFAULT '',
  `H4920` char(1) NOT NULL DEFAULT '',
  `H4930` char(1) NOT NULL DEFAULT '',
  `H4940` char(1) NOT NULL DEFAULT '',
  `H4950` char(1) NOT NULL DEFAULT '',
  `H4960` char(1) NOT NULL DEFAULT '',
  `H4970` char(1) NOT NULL DEFAULT '',
  `H4980` char(1) NOT NULL DEFAULT '',
  `H4990` char(1) NOT NULL DEFAULT '',
  `H4A00` char(1) NOT NULL DEFAULT '',
  `H4A10` char(1) NOT NULL DEFAULT '',
  `H4A20` char(1) NOT NULL DEFAULT '',
  `H4A30` char(1) NOT NULL DEFAULT '',
  `H4A40` char(1) NOT NULL DEFAULT '',
  `H4A50` char(1) NOT NULL DEFAULT '',
  `H4A60` char(1) NOT NULL DEFAULT '',
  `H4A70` char(1) NOT NULL DEFAULT '',
  `H4A80` char(1) NOT NULL DEFAULT '',
  `H4A90` char(1) NOT NULL DEFAULT '',
  `H4AA0` char(1) NOT NULL DEFAULT '',
  `H4AB0` char(1) NOT NULL DEFAULT '',
  `H4AC0` char(1) NOT NULL DEFAULT '',
  `H4AD0` char(1) NOT NULL DEFAULT '',
  `H4B00` char(1) NOT NULL DEFAULT '',
  `H4B10` char(1) NOT NULL DEFAULT '',
  `H4B20` char(1) NOT NULL DEFAULT '',
  `H4B30` char(1) NOT NULL DEFAULT '',
  `H4B40` char(1) NOT NULL DEFAULT '',
  `H4C00` char(1) NOT NULL DEFAULT '',
  `H4C10` char(1) NOT NULL DEFAULT '',
  `H4C20` char(1) NOT NULL DEFAULT '',
  `H4C30` char(1) NOT NULL DEFAULT '',
  `H4C40` char(1) NOT NULL DEFAULT '',
  `H5000` char(1) NOT NULL DEFAULT '',
  `H5100` char(1) NOT NULL DEFAULT '',
  `H5110` char(1) NOT NULL DEFAULT 'T',
  `H5120` char(1) NOT NULL DEFAULT 'T',
  `H5130` char(1) NOT NULL DEFAULT 'T',
  `H5140` char(1) NOT NULL DEFAULT 'T',
  `H5150` char(1) NOT NULL DEFAULT 'T',
  `H5160` char(1) NOT NULL DEFAULT 'T',
  `H5170` char(1) NOT NULL DEFAULT 'T',
  `H5180` char(1) NOT NULL DEFAULT 'T',
  `H5200` char(1) NOT NULL DEFAULT '',
  `H5300` char(1) NOT NULL DEFAULT '',
  `H5400` char(1) NOT NULL DEFAULT '',
  `H5500` char(1) NOT NULL DEFAULT '',
  `H5600` char(1) NOT NULL DEFAULT '',
  `H5610` char(1) NOT NULL DEFAULT 'T',
  `H5620` char(1) NOT NULL DEFAULT 'T',
  `H5630` char(1) NOT NULL DEFAULT 'T',
  `H5640` char(1) NOT NULL DEFAULT 'T',
  `H5650` char(1) NOT NULL DEFAULT 'T',
  `H5700` char(1) NOT NULL DEFAULT '',
  `H5800` char(1) DEFAULT 'F',
  `H5900` char(1) NOT NULL DEFAULT '',
  `H5910` char(1) NOT NULL DEFAULT '',
  `H5920` char(1) NOT NULL DEFAULT '',
  `H5930` char(1) NOT NULL DEFAULT '',
  `H5940` char(1) NOT NULL DEFAULT '',
  `H5950` char(1) NOT NULL DEFAULT '',
  `H5960` char(1) NOT NULL DEFAULT '',
  `H5970` char(1) NOT NULL DEFAULT '',
  `H5980` char(1) NOT NULL DEFAULT '',
  `H6000` char(1) NOT NULL DEFAULT '',
  `H6100` char(1) NOT NULL DEFAULT 'T',
  `H6200` char(1) NOT NULL DEFAULT 'T',
  `H6300` char(1) NOT NULL DEFAULT 'T',
  `H6400` char(1) NOT NULL DEFAULT 'T',
  `H6500` char(1) NOT NULL DEFAULT 'T',
  `H6600` char(1) NOT NULL DEFAULT 'T',
  `H6700` char(1) NOT NULL DEFAULT 'T',
  `H6800` char(1) NOT NULL DEFAULT 'T',
  `H6900` char(1) NOT NULL DEFAULT 'T',
  `H6A00` char(1) NOT NULL DEFAULT 'T',
  `H6B00` char(1) NOT NULL DEFAULT 'T',
  `H6C00` char(1) NOT NULL DEFAULT 'T',
  `H6D00` char(1) NOT NULL DEFAULT 'T',
  `H6E00` char(1) NOT NULL DEFAULT 'T',
  `H6F00` char(1) NOT NULL DEFAULT 'T',
  `H6G00` char(1) NOT NULL DEFAULT 'T',
  `H6H00` char(1) NOT NULL DEFAULT 'T',
  `H6I00` char(1) NOT NULL DEFAULT 'T',
  `LEVEL` varchar(12) NOT NULL DEFAULT '',
  `H4D00` char(1) NOT NULL DEFAULT 'T',
  `H4D10` char(1) NOT NULL DEFAULT 'T',
  `H4D20` char(1) NOT NULL DEFAULT 'T',
  `H4D30` char(1) NOT NULL DEFAULT 'T',
  `H4D40` char(1) NOT NULL DEFAULT 'T',
  `H4D50` char(1) NOT NULL DEFAULT 'T',
  `H4D60` char(1) NOT NULL DEFAULT 'T',
  `H4D70` char(1) NOT NULL DEFAULT 'T',
  `H4D80` char(1) NOT NULL DEFAULT 'T',
  `h4D90` char(1) NOT NULL DEFAULT 'T',
  `H4E00` char(1) NOT NULL DEFAULT 'T',
  `H4E10` char(1) NOT NULL DEFAULT 'T',
  `H4E20` char(1) NOT NULL DEFAULT 'T',
  `H4E30` char(1) NOT NULL DEFAULT 'T',
  `H4E40` char(1) NOT NULL DEFAULT 'T',
  `H4E50` char(1) NOT NULL DEFAULT 'T',
  `H1370` char(1) NOT NULL DEFAULT 'T',
  `H1380` char(1) NOT NULL DEFAULT 'T',
  `H1390` char(1) NOT NULL DEFAULT 'T',
  `H13A0` char(1) NOT NULL DEFAULT 'T',
  `H13B0` char(1) NOT NULL DEFAULT 'T',
  `H43W0` char(1) NOT NULL DEFAULT 'F',
  `H2106` char(1) NOT NULL DEFAULT 'T',
  `H2205` char(1) NOT NULL DEFAULT 'T',
  `H2306` char(1) NOT NULL DEFAULT 'T',
  `H2405` char(1) NOT NULL DEFAULT 'T',
  `H2505` char(1) NOT NULL DEFAULT 'T',
  `H2605` char(1) NOT NULL DEFAULT 'T',
  `H2705` char(1) NOT NULL DEFAULT 'T',
  `H2825` char(1) NOT NULL DEFAULT 'T',
  `H2835` char(1) NOT NULL DEFAULT 'T',
  `H2845` char(1) NOT NULL DEFAULT 'T',
  `H2856` char(1) NOT NULL DEFAULT 'T',
  `H2867` char(1) NOT NULL DEFAULT 'T',
  `H287A` char(1) NOT NULL DEFAULT 'T',
  `H2888` char(1) NOT NULL DEFAULT 'T',
  `H28A5` char(1) NOT NULL DEFAULT 'T',
  `H42A0` char(1) NOT NULL DEFAULT 'T',
  `H3130` char(1) NOT NULL DEFAULT 'T',
  `H2E00` char(1) NOT NULL DEFAULT 'F',
  `H4G00` char(1) NOT NULL DEFAULT 'F',
  `H4H00` char(1) NOT NULL DEFAULT 'T',
  `H1U00` char(1) NOT NULL DEFAULT 'T',
  `H4F00` char(1) NOT NULL DEFAULT 'T',
  `H13C0` char(1) NOT NULL DEFAULT 'T',
  `H2891` char(1) NOT NULL DEFAULT 'T',
  `H2892` char(1) NOT NULL DEFAULT 'T',
  `H2893` char(1) NOT NULL DEFAULT 'T',
  `H2894` char(1) NOT NULL DEFAULT 'T',
  `H2895` char(1) NOT NULL DEFAULT 'T',
  `H2896` char(1) NOT NULL DEFAULT 'T',
  `H2897` char(1) NOT NULL DEFAULT 'T',
  `H2898` char(1) NOT NULL DEFAULT 'T',
  `H2899` char(1) NOT NULL DEFAULT 'T',
  `H289A` char(1) NOT NULL DEFAULT 'T',
  `H289B` char(1) NOT NULL DEFAULT 'T',
  `H289C` char(1) NOT NULL DEFAULT 'T',
  `H289D` char(1) NOT NULL DEFAULT 'T',
  `H13D0` char(1) NOT NULL DEFAULT 'T',
  `H1V00` char(1) NOT NULL DEFAULT 'T',
  `H1Y00` char(1) NOT NULL DEFAULT 'T',
  `H1X00` char(1) NOT NULL DEFAULT 'T',
  `H1361` char(1) NOT NULL DEFAULT 'T',
  `H2F00` char(1) NOT NULL DEFAULT 'T',
  `H2G00` char(1) NOT NULL DEFAULT 'T',
  `H2H00` char(1) NOT NULL DEFAULT 'T',
  `H1R10` char(1) NOT NULL DEFAULT 'T',
  `H1Z00` char(1) NOT NULL DEFAULT 'T',
  `H1Z10` char(1) NOT NULL DEFAULT 'T',
  `H1Z20` char(1) NOT NULL DEFAULT 'T',
  `H1Z30` char(1) NOT NULL DEFAULT 'T',
  `H1Z40` char(1) NOT NULL DEFAULT 'T',
  `H1Z50` char(1) NOT NULL DEFAULT 'T',
  `H3600` char(1) NOT NULL DEFAULT 'F',
  `H2107` char(1) NOT NULL DEFAULT 'F',
  `H2206` char(1) NOT NULL DEFAULT 'F',
  `H2307` char(1) NOT NULL DEFAULT 'F',
  `H2406` char(1) NOT NULL DEFAULT 'F',
  `H2506` char(1) NOT NULL DEFAULT 'F',
  `H2606` char(1) NOT NULL DEFAULT 'F',
  `H2706` char(1) NOT NULL DEFAULT 'F',
  `H2857` char(1) NOT NULL DEFAULT 'F',
  `H2868` char(1) NOT NULL DEFAULT 'F',
  `H287B` char(1) NOT NULL DEFAULT 'F',
  `H2889` char(1) NOT NULL DEFAULT 'F',
  `H5A00` char(1) NOT NULL DEFAULT 'F',
  `H5B00` char(1) NOT NULL DEFAULT 'F',
  `H5C00` char(1) NOT NULL DEFAULT 'F',
  `H1Z60` char(1) NOT NULL DEFAULT 'F',
  `H1Z70` char(1) NOT NULL DEFAULT 'F',
  `H5D00` char(1) NOT NULL DEFAULT 'T',
  `H5E00` char(1) NOT NULL DEFAULT 'T',
  `H5F00` char(1) NOT NULL DEFAULT 'T',
  `H28G0` char(1) NOT NULL DEFAULT 'F',
  `H28G1` char(1) NOT NULL DEFAULT 'F',
  `H28G2` char(1) NOT NULL DEFAULT 'F',
  `H28G3` char(1) NOT NULL DEFAULT 'F',
  `H28G4` char(1) NOT NULL DEFAULT 'F',
  `H28G5` char(1) NOT NULL DEFAULT 'F',
  `H28G6` char(1) NOT NULL DEFAULT 'F',
  `H28G7` char(1) NOT NULL DEFAULT 'F',
  `H2108` char(1) NOT NULL DEFAULT 'T',
  `H2207` char(1) NOT NULL DEFAULT 'T',
  `H2308` char(1) NOT NULL DEFAULT 'T',
  `H2407` char(1) NOT NULL DEFAULT 'T',
  `H2507` char(1) NOT NULL DEFAULT 'T',
  `H2607` char(1) NOT NULL DEFAULT 'T',
  `H2707` char(1) NOT NULL DEFAULT 'T',
  `H2858` char(1) NOT NULL DEFAULT 'T',
  `H2869` char(1) NOT NULL DEFAULT 'T',
  `H287C` char(1) NOT NULL DEFAULT 'T',
  `H288A` char(1) NOT NULL DEFAULT 'T',
  `H28A6` char(1) NOT NULL DEFAULT 'T',
  `H289E` char(1) NOT NULL DEFAULT 'F',
  `H289F` char(1) NOT NULL DEFAULT 'F',
  `H4I00` char(1) NOT NULL DEFAULT 'F',
  PRIMARY KEY (`LEVEL`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userpin2`
--

LOCK TABLES `userpin2` WRITE;
/*!40000 ALTER TABLE `userpin2` DISABLE KEYS */;
INSERT INTO `userpin2` VALUES ('T','T','T','T','T','T','T','T','T','T','T','T','T','F','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','F','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','F','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','F','T','T','T','T','F','T','T','T','T','F','T','T','T','T','T','F','T','T','T','T','F','T','T','T','T','F','T','T','T','T','F','T','T','T','T','T','T','F','T','T','T','T','F','T','T','T','T','F','T','T','T','T','F','T','T','T','T','F','T','T','T','T','T','T','F','T','T','T','T','T','T','T','T','T','F','T','T','T','T','T','T','T','T','T','T','F','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','F','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','F','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','Super','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','F','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','F','F','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','F','F','F','F','F','F','F','F','F','F','F','T','T','T','T','T','T','T','T','T','T','T','T','F','T','T','F','T','T','T','T','T','T','T','T','T','T','T','T','F','F','T'),('T','T','T','T','T','T','T','T','T','T','T','T','T','F','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','F','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','F','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','F','T','T','T','T','F','T','T','T','T','F','T','T','T','T','T','F','T','T','T','T','F','T','T','T','T','F','T','T','T','T','F','T','T','T','T','T','T','F','T','T','T','T','F','T','T','T','T','F','T','T','T','T','F','T','T','T','T','F','T','T','T','T','T','T','F','T','T','T','T','T','T','T','T','T','F','T','T','T','T','T','T','T','T','T','T','F','T','T','T','F','F','T','F','F','T','T','T','T','T','T','T','','T','T','F','T','T','T','T','T','F','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','F','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','F','T','T','T','T','T','T','T','T','F','T','F','F','F','T','T','T','T','T','F','F','','','','','','','','','','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','General','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','F','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','F','F','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','T','T','T','F','F','F','F','F','F','F','F','T','T','T','T','T','T','T','T','T','T','T','T','F','F','F'),('T','T','T','T','T','T','T','T','T','T','T','T','T','F','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','F','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','F','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','F','T','T','T','T','F','T','T','T','T','F','T','T','T','T','T','F','T','T','T','T','F','T','T','T','T','F','T','T','T','T','F','T','T','T','T','T','T','F','T','T','T','T','F','T','T','T','T','F','T','T','T','T','F','T','T','T','T','F','T','T','T','T','T','T','F','T','T','T','T','T','T','T','T','T','F','T','T','T','T','T','T','T','T','T','T','F','T','T','T','T','F','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','F','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','F','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','F','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','Admin','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','F','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','F','F','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','F','F','F','F','F','F','F','F','F','F','F','T','T','T','T','T','T','T','T','T','T','T','T','F','T','T','F','T','T','T','T','T','T','T','T','T','T','T','T','F','F','T'),('F','F','F','F','F','T','T','T','F','F','F','T','T','F','T','F','F','T','T','T','','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','T','T','T','T','','','','','','','','','','','','','','T','T','T','T','T','T','','','','','','','T','T','','','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','F','F','F','F','F','F','T','T','T','T','T','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','','','','T','F','F','F','T','F','F','F','F','F','T','T','F','F','F','F','F','','','T','','F','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','F','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','F','F','T','T','T','T','T','T','T','T','F','F','F','F','F','T','T','T','T','T','T','F','','','','','','','','','','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','Limited','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','F','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','F','F','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','T','T','T','F','F','F','F','F','F','F','F','T','T','T','T','T','T','T','T','T','T','T','T','F','F','F'),('T','F','T','F','T','T','T','T','T','F','T','T','T','F','T','F','F','F','F','F','','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','T','T','T','T','','','','','','','','','','','','','','T','T','T','T','T','T','','','','','','','T','T','','','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','F','T','T','T','T','T','T','T','T','T','T','T','F','F','F','T','F','F','F','F','T','F','F','T','F','F','F','F','F','T','T','T','F','F','T','F','F','F','F','F','T','T','F','F','F','T','T','F','F','T','F','T','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','T','T','T','F','F','F','F','F','F','F','F','F','F','F','','','','T','F','F','F','F','F','F','F','F','F','T','T','F','F','F','F','F','','','F','','F','T','T','T','T','T','T','F','T','T','','F','F','F','F','F','F','F','F','F','F','F','F','T','T','T','T','T','T','F','T','T','T','T','F','F','T','T','F','T','F','T','T','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','F','F','F','F','F','F','F','T','F','F','F','F','T','T','T','F','F','F','F','F','T','F','T','T','T','T','T','T','T','T','T','T','','','','','','','','','','','','','','','','','','','','','','','','','F','F','T','T','T','T','T','T','T','T','F','F','F','F','F','T','T','T','T','T','T','F','','','','','','','','','','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','Standard','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','F','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','F','F','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','T','T','T','F','F','F','F','F','F','F','F','T','T','T','T','T','T','T','T','T','T','T','T','F','F','F'),('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','T','','','','','','','T','T','','','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','F','T','T','T','T','T','T','T','T','T','T','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','F','','','','','','','','','','','','','','','','','','','','','T','T','','','','','','','','','','F','T','T','T','','','','T','T','T','T','','','','','','','','','','','','T','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','T','T','T','T','T','T','T','T','T','T','T','T','T','T','','','','','','','','','','','','','','T','T','T','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','T','T','T','T','T','T','T','T','','','','','','T','T','T','T','T','T','F','','','','','','','','','','','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','Mobile','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','F','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','F','F','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','T','T','T','F','F','F','F','F','F','F','F','T','T','T','T','T','T','T','T','T','T','T','T','F','F','F'),('T','F','T','T','T','T','T','T','T','T','T','T','T','F','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','F','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','F','T','F','T','F','T','T','T','T','T','T','T','F','T','T','T','T','T','F','T','T','T','T','T','T','T','T','F','T','T','T','T','T','F','T','T','T','T','F','T','T','T','T','F','T','T','T','T','F','T','T','T','T','T','T','F','T','T','T','T','F','T','T','T','T','F','T','T','T','T','F','F','F','F','F','F','F','F','T','T','T','T','F','T','T','T','T','T','T','T','T','T','F','T','T','T','T','T','T','T','T','T','T','F','T','F','T','F','F','T','F','F','T','T','T','T','T','T','T','T','T','T','T','F','F','T','T','F','F','T','T','T','T','T','F','F','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','F','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','F','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','Sales','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','F','T','T','T','T','T','T','T','T','T','T','T','F','T','T','T','T','T','F','F','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','F','T','T','T','T','T','T','T','T','T','T','T','T','T','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','T','T','T','F','F','F','F','F','F','F','F','T','T','T','T','T','T','T','T','T','T','T','T','F','F','F'),('T','T','T','T','T','T','T','F','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','F','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','F','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','F','F','F','F','T','F','T','T','T','T','T','T','T','T','T','T','T','F','T','T','T','T','F','F','T','T','T','T','T','F','T','T','T','T','F','T','T','T','T','F','T','T','T','T','F','T','T','T','T','T','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','T','T','T','T','F','T','T','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','T','F','F','F','F','F','F','F','T','T','T','T','T','T','T','T','F','F','T','T','F','F','F','F','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','Purchase','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','F','F','F','F','T','F','F','F','T','T','F','F','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','T','F','T','T','T','T','T','T','T','T','T','T','T','T','T','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','F','T','T','T','F','F','F','F','F','F','F','F','T','T','T','T','T','T','T','T','T','T','T','T','F','F','F');
/*!40000 ALTER TABLE `userpin2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicapacity`
--

DROP TABLE IF EXISTS `vehicapacity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicapacity` (
  `Capacity` varchar(100) NOT NULL DEFAULT '',
  `Desp` varchar(200) NOT NULL DEFAULT '',
  PRIMARY KEY (`Capacity`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicapacity`
--

LOCK TABLES `vehicapacity` WRITE;
/*!40000 ALTER TABLE `vehicapacity` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehicapacity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicles`
--

DROP TABLE IF EXISTS `vehicles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicles` (
  `entryno` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `custcode` varchar(45) NOT NULL,
  `custname` varchar(150) DEFAULT NULL,
  `custic` varchar(150) DEFAULT NULL,
  `gender` varchar(45) DEFAULT NULL,
  `marstatus` varchar(45) DEFAULT NULL,
  `dob` date DEFAULT '0000-00-00',
  `NCD` varchar(45) DEFAULT NULL,
  `com` varchar(45) DEFAULT NULL,
  `carno` varchar(45) DEFAULT NULL,
  `scheme` varchar(45) DEFAULT NULL,
  `make` varchar(45) DEFAULT NULL,
  `model` varchar(45) DEFAULT NULL,
  `chasisno` varchar(45) DEFAULT NULL,
  `yearmade` varchar(45) DEFAULT NULL,
  `oriregdate` date DEFAULT '0000-00-00',
  `capacity` varchar(45) DEFAULT NULL,
  `coveragetype` varchar(45) DEFAULT NULL,
  `excess` varchar(45) DEFAULT NULL,
  `suminsured` varchar(45) DEFAULT NULL,
  `insurance` varchar(150) DEFAULT NULL,
  `premium` varchar(150) DEFAULT NULL,
  `financecom` varchar(150) DEFAULT NULL,
  `commission` varchar(45) DEFAULT NULL,
  `contract` varchar(45) DEFAULT NULL,
  `payment` varchar(45) DEFAULT NULL,
  `custrefer` varchar(45) DEFAULT NULL,
  `voltran` varchar(45) DEFAULT NULL,
  `updated_on` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_on` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` varchar(45) DEFAULT NULL,
  `updated_by` varchar(45) DEFAULT NULL,
  `custadd` varchar(450) DEFAULT NULL,
  `licdate` varchar(45) DEFAULT NULL,
  `inexpdate` date DEFAULT '0000-00-00',
  `engineno` varchar(150) DEFAULT '',
  `add1` varchar(150) DEFAULT '',
  `add2` varchar(150) DEFAULT '',
  `add3` varchar(150) DEFAULT '',
  `add4` varchar(150) DEFAULT '',
  `postalcode` varchar(150) DEFAULT '',
  `email` varchar(150) DEFAULT '',
  `phone` varchar(150) DEFAULT '',
  `hp` varchar(150) DEFAULT '',
  `contactperson` varchar(150) DEFAULT '',
  `honorific` varchar(45) DEFAULT NULL,
  `contact` varchar(150) DEFAULT NULL,
  `regyear` varchar(45) DEFAULT '',
  `lastmileage` double(20,5) NOT NULL DEFAULT '0.00000',
  `lastserdate` date NOT NULL DEFAULT '0000-00-00',
  `nextmileage` double(20,5) NOT NULL DEFAULT '0.00000',
  `nextserdate` varchar(45) NOT NULL DEFAULT '0000-00-00',
  `remark` text,
  `colour` varchar(150) DEFAULT '',
  `memberid` varchar(150) DEFAULT '',
  PRIMARY KEY (`entryno`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicles`
--

LOCK TABLES `vehicles` WRITE;
/*!40000 ALTER TABLE `vehicles` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehicles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicolour`
--

DROP TABLE IF EXISTS `vehicolour`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicolour` (
  `Colour` varchar(100) NOT NULL DEFAULT '',
  `Desp` varchar(200) NOT NULL DEFAULT '',
  PRIMARY KEY (`Colour`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicolour`
--

LOCK TABLES `vehicolour` WRITE;
/*!40000 ALTER TABLE `vehicolour` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehicolour` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehimake`
--

DROP TABLE IF EXISTS `vehimake`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehimake` (
  `Make` varchar(100) NOT NULL DEFAULT '',
  `desp` varchar(200) NOT NULL DEFAULT '',
  PRIMARY KEY (`Make`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehimake`
--

LOCK TABLES `vehimake` WRITE;
/*!40000 ALTER TABLE `vehimake` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehimake` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehimodel`
--

DROP TABLE IF EXISTS `vehimodel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehimodel` (
  `Model` varchar(100) NOT NULL DEFAULT '',
  `desp` varchar(200) DEFAULT '',
  PRIMARY KEY (`Model`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehimodel`
--

LOCK TABLES `vehimodel` WRITE;
/*!40000 ALTER TABLE `vehimodel` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehimodel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `voucher`
--

DROP TABLE IF EXISTS `voucher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `voucher` (
  `voucherID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `voucherNo` varchar(45) DEFAULT NULL,
  `type` varchar(45) DEFAULT NULL,
  `value` double DEFAULT NULL,
  `desp` varchar(450) DEFAULT NULL,
  `used` varchar(45) DEFAULT NULL,
  `invoiceno` varchar(45) DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` varchar(45) DEFAULT NULL,
  `updated_on` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `batch` varchar(45) DEFAULT NULL,
  `used_on` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `order_cl` varchar(45) DEFAULT 'N',
  `custno` varchar(45) DEFAULT '',
  PRIMARY KEY (`voucherID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `voucher`
--

LOCK TABLES `voucher` WRITE;
/*!40000 ALTER TABLE `voucher` DISABLE KEYS */;
/*!40000 ALTER TABLE `voucher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `voucherprefix`
--

DROP TABLE IF EXISTS `voucherprefix`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `voucherprefix` (
  `voucherprefixno` varchar(10) NOT NULL DEFAULT '',
  PRIMARY KEY (`voucherprefixno`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `voucherprefix`
--

LOCK TABLES `voucherprefix` WRITE;
/*!40000 ALTER TABLE `voucherprefix` DISABLE KEYS */;
/*!40000 ALTER TABLE `voucherprefix` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vouchertran`
--

DROP TABLE IF EXISTS `vouchertran`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vouchertran` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `voucherno` varchar(45) DEFAULT '',
  `usagevalue` double(15,5) DEFAULT '0.00000',
  `wos_date` date DEFAULT '0000-00-00',
  `refno` varchar(100) DEFAULT '',
  `type` varchar(45) DEFAULT '',
  `created_by` varchar(45) DEFAULT '',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` varchar(45) DEFAULT '',
  `updated_on` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vouchertran`
--

LOCK TABLES `vouchertran` WRITE;
/*!40000 ALTER TABLE `vouchertran` DISABLE KEYS */;
/*!40000 ALTER TABLE `vouchertran` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vouchertrantemp`
--

DROP TABLE IF EXISTS `vouchertrantemp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vouchertrantemp` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `vouchernofrom` varchar(45) DEFAULT NULL,
  `usagevaluefrom` double(15,5) DEFAULT '0.00000',
  `wos_date` date DEFAULT '0000-00-00',
  `refno` varchar(100) DEFAULT '',
  `type` varchar(45) DEFAULT '',
  `created_by` varchar(45) DEFAULT '',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `approved` varchar(45) DEFAULT '',
  `vouchernoto` varchar(45) DEFAULT '',
  `usagevalueto` varchar(45) DEFAULT '',
  `idfrom` varchar(45) DEFAULT '',
  `idto` varchar(45) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vouchertrantemp`
--

LOCK TABLES `vouchertrantemp` WRITE;
/*!40000 ALTER TABLE `vouchertrantemp` DISABLE KEYS */;
/*!40000 ALTER TABLE `vouchertrantemp` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-08-09 15:36:28
