<cfset dts=replace(dts,'_i','_p','all')>

<cfquery name="userpin_qry" datasource="#dts#">
		SELECT pin from userpin where usergroup = "#getHQstatus.userGrpID#"
	</cfquery>
	<cfset Hpin = userpin_qry.pin >
	<cfif getHQstatus.userGrpID eq "super">
		<cfset Hpin = 0>
	</cfif>
<cfset HcomID=replace(HcomID,'_i','','all')>
<cfset DTS_MAIN = "payroll_main">
<cfquery name="gsetup_qry" datasource="payroll_main">
		SELECT ccode from gsetup where comp_id = '#HcomID#'
	</cfquery>
	<cfset HuserCcode = gsetup_qry.ccode>

<html>
<head>
	<title>More Basic Pay Details</title>
	<link href="/stylesheet/app.css" rel="stylesheet" type="text/css">
</head>

<body>

<cfquery name="pay_qry" datasource="#dts#">
SELECT * FROM paytran
WHERE EMPNO = "#url.empno#"
</cfquery>

<cfquery name="emp_qry" datasource="#dts#">
SELECT *
FROM pmast
WHERE EMPNO = "#url.empno#" 
</cfquery>

<cfoutput>
<cfform name="mForm" action="/payments/2ndHalf/AddUpdate/normalPay_process.cfm?type=more&empno=#emp_qry.empno#" method="post">
<table class="form">
<tr>
	<th colspan="2">Back Pay For Basic Pay</th>
</tr>
<tr>
	<input type="hidden" name="empno" value="emp_qry.empno">
	<td>Back Pay</td>
	<td><input type="text" name="backpay" value="#numberformat(pay_qry.backpay,'.__')#" size="10"></td>
</tr>
<tr>
	<th colspan="2">Increment In Mid Of The Month</th>
</tr>
<tr>
	<td>Basic Rate Before Increment</td>
	<td><input type="text" name="brate" value="<cfif #pay_qry.payyes# eq "">#emp_qry.brate#<cfelse>#pay_qry.brate#</cfif>" size="10" readonly></td>
</tr>
<tr>
	<td>Mid Month Increment Amount</td>
	<td><input type="text" name="m_inc_amt" value="#emp_qry.m_inc_amt#" size="10" readonly></td>
</tr>
<tr>
	<td>Mid Month Increment Date</td>
	<td><input type="text" name="m_inc_date" value="#DateFormat(emp_qry.m_inc_date, "dd/mm/yyyy")#" size="10" maxlength="10" readonly/></td>
</tr>
<tr>
	<td>Basic Rate</td>
	<td><input type="text" name="brate2" value="#numberformat(pay_qry.brate2,'.__')#" size="10"></td>
</tr>
<tr>
	<td>Working Days</td>
	<td><input type="text" name="wday2" value="#numberformat(pay_qry.wday2,'.__')#" size="10"></td>
</tr>
<tr>
	<td>DW</td>
	<td><input type="text" name="dw2" value="#numberformat(pay_qry.dw2,'.__')#" size="10"></td>
</tr>
<tr>
	<td>NPL</td>
	<td><input type="text" name="npl2" value="#numberformat(pay_qry.npl2,'.__')#" size="10"></td>
</tr>
<tr>
	<td colspan="2" align="right"><br /><input type="submit" name="save" value="Save"></td>
</tr>
</table>
</cfform>
</cfoutput>
</body>

</html>