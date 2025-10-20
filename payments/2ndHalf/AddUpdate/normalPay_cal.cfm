<html>
<head>
	<title>Caluculate Working Days</title>
	<link href="/stylesheet/app.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
function calt(){
	document.mForm.wday.value = parseInt(document.mForm.dim.value) - parseInt(document.mForm.ddcomm.value) +1 - parseInt(document.mForm.rest1.value) - parseInt(document.mForm.rest2.value);
	opener.document.eForm.WDAY.value = document.mForm.wday.value;
	window.close();
}
</script>

</head>

<body>

<cfquery name="cal_qry" datasource="#dts#">
SELECT *, day(dcomm) as ddcomm, month(dcomm) as mdcomm, year(dcomm) as ydcomm
FROM pmast
WHERE empno = "#url.empno#"
</cfquery>
<!--- /payments/2ndHalf/AddUpdate/normalPay_process.cfm?type=cal --->
<cfoutput>
<form name="mForm" action="" method="post">
<cfset commDate = CreateDate(#cal_qry.ydcomm#, #cal_qry.mdcomm#, #cal_qry.ddcomm#)>
<cfset d0=0>
<cfset d1=#cal_qry.ddcomm#>
<cfset d2=d1-1>
<cfset sun=0>
<cfset mon=0>
<cfset tue=0>
<cfset wed=0>
<cfset thu=0>
<cfset fri=0>
<cfset sat=0>
<cfloop from=#cal_qry.ddcomm# to=#daysInMonth(commDate)# index="i">
<cfset d0=(i+d2) MOD 7>
<cfswitch expression="#d0#"> 
	<cfcase value="0"> 
		<cfset sun=sun+1>
	</cfcase>
	<cfcase value="1"> 
		<cfset mon=mon+1>
	</cfcase>
	<cfcase value="2"> 
		<cfset tue=tue+1>
	</cfcase>
	<cfcase value="3"> 
		<cfset wed=wed+1>
	</cfcase>
	<cfcase value="4"> 
		<cfset thu=thu+1>
	</cfcase>
	<cfcase value="5"> 
		<cfset fri=fri+1>
	</cfcase>
	<cfcase value="6"> 
		<cfset sat=sat+1>
	</cfcase>
</cfswitch>
</cfloop>
<input type="hidden" name="sun" value="#sun#">
<input type="hidden" name="mon" value="#mon#">
<input type="hidden" name="tue" value="#tue#">
<input type="hidden" name="wed" value="#wed#">
<input type="hidden" name="thu" value="#thu#">
<input type="hidden" name="fri" value="#fri#">
<input type="hidden" name="sat" value="#sat#">
<!--- <cfset wday=#daysInMonth(commDate)# - #d1# +1 - #sat# - #sun#> --->
<input type="hidden" name="wday" value="">
<input type="hidden" name="" value="#mon#,#tue#,#wed#,#thu#,#fri#,#sat#,#sun#">
<table class="form">
<tr>
	<input type="hidden" name="ddcomm" value="#cal_qry.ddcomm#">
	<input type="hidden" name="mdcomm" value="#cal_qry.mdcomm#">
	<input type="hidden" name="ydcomm" value="#cal_qry.ydcomm#">
	<input type="hidden" name="dim" value="#daysInMonth(commDate)#">
	<td>Date Commence</td>
	<td><input type="text" name="dcomm" value="#DateFormat(cal_qry.dcomm, "dd-mm-yyyy")#" size="12" readonly></td>
</tr>
<tr>
	<td><br />Rest Day</td>
	<td><br />
	<select name="rest1">
		<option value="0">Nil</option>
		<option value="#sun#">Sunday</option>
		<option value="#mon#">Monday</option>
		<option value="#tue#">Tuesday</option>
		<option value="#wed#">Wednesday</option>
		<option value="#thu#">Thursday</option>
		<option value="#fri#">Friday</option>
		<option value="#sat#">Saturday</option>
	</select>
	</td>
</tr>
<tr>
	<td>Rest Day 2</td>
	<td>
	<select name="rest2">
		<option value="0">Nil</option>
		<option value="#sun#">Sunday</option>
		<option value="#mon#">Monday</option>
		<option value="#tue#">Tuesday</option>
		<option value="#wed#">Wednesday</option>
		<option value="#thu#">Thursday</option>
		<option value="#fri#">Friday</option>
		<option value="#sat#">Saturday</option>
	</select>
	</td>
</tr>
<tr>
	<td colspan="2" align="right"><br /><input type="button" name="save" value="Save" onclick="calt();"></td>
</tr>
</table>
</form>
</cfoutput>
</body>

</html>