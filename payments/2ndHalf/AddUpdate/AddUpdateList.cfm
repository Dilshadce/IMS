<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<link href="/stylesheet/app.css" rel="stylesheet" type="text/css">
	<title>Add/ Update Payments</title>
</head>

<body>
<cfquery name="gsetup" datasource="#dts_main#">
 SELECT * FROM gsetup WHERE  comp_id = "#HcomID#"
</cfquery>
<cfset country_code = "#gsetup.ccode#" > 
<div class="mainTitle">Add/ Update</div>
<div class="subTitle"></div>
<table class="list" border="0">
<tr>
	<td colspan="3" height="20"></td>
</tr>
<tr>
	<td colspan="2" nowrap width="200"><a href="/payments/2ndHalf/AddUpdate/normalPayMain.cfm" target="mainFrame">
		<img name="Cash Sales" src="/images/reportlogo.gif">Normal Pay</a></td>
			<cfif country_code eq 'MY'>
	<td colspan="2" nowrap width="200"><a href="/payments/2ndHalf/AddUpdate/editOTRateCPFMain.cfm" target="mainFrame">
		<img name="Cash Sales" src="/images/reportlogo.gif">Edit Overtime Rate/ EPF / SOCSO / PCB</a></td>
		<cfelse>
		<td colspan="2" nowrap width="200"><a href="/payments/2ndHalf/AddUpdate/editOTRateCPFMain.cfm" target="mainFrame">
		<img name="Cash Sales" src="/images/reportlogo.gif">Edit Overtime Rate/ CPF</a></td>
		</cfif>
		

	<td colspan="2" nowrap width="200"><a href="/payments/2ndHalf/addUpdate/fixedOTRateByPayGroupMain.cfm" target="mainFrame">
		<img name="Cash Sales" src="/images/reportlogo.gif">Fixed Overtime Rate By Pay Group</a></td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
	<td colspan="2" nowrap width="200"><a href="/payments/2ndHalf/addUpdate/updateBRFromMasterMain.cfm" target="mainFrame">
		<img name="Cash Sales" src="/images/reportlogo.gif">Update Basic Rate From Master</a></td>
	<td colspan="2" nowrap width="200"><a href="/payments/2ndHalf/addUpdate/paySlipAdditionalMain.cfm" target="mainFrame">
		<img name="Cash Sales" src="/images/reportlogo.gif">Pay Slip - Additional Remarks/ Note</a></td>
	<td colspan="2" nowrap width="200"><a href="/payments/2ndHalf/AddUpdate/TipAndPieceWorkedMaintenance/tnpList.cfm" target="mainFrame">
		<img name="Cash Sales" src="/images/reportlogo.gif">Tip And Piece Worked Maintenance ></a></td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
	<td colspan="2" nowrap width="200"><a href="/payments/2ndHalf/addUpdate/assignNoOfWDAYMain.cfm" target="mainFrame">
		<img name="Cash Sales" src="/images/reportlogo.gif">Assign No. Of WDAY</a></td>
	<td colspan="2" nowrap width="200"><a href="/payments/2ndHalf/AddUpdate/HolidayAndLeaveMaintenance/hnlList.cfm" target="mainFrame">
		<img name="Cash Sales" src="/images/reportlogo.gif">Holiday And Leave Maintenance ></a></td>
	<td colspan="2" nowrap width="200"><a href="/payments/2ndHalf/AddUpdate/RestdayAndHolidayWorked/rnlList.cfm" target="mainFrame">
		<img name="Cash Sales" src="/images/reportlogo.gif">Restday And Holiday Worked ></a></td>
</tr>
<tr><td>&nbsp;</td></tr>


<tr>
	<td colspan="2" nowrap width="200"><a href="/payments/2ndHalf/addUpdate/AddModifyDeductionMain.cfm" target="mainFrame">
		<img name="Cash Sales" src="/images/reportlogo.gif">Add/ Modify Deduction</a></td>
	<td colspan="2" nowrap width="200"><a href="/payments/2ndHalf/AddUpdate/addModifyZakatMain.cfm" target="mainFrame">
		<img name="Cash Sales" src="/images/reportlogo.gif">Add/ Modify Zakat</a></td>
	<td colspan="2" nowrap width="200"><a href="/payments/2ndHalf/addUpdate/AddModifyAllowanceMain.cfm" target="mainFrame">
		<img name="Cash Sales" src="/images/reportlogo.gif">Add/ Modify Allowance</a></td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
	<td colspan="2" nowrap width="200"><a href="/payments/2ndHalf/AddUpdate/LoanDeductionMaintenance/ldList.cfm" target="mainFrame">
		<img name="Cash Sales" src="/images/reportlogo.gif">Loan Deduction Maintenance ></a></td>
                	<td colspan="2" nowrap width="200"><a href="/payments/2ndHalf/addUpdate/payAWForTaxMain.cfm" target="mainFrame">
		<img name="Cash Sales" src="/images/reportlogo.gif">Pay Allowance For Tax</a></td>
<!--- 	<td colspan="2" nowrap width="200"><a href="/underconstruction.cfm" target="mainFrame">
		<img name="Cash Sales" src="/images/reportlogo.gif">Import From Payroll.txt</a></td>
	<td colspan="2" nowrap width="200"><a href="/underconstruction.cfm" target="mainFrame">
		<img name="Cash Sales" src="/images/reportlogo.gif">Import From Pay9.DBF</a></td> --->
</tr>

<tr><td>&nbsp;</td></tr>

<tr>
	<td><br />
		<a href="/payments/2ndHalf/2ndHalfList.cfm"><strong>< Back</strong></a>
	</td>
</tr>
</table>
</body>
</html>