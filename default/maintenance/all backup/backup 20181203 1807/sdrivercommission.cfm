<html>
<head>
<title>Create Or Edit Or View Driver Commission</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<cfparam name="start" default="1">
<cfparam name="page" default="1">
<cfparam name="prevtwenty" default="0">
<cfparam name="nexttwenty" default="0">
<cfquery datasource='#dts#' name="getPersonnel">
	Select * from drivercommission where driverno="#url.driverno#" order by category 
</cfquery>
<body>
<!--- ADD ON 15-07-2009 --->
<cfquery name="getGsetup" datasource="#dts#">
  Select lDRIVER from GSetup
</cfquery>
<!--- <cfset typeNo=#url.type# & "No"> 
	<cfset link = #url.type# &".cfm"> --->
<!--- <cfif isdefined("URL.Type")> --->
<h1><cfoutput>#getGsetup.lDRIVER# Commission Selection Page</cfoutput></h1>
<cfoutput> 
  <h4>
	<cfif getpin2.h1C10 eq 'T'><a href="Driver.cfm?type=Create"> Creating a #getGsetup.lDRIVER#</a> </cfif>
	<cfif getpin2.h1C20 eq 'T'>|| <a href="vdriver.cfm">List all #getGsetup.lDRIVER#</a> </cfif>
	<cfif getpin2.h1C30 eq 'T'>|| <a href="sdriver.cfm">Search #getGsetup.lDRIVER#</a> </cfif>
	<cfif getpin2.h1C40 eq 'T'>|| <a href="pdriver.cfm" target="_blank">#getGsetup.lDRIVER# Listing</a></cfif></h4>
    
    <br>
    
    <h4><cfif getpin2.h1C10 eq 'T'><a href="Drivercommission.cfm?type=Create&driverno=#url.driverno#"> Creating a #getGsetup.lDRIVER# Commission</a> </cfif></h4>
</cfoutput>
<cfoutput>
<form action="sdrivercommission.cfm?driverno=#url.driverno#" method="post">
    <h1>Search By : 
    	<select name="searchType">
        	<option value="category">Category No</option>
      	</select>
      	Search for #getGsetup.lDRIVER# Commission : 
      	<input type="text" name="searchStr" value="">
    </h1>
</form>
</cfoutput>			
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
	<cfform action="sdriver.cfm" method="post">
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
				|| <a href="sdriver.cfm?start=#prevtwenty#">Previous</a> ||
			</cfif>
		
			<cfif page neq noOfPage>
				 <a href="sdriver.cfm?start=#evaluate(nexttwenty)#">Next</a> ||
			</cfif>
		
			Page #page# Of #noOfPage#
		</cfoutput>
	</div>
    </cfform>	


<cfif isdefined("url.process")>
	<h1><cfoutput>#form.status#</cfoutput></h1>
    <hr>
</cfif>
<cfquery datasource='#dts#' name="type">
	Select * from drivercommission where driverno='#url.driverno#' order by created_on desc
</cfquery>
		
<cfif isdefined("form.searchStr")>
	<cfquery datasource="#dts#" name="exactResult">
		Select * from drivercommission where #form.searchType# = '#form.searchStr#' and driverno='#url.driverno#' order by #form.searchType#
	</cfquery>
			
	<cfquery datasource="#dts#" name="similarResult">
		Select * from drivercommission where #form.searchType# LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#form.searchStr#%"> and driverno='#url.driverno#' order by #form.searchType#
	</cfquery>
			
	<h2>Exact Result</h2>
	<cfif exactResult.recordCount neq 0>
		<table align="center" class="data" width="600px">	
			<tr>	
				<th><cfoutput>#getGsetup.lDRIVER#</cfoutput></th>
				<th>Category</th>						
        		<th>Commission</th>
				<cfif getpin2.h1C11 eq 'T'><th>Action</th></cfif>
			</tr>
			<cfoutput query="exactResult">
				<tr>
					<td>#exactResult.Driverno#</td>
					<td>#exactResult.category#</td>
					<td>#exactResult.commission#</td>
                    
					<cfif getpin2.h1C11 eq 'T'>
          				<td width="10%" nowrap>
						<div align="center"><a href="drivercommission.cfm?type=Delete&driverno=#exactResult.driverno#&category=#exactResult.category#"><img height="18px" width="18px" src="../../images/delete.ICO" alt="Delete" border="0">Delete</a>&nbsp;<a href="drivercommission.cfm?type=Edit&driverno=#exactResult.driverno#&category=#exactResult.category#"><img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0">Edit</a></div></td>
					</cfif>
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
			<th><cfoutput>#getGsetup.lDRIVER#</cfoutput></th>
			<th>Category</th>				
        	<th>Commission</th>
			<cfif getpin2.h1C11 eq 'T'><th>Action</th></cfif>
		</tr>
		<cfoutput query="similarResult">
			<tr>
				<td>#similarResult.driverno#</td>
				<td>#similarResult.category#</td>
				<td>#similarResult.commission#</td>
				<cfif getpin2.h1C11 eq 'T'>
          			<td width="10%" nowrap> 
            			<div align="center"><a href="drivercommission.cfm?type=Delete&driverno=#similarResult.driverno#&category=#similarResult.category#"><img height="18px" width="18px" src="../../images/delete.ICO" alt="Delete" border="0">Delete</a>&nbsp;<a href="drivercommission.cfm?type=Edit&driverno=#similarResult.driverno#&category=#similarResult.category#"><img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0">Edit</a></div></td>
				</cfif>
			</tr>
		</cfoutput>
	</table>
	<cfelse>
		<h3>No Similar Records were found.</h3>
	</cfif>
</cfif>
		
<cfparam name="i" default="1" type="numeric">
<hr>
		
<fieldset><legend style="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;font-style: italic;line-height: normal;font-weight: bold;text-transform: capitalize;color: #0066FF;">
	<cfoutput>20 Newest #getGsetup.lDRIVER# Commission:</cfoutput></legend><br>
	<cfif #type.recordCount# neq 0>
		<table align="center" class="data" width="600px">	
			<tr>
				<th>No.</th>
				<th><cfoutput>#getGsetup.lDRIVER#</cfoutput></th>
				<th>Category</th>
				<th>Commission</th>
				<cfif getpin2.h1C11 eq 'T'><th>Action</th></cfif>
			</tr>
			<cfoutput query="type" maxrows="20">
				<tr>
					<td>#i#</td>
					<td>#type.driverno#</td>
					<td>#type.category#</td>
					<td>#type.commission#</td>
					<cfif getpin2.h1C11 eq 'T'>
        				<td width="10%" nowrap> 
         				<div align="center"><a href="drivercommission.cfm?type=Delete&driverno=#type.driverno#&category=#type.category#"><img height="18px" width="18px" src="../../images/delete.ICO" alt="Delete" border="0">Delete</a>&nbsp;<a href="drivercommission.cfm?type=Edit&driverno=#type.driverno#&category=#type.category#"><img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0">Edit</a></div></td>
					</cfif>
				</tr>
				<cfset i = incrementvalue(#i#)>
			</cfoutput>
		</table>
	<cfelse>
		<h3>No Records were found.</h3>
	</cfif>
	<br>
</fieldset>
	<!--- <cfelse>
		<h1>URL Error. Please Click On The Correct Link.</h1>
	</cfif> --->	

</body>
</html>
