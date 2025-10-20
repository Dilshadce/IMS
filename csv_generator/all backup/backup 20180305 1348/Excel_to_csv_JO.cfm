<cfoutput>
<cfsetting showdebugoutput="Yes" requestTimeOut="0">

<cfset dateNow = #dateformat(now(), 'yyyymmdd-hhmmss')#>
<cfset fileName = "timesheetJO_#dateNow#.csv">
<cfset firstTime = TRUE>
<cfset writeAppend = "WRITE">
<cfset lastRow = "50">
<cfset lastRowMonth = "">
<cfset srcFile = "#ExpandPath('../importfile/jo_timesheet_generate.csv')#">			<!---change excel file--->
<cfset stcol = "">
<cfset outputfile = "#ExpandPath('../Excel_Report/#filename#')#">
<cfset workhours = "0.00">
<cfset breaktime = "1">
<cfset phflag = FALSE>
<cfset leaveflag = FALSE>

<cfquery datasource="#dts#">
    SET SESSION binlog_format = 'MIXED';
</cfquery>    

<cfquery name="clearimporttimesheet" datasource="#dts#">
    TRUNCATE TABLE timesheet_import
</cfquery>
    
<cfquery name="InsertIntoTimesheet" datasource="#dts#"><!---change to manpower_p to import live--->
    LOAD DATA LOCAL INFILE '#Replace(HRootPath, '\', '\\', 'ALL')#\\importfile\\jo_timesheet_generate.csv' INTO TABLE timesheet_import
    FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY
    '\r\n' (col_1,col_2,col_3,col_4,col_5,col_6,col_7,col_8,col_9,col_10,col_11,col_12,col_13,col_14,col_15,col_16,col_17);
</cfquery>
    
<cfquery name="excel" datasource="#dts#">
    SELECT * FROM timesheet_import
</cfquery>

