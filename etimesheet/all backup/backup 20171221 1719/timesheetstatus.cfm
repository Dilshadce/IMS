<cfsetting showDebugOutput="Yes">
<cfoutput>
    <cfset timenow = #dateTimeformat(now(), 'yyyymmdd_hhnnss')#>
    <cfset dsname = #Replace(dts, '_i', '_p')#>
    <cfset datestart = "#DateFormat(CreateDate(url.year, url.period, '01'), 'yyyy-mm-dd')#">
    <cfset dateend = "#DateFormat(CreateDate(url.year, url.period, daysinmonth(datestart)), 'yyyy-mm-dd')#">
    
    <cfquery name="getTimesheetStatus" datasource="#dts#">
        SELECT pm.empno, pm.empname, pm.placementno, tm.tmonth, pm.custno, pm.custname,
        CASE WHEN tm.status = "" THEN "Saved" ELSE tm.status END AS timestatus, hm.username, hm.useremail
        FROM placement pm
        LEFT JOIN #dsname#.timesheet tm ON pm.placementno = tm.placementno
        LEFT JOIN payroll_main.hmusers hm ON pm.hrmgr = hm.entryid
        WHERE pm.startdate <= "#dateend#" AND pm.completedate >= "#datestart#"
        AND pm.custno = "#url.custno#"
        AND tm.tsrowcount = "0"
        AND tm.tmonth = "#url.period#"
        GROUP BY pm.placementno
    </cfquery>
    
    <cfscript>
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

    </cfscript>
    
</cfoutput>