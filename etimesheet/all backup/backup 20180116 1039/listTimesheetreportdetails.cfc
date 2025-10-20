<cfcomponent>
    <cffunction name="listDetails" access="remote" returntype="struct"> 
        <!---<cfset dts=form.dts>--->
        <!---<cfquery name="getdts" datasource="main">
         SELECT userbranch AS dts FROM users WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#GetAuthUser()#">
        </cfquery>
        <cfset dts = trim(getdts.dts)>--->
        <cfset dsname = "#replace(dts, '_i', '_p')#">
        <cfset datestart = "#DateFormat(CreateDate(yearselected, monthselected, '01'), 'yyyy-mm-dd')#">
        <cfset dateend = "#DateFormat(CreateDate(yearselected, monthselected, daysinmonth(datestart)), 'yyyy-mm-dd')#">
        
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
        <cfquery name="getcustno" datasource="#dts#">
            SELECT custno,custname,placementno,empno FROM placement
            WHERE completedate >= now() and custno = #custno#
        </cfquery>
        <!---end of custom query--->
            
        <cfquery name="getFilteredDataSet" datasource="#dts#">
            SELECT SQL_CALC_FOUND_ROWS *
            FROM
            (
                SELECT pl.empno, pl.empname, pm.phone, pl.placementno,
                CASE WHEN pm.workemail = "" THEN pm.email ELSE pm.workemail END AS email,
                <!---CASE WHEN tm.status = "" THEN "Saved" ELSE tm.status END AS status,---> 
                hm.username AS hmname, hm.userid AS hmemail<!---, tm.created_on AS submitdate,
                tm.tmonth, tm.updated_on AS updateddate--->
                FROM placement pl
                LEFT JOIN #dsname#.pmast pm ON pl.empno = pm.empno
                LEFT JOIN payroll_main.hmusers hm ON pl.hrmgr = hm.entryid
                <!---LEFT JOIN #dsname#.timesheet tm ON pl.placementno = tm.placementno--->
                WHERE pl.startdate <="#dateend#" AND pl.completedate >= "#datestart#"
                AND pl.custno = "#custno#"
                AND pl.empno <> '0'
                AND pl.jobstatus NOT IN ('3', '4')
                <!---AND tm.tsrowcount = "0"
                AND tm.tmonth = "#monthselected#"--->
            ) AS aa
                        
            #sWhere#
            #sOrder#
            #sLimit#
        </cfquery>
    
        <cfquery name="getFilteredDataSetLength" datasource="#dts#">
            SELECT FOUND_ROWS() AS iFilteredTotal
        </cfquery>
        
        <cfquery name="getTotalDataSetLength" datasource="#dts#">
            SELECT COUNT(empno) AS iTotal
            FROM #targetTable#
            GROUP BY empno
        </cfquery>      
    
		<cfset aaData=ArrayNew(1)>
        <cfloop query="getFilteredDataSet">	
        
        	<!---custom query--->
            <!---<cfquery name="getempname" datasource="manpower_p">
            	SELECT name, phone, email FROM pmast 
            	WHERE empno = 
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#getFilteredDataSet.empno#">
            </cfquery> 
           
            <cfquery name="gettimesheet" datasource="manpower_p">
               SELECT status,created_on, updated_on, tmonth FROM timesheet
               WHERE empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getFilteredDataSet.empno#">
            </cfquery>
           
            <cfquery name="getHMdetail" datasource="payroll_main">
               SELECT entryid, userName, userEmail FROM payroll_main.hmusers
               WHERE entryid = "#getFilteredDataSet.hrmgr#"
            </cfquery>  --->
            <cfquery name="timesheetdata" datasource="#dsname#">
                SELECT IFNULL(CASE WHEN status = "" THEN "Saved" ELSE status END, "No Timesheet") AS status,
                tmonth, updated_on AS updateddate, created_on AS submitdate
                FROM timesheet
                WHERE placementno = "#getFilteredDataSet.placementno#"
                AND tmonth = "#monthselected#" AND tsrowcount = "0"
            </cfquery>
            <!---end of custom query--->
            
            <cfset data=StructNew()>
			<cfset data["empno"]=empno>
            <cfset data["empname"]=empname>
            <cfset data["phone"]=phone>
            <cfset data["email"]=email>
            <cfif "#timesheetdata.recordcount#"  EQ '0'>
                <cfset data["status"]="No Timesheet">
            <cfelse>
                <cfset data["status"]=timesheetdata.status>
            </cfif>
            <cfset data["hmname"]=hmname>
            <cfset data["hmemail"]=hmemail>
            <cfset data["submitdate"]="#DateTimeFormat(timesheetdata.submitdate, 'yyyy-mm-dd hh:nn:ss')#">
            <cfset data["updateddate"]="#DateTimeFormat(timesheetdata.updateddate, 'yyyy-mm-dd hh:nn:ss')#">
            <cfset data["tmonth"]=timesheetdata.tmonth>
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