<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<title>Loan Deduction Maintenance</title>
	<script src="/javascripts/tabber.js" type="text/javascript"></script>
	<link href="/stylesheet/tabber.css" rel="stylesheet" TYPE="text/css" MEDIA="screen">
	<link href="/stylesheet/app.css" rel="stylesheet" type="text/css">
</head>

<cfquery name="getList_qry" datasource="#dts#">
SELECT * FROM pmast AS a LEFT JOIN loanmst AS b ON a.empno=b.empno 
WHERE 0=0
	<cfif form.empnoFrom neq ""> AND a.empno >='#form.empnoFrom#' </cfif><cfif form.empnoTo neq ""> AND a.empno <='#form.empnoTo#' </cfif> 
	<cfif form.lineFrom neq ""> AND plineno >='#form.lineFrom#' </cfif><cfif form.lineTo neq ""> AND plineno <='#form.lineTo#' </cfif>
	<cfif form.branchFrom neq ""> AND brcode >='#form.branchFrom#' </cfif><cfif form.branchTo neq "">AND brcode <='#form.branchTo#' </cfif>
	<cfif form.deptFrom neq ""> AND deptcode >='#form.deptFrom#' </cfif><cfif form.deptTo neq ""> AND deptcode <='#form.deptTo#' </cfif>
	<cfif form.categoryFrom neq ""> AND category >='#form.categoryFrom#' </cfif><cfif form.categoryTo neq "">AND category <='#form.categoryTo#' </cfif>
	<cfif form.empcodeFrom neq ""> AND emp_code >='#form.empcodeFrom#' </cfif><cfif form.empcodeTo neq ""> AND emp_code <='#form.empcodeTo#' </cfif> 
</cfquery>

<cfquery name="getComp_qry" datasource="payroll_main">
SELECT * FROM gsetup WHERE comp_id = "#HcomID#"
</cfquery>

<cfset date = #dateFormat(Now(), "dd/mm/yyyy")#>

<body>

	
<cfif form.loanList eq "records">
<cfoutput>
<div class="tabber">
<table>
	<tr><td colspan="9" align="center"><h1>List Loan Records</h1></tr>
	<tr><td colspan="9"><hr></td></tr>
	<tr>
		<th width="120px">Empno</th>
		<th width="350px">Accno</th>
		<th width="180px">Loanamt</th>
		<th width="100px">Date_from</th>
		<th width="80px">Date_to</th>
		<th width="120px">Repayment</th>
		<th width="350px">Times***</th>
		<th width="180px">Ded_code</th>
		<th width="100px">Name</th>
	</tr>
	<cfloop query="getList_qry">
	<tr>
		<td>#getList_qry.empno#</td>
		<td>#getList_qry.accno#</td>
		<td>#getList_qry.loanamt#</td>
		<td>#lsdateformat(getList_qry.dates1,"dd/mm/yyyy")#</td>
		<td>#lsdateformat(getList_qry.datee1,"dd/mm/yyyy")#</td>
		<td>#getList_qry.loanret1#</td>
		<td>&nbsp;</td>
		<td>#getList_qry.dednum#</td>
		<td>#getList_qry.name#</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>#lsdateformat(getList_qry.dates2,"dd/mm/yyyy")#</td>
		<td>#lsdateformat(getList_qry.datee2,"dd/mm/yyyy")#</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	</cfloop>
</table>

	<cfif getList_qry.recordcount eq 0>
			<h3>Sorry, No records were found.</h3>
	</cfif>
	
</div>
</cfoutput>

<cfelseif form.loanList eq "repayment">
<cfoutput>
<div class="tabber">
<table>
	<tr><td colspan="9" align="center"><h1>LIST THIS MONTH REPAYMENT</h1></tr>
	<tr>
		<td colspan="8">#getComp_qry.comp_name#</td>
		<td>#DATE#</td>
	</tr>
	<tr><td colspan="9"><hr></td></tr>
	<tr>
		<td width="120px">EMPLOYEE NUMBER</td>
		<td width="150px">ACCOUNT NUMBER</td>
		<td width="180px">DED. CODE</td>
		<td width="100px">NAME</td>
		<td width="80px">LOAN AMOUNT</td>
		<td width="120px">DATE FROM</td>
		<td width="350px">DATE TO</td>
		<td width="180px">REPAYMENT AMOUNT</td>
		<td width="100px">THIS MONTH</td>
	</tr>
	<tr><td colspan="9"><hr></td></tr>
	<cfloop query="getList_qry">
	<tr>
		<td>#getList_qry.empno#</td>
		<td>#getList_qry.accno#</td>
		<td>#getList_qry.dednum#</td>
		<td>#getList_qry.name#</td>
		<td>#getList_qry.loanamt#</td>
		<td>#lsdateformat(getList_qry.dates1,"dd/mm/yyyy")#</td>
		<td>#lsdateformat(getList_qry.datee1,"dd/mm/yyyy")#</td>
		<td>#getList_qry.loanret1#</td>
		<td>#getList_qry.this_mth#</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>#lsdateformat(getList_qry.dates2,"dd/mm/yyyy")#</td>
		<td>#lsdateformat(getList_qry.datee2,"dd/mm/yyyy")#</td>
		<td>#getList_qry.loanret2#</td>
		<td>&nbsp;</td>
	</tr>
	</cfloop>
	<tr><td colspan="9">&nbsp;</td></tr>
	<tr><td colspan="9" align="center">---END---</td></tr>
