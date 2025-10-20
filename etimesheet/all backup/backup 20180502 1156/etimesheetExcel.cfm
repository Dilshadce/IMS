<cfsetting requestTimeOut = "9000" />
<cfoutput>
<cfset uuid = createuuid()>

<cfsetting showdebugoutput="yes">
<cfinclude template="/object/dateobject.cfm">
<cfinclude template="/object/stringobject.cfm">

<cfquery name="getpayroll" datasource="#dts#">
SELECT mmonth,myear FROM payroll_main.gsetup WHERE comp_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#replace(dts,'_i','')#">
</cfquery>
<cfset payrollmonth = getpayroll.mmonth>
<cfset payrollyear = getpayroll.myear>
<cfset currentdate = createdate(val(payrollyear),val(payrollmonth),1)>

	<cffile action="WRITE" file="#HRootPath#\Excel_Report\etimesheetReport#dateformat(now(),'ddmmyyyy')#.csv"
    	output="Company,Client No,Client Name,Placement Count,Count of Submit Date,Count of Approval Date" 
        addnewline="yes">
        
    <cffile action="APPEND" file="#HRootPath#\Excel_Report\etimesheetReport#dateformat(now(),'ddmmyyyy')#.csv" 
   		output="Associate,Employee No,Employee Name,Phone,Email,Timesheet Status,HM Name,HM Email,Submit Date,Approval Date,Timesheet Period"
  		addnewline="Yes">
        
	<cfquery name="getPlacementCount" datasource="#dts#">
    	SELECT custno, custname, count(placementno) as placementcount, placementno, empno
        FROM placement
        WHERE completedate >= now()
        AND startdate <= now()
        AND empno <> '0'
        AND placementno not like '%test%'
        GROUP BY custno
    </cfquery>
    
    <cfloop query="getPlacementCount">
    
    	<cfquery name ="getplacementno" datasource="#dts#">
            select GROUP_CONCAT(placementno) as placementno from manpower_i.placement where custno = '#getPlacementCount.custno#'
            AND empno <> 0
            and completedate >= now() 
            AND startdate <= now()
        </cfquery>

        <cfquery name='getvalidatedcount' datasource="#replace(dts,'_i','_p')#">
            select placementno 
            from timesheet 
            where placementno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#getplacementno.placementno#" list="yes" separator=",">)
            group by placementno
        </cfquery>
                
        <cfquery name='getapprovedcount' datasource="#replace(dts,'_i','_p')#">
            select placementno 
            from timesheet 
            where placementno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#getplacementno.placementno#" list="yes" separator=",">)
            and status = "Approved"
            group by placementno
        </cfquery>
    
        <cffile action="APPEND" file="#HRootPath#\Excel_Report\etimesheetReport#dateformat(now(),'ddmmyyyy')#.csv"
            output="Company,#getPlacementCount.custno#,#getPlacementCount.custname#,#getPlacementCount.placementcount#,#getvalidatedcount.recordcount#, #getapprovedcount.recordcount#" 
            addnewline="yes">
            
        <cfquery name="getDetailsPlacement" datasource="#dts#">
        	SELECT *
            FROM
            (	SELECT placement.empno, placement.empname, placement.placementno, placement.custno, placement.custname, placement.hrmgr, 
            	a.phone, a.email, c.username, c.useremail
                FROM placement 
                left join manpower_p.pmast as a on placement.empno = a.empno
                left join payroll_main.hmusers as c on placement.hrmgr = c.entryid
                WHERE 1=1 and placement.custno = #getPlacementCount.custno#
                AND placement.empno <> '0'
               	AND placement.placementno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#getplacementno.placementno#" list="yes" separator=",">)
                
                GROUP BY empno
                ORDER BY empno  
            ) AS aa
        </cfquery>
            
        <cfloop query="getDetailsPlacement">
        
        	<cfquery name="getTimesheet" datasource="#replace(dts,'_i','_p')#">
            	SELECT status, updated_on, created_on, tmonth
                FROM timesheet 
                WHERE placementno = "#getDetailsPlacement.placementno#"
                AND (month(pdate) = #payrollmonth# AND year(pdate) = #payrollyear#)
            </cfquery>
        
        	<cfif #getTimesheet.status# neq "Approved">
                <cffile action="APPEND" file="#HRootPath#\Excel_Report\etimesheetReport#dateformat(now(),'ddmmyyyy')#.csv" 
                        output="Associate,""#getDetailsPlacement.empno#"",""#getDetailsPlacement.empname#"",""#getDetailsPlacement.phone#"",""#getDetailsPlacement.email#"",""#getTimesheet.status#"",""#getDetailsPlacement.username#"",""#getDetailsPlacement.useremail#"",""#datetimeformat(gettimesheet.created_on, 'yyyy/MM/dd h:mm:ss tt')#"","""",""#getTimesheet.tmonth#"""
                        addnewline="Yes">
            <cfelse>
                <cffile action="APPEND" file="#HRootPath#\Excel_Report\etimesheetReport#dateformat(now(),'ddmmyyyy')#.csv" 
                    output="Associate,""#getDetailsPlacement.empno#"",""#getDetailsPlacement.empname#"",""#getDetailsPlacement.phone#"",""#getDetailsPlacement.email#"",""#getTimesheet.status#"",""#getDetailsPlacement.username#"",""#getDetailsPlacement.useremail#"",""#datetimeformat(gettimesheet.created_on, 'yyyy/MM/dd h:mm:ss tt')#"",""#datetimeformat(gettimesheet.updated_on, 'yyyy/MM/dd h:mm:ss tt')#"",""#getTimesheet.tmonth#"""
                    addnewline="Yes">
            </cfif>
        
        
        </cfloop>
        
    </cfloop>
		
        
		<!---FINISHED WRITING CSV--->
		
        <cfheader name="Content-Type" value="csv">
		<cfset filename = "etimesheetReport#dateformat(now(),'ddmmyyyy')#.csv">

		<cfheader name="Content-Disposition" value="inline; filename=#filename#">		
		<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\etimesheetReport#dateformat(now(),'ddmmyyyy')#.csv">
</cfoutput>