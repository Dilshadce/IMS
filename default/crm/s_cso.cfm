<html>
<head>
<title>Create Or Edit Or View</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<body>
		
<h1>CSO Selection Page</h1>
		
<cfoutput>
  <h4>
	<a href="csotable2.cfm?type=Create">Creating a New CSO</a>
	|| <a href="csotable.cfm">List all CSO</a>
	|| <a href="s_cso.cfm">Search For CSO</a>
  </h4>
</cfoutput>
		
<cfoutput>
<form action="s_cso.cfm" method="post"></cfoutput>
	<cfoutput>
	<h1>Search By :
	
	<select name="searchType">
		<option value="csoid">CSO Id</option>
		<option value="desp">Description</option>
	</select>
	Search for CSO : 
	<input type="text" name="searchStr" value=""> 
	</h1>
	</cfoutput>
</form>

<cfif isdefined("url.process")>
	<cfoutput><h1>#form.status#</h1><hr></cfoutput>
</cfif>

<cfquery datasource='#dts#' name="type">
	Select * from cso order by csoid,desp
</cfquery>

<cfif isdefined("form.searchStr")>
	<cfquery datasource='#dts#' name="exactResult">
		Select * from cso where #form.searchType# = '#form.searchStr#' order by csoid,desp
	</cfquery>
	
	<cfquery datasource='#dts#' name="similarResult">
		Select * from cso where #form.searchType# LIKE '%#form.searchStr#%' order by csoid,desp
	</cfquery>
	
	<h2>Exact Result</h2>
	<cfif #exactResult.recordCount# neq 0>
	
		<table align="center" class="data" width="600px">
		  <tr> 
			<th>CSO Id</th>
			<th>Description</th>
			<th>Action</th>
		  </tr>
		  <cfoutput query="exactResult"> 
			<tr> 
			  	<td>#exactResult.csoid#</td>
			  	<td>#exactResult.desp#</td>
				<td width="20%" nowrap><div align="center"><a href="csotable2.cfm?type=Delete&csoid=#exactResult.csoid#"><img height="18px" width="18px" src="/images/delete.ICO" alt="Delete" border="0">Delete</a>&nbsp; 
					<a href="csotable2.cfm?type=Edit&csoid=#exactResult.csoid#"><img height="18px" width="18px" src="/images/edit.ICO" alt="Edit" border="0">Edit</a></div>
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
			<th>CSO Id</th>
			<th>Description</th>
			<th>Action</th>
		</tr>
      <cfoutput query="similarResult"> 
        <tr> 
          	<td>#similarResult.csoid#</a></td>
          	<td>#similarResult.desp#</td>
			<td width="20%" nowrap><div align="center"><a href="csotable2.cfm?type=Delete&csoid=#similarResult.csoid#"><img height="18px" width="18px" src="/images/delete.ICO" alt="Delete" border="0">Delete</a>&nbsp; 
              <a href="csotable2.cfm?type=Edit&csoid=#similarResult.csoid#"><img height="18px" width="18px" src="/images/edit.ICO" alt="Edit" border="0">Edit</a></div>
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
		<cfoutput>20 First CSO :</cfoutput></legend>
		<br>
		<cfif #type.recordCount# neq 0>
  		<cfelse>
			<h3>No Records were found.</h3>
		</cfif>
		<br>
		
<table align="center" class="data" width="600px">
  <tr> 
    <th>No</th>
    <th>CSO Id</th>
    <th>Description</th>
    <th>Action</th>
  </tr>
  <cfoutput query="type" maxrows="20"> 
    <tr> 
      	<td>#i#</td>
      	<td>#type.csoid#</td>
      	<td>#type.desp#</td>
		<td width="20%" nowrap><div align="center"><a href="csotable2.cfm?type=Delete&csoid=#type.csoid#"><img height="18px" width="18px" src="/images/delete.ICO" alt="Delete" border="0">Delete</a>&nbsp; 
          	<a href="csotable2.cfm?type=Edit&csoid=#type.csoid#"><img height="18px" width="18px" src="/images/edit.ICO" alt="Edit" border="0">Edit</a></div>
		</td>
    </tr>
    <cfset i = incrementvalue(#i#)>
  </cfoutput> 
</table>
<br>
</fieldset>
</body>
</html>
