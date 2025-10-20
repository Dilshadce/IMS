<html>
<head>
<title>Recover Update Result</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>
<cfif isdefined("form.qtyinout")>
	<cfinvoke component="cfc.recover_update_qtybf" method="general">
		<cfinvokeargument name="dts" value="#dts#">
	</cfinvoke>
</cfif>

<cfif isdefined("form.batch")>
	<cfinvoke component="cfc.recover_update_batch_qtybf" method="batch">
		<cfinvokeargument name="dts" value="#dts#">
	</cfinvoke>
</cfif>

<cfif isdefined("form.locationbatch")>
	<cfinvoke component="cfc.recover_update_batch_qtybf" method="locationbatch">
		<cfinvokeargument name="dts" value="#dts#">
	</cfinvoke>
</cfif>

<cfif isdefined("form.update_month_cost")>
	<cfinvoke component="cfc.recover_update_monthcost" method="monthcost">
		<cfinvokeargument name="dts" value="#dts#">
	</cfinvoke>
</cfif>

<script language="javascript" type="text/javascript">
	alert('Done !');
</script>

<h2 align="center">Done !</h2>

</body>
</html>