<cfcomponent>
<cffunction name="custlist" access="remote" returntype="struct">
	<!---<cfset dts=form.dts>--->
    <cfquery name="getdts" datasource="main">
     SELECT userbranch AS dts FROM users WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#GetAuthUser()#">
    </cfquery>
    <cfset dts = trim(getdts.dts)>
	<cfset targetTable=form.targetTable>
	<cfset custno=form.custno>
	<cfquery name="getcustlist" datasource="#dts#">
		SELECT custno
		FROM #targetTable#
		WHERE custno like <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(custno,6)#%"> order by custno desc limit 1
	</cfquery>
	<cfset output=StructNew()>
	<cfset output["recordTotal"]=getcustlist.recordcount>
    <cfset output["lastrecord"]=" "&getcustlist.custno>
	<cfreturn output>
</cffunction>
</cfcomponent>