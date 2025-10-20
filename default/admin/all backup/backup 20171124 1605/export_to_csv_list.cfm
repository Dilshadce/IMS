<html>
<head>
<title>EXPORT TO CSV FILE</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<cfparam name="submit" default="">

<body>

<H1>Export To CSV File</H1>
<h3>* Please double click on the description to go to the next screen.</h3>
<cfif isdefined("url.process")>
	<div><font color="#FF0000" size="2"><strong><cfoutput>#form.status#</cfoutput></strong></font></div>
</cfif>
<table align="center" class="data">
	<tr>
    	<th>No</th>
        <th>Description</th>
        <th>Download Exported File Ver 9.2</th>
    </tr>
    <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
    	<td>1.</td>
        <td><a href="export_to_csv.cfm?type=arcust">Copy Customer File to ARCUST9.CSV&nbsp;</a></td>
        
        <cfoutput><td align="center"><a href="..\..\download\#dts#\ver9.0\ARCUST9.CSV">ARCUST9.CSV</a></td></cfoutput>
    </tr>
    <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
    	<td>2.</td>
        <td><a href="export_to_csv.cfm?type=apvend">Copy Supplier File to APVEND9.CSV&nbsp;</a></td>
        <cfoutput><td align="center"><a href="..\..\download\#dts#\ver9.0\APVEND9.CSV">APVEND9.CSV</a></td></cfoutput>
    </tr>
</table>

</body>
</html>