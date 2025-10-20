<cfoutput>
<cfif isdefined('url.type')>
	<cfquery name="createtable" datasource="#dts#">
      CREATE TABLE IF NOT EXISTS `#dts#`.`paybillprofile` (
      `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
      `custno` varchar(12) DEFAULT '',
      `profilename` varchar(45) DEFAULT '0.00000',
      `payrate` double(15,5) DEFAULT '0.00000',
      `billrate` double(15,5) DEFAULT '0.00000',
      `adminfee` double(15,5) DEFAULT '0.00000',
      `created_by` varchar(45) DEFAULT '',
      `created_on` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
      `updated_by` varchar(45) DEFAULT '',
      `updated_on` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
      `ratetype` varchar(10) DEFAULT 'mth',
      PRIMARY KEY (`id`) USING BTREE
      ) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8
    </cfquery>
    
    <!---<cfoutput>
    <cfif find("%",form.adminfee) neq 0>
    	<cfset adminfeeamt = replace(form.adminfee,"%","")/100>
    <cfelse>
    	<cfset adminfeeamt = form.adminfee>
    </cfif>
    </cfoutput>--->

    
	<cfif url.type eq "create">
    	<cfquery name="checkpaybillprofile" datasource="#dts#">
        SELECT id FROM paybillprofile
        </cfquery>
        
        <cfset paybillbefore = checkpaybillprofile.recordcount>
        
        <cftry>
            <cfquery name="insertpaybillprofile" datasource="#dts#">
            INSERT INTO paybillprofile
            (
            custno,
            profilename,
            payrate,
            billrate,
            ratetype,
            adminfee,
            created_by,
            created_on
            )
            VALUES
            (
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custprofile#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.profilename#">,
            <cfqueryparam cfsqltype="cf_sql_double" value="#form.payrate#">,
            <cfqueryparam cfsqltype="cf_sql_double" value="#form.billrate#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ratetype#">,
           	<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.adminfee#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
            now()
            )
            </cfquery>
        <cfcatch>        	
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
            profilename,
            payrate,
            billrate,
            ratetype,
            adminfee,
            created_by,
            created_on
            )
            VALUES
            (
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custprofile#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.profilename#">,
            <cfqueryparam cfsqltype="cf_sql_double" value="#form.payrate#">,
            <cfqueryparam cfsqltype="cf_sql_double" value="#form.billrate#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ratetype#">,
           	<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.adminfee#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
            now()
            )
            </cfquery>
        <cfelse>
        	<script type="text/javascript">
			alert("Success!");
			</script>
            <cflocation url = "/CFSpaybill/listCFSprofile.cfm">
        
        </cfif>
    </cfif>
    <cfif url.type eq "edit">
        
        <cfquery name="editpaybillprofile" datasource="#dts#">
        UPDATE paybillprofile SET
        custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custprofile#">,
        profilename = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.profilename#">,
        payrate = <cfqueryparam cfsqltype="cf_sql_double" value="#form.payrate#">,
        billrate = <cfqueryparam cfsqltype="cf_sql_double" value="#form.billrate#">,
        adminfee = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.adminfee#">,
        ratetype = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ratetype#">,
        updated_by = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
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