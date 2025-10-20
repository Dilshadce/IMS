
<cfquery name="getdata" datasource="#dts#">
SELECT itemno from icitem
</cfquery>
<cfloop query="getdata">
<cftry>
<cfquery name="inserttbl" datasource="#dts#">
INSERT INTO FIFOOPQ (itemno) values (<cfqueryparam cfsqltype="cf_sql_varchar" value="#getdata.itemno#">)
</cfquery>
<cfcatch type="any">
</cfcatch>
</cftry>
</cfloop>