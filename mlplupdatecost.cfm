<cfquery name="getitemno" datasource="#dts#">
SELECT itemno FROM ictran WHERE price <> 0 and linecode <> "sv" and type = "RC"
</cfquery>

<cfquery name="getitemlist" datasource="#dts#">
SELECT itemno FROM icitem WHERE itemno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getitemno.itemno)#" separator="," list="yes">) and ucost = 0
</cfquery>

<cfloop query="getitemlist">
<cfquery name="getrcprice" datasource="#dts#">
SELECT price FROM ictran where price <> 0 and linecode <> "sv" and type = "RC" and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemlist.itemno#"> ORDER BY trdatetime desc limit 1
</cfquery>
<cfif getrcprice.recordcount neq 0>
<cfquery name="updateucost" datasource="#dts#">
UPDATE icitem SET ucost = "#getrcprice.price#" WHERE itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemlist.itemno#">
</cfquery>
</cfif>
</cfloop>
