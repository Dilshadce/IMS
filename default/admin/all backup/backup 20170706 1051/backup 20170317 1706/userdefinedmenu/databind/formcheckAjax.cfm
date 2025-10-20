<cfset msg =''>
<cfsetting showdebugoutput="no">

<cfif url.action eq "add">
	<cfquery name="getinfo" datasource="#dts#">
		SELECT * 
        FROM userpin2 
		WHERE level = '#groupname#';
	</cfquery>

	<cfif getinfo.recordcount neq 0>
		<cfset msg = "The group name: " & "#groupname#" & " already exist!">
        <cfelse>
        
    <cfquery name="getfields" datasource="#dts#">
		SELECT * 
        FROM userpin;
	</cfquery>

	<cfquery name="insert" datasource="#dts#">
		INSERT into userpin2 
		(level
		<cfloop query="getfields">
			<cfset fieldname = "H"&"#getfields.code#">,#fieldname#
		</cfloop>) 
		values
		('#groupname#'<cfloop query="getfields">,'T'</cfloop>)
	</cfquery>
    <cfset msg = "The group name: " & "#groupname#" & " has been added!">
        
	</cfif>
	
<cfelseif url.action eq "delete">
	<cfif groupname eq "Standard">
		<cfset thisgroupid = "Suser">
	<cfelseif groupname eq "General">	
		<cfset thisgroupid = "guser">
	<cfelseif groupname eq "Limited">	
		<cfset thisgroupid = "luser">
	<cfelseif groupname eq "Mobile">	
		<cfset thisgroupid = "muser">
	<cfelseif groupname eq "Admin">	
		<cfset thisgroupid = "admin">
	<cfelse>	
		<cfset thisgroupid = "#groupname#">
	</cfif>
	
	<cfquery name="getinfo" datasource="main">
		SELECT * 
        FROM users
		WHERE userGrpID = '#thisgroupid#'
		AND userBranch = '#HcomID#'
		LIMIT 1;
	</cfquery>
    
    
	<cfif getinfo.recordcount neq 0>
		<cfset msg = "Cannot Delete! This group : " & "#groupname#" & " is used!">
        <cfelse>
        
        <cfquery name="delete" datasource="#dts#">
            DELETE FROM userpin2 
            WHERE level = '#groupname#';
		</cfquery>

	</cfif>
</cfif>

<cfoutput>
	#msg#
</cfoutput>