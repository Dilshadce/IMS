<!---Loreal Report Version 2.0--->
<cfoutput>
    
<cfset dts_p = replace(dts,'_i','_p')>
    
<cfquery name="getmmonth" datasource="#dts#">
    SELECT mmonth,myear FROM payroll_main.gsetup WHERE comp_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#replace(dts,'_i','')#">
</cfquery>
    
<!---Prepare temp excel file to write data--->
<cfset currentDirectory = "#Hrootpath#\Excel_Report\">
    
<cfset timenow = "#DateTimeFormat(now(), 'yyyymmddhhnnss')#">
    
<cfif DirectoryExists(currentDirectory) eq false>
    <cfdirectory action = "create" directory = "#currentDirectory#" >
</cfif>
<!---Prepare temp excel file to write data--->
    
<!---Excel Format--->
<cfset s67 = StructNew()>
<cfset s67.dataformat="_(* ##,####0.00_);_(* (##,####0.00);_(* \-??_);_(@_)">

<cfset s23 = StructNew()>                                   
<cfset s23.font="Arial">
<cfset s23.fontsize="11">
<cfset s23.bold="true">
<cfset s23.textwrap="true">
<cfset s23.alignment="center">
<cfset s23.verticalalignment="vertical_center">
<cfset s23.bottomborder="medium">
<cfset s23.topborder="medium">
<cfset s23.leftborder="medium">
<cfset s23.rightborder="medium">

<cfset s24 = StructNew()>                                   
<cfset s24.font="Arial">
<cfset s24.fontsize="11">
<cfset s24.bold="true">
<cfset s24.alignment="left">
<cfset s24.verticalalignment="vertical_bottom">

<cfset s25 = StructNew()>                                   
<cfset s25.font="Arial">
<cfset s25.fontsize="11">
<cfset s25.bold="true">
<cfset s25.alignment="right">
<cfset s25.verticalalignment="vertical_bottom">

<cfset s26 = StructNew()>                                   
<cfset s26.font="Arial">
<cfset s26.fontsize="11">
<cfset s26.bold="true">
<cfset s26.alignment="right">
<cfset s26.verticalalignment="vertical_bottom">
<cfset s26.bottomborder="thin">

<cfset s27 = StructNew()>                                   
<cfset s27.font="Arial">
<cfset s27.fontsize="11">
<cfset s27.bold="true">
<cfset s27.alignment="left">
<cfset s27.verticalalignment="vertical_bottom">
<cfset s27.bottomborder="thin">

<cfset s28 = StructNew()>
<cfset s28.bottomborder="thin">
<cfset s28.topborder="thin">
<cfset s28.leftborder="thin">
<cfset s28.rightborder="thin">
<cfset s28.textwrap="true">  

<cfset s30 = StructNew()>                  
<cfset s30.bottomborder="double">
<cfset s30.bold="true">
    
<cfset s31 = StructNew()>                                   
<cfset s31.font="Arial">
<cfset s31.fontsize="11">
<cfset s31.bold="true">
<cfset s31.textwrap="true">    
<cfset s31.alignment="center">
<cfset s31.verticalalignment="vertical_center">
<cfset s31.leftborder="medium">
<cfset s31.rightborder="medium">
    
<cfset s32 = StructNew()>                                   
<cfset s32.font="Arial">
<cfset s32.fontsize="11">
<cfset s32.bold="true">
<cfset s32.textwrap="true">    
<cfset s32.alignment="center">
<cfset s32.verticalalignment="vertical_center">
<cfset s32.bottomborder="medium">
    
<cfset s33 = StructNew()>                                   
<cfset s33.font="Arial">
<cfset s33.fontsize="11">
<cfset s33.textwrap="true">    
<cfset s33.alignment="center">
<cfset s33.verticalalignment="vertical_center">
<cfset s33.rightborder="medium">
    
<cfset s34 = StructNew()>                                   
<cfset s34.font="Arial">
<cfset s34.fontsize="11">
<cfset s34.bold="true">
<cfset s34.textwrap="true">    
<cfset s34.alignment="center">
<cfset s34.verticalalignment="vertical_center">
<cfset s34.topborder="medium">
<cfset s34.bottomborder="medium">
    
<cfset s35 = StructNew()>                                   
<cfset s35.dataformat="0.0">
    
