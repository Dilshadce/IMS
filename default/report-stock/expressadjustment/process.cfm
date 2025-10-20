<html>
<head>
<title>Express Quantity Adjustment</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<body>

<cfinvoke component="cfc.expressphysical_adjustment_increase_reduce" method="update_icitem_qtyactual">
	<cfinvokeargument name="dts" value="#dts#">
	<cfinvokeargument name="form" value="#form#">
    <cfinvokeargument name="huserid" value="#huserid#">
</cfinvoke>

<script language="javascript" type="text/javascript">
	alert("Adjustment Process Done !");
	window.close();
</script>
</body>
</html>