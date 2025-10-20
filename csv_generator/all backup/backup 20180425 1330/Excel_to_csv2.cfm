<cfoutput>
<cfsetting showdebugoutput="Yes" requestTimeOut="0">

<cfset dateNow = #dateformat(now(), 'yyyymmdd-hhmmss')#>
<cfset fileName = "timesheet_#dateNow#.csv">
<cfset firstTime = TRUE>
<cfset writeAppend = "WRITE">
<cfset lastRow = "50">
<cfset lastRowMonth = "">
<cfset srcFile = "#ExpandPath('../importfile/timesheet_convert.xlsx')#">			<!---change excel file--->
<cfset stcol = "">
<cfset outputfile = "#ExpandPath('../Excel_Report/#fileName#')#">
<cfset workhours = "0.00">
<cfset breaktime = "1">
<cfset tsrowcount = 0>
<cfset monthlist = "Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec">
<cfset monthselected = "3">
<cfset writeAppend = "Write">

<cfquery name="comp_detail" datasource="payroll_main">
    SELECT mmonth, myear FROM gsetup WHERE comp_id = "#ListFirst(getHQstatus.userBranch, '_')#"
</cfquery>
    
<cfquery name="getottable" datasource="#dts#">
    SELECT * FROM icsizeid
</cfquery>
    
<cfset monthdays = "#DaysInMonth(DateFormat(CreateDate(comp_detail.myear, monthselected, 1), 'yyyy-mm-dd'))#">    
    
<cfquery name="getplacement" datasource="#dts#">
    SELECT pm.placementno, pm.timesheet, emp.empno, emp.client_ref_id, pm.startdate, pm.completedate, pm.ottable, ot.*
    FROM placement AS pm
    LEFT JOIN #Replace(dts, '_i', '_p')#.pmast AS emp ON pm.empno = emp.empno
    LEFT JOIN icsizeid AS ot ON ot.sizeid = pm.ottable
    WHERE pm.jobstatus = '2'
</cfquery>

<cfquery name="getleave" datasource="#dts#">
    SELECT placementno, leavetype, days, remarks, startdate, startampm, enddate, endampm, status
    FROM leavelist
    WHERE status = "APPROVED"
</cfquery>

<cfspreadsheet action="read" src="#srcFile#" query="excelData">
    
<cfquery dbtype="query" name="queryData">
    SELECT col_2 AS client_ref_id, col_5 AS client_date, col_7 AS time_in, col_8 AS time_out FROM excelData 
</cfquery>

<cfquery name="totalemp" dbtype="query">
    SELECT client_ref_id FROM queryData WHERE client_ref_id != 'Emp.ID' GROUP BY client_ref_id
</cfquery>    

