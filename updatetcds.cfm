<cfsetting showdebugoutput="no">
<cfquery name="getitem" datasource="#dts#">
select  * from tcdsmemberhistory where (desp = "" or desp is null) group by itemno
</cfquery>
<cfquery name="getallitem" datasource="#dts#">
SELECT desp,sizeid,barcode FROM icitem WHERE (barcode <> "" and barcode is not null)
and barcode in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getitem.itemno)#" list="yes" separator=",">)
</cfquery>
<cfloop query="getallitem">
<cfquery name="updateitem" datasource="#dts#">
UPDATE tcdsmemberhistory SET desp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getallitem.desp#">, sizeid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getallitem.sizeid#"> WHERE itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getallitem.barcode#"> and (desp = "" or desp is null)
</cfquery>
</cfloop>
