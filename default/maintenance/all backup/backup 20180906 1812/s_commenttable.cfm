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
	Select * from comments order by code
</cfquery>
<body>

	<!--- <cfset typeNo=#url.type# & "No"> 
	<cfset link = #url.type# &".cfm"> --->
	
	<!--- <cfif isdefined("URL.Type")> --->
		<h1><cfoutput>Comment Selection Page</cfoutput></h1>
		
		<cfoutput><h4><cfif getpin2.h1E10 eq 'T'><a href="commenttable2.cfm?type=Create">Creating a New Comment</a> </cfif><cfif getpin2.h1E20 eq 'T'>|| <a href="commenttable.cfm?">List all Comment</a> </cfif><cfif getpin2.h1E30 eq 'T'>|| <a href="s_commenttable.cfm?type=comments">Search For Comment</a></cfif>
  
   <cfif getpin2.h1630 eq 'T'>|| <a href="p_comment.cfm">Comment Listing</a></cfif></h4></cfoutput>
		
		<cfoutput>
		<form action="s_commenttable.cfm" method="post"></cfoutput>
			<cfoutput>
			<h1>Search By :
			
			<select name="searchType">
				<option value="code">Code</option>
				<!--- <option value="phone">#URL.Type# Tel</option> --->
			</select>
        Search for Comment : <input type="text" name="searchStr" value=""> </h1>
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
	<cfform action="s_commenttable.cfm" method="post">
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
				|| <a href="s_commenttable.cfm?start=#prevtwenty#">Previous</a> ||
			</cfif>
		
			<cfif page neq noOfPage>
				 <a href="s_commenttable.cfm?start=#evaluate(nexttwenty)#">Next</a> ||
			</cfif>
		
			Page #page# Of #noOfPage#
		</cfoutput>
	</div>
    </cfform>	
		
		<cfif isdefined("url.process")>
				<cfoutput><h1>#form.status#</h1><hr></cfoutput>
		</cfif>
	
		<cfquery datasource='#dts#' name="type">
			Select * from comments order by code, desp, details
		</cfquery>
		
		<cfif isdefined("form.searchStr")>
			<cfquery datasource="#dts#" name="exactResult">
				Select * from comments where #form.searchType# = '#form.searchStr#' order by code, desp, details
			</cfquery>
			
			<cfquery datasource="#dts#" name="similarResult">
				Select * from comments where #form.searchType# LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#form.searchStr#%"> order by code, desp, details
			</cfquery>
			
			<h2>Exact Result</h2>
			<cfif #exactResult.recordCount# neq 0>
			<table align="center" class="data" width="800px">					
					
					<tr>
						
						<th>Code</th>
						<th>Description</th>
						<th>Details</th>
						<cfif getpin2.h1E11 eq 'T'><th>Action</th></cfif>
		
					</tr>
					<cfoutput query="exactResult">
					<cfset det = ToString(#exactResult.details#)>
					<tr>
						<td>#exactResult.code#</a></td>
						<td>#exactResult.desp#</td>
						<td><textarea name="textarea" cols="90" rows="5" class="data" readonly wrap="hard">#det#</textarea></td>
						<cfif getpin2.h1E11 eq 'T'>
          				<td width="10%" nowrap> 
            			<a href="commenttable2.cfm?type=Delete&code=#URLEncodedFormat(exactResult.code)#"><img height="18px" width="18px" src="../../images/delete.ICO" alt="Delete" border="0">Delete</a> 
            			<a href="commenttable2.cfm?type=Edit&code=#URLEncodedFormat(exactResult.code)#"><img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0">Edit</a></td></cfif>
					</tr>
					</cfoutput>
			</table>
			<cfelse>
				<h3>No Exact Records were found.</h3>
			</cfif>
			
			<h2>Similar Result</h2>
			<cfif #similarResult.recordCount# neq 0>
			<table align="center" class="data" width="800px">					
					
					<tr>
						
						<th>Code</th>
						<th>Description</th>
						<th>Details</th>
						<cfif getpin2.h1E11 eq 'T'><th>Action</th></cfif>
						
					</tr>
					<cfoutput query="similarResult">
					<cfset det = ToString(#similarResult.details#)>
					<tr>
						<td>#similarResult.code#</a></td>
						<td>#similarResult.desp#</td>
						<td><textarea name="textarea" cols="90" rows="5" class="data" readonly wrap="hard">#det#</textarea></td>
						<cfif getpin2.h1E11 eq 'T'>
          				<td width="10%" nowrap><div align="center"><a href="commenttable2.cfm?type=Delete&code=#URLEncodedFormat(similarResult.code)#"><img height="18px" width="18px" src="../../images/delete.ICO" alt="Delete" border="0">Delete</a><a href="commenttable2.cfm?type=Edit&code=#URLEncodedFormat(similarResult.code)#"><img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0">Edit</a></div></td></cfif>
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
		<cfoutput>20 Newest Comments:</cfoutput></legend><br>
		<cfif #type.recordCount# neq 0>
		<table align="center" class="data" width="700px">					
				
				<tr>
						<th>No.</th>
						<th>Code</th>
						<th>Description</th>
						<th>Details</th>
						<cfif getpin2.h1E11 eq 'T'><th>Action</th></cfif>
				
				</tr>
				<cfoutput query="type" maxrows="20">
				<cfset det = ToString(#type.details#)>
				<tr>
						
						<td>#i#</td>
						<td>#type.code#</a></td>
						<td>#type.desp#</td>						
        				<td><textarea name="textarea" cols="90" rows="5" class="data" readonly wrap="hard">#det#</textarea></td>
						<cfif getpin2.h1E11 eq 'T'>
        				<td width="10%" nowrap><div align="center"><a href="commenttable2.cfm?type=Delete&code=#URLEncodedFormat(type.code)#"><img height="18px" width="18px" src="../../images/delete.ICO" alt="Delete" border="0">Delete</a><a href="commenttable2.cfm?type=Edit&code=#URLEncodedFormat(type.code)#"><img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0">Edit</a></div></td>
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