<cfloop query="totalemp">
    
    <cfset tsrowcount = 0>
    
    <cfloop from="1" to="#monthdays#" index="a">
        <cfset currentdate = "#DateFormat(CreateDate(comp_detail.myear, monthselected, a), 'yyyy-mm-dd')#">
        <cfquery name="empplacementno" dbtype="query">
            SELECT * FROM getplacement
            WHERE '#currentdate#'
            BETWEEN startdate AND completedate
            AND client_ref_id = '#totalemp.client_ref_id#'
        </cfquery>
        
        <cfif #empplacementno.recordcount# EQ 0>
            <cfcontinue>
        </cfif>
            
        <cfset stcol = "NPL">
        <cfset placementno = "#empplacementno.placementno#">
        <cfset empno = "#empplacementno.empno#">
        <cfset starttime = "00:00:00">
        <cfset endtime = "00:00:00">
        <cfset workhours = "0.00">
        <cfset breaktime = "0">
        <cfset remarks = "">
        <cfset ampm = "">
            
        <cfloop from="1" to="30" index="b">
            <cfif "#Evaluate('empplacementno.phdate#b#')#" EQ "#currentdate#" AND "#Evaluate('empplacementno.phdesp#b#')#" NEQ "">
                <cfset stcol = "PH">
                <cfset remarks = "#Evaluate('empplacementno.phdesp#b#')#">
                <cfbreak>
            </cfif>
        </cfloop>
                    
        <cfif "#stcol#" NEQ "PH">
            <cfif "#DateFormat(currentdate, 'ddd')#" EQ "SAT">
                <cfset stcol = "OD">
            <cfelseif "#DateFormat(currentdate, 'ddd')#" EQ "SUN">
                <cfset stcol = "RD">
            </cfif>
            
            <cfquery name="checkleave" dbtype="query">
                SELECT * FROM getleave
                WHERE placementno = '#placementno#' 
                AND '#currentdate#' BETWEEN startdate AND enddate
            </cfquery>
                
            <cfif "#checkleave.recordcount#" NEQ 0>
                <cfset stcol = "#checkleave.leavetype#">
                <cfif "#checkleave.days#" EQ "0.5">
                    <cfif "#Left(checkleave.startampm, 2)#" LT 12>
                        <cfset starttime = "#Timeformat(CreateTime(Left(checkleave.startampm, 2)+4, Right(checkleave.startampm, 2), '00'), 'HH:nn:ss')#">
                        <cfset endtime = "#Timeformat(CreateTime(Left(checkleave.endampm, 2)+4, Right(checkleave.endampm, 2), '00'), 'HH:nn:ss')#">
                        <cfset ampm = "AM">
                    <cfelse>
                        <cfset starttime = "#Timeformat(CreateTime(Left(checkleave.startampm, 2)-4, Right(checkleave.startampm, 2), '00'), 'HH:nn:ss')#">
                        <cfset endtime = "#Timeformat(CreateTime(Left(checkleave.endampm, 2)-4, Right(checkleave.endampm, 2), '00'), 'HH:nn:ss')#">
                        <cfset ampm = "PM">
                    </cfif>
                <cfelse>
                    <cfset ampm = "FULL DAY">
                </cfif>
            </cfif>
        </cfif>
        
        <cfquery name="gettime" dbtype="query">
            SELECT client_date, client_ref_id, time_in, time_out FROM queryData
            WHERE client_ref_id = '#totalemp.client_ref_id#'
            AND client_date = '#DateFormat(currentdate, 'd')# #DateFormat(currentdate, 'mmm')# #DateFormat(currentdate, 'yyyy')# (#DateFormat(currentdate, 'ddd')#)'
            AND time_in != '' AND time_out != ''
        </cfquery>
        
        <cfif "#gettime.time_in#" NEQ "" AND "#gettime.time_out#" NEQ "">
            <cfset starttime = #Replace(gettime.time_in, "'", "", "ALL")#>    
            <cfset starttime = "#Timeformat(CreateTime(Left(starttime, 2), Right(starttime, 2), '00'), 'HH:nn:ss')#">
            <cfset endtime = #Replace(gettime.time_out, "'", "", "ALL")#>    
            <cfset endtime = "#Timeformat(CreateTime(Left(endtime, 2), Right(endtime, 2), '00'), 'HH:nn:ss')#">   
            <cfset breaktime = "1">
            <cfif "#stcol#" EQ "NPL">
                <cfset stcol = "">
            </cfif>
        </cfif>
        
        <cffile action="#writeAppend#" file="#outputfile#"
                output="#placementno#,#empno#,#stcol#,#tsrowcount#,#currentdate#,#starttime#,#endtime#,#workhours#,#breaktime#,0,0,0,0,0,0,0,0,""#remarks#"",#ampm#,#monthselected#,#comp_detail.myear#"
            addnewline="yes">
            
        <cfset tsrowcount += 1>
        <cfif "#writeAppend#" EQ "Write">
            <cfset writeAppend = "Append">
        </cfif>
    </cfloop>  
    
</cfloop>  
    
<cfheader name="Content-Type" value="csv">
<cfheader name="Content-Disposition" value="inline; filename=#fileName#">
<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#outputfile#">

</cfoutput>