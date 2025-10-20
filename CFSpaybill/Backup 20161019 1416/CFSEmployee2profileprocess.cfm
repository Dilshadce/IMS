<cfoutput>
<cfif isdefined('url.type')>
	<cfif url.type eq 'Add'>
    	<cfquery name="checkexistCFS" datasource="#dts#">
        SELECT * FROM cfsempinprofile 
        WHERE icno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.getCFSEmplist2#"> 
        AND profileid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.id#">
        </cfquery>
        
        <cfif checkexistCFS.recordcount eq 0>        
            <cfquery name="insertCFS" datasource="#dts#">
            INSERT IGNORE cfsempinprofile
            (
            icno,
            profileid    
            )
            VALUES
            (
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.getCFSEmplist2#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.id#">
            )
            </cfquery>
        </cfif>
        
        <cflocation url="/CFSpaybill/addCFSEmployee2profile.cfm?id=#url.id#">
        
     <cfelseif url.type eq 'Delete'>
        <cfquery name="insertCFS" datasource="#dts#">
        DELETE FROM cfsempinprofile
        WHERE
        id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.id#">
        </cfquery>
        
        <cflocation url="/CFSpaybill/addCFSEmployee2profile.cfm?id=#url.id#">
    </cfif>
</cfif>
</cfoutput>