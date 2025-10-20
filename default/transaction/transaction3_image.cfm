<html>
<head>
<title>Item Image</title>
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

</head>
<body>

<cfoutput>
	<cfif isdefined('url.itemno')>
    <cfquery name="getitemimage" datasource="#dts#">
    select photo from icitem where itemno='#url.itemno#'
    </cfquery>
    <cfif getitemimage.photo neq ''>
		<img src="\images\#hcomid#\#getitemimage.photo#" align="middle" width="100" height="100" onClick="parent.showpic(this)">
    <cfelse>
    No Image
    </cfif>
	</cfif>
</cfoutput>

</body>
</html>