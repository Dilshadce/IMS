<html>
<head>
<title>Import List</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>
<cfset currentDirectory = "C:\POSFILE\importingdbf\importdbf\">
<cfif DirectoryExists(currentDirectory) eq false>
<h3>Folder 'importdbf' is not found</h3>
<cfelse>
<form action="importprocess.cfm" method="post" enctype="multipart/form-data">
<H1>Import List</H1>
<table align="center" class="data">
	<tr><td colspan="3"><div align="center"><font color="#FF0000" size="2"><strong>Import List</strong></font></div></td></tr>
    <tr><td colspan="3"><div align="center"><font color="#FF0000" size="2"><strong>Tick The Files to import</strong></font></div></td></tr>
    

    <tr>
        <td>Supplier</td>
        <td><font size="2">
        	<input type="checkbox" name="cbapvend" value="" checked>
        </font></td>
    </tr>

    <tr>
        <td>Customer</td>
        <td><font size="2">
        	<input type="checkbox" name="cbarcust" value="" checked>
        </font></td>
    </tr>

    <tr>
        <td>Transaction</td>
        <td><font size="2">
        	<input type="checkbox" name="cbartran" value="" checked>
        </font></td>
    </tr>

    

    <tr>
        <td>Item</td>
        <td><font size="2">
        	<input type="checkbox" name="cbicitem" value="" checked>
        </font></td>
    </tr>

    <tr>
    <td colspan="2"><input type="submit" name="submit" value="Submit"></td>
    </tr>
</table>
<br>
<br>
</form>
<cfoutput></cfoutput>
</cfif>
</body>
</html>