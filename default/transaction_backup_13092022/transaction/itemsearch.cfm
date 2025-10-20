<html>
<head>
<title>Create Or Edit Or View</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>
<h1></h1>
<cfoutput>
	<cfif url.type eq "Create">
		<cfif url.stype eq "inv">
			<form action="itemsearch.cfm?stype=#url.stype#&type=#url.type#&newinvoice=#url.newinvoice#&custno=#URLEncodedFormat(url.custno)#&invoicedate=#invoicedate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#" method="post">
		<cfelseif url.stype eq "DO">
			<form action="itemsearch.cfm?stype=#url.stype#&type=#url.type#&newdo=#url.newdo#&custno=#URLEncodedFormat(url.custno)#&deliveryorderdate=#deliveryorderdate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#" method="post">
		<cfelseif url.stype eq "PR">
			<form action="itemsearch.cfm?stype=#url.stype#&type=#url.type#&newpr=#url.newpr#&custno=#URLEncodedFormat(url.custno)#&preturndate=#preturndate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#" method="post">
		<cfelseif url.stype eq "RC">
			<form action="itemsearch.cfm?stype=#url.stype#&type=#url.type#&newrc=#url.newrc#&custno=#URLEncodedFormat(url.custno)#&purchasedate=#purchasedate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#" method="post">
		<cfelseif url.stype eq "CN">
			<form action="itemsearch.cfm?stype=#url.stype#&type=#url.type#&newcn=#url.newcn#&custno=#URLEncodedFormat(url.custno)#&creditnotedate=#creditnotedate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#" method="post">
		<cfelseif url.stype eq "DN">
			<form action="itemsearch.cfm?stype=#url.stype#&type=#url.type#&newinvoice=#url.newinvoice#&custno=#URLEncodedFormat(url.custno)#&invoicedate=#invoicedate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#" method="post">
		<cfelseif url.stype eq "PO">
			<form action="itemsearch.cfm?stype=#url.stype#&type=#url.type#&newpo=#url.newpo#&supp1=#URLEncodedFormat(url.supp1)#&podate=#podate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#" method="post">
		<cfelseif url.stype eq "SO">
			<form action="itemsearch.cfm?stype=#url.stype#&type=#url.type#&newso=#url.newso#&custno=#URLEncodedFormat(url.custno)#&sodate=#sodate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#" method="post">
		<cfelseif url.stype eq "QUO">
			<form action="itemsearch.cfm?stype=#url.stype#&type=#url.type#&newquo=#url.newquo#&custno=#URLEncodedFormat(url.custno)#&quodate=#quodate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#" method="post">
		</cfif>
	<cfelse>
		<cfif url.stype eq "inv">
			<form action="itemsearch.cfm?stype=#url.stype#&type=#url.type#&refno=#url.refno#&custno=#URLEncodedFormat(url.custno)#&invoicedate=#invoicedate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#" method="post">
		<cfelseif url.stype eq "DO">
			<form action="itemsearch.cfm?stype=#url.stype#&type=#url.type#&refno=#url.refno#&custno=#URLEncodedFormat(url.custno)#&deliveryorderdate=#deliveryorderdate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#" method="post">
		<cfelseif url.stype eq "PR">
			<form action="itemsearch.cfm?stype=#url.stype#&type=#url.type#&refno=#url.refno#&custno=#URLEncodedFormat(url.custno)#&preturndate=#preturndate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#" method="post">
		<cfelseif url.stype eq "RC">
			<form action="itemsearch.cfm?stype=#url.stype#&type=#url.type#&refno=#url.refno#&custno=#URLEncodedFormat(url.custno)#&purchasedate=#purchasedate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#" method="post">
		<cfelseif url.stype eq "CN">
			<form action="itemsearch.cfm?stype=#url.stype#&type=#url.type#&refno=#url.refno#&custno=#URLEncodedFormat(url.custno)#&creditnotedate=#creditnotedate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#" method="post">
		<cfelseif url.stype eq "DN">
			<form action="itemsearch.cfm?stype=#url.stype#&type=#url.type#&refno=#url.refno#&custno=#URLEncodedFormat(url.custno)#&invoicedate=#invoicedate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#" method="post">
		<cfelseif url.stype eq "PO">
			<form action="itemsearch.cfm?stype=#url.stype#&type=#url.type#&refno=#url.refno#&supp1=#URLEncodedFormat(url.supp1)#&podate=#podate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#" method="post">
		<cfelseif url.stype eq "SO">
			<form action="itemsearch.cfm?stype=#url.stype#&type=#url.type#&refno=#url.refno#&custno=#URLEncodedFormat(url.custno)#&sodate=#sodate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#" method="post">
		<cfelseif url.stype eq "QUO">
			<form action="itemsearch.cfm?stype=#url.stype#&type=#url.type#&refno=#url.refno#&custno=#URLEncodedFormat(url.custno)#&quodate=#quodate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#" method="post">
		</cfif>
	</cfif>
	
	<h1>Search By :
		<select name="searchType">
			<option value="itemno">Item No</option>
			<option value="mitemno">Product Code</option>
		</select>
		Search for Item :
		<input type="text" name="searchStr" value="">
	</h1>
	</form>

	<cfif isdefined("url.process")>
		<h1>#form.status#</h1><hr>
	</cfif>
