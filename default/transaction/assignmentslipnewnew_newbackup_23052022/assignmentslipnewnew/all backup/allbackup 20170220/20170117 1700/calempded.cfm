<html>
<head>
	<title>More Deductions</title>
	<link href="/stylesheet/app.css" rel="stylesheet" type="text/css">
</head>

<body>
<cfset dts1 = replace(dts,'_i','_p','All')>
<cfquery name="mDED_qry" datasource="#dts1#">
SELECT * FROM dedtable
</cfquery>

<cfquery name="mDED_qry2" datasource="#dts1#">
SELECT * FROM paytra1 WHERE EMPNO = "#url.empno#"
</cfquery>

<cfoutput>
<cfform name="moreDED" action="/default/transaction/assignmentslipnewnew/calempded_process.cfm?type=moreDED&empno=#url.empno#" method="post">
	<div class="mainTitle">More Deductions</div>
	
	<table>
	<tr>
		<th width="25">No.</th>
		<th width="200">Description</th>
		<th width="80">Rate</th>
	</tr>
	<cfset j=101>
	<cfloop query="mDED_qry">
	<tr>
		<td>#mDED_qry.ded_cou#.</td>
		<td>#mDED_qry.ded_desp#</td>
		<td><input type="text" name="DED#j#" value="#numberformat(evaluate('mDED_qry2.DED#j#'),'.__')#" size="10"></td>
		
	</tr>
	<cfset j=j+1>
	</cfloop>
	<input type="hidden" name="empno" value="#mDED_qry2.empno#">
</table>

<table class="form">
<tr>
	<td width="340px" align="right"><br />
		<!--- <input type="reset" name="reset" value="Reset"> --->
		<input type="submit" name="save" value="Save">
		<input type="button" name="close" value="Close" onClick="ColdFusion.Window.hide('calempded');">
	</td>
</tr>
</table>

</cfform>
</cfoutput>
</body>

</html>