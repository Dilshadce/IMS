<html>
<head>
<title>Compare Project</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfquery datasource="#dts#" name="getGeneralInfo">
	SELECT * 
    FROM gsetup;
</cfquery>

<cfset listnotimported=''>

<body>
<cfform action="import_project3.cfm" method="post" enctype="multipart/form-data">
<H1>Compare Project</H1>
<table align="center" class="data">
	<tr><td colspan="3"><div align="center"><font color="#FF0000" size="2"><strong>IMPORT Project</strong></font></div></td></tr>
    <tr>
        <td>Get File (<cfoutput>project.xls</cfoutput>) From Local Disk</td>
        <td><font size="2">
        	<input type="file" name="geticitem" size="25">
        </font></td>
    </tr>
	<tr>
        <td>Import into Database</td>
        <td><font size="2">
        <input type="submit" name="importicitem" value="Import">
        </font></td>
    </tr>
</table>
</cfform>
<cfoutput>


</cfoutput>
</body>
</html>