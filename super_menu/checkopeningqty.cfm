<html>
<head>
<title>Item With Different Opening Qty and Fifo Qty</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<body>
<cfoutput>
<h1>
Item With Different Opening Qty and Fifo Qty 
</h1>
<cfquery name="geticitem" datasource="#dts#">
select a.*,a.ffq11
<cfloop from="12" to="50" index="i">
+a.ffq#i#
</cfloop>
as qtyfifo
,b.* from fifoopq as a,icitem as b
where a.itemno=b.itemno

</cfquery>
<table width="800px">
<tr>
<th width="100px">Itemno</th>
<th width="500px">Desp</th>
<th width="100px">Opening Qty</th>
<th width="100px">Fifo Opening Qty</th>
</tr>
<cfloop query="geticitem">
<tr <cfif geticitem.qtyfifo neq geticitem.qtybf>style="background:##FF0000"</cfif>>
<th>#geticitem.itemno#</th>
<th>#geticitem.desp#</th>
<td >#geticitem.qtybf#</td>
<td >#geticitem.qtyfifo#</td>
</tr>
</cfloop>
</table>
</cfoutput>
</body>
</html>