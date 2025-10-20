<cfcomponent>
    <cffunction name="listTime" access="remote" returntype="struct"> 
        <cfset dts=form.dts>
        
        <cfif #IsNumeric(Left(Right(dts, 4),2))#>
            <cfset dts = #Replace(dts, Left(Right(dts, 4),2), '')#>
        </cfif>
            
        <cfset dsname = "#replace(dts, '_i', '_p')#">
        
        <!---<cfquery name="getdts" datasource="main">
         SELECT userbranch AS dts FROM users WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#GetAuthUser()#">
        </cfquery>--->
        
        <!---<cfset dts = trim(getdts.dts)>--->
        
        <cfset clientfrom=trim(clientfrom)>
        <cfset clientto=trim(clientto)>
        <cfset empfrom=trim(empfrom)>
        <cfset empto=trim(empto)>
        <cfset targetTable=form.targetTable>
        <cfset reportmonth=reportmonth>
        <cfset reportyear=reportyear>
        <cfset datestart = "#DateFormat(CreateDate(reportyear, reportmonth, '01'), 'yyyy-mm-dd')#">
        <cfset dateend = "#DateFormat(CreateDate(reportyear, reportmonth, daysinmonth(datestart)), 'yyyy-mm-dd')#">
            
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
        
        <cfquery name="getFilteredDataSet" datasource="#dts#">
            SELECT SQL_CALC_FOUND_ROWS  *
            FROM 
            ( 	SELECT custno, custname, count(placementno) as placementcount, placementno, empno
                FROM #targetTable#
            	WHERE completedate >= "#datestart#" AND startdate <= "#dateend#"
                AND empno <> '0'
                AND jobstatus = '2'
				
                <!---<cfif #clientfrom# neq "" and #clientto# neq "" and #empto# neq "" and #empfrom# neq "">--->

                    <cfif (isdefined('#clientfrom#') and #clientfrom# neq "") and (isdefined('#clientto#') and #clientto# neq "")>
                        AND custno BETWEEN <cfqueryparam cfsqltype="cf_sql_varchar" value="#clientfrom#"> 
                        AND <cfqueryparam cfsqltype="cf_sql_varchar" value="#clientto#">
                    <cfelse>
                        <cfif #clientfrom# neq "">
                            AND custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#clientfrom#">
                        <cfelseif #clientto# neq "">
                            AND custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#clientto#">
                        </cfif>
                    </cfif>

                    <cfif (isdefined('#empfrom#') and #empfrom# neq "") and (isdefined('#empto#') and #empto# neq "")>
                        AND empno BETWEEN <cfqueryparam cfsqltype="cf_sql_varchar" value="#empfrom#"> 
                        AND <cfqueryparam cfsqltype="cf_sql_varchar" value="#empto#">
                    <cfelse>
                        <cfif #empfrom# neq "">
                            AND empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#empfrom#">
                        <cfelseif #empto# neq "">
                            AND empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#empto#">
                        </cfif>
                    </cfif>
						
				<!---</cfif>--->
                
				Group by custno
                
			) AS aa
            
            #sWhere#
            #sOrder#
            #sLimit#
          
        </cfquery>

        <cfquery name="getFilteredDataSetLength" datasource="#dts#">
            SELECT FOUND_ROWS() AS iFilteredTotal
        </cfquery>
        <cfquery name="getTotalDataSetLength" datasource="#dts#">
            SELECT COUNT(custno) AS iTotal
            FROM #targetTable#
        </cfquery>      
    
		<cfset aaData=ArrayNew(1)>
        <cfloop query="getFilteredDataSet">	
        
        	<!---custom query--->
            <cfquery name="gettimesheetstatus" datasource="#dsname#">
                SELECT 
                IFNULL(SUM(CASE WHEN status = '' THEN 1 ELSE 0 END), 0) AS saved,
                IFNULL(SUM(CASE WHEN status = 'Approved' THEN 1 ELSE 0 END), 0) AS approved,
                IFNULL(SUM(CASE WHEN status = 'Submitted For Approval' THEN 1 ELSE 0 END), 0) AS submitted,
                IFNULL(SUM(CASE WHEN status = 'Processed' THEN 1 ELSE 0 END), 0) AS processed,
                IFNULL(SUM(CASE WHEN status = 'Rejected' THEN 1 ELSE 0 END), 0) AS rejected
                FROM
                timesheet
                WHERE tsrowcount = '0'
                AND tmonth = '#reportmonth#'
                AND placementno IN 
                (SELECT placementno FROM #dts#.placement where custno = '#custno#' AND completedate >= "#datestart#" AND startdate <= "#dateend#"
                AND empno <> '0'
                AND jobstatus = '2')
            </cfquery>
            
            <!---<cfquery name ="getplacementno" datasource="#dts#">
                select GROUP_CONCAT(placementno) as placementno from placement where custno = '#custno#'
                AND empno <> 0
                and completedate >= "#dateselected#"
            </cfquery>
                        
            <cfquery name='getprocessedcount' datasource="#dsname#">
                select placementno 
                from timesheet 
                where placementno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#getplacementno.placementno#" list="yes" separator=",">)
                and tsrowcount = 1
                and tmonth = "#reportmonth#"
                and status = "Processed"
            </cfquery>
                    
            <cfquery name='getapprovedcount' datasource="#dsname#">
                select placementno 
                from timesheet 
                where placementno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#getplacementno.placementno#" list="yes" separator=",">) 
                and tsrowcount = 1
                and tmonth = "#reportmonth#"
                and status = "Approved" 
            </cfquery>
            
            <cfquery name='getsubmitcount' datasource="#dsname#">
                select placementno 
                from timesheet 
                where placementno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#getplacementno.placementno#" list="yes" separator=",">) 
                and tsrowcount = 1
                and tmonth = "#reportmonth#"
                and status = "Submitted For Approval" 
            </cfquery>
            
            <cfquery name='getsavedcount' datasource="#dsname#">
                select placementno 
                from timesheet 
                where placementno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#getplacementno.placementno#" list="yes" separator=",">) 
                and tsrowcount = 1
                and tmonth = "#reportmonth#"
                and status = "" 
            </cfquery>
            
            <cfquery name='getrejectedcount' datasource="#dsname#">
                select placementno 
                from timesheet 
                where placementno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#getplacementno.placementno#" list="yes" separator=",">) 
                and tsrowcount = 1
                and tmonth = "#reportmonth#"
                and status = "Rejected" 
            </cfquery>--->
            <!---end of custom query--->
        
            <cfset data=StructNew()>
			<cfset data["custno"]=custno>
            <cfset data["custname"]=custname>
            <cfset data["placementcount"]=placementcount>
            <cfset data["submittedcount"]=#gettimesheetstatus.submitted#>
            <cfset data["processedcount"]=#gettimesheetstatus.processed#>
            <cfset data["approvedcount"]=#gettimesheetstatus.approved#>            
            <cfset data["savedcount"]=#gettimesheetstatus.saved#>            
            <cfset data["rejectedcount"]=#gettimesheetstatus.rejected#>
            <cfset data["notfound"]=#val(placementcount)# - #gettimesheetstatus.submitted# - #gettimesheetstatus.processed# - #gettimesheetstatus.approved# -#gettimesheetstatus.saved# - #gettimesheetstatus.rejected#>
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