<cfset s36 = StructNew()>                                   
<cfset s36.font="Arial">
<cfset s36.fontsize="11">
<cfset s36.bold="true">
<cfset s36.textwrap="true">    
<cfset s36.alignment="center">
<cfset s36.verticalalignment="vertical_center">
<cfset s36.topborder="medium">
<cfset s36.leftborder="medium">
<cfset s36.rightborder="medium">
    
<cfset s37 = StructNew()>    
<cfset s37.alignment="center">
    
<cfset s38 = StructNew()>    
<cfset s38.bold="true">
    
<cfset s39 = StructNew()>    
<cfset s39.underline="true">
    
<cfset s40 = StructNew()>    
<cfset s40.textwrap="true">
 
<cfset s41 = StructNew()>
<cfset s41.alignment="center">
    
<cfset s68 = StructNew()>
<cfset s68.dataformat = "d-mmm-yy">
<!---Excel Format--->

<!---Column Width--->
<cfset columnname = 49>
<cfset columnnumbers = 14>
<cfset columnsection = 17>
<!---Column Width--->
    
<!---Prepare period wording--->
<cfset thisperiod = ucase(left(monthAsString(form.period),3))>
    
<cfset lastperiod = form.period-1>
<cfset lastyear = getmmonth.myear>    

<cfif form.period eq 1>
    <cfset lastperiod = 12>
    <cfset lastyear = getmmonth.myear-1>
</cfif>
        
<cfset lastperiod = ucase(left(monthAsString(lastperiod),3))>
<!---Prepare period wording--->
    
<!---Get new hire employees--->    
<cfquery name="getnewemp" datasource="#dts#">
    SELECT p.empno,empname,
    case when length(trim(nricn)) = 12 then concat(substr(nricn,1,6),'-',substr(nricn,7,2),'-',substr(nricn,9,4)) else nricn end nricn,
    <!---date_format(dcomm,'%e-%b-%Y')---> DATEDIFF(dcomm,'1900-01-01')+2 startdate,cast(employee_rate_1 AS DECIMAL(15,5)) basic,workordid,
    UPPER(concat(
            case when outlet1.outletname is not null then outlet1.outletname else "" end," ",
            case when outlet1.location is not null then outlet1.location else "" end,
            case when outlet2.outletname is not null then " & " else "" end,
            case when outlet2.outletname is not null then outlet2.outletname else "" end," ",
            case when outlet2.location is not null then outlet2.location else "" end,
            case when outlet3.outletname is not null then " & " else "" end,
            case when outlet3.outletname is not null then outlet3.outletname else "" end," ",
            case when outlet3.location is not null then outlet3.location else "" end
        )) worklocation,
    "" remarks
    FROM placement p
    LEFT JOIN #dts_p#.pmast pm
    ON p.empno=pm.empno
    
    <!---Store Name--->
    left join 
    (
    SELECT * FROM #dts_p#.outletlocation
    WHERE outletno=1) outlet1
    on p.empno=outlet1.empno
    left join 
    (
    SELECT * FROM #dts_p#.outletlocation
    WHERE outletno=2) outlet2
    on p.empno=outlet2.empno
    left join 
    (
    SELECT * FROM #dts_p#.outletlocation
    WHERE outletno=3) outlet3
    on p.empno=outlet3.empno
    <!---Store Name--->
    
    WHERE month(startdate)=#form.period# 
    AND year(startdate)=#getmmonth.myear# 
    AND year(completedate)>=#getmmonth.myear# 
    AND jobpostype = 5
    AND (custname like "%l'oreal%"  or custname like "%loreal%")
    AND p.jobstatus != '3'
    AND p.empno<>'0'
    AND p.empno != '100137734'<!---Consultancy Fee--->
    AND p.empno not in (
        SELECT empno FROM placement 
        WHERE (custname like "%l'oreal%"  or custname like "%loreal%")
        AND jobstatus != '3'
        AND jobpostype = 5
        AND year(completedate)=#getmmonth.myear-1# 
        AND month(completedate)=12
    )
</cfquery>
<!---End Get new hire employees--->    

