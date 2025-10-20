<html>
<head>
<title>Search Batch Item</title>
<link href="../../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>
<h1 align="center">Search Items</h1>

<cfoutput>
	<form action="location_opening_qty_maintenance_search_item.cfm" method="post">
		<input type="hidden" name="location" value="#location#">
		<input type="hidden" name="qtybf" value="#qtybf#">
		<input type="hidden" name="minimum" value="#minimum#">
		<input type="hidden" name="reorder" value="#reorder#">
		<h1>Search By :
		<select name="searchType">
	    	<option value="itemno">Item No</option>
			<option value="desp">Description</option>
	    	<option value="mitemno">Product Code</option>
	  	</select>
		Search for Item : 
      	<input type="text" name="searchStr" value="">
	  	<cfif husergrpid eq "Muser">
			<input type="submit" name="submit" value="Search">
		</cfif>
		</h1>
	</form>
</cfoutput>

<cfquery datasource="#dts#" name="type1">
	Select * from 
	icitem 
	order by itemno desc;
</cfquery>
		
<cfif isdefined("form.searchStr")>
	<cfquery dbtype="query" name="exactResult">
		select * from 
		TYPE1 
		where #form.searchType#='#form.searchStr#' 
		order by #form.searchType#;
	</cfquery>
			
	<cfquery dbtype="query" name="similarResult">
	  	Select * from 
		TYPE1 
		where #form.searchType# LIKE '#form.searchStr#' 
		order by #form.searchType#;
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
		  		<th>Action</th>
			</tr>
			<form name="done" action="location_opening_qty_maintenance.cfm?modeaction=add" method="post">
				<cfoutput>
					<input type="hidden" name="location" value="#location#">
					<input type="hidden" name="qtybf" value="#qtybf#">
					<input type="hidden" name="minimum" value="#minimum#">
					<input type="hidden" name="reorder" value="#reorder#">
				</cfoutput>
				<cfoutput query="exactResult">
				<tr>
					<td>#exactResult.itemno#</a></td>
					<td>#exactResult.desp#<br>#exactResult.despa#</td>
					<td>#exactResult.brand#</td>
					<td>#exactResult.category#</td>
					<td>#exactResult.wos_group#</td>
					<td>#exactResult.price#</td>
					<td align="left"><input type="submit" name="item1" value="#exactResult.itemno#" style="background-color:##CCCCFF; border-color:##CCCCFF; border-style:none"></td>
				</tr>
				</cfoutput>
			</form>
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
		  		<th>Action</th>
			</tr>
			<form name="done" action="location_opening_qty_maintenance.cfm?modeaction=add" method="post">
				<cfoutput>
					<input type="hidden" name="location" value="#location#">
					<input type="hidden" name="qtybf" value="#qtybf#">
					<input type="hidden" name="minimum" value="#minimum#">
					<input type="hidden" name="reorder" value="#reorder#">
				</cfoutput>
				<cfoutput query="similarResult">
				<tr>
					<td>#similarResult.itemno#</a></td>
					<td>#similarResult.desp#<br>#similarResult.despa#</td>
					<td>#similarResult.brand#</td>
					<td>#similarResult.category#</td>
					<td>#similarResult.wos_group#</td>
					<td>#similarResult.price#</td>
					<td align="left"><input type="submit" name="item2" value="#similarResult.itemno#" style="background-color:##CCCCFF; border-color:##CCCCFF; border-style:none"></td>
				</tr>
				</cfoutput>
			</form>
	  	</table>
	<cfelse>
	  	<h3>No Similar Records were found.</h3>
	</cfif>
</cfif>
  
<cfparam name="i" default="1" type="numeric">
  
<hr><fieldset><legend style="font-family:Verdana, Arial,Helvetica,sans-serif;font-size:12px;font-style:italic;line-height:normal;font-weight:bold;text-transform:capitalize;color:#0066FF;">
<cfoutput>20 Newest Icitem:</cfoutput></legend><br>
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
		  	<th>Action</th>
		</tr>
		<form name="done" action="location_opening_qty_maintenance.cfm?modeaction=add" method="post">
			<cfoutput>
				<input type="hidden" name="location" value="#location#">
				<input type="hidden" name="qtybf" value="#qtybf#">
				<input type="hidden" name="minimum" value="#minimum#">
				<input type="hidden" name="reorder" value="#reorder#">
			</cfoutput>
			<cfoutput query="type1" maxrows="20">
			<tr>
				<td>#i#</td>
				<td>#type1.itemno#</a></td>
				<td>#type1.desp#<br>#type1.despa#</td>
				<td>#type1.brand#</td>
				<td>#type1.category#</td>
				<td>#type1.wos_group#</td>
				<td>#type1.price#</td>
				<td align="left"><input type="submit" name="item3" value="#type1.itemno#" style="background-color:##CCCCFF; border-color:##CCCCFF; border-style:none"></td>
			</tr>
			<cfset i = incrementvalue(i)>
			</cfoutput>
		</form>
	</table>
<cfelse>
	<h3>No Records were found.</h3>
</cfif>

<br/>

<table align="center">
	<tr>
		<td><input type="button" name="Back" value="Back" onClick="javascript:history.back();history.back();"></td>
	</tr>
</table>

</fieldset>  	
</body>
</html>