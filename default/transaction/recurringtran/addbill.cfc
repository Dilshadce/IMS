<cfcomponent output="false">
	
	<cffunction name="getBill" access="remote" returntype="any">
		<cfargument name="page" required="yes">
      	<cfargument name="pageSize" required="yes">
    	<cfargument name="gridsortcolumn" required="yes">
	    <cfargument name="gridsortdirection" required="yes">
	    <cfargument name="filtercolumn" required="no" default="">
	    <cfargument name="filter" required="no" default="">
        <cfargument name="dts" required="no" default="">
        <cfargument name="groupid1" required="no" default="">
	    <cfquery name="selUsers" datasource="#dts#">
			SELECT type,a.desp,source,job,concat('R-',refno) as refno,custno,name,wos_date,if(void = "","Y","N") as void,counter,eInvoice_Submited,DATE_FORMAT(b.nextdate,"%d/%m/%Y") AS nextdate  FROM currartran as a left join (select nextdate,groupid from recurrgroup) as b on a.eInvoice_Submited =b.groupid
            WHERE 0 = 0
			<cfif Arguments.filtercolumn NEQ "" AND Arguments.filter NEQ "">
				and #Arguments.filtercolumn# LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="#Arguments.filter#%">
			</cfif>
            <cfif Arguments.groupid1 EQ "ALL" >
            <cfelseif Arguments.groupid1 EQ "">
            and (eInvoice_Submited = "" or eInvoice_Submited is null)
			<cfelse>
			and eInvoice_Submited = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Arguments.groupid1#">
			</cfif>
			<cfif Arguments.gridsortcolumn NEQ "">
				ORDER BY #Arguments.gridsortcolumn# #Arguments.gridsortdirection#
			</cfif>
		</cfquery>
		
		<cfreturn queryconvertforgrid(selUsers,Arguments.page,Arguments.pagesize)/>
	</cffunction>
	
	<cffunction name="getBillColumns" access="remote" returntype="any">
   
		<cfargument name="dts" required="no">
		<cfquery name="selUsers" datasource="#dts#" result="selResult">
			SELECT
				refno,type,custno,name,wos_date
			FROM
				currartran		
		</cfquery>
		
		<cfset selColumns = QueryNew("ColumnName,ColumnID")>
		
		<cfloop list="#selResult.columnList#" index="listIndex">
			<cfset temp = QueryAddRow(selColumns,1)>
			<cfset temp = QuerySetCell(selColumns,"ColumnName","#listIndex#")>
			<cfset temp = QuerySetCell(selColumns,"ColumnID","#Val(selColumns.RecordCount-1)#")>
		</cfloop>
		
		<cfreturn selColumns>
	</cffunction>
    
    <cffunction name="editBill" access="remote">
        <cfargument name="gridaction" type="string" required="yes">
        <cfargument name="gridrow" type="struct" required="yes">
        <cfargument name="gridchanged" type="struct" required="yes">
        <cfargument name="dts" required="no">
		<cfargument name="HuserID" required="no">
        <cfargument name="apvend" required="no">
        <cfargument name="arcust" required="no">
		<cfset var colname="">
		<cfset var value="">
		<cfset SetLocale("English (UK)")>
        
        <cfset refnonew = ARGUMENTS.gridrow.refno>
		<cfset refnolen = len(refnonew)>
        <cfset custnonew = ARGUMENTS.gridrow.custno>
        
        <cfset refnonew = right(refnonew,refnolen - 2)>
        <!--- Local variables --->
        
		
		<cfset currentdatetime = '#lsdateformat(now(), "YYYY-MM-DD")# #timeformat(now(), "HH:MM:SS")#'>
        <!--- Process gridaction --->
        <cfswitch expression="#ARGUMENTS.gridaction#">
            <!--- Process updates --->
            <cfcase value="U">
                <!--- Get column name and value --->
                <cfset colname=StructKeyList(ARGUMENTS.gridchanged)>
                <cfset value=ARGUMENTS.gridchanged[colname]>
                
                <cfif colname eq "custno">
                <cfif ARGUMENTS.gridrow.type eq "rc" or ARGUMENTS.gridrow.type eq "pr" or ARGUMENTS.gridrow.type eq "po">
                <cfquery name="getcustlist" datasource="#dts#">
                SELECT custno,name,name2,add1,add2,add3,add4,attn,daddr1,daddr2,daddr3,daddr4,dattn,contact,phone,dphone,fax,dfax,term,agent,currcode,phonea from #apvend# where custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#value#">
                </cfquery>
                
                <cfelse>
                <cfquery name="getcustlist" datasource="#dts#">
                SELECT custno,name,name2,add1,add2,add3,add4,attn,daddr1,daddr2,daddr3,daddr4,dattn,contact,phone,dphone,fax,dfax ,term,agent,currcode,phonea from #arcust# where custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#value#">
                </cfquery>
                </cfif>
                
                <cfquery name="updateartran" datasource="#dts#">
                Update currartran set 
                rem0 = 'profile', 
                rem2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustlist.attn#">,
                rem4 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustlist.phone#">, 
                frem2 =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustlist.add1#">, 
                frem3 =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustlist.add2#">,
                frem4 =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustlist.add3#">, 
                frem5 =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustlist.add4#">, 
                rem13 = '', 
                frem0 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustlist.name#">, 
                frem1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustlist.name2#">, 
                frem6 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustlist.fax#">,
             	name=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustlist.name#">,	
                phonea=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustlist.phonea#">,
                term=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustlist.term#">,
                agenno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustlist.agent#">,
                currcode=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustlist.currcode#">
                <cfif ARGUMENTS.gridrow.type eq 'PO' or ARGUMENTS.gridrow.type eq 'SO' or ARGUMENTS.gridrow.type eq 'DO' or ARGUMENTS.gridrow.type eq 'INV'>
                , rem1 = 'profile', 
                rem3 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustlist.dattn#">, 
                rem12=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustlist.dphone#">,
      			rem14 = '',
                frem7 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustlist.name#">,
                frem8 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustlist.name2#">,
                comm0=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustlist.daddr1#">, 
                comm1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustlist.daddr2#">, 
                comm2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustlist.daddr3#">,
                comm3=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustlist.daddr4#">, 
                comm4=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustlist.dfax#">
                </cfif>
                WHERE type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gridrow.type#">
                and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refnonew#">
                and custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#custnonew#">
                </cfquery>
                
                <cfquery name="updateictran" datasource="#dts#">
                UPDATE currictran
                SET NAME = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustlist.name#">
                WHERE type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gridrow.type#">
                and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refnonew#">
                and custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#custnonew#">
                </cfquery>
                
				</cfif>
                
                <cfquery datasource="#dts#">
                UPDATE currartran
                <cfif colname neq "void">
                SET #colname# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#value#">
                <cfelse>
                <cfif value eq "Y">
                SET #colname# = ""
                <cfelse>
                SET #colname# = "Y"
				</cfif>
				</cfif>
                ,UPDATED_ON = <cfqueryparam cfsqltype="cf_sql_varchar" value="#currentdatetime#">
                ,UPDATED_BY = <cfqueryparam cfsqltype="cf_sql_varchar" value="#HuserID#">
                WHERE type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gridrow.type#">
                and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refnonew#">
                and custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#custnonew#">
                </cfquery>
                
               
                <cfif colname neq "COUNTER">
                <cfquery datasource="#dts#">
                UPDATE currictran
                <cfif colname neq "void">
                SET #colname# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#value#">
                <cfelse>
                <cfif value eq "Y">
                SET #colname# = ""
                <cfelse>
                SET #colname# = "Y"
				</cfif>
				</cfif>
                WHERE type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gridrow.type#">
                and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refnonew#">
                and custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#custnonew#">
                </cfquery>
                </cfif>
            </cfcase>
            <!--- Process deletes --->
            <cfcase value="D">
                <!--- Perform actual delete --->
                <cfquery datasource="#dts#">
                DELETE FROM currartran
                where type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gridrow.type#">
                and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refnonew#">
                and custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#custnonew#">
                </cfquery>
                
                <cfquery datasource="#dts#">
                DELETE FROM currictran
                where type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gridrow.type#">
                and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refnonew#">
                and custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#custnonew#">
                </cfquery>
            </cfcase>
        </cfswitch>
    </cffunction>


	
</cfcomponent>