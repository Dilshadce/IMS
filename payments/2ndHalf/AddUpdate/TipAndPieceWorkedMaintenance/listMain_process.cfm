<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<cfset datestart=form.datefrom>
<cfset dateend = form.dateto>
<cfset datestart=#DateFormat(datestart,'YYYYMMDD')#>
<cfset dateend= #DateFormat(dateend,'YYYYMMDD')#>
<cfset stype = form.stype>

<cfquery name="emp_qry" datasource="#dts#">
SELECT pmast.empno FROM pmast, paytran
WHERE pmast.empno = paytran.empno
	<cfif form.empnoFrom neq ""> AND pmast.empno >= '#form.empnoFrom#' </cfif><cfif empnoTo neq ""> AND pmast.empno <= '#form.empnoTo#' </cfif>
	<cfif form.lineFrom neq ""> AND plineno >= '#form.lineFrom#' </cfif><cfif lineTo neq ""> AND plineno <= '#form.lineTo#' </cfif>
	<cfif form.branchFrom neq ""> AND brcode >= '#form.branchFrom#' </cfif><cfif branchTo neq ""> AND brcode <= '#form.branchTo#' </cfif>
	<cfif form.deptFrom neq ""> AND deptcode >= '#form.deptFrom#' </cfif><cfif deptTo neq ""> AND deptcode <= '#form.deptTo#' </cfif>
	<cfif form.categoryFrom neq ""> AND category >= '#form.categoryFrom#' </cfif><cfif categoryTo neq ""> AND category <= '#form.categoryTo#' </cfif>
</cfquery>





<cfquery name="pc_qry" datasource="#dts#">
SELECT * FROM pctab2 
</cfquery>

<cfquery name="pcwork_qry" datasource="#dts#">
SELECT * FROM pcwork WHERE empno = '#emp_qry.empno#' and WORK_DATE <= #dateend# and WORK_DATE >=#datestart# ORDER BY #stype#
</cfquery>



<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<title>Loan Deduction Maintenance</title>
	<script src="/javascripts/tabber.js" type="text/javascript"></script>
	<link href="/stylesheet/tabber.css" rel="stylesheet" TYPE="text/css" MEDIA="screen">
	<link href="/stylesheet/app.css" rel="stylesheet" type="text/css">
</head>

<cfset date = #dateFormat(Now(), "dd/mm/yyyy")#>

<body>

<cfif form.list eq "worked">
<cfoutput>
<div class="tabber">
<table>
	<tr><td colspan="7" align="center"><h1>List Piece Rated Work</h1></tr>
	<tr>
		<th width="120px">EMPLOYEE NUMBER</th>
		<th width="350px">HALF</th>
		<th width="180px">DATE</th>
		<th width="100px">PIECE CODE</th>
		<th width="80px">DESCRIPTION</th>
		<th width="120px">PIECES X</th>
		<th width="350px">PIECES Y</th>
	</tr>
    <cfloop query="pcwork_qry">
    <cfoutput>
    <tr>
		<td>#pcwork_qry.empno#</td>
		<td>#pcwork_qry.half12#</td>
		<td>#DATEFORMAT(pcwork_qry.work_date,'DD/MM/YYYY')#</td>
		<td>#pcwork_qry.PC_CODE#</td>
		<td>#pcwork_qry.PC_DESP#</td>
		<td>#pcwork_qry.PC_WORK#</td>
		<td>#pcwork_qry.PC_YWORK#</td>
	</tr>
    </cfoutput>
    </cfloop>
	<!---cfloop query=""--->
	<tr>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
	</tr>
	<!---/cfloop--->
</table>
<center>
	<input type="button" name="exit" value="Exit" onclick="window.close()">
</center>
</div>	
</cfoutput>

<cfelseif form.list eq "payX">
<cfoutput>
<div class="tabber">
<table>
	<tr><td colspan="7" align="center"><h1>List Piece Rated Pay - X</h1></tr>
	<tr>
		<th width="120px">EMPLOYEE NUMBER</th>
		<th width="180px">DATE</th>
		<th width="100px">PIECE CODE</th>
		<th width="350px">PIECE RATE</th>
		<th width="80px">PIECE WORK</th>
		<th width="120px">PAY</th>
        <th width="80px">COUNT</th>
		<th width="350px">TOTAL PIECE</th>
	</tr><cfset total_pay = 0 >
     <cfloop query="pcwork_qry">
    <cfoutput>
    <tr>
		<td>#pcwork_qry.empno#</td>
		<td>#DATEFORMAT(pcwork_qry.work_date,'DD/MM/YYYY')#</td>
		<td>#pcwork_qry.PC_CODE#</td>
		<td>#pcwork_qry.PC_XRATE#</td>
		<td>#pcwork_qry.PC_WORK#</td>
        <cfset pay = #val(pcwork_qry.PC_XRATE)# * #val(pcwork_qry.PC_WORK)#>
        <td>#pay#</td>
        <td>#pcwork_qry.PC_COUNT#</td>
        <cfset row_count = #pcwork_qry.currentrow#>
        <cfif row_count eq 1>
		<td>#pcwork_qry.PC_WORK_T#</td>
        <cfelse>
        <td>0.00</td>
        </cfif>
	</tr>
    </cfoutput>
    <cfset total_pay = total_pay + pay >
    </cfloop>
	<tr><td colspan="8"><hr></td></tr>
	<tr>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td>#total_pay#</td>
		<td></td>
	</tr>
</table>
<center>
	<input type="button" name="exit" value="Exit" onclick="window.close()">
</center>
</div>	
</cfoutput>

<cfelseif form.list eq "payY">
<cfoutput>
<div class="tabber">
<table>
	<tr><td colspan="7" align="center"><h1>List Piece Rated Pay - Y</h1></tr>
	<tr>
		<th width="120px">EMPLOYEE NUMBER</th>
		<th width="180px">DATE</th>
		<th width="100px">PIECE CODE</th>
		<th width="350px">PIECE RATE</th>
		<th width="80px">PIECE WORK</th>
		<th width="120px">PAY</th>
        <th width="80px">COUNT</th>
		<th width="350px">TOTAL PIECE</th>
	</tr>
	<!---cfloop query=""--->
    <cfset total_pay = 0 >
     <cfloop query="pcwork_qry">
    <cfoutput>
    <tr>
		<td>#pcwork_qry.empno#</td>
		<td>#DATEFORMAT(pcwork_qry.work_date,'DD/MM/YYYY')#</td>
		<td>#pcwork_qry.PC_CODE#</td>
		<td>#pcwork_qry.PC_YRATE#</td>
		<td>#pcwork_qry.PC_YWORK#</td>
        <cfset pay = #val(pcwork_qry.PC_YRATE)# * #val(pcwork_qry.PC_YWORK)#>
        <td>#pay#</td>
        <td>#pcwork_qry.PC_COUNT#</td>
        <cfset row_count = #pcwork_qry.currentrow#>
        <cfif row_count eq 1>
		<td>#pcwork_qry.PC_YWORK_T#</td>
        <cfelse>
        <td>0.00</td>
        </cfif>
	</tr>
    </cfoutput>
    <cfset total_pay = total_pay + pay >
    </cfloop>
	<!---/cfloop--->
	<tr><td colspan="8"><hr></td></tr>
	<tr>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td>#total_pay#</td>
		<td></td>
	</tr>
</table>
<center>
	<input type="button" name="exit" value="Exit" onclick="window.close()">
</center>
</div>	
</cfoutput>
</cfif>

</body>
</html>