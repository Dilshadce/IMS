<cfif isdefined("url.proc")>
	<cfset status="">
	<cfif url.proc eq "add">
		<cfquery name="checkComm_s" datasource="#dts#">
			select ctype_id from commission_structure where ctype_id='#url.type#' and range1='#form.range1#'
		</cfquery>
		<cfif checkComm_s.recordcount eq 0>
			<cfquery name="insertComm_s" datasource="#dts#">
				insert into commission_structure (ctype_id,range1,comm) values ('#url.type#','#Replace(form.range1,",","","all")#','#form.comm#')
			</cfquery>
			<cfset status="Successfully Insert.">
		<cfelse>
			<cfset status="System already have this range. Please try others.">
		</cfif>
	<cfelse>
		<cfif url.entry neq "">
			<cfquery name="deleteComm_s" datasource="#dts#">
				delete from commission_structure where entryno='#url.entry#' and ctype_id='#url.type#'
			</cfquery>
			<cfset status="Successfully Delete.">
		</cfif>
	</cfif>
	<cflocation url="commission_table.cfm?type=#url.type#&status=#variables.status#" addtoken="no">
</cfif>

<cfquery name="getCommissionHeader" datasource="#dts#">
	select * from commission_type where ctype_id='#url.type#'
</cfquery>
<cfquery name="getCommission" datasource="#dts#">
	SELECT entryno,if(range1=0,'above',range1) as range1,comm FROM commission_structure s
	where s.ctype_id='#url.type#'
	order by range1
</cfquery>
	
<cfset cr=0>
<cfset i=1>
<cfset rangeList="">

<cfif getCommission.recordcount gt 0>
	<cfloop query="getCommission">
		<cfset cr=getCommission.currentrow>
		<cfif getCommission.currentrow eq getCommission.recordcount>
			<cfset rangeList=listappend(rangeList,"above","||")>
		<cfelse>
			<cfset rangeList=listappend(rangeList,numberformat(getCommission.range1[cr+1]-1,","),"||")>
		</cfif>
	</cfloop>
</cfif>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Commission Table</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>
<h1>Commission - <cfoutput>#getCommissionHeader.desp#</cfoutput></h1>
<h4><a href="commission_menu.cfm">Commission Menu</a></h4>
<cfif isdefined("url.status")><h3><cfoutput>#url.status#</cfoutput></h3></cfif>
	<table class="data">
	<cfoutput query="getCommissionHeader">
	<tr><th colspan="5">#desp#</th></tr>
	<tr>
		<th colspan="3">#range_header#</th>
		<th width="150" rowspan="2">#comm_header#</th>
		<th rowspan="2">Action</th>
	</tr>
	<tr>
		<th>X (User)</th>
		<th>and/to</th>
		<th>Y (System)</th>
	</tr>
	</cfoutput>
	<cfoutput query="getCommission">
		<tr>
			<td align="center">#numberFormat(getCommission.range1,",")#</td>
			<td align="center">#IIF(getCommission.recordcount eq getCommission.currentrow,DE("and"),DE("to"))#</td>
			<td align="center">#listgetat(rangeList,i,"||")#</td>
			<td>#comm#%</td>
			<td><a href="commission_table.cfm?type=#url.type#&proc=delete&entry=#getCommission.entryno#">Delete</a></td>
		</tr>
		<cfset i=i+1>
	</cfoutput>
	<cfform action="commission_table.cfm?type=#url.type#&proc=add" method="post">
	<tr>
		<td><cfinput type="text" name="range1" validate="integer" message="Incorrect Range!!" required="yes" maxlength="12" size="12"></td>
		<td colspan="2"></td>
		<td><cfinput type="text" name="comm" validate="float" message="Incorrect Commission Rate!!" required="yes" size="5" maxlength="5">%</td>
		<td><cfinput type="submit" name="submit" value="Add"></td>
	</tr>
	</cfform>
	</table>
</body>
</html>
