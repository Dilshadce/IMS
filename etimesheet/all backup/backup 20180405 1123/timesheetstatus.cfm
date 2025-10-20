<!---Modified to use built in excel generator, [20180116, Alvin]--->
<cfsetting showDebugOutput="Yes">
<cfoutput>
    <cfset timenow = #dateTimeformat(now(), 'yyyymmdd_hhnnss')#>
    <cfset filename = "Timesheet_Status_#timenow#.xlsx">
    <cfif #IsNumeric(Left(Right(dts, 4),2))#>
        <cfset dts = #Replace(dts, Left(Right(dts, 4),2), '')#>
    </cfif>
    <cfset dsname = #Replace(dts, '_i', '_p')#>
    <cfset datestart = "#DateFormat(CreateDate(url.year, url.period, '01'), 'yyyy-mm-dd')#">
    <cfset dateend = "#DateFormat(CreateDate(url.year, url.period, daysinmonth(datestart)), 'yyyy-mm-dd')#">
    
    
    <cfquery name="getTimesheetStatus" datasource="#dts#">
        SELECT pm.empno, pm.empname, pm.placementno, IFNULL(tm.tmonth,0) AS tmonth, IFNULL(tm.status, "No Timesheet") AS timestatus,
        hm.username, hm.useremail, pm.custno, pm.custname
        FROM placement pm
        LEFT JOIN 
        (
            SELECT CASE WHEN status = "" THEN "Saved" ELSE status END AS status, placementno, tmonth
            FROM #dsname#.timesheet 
            WHERE tmonth = "#url.period#" 
            AND tsrowcount = "0"
        ) tm ON pm.placementno = tm.placementno
        LEFT JOIN payroll_main.hmusers hm ON pm.hrmgr = hm.entryid
        WHERE pm.startdate <= "#dateend#" AND pm.completedate >= "#datestart#"
        AND pm.empno <> '0'
        AND pm.jobstatus = 2
        AND pm.custno = "#url.custno#"
        GROUP BY pm.placementno
    </cfquery>
    
    #ExpandPath('\Excel_Report')#
        
    <cfset excel = SpreadSheetNew(true)>
    
    <cfset s23 = StructNew()>                                    <!---header format--->
    <cfset s23.font="Arial">
    <cfset s23.fontsize="11">
    <cfset s23.bold="true">
    <cfset s23.alignment="center">
    <cfset s23.verticalalignment="vertical_bottom">
        
    <cfset SpreadSheetAddRow(excel,"Employee No, Employee Name, Placement No, Month, Timesheet Status, Hiring Manager Name, Hiring Manager Email, Customer No, Customer Name")>
    <cfset SpreadSheetFormatRow(excel, s23, 1)>                <!---Add header---> 
    <cfset SpreadSheetAddRows(excel, getTimesheetStatus)>      <!---Add data--->
        
    <cfspreadsheet action="write" filename="#ExpandPath('\Excel_Report\#filename#')#" name="excel" overwrite="true">    <!---Write to File--->
        
    <cfheader name="Content-Disposition" value="inline; filename=#filename#">                                          <!---Force Download--->
    <cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#ExpandPath('\Excel_Report\#filename#')#">
    
    <!---<cfscript>
        Builder = createObject("component","/Excel_Generator/Excel_builder").init();

        Builder.setFilename("Timesheet_Status_"&timenow);
        headerFields = [
            "Employee No", "Employee Name", "Placement No", "Month", "Timesheet Status", "Hiring Manager Name",
            "Hiring Manager Email" , "Customer No", "Customer Name"	
        ];

        Builder.setHeader(headerFields);

        for(i = 1; i <= getTimesheetStatus.recordCount; i++){
            line = [ 
                getTimesheetStatus.empno[i],
                getTimesheetStatus.empname[i],
                getTimesheetStatus.placementno[i],
                getTimesheetStatus.tmonth[i],
                getTimesheetStatus.timestatus[i],
                getTimesheetStatus.username[i],
                getTimesheetStatus.useremail[i],
                getTimesheetStatus.custno[i],
                getTimesheetStatus.custname[i]
            ];

            lineType = [ 
                "Number",
                "String",
                "Number",
                "Number",
                "String",
                "String",
                "String",
                "Number",
                "String"
            ];

            Builder.addLine(line);
            Builder.addLineType(lineType);
        }

        Builder.setTypeFlag(True);

        Builder.output();

    </cfscript>--->
    
</cfoutput>