<cfquery name="getsupp" datasource="#dts#">
SELECT custno, arrem1 FROM apvend
</cfquery>

<cfloop query="getsupp">
<cfquery name="updateitem" datasource="#dts#">
UPDATE icitem SET supp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getsupp.custno#"> WHERE remark10 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getsupp.arrem1#">
</cfquery>
</cfloop>