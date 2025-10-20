<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>Loan Maintenance</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<script src="/javascripts/tabber.js" type="text/javascript"></script>
	<link href="/stylesheet/tabber.css" rel="stylesheet" TYPE="text/css" MEDIA="screen">
	<link href="/stylesheet/app.css" rel="stylesheet" type="text/css">	
	<link href="/stylesheet/CalendarControl.css" rel="stylesheet" type="text/css">
	<script src="/javascripts/CalendarControl.js" language="javascript"></script>
</head>


<cfquery name="loan_qry" datasource="#dts#">
SELECT * FROM loanmst AS a LEFT JOIN pmast AS b ON a.empno=b.empno WHERE entryno='#entryno#'
</cfquery>

<cfquery name="ded_qry" datasource="#dts#">
SELECT ded_cou,ded_desp FROM dedtable
</cfquery>

<body>
<div class="mainTitle">Loan Maintenance</div>
<div class="tabber">
	<form name="lForm" action="updateAdd_editPro.cfm" method="post">
	<cfoutput>
		<table>
		<tr><input type="hidden" name="entryno" value="#loan_qry.entryno#">
			<th>Employee No.</th>
			<td colspan="2" width="100px"><input type="text" size="12"  name="empno" value="#loan_qry.empno#" readonly="yes"/></td>
		</tr>
		<tr>
			<th>Name</th>
			<td colspan="2" width="300px"><input type="text" size="60" name="name" value="#loan_qry.name#" readonly="yes"/></td>
		</tr>
		<tr>
			<th>Basic Rate</th>
			<td width="128px"><input type="text" size="15" name="brate" value="#loan_qry.brate#" readonly="yes"/></td>
			<td width="240px"><input type="text" size="6" value="Monthly" readonly="yes"/></td>
		</tr>
		<tr>
			<th>A/C Number</th>
			<td colspan="2" width="380px"><input type="text" name="accno" size="25" value="#loan_qry.accno#" maxlength="20" readonly="yes"/></td>
			<th>Bank Name</th>
			<td><input type="text" size="45" name="bname" value="#loan_qry.bankname#" maxlength="35"/></td>
		</tr>
		<tr>
			<th>Loan Amount</th>
			<td width="128px"><input type="text" size="10" name="lamt" value="#loan_qry.loanamt#" maxlength="6" /></td>
			<td>Last Payment</td>
		</tr>
		<tr>
			<th>Date From</th>
			<td width="128px"><input type="text" size="15" name="dateFrom" value="#lsdateformat(loan_qry.dates1,"DD/MM/YYYY")#"/>
				<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(dateFrom);"></td>
			<td width="240px"><input type="text" size="15" name="pdate1" value="#lsdateformat(loan_qry.dates2,"DD/MM/YYYY")#"/>
				<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(pdate1);"></td>
			<th>Ded.No.</th>
			<td><select name="dnum" id="dnum"/>
				<cfloop query="ded_qry">
				<option name="#ded_qry.ded_cou#" value="#ded_qry.ded_cou#"
					<cfif loan_qry.dednum eq ded_qry.ded_cou > selected </cfif>>
						#ded_qry.ded_cou#|#ded_qry.ded_desp#
				</option>
				</cfloop>
			</select></td>		
		</tr>
		<tr>
			<th>Date To</th>
			<td width="128px"><input type="text" size="15" name="dateTo" value="#lsdateformat(loan_qry.datee1,"DD/MM/YYYY")#"/>
				<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(dateTo);"></td>
			<td width="240px"><input type="text" size="15" name="pdate2" value="#lsdateformat(loan_qry.datee2,"DD/MM/YYYY")#"/>
				<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(pdate2);"></td>
		</tr>
		<tr>
			<th>Repayment Amount</th>
			<td width="128px"><input type="text" size="10" name="rpayamt" value="#loan_qry.loanret1#" maxlength="6"/></td>
			<td width="240px"><input type="text" size="10" name="lpayamt" value="#loan_qry.loanret2#" maxlength="6"/></td>
			<td></td>
			<td width="240px"><input type="checkbox" name="fixed" value="0" #IIF(loan_qry.fixed eq 1,DE("checked"),DE(""))# /> Fixed</td>
			<!---td width="240px"><input type="checkbox" name="fixed" value="1" #IIF(loan_qry.fixed eq 0,DE(""),DE("checked"))# /> Fixed</td--->
		</tr>
		</table>
	</cfoutput>
		<br />
		<center>
			<input type="submit" name="save" value="Save">
			<input type="button" name="exit" value="Exit" onclick="history.back()">
		</center>
		<br />
	</form>
	
</div>
</body>
</html>
