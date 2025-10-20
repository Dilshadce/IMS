<html>
<head>
	<title>Add / Modify Zakat</title>
	<link rel="stylesheet" href="/stylesheet/app.css"/>

<script language="javascript">

function showFoot(empno)
{
	document.getElementById("aname").innerHTML = document.getElementById("name_"+empno).value;
	document.getElementById("adcomm").innerHTML = document.getElementById("dcomm_"+empno).value;
	document.getElementById("aprt").innerHTML = document.getElementById("payrtype_"+empno).value;
	document.getElementById("adresign").innerHTML = document.getElementById("dresign_"+empno).value;
}

</script>

</head>

<body>

<cfquery name="zakat_qry" datasource="#dts#">
SELECT pm.empno, pm.name, pm.dcomm, pm.dresign, pm.payrtype, pm.brate, p.zakat_bf
FROM paytran p, pmast pm 
WHERE p.empno = pm.empno and confid >= #hpin# 
ORDER BY length(pm.empno),pm.empno
</cfquery>

<cfoutput>
<form name="aForm" action="/payments/2ndHalf/addUpdate/addModifyZakatMain_process.cfm" method="post">
<div class="mainTitle">Add / Modify Zakat</div>
<div style="width:555px;height:300px;overflow:auto;">
<table class="form">
<tr>
	<th>Employee No.</th>
	<th>Baisc Rate</th>
	<th>Zakat B/F or Paid</th>
</tr>
<cfloop query="zakat_qry">
<tr onClick="showFoot('#zakat_qry.currentrow#');">
	<td>#zakat_qry.empno#</td>
	<td>#zakat_qry.brate#</td>
	<td><input type="text" name="zakat_bf_#zakat_qry.currentrow#" value="#zakat_qry.zakat_bf#" size="18" maxlength="10" /></tr>

	<input type="hidden" name="empno" value="#zakat_qry.empno#">
	<input type="hidden" name="name_#zakat_qry.currentrow#" id="name_#zakat_qry.currentrow#" value="#zakat_qry.name#">
	<input type="hidden" name="dcomm_#zakat_qry.currentrow#" id="dcomm_#zakat_qry.currentrow#" value="#DateFormat(zakat_qry.dcomm, "dd-mm-yyyy")#">
	<input type="hidden" name="payrtype_#zakat_qry.currentrow#" id="payrtype_#zakat_qry.currentrow#" 
		value="<cfif #zakat_qry.payrtype# eq "M">Monthly<cfelseif #zakat_qry.payrtype# eq "D">Daily<cfelseif #zakat_qry.payrtype# eq "H">Hourly</cfif>">
	<input type="hidden" name="dresign_#zakat_qry.currentrow#" id="dresign_#zakat_qry.currentrow#" value="#DateFormat(zakat_qry.dresign, "dd-mm-yyyy")#">

</cfloop>
</table>
</div>

<table border="1">
<tr>
	<td>Name</td>
	<td>:</td>
	<td width="200"><label id="aname"></label></td>
	<td></td>
	<td>Date Commence</td>
	<td>:</td>
	<td width="125"><label id="adcomm"></label></td>
</tr>
<tr>
	<td>Pay Rate Type</td>
	<td>:</td>
	<td><label id="aprt"></label>
	</td>
	<td></td>
	<td>Date Resign</td>
	<td>:</td>
	<td><label id="adresign"></label></td>
</tr>
</table>

<table>
<tr>
	<td width="555px" align="right"><br />
		<input type="submit" name="submit" value="Save">
		<input type="button" name="cancel" value="Cancel" onClick="window.location='/payments/2ndHalf/addUpdate/addUpdateList.cfm'">
	</td>
</tr>
</table>

</form>
</cfoutput>
</body>

</html>