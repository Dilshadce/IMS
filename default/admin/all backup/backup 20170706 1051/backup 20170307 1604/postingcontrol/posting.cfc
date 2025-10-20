<cfcomponent output="false">
	
	<cffunction name="getlog" access="remote" returntype="any">
		<cfargument name="page" required="yes">
      	<cfargument name="pageSize" required="yes">
    	<cfargument name="gridsortcolumn" required="yes">
	    <cfargument name="gridsortdirection" required="yes">
	  	<cfargument name="filtercolumn" required="no" default="">
	    <cfargument name="filter" required="no" default="">
        <cfargument name="dts" required="no" default="">

	    <cfquery name="getlog" datasource="#dts#">
		SELECT action,billtype,actiondata,user,timeaccess FROM postlog WHERE 0=0
        <cfif Arguments.filtercolumn NEQ "" AND Arguments.filter NEQ "">
				and #Arguments.filtercolumn# LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="#Arguments.filter#%">
			</cfif>
            and user not like 'ultra%'
			<cfif Arguments.gridsortcolumn NEQ "">
				ORDER BY #Arguments.gridsortcolumn# #Arguments.gridsortdirection#
            <cfelse>
            	ORDER BY timeaccess DESC 
			</cfif>
		</cfquery>
		
		<cfreturn queryconvertforgrid(getlog,Arguments.page,Arguments.pagesize)/>
	</cffunction>

<cffunction name="getlogColumns" access="remote" returntype="any">
    
		<cfargument name="dts" required="no">
		<cfquery name="selUsers" datasource="#dts#" result="selResult">
			SELECT action,billtype,actiondata,user,timeaccess FROM postlog
		</cfquery>
		
		<cfset selColumns = QueryNew("ColumnName,ColumnID")>
		
		<cfloop list="#selResult.columnList#" index="listIndex">
			<cfset temp = QueryAddRow(selColumns,1)>
			<cfset temp = QuerySetCell(selColumns,"ColumnName","#listIndex#")>
			<cfset temp = QuerySetCell(selColumns,"ColumnID","#Val(selColumns.RecordCount-1)#")>
		</cfloop>
		
		<cfreturn selColumns>
		
	</cffunction>	
	
</cfcomponent>

