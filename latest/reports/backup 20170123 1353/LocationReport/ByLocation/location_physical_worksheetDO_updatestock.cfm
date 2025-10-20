<html>
<head>
<title>Physical Worksheet Update DO</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<body>

<cfinvoke component="cfc.location_ physical_adjustmentDO" method="update_icitem_qtyactual">
	<cfinvokeargument name="dts" value="#dts#">
	<cfinvokeargument name="form" value="#form#">
    <cfinvokeargument name="huserid" value="#huserid#">
    <cfinvokeargument name="target_arcust" value="#target_arcust#">
</cfinvoke>

<script language="javascript" type="text/javascript">
	alert("Location Adjustment Process Done !");
	window.close();
</script>
</body>
</html>