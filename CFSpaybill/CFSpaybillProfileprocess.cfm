<cfoutput>
  <cfif isdefined('url.type')>
    
    <!---<cfoutput>
    <cfif find("%",form.adminfee) neq 0>
    	<cfset adminfeeamt = replace(form.adminfee,"%","")/100>
    <cfelse>
    	<cfset adminfeeamt = form.adminfee>
    </cfif>
    </cfoutput>--->
    
    <cfif url.type eq "create">
      <cfif StructKeyExists(form,'adminfeecap') >
        <cfset adminFeeCap = 2500>
        <cfelse>
        <cfset adminFeeCap = 0>
      </cfif>
      <cfquery name="checkpaybillprofile" datasource="#dts#">
        SELECT id FROM paybillprofile
        </cfquery>
      <cfset paybillbefore = checkpaybillprofile.recordcount>
      <cftry>
        <cfquery name="insertpaybillprofile" datasource="#dts#">
            INSERT INTO paybillprofile
            (
            custno,
            empno,
            profilename,
            payrate,
            billrate,
            ratetype,
            adminfee,
            startdate,
            completedate,
            created_by,
            created_on,
            adminFeeCap
            )
            VALUES
            (
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custprofile#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.profilename#">,
            <cfif not isNumeric(form.payrate)>0<cfelse><cfqueryparam cfsqltype="cf_sql_double" value="#form.payrate#"></cfif>,
            <cfif not isNumeric(form.billrate)>0.00<cfelse><cfqueryparam cfsqltype="cf_sql_double" value="#form.billrate#"></cfif>,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ratetype#">,
           	<cfif form.adminfee eq ''>0.00<cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="#form.adminfee#"></cfif>,
           	<cfqueryparam cfsqltype="cf_sql_date" value="#form.startdate#">,
            <cfqueryparam cfsqltype="cf_sql_date" value="#form.completedate#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
            now(),
            <cfif adminFeeCap eq ''>0.00<cfelse><cfqueryparam cfsqltype="cf_sql_decimal" value="#adminFeeCap#"></cfif>
            )
            </cfquery>
        <cfcatch>
        	<cfquery name="createtable" datasource="#dts#">
			  DROP TABLE IF  EXISTS `paybillprofile` 
			</cfquery>
			<cfquery name="createtable" datasource="#dts#">
			  CREATE TABLE IF NOT EXISTS `paybillprofile` (
			  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
			  `profilename` varchar(45) DEFAULT '',
			  `custno` varchar(12) DEFAULT '',
			  `empno` varchar(12) DEFAULT '',
			  `payrate` double(15,5) DEFAULT '0.00000',
			  `billrate` double(15,5) DEFAULT '0.00000',
			  `adminfee` varchar(45) DEFAULT '0',
			  `startdate` date DEFAULT '0000-00-00',
			  `completedate` date DEFAULT '0000-00-00',
			  `adminFeeCap` decimal(12,5) DEFAULT '0.00000',
			  `created_by` varchar(45) DEFAULT '',
			  `created_on` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
			  `updated_by` varchar(45) DEFAULT '',
			  `updated_on` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
			  `ratetype` varchar(10) DEFAULT 'mth',
			  PRIMARY KEY (`id`) USING BTREE
			  ) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8
			</cfquery>
      		<cfquery name="createindex" datasource="#dts#">
			  CREATE INDEX search
				ON paybillprofile (custno, empno, created_by,profilename)
			</cfquery>
       		<cfquery name="insertpaybillprofile" datasource="#dts#">
            INSERT INTO paybillprofile
            (
            custno,
            empno,
            profilename,
            payrate,
            billrate,
            ratetype,
            adminfee,
            startdate,
            completedate,
            created_by,
            created_on,
            adminFeeCap
            )
            VALUES
            (
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custprofile#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.profilename#">,
            <cfif not isNumeric(form.payrate)>0<cfelse><cfqueryparam cfsqltype="cf_sql_double" value="#form.payrate#"></cfif>,
            <cfif not isNumeric(form.billrate)>0.00<cfelse><cfqueryparam cfsqltype="cf_sql_double" value="#form.billrate#"></cfif>,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ratetype#">,
           	<cfif form.adminfee eq ''>0.00<cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="#form.adminfee#"></cfif>,
           	<cfqueryparam cfsqltype="cf_sql_date" value="#form.startdate#">,
            <cfqueryparam cfsqltype="cf_sql_date" value="#form.completedate#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
            now(),
            <cfif adminFeeCap eq ''>0.00<cfelse><cfqueryparam cfsqltype="cf_sql_decimal" value="#adminFeeCap#"></cfif>
            )
            </cfquery>
        </cfcatch>
      </cftry>
      <cfquery name="checkpaybillprofile" datasource="#dts#">
        SELECT id FROM paybillprofile
        </cfquery>
      <cfset paybillafter = checkpaybillprofile.recordcount>
      <cfif paybillbefore eq paybillafter>
        <cfquery name="insertpaybillprofile" datasource="#dts#">
            INSERT INTO paybillprofile
            (
            custno,
            empno,
            profilename,
            payrate,
            billrate,
            ratetype,
            adminfee,
            startdate,
            completedate,
            created_by,
            created_on,
            adminFeeCap
            )
            VALUES
            (
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custprofile#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.profilename#">,
            <cfif not isNumeric(form.payrate)>0<cfelse><cfqueryparam cfsqltype="cf_sql_double" value="#form.payrate#"></cfif>,
            <cfif not isNumeric(form.billrate)>0.00<cfelse><cfqueryparam cfsqltype="cf_sql_double" value="#form.billrate#"></cfif>,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ratetype#">,
           	<cfif form.adminfee eq ''>0.00<cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="#form.adminfee#"></cfif>,
           	<cfqueryparam cfsqltype="cf_sql_date" value="#form.startdate#">,
            <cfqueryparam cfsqltype="cf_sql_date" value="#form.completedate#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
            now(),
            <cfif adminFeeCap eq ''>0.00<cfelse><cfqueryparam cfsqltype="cf_sql_decimal" value="#adminFeeCap#"></cfif>
            )
            </cfquery>
        <cfelse>
        	<cfquery name="getlatest" datasource="#dts#">
        		SELECT id FROM paybillprofile 
        		WHERE created_by="#Huserid#"
        		ORDER BY created_on DESC
        	</cfquery>
        <cflocation url = "/CFSpaybill/listCFSprofile.cfm?profileno=#getlatest.id#">
      </cfif>
    </cfif>
    <cfif url.type eq "edit">
      <cfif StructKeyExists(form,'adminfeecap') >
        <cfset adminFeeCap = 2500 >
        <cfelse>
        <cfset adminFeeCap = 0 >
      </cfif>
      <cfquery name="editpaybillprofile" datasource="#dts#">
        UPDATE paybillprofile SET
        custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custprofile#">,
        empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#">,
        profilename = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.profilename#">,
        payrate = <cfif not isNumeric(form.payrate)>0.00<cfelse><cfqueryparam cfsqltype="cf_sql_double" value="#form.payrate#"></cfif>,
        billrate = <cfif not isNumeric(form.billrate)>0.00<cfelse><cfqueryparam cfsqltype="cf_sql_double" value="#form.billrate#"></cfif>,
        adminfee = <cfif form.adminfee eq ''>0.00<cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="#form.adminfee#"></cfif>,
        ratetype = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ratetype#">,
        startdate = <cfqueryparam cfsqltype="cf_sql_date" value="#form.startdate#">,
        completedate = <cfqueryparam cfsqltype="cf_sql_date" value="#form.completedate#">,
        updated_by = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
        adminfeecap = <cfif adminFeeCap eq ''>0.00<cfelse><cfqueryparam cfsqltype="cf_sql_decimal" value="#adminFeeCap#"></cfif>,
        updated_on = now()
        WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.id#">
        </cfquery>
      <cflocation url = "/CFSpaybill/listCFSprofile.cfm">
    </cfif>
    <cfif url.type eq "delete">
      <cfquery name="deletepaybillprofile" datasource="#dts#">
        DELETE FROM paybillprofile
        WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.id#">
        </cfquery>
      <cflocation url = "/CFSpaybill/listCFSprofile.cfm">
    </cfif>
  </cfif>
</cfoutput>