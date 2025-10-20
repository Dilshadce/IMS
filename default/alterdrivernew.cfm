<html>
<head></head>
<body>
<cfquery name="getcompany" datasource="main">
	SELECT schema_name as userDept  FROm information_schema.SCHEMATA where schema_name <> "information_schema" and schema_name <> "mysql" and right(schema_name,2) = "_i"
</cfquery>

 <cfloop query="getcompany">
 	<cfoutput>
    #getcompany.userDept#
    </cfoutput>
	<cfset dts=getcompany.userDept>
	
	<cftry>
		<cfquery name="updatetable" datasource="#dts#">
    DROP TABLE IF EXISTS fifoitemstatus
        </cfquery>
        
        <cfquery name="updatetable" datasource="#dts#">
     CREATE TABLE  `fifoitemstatus` (
  `itemno` varchar(100) NOT NULL DEFAULT '',
  `aitemno` varchar(100) DEFAULT '',
  `desp` varchar(450) DEFAULT '',
  `despa` varchar(450) DEFAULT '',
  `unit` varchar(100) DEFAULT '',
  `qtybf` double(17,7) NOT NULL DEFAULT '0.0000000',
  `qin11` double(17,7) NOT NULL DEFAULT '0.0000000',
  `qin12` double(17,7) NOT NULL DEFAULT '0.0000000',
  `qin13` double(17,7) NOT NULL DEFAULT '0.0000000',
  `qin14` double(17,7) NOT NULL DEFAULT '0.0000000',
  `qin15` double(17,7) NOT NULL DEFAULT '0.0000000',
  `qin16` double(17,7) NOT NULL DEFAULT '0.0000000',
  `qin17` double(17,7) NOT NULL DEFAULT '0.0000000',
  `qin18` double(17,7) NOT NULL DEFAULT '0.0000000',
  `qin19` double(17,7) NOT NULL DEFAULT '0.0000000',
  `qin20` double(17,7) NOT NULL DEFAULT '0.0000000',
  `qin21` double(17,7) NOT NULL DEFAULT '0.0000000',
  `qin22` double(17,7) NOT NULL DEFAULT '0.0000000',
  `qin23` double(17,7) NOT NULL DEFAULT '0.0000000',
  `qin24` double(17,7) NOT NULL DEFAULT '0.0000000',
  `qin25` double(17,7) NOT NULL DEFAULT '0.0000000',
  `qin26` double(17,7) NOT NULL DEFAULT '0.0000000',
  `qin27` double(17,7) NOT NULL DEFAULT '0.0000000',
  `qin28` double(17,7) NOT NULL DEFAULT '0.0000000',
  `qout11` double(17,7) NOT NULL DEFAULT '0.0000000',
  `qout12` double(17,7) NOT NULL DEFAULT '0.0000000',
  `qout13` double(17,7) NOT NULL DEFAULT '0.0000000',
  `qout14` double(17,7) NOT NULL DEFAULT '0.0000000',
  `qout15` double(17,7) NOT NULL DEFAULT '0.0000000',
  `qout16` double(17,7) NOT NULL DEFAULT '0.0000000',
  `qout17` double(17,7) NOT NULL DEFAULT '0.0000000',
  `qout18` double(17,7) NOT NULL DEFAULT '0.0000000',
  `qout19` double(17,7) NOT NULL DEFAULT '0.0000000',
  `qout20` double(17,7) NOT NULL DEFAULT '0.0000000',
  `qout21` double(17,7) NOT NULL DEFAULT '0.0000000',
  `qout22` double(17,7) NOT NULL DEFAULT '0.0000000',
  `qout23` double(17,7) NOT NULL DEFAULT '0.0000000',
  `qout24` double(17,7) NOT NULL DEFAULT '0.0000000',
  `qout25` double(17,7) NOT NULL DEFAULT '0.0000000',
  `qout26` double(17,7) NOT NULL DEFAULT '0.0000000',
  `qout27` double(17,7) NOT NULL DEFAULT '0.0000000',
  `qout28` double(17,7) NOT NULL DEFAULT '0.0000000',
  `supp` varchar(100) DEFAULT '',
  `brand` varchar(100) DEFAULT '',
  `category` varchar(100) DEFAULT '',
  `wos_group` varchar(100) DEFAULT '',
  `itemtype` varchar(45) DEFAULT '',
  `uuid` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`itemno`,`uuid`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
        </cfquery>
        <cfoutput>
        #dts#<br/>
        </cfoutput>
	<cfcatch type="any">
		<cfoutput>#cfcatch.Message#:#cfcatch.Detail#</cfoutput><br>	
	</cfcatch>
	</cftry>
</cfloop>
Finish.
</body>
</html>