<html>
<head>
<title>Match Comment</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfparam name="submit" default="">

<cfif submit eq 'submit'>
	<cfquery name="update_comment" datasource="#dts#">
		update ictran,commen1 set 
		ictran.comment=commen1.comment 
		where ictran.type=commen1.type and ictran.refno=commen1.refno and ictran.trancode=commen1.trancode;
	</cfquery>
	
	<h1>Success</h1>
</cfif>

<body>
<h2>Match Comment</h2>

<form action="" method="post">
	<input type="submit" name="submit" value="submit">
</form>

</body>
</html>