<cfsetting showdebugoutput="no">
<cfif isdefined('url.refno') and isdefined('url.type') and isdefined('url.trancode')>
<cfset url.refno = URLDECODE(url.refno)>
<cfset url.type = URLDECODE(url.type)>
<cfset url.brem3 = trim(URLDECODE(url.brem3))>


<cfquery name="updatetrancode" datasource="#dts#">
update ictran set brem3="#url.brem3#"
WHERE 
trancode = "#val(url.trancode)#"
and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#">
and type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.type#">
</cfquery>


</cfif>