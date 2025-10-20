<cfcomponent output="false">
	
	<cffunction name="gethunting" access="remote" returntype="any">
		<cfargument name="page" required="yes">
      	<cfargument name="pageSize" required="yes">
        <cfargument name="gridsortcolumn" required="yes">
	    <cfargument name="gridsortdirection" required="yes">
	    <cfargument name="filtercolumn" required="no" default="">
	    <cfargument name="filter" required="no" default="">
        <cfargument name="dts" required="no" default="">
        <cfargument name="type" required="no" default="">
	    
	    <cfquery name="selUsers" datasource="#dts#">
			SELECT
				*
			FROM
				hunting
                
                WHERE 0=0
			<cfif Arguments.filtercolumn NEQ "" AND Arguments.filter NEQ "">
				AND #Arguments.filtercolumn# LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#Arguments.filter#%">
			</cfif>

		</cfquery>
		
		<cfreturn queryconvertforgrid(selUsers,Arguments.page,Arguments.pagesize)/>
	    
	</cffunction>
    
    
    <cffunction name="gethunting1" access="remote" returntype="any">
		<cfargument name="page" required="yes">
      	<cfargument name="pageSize" required="yes">
        <cfargument name="gridsortcolumn" required="yes">
	    <cfargument name="gridsortdirection" required="yes">
	    <cfargument name="filtercolumn" required="no" default="">
	    <cfargument name="filter" required="no" default="">
        <cfargument name="dts" required="no" default="">
        <cfargument name="type" required="no" default="">
	    <cfargument name="FirstGrid1.selectedIndex" required="no" default="">
	    <cfquery name="selUsers" datasource="#dts#">
			SELECT
				*
			FROM
				hunting
                
                WHERE 0=0
			<cfif Arguments.filtercolumn NEQ "" AND Arguments.filter NEQ "">
				AND #Arguments.filtercolumn# LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#Arguments.filter#%">
			</cfif>

		</cfquery>
		
		<cfreturn queryconvertforgrid(selUsers,Arguments.page,Arguments.pagesize)/>
	    
	</cffunction>
    
	
	<cffunction name="getHuntingColumns" access="remote" returntype="any">
    
		<cfargument name="dts" required="no">
		<cfquery name="selUsers" datasource="#dts#" result="selResult">
			SELECT
				*
			FROM
				hunting			
		</cfquery>
		
		<cfset selColumns = QueryNew("ColumnName,ColumnID")>
		
		<cfloop list="#selResult.columnList#" index="listIndex">
			<cfset temp = QueryAddRow(selColumns,1)>
			<cfset temp = QuerySetCell(selColumns,"ColumnName","#listIndex#")>
			<cfset temp = QuerySetCell(selColumns,"ColumnID","#Val(selColumns.RecordCount-1)#")>
		</cfloop>
		
		<cfreturn selColumns>
		
	</cffunction>
    
    <cffunction name="edithunting" access="remote">
        <cfargument name="gridaction" type="string" required="yes">
        <cfargument name="gridrow" type="struct" required="yes">
        <cfargument name="gridchanged" type="struct" required="yes">
        <cfargument name="dts" required="no">
		<cfargument name="HuserID" required="no">
        <!--- Local variables --->
        <cfset var colname="">
        <cfset var value="">
		<cfset SetLocale("English (UK)")>
		<cfset currentdatetime = '#lsdateformat(now(), "YYYY-MM-DD")# #timeformat(now(), "HH:MM:SS")#'>
        <!--- Process gridaction --->
        <cfswitch expression="#ARGUMENTS.gridaction#">
            <!--- Process updates --->
            <cfcase value="U">
                <!--- Get column name and value --->
                <cfset colname=StructKeyList(ARGUMENTS.gridchanged)>
                <cfset value=ARGUMENTS.gridchanged[colname]>
   
                
                
                <cfquery datasource="#dts#">
                UPDATE hunting
                SET #colname# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#value#">
                WHERE 
                itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gridrow.itemno#"> and
                cate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gridrow.cate#"> and
                owner = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gridrow.owner#"> and
                mill_cert = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gridrow.mill_cert#">
                
                </cfquery>
            </cfcase>
            <!--- Process deletes --->
            <cfcase value="D">
                <!--- Perform actual delete --->
                <cfquery datasource="#dts#">
                DELETE FROM hunting
                where 
                itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gridrow.itemno#"> and
                cate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gridrow.cate#"> and
                owner = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gridrow.owner#"> and
                mill_cert = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gridrow.mill_cert#">
                </cfquery>
                
            </cfcase>
        </cfswitch>
    </cffunction>


	
</cfcomponent>