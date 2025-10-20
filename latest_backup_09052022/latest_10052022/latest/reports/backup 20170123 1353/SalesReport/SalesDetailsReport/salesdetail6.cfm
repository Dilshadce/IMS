
<cfset subsales = 0>
<cfset subdiscount = 0>
<cfset subtax = 0>
<cfset subgrand = 0>
<cfset subvoucher = 0>
<cfset subroundadj = 0>
<cfset submcharge = 0>


<cfquery name="getgeneral" datasource="#dts#">
	select compro,lastaccyear,agentlistuserid,ddllocation from gsetup
</cfquery>

<cfquery name="getgsetup2" datasource='#dts#'>
  Select * from gsetup2
</cfquery>


<cfif isdefined('form.locationfrom') and isdefined('form.locationto')>
<cfif form.locationfrom neq "" and form.locationto neq "">
<cfquery name="getalllocation" datasource='#dts#'>
select refno from ictran where location >='#form.locationfrom#' and location <= '#form.locationto#'
</cfquery>
<cfset billlocation = valuelist(getalllocation.refno)>
			</cfif>
</cfif>

    
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
    
<cfset grouptotal=0>
<cfset catetotal=0>
<cfset itemtotal=0>
<cfset billtotal=0>
<cfset agenttotal=0>
    
		<html>
		<head>
		<title>Cash Sales Summary Report</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<link href="../../../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
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

		<cfquery name="getdata" datasource="#dts#">
			select * from artran
			where type in ('CS','INV') and (void = '' or void is null) and cs_pm_vouc <>0
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            
            <cfif form.locationfrom neq "" and form.locationto neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billlocation#">)
			</cfif>
            
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
			</cfif>
            <cfif url.alown eq 1>
					<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
					</cfif>
					<cfelse>
					<cfif Huserloc neq "All_loc">
					and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
					</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			<cfif form.counterfrom neq "">
			and counter ='#form.counterfrom#'
			</cfif>
            order by wos_date
		</cfquery>
        
        <cfquery name="getdata2" datasource="#dts#">
			select sum(cs_pm_vouc) as vouc,rem13 from artran
			where type in ('CS','INV') and (void = '' or void is null) and cs_pm_vouc <>0
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            
            <cfif form.locationfrom neq "" and form.locationto neq "">
			and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billlocation#">)
			</cfif>
            
            <cfif form.userfrom neq "" and form.userto neq "">
			and userid >='#form.userfrom#' and userid <= '#form.userto#'
			</cfif>
            <cfif url.alown eq 1>
					<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
					</cfif>
					<cfelse>
					<cfif Huserloc neq "All_loc">
					and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
					</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
			<cfelse>
			and wos_date > #getgeneral.lastaccyear#
			</cfif>
			<cfif form.counterfrom neq "">
			and counter ='#form.counterfrom#'
			</cfif>
            group by rem13
            order by wos_date
		</cfquery>
        
        

		<cfoutput>
		<table width="100%" style="font-size:11px; border-width:thin;" cellpadding="0" cellspacing="0" >
        	<tr>
				<td colspan="100%"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>#getgeneral.ddllocation#</strong></font></div></td>
			</tr>
			<tr>
				<td colspan="100%"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>Daily Checkout Report</strong></font></div></td>
			</tr>
            <tr>
				<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">Printing : #dateformat(now(),'DD/MM/YYYY')# #timeformat(now(),'HH:MM')#</font></div></td>
			</tr>
            <tr>
				<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">Counter : #getgeneral.ddllocation#</font></div></td>
			</tr>
            <tr>
				<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">Casher : #huserid#</font></div></td>
			</tr>
			<cfif form.datefrom neq "" and form.dateto neq "">
				<tr>
					<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">#form.datefrom# - #form.dateto#</font></div></td>
				</tr>
			</cfif>
			
			<tr>
				<td colspan="100%"><hr></td>
			</tr>
            
            <tr>
				<td colspan="4"><font size="2" face="Times New Roman, Times, serif"><strong>Voucher Detail Record</strong></font></td>
			</tr>
			<tr>
				<td colspan="100%"><hr></td>
			</tr>
            <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">DATE</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">REF NO.</font></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">Sales</font></div></td>
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif">Discount</font></div></td>
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif">Tax</font></div></td>
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif">Rounding Adjustment</font></div></td>
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif">Misc Charges</font></div></td>
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif">Grand</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">Voucher</font></div></td>
				<td><div align="center"><font size="2" face="Times New Roman, Times, serif">Voucher Type</font></div></td>
                <td><div align="left"><font size="2" face="Times New Roman, Times, serif">Voucher No</font></div></td>
			</tr>
            <tr>
				<td colspan="100%"><hr></td>
			</tr>
			<cfloop query="getdata">
					<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
                    <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#dateformat(getdata.wos_date,"dd-mm-yyyy")#</font></div></td>
						<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getdata.refno#</font></div></td>
								<td><div align="right">#numberformat(val(getdata.invgross),',_.__')#</div></td>
								<td><div align="right">#numberformat(val(getdata.discount),',_.__')#</div></td>
								<td><div align="right">#numberformat(val(getdata.tax),',_.__')#</div></td>
                                <td><div align="right">#numberformat(val(getdata.roundadj),',_.__')#</div></td>
                                <td><div align="right">#numberformat(val(getdata.m_charge1),',_.__')#</div></td>
                                <td><div align="right">#numberformat(val(getdata.grand),',_.__')#</div></td>
								
                                <td><div align="right">#numberformat(val(getdata.CS_PM_vouc),',_.__')#</div></td>
                                <td><div align="center">#getdata.rem13#</div></td>
                                <td><div align="left">#getdata.rem14#</div></td>
                                
								<cfset subsales = subsales + val(getdata.invgross)>
                                
                                <cfset subdiscount = subdiscount + val(getdata.discount)>
                                
                                <cfset subtax = subtax + val(getdata.tax)>
                                
                                <cfset subroundadj = subroundadj + val(getdata.roundadj)>
                                
                                <cfset submcharge = submcharge + val(getdata.m_charge1)>
                                
                                <cfset subgrand = subgrand + val(getdata.grand)>
                              
                                <cfset subvoucher = subvoucher + val(getdata.CS_PM_vouc)>
							
					</tr>
				</cfloop>
			<tr>
					<td colspan="100%"><hr></td>
				</tr>
				<tr>
                <td></td>
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif">Total:</strong></font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(subsales,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(subdiscount,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(subtax,stDecl_UPrice)#</font></div></td>
                    <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(subroundadj,stDecl_UPrice)#</font></div></td>
                    <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(submcharge,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(subgrand,stDecl_UPrice)#</font></div></td>
                    <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(subvoucher,stDecl_UPrice)#</font></div></td>

				</tr>
				<tr><td colspan="100%"><hr></td></tr>
			<tr>
				<td colspan="100%"><br></td>
			</tr>
            <tr>
				<td colspan="4"><font size="2" face="Times New Roman, Times, serif"><strong>Total Voucher Collected</strong></font></td>
			</tr>
			<tr>
				<td colspan="100%"><hr></td>
			</tr>
           <tr>
            	<td><font size="2" face="Times New Roman, Times, serif">Voucher Type</font></td>
				<td align="right"><font size="2" face="Times New Roman, Times, serif">Amount</font></td>
                
			</tr>
            <tr>
				<td colspan="100%"><hr></td>
			</tr>
            <cfloop query="getdata2">
            <tr>
            <td><font size="2" face="Times New Roman, Times, serif">#getdata2.rem13#</font></td>
			<td align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getdata2.vouc,'.__')#</font></td>
            
            </tr>
            </cfloop>
           <tr>
				<td colspan="100%"><br></td>
			</tr>
            </table>
            </cfoutput>

		
		<br>
		<br>
		<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
		<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
		</body>
		</html>