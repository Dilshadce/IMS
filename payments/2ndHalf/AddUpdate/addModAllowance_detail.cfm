<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<title>Assign Tip Point To Employees</title>
	<script src="/javascripts/tabber.js" type="text/javascript"></script>
	<link href="/stylesheet/tabber.css" rel="stylesheet" TYPE="text/css" MEDIA="screen">
	<link href="/stylesheet/app.css" rel="stylesheet" type="text/css">
	<script language="javascript" type="text/javascript" src="/javascripts/ajax.js"></script>

<cfquery name="detail_qry" datasource="#dts#">
SELECT 	empno,name,payrtype,dcomm,dresign FROM pmast
</cfquery>

<body>
	
<div class="mainTitle">Assign Tip Point To Employees</div>
<div class="tabber">
	
	<table>
		<tr>
			<td>Select :</td>
			<td><select id="sEmp" name="sEmp" onChange="ajaxFunction(document.getElementById('ajaxField'),'addModAllowance_detailAjax.cfm?c='+this.options[this.selectedIndex].id);">
				<option id="default"  value="default">All</option>
				<cfoutput query="detail_qry">
				<option id="#detail_qry.empno#" value="#detail_qry.empno#">#detail_qry.empno#</option>
				</cfoutput>
			</select></td>
		</tr>
	</table>
		
	<div id="ajaxField" name="ajaxField">
	<table class="form" border="0">	
		<tr>
			<th>Name</td>
			<th>Pay Rate Type</td>
			<th>Date Commence</td>
			<th>Date Resign</td>
		</tr>
		<cfoutput query="detail_qry">
		<tr>
			<td><input type="text" name="" value="#detail_qry.name#"></td>
			<td><input type="text" name="" value="#detail_qry.payrtype#"></td>
			<td><input type="text" name="" value="#lsdateformat(detail_qry.dcomm,"dd/mm/yyyy")#"></td>
			<td><input type="text" name="" value="#lsdateformat(detail_qry.dresign,"dd/mm/yyyy")#"></td>
		</tr>
		</cfoutput>
	</table>
	</div>
	
	<center>
		<input type="button" name="cancel" value="Cancel" onclick="window.location.href='addModAllowance.cfm';">
	</center>
	
</div>

</body>
</html>