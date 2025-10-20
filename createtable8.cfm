<cfoutput>

<!--- <cfloop list="weikeninv_c,weikenint_c,weikenbuilder_c,futurehome_c,weikenid_c,weikendecor_c" index="a">
</cfloop> --->




<!--- <cfquery name="ff" datasource="main">
select * from users where userbranch = 'weikenid_i'
</cfquery>

<cfloop query="ff">
<cfquery name="ff" datasource="ssmain">
UPDATE users set password = '#USERPWD#' WHERE userdsn = 'weikenid_c' and username = '#USERID#'
</cfquery>


<cfquery name="ff" datasource="#dts#">
UPDATE security set password = '#USERPWD#' WHERE username = '#USERID#'
</cfquery>

</cfloop> --->


<cfquery name="get" datasource="#dts#">
select * from intune_ava
</cfquery>

<cfdump var="#get#">

<!--- <cfquery name="gg" datasource="ssmain">
select * from users where userdsn = 'weikenid_c'
</cfquery>
<cfdump var="#gg#">

<cfquery name="gg" datasource="#dts#">
select * from srf
</cfquery>
<cfdump var="#gg#">

<cfquery name="gg" datasource="#dts#">
select * from security
</cfquery>
<cfdump var="#gg#">

<cfquery name="gg" datasource="#dts#">
select * from securitylink
</cfquery>
<cfdump var="#gg#"> --->


 <!--- <cfset dd = createdatetime(2012,07,05,13,22,30)>
 <cfloop index="a"
 from="1" to="80" step="2">
<cfquery name="g" datasource="ssmain">
insert into userslog 

(
userlogip,userlogtime,status,comid,username 
)
VALUES
(
'219.92.85.30','#dateformat(dateadd('d',a,dd),'yyyy-mm-dd hh:mm:ss')#','Success','supervalu','adminsupervalu'
)
</cfquery> 

</cfloop> 

<cfquery name="g" datasource="#dts#">
UPdate lead SET
created_on = '2012-01-11'
where id = '28'
</cfquery> --->
<!--- <cfquery name="g" datasource="#dts#">
CREATE TABLE `crossreference` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `a_product` varchar(250) DEFAULT '',
  `finisar_pn` varchar(250) DEFAULT '',
  `competition_pn1` varchar(250) DEFAULT NULL,
  `brand1` varchar(250) DEFAULT NULL,
  `testing_result1` varchar(250) DEFAULT NULL,
  `equipment_tested1` varchar(250) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` varchar(45) DEFAULT '',
  `updated_on` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by` varchar(45) DEFAULT '',
  `reg` varchar(250) DEFAULT '',
  `no` varchar(250) DEFAULT '',
  `equipment_tested10` varchar(250) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=20000001 DEFAULT CHARSET=utf8;
</cfquery> --->
<!--- <cfinclude template="/CFC/convert_single_double_quote_script2.cfm"> --->
<!--- <cfquery name="ab" datasource="#dts#">
SELECT * FROM pp06

</cfquery> --->
<!--- <cfquery name="ee" datasource="#dts#">
select * FROM artran WHERE refno = 'RM131003'

</cfquery> --->

<!--- <cfquery name="u" datasource="#dts#">
UPDATE ictran SET
itemcount = '11', trancode = '11'
WHERE refno = 'rm131003' and itemno = '850205005'
</cfquery> --->

<!--- <cfquery name="ee2" datasource="#dts#">
ALTER TABLE `thats_c`.`member` ADD COLUMN `signature` VARCHAR(45) DEFAULT '';


</cfquery> --->



<!--- 
<cfquery name="ee2" datasource="#dts#">
UPDATE barrel_parameter SET 
customer = '50'
WHERE customer between '51' and '70'

</cfquery>
<cfquery name="ee2" datasource="#dts#">
UPDATE barrel_parameter SET 
customer = '235'
WHERE customer between '236' and '249'

</cfquery>
<cfquery name="ee2" datasource="#dts#">
UPDATE barrel_parameter SET 
customer = '273'
WHERE customer between '274' and '277'

</cfquery>

 <cfloop query="ee2">

#ee2.id# - #ee2.customer# <br />

</cfloop>  --->
 <!---<cfloop query="ab">
<cfloop query="abc">#evaluate('ab.#abc.field#')# - </cfloop><br />
</cfloop> --->
<!--- <cfquery name="ab" datasource="#dts#">
insert into submenu 
(submenu,menuid,accesslist,url)
VALUES
('Quotation','19','SupportB, AgentB, MySupport, MyAgent, Telemarketer, Support, Agent, Administrator,','/default/transaction/transaction.cfm?tran=quo')

</cfquery>

