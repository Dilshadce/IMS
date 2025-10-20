<!------------------------------------------------------------------------------
File Name: CFSprocess.cfm
Directory: 
Description: The source code below are the process of create update and delete the CFS record
Last Modified By (Developer Name): Nieo Jie Xiang
Last Modified On (DateTime): 4/10/2016 12:02PM
Copy Rights: Netiquette Software Pte Ltd
--------------------------------------------------------------------------------->
<cfif isdefined('url.type')>
	<cfif url.type eq "create"> 
        <cfquery name="getcfsrecords" datasource="#dts#">
        SELECT icno FROM cfsemp
        </cfquery>
        
        <cfset cfsrecordbefore = getcfsrecords.recordcount>
        
        <cfquery name="insertCFS" datasource="#dts#">
        INSERT INTO cfsemp
        (
        name,
        name2,
        icno,
        add1,
        add2,
        add3,
        phone,
        bankpersonname,
        bankicno,
        bankcompregno,
        banktype,
        bankaccno,
        created_by,
        created_on
        )
        values
        (
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.name#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.name2#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.icno#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.add1#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.add2#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.add3#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.phone#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.bankpersonname#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.bankicno#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.bankcompregno#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.banktype#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.bankaccno#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
        now()
        )
        </cfquery>
        
        <cfquery name="getcfsrecords" datasource="#dts#">
        SELECT icno FROM cfsemp
        </cfquery>
        
        <cfset cfsrecordafter = getcfsrecords.recordcount>
        
        <cfif cfsrecordbefore eq cfsrecordafter>
            <cfquery name="insertCFS" datasource="#dts#">
            INSERT INTO cfsemp
            (
            name,
            name2,
            icno,
            add1,
            add2,
            add3,
            phone,
            bankpersonname,
            bankicno,
            bankcompregno,
            banktype,
            bankaccno,
            created_by,
        	created_on
            )
            values
            (
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.name#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.name2#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.icno#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.add1#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.add2#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.add3#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.phone#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.bankpersonname#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.bankicno#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.bankcompregno#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.banktype#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.bankaccno#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
        	now()
            )
            </cfquery>
        <cfelse>
        
            <cflocation url = "/CFSpaybill/listCFSEmployee.cfm">
        
        </cfif>
    </cfif>
    <cfif url.type eq 'edit'>
    	<cfquery name="insertCFS" datasource="#dts#">
        UPDATE cfsemp SET
        name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.name#">,
        name2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.name2#">,
        icno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.icno#">,
        add1 =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.add1#">,
        add2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.add2#">,
        add3 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.add3#">,
        phone = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.phone#">,
        bankpersonname = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.bankpersonname#">,
        bankicno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.bankicno#">,
        bankcompregno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.bankcompregno#">,
        banktype = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.banktype#">,
        bankaccno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.bankaccno#">,
        updated_by = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
        updated_on = now()
        WHERE
        id = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.id#">
        </cfquery>
        
        <cflocation url = "/CFSpaybill/listCFSEmployee.cfm">
    </cfif>
    <cfif url.type eq 'delete'>
    	<cfquery name="deleteCFS" datasource="#dts#">
        DELETE FROM cfsemp
        WHERE
        id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.id#">
        </cfquery>
        
        <cflocation url = "/CFSpaybill/listCFSEmployee.cfm">
    </cfif>
</cfif>


