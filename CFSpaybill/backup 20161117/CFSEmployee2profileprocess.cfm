<cfoutput>
<cfif isdefined('url.type')>
	<cfif url.type eq 'Add'>
    	<cfquery name="checkexistCFS" datasource="#dts#">
        SELECT * FROM cfsempinprofile 
        WHERE icno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.getCFSEmplist2#"> 
        AND profileid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.profileid#">
        </cfquery>
        
        <cfif checkexistCFS.recordcount eq 0>        
            <cfquery name="insertCFS" datasource="#dts#">
            INSERT IGNORE cfsempinprofile
            (
            icno,
            profileid,
            created_by,
            created_on   
            )
            VALUES
            (
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.getCFSEmplist2#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.profileid#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
	        now()
            )
            </cfquery>
        </cfif>
        
        <cflocation url="/CFSpaybill/addCFSEmployee2profile.cfm?id=#url.profileid#">
        
     <cfelseif url.type eq 'Delete'>
        <cfquery name="insertCFS" datasource="#dts#">
        DELETE FROM cfsempinprofile
        WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.id#">
        </cfquery>
        
        <cflocation url="/CFSpaybill/addCFSEmployee2profile.cfm?id=#url.profileid#">
    </cfif>
</cfif>
</cfoutput>