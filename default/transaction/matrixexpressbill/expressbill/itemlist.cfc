<cfcomponent output="false">
	
	<cffunction name="getictran" access="remote" returntype="any">
		<cfargument name="page" required="yes">
      	<cfargument name="pageSize" required="yes">
    	<cfargument name="gridsortcolumn" required="yes">
	    <cfargument name="gridsortdirection" required="yes">
        <cfargument name="dts" required="no" default="">
        <cfargument name="uuid" required="no" default="">
	    
	    <cfquery name="itemqry" datasource="#dts#">
			SELECT
				trancode,itemno,desp,qty_bil,price_bil,amt_bil,uuid
			FROM
				ictrantemp
				WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#" >
			<cfif Arguments.gridsortcolumn NEQ "">
				ORDER BY #Arguments.gridsortcolumn# #Arguments.gridsortdirection#
			</cfif>
		</cfquery>
		
		<cfreturn queryconvertforgrid(itemqry,Arguments.page,Arguments.pagesize)/>
	    
	</cffunction>
	
    
    <cffunction name="editictran" access="remote">
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
   
                
                
            </cfcase>
            <!--- Process deletes --->
            <cfcase value="D">
                <!--- Perform actual delete --->
                <cfquery datasource="#dts#">
                DELETE FROM ictrantemp
                where 
                uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gridrow.uuid#">
                and
                trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gridrow.trancode#">
                and
                itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gridrow.itemno#">
                </cfquery>
            </cfcase>
        </cfswitch>
    </cffunction>


	
</cfcomponent>