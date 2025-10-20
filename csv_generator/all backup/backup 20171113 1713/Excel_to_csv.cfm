<cfoutput>
<cfsetting showdebugoutput="Yes" requestTimeOut="0">

<cfset dateNow = #dateformat(now(), 'yyyymmdd-hhmmss')#>
<cfset fileName = "timesheet_#dateNow#.csv">
<cfset firstTime = TRUE>
<cfset writeAppend = "WRITE">
<cfset lastRow = "50">
<cfset lastRowMonth = "">
<cfset srcFile = "#ExpandPath('../../../timesheet_import_generate.xlsx')#">			<!---change excel file--->
<cfset stcol = "">
<cfset outputfile = "#GetDirectoryFromPath('*.*')#"&"#filename#">
<cfset workhours = "0.00">
<cfset breaktime = "1">

<cfloop list="#SpreadSheetInfo(SpreadsheetRead(srcFile)).SHEETNAMES#" index="a">

	<cfinvoke component="createTimesheet" method="createTimesheet" returnvariable="firsttimestatus">
        <cfinvokeargument name="dts" value="#dts#">
        <cfinvokeargument name="a" value="#a#">
        <cfinvokeargument name="dateNow" value="#dateNow#">
        <cfinvokeargument name="fileName" value="#fileName#">
        <cfinvokeargument name="firstTime" value="#firstTime#">
        <cfinvokeargument name="writeAppend" value="#writeAppend#">
        <cfinvokeargument name="lastRow" value="#lastRow#">
        <cfinvokeargument name="lastRowMonth" value="#lastRowMonth#">
        <cfinvokeargument name="srcFile" value="#srcFile#">
        <cfinvokeargument name="stcol" value="#stcol#">
        <cfinvokeargument name="outputfile" value="#outputfile#">
        <cfinvokeargument name="workhours" value="#workhours#">
        <cfinvokeargument name="breaktime" value="#breaktime#">
    </cfinvoke>
    
    <cfset firstTime = #firsttimestatus#>
	
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