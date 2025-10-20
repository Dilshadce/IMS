<html>
<head>
<title>Search Items</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfquery name="getgsetup" datasource="#dts#">
	select * from gsetup
</cfquery>

<cfquery name="getgsetup2" datasource='#dts#'>
	select concat(',.',(repeat('_',decl_uprice))) as decl_uprice 
	from gsetup2
</cfquery>

<cfparam name="start" default="1">
<cfparam name="page" default="1">
<cfparam name="prevTwenty" default="0">
<cfparam name="nextTwenty" default="0">

<cfquery name="getrecordcount" datasource="#dts#">
	select count(placementno) as totalrecord 
	from placementleave 
	order by Placementno
</cfquery>

<body>
<cfoutput>
<cfif getrecordcount.recordcount neq 0>
	<cfif isdefined("form.skeypage")>
		<cfset noOfPage = round(getrecordcount.totalrecord/20)>
		<cfif getrecordcount.totalrecord mod 20 LT 10 and getrecordcount.totalrecord mod 20 neq 0>
			<cfset noOfPage = noOfPage + 1>
		</cfif>
		
		<cfif form.skeypage gt noofpage or form.skeypage lt 1>
			<h3 align="center"><font color="FF0000">Wrong page number! Please try again.</font></h3>
			<cfabort>
		</cfif>
 	</cfif>
	
	<cfform action="splacementleave_newest.cfm" method="post" target="_self">
		<div align="right">Page <cfinput name="skeypage" type="text" size="2" validate="integer" message="Wrong value in Page field.">
		
		<cfset noOfPage = round(getrecordcount.totalrecord/20)>
		
		<cfif getrecordcount.totalrecord mod 20 LT 10 and getrecordcount.totalrecord mod 20 neq 0>
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
		
		<cfquery datasource='#dts#' name="getjob">
			Select * from Placementleave order by placementno
			limit #start-1#,20;
		</cfquery>

		<cfif start neq 1>
			|| <a target="_self" href="splacementleave_newest.cfm?start=#prevTwenty#">Previous</a> ||
		</cfif>
		
		<cfif page neq noOfPage>
			<a target="_self" href="splacementleave_newest.cfm?start=#nextTwenty#">Next</a> ||
		</cfif>

		Page #page# Of #noOfPage#
		</div>
		<hr>

	<table align="center" class="data" width="700px">
      		<tr> 
        	<th>Placement</th>
        	<th>Date Created</th>
            <th>Created By</th>
            <th>Date Updated</th>
            <th>Updated By</th>
            <th>Action</th>
      		</tr>
      		
			<cfloop query="getjob"> 
        		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';" > 
          		<td>#getjob.Placementno#</a></td>
          		<td>#dateformat(getjob.created_on,'YYYY-MM-DD')# #timeformat(getjob.created_on,'HH:MM:SS')#</td>
                <td>#getjob.created_by#</td>
          		<td>#dateformat(getjob.updated_on,'YYYY-MM-DD')# #timeformat(getjob.updated_on,'HH:MM:SS')#</td>   
                <td>#getjob.updated_by#</td>      
						<td width="10%" nowrap>
            
            <div align="center"> 
            
            <a href="Placementleavetable.cfm?type=Delete&Placementno=#getjob.id#" target="_parent"><img height="18px" width="18px" src="/images/delete.ICO" alt="Delete" border="0">Delete</a>&nbsp; 
              <a href="Placementleavetable.cfm?type=Edit&Placementno=#getjob.id#" target="_parent"><img height="18px" width="18px" src="/images/edit.ICO" alt="Edit" border="0">Edit</a></div></td>

        		</tr>
      		</cfloop> 
    	</table>
		<hr>
		<div align="right">
		<cfif start neq 1>
			|| <a target="_self" href="splacementleave_newest.cfm?start=#prevTwenty#">Previous</a> ||
		</cfif>
		
		<cfif page neq noOfPage>
			<a target="_self" href="splacementleave_newest.cfm?start=#nextTwenty#">Next</a> ||
		</cfif>
		
		Page #page# Of #noOfPage#
		</div>
	</cfform>
<cfelse>
	<h3>No Records were found.</h3>
</cfif>
</cfoutput>
</body>
</html>