<cfset packid = url.packid>
<cfquery name="getPackDetail" datasource="#dts#">
SELECT * FROM PACKLISTBILL WHERE packID = "#packID#"
</cfquery>

<cfoutput>

<cfloop query="getPackDetail">

<cfquery name="updateArtran" datasource="#dts#">
UPDATE artran SET PACKED = "N" WHERE REFNO = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getPackDetail.billrefno#" /> and type = "#getPackDetail.reftype#"
</cfquery>

</cfloop>

<cfquery name="updatePackID" datasource="#dts#">
DELETE FROM PACKLIST WHERE packid = "#packID#"
</cfquery>
<cfquery name="clearpacklistbill" datasource="#dts#">
DELETE FROM PACKLISTBILL WHERE packid = "#packID#"
</cfquery>
</cfoutput>