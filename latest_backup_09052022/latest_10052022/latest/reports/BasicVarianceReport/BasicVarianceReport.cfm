<!---Loreal Report Version 2.0--->
<cfoutput>
    
<cfset dts_p = replace(dts,'_i','_p')>
    
<cfquery name="getComp_qry" datasource="#dts#">
	SELECT * FROM gsetup
</cfquery>
    
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
    
<cfset thisperiod = ucase(left(monthAsString(form.period),3))>
    
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
    
<cfset s28 = StructNew()>
<cfset s28.bottomborder="thin">
<cfset s28.topborder="thin">
<cfset s28.leftborder="thin">
<cfset s28.rightborder="thin">
    
<cfset s29 = StructNew()>  
<cfset s29.fontsize="11">
<cfset s29.alignment="center">
    
<cfset s30 = StructNew()>                  
<cfset s30.bottomborder="double">
<cfset s30.topborder="thin">
<cfset s30.color="red">
    
<cfset s31 = StructNew()>  
<cfset s31.fontsize="11">
<cfset s31.alignment="left">
    
<cfset s32 = StructNew()>  
<cfset s32.fontsize="11">
<cfset s32.alignment="right">
<cfset s32.bold="true">
    
<cfset s33 = StructNew()>                  
<cfset s33.bottomborder="double">
<cfset s33.topborder="thin">
    
<cfset s34 = StructNew()>
<cfset s34.bottomborder="thin">
<cfset s34.topborder="thin">
<cfset s34.leftborder="thin">
<cfset s34.rightborder="thin">
<cfset s34.bold="true">
<cfset s34.alignment="center">
    
<cfset s35 = StructNew()>
<cfset s35.topborder="thin">

<cfset s36 = StructNew()>
<cfset s36.color="red">
    
<cfset s68 = StructNew()>
<cfset s68.dataformat = "d-mmm-yy">
<!---Excel Format--->
    
<!---Column Width--->
<cfset columnname = 40>
<cfset columnnumbers = 19>
<cfset columnsection = 17>
<!---Column Width--->
    
<cfset pagecount = 0>
    
<cfloop index="a" from="#form.period#" to="1" step="-1">
    
<cfset overall = SpreadSheetNew(true)>
    
<cfset lastperiod = #a#-1>
<cfset lastyear = getmmonth.myear>    

<cfif a eq 1>
    <cfset lastperiod = 12>
    <cfset lastyear = getmmonth.myear-1>
        
    <cfset lastmonth = 12>
<cfelse>
    <cfset lastmonth = #a#-1>
</cfif>
    
<cfset firstdaythis = createdate("#getmmonth.myear#","#a#","01")>
<cfset lastdaythis = createdate("#getmmonth.myear#","#a#","#daysinmonth(createdate("#getmmonth.myear#","#a#","01"))#")>
    
<cfset firstdaylast = createdate("#lastyear#","#lastmonth#","01")>
<cfset lastdaylast = createdate("#lastyear#","#lastmonth#","#daysinmonth(createdate("#lastyear#","#lastmonth#","01"))#")>
    
<cfif a lte getmmonth.mmonth>

    <cfquery name="getpayrolldata" datasource="#dts#">
    SELECT "",pm.empno,pm.name,
        <!---date_format(dcomm,'%e-%b-%Y')---> DATEDIFF(dcomm,'1900-01-01')+2 dcomm,
        <!---date_format(dcomm,'%e-%b-%Y')---> DATEDIFF(dresign,'1900-01-01')+2 dresign,
        coalesce(p.basic,0) as A,coalesce(presalary,0) as B, 
        (coalesce(p.basic,0)-coalesce(presalary,0)) as "diff"
    FROM #dts_p#.pmast pm
    LEFT JOIN (
        SELECT empno,custname,
        sum(
            custsalary
            <cfloop  index="aa" from="1" to="18">
                + coalesce(case when allowance#aa#= 11 then coalesce(awer#aa#,0) else 0 end,0)
            </cfloop>
        ) basic 
        FROM assignmentslip 
        WHERE ((placementno in (
            SELECT placementno FROM placement 
            WHERE (custname like "%l'oreal%" or custname like "%loreal%")
            AND jobpostype in (3,5)
            )        
        AND month(completedate)=#a#)
        OR include="Y")
        AND payrollperiod=#a#
        GROUP BY empno
    ) p
    on pm.empno=p.empno
    LEFT JOIN ( 
        SELECT empno,custname,
        sum(
            custsalary
            <cfloop  index="aa" from="1" to="18">
                + coalesce(case when allowance#aa#= 11 then coalesce(awer#aa#,0) else 0 end,0)
            </cfloop>
        ) presalary 
        FROM <cfif lastmonth eq 12>#replace(dts,'_i','#right(lastyear,2)#_i')#.</cfif>assignmentslip 
        WHERE (( placementno in (
        SELECT placementno FROM <cfif lastmonth eq 12>#replace(dts,'_i','#right(lastyear,2)#_i')#.</cfif>placement 
        WHERE  (custname like "%l'oreal%" or custname like "%loreal%")
        AND jobpostype in (3,5)
        )    
    AND month(completedate)=#lastmonth#)
    OR include="Y")
    AND payrollperiod=#lastmonth#
    GROUP BY empno
    ) pl
    on pm.empno=pl.empno
    WHERE pm.name not like "%Advance Salary Permanent BA%"
    GROUP BY pm.empno
    having diff<>0
    ORDER BY pm.empno
    </cfquery>

    <cfif getpayrolldata.recordcount neq 0> 

        <cfquery  name="getcurrenttotal" datasource="#dts#">
        SELECT sum(
            custsalary
            <cfloop  index="aa" from="1" to="18">
                + coalesce(case when a.allowance#aa#= 11 then coalesce(a.awer#aa#,0) else 0 end,0)
            </cfloop>
            ) as ctotal 
        FROM assignmentslip a
        LEFT JOIN placement p
        on a.placementno=p.placementno 
        WHERE payrollperiod=#a# 
        AND a.empname not like "%Advance Salary Permanent BA%"
        AND (((a.custname like "%l'oreal%" or a.custname like "%loreal%")
        AND month(a.completedate)=#a#
        AND p.jobpostype in (3,5))
        OR include="Y")
        <!---AND selftotal --->   
        </cfquery>

        <cfquery  name="getlasttotal" datasource="#dts#">
        SELECT sum(
            custsalary
            <cfloop  index="aa" from="1" to="18">
                + coalesce(case when a.allowance#aa#= 11 then coalesce(a.awer#aa#,0) else 0 end,0)
            </cfloop>
            ) ltotal 
        FROM <cfif lastmonth eq 12>#replace(dts,'_i','#right(lastyear,2)#_i')#.</cfif>assignmentslip a
        LEFT JOIN <cfif lastmonth eq 12>#replace(dts,'_i','#right(lastyear,2)#_i')#.</cfif>placement p
        on a.placementno=p.placementno 
        WHERE payrollperiod=#lastmonth# 
        AND a.empname not like "%Advance Salary Permanent BA%"
        AND (((a.custname like "%l'oreal%" or a.custname like "%loreal%")
        AND month(a.completedate)=#lastmonth#
        AND p.jobpostype in (3,5))
        OR include="Y")
        <!---AND selftotal--->    
        </cfquery>
        
        <!---spreadsheetAddColumn(spreadsheetObj, data, startrow, startcolumn, insert [, insert])--->

        <cfset SpreadSheetAddRow(overall, ",,,,,,,,,,,,,,")>

        <cfset SpreadSheetAddRow(overall, ",,,,,,,,,,,,,,")>

        <cfset SpreadSheetAddRow(overall, ",COMPANY")>
            
        <cfset spreadsheetAddColumn(overall, "MANPOWER BUSINESS SOLUTIONS (M) SDN BHD", 3, 4, false)>

        <cfset SpreadSheetAddRow(overall, ",REPORT TITLE")>
            
        <cfset spreadsheetAddColumn(overall, "VARIANCE REPORT ON BASIC SALARY", 4, 4, false)>

        <cfset SpreadSheetAddRow(overall, ",PERIOD")>
            
        <cfset spreadsheetAddColumn(overall, "#ucase(monthasstring(a))# #getmmonth.myear# VS #ucase(monthasstring(lastmonth))# #lastyear#", 5, 4, false)>

        <cfset SpreadSheetAddRow(overall, ",,,,,,,,,,,,,,")>

        <cfset SpreadSheetAddRow(overall, ",,,Basic Salary (#monthasstring(a)# #getmmonth.myear# Payroll Register)/")>
            
        <cfset spreadsheetAddColumn(overall, "#getcurrenttotal.ctotal#", 7, 7, false)>

        <cfset SpreadSheetAddRow(overall, ",,,Basic Salary (#monthasstring(lastmonth)# #lastyear# Payroll Register)/")>
            
        <cfset spreadsheetAddColumn(overall, "#getlasttotal.ltotal#", 8, 7, false)>
            
        <cfset SpreadSheetAddRow(overall, ",,,Variance,,,#val(getcurrenttotal.ctotal) - val(getlasttotal.ltotal)#")>
            
        <cfset SpreadSheetAddRow(overall, ",,,,,,,,,,,,,,")>

        <cfset SpreadSheetAddRow(overall, ",,,,,,,,,,,,,,")>
            
        <cfset SpreadSheetAddRow(overall, ",,,DATE,DATE,(A),(B),(A)-(B)")>
        
        <cfset SpreadSheetAddRow(overall, ",EMPLOYEE NO.,EMPLOYEE NAME,HIRE,RESIGN,#ucase(monthasstring(a))#,#ucase(monthasstring(lastmonth))#,VARIANCE")>
            
        <cfset SpreadSheetAddRows(overall,getpayrolldata)>
            
        <cfset SpreadSheetAddRow(overall, ",,TOTAL,,,,,#val(getcurrenttotal.ctotal) - val(getlasttotal.ltotal)#")>
            
        <cfset SpreadSheetAddRow(overall, ",,,,,,,,,,,,,,")>

        <cfset SpreadSheetAddRow(overall, ",,,,,,,,,,,,,,")>
        
        <cfset SpreadSheetAddRow(overall, ",,,,,,,,,,,,,,")>

        <cfset SpreadSheetAddRow(overall, ",,Prepared By:,,Checked By:,,Validated By:,,,,,,,,")>
            
        <cfloop index="i" from="1" to="6">
            <cfset SpreadSheetAddRow(overall, ",,,,,,,,,,,,,,")>    
        </cfloop>
            
        <cfset SpreadSheetAddRow(overall, ",,Janet Leong,,Piriya Rajikeli,,Joey Wong,,,,,,,,")>
            
        <cfset SpreadSheetAddRow(overall, ",,Payroll & Billing Executive,,Manager Pay and Bill")>
            
        <cfset spreadsheetAddColumn(overall, "Payroll & Administrative Executive", getpayrolldata.recordcount+26, 7, false)>
            
        <!---Formatting--->
            
        <!---spreadsheetFormatCellRange (spreadsheetObj, format, startRow, startColumn, endRow, endColumn)--->
        <cfset SpreadSheetFormatCellRange(overall, s67, 14, 6, getpayrolldata.recordcount+14, 8)>
        <cfset SpreadSheetFormatCellRange(overall, s67, 7, 7, 9, 7)>
            
        <cfset SpreadSheetFormatCellRange(overall, s29, 3, 4, 5, 4)>
            
        <cfset SpreadSheetFormatCellRange(overall, s29, 14, 2, getpayrolldata.recordcount+14, 5)>
            
        <cfif (val(getcurrenttotal.ctotal) - val(getlasttotal.ltotal)) lt 0>
            
            <cfset SpreadSheetFormatCellRange(overall, s30, 9, 7, 9, 7)>
            <cfset SpreadSheetFormatCellRange(overall, s36, getpayrolldata.recordcount+14, 8, getpayrolldata.recordcount+14, 8)>
                
        <cfelse>
            
            <cfset SpreadSheetFormatCellRange(overall, s33, 9, 7, 9, 7)>
        
        </cfif>
            
        <cfset SpreadSheetFormatCellRange(overall, s31, 14, 3, getpayrolldata.recordcount+13, 3)>
            
        <cfset SpreadSheetFormatCellRange(overall, s32, getpayrolldata.recordcount+14, 3, getpayrolldata.recordcount+14, 3)>
            
        <cfset SpreadSheetFormatCellRange(overall, s34, 12, 2, 13, 8)>
            
        <cfset SpreadSheetFormatCellRange(overall, s28, 14, 2, getpayrolldata.recordcount+14, 8)>   
            
        <cfset SpreadSheetFormatCellRange(overall, s35, getpayrolldata.recordcount+25, 3, getpayrolldata.recordcount+25, 3)>
            
        <cfset SpreadSheetFormatCellRange(overall, s35, getpayrolldata.recordcount+25, 5, getpayrolldata.recordcount+25, 5)>
            
        <cfset SpreadSheetFormatCellRange(overall, s35, getpayrolldata.recordcount+25, 7, getpayrolldata.recordcount+25, 7)>
            
        <cfset SpreadSheetFormatCellRange(overall, s68, 14, 4, getpayrolldata.recordcount+14, 5)>
            
        <cfloop index="i" from="1" to="9">
              <cfset spreadsheetSetColumnWidth(overall, i, columnnumbers) >
        </cfloop> 
            
        <cfset spreadsheetSetColumnWidth(overall, 3, columnname) >
            
        <cfloop query="getpayrolldata">
            <cfif getpayrolldata.diff lt 0>
                <cfset SpreadSheetFormatCellRange(overall, s36, getpayrolldata.currentrow+13, 8, getpayrolldata.currentrow+13, 8)>
            </cfif>
        </cfloop>
        
        <cfif pagecount eq 0>
            
            <!---anchor: startRow,startColumn,endRow,endColumn--->
            <cfset SpreadsheetAddImage(overall,"#hrootpath#/latest/reports/BasicVarianceReport/BasicVarianceSignature1.PNG","#getpayrolldata.recordcount+20#,3,#getpayrolldata.recordcount+24#,4")>

            <cfset SpreadsheetAddImage(overall,"#hrootpath#/latest/reports/BasicVarianceReport/BasicVarianceSignature2.PNG","#getpayrolldata.recordcount+22#,5,#getpayrolldata.recordcount+25#,6")>

            <!---Formatting--->

            <cfspreadsheet action="write" sheetname="#ucase(left(monthasstring(a),3))# #getmmonth.myear#" filename="#HRootPath#\Excel_Report\Basic_Variance_Report_#timenow#.xlsx" name="overall" overwrite="true">
                
            <cfset pagecount += 1>

        <cfelse>

            <cfspreadsheet action="update" sheetname="#ucase(left(monthasstring(a),3))# #getmmonth.myear#" filename="#HRootPath#\Excel_Report\Basic_Variance_Report_#timenow#.xlsx" name="overall">
                
            <cfset pagecount += 1>

        </cfif>

    </cfif>
        
</cfif>
    
</cfloop>
                
<cfset filename = "Basic Salary Variance Report #thisperiod# #getmmonth.myear#_#timenow#">
    
<cfheader name="Content-Disposition" value="inline; filename=#filename#.xlsx">
<cfcontent type="application/vnd.ms-excel" deletefile="no" file="#HRootPath#\Excel_Report\Basic_Variance_Report_#timenow#.xlsx">
    
</cfoutput>