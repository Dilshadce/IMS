<cfquery name="getgeneral" datasource="#dts#">
	select compro,lastaccyear from gsetup
</cfquery>

<cfquery name="getgsetup2" datasource='#dts#'>
  Select * from gsetup2
</cfquery>

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

		<html>
		<head>
		<title>SUPPLIER ITEM TRANSACTION LISTING REPORT</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<link href="../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
		<style type="text/css" media="print">
			.noprint { display: none; }
		</style>
		</head>
		<body>

		<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
		<cfset stDecl_UPrice = ",___.">

		<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
		  	<cfset stDecl_UPrice = stDecl_UPrice & "_">
		</cfloop>

		<cfoutput>
		<table width="100%" border="0" cellspacing="0" cellpadding="2">
			<tr>
				<td colspan="8"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>Supplier Item Transaction Listing Report</strong></font></div></td>
			</tr>
			<cfif form.periodfrom neq "" and form.periodto neq "">
				<tr>
					<td colspan="8"><div align="center"><font size="2" face="Times New Roman, Times, serif">PERIOD: #form.periodfrom# - #form.periodto#</font></div></td>
				</tr>
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
				<tr>
					<td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">DATE: #dateformat(form.datefrom,"dd/mm/yyyy")# - #dateformat(form.dateto,"dd/mm/yyyy")#</font></div></td>
				</tr>
			</cfif>
			<cfif trim(form.supplierFrom) neq "" and trim(form.supplierTo) neq "">
				<tr>
					<td colspan="8"><div align="center"><font size="2" face="Times New Roman, Times, serif">SUPP_NO: #form.supplierFrom# - #form.supplierTo#</font></div></td>
				</tr>
			</cfif>
			<tr>
				<td colspan="3"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td colspan="6"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
			</tr>
			<tr>
				<td colspan="9"><hr></td>
			</tr>
			<tr>
            	<td><font size="2" face="Times New Roman, Times, serif">DATE</font></td>
                <td><font size="2" face="Times New Roman, Times, serif">TYPE</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">REF NO.</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">ITEM NO.</font></td>
                <td><font size="2" face="Times New Roman, Times, serif">Quantity</font></td>
                <td><font size="2" face="Times New Roman, Times, serif">Price</font></td>
                <td><font size="2" face="Times New Roman, Times, serif">Amount</font></td>
			</tr>
			<tr>
				<td colspan="9"><hr></td>
			</tr>

			<cfset totalinv = 0>
			<cfset totalcs = 0>
			<cfset totaldn = 0>
			<cfset totalcn = 0>
			<cfset total = 0>

			<cfquery name="getcustomer" datasource="#dts#">
				select custno,name,agenno from artran
				where (type = 'PR' or type = 'RC') and (void = '' or void is null)

				<cfif trim(form.supplierFrom) neq "" and trim(form.supplierTo) neq "">
				and custno >='#form.supplierFrom#' and custno <= '#form.supplierTo#'
				</cfif>
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
				and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
				<cfelse>
				and wos_date > #getgeneral.lastaccyear#
				</cfif>
				group by custno order by custno
			</cfquery>

			<cfloop query="getcustomer">
				<cfset subqty = 0>
				<cfset subamt = 0>
                <cfset subpr = 0>
                <cfset subprqty = 0>
				<tr>
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong><u>#getcustomer.currentrow#.CUSTOMER NO: #getcustomer.custno#</u></strong></font></div></td>
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong><u>#getcustomer.name#</u></strong></font></div></td>
					
				</tr>

				<cfquery name="getdata" datasource="#dts#">
					select * from ictran where (type = 'PR' or type = 'RC')
					and custno = '#getcustomer.custno#' and (void = '' or void is null)

					<cfif form.periodfrom neq "" and form.periodto neq "">
					and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
					</cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
					<cfelse>
					and wos_date > #getgeneral.lastaccyear#
					</cfif>
					order by itemno
				</cfquery>

				<cfloop query="getdata">
					<cfset qty = 0>
					<cfset dn = 0>
					<cfset cs = 0>
					<cfset cn = 0>
					<cfset amt = 0>
					<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
                    <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#dateformat(getdata.wos_date,"dd-mm-yyyy")#</font></div></td>
					  <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getdata.type#</font></div></td>
					  <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getdata.refno#</font></div></td>
                      <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getdata.itemno#</font></div></td>
                      <cfif getdata.type eq "RC">
                      <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getdata.qty_bil#</font></div></td>
                      <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#numberformat(getdata.price_bil,",.__")#</font></div></td>
                      <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#numberformat(getdata.amt1_bil,",.__")#</font></div></td>
                      <cfelseif getdata.type eq "PR">
                      <td><div align="left"><font size="2" face="Times New Roman, Times, serif">-#getdata.qty_bil#</font></div></td>
                      <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#numberformat(getdata.price_bil,",.__")#</font></div></td>
                      <td><div align="left"><font size="2" face="Times New Roman, Times, serif">-#numberformat(getdata.amt1_bil,",.__")#</font></div></td>
                      
                      </cfif>
                      
                      <cfif getdata.type eq "RC">
                      <cfset subamt=subamt+getdata.amt1_bil>
                      <cfset subqty=subqty+getdata.qty_bil>
                      <cfelseif getdata.type eq "PR">
                      <cfset subpr=subpr+getdata.amt1_bil>
                      <cfset subprqty=subprqty+getdata.qty_bil>
                      </cfif>
					</tr>
				</cfloop>
				<tr>
					<td colspan="9"><hr></td>
				</tr>
                <cfset subtotal=subamt - subpr>
                <cfset subtotalqty=subqty - subprqty>
				<tr>
					<td></td>
                    <td></td>
					<td><div align="center"><font size="2" face="Times New Roman, Times, serif">TOTAL:</strong></font></div></td>
					<td></td>
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#subtotalqty#</font></div></td>
					<td></td>
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#numberformat(subtotal,",.__")#</font></div></td>

                    
                    
				</tr>
				<tr><td><br></td></tr>
			</cfloop>
			<cfflush>

		  </table>
		</cfoutput>

		<cfif getcustomer.recordcount eq 0>
			<h3>Sorry, No records were found.</h3>
		</cfif>

		<br>
		<br>
		<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
		<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
		</body>
		</html>
