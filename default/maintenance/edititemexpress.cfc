<cfcomponent output="false">
	
        
	<cffunction name="getitem" access="remote" returntype="any">
		<cfargument name="page" required="yes">
      		<cfargument name="pageSize" required="yes">
    		<cfargument name="gridsortcolumn" required="yes">
		<cfargument name="gridsortdirection" required="yes">
        <cfargument name="filtercolumn" required="no" default="">
	    <cfargument name="filter" required="no" default="">
      		<cfargument name="dts" required="no" default="">
	        <cfargument name="uuid" required="no" default="">
        
        	<cfquery name="setCounter" datasource="#dts#">
	        set @counter = 0;

	        </cfquery>

		<cfquery name="getitem" datasource="#dts#">

			select a.itemno<!---,b.lastcost--->,desp,ucost,price,price2,price3,supp,price4,category,wos_group,custprice_rate,brand,remark1,remark2,costcode,remark3,remark4,colorid,sizeid,aitemno,barcode
			from icitem as a
            <!---left join
            (select price as lastcost,itemno from ictran where type='RC' and price<>0 group by itemno order by wos_date desc limit 1)as b on a.itemno=b.itemno--->
            <cfif Arguments.filtercolumn NEQ "" AND Arguments.filter NEQ "">
				WHERE #Arguments.filtercolumn# LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#Arguments.filter#%">
                <cfif Arguments.filtercolumn eq 'sizeid'>or remark1 like <cfqueryparam cfsqltype="cf_sql_varchar" value="#Arguments.filter#%"></cfif>
			</cfif>
			
			<cfif Arguments.gridsortcolumn NEQ "">
				ORDER BY #Arguments.gridsortcolumn# #Arguments.gridsortdirection#
            <cfelse>
            order by itemno;
			</cfif>

		</cfquery>
	   
		
		<cfreturn queryconvertforgrid(getitem,Arguments.page,Arguments.pagesize)/>
	    
	</cffunction>
    
	<cffunction name="editItemOP" access="remote">
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
                	<!--- Perform actual update --->
                    
                    <cfif colname eq 'ucost'>
					
                    <cftry>
					<cfset cost1=listgetat(value,1,'.')>
                    <cfset cost2=listgetat(value,2,'.')>
                    <cfcatch>
                    
                    <cfset cost1=value>
                    <cfset cost2=''>
                    </cfcatch></cftry>
                    
                    <cfquery name="getformula" datasource="#dts#">
                    SELECT * from gsetup
                    </cfquery>
                    <cfset itemnumber = arraynew(1)>
                    <cfset itemnumber[1]=left(getformula.costformula1,1)>
                    <cfset itemnumber[2]=mid(getformula.costformula1,2,1)>
                    <cfset itemnumber[3]=mid(getformula.costformula1,3,1)>
                    <cfset itemnumber[4]=mid(getformula.costformula1,4,1)>
                    <cfset itemnumber[5]=mid(getformula.costformula1,5,1)>
                    <cfset itemnumber[6]=mid(getformula.costformula1,6,1)>
                    <cfset itemnumber[7]=mid(getformula.costformula1,7,1)>
                    <cfset itemnumber[8]=mid(getformula.costformula1,8,1)>
                    <cfset itemnumber[9]=mid(getformula.costformula1,9,1)>
                    <cfset itemnumber[10]=mid(getformula.costformula1,10,1)>
            
                    <cfloop from="1" to="9" index="i">
                    <cfset cost1=replace(cost1,i,itemnumber[i],"All")>
                    </cfloop>
                    
                    <cfset itemnumber2 = arraynew(1)>
                    <cfset itemnumber2[1]=left(getformula.costformula3,1)>
                    <cfset itemnumber2[2]=mid(getformula.costformula3,2,1)>
                    <cfset itemnumber2[3]=mid(getformula.costformula3,3,1)>
                    <cfset itemnumber2[4]=mid(getformula.costformula3,4,1)>
                    <cfset itemnumber2[5]=mid(getformula.costformula3,5,1)>
                    <cfset itemnumber2[6]=mid(getformula.costformula3,6,1)>
                    <cfset itemnumber2[7]=mid(getformula.costformula3,7,1)>
                    <cfset itemnumber2[8]=mid(getformula.costformula3,8,1)>
                    <cfset itemnumber2[9]=mid(getformula.costformula3,9,1)>
                    <cfset itemnumber2[10]=mid(getformula.costformula3,10,1)>
                    
                    <cfloop from="1" to="9" index="i">
                    <cfset cost2=replace(cost2,i,itemnumber2[i],"All")>
                    </cfloop>
                    
                    <cfif cost2 eq ''>
                    <cfset myResult=replace(cost1,'0',itemnumber[10],"All")&getformula.costformula2>
                    <cfelse>
                    <cfset myResult=replace(cost1,'0',itemnumber[10],"All")&getformula.costformula2&replace(cost2,'0',itemnumber2[10],"All")>
                    </cfif>
					
					</cfif>
                    
                    
	                 <cfquery datasource="#dts#">
        	        UPDATE icitem
                	SET #colname# = 
	                <cfif colname eq 'SUPP'><cfqueryparam cfsqltype="cf_sql_varchar" value="#listgetat(value,1,'-')#"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="#value#"></cfif>
                    <cfif colname eq 'ucost'>,costformula=<cfqueryparam cfsqltype="cf_sql_varchar" value="#myResult#"></cfif>
        	        	WHERE itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gridrow.itemno#">
                	</cfquery>
                   </cfcase>
            
                   <!--- Process deletes --->
	           <cfcase value="D">
        	        <!--- Perform actual delete --->
                	<cfquery datasource="#dts#">
		                DELETE FROM icitem
        	        	where itemno = #ARGUMENTS.gridrow.itemno#
                	</cfquery>
        	  </cfcase>
        	</cfswitch>
	</cffunction>   
	
</cfcomponent>