<cfloop query="excel">

    <cfquery name="getplacement" datasource="#dts#">
        SELECT placementno, timesheet 
        FROM placement
        WHERE empno = #excel.col_1#
        AND "#LsDateFormat(excel.col_4, 'yyyy-mm-dd', 'en_AU')#" 
        BETWEEN startdate AND completedate
    </cfquery>
    
    <cfset placementno = "#getplacement.placementno#">
    <cfset remarks = "">
    <cfset tmonth = "">
    <cfset ampm = "">
        
    <cfif "#placementno#" EQ "">
        <cffile action="#writeAppend#" file="#outputfile#"
            output="#placementno#,#excel.col_1#,#excel.col_2#,#excel.col_3#,#LsDateFormat(excel.col_4, 'yyyy-mm-dd', 'English (Australian)')#,#excel.col_5#,#excel.col_6#,#excel.col_7#,#excel.col_8#,#excel.col_9#,#excel.col_10#,#excel.col_11#,#excel.col_12#,#excel.col_13#,#excel.col_14#,#excel.col_15#,#excel.col_16#,""#remarks#"",#ampm#,#tmonth#"
            addnewline="yes">
    <cfelse>
        
        <!---placementno found, check tmonth--->
        <cfif "#getplacement.timesheet#" EQ "01-31">
            <cfset tmonth = "#LsDateFormat(excel.col_4, 'm', 'English (Australian)')#">
        <cfelse>
            <cfif "#LsDateFormat(excel.col_4, 'd', 'English (Australian)')#" GTE "#Left(timesheet, 2)#"> <!--- >= left(timesheet cycle) means next payroll month reached--->
                <cfset tmonth = #LsDateFormat(DateAdd('m', 1, "#LsDateFormat(excel.col_4, 'yyyy-mm-dd', 'English (Australian)')#"), 'm', 'English (Australian)')#>
            <cfelse>
                <cfset tmonth = "#LsDateFormat(excel.col_4, 'm', 'English (Australian)')#">
            </cfif>
        </cfif>
        <!---placementno found, check tmonth--->
        
        <!---To check public holiday and override the timesheet--->
		<cfquery name="checkPH" datasource="#dts#">
            SELECT pm.ottable
            <cfloop from="1" to="30" index="i">
                ,phdate#i#, phdesp#i#
            </cfloop> 
            FROM placement pm
            LEFT JOIN icsizeid ot on pm.ottable = ot.sizeid
            WHERE PM.placementno = "#placementno#"
		</cfquery>
		
		<cfloop from="1" to="30" index="i">
		    <cfif "#LsDateFormat(excel.col_1, 'yyyy-mm-dd', 'English (Australian)')#" EQ "#evaluate('checkPH.phdate#i#')#">
                <cfset phflag = TRUE>
                <cfset remarks = "#evaluate('checkPH.phdesp#i#')#">
                <cfbreak>
            </cfif>
        </cfloop>
		<!---To check public holiday and override the timesheet--->
                
        
        <cfif "#phflag#" EQ TRUE>
            <cffile action="#writeAppend#" file="#outputfile#"
                    output="#placementno#,#excel.col_1#,PH,#excel.col_3#,#LsDateFormat(excel.col_4, 'yyyy-mm-dd', 'English (Australian)')#,#excel.col_5#,#excel.col_6#,#excel.col_7#,#excel.col_8#,#excel.col_9#,#excel.col_10#,#excel.col_11#,#excel.col_12#,#excel.col_13#,#excel.col_14#,#excel.col_15#,#excel.col_16#,""#remarks#"",#ampm#,#tmonth#"
                    addnewline="yes">
        <cfelse>
            
            <!---To check applied leave and override the timesheet--->
            <cfquery name="checkLeave" datasource=#dts#>
                SELECT startdate, enddate, startampm, endampm, leavetype, remarks, days, mgmtremarks, status
                FROM leavelist
                WHERE placementno = "#placementno#"
                AND status = "Approved"
                AND "#LsDateFormat(excel.col_4, 'yyyy-mm-dd', 'English (Australian)')#" 
                BETWEEN startdate AND enddate
            </cfquery>

            <cfif #checkLeave.recordcount# NEQ 0>
                <cfset stcol = #checkLeave.leavetype#>
                <!---Added to set timesheet according to am pm working hour, if apply am workhour will be pm [20180103 1116, ALvin]--->
                <cfif "#checkLeave.days#" EQ "0.50">
                    <cfif "#val(left(checkLeave.startampm, 2))#" LT 12>
                        <cfset starttime = '#numberformat(val(left(checkLeave.startampm, 2)), '__')+4#:#right(checkLeave.startampm, 2)#:00'>
                        <cfset endtime = '#numberformat(val(left(checkLeave.endampm, 2)), '__')+4#:#right(checkLeave.endampm, 2)#:00'>
                    <cfelse>
                        <cfset starttime = '#numberformat(val(left(checkLeave.startampm, 2)), '__')-4#:#right(checkLeave.startampm, 2)#:00'>
                        <cfset endtime = '#numberformat(val(left(checkLeave.endampm, 2)), '__')-4#:#right(checkLeave.endampm, 2)#:00'>
                    </cfif>
                <cfelse>
                    <cfset starttime = "#checkLeave.startampm#"&":00">
                    <cfset endtime = "#checkLeave.endampm#"&":00">
                </cfif>  
                <!---Added to set timesheet---> 
                    <cfif (#checkLeave.startampm# eq '00:00') AND (#checkLeave.endampm# eq '00:00')>
                        <cfset ampm = 'FULL DAY'>
                    <cfelseif #val(left(checkLeave.startampm, 2))# GTE 12>
                        <cfset ampm = 'PM'>
                    <cfelseif #val(left(checkLeave.startampm, 2))# LT 12>
                        <cfset ampm = 'AM'>
                    </cfif>
                <cfset starthour = left(#checkLeave.startampm#, 2)&':00'>
                <cfset endhour = left(#checkLeave.endampm#, 2)&':00'>
                <cfset startminute = '00:'&right(#checkLeave.startampm#, 2)>
                <cfset endminute = '00:'&right(#checkLeave.endampm#, 2)>
                <cfset workhours = #Abs(datediff('h', starthour, endhour))#&'.'&#Abs(numberformat(datediff('n', startminute, endminute),'_0'))#>
                <cfset breaktime = 0>
                <cfset remarks = "#checkLeave.remarks#">
            
                <cffile action="#writeAppend#" file="#outputfile#"
                    output="#placementno#,#excel.col_1#,#checkLeave.leavetype#,#excel.col_3#,#LsDateFormat(excel.col_4, 'yyyy-mm-dd', 'English (Australian)')#,#excel.col_5#,#excel.col_6#,#workhours#,#breaktime#,#excel.col_9#,#excel.col_10#,#excel.col_11#,#excel.col_12#,#excel.col_13#,#excel.col_14#,#excel.col_15#,#excel.col_16#,""#checkLeave.remarks#"",#ampm#,#tmonth#"
                    addnewline="yes">
                    
            <cfelse>            
                <!---No leave and PH found, replace it with timesheet provided--->
                <cffile action="#writeAppend#" file="#outputfile#"
                output="#placementno#,#excel.col_1#,#excel.col_2#,#excel.col_3#,#LsDateFormat(excel.col_4, 'yyyy-mm-dd', 'English (Australian)')#,#excel.col_5#,#excel.col_6#,#excel.col_7#,#excel.col_8#,#excel.col_9#,#excel.col_10#,#excel.col_11#,#excel.col_12#,#excel.col_13#,#excel.col_14#,#excel.col_15#,#excel.col_16#,#remarks#,#ampm#,#tmonth#"
                addnewline="yes">
                <!---No leave and PH found--->
            </cfif>
            <!---To check applied leave and override the timesheet--->
            
        </cfif>
        
    </cfif>
    
    <cfif "#writeAppend#" EQ "Write">
        <cfset writeAppend = "Append">                
    </cfif>
    
</cfloop>

   	<!---<cftry>
		<cffile action = "delete" file = "C:\NEWSYSTEM\IMS\timesheet_import_generate.xlsx">	 
	<cfcatch type="any">
		#cfcatch.message# <br>  #cfcatch.detail# 
	</cfcatch>
	</cftry>--->
        <cfabort>
    <cfheader name="Content-Type" value="csv">

	<cfheader name="Content-Disposition" value="inline; filename=#fileName#">
	<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#outputfile#">

</cfoutput>