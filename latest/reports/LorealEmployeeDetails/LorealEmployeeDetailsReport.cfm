<!---Loreal RepORt Version 2.0--->
<cfoutput>
    
<cfset dts_p = replace(dts,'_i','_p')>
    
<cfquery name="getComp_qry" datasource="#dts#">
	SELECT * FROM gsetup
</cfquery>
    
<cfquery name="getmmonth" datasource="#dts#">
    SELECT mmonth,myear FROM payroll_main.gsetup WHERE comp_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#replace(dts,'_i','')#">
</cfquery>

<cfset lastyear = getmmonth.myear-1>

<cfset lastyeardts_p = replace(dts,'_i','#right(lastyear,2)#_p')>
    
<cfset lastyeardts_i = replace(dts,'_i','#right(lastyear,2)#_i')>
    
<!---Prepare temp excel file to write data--->
<cfset currentDirectORy = "#Hrootpath#\Excel_RepORt\">
    
<cfset timenow = "#DateTimeformat(now(), 'yyyymmddhhnnss')#">
    
<cfif DirectORyExists(currentDirectORy) eq false>
    <cfdirectORy action = "create" directORy = "#currentDirectORy#" >
</cfif>
<!---Prepare temp excel file to write data--->
    
<!---Excel format--->
<cfset s67 = StructNew()>
<cfset s67.dataformat="_(* ##,####0.00_);_(* (##,####0.00);_(* \-??_);_(@_)">
    
<cfset s23 = StructNew()>                                   
<cfset s23.font="Arial">
<cfset s23.fontsize="11">
<cfset s23.bold="true">
<cfset s23.textwrap="true">    
<cfset s23.alignment="center">
<cfset s23.verticalalignment="vertical_center">
<cfset s23.topbORder="medium">
<cfset s23.leftbORder="medium">
<cfset s23.rightbORder="medium">
<cfset s23.dataformat="0.0">
    
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
<cfset s26.bottombORder="thin">
    
<cfset s27 = StructNew()>                                   
<cfset s27.font="Arial">
<cfset s27.fontsize="11">
<cfset s27.bold="true">
<cfset s27.alignment="left">
<cfset s27.verticalalignment="vertical_bottom">
<cfset s27.bottombORder="thin">
    
<cfset s28 = StructNew()>
<cfset s28.bottombORder="thin">
<cfset s28.topbORder="thin">
<cfset s28.leftbORder="thin">
<cfset s28.rightbORder="thin">
    
<cfset s29 = StructNew()>                                   
<cfset s29.font="Arial">
<cfset s29.fontsize="11">
<cfset s29.bold="true">
<cfset s29.textwrap="true">    
<cfset s29.alignment="center">
<cfset s29.verticalalignment="vertical_center">
<cfset s29.topbORder="medium">
    
<cfset s30 = StructNew()>                  
<cfset s30.bottombORder="double">
<cfset s30.bold="true">
    
<cfset s31 = StructNew()>                                   
<cfset s31.font="Arial">
<cfset s31.fontsize="11">
<cfset s31.bold="true">
<cfset s31.textwrap="true">    
<cfset s31.alignment="center">
<cfset s31.verticalalignment="vertical_center">
<cfset s31.leftbORder="medium">
<cfset s31.rightbORder="medium">
    
<cfset s32 = StructNew()>                                   
<cfset s32.font="Arial">
<cfset s32.fontsize="11">
<cfset s32.bold="true">
<cfset s32.textwrap="true">    
<cfset s32.alignment="center">
<cfset s32.verticalalignment="vertical_center">
<cfset s32.bottombORder="medium">
    
<cfset s33 = StructNew()>                                   
<cfset s33.font="Arial">
<cfset s33.fontsize="11">
<cfset s33.textwrap="true">    
<cfset s33.alignment="center">
<cfset s33.verticalalignment="vertical_center">
<cfset s33.rightbORder="medium">
    
<cfset s34 = StructNew()>
<cfset s34.bold="true">
<cfset s34.textwrap="true">    
<cfset s34.alignment="center">
<cfset s34.verticalalignment="vertical_center">
    
<cfset s35 = StructNew()>                                   
<cfset s35.dataformat="0.0">
    
