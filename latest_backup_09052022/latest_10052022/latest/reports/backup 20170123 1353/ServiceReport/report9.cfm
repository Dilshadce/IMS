<cfquery name="getgeneral" datasource="#dts#">
	select a.compro,date_format(a.lastaccyear,'%Y-%m-%d') as lastaccyear,concat(',.',repeat('_',b.decl_uprice))as decl_uprice
	from gsetup as a, gsetup2 as b;
</cfquery>

<cfset grandtotal = 0>
<cfset monthtotal = arraynew(1)>


		<cfset stDecl_UPrice = getgeneral.decl_uprice>

<html>
<head>
<title>Product Service By Month Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
<style type="text/css" media="print">
	.noprint { display: none; }
</style>
</head>

<body>
<cfoutput>
<table width="100%" border="0" cellspacing="0" cellpadding="2">
	<tr>
		<td colspan="25"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong> PRODUCTIVITY REPORT BY MONTH REPORT</strong></font></div></td>
	</tr>
    <tr>
      	<td colspan="25"><div align="center"><font size="2" face="Times New Roman, Times, serif">
	  		<cfswitch expression="#form.period#">
				<cfcase value="1">PERIOD 1 - 6</cfcase>
				<cfcase value="2">PERIOD 7 - 12</cfcase>
				<cfcase value="3">PERIOD 13 - 18</cfcase>
                <cfcase value="5">PERIOD #form.Poption#</cfcase>
				<cfdefaultcase>ONE YEAR</cfdefaultcase>
			</cfswitch>
	  	</font></div>
	  	</td>
    </tr>
    
    
    <cfswitch expression="#form.period#">
    <cfcase value="1">
    <cfquery name="getitem" datasource="#dts#">
    select a.*,b.multiagent1,c.multiagent2,d.multiagent3,e.multiagent4,f.multiagent5,g.multiagent6,h.multiagent7,i.multiagent8 from ictran as a 
    left join (select multiagent1,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent1 >='#form.agentfrom#' and multiagent1 <= '#form.agentto#'
		</cfif>

    )as b on b.refno=a.refno 
    
    left join (select multiagent2,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "" >
			and multiagent2 >='#form.agentfrom#' and multiagent2 <= '#form.agentto#'
		</cfif>

    )as c on c.refno=a.refno 
    
    left join (select multiagent3,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent3 >='#form.agentfrom#' and multiagent3 <= '#form.agentto#'
		</cfif>

    )as d on d.refno=a.refno 
    
    left join (select multiagent4,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent4 >='#form.agentfrom#' and multiagent4 <= '#form.agentto#'
		</cfif>

    )as e on e.refno=a.refno 
    
    left join (select multiagent5,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent5 >='#form.agentfrom#' and multiagent5 <= '#form.agentto#'
		</cfif>

    )as f on f.refno=a.refno 
    
    left join (select multiagent6,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent6 >='#form.agentfrom#' and multiagent6 <= '#form.agentto#'
		</cfif>

    )as g on g.refno=a.refno 
    
    left join (select multiagent7,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent7 >='#form.agentfrom#' and multiagent7 <= '#form.agentto#'
		</cfif>

    )as h on h.refno=a.refno 
    
    left join (select multiagent8,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent8 >='#form.agentfrom#' and multiagent8 <= '#form.agentto#'
		</cfif>

    )as i on i.refno=a.refno 
    
    
    
    where fperiod >='01' and fperiod <='06'
    and linecode ='SV'
    <cfif form.billType neq "" >
				and type ='#form.billType#'
				</cfif>
  
			
				<cfif trim(form.servicefrom) neq "" and trim(form.serviceto) neq "">
				and itemno >='#form.servicefrom#' and itemno <= '#form.serviceto#'
				</cfif>
    order by wos_date
    </cfquery>
    </cfcase>
    
    <cfcase value="2">
    <cfquery name="getitem" datasource="#dts#">
    select a.*,b.multiagent1,c.multiagent2,d.multiagent3,e.multiagent4,f.multiagent5,g.multiagent6,h.multiagent7,i.multiagent8
 from ictran as a 
    left join (select multiagent1,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent1 >='#form.agentfrom#' and multiagent1 <= '#form.agentto#'
		</cfif>

    )as b on b.refno=a.refno 
    
    left join (select multiagent2,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "" >
			and multiagent2 >='#form.agentfrom#' and multiagent2 <= '#form.agentto#'
		</cfif>

    )as c on c.refno=a.refno 
    
    left join (select multiagent3,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent3 >='#form.agentfrom#' and multiagent3 <= '#form.agentto#'
		</cfif>

    )as d on d.refno=a.refno 
    
    left join (select multiagent4,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent4 >='#form.agentfrom#' and multiagent4 <= '#form.agentto#'
		</cfif>

    )as e on e.refno=a.refno 
    
    left join (select multiagent5,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent5 >='#form.agentfrom#' and multiagent5 <= '#form.agentto#'
		</cfif>

    )as f on f.refno=a.refno 
    
    left join (select multiagent6,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent6 >='#form.agentfrom#' and multiagent6 <= '#form.agentto#'
		</cfif>

    )as g on g.refno=a.refno 
    
    left join (select multiagent7,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent7 >='#form.agentfrom#' and multiagent7 <= '#form.agentto#'
		</cfif>

    )as h on h.refno=a.refno 
    
    left join (select multiagent8,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent8 >='#form.agentfrom#' and multiagent8 <= '#form.agentto#'
		</cfif>

    )as i on i.refno=a.refno 
    
   
    
    where fperiod >='07' and fperiod <='12'
    and linecode ='SV'
    <cfif form.billType neq "" >
				and type ='#form.billType#'
				</cfif>
   
			
				<cfif trim(form.servicefrom) neq "" and trim(form.serviceto) neq "">
				and itemno >='#form.servicefrom#' and itemno <= '#form.serviceto#'
				</cfif>
    order by wos_date
    </cfquery>
    </cfcase>
    
    <cfcase value="3">
    <cfquery name="getitem" datasource="#dts#">
    select a.*,b.multiagent1,c.multiagent2,d.multiagent3,e.multiagent4,f.multiagent5,g.multiagent6,h.multiagent7,i.multiagent8 from ictran as a 
    left join (select multiagent1,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent1 >='#form.agentfrom#' and multiagent1 <= '#form.agentto#'
		</cfif>

    )as b on b.refno=a.refno 
    
    left join (select multiagent2,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "" >
			and multiagent2 >='#form.agentfrom#' and multiagent2 <= '#form.agentto#'
		</cfif>

    )as c on c.refno=a.refno 
    
    left join (select multiagent3,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent3 >='#form.agentfrom#' and multiagent3 <= '#form.agentto#'
		</cfif>

    )as d on d.refno=a.refno 
    
    left join (select multiagent4,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent4 >='#form.agentfrom#' and multiagent4 <= '#form.agentto#'
		</cfif>

    )as e on e.refno=a.refno 
    
    left join (select multiagent5,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent5 >='#form.agentfrom#' and multiagent5 <= '#form.agentto#'
		</cfif>

    )as f on f.refno=a.refno 
    
    left join (select multiagent6,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent6 >='#form.agentfrom#' and multiagent6 <= '#form.agentto#'
		</cfif>

    )as g on g.refno=a.refno 
    
    left join (select multiagent7,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent7 >='#form.agentfrom#' and multiagent7 <= '#form.agentto#'
		</cfif>

    )as h on h.refno=a.refno 
    
    left join (select multiagent8,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent8 >='#form.agentfrom#' and multiagent8 <= '#form.agentto#'
		</cfif>

    )as i on i.refno=a.refno 
    
   
    
    where fperiod >='13' and fperiod <='18'
    and linecode ='SV'
    <cfif form.billType neq "" >
				and type ='#form.billType#'
				</cfif>
			
				<cfif trim(form.servicefrom) neq "" and trim(form.serviceto) neq "">
				and itemno >='#form.servicefrom#' and itemno <= '#form.serviceto#'
				</cfif>
    order by wos_date
    </cfquery>
    </cfcase>
    
    <cfcase value="4">
    <cfquery name="getitem" datasource="#dts#">
    select a.*,b.multiagent1,c.multiagent2,d.multiagent3,e.multiagent4,f.multiagent5,g.multiagent6,h.multiagent7,i.multiagent8 from ictran as a 
    left join (select multiagent1,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent1 >='#form.agentfrom#' and multiagent1 <= '#form.agentto#'
		</cfif>

    )as b on b.refno=a.refno 
    
    left join (select multiagent2,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "" >
			and multiagent2 >='#form.agentfrom#' and multiagent2 <= '#form.agentto#'
		</cfif>

    )as c on c.refno=a.refno 
    
    left join (select multiagent3,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent3 >='#form.agentfrom#' and multiagent3 <= '#form.agentto#'
		</cfif>

    )as d on d.refno=a.refno 
    
    left join (select multiagent4,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent4 >='#form.agentfrom#' and multiagent4 <= '#form.agentto#'
		</cfif>

    )as e on e.refno=a.refno 
    
    left join (select multiagent5,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent5 >='#form.agentfrom#' and multiagent5 <= '#form.agentto#'
		</cfif>

    )as f on f.refno=a.refno 
    
    left join (select multiagent6,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent6 >='#form.agentfrom#' and multiagent6 <= '#form.agentto#'
		</cfif>

    )as g on g.refno=a.refno 
    
    left join (select multiagent7,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent7 >='#form.agentfrom#' and multiagent7 <= '#form.agentto#'
		</cfif>

    )as h on h.refno=a.refno 
    
    left join (select multiagent8,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent8 >='#form.agentfrom#' and multiagent8 <= '#form.agentto#'
		</cfif>

    )as i on i.refno=a.refno 
    
   
    
    where fperiod >='01' and fperiod <='18'
    and linecode ='SV'
    
    <cfif form.billType neq "" >
				and type ='#form.billType#'
				</cfif>
  
			
				<cfif trim(form.servicefrom) neq "" and trim(form.serviceto) neq "">
				and itemno >='#form.servicefrom#' and itemno <= '#form.serviceto#'
				</cfif>
    order by wos_date
    </cfquery>
    </cfcase>
    
    <cfcase value="5">
    <cfquery name="getitem" datasource="#dts#">
    select a.*,b.multiagent1,c.multiagent2,d.multiagent3,e.multiagent4,f.multiagent5,g.multiagent6,h.multiagent7,i.multiagent8 from ictran as a 
    left join (select multiagent1,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent1 >='#form.agentfrom#' and multiagent1 <= '#form.agentto#'
		</cfif>

    )as b on b.refno=a.refno 
    
    left join (select multiagent2,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "" >
			and multiagent2 >='#form.agentfrom#' and multiagent2 <= '#form.agentto#'
		</cfif>

    )as c on c.refno=a.refno 
    
    left join (select multiagent3,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent3 >='#form.agentfrom#' and multiagent3 <= '#form.agentto#'
		</cfif>

    )as d on d.refno=a.refno 
    
    left join (select multiagent4,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent4 >='#form.agentfrom#' and multiagent4 <= '#form.agentto#'
		</cfif>

    )as e on e.refno=a.refno 
    
    left join (select multiagent5,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent5 >='#form.agentfrom#' and multiagent5 <= '#form.agentto#'
		</cfif>

    )as f on f.refno=a.refno 
    
    left join (select multiagent6,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent6 >='#form.agentfrom#' and multiagent6 <= '#form.agentto#'
		</cfif>

    )as g on g.refno=a.refno 
    
    left join (select multiagent7,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent7 >='#form.agentfrom#' and multiagent7 <= '#form.agentto#'
		</cfif>

    )as h on h.refno=a.refno 
    
    left join (select multiagent8,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent8 >='#form.agentfrom#' and multiagent8 <= '#form.agentto#'
		</cfif>

    )as i on i.refno=a.refno 
    
   
    
    where fperiod = '#form.poption#'
    and linecode ='SV'
    and ((a.agenno >='#form.agentfrom#' and a.agenno <= '#form.agentto#') or (b.multiagent1 >='#form.agentfrom#' and b.multiagent1 <= '#form.agentto#') or (c.multiagent2 >='#form.agentfrom#' and c.multiagent2 <= '#form.agentto#') or (d.multiagent3 >='#form.agentfrom#' and d.multiagent3 <= '#form.agentto#') or (e.multiagent4 >='#form.agentfrom#' and e.multiagent4 <= '#form.agentto#') or (f.multiagent5 >='#form.agentfrom#' and f.multiagent5 <= '#form.agentto#') or (g.multiagent6 >='#form.agentfrom#' and g.multiagent6 <= '#form.agentto#') or (h.multiagent7 >='#form.agentfrom#' and h.multiagent7 <= '#form.agentto#') or (i.multiagent8 >='#form.agentfrom#' and i.multiagent8 <= '#form.agentto#')  )
    <cfif form.billType neq "" >
				and type ='#form.billType#'
				</cfif>
 
			
				<cfif trim(form.servicefrom) neq "" and trim(form.serviceto) neq "">
				and itemno >='#form.servicefrom#' and itemno <= '#form.serviceto#'
				</cfif>
    order by wos_date
    </cfquery>

    </cfcase>
    </cfswitch>
   <cfif form.servicefrom neq "" and form.serviceto neq "">
        <tr>
          	<td colspan="25"><div align="center"><font size="2" face="Times New Roman, Times, serif">Service: #form.servicefrom# - #form.serviceto#</font></div></td>
        </tr>
    </cfif>
  
    <cfif form.agentfrom neq "" and form.agentto neq "">
        <tr>
          	<td colspan="25"><div align="center"><font size="2" face="Times New Roman, Times, serif">AGENT: #form.agentfrom# - #form.agentto#</font></div></td>
        </tr>
    </cfif>

	
    <tr>
      	<td colspan="3"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
      	<td>&nbsp;</td>
      	<td>&nbsp;</td>
      	<td>&nbsp;</td>
      	<td colspan="19"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
    </tr>
    <tr>
      	<td colspan="25"><hr></td>
    </tr>
    <tr>
		<td><font size="2" face="Times New Roman, Times, serif">NO</font></td>
      	<td><font size="2" face="Times New Roman, Times, serif">DATE</font></td>
	  	<td><font size="2" face="Times New Roman, Times, serif">TYPE</font></td>
        <td><font size="2" face="Times New Roman, Times, serif">REF No</font></td>
		<td><font size="2" face="Times New Roman, Times, serif">Customer Name</font></td>
        <td><font size="2" face="Times New Roman, Times, serif">Agent</font></td>
        <td><font size="2" face="Times New Roman, Times, serif">Business</font></td>
        <td><font size="2" face="Times New Roman, Times, serif">Area</font></td>
        <td><font size="2" face="Times New Roman, Times, serif">Hrs Work</font></td>
        <td><font size="2" face="Times New Roman, Times, serif">Remarks</font></td>
	  	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">Amount</font></div></td>
    </tr>
    <tr>
      	<td colspan="25"><hr></td>
    </tr>
<cfset sumqty=0>
	<cfloop query="getitem">
    
    <cfquery name="getbusiness" datasource="#dts#">
    select * from #target_arcust#  where custno = '#getitem.custno#'
    </cfquery>
    
    <cfquery name="getarea" datasource="#dts#">
    select van from artran  where refno = '#getitem.refno#'
    </cfquery>
    <cfif getitem.agenno neq "" and getitem.agenno gte form.agentfrom and getitem.agenno lte form.agentto >
		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
			<td><font size="2" face="Times New Roman, Times, serif">#getitem.currentrow#.</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#dateformat(getitem.wos_date,'DD/MM/YYYY')#</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#getitem.itemno#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.refno#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.name#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#agenno#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getbusiness.business#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getarea.van#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.qty_bil#</font></td>
      
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.brem1# #getitem.brem2# #getitem.brem3# #getitem.brem4#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#lsnumberformat(getitem.amt1_bil,',_.__')#</font></td>
					
		</tr>
         <cfset sumqty = sumqty + getitem.qty_bil>
        </cfif>
        <cfif getitem.multiagent1 neq "" and getitem.multiagent1 gte form.agentfrom and getitem.multiagent1 lte form.agentto >

		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
			<td><font size="2" face="Times New Roman, Times, serif">#getitem.currentrow#.</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#dateformat(getitem.wos_date,'DD/MM/YYYY')#</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#getitem.itemno#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.refno#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.name#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.multiagent1#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getbusiness.business#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getarea.van#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.qty_bil#</font></td>
   
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.brem1# #getitem.brem2# #getitem.brem3# #getitem.brem4#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#lsnumberformat(getitem.amt1_bil,',_.__')#</font></td>
					
		</tr>
 <cfset sumqty = sumqty + getitem.qty_bil>
    </cfif>
    <cfif getitem.multiagent2 neq "" and getitem.multiagent2 gte form.agentfrom and getitem.multiagent2 lte form.agentto >

		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
			<td><font size="2" face="Times New Roman, Times, serif">#getitem.currentrow#.</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#dateformat(getitem.wos_date,'DD/MM/YYYY')#</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#getitem.itemno#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.refno#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.name#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.multiagent2#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getbusiness.business#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getarea.van#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.qty_bil#</font></td>
      
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.brem1# #getitem.brem2# #getitem.brem3# #getitem.brem4#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#lsnumberformat(getitem.amt1_bil,',_.__')#</font></td>
					
		</tr>
 <cfset sumqty = sumqty + getitem.qty_bil>
    </cfif>
         <cfif getitem.multiagent3 neq "" and getitem.multiagent3 gte form.agentfrom and getitem.multiagent3 lte form.agentto >

		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
			<td><font size="2" face="Times New Roman, Times, serif">#getitem.currentrow#.</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#dateformat(getitem.wos_date,'DD/MM/YYYY')#</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#getitem.itemno#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.refno#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.name#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.multiagent3#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getbusiness.business#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getarea.van#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.qty_bil#</font></td>
    
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.brem1# #getitem.brem2# #getitem.brem3# #getitem.brem4#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#lsnumberformat(getitem.amt1_bil,',_.__')#</font></td>
					
		</tr>
 <cfset sumqty = sumqty + getitem.qty_bil>
    </cfif>
     <cfif getitem.multiagent4 neq "" and getitem.multiagent4 gte form.agentfrom and getitem.multiagent4 lte form.agentto >

		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
			<td><font size="2" face="Times New Roman, Times, serif">#getitem.currentrow#.</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#dateformat(getitem.wos_date,'DD/MM/YYYY')#</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#getitem.itemno#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.refno#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.name#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.multiagent4#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getbusiness.business#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getarea.van#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.qty_bil#</font></td>
    
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.brem1# #getitem.brem2# #getitem.brem3# #getitem.brem4#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#lsnumberformat(getitem.amt1_bil,',_.__')#</font></td>
					
		</tr>
 <cfset sumqty = sumqty + getitem.qty_bil>
    </cfif>
     <cfif getitem.multiagent5 neq "" and getitem.multiagent5 gte form.agentfrom and getitem.multiagent5 lte form.agentto >

		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
			<td><font size="2" face="Times New Roman, Times, serif">#getitem.currentrow#.</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#dateformat(getitem.wos_date,'DD/MM/YYYY')#</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#getitem.itemno#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.refno#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.name#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.multiagent5#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getbusiness.business#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getarea.van#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.qty_bil#</font></td>

            <td><font size="2" face="Times New Roman, Times, serif">#getitem.brem1# #getitem.brem2# #getitem.brem3# #getitem.brem4#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#lsnumberformat(getitem.amt1_bil,',_.__')#</font></td>
					
		</tr>
 <cfset sumqty = sumqty + getitem.qty_bil>
    </cfif>
        
         <cfif getitem.multiagent6 neq "" and getitem.multiagent6 gte form.agentfrom and getitem.multiagent6 lte form.agentto >

		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
			<td><font size="2" face="Times New Roman, Times, serif">#getitem.currentrow#.</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#dateformat(getitem.wos_date,'DD/MM/YYYY')#</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#getitem.itemno#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.refno#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.name#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.multiagent6#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getbusiness.business#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getarea.van#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.qty_bil#</font></td>

            <td><font size="2" face="Times New Roman, Times, serif">#getitem.brem1# #getitem.brem2# #getitem.brem3# #getitem.brem4#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#lsnumberformat(getitem.amt1_bil,',_.__')#</font></td>
					
		</tr>
 <cfset sumqty = sumqty + getitem.qty_bil>
    </cfif>
    
     <cfif getitem.multiagent7 neq "" and getitem.multiagent7 gte form.agentfrom and getitem.multiagent7 lte form.agentto >

		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
			<td><font size="2" face="Times New Roman, Times, serif">#getitem.currentrow#.</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#dateformat(getitem.wos_date,'DD/MM/YYYY')#</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#getitem.itemno#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.refno#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.name#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.multiagent7#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getbusiness.business#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getarea.van#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.qty_bil#</font></td>

            <td><font size="2" face="Times New Roman, Times, serif">#getitem.brem1# #getitem.brem2# #getitem.brem3# #getitem.brem4#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#lsnumberformat(getitem.amt1_bil,',_.__')#</font></td>
					
		</tr>
 <cfset sumqty = sumqty + getitem.qty_bil>
    </cfif>
    
     <cfif getitem.multiagent8 neq "" and getitem.multiagent8 gte form.agentfrom and getitem.multiagent8 lte form.agentto >

		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
			<td><font size="2" face="Times New Roman, Times, serif">#getitem.currentrow#.</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#dateformat(getitem.wos_date,'DD/MM/YYYY')#</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#getitem.itemno#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.refno#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.name#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.multiagent8#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getbusiness.business#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getarea.van#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.qty_bil#</font></td>

            <td><font size="2" face="Times New Roman, Times, serif">#getitem.brem1# #getitem.brem2# #getitem.brem3# #getitem.brem4#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#lsnumberformat(getitem.amt1_bil,',_.__')#</font></td>
					
		</tr>
 <cfset sumqty = sumqty + getitem.qty_bil>
    </cfif>
   
	</cfloop>
    
    
	<tr>
    	<td colspan="25"><hr></td>
    </tr>
        <cfif form.agentfrom eq form.agentto>
    <tr>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td colspan="3">Total hrs of work</td>

    <td>#sumqty#</td>

    </tr>
        </cfif>
</table>
</cfoutput>

<cfif getitem.recordcount eq 0>
	<h3>Sorry, No records were found.</h3>
	<cfabort>
</cfif>

<br>
<br>
<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
</body>
</html>