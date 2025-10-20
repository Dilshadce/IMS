<html>
<head>
<title>Adjusted Transaction Cost</title>
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
		<td colspan="13"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>Supplier - Item Transacted Price Enquiry</strong></font></div></td>
	</tr>
	<cfif form.periodFrom neq "" and form.periodTo neq "">
		<tr>		
			<td colspan="13"><div align="center"><font size="2" face="Times New Roman, Times, serif">PERIOD: #form.periodFrom# - #form.periodTo#</font></div></td>
		</tr>
	</cfif>
    <cfif trim(form.refNoFrom) neq "" and trim(form.refNoTo) neq "">
		<tr>
			<td colspan="13"><div align="center"><font size="2" face="Times New Roman, Times, serif">Ref No: #form.refNoFrom# - #form.refNoTo#</font></div></td>
		</tr>
	</cfif>
	<cfif trim(form.supplierFrom) neq "" and trim(form.supplierTo) neq "">
		<tr>
			<td colspan="13"><div align="center"><font size="2" face="Times New Roman, Times, serif">SUPP: #form.supplierFrom# - #form.supplierTo#</font></div></td>
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
			<td colspan="13"><div align="center"><font size="2" face="Times New Roman, Times, serif">DATE: #form.datefrom# - #form.dateto#</font></div></td>
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
		
        <tr> 
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">TYPE</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">REFNO</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">ITEM NO.</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">ITEM DESP.</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">QTY</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">COST</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">AMOUNT</font></div></td>
		</tr>
		<tr> 
			<td colspan="10"><hr></td>
		</tr>
        
        <cfquery name="getitem" datasource="#dts#">
			select *
			from ictran
			where <!---wos_date > #getgeneral.lastaccyear# and---> (type='RC' or type='PR') and (void='' or void is null) and brem4='XCOST'
            <cfif trim(form.supplierFrom) neq "" and trim(form.supplierTo) neq "">
			and custno between '#form.supplierFrom#' and '#form.supplierTo#'
			</cfif>
			<cfif form.periodFrom neq "" and form.periodTo neq "">
			and fperiod between '#form.periodFrom#' and '#form.periodTo#'
			</cfif>
			<cfif trim(form.itemFrom) neq "" and trim(form.itemTo) neq "">
			and itemno between '#form.itemFrom#' and '#form.itemTo#'
			</cfif>
            
            <cfif trim(form.refNoFrom) neq "" and trim(form.refNoTo) neq "">
			and refno between '#form.refNoFrom#' and '#form.refNoTo#'
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
			
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.type#</font></div></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.refno#</font></div></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.itemno#</font></div></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.desp#</font></div></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.qty#</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.price,stDecl_UPrice)#</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.amt,stDecl_UPrice)#</font></div></td>
			</tr>
			
			<tr>
				<td></td>
				<td></td>
				<td colspan="2">MISC CHARGE 1</td>
                <td></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfif getitem.qty neq 0>#numberformat(getitem.m_charge1/getitem.qty,',_.__')#<cfelse>#numberformat(getitem.m_charge1,',_.__')#</cfif></font></div></td>
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.m_charge1,',_.__')#</font></div></td>
			</tr>
            <tr>
				<td></td>
				<td></td>
				<td colspan="2">MISC CHARGE 2</td>
                <td></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfif getitem.qty neq 0>#numberformat(getitem.m_charge2/getitem.qty,',_.__')#<cfelse>#numberformat(getitem.m_charge2,',_.__')#</cfif></font></div></td>
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.m_charge2,',_.__')#</font></div></td>
			</tr>
			
            <tr>
				<td></td>
				<td></td>
				<td colspan="2">MISC CHARGE 3</td>
                <td></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfif getitem.qty neq 0>#numberformat(getitem.m_charge3/getitem.qty,',_.__')#<cfelse>#numberformat(getitem.m_charge3,',_.__')#</cfif></font></div></td>
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.m_charge3,',_.__')#</font></div></td>
			</tr>
            <tr>
				<td></td>
				<td></td>
				<td colspan="2">MISC CHARGE 4</td>
                <td></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfif getitem.qty neq 0>#numberformat(getitem.m_charge4/getitem.qty,',_.__')#<cfelse>#numberformat(getitem.m_charge4,',_.__')#</cfif></font></div></td>
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.m_charge4,',_.__')#</font></div></td>
			</tr>
            <tr>
				<td></td>
				<td></td>
				<td colspan="2">MISC CHARGE 5</td>
                <td></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfif getitem.qty neq 0>#numberformat(getitem.m_charge5/getitem.qty,',_.__')#<cfelse>#numberformat(getitem.m_charge5,',_.__')#</cfif></font></div></td>
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.m_charge5,',_.__')#</font></div></td>
			</tr>
            <tr>
				<td></td>
				<td></td>
				<td colspan="2">MISC CHARGE 6</td>
                <td></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfif getitem.qty neq 0>#numberformat(getitem.m_charge6/getitem.qty,',_.__')#<cfelse>#numberformat(getitem.m_charge6,',_.__')#</cfif></font></div></td>
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.m_charge6,',_.__')#</font></div></td>
			</tr>
            <tr>
				<td></td>
				<td></td>
				<td colspan="2">MISC CHARGE 7</td>
                <td></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfif getitem.qty neq 0>#numberformat(getitem.m_charge7/getitem.qty,',_.__')#<cfelse>#numberformat(getitem.m_charge7,',_.__')#</cfif></font></div></td>
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.m_charge7,',_.__')#</font></div></td>
			</tr>
            <tr>
				<td></td>
				<td></td>
				<td colspan="2"></td>
                <td></td>
                <cfif getitem.qty neq 0>
                <cfset mcharge1=getitem.m_charge1/getitem.qty>
                <cfset mcharge2=getitem.m_charge2/getitem.qty>
                <cfset mcharge3=getitem.m_charge3/getitem.qty>
                <cfset mcharge4=getitem.m_charge4/getitem.qty>
                <cfset mcharge5=getitem.m_charge5/getitem.qty>
                <cfset mcharge6=getitem.m_charge6/getitem.qty>
                <cfset mcharge7=getitem.m_charge7/getitem.qty>
                
                </cfif>
                
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.price+mcharge1+mcharge2+mcharge3+mcharge4+mcharge5+mcharge6+mcharge7,',_.__')#</font></div></td>
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.amt+getitem.m_charge1+getitem.m_charge2+getitem.m_charge3+getitem.m_charge4+getitem.m_charge5+getitem.m_charge6+getitem.m_charge7,',_.__')#</font></div></td>
			</tr>
            <tr> 
			<td colspan="10"><hr></td>
		</tr>
		<tr><td><br></td></tr>
		</cfloop>
		
		<cfflush>
</table>
</cfoutput>

<cfif getitem.recordcount eq 0>
	<h4 style="color:red">Sorry, No records were found.</h4>
</cfif> 

<br>
<br>
<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
</body>
</html>