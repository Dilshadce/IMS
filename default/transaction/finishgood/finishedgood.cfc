<cfcomponent output="false">
	
	<cffunction name="getfinishedgood" access="remote" returntype="any">
		<cfargument name="page" required="yes">
      	<cfargument name="pageSize" required="yes">
    	<cfargument name="gridsortcolumn" required="yes">
	    <cfargument name="gridsortdirection" required="yes">
	    <cfargument name="filtercolumn" required="no" default="">
	    <cfargument name="filter" required="no" default="">
        <cfargument name="dts" required="no" default="">
	    
        <cfset datenow = dateformat(now(),'yyyy-mm-dd') >
	    <cfquery name="selUsers" datasource="#dts#">
			SELECT
				a.id,a.project,a.itemno,a.quantity,a.rcno,a.created_by,a.created_on,b.aitemno
			FROM
				finishedgoodar as a left join (select aitemno,itemno as bitemno from icitem) as b on a.itemno=b.bitemno
           
			<cfif Arguments.filtercolumn NEQ "" AND Arguments.filter NEQ "">
				WHERE #Arguments.filtercolumn# LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#Arguments.filter#%">
			</cfif>
			
			<cfif Arguments.gridsortcolumn NEQ "">
				ORDER BY #Arguments.gridsortcolumn# #Arguments.gridsortdirection#
			</cfif>
		</cfquery>
		
		<cfreturn queryconvertforgrid(selUsers,Arguments.page,Arguments.pagesize)/>
	    
	</cffunction>
	
	<cffunction name="getfinishedgoodColumns" access="remote" returntype="any">
    
		<cfargument name="dts" required="no">
		<cfquery name="selUsers" datasource="#dts#" result="selResult">
			SELECT
				PROJECT,ITEMNO,QUANTITY,RCNO,CREATED_BY,CREATED_ON
			FROM
				finishedgoodar			
		</cfquery>
		
		<cfset selColumns = QueryNew("ColumnName,ColumnID")>
		
		<cfloop list="#selResult.columnList#" index="listIndex">
			<cfset temp = QueryAddRow(selColumns,1)>
			<cfset temp = QuerySetCell(selColumns,"ColumnName","#listIndex#")>
			<cfset temp = QuerySetCell(selColumns,"ColumnID","#Val(selColumns.RecordCount-1)#")>
		</cfloop>
		
		<cfreturn selColumns>
		
	</cffunction>
    
    
    <cffunction name="editfinishedgood" access="remote">
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
                DELETE FROM finishedgoodar
                where 
                id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gridrow.id#">
                </cfquery>
                
                <cfquery datasource="#dts#">
                DELETE FROM finishedgoodothercode
                where 
                fgic in (SELECT id FROM finishedgoodic WHERE arid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gridrow.id#">)
                </cfquery>
                
                <cfquery datasource="#dts#">
                DELETE FROM finishedgoodic
                where 
                arid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gridrow.id#">
                </cfquery>
                
                
               
                
            </cfcase>
        </cfswitch>
    </cffunction>	
  
</cfcomponent>