<!---Get resigned employees---> 
<cfquery name="getresignemp" datasource="#dts#">
    SELECT p.empno,empname,<!---date_format(pm.dtender,'%e-%b-%y')---> DATEDIFF(pm.dtender,'1900-01-01')+2 tenderdate,<!---date_format(pm.dresign,'%e-%b-%y')---> DATEDIFF(pm.dlastphysical,'1900-01-01')+2 physicaldate,<!---date_format(pm.dresign,'%e-%b-%y')---> DATEDIFF(pm.dresign,'1900-01-01')+2 payrolldate,workordid,"Not stated in resignation letter" reason,"" remarks
    FROM placement p
    LEFT JOIN #dts_p#.pmast pm
    ON p.empno=pm.empno
    WHERE month(pm.dresign)=#form.period#  
    AND year(pm.dresign)=#getmmonth.myear# 
    AND year(completedate)>=#getmmonth.myear# 
    AND jobpostype = 5
    AND (custname like "%l'oreal%"  or custname like "%loreal%")
    AND p.jobstatus != '3'
    AND p.empno<>'0'
    GROUP BY p.empno
</cfquery>
<!---End Get resigned employees---> 
    
<cfset overall = SpreadSheetNew(true)> 
    
<cfset SpreadSheetAddRow(overall, "MANPOWER BUSINESS SOLUTIONS SDN BHD")>
    
<cfset SpreadSheetAddRow(overall, ",,,,,,,,,,,,,,")>
    
<cfset SpreadSheetAddRow(overall, "STAFF TURNOVER REPORT - #thisperiod# #getmmonth.myear#")>
    
<cfset SpreadSheetAddRow(overall, ",,,,,,,,,,,,,,")>
    
<cfif getnewemp.recordcount neq 0>
    
    <cfset SpreadSheetAddRow(overall, "NEW HIRE LIST")>

    <cfset SpreadSheetAddRow(overall, "EMPLOYEE NO,EMPLOYEE NAME, NRIC,JOIN DATE,BASIC SALARY,REGION,LOCATION OF WORK,REMARKS")>

    <!---Add Data in the form of query--->
    <cfset SpreadSheetAddRows(overall, getnewemp)>
    <!---End Add Data in the form of query--->
        
    <cfset SpreadSheetAddRow(overall, ",,,,,,,,,,,,,,")>
    <cfset SpreadSheetAddRow(overall, ",,,,,,,,,,,,,,")>
    
</cfif>
    
<cfif getresignemp.recordcount neq 0>

    <cfset SpreadSheetAddRow(overall, "RESIGNATION LIST")>

    <cfset SpreadSheetAddRow(overall, "EMPLOYEE ID,EMPLOYEE NAME, TENDER DATE,LAST PHYSICAL DATE,LAST PAYROLL DATE,REGION,REASON OF RESIGNATION,REMARKS")>

    <!---Add Data in the form of query--->
    <cfset SpreadSheetAddRows(overall, getresignemp)>
    <!---End Add Data in the form of query--->
    
</cfif>
    
<!---Cell Formatting--->
    
<!---spreadsheetFormatCellRange (spreadsheetObj, format, startRow, startColumn, endRow, endColumn)--->
        
<cfif getnewemp.recordcount neq 0>
    
    <cfset SpreadSheetFormatCellRange(overall, s67, 7, 5, getnewemp.recordcount+6, 5)>

    <cfset SpreadSheetFormatCellRange(overall, s68, 7, 4, getnewemp.recordcount+6, 4)>

    <cfset SpreadSheetFormatCellRange(overall, s28, 6, 1, getnewemp.recordcount+6, 8)>

    <cfset SpreadSheetFormatCellRange(overall, s37, 6, 1, getnewemp.recordcount+6, 1)>

    <cfset SpreadSheetFormatCellRange(overall, s37, 6, 3, getnewemp.recordcount+6, 4)>

    <cfset SpreadSheetFormatCellRange(overall, s37, 6, 6, getnewemp.recordcount+6, 8)>

    <cfset SpreadSheetFormatCellRange(overall, s38, 1, 1, 6, 8)>
        
</cfif>
        
<cfif getnewemp.recordcount eq 0>
    <cfset startprintline = 5>
    <cfset printline = 6>
<cfelse>
    <cfset startprintline = 8>
    <cfset printline = 10>
</cfif>

<cfset SpreadSheetFormatCellRange(overall, s38, getnewemp.recordcount+startprintline, 1, getnewemp.recordcount+printline, 8)>
    
