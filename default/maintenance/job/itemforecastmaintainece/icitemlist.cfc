<cfcomponent output="false">
	
	<cffunction name="geticitemlist" access="remote" returntype="any">
		<cfargument name="page" required="yes">
      	<cfargument name="pageSize" required="yes">
    	<cfargument name="gridsortcolumn" required="yes">
	    <cfargument name="gridsortdirection" required="yes">
	    <cfargument name="filtercolumn" required="no" default="">
	    <cfargument name="filter" required="no" default="">
        <cfargument name="dts" required="no" default="">
        <cfargument name="type" required="no" default="">
	    
        <cfset datenow = dateformat(now(),'yyyy-mm-dd') >
	    <cfquery name="selUsers" datasource="#dts#">
			SELECT
				itemno,desp,created_on,created_by,"Assign item amount for each period" as assign
			FROM
				icitem
                
                WHERE
               0=0
			<cfif Arguments.filtercolumn NEQ "" AND Arguments.filter NEQ "">
				AND #Arguments.filtercolumn# LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#Arguments.filter#%">
			</cfif>
			
			<cfif Arguments.gridsortcolumn NEQ "">
				ORDER BY #Arguments.gridsortcolumn# #Arguments.gridsortdirection#
			</cfif>
		</cfquery>
		
		<cfreturn queryconvertforgrid(selUsers,Arguments.page,Arguments.pagesize)/>
	    
	</cffunction>
	
	<cffunction name="getitemColumns" access="remote" returntype="any">
    
		<cfargument name="dts" required="no">
		<cfquery name="selUsers" datasource="#dts#" result="selResult">
			SELECT
				created_on,created_by,desp,itemno
			FROM
				icitem			
		</cfquery>
		
		<cfset selColumns = QueryNew("ColumnName,ColumnID")>
		
		<cfloop list="#selResult.columnList#" index="listIndex">
			<cfset temp = QueryAddRow(selColumns,1)>
			<cfset temp = QuerySetCell(selColumns,"ColumnName","#listIndex#")>
			<cfset temp = QuerySetCell(selColumns,"ColumnID","#Val(selColumns.RecordCount-1)#")>
		</cfloop>
		
		<cfreturn selColumns>
		
	</cffunction>
    
    <cffunction name="edititem" access="remote">
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
                UPDATE icitem
                SET #colname# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#value#">
                ,UPDATED_ON = <cfqueryparam cfsqltype="cf_sql_varchar" value="#currentdatetime#">
                ,UPDATED_BY = <cfqueryparam cfsqltype="cf_sql_varchar" value="#HuserID#">
                WHERE itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gridrow.itemno#">
                </cfquery>
            </cfcase>
            <!--- Process deletes --->
            <cfcase value="D">
                <!--- Perform actual delete --->
                <cfquery datasource="#dts#">
                DELETE FROM icitem
                where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gridrow.itemno#">
                </cfquery>
                <cfquery datasource="#dts#">
                DELETE FROM icitem
                where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gridrow.itemno#">
                </cfquery>
            </cfcase>
        </cfswitch>
    </cffunction>


	
</cfcomponent>