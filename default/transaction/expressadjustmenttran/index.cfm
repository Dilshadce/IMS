<cfquery datasource="#dts#" name="getgeneral">
	Select 'Adjustment' as layer from gsetup
</cfquery>
<html>
<head>
<title>Create Or Edit Or View</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<cfparam name="start" default="1">
<cfparam name="page" default="1">
<cfparam name="prevTwenty" default="0">
<cfparam name="nextTwenty" default="0">

<cfquery datasource='#dts#' name="getjob">
	Select * from locadjtran group by refno
</cfquery>
<body>

	<!--- <cfset typeNo=#url.type# & "No"> 
	<cfset link = #url.type# &".cfm"> --->
	
	<!--- <cfif isdefined("URL.Type")> --->
		
<h1><cfoutput>Express Adjustment Selection Page</cfoutput></h1>
		
<cfoutput>
  <h4><a href="index2.cfm?type=Create">Creating an Adjustment</a></h4>
</cfoutput>
		
		<cfoutput>
		<form action="index.cfm" method="post"></cfoutput>
        
			<cfoutput>
			<h1>Search By :
			
			<select name="searchType">
				<option value="refno">Ref No</option>
				<option value="date">Date</option>
			</select>
      Search for #getgeneral.layer# : 
      <input type="text" name="searchStr" value=""> </h1>
			</cfoutput>
		</form>
		
		<cfif isdefined("url.process")>
				<cfoutput><h1>#form.status#</h1><hr></cfoutput>
		</cfif>
	
		<cfquery datasource='#dts#' name="type">
			Select * from locadjtran group by refno order by refno
		</cfquery>
		
		<cfif isdefined("form.searchStr")>
			<cfquery datasource='#dts#' name="exactResult">
				Select * from locadjtran where #form.searchType# = '#form.searchStr#'  group by refno order by #form.searchType#
			</cfquery>
			
			<cfquery datasource='#dts#' name="similarResult">
				Select * from locadjtran where #form.searchType# LIKE '#form.searchStr#' group by refno order by #form.searchType#
			</cfquery>
			
			<h2>Exact Result</h2>
			<cfif #exactResult.recordCount# neq 0>
			
    <table align="center" class="data" width="600px">
      <tr> 
        <th><cfoutput>#getgeneral.layer#</cfoutput></th>
        <th>Description</th>
        <th>Action</th>
      </tr>
      <cfoutput query="exactResult" startrow="#start#" maxrows="20"> 
        <tr> 
          <td>#exactResult.refno#</a></td>
          <td>#dateformat(exactResult.date,'DD/MM/YYYY')#</td>
          <td width="10%" nowrap> 
            <div align="center"><a href="index2.cfm?type=Delete&refno=#exactResult.refno#&uuid=#exactResult.uuid#"><img height="18px" width="18px" src="/images/delete.ICO" alt="Delete" border="0">Delete</a>&nbsp; 
              <a href="index2.cfm?type=Edit&refno=#exactResult.refno#&uuid=#exactResult.uuid#"><img height="18px" width="18px" src="/images/edit.ICO" alt="Edit" border="0">Preview</a></div></td>
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
        <th><cfoutput>#getgeneral.layer#</cfoutput></th>
        <th>Description</th>
        <th>Action</th>
      </tr>
      <cfoutput query="similarResult" startrow="#start#" maxrows="20"> 
        <tr> 
          <td>#similarResult.refno#</a></td>
          <td>#dateformat(similarResult.date,'DD/MM/YYYY')#</td>
          <td width="10%" nowrap> 
            <div align="center"><a href="index2.cfm?type=Delete&refno=#similarResult.refno#&uuid=#similarResult.uuid#"><img height="18px" width="18px" src="/images/delete.ICO" alt="Delete" border="0">Delete</a>&nbsp; 
              <a href="index2.cfm?type=Edit&refno=#similarResult.refno#&uuid=#similarResult.uuid#"><img height="18px" width="18px" src="/images/edit.ICO" alt="Edit" border="0">Preview</a></div></td>
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
		<cfoutput>20 Newest Project :</cfoutput></legend>
		<br>
		<cfif #type.recordCount# neq 0>
		<cfform action="index.cfm" method="post">
		<div align="right">Page 
		<cfinput name="skeypage" type="text" size="2" validate="integer" message="Wrong value in Page field.">
		
		<cfset noOfPage = round(getJob.recordcount/20)>
		
		<cfif getJob.recordcount mod 20 LT 10 and getJob.recordcount mod 20 neq 0>
			<cfset noOfPage = noOfPage + 1>
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
		
		<cfset prevTwenty = start -20>
		<cfset nextTwenty = start +20>
		<cfset page = round(nextTwenty/20)>
		
		<cfoutput>
			<cfif start neq 1>
				|| <a href="index.cfm?start=#prevTwenty#">Previous</a> ||
			</cfif>
			
			<cfif page neq noOfPage>
				 <a href="index.cfm?start=#evaluate(nextTwenty)#">Next</a> ||
			</cfif>
		
			Page #page# Of #noOfPage#
		</cfoutput>
			</div>
  <table align="center" class="data" width="600px">
    <tr> 
      <th width="40">No</th>
      <th width="60"><cfoutput>#getgeneral.layer#</cfoutput></th>
      <th>Description</th>
      <cfif getpin2.h1H11 eq 'T'><th width="70">Action</th></cfif>
    </tr>
    <cfoutput query="type" startrow="#start#" maxrows="20"> 
      <tr> 
        <td>#i#</td>
        <td>#type.refno#</a></td>
        <td>#dateformat(type.date,'DD/MM/YYYY')#</td>
        <td width="10%" nowrap> 
          <div align="center"><a href="index2.cfm?type=Delete&refno=#type.refno#&uuid=#type.uuid#"><img height="18px" width="18px" src="/images/delete.ICO" alt="Delete" border="0">Delete</a>&nbsp; 
            <a href="index2.cfm?type=Edit&refno=#type.refno#&uuid=#type.uuid#"><img height="18px" width="18px" src="/images/edit.ICO" alt="Edit" border="0">Preview</a></div></td>
      </tr>
      <cfset i = incrementvalue(#i#)>
    </cfoutput> 
  </table>
  <hr>
    	<div align="right">
		<cfoutput>
      		<cfif start neq 1>
        		<a href="index.cfm?start=#prevTwenty#">Previous</a> || 
      		</cfif>
      		<cfif page neq noOfPage>
        		<a href="index.cfm?start=#evaluate(nextTwenty)#">Next</a> || 
			</cfif>
     		Page #page# Of #noOfPage#</div>
  		</cfoutput>
	</cfform>
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
