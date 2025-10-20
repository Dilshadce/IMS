<html>
<head>
<title>IMPORT DBF FILE TO IMS</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>

<form action="uploadfile2.cfm" method="post" enctype="multipart/form-data">
<H1>Import DBF File To IMS</H1>

<cfif isdefined('url.done')>
<h3>Import has been done</h3>
</cfif>

<table align="center" class="data">
	<tr><td colspan="3"><div align="center"><font color="#FF0000" size="2"><strong>IMPORT FROM UBS</strong></font></div></td></tr>
    <tr>
    	<td>3.</td>
        <td>Upload Ziped DBF Files From Local Disk</td>
        <td><font size="2">
        	<input type="file" name="geticitem" size="25">
        </font></td>
    </tr>
	<tr>
    	<td>6.</td>
        <td>Import into Database</td>
        <td><font size="2">
        <input type="submit" name="importicitem" value="Import Item">
        </font></td>
    </tr>
</table>
<br>
<br>
</form>
<cfoutput></cfoutput>
</body>
</html>