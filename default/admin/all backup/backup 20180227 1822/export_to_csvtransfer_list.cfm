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
        <th>Download Exported File </th>
    </tr>
    <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
    	<td>1.</td>
        <td onDblClick="javascript:window.location.href('export_to_csvtransfer.cfm')" title="Pls Double Click To Copy!">Copy Transfer File to DBF&nbsp;</td>
        <cfoutput><td align="center"><a href="/download/#dts#/DBF.zip">DBF File</a></td></cfoutput>
    </tr>
</table>

</body>
</html>