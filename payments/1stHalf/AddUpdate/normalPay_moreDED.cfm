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
	<title>More Deductions</title>
	<link href="/stylesheet/app.css" rel="stylesheet" type="text/css">
</head>

<body>

<cfquery name="mDED_qry" datasource="#dts#">
SELECT * FROM mdedtab
</cfquery>

<cfquery name="moreDED_qry" datasource="#dts#">
SELECT * FROM moretra
WHERE EMPNO = "#url.empno#"
</cfquery>

<cfoutput>
<cfform name="moreDED" action="/payments/1stHalf/AddUpdate/normalPay_process.cfm?type=moreDED&empno=#url.empno#" method="post">
	<div class="mainTitle">More Deductions</div>
	
	<table>
	<tr>
		<th width="25">No.</th>
		<th width="200">Description</th>
		<th width="80">Rate</th>
		<th width="25"></th>
	</tr>
	<cfset j=101>
	<cfloop query="mDED_qry">
	<tr>
		<td>#mDED_qry.mded_cou#.</td>
		<td>#mDED_qry.mded_desp#</td>
		<td><input type="text" name="MDED#j#" value="#numberformat(evaluate('moreDED_qry.MDED#j#'),'.__')#" size="10"></td>
		<td><input type="text" name="mded_link" value="#mDED_qry.mded_link#" size="1" readonly></td>
	</tr>
	<cfset j=j+1>
	</cfloop>
	<input type="hidden" name="empno" value="#moreDED_qry.empno#">
</table>

<table class="form">
<tr>
	<td width="340px" align="right"><br />
		<!--- <input type="reset" name="reset" value="Reset"> --->
		<input type="submit" name="save" value="Save">
		<input type="button" name="close" value="Close" onClick="window.close();">
	</td>
</tr>
</table>

</cfform>
</cfoutput>
</body>

</html>