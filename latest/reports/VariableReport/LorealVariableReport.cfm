<!---Loreal Report Version 1.0--->
<cfoutput>
    
<cfquery name="getmmonth" datasource="#dts#">
    SELECT mmonth,myear FROM payroll_main.gsetup WHERE comp_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#replace(dts,'_i','')#">
</cfquery>
    
<cfquery name="getvariabledata" datasource="#dts#">
SELECT a.empno,replace(replace(group_concat( distinct a.placementno),a.placementno,""),",","") old_jo, a.placementno current_jo,empname,nricn,workordid,
dcomm,dresign,
selfusualpay as BasicRate,
sum(0
<cfloop  index="a" from="1" to="6">
    + coalesce(case when fixawcode#a#= 110 then coalesce(fixawee#a#,0) else 0 end,0)
</cfloop>
<cfloop  index="a" from="1" to="18">
    + coalesce(case when allowance#a#= 110 then coalesce(awee#a#,0) else 0 end,0)
</cfloop>
) as SalesIncentive,
sum(0
<cfloop  index="a" from="1" to="6">
    + coalesce(case when fixawcode#a#= 111 then coalesce(fixawee#a#,0) else 0 end,0)
</cfloop>
<cfloop  index="a" from="1" to="18">
    + coalesce(case when allowance#a#= 111 then coalesce(awee#a#,0) else 0 end,0)
</cfloop>
) as ExtraIncentive,
sum(0
<cfloop  index="a" from="1" to="6">
    + coalesce(case when fixawcode#a#= 112 then coalesce(fixawee#a#,0) else 0 end,0)
</cfloop>
<cfloop  index="a" from="1" to="18">
    + coalesce(case when allowance#a#= 112 then coalesce(awee#a#,0) else 0 end,0)
</cfloop>
) as BackPayIncentive,
sum(0
<cfloop  index="a" from="1" to="6">
    + coalesce(case when fixawcode#a#= 124 then coalesce(fixawee#a#,0) else 0 end,0)
</cfloop>
<cfloop  index="a" from="1" to="18">
    + coalesce(case when allowance#a#= 124 then coalesce(awee#a#,0) else 0 end,0)
</cfloop>
) as ProductIncentive,
sum(0
<cfloop  index="a" from="1" to="6">
    + coalesce(case when fixawcode#a#= 110 then coalesce(fixawee#a#,0) else 0 end,0)
</cfloop>
<cfloop  index="a" from="1" to="18">
    + coalesce(case when allowance#a#= 110 then coalesce(awee#a#,0) else 0 end,0)
</cfloop>
    
<cfloop  index="a" from="1" to="6">
    + coalesce(case when fixawcode#a#= 111 then coalesce(fixawee#a#,0) else 0 end,0)
</cfloop>
<cfloop  index="a" from="1" to="18">
    + coalesce(case when allowance#a#= 111 then coalesce(awee#a#,0) else 0 end,0)
</cfloop>
    
<cfloop  index="a" from="1" to="6">
    + coalesce(case when fixawcode#a#= 112 then coalesce(fixawee#a#,0) else 0 end,0)
</cfloop>
<cfloop  index="a" from="1" to="18">
    + coalesce(case when allowance#a#= 112 then coalesce(awee#a#,0) else 0 end,0)
</cfloop>
    
<cfloop  index="a" from="1" to="6">
    + coalesce(case when fixawcode#a#= 124 then coalesce(fixawee#a#,0) else 0 end,0)
</cfloop>
<cfloop  index="a" from="1" to="18">
    + coalesce(case when allowance#a#= 124 then coalesce(awee#a#,0) else 0 end,0)
</cfloop>
) as TotalIncentive,
sum(0
<cfloop  index="a" from="1" to="6">
    + coalesce(case when fixawcode#a#= 6 then coalesce(fixawee#a#,0) else 0 end,0)
</cfloop>
<cfloop  index="a" from="1" to="18">
    + coalesce(case when allowance#a#= 6 then coalesce(awee#a#,0) else 0 end,0)
</cfloop>
) as TotalReimbursement,
selfothour2,
selfot2,
selfothour3,
selfot3,
selfothour4,
selfot4,
(selfothour2+selfothour3+selfothour4) as selfothourtotal,
selfottotal,
"" as Remark
 
FROM assignmentslip a
LEFT JOIN #replace(dts,'_i','_p')#.pmast p
ON a.empno=p.empno
WHERE payrollperiod=#form.period#
AND custname like "%l'oreal%"
GROUP BY a.empno
</cfquery>
    
<!---Excel Format--->
<cfset s67 = StructNew()>
<cfset s67.dataformat="0.00">
    
<cfset s23 = StructNew()>                                   
<cfset s23.font="Arial">
<cfset s23.fontsize="11">
<cfset s23.bold="true">
<cfset s23.alignment="center">
<cfset s23.verticalalignment="vertical_bottom">
<cfset s23.bottomborder="medium">
    
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
    
<cfset s30 = StructNew()>                  
<cfset s30.bottomborder="double">
<!---Excel Format--->
    
<!---Add 1st sheets--->
<cfset overall = SpreadSheetNew(true)>
    
<cfset SpreadSheetAddRow(overall, ",,Company Name:L'OREAL MALAYSIA SDN BHD,,,,,,,,,,,#left(monthAsString(getmmonth.mmonth),3)#,#getmmonth.myear#")>
    
<cfset SpreadSheetAddRow(overall, ",,Report ID: Variable Report,,,,,,,,,,,#left(monthAsString(getmmonth.mmonth-1),3)#,#getmmonth.myear#")>
    
<cfset SpreadSheetAddRow(overall, ",,,,,,,,,,,,,,")>
    
<cfset SpreadSheetAddRow(overall, "Employee ID,Old Job Order No,Current Job Order No,Employee Name,NRIC No,Section,Date of Hire,Date of Cessation,Basic Rate #getmmonth.myear#,Sales Incentive (TIER 1 + TIER 2),Extra Incentive,Back Pay Incentive (TIER 1 + TIER 2),Product incentive,Total Incentive,Total Reimbursement,OT 1.5 Normal (Hour),OT 1.5 Total (RM),OT 2.0 OFF/PH (Hour),OT 2.0 Total (RM),OT 3.0 O/T (Hour/Rate),OT 3.0 Total (RM),1.5+2.0+3.0 Total Number of OT (Hour),1.5+2.0+3.0 Total Number of OT (RM),Remark")>
    
<cfset SpreadSheetAddRows(overall, getvariabledata)>
    
<cfset tbasic = 0>
<cfset tsales = 0>
<cfset textra = 0>    
<cfset tbackpay = 0>
<cfset tproduct = 0>
<cfset tincentive = 0>
<cfset treimburse = 0>
<cfset t15h = 0>
<cfset t15amt = 0>
<cfset t20h = 0>
<cfset t20amt = 0>
<cfset t30h = 0>
<cfset t30amt = 0>
<cfset tothour = 0>
<cfset totamt = 0>
    
<cfloop query="getvariabledata">
    <cfset tbasic = val(tbasic) + val(getvariabledata.BasicRate)>
    <cfset tsales = val(tsales) + val(getvariabledata.SalesIncentive)>
    <cfset textra = val(textra) + val(getvariabledata.ExtraIncentive)>    
    <cfset tbackpay = val(tbackpay) + val(getvariabledata.BackPayIncentive)>
    <cfset tproduct = val(tproduct) + val(getvariabledata.ProductIncentive)>
    <cfset tincentive = val(tincentive) + val(getvariabledata.TotalIncentive)>
    <cfset treimburse = val(treimburse) + val(getvariabledata.TotalReimbursement)>
    <cfset t15h = val(t15h) + val(getvariabledata.selfothour2)>
    <cfset t15amt = val(t15amt) + val(getvariabledata.selfot2)>
    <cfset t20h = val(t20h) + val(getvariabledata.selfothour3)>
    <cfset t20amt = val(t20amt) + val(getvariabledata.selfot3)>
    <cfset t30h = val(t30h) + val(getvariabledata.selfothour4)>
    <cfset t30amt = val(t30amt) + val(getvariabledata.selfot4)>
    <cfset tothour = val(tothour) + val(getvariabledata.selfothourtotal)>
    <cfset totamt = val(totamt) + val(getvariabledata.selfottotal)>
</cfloop>
        
<cfset SpreadSheetAddRow(overall, ",,,,,,,,#tbasic#,#tsales#,#textra#,#tbackpay#,#tproduct#,#tincentive#,#treimburse#,#t15h#,#t15amt#,#t20h#,#t20amt#,#t30h#,#t30amt#,#tothour#,#totamt#")>
    
<cfset SpreadSheetAddRow(overall, ",,,,,,,,,,,,,,")>
    
<cfset SpreadSheetAddRow(overall, ",,Total Employee Count,#getvariabledata.recordcount#,,,,,,,,,,,")>
    
<cfset SpreadSheetFormatCellRange(overall, s67, 5, 9, getvariabledata.recordcount+6, 23)>
<cfset SpreadSheetFormatCellRange(overall, s23, 4, 1, 4, 24)>
    
<cfset SpreadSheetFormatCellRange(overall, s24, 1, 1, 2, 15)>
<cfset SpreadSheetFormatCellRange(overall, s26, 1, 14, 2, 14)>
<cfset SpreadSheetFormatCellRange(overall, s27, 1, 15, 2, 15)>
    
<cfset SpreadSheetFormatCellRange(overall, s30, getvariabledata.recordcount+5, 1, getvariabledata.recordcount+5, 24)>
    
<!---Prepare temp excel file to write data--->
<cfset currentDirectory = "#Hrootpath#\Excel_Report\">
    
<cfset timenow = "#DateTimeFormat(now(), 'yyyymmddhhnnss')#">
    
<cfif DirectoryExists(currentDirectory) eq false>
    <cfdirectory action = "create" directory = "#currentDirectory#" >
</cfif>
<!---Prepare temp excel file to write data--->
    
<cfspreadsheet action="write" sheetname="Variable report - MP4U" filename="#HRootPath#\Excel_Report\Variable_Report_#timenow#.xlsx" name="overall" overwrite="true">
    
<!---Add 1st sheets--->
    
<!---Add 2nd sheets--->
    
<cfquery name="checkregion" dbtype="query"> 
    SELECT workordid 
    FROM getvariabledata
    WHERE workordid != ''
    GROUP BY workordid     
</cfquery>
    
<cfif checkregion.recordcount gt 1>
    
<cfloop query="checkregion">
    
<cfquery name="getvariabledata1" datasource="#dts#">
SELECT a.empno,replace(replace(group_concat( distinct a.placementno),a.placementno,""),",","") old_jo, a.placementno current_jo,empname,nricn,workordid,
dcomm,dresign,
selfusualpay as BasicRate,
sum(0
<cfloop  index="a" from="1" to="6">
    + coalesce(case when fixawcode#a#= 110 then coalesce(fixawee#a#,0) else 0 end,0)
</cfloop>
<cfloop  index="a" from="1" to="18">
    + coalesce(case when allowance#a#= 110 then coalesce(awee#a#,0) else 0 end,0)
</cfloop>
) as SalesIncentive,
sum(0
<cfloop  index="a" from="1" to="6">
    + coalesce(case when fixawcode#a#= 111 then coalesce(fixawee#a#,0) else 0 end,0)
</cfloop>
<cfloop  index="a" from="1" to="18">
    + coalesce(case when allowance#a#= 111 then coalesce(awee#a#,0) else 0 end,0)
</cfloop>
) as ExtraIncentive,
sum(0
<cfloop  index="a" from="1" to="6">
    + coalesce(case when fixawcode#a#= 112 then coalesce(fixawee#a#,0) else 0 end,0)
</cfloop>
<cfloop  index="a" from="1" to="18">
    + coalesce(case when allowance#a#= 112 then coalesce(awee#a#,0) else 0 end,0)
</cfloop>
) as BackPayIncentive,
sum(0
<cfloop  index="a" from="1" to="6">
    + coalesce(case when fixawcode#a#= 124 then coalesce(fixawee#a#,0) else 0 end,0)
</cfloop>
<cfloop  index="a" from="1" to="18">
    + coalesce(case when allowance#a#= 124 then coalesce(awee#a#,0) else 0 end,0)
</cfloop>
) as ProductIncentive,
sum(0
<cfloop  index="a" from="1" to="6">
    + coalesce(case when fixawcode#a#= 110 then coalesce(fixawee#a#,0) else 0 end,0)
</cfloop>
<cfloop  index="a" from="1" to="18">
    + coalesce(case when allowance#a#= 110 then coalesce(awee#a#,0) else 0 end,0)
</cfloop>
    
<cfloop  index="a" from="1" to="6">
    + coalesce(case when fixawcode#a#= 111 then coalesce(fixawee#a#,0) else 0 end,0)
</cfloop>
<cfloop  index="a" from="1" to="18">
    + coalesce(case when allowance#a#= 111 then coalesce(awee#a#,0) else 0 end,0)
</cfloop>
    
<cfloop  index="a" from="1" to="6">
    + coalesce(case when fixawcode#a#= 112 then coalesce(fixawee#a#,0) else 0 end,0)
</cfloop>
<cfloop  index="a" from="1" to="18">
    + coalesce(case when allowance#a#= 112 then coalesce(awee#a#,0) else 0 end,0)
</cfloop>
    
<cfloop  index="a" from="1" to="6">
    + coalesce(case when fixawcode#a#= 124 then coalesce(fixawee#a#,0) else 0 end,0)
</cfloop>
<cfloop  index="a" from="1" to="18">
    + coalesce(case when allowance#a#= 124 then coalesce(awee#a#,0) else 0 end,0)
</cfloop>
) as TotalIncentive,
sum(0
<cfloop  index="a" from="1" to="6">
    + coalesce(case when fixawcode#a#= 6 then coalesce(fixawee#a#,0) else 0 end,0)
</cfloop>
<cfloop  index="a" from="1" to="18">
    + coalesce(case when allowance#a#= 6 then coalesce(awee#a#,0) else 0 end,0)
</cfloop>
) as TotalReimbursement,
selfothour2,
selfot2,
selfothour3,
selfot3,
selfothour4,
selfot4,
(selfothour2+selfothour3+selfothour4) as selfothourtotal,
selfottotal,
"" as Remark
 
FROM assignmentslip a
LEFT JOIN #replace(dts,'_i','_p')#.pmast p
ON a.empno=p.empno
WHERE payrollperiod=#form.period#
AND custname like "%l'oreal%"
AND workordid='#checkregion.workordid#'
GROUP BY a.empno
</cfquery>
    
<cfif getvariabledata1.recordcount neq 0>
    
<cfset tempvar = "#ReReplaceNoCase(trim(checkregion.workordid),'[^a-zA-Z]','','ALL')#">
    
<cfset #tempvar# = SpreadSheetNew(true)>
    
<cfset SpreadSheetAddRow(#tempvar#, ",,Company Name:L'OREAL MALAYSIA SDN BHD,,,,,,,,,,,#left(monthAsString(getmmonth.mmonth),3)#,#getmmonth.myear#")>
    
<cfset SpreadSheetAddRow(#tempvar#, ",,Report ID: Variable Report,,,,,,,,,,,#left(monthAsString(getmmonth.mmonth-1),3)#,#getmmonth.myear#")>
    
<cfset SpreadSheetAddRow(#tempvar#, ",,,,,,,,,,,,,,")>
    
<cfset SpreadSheetAddRow(#tempvar#, "Employee ID,Old Job Order No,Current Job Order No,Employee Name,NRIC No,Section,Date of Hire,Date of Cessation,Basic Rate #getmmonth.myear#,Sales Incentive (TIER 1 + TIER 2),Extra Incentive,Back Pay Incentive (TIER 1 + TIER 2),Product incentive,Total Incentive,Total Reimbursement,OT 1.5 Normal (Hour),OT 1.5 Total (RM),OT 2.0 OFF/PH (Hour),OT 2.0 Total (RM),OT 3.0 O/T (Hour/Rate),OT 3.0 Total (RM),1.5+2.0+3.0 Total Number of OT (Hour),1.5+2.0+3.0 Total Number of OT (RM),Remark")>
    
<cfset SpreadSheetAddRows(#tempvar#, getvariabledata1)>
    
<cfset tbasic = 0>
<cfset tsales = 0>
<cfset textra = 0>    
<cfset tbackpay = 0>
<cfset tproduct = 0>
<cfset tincentive = 0>
<cfset treimburse = 0>
<cfset t15h = 0>
<cfset t15amt = 0>
<cfset t20h = 0>
<cfset t20amt = 0>
<cfset t30h = 0>
<cfset t30amt = 0>
<cfset tothour = 0>
<cfset totamt = 0>
    
<cfloop query="getvariabledata">
    <cfset tbasic = val(tbasic) + val(getvariabledata1.BasicRate)>
    <cfset tsales = val(tsales) + val(getvariabledata1.SalesIncentive)>
    <cfset textra = val(textra) + val(getvariabledata1.ExtraIncentive)>    
    <cfset tbackpay = val(tbackpay) + val(getvariabledata1.BackPayIncentive)>
    <cfset tproduct = val(tproduct) + val(getvariabledata1.ProductIncentive)>
    <cfset tincentive = val(tincentive) + val(getvariabledata1.TotalIncentive)>
    <cfset treimburse = val(treimburse) + val(getvariabledata1.TotalReimbursement)>
    <cfset t15h = val(t15h) + val(getvariabledata1.selfothour2)>
    <cfset t15amt = val(t15amt) + val(getvariabledata1.selfot2)>
    <cfset t20h = val(t20h) + val(getvariabledata1.selfothour3)>
    <cfset t20amt = val(t20amt) + val(getvariabledata1.selfot3)>
    <cfset t30h = val(t30h) + val(getvariabledata1.selfothour4)>
    <cfset t30amt = val(t30amt) + val(getvariabledata1.selfot4)>
    <cfset tothour = val(tothour) + val(getvariabledata1.selfothourtotal)>
    <cfset totamt = val(totamt) + val(getvariabledata1.selfottotal)>
</cfloop>
        
<cfset SpreadSheetAddRow(#tempvar#, ",,,,,,,,#tbasic#,#tsales#,#textra#,#tbackpay#,#tproduct#,#tincentive#,#treimburse#,#t15h#,#t15amt#,#t20h#,#t20amt#,#t30h#,#t30amt#,#tothour#,#totamt#")>
    
<cfset SpreadSheetAddRow(#tempvar#, ",,,,,,,,,,,,,,")>
    
<cfset SpreadSheetAddRow(#tempvar#, ",,Total Employee Count,#getvariabledata1.recordcount#,,,,,,,,,,,")>
    
<cfset SpreadSheetFormatCellRange(#tempvar#, s67, 5, 9, getvariabledata1.recordcount+6, 23)>
<cfset SpreadSheetFormatCellRange(#tempvar#, s23, 4, 1, 4, 24)>
    
<cfset SpreadSheetFormatCellRange(#tempvar#, s24, 1, 1, 2, 15)>
<cfset SpreadSheetFormatCellRange(#tempvar#, s26, 1, 14, 2, 14)>
<cfset SpreadSheetFormatCellRange(#tempvar#, s27, 1, 15, 2, 15)>
    
<cfset SpreadSheetFormatCellRange(#tempvar#, s30, getvariabledata1.recordcount+5, 1, getvariabledata1.recordcount+5, 24)>
    
<cfspreadsheet action="update" sheetname="#checkregion.workordid#" filename="#HRootPath#\Excel_Report\Variable_Report_#timenow#.xlsx" name="tempvar" >

</cfif>
    
</cfloop>
    
</cfif>   
<!---Add 2nd sheets--->
    <cfabort>

<cfheader name="Content-Disposition" value="inline; filename=Variable_Report_#timenow#.xlsx">
<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\Variable_Report_#timenow#.xlsx">
    
</cfoutput>