<cfsetting showdebugoutput="no">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<cfif IsDefined('url.menuID')>
	<cfset URLmenuID = url.menuID>
    <cfelse>
    <cfset URLmenuID = "">
</cfif>


<cfquery name="getlocqdbf" datasource="#dts#">
	SELECT * FROM locqdbf where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemno#">
    order by location
</cfquery>

<cfloop query="getlocqdbf">
<cftry>
<cfquery datasource='#dts#' name="insert">
    UPDATE locqdbf set 

    locqfield="#val(evaluate('form.qtybf_#getlocqdbf.currentrow#'))#"
    where location="#evaluate('form.location_#getlocqdbf.currentrow#')#"
    and itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemno#">
</cfquery>
<cfcatch>
</cfcatch>
</cftry>
</cfloop>



<cfoutput>
<script type="text/javascript">
			alert('Updated #trim(form.itemno)# successfully!');
			window.open('/latest/maintenance/productProfile.cfm?menuID=#URLmenuID#','_self');
</script>
</cfoutput>