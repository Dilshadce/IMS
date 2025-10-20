<cfquery name="checkcustom" datasource="#dts#">
    select customcompany from dealer_menu
</cfquery>
<html>
<head>
<title>Create Or Edit Or View</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>
<br>

<cfif isdefined('consignment')>
    <cfset consignment=consignment>
    <cfelse>
    <cfset consignment=''>
    </cfif>

<cfoutput>
	<cfif checkcustom.customcompany eq "Y">
		<cfset xremark5=url.remark5>
		<cfset xremark6=url.remark6>
	<cfelse>
		<cfset xremark5="">
		<cfset xremark6="">
	</cfif>
	<form action="issitemsearch.cfm?tran=#tran#&type=#type#&stype=#stype#&nexttranno=#nexttranno#&custno=#URLEncodedFormat(custno)#&invoicedate=#invoicedate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&name=#name#&agenno=#agenno#&hmode=#hmode#<cfif tran eq 'TR'>&trfrom=#trfrom#&trto=#trto#&oldtrfrom=#oldtrfrom#&oldtrto=#oldtrto#&ttran=#ttran#</cfif>&remark5=#xremark5#&remark6=#xremark6#&consignment=#consignment#" method="post">
		<h1>
        <cfif isdefined('url.TRfrom')><input type="hidden" name="trfrom" id="trfrom" value="#url.trfrom#"></cfif>
		Search By :
		<select name="searchType">
			<option value="itemno">Item No</option>
			<option value="mitemno">Product Code</option>
			<option value="desp">Description</option>
			<option value="category">Category</option>
			<option value="wos_group">Group</option>
			<option value="brand">Brand</option>
		</select>
		Search for Item :
		<input type="text" name="searchStr" value="">
		<cfif husergrpid eq "Muser"><input type="submit" name="submit" value="Search"></cfif> 
		</h1>
	</form>

<cfif isdefined("url.process")>
	<h1>#form.status#</h1><hr>
</cfif>

</cfoutput>

<cfquery datasource='#dts#' name="type1">
	Select itemno,desp,despa,brand,category,wos_group,price,nonstkitem,created_on from Icitem
    WHERE 1=1
    <cfif Hitemgroup neq ''>
        and wos_group='#Hitemgroup#'
    </cfif>
    order by created_on desc limit 20 
</cfquery>

<cfif isdefined("form.searchStr")>
	<cfquery datasource='#dts#' name="exactResult">
		Select itemno,desp,despa,brand,category,wos_group,price,nonstkitem from icitem where #form.searchType# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.searchStr#">
        <cfif Hitemgroup neq ''>
        and wos_group='#Hitemgroup#'
    	</cfif>
         order by #form.searchType#
	</cfquery>

	<cfquery datasource='#dts#' name="similarResult">
		Select itemno,desp,despa,brand,category,wos_group,price,nonstkitem from icitem where #form.searchType# LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#form.searchStr#%">
        <cfif Hitemgroup neq ''>
        and wos_group='#Hitemgroup#'
    	</cfif>
        order by #form.searchType#
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
			
			<cfoutput query="exactResult">
				<tr>
					<td>#exactResult.itemno#</a></td>
					<td>#exactResult.desp#<br>#exactResult.despa#</td>
					<td>#exactResult.brand#</td>
					<td>#exactResult.category#</td>
					<td>#exactResult.wos_group#</td>
					<td>#exactResult.price#</td>
					<td align="center">#exactResult.nonstkitem#</td>
					<td>
					<cfif exactResult.nonstkitem neq "T">
						<cfif type eq "Create">
							<a href="iss3.cfm?tran=#tran#&type=#type#&stype=#stype#&nexttranno=#nexttranno#&custno=#URLEncodedFormat(custno)#&invoicedate=#invoicedate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#URLEncodedFormat(exactResult.itemno)#&name=#name#&agenno=#agenno#&hmode=#hmode#<cfif tran eq 'TR'>&trfrom=#trfrom#&trto=#trto#&oldtrfrom=#oldtrfrom#&oldtrto=#oldtrto#&ttran=#ttran#</cfif>&remark5=#xremark5#&remark6=#xremark6#&consignment=#consignment#<cfif isdefined('url.TRfrom')>&trfrom=#url.trfrom#</cfif>">Select</a>
						<cfelse>
							<a href="iss3.cfm?tran=#tran#&type=#type#&stype=#stype#&nexttranno=#nexttranno#&custno=#URLEncodedFormat(custno)#&invoicedate=#invoicedate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#URLEncodedFormat(exactResult.itemno)#&name=#name#&agenno=#agenno#&hmode=#hmode#<cfif tran eq 'TR'>&trfrom=#trfrom#&trto=#trto#&oldtrfrom=#oldtrfrom#&oldtrto=#oldtrto#&ttran=#ttran#</cfif>&remark5=#xremark5#&remark6=#xremark6#&consignment=#consignment#<cfif isdefined('url.TRfrom')>&trfrom=#url.trfrom#</cfif>">Select</a>
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
			
			<cfoutput query="similarResult">
				<tr>
					<td>#similarResult.itemno#</a></td>
					<td>#similarResult.desp#<br>#similarResult.despa#</td>
					<td>#similarResult.brand#</td>
					<td>#similarResult.category#</td>
					<td>#similarResult.wos_group#</td>
					<td>#similarResult.price#</td>
					<td align="center">#similarResult.nonstkitem#</td>
					<td>
					<cfif similarResult.nonstkitem neq "T">
						<cfif type eq "Create">
							<a href="iss3.cfm?tran=#tran#&type=#type#stype=#stype#&nexttranno=#nexttranno#&custno=#URLEncodedFormat(custno)#&invoicedate=#invoicedate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#URLEncodedFormat(similarResult.itemno)#&name=#name#&agenno=#agenno#&hmode=#hmode#<cfif tran eq 'TR'>&trfrom=#trfrom#&trto=#trto#&oldtrfrom=#oldtrfrom#&oldtrto=#oldtrto#&ttran=#ttran#</cfif>&remark5=#xremark5#&remark6=#xremark6#&consignment=#consignment#<cfif isdefined('url.TRfrom')>&trfrom=#url.trfrom#</cfif>">Select</a>
						<cfelse>
							<a href="iss3.cfm?tran=#tran#&type=#type#stype=#stype#&nexttranno=#nexttranno#&custno=#URLEncodedFormat(custno)#&invoicedate=#invoicedate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#URLEncodedFormat(similarResult.itemno)#&name=#name#&agenno=#agenno#&hmode=#hmode#<cfif tran eq 'TR'>&trfrom=#trfrom#&trto=#trto#&oldtrfrom=#oldtrfrom#&oldtrto=#oldtrto#&ttran=#ttran#</cfif>&remark5=#xremark5#&remark6=#xremark6#&consignment=#consignment#<cfif isdefined('url.TRfrom')>&trfrom=#url.trfrom#</cfif>">Select</a>
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
<legend style="font-family:Verdana,Arial,Helvetica,sans-serif;font-size:12px;font-style:italic;line-height:normal;font-weight:bold;text-transform:capitalize;color:##0066FF;">
	20 Newest Icitem:
</legend>
<br>

<cfif type1.recordCount neq 0>
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
		</tr>
		
		<cfoutput query="type1" maxrows="20">
			<tr>
				<td>#i#</td>
				<td>#type1.itemno#</a></td>
				<td>#type1.desp#<br>#type1.despa#</td>
				<td>#type1.brand#</td>
				<td>#type1.category#</td>
				<td>#type1.wos_group#</td>
				<td>#type1.price#</td>
				<td align="center">#type1.nonstkitem#</td>
				<td>
				<cfif type1.nonstkitem neq "T">
					<cfif type eq "Create">
						<a href="iss3.cfm?tran=#tran#&stype=#stype#&type=#type#&nexttranno=#nexttranno#&custno=#URLEncodedFormat(custno)#&invoicedate=#invoicedate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#URLEncodedFormat(type1.itemno)#&name=#name#&agenno=#agenno#&hmode=#hmode#<cfif tran eq 'TR'>&trfrom=#trfrom#&trto=#trto#&oldtrfrom=#oldtrfrom#&oldtrto=#oldtrto#&ttran=#ttran#</cfif>&remark5=#xremark5#&remark6=#xremark6#&consignment=#consignment#<cfif isdefined('url.TRfrom')>&trfrom=#url.trfrom#</cfif>">Select</a>
					<cfelse>
						<a href="iss3.cfm?tran=#tran#&stype=#stype#&type=#type#&nexttranno=#nexttranno#&custno=#URLEncodedFormat(custno)#&invoicedate=#invoicedate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#URLEncodedFormat(type1.itemno)#&name=#name#&agenno=#agenno#&hmode=#hmode#<cfif tran eq 'TR'>&trfrom=#trfrom#&trto=#trto#&oldtrfrom=#oldtrfrom#&oldtrto=#oldtrto#&ttran=#ttran#</cfif>&remark5=#xremark5#&remark6=#xremark6#&consignment=#consignment#<cfif isdefined('url.TRfrom')>&trfrom=#url.trfrom#</cfif>">Select</a>
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