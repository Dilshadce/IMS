<cfcomponent output="false">
	
	<cffunction name="getictran" access="remote" returntype="any">
		<cfargument name="page" required="yes">
      	<cfargument name="pageSize" required="yes">
    	<cfargument name="gridsortcolumn" required="yes">
	    <cfargument name="gridsortdirection" required="yes">
        <cfargument name="dts" required="no" default="">
        <cfargument name="uuid" required="no" default="">
        <cfargument name="newps" required="no" default="7">
	    <cfset var ps = arguments.pagesize>
	    <cfquery name="itemqry" datasource="#dts#">
			SELECT
				refno,itemno,desp,qtyonhand,qtyactual,qtydiff,location,uuid
			FROM
				locadj
				WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#" >
			<cfif Arguments.gridsortcolumn NEQ "">
				ORDER BY #Arguments.gridsortcolumn# #Arguments.gridsortdirection#
            <cfelse>
			</cfif>
		</cfquery>
		<cfset ps = newps>
		<cfreturn queryconvertforgrid(itemqry,Arguments.page,ps)/>
	    
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
                DELETE FROM locadj
                where 
                uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gridrow.uuid#">
                and
                itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gridrow.itemno#">
                </cfquery>
                

                
            </cfcase>
        </cfswitch>
    </cffunction>	
</cfcomponent>