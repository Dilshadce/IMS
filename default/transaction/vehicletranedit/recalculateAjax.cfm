<cfsetting showdebugoutput="no">
<cfquery name="getsum" datasource="#dts#">
SELECT SUM(amt1_bil) as sumsubtotal,count(trancode) as notran FROM ictran where refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.refno)#" /> and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.tran)#" />
</cfquery>

<cfoutput>
<input type="hidden" name="hidsubtotal" id="hidsubtotal" value="#numberformat(getsum.sumsubtotal,'.__')#" />
<input type="hidden" name="hiditemcount" id="hiditemcount" value="#getsum.notran#" />
</cfoutput>