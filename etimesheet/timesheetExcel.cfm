<cfsetting showdebugoutput="true" requesttimeout="0">
<cfif "#form.fromclient#" EQ "" AND "#form.toclient#" EQ "" AND "#form.fromemp#" EQ "" AND "#form.toemp#" EQ "" 
	AND "#form.custlist#" EQ "" AND "#form.emplist#" EQ "" AND "#form.filteremplist#" EQ "">
    <script>
        alert('Please select filter for client or employee.');
        window.close();
    </script>
    <cfabort>
</cfif>

<cfset dsname = "#Replace(dts, '_i', '_p')#">

<cfif "#form.subbtn#" EQ "Generate Excel Timesheet">
	<cfset workhours = "a.workhours">
	<cfset othour = "a.othour">
	<cfset othour = "a.othour">
	<cfset ot1 = "a.ot1">
	<cfset ot2 = "a.ot2">
	<cfset ot3 = "a.ot3">
	<cfset ot4 = "a.ot4">
	<cfset ot5 = "a.ot5">
	<cfset ot6 = "a.ot6">
	<cfset ot7 = "a.ot7">
	<cfset ot8 = "a.ot8">
	<cfset grouporder = "ORDER BY a.empno, a.pdate">
	<cfset filetype = "Timesheet">
	<cfset headerlist = "Placement No,Employee No,Name,Cliet No,Client Name,Manager,Date,Day Type,Start Time,End Time,Break Time,Status,Total Work Hour,Total OT Hour,Remarks,Manager Remarks,OT1.0,OT1.5,OT2.0,OT3.0,RD1.0,RD2.0,PH1.0,PH2.0,Updated On,Submitted On">
<cfelse>
	<cfset workhours = "sum(a.workhours)">
	<cfset othour = "sum(a.othour)">
	<cfset othour = "sum(a.othour)">
	<cfset ot1 = "sum(a.ot1)">
	<cfset ot2 = "sum(a.ot2)">
	<cfset ot3 = "sum(a.ot3)">
	<cfset ot4 = "sum(a.ot4)">
	<cfset ot5 = "sum(a.ot5)">
	<cfset ot6 = "sum(a.ot6)">
	<cfset ot7 = "sum(a.ot7)">
	<cfset ot8 = "sum(a.ot8)">
	<cfset grouporder = "GROUP BY a.placementno ORDER BY a.empno, a.pdate">
	<cfset filetype = "OT">
	<cfset headerlist = "Placement No,Employee No,Name,Cliet No,Client Name,Manager,Status,Total Work Hour,Total OT Hour,Remarks,Manager Remarks,OT1.0,OT1.5,OT2.0,OT3.0,RD1.0,RD2.0,PH1.0,PH2.0,Updated On,Submitted On">
</cfif>

<cfquery name="getTimesheet" datasource="#dts#">
	SELECT
	a.placementno 'Placement No'
	, a.empno 'Employee No'
	, b.empname 'Name'
	, b.custno 'Client No'
	, b.custname 'Client Name'
	, c.username 'Manager'
	<cfif "#form.subbtn#" EQ "Generate Excel Timesheet"> 
		, a.pdate 'Date'
		, a.stcol 'Day Type'
		, a.starttime 'Start Time'
		, a.endtime 'End Time'
		, a.breaktime 'Break Time'
	</cfif>
	, CASE WHEN a.status = '' THEN 'SAVED' ELSE a.status END AS 'Status' 
	, #workhours# 'Total Work Hour'
	, #othour# 'Total OT Hour'
	, a.remarks 'Remarks'
	, a.mgmtremarks AS 'Manager Remarks'
	, #ot1# 'OT1.0'
	, #ot2# 'OT1.5'
	, #ot3# 'OT2.0' 
	, #ot4# 'OT3.0' 
	, #ot5# 'RD1.0' 
	, #ot6# 'RD2.0' 
	, #ot7# 'PH1.0' 
	, #ot8# 'PH2.0'
	, a.updated_on 'Updated On' 
	, a.created_on 'Submitted On'
	FROM #dsname#.timesheet a
	LEFT JOIN placement b ON a.placementno = b.placementno
	LEFT JOIN payroll_main.hmusers c ON b.hrmgr = c.entryid
	WHERE a.tmonth = '#form.monthselected#' AND tyear = '#form.yearselected#'

	<cfif #IsDefined('form.status')#>
        AND a.status IN (<cfqueryparam list="true" separator="," value="#form.status#">)
    </cfif>

    <cfif (#IsDefined('form.fromclient')# AND "#form.fromclient#" NEQ "") AND (#IsDefined('form.toclient')# AND "#form.toclient#" NEQ "")>
        AND b.custno BETWEEN <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fromclient#"> 
        AND <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.toclient#">
    <cfelse>
        <cfif "#form.fromclient#" NEQ "">
            AND b.custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fromclient#">
        <cfelseif "#form.toclient#" NEQ "">
            AND b.custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.toclient#">
        </cfif>
    </cfif>
            
    <cfif (#IsDefined('form.fromemp')# AND "#form.fromemp#" NEQ "") AND (#IsDefined('form.toemp')# AND "#form.toemp#" NEQ "")>
        AND a.empno BETWEEN <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fromemp#"> 
        AND <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.toemp#">
    <cfelse>
        <cfif "#form.fromemp#" NEQ "">
            AND a.empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fromemp#">
        <cfelseif "#form.toemp#" NEQ "">
            AND a.empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.toemp#">
        </cfif>
    </cfif>

    <cfif #isDefined('form.custlist')# AND "#form.custlist#" NEQ "">
        AND b.custno IN (<cfqueryparam list="Yes" separator="," value="#Replace(form.custlist, ' ', '', 'ALL')#">)
    </cfif>

    <cfif #isDefined('form.emplist')# AND "#form.emplist#" NEQ "">
        AND a.empno IN (<cfqueryparam list="Yes" separator="," value="#Replace(form.emplist, ' ', '', 'ALL')#">)
    </cfif>

    <cfif #isDefined('form.filteremplist')# AND "#form.filteremplist#" NEQ "">
        AND a.empno NOT IN (<cfqueryparam list="Yes" separator="," value="#Replace(form.filteremplist, ' ', '', 'ALL')#">)
    </cfif>

   	#grouporder#;
</cfquery>

<cfset s23 = StructNew()>                                                                                       <!---header formatting--->
<cfset s23.font="Arial">
<cfset s23.fontsize="11">
<cfset s23.bold="true">
<cfset s23.alignment="center">
<cfset s23.verticalalignment="vertical_bottom">
<cfset datatype = [""]>

<cfset excel = SpreadSheetNew(true)>
<cfset spreadsheetAddrow(excel, "#headerlist#")> 
<cfset spreadsheetAddrows(excel, getTimesheet)> 
<cfset SpreadSheetFormatRow(excel, s23, 1)>
<cfset timenow = "#dateformat(now(), 'yyyymmdd_hhmmss')#">

<cfspreadsheet action="write" filename="#HRootPath#\Excel_Report\#filetype#_Report_#timenow#.xlsx" name="excel" overwrite="true">

<cfheader name="Content-Type" value="xlsx">

<cfheader name="Content-Disposition" value="inline; filename=#filetype#_Report_#timenow#.xlsx">		
<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\#filetype#_Report_#timenow#.xlsx">