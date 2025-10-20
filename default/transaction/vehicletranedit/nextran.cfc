<cfcomponent>
	<cffunction name="newtran" access="remote" returntype="query">
		<cfargument name="dts" type="string" required="yes">
        <cfargument name="refno" type="string" required="yes">
        <cfargument name="tran" type="string" required="yes">
        <cfargument name="itemno" type="string" required="no">
        <cfquery name="getnewtrancode" datasource="#dts#">
		select max(trancode) as newtrancode
		from ictran
		where refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#"> and type= <cfqueryparam cfsqltype="cf_sql_varchar" value="#tran#">
        </cfquery>
        <cfif getnewtrancode.recordcount eq 0>
            <cfset newtrancode=1>
        <cfelse>
            <cfset newtrancode = val(getnewtrancode.newtrancode)+1>
        </cfif>
<!---         <cfset listtran = "">
        <cfloop from="#newtrancode#" to="1" index="i" step="-1">
        <cfset listtran = listtran&i>
        <cfif listtran neq 1>
        <cfset listtran = listtran&",">
		</cfif>
        </cfloop> --->
        <cfquery name="newtranqy" datasource="#dts#">
        SELECT #newtrancode# as trancode
        union
        SELECT trancode FROM ictran where refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#"> and type= <cfqueryparam cfsqltype="cf_sql_varchar" value="#tran#">
        ORDER BY trancode desc
        </cfquery>
		<cfreturn newtranqy>
	</cffunction>
</cfcomponent>