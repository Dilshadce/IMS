<cfoutput>
<cfquery name="getusers" datasource="main">
SELECT userbranch from users group by userbranch
</cfquery>
<cfloop query="getusers">
<cftry>
<cfquery name="getname" datasource="#getusers.userbranch#">
SELECT COMPRO from gsetup
</cfquery>
<cfset comname= getname.compro>
<cfcatch type="any">
<cfset comname = "">
</cfcatch>
</cftry>
#getusers.userbranch#-#comname#<br/>
</cfloop>
</cfoutput>