<cfif getresignemp.recordcount neq 0>
    
    <cfset SpreadSheetFormatCellRange(overall, s28, getnewemp.recordcount+printline, 1, getresignemp.recordcount+getnewemp.recordcount+printline, 8)>
        
    
</cfif>
    
<cfif getnewemp.recordcount neq 0>
    
    <cfset SpreadSheetFormatCellRange(overall, s37, getnewemp.recordcount+10, 1, getresignemp.recordcount+getnewemp.recordcount+10, 1)>

    <cfset SpreadSheetFormatCellRange(overall, s37, getnewemp.recordcount+10, 3, getresignemp.recordcount+getnewemp.recordcount+10, 6)>
        
    <cfset SpreadSheetFormatCellRange(overall, s68, getnewemp.recordcount+10, 3, getresignemp.recordcount+getnewemp.recordcount+10, 6)>
        
<cfelse>
    
    <cfset SpreadSheetFormatCellRange(overall, s68, getnewemp.recordcount+7, 3, getresignemp.recordcount+getnewemp.recordcount+7, 6)>
    
</cfif>
    
<cfset SpreadSheetFormatCellRange(overall, s39, 1, 1, 1, 1)>
    
<cfset SpreadSheetFormatCellRange(overall, s39, 3, 1, 3, 1)>
    
<cfif getnewemp.recordcount neq 0>
    
    <cfset SpreadSheetFormatCellRange(overall, s40, 6, 1, 6, 8)>

    <cfset SpreadSheetFormatCellRange(overall, s40, getnewemp.recordcount+10, 1, getnewemp.recordcount+10, 8)>

    <cfset SpreadSheetFormatCellRange(overall, s41, 6, 2, 6, 2)>

    <cfset SpreadSheetFormatCellRange(overall, s41, 6, 5, 6, 5)>

    <cfset SpreadSheetFormatCellRange(overall, s41, getnewemp.recordcount+10, 2, getnewemp.recordcount+10, 2)>

    <cfset SpreadSheetFormatCellRange(overall, s41, getnewemp.recordcount+10, 7, getnewemp.recordcount+10, 8)>
    
</cfif>
    
<cfset spreadsheetSetColumnWidth(overall, 1, 10) >

<cfset spreadsheetSetColumnWidth(overall, 7, 36) >
    
<!---End Cell Formatting--->
    
<!---Add Image--->
    
<!---anchor: startRow,startColumn,endRow,endColumn--->
<cfif getresignemp.recordcount neq 0>
    
    <cfif getnewemp.recordcount eq 0>
        <cfset startprintline = 8>
        <cfset printline = 16>
    <cfelse>
        <cfset startprintline = 12>
        <cfset printline = 20>
    </cfif>
    
    <cfset SpreadsheetAddImage(overall,"#hrootpath#/latest/reports/StaffTurnover/signature.PNG","#getresignemp.recordcount+getnewemp.recordcount+startprintline#,4,#getresignemp.recordcount+getnewemp.recordcount+printline#,8")>

<cfelse>
    
    <cfset SpreadsheetAddImage(overall,"#hrootpath#/latest/reports/StaffTurnover/signature.PNG","#getresignemp.recordcount+getnewemp.recordcount+8#,4,#getresignemp.recordcount+getnewemp.recordcount+16#,8")>
    
</cfif>
    
<!---End Add Image--->
    
<cfspreadsheet action="write" sheetname="STAFF TURNOVER - PERM BA" filename="#HRootPath#\Excel_Report\Staff_Turnover_#timenow#.xlsx" name="overall" overwrite="true">
    
<cfset filename = "Staff turnover #thisperiod# #getmmonth.myear#_#timenow#">
            
<!---Added by Nieo 20180605 0951 to eliminate the error show when there is no file generated---> 
<cfif fileExists("#HRootPath#\Excel_Report\Staff_Turnover_#timenow#.xlsx") eq false>
    
    <script>
        alert("No File Generated due to no data for the selected month.");
        window.close();
    </script>
    <cfabort>
        
</cfif>
<!---Added by Nieo 20180605 0951 to eliminate the error show when there is no file generated---> 
    
<cfheader name="Content-Disposition" value="inline; filename=#filename#.xlsx">
<cfcontent type="application/vnd.ms-excel" deletefile="no" file="#HRootPath#\Excel_Report\Staff_Turnover_#timenow#.xlsx">
    
</cfoutput>