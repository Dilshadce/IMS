<html>
<head>
<title>Create Or Edit Or View</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>	
		
  <cfoutput>
	<form action="itemsearch.cfm?get=#get#<cfif isdefined("productfrom")>&productfrom=#productfrom#</cfif><cfif isdefined("productto")>&productto=#productto#</cfif>" method="post">
  </cfoutput>
  <cfoutput>
	<h1>
	  Search By :
	  <select name="searchType">
	    <option value="itemno">Item No</option>
		<option value="desp">Description</option>
	    <option value="mitemno">Product Code</option>	    
	  </select>
    
	  Search for Item : 
      <input type="text" name="searchStr" value="">
	  <cfif husergrpid eq "Muser"><input type="submit" name="submit" value="Search"></cfif>
	</h1>	
  </cfoutput>  
  </form>
		
  <cfif isdefined("url.process")>
	<cfoutput><h1>#form.status#</h1><hr></cfoutput>
  </cfif>
	
  <cfquery datasource='#dts#' name="type1">
	Select * from Icitem order by itemno desc
  </cfquery>
		
  <cfif isdefined("form.searchStr")>
	<cfquery dbtype="query" name="exactResult">
	  Select * from TYPE1 where #form.searchType# = '#form.searchStr#' order by #form.searchType#
	</cfquery>
			
	<cfquery dbtype="query" name="similarResult">
	  Select * from TYPE1 where #form.searchType# LIKE '#form.searchStr#' order by #form.searchType#
	</cfquery>
			
	<h2>Exact Result</h2>
	<cfif #exactResult.recordCount# neq 0>
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
		
		<cfoutput query="exactResult">
		  <tr>
		    <td>#exactResult.itemno#</a></td>
		    <td>#exactResult.desp#<br>#exactResult.despa#</td>
		    <td>#exactResult.brand#</td>
		    <td>#exactResult.category#</td>
		    <td>#exactResult.wos_group#</td>
		    <td>#exactResult.price#</td>
		    <td><a href="profitmargin_menu.cfm?itemno1=#exactResult.itemno#&get=#get#<cfif isdefined("productfrom")>&productfrom=#productfrom#</cfif><cfif isdefined("productto")>&productto=#productto#</cfif>">Select</a>
			</td>
		  </tr>
	    </cfoutput>
	  </table>
	<cfelse>
	  <h3>No Exact Records were found.</h3>
	</cfif>
			
	<h2>Similar Result</h2>
	<cfif #similarResult.recordCount# neq 0>
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
		
		<cfoutput query="similarResult">
		  <tr>
		    <td>#similarResult.itemno#</a></td>
		    <td>#similarResult.desp#<br>#similarResult.despa#</td>
		    <td>#similarResult.brand#</td>
		    <td>#similarResult.category#</td>
		    <td>#similarResult.wos_group#</td>
		    <td>#similarResult.price#</td>
		    <td><a href="profitmargin_menu.cfm?itemno1=#similarResult.itemno#&get=#get#<cfif isdefined("productfrom")>&productfrom=#productfrom#</cfif><cfif isdefined("productto")>&productto=#productto#</cfif>">Select</a>
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
    <legend style="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;
	  font-style: italic;line-height: normal;font-weight: bold;text-transform: capitalize;color: #0066FF;">
	<cfoutput>20 Newest Icitem:</cfoutput></legend><br>
	<cfif #type1.recordCount# neq 0>
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
		<cfoutput query="type1" maxrows="20">
		  <tr>
		    <td>#i#</td>
		    <td>#type1.itemno#</a></td>
		    <td>#type1.desp#<br>#type1.despa#</td>
		    <td>#type1.brand#</td>
		    <td>#type1.category#</td>
		    <td>#type1.wos_group#</td>
		    <td>#type1.price#</td>
		    <td><a href="profitmargin_menu.cfm?itemno1=#type1.itemno#&get=#get#<cfif isdefined("productfrom")>&productfrom=#productfrom#</cfif><cfif isdefined("productto")>&productto=#productto#</cfif>">Select</a></td>
		  </tr>
		
		  <cfset i = incrementvalue(#i#)>
		</cfoutput>
	  </table>
	<cfelse>
	  <h3>No Records were found.</h3>
	</cfif>
	<br>
  </fieldset>
  	
</body>
</html>