<cfsetting showdebugoutput="no">
<cfquery name="getsum" datasource="#dts#">
SELECT SUM(amt1_bil) as sumsubtotal FROM ictrantemp where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.uuid)#" />
</cfquery>

<cfoutput>
<input type="hidden" name="hidsubtotal2" id="hidsubtotal2" value="#numberformat(getsum.sumsubtotal,'.__')#" />
</cfoutput>