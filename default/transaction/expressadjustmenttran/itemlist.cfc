<cfcomponent output="false">
	
	<cffunction name="getictran" access="remote" returntype="any">
		<cfargument name="page" required="yes">
      	<cfargument name="pageSize" required="yes">
    	<cfargument name="gridsortcolumn" required="yes">
	    <cfargument name="gridsortdirection" required="yes">
        <cfargument name="dts" required="no" default="">
        <cfargument name="refno" required="no" default="">
        <cfargument name="uuid" required="no" default="">
        <cfargument name="type" required="no" default="">
        <cfargument name="newps" required="no" default="7">
	    <cfset var ps = arguments.pagesize>
        <cfif Arguments.type neq "Create">
        
        <cfquery name="itemqry" datasource="#dts#">
			SELECT
				refno,itemno,desp,qtyonhand,qtyactual,qtydiff,location,oarrefno,oairefno,ucost
			FROM
				locadjtran
				WHERE  refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#" >
			<cfif Arguments.gridsortcolumn NEQ "">
				ORDER BY #Arguments.gridsortcolumn# #Arguments.gridsortdirection#
            <cfelse>
			</cfif>
		</cfquery>
        
        <cfelse>
	    <cfquery name="itemqry" datasource="#dts#">
			SELECT
				refno,itemno,desp,qtyonhand,qtyactual,qtydiff,location,uuid,oarrefno,oairefno,ucost
			FROM
				locadjtran_temp
				WHERE  uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#" >
			<cfif Arguments.gridsortcolumn NEQ "">
				ORDER BY #Arguments.gridsortcolumn# #Arguments.gridsortdirection#
            <cfelse>
			</cfif>
		</cfquery>
        </cfif>
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
                DELETE FROM expressadjtrangrd
                where 
                uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gridrow.uuid#">
                and
                itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gridrow.itemno#">
                and
                location = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gridrow.location#">
                </cfquery>
                
                <cfquery datasource="#dts#">
                DELETE FROM ictran
                where type='OAI' and 
                refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gridrow.oairefno#">
                and
                itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gridrow.itemno#">
                and
                location = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gridrow.location#">
                </cfquery>
                
                <cfquery datasource="#dts#">
                DELETE FROM ictran
                where type='OAR' and 
                refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gridrow.oarrefno#">
                and
                itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gridrow.itemno#">
                and
                location = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gridrow.location#">
                </cfquery>
                
                <cfquery datasource="#dts#">
                DELETE FROM igrade
                where type='OAI' and 
                refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gridrow.oairefno#">
                and
                itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gridrow.itemno#">
                and
                location = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gridrow.location#">
                </cfquery>
                
                <cfquery datasource="#dts#">
                DELETE FROM igrade
                where type='OAR' and 
                refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gridrow.oarrefno#">
                and
                itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gridrow.itemno#">
                and
                location = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gridrow.location#">
                </cfquery>
                
                <cfquery datasource="#dts#">
                DELETE FROM locadjtran_temp
                where 
                itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gridrow.itemno#">
                and
                uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gridrow.uuid#">
                
                </cfquery>

                
            </cfcase>
        </cfswitch>
    </cffunction>	
</cfcomponent>