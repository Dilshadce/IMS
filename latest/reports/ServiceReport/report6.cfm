<cfquery name="getgeneral" datasource="#dts#">
	select cost,compro,lastaccyear from gsetup
</cfquery>

<cfif getgeneral.cost eq "FIXED">
	<cfset costingmethod = "Fixed Cost Method">
<cfelseif getgeneral.cost eq "MONTH">
	<cfset costingmethod = "Month Average Method">
<cfelseif getgeneral.cost eq "MOVING">
	<cfset costingmethod = "Moving Average Method">
<cfelseif getgeneral.cost eq "FIFO">
	<cfset costingmethod = "First In First Out Method">
<cfelse>
	<cfset costingmethod = "Last In First Out Method">
</cfif>

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
		<title>Profit Margin By Transaction Report</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<link href = "../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
		<style type="text/css" media="print">
			.noprint { display: none; }
		</style>
		</head>

		<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
		<cfset stDecl_UPrice = ",___.">

		<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
			<cfset stDecl_UPrice = stDecl_UPrice & "_">
		</cfloop>

		<body>
		<cfoutput>
		<table width="100%" border="0" cellspacing="0" cellpadding="2">
			<tr>
				<td colspan="11"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>Print Service Profit Margin - Transactions Report</strong></font></div></td>
			</tr>
			<tr>
				<td colspan="11"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>Calculated by #costingmethod#</strong></font></div></td>
			</tr>
			<cfif form.periodfrom neq "" and form.periodto neq "">
				<tr>
					<td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">PERIOD: #form.periodfrom# - #form.periodto#</font></div></td>
				</tr>
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
				<tr>
					<td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">DATE: #dateformat(form.datefrom,"dd/mm/yyyy")# - #dateformat(form.dateto,"dd/mm/yyyy")#</font></div></td>
				</tr>
			</cfif>
			
			<tr>
				<td colspan="2"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td colspan="2"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
			</tr>
			<tr>
				<td colspan="6"><hr></td>
			</tr>
			<tr>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">TYPE</font></div></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">REF NO</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">AMT</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">COST</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">GROSS PROFIT</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">MARGIN (%)</font></div></td>
			</tr>
			<tr>
				<td colspan="6"><hr></td>
			</tr>

			<cfquery name="gettran" datasource="#dts#"><!---Transaction No--->
				select b.type as type,b.refno as refno, a.servi as itemno,b.linecode as linecode,b.desp as desp from icservi as a left join ictran  as b on a.servi = b.itemno
				where (type = 'INV' or type = 'DN' or type = 'CS') and (void = '' or void is null) and linecode='SV'
				
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and b.fperiod >= '#form.periodfrom#' and b.fperiod <= '#form.periodto#'
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
				and b.wos_date >= '#ndatefrom#' and b.wos_date <= '#ndateto#'
				<cfelse>
				and b.wos_date > #getgeneral.lastaccyear#
				</cfif>
				group by refno order by refno
			</cfquery>

			<cfset totalsales = 0>
			<cfset totalcost = 0>
			<cfset totalprofit = 0>

			<cfloop query="gettran">
				<cfset refno = gettran.refno>
				<cfset sales = 0>
				<cfset cost = 0>
				<cfset profit = 0>

				<cfquery name="getsales" datasource="#dts#">
					select itemno,refno,sum(sercost) as sumcost,sum(amt) as sumamt from ictran
					where linecode='SV' and
					(type = 'INV' or type = 'CS' or type = 'DN') and refno = '#gettran.refno#'
					
			
					<cfif form.periodfrom neq "" and form.periodto neq "">
					and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
					</cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
					<cfelse>
					and wos_date > #getgeneral.lastaccyear#
					</cfif>
					group by refno
				</cfquery>

				<cfset cost = cost + val(getsales.sumcost)>
				<cfset sales = sales + val(getsales.sumamt)>
				<cfset totalcost = totalcost + val(getsales.sumcost)>
				<cfset totalsales = totalsales + val(getsales.sumamt)>
				<cfset profit = sales - cost>
				<cfset totalprofit = totalprofit + profit>

				<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
					<cfif gettran.refno eq "">
						<td><div align="left"><font size="2" face="Times New Roman, Times, serif"></font></div></td>
						<td><div align="left"><font size="2" face="Times New Roman, Times, serif"></font></div></td>
					<cfelse>
<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#gettran.type#</font></div></td>
						<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#gettran.refno#</font></div></td>
						
					</cfif>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#NumberFormat(sales,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#NumberFormat(cost,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#NumberFormat(profit,stDecl_UPrice)#</font></div></td>
					<cfif sales neq 0 and profit neq 0 and sales neq "">
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#NumberFormat(profit / sales * 100,"0.00")#</font></div></td>
					<cfelse>
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#NumberFormat(0,"0.00")#</font></div></td>
					</cfif>
				</tr>
				<cfflush>
			</cfloop>
			<tr>
				<td colspan="6"><hr></td>
			</tr>
			<tr>
				<td><div align="left"></div></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>TOTAL:</strong></font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#NumberFormat(totalsales,",.__")#</strong></font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#NumberFormat(totalcost,",.__")#</strong></font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#NumberFormat(totalprofit,",.__")#</strong></font></div></td>
				<cfif totalsales neq 0 and totalprofit neq 0 and totalsales neq "">
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#NumberFormat(totalprofit / totalsales * 100,"0.00")#</strong></font></div></td>
				<cfelse>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#NumberFormat(0,"0.00")#</strong></font></div></td>
				</cfif>
			</tr>
		</table>

		<cfif gettran.recordcount eq 0>
			<h3>Sorry, No records were found.</h3>
		</cfif>
		</cfoutput>
		<br>
		<br>
		<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
		<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
		</body>
		</html>