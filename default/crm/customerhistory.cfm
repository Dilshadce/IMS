<html>
<head>
<title>Customer Relationship Management</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script type='text/javascript' src='../../ajax/core/engine.js'></script>
<script type='text/javascript' src='../../ajax/core/util.js'></script>
<script type='text/javascript' src='../../ajax/core/settings.js'></script>

<script type="text/javascript">
	function disable1()
	{
		if(document.selectcust.custno.value == "")
			{document.selectcust.custfrom.disabled = false;
			 document.selectcust.custto.disabled = false;}
		else
			{document.selectcust.custfrom.disabled = true;
			 document.selectcust.custto.disabled = true;
			 document.selectcust.custfrom.value = "";
			 document.selectcust.custto.value = "";}
	}
	function disable2()
	{
		if(document.selectcust.custfrom.value == "" && document.selectcust.custto.value == "")
			{document.selectcust.custno.disabled = false;}
		else
			{document.selectcust.custno.disabled = true;
			document.selectcust.custno.value = "";}
	}
	function checkid()
	{
		if(document.selectcust.custno.value == "")
			{document.selectcust.custfrom.disabled = false;
			 document.selectcust.custto.disabled = false;}
		else
			{document.selectcust.custfrom.disabled = true;
			 document.selectcust.custto.disabled = true;
			 document.selectcust.custfrom.value = "";
			 document.selectcust.custto.value = "";}
	}
	
	// begin: customer search
	function getCust(type,option){
		if(type == 'custfrom'){
			var inputtext = document.selectcust.searchcustfr.value;
			DWREngine._execute(_reportflocation, null, 'supplierlookup', inputtext, option, getCustResult);
			
		}
		else{
			var inputtext = document.selectcust.searchcustto.value;
			DWREngine._execute(_reportflocation, null, 'supplierlookup', inputtext, option, getCustResult2);
		}
	}
	
	function getCustResult(suppArray){
		DWRUtil.removeAllOptions("custfrom");
		DWRUtil.addOptions("custfrom", suppArray,"KEY", "VALUE");
	}
	
	function getCustResult2(suppArray){
		DWRUtil.removeAllOptions("custto");
		DWRUtil.addOptions("custto", suppArray,"KEY", "VALUE");
	}
	// end: customer search
</script>
</head>
<body onLoad="checkid()">

<h1>View Customer History</h1>
<!---<cfset curdate = dateformat(now(),"dd-mm-yyyy")>--->

<!--- <cfquery name="getcust" datasource="#dts#">
	select custno,name,wos_date from ictran where itemno = "MAINTENANCE-1Y" and (type="inv" or type="do") group by custno order by custno
</cfquery> --->
<cfquery name="getgeneral" datasource="#dts#">
	select filterall from gsetup
</cfquery>
<cfquery name="getcust" datasource="#dts#">
	select custno,name,wos_date from artran where frem9 = 'T' and type='INV' group by custno order by custno
</cfquery>

<cfform name="selectcust" action="historyresult.cfm" method="post" target="_blank">
	<table align="center" class="data">
		<tr>
			<th>Customer ID</th>
			<cfoutput>
			<cfif isdefined("url.custno")>
				<td><cfinput name="custno" onBlur="disable1()" type="text" value="#custno#">
			<cfelse>
				<td><cfinput name="custno" onBlur="disable1()" type="text" value="">
			</cfif>
			<a href="ctsearch.cfm?type=custhistory">SEARCH</a></td>
			</cfoutput>
		</tr>
		<tr> 
			<td colspan="7"><hr></td>
		</tr>
		<th>Customer From</th>
        <td><select name="custfrom" onchange="disable2()">
				<option value="">Choose a Customer</option>
				<cfoutput>
				<cfloop query="getcust">
					<cfset expiredate = DateAdd("d", 372 , getcust.wos_date)>
					<cfset checkdate = datediff("d",now(),expiredate)>
					<cfif checkdate gte 1>
						<option value="#custno#">#custno# - #name#</option>
					</cfif>
				</cfloop>
				</cfoutput>
			</select>
			<cfif getgeneral.filterall eq "1">
				<input type="text" name="searchcustfr" onkeyup="getCust('custfrom','Customer');">
			</cfif>
		</td>
      	</tr>
      	<tr> 
        	<th>Customer To</th>
        	<td><select name="custto" onchange="disable2()">
				<option value="">Choose a Customer</option>
				<cfoutput>
				<cfloop query="getcust">
					<cfset expiredate = DateAdd("d", 372 , getcust.wos_date)>
					<cfset checkdate = datediff("d",now(),expiredate)>
					<cfif checkdate gte 1>
						<option value="#custno#">#custno# - #name#</option>
					</cfif>
				</cfloop>
				</cfoutput>
			</select>	
			<cfif getgeneral.filterall eq "1">
				<input type="text" name="searchcustto" onkeyup="getCust('custto','Customer');">
			</cfif>
			</td>
      	</tr>
		<tr>
			<td></td>
			<td align="right" nowrap><cfinput name="submit" type="submit" value="Submit"></td>
			<td align="right" nowrap><cfinput name="reset" type="reset" value="Reset" onClick="window.location='customerhistory.cfm'"></td>
		</tr>
	</table>
</cfform>
</body>
</html>