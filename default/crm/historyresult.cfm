<html>
<head>
<title>Customer Relationship Management</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<style type="text/css" media="print">
	.noprint { display: none; }
</style>
</head>
<body>
<h1 align="center">VIEW CUSTOMER HISTORY REPORT</h1>
<cfoutput>
<cfquery name="getservi" datasource="#dts#">
	select servi,(select desp from icservi where servi=service_type.servi) as servicedesp from service_type where servi <> '' group by servi
</cfquery>
<!--- <cfquery name="getcontract" datasource="#dts#">
	<cfif isdefined("form.custno") and form.custno neq "">
		select refno,type,custno,name,wos_date from ictran 
		where custno="#form.custno#" and type in ('INV','DO') and toinv='' and itemno="MAINTENANCE-1Y" <!---and void = ""--->
	<cfelseif isdefined("form.custfrom") and form.custfrom neq "" and form.custto neq "">
		select refno,type,custno,name,wos_date from ictran 
		where custno between "#form.custfrom#" and "#form.custto#" and type in ('INV','DO') and toinv='' and itemno="MAINTENANCE-1Y" <!---and void = ""--->
	<cfelse>
		select refno,type,custno,name,wos_date from ictran 
		where type in ('INV','DO') and toinv='' and itemno="MAINTENANCE-1Y" <!---and void = ""--->
	</cfif> 
	group by type,refno
</cfquery> --->
<cfquery name="getcontract" datasource="#dts#">
	<cfif isdefined("form.custno") and form.custno neq "">
		select refno,type,custno,name,wos_date,rem10,rem11 from artran 
		where custno="#form.custno#" and type='INV' and frem9='T'
	<cfelseif isdefined("form.custfrom") and form.custfrom neq "" and form.custto neq "">
		select refno,type,custno,name,wos_date,rem10,rem11 from artran 
		where custno between '#form.custfrom#' and '#form.custto#' and type='INV' and frem9='T'
    <cfelseif isdefined("url.custno") and url.custno neq "">
    	select refno,type,custno,name,wos_date,rem10,rem11 from artran 
		where custno="#url.custno#" and type='INV' and frem9='T'
	<cfelse>
		select refno,type,custno,name,wos_date,rem10,rem11 from artran 
		where type='INV' and frem9='T'
	</cfif> 
	group by type,refno
</cfquery>

<cfloop query="getcontract">
	<cfif getcontract.rem10 neq "" and getcontract.rem11 neq "">
		<cfset startdate=createDate(ListGetAt(getcontract.rem10,3,"/"),ListGetAt(getcontract.rem10,2,"/"),ListGetAt(getcontract.rem10,1,"/"))>
		<cfset expiredate=createDate(ListGetAt(getcontract.rem11,3,"/"),ListGetAt(getcontract.rem11,2,"/"),ListGetAt(getcontract.rem11,1,"/"))>
	<cfelse>
		<cfset startdate=getcontract.wos_date>
		<!--- <cfset expiredate = DateAdd("d", 372 , getcontract.wos_date)> --->
		<cfset expiredate=DateAdd("d", 372 , getcontract.wos_date)>
	</cfif>
	
	<cfset checkdate = datediff("d", now(), expiredate)>
	<cfif checkdate gte 1>
	<table cellspacing="0" class="data" width="100%">
		<tr>
			<th nowrap>RefNo</th>
			<th nowrap>CustNo</th>
			<th colspan="3">Name</th>
			<th nowrap>Date of Purchace</th>
			<th nowrap>Expire Date</th>
		</tr>
		<!--- <cfset inscount = 0>
		<cfset o2count = 0>
		<cfset trancount = 0>
		<cfset sitecount = 0>
		<cfset custcount = 0>
		<cfset othercount = 0> --->
		<cfset custno = getcontract.custno>
		<cfset type = getcontract.type>
		<cfset refno = getcontract.refno>
		<cfset cdate = dateformat(startdate,"yyyy-mm-dd")>
		<cfset edate = dateformat(expiredate,"yyyy-mm-dd")>
			
		<!--- <cfquery name="getservice" datasource="#dts#">
			select * from service_tran where custno = "#custno#"
			and servicedate between '#cdate#' and '#edate#'
		</cfquery> --->
			
		<tr>
			<td align="left"><strong>#getcontract.type# #getcontract.refno#</strong></td>
			<td align="left"><strong>#getcontract.custno#</strong></td>
			<td colspan="3" align="left"><strong>#getcontract.name#</strong></td>
			<td align="center"><strong>#dateformat(startdate,"dd-mm-yyyy")#</strong></td>
			<td align="left"><strong>#dateformat(expiredate,"dd-mm-yyyy")# Remain #checkdate# days</strong></td>
		</tr>
		<cfloop query="getservi">
			<cfset inscount = 0>
			<cfset thisservice=getservi.servi>
			<cfquery name="getpackage" datasource="#dts#">
				select type,refno,qty,unit from ictran 
				where type in ('INV','DO') and (toinv = "" or toinv is null) and custno = "#custno#"
				and wos_date between '#cdate#' and '#edate#'
				and itemno="#thisservice#"
			</cfquery>
			<cfquery name="getpackage2" datasource="#dts#">
				select qty,unit from contract_service 
				where type='#type#' and refno = "#refno#" and custno = "#custno#"
				and servi="#thisservice#"
			</cfquery>
			<cfquery name="getservice_tran" datasource="#dts#">
				select * from service_tran where custno = "#custno#"
				and servicedate between '#cdate#' and '#edate#'
				<cfif thisservice eq "OTR">
					and (servicetype in (select servicetypeid from service_type where servi='#thisservice#') or servicetype not in (select servicetypeid from service_type))
				
					
				<cfelse>
					and servicetype in (select servicetypeid from service_type where servi='#thisservice#')
				</cfif>
			</cfquery>
			<tr>
				<td align="left"><strong><u>#getservi.servicedesp#</u></strong></td>
			</tr>
			<cfloop query="getservice_tran">
				<cfif getservice_tran.s_status neq "5">
					<cfset inscount = inscount + getservice_tran.qty>
				</cfif>
				<cfif getservice_tran.s_status eq "1">
					<cfset this_status="New">
				<cfelseif getservice_tran.s_status eq "2">
					<cfset this_status="Follow Up">
				<cfelseif getservice_tran.s_status eq "3">
					<cfset this_status="Closed">
				<cfelseif getservice_tran.s_status eq "4">
					<cfset this_status="Unsolved">
				<cfelseif getservice_tran.s_status eq "5">
					<cfset this_status="Cancel">
				</cfif>
				<tr bgcolor="white">
					<td align="left">#getservice_tran.serviceid# (#this_status#)</td>
					<td align="left">#getservice_tran.csoid#</td>
					<td align="left">#dateformat(getservice_tran.servicedate,"dd-mm-yyyy")#</td>
                    <td align="left">#getservice_tran.qty# #getpackage.unit#</td>
					<td align="left">#getservice_tran.servicetype#</td>
					<td align="left">#getservice_tran.apptime#</td>
					<td align="justify">#tostring(getservice_tran.instruction)#</td>
					<td align="left">#getservice_tran.assby#</td>
				</tr>
			</cfloop>
			<cfset totqty=val(getpackage2.qty)>
			<cfloop query="getpackage">
				<tr bgcolor="##83B8ED">
					<td colspan="100%" align="left"><i>&nbsp;&nbsp;#getpackage.type# #getpackage.refno#&nbsp;&nbsp;&nbsp;Qty = #val(getpackage.qty)# #getpackage.unit#</i></td>
				</tr>		
				<cfset totqty=val(getpackage.qty)+totqty>
			</cfloop>
			<tr>
				<td colspan="2" align="left"><font color="red">Total = #val(totqty)# #getpackage2.unit#; Used = #inscount#; Remain = #val(totqty)-inscount#</font></td>
			</tr>
		</cfloop>
		<br><br><br>
	</cfif>
	</table>
</cfloop>
</cfoutput>

<cfif getcontract.recordcount eq 0>
	<h3>Sorry,No Records Found !</h3>
</cfif>

</body>
</html>