<cfset s36 = StructNew()>                                   
<cfset s36.font="Arial">
<cfset s36.fontsize="11">
<cfset s36.bold="true">
<cfset s36.textwrap="true">    
<cfset s36.alignment="center">
<cfset s36.verticalalignment="vertical_center">
<cfset s36.topbORder="medium">
<cfset s36.leftbORder="medium">
<cfset s36.rightbORder="medium">
<cfset s36.dataformat="0.0">
    
<cfset s39 = StructNew()>    
<cfset s39.underline="true">
<cfset s39.bold="true">
    
<cfset s40 = StructNew()>    
<cfset s40.alignment="center">
    
<cfset s68 = StructNew()>
<cfset s68.dataformat = "d-mmm-yy">
<!---Excel format--->
    
<!---Column Width--->
<cfset columnname = 49>
<cfset columnnumbers = 14>
<cfset columnsection = 17>
<!---Column Width--->
    
<cfloop index="a" FROM="#form.period#" to="1" step="-1">    

<!---Prepare period wORding--->
<cfset thisperiod = ucase(left(monthAsString(a),3))>
    
<cfset nextperiod = a+1>
<cfset nextyear = getmmonth.myear>    

<cfif a eq 12>
    <cfset nextperiod = 1>
    <cfset nextyear = getmmonth.myear+1>
</cfif>
        
<cfset nextperiodnum = nextperiod>
        
<cfset nextperiod = ucase(left(monthAsString(nextperiod),3))>
    
<cfset lastperiod = a-1>
<cfset lastyear = getmmonth.myear>    

<cfif a eq 1>
    <cfset lastperiod = 12>
    <cfset lastyear = getmmonth.myear-1>
</cfif>
        
<cfset lastperiodnum = lastperiod>
<!---Prepare period wORding--->
    
