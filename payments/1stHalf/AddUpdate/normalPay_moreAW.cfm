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
	<title>More Allowances</title>
	<link href="/stylesheet/app.css" rel="stylesheet" type="text/css">
</head>

<body>

<cfquery name="mAW_qry" datasource="#dts#">
SELECT * FROM mawtab
</cfquery>

<cfquery name="moreAW_qry" datasource="#dts#">
SELECT * 
FROM moretra
WHERE EMPNO = "#url.empno#"
</cfquery>

<cfoutput>
<form name="moreAW" action="/payments/1stHalf/AddUpdate/normalPay_process.cfm?type=moreAW&empno=#url.empno#" method="post">
	<div class="mainTitle">More Allowances</div>
	
	<table>
	<tr>
		<th width="25px">No.</th>
		<th width="200px">Description</th>
		<th width="80px">Rate</th>
		<th width="25px"></th>
	</tr>
	<cfset j=101>
	<cfloop query="mAW_qry">
	<tr>
		<td>#mAW_qry.maw_cou#.</td>
		<td>#mAW_qry.maw_desp#</td>
		<td><input type="text" name="MAW#j#" value="#numberformat(evaluate('moreAW_qry.MAW#j#'),'.__')#" size="10"></td>
		<td><input type="text" name="maw_link" value="#mAW_qry.maw_link#" size="1" readonly></td>
	</tr>	
	<cfset j=j+1>
	</cfloop>
	<input type="hidden" name="empno" value="#moreAW_qry.empno#">
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

</form>
</cfoutput>
</body>

</html>