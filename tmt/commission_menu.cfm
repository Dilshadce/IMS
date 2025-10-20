<!--- <cflocation url="commission_table.cfm?type=cgs" addtoken="no"> --->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Commission Menu</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>
<h1>Commission - Main Menu</h1>
<cfloop list="cgs,p,tb" index="id">
	<cfquery name="getCommissionHeader" datasource="#dts#">
		select * from commission_type where ctype_id='#id#'
	</cfquery>
	<cfquery name="getCommission" datasource="#dts#">
		SELECT if(range1=0,'above',range1) as range1,comm FROM commission_structure s
		where s.ctype_id='#id#'
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
	<h4><cfoutput><a href="commission_table.cfm?type=#id#">Edit #getCommissionHeader.desp#</a></cfoutput></h4>
	<table class="data">
		<cfoutput query="getCommissionHeader">
		<tr><th colspan="5">#desp#</th></tr>
		<tr>
			<th colspan="3">#range_header#</th>
			<th width="150" rowspan="2">#comm_header#</th>
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
			</tr>
			<cfset i=i+1>
		</cfoutput>
		<cfif getCommission.recordcount eq 0><tr><td colspan="4">No Record Found.</td></tr></cfif>
	</table><br>
</cfloop>
</body>
</html>
