<html>
<head>
<title>Check Item Cost Price</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<body>
<cfoutput>
<h1>
Item Profile-without Price and Cost
</h1>
<cfquery name="geticitem" datasource="#dts#">
SELECT ucost,price,itemno,desp from icitem where ucost = 0 or price = 0
</cfquery>
<table width="800px">
<tr>
<th width="100px">Itemno</th>
<th width="500px">Desp</th>
<th width="100px">Unit Cost</th>
<th width="100px">Price</th>
</tr>
<cfloop query="geticitem">
<tr>
<th>#geticitem.itemno#</th>
<th>#geticitem.desp#</th>
<td <cfif geticitem.ucost lte "0">style="background:##FF0000"</cfif>>#geticitem.ucost#</td>
<td  <cfif geticitem.price lte "0">style="background:##FF0000"</cfif>>#geticitem.price#</td>
</tr>
</cfloop>
</table>
</cfoutput>
</body>
</html>