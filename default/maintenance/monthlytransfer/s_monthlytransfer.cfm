<html>
<head>
<title>Search Transfer Limit</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>
<h1>Transfer Limit Selection Page</h1>

<cfoutput>
	<h4>
	<cfif getpin2.h1F10 eq 'T'><a href="monthlytransfertable2.cfm?type=Create">Creating A New Transfer Limit</a> </cfif>
	<cfif getpin2.h1F20 eq 'T'>|| <a href="monthlytransfertable.cfm">List All Transfer Limit</a> </cfif>
	<cfif getpin2.h1F30 eq 'T'>|| <a href="s_monthlytransfer.cfm?type=monthlytransfer">Search For Transfer Limit</a></cfif>
    
    
    <cfif getpin2.h1630 eq 'T'>|| <a href="p_monthlytransfer.cfm">Transfer Limit Listing</a></cfif>
	</h4>

    <form action="s_monthlytransfer.cfm" method="post">
		<h1>Search By :
        <select name="searchType">
			<option value="itemno">Item No</option>
	      	<option value="fperiod">period</option>
	    </select>
      	Search for Transfer Limit : 
      	<input type="text" name="searchStr" value="" size="40">
	  	</h1>
	</form>
	
	<cfif isdefined("url.process")>
		<h1>#form.status#</h1><hr>
  	</cfif>
	
  	<cfquery datasource='#dts#' name="type">
		select * from monthlytransfer order by itemno
  	</cfquery>
		
  	<cfif isdefined("form.searchStr")>
  		<cfquery datasource="#dts#" name="exactResult">
    		select * from monthlytransfer where #form.searchType# = '#form.searchStr#' order by #form.searchType#
		</cfquery>
			
  		<cfquery datasource="#dts#" name="similarResult">
    		select * from monthlytransfer where #form.searchType# LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#form.searchStr#%"> order by #form.searchType#
		</cfquery>
			
		<h2>Exact Result</h2>
		<cfif exactResult.recordCount neq 0>
		
		<table align="center" class="data" width="50%">
      		<tr> 
        		<th>Item No</th>
        		<th>Period</th>
                <th>Qty</th>
        		<cfif getpin2.h1F11 eq 'T'>
					<th width="10%">Action</th>
				</cfif>
      		</tr>
      		<cfloop query="exactResult"> 
        	<tr> 
          		<td>#exactResult.itemno#</td>
          		<td>#exactResult.fperiod#</td>
                <td>#exactResult.qty#</td>
          		<cfif getpin2.h1F11 eq 'T'>
				<td nowrap> 
            		<div align="center">
					<a href="monthlytransfertable2.cfm?type=Delete&id=#exactResult.id#">
					<img height="18px" width="18px" src="/images/delete.ICO" alt="Delete" border="0">Delete</a>&nbsp; 
					<a href="monthlytransfertable2.cfm?type=Edit&id=#exactResult.id#">
					<img height="18px" width="18px" src="/images/edit.ICO" alt="Edit" border="0">Edit</a> 
            		</div>
				</td>
				</cfif>
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
	      		<th>Item No</th>
        		<th>Period</th>
                <th>Qty</th>
        		<cfif getpin2.h1F11 eq 'T'>
					<th width="10%">Action</th>
				</cfif>
	    	</tr>
	
	   		<cfloop query="similarResult">
	      	<tr> 
          		<td>#similarResult.itemno#</td>
          		<td>#similarResult.fperiod#</td>
                <td>#similarResult.qty#</td>
          		<cfif getpin2.h1F11 eq 'T'>
				<td nowrap> 
            		<div align="center">
					<a href="monthlytransfertable2.cfm?type=Delete&id=#similarResult.id#">
					<img height="18px" width="18px" src="/images/delete.ICO" alt="Delete" border="0">Delete</a>&nbsp; 
					<a href="monthlytransfertable2.cfm?type=Edit&id=#similarResult.id#">
					<img height="18px" width="18px" src="/images/edit.ICO" alt="Edit" border="0">Edit</a> 
            		</div>
				</td>
				</cfif>
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
20 Newest Address:
</legend><br>


<cfif type.recordCount neq 0>
  	<table align="center" class="data" width="50%">
    	<tr> 
      		<th>No.</th>
      		<th>Item No</th>
        	<th>Period</th>
            <th>Qty</th>
      		<cfif getpin2.h1F11 eq 'T'>
				<th width="10%">Action</th>
			</cfif>
    	</tr>
    	<cfoutput query="type" maxrows="20"> 
      	<tr> 
        	<td width="5%">#type.currentrow#</td>
        	<td>#type.itemno#</td>
        	<td nowrap>#type.fperiod#</td>
            <td nowrap>#type.qty#</td>
			<cfif getpin2.h1F11 eq 'T'>
				<td nowrap><div align="center">
					<a href="monthlytransfertable2.cfm?type=Delete&id=#type.id#">
					<img height="18px" width="18px" src="/images/delete.ICO" alt="Delete" border="0">Delete</a>&nbsp; 
					<a href="monthlytransfertable2.cfm?type=Edit&id=#type.id#">
					<img height="18px" width="18px" src="/images/edit.ICO" alt="Edit" border="0">Edit</a></div> 
				</td>
			</cfif>
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