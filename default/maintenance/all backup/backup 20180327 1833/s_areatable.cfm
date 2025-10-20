<html>
<head>
<title>Search Area</title>
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<cfparam name="start" default="1">
<cfparam name="page" default="1">
<cfparam name="prevtwenty" default="0">
<cfparam name="nexttwenty" default="0">
<cfquery datasource='#dts#' name="getPersonnel">
	Select * FROM #target_icarea# order by area
</cfquery>
<body>
<h1>Area Selection Page</h1>

<cfoutput>
	<h4>
	<cfif getpin2.h1F10 eq 'T'><a href="areatable2.cfm?type=Create">Creating A New Area</a> </cfif>
	<cfif getpin2.h1F20 eq 'T'>|| <a href="areatable.cfm">List All Area</a> </cfif>
	<cfif getpin2.h1F30 eq 'T'>|| <a href="s_areatable.cfm?type=icarea">Search For Area</a></cfif>
    
    
    <cfif getpin2.h1630 eq 'T'>|| <a href="p_area.cfm">Area Listing</a></cfif>
	</h4>

    <form action="s_areatable.cfm" method="post">
		<h1>Search By :
        <select name="searchType">
			<option value="Area">Area</option>
	      	<option value="Desp">Description</option>
	    </select>
      	Search for Area : 
      	<input type="text" name="searchStr" value="" size="40">
	  	</h1>
	</form>
	 <cfif getPersonnel.recordcount neq 0>
	<cfif isdefined("form.skeypage")>
		<cfset noOfPage=round(getPersonnel.recordcount/20)>
		
		<cfif getPersonnel.recordcount mod 20 LT 10 and getPersonnel.recordcount mod 20 neq 0>
			<cfset noOfPage = noOfPage + 1>
		</cfif>
		
		<cfif form.skeypage gt noofpage OR form.skeypage lt 1>
			<h3 align="center"><font color="##FF0000">Wrong page number! Please try again.</font></h3>
			<cfabort>
		</cfif>
	</cfif>
    </cfif>
	<cfform action="s_areatable.cfm" method="post">
		<div align="right">Page <cfinput name="skeypage" type="text" size="2" validate="integer" message="Wrong value in Page field.">
		
		<cfset noOfPage=round(getPersonnel.recordcount/20)>
		
		<cfif getPersonnel.recordcount mod 20 LT 10 and getPersonnel.recordcount mod 20 neq 0>
			<cfset noOfPage = noOfPage+1>
		</cfif>
		
		<cfif isdefined("url.start")>
			<cfset start = url.start>
		</cfif>
		
		<cfif isdefined("form.skeypage")>				
			<cfset start = form.skeypage * 20 + 1 - 20>				
			
			<cfif form.skeypage eq "1">
				<cfset start = "1">					
			</cfif>  				
		</cfif> 

		<cfset prevtwenty = start -20>
		<cfset nexttwenty = start +20>
		<cfset page = round(nextTwenty/20)>
		
		<cfoutput>
			<cfif start neq 1>
				|| <a href="s_areatable.cfm?start=#prevtwenty#">Previous</a> ||
			</cfif>
		
			<cfif page neq noOfPage>
				 <a href="s_areatable.cfm?start=#evaluate(nexttwenty)#">Next</a> ||
			</cfif>
		
			Page #page# Of #noOfPage#
		</cfoutput>
	</div>
    </cfform>	
    
	<cfif isdefined("url.process")>
		<h1>#form.status#</h1><hr>
  	</cfif>
	
  	<cfquery datasource='#dts#' name="type">
		select * FROM #target_icarea# order by area
  	</cfquery>
		
  	<cfif isdefined("form.searchStr")>
  		<cfquery datasource="#dts#" name="exactResult">
    		select * FROM #target_icarea# where #form.searchType# = '#form.searchStr#' order by #form.searchType#
		</cfquery>
			
  		<cfquery datasource="#dts#" name="similarResult">
    		select * FROM #target_icarea# where #form.searchType# LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#form.searchStr#%"> order by #form.searchType#
		</cfquery>
			
		<h2>Exact Result</h2>
		<cfif exactResult.recordCount neq 0>
		
		<table align="center" class="data" width="50%">
      		<tr> 
        		<th>Area</th>
        		<th>Description</th>
        		<cfif getpin2.h1F11 eq 'T'>
					<th width="10%">Action</th>
				</cfif>
      		</tr>
      		<cfloop query="exactResult"> 
        	<tr> 
          		<td>#exactResult.area#</td>
          		<td>#exactResult.desp#</td>
          		<cfif getpin2.h1F11 eq 'T'>
				<td nowrap> 
            		<div align="center">
					<a href="areatable2.cfm?type=Delete&area=#exactResult.area#">
					<img height="18px" width="18px" src="../../images/delete.ICO" alt="Delete" border="0">Delete</a>&nbsp; 
					<a href="areatable2.cfm?type=Edit&area=#exactResult.area#">
					<img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0">Edit</a> 
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
	      		<th>Area</th>
        		<th>Description</th>
        		<cfif getpin2.h1F11 eq 'T'>
					<th width="10%">Action</th>
				</cfif>
	    	</tr>
	
	   		<cfloop query="similarResult">
	      	<tr> 
          		<td>#similarResult.area#</td>
          		<td>#similarResult.desp#</td>
          		<cfif getpin2.h1F11 eq 'T'>
				<td nowrap> 
            		<div align="center">
					<a href="areatable2.cfm?type=Delete&area=#similarResult.area#">
					<img height="18px" width="18px" src="../../images/delete.ICO" alt="Delete" border="0">Delete</a>&nbsp; 
					<a href="areatable2.cfm?type=Edit&area=#similarResult.area#">
					<img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0">Edit</a> 
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
      		<th>Area</th>
      		<th>Description</th>
      		<cfif getpin2.h1F11 eq 'T'>
				<th width="10%">Action</th>
			</cfif>
    	</tr>
    	<cfoutput query="type" maxrows="20"> 
      	<tr> 
        	<td width="5%">#type.currentrow#</td>
        	<td>#type.area#</td>
        	<td nowrap>#type.desp#</td>
			<cfif getpin2.h1F11 eq 'T'>
				<td nowrap><div align="center">
					<a href="areatable2.cfm?type=Delete&area=#type.area#">
					<img height="18px" width="18px" src="../../images/delete.ICO" alt="Delete" border="0">Delete</a>&nbsp; 
					<a href="areatable2.cfm?type=Edit&area=#type.area#">
					<img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0">Edit</a></div> 
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