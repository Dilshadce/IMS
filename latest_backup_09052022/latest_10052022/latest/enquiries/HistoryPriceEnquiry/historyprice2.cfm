<html>
<head>
<title>Item - Customer Transacted Price Enquiry</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
<style type="text/css" media="print">
	.noprint { display: none; }
</style>
</head>

<body>
<cfquery name="getgeneral" datasource="#dts#">
	select compro,lastaccyear from gsetup
</cfquery>

<cfquery name="getgsetup2" datasource='#dts#'>
  Select * from gsetup2
</cfquery>

<cfquery name="getmodule" datasource='#dts#'>
  Select * from modulecontrol
</cfquery>

<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
<cfset stDecl_UPrice = ",___.">

<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
  <cfset stDecl_UPrice = stDecl_UPrice & "_">
</cfloop>
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
<cfoutput>
<table width="100%" border="0" cellspacing="0" cellpadding="2">
	<tr> 
		<td colspan="13"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>Customer - Item Transacted Price Enquiry</strong></font></div></td>
	</tr>
	<cfif form.periodFrom neq "" and form.periodTo neq "">
		<tr>
			<td colspan="13"><div align="center"><font size="2" face="Times New Roman, Times, serif">PERIOD: #form.periodFrom# - #form.periodTo#</font></div></td>
		</tr>
	</cfif>
	<cfif trim(form.customerFrom) neq "" and trim(form.customerTo) neq "">
		<tr>
			<td colspan="13"><div align="center"><font size="2" face="Times New Roman, Times, serif">CUST: #form.customerFrom# - #form.customerTo#</font></div></td>
		</tr>
	</cfif>
	<cfif trim(form.itemFrom) neq "" and trim(form.itemTo) neq "">
		<tr>
			<td colspan="13"><div align="center"><font size="2" face="Times New Roman, Times, serif">ITEM.NO: #form.itemFrom# - #form.itemTo#</font></div></td>
		</tr>
	</cfif>
	<cfif form.locationFrom neq "" and form.locationTo neq "">
		<tr>
			<td colspan="13"><div align="center"><font size="2" face="Times New Roman, Times, serif">LOCATION: #form.locationFrom# - #form.locationTo#</font></div></td>
		</tr>
	</cfif>
    <cfif form.datefrom neq "" and form.dateto neq "">
		<tr>
			<td colspan="13"><div align="center"><font size="2" face="Times New Roman, Times, serif">DATE: #dateformat(form.datefrom,"dd/mm/yyyy")# - #dateformat(form.dateto,"dd/mm/yyyy")#</font></div></td>
		</tr>
	</cfif>
	<tr> 
		<td colspan="2"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>  
	  	<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td colspan="5"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
	</tr>
	<tr><td><br></td></tr>
		
	<cfquery name="getcust" datasource="#dts#">
		select a.custno as custno,a.name as name,a.currcode as currcode 
		from #target_arcust# a,ictran b
		where a.custno=b.custno <!---and b.wos_date > #getgeneral.lastaccyear# --->
		and (b.type='INV' or b.type='DN' or b.type='CS' or b.type='CN') and (b.void='' or b.void is null)
		<cfif form.periodFrom neq "" and form.periodTo neq "">
		and b.fperiod between '#form.periodFrom#' and '#form.periodTo#'
		</cfif>
		<cfif trim(form.customerFrom) neq "" and trim(form.customerTo) neq "">
		and a.custno between '#form.customerFrom#' and '#form.customerTo#'
		</cfif>
		<cfif trim(form.itemFrom) neq "" and trim(form.itemTo) neq "">
		and b.itemno between '#form.itemFrom#' and '#form.itemTo#'
		</cfif>
		<cfif form.locationFrom neq "" and form.locationTo neq "">
		and b.location between '#form.locationFrom#' and '#form.locationTo#'
		</cfif>
        <cfif form.datefrom neq "" and form.dateto neq "">
			and b.wos_date between '#ndatefrom#' and '#ndateto#'
		<cfelse>
        <cfif not isdefined('form.includelastyear')>
			and b.wos_date > #getgeneral.lastaccyear#
        </cfif>
		</cfif>
		group by custno order by custno
	</cfquery>

	<cfloop query="getcust">
		<tr>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><b>#getcust.custno#</b></font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><b>#getcust.name#</b></font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><b>#getcust.currcode#</b></font></div></td>
		</tr>
		<tr> 
			<td colspan="11"><hr></td>
		</tr>
		<tr> 
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">PD</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">DATE</font></div></td>
            <cfif getmodule.auto eq '1'>
            <td><div align="left"><font size="2" face="Times New Roman, Times, serif">VEHICLE NUMBER</font></div></td>
            </cfif>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">TYPE</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">REF.NO</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">ITEM</font></div></td>

            <td><div align="left"><font size="2" face="Times New Roman, Times, serif">DESP</font></div></td>
            <cfif (lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjctrial_i")>
            <td><div align="left"><font size="2" face="Times New Roman, Times, serif">Remark</font></div></td>
            </cfif>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">QTY</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">U.M</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">PRICE</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">AMT</font></div></td>
            <td><div align="right"><font size="2" face="Times New Roman, Times, serif">Discount</font></div></td>
		</tr>
		<tr> 
			<td colspan="10"><hr></td>
		</tr>
			
		<cfquery name="getitem" datasource="#dts#">
			select fperiod,wos_date,type,refno,itemno,desp,qty,unit,(price_bil) as price,(amt_bil) as amt,dispec1,dispec2,dispec3
			from ictran
			where <!---wos_date > #getgeneral.lastaccyear# and---> (type='INV' or type='DN' or type='CS' or type='CN') and custno='#getcust.custno#'
			<cfif form.periodFrom neq "" and form.periodTo neq "">
			and fperiod between '#form.periodFrom#' and '#form.periodTo#'
			</cfif>
			<cfif trim(form.itemFrom) neq "" and trim(form.itemTo) neq "">
			and itemno between '#form.itemFrom#' and '#form.itemTo#'
			</cfif>
			<cfif form.locationFrom neq "" and form.locationTo neq "">
			and location between '#form.locationFrom#' and '#form.locationTo#'
			</cfif>
               <cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date between '#ndatefrom#' and '#ndateto#'
		<cfelse>
        <cfif not isdefined('form.includelastyear')>
			and wos_date > #getgeneral.lastaccyear#
        </cfif>
		</cfif>
			order by wos_date
		</cfquery>
	
		<cfloop query="getitem">
        <cfquery name="getvehicleno" datasource="#dts#">
        select rem5 from artran where refno='#getitem.refno#' and type='#getitem.type#'
        </cfquery>
			<tr>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.fperiod#</font></div></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#dateformat(getitem.wos_date,"dd-mm-yyyy")#</font></div></td>
				<cfif getmodule.auto eq '1'>
            	<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getvehicleno.rem5#</font></div></td>
            	</cfif>
                <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.type#</font></div></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.refno#</font></div></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.itemno#</font></div></td>

                <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.desp#</font></div></td>
                <cfif (lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjctrial_i")>
                <cfquery name="getremark11" datasource="#dts#">
                select rem11 from artran where refno='#getitem.refno#' and type='#getitem.type#'
                </cfquery>
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#getremark11.rem11#</font></div></td>
                </cfif>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#getitem.qty#</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#getitem.unit#</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.price,stDecl_UPrice)#</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.amt,stDecl_UPrice)#</font></div></td>
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getitem.dispec1),".__")#+#numberformat(val(getitem.dispec2),".__")#+#numberformat(val(getitem.dispec3),".__")#</font></div></td>
			</tr>
		</cfloop>
		<tr> 
			<td colspan="11"><hr></td>
		</tr>
		<tr><td><br></td></tr>
		<cfflush>
	</cfloop>
</table>
</cfoutput>

<cfif getcust.recordcount eq 0>
	<h4 style="color:red">Sorry, No records were found.</h4>
</cfif> 

<br>
<br>
<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
</body>
</html>