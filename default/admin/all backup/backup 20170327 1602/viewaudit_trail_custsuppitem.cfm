<html>
<head>
<title>View Audit Trail For Customer/Supplier/Product</title>
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../../scripts/date_format.js"></script>
</head>

<body>
<h1 align="center">View Audit Trail For Customer/Supplier/Product</h1>
<form name="form" action="viewaudit_trail_custsuppitem1.cfm" method="post" target="_blank">
<table border="0" align="center" width="50%" class="data">
	<tr>
	  	<td nowrap colspan="2">
        	<input type="radio" name="result" value="edited_arcust" checked>Edited Customer<br/>
			<input type="radio" name="result" value="deleted_arcust" checked>Deleted Customer<br/>
			<input type="radio" name="result" value="deleted_apvend">Deleted Supplier<br/>
			<input type="radio" name="result" value="deleted_icitem">Deleted Product
		</td>
	</tr>
	<tr><td colspan="100%"><hr></td></tr>
	<tr>
		<th>Cust/Supp/Item No.</th>
		<td><input type="text" name="code"></td>
	</tr>
	<tr>
		<th>Date From</th>
		<td><input name="datefrom" type="text" value="" size="11" onKeyUp="DateFormat(this,this.value,event,false,'3');" onBlur="DateFormat(this,this.value,event,true,'3');"> (DD/MM/YYYY)</td>
	</tr>
	<tr>
		<th>Date To</th>
		<td><input name="dateto" type="text" value="" size="11" onKeyUp="DateFormat(this,this.value,event,false,'3');" onBlur="DateFormat(this,this.value,event,true,'3');"> (DD/MM/YYYY)</td>
	</tr>
	<tr> 
        <td colspan="2" align="right"><input type="submit" name="Submit" value="Submit"></td>
    </tr>
</table>
</form>
</body>
</html>