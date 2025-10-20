<html>
<head>
<title>Create Or Edit Or View</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<cfparam name="start" default="1">
<cfparam name="page" default="1">
<cfparam name="prevtwenty" default="0">
<cfparam name="nexttwenty" default="0">
<cfquery datasource='#dts#' name="getPersonnel">
	Select * FROM #target_icagent# order by agent
</cfquery>
<body>
<!--- ADD ON 15-07-2009 --->
<cfquery name="getGsetup" datasource="#dts#">
  Select lAGENT from GSetup
</cfquery>
	
<h1><cfoutput>#getGsetup.lAGENT# Selection Page</cfoutput></h1>

<cfoutput>
	<h4><cfif getpin2.h1B10 eq 'T'><a href="agenttable2.cfm?type=Create">Creating a New #getGsetup.lAGENT#</a> </cfif>
	<cfif getpin2.h1B20 eq 'T'>|| <a href="agenttable.cfm">List all #getGsetup.lAGENT#</a> </cfif>
	<cfif getpin2.h1B30 eq 'T'>|| <a href="s_agenttable.cfm?type=Icitem">Search For #getGsetup.lAGENT#</a></cfif>
    
    <cfif getpin2.h1630 eq 'T'>|| <a href="p_agent.cfm">#getGsetup.lAGENT# Listing </a></cfif>
	</h4>
</cfoutput>

<cfoutput>
<form action="s_agenttable.cfm" method="post"></cfoutput>
	<cfoutput>
	<h1>Search By :
	
	<select name="searchType">
		<option value="agent">#getGsetup.lAGENT#</option>
		<!--- <option value="phone">#URL.Type# Tel</option> --->
	</select>
	Search for #getGsetup.lAGENT# : <input type="text" name="searchStr" value=""> </h1>
	</cfoutput>
</form>

 <cfif getPersonnel.recordcount neq 0>
	<cfif isdefined("form.skeypage")>
		<cfset noOfPage=round(getPersonnel.recordcount/20)>
		
		<cfif getPersonnel.recordcount mod 20 LT 10 and getPersonnel.recordcount mod 20 neq 0>
			<cfset noOfPage = noOfPage + 1>
		</cfif>
		
		<cfif form.skeypage gt noofpage OR form.skeypage lt 1>
			<h3 align="center"><font color="#FF0000">Wrong page number! Please try again.</font></h3>
			<cfabort>
		</cfif>
	</cfif>
    </cfif>
	<cfform action="s_agenttable.cfm" method="post">
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
				|| <a href="s_agenttable.cfm?start=#prevtwenty#">Previous</a> ||
			</cfif>
		
			<cfif page neq noOfPage>
				 <a href="s_agenttable.cfm?start=#evaluate(nexttwenty)#">Next</a> ||
			</cfif>
		
			Page #page# Of #noOfPage#
		</cfoutput>
	</div>
    </cfform>	

<cfif isdefined("url.process")>
		<cfoutput><h1>#form.status#</h1><hr></cfoutput>
</cfif>

<cfif lcase(HcomID) eq "tmt_i" or lcase(HcomID) eq "taff_i" or lcase(HcomID) eq "taftc_i">
	<cfquery datasource='#dts#' name="type">
		Select agent,i.desp,commsion1,i2.desp as hp FROM #target_icagent# i
		left join icagent_type i2 on i.hp=i2.atype_id
		order by agent, desp, commsion1
	</cfquery>
<cfelse>
	<cfquery datasource='#dts#' name="type">
		Select * FROM #target_icagent# order by agent, desp, commsion1
	</cfquery>
</cfif>
<cfif isdefined("form.searchStr")>
	<cfif lcase(HcomID) eq "tmt_i" or lcase(HcomID) eq "taff_i" or lcase(HcomID) eq "taftc_i">
		<cfquery datasource='#dts#' name="exactResult">
			Select agent,i.desp,commsion1,i2.desp as hp FROM #target_icagent# i 
			left join icagent_type i2 on i.hp=i2.atype_id
			where #form.searchType# = '#form.searchStr#' order by agent, desp, commsion1
		</cfquery>
		
		<cfquery datasource='#dts#' name="similarResult">
			Select agent,i.desp,commsion1,i2.desp as hp FROM #target_icagent# i
			left join icagent_type i2 on i.hp=i2.atype_id
			where #form.searchType# LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#form.searchStr#%"> order by agent, desp, commsion1
		</cfquery>
	<cfelse>
		<cfquery datasource='#dts#' name="exactResult">
			Select * FROM #target_icagent# where #form.searchType# = '#form.searchStr#' order by agent, desp, commsion1
		</cfquery>
		
		<cfquery datasource='#dts#' name="similarResult">
			Select * FROM #target_icagent# where #form.searchType# LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#form.searchStr#%"> order by agent, desp, commsion1
		</cfquery>
	</cfif>
	<h2>Exact Result</h2>
	<cfif #exactResult.recordCount# neq 0>
	<table align="center" class="data" width="600px">					
			
		<tr>			
			<cfoutput><th>#getGsetup.lAGENT#</th></cfoutput>
			<th>Description</th>			
			<cfif lcase(HcomID) eq "avt_i" or lcase(HcomID) eq "net_i" or lcase(HcomID) eq "netm_i" or lcase(HcomID) eq "ideal_i" or lcase(HcomID) eq "idealb_i">
				<th>Email</th>
				<th>Contact</th>
			<cfelseif lcase(HcomID) eq "tmt_i" or lcase(HcomID) eq "taff_i" or lcase(HcomID) eq "taftc_i">
				<th>Commission</th>
				<th>Agent Type</th>
			<cfelse>			
				<th>Commission</th>
				<th>Contact</th>
			</cfif>
			<cfif getpin2.h1B11 eq 'T'><th>Action</th></cfif>
		</tr>
		<cfoutput query="exactResult"  startrow="#start#" maxrows="20">
		<tr>
			<td>#exactResult.agent#</a></td>
			<td>#exactResult.desp#</td>
			<td>#exactResult.commsion1#%</td>
			<td>#exactResult.hp#</td>				
  			<cfif getpin2.h1B11 eq 'T'><td nowrap><div align="center"><a href="agenttable2.cfm?type=Delete&agent=#exactResult.agent#"><img height="18px" width="18px" src="../../images/delete.ICO" alt="Delete" border="0">Delete</a>&nbsp;<a href="agenttable2.cfm?type=Edit&agent=#exactResult.agent#"><img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0">Edit</a></div></td></cfif>
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
			<th>Agent</th>
			<th>Description</th>
			<cfif lcase(HcomID) eq "avt_i" or lcase(HcomID) eq "net_i" or lcase(HcomID) eq "netm_i" or lcase(HcomID) eq "ideal_i" or lcase(HcomID) eq "idealb_i">
				<th>Email</th>
				<th>Contact</th>
			<cfelseif lcase(HcomID) eq "tmt_i" or lcase(HcomID) eq "taff_i" or lcase(HcomID) eq "taftc_i">
				<th>Commission</th>
				<th>Agent Type</th>
			<cfelse>			
				<th>Commission</th>
				<th>Contact</th>
			</cfif>	
			<cfif getpin2.h1B11 eq 'T'><th width="10%">Action</th></cfif>
		</tr>
		<cfoutput query="similarResult"  startrow="#start#" maxrows="20">
		<tr>
			<td>#similarResult.agent#</a></td>
			<td>#similarResult.desp#</td>
			<td>#similarResult.commsion1#%</td>
			<td>#similarResult.hp#</td>				
			<cfif getpin2.h1B11 eq 'T'><td nowrap><div align="center"><a href="agenttable2.cfm?type=Delete&agent=#similarResult.agent#"><img height="18px" width="18px" src="../../images/delete.ICO" alt="Delete" border="0">Delete</a>&nbsp;<a href="agenttable2.cfm?type=Edit&agent=#similarResult.agent#"><img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0">Edit</a></div></td></cfif>
		</tr>
		</cfoutput>
	</table>
	<cfelse>
		<h3>No Similar Records were found.</h3>
	</cfif>
</cfif>

<cfparam name="i" default="1" type="numeric">
<hr>

<fieldset><legend style="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;
font-style: italic;line-height: normal;font-weight: bold;text-transform: capitalize;color: #0066FF;">
<cfoutput>20 Newest #getGsetup.lAGENT#:</cfoutput></legend><br>
<cfif #type.recordCount# neq 0>
	<table align="center" class="data" width="600px">		
	<tr>
		<th>No.</th>
		<th><cfoutput>#getGsetup.lAGENT#</cfoutput></th>
		<th>Description</th>					
		<cfif lcase(HcomID) eq "avt_i" or lcase(HcomID) eq "net_i" or lcase(HcomID) eq "netm_i" or lcase(HcomID) eq "ideal_i" or lcase(HcomID) eq "idealb_i">
			<th>Email</th>
			<th>Contact</th>
		<cfelseif lcase(HcomID) eq "tmt_i" or lcase(HcomID) eq "taff_i" or lcase(HcomID) eq "taftc_i">
			<th>Commission</th>
			<th>Agent Type</th>
		<cfelse>			
			<th>Commission</th>
			<th>Contact</th>
		</cfif>
		<cfif getpin2.h1B11 eq 'T'><th>Action</th></cfif>
	</tr>
	<cfoutput query="type"  startrow="#start#" maxrows="20" >
	<tr>			
		<td>#i#</td>
		<td>#type.agent#</a></td>
		<td>#type.desp#</td>
		<td>#type.commsion1#%</td>
		<td>#type.hp#</td>				
		<cfif getpin2.h1B11 eq 'T'><td width="10%" nowrap><div align="center"><a href="agenttable2.cfm?type=Delete&agent=#type.agent#"><img height="18px" width="18px" src="../../images/delete.ICO" alt="Delete" border="0">Delete</a>&nbsp;<a href="agenttable2.cfm?type=Edit&agent=#type.agent#"><img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0">Edit</a></div></td></cfif>
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
