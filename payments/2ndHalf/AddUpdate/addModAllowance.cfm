<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<title>Add Modified Allowance</title>
	<script src="/javascripts/tabber.js" type="text/javascript"></script>
	<link href="/stylesheet/tabber.css" rel="stylesheet" TYPE="text/css" MEDIA="screen">
	<link href="/stylesheet/app.css" rel="stylesheet" type="text/css">
	
</head>

<cfquery name="getPaytran_qry" datasource="#dts#">
SELECT * FROM paytran
</cfquery>
	
<body>
	<div class="mainTitle">Add Modified Allowance</div>

	<form name="aForm" action="addModAllowance_process.cfm" method="post">	
	<div class="tabber">
	
	<!---table>
		<tr>
			<td>Search :</td>
			<td><select id="sEmp" name="sEmp">
				<option id="default"  value="default">All</option>
				<cfoutput query="getPaytran_qry">
				<option id="#getPaytran_qry.empno#" value="#getPaytran_qry.empno#">#getPaytran_qry.empno#</option>
				</cfoutput>
			</select></td>
		</tr>
	</table--->
		<div class="tabbertab">
			<h3>All</h3>
			<div style="width:100%; height:250px; overflow:auto;">
			<table class="form" border="0">
			<tr>
				<th width="">Employee No.</th>
				<th width="">HANDPHONE</th>
				<th width="">INCENTIVE</th>
				<th width="">MEAL</th>
				<th width="">AW4</th>
				<th width="">AW5</th>
				<th width="">AW6</th>
				<th width="">ATTN.ALLW</th>
				<th width="">FOOD.ALLW</th>
				<th width="">NO LATENESS</th>
				<th width="">NO ABSENT</th>
				<th width="">SHIFT ALL:</th>
				<th width="">TIP ALL.</th>
				<th width="">AW13</th>
				<th width="">AW14</th>
				<th width="">AW15</th>
				<th width="">AW16</th>
				<th width="">AW17</th>
			</tr>
			<cfoutput query="getPaytran_qry">
			<tr>
				<td><input type="text" name="#getPaytran_qry.empno#" value="#getPaytran_qry.empno#"></td>
				<td><input type="text" name="aw101__r#getPaytran_qry.empno#" value="#getPaytran_qry.aw101#"></td>
				<td><input type="text" name="aw102__r#getPaytran_qry.empno#" value="#getPaytran_qry.aw102#"></td>
				<td><input type="text" name="aw103__r#getPaytran_qry.empno#" value="#getPaytran_qry.aw103#"></td>
				<td><input type="text" name="aw104__r#getPaytran_qry.empno#" value="#getPaytran_qry.aw104#"></td>
				<td><input type="text" name="aw105__r#getPaytran_qry.empno#" value="#getPaytran_qry.aw105#"></td>
				<td><input type="text" name="aw106__r#getPaytran_qry.empno#" value="#getPaytran_qry.aw106#"></td>
				<td><input type="text" name="aw107__r#getPaytran_qry.empno#" value="#getPaytran_qry.aw107#"></td>
				<td><input type="text" name="aw108__r#getPaytran_qry.empno#" value="#getPaytran_qry.aw108#"></td>
				<td><input type="text" name="aw109__r#getPaytran_qry.empno#" value="#getPaytran_qry.aw109#"></td>
				<td><input type="text" name="aw110__r#getPaytran_qry.empno#" value="#getPaytran_qry.aw110#"></td>
				<td><input type="text" name="aw111__r#getPaytran_qry.empno#" value="#getPaytran_qry.aw111#"></td>
				<td><input type="text" name="aw112__r#getPaytran_qry.empno#" value="#getPaytran_qry.aw112#"></td>
				<td><input type="text" name="aw113__r#getPaytran_qry.empno#" value="#getPaytran_qry.aw113#"></td>
				<td><input type="text" name="aw114__r#getPaytran_qry.empno#" value="#getPaytran_qry.aw114#"></td>
				<td><input type="text" name="aw115__r#getPaytran_qry.empno#" value="#getPaytran_qry.aw115#"></td>
				<td><input type="text" name="aw116__r#getPaytran_qry.empno#" value="#getPaytran_qry.aw116#"></td>
				<td><input type="text" name="aw117__r#getPaytran_qry.empno#" value="#getPaytran_qry.aw117#"></td>
			</tr>
			</cfoutput>
			</table>
			</div>
		</div>
		
		<div class="tabbertab">
			<h3>Fixed</h3>
			<table class="form" border="0">
			<tr>
				<th width="">Employee No.</th>
				<th width="">HANDPHONE</th>
				<th width="">INCENTIVE</th>
				<th width="">MEAL</th>
				<th width="">AW4</th>
				<th width="">AW5</th>
				<th width="">AW6</th>
			</tr>
			<cfoutput query="getPaytran_qry">
			<tr>
				<td><input type="text" name="#getPaytran_qry.empno#" value="#getPaytran_qry.empno#"></td>
				<td><input type="text" name="aw101__r#getPaytran_qry.empno#" value="#getPaytran_qry.aw101#"></td>
				<td><input type="text" name="aw102__r#getPaytran_qry.empno#" value="#getPaytran_qry.aw102#"></td>
				<td><input type="text" name="aw103__r#getPaytran_qry.empno#" value="#getPaytran_qry.aw103#"></td>
				<td><input type="text" name="aw104__r#getPaytran_qry.empno#" value="#getPaytran_qry.aw104#"></td>
				<td><input type="text" name="aw105__r#getPaytran_qry.empno#" value="#getPaytran_qry.aw105#"></td>
				<td><input type="text" name="aw106__r#getPaytran_qry.empno#" value="#getPaytran_qry.aw106#"></td>
			</tr>
			</cfoutput>
			</table>
		</div>
		
		<div class="tabbertab">
			<h3>Variable</h3>
			<table class="form" border="0">
			<tr>
				<th width="">Employee No.</th>
				<th width="">ATTN.ALLW</th>
				<th width="">FOOD.ALLW</th>
				<th width="">NO LATENESS</th>
				<th width="">NO ABSENT</th>
				<th width="">TIP ALL.</th>
			</tr>
			<cfoutput query="getPaytran_qry">
			<tr>
				<td><input type="text" name="aw107__r#getPaytran_qry.empno#" value="#getPaytran_qry.aw107#"></td>
				<td><input type="text" name="aw108__r#getPaytran_qry.empno#" value="#getPaytran_qry.aw108#"></td>
				<td><input type="text" name="aw109__r#getPaytran_qry.empno#" value="#getPaytran_qry.aw109#"></td>
				<td><input type="text" name="aw110__r#getPaytran_qry.empno#" value="#getPaytran_qry.aw110#"></td>
				<td><input type="text" name="aw112__r#getPaytran_qry.empno#" value="#getPaytran_qry.aw112#"></td>
			</tr>
			</cfoutput>
			</table>
		</div>
		
		<div class="tabbertab">
			<h3>Day Based</h3>
			<table class="form" border="0">
			<tr>
				<th width="">Employee No.</th>
				<th width="">AW13</th>
				<th width="">AW14</th>
				<th width="">AW15</th>
				<th width="">AW16</th>
				<th width="">AW17</th>
			</tr>
			<cfoutput query="getPaytran_qry">
			<tr>
				<td><input type="text" name="#getPaytran_qry.empno#" value="#getPaytran_qry.empno#"></td>
				<td><input type="text" name="aw113__r#getPaytran_qry.empno#" value="#getPaytran_qry.aw113#"></td>
				<td><input type="text" name="aw114__r#getPaytran_qry.empno#" value="#getPaytran_qry.aw114#"></td>
				<td><input type="text" name="aw115__r#getPaytran_qry.empno#" value="#getPaytran_qry.aw115#"></td>
				<td><input type="text" name="aw116__r#getPaytran_qry.empno#" value="#getPaytran_qry.aw116#"></td>
				<td><input type="text" name="aw117__r#getPaytran_qry.empno#" value="#getPaytran_qry.aw117#"></td>
			</tr>
			</cfoutput>
			</table>
		</div>

	</div>
	<br />

	<center>
		<input type="reset" name="reset" value="Reset">
		<input type="submit" name="save" value="Save">
		<input type="button" name="detail" value="Detail" onclick="window.location.href='addModAllowance_detail.cfm'">
		<input type="button" name="cancel" value="Cancel" onclick="window.location.href='AddUpdateList.cfm';">
	</center>
	
	</form>
</body>
</html>
