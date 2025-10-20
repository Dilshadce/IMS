<cfcomponent output="false">
	
	<cffunction name="getBatchs" access="remote" returntype="any">
		<cfargument name="page" required="yes">
      	<cfargument name="pageSize" required="yes">
    	<cfargument name="gridsortcolumn" required="yes">
	    <cfargument name="gridsortdirection" required="yes">
	    <cfargument name="filtercolumn" required="no" default="">
	    <cfargument name="filter" required="no" default="">
        <cfargument name="dts" required="no" default="">
	    
	    <cfquery name="selUsers" datasource="#dts#">
			SELECT
				entryno,custcode,custname,custic,custadd,gender,marstatus,DATE_FORMAT(dob,'%d-%m-%Y') as dob, DATE_FORMAT(licdate,'%d-%m-%Y') as licdate, ncd,com,carno,scheme,make,model,chasisno,yearmade,oriregdate,capacity,coveragetype,excess,suminsured,insurance,premium,financecom,commission,contract,payment,custrefer,DATE_FORMAT(inexpdate,'%d-%m-%Y') as inexpdate
			FROM
				vehicles
			<cfif Arguments.filtercolumn NEQ "" AND Arguments.filter NEQ "">
				WHERE #Arguments.filtercolumn# LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="#Arguments.filter#%">
			</cfif>
			
			<cfif Arguments.gridsortcolumn NEQ "">
				ORDER BY #Arguments.gridsortcolumn# #Arguments.gridsortdirection#
			</cfif>
		</cfquery>
		
		<cfreturn queryconvertforgrid(selUsers,Arguments.page,Arguments.pagesize)/>
	    
	</cffunction>
	
	<cffunction name="getBatchColumns" access="remote" returntype="any">
    
		<cfargument name="dts" required="no">
		<cfquery name="selUsers" datasource="#dts#" result="selResult">
			SELECT
				entryno,custcode,custname,custic,custadd,gender,marstatus,DATE_FORMAT(dob,'%d-%m-%Y') as dob, DATE_FORMAT(licdate,'%d-%m-%Y') as licdate, ncd,com,carno,scheme,make,model,chasisno,yearmade,oriregdate,capacity,coveragetype,excess,suminsured,insurance,premium,financecom,commission,contract,payment,custrefer,DATE_FORMAT(inexpdate,'%d-%m-%Y') as inexpdate
			FROM
				vehicles			
		</cfquery>
		
		<cfset selColumns = QueryNew("ColumnName,ColumnID")>
		
		<cfloop list="#selResult.columnList#" index="listIndex">
			<cfset temp = QueryAddRow(selColumns,1)>
			<cfset temp = QuerySetCell(selColumns,"ColumnName","#listIndex#")>
			<cfset temp = QuerySetCell(selColumns,"ColumnID","#Val(selColumns.RecordCount-1)#")>
		</cfloop>
		
		<cfreturn selColumns>
		
	</cffunction>
    
    <cffunction name="editBatch" access="remote">
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
                UPDATE vehicles
                SET #colname# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#value#">
                ,UPDATED_ON = <cfqueryparam cfsqltype="cf_sql_varchar" value="#currentdatetime#">
                ,UPDATED_BY = <cfqueryparam cfsqltype="cf_sql_varchar" value="#HuserID#">
                WHERE entryno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gridrow.entryno#">
                </cfquery>
            </cfcase>
            <!--- Process deletes --->
            <cfcase value="D">
                <!--- Perform actual delete --->
                <cfquery datasource="#dts#">
                DELETE FROM vehicles
                where entryno = #ARGUMENTS.gridrow.entryno#
                </cfquery>
            </cfcase>
        </cfswitch>
    </cffunction>


	
</cfcomponent>