<cfquery name="a" datasource="#dts#">
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
  `AGENNO` varchar(66) DEFAULT '',
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
  `toprc` varchar(100) DEFAULT '',
  PRIMARY KEY (`TYPE`,`REFNO`,`CUSTNO`,`WOS_DATE`),
  KEY `TRANSACTION` (`TYPE`,`REFNO`,`CUSTNO`,`FPERIOD`,`WOS_DATE`,`AGENNO`,`NET`,`TOINV`,`VOID`) USING BTREE,
  KEY `CUSTREPORT` (`CUSTNO`,`TYPE`,`REFNO`,`FPERIOD`,`WOS_DATE`,`AGENNO`,`AREA`,`SOURCE`,`NET`,`TOINV`,`ORDER_CL`,`VOID`) USING BTREE,
  KEY `AGENTREPORT` (`AGENNO`,`TYPE`,`REFNO`,`CUSTNO`,`FPERIOD`,`WOS_DATE`,`AREA`,`SOURCE`,`NET`,`TOINV`,`VOID`,`NAME`) USING BTREE,
  KEY `ENDUSERREPORT` (`VAN`,`TYPE`,`REFNO`,`CUSTNO`,`FPERIOD`,`WOS_DATE`,`AGENNO`,`AREA`,`SOURCE`,`NET`,`TOINV`,`VOID`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
</cfquery>


<cfquery name="b" datasource="empty_c">
CREATE TABLE `ictran` (
  `TYPE` varchar(4) NOT NULL DEFAULT '',
  `REFNO` varchar(50) NOT NULL DEFAULT '',
  `REFNO2` varchar(24) DEFAULT NULL,
  `TRANCODE` int(4) NOT NULL DEFAULT '0',
  `CUSTNO` varchar(12) NOT NULL DEFAULT '',
  `FPERIOD` varchar(2) DEFAULT '0',
  `WOS_DATE` date NOT NULL DEFAULT '0000-00-00',
  `CURRRATE` double(16,10) NOT NULL DEFAULT '0.0000000000',
  `ITEMCOUNT` int(4) unsigned NOT NULL DEFAULT '0',
  `LINECODE` varchar(2) DEFAULT NULL,
  `ITEMNO` varchar(54) NOT NULL DEFAULT '',
  `DESP` varchar(450) DEFAULT NULL,
  `DESPA` varchar(450) DEFAULT NULL,
  `AGENNO` varchar(53) DEFAULT '',
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
  `toprc` varchar(45) DEFAULT '',
  `brem5` varchar(250) DEFAULT '',
  `brem6` varchar(250) DEFAULT '',
  `brem7` varchar(250) DEFAULT '',
  `brem8` varchar(250) DEFAULT '',
  `brem9` varchar(250) DEFAULT '',
  PRIMARY KEY (`TYPE`,`REFNO`,`CUSTNO`,`TRANCODE`,`ITEMCOUNT`,`ITEMNO`,`WOS_DATE`),
  KEY `COSTING` (`ITEMNO`,`TYPE`,`REFNO`,`TRANCODE`,`QTY`,`AMT`,`IT_COS`,`TOINV`,`VOID`),
  KEY `ASSMITEM` (`ITEMNO`,`TYPE`,`REFNO`,`FPERIOD`,`WOS_DATE`,`LOCATION`,`SOURCE`,`QTY`,`AMT`,`IT_COS`,`VOID`,`AREA`,`SHELF`,`BOMNO`) USING BTREE,
  KEY `BATCHITEM` (`ITEMNO`,`TYPE`,`REFNO`,`CUSTNO`,`FPERIOD`,`WOS_DATE`,`AGENNO`,`LOCATION`,`QTY`,`AMT`,`BATCHCODE`,`EXPDATE`,`TOINV`,`AREA`) USING BTREE,
  KEY `ITEMREPORT` (`ITEMNO`,`TYPE`,`FPERIOD`,`WOS_DATE`,`AGENNO`,`LOCATION`,`SOURCE`,`QTY`,`AMT`,`IT_COS`,`AREA`,`SHELF`,`SHIPPED`,`TOINV`) USING BTREE,
  KEY `CUSTREPORT` (`CUSTNO`,`TYPE`,`ITEMNO`,`FPERIOD`,`WOS_DATE`,`AGENNO`,`LOCATION`,`SOURCE`,`QTY`,`AMT`,`IT_COS`,`SHIPPED`,`TOINV`,`AREA`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
</cfquery>


<cfquery name="c" datasource="empty_c">
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
</cfquery> --->

<!---  <!--- <cfquery datasource="ssmain" name="abc">

delete  from userslog where comid = 'drled' and logid = '34552' and userlogtime = '2013-01-30 09:02:49.0'
    </cfquery>
    
   <cfquery datasource="ssmain" name="abc">

select * from userslog where comid = 'drled'
    </cfquery>  
<cfloop query="abc">
 1 - #abc.logid# - #abc.userlogtime# - #abc.status# - #abc.username#<br />

</cfloop> --->
<!--- <cfquery name="abc" datasource="#dts#">
SELECT * FROM serviceproduct
</cfquery>  
 <cfloop query="getmenu1">
 #getmenu1.link_url# <br />


</cfloop>--->
<!--- <cfloop query="abc">
 1 - #abc.report_no# - #abc.companyno# - <br />


</cfloop> --->
<!---  <cfquery name="ab" datasource="#dts#">
ALTER TABLE `rmaproduct` ADD COLUMN `report_no` VARCHAR(45) DEFAULT '';

</cfquery>   

 ---> 


<!--- <cfquery name="ab" datasource="#dts#">
ALTER TABLE `electroplating` 
ADD COLUMN `refno` VARCHAR(45) DEFAULT '';



</cfquery> --->

 <cfquery name="ab" datasource="#imsdts#">
delete from ictran
</cfquery>  

 <cfquery name="ab" datasource="#dts#">
delete from lead
</cfquery>


 <cfquery name="getcompany" datasource="#dts#">
delete from #target_arcust#
</cfquery>
 
 <cfquery name="getcompany" datasource="#dts#">
delete from artran

</cfquery>
 
 <cfquery name="getcompany" datasource="#dts#">
delete from ictran

</cfquery>
 
 <cfquery name="getcompany" datasource="#dts#">
delete from electroplating

</cfquery>


 <cfquery name="getcompany" datasource="#dts#">
delete from qa08

</cfquery>

 <cfquery name="getcompany" datasource="#dts#">
delete from ss12

</cfquery>

 <cfquery name="getcompany" datasource="#dts#">
delete from barrel_parameter

</cfquery>

<cfquery name="getcompany" datasource="#dts#">
delete from pp08

</cfquery>


<!--- <cfquery name="getcompany" datasource="#dts#">
delete from lead
</cfquery> --->

<cfquery name="getcompany" datasource="#imsdts#">
delete from artran

</cfquery>
 
 <cfquery name="getcompany" datasource="#imsdts#">
delete from ictran
</cfquery> 

<!---   <cfloop query="getCompany" --->>
<cfquery name="ab" datasource="#dts#">
INSERT INTO useraccountlimit 
(companyid,usercount)
VALUES
('#getCompany.userdsn#','3')
</cfquery> 
</cfloop>
<cfloop query="ab">
#ab.submenu# - #ab.id#  <br />
</cfloop>
<cfloop query="ab2">
#ab2.agent# - #ab2.agentid# - #ab2.name#<br />
</cfloop>
 <cfquery name="ab" datasource="#imsDTS#">
SELECT * FROM icitem WHERE created_by = 'netivanasaiki'
</cfquery>
 
 --->
 <!--- <cfloop list="387,389,392,393,394" index="f"> --->


<!--- <cfloop query="ab">
 #ab.customer# -#ab.id# - #ab.leadname#<br /></cfloop> --->
<!--- <cfquery name="abd" datasource="#dts#">
UPDATE qa08 set CUST = '3000I001' where CUST in ('353','345')
</cfquery>
<cfquery name="abdd" datasource="#dts#">
UPDATE qa08 set CUST = '3000A015' where CUST in ('352')
</cfquery>
<cfquery name="abddd" datasource="#dts#">
UPDATE qa08 set CUST = '3000F001' where CUST in ('3000F002' ,
'3000F003',
'3000F004', 
'3000F005', 
'3000F006')
</cfquery>
 --->
<!--- <cfquery name="abdddd" datasource="#dts#">
UPDATE qa08 set CUST = '3000M003' where CUST in ('3000M005')
</cfquery> --->
<!---  <cfquery name="abcd" datasource="#dts#">
UPDATE lead SET  
leadname = '#ab.name#'
<cfif ab.add1 eq '' and ab.daddr1 eq ''>
,
add1 = '#ab.add1#', 
add2 = '#ab.add2#', 
add3 = '#ab.add3#', 
daddr1 = '#ab.daddr1#', 
daddr2 = '#ab.daddr2#', 
daddr3 = '#ab.daddr3#'
</cfif>
WHERE accountno ='#ab.custno#'
</cfquery>
<cfquery name="abcde" datasource="#dts#">
UPDATE artran set NAME = '#ab.name#' WHERE custno ='#ab.custno#'
</cfquery> 
--->
<!--- <cfquery name="abcf" datasource="#dts#">
UPDATE QA08 set CUST = '3000A015' WHERE cust ='A3800001'
</cfquery> ---> 

</cfoutput>
