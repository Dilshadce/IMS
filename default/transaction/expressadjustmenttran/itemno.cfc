<cfcomponent output="false">

	<!--- Lookup used for auto suggest --->
	<cffunction name="findItem" access="remote" returntype="string">
		<cfargument name="search" type="any" required="false" default="">
		<cfargument name="dns" type="any" required="false" default="">
		<!--- Define variables --->
		<cfset var local = {} />
        <cfquery name="local.query" datasource="#dns#" >
        			select concat(itemno,'___',desp) as a from icitem
                    WHERE 
                    itemno like <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.search#%" />
                    order by a desc limit 10
                </cfquery>

<cfreturn valueList(local.query.a)>
	</cffunction>
    
   

</cfcomponent>