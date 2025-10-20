<html>
<head>
<title>Check FIFO Item Cost Price</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<body>
<cfoutput>
<h1>
Item FIFO Profile-With Quantity But Without Cost
</h1>
<cfquery name="geticitem" datasource="#dts#">
SELECT * from icitem as a left join  fifoopq as b on a.itemno = b.itemno
</cfquery>
<table width="1000px">
<tr>
<th width="100px">Itemno</th>
<th width="400px">Desp</th>
<th width="500px">Fifo Item With Quantity Without Price</th>
</tr>
<cfloop query="geticitem">
<cfset msgcount = "">
<cfloop from="11" to="50" index="i">
<cfset ffq = "ffq"&i>
<cfset ffc = "ffc"&i>
<cfif evaluate('geticitem.#ffq#') gt 0 and evaluate('geticitem.#ffc#') lte 0>
<cfset msgcount = msgcount&ffq&" - "&ffc&"<br />">
</cfif>
</cfloop>
<cfif msgcount neq "">
<tr>
<th>#geticitem.itemno#</th>
<th>#geticitem.desp#</th>

<td style="background:##FF0000">#msgcount#</td>
</tr>
</cfif>
</cfloop>
</table>
</cfoutput>
</body>
</html>