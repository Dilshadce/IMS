<cfif HUserGrpID eq "SUPER" and left(huserid,5) eq "ultra">
<!---ultra user --->
<cfif isdefined('url.comid')>
<cfoutput>
<cfquery name="checkuserlink" datasource="main">
    SELECT linktoams from users where userbranch=<cfqueryparam cfsqltype="cf_sql_char" value="#url.comid#">
</cfquery>
    <cfif checkuserlink.recordcount neq 0>
    <cfquery name="updatemain" datasource="main">
    Update users SET 
    userbranch = <cfqueryparam cfsqltype="cf_sql_char" value="#url.comid#">, 
    userdept = <cfqueryparam cfsqltype="cf_sql_char" value="#url.comid#">,
    linktoams = "#checkuserlink.linktoams#"
    WHERE
    USERID = <cfqueryparam cfsqltype="cf_sql_char" value="#huserid#">
    </cfquery>
    <script type="text/javascript">
	top.location.href=top.location.href;
    </script>
    </cfif>
</cfoutput>
</cfif>
<cfelse>
<!---Not ultra user --->
<cfif isdefined('url.comid')>
<cfquery datasource='main' name="getmulticompany">
	select * from multicomusers where userid='#huserid#' 
</cfquery>
<cfset multicomlist=valuelist(getmulticompany.comlist)>

<cfif ListFindNoCase(multicomlist,'#url.comid#') GT 0>

<cfoutput>
<cfquery name="checkuserlink" datasource="main">
    SELECT linktoams from users where userbranch=<cfqueryparam cfsqltype="cf_sql_char" value="#url.comid#">
</cfquery>
    <cfif checkuserlink.recordcount neq 0>
    <cfquery name="updatemain" datasource="main">
    Update users SET 
    userbranch = <cfqueryparam cfsqltype="cf_sql_char" value="#url.comid#">, 
    userdept = <cfqueryparam cfsqltype="cf_sql_char" value="#url.comid#">,
    linktoams = "#checkuserlink.linktoams#"
    WHERE
    USERID = <cfqueryparam cfsqltype="cf_sql_char" value="#huserid#">
    </cfquery>
    <script type="text/javascript">
	top.location.href='/index.cfm';
    </script>
    </cfif>
</cfoutput>
</cfif>
<cfelse>
<cfabort/>
</cfif>
<!--- --->
</cfif>

