<cfif getpin2.h4G00 eq "T">
<script language="JavaScript"> 
var popup="Sorry, right-click is disabled.";
 function noway(go) { if 
(document.all) { if (event.button == 2) { alert(popup); return false; } } if (document.layers) 
{ if (go.which == 3) { alert(popup); return false; } } } if (document.layers) 
{ document.captureEvents(Event.MOUSEDOWN); } document.onmousedown=noway;
</script>
</cfif>

<html>
<head>
<title>Forecast Billable Report</title>
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
</head>

<cfquery name="getgeneral" datasource="#dts#">
	SELECT * FROM gsetup;
</cfquery>

<cfquery name="getgsetup2" datasource="#dts#">
	select 
	concat(',.',repeat('_',decl_uprice)) as decl_uprice
	from gsetup2;
</cfquery>

<cfset stDecl_UPrice = getgsetup2.Decl_UPrice>

<cfquery name="getcategory" datasource="#dts#">
	SELECT * FROM iccate order by cate
</cfquery>

<cfquery name="getallcustpo" datasource="#dts#">
    SELECT * FROM manpowerpo
	<!---
    <cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
    and itemno between <cfqueryparam cfsqltype="cf_sql_char" value="#form.productfrom#"> and <cfqueryparam cfsqltype="cf_sql_char" value="#form.productto#">
    </cfif>
    <cfif form.agentfrom neq "" and form.agentto neq "">
    and agenno between <cfqueryparam cfsqltype="cf_sql_char" value="#form.agentfrom#"> and <cfqueryparam cfsqltype="cf_sql_char" value="#form.agentto#">
    </cfif>
    <cfif form.periodfrom neq "" and form.periodto neq "">
    and fperiod between <cfqueryparam cfsqltype="cf_sql_char" value="#form.periodfrom#"> and <cfqueryparam cfsqltype="cf_sql_char" value="#form.periodto#">
    </cfif>
    <cfif form.datefrom neq "" and form.dateto neq "">
    and wos_date between <cfqueryparam cfsqltype="cf_sql_char" value="#ndatefrom#"> and <cfqueryparam cfsqltype="cf_sql_char" value="#ndateto#">
    <cfelse>
    and wos_date > <cfqueryparam cfsqltype="cf_sql_char" value="#lsdateformat(getgeneral.lastaccyear,'yyyy-mm-dd')#">
    </cfif>--->
</cfquery>

<body <cfif getpin2.h4G00 eq "T">onBeforePrint="document.body.style.display = 'none';" onAfterPrint="document.body.style.display = '';"</cfif>>
	<cfoutput>
	<h1 align="center">Forecast Billable Report</h1><br>
    <h2 align="center">Date : #dateformat(now(),"dd/mm/yyyy")#</h2>
    
	<table width="100%" border="2" cellspacing="0" cellpadding="5" >
		<tr>
			<th><div align="center"><font size="2" face="Times New Roman, Times, serif">No.</font></div></td>
			<th><div align="left"><font size="2" face="Times New Roman, Times, serif">PO Date</font></div></td>
			<th><div align="left"><font size="2" face="Times New Roman, Times, serif">PO No</font></div></td>
			<th><div align="left"><font size="2" face="Times New Roman, Times, serif">Customer</font></div></td>
			<th><div align="right"><font size="2" face="Times New Roman, Times, serif">PO Amount</font></div></td>
			<th><div align="right"><font size="2" face="Times New Roman, Times, serif">PO Threshold Amount</font></div></td>
			<th><div align="right"><font size="2" face="Times New Roman, Times, serif">Total JO Amount</font></div></td>
			<th><div align="right"><font size="2" face="Times New Roman, Times, serif">Average JO Amount</font></div></td>
			<th><div align="right"><font size="2" face="Times New Roman, Times, serif">Valid Date</font></div></td>
			<th><div align="right"><font size="2" face="Times New Roman, Times, serif">Months To Expire</font></div></td>
			<th><div align="right"><font size="2" face="Times New Roman, Times, serif">Sustainability</font></div></td>
		</tr>

		<cfloop query="getallcustpo">
		<cfquery name="getpolist" datasource="#dts#">
			SELECT jono FROM manpowerpolink where pono=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getallcustpo.refno)#">
		</cfquery>
		<cfset jolist=valuelist(getpolist.jono)>
		<cfquery name="getjoamount" datasource="#dts#">
		SELECT ifnull(sum(custtotal),0) as custtotal FROM assignmentslip
		WHERE placementno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#jolist#">)
		</cfquery>
		
		<cfset totalmonth = DateDiff('m',getallcustpo.wos_date,now())>
		<cfif totalmonth eq 0>
		<cfset totalmonth=1>
		</cfif>
				<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
					<td nowrap><div align="center"><font size="2" face="Times New Roman,Times,serif">#getallcustpo.currentrow#</font></div></td>
					<td nowrap><div align="left"><font size="2" face="Times New Roman,Times,serif">#dateformat(getallcustpo.wos_date,'dd/mm/yyyy')#</font></div></td>
					<td nowrap><div align="left"><font size="2" face="Times New Roman,Times,serif"><a href="po.cfm?action=update&refno=#getallcustpo.refno#" target="_blank">#getallcustpo.refno#</a></font></div></td>
					<td nowrap><div align="left"><font size="2" face="Times New Roman,Times,serif">#getallcustpo.custno# - #getallcustpo.name#</font></div></td>
					<td nowrap><div align="right"><font size="2" face="Times New Roman,Times,serif">#numberformat(getallcustpo.poamount,",.__")#</font></div></td>
					<td nowrap><div align="right"><font size="2" face="Times New Roman,Times,serif">#numberformat(getallcustpo.pothresholdamount,",.__")#</font></div></td>
					<td nowrap><div align="right"><font size="2" face="Times New Roman,Times,serif">#numberformat(getjoamount.custtotal,",.__")#</font></div></td>
					<td nowrap><div align="right"><font size="2" face="Times New Roman,Times,serif">#getallcustpo.povalidate#</font></div></td>
					<td nowrap><div align="right"><font size="2" face="Times New Roman,Times,serif"><cftry>#DateDiff('m',getallcustpo.povalidate,now())#<cfcatch></cfcatch></cftry></font></div></td>
					<cfset averagejo=getjoamount.custtotal/totalmonth>
					<td nowrap><div align="right"><font size="2" face="Times New Roman,Times,serif">#numberformat(averagejo,",.__")#</font></div></td>
					<cfif averagejo eq 0>
					<cfset averagejo=1>
					</cfif>
					<cfset forecast=int((getallcustpo.pothresholdamount-getjoamount.custtotal)/averagejo)>
					<td nowrap><div align="right"><font size="2" face="Times New Roman,Times,serif">#forecast#</font></div></td>
				</tr>
		</cfloop>
		

	</table>
    </cfoutput>
	
<br><br>
<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
</body>
</html>