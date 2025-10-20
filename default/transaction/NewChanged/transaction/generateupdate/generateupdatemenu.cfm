<html>
<head>
<title>Generate / Update Menu</title>
<link rel="stylesheet" href="../../../stylesheet/stylesheet.css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<h1><center>Generate / Update Menu</center></h1>

<br><br>
Click on the following to select functions.
<br><br>
<table width="60%" border="0" class="data" align="center">
	<tr>
  		<cfif getpin2.h2901 eq 'T'><td nowrap><a href="distribute_miscellaneous_charges_into_cost.cfm" target="mainFrame"><img name="Cash Sales" src="../../../images/reportlogo.gif">Distribute Miscellaneous Charges Into Cost</a></td></cfif>
		<cfif getpin2.h2902 eq 'T'><td nowrap><a href="generate_full_payment_date.cfm" target="_blank" onClick="javascript:return confirm('Are You Sure ?');"><img name="Cash Sales" src="../../../images/reportlogo.gif">Generate Full Payment Date</a></td></cfif>
		<cfif getpin2.h2903 eq 'T'><td nowrap><a href="generate_customer_outstanding_balance.cfm" target="_blank" onClick="javascript:return confirm('Are You Sure ?');"><img name="Cash Sales" src="../../../images/reportlogo.gif">Generate Customer Outstanding Balance</a></td></cfif>
	</tr>
</table>
<p>&nbsp;</p>
<p>&nbsp;</p>
</body>
</html>