</cfoutput>

<cfquery datasource='#dts#' name="type">
	Select * from icitem order by itemno
</cfquery>

<cfif isdefined("form.searchStr")>
	<cfquery dbtype="query" name="exactResult">
		Select * from TYPE where #form.searchType# = '#form.searchStr#'
	</cfquery>

	<cfquery dbtype="query" name="similarResult">
		Select * from TYPE where #form.searchType# LIKE '%#form.searchStr#%'
	</cfquery>

	<h2>Exact Result</h2>
	
	<cfif exactResult.recordCount neq 0>
		<table align="center" class="data" width="550px">
			<tr>
				<th>Item No</th>
				<th>Description</th>
				<th>Brand</th>
				<th>Category</th>
				<th>Group</th>
				<th>Price</th>
				<th>Status</th>
				<th>Action</th>
			</tr>
			<cfoutput query="exactResult" maxrows="10">
				<tr>
					<td>#exactResult.itemno#</a></td>
					<td>#exactResult.desp#<br>#type.despa#</td>
					<td>#exactResult.brand#</td>
					<td>#exactResult.category#</td>
					<td>#exactResult.wos_group#</td>
					<td>#exactResult.price#</td>
					<td align="center">#exactResult.nonstkitem#</td>
					<td><cfif exactResult.nonstkitem neq "T">
							<cfif url.type eq "Create">
								<cfif url.stype eq "inv">
									<a href="invoice3.cfm?stype=#url.stype#&type=#url.type#&newinvoice=#url.newinvoice#&custno=#URLEncodedFormat(url.custno)#&invoicedate=#invoicedate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#exactResult.itemno#">Select</a>
								<cfelseif url.stype eq "DO">
									<a href="deliveryorder3.cfm?stype=#url.stype#&type=#url.type#&newdo=#url.newdo#&custno=#URLEncodedFormat(url.custno)#&deliveryorderdate=#deliveryorderdate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#exactResult.itemno#">Select</a>
								<cfelseif url.stype eq "PR">
									<a href="preturn3.cfm?stype=#url.stype#&type=#url.type#&newpr=#url.newpr#&custno=#URLEncodedFormat(url.custno)#&preturndate=#preturndate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#exactResult.itemno#">Select</a>
								<cfelseif url.stype eq "RC">
									<a href="purchase3.cfm?stype=#url.stype#&type=#url.type#&newrc=#url.newrc#&custno=#URLEncodedFormat(url.custno)#&purchasedate=#purchasedate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#exactResult.itemno#">Select</a>
								<cfelseif url.stype eq "CN">
									<a href="creditnote3.cfm?stype=#url.stype#&type=#url.type#&newcn=#url.newcn#&custno=#URLEncodedFormat(url.custno)#&creditnotedate=#creditnotedate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#exactResult.itemno#">Select</a>
								<cfelseif url.stype eq "DN">
									<a href="debitnote3.cfm?stype=#url.stype#&type=#url.type#&newinvoice=#url.newinvoice#&custno=#URLEncodedFormat(url.custno)#&invoicedate=#invoicedate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#exactResult.itemno#">Select</a>
								<cfelseif url.stype eq "PO">
									<a href="otransaction_po3.cfm?stype=#url.stype#&type=#url.type#&newpo=#url.newpo#&supp1=#URLEncodedFormat(url.supp1)#&podate=#podate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#exactResult.itemno#">Select</a>
								<cfelseif url.stype eq "SO">
									<a href="otransaction_so3.cfm?stype=#url.stype#&type=#url.type#&newso=#url.newso#&custno=#URLEncodedFormat(url.custno)#&sodate=#sodate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#exactResult.itemno#">Select</a>
								<cfelseif url.stype eq "QUO">
									<a href="otransaction_quo3.cfm?stype=#url.stype#&type=#url.type#&newquo=#url.newquo#&custno=#URLEncodedFormat(url.custno)#&quodate=#quodate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#exactResult.itemno#">Select</a>
								</cfif>
							<cfelse>
								<cfif url.stype eq "inv">
									<a href="invoice3.cfm?stype=#url.stype#&type=#url.type#&newinvoice=#url.refno#&custno=#URLEncodedFormat(url.custno)#&invoicedate=#invoicedate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#exactResult.itemno#">Select</a>
								<cfelseif url.stype eq "DO">
									<a href="deliveryorder3.cfm?stype=#url.stype#&type=#url.type#&newdo=#url.refno#&custno=#URLEncodedFormat(url.custno)#&deliveryorderdate=#deliveryorderdate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#exactResult.itemno#">Select</a>
								<cfelseif url.stype eq "PR">
									<a href="preturn3.cfm?stype=#url.stype#&type=#url.type#&newpr=#url.refno#&custno=#URLEncodedFormat(url.custno)#&preturndate=#preturndate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#exactResult.itemno#">Select</a>
								<cfelseif url.stype eq "RC">
									<a href="purchase3.cfm?stype=#url.stype#&type=#url.type#&newrc=#url.refno#&custno=#URLEncodedFormat(url.custno)#&purchasedate=#purchasedate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#exactResult.itemno#">Select</a>
								<cfelseif url.stype eq "CN">
									<a href="creditnote3.cfm?stype=#url.stype#&type=#url.type#&newcn=#url.refno#&custno=#URLEncodedFormat(url.custno)#&creditnotedate=#creditnotedate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#exactResult.itemno#">Select</a>
								<cfelseif url.stype eq "DN">
									<a href="debitnote3.cfm?stype=#url.stype#&type=#url.type#&newinvoice=#url.refno#&custno=#URLEncodedFormat(url.custno)#&invoicedate=#invoicedate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#exactResult.itemno#">Select</a>
								<cfelseif url.stype eq "PO">
									<a href="otransaction_po3.cfm?stype=#url.stype#&type=#url.type#&newpo=#url.refno#&supp1=#URLEncodedFormat(url.supp1)#&podate=#podate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#exactResult.itemno#">Select</a>
								<cfelseif url.stype eq "SO">
									<a href="otransaction_so3.cfm?stype=#url.stype#&type=#url.type#&newso=#url.refno#&custno=#URLEncodedFormat(url.custno)#&sodate=#sodate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#exactResult.itemno#">Select</a>
								<cfelseif url.stype eq "QUO">
									<a href="otransaction_quo3.cfm?stype=#url.stype#&type=#url.type#&newquo=#url.refno#&custno=#URLEncodedFormat(url.custno)#&quodate=#quodate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#exactResult.itemno#">Select</a>
								</cfif>
							</cfif>
						</cfif>
						</td>
					</tr>
				</cfoutput>
			</table>
		<cfelse>
			<h3>No Exact Records were found.</h3>
		</cfif>

		<h2>Similar Result</h2>
		
		<cfif similarResult.recordCount neq 0>
			<table align="center" class="data" width="600px">
				<tr>
					<th>Item No</th>
					<th>Description</th>
					<th>Brand</th>
					<th>Category</th>
					<th>Group</th>
					<th>Price</th>
					<th>Status</th>
					<th>Action</th>
				</tr>
				<cfoutput query="similarResult" maxrows="10">
					<tr>
						<td>#similarResult.itemno#</a></td>
						<td>#similarResult.desp#<br>#type.despa#</td>
						<td>#similarResult.brand#</td>
						<td>#similarResult.category#</td>
						<td>#similarResult.wos_group#</td>
						<td>#similarResult.price#</td>
						<td align="center">#similarResult.nonstkitem#</td>
						<td><cfif similarResult.nonstkitem neq "T">
								<cfif url.type eq "Create">
									<cfif url.stype eq "inv">
										<a href="invoice3.cfm?stype=#url.stype#&type=#url.type#&newinvoice=#url.newinvoice#&custno=#URLEncodedFormat(url.custno)#&invoicedate=#invoicedate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#similarResult.itemno#">Select</a>
									<cfelseif url.stype eq "DO">
										<a href="deliveryorder3.cfm?stype=#url.stype#&type=#url.type#&newdo=#url.newdo#&custno=#URLEncodedFormat(url.custno)#&deliveryorderdate=#deliveryorderdate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#similarResult.itemno#">Select</a>
									<cfelseif url.stype eq "PR">
										<a href="preturn3.cfm?stype=#url.stype#&type=#url.type#&newpr=#url.newpr#&custno=#URLEncodedFormat(url.custno)#&preturndate=#preturndate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#similarResult.itemno#">Select</a>
									<cfelseif url.stype eq "RC">
										<a href="purchase3.cfm?stype=#url.stype#&type=#url.type#&newrce=#url.newrc#&custno=#URLEncodedFormat(url.custno)#&purchasedate=#purchasedate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#similarResult.itemno#">Select</a>
									<cfelseif url.stype eq "CN">
										<a href="creditnote3.cfm?stype=#url.stype#&type=#url.type#&newcn=#url.newcn#&custno=#URLEncodedFormat(url.custno)#&creditnotedate=#creditnotedate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#similarResult.itemno#">Select</a>
									<cfelseif url.stype eq "DN">
										<a href="debitnote3.cfm?stype=#url.stype#&type=#url.type#&newinvoice=#url.newinvoice#&custno=#URLEncodedFormat(url.custno)#&debitnotedate=#debitnotedate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#similarResult.itemno#">Select</a>
									<cfelseif url.stype eq "PO">
										<a href="otransaction_po3.cfm?stype=#url.stype#&type=#url.type#&newpo=#url.newpo#&supp1=#URLEncodedFormat(url.supp1)#&podate=#podate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#similarResult.itemno#">Select</a>
									<cfelseif url.stype eq "SO">
										<a href="otransaction_so3.cfm?stype=#url.stype#&type=#url.type#&newso=#url.newso#&custno=#URLEncodedFormat(url.custno)#&sodate=#sodate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#similarResult.itemno#">Select</a>
									<cfelseif url.stype eq "QUO">
										<a href="otransaction_quo3.cfm?stype=#url.stype#&type=#url.type#&newquo=#url.newquo#&custno=#URLEncodedFormat(url.custno)#&quodate=#quodate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#similarResult.itemno#">Select</a>
									</cfif>
								<cfelse>
									<cfif url.stype eq "inv">
										<a href="invoice3.cfm?stype=#url.stype#&type=#url.type#&newinvoice=#url.refno#&custno=#URLEncodedFormat(url.custno)#&invoicedate=#invoicedate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#similarResult.itemno#">Select</a>
									<cfelseif url.stype eq "DO">
										<a href="deliveryorder3.cfm?stype=#url.stype#&type=#url.type#&newdo=#url.refno#&custno=#URLEncodedFormat(url.custno)#&deliveryorderdate=#deliveryorderdate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#similarResult.itemno#">Select</a>
									<cfelseif url.stype eq "PR">
										<a href="preturn3.cfm?stype=#url.stype#&type=#url.type#&newpr=#url.refno#&custno=#URLEncodedFormat(url.custno)#&preturndate=#preturndate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#similarResult.itemno#">Select</a>
									<cfelseif url.stype eq "RC">
										<a href="purchase3.cfm?stype=#url.stype#&type=#url.type#&newrc=#url.refno#&custno=#URLEncodedFormat(url.custno)#&purchasedate=#purchasedate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#similarResult.itemno#">Select</a>
									<cfelseif url.stype eq "CN">
										<a href="creditnote3.cfm?stype=#url.stype#&type=#url.type#&newcn=#url.refno#&custno=#URLEncodedFormat(url.custno)#&creditnotedate=#creditnotedate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#similarResult.itemno#">Select</a>
									<cfelseif url.stype eq "DN">
										<a href="debitnote3.cfm?stype=#url.stype#&type=#url.type#&newinvoice=#url.refno#&custno=#URLEncodedFormat(url.custno)#&invoicedate=#invoicedate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#similarResult.itemno#">Select</a>
									<cfelseif url.stype eq "PO">
										<a href="otransaction_po3.cfm?stype=#url.stype#&type=#url.type#&newpo=#url.refno#&supp1=#URLEncodedFormat(url.supp1)#&podate=#podate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#similarResult.itemno#">Select</a>
									<cfelseif url.stype eq "SO">
										<a href="otransaction_so3.cfm?stype=#url.stype#&type=#url.type#&newso=#url.refno#&custno=#URLEncodedFormat(url.custno)#&sodate=#sodate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#similarResult.itemno#">Select</a>
									<cfelseif url.stype eq "QUO">
										<a href="otransaction_quo3.cfm?stype=#url.stype#&type=#url.type#&newquo=#url.refno#&custno=#URLEncodedFormat(url.custno)#&quodate=#quodate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#similarResult.itemno#">Select</a>
									</cfif>
								</cfif>
							</cfif>
						</td>
					</tr>
				</cfoutput>
			</table>
		<cfelse>
			<h3>No Similar Records were found.</h3>
		</cfif>
	</cfif>

	<cfparam name="i" default="1" type="numeric">
	<hr>
	<fieldset>
	<legend style="font-family:Verdana,Arial,Helvetica,sans-serif;font-size:12px;font-style:italic;line-height:normal;font-weight:bold;text-transform:capitalize;color:#0066FF;">
		20 Newest Icitem:
	</legend>
	<br>
	
	<cfif type.recordCount neq 0>
		<table align="center" class="data" width="600px">
			<tr>
				<th>No.</th>
				<th>Item No</th>
				<th>Description</th>
				<th>Brand</th>
				<th>Category</th>
				<th>Group</th>
				<th>Price</th>
				<th>Status</th>
				<th>Action</th>
				<input type="hidden" name="newinvoice" value="#url.refno#">
			</tr>
			<cfoutput query="type" maxrows="20">
				<tr>
					<td>#i#</td>
					<td>#type.itemno#</a></td>
					<td>#type.desp#<br>#type.despa#</td>
					<td>#type.brand#</td>
					<td>#type.category#</td>
					<td>#type.wos_group#</td>
					<td>#type.price#</td>
					<td>#type.nonstkitem#</td>
					<td><cfif type.nonstkitem neq "T">
							<cfif url.type eq "Create">
								<cfif url.stype eq "inv">
									<a href="invoice3.cfm?stype=#url.stype#&type=#url.type#&newinvoice=#url.newinvoice#&custno=#URLEncodedFormat(url.custno)#&invoicedate=#invoicedate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#type.itemno#">Select</a>
								<cfelseif url.stype eq "DO">
									<a href="deliveryorder3.cfm?stype=#url.stype#&type=#url.type#&newdo=#url.newdo#&custno=#URLEncodedFormat(url.custno)#&deliveryorderdate=#deliveryorderdate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#type.itemno#">Select</a>
								<cfelseif url.stype eq "PR">
									<a href="preturn3.cfm?stype=#url.stype#&type=#url.type#&newpr=#url.newpr#&custno=#URLEncodedFormat(url.custno)#&preturndate=#preturndate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#type.itemno#">Select</a>
								<cfelseif url.stype eq "RC">
									<a href="purchase3.cfm?stype=#url.stype#&type=#url.type#&newrce=#url.newrc#&custno=#URLEncodedFormat(url.custno)#&purchasedate=#purchasedate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#type.itemno#">Select</a>
								<cfelseif url.stype eq "CN">
									<a href="creditnote3.cfm?stype=#url.stype#&type=#url.type#&newcn=#url.newcn#&custno=#URLEncodedFormat(url.custno)#&creditnotedate=#creditnotedate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#type.itemno#">Select</a>
								<cfelseif url.stype eq "DN">
									<a href="debitnote3.cfm?stype=#url.stype#&type=#url.type#&newinvoice=#url.newinvoice#&custno=#URLEncodedFormat(url.custno)#&invoicedate=#invoicedate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#type.itemno#">Select</a>
								<cfelseif url.stype eq "PO">
									<a href="otransaction_po3.cfm?stype=#url.stype#&type=#url.type#&newpo=#url.newpo#&supp1=#URLEncodedFormat(url.supp1)#&podate=#podate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#type.itemno#">Select</a>
								<cfelseif url.stype eq "SO">
									<a href="otransaction_so3.cfm?stype=#url.stype#&type=#url.type#&newso=#url.newso#&custno=#URLEncodedFormat(url.custno)#&sodate=#sodate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#type.itemno#">Select</a>
								<cfelseif url.stype eq "QUO">
									<a href="otransaction_quo3.cfm?stype=#url.stype#&type=#url.type#&newquo=#url.newquo#&custno=#URLEncodedFormat(url.custno)#&quoodate=#quodate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#type.itemno#">Select</a>
								</cfif>
							<cfelse>
								<cfif url.stype eq "inv">
									<a href="invoice3.cfm?stype=#url.stype#&type=#url.type#&newinvoice=#url.refno#&custno=#URLEncodedFormat(url.custno)#&invoicedate=#invoicedate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#type.itemno#">Select</a>
								<cfelseif url.stype eq "DO">
									<a href="deliveryorder3.cfm?stype=#url.stype#&type=#url.type#&newdo=#url.refno#&custno=#URLEncodedFormat(url.custno)#&deliveryorderdate=#deliveryorderdate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#type.itemno#">Select</a>
								<cfelseif url.stype eq "PR">
									<a href="preturn3.cfm?stype=#url.stype#&type=#url.type#&newpr=#url.refno#&custno=#URLEncodedFormat(url.custno)#&preturndate=#preturndate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#type.itemno#">Select</a>
								<cfelseif url.stype eq "RC">
									<a href="purchase3.cfm?stype=#url.stype#&type=#url.type#&newrc=#url.refno#&custno=#URLEncodedFormat(url.custno)#&purchasedate=#purchasedate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#type.itemno#">Select</a>
								<cfelseif url.stype eq "CN">
									<a href="creditnote3.cfm?stype=#url.stype#&type=#url.type#&newcn=#url.refno#&custno=#URLEncodedFormat(url.custno)#&creditnotedate=#creditnotedate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#type.itemno#">Select</a>
								<cfelseif url.stype eq "DN">
									<a href="debitnote3.cfm?stype=#url.stype#&type=#url.type#&newinvoice=#url.refno#&custno=#URLEncodedFormat(url.custno)#&invoicedate=#invoicedate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#type.itemno#">Select</a>
								<cfelseif url.stype eq "PO">
									<a href="otransaction_po3.cfm?stype=#url.stype#&type=#url.type#&newpo=#url.refno#&supp1=#URLEncodedFormat(url.supp1)#&podate=#podate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#type.itemno#">Select</a>
								<cfelseif url.stype eq "SO">
									<a href="otransaction_so3.cfm?stype=#url.stype#&type=#url.type#&newso=#url.refno#&custno=#URLEncodedFormat(url.custno)#&sodate=#sodate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#type.itemno#">Select</a>
								<cfelseif url.stype eq "QUO">
									<a href="otransaction_quo3.cfm?stype=#url.stype#&type=#url.type#&newquo=#url.refno#&custno=#URLEncodedFormat(url.custno)#&quodate=#quodate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#type.itemno#">Select</a>
								</cfif>
							</cfif>
						</cfif>
					</td>
				</tr>
			<cfset i = incrementvalue(i)>
		</cfoutput>
	</table>
<cfelse>
	<h3>No Records were found.</h3>
</cfif>

<br>
</fieldset>
</body>
</html>