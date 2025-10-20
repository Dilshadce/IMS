<cfset DATE = #DateFormat(Now(), "dd-mm-yyyy")#>

<cfinvoke component="cfc.dateformat" method="dbDateFormat" inputDate="#evaluate('form.dateFrom')#" returnvariable="cfc_fdate" />
<cfinvoke component="cfc.dateformat" method="dbDateFormat" inputDate="#evaluate('form.dateTo')#" returnvariable="cfc_tdate" />

<cfquery name="getList_qry" datasource="#dts#">
SELECT * FROM pmast AS a RIGHT JOIN pwork AS b ON a.empno=b.empno 
WHERE 0=0
	<cfif form.empnoFrom neq ""> AND a.empno >='#form.empnoFrom#' </cfif><cfif form.empnoTo neq ""> AND a.empno <='#form.empnoTo#' </cfif> 
	<cfif form.lineFrom neq ""> AND plineno >='#form.lineFrom#' </cfif><cfif form.lineTo neq ""> AND plineno <='#form.lineTo#' </cfif>
	<cfif form.branchFrom neq ""> AND brcode >='#form.branchFrom#' </cfif><cfif form.branchTo neq "">AND brcode <='#form.branchTo#' </cfif>
	<cfif form.deptFrom neq ""> AND deptcode >='#form.deptFrom#' </cfif><cfif form.deptTo neq ""> AND deptcode <='#form.deptTo#' </cfif>
	<cfif form.categoryFrom neq ""> AND category >='#form.categoryFrom#' </cfif><cfif form.categoryTo neq "">AND category <='#form.categoryTo#' </cfif>
	<cfif form.dateFrom neq ""> AND work_date >= '#cfc_fdate#' </cfif><cfif form.dateTo neq ""> AND work_date <= '#cfc_tdate#'</cfif> 
	<cfif leaveType neq ""> AND work_type = '#form.leaveType#' </cfif>
</cfquery>

<cfquery name="getComp_qry" datasource="payroll_main">
SELECT comp_id, comp_name FROM gsetup
</cfquery>

<cfswitch expression="#form.result#">
	
<cfcase value="HTML">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<title>RestDay and Holiday Worked</title>
	<script src="/javascripts/tabber.js" type="text/javascript"></script>
	<link href="/stylesheet/report.css" rel="stylesheet" type="text/css">
</head>

<body>

<div class="tabber">
<table>
	<tr><td colspan="5" align="center"><h1>LIST REST DAY AND PUBLIC HOLIDAY WORK</h1></tr>
	<cfoutput>
	<tr>
		<td colspan="4">#getComp_qry.comp_name#</td>
		<td>#DATE#</td>
	</tr>
	</cfoutput>
	<tr><td colspan="5"><hr></td></tr>
	<tr>
		<td width="120px">EMPLOYEE NUMBER</td>
		<td width="350px">NAME</td>
		<td width="180px">TYPE</td>
		<td width="100px">DATE</td>
		<td width="80px">NO OF DAY</td>
	</tr>
	<cfoutput query="getList_qry">
	<tr>
		<td>#getList_qry.empno#</td>
		<td>#getList_qry.name#</td>
		<td>#getList_qry.work_type#</td>
		<td>#lsdateformat(getList_qry.work_date,"dd/mm/yy")#</td>
		<td>#getList_qry.work_day#</td>
	</tr>
	</cfoutput>
	<tr><td colspan="5" align="center">---END---</td></tr>	
	<cfif getList_qry.recordcount eq 0>
			<h3>Sorry, No records were found.</h3>
	</cfif>
	
</table>
</div>
</body>
</html>

</cfcase>

<cfcase value="EXCELDEFAULT">
<cfheader name="Content-Type" value="pdf">
<cfheader name="Content-Disposition" value="attachment; filename=RestDayandHolidayWorked.pdf">

<cfdocument format="pdf" backgroundvisible="no" pagetype="A4" scale="100">
<html>
<body>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<title>RestDay and Holiday Worked</title>
	<script src="/javascripts/tabber.js" type="text/javascript"></script>
	<link href="/stylesheet/report.css" rel="stylesheet" type="text/css">
</head>

<body>

<div class="tabber">
<table>
	<tr><td colspan="5" align="center"><h1>LIST REST DAY AND PUBLIC HOLIDAY WORK</h1></tr>
	<cfoutput>
	<tr>
		<td colspan="4">#getComp_qry.comp_name#</td>
		<td>#DATE#</td>
	</tr>
	</cfoutput>
	<tr><td colspan="5"><hr></td></tr>
	<tr>
		<td width="120px">EMPLOYEE NUMBER</td>
		<td width="350px">NAME</td>
		<td width="180px">TYPE</td>
		<td width="100px">DATE</td>
		<td width="80px">NO OF DAY</td>
	</tr>
	<cfoutput query="getList_qry">
	<tr>
		<td>#getList_qry.empno#</td>
		<td>#getList_qry.name#</td>
		<td>#getList_qry.work_type#</td>
		<td>#lsdateformat(getList_qry.work_date,"dd/mm/yy")#</td>
		<td>#getList_qry.work_day#</td>
	</tr>
	</cfoutput>
	<tr><td colspan="5" align="center">---END---</td></tr>	
	<cfif getList_qry.recordcount eq 0>
			<h3>Sorry, No records were found.</h3>
	</cfif>
	
</table>
</div>
</body>
</html>
<cfoutput>
<cfdocumentitem type="footer">
	<font size="2">Page #cfdocument.currentpagenumber# of #cfdocument.totalpagecount#</font>
</cfdocumentitem>
</cfoutput>
</body>
</html>
</cfdocument>
	</cfcase>
	
</cfswitch>