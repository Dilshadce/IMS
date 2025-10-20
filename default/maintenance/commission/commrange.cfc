<cfcomponent output="false">
	
	<cffunction name="getCommRange" access="remote" returntype="any">
		<cfargument name="page" required="yes">
      	<cfargument name="pageSize" required="yes">
    	<cfargument name="gridsortcolumn" required="yes">
	    <cfargument name="gridsortdirection" required="yes">
	    <cfargument name="filter" required="no" default="">
        <cfargument name="dts" required="no" default="">
	    
	    <cfquery name="selUsers" datasource="#dts#">
			SELECT
				*
			FROM
				commrate
			<cfif Arguments.filter NEQ "">
				WHERE commname = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Arguments.filter#">
			</cfif>
			
			<cfif Arguments.gridsortcolumn NEQ "">
				ORDER BY #Arguments.gridsortcolumn# #Arguments.gridsortdirection#
            <cfelse>
                ORDER BY rangeFROM ASC
			</cfif>
		</cfquery>
		
		<cfreturn queryconvertforgrid(selUsers,Arguments.page,Arguments.pagesize)/>
	    
	</cffunction>

     <cffunction name="editCommRange" access="remote">
        <cfargument name="gridaction" type="string" required="yes">
        <cfargument name="gridrow" type="struct" required="yes">
        <cfargument name="gridchanged" type="struct" required="yes">
        <cfargument name="dts" required="no">
		<cfargument name="HuserID" required="no">
        <!--- Local variables --->
        <cfset var colname="">
        <cfset var value="">
		<cfset SetLocale("English (UK)")>
        <!--- Process gridaction --->
        <cfswitch expression="#ARGUMENTS.gridaction#">
            <!--- Process updates --->
            <cfcase value="U">
                <!--- Get column name and value --->
                <cfset colname=StructKeyList(ARGUMENTS.gridchanged)>
                <cfset value=ARGUMENTS.gridchanged[colname]>
   
                
                
                <cfquery datasource="#dts#">
                UPDATE commrate
                SET #colname# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#value#">
                ,UPDATED_ON = now()
                ,UPDATED_BY = <cfqueryparam cfsqltype="cf_sql_varchar" value="#HuserID#">
                WHERE commrateid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gridrow.commrateid#">
                </cfquery>
            </cfcase>
            <!--- Process deletes --->
            <cfcase value="D">
                <!--- Perform actual delete --->
                <cfquery datasource="#dts#">
                DELETE FROM commrate
                where commrateid = "#ARGUMENTS.gridrow.commrateid#"
                </cfquery>
                
            </cfcase>
        </cfswitch>
    </cffunction>
</cfcomponent>