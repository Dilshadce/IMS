<cfcomponent>
    <cffunction name="listDetails" access="remote" returntype="struct"> 
        <!---<cfset dts=form.dts>--->
        <!---<cfquery name="getdts" datasource="main">
         SELECT userbranch AS dts FROM users WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#GetAuthUser()#">
        </cfquery>
        <cfset dts = trim(getdts.dts)>--->
        
        <cfset targetTable=form.targetTable>
            
        <cfset sLimit="">
        <cfif IsDefined("form.iDisplayStart") AND form.iDisplayLength NEQ "-1">
            <cfset sLimit="LIMIT "&form.iDisplayStart&","&form.iDisplayLength>
        </cfif>		
        
        <cfset sOrder="">
        <cfif IsDefined("form.iSortCol_0")>
            <cfset sOrder="ORDER BY `">
            <cfloop from="0" to="#form.iSortingCols-1#" index="i" step="1">
                <cfif Evaluate('form.bSortable_'&Evaluate('form.iSortCol_'&i)) EQ "true">
                    <cfset sOrder=sOrder&Evaluate('form.mDataProp_'&Evaluate('form.iSortCol_'&i))>
                        <cfif Evaluate('form.sSortDir_'&i) EQ "asc">
                            <cfset sOrder=sOrder&"` ASC,`">
                        <cfelse>
                            <cfset sOrder=sOrder&"` DESC,`">
                        </cfif>
                </cfif>
            </cfloop>
            <cfset sOrder=Left(sOrder,Len(sOrder)-2)>
            <cfif sOrder EQ "ORDER BY `">
                <cfset sOrder="">
            </cfif>  
        </cfif>
        
        <cfset sWhere="">
		<cfif IsDefined("form.sSearch") AND form.sSearch NEQ "">
            <cfset sWhere=" WHERE (">
            <cfloop from="0" to="#form.iColumns-1#" index="i" step="1">	
                <cfif Evaluate('form.bSearchable_'&i) EQ "true">
                    <cfset sWhere=sWhere&'aa.'&Evaluate('form.mDataProp_'&i)&" LIKE ""%"&form.sSearch&"%"" OR ">
                </cfif>
            </cfloop>
            <cfset sWhere=Left(sWhere,Len(sWhere)-4)>
            <cfset sWhere=sWhere&")">
        </cfif>
        
        <!---custom query--->
        <cfquery name="getcustno" datasource="manpower_i">
            SELECT custno,custname,placementno,empno FROM placement
            WHERE completedate >= now() and custno = #custno#
        </cfquery>
        <!---end of custom query--->
            
        <cfquery name="getFilteredDataSet" datasource="manpower_i">
            SELECT SQL_CALC_FOUND_ROWS *
            FROM
            (	SELECT placement.empno, placement.empname, placement.placementno, placement.custno, placement.custname, placement.hrmgr, 
            	a.phone, a.email, b.status, c.username, c.useremail
                FROM placement 
                left join manpower_p.pmast as a on placement.empno = a.empno
                left join manpower_p.timesheet as b on placement.empno = b.empno
                left join payroll_main.hmusers as c on placement.hrmgr = c.entryid
                WHERE 1=1 and placement.custno = #custno#
                AND placement.empno <> '0'
                <cfif getcustno.recordcount neq 0>
                	AND placement.placementno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#valuelist(getcustno.placementno)#">)
                </cfif>
                GROUP BY empno
                ORDER BY empno  
            ) AS aa
                        
            #sWhere#
            #sOrder#
            #sLimit#
        </cfquery>
    
        <cfquery name="getFilteredDataSetLength" datasource="manpower_i">
            SELECT FOUND_ROWS() AS iFilteredTotal
        </cfquery>
        
        <cfquery name="getTotalDataSetLength" datasource="manpower_i">
            SELECT COUNT(empno) AS iTotal
            FROM #targetTable#
        </cfquery>      
    
		<cfset aaData=ArrayNew(1)>
        <cfloop query="getFilteredDataSet">	
        
        	<!---custom query--->
            <cfquery name="getempname" datasource="manpower_p">
            	SELECT name, phone, email FROM pmast 
            	WHERE empno = 
           <cfqueryparam cfsqltype="cf_sql_varchar" value="#getFilteredDataSet.empno#">
           </cfquery> 
           
           <cfquery name="gettimesheet" datasource="manpower_p">
              SELECT status,created_on, updated_on FROM timesheet
              WHERE empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getFilteredDataSet.empno#">
           </cfquery>
           
           <cfquery name="getHMdetail" datasource="payroll_main">
              SELECT entryid, userName, userEmail FROM payroll_main.hmusers
              WHERE entryid = "#getFilteredDataSet.hrmgr#"
           </cfquery>  
            <!---end of custom query--->
            
            <cfset data=StructNew()>
			<cfset data["empno"]=empno>
            <cfset data["empname2"]=empname>
            <cfset data["phone2"]=phone>
            <cfset data["email2"]=email>
            <cfset data["status2"]=status>
            <cfset data["hmname2"]=username>
            <cfset data["hmemail2"]=useremail>
			<cfset data["empname"]=#getempname.name#>
            <cfset data["phone"]=#getempname.phone#>
            <cfset data["email"]=#getempname.email#>
            
            <cfif gettimesheet.status eq ''>
            	<cfset data["timesheetstatus"]=''>
            <cfelse>
            	<cfset data["timesheetstatus"]= #gettimesheet.status#>
            </cfif>
           
            <cfset data["hmname"]=#getHMdetail.userName#>
            <cfset data["hmemail"]=#getHMdetail.userEmail#>
            
            <cfif gettimesheet.status eq ''>
            	<cfset data["submitdate"]=''> <!---in case null data on database--->
            <cfelse>
            	<cfset data["submitdate"]=#datetimeformat(gettimesheet.created_on, "yyyy/MM/dd h:mm:ss tt")#>
            </cfif>
            
            <cfif gettimesheet.status neq 'Approved'>
            	<cfset data["approvaldate"]=''>
            <cfelse>
            	<cfset data["approvaldate"]=#datetimeformat(gettimesheet.updated_on, "yyyy/MM/dd h:mm:ss tt")#>
            </cfif>

            <cfset ArrayAppend(aaData,data)>
        </cfloop>
        
        <cfset output=StructNew()>
        <cfset output["sEcho"]=form.sEcho>
        <cfset output["iTotalRecords"]=getTotalDataSetLength.iTotal>
        <cfset output["iTotalDisplayRecords"]=getFilteredDataSetLength.iFilteredTotal>
        <cfset output["aaData"]=aaData>
        <cfreturn output>
    </cffunction>
</cfcomponent>