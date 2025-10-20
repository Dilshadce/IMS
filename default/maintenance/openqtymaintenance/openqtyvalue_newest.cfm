<html>
<head>
<title>Enquiry Opening Value</title>
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
	select count(itemno) as totalrecord 
	from icitem 
	order by wos_date
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
	
	<cfform action="openqtyvalue_newest.cfm" method="post" target="_self">
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
	
		<cfquery name="getitem" datasource="#dts#">
			select itemno,desp,despa
			from icitem 
			order by itemno
            limit #start-1#,20;
		</cfquery>

		<cfif start neq 1>
			|| <a target="_self" href="openqtyvalue_newest.cfm?start=#prevTwenty#">Previous</a> ||
		</cfif>
		
		<cfif page neq noOfPage>
			<a target="_self" href="openqtyvalue_newest.cfm?start=#nextTwenty#">Next</a> ||
		</cfif>

		Page #page# Of #noOfPage#
	  </div>
		<hr>
<h3><a href="openqtysummary.cfm"> >> Print All </a></h3>
<br>
<h3><a href="locationopenqtysummary.cfm"> >> Print All Location </a></h3>
		<table align="center" class="data" width="600px">
      		<tr> 
				
        		<th width="150">Item No</th>
        		<th>Description</th>
        		
        		<cfif getpin2.h1311 eq 'T'>
					<th width="100">Action</th>
			  </cfif>
      		</tr>
      		
			<cfloop query="getitem"> 
        		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
					
          			<td nowrap>#getitem.itemno#</td>
          			<td nowrap>#getitem.desp# #getitem.despa#</td>
          			<cfif getpin2.h1311 eq 'T'>
						<td width="100" nowrap>
					   <a href="openqtyvalue_item.cfm?itemno=#urlencodedformat(itemno)#">View</a></td>
			      </cfif>
        		</tr>
      		</cfloop> 
    	</table>
<hr>
		<div align="right">
		<cfif start neq 1>
			|| <a target="_self" href="openqtyvalue_newest.cfm?start=#prevTwenty#">Previous</a> ||
		</cfif>
		
		<cfif page neq noOfPage>
			<a target="_self" href="openqtyvalue_newest.cfm?start=#nextTwenty#">Next</a> ||
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