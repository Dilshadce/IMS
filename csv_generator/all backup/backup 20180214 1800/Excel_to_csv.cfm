<cfoutput>
<cfsetting showdebugoutput="Yes" requestTimeOut="0">

<cfset dateNow = #dateformat(now(), 'yyyymmdd-hhmmss')#>
<cfset fileName = "timesheet_#dateNow#.csv">
<cfset firstTime = TRUE>
<cfset writeAppend = "WRITE">
<cfset lastRow = "50">
<cfset lastRowMonth = "">
<cfset srcFile = "#ExpandPath('../importfile/timesheet_import_generate.xlsx')#">			<!---change excel file--->
<cfset stcol = "">
<cfset outputfile = "#ExpandPath('../#fileName#')#">
<cfset workhours = "0.00">
<cfset breaktime = "1">

<cfloop list="#SpreadSheetInfo(SpreadsheetRead(srcFile)).SHEETNAMES#" index="a">

	<cfspreadsheet action="read" src="#srcFile#" sheetname="#a#" query="queryData">
	<cfspreadsheet action="read" src="#srcFile#" sheetname="#a#" rows="6" query="placementEmpno">
	
	<cfset client_ref = #ListFirst(placementEmpno.col_1, ' ')#>
	<cfset placementno = "">
	<cfset empno = "">
    <cfset startrow = "">

    <cfquery name="getClientEmp" datasource="#replace(dts, '_i', '_p')#">
	    SELECT empno FROM pmast WHERE client_ref_id = "#client_ref#" 
	</cfquery>
  
    <cfloop query="queryData" startrow="11" endrow="50">
        <cfif #startrow# EQ "">
            <cfquery name="getfirstrow" datasource="#dts#">
                SELECT placementno, startdate FROM placement WHERE "#LsDateFormat(queryData.col_1, 'YYYY-MM-DD', 'English (Australian)')#"
                BETWEEN startdate AND completedate
                AND empno = "#getClientEmp.empno#"
            </cfquery>
            <!---Added to skip those timesheet before the actual placement startdate--->
            <cfif #getfirstrow.recordcount# NEQ 0>
                <cfset startrow = #queryData.currentRow#>
                <cfset importMonth = #queryData.col_1#>
            </cfif>
        </cfif>
        
		<cfif #queryData.col_1# eq "">
			<cfset lastrow = #queryData.currentRow#>
			<cfbreak>
		</cfif>
	</cfloop>
  
    <cfif #startrow# EQ "">
        <cfset startrow = 11>
    </cfif>
   
    <cfif #getClientEmp.recordcount# NEQ 0>
	    <cfquery name="getPlacement" datasource="#dts#">
	        SELECT placementno, startdate FROM placement WHERE "#LsDateFormat(importMonth, 'YYYY-MM-DD', 'English (Australian)')#"
	        BETWEEN startdate AND completedate
	        AND empno = "#getClientEmp.empno#"
	        AND jobstatus = '2'
	    </cfquery>
	    
	    <cfset empno = "#getClientEmp.empno#">
	    <cfif #getPlacement.recordcount# NEQ 0>
	        <cfset placementno = "#getPlacement.placementno#">
        <cfelse>
            <cfset placementno = "#placementEmpno.col_1#">
        </cfif>
	<cfelse>
	    <cfset placementno = "#placementEmpno.col_1#">
	    <cfset empno = "#placementEmpno.col_1#">
	</cfif>
    
	

	<cfset lastrow = #val(lastrow)# - 1>
	<cfset tsrowcount = 0>
	<cfspreadsheet action="read" src="#srcFile#" sheetname="#a#" rows="#lastrow#" query="monthData">
	<cfset lastRowMonth = "#month(monthData.col_1)#">

	<cfloop query="queryData" startrow="#startrow#" endrow="#val(lastrow)#">
        
        <cfset ampm = "">
        <cfset remarks = "">
        
		<cfif #firstTime# EQ TRUE>
			<cfset writeAppend = "WRITE">
			<cfset firstTime = FALSE>
		<cfelse>
			<cfset writeAppend = "APPEND">
		</cfif>

		<cfif #queryData.col_3# EQ "OFF">
			<cfset stcol = "OD">
		<cfelseif #queryData.col_3# EQ "REST">
			<cfset stcol = "RD">
		<cfelseif #queryData.col_3# EQ "a">
			<cfset stcol = "">
		<cfelse>
			<cfset stcol = "what">
		</cfif>
		
		<cfif #queryData.col_17# EQ "Absent">								<!---to set NPL if absent remark detected--->
			<cfset stcol = "NPL">
		</cfif>

		<cfif #val(queryData.col_10)# EQ 0>
			<cfset workhours = "0.00">
			<cfset breaktime = "0">
		<cfelse>
			<!---<cfset workhours = #TimeFormat(LsParseNumber(queryData.col_10)/1440, 'HH.nn')#>--->
			<cfset workhours = #TimeFormat(queryData.col_10, 'HH.nn')#>
			<cfset breaktime = "0">
		</cfif>
       
		<!---<cfif #queryData.col_1# EQ "01/05/2017"> 							<!---labour day--->
			<cfset starttime = "00:00:00">--->
		<cfif #queryData.col_4# EQ "">
			<cfset starttime = "00:00:00">
		<cfelse>
			<cfset starttime = "#TimeFormat(queryData.col_4, 'HH:nn:ss')#">
		</cfif>

		<!---<cfif #queryData.col_1# EQ "01/05/2017">							<!---labour day--->
			<cfset endtime = "00:00:00">--->
		<cfif #queryData.col_7# EQ "">
			<cfset endtime = "00:00:00">
			<cfset starttime = "00:00:00">
			
			<cfif #queryData.col_3# NEQ "OFF" AND #queryData.col_3# NEQ "REST">
            	<cfset stcol = "NPL">
            </cfif>
            
		<cfelse>
			<cfset endtime = "#TimeFormat(queryData.col_7, 'HH:nn:ss')#">
		</cfif>
		
		<cfset remarks = "#queryData.col_17#">
		
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
		    <cfif "#LsDateFormat(queryData.col_1, 'yyyy-mm-dd', 'English (Australian)')#" EQ "#evaluate('checkPH.phdate#i#')#">
                <cfif "#starttime#" EQ "00:00:00" AND "#endtime#" EQ "00:00:00">
                    <cfset stcol = "PH">
                    <cfset starttime = "00:00:00">
                    <cfset endtime = "00:00:00">
                    <cfset ampm = ''>
                    <cfset workhours = "0">
                    <cfset breaktime = 0>
                    <cfset remarks = "#evaluate('checkPH.phdesp#i#')#">
                   <cfbreak>
                <cfelse>
                    <cfset stcol = "PH">
                </cfif>
            </cfif>
        </cfloop>
		<!---To check public holiday and override the timesheet--->
		
		<!---To check applied leave and override the timesheet--->
		<cfquery name="checkLeave" datasource=#dts#>
		    SELECT startdate, enddate, startampm, endampm, leavetype, remarks, days, mgmtremarks, status
            FROM leavelist
            WHERE placementno = "#placementno#"
            AND status = "Approved"
            AND "#LsDateFormat(queryData.col_1, 'yyyy-mm-dd', 'English (Australian)')#" 
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
                <cfelseif #val(left(checkLeave.startampm, 2))# gte 12>
                    <cfset ampm = 'PM'>
                <cfelseif #val(left(checkLeave.startampm, 2))# lt 12>
                    <cfset ampm = 'AM'>
                </cfif>
            <cfset starthour = left(#checkLeave.startampm#, 2)&':00'>
            <cfset endhour = left(#checkLeave.endampm#, 2)&':00'>
            <cfset startminute = '00:'&right(#checkLeave.startampm#, 2)>
            <cfset endminute = '00:'&right(#checkLeave.endampm#, 2)>
            <cfset workhours = #Abs(datediff('h', starthour, endhour))#&'.'&#Abs(numberformat(datediff('n', startminute, endminute),'_0'))#>
            <cfset breaktime = 0>
            <cfset remarks = "#checkLeave.remarks#">
        </cfif>
        <!---To check applied leave and override the timesheet--->

		<cffile action="#writeAppend#" file="#outputfile#"
				output="#placementno#,#empno#,#stcol#,#tsrowcount#,#LsDateFormat(queryData.col_1, 'yyyy-mm-dd', 'English (Australian)')#,#starttime#,#endtime#,#workhours#,#breaktime#,0,0,0,0,0,0,0,0,""#remarks#"",#ampm#,#lastRowMonth#"
				addnewline="yes">

		<cfset tsrowcount += 1>
	</cfloop>

</cfloop>

   	<!---<cftry>
		<cffile action = "delete" file = "C:\NEWSYSTEM\IMS\timesheet_import_generate.xlsx">	 
	<cfcatch type="any">
		#cfcatch.message# <br>  #cfcatch.detail# 
	</cfcatch>
	</cftry>--->
        
    <cfheader name="Content-Type" value="csv">

	<cfheader name="Content-Disposition" value="inline; filename=#fileName#">
	<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#outputfile#">

</cfoutput>