</table>

	<cfif getList_qry.recordcount eq 0>
			<h3>Sorry, No records were found.</h3>
	</cfif>
	
</div>
</cfoutput>

<cfelseif form.loanList eq "report">
<cfoutput>
<div class="tabber">
<table width="100%">
	<tr><td colspan="8" align="center"><h1>OUTSTANDING LOAN REPORT</h1></tr>
	<tr>
		<td colspan="7">#getComp_qry.comp_name#</td>
		<td>#DATE#</td>
	</tr>
	<tr><td colspan="8"><hr></td></tr>
	<tr>
		<td width="120px">EMPLOYEE NUMBER</td>
		<td width="150px">ACCOUNT NUMBER</td>
		<td width="250px">NAME</td>
		<td width="90px">LOAN AMOUNT</td>
		<td width="90px">ALREADY PAID</td>
		<td width="90px">THIS MONTH</td>
		<td width="90px">YET TO PAY</td>
		<td width="120px">TOTAL SCHEDULE PAYMENT</td>
	</tr>
	<tr><td colspan="8"><hr></td></tr>
	<cfset p = 0>
	<cfset q = 0>
	<cfset r = 0>
	<cfset s = 0>
	<cfloop query="getList_qry">
	<tr bgcolor="#iif((val(getList_qry.loanamt) neq val(getList_qry.loanpay)),DE('0099FF'),DE(''))#">
		<td>#getList_qry.empno#</td>
		<td>#getList_qry.accno#</td>
		<td>#getList_qry.name#</td>
		<td>#getList_qry.loanamt#</td>
		<cfset loanalp = val(getList_qry.loanret1) + val(getList_qry.loanret2)>
		<td>#loanalp#</td>
		<td>#getList_qry.this_mth#</td>
		<td>#getList_qry.loanyetp#</td>
		<td>
			<cfif val(getList_qry.loanamt) eq val(getList_qry.loanpay)>*OK*
			<cfelse>*ERROR*
			</cfif>
		</td>
	</tr>
	<cfset p = val(getList_qry.loanamt)>
	<cfset q = val(getList_qry.loanalp)>
	<cfset r = val(getList_qry.this_mth)>
	<cfset s = val(getList_qry.loanyetp)>
	</cfloop>
	<tr>
		<td colspan="3">&nbsp;</td>
		<td><hr></td>
		<td><hr></td>
		<td><hr></td>
		<td><hr></td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td width="90px" colspan="3">TOTAL:</td>
		<td>#p#</td>
		<td>#q#</td>
		<td>#r#</td>
		<td>#s#</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td colspan="3">&nbsp;</td>
		<td><hr><hr></td>
		<td><hr><hr></td>
		<td><hr><hr></td>
		<td><hr><hr></td>
		<td>&nbsp;</td>
	</tr>
</table>

	<cfif getList_qry.recordcount eq 0>
			<h3>Sorry, No records were found.</h3>
	</cfif>
	
</div>
</cfoutput>

<cfelseif form.loanList eq "details">
<cfoutput>
<div class="tabber">
<table>
	<tr>
		<td colspan="5" align="center"><h1>LOAN TO BANK DETAILS</h1></tr>
		<td>#date#</td>
	</tr>
	<tr><td colspan="6"><hr></td></tr>
	<tr>
		<td width="60px">NO</td>
		<td width="250px">NAME</td>
		<td width="150px">EMPLOYEE NUMBER</td>
		<td width="90px">I/C NO.</td>
		<td width="150px">ACCOUNT NUMBER</td>
		<td width="90px">AMOUNT</td>
	</tr>
	<tr><td colspan="6"><hr></td></tr>
	<cfset i = 1>
	<cfloop query="getList_qry">
	<tr>
		<td width="60px">#i#</td>
		<td width="250px">#getList_qry.name#</td>
		<td width="150px">#getList_qry.empno#</td>
		<td width="90px">I/C NO.</td>
		<td width="150px">#getList_qry.accno#</td>
		<td width="90px">AMOUNT</td>
	</tr>
	<cfset i = i + 1>
	</cfloop>
</table>

	<cfif getList_qry.recordcount eq 0>
			<h3>Sorry, No records were found.</h3>
	</cfif>
	
</div>
</cfoutput>

<cfelseif form.loanList eq "totals">
<cfoutput>
<div class="tabber">
<table width="100%">
	<tr>
		<td colspan="2" align="center"><h1>LOAN TO BANK TOTALS</h1>
		<td>#date#</td></tr>
	<tr><td colspan="3"><hr></td></tr>
	<tr>
		<td width="60px">NO</td>
		<td width="250px">BANK</td>
		<td width="150px">AMOUNT</td>
	</tr>
	<tr><td colspan="3"><hr></td></tr>
	<cfset i = 1>
	<cfloop query="getList_qry">
	<tr>
		<td width="60px">#i#</td>
		<td width="250px">#getList_qry.bankname#</td>
		<td width="150px">amount</td>
	</tr>
	<cfset i = i + 1>
	</cfloop>
</table>

	<cfif getList_qry.recordcount eq 0>
			<h3>Sorry, No records were found.</h3>
	</cfif>
	
</div>
</cfoutput>

</cfif>

</body>
</html>