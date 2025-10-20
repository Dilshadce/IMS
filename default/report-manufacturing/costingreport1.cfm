<cfif getpin2.h4G00 eq "T">
<script language="JavaScript"> 
var popup="Sorry, right-click is disabled.";
 function noway(go) { if 
(document.all) { if (event.button == 2) { alert(popup); return false; } } if (document.layers) 
{ if (go.which == 3) { alert(popup); return false; } } } if (document.layers) 
{ document.captureEvents(Event.MOUSEDOWN); } document.onmousedown=noway;
</script>
</cfif>

<cfquery name="getgeneral" datasource="#dts#">
	select cost,compro,lastaccyear,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION,agentlistuserid from gsetup
</cfquery>

<cfquery name="getgsetup2" datasource='#dts#'>
	select * from gsetup2
</cfquery>

<cfparam name="ndatefrom" default="">
<cfparam name="ndateto" default="">
<cfparam name="totalamt" default="0">
<cfparam name="totaldisc" default="0">
<cfparam name="totalnet" default="0">
<cfparam name="totaltax" default="0">
<cfparam name="totalgrand" default="0">
<cfparam name="totalfcamt" default="0">

<cfset title1 = iif(form.title eq "Customer",DE(target_arcust),DE(target_apvend))>	
	
<cfif isdefined("form.datefrom") and isdefined("form.dateto")>
	<cfset dd = dateformat(form.datefrom, "DD")>

	<cfif dd greater than '12'>
		<cfset ndatefrom = dateformat(form.datefrom,"YYYYMMDD")>
	<cfelse>
		<cfset ndatefrom = dateformat(form.datefrom,"YYYYDDMM")>
	</cfif>

	<cfset dd = dateformat(form.dateto, "DD")>

	<cfif dd greater than '12'>
		<cfset ndateto = dateformat(form.dateto,"YYYYMMDD")>
	<cfelse>
		<cfset ndateto = dateformat(form.dateto,"YYYYDDMM")>
	</cfif>
</cfif>

<cfquery datasource="#dts#" name="gettran">
	select 
	a.*
	from artran as a<cfif (form.locationfrom neq "" and form.locationto neq "") or url.trancode eq "TR" or (form.groupfrom neq "" and form.groupto neq "")>, ictran as b</cfif>
	where 
	a.type='#url.trancode#' 
	and (a.void='' or a.void is null)
	<cfif (form.locationfrom neq "" and form.locationto neq "") or url.trancode eq "TR" or (form.groupfrom neq "" and form.groupto neq "")>
		<cfif url.trancode neq "TR">
			and a.type=b.type 
		<cfelse>
			and b.type ='TROU'
		</cfif>
		and a.refno=b.refno
	</cfif>	
	<cfif url.trancode eq "CS" and lcase(Hcomid) eq "ovas_i" and isdefined("form.refnoprefix") and form.refnoprefix neq "">
		and a.refno like '#form.refnoprefix#%'
	</cfif>
	<cfif ndatefrom neq "" and ndateto neq "">
		and a.wos_date between '#ndatefrom#' and '#ndateto#'
	<cfelse>
		and a.wos_date > #getgeneral.lastaccyear#
	</cfif>
	<cfif form.agentfrom neq "" and form.agentto neq "">
		and a.agenno between '#form.agentfrom#' and '#form.agentto#'
	</cfif>
	<cfif trim(form.getfrom) neq "" and trim(form.getto) neq "">
		and a.custno between '#form.getfrom#' and '#form.getto#'
	</cfif>
	<cfif form.periodfrom neq "" and form.periodto neq "">
		and a.fperiod between '#form.periodfrom#' and '#form.periodto#' 
	</cfif>
	<cfif form.billfrom neq "" and form.billto neq "">
		and a.refno between '#form.billfrom#' and '#form.billto#' and a.refno <> '99'
	</cfif>
	<cfif form.locationfrom neq "" and form.locationto neq "">
		and b.location between '#form.locationfrom#' and '#form.locationto#'
	</cfif>
	<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		and b.wos_group between '#form.groupfrom#' and '#form.groupto#'
	</cfif>
    <cfif form.projectfrom neq "" and form.projectto neq "">
			and a.source between "#form.projectfrom#" and "#form.projectto#"
	</cfif> 
	<cfif form.jobfrom neq "" and form.jobto neq "">
    and a.job between "#form.jobfrom#" and "#form.jobto#"
    </cfif>
    <cfif url.alown eq 1>
			<cfif getgeneral.agentlistuserid eq "Y">and ucase(a.agenno) in (SELECT agent FROM icagent WHERE agentlist like "%#ucase(huserid)#%")
			<cfelse>
            and (ucase(userid)='#ucase(huserid)#' or ucase(a.agenno)='#ucase(huserid)#')  
			</cfif>
		<cfelse>
			<cfif Huserloc neq "All_loc">
				and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
			</cfif>
		</cfif>
	group by a.type,a.refno
	order by a.refno
</cfquery>

		<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
		<cfset stDecl_UPrice = ",.">
		
		<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
			<cfset stDecl_UPrice = stDecl_UPrice & "_">
		</cfloop>
		
		<html>
		<head>
			<title>View Bill Listing Report</title>
			<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
			<link href = "../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
			<style type="text/css" media="print">
				.noprint { display: none; }
			</style>
		</head>

		<body <cfif getpin2.h4G00 eq "T">onBeforePrint="document.body.style.display = 'none';" onAfterPrint="document.body.style.display = '';"</cfif>>
		
		<table align="center" cellpadding="3" cellspacing="0" width="100%">
		<cfoutput>
			<tr>
				<td colspan="11"><div align="center"><font size="3" face="Arial, Helvetica, sans-serif"><strong>Costing Report</strong></font></div></td>
			</tr>
			<cfif form.billfrom neq "" and form.billto neq "">
				<tr>
					<td colspan="11"><div align="center"><font size="1.5" face="Arial, Helvetica, sans-serif">Ref No From #form.billfrom# To #form.billto#</font></div></td>
				</tr>
			</cfif>
			<cfif ndatefrom neq "" and ndateto neq "">
				<tr>
					<td colspan="11"><div align="center"><font size="1.5" face="Arial, Helvetica, sans-serif">#form.datefrom# - #form.dateto#</font></div></td>
				</tr>
			</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
				<tr>
					<td colspan="11"><div align="center"><font size="1.5" face="Arial, Helvetica, sans-serif">Period From #form.periodfrom# To #form.periodto#</font></div></td>
				</tr>
			</cfif>
			<cfif form.agentfrom neq "" and form.agentto neq "">
				<tr>
					<td colspan="11"><div align="center"><font size="1.5" face="Arial, Helvetica, sans-serif">#getgeneral.lAGENT# From #form.agentfrom# To #form.agentto#</font></div></td>
				</tr>
			</cfif>
			<cfif form.locationfrom neq "" and form.locationto neq "">
				<tr>
					<td colspan="11"><div align="center"><font size="1.5" face="Arial, Helvetica, sans-serif">Location From #form.locationfrom# To #form.locationto#</font></div></td>
				</tr>
			</cfif>
             <cfif form.projectfrom neq "" and form.projectto neq "">
			<tr>
					<td colspan="11"><div align="center"><font size="1.5" face="Arial, Helvetica, sans-serif">Project From #form.projectfrom# To #form.projectto#</font></div></td>
				</tr>
	</cfif> 
	<cfif form.jobfrom neq "" and form.jobto neq "">
    <tr>
					<td colspan="11"><div align="center"><font size="1.5" face="Arial, Helvetica, sans-serif">Job From #form.Jobfrom# To #form.Jobto#</font></div></td>
				</tr>

    </cfif>
			<tr>
				<td colspan="4"><font size="1.5" face="Arial, Helvetica, sans-serif">#getgeneral.compro#</font></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td colspan="5"><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
			</tr>
		</cfoutput>
			<tr>
				<td colspan="13"><hr></td>
			</tr>
			<tr>
				<td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Refno</strong></font></div></td>

                
				<td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Date</strong></font></div></td>
                <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Issue/PO No</strong></font></div></td>
				<td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Cust No</strong></font></div></td>
				<td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Name</strong></font></div></td>
				<td><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Amount</strong></font></div></td>
				
				<td><div align="center"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>
						Created By
					</strong></font></div>
				</td>

			</tr>
			<tr>
				<td colspan="13"><hr></td>
			</tr>
		
			<cfoutput query="gettran">
				<cfif currrate neq "">
					<cfset xcurrrate = currrate>
				<cfelse>
					<cfset xcurrrate = 1>
				</cfif>
		
				<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
					<td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">
					<cfif url.trancode eq "rc" or url.trancode eq "DO" or url.trancode eq "INV" or url.trancode eq "CS" or url.trancode eq "QUO" or url.trancode eq "PO" or url.trancode eq "CN" or url.trancode eq "DN" or url.trancode eq "PR" or url.trancode eq "SAM">
                    <a href="costingreport2.cfm?type=#url.trancode#&refno=#gettran.refno#">#gettran.refno#</a>
					<cfelse>
                    #gettran.refno#
					</cfif></font></div></td>
                    
					<td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">#dateformat(wos_date,"dd-mm-yy")#</font></div></td>
                    <td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">#pono#</font></div></td>
					<td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">#custno#</font></div></td>
					<cfquery datasource="#dts#" name="getcust">
						Select name, currcode from #title1# where custno='#custno#'
					</cfquery>
					<td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">#name#</font></div></td>
		
					<cfif url.trancode neq "TR">
						<cfset xamt = val(gettran.invgross)>
						<cfset xdisc = val(gettran.discount)>
                        <cfset xnet = val(gettran.net)>
						<cfset xtax = val(gettran.tax)>
						<cfset xgrand = val(gettran.grand)>
						<cfset xcurrrate = val(gettran.currrate)>
					<cfelse>
						<cfset xamt = val(gettran.invgross) / 2>
						<cfset xdisc = val(gettran.discount) / 2>
                        <cfset xnet = val(gettran.net) / 2>
						<cfset xtax = val(gettran.tax) / 2>
						<cfset xgrand = val(gettran.grand) / 2>
						<cfset xcurrrate = val(gettran.currrate)>
					</cfif>	
					
					<td nowrap><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif">#numberformat(xamt,",.__")#</font></div></td>
		
					<cfif xcurrrate eq "1">
						<td><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif">-</font></div></td>
					<cfelse>
						<cfif gettran.grand_bil neq "">
							<cfif url.trancode neq "TR">
								<cfset xfcamt = val(gettran.grand_bil)>
							<cfelse>
								<cfset xfcamt = val(gettran.grand_bil) / 2>
							</cfif>
						</cfif>
						<td nowrap><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif">#getcust.currcode# #numberformat(xfcamt,stDecl_UPrice)#</font></div></td>
						<cfset totalfcamt = totalfcamt + xfcamt>
					</cfif>
					<td><div align="center"><font size="1.5" face="Arial, Helvetica, sans-serif">
							#userid#
						</font></div>
					</td>
				
				</tr>
				<cfset totalamt = totalamt + numberformat(xamt,".__")>				
				<cfset totaldisc = totaldisc + numberformat(xdisc,".__")>
                <cfset totalnet = totalnet + numberformat(xnet,".__")>
				<cfset totaltax = totaltax + numberformat(xtax,".__")>
				<cfset totalgrand = totalgrand + numberformat(xgrand,".__")>
			</cfoutput>
			<tr>
				<td colspan="13"><hr></td>
			</tr>
			<tr>
				<td></td>
				<td></td>
				<td></td>
             
<cfoutput>
				<td><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Total:</strong></font></div></td>
				<td><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>#numberformat(totalamt,",.__")#</strong></font></div></td>
				<cfif lcase(HcomID) eq "mhca_i"><td><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif"></font></div></td></cfif>
				<td><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>#numberformat(totalfcamt,",.__")#</strong></font></div></td>
				</cfoutput>
				<td></td>
			</tr>
		</table>
		
		<br><br>
		<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
		<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
		</body>
		</html>