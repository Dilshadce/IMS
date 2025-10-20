<html>
<head>
<title>Search Counter</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>

<h1>Counter Selection Page</h1>



<cfoutput>
	<h4>
<a href="countertable2.cfm?type=Create">Create New Counter</a>
|| <a href="countertable.cfm">List All Counter</a>
|| <a href="s_countertable.cfm?type=counter">Search For Counter</a>
	</h4>

    <form action="s_countertable.cfm" method="post">
		<h1>Search By :
        <select name="searchType">
			<option value="counterid">Counter</option>
	      	<option value="counterdesp">Description</option>
            <option value="bonduser">Bond User</option>
	    </select>
      	Search for Counter : 
      	<input type="text" name="searchStr" value="" size="40">
	  	</h1>
	</form>
	
	<cfif isdefined("url.process")>
		<h1>#form.status#</h1><hr>
  	</cfif>
	
  	<cfquery datasource='#dts#' name="type">
		select * from counter order by counterid
  	</cfquery>
		
  	<cfif isdefined("form.searchStr")>
  		<cfquery datasource="#dts#" name="exactResult">
    		select * from counter where #form.searchType# = '#form.searchStr#' order by #form.searchType#
		</cfquery>
			
  		<cfquery datasource="#dts#" name="similarResult">
    		select * from counter where #form.searchType# LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#form.searchStr#%"> order by #form.searchType#
		</cfquery>
			
		<h2>Exact Result</h2>
		<cfif exactResult.recordCount neq 0>
		
		<table align="center" class="data" width="50%">
      		<tr> 
        		<th>Counter</th>
        		<th>Description</th>
                <th>Bond User</th>
				<th width="10%">Action</th>
      		</tr>
      		<cfloop query="exactResult"> 
        	<tr> 
          		<td>#exactResult.counterid#</td>
          		<td>#exactResult.counterdesp#</td>
                <td>#exactResult.bonduser#</td>

				<td nowrap> 
            		<div align="center">
					<a href="countertable2.cfm?type=Delete&counter=#exactResult.counterid#">
					<img height="18px" width="18px" src="/images/delete.ICO" alt="Delete" border="0">Delete</a>&nbsp; 
					<a href="countertable2.cfm?type=Edit&counter=#exactResult.counterid#">
					<img height="18px" width="18px" src="/images/edit.ICO" alt="Edit" border="0">Edit</a> 
            		</div>
				</td>

        	</tr>
      		</cfloop> 
    	</table>
	<cfelse>
	  	<h3>No Exact Records were found.</h3>
    </cfif>
			
    <h2>Similar Result</h2>
    <cfif similarResult.recordCount neq 0>
      	<table align="center" class="data" width="50%">					
	    	<tr>
	      		<th>Counter</th>
        		<th>Description</th>
                <th>Bond User</th>
					<th width="10%">Action</th>
	    	</tr>
	
	   		<cfloop query="similarResult">
	      	<tr> 
          		<td>#similarResult.counterid#</td>
          		<td>#similarResult.counterdesp#</td>
                <td>#similarResult.bonduser#</td>
				<td nowrap> 
            		<div align="center">
					<a href="countertable2.cfm?type=Delete&counter=#similarResult.counterid#">
					<img height="18px" width="18px" src="/images/delete.ICO" alt="Delete" border="0">Delete</a>&nbsp; 
					<a href="countertable2.cfm?type=Edit&counter=#similarResult.counterid#">
					<img height="18px" width="18px" src="/images/edit.ICO" alt="Edit" border="0">Edit</a> 
            		</div>
				</td>
        	</tr>
	    	</cfloop>
      	</table>
    <cfelse>
	  	<h3>No Similar Records were found.</h3>
    </cfif>
</cfif>
</cfoutput>
<hr><fieldset>
<legend style="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;font-style: italic;line-height: normal;font-weight: bold;text-transform: capitalize;color: #0066FF;">
20 Newest Counter:
</legend><br>


<cfif type.recordCount neq 0>
  	<table align="center" class="data" width="50%">
    	<tr> 
      		<th>No.</th>
      		<th>Counter</th>
      		<th>Description</th>
            <th>Bond User</th>
			<th width="10%">Action</th>

    	</tr>
    	<cfoutput query="type" maxrows="20"> 
      	<tr> 
        	<td width="5%">#type.currentrow#</td>
        	<td>#type.counterid#</td>
        	<td nowrap>#type.counterdesp#</td>
            <td>#type.bonduser#</td>

				<td nowrap><div align="center">
					<a href="countertable2.cfm?type=Delete&counter=#type.counterid#">
					<img height="18px" width="18px" src="/images/delete.ICO" alt="Delete" border="0">Delete</a>&nbsp; 
					<a href="countertable2.cfm?type=Edit&counter=#type.counterid#">
					<img height="18px" width="18px" src="/images/edit.ICO" alt="Edit" border="0">Edit</a></div> 
				</td>

      	</tr>
    	</cfoutput>
	</table>
<cfelse>
  	<h3>No Records were found.</h3>
</cfif>
<br>
</fieldset>
</body>
</html>