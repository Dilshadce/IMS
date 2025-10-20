<cfoutput>
<cfset timenow = dateformat(now(), 'yyyymmdd_hhmmss')>

<cfsetting showdebugoutput="yes">

    <cfset headerlist = "Employee No,Placement No,Employee Name,Client No,Client Name">
    <cfset headerlist2 = "Leave Type,Days Taken,Submitted On,Leave Start Date,Leave Start Time,Leave End Date,Leave End Time,Leave Status,Employee Remarks,Manager Remarks,Updated On,Updated By">
    
	<cfquery name="getleavetype" datasource="#dts#">
	    SELECT * FROM iccostcode ORDER BY costcode
	</cfquery>

    <cfloop query = "getleavetype">
        <cfset headerlist = ListAppend(headerlist, '#UCase(getleavetype.costcode)# Entitle', ',')>
        <cfset headerlist = ListAppend(headerlist, '#UCase(getleavetype.costcode)# Days Entitled', ',')>
    </cfloop>
    
    <cfset headerlist = ListAppend(headerlist, '#headerlist2#', ',')>
    
    <cfquery name="getleave" datasource="#dts#">
        SELECT 
        pl.empno, 
        ll.placementno,
        pl.empname,
        pl.custno,
        pl.custname,
        <cfloop query="getleavetype">
            pl.#getleavetype.costcode#entitle, pl.#getleavetype.costcode#totaldays,
        </cfloop>
        ll.leavetype,
        ll.days,
        ll.submited_on,
        ll.startdate,
        ll.startampm,
        ll.enddate,
        ll.endampm,
        ll.status,
        ll.remarks, 
        ll.mgmtremarks,
        ll.updated_on,
        ll.updated_by
        FROM leavelist ll
        LEFT JOIN placement pl ON ll.placementno = pl.placementno
        WHERE 1=1
        
        <cfif (#IsDefined('form.customerFrom')# AND "#form.customerFrom#" NEQ "") AND (#IsDefined('form.customerTo')# AND "#form.customerTo#" NEQ "")>
            AND pl.custno BETWEEN <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.customerFrom#"> 
            AND <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.customerTo#">
        <cfelse>
            <cfif "#form.customerFrom#" NEQ "">
                AND pl.custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.customerFrom#">
            <cfelseif "#form.customerTo#" NEQ "">
                AND pl.custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.customerTo#">
            </cfif>
        </cfif>

        <cfif (#IsDefined('form.empFrom')# AND "#form.empFrom#" NEQ "") AND (#IsDefined('form.empTo')# AND "#form.empTo#" NEQ "")>
            AND pl.empno BETWEEN <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empFrom#"> 
            AND <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empTo#">
        <cfelse>
            <cfif "#form.empFrom#" NEQ "">
                AND pl.empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empFrom#">
            <cfelseif "#form.empTo#" NEQ "">
                AND pl.empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empTo#">
            </cfif>
        </cfif>
        
    </cfquery>
    
    <cfset excel = SpreadSheetNew(true)>
    <cfset rowcount = 1>
    <cfset SpreadSheetAddRow(excel,"Leave Type,Leave Description")>
    <cfset rowcount += 1>
    
    <cfloop query="getleavetype">
        <cfset SpreadSheetAddRow(excel,"#getleavetype.costcode#,#getleavetype.desp#")>
        <cfset rowcount += 1>
    </cfloop>
    
    <cfset SpreadSheetAddRow(excel," ")>
    <cfset rowcount += 1>
    
    <cfset s23 = StructNew()>                                    <!---header--->
    <cfset s23.font="Arial">
    <cfset s23.fontsize="11">
    <cfset s23.bold="true">
    <cfset s23.alignment="center">
    <cfset s23.verticalalignment="vertical_bottom">
   
    <cfset SpreadSheetAddRow(excel,"#headerlist#")>
    <cfset SpreadSheetFormatRow(excel, s23, rowcount)>
    <cfset rowcount += 1>
    
    <cfset SpreadSheetAddRows(excel, getleave)>

    <cfspreadsheet action="write" filename="#HRootPath#\Excel_Report\LeaveReport_#timenow#.xlsx" name="excel" overwrite="true">
    
    <!---<cfspreadsheet action="write" filename="#HRootPath#\Excel_Report\LeaveReport_#timenow#.xlsx" query="getleave" overwrite="true">--->
   
    <cfheader name="Content-Type" value="xlsx">
    <cfset filename = "LeaveReport_#timenow#.xlsx">

    <cfheader name="Content-Disposition" value="inline; filename=#filename#">		
    <cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\LeaveReport_#timenow#.xlsx">
      
        
</cfoutput>