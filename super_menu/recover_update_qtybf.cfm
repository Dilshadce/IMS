<html>
<head>
<title>Recover Update QTYBF</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>
<cfinvoke component="cfc.recover_update_qtybf" method="general">
	<cfinvokeargument name="dts" value="#dts#">
</cfinvoke>

<cfinvoke component="cfc.recover_update_qtybf" method="batch">
	<cfinvokeargument name="dts" value="#dts#">
</cfinvoke>

<script language="javascript" type="text/javascript">
	alert('Done !');
</script>

<h2 align="center">Done !</h2>
</body>
</html>