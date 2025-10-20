<html>
<head>
<title>Edit Serial No Opening Quantity</title>
<link rel="stylesheet" type="text/css" href="/stylesheet/table.css" media="all">
<script language="javascript" type="text/javascript" src="/scripts/table.js"></script>
</head>
<body>
<cfquery name="getgeneral" datasource="#dts#">
select * from gsetup
</cfquery>
<h1 align="center">Edit <cfoutput>#getgeneral.lserial#</cfoutput>. Opening Quantity</h1>
<cfquery name="get_serialno_item" datasource="#dts#">
	select * from icitem
	where wserialno =  'T'
	order by itemno
</cfquery>

<table id="page" align="center" class="example table-autosort table-stripeclass:alternate table-page-number:t1page table-page-count:t1pages table-filtered-rowcount:t1filtercount table-rowcount:t1allcount table-autofilter">
	<thead>
		<tr>
			<th class="table-sortable:default filterable">Item No.</th>
			<th>Unit</th>
			<th class="table-sortable:numeric">Qty B/f</th>
			<th>Action</th>
		</tr>
	</thead>
	<tbody>
	<cfoutput query="get_serialno_item">
		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
        	<td>#get_serialno_item.itemno#</td>
            <td>#get_serialno_item.unit#</td>
            <td>#get_serialno_item.qtybf#</td>
            <td><img src="/images/userdefinedmenu/iedit.gif" alt="Edit" onClick="window.location.href='dsp_serialno_opening.cfm?itemno=#URLEncodedFormat(itemno)#'" style="cursor: hand;"></td>
        </tr>
	</cfoutput>
	</tbody>
</table>

</body>
</html>