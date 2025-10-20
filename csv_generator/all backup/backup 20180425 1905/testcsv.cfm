<cfoutput>
<cfsetting showdebugoutput="Yes">

<cfset dateNow = #dateformat(now(), 'yyyymmdd-hhmmss')#>
<cfset fileName = "timesheet_#dateNow#.csv">
<cfset firstTime = TRUE>
<cfset writeAppend = "WRITE">
<cfset lastRow = "50">
<cfset srcFile = "#ExpandPath('samsung_june.xls')#">			<!---change excel file--->
<cfset stcol = "">
<cfset outputfile = "#GetDirectoryFromPath('*.*')#"&"#filename#">
<cfset workhours = "0.00">
<cfset breaktime = "1">

<cfloop list="#SpreadSheetInfo(SpreadsheetRead(srcFile)).SHEETNAMES#" index="a">
	
	<cfspreadsheet action="read" src="#srcFile#" sheetname="#a#" query="queryData">
	<cfspreadsheet action="read" src="#srcFile#" sheetname="#a#" rows="6" query="placementEmpno">
	
	<cfloop query="queryData" startrow="11" endrow="#50#">
		<cfif #queryData.col_1# eq "">
			<cfset lastrow = #queryData.currentRow#>		
		</cfif>
	</cfloop>

	<cfset lastrow = #val(lastrow)# - 1>
	<cfset tsrowcount = 0>
	
	<cfloop query="queryData" startrow="11" endrow="#val(lastrow)#">
		
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
		
		<cfif #val(queryData.col_10)# EQ 0>
			<cfset workhours = "0.00">
			<cfset breaktime = "0">
		<cfelse>
			<cfset workhours = #TimeFormat(LsParseNumber(queryData.col_10)/1440, 'HH.nn')#>
			<cfset breaktime = "0">
		</cfif>
		
		<cfif #queryData.col_1# EQ "01/05/2017">
			<cfset starttime = "00:00:00">
		<cfelseif #queryData.col_4# EQ "">
			<cfset starttime = "00:00:00">
		<cfelse>
			<cfset starttime = "#TimeFormat(queryData.col_4, 'HH:nn:ss')#">	
		</cfif>
		
		<cfif #queryData.col_1# EQ "01/05/2017">
			<cfset endtime = "00:00:00">
		<cfelseif #queryData.col_4# EQ "">
			<cfset endtime = "00:00:00">
		<cfelse>
			<cfset endtime = "#TimeFormat(queryData.col_7, 'HH:nn:ss')#">	
		</cfif>

		<cffile action="#writeAppend#" file="#outputfile#"
				output="#placementEmpno.col_3#,#placementEmpno.col_2#,#stcol#,#tsrowcount#,#LsDateFormat(queryData.col_1, 'yyyy-mm-dd', 'English (Australian)')#,#starttime#,#endtime#,#workhours#,#breaktime#,0,0,0,0,0,0,0,0,#queryData.col_17#"
				addnewline="yes">
		
		<cfset tsrowcount += 1>
	</cfloop>
	
	
        
</cfloop>  
    
    <cfheader name="Content-Type" value="csv">

	<cfheader name="Content-Disposition" value="inline; filename=#fileName#">
	<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#outputfile#">
     
</cfoutput>