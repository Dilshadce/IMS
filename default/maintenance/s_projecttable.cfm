<cfquery datasource="#dts#" name="getgeneral">
	Select lPROJECT as layer from gsetup
</cfquery>
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
	Select * FROM #target_project# order by source
</cfquery>
<body>

	<!--- <cfset typeNo=#url.type# & "No"> 
	<cfset link = #url.type# &".cfm"> --->
	
	<!--- <cfif isdefined("URL.Type")> --->
		
<h1><cfoutput>#getgeneral.layer# Selection Page</cfoutput></h1>
		
<cfoutput>
	<h4>
		<cfif getpin2.h1H10 eq 'T'><a href="Projecttable2.cfm?type=Create">Creating a #getgeneral.layer#</a> </cfif>
		<cfif getpin2.h1H20 eq 'T'>|| <a href="Projecttable.cfm?">List all #getgeneral.layer#</a> </cfif>
		<cfif getpin2.h1H30 eq 'T'>|| <a href="s_Projecttable.cfm?type=project">Search For #getgeneral.layer#</a></cfif>||<a href="p_project.cfm">#getgeneral.layer# Listing report</a>||<a href="import_project.cfm">#getgeneral.layer# comparing report</a>
	</h4>
</cfoutput>
		
		<cfoutput>
		<form action="s_Projecttable.cfm" method="post"></cfoutput>
			<cfoutput>
			<h1>Search By :
			
			<select name="searchType">
				<option value="source">#getgeneral.layer#</option>
				<option value="project">Description</option>
			</select>
      Search for #getgeneral.layer# : 
      <input type="text" name="searchStr" value=""> </h1>
			</cfoutput>
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
	<cfform action="s_Projecttable.cfm" method="post">
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
				|| <a href="s_Projecttable.cfm?start=#prevtwenty#">Previous</a> ||
			</cfif>
		
			<cfif page neq noOfPage>
				 <a href="s_Projecttable.cfm?start=#evaluate(nexttwenty)#">Next</a> ||
			</cfif>
		
			Page #page# Of #noOfPage#
		</cfoutput>
	</div>
    </cfform>	
		<cfif isdefined("url.process")>
				<cfoutput><h1>#form.status#</h1><hr></cfoutput>
		</cfif>
	
		<cfquery datasource='#dts#' name="type">
			Select * FROM #target_project# where porj = "P" order by source, project, porj
		</cfquery>
		
		<cfif isdefined("form.searchStr")>
			<cfquery datasource='#dts#' name="exactResult">
				Select * FROM #target_project# where #form.searchType# = '#form.searchStr#' and porj = "P" order by #form.searchType#
			</cfquery>
			
			<cfquery datasource='#dts#' name="similarResult">
				Select * FROM #target_project# where #form.searchType# LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#form.searchStr#%"> and porj = "P" order by #form.searchType#
			</cfquery>
			
			<h2>Exact Result</h2>
			<cfif exactResult.recordCount neq 0>
			
    <table align="center" class="data" width="600px">
      <tr> 
        <th><cfoutput>#getgeneral.layer#</cfoutput></th>
        <th>Description</th>
<!---         <th>P or J</th> --->
        <cfif getpin2.h1H11 eq 'T'><th>Action</th></cfif>
      </tr>
      <cfoutput query="exactResult"> 
        <tr> 
          <td>#exactResult.source#</a></td>
          <td>#exactResult.project#</td>
<!---           <td>#exactResult.porj#</td> --->
          <cfif getpin2.h1H11 eq 'T'><td width="10%" nowrap> 
            <div align="center"><a href="Projecttable2.cfm?type=Delete&source=#URLEncodedFormat(exactResult.source)#"><img height="18px" width="18px" src="../../images/delete.ICO" alt="Delete" border="0">Delete</a>&nbsp; 
              <a href="Projecttable2.cfm?type=Edit&source=#URLEncodedFormat(exactResult.source)#"><img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0">Edit</a></div></td></cfif>
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
        <th><cfoutput>#getgeneral.layer#</cfoutput></th>
        <th>Description</th>
<!---         <th>P or J</th> --->
        <cfif getpin2.h1H11 eq 'T'><th>Action</th></cfif>
      </tr>
      <cfoutput query="similarResult"> 
        <tr> 
          <td>#similarResult.source#</a></td>
          <td>#similarResult.project#</td>
 <!---          <td>#similarResult.porj#</td> --->
          <cfif getpin2.h1H11 eq 'T'><td width="10%" nowrap> 
            <div align="center"><a href="Projecttable2.cfm?type=Delete&source=#URLEncodedFormat(similarResult.source)#"><img height="18px" width="18px" src="../../images/delete.ICO" alt="Delete" border="0">Delete</a>&nbsp; 
              <a href="Projecttable2.cfm?type=Edit&source=#URLEncodedFormat(similarResult.source)#"><img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0">Edit</a></div></td></cfif>
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
		<cfoutput>20 Newest #getgeneral.layer# :</cfoutput></legend>
		<br>
		<cfif #type.recordCount# neq 0>
		
  <table align="center" class="data" width="600px">
    <tr> 
      <th width="40">No</th>
      <th width="60"><cfoutput>#getgeneral.layer#</cfoutput></th>
      <th>Description</th>
<!---       <th width="45">P or J</th> --->
      <cfif getpin2.h1H11 eq 'T'><th width="70">Action</th></cfif>
    </tr>
    <cfoutput query="type" startrow="#start#" maxrows="20"> 
      <tr> 
        <td>#i#</td>
        <td>#type.source#</a></td>
        <td>#type.project#</td>
<!---         <td>#type.porj#</td> --->
        <cfif getpin2.h1H11 eq 'T'><td width="10%" nowrap> 
          <div align="center"><a href="Projecttable2.cfm?type=Delete&source=#URLEncodedFormat(type.source)#"><img height="18px" width="18px" src="../../images/delete.ICO" alt="Delete" border="0">Delete</a>&nbsp; 
            <a href="Projecttable2.cfm?type=Edit&source=#URLEncodedFormat(type.source)#"><img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0">Edit</a></div></td></cfif>
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
