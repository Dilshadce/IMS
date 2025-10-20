<cfsetting showdebugoutput="no">
<cfif isdefined('url.status')>
<cfif url.status eq "load">
<cfquery name="updatecolumn" datasource="#dts#">
Update poststatus 
SET
armstatus = "Y",
armedon = now(),
armedby = "#huserid#"
</cfquery>
<cfelseif url.status eq "unload">
<cfquery name="updatecolumn" datasource="#dts#">
Update poststatus 
SET
armstatus = "N",
armedon = now(),
armedby = "#huserid#"
</cfquery>
</cfif>
</cfif>