<cfquery name="getgeneral" datasource="#dts#">
	select 
	compro,
	lastaccyear 
	from gsetup;
</cfquery>

<cfquery name="getgsetup2" datasource='#dts#'>
	select 
	decl_uprice 
	from gsetup2;
</cfquery>

<cfquery name="showcomm" datasource="#dts#">
select * from (
select sum(salesamt) as salesamt,itemno,agenno,brand from (
select 
sum(amt) as salesamt,itemno,agenno 
from 
ictran 
where 
(linecode is null or linecode = "" )
and fperiod <> "99"
and type in ('INV','CS','DN')
<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
and custno between '#form.custfrom#' and '#form.custto#'
</cfif>
<cfif form.datefrom neq "" and form.dateto neq "">
and wos_date between '#lsdateformat(form.datefrom,"yyyy-mm-dd")#' and '#lsdateformat(form.dateto,"yyyy-mm-dd")#'
</cfif>
<cfif form.periodfrom neq "" and form.periodto neq "">
and fperiod between '#form.periodfrom#' and '#form.periodto#'
</cfif>
<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
and itemno between '#form.itemfrom#' and '#form.itemto#'
</cfif>
<cfif form.agentfrom neq "" and form.agentto neq "">
and agenno between '#form.agentfrom#' and '#form.agentto#'
</cfif>
<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
and category between '#form.catefrom#' and '#form.cateto#'
</cfif>
<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
and wos_group between '#form.groupfrom#' and '#form.groupto#'
</cfif>
<cfif form.areafrom neq "" and form.areato neq "">
and area between '#form.areafrom#' and '#form.areato#'
</cfif>
group by itemno,agenno) as a
left join 
(
select brand,itemno as itemno1 from icitem
) as b on a.itemno = b.itemno1 

<cfif form.brandfrom neq "" and form.brandto neq "">
WHERE brand between '#form.brandfrom#' and '#form.brandto#'
</cfif>
group by agenno,brand order by agenno
) as aa

left join
(select brand as brand1, desp from brand)
as bb
on aa.brand = bb.brand1
</cfquery>

<cfquery name="showCNcomm" datasource="#dts#">
select * from (
select 
sum(amt) as cnamt,itemno,agenno 
from 
ictran 
where 
(linecode is null or linecode = "" )
and fperiod <> "99"
and type = "CN"
<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
and custno between '#form.custfrom#' and '#form.custto#'
</cfif>
<cfif form.datefrom neq "" and form.dateto neq "">
and wos_date between '#lsdateformat(form.datefrom,"yyyy-mm-dd")#' and '#lsdateformat(form.dateto,"yyyy-mm-dd")#'
</cfif>
<cfif form.periodfrom neq "" and form.periodto neq "">
and fperiod between '#form.periodfrom#' and '#form.periodto#'
</cfif>
<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
and itemno between '#form.itemfrom#' and '#form.itemto#'
</cfif>
<cfif form.agentfrom neq "" and form.agentto neq "">
and agenno between '#form.agentfrom#' and '#form.agentto#'
</cfif>
<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
and category between '#form.catefrom#' and '#form.cateto#'
</cfif>
<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
and wos_group between '#form.groupfrom#' and '#form.groupto#'
</cfif>
<cfif form.areafrom neq "" and form.areato neq "">
and area between '#form.areafrom#' and '#form.areato#'
</cfif>
group by itemno) as a
left join 
(
select brand,itemno as itemno1 from icitem
) as b on a.itemno = b.itemno1 

<cfif form.brandfrom neq "" and form.brandto neq "">
WHERE brand between '#form.brandfrom#' and '#form.brandto#'
</cfif>
group by agenno,brand order by agenno
</cfquery>

<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
<cfset stDecl_UPrice = ",___.">

<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
	<cfset stDecl_UPrice = stDecl_UPrice & "_">
</cfloop>

<cfoutput>
		<table width="100%" border="0" cellspacing="2" cellpadding="0">
			<tr>
				<td colspan="8" class="title"><div align="center">Agent Product Sales Commission Report</div></td>
			</tr>
			
			<cfif form.periodfrom neq "" and form.periodto neq "">
				<tr>
					<td colspan="8"><div align="center"><font size="2" face="Times New Roman,Times,serif">PERIOD: #form.periodfrom# - #form.periodto#</font></div></td>
				</tr>
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
				<tr>
					<td colspan="9"><div align="center"><font size="2" face="Times New Roman,Times,serif">DATE: #lsdateformat(form.datefrom,"dd/mm/yyyy")# - #lsdateformat(form.dateto,"dd/mm/yyyy")#</font></div></td>
				</tr>
			</cfif>
			<cfif form.agentfrom neq "" and form.agentto neq "">
				<tr>
					<td colspan="8"><div align="center"><font size="2" face="Times New Roman,Times,serif">AGENT: #form.agentfrom# - #form.agentto#</font></div></td>
				</tr>
			</cfif>
			<cfif form.areafrom neq "" and form.areato neq "">
				<tr>
					<td colspan="8"><div align="center"><font size="2" face="Times New Roman,Times,serif">AREA: #form.areafrom# - #form.areato#</font></div></td>
				</tr>
			</cfif>
			<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
				<tr>
					<td colspan="8"><div align="center"><font size="2" face="Times New Roman,Times,serif">CUST_NO: #form.custfrom# - #form.custto#</font></div></td>
				</tr>
			</cfif>
			<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
				<tr>
					<td colspan="8"><div align="center"><font size="2" face="Times New Roman,Times,serif">CATEGORY: #form.catefrom# - #form.cateto#</font></div></td>
				</tr>
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				<tr>
					<td colspan="8"><div align="center"><font size="2" face="Times New Roman,Times,serif">GROUP: #form.groupfrom# - #form.groupto#</font></div></td>
				</tr>
			</cfif>
			<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
				<tr>
					<td colspan="8"><div align="center"><font size="2" face="Times New Roman,Times,serif">ITEM_NO: #form.itemfrom# - #form.itemto#</font></div></td>
				</tr>
			</cfif>
            <cfif trim(form.brandfrom) neq "" and trim(form.brandto) neq "">
				<tr>
					<td colspan="8"><div align="center"><font size="2" face="Times New Roman,Times,serif">BRAND: #form.brandfrom# - #form.brandto#</font></div></td>
				</tr>
			</cfif>
			<tr>
				<td colspan="2"><font size="2" face="Times New Roman,Times,serif"><b>#getgeneral.compro#</b></font></td>
                <td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td colspan="3"><div align="right"><font size="2" face="Times New Roman,Times,serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
			</tr>
			<tr><td colspan="8"><hr></td></tr>
            <tr>
				<th align="left" width="10%"><font size="2" face="Times New Roman,Times,serif">BRAND.</font></th>
				<th align="left" width="32%"><font size="2" face="Times New Roman,Times,serif">DESCRIPTION</font></th>
				<th width="8%"><font size="2" face="Times New Roman,Times,serif">AMOUNT</font></th>
				<th align="right" width="10%"><font size="2" face="Times New Roman,Times,serif">COMM RATE</font></th>
				<th align="right" width="10%"><font size="2" face="Times New Roman,Times,serif">COMM AMT</font></th>
				<th align="right" width="10%"><font size="2" face="Times New Roman,Times,serif">AMT - CN</font></th>
				<th align="right" width="10%"><font size="2" face="Times New Roman,Times,serif">COMM RATE</font></th>
				<th align="right" width="10%"><font size="2" face="Times New Roman,Times,serif">NET COMM AMT</font></th>
			</tr>
			<tr><td colspan="8"><hr></td></tr>
            <cfset agentgroup = "agentagentagent">
            <cfset totamt = 0>
            <cfset totcommamt = 0>
            <cfset totamtcn = 0>
            <cfset totnetcommamt = 0>
            <cfset totgrpamt = 0>
            <cfset totgrpcommamt = 0>
            <cfset totgrpamtcn = 0>
            <cfset totgrpnetcommamt = 0>
            <cfloop query="showcomm">
            <cfif agentgroup eq "agentagentagent">
            <cfset agentgroup = showcomm.agenno>
           <tr>
					<td colspan="8"><font size="2" face="Times New Roman,Times,serif"><u><b>AGENT: #agentgroup#</b></u></font></td>
			</tr>
            <cfelseif showcomm.agenno neq agentgroup>
            <tr><td colspan="8"><hr></td></tr>
            <tr>
            <td><div align="left"><font size="2" face="Times New Roman,Times,serif"><u><b>Total:</b></u></font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman,Times,serif"></font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman,Times,serif"><u><b>#numberformat(totgrpamt,stDecl_UPrice)#</b></u></font></div></td>                       
			<td><div align="right"><font size="2" face="Times New Roman,Times,serif"></font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman,Times,serif"><u><b>#numberformat(totgrpcommamt,stDecl_UPrice)#</b></u></font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman,Times,serif"><u><b>#numberformat(totgrpamtcn,stDecl_UPrice)#</b></u></font></div></td>                          
			<td><div align="right"><font size="2" face="Times New Roman,Times,serif"></font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman,Times,serif"><u><b>#numberformat(totgrpnetcommamt,stDecl_UPrice)#</b></u></font></div></td>
			</tr>
            <tr><td colspan="8"><hr></td></tr>
            
            <cfset agentgroup = showcomm.agenno>
            <cfset totgrpamt = 0>
            <cfset totgrpcommamt = 0>
            <cfset totgrpamtcn = 0>
            <cfset totgrpnetcommamt = 0>
            <tr>
					<td colspan="8"><font size="2" face="Times New Roman,Times,serif"><u><b>AGENT: #agentgroup#</b></u></font></td>
			</tr>
			</cfif>
            
            <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
						<td><div align="left"><font size="2" face="Times New Roman,Times,serif"><cfif showcomm.brand eq "">No Brand<cfelse>#showcomm.brand#</cfif></font></div></td>
						<td><div align="left"><font size="2" face="Times New Roman,Times,serif">#showcomm.desp#</font></div></td>
						<td><div align="right"><font size="2" face="Times New Roman,Times,serif">#numberformat(showcomm.salesamt,stDecl_UPrice)#</font></div></td>
<cfinvoke component="cfc.commission" method="commcal" dts="#dts#" itemno="#showcomm.itemno#" salesamt="#showcomm.salesamt#" agentid="#showcomm.agenno#" returnvariable="finalcomm">                        
						<td><div align="right"><font size="2" face="Times New Roman,Times,serif">#ListGetAt(finalcomm, 1)#</font></div></td>
						<td><div align="right"><font size="2" face="Times New Roman,Times,serif">#numberformat(ListGetAt(finalcomm, 2),stDecl_UPrice)#</font></div></td>
<cfquery name="getcnamt" dbtype="query">
SELECT cnamt from showcncomm WHERE agenno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#showcomm.agenno#"> and brand = <cfqueryparam cfsqltype="cf_sql_varchar" value="#showcomm.brand#">
</cfquery>
<cfset cnamt = val(getcnamt.cnamt)>
<cfset newsalesamt = val(showcomm.salesamt)- cnamt>
						<td><div align="right"><font size="2" face="Times New Roman,Times,serif">#numberformat(newsalesamt,stDecl_UPrice)#</font></div></td>
<cfinvoke component="cfc.commission" method="commcal" dts="#dts#" itemno="#showcomm.itemno#" salesamt="#newsalesamt#" agentid="#showcomm.agenno#" returnvariable="finalcommcn">                          
						<td><div align="right"><font size="2" face="Times New Roman,Times,serif">#ListGetAt(finalcommcn, 1)#</font></div></td>
						<td><div align="right"><font size="2" face="Times New Roman,Times,serif">#numberformat(ListGetAt(finalcommcn, 2),stDecl_UPrice)#</font></div></td>
					</tr>
            <cfset totgrpamt = totgrpamt + val(showcomm.salesamt)>
            <cfset totgrpcommamt = totgrpcommamt + ListGetAt(finalcomm, 2)>
            <cfset totgrpamtcn = totgrpamtcn + newsalesamt>
            <cfset totgrpnetcommamt = totgrpnetcommamt + ListGetAt(finalcommcn, 2)>
            <cfset totamt = totamt + val(showcomm.salesamt)>
            <cfset totcommamt = totcommamt + ListGetAt(finalcomm, 2)>
            <cfset totamtcn = totamtcn + newsalesamt>
            <cfset totnetcommamt = totnetcommamt + ListGetAt(finalcommcn, 2)>
            </cfloop>
            <tr><td colspan="8"><hr></td></tr>
            <tr>
            <td><div align="left"><font size="2" face="Times New Roman,Times,serif"><u><b>Total:</b></u></font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman,Times,serif"></font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman,Times,serif"><u><b>#numberformat(totgrpamt,stDecl_UPrice)#</b></u></font></div></td>                       
			<td><div align="right"><font size="2" face="Times New Roman,Times,serif"></font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman,Times,serif"><u><b>#numberformat(totgrpcommamt,stDecl_UPrice)#</b></u></font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman,Times,serif"><u><b>#numberformat(totgrpamtcn,stDecl_UPrice)#</b></u></font></div></td>                          
			<td><div align="right"><font size="2" face="Times New Roman,Times,serif"></font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman,Times,serif"><u><b>#numberformat(totgrpnetcommamt,stDecl_UPrice)#</b></u></font></div></td>
			</tr>
            <tr><td colspan="8"><hr></td></tr>
            <tr><td colspan="8"><hr></td></tr>
            <tr>
            <td><div align="left"><font size="2" face="Times New Roman,Times,serif"><u><b>Total ALL:</b></u></font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman,Times,serif"></font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman,Times,serif"><u><b>#numberformat(totamt,stDecl_UPrice)#</b></u></font></div></td>                       
			<td><div align="right"><font size="2" face="Times New Roman,Times,serif"></font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman,Times,serif"><u><b>#numberformat(totcommamt,stDecl_UPrice)#</b></u></font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman,Times,serif"><u><b>#numberformat(totamtcn,stDecl_UPrice)#</b></u></font></div></td>                          
			<td><div align="right"><font size="2" face="Times New Roman,Times,serif"></font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman,Times,serif"><u><b>#numberformat(totnetcommamt,stDecl_UPrice)#</b></u></font></div></td>
			</tr>
            <tr><td colspan="8"><hr></td></tr>
                </table>
                
                </cfoutput>
				