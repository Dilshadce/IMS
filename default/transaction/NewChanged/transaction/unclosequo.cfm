<html>
<head>
<title>Close Quotation</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script type='text/javascript' src='/scripts/ajax.js'></script>

<script type="text/javascript">
function checkValidate(){
	if(document.form.oldrefno.value == ''){
		alert('Please Select A Reference No.');
		return false;
	}
			return true;
}
</script>

</head>
<body>
<cfif isdefined("url.process")>
	<cfoutput><h3>#form.status#</h3><hr></cfoutput>
</cfif>
<form name="form" action="unclosequo1.cfm" method="post">
<H1>Close Quotation</H1>

<cfquery name="getrefno" datasource="#dts#">
	select refno,name from artran
	where type ='QUO'
	and fperiod <> '99'
	and (posted is null or posted ='')
    and toinv = "C"
    and order_cl="C"
    and exported="C"
    and (void is null or void ='')
	order by refno
</cfquery>
<table align="center" width="60%" class="data">
	
	<tr>
		<th>Reference No.</th>
		<td>
				<select name="oldrefno">
					<option value="">Choose a Reference No.</option>
	          		<cfoutput query="getrefno">
	            		<option value="#refno#">#refno# - #name#</option>
	          		</cfoutput>
				</select>
            <input type="hidden" name="reftype" id="reftype" value="QUO">
		</td>
	</tr>
	<tr><td colspan="100%"><hr></td></tr>
	<tr>
		<td colspan="100%" align="center">
			<input type="submit" name="submit" value="Submit" onClick="return checkValidate();">
		</td>
	</tr>
</table>
</form>
</body>
</html>