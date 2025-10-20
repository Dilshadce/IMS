<cfoutput>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type=
"text/css">
<h3>
	<a><font size="2">Eform Report</font></a>
</h3>

<form name="form1" id="form1"  action="eformreportEmployee.cfm" method="post" target="_blank"><!---action="eformreportprocess.cfm"--->
<table class="data">
<tr>
<th>Client ID</th>
<td>
<input type="text" name="custno" id="custno" value="">
</td>
</tr>
<tr>
<td colspan="100%" align="center">
<input type="submit" name="sub_btn" id="sub_btn" value="Submit">
<!---
&nbsp;&nbsp;&nbsp; 
<input type="submit" name="subbtn" id="subbtn" value="Get All Client Excel" onClick="document.form1.action = 'eformexcel.cfm';">
--->
</td>
</tr>
</table>
</form>
</cfoutput>