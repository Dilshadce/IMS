<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<title>Assign Tip Point To Employees</title>
	<script src="/javascripts/tabber.js" type="text/javascript"></script>
	<link href="/stylesheet/tabber.css" rel="stylesheet" TYPE="text/css" MEDIA="screen">
	<link href="/stylesheet/app.css" rel="stylesheet" type="text/css">
	<script language="javascript" type="text/javascript" src="/javascripts/ajax.js"></script>
	
	<script language="javascript">
	function showFoot(empno)
	{
		document.getElementById("ename").innerHTML = document.getElementById("name_"+empno).value;
		document.getElementById("edcomm").innerHTML = document.getElementById("dcomm_"+empno).value;
		document.getElementById("epayrtype").innerHTML = document.getElementById("payrtype_"+empno).value;
		document.getElementById("edresign").innerHTML = document.getElementById("dresign_"+empno).value;
	}
	</script>

<cfquery name="tipPoint_qry" datasource="#dts#">
SELECT a.empno,a.brate,a.name,a.payrtype,a.dcomm,a.dresign,
b.empno,b.tippoint 
FROM pmast AS a LEFT JOIN paytra1 AS b ON a.empno=b.empno WHERE a.paystatus = "A" and confid >= #hpin#
order by length(a.empno), a.empno
</cfquery>

<body>
	
<div class="mainTitle">Assign Tip Point To Employees</div>
<div class="tabber">
	
	<table>
		<tr>
			<td>Search :</td>
			<td><select id="sEmp" name="sEmp" onChange="ajaxFunction(document.getElementById('ajaxField'),'assignMain_ajax.cfm?c='+this.options[this.selectedIndex].id);">
				<option id="default"  value="default">All</option>
				<cfoutput query="tipPoint_qry">
				<option id="#tipPoint_qry.empno#" value="#tipPoint_qry.empno#">#tipPoint_qry.empno#</option>
				</cfoutput>
			</select></td>
		</tr>
	</table>
	
	<div id="ajaxField" name="ajaxField">
	<form name="eForm" action="assignMain_add.cfm" method="post">
		<table class="form" border="0">	
		<tr>
			<th width="160px">Employee No.</th>
			<th width="120px">Basic Rate</th>
			<th width="120px">Tip Point</th>
		</tr>
		<cfoutput query="tipPoint_qry">
		<tr onclick="showFoot('#tipPoint_qry.currentrow#');">
			<td>
				<input type="text" id="empno" name="empno" value="#tipPoint_qry.empno#" size="25" readonly="yes" />
			</td>
			<td>
				<input type="text" name="brate" value="#tipPoint_qry.brate#" size="18" readonly="yes" />
			</td>
			<td>
				<input type="text" name="tippoint__r#tipPoint_qry.empno#" value="#tipPoint_qry.tippoint#" size="18" maxlength="10" />
			</td>
			
				<input type="hidden" name="empno" id="empno" value="#tippoint_qry.empno#">
				<input type="hidden" name="name_#tippoint_qry.currentrow#" id="name_#tippoint_qry.currentrow#" value="#tippoint_qry.name#">
				<input type="hidden" name="dcomm_#tippoint_qry.currentrow#" id="dcomm_#tippoint_qry.currentrow#" value="#DateFormat(tippoint_qry.dcomm, "dd-mm-yyyy")#">
				<input type="hidden" name="payrtype_#tippoint_qry.currentrow#" id="payrtype_#tippoint_qry.currentrow#" value="<cfif #tippoint_qry.payrtype# eq "M">Monthly<cfelseif #tippoint_qry.payrtype# eq "D">Daily<cfelseif #tippoint_qry.payrtype# eq "H">Hourly</cfif>">
				<input type="hidden" name="dresign_#tippoint_qry.currentrow#" id="dresign_#tippoint_qry.currentrow#" value="#DateFormat(tippoint_qry.dresign, "dd-mm-yyyy")#">
				
		</tr>
		</cfoutput>
		</table>
		<br />
		
		<table border="1">
			<tr>
				<td>Name</td>
				<td>:</td>
				<td width="200"><label id="ename"></label></td>
				<td></td>
				<td>Date Commence</td>
				<td>:</td>
				<td width="125"><label id="edcomm"></label></td>
			</tr>
			<tr>
				<td>Pay Rate Type</td>
				<td>:</td>
				<td><label id="epayrtype"></label></td>
				<td></td>
				<td>Date Resign</td>
				<td>:</td>
				<td><label id="edresign"></label></td>
			</tr>
		</table>
		<br />	
		
	<center>
		<input type="submit" name="save" value="Save">
		<input type="button" name="cancel" value="Cancel" onclick="window.location.href='tnpList.cfm';">
	</center>
	</form>
	</div>
	
</div>

</body>
</html>