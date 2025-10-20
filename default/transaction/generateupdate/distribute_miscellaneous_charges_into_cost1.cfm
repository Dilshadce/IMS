<html>
<head>
<title>Distribute Miscellaneous Charges Into Cost</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
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

<cfoutput>
	<table width="100%" border="0" cellspacing="0" cellpadding="2">
		<tr> 
		  	<td colspan="13"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>Distribute Miscellaneous Charges Into Cost</strong></font></div></td>
		</tr>
		<tr>
			<cfif isdefined("form.periodfrom") and form.periodfrom neq "">
				<td colspan="13"><div align="center"><font size="2" face="Times New Roman, Times, serif">PERIOD: #form.periodfrom#</font></div></td>
			</cfif>
		</tr>
		<tr> 
			<td colspan="2"><font size="2" face="Times New Roman, Times, serif"> 
				<cfif getgeneral.compro neq "">
			  	#getgeneral.compro# 
				</cfif>
				</font>
			</td>
		  	<td>&nbsp;</td>
		  	<td>&nbsp;</td>
		  	<td>&nbsp;</td>
		  	<td colspan="8"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
		</tr>
		<tr> 
			<td colspan="13"><hr></td>
		</tr>
		<tr> 
		  	<td><div align="left"><font size="2" face="Times New Roman, Times, serif">TYPE</font></div></td>
		  	<td><div align="left"><font size="2" face="Times New Roman, Times, serif">REF.NO</font></div></td>
	 	 	<td><div align="left"><font size="2" face="Times New Roman, Times, serif">ITEM.NO</font></div></td>
      		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">QTY</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">PRICE</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">AMOUNT</font></div></td>
			
            <td><div align="right"><font size="2" face="Times New Roman, Times, serif">MISC.CHARGE-1</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">MISC.CHARGE-2</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">MISC.CHARGE-3</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">MISC.CHARGE-4</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">MISC.CHARGE-5</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">MISC.CHARGE-6</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">MISC.CHARGE-7</font></div></td>
    	</tr>
    	<tr> 
      		<td colspan="13"><hr></td>
    	</tr>
	<cfif isdefined('form.distriall')>
    
    <cfquery name="selectcost" datasource="#dts#">
		select a.type,a.refno,a.m_charge1,
		(a.m_charge1/(select sum(amt) from ictran where type='RC' and refno=a.refno)) as cost1,
		(a.m_charge2/(select sum(amt) from ictran where type='RC' and refno=a.refno)) as cost2,
		(a.m_charge3/(select sum(amt) from ictran where type='RC' and refno=a.refno)) as cost3,
		(a.m_charge4/(select sum(amt) from ictran where type='RC' and refno=a.refno)) as cost4,
		(a.m_charge5/(select sum(amt) from ictran where type='RC' and refno=a.refno)) as cost5,
		(a.m_charge6/(select sum(amt) from ictran where type='RC' and refno=a.refno)) as cost6,
		(a.m_charge7/(select sum(amt) from ictran where type='RC' and refno=a.refno)) as cost7,
		(a.mc1_bil/(select sum(amt) from ictran where type='RC' and refno=a.refno)) as fcost1,
		(a.mc2_bil/(select sum(amt) from ictran where type='RC' and refno=a.refno)) as fcost2,
		(a.mc3_bil/(select sum(amt) from ictran where type='RC' and refno=a.refno)) as fcost3,
		(a.mc4_bil/(select sum(amt) from ictran where type='RC' and refno=a.refno)) as fcost4,
		(a.mc5_bil/(select sum(amt) from ictran where type='RC' and refno=a.refno)) as fcost5,
		(a.mc6_bil/(select sum(amt) from ictran where type='RC' and refno=a.refno)) as fcost6,
		(a.mc7_bil/(select sum(amt) from ictran where type='RC' and refno=a.refno)) as fcost7 
		from artran a, ictran b 
		where (a.type='RC' and a.refno=b.refno and b.type=a.type)
		<cfif form.periodfrom neq "">
		and b.fperiod='#form.periodfrom#'
		</cfif>
		
		<cfif form.enterreffrom neq "" and enterrefto neq "">
		and b.refno between '#form.enterreffrom#' and '#form.enterrefto#'
		</cfif>
		group by b.refno
	</cfquery>
    
    <cfelse>
	<cfquery name="selectcost" datasource="#dts#">
		select a.type,a.refno,a.m_charge1,
		(a.m_charge1/(select sum(amt) from ictran where brem4='XCOST' and type='RC' and refno=a.refno)) as cost1,
		(a.m_charge2/(select sum(amt) from ictran where brem4='XCOST' and type='RC' and refno=a.refno)) as cost2,
		(a.m_charge3/(select sum(amt) from ictran where brem4='XCOST' and type='RC' and refno=a.refno)) as cost3,
		(a.m_charge4/(select sum(amt) from ictran where brem4='XCOST' and type='RC' and refno=a.refno)) as cost4,
		(a.m_charge5/(select sum(amt) from ictran where brem4='XCOST' and type='RC' and refno=a.refno)) as cost5,
		(a.m_charge6/(select sum(amt) from ictran where brem4='XCOST' and type='RC' and refno=a.refno)) as cost6,
		(a.m_charge7/(select sum(amt) from ictran where brem4='XCOST' and type='RC' and refno=a.refno)) as cost7,
		(a.mc1_bil/(select sum(amt) from ictran where brem4='XCOST' and type='RC' and refno=a.refno)) as fcost1,
		(a.mc2_bil/(select sum(amt) from ictran where brem4='XCOST' and type='RC' and refno=a.refno)) as fcost2,
		(a.mc3_bil/(select sum(amt) from ictran where brem4='XCOST' and type='RC' and refno=a.refno)) as fcost3,
		(a.mc4_bil/(select sum(amt) from ictran where brem4='XCOST' and type='RC' and refno=a.refno)) as fcost4,
		(a.mc5_bil/(select sum(amt) from ictran where brem4='XCOST' and type='RC' and refno=a.refno)) as fcost5,
		(a.mc6_bil/(select sum(amt) from ictran where brem4='XCOST' and type='RC' and refno=a.refno)) as fcost6,
		(a.mc7_bil/(select sum(amt) from ictran where brem4='XCOST' and type='RC' and refno=a.refno)) as fcost7 
		from artran a, ictran b 
		where (a.type='RC' and a.refno=b.refno and b.type=a.type) and (b.brem4='XCOST') 
		<cfif form.periodfrom neq "">
		and b.fperiod='#form.periodfrom#'
		</cfif>
		
		<cfif form.enterreffrom neq "" and enterrefto neq "">
		and b.refno between '#form.enterreffrom#' and '#form.enterrefto#'
		</cfif>
		group by b.refno,b.brem4
	</cfquery>
    </cfif>
	
	<cfloop query="selectcost">
    <cfif isdefined('form.distriall')>
    	<cfquery name="updatecost" datasource="#dts#">
			update ictran a set 
			m_charge1=#val(selectcost.cost1)#*amt,
			m_charge2=#val(selectcost.cost2)#*amt,
			m_charge3=#val(selectcost.cost3)#*amt,
			m_charge4=#val(selectcost.cost4)#*amt,
			m_charge5=#val(selectcost.cost5)#*amt,
			m_charge6=#val(selectcost.cost6)#*amt,
			m_charge7=#val(selectcost.cost7)#*amt,  
			mc1_bil=#val(selectcost.fcost1)#*amt,
			mc2_bil=#val(selectcost.fcost2)#*amt,
			mc3_bil=#val(selectcost.fcost3)#*amt,
			mc4_bil=#val(selectcost.fcost4)#*amt,
			mc5_bil=#val(selectcost.fcost5)#*amt,
			mc6_bil=#val(selectcost.fcost6)#*amt,
			mc7_bil=#val(selectcost.fcost7)#*amt 
			where type='#selectcost.type#' and refno='#selectcost.refno#';
		</cfquery>
    <cfelse>
		<cfquery name="updatecost" datasource="#dts#">
			update ictran a set 
			m_charge1=#val(selectcost.cost1)#*amt,
			m_charge2=#val(selectcost.cost2)#*amt,
			m_charge3=#val(selectcost.cost3)#*amt,
			m_charge4=#val(selectcost.cost4)#*amt,
			m_charge5=#val(selectcost.cost5)#*amt,
			m_charge6=#val(selectcost.cost6)#*amt,
			m_charge7=#val(selectcost.cost7)#*amt,  
			mc1_bil=#val(selectcost.fcost1)#*amt,
			mc2_bil=#val(selectcost.fcost2)#*amt,
			mc3_bil=#val(selectcost.fcost3)#*amt,
			mc4_bil=#val(selectcost.fcost4)#*amt,
			mc5_bil=#val(selectcost.fcost5)#*amt,
			mc6_bil=#val(selectcost.fcost6)#*amt,
			mc7_bil=#val(selectcost.fcost7)#*amt 
			where type='#selectcost.type#' and refno='#selectcost.refno#' and brem4='XCOST';
		</cfquery>
    </cfif>
	</cfloop>
	
    <cfif isdefined('form.distriall')>
    <cfelse>
	<cfquery name="updatecost2" datasource="#dts#">
		update ictran set
		m_charge1=0,mc1_bil=0,
		m_charge2=0,mc2_bil=0,
		m_charge3=0,mc3_bil=0,
		m_charge4=0,mc4_bil=0,
		m_charge5=0,mc5_bil=0,
		m_charge6=0,mc6_bil=0,
		m_charge7=0,mc7_bil=0 
		where type='RC' and brem4='' 
		<cfif form.periodfrom neq "">
		and fperiod='#form.periodfrom#'
		</cfif>
	</cfquery>
	</cfif>
    
    <cfif isdefined('form.distriall')>
    
    <cfquery name="getresult" datasource="#dts#">
		select mc1_bil,mc2_bil,type,refno,itemno,qty,amt,price,m_charge1,m_charge2,m_charge3,m_charge4,m_charge5,m_charge6,m_charge7 from ictran where type='RC'
		<cfif form.periodfrom neq "">
		and fperiod='#form.periodfrom#'
		</cfif>
		
		<cfif form.enterreffrom neq "" and enterrefto neq "">
		and refno between '#form.enterreffrom#' and '#form.enterrefto#'
		</cfif>
	</cfquery>
    
    <cfelse>
	<cfquery name="getresult" datasource="#dts#">
		select mc1_bil,mc2_bil,type,refno,itemno,amt,qty,price,m_charge1,m_charge2,m_charge3,m_charge4,m_charge5,m_charge6,m_charge7 from ictran where type='RC' and brem4='XCOST'
		<cfif form.periodfrom neq "">
		and fperiod='#form.periodfrom#'
		</cfif>
		
		<cfif form.enterreffrom neq "" and enterrefto neq "">
		and refno between '#form.enterreffrom#' and '#form.enterrefto#'
		</cfif>
	</cfquery>
	</cfif>
    
	<cfloop query="getresult">
		<tr>
			<td><div align="left"><font size="1" face="Times New Roman, Times, serif">#getresult.type#</font></div></td>
			<td><div align="left"><font size="1" face="Times New Roman, Times, serif">#getresult.refno#</font></div></td>
			<td><div align="left"><font size="1" face="Times New Roman, Times, serif">#getresult.itemno#</font></div></td>
			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getresult.qty,"0")#</font></div></td>
			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getresult.price,stDecl_UPrice)#</font></div></td>
            <td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getresult.amt,stDecl_UPrice)#</font></div></td>
			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getresult.m_charge1,stDecl_UPrice)#</font></div></td>
			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getresult.m_charge2,stDecl_UPrice)#</font></div></td>
			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getresult.m_charge3,stDecl_UPrice)#</font></div></td>
			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getresult.m_charge4,stDecl_UPrice)#</font></div></td>
			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getresult.m_charge5,stDecl_UPrice)#</font></div></td>
			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getresult.m_charge6,stDecl_UPrice)#</font></div></td>
			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(getresult.m_charge7,stDecl_UPrice)#</font></div></td>
		</tr>
    <cfif isdefined('form.updateitemcost')>
    <cfquery name="updateitemprofilecost" datasource="#dts#">
    update icitem set ucost='#(amt+m_charge1+m_charge2+m_charge3+m_charge4+m_charge5+m_charge6+m_charge7)/qty#' where itemno='#getresult.itemno#'
    </cfquery>
    
    </cfif>
        
        
	</cfloop>
</cfoutput>
</table>

<cfif getresult.recordcount eq 0>
	<h4 style="color:red">Sorry, No records were found.</h4>
</cfif> 

<br>
<br>
<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
</body>
</html>