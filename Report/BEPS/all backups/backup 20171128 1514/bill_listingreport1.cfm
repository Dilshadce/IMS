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
	select * from gsetup
</cfquery>

<cfquery name="getdisplaydetail" datasource="#dts#">
select * from displaysetup
</cfquery>

<cfquery name="getgsetup2" datasource='#dts#'>
	select * from gsetup2
</cfquery>

<cfparam name="ndatefrom" default="">
<cfparam name="ndateto" default="">
<cfparam name="totalamt" default="0">
<cfparam name="totalamt2" default="0">
<cfset tranname=''>
<cfset tranname = getgeneral.linv>
	
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
	select * from assignmentslip where 0=0
    	<cfif trim(form.datefrom) neq "" and trim(form.dateto) neq "">
		and assignmentslipdate between '#ndatefrom#' and '#ndateto#'
		</cfif>
	<cfif trim(form.getfrom) neq "" and trim(form.getto) neq "">
		and custno between '#form.getfrom#' and '#form.getto#'
	</cfif>
	<cfif form.billfrom neq "" and form.billto neq "">
		and refno between '#form.billfrom#' and '#form.billto#'
	</cfif>
	order by refno
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
				<td colspan="100%"><div align="center"><font size="3" face="Arial, Helvetica, sans-serif"><strong>Assignment Slip Listing Report</strong></font></div></td>
			</tr>
			<cfif form.billfrom neq "" and form.billto neq "">
				<tr>
					<td colspan="100%"><div align="center"><font size="1.5" face="Arial, Helvetica, sans-serif">Ref No From #form.billfrom# To #form.billto#</font></div></td>
				</tr>
			</cfif>
			<cfif ndatefrom neq "" and ndateto neq "">
				<tr>
					<td colspan="100%"><div align="center"><font size="1.5" face="Arial, Helvetica, sans-serif">#form.datefrom# - #form.dateto#</font></div></td>
				</tr>
			</cfif>
			
			<tr>
				<td colspan="80%"><font size="1.5" face="Arial, Helvetica, sans-serif">#getgeneral.compro#</font></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td colspan="20%"><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
			</tr>
		</cfoutput>
			<tr>
				<td colspan="100%"><hr></td>
			</tr>
			<tr>
            <td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Ref No</strong></font></div></td>
				<td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Date</strong></font></div></td>
				<td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Cust No</strong></font></div></td>
				<td><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Name</strong></font></div></td>
				<td><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Amount</strong></font></div></td>
				<td><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Employee Cost</strong></font></div></td>
			</tr>
			<tr>
				<td colspan="100%"><hr></td>
			</tr>
			<cfset count=1>
			<cfoutput query="gettran">
		
				<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
					<td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">
                    #gettran.refno#</font></div></td>
					<td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">#dateformat(assignmentslipdate,"dd-mm-yy")#</font></div></td>
					<td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">#custno#</font></div></td>
					<cfquery datasource="#dts#" name="getcust">
						Select name, currcode from #target_arcust# where custno='#custno#'
					</cfquery>
					<td nowrap><div align="left"><font size="1.5" face="Arial, Helvetica, sans-serif">#getcust.name#</font></div></td>
						
					
					<td nowrap><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif">#numberformat(custnet,",.__")#</font></div></td>
                    <td nowrap><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif">#numberformat(selftotal,",.__")#</font></div></td>

		
				<cfset totalamt = totalamt + numberformat(custnet,".__")>
                <cfset totalamt2 = totalamt2 + numberformat(selftotal,".__")>
                <cfset count=count+1>
                </tr>
			</cfoutput>
			<tr>
				<td colspan="100%"><hr></td>
			</tr>
			<tr>
				<td></td>
				<td></td>
				
				<cfoutput>
				<td><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>Total:</strong></font></div></td>
				<td></td>
				<td><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>#numberformat(totalamt,",.__")#</strong></font></div></td>
                <td><div align="right"><font size="1.5" face="Arial, Helvetica, sans-serif"><strong>#numberformat(totalamt2,",.__")#</strong></font></div></td>
				</cfoutput>
				<td></td>
			</tr>
		</table>
		
		<br><br>
		<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
		<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
		</body>
		</html>