<cfquery name="getdata" datasource="#dts#">
    SELECT * FROM (
        
        SELECT a.empno,UPPER(empname) empname,"200-1101" as cost_centre,UPPER(workordid) workordid,
        CASE WHEN sex='F' THEN "FEMALE" ELSE "MALE" END as sex,
        CASE WHEN race='C' THEN "CHINESE" 
        ELSE 
            CASE WHEN race='M' THEN "MALAY" 
            ELSE
                CASE WHEN race='I' THEN "INDIA" 
                ELSE "OTHER" 
                END
            END
        END as race,
        case when length(trim(nricn)) = 12 then concat(substr(nricn,1,6),'-',substr(nricn,7,2),'-',substr(nricn,9,4)) else nricn end nricn,
        UPPER(jtitle) jtitle,
        <!---UPPER(date_format(dcomm,'%e-%b-%y'))---> DATEDIFF(dcomm,'1900-01-01')+2 DateofHire,
        <!---UPPER(date_format(dresign,'%e-%b-%y'))--->DATEDIFF(dresign,'1900-01-01')+2 DateofCessation,
        sumcustusualpay as Basic, dcomm, dresign
        FROM (
			SELECT *,sum(custusualpay) sumcustusualpay FROM assignmentslip
            WHERE payrollperiod between 1 AND #a# 
            AND month(completedate) = #a#  
            AND (custname LIKE "%l'oreal%"  OR custname LIKE "%loreal%")
            GROUP BY empno,payrollperiod
            HAVING sumcustusualpay
            ORDER BY payrollperiod desc
            ) a
        LEFT JOIN #dts_p#.pmast pm
        on a.empno=pm.empno
        WHERE (dresign>='#getmmonth.myear#-01-01' OR dresign='0000-00-00')
        AND dcomm <='#getmmonth.myear#-#a#-#daysinmonth(createdate(getmmonth.myear,a,1))#'
        AND placementno in (
            SELECT placementno FROM placement WHERE jobpostype in (3,5) 
            AND (custname LIKE "%l'oreal%"  OR custname LIKE "%loreal%")
            AND jobstatus != '3'
        )
        AND a.empname NOT LIKE "%Advance Salary Permanent BA%"
        AND a.empname NOT LIKE "%CONSULTANCY FEE%"
        AND a.empname NOT LIKE "%MANAGEMENT FEE%" 
    
        
        <cfif getmmonth.myear eq 2018>
            UNION 

            SELECT a.empno,UPPER(empname) empname,"200-1101" as cost_centre,UPPER(workordid) workordid,
            CASE WHEN sex='F' THEN "FEMALE" ELSE "MALE" END as sex,
            CASE WHEN race='C' THEN "CHINESE" 
            ELSE 
                CASE WHEN race='M' THEN "MALAY" 
                ELSE
                    CASE WHEN race='I' THEN "INDIA" 
                    ELSE "OTHER" 
                    END
                END
            END as race,
            case when length(trim(nricn)) = 12 then concat(substr(nricn,1,6),'-',substr(nricn,7,2),'-',substr(nricn,9,4)) else nricn end nricn,
            UPPER(jtitle) jtitle,
            <!---UPPER(date_format(dcomm,'%e-%b-%y'))---> DATEDIFF(dcomm,'1900-01-01')+2 DateofHire,
            <!---UPPER(date_format(dresign,'%e-%b-%y'))--->DATEDIFF(dresign,'1900-01-01')+2 DateofCessation,
            sumcustusualpay as Basic, dcomm, dresign
            FROM (
                SELECT *,0 sumcustusualpay FROM #lastyeardts_i#.assignmentslip
                WHERE payrollperiod between 12 AND 12 
                AND (custname LIKE "%l'oreal%"  OR custname LIKE "%loreal%")
                GROUP BY empno,payrollperiod
                ORDER BY payrollperiod desc
                ) a
            LEFT JOIN #dts_p#.pmast pm
            on a.empno=pm.empno
            WHERE (dresign>='#getmmonth.myear-1#-01-01' OR dresign='0000-00-00')
            AND placementno in (
                SELECT placementno FROM #lastyeardts_i#.placement 
                WHERE jobpostype in (3,5) 
                AND (custname LIKE "%l'oreal%"  OR custname LIKE "%loreal%")
                AND jobstatus != '3'
            )
            AND pm.empno in ('100121611',
            '100127738',
            '100137734',
            '100129919')
        </cfif>
        <!---New Hire--->
        UNION 

        SELECT a.empno,UPPER(empname) empname,"200-1101" as cost_centre,UPPER(workordid) workordid,
        CASE WHEN sex='F' THEN "FEMALE" ELSE "MALE" END as sex,
        CASE WHEN race='C' THEN "CHINESE" 
        ELSE 
            CASE WHEN race='M' THEN "MALAY" 
            ELSE
                CASE WHEN race='I' THEN "INDIA" 
                ELSE "OTHER" 
                END
            END
        END as race,
        case when length(trim(nricn)) = 12 then concat(substr(nricn,1,6),'-',substr(nricn,7,2),'-',substr(nricn,9,4)) else nricn end nricn,
        UPPER(jtitle) jtitle,
        DATEDIFF(dcomm,'1900-01-01')+2 DateofHire,
        DATEDIFF(dresign,'1900-01-01')+2 DateofCessation,
        sumcustusualpay as Basic, dcomm, dresign
        FROM (
            SELECT empno,empname,cast(employee_rate_1 AS DECIMAL(15,5)) sumcustusualpay FROM placement 
            WHERE jobpostype in (3,5) 
            AND (custname LIKE "%l'oreal%"  OR custname LIKE "%loreal%")
            AND month(startdate)=#a# and year(startdate)=#getmmonth.myear#
            AND jobstatus != '3'
            AND empno<>'0'
            GROUP BY empno
            ) a
        LEFT JOIN #dts_p#.pmast pm
        on a.empno=pm.empno
        WHERE (dresign>='#getmmonth.myear#-01-01' OR dresign='0000-00-00')
        AND dcomm <='#getmmonth.myear#-#a#-#daysinmonth(createdate(getmmonth.myear,a,1))#'
        AND a.empname NOT LIKE "%Advance Salary Permanent BA%"
        AND a.empname NOT LIKE "%CONSULTANCY FEE%"
        AND a.empname NOT LIKE "%MANAGEMENT FEE%" 
        AND month(dcomm)=#a# and year(dcomm)=#getmmonth.myear#
        <!---New Hire--->
        <!---Maternity Leave--->
        UNION 

            SELECT a.empno,UPPER(empname) empname,"200-1101" as cost_centre,UPPER(workordid) workordid,
            CASE WHEN sex='F' THEN "FEMALE" ELSE "MALE" END as sex,
            CASE WHEN race='C' THEN "CHINESE" 
            ELSE 
                CASE WHEN race='M' THEN "MALAY" 
                ELSE
                    CASE WHEN race='I' THEN "INDIA" 
                    ELSE "OTHER" 
                    END
                END
            END as race,
            case when length(trim(nricn)) = 12 then concat(substr(nricn,1,6),'-',substr(nricn,7,2),'-',substr(nricn,9,4)) else nricn end nricn,
            UPPER(jtitle) jtitle,
            DATEDIFF(dcomm,'1900-01-01')+2 DateofHire,
            DATEDIFF(dresign,'1900-01-01')+2 DateofCessation,
            sumcustusualpay as Basic, dcomm, dresign
            FROM (
                SELECT empno,empname,cast(employee_rate_1 AS DECIMAL(15,5)) sumcustusualpay FROM placement 
                WHERE jobpostype in (3,5) 
                AND (custname LIKE "%l'oreal%"  OR custname LIKE "%loreal%")
                AND month(startdate)>=1 and year(startdate)=#getmmonth.myear#
                AND jobstatus != '3'
                AND empno<>'0'
                GROUP BY empno
                ) a
            LEFT JOIN #dts_p#.pmast pm
            on a.empno=pm.empno
            WHERE (dresign>='#getmmonth.myear#-01-01' OR dresign='0000-00-00')
            AND dcomm <='#getmmonth.myear#-#a#-#daysinmonth(createdate(getmmonth.myear,a,1))#'
            AND a.empname NOT LIKE "%Advance Salary Permanent BA%"
            AND a.empname NOT LIKE "%CONSULTANCY FEE%"
            AND a.empname NOT LIKE "%MANAGEMENT FEE%" 
        <!---Maternity Leave--->
        
    
    ) data
    GROUP BY empno
    ORDER BY workordid,empno
</cfquery>
    
<cfset columnwidth = "11,38,9,18,8,8,16,16,13,11,13">
    
<!---Add 1st sheets--->
        
    <cfset data = SpreadSheetNew(true)>
      
    <cfset SpreadSheetAddRow(data, "Company Name : L'OREAL MALAYSIA SDN BHD")>    
    
    <cfset SpreadSheetAddRow(data, "Report Title, :  Employee Detail ")>  
        
    <cfset SpreadSheetAddRow(data, "For Year #getmmonth.myear#")>  
    
    <!---spreadsheetAddColumn(spreadsheetObj, data, startrow, startcolumn, insert [, insert])--->
     <cfset spreadsheetAddColumn(data, "Ended", 1, 10, false)>
        
    <cfset spreadsheetAddColumn(data, "#thisperiod#-#right(getmmonth.myear,2)#", 1, 11, false)>
        
    <cfset spreadsheetAddColumn(data, "For Month:", 3, 10, false)>
        
    <cfset spreadsheetAddColumn(data, "#nextperiod#-#right(nextyear,2)#", 3, 11, false)>
        
    <cfset SpreadSheetAddRow(data, ",,")>
        
    <cfset SpreadSheetAddRow(data, ",,")>
        
        
    <!---Add Header---> 
    <cfset SpreadSheetAddRow(data, "EMPLOYEE NUM,NAME,COST CENTRE,REGION,GENDER,RACE,IC NO,JOB TITLE DESC,DATE JOIN,DATE RESIGN,BASIC SALARY #getmmonth.myear#")>   
        
    <cfquery name="getactualdata" dbtype="query">
        SELECT empno,empname,cost_centre,wORkORdid,
        sex,race,nricn,jtitle,DateofHire,DateofCessation,Basic 
        FROM getdata
    </cfquery>
        
    <cfset SpreadSheetAddRows(data, getactualdata)>
        
    <cfset SpreadSheetAddRow(data, ",,")>
        
    <cfset SpreadSheetAddRow(data, ",Total Employee Count")>
        
    <cfset spreadsheetSetCellFormula(data, "COUNTA(A7:A#6+getactualdata.recordcount#)", 6+getactualdata.recordcount+2, 3)>
        
    <cfquery name="getleavingbefore" dbtype="query">
        SELECT * FROM getdata     
        WHERE dresign is not null and dresign != '' and dresign <= #createdate(lastyear,lastperiodnum,daysinmonth(createdate(lastyear,lastperiodnum,01)))#
    </cfquery>
        
    <cfset SpreadSheetAddRow(data, ",Active headcount for the month")>
        
    <cfset spreadsheetSetCellFormula(data, "COUNTA(A7:A#6+getactualdata.recordcount#)-#getleavingbefore.recordcount#", 6+getactualdata.recordcount+3, 3)>
        
    <cfquery name="getleavingafter" dbtype="query">
        SELECT * FROM getdata     
        WHERE dresign is not null and dresign != '' and dresign <= #createdate(getmmonth.myear,a,daysinmonth(createdate(getmmonth.myear,a,01)))#     
    </cfquery>
        
    <cfset SpreadSheetAddRow(data, ",Closing active headcount")>
        
    <cfset spreadsheetSetCellFormula(data, "COUNTA(A7:A#6+getactualdata.recordcount#)-#getleavingafter.recordcount#", 6+getactualdata.recordcount+4, 3)>
    
    <!---Format table--->
        
    <!---spreadsheetFormatCellRange (spreadsheetObj, format, startRow, startColumn, endRow, endColumn)--->
    <cfset SpreadSheetFormatCellRange(data, s28, 6, 1, 6+getactualdata.recordcount, 11)>
        
    <cfset SpreadSheetFormatCellRange(data, s68, 6, 9, 6+getactualdata.recordcount, 10)>
        
    <cfset SpreadSheetFormatCellRange(data, s67, 6, 11, 6+getactualdata.recordcount, 11)>
        
    <cfset SpreadSheetFormatCellRange(data, s34, 6, 1, 6, 11)>
        
    <cfset SpreadSheetFormatCellRange(data, s40, 6, 1, 6+getactualdata.recordcount, 1)>        
    
    <cfset SpreadSheetFormatCellRange(data, s40, 6, 3, 6+getactualdata.recordcount, 7)>
        
    <cfset SpreadSheetFormatCellRange(data, s40, 6, 9, 6+getactualdata.recordcount, 10)>
        
    <cfset count = 1>
        
    <cfloop index="i" list="#columnwidth#">
        <cfset spreadsheetSetColumnWidth(data, count, i)>
        <cfset count += 1>
    </cfloop>
        
    <!---spreadsheetSetRowHeight(spreadsheetObj, rowNumber, height)--->    
    <cfset spreadsheetSetRowHeight(data, 6, 55)>
        
    <!---Format table--->
        
    <cfif a eq form.period>
        <cfspreadsheet action="write" sheetname="#thisperiod# #right(getmmonth.myear,2)#" filename="#HRootPath#\Excel_RepORt\Employee_Details_#timenow#.xlsx" name="data" overwrite="true"> 
    <cfELSE>
        <cfspreadsheet action="update" sheetname="#thisperiod# #right(getmmonth.myear,2)#" filename="#HRootPath#\Excel_RepORt\Employee_Details_#timenow#.xlsx" name="data"> 
    </cfif>
        
    <cfif isdefined('data')>
        <cfset StructDelete(Variables,"data")>
    </cfif>
        
</cfloop>
        
<!---Add 1st sheets--->
        
<cfset filename = "L'Oreal Employee detail #ucase(left(monthAsString(form.period),3))# #getmmonth.myear#_#timenow#">
        
<!---Added by Nieo 20180605 0951 to eliminate the errOR show when there is no file generated---> 
<cfif fileExists("#HRootPath#\Excel_RepORt\Employee_Details_#timenow#.xlsx") eq false>
    
    <script>
        alert("No File Generated due to no data for the selected month.");
        window.close();
    </script>
    <cfabORt>
        
</cfif>
<!---Added by Nieo 20180605 0951 to eliminate the errOR show when there is no file generated---> 
    
<cfheader name="Content-Disposition" value="inline; filename=#filename#.xlsx">
<cfcontent type="application/vnd.ms-excel" deletefile="no" file="#HRootPath#\Excel_RepORt\Employee_Details_#timenow#.xlsx">
    
</cfoutput>