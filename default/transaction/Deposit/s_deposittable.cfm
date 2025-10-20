<html>
<head>
<title>Search Deposit</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>

<cfparam name="start" default="1">
<cfparam name="page" default="1">
<cfparam name="prevtwenty" default="0">
<cfparam name="nexttwenty" default="0">
<h1>Deposit Selection Page</h1>

<cfoutput>
	<h4>
	<cfif getpin2.h1F10 eq 'T'><a href="Deposittable2.cfm?type=Create">Creating A New Deposit</a> </cfif>
	<cfif getpin2.h1F20 eq 'T'>|| <a href="Deposittable.cfm">List All Deposit</a> </cfif>
	<cfif getpin2.h1F30 eq 'T'>|| <a href="s_Deposittable.cfm?type=Deposit">Search For Deposit</a></cfif>
    
    
    <cfif getpin2.h1630 eq 'T'>|| <a href="p_Deposit.cfm">Deposit Listing</a></cfif>
	<cfif getpin2.h1F10 eq 'T'>
    || <a href="postingdeposit.cfm">Deposit Posting</a>
    || <a href="unpostingdeposit.cfm">Unposting Deposit</a>
	|| <a href="depositimport_to_ams.cfm">Import Posting</a>
 	</cfif>
	</h4>

	

    <form action="s_Deposittable.cfm" method="post">
		<h1>Search By :
        <select name="searchType">
			<option value="Depositno">Deposit</option>
	      	<option value="Desp">Description</option>
	    </select>
      	Search for Deposit : 
      	<input type="text" name="searchStr" value="" size="40">
	  	</h1>
	</form>
	
    <cfquery datasource='#dts#' name="getPersonnel">
		select * from Deposit order by Depositno
  	</cfquery>
    
    <cfif getPersonnel.recordcount neq 0>
	<cfif isdefined("form.skeypage")>
		<cfset noOfPage=round(getPersonnel.recordcount/20)>
		
		<cfif getPersonnel.recordcount mod 20 LT 3 and getPersonnel.recordcount mod 20 neq 0>
			<cfset noOfPage = noOfPage + 1>
		</cfif>
		
		<cfif form.skeypage gt noofpage OR form.skeypage lt 1>
			<h3 align="center"><font color="##FF0000">Wrong page number! Please try again.</font></h3>
			<cfabort>
		</cfif>
	</cfif>
    </cfif>
    
    <cfform action="s_deposittable.cfm" method="post">
		<div align="right">Page <cfinput name="skeypage" type="text" size="2" validate="integer" message="Wrong value in Page field.">
		<input type="submit" name="submit" id="submit" value="go" >
		<cfset noOfPage=round(getPersonnel.recordcount/20)>
		
		<cfif getPersonnel.recordcount mod 20 LT 3 and getPersonnel.recordcount mod 20 neq 0>
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
				|| <a href="s_deposittable.cfm?start=#prevtwenty#">Previous</a> ||
			</cfif>
		
			<cfif page neq noOfPage>
				 <a href="s_deposittable.cfm?start=#evaluate(nexttwenty)#">Next</a> ||
			</cfif>
		
			Page #page# Of #noOfPage#
		</cfoutput>
	</div>
    </cfform>
    
    
	<cfif isdefined("url.process")>
		<h1>#form.status#</h1><hr>
  	</cfif>
    <cfquery datasource='#dts#' name="type">
		select * from Deposit order by Depositno
        limit #start-1#,20;
  	</cfquery>
    
	
  	
		
  	<cfif isdefined("form.searchStr")>
  		<cfquery datasource="#dts#" name="exactResult">
    		select * from Deposit where #form.searchType# = '#form.searchStr#' order by #form.searchType#
            limit #start-1#,20;
		</cfquery>
			
  		<cfquery datasource="#dts#" name="similarResult">
    		select * from Deposit where #form.searchType# LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#form.searchStr#%"> order by #form.searchType#
			limit #start-1#,20;
        </cfquery>
			
		<h2>Exact Result</h2>
		<cfif exactResult.recordCount neq 0>
		
		<table align="center" class="data" width="50%">
      		<tr> 
        		<th>Deposit</th>
                <th>Date</th>
                <th>Reference No</th>
        		<th>Description</th>
                <th>Posted</th>
        		<cfif getpin2.h1F11 eq 'T'>
					<th width="10%">Action</th>
				</cfif>
      		</tr>
      		<cfloop query="exactResult"> 
        	<tr> 
          		<td>#exactResult.Depositno#</td>
                <td>#dateformat(exactResult.wos_date,'DD/MM/YYYY')#</td>
                <td>#exactResult.sono#</td>
          		<td>#exactResult.desp#</td>
                <td>#exactResult.posted#</td>
          		<cfif getpin2.h1F11 eq 'T'>
                <cfif exactResult.posted eq 'P'>
                <td nowrap> 
            		<div align="center">
					<a>
					<img height="18px" width="18px" src="/images/delete.ICO" alt="Delete" border="0">Delete</a>&nbsp; 
					<a>
					<img height="18px" width="18px" src="/images/edit.ICO" alt="Edit" border="0">Edit</a> 
            		</div>
				</td>
                <cfelse>
				<td nowrap> 
            		<div align="center">
					<a href="Deposittable2.cfm?type=Delete&Deposit=#exactResult.Depositno#">
					<img height="18px" width="18px" src="/images/delete.ICO" alt="Delete" border="0">Delete</a>&nbsp; 
					<a href="Deposittable2.cfm?type=Edit&Deposit=#exactResult.Depositno#">
					<img height="18px" width="18px" src="/images/edit.ICO" alt="Edit" border="0">Edit</a> 
            		</div>
				</td>
                </cfif>
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
	      		<th>Deposit</th>
                <th>Date</th>
                <th>Reference No</th>
        		<th>Description</th>
                <th>Posted</th>
        		<cfif getpin2.h1F11 eq 'T'>
					<th width="10%">Action</th>
				</cfif>
	    	</tr>
	
	   		<cfloop query="similarResult">
	      	<tr> 
          		<td>#similarResult.Depositno#</td>
                <td>#dateformat(similarResult.wos_date,'DD/MM/YYYY')#</td>
                <td>#similarResult.sono#</td>
          		<td>#similarResult.desp#</td>
                <td>#similarResult.posted#</td>
          		<cfif getpin2.h1F11 eq 'T'>
                <cfif similarResult.posted eq 'P'>
                <td nowrap> 
            		<div align="center">
                    <a href="printdeposit.cfm?depositno=#similarResult.Depositno#" target="_blank">
					Print</a>&nbsp; 

					<img height="18px" width="18px" src="/images/delete.ICO" alt="Delete" border="0">Delete&nbsp; 

					<img height="18px" width="18px" src="/images/edit.ICO" alt="Edit" border="0">Edit
            		</div>
				</td>
                <cfelse>
				<td nowrap> 
            		<div align="center">
                    <a href="printdeposit.cfm?depositno=#similarResult.Depositno#" target="_blank">
					Print</a>&nbsp; 
					<a href="Deposittable2.cfm?type=Delete&Deposit=#similarResult.Depositno#">
					<img height="18px" width="18px" src="/images/delete.ICO" alt="Delete" border="0">Delete</a>&nbsp; 
					<a href="Deposittable2.cfm?type=Edit&Deposit=#similarResult.Depositno#">
					<img height="18px" width="18px" src="/images/edit.ICO" alt="Edit" border="0">Edit</a> 
            		</div>
				</td>
                </cfif>
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
      		<th>Deposit</th>
            <th>Date</th>
            <th>Reference No</th>
      		<th>Description</th>
            <th>Posted</th>
      		<cfif getpin2.h1F11 eq 'T'>
				<th width="10%">Action</th>
			</cfif>
    	</tr>
    	<cfoutput query="type" maxrows="20"> 
      	<tr> 
        	<td width="5%">#type.currentrow#</td>
        	<td>#type.Depositno#</td>
            <td>#dateformat(type.wos_date,'DD/MM/YYYY')#</td>
            <td>#type.sono#</td>
        	<td nowrap>#type.desp#</td>
            <td nowrap>#type.posted#</td>
			<cfif getpin2.h1F11 eq 'T'>
            <cfif type.posted eq 'P'>
            <td nowrap><div align="center">
                <a href="printdeposit.cfm?depositno=#type.Depositno#" target="_blank">
					Print</a>&nbsp; 
					
					<img height="18px" width="18px" src="/images/delete.ICO" alt="Delete" border="0">Delete&nbsp; 
					
					<img height="18px" width="18px" src="/images/edit.ICO" alt="Edit" border="0">Edit</div> 
				</td>
            <cfelse>
				<td nowrap><div align="center">
                <a href="printdeposit.cfm?depositno=#type.Depositno#" target="_blank">
					Print</a>&nbsp; 
					<a href="Deposittable2.cfm?type=Delete&Deposit=#type.Depositno#">
					<img height="18px" width="18px" src="/images/delete.ICO" alt="Delete" border="0">Delete</a>&nbsp; 
					<a href="Deposittable2.cfm?type=Edit&Deposit=#type.Depositno#">
					<img height="18px" width="18px" src="/images/edit.ICO" alt="Edit" border="0">Edit</a></div> 
				</td>
            </cfif>
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