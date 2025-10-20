<cfquery name="getgeneral" datasource="#dts#">
	select compro,lastaccyear,agentlistuserid from gsetup
</cfquery>

<cfquery name="getgsetup2" datasource='#dts#'>
	select * from gsetup2
</cfquery>

		<html>
		<head>
		<title>TOP CATEGORY PRODUCT SALES REPORT</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
		<style type="text/css" media="print">
			.noprint { display: none; }
		</style>
		</head>

		<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
		<cfset stDecl_UPrice = ",___.">

		<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
		  <cfset stDecl_UPrice = stDecl_UPrice & "_">
		</cfloop>


		<cfif form.showby eq "qty">
			<cfset msg = "By Sales Quantity">
		<cfelse>
			<cfset msg = "By Sales Value">
		</cfif>

		<cfset totalqty =0>
		<cfset totalamt =0>
		<cfif lcase(HcomID) eq "hyray_i">
        <cfquery name="getcategory" datasource="#dts#">
        select a.itemno,b.category from ictran as a left join (select category,itemno from icitem) as b on a.itemno=b.itemno
			where wos_date > #getgeneral.lastaccyear# and (void = '' or void is null)
           <cfif form.customerfrom neq "">
			and a.custno = '#form.customerfrom#'
			</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and a.fperiod >= '#form.periodfrom#' and a.fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and a.agenno >='#form.agentfrom#' and a.agenno <= '#form.agentto#'
			</cfif>
            <cfif url.alown eq 1>
			<cfif getgeneral.agentlistuserid eq "Y">and ucase(a.agenno) in (SELECT agent FROM icagent WHERE agentlist like "%#ucase(huserid)#%")
            <cfelse>
            and (ucase(a.userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
            </cfif>
            <cfelse>
            <cfif Huserloc neq "All_loc">
            and (a.userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
            </cfif>
            </cfif>
            <cfif form.teamfrom neq "" and form.teamto neq "">
			and a.agenno in(select agent from icagent where team >= '#form.teamfrom#' and team <= '#form.teamto#')
			</cfif>
			<cfif form.areafrom neq "" and form.areato neq "">
			and a.area >='#form.areafrom#' and a.area <='#form.areato#'
			</cfif>
            <cfif form.categoryfrom neq "" and form.categoryto neq "">
			and b.category >='#form.categoryfrom#' and b.category <='#form.categoryto#'
			</cfif>
			group by b.category
            order by b.category
        </cfquery>
        <cfelse>
        <cfquery name="getcategory" datasource="#dts#">
        select itemno,category,desp,sum(qty) as sumqty,sum(amt) as sumamt from ictran 
			where (type = 'INV' or type = 'DN' or type = 'CS') and wos_date > #getgeneral.lastaccyear# and (void = '' or void is null)
           <cfif form.customerfrom neq "" and form.customerto neq "">
			and custno >= '#form.customerfrom#' and custno <= '#form.customerto#'
			</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif url.alown eq 1>
			<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM icagent WHERE agentlist like "%#ucase(huserid)#%")
            <cfelse>
            and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
            </cfif>
            <cfelse>
            <cfif Huserloc neq "All_loc">
            and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
            </cfif>
            </cfif>
            <cfif form.teamfrom neq "" and form.teamto neq "">
			and agenno in(select agent from icagent where team >= '#form.teamfrom#' and team <= '#form.teamto#')
			</cfif>
			<cfif form.areafrom neq "" and form.areato neq "">
			and area >='#form.areafrom#' and area <='#form.areato#'
			</cfif>
            <cfif form.categoryfrom neq "" and form.categoryto neq "">
			and category >='#form.categoryfrom#' and category <='#form.categoryto#'
			</cfif>
			group by category
			<cfif form.showby eq "amt">
			order by sumamt
			<cfelse>
			order by sumqty
			</cfif>
			<cfif url.trantype eq "top">
			desc
			</cfif>
        </cfquery>
        </cfif>
        <cfquery name="getcustname" datasource="#dts#">
        select name from #target_arcust# where custno='#form.customerfrom#'
        </cfquery>

		<body>
		<cfoutput>
		  <table width="100%" border="0" cellspacing="0" cellpadding="2">
			<tr>
				
					<td colspan="7"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong><cfif url.trantype eq "top">TOP CATEGORY PRODUCT SALES REPORT<cfelse>BOTTOM CATEGORY PRODUCT SALES REPORT</cfif></strong></font></div></td>
				
			</tr>
            <cfif form.customerfrom neq "" and form.customerto neq "">
				<tr>
					<td colspan="7"><div align="center"><font size="2" face="Times New Roman, Times, serif">Customer: <cfif lcase(HcomID) eq "hyray_i">#getcustname.name#<cfelse>#form.customerfrom# - #form.customerto#</cfif></font></div></td>
				</tr>
			</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
				<tr>
					<td colspan="7"><div align="center"><font size="2" face="Times New Roman, Times, serif">PERIOD: #form.periodfrom# - #form.periodto#</font></div></td>
				</tr>
			</cfif>
			<cfif form.agentfrom neq "" and form.agentto neq "">
				<tr>
					<td colspan="7"><div align="center"><font size="2" face="Times New Roman, Times, serif">AGENT: #form.agentfrom# - #form.agentto#</font></div></td>
				</tr>
			</cfif>
            <cfif form.teamfrom neq "" and form.teamto neq "">
				<tr>
					<td colspan="7"><div align="center"><font size="2" face="Times New Roman, Times, serif">TEAM: #form.teamfrom# - #form.teamto#</font></div></td>
				</tr>
			</cfif>
			<cfif form.areafrom neq "" and form.areato neq "">
				<tr>
					<td colspan="7"><div align="center"><font size="2" face="Times New Roman, Times, serif">AREA: #form.areafrom# - #form.areato#</font></div></td>
				</tr>
			</cfif>
			<tr>
				<td colspan="3"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td colspan="2"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
			</tr>
			<tr>
				<td colspan="7"><hr></td>
			</tr>
			<tr>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">NO</font></div></td>
				<td></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">ITEM NO.</font></div></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">DESP</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">QTY SOLD</font></div></td>
				<td></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">SALES</font></div></td>
			</tr>
			<tr>
				<td colspan="7"><hr></td>
			</tr>
			<cfloop query="getcategory">
            <cfset subqty=0>
            <cfset subamt=0>
            <tr>
            <td><div align="left"><font size="3" face="Times New Roman, Times, serif"><b><u>#category#</u></b></font></div></td>
            <cfquery name="getcatedesp" datasource="#dts#">
            select desp from iccate where cate='#getcategory.category#'
            </cfquery>
            <td colspan="3"><div align="left"><font size="3" face="Times New Roman, Times, serif"><b><u>#getcatedesp.desp#</u></b></font></div></td>
            </tr>

            
            <cfif lcase(HcomID) eq "hyray_i">
            <cfquery name="getitem" datasource="#dts#">
			select (ifnull(bb.sumqty,0)-ifnull(cc.sumqty,0)) as sumqty,aa.itemno,aa.desp,(ifnull(bb.sumamt,0)-ifnull(cc.sumamt,0)) as sumamt from
            (select a.itemno, a.desp, sum(a.qty) as sumqty, sum(a.amt) as sumamt from ictran as a left join (select category,itemno from icitem) as b on a.itemno=b.itemno
            	where  wos_date > #getgeneral.lastaccyear# and (void = '' or void is null)
            <cfif form.customerfrom neq "" and form.customerto neq "">
             
             and a.custno = '#form.customerfrom#'
           
			</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and a.fperiod >= '#form.periodfrom#' and a.fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and a.agenno >='#form.agentfrom#' and a.agenno <= '#form.agentto#'
			</cfif>
            <cfif form.teamfrom neq "" and form.teamto neq "">
				and a.agenno in(select agent from icagent where team >= '#form.teamfrom#' and team <= '#form.teamto#')
			</cfif>
            <cfif url.alown eq 1>
			<cfif getgeneral.agentlistuserid eq "Y">and ucase(a.agenno) in (SELECT agent FROM icagent WHERE agentlist like "%#ucase(huserid)#%")
            <cfelse>
            and (ucase(a.userid)='#ucase(huserid)#' or ucase(a.agenno)='#ucase(huserid)#')  
            </cfif>
            <cfelse>
            <cfif Huserloc neq "All_loc">
            and (a.userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
            </cfif>
            </cfif>
            
			<cfif form.areafrom neq "" and form.areato neq "">
			and a.area >='#form.areafrom#' and a.area <='#form.areato#'
			</cfif>
            and b.category='#getcategory.category#'
			group by itemno
			) as aa left join
            (select a.itemno, a.desp, sum(a.qty) as sumqty, sum(a.amt) as sumamt from ictran as a left join (select category,itemno from icitem) as b on a.itemno=b.itemno
            	where (type = 'INV' or type = 'DN' or type = 'CS') and wos_date > #getgeneral.lastaccyear# and (void = '' or void is null)
            <cfif form.customerfrom neq "" and form.customerto neq "">
             
             and a.custno = '#form.customerfrom#'
           
			</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and a.fperiod >= '#form.periodfrom#' and a.fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and a.agenno >='#form.agentfrom#' and a.agenno <= '#form.agentto#'
			</cfif>
            <cfif url.alown eq 1>
			<cfif getgeneral.agentlistuserid eq "Y">and ucase(a.agenno) in (SELECT agent FROM icagent WHERE agentlist like "%#ucase(huserid)#%")
            <cfelse>
            and (ucase(a.userid)='#ucase(huserid)#' or ucase(a.agenno)='#ucase(huserid)#')  
            </cfif>
            <cfelse>
            <cfif Huserloc neq "All_loc">
            and (a.userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
            </cfif>
            </cfif>
            
            <cfif form.teamfrom neq "" and form.teamto neq "">
				and a.agenno in(select agent from icagent where team >= '#form.teamfrom#' and team <= '#form.teamto#')
				</cfif>
			<cfif form.areafrom neq "" and form.areato neq "">
			and a.area >='#form.areafrom#' and a.area <='#form.areato#'
			</cfif>
            and b.category='#getcategory.category#'
			group by itemno
			) as bb on aa.itemno=bb.itemno left join
            (select a.itemno, a.desp, sum(a.qty) as sumqty, sum(a.amt) as sumamt from ictran as a left join (select category,itemno from icitem) as b on a.itemno=b.itemno
            	where (type = 'CN') and wos_date > #getgeneral.lastaccyear# and (void = '' or void is null)
            <cfif form.customerfrom neq "" and form.customerto neq "">
             
             and a.custno = '#form.customerfrom#'
           
			</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and a.fperiod >= '#form.periodfrom#' and a.fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and a.agenno >='#form.agentfrom#' and a.agenno <= '#form.agentto#'
			</cfif>
            
            <cfif url.alown eq 1>
			<cfif getgeneral.agentlistuserid eq "Y">and ucase(a.agenno) in (SELECT agent FROM icagent WHERE agentlist like "%#ucase(huserid)#%")
            <cfelse>
            and (ucase(a.userid)='#ucase(huserid)#' or ucase(a.agenno)='#ucase(huserid)#')  
            </cfif>
            <cfelse>
            <cfif Huserloc neq "All_loc">
            and (a.userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
            </cfif>
            </cfif>
            
            <cfif form.teamfrom neq "" and form.teamto neq "">
				and a.agenno in(select agent from icagent where team >= '#form.teamfrom#' and team <= '#form.teamto#')
				</cfif>
			<cfif form.areafrom neq "" and form.areato neq "">
			and a.area >='#form.areafrom#' and a.area <='#form.areato#'
			</cfif>
            and b.category='#getcategory.category#'
			group by itemno
			) as cc on aa.itemno = cc.itemno
            
            group by aa.itemno
            <cfif form.showby eq "amt">
			order by sumamt
			<cfelse>
			order by sumqty
			</cfif>
			<cfif url.trantype eq "top">
			desc
			</cfif>
		</cfquery>
        
        <cfelse>
        <cfquery name="getitem" datasource="#dts#">
			select itemno, desp, sum(qty) as sumqty, sum(amt) as sumamt from ictran
			where (type = 'INV' or type = 'DN' or type = 'CS') and wos_date > #getgeneral.lastaccyear# and (void = '' or void is null)
            <cfif form.customerfrom neq "" and form.customerto neq "">
             
            and custno >= '#form.customerfrom#' and custno <= '#form.customerto#'
           
			</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif url.alown eq 1>
			<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM icagent WHERE agentlist like "%#ucase(huserid)#%")
            <cfelse>
            and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
            </cfif>
            <cfelse>
            <cfif Huserloc neq "All_loc">
            and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
            </cfif>
            </cfif>
            <cfif form.teamfrom neq "" and form.teamto neq "">
				and agenno in(select agent from icagent where team >= '#form.teamfrom#' and team <= '#form.teamto#')
				</cfif>
			<cfif form.areafrom neq "" and form.areato neq "">
			and area >='#form.areafrom#' and area <='#form.areato#'
			</cfif>
            and category='#getcategory.category#'
			group by itemno
			<cfif form.showby eq "amt">
			order by sumamt
			<cfelse>
			order by sumqty
			</cfif>
			<cfif url.trantype eq "top">
			desc
			</cfif>
		</cfquery>
        </cfif>
				<cfloop query="getitem">
                <cfif getitem.sumqty neq 0>
					<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
						<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.currentrow#.</font></div></td>
						<td></td>
						<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.itemno#</font></div></td>
						<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.desp#</font></div></td>
						<cfset totalqty = totalqty + val(getitem.sumqty)>
                        <cfset subqty= subqty+val(getitem.sumqty)>
           
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getitem.sumqty),"0")#</font></div></td>
						<td></td>
						<cfset totalamt = totalamt + val(getitem.sumamt)>
                         <cfset subamt= subamt+val(getitem.sumamt)>
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getitem.sumamt),stDecl_UPrice)#</font></div></td>
					</tr>
                    </cfif>
				</cfloop>

            <tr>
            <td colspan="100%">
            <hr>
            </td>
            </tr>
            <tr>
            <td colspan="4">&nbsp;</td>
            <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(subqty,"0")#</strong></font></div></td>
            <td></td>
            <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(subamt,",___.__")#</strong></font></div></td>
            </tr>
            </cfloop>
			<tr>
				<td colspan="7"><hr></td>
			</tr>
			<tr>
				<td></td>
				<td></td>
				<td></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>TOTAL:</strong></font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totalqty,"0")#</strong></font></div></td>
				<td></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totalamt,",___.__")#</strong></font></div></td>
			</tr>
		</table>

		<cfif getcategory.recordcount eq 0>
			<h3>Sorry, No records were found.</h3>
		</cfif>
		</cfoutput>
		<br>
		<br>
		<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
		<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
		</body>
		</html>
