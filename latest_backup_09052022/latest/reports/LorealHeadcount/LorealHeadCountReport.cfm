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
    
<cfset s42 = StructNew()>
<cfset s42.dataformat="@">
    
<cfset s43 = StructNew()>
<cfset s43.color="blue">
    
<cfset s44 = StructNew()>
<cfset s44.bottomborder="medium">
    
<cfset s68 = StructNew()>
<cfset s68.dataformat = "d-mmm-yy">
<!---Excel Format--->

<!---Column Width--->
<cfset columnname = 49>
<cfset columnnumbers = 14>
<cfset columnsection = 17>
<!---Column Width--->
    
<cfloop index="i" from="#form.period#" to="1" step="-1">
    
<!---Prepare period wording--->
<cfset thisperiod = ucase(left(monthAsString(i),3))>
    
<cfset lastperiod = i-1>
<cfset lastyear = getmmonth.myear>    

<cfif i eq 1>
    <cfset lastperiod = 12>
    <cfset lastyear = getmmonth.myear-1>
</cfif>
        
<cfset lastperiod = ucase(left(monthAsString(lastperiod),3))>
<!---Prepare period wording--->
    
<!---Get employee details---> 
    
<cfquery name="setrow" datasource="#dts#">
    set @row=0;
</cfquery>

<cfquery name="getheadcount" datasource="#dts#">
    SELECT * FROM (SELECT  @row := @row + 1 as row_number,sortedquery.* 
        FROM (
            SELECT * FROM (
                SELECT a.empno,UPPER(a.empname) empname,UPPER(workordid) workordid,
                UPPER(outlet1.outletname) Outlet1,UPPER(outlet1.location) Location1,
                UPPER(outlet2.outletname) Outlet2,UPPER(outlet2.location) Location2,
                UPPER(outlet3.outletname) Outlet3,UPPER(outlet3.location) Location3, 
                <!---date_format(p.dcomm,'%e-%b-%y')---> DATEDIFF(p.dcomm,'1900-01-01')+2 JoinDate,
                <!---date_format(p.dresign,'%e-%b-%y')---> DATEDIFF(p.dresign,'1900-01-01')+2 ResignedDate
                FROM assignmentslip a
                LEFT JOIN #dts_p#.pmast p
                ON a.empno=p.empno
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

                WHERE payrollperiod=#i# 
                AND (custname LIKE "%l'oreal%"  or custname like "%loreal%")
                AND placementno in (
                    SELECT placementno 
                    FROM placement 
                    WHERE jobpostype in (3,5)
                    AND (custname like "%l'oreal%"  or custname like "%loreal%")
                    AND jobstatus != '3'
                ) 
                AND a.empname NOT LIKE "%Advance Salary Permanent BA%"
                AND a.empname NOT LIKE "%CONSULTANCY FEE%"
                AND a.empname NOT LIKE "%MANAGEMENT FEE%" 
                <!---AND selftotal<>0--->
                AND (month(p.dresign) >= #i# or p.dresign="0000-00-00")
                GROUP BY a.empno

                UNION ALL

                SELECT a.empno,UPPER(a.empname) empname,UPPER(workordid) workordid,
                UPPER(outlet1.outletname) Outlet1,UPPER(outlet1.location) Location1,
                UPPER(outlet2.outletname) Outlet2,UPPER(outlet2.location) Location2,
                UPPER(outlet3.outletname) Outlet3,UPPER(outlet3.location) Location3, 
                <!---date_format(p.dcomm,'%e-%b-%y')---> DATEDIFF(p.dcomm,'1900-01-01')+2 JoinDate,
                <!---date_format(p.dresign,'%e-%b-%y')---> DATEDIFF(p.dresign,'1900-01-01')+2 ResignedDate
                FROM (
                    SELECT empno,empname FROM placement 
                    WHERE jobpostype in (3,5) 
                    AND (custname LIKE "%l'oreal%"  OR custname LIKE "%loreal%")
                    AND month(startdate)=#i# and year(startdate)=#getmmonth.myear#
                    AND jobstatus != '3'
                    AND empno<>'0'
                    GROUP BY empno
                ) a
                LEFT JOIN #dts_p#.pmast p
                ON a.empno=p.empno
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

                WHERE (dresign>='#getmmonth.myear#-01-01' OR dresign='0000-00-00')
                AND a.empname NOT LIKE "%Advance Salary Permanent BA%"
                AND a.empname NOT LIKE "%CONSULTANCY FEE%"
                AND a.empname NOT LIKE "%MANAGEMENT FEE%" 
                AND month(dcomm)=#i# and year(dcomm)=#getmmonth.myear#
                GROUP BY a.empno
    
                UNION ALL

                SELECT a.empno,UPPER(a.empname) empname,UPPER(workordid) workordid,
                UPPER(outlet1.outletname) Outlet1,UPPER(outlet1.location) Location1,
                UPPER(outlet2.outletname) Outlet2,UPPER(outlet2.location) Location2,
                UPPER(outlet3.outletname) Outlet3,UPPER(outlet3.location) Location3, 
                <!---date_format(p.dcomm,'%e-%b-%y')---> DATEDIFF(p.dcomm,'1900-01-01')+2 JoinDate,
                <!---date_format(p.dresign,'%e-%b-%y')---> DATEDIFF(p.dresign,'1900-01-01')+2 ResignedDate
                FROM (
                    SELECT empno,empname FROM placement 
                    WHERE jobpostype in (3,5) 
                    AND (custname LIKE "%l'oreal%"  OR custname LIKE "%loreal%")
                    AND (month(startdate)<=#i# and year(startdate)=#getmmonth.myear# or year(startdate)<#getmmonth.myear#)
                    AND (month(completedate)>=#i# and year(completedate)=#getmmonth.myear# or year(completedate)>#getmmonth.myear#)
                    AND jobstatus != '3'
                    AND empno<>'0'
                    GROUP BY empno
                ) a
                LEFT JOIN #dts_p#.pmast p
                ON a.empno=p.empno
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

                WHERE (dresign>='#getmmonth.myear#-01-01' OR dresign='0000-00-00')
                AND a.empname NOT LIKE "%Advance Salary Permanent BA%"
                AND a.empname NOT LIKE "%MANAGEMENT FEE%" 
                AND a.empname NOT LIKE "%CONSULTANCY FEE%"
                GROUP BY a.empno


            ) query
            GROUP BY empno
            ORDER BY workordid,empno
        ) sortedquery
    ) aa
    ORDER BY row_number
</cfquery>
<!---End Get employee details--->    
    
<!---Declare Spreadsheet Object--->
<cfset overall = SpreadSheetNew(true)> 
<!---End Declare Spreadsheet Object--->
 
<!---Add Header Data--->
<cfset SpreadSheetAddRow(overall, "L'Oreal Malaysia Sdn Bhd")>
    
<cfset SpreadSheetAddRow(overall, ",,,,,,,,,,,,,,")>
    
<cfset SpreadSheetAddRow(overall, "Headcount Reporting - CPD")>
    
<cfset SpreadSheetAddRow(overall, ",,,,,,,,,,,,,,")>
    
<cfset SpreadSheetAddRow(overall, "Month")>
    
<cfset SpreadSheetAddRow(overall, "Brand")>
    
<cfset SpreadSheetAddRow(overall, "Cost Centre")>
    
<cfset SpreadSheetAddRow(overall, ",,,,,,,,,,,,,,")>
    
<cfset SpreadSheetAddRow(overall, "NO,EMPLOYEE NO,NAME,REGION,OUTLET 1,LOCATION 1,OUTLET 2,LOCATION 2,OUTLET 3,LOCATION 3,JOIN DATE,RESIGNED DATE")>
<!---End Add Header Data--->
    
<!---Add Data in the form of query--->
<cfset SpreadSheetAddRows(overall, getheadcount)>
<!---End Add Data in the form of query--->
    
<!---Add Data outside of query--->
<cfset SpreadSheetAddRow(overall, ",,,,,,,,,,,,,,")>    

<cfset SpreadSheetAddRow(overall, ",,Total Employee Count:")>
    
    
<!---spreadsheetSetCellFormula(spreadsheetObj, formula, row, column)--->
<cfset spreadsheetSetCellFormula(overall, "COUNTA(C10:C#9+getheadcount.recordcount#)", 9+getheadcount.recordcount+2, 4)>
<!---End Add Data outside of query--->
    
<!---Cell Formatting--->
    
<!---spreadsheetFormatCellRange (spreadsheetObj, format, startRow, startColumn, endRow, endColumn)--->
<cfset SpreadSheetFormatCellRange(overall, s42, 5, 4, 5, 4)>
<cfset SpreadSheetFormatCellRange(overall, s43, 1, 1, 1, 1)>
<cfset SpreadSheetFormatCellRange(overall, s38, 1, 1, 9, 12)>
<cfset SpreadSheetFormatCellRange(overall, s41, 9, 1, getheadcount.recordcount+9, 2)>
<cfset SpreadSheetFormatCellRange(overall, s41, 9, 4, getheadcount.recordcount+9, 12)>
<cfset SpreadSheetFormatCellRange(overall, s41, 9, 3, 9, 3)>
<cfset SpreadSheetFormatCellRange(overall, s28, 9, 1, getheadcount.recordcount+9, 12)>
<cfset SpreadSheetFormatCellRange(overall, s41, 5, 3, 7, 3)>
<cfset SpreadSheetFormatCellRange(overall, s44, 3, 1, 3, 11)>
<cfset SpreadSheetFormatCellRange(overall, s68, 9, 11, getheadcount.recordcount+9, 12)>
    
<cfset spreadsheetSetColumnWidth(overall, 1, 6) >    
<cfset spreadsheetSetColumnWidth(overall, 2, 14) >
<cfset spreadsheetSetColumnWidth(overall, 3, 42) >
<cfset spreadsheetSetColumnWidth(overall, 4, 24) >
    
<cfloop index="a" from="5" to="10">
    <cfset spreadsheetSetColumnWidth(overall, a, 29) >
</cfloop>
    
<cfset spreadsheetSetColumnWidth(overall, 11, 18) >
<cfset spreadsheetSetColumnWidth(overall, 12, 18) >
    
<!---spreadsheetMergeCells(spreadsheetObj, startrow, endrow, startcolumn, endcolumn)--->
    
<cfif i eq form.period>
    <cfset spreadsheetMergeCells(overall, 1, 1, 1, 3)>

    <cfset spreadsheetMergeCells(overall, 3, 3, 1, 3)>

    <cfset spreadsheetMergeCells(overall, 5, 5, 1, 2)>
    <cfset spreadsheetMergeCells(overall, 6, 6, 1, 2)>
    <cfset spreadsheetMergeCells(overall, 7, 7, 1, 2)>
</cfif>
    
<!---End Cell Formatting--->
    
<!---Add Data after format--->
<!---spreadsheetAddColumn(spreadsheetObj, data, startrow, startcolumn, insert [, insert])--->
<cfset spreadsheetAddColumn(overall, ":", 5, 3, false)>
<cfset spreadsheetAddColumn(overall, "#thisperiod# #getmmonth.myear#", 5, 4, false)>
<cfset spreadsheetAddColumn(overall, ":", 6, 3, false)>
<cfset spreadsheetAddColumn(overall, "CPD", 6, 4, false)>
<cfset spreadsheetAddColumn(overall, ":", 7, 3, false)>
<cfset spreadsheetAddColumn(overall, "200-1101", 7, 4, false)>
<!---End Add Data after format--->
    
    
<cfif i eq form.period>
    <cfspreadsheet action="write" sheetname="HC Report CPD #thisperiod# #right(getmmonth.myear,2)#" filename="#HRootPath#\Excel_Report\HeadCount_#timenow#.xlsx" name="overall" overwrite="true">
<cfelse>
    <cfspreadsheet action="update" sheetname="HC Report CPD #thisperiod# #right(getmmonth.myear,2)#" filename="#HRootPath#\Excel_Report\HeadCount_#timenow#.xlsx" name="overall">
</cfif>
    
<cfif isdefined('overall')>
    <cfset StructDelete(Variables,"overall")>
</cfif>
    
</cfloop>
    
<cfset filename = "L'Oreal Headcount Report - #ucase(left(monthAsString(form.period),3))# #getmmonth.myear#_#timenow#">
    
<!---Added by Nieo 20180605 0951 to eliminate the error show when there is no file generated---> 
<cfif fileExists("#HRootPath#\Excel_Report\HeadCount_#timenow#.xlsx") eq false>
    
    <script>
        alert("No File Generated due to no data for the selected month.");
        window.close();
    </script>
    <cfabort>
        
</cfif>
<!---Added by Nieo 20180605 0951 to eliminate the error show when there is no file generated---> 
    
<cfheader name="Content-Disposition" value="inline; filename=#filename#.xlsx">
<cfcontent type="application/vnd.ms-excel" deletefile="no" file="#HRootPath#\Excel_Report\HeadCount_#timenow#.xlsx">
    
</cfoutput>