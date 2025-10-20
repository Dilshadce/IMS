<cfoutput>
<cfif isdefined('url.type')>
	<cfif url.type eq "create">
    	<cfquery name="checkpaybillprofile" datasource="#dts#">
        SELECT id FROM paybillprofile
        </cfquery>
        
        <cfset paybillbefore = checkpaybillprofile.recordcount>
        
        <cfquery name="insertpaybillprofile" datasource="#dts#">
        INSERT INTO paybillprofile
        (
        custno,
        profilename,
        payrate,
        billrate,
        adminfee,
        created_by,
        created_on
        )
        VALUES
        (
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custprofile#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.profilename#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.payrate#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billrate#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.adminfee#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
        now()
        )
        </cfquery>
        
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
            adminfee,
            created_by,
            created_on
            )
            VALUES
            (
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custprofile#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.profilename#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.payrate#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billrate#">,
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
        
        <cfquery name="insertpaybillprofile" datasource="#dts#">
        UPDATE paybillprofile SET
        custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custprofile#">,
        profilename = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.profilename#">,
        payrate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.payrate#">,
        billrate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billrate#">,
        adminfee = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.adminfee#">,
        updated_by = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
        updated_on = now()
        WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.id#">
        </cfquery>
        
        <cflocation url = "/CFSpaybill/listCFSprofile.cfm">
    </cfif>
    <cfif url.type eq "delete">
        
        <cfquery name="deletepaybillprofile" datasource="#dts#">
        DELETE paybillprofile
        WHERE
        id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.id#">
        </cfquery>
        
        <cflocation url = "/CFSpaybill/listCFSprofile.cfm">        
        
    </cfif>
</cfif>
</cfoutput>