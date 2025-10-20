<html>
<head>
<title>Customer Relationship Management</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script type='text/javascript' src='../../ajax/core/engine.js'></script>
<script type='text/javascript' src='../../ajax/core/util.js'></script>
<script type='text/javascript' src='../../ajax/core/settings.js'></script>

<script type="text/javascript">
	
// begin: customer search
function getCust(option){
	var inputtext = document.chkcntct.searchcust.value;
	DWREngine._execute(_reportflocation, null, 'supplierlookup', inputtext, option, getCustResult);
}

function getCustResult(custArray){
	DWRUtil.removeAllOptions("custno");
	DWRUtil.addOptions("custno", custArray,"KEY", "VALUE");
}
// end: customer search

</script>
</head>
<body>
<h1>Check Customer Contract Expiry</h1>
<br><br>
<hr>
<br>
<cfquery name="getgeneral" datasource="#dts#">
	select filterall from gsetup
</cfquery>
<cfform name="chkcntct" action="chkcntct2.cfm" method="post">
<table align="center" class="data">
	<tr>
		<th>Customer ID</th>
		<cfif getgeneral.filterall eq "1">
			<cfquery name="getcust" datasource="#dts#">
				select custno,name as cname from #target_arcust# order by custno
			</cfquery>
			<td>
				<select name="custno">
					<option value="">Choose a Customer</option>
					<cfoutput query="getcust">
						<option value="#getcust.custno#">#getcust.custno# - #getcust.cname#</option>
					</cfoutput>
				</select>
				<input type="text" name="searchcust" onKeyUp="getCust('Customer');">
			</td>
		<cfelse>
			<cfif isdefined("url.custno")>
				<td><cfoutput><input name="custno" type="text" value="#custno#"></cfoutput>
			<cfelse>
				<td><cfoutput><input name="custno" type="text" value=""></cfoutput>
			</cfif>
			<a href="ctsearch.cfm?type=chkcnt">SEARCH</a></td>
		</cfif>
	</tr>
	<tr>
		<td></td>
		<td align="right" nowrap><input name="submit" type="submit" value="Submit"></td>
	</tr>
</table>
</cfform>
</body>
</html>