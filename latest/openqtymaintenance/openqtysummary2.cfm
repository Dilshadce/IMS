<html>
<head>
<title>List Opening Value</title>
<link href="../../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
</head>

<cfparam name="i" default="1" type="numeric">
<cfparam name="RCqty" default="0">
<cfparam name="PRqty" default="0">
<cfparam name="DOqty" default="0">
<cfparam name="invqty" default="0">
<cfparam name="CNqty" default="0">
<cfparam name="DNqty" default="0">
<cfparam name="CSqty" default="0">
<cfparam name="ISSqty" default="0">
<cfparam name="OAIqty" default="0">
<cfparam name="OARqty" default="0">
<cfparam name="TRINqty" default="0">
<cfparam name="TROUqty" default="0">
<cfparam name="xucost" default="0.0000000">
<cfparam name="balonhand" default="0">
<cfparam name="lastbalonhand" default="0">
<cfparam name="grandstkval" default="0">
<cfparam name="grandqtybf" default="0">
<cfparam name="grandqtyin" default="0">
<cfparam name="grandqtyout" default="0">
<cfparam name="grandqty" default="0">

<cfquery name="getgeneral" datasource="#dts#">
	SELECT cost,compro,lastaccyear 
	FROM gsetup;
</cfquery>

<cfswitch expression="#getgeneral.cost#">
	<cfcase value="FIXED">
		<cfset costingmethod = "Fixed Cost Method">
	</cfcase>
	<cfcase value="MONTH">
		<cfset costingmethod = "Month Average Method">
	</cfcase>
	<cfcase value="MOVING">
		<cfset costingmethod = "Moving Average Method">
	</cfcase>
    <cfcase value="WEIGHT">
		<cfset costingmethod = "Weight Average Method">
	</cfcase>
	<cfcase value="FIFO">
		<cfset costingmethod = "First In First Out Method">
	</cfcase>
	<cfdefaultcase>
		<cfset costingmethod = "Last In First Out Method">
	</cfdefaultcase>
</cfswitch>

<cfquery name="getgsetup2" datasource='#dts#'>
  	SELECT * 
	FROM gsetup2;
</cfquery>

<cfif lcase(hcomid) eq "gecn_i">
	<cfset iDecl_UPrice = 5>
	<cfset stDecl_UPrice = ",.">
	<cfset iDecl_TPrice = 2>
	<cfset stDecl_TPrice = ",.">
<cfelse>
	<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
	<cfset stDecl_UPrice = ",.">
	<cfset iDecl_TPrice = getgsetup2.Decl_UPrice>
	<cfset stDecl_TPrice = ",.">
</cfif>

<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
  	<cfset stDecl_UPrice = stDecl_UPrice & "_">
</cfloop>

	<cfquery name="getgroup" datasource="#dts#">
		select wos_group, desp from icitem 
		where itemno = itemno
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and category >='#form.catefrom#' and category <='#form.cateto#'
		</cfif>
		<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		and wos_group >='#form.groupfrom#' and wos_group <='#form.groupto#'
		</cfif>
		<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
		and itemno >='#form.productfrom#' and itemno <= '#form.productto#'
		</cfif>
		<cfif isdefined('form.include0')>
        <cfelse>
                and qtybf <> 0
        </cfif>
		group by wos_group order by wos_group
	</cfquery>

<body>


<h3 align="center"><font face="Times New Roman, Times, serif">List Opening Value</font></h3>
<h4 align="center"><font face="Times New Roman, Times, serif">Calculated by <cfoutput>#costingmethod#</cfoutput></font></h4>

<cfif getgeneral.cost neq "FIFO" and getgeneral.cost neq "LIFO">
	
	
	<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0">
	<cfoutput>
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
			<tr>
				<td colspan="100%"><div align="center"><font size="2" face="Times New Roman,Times,serif">Category: #form.catefrom# - #form.cateto#</font></div></td>
			</tr>
		</cfif>
		
		<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
			<tr>
				<td colspan="100%"><div align="center"><font size="2" face="Times New Roman,Times,serif">Group: #form.groupfrom# - #form.groupto#</font></div></td>
			</tr>
		</cfif>
		
		<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
			<tr>
				<td colspan="100%"><div align="center"><font size="2" face="Times New Roman,Times,serif">Item: #form.productfrom# - #form.productto#</font></div></td>
			</tr>
		</cfif>
		
	</cfoutput>
	</table>
	<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0">
		<cfoutput>
		<tr>
      		<td colspan="90%"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
      		<td colspan="10%"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
    	</tr>
		</cfoutput>
    	<tr>
      		<td colspan="100%"><hr></td>
    	</tr>
  		<tr>
			<td><div align="left"><font size="1" face="Times New Roman, Times, serif">Item No.</font></div></td>
			<td><div align="left"><font size="1" face="Times New Roman, Times, serif">Description</font></div></td>
            <td><div align="left"><font size="1" face="Times New Roman, Times, serif">Description 2</font></div></td>
			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">Qty</font></div></td>
				<cfswitch expression="#getgeneral.cost#">
					<cfcase value="FIXED">
						<td><div align="right"><font size="1" face="Times New Roman, Times, serif">Fixed Cost</font></div></td>
					</cfcase>
					<cfcase value="MONTH,MOVING" delimiters=",">
						<td><div align="right"><font size="1" face="Times New Roman, Times, serif">Average Cost</font></div></td>
					</cfcase>
                    <cfcase value="WEIGHT" delimiters=",">
						<td><div align="right"><font size="1" face="Times New Roman, Times, serif">Weight Cost</font></div></td>
					</cfcase>
				</cfswitch>
			
			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">Stock Value ($)</font></div></td>
  		</tr>
	
  		<tr>
      		<td colspan="100%"><hr></td>
    	</tr>
	

		   <cfset totalqty = 0>
			<cfset totalfc = 0>
			<cfset totalmth = 0>
			<cfset totalmov = 0>	
           	<cfset i=1>
		

	<cfloop query="getgroup">
 	 <cfset grandfc = 0>
			<cfset grandmth = 0>
			<cfset grandmov = 0>
			<cfset grandqtybf = 0>
				
			<tr>
				<cfif getgroup.wos_group eq "">
					<td><font size="2" face="Times New Roman, Times, serif"><strong><u>GROUP: No - Grouped</u></strong></font></td>
					<td><font size="2" face="Times New Roman, Times, serif"><strong><u>No - Grouped</u></strong></font></td>
				<cfelse>
					<cfquery name="getgroupname" datasource="#dts#">
						select * from icgroup where wos_group = '#getgroup.wos_group#'
					</cfquery>
					<td><font size="2" face="Times New Roman, Times, serif"><strong><u><cfoutput>GROUP: #getgroup.wos_group#</cfoutput></u></strong></font></td>
					<td><font size="2" face="Times New Roman, Times, serif"><strong><u><cfoutput>#getgroupname.desp#</cfoutput></u></strong></font></td>
				</cfif>
			</tr>
			
			<cfquery name="getitem" datasource="#dts#">
				select b.itemno, b.desp,b.despa, b.qtybf, b.ucost, b.avcost, b.avcost2, sum(b.qtybf) as sumqty from icitem b
				where b.wos_group = '#getgroup.wos_group#'
				<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
				and b.category >='#form.catefrom#' and b.category <='#form.cateto#'
				</cfif>
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and b.itemno >='#form.productfrom#' and b.itemno <= '#form.productto#'
				</cfif>
                <cfif isdefined('form.include0')>
                <cfelse>
                and b.qtybf <> 0
                </cfif>
				group by b.itemno order by b.itemno
			</cfquery>
			
		
	<cfloop query="getitem">
			<!--- 	<cfquery name="getrc" datasource="#dts#">
					select sum(qty) as sumqty, sum(amt) as sumamt from ictran
					where type = 'RC' and itemno = '#getitem.itemno#' and (void = '' or void is null)
					order by itemno
				</cfquery>

				<cfquery name="getpr" datasource="#dts#">
					select sum(qty) as sumqty, sum(amt) as sumamt from ictran
					where type = 'PR' and itemno = '#getitem.itemno#' and (void = '' or void is null)
					order by itemno
				</cfquery> --->
  		
  		
			<cfset valueqty= (val(getitem.ucost) * val(qtybf))>
			<cfset valuemthave= numberformat(val(getitem.avcost) * val(getitem.qtybf),'.__')>
			<cfset valuemovave= numberformat(val(getitem.avcost2) * val(getitem.qtybf),'.__')>
			<cfset grandfc = val(grandfc) + val(valueqty) >
				 <cfset grandqtybf = val(grandqtybf) + val(qtybf)>
			<cfset grandmth =grandmth +val(valuemthave)>
			<cfset grandmov =grandmov +val(valuemovave)>
			<cfset grandqty = grandqty + val(getitem.qtybf)>
			
		
			
			<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
				<cfoutput>
                <td><div align="left"><font size="1" face="Times New Roman, Times, serif">#i#</font></div></td>
				<td><div align="left"><font size="1" face="Times New Roman, Times, serif">#getitem.itemno#</font></div></td>
				<td><div align="left"><font size="1" face="Times New Roman, Times, serif">#getitem.desp#</font></div></td>
                <td><div align="left"><font size="1" face="Times New Roman, Times, serif">#getitem.despa#</font></div></td>
				<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(val(qtybf),",_.___")#</font></div></td>
				<cfswitch expression="#getgeneral.cost#">
					<cfcase value="FIXED">
						<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(val(getitem.ucost),",_._______")#</font></div></td>
					</cfcase>
					<cfcase value="MONTH" delimiters=",">
						<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(val(getitem.avcost),",_._______")#</font></div></td>
					</cfcase>
					<cfcase value="MOVING" delimiters=",">
						<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(val(getitem.avcost2),",_._______")#</font></div></td>
					</cfcase>
                    <cfcase value="WEIGHT" delimiters=",">
						<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(val(getitem.avcost2),",_._______")#</font></div></td>
					</cfcase>
				</cfswitch>
				
				<cfswitch expression="#getgeneral.cost#">
					<cfcase value="FIXED">
						<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(val(valueqty),",_.__")#</font></div></td>
					</cfcase>
					<cfcase value="MONTH" delimiters=",">
						<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(val(valuemthave),",_.__")#</font></div></td>
					</cfcase>
					<cfcase value="MOVING" delimiters=",">
						<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(val(valuemovave),",_.__")#</font></div></td>
					</cfcase>
                    <cfcase value="WEIGHT" delimiters=",">
						<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(val(valuemovave),",_.__")#</font></div></td>
					</cfcase>
				</cfswitch>
				</cfoutput>
			</tr>
			<cfset i=i+1>
  			</cfloop>
            
           
		
	<tr>
      		<td colspan="100%"><hr></td>
    	</tr>
       <!---  <tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">TOTAL:</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(grandstkval,",_.__")#</cfoutput></font></div></td>
		</tr> --->
		<tr>
        	<td>&nbsp;</td>
			<td>&nbsp;</td>
            <td>&nbsp;</td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">GROUP TOTAL:</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(grandqtybf,",_.___")#</cfoutput></font></div></td>
			<td>&nbsp;</td>
			<cfswitch expression="#getgeneral.cost#">
					<cfcase value="FIXED">
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(grandfc,",_.__")#</cfoutput></font></div></td>
					</cfcase>
					<cfcase value="MONTH" delimiters=",">
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(grandmth,",_.__")#</cfoutput></font></div></td>
					</cfcase>
					<cfcase value="MOVING" delimiters=",">
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(grandmov,",_.__")#</cfoutput></font></div></td>
					</cfcase>
                    <cfcase value="WEIGHT" delimiters=",">
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(grandmov,",_.__")#</cfoutput></font></div></td>
					</cfcase>
			</cfswitch>
		</tr>
				<tr><td><br></td></tr>
                <cfset totalqty = totalqty + grandqtybf>
            <cfset totalfc = totalfc + val(grandfc)>
			<cfset totalmth = totalmth + val(grandmth)>
			<cfset totalmov = totalmov + val(grandmov)>
			</cfloop>
            	
            
			<tr>
			
			<td colspan="100%"><hr></td>
		</tr>
		<tr>
			<td colspan="1"></td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>TOTAL:</strong></font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong><cfoutput>#numberformat(totalqty,",_.__")#</cfoutput></strong></font></div></td>
			<td>&nbsp;</td>
			<cfswitch expression="#getgeneral.cost#">
					<cfcase value="FIXED">
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(totalfc,",_.__")#</cfoutput></font></div></td>
					</cfcase>
					<cfcase value="MONTH" delimiters=",">
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(totalmth,",_.__")#</cfoutput></font></div></td>
					</cfcase>
					<cfcase value="MOVING" delimiters=",">
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(totalmov,",_.__")#</cfoutput></font></div></td>
					</cfcase>
                    <cfcase value="WEIGHT" delimiters=",">
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(totalmov,",_.__")#</cfoutput></font></div></td>
					</cfcase>
				</cfswitch></tr>
	  </table>

	<cfif getgroup.recordcount eq 0>
		<h3>Sorry, No records were found.</h3>
		<cfabort>
	</cfif>
	</table>

<!--- FIFO Costing Method --->
<cfelseif getgeneral.cost eq "FIFO">
<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0">
	<cfoutput>
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
			<tr>
				<td colspan="100%"><div align="center"><font size="2" face="Times New Roman,Times,serif">Category: #form.catefrom# - #form.cateto#</font></div></td>
			</tr>
		</cfif>
		
		<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
			<tr>
				<td colspan="100%"><div align="center"><font size="2" face="Times New Roman,Times,serif">Group: #form.groupfrom# - #form.groupto#</font></div></td>
			</tr>
		</cfif>
		
		<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
			<tr>
				<td colspan="100%"><div align="center"><font size="2" face="Times New Roman,Times,serif">Item: #form.productfrom# - #form.productto#</font></div></td>
			</tr>
		</cfif>
		
	</cfoutput>
	</table>
	<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0">
		<cfoutput>
		<tr>
      		<td colspan="3"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
      		<td colspan="2"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
    	</tr>
		</cfoutput>
    	<tr>
      		<td colspan="100%"><hr></td>
    	</tr>
  		<tr>
			<td><div align="left"><font size="1" face="Times New Roman, Times, serif">Item No.</font></div></td>
			<td><div align="left"><font size="1" face="Times New Roman, Times, serif">Description</font></div></td>
            <td><div align="left"><font size="1" face="Times New Roman, Times, serif">Description 2</font></div></td>
			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">Qty</font></div></td>
			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">Last Cost</font></div></td>
			<td><div align="right"><font size="1" face="Times New Roman, Times, serif">Stock Value ($)</font></div></td>
  		</tr>
	
  		<tr>
      		<td colspan="100%"><hr></td>
    	</tr>

			<cfset totalqty = 0>
			<cfset totalfifo = 0>

	<cfloop query="getgroup">
				
			<tr>
				<cfif getgroup.wos_group eq "">
					<td><font size="2" face="Times New Roman, Times, serif"><strong><u>GROUP: No - Grouped</u></strong></font></td>
					<td><font size="2" face="Times New Roman, Times, serif"><strong><u>No - Grouped</u></strong></font></td>
				<cfelse>
					<cfquery name="getgroupname" datasource="#dts#">
						select * from icgroup where wos_group = '#getgroup.wos_group#' 
					</cfquery>
					<td><font size="2" face="Times New Roman, Times, serif"><strong><u><cfoutput>GROUP: #getgroup.wos_group#</cfoutput></u></strong></font></td>
					<td><font size="2" face="Times New Roman, Times, serif"><strong><u><cfoutput>#getgroupname.desp#</cfoutput></u></strong></font></td>
				</cfif>
			</tr>
			
			<cfquery name="getitem" datasource="#dts#">
				select b.itemno, b.desp,b.despa, b.qtybf, sum(b.qtybf) as sumqty from icitem b
				where b.wos_group = '#getgroup.wos_group#'
				<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
				and b.category >='#form.catefrom#' and b.category <='#form.cateto#'
				</cfif>
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and b.itemno >='#form.productfrom#' and b.itemno <= '#form.productto#'
				</cfif>
                <cfif isdefined('form.include0')>
                <cfelse>
                and b.qtybf <> 0
                </cfif>
				group by b.itemno order by b.itemno
			</cfquery>
			
			<cfset valuefifo = 0>
			<cfset lastcost = 0>
			
			<cfquery name="check" datasource="#dts#">
			  	select a.itemno 
				from fifoopq a, icitem b
				where b.wos_group = '#getgroup.wos_group#' and b.itemno = a.itemno 
				<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
				and b.category >='#form.catefrom#' and b.category <='#form.cateto#'
				</cfif>
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and b.itemno >='#form.productfrom#' and b.itemno <= '#form.productto#'
				</cfif>
			</cfquery>
            
        
		
			<cfset grandfifo = 0>
			<cfset grandqtybf = 0>
			
<cfloop query="getitem">
	<cfset valuefifo=0>
	<cfset lastcost=0>
	
	
<cfif check.recordcount gt 0>		

<cfset cntLP = 11>
	
<cfset ffc = "ffc"&"#cntLP#">
<cfset ffq = "ffq"&"#cntLP#">
        <cfquery name="getopq" datasource="#dts#">
				select #ffq# as affq, #ffc# as affc
				from fifoopq 
				where itemno='#itemno#';
		</cfquery>
        
					<cfset lastcost = getopq.affc>
					
	
	<cfloop index="i" from="50" to="11" step="-1">
		
<cfset ffq = "ffq"&"#i#">
<cfset ffc = "ffc"&"#i#">

        <cfquery name="getfifoopq" datasource="#dts#">
				select #ffq# as xffq, #ffc# as xffc
				from fifoopq 
				where itemno='#getitem.itemno#';
		</cfquery>
		    
	<cfset valuefifounit = val(getfifoopq.xffq) * val(getfifoopq.xffc)>

	<cfset valuefifo = valuefifo + valuefifounit>
	   
     </cfloop>
	<!--- <cfset valuefifo = valuefifo + valuefifounit> --->
<cfelse>

 <cfquery name="getfifoopq" datasource="#dts#">
  		select qtybf, ucost as lastcost, itemno, desp, avcost, avcost2,  sum(qtybf) as sumqty
		from icitem 
       where itemno='#itemno#'
		group by itemno order by itemno
  </cfquery>
<cfset lastcost = val(getfifoopq.lastcost)>
  <cfset valuefifo = val(getfifoopq.lastcost) * val(getfifoopq.qtybf)>

  </cfif>

			<cfset grandfifo = grandfifo + valuefifo >	
			<cfset grandqtybf = grandqtybf + val(qtybf)>
			
			
			<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
				<cfoutput>
				<td><div align="left"><font size="1" face="Times New Roman, Times, serif">#itemno#</font></div></td>
				<td><div align="left"><font size="1" face="Times New Roman, Times, serif">#desp#</font></div></td>
                <td><div align="left"><font size="1" face="Times New Roman, Times, serif">#despa#</font></div></td>
				<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(qtybf,",_.___")#</font></div></td>
				<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(lastcost,",_._______")#</font></div></td>
				<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(valuefifo,",_.__")#</font></div></td>
				</cfoutput>
			</tr>

  			</cfloop>
		<tr>
			<td colspan="100%"><hr></td>
		</tr>
		<tr><cfoutput>
			<td>&nbsp;</td>
            <td>&nbsp;</td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">GROUP TOTAL:</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(grandqtybf,",_.___")#</font></div></td>
			<td>&nbsp;</td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(grandfifo,",_.__")#</font></div></td>
			</cfoutput>	
		</tr>
				<tr><td><br></td></tr>
			<cfset totalqty = totalqty + grandqtybf>
			<cfset totalfifo = totalfifo + val(grandfifo)>
			</cfloop>
            
		
			<tr>
			<td colspan="5"><hr></td>
		</tr>
		<tr><cfoutput>
			<td colspan="2"></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>TOTAL:</strong></font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totalqty,",_.___")#</strong></font></div></td>
			<td>&nbsp;</td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totalfifo,",_.__")#</strong></font></div></td>
			</cfoutput></tr>
	  </table>

	<cfif getgroup.recordcount eq 0>
		<h3>Sorry, No records were found.</h3>
		<cfabort>
	</cfif>
	</table>

<!-- LIFO Costing Method -->
<cfelseif getgeneral.cost eq "LIFO">
	<cfset stkvalff=0>
	<cfquery name="getitem" datasource="#dts#">
		select itemno,desp,unit,qtybf 
		from icitem 
		where itemno <> ''
		<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
		and itemno between '#form.productfrom#' and '#form.productto#'
		</cfif>
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and category between '#form.catefrom#' and '#form.cateto#'
		</cfif>
		<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		and wos_group betwwen '#form.groupfrom#' and '#form.groupto#'
		</cfif>
        <cfif isdefined('form.include0')>
                <cfelse>
                and qtybf <> 0
                </cfif>
		order by itemno;
	</cfquery>
	<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0">
	<cfoutput>
		<cfif form.brandfrom neq "" and form.brandto neq "">
			<tr>
				<td colspan="9"><div align="center"><font size="2" face="Times New Roman,Times,serif">Brand: #form.brandfrom# - #form.brandto#</font></div></td>
			</tr>
		</cfif>
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
			<tr>
				<td colspan="9"><div align="center"><font size="2" face="Times New Roman,Times,serif">Category: #form.catefrom# - #form.cateto#</font></div></td>
			</tr>
		</cfif>
		<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
			<tr>
				<td colspan="9"><div align="center"><font size="2" face="Times New Roman,Times,serif">Group: #form.groupfrom# - #form.groupto#</font></div></td>
			</tr>
		</cfif>
		<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
			<tr>
				<td colspan="9"><div align="center"><font size="2" face="Times New Roman,Times,serif">Item: #form.productfrom# - #form.productto#</font></div></td>
			</tr>
		</cfif>
		<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
			<tr>
				<td colspan="9"><div align="center"><font size="2" face="Times New Roman,Times,serif">Supplier: #form.suppfrom# - #form.suppto#</font></div></td>
			</tr>
		</cfif>
		<cfif form.periodfrom neq "" and form.periodto neq "">
			<tr>
				<td colspan="9"><div align="center"><font size="2" face="Times New Roman,Times,serif">Period: #form.periodfrom# - #form.periodto#</font></div></td>
			</tr>
			<tr>
				<td colspan="9"><div align="center"><font size="2" face="Times New Roman,Times,serif">#form.monthfrom# - #form.monthto#</font></div></td>
			</tr>
		</cfif>
	</cfoutput>
	</table>
	<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0">
    	<cfoutput>
		<tr>
        	<td colspan="4"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
        	<td>&nbsp;</td>
        	<td>&nbsp;</td>
        	<td>&nbsp;</td>
        	<td colspan="4"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
      	</tr>
    	</cfoutput>
    	<tr>
      		<td colspan="9"><hr></td>
    	</tr>
    	<tr>
      		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">ITEM NO.</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">ITEM DESCRIPTION</font></div></td>
      		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">UNIT</font></div></td>
      		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">B/F</font></div></td>
      		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">IN</font></div></td>
      		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">OUT</font></div></td>
      		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">QTY</font></div></td>
      		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">LAST COST</font></div></td>
      		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">STK VAL</font></div></td>
    	</tr>
    	<tr>
      		<td colspan="9"><hr></td>
    	</tr>
    	<cfloop query="getitem">
      		<cfset lastbal= 0>
      		<cfset lastin=0>
      		<cfset lastout=0>
      		<cfset lastdo=0>
      		
			<cfif form.periodfrom neq '01'>
        		<cfquery name="lastgetin" datasource="#dts#">
        			select sum(qty)as sumqty 
					from ictran 
					where type in ('RC','CN','OAI','TRIN') and itemno='#itemno#' and (void = '' or void is null)
        			<cfif form.periodfrom neq "" and form.periodto neq "">
          			and fperiod+0 < '#form.periodfrom#'
        			</cfif>
        		</cfquery>
        		
				<cfif lastgetin.sumqty neq "">
          			<cfset lastin = lastgetin.sumqty>
        		</cfif>
        		
				<cfquery name="lastgetout" datasource="#dts#">
        			select sum(qty)as sumqty 
					from ictran 
					where type in ('INV','ISS','DN','TROU','CS','PR','OAR') and itemno='#itemno#' and (void = '' or void is null) 
        			<cfif form.periodfrom neq "" and form.periodto neq "">
          			and fperiod+0 < '#form.periodfrom#' 
        			</cfif>
        		</cfquery>
        		
				<cfif lastgetout.sumqty neq "">
				  	<cfset lastout = lastgetout.sumqty>
				</cfif>
				
				<cfquery name="lastgetdo" datasource="#dts#">
					select sum(qty)as sumqty 
					from ictran 
					where type='DO' and toinv='' and itemno='#itemno#' and (void = '' or void is null)
					<cfif form.periodfrom neq "" and form.periodto neq "">
					and fperiod+0 < '#form.periodfrom#'
					</cfif> 
					group by itemno;
				</cfquery>
				
				<cfif lastgetdo.sumqty neq "">
				  	<cfset lastdo = lastgetdo.sumqty>
				</cfif>
				
				<cfset lastbal = lastin - lastdo - lastout>
			</cfif>
			
			<cfquery name="check" datasource="#dts#">
			  	select itemno 
				from fifoopq 
				where itemno='#getitem.itemno#';
			</cfquery>
			
			<cfset lastcost = 0>
			
			<cfif getitem.qtybf neq "">
				<cfset bfqty = getitem.qtybf + lastbal>
			<cfelse>
				<cfset bfqty = lastbal>
			</cfif>
			
			<cfquery name="getin" datasource="#dts#">
      			select sum(qty) as qty 
				from ictran 
				where itemno='#getitem.itemno#' and type in ('RC','CN','OAI','TRIN') and (void = '' or void is null)
      			<cfif form.periodfrom neq "" and form.periodto neq "">
        		and fperiod+0 <= '#form.periodto#'
			  	</cfif>
			</cfquery>
			
			<cfif getin.qty neq "">
				<cfset inqty = getin.qty>
			<cfelse>
				<cfset inqty = 0>
			</cfif>
			
			<cfquery name="getinnow" datasource="#dts#">
				select sum(qty) as qty 
				from ictran 
				where itemno='#getitem.itemno#' and (void = '' or void is null) and type in ('RC','CN','OAI','TRIN') 
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			  	</cfif>
			</cfquery>
			
			<cfif getinnow.qty neq "">
				<cfset innowqty = getinnow.qty>
			<cfelse>
				<cfset innowqty = 0>
			</cfif>
      
	  		<cfquery name="getdo" datasource="#dts#">
      			select sum(qty) as qty 
				from ictran 
				where itemno='#getitem.itemno#' and type='DO' and toinv='' and (void = '' or void is null)
		  		<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 <= '#form.periodto#' 
		  		</cfif>
		  	</cfquery>
	  
		  	<cfif getdo.qty neq "">
				<cfset doqty = getdo.qty>
			<cfelse>
				<cfset doqty = 0>
		  	</cfif>
			
		  	<cfquery name="getdonow" datasource="#dts#">
		  		select sum(qty) as qty 
				from ictran 
				where itemno='#getitem.itemno#' and type='DO' and toinv='' and (void = '' or void is null)
		  		<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
		  		</cfif>
				group by itemno;
		  	</cfquery>
			
			<cfif getdonow.qty neq "">
        		<cfset donowqty = getdonow.qty>
        	<cfelse>
        		<cfset donowqty = 0>
      		</cfif>
      	
			<cfquery name="getout" datasource="#dts#">
      			select sum(qty) as qty 
				from ictran 
				where itemno='#getitem.itemno#' and type in ('INV','PR','DN','CS','ISS','OAR','TROU') and (void = '' or void is null)
      			<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 <= '#form.periodto#'
				</cfif>
      		</cfquery>
      
		  	<cfif getout.qty neq "">
				<cfset outqty = getout.qty>
			<cfelse>
				<cfset outqty = 0>
			</cfif>
			
			<cfquery name="getoutnow" datasource="#dts#">
      			select sum(qty) as qty 
				from ictran 
				where itemno='#getitem.itemno#' and (void = '' or void is null) and type in ('INV','PR','DN','CS','ISS','OAR','TROU') 
		  		<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 between '#form.periodfrom#' and '#form.periodto#' 
		  		</cfif>
				group by itemno;
		  	</cfquery>
			
			<cfif getoutnow.qty neq "">
        		<cfset outnowqty = getoutnow.qty>
        	<cfelse>
        		<cfset outnowqty = 0>
      		</cfif>
      		
			<cfset ttoutnowqty = outnowqty + donowqty>
		  	<cfset ttoutqty = outqty + doqty>
		  	<cfset balqty =  bfqty + inqty - ttoutqty>
		  	<cfset balnowqty =  bfqty + innowqty - ttoutnowqty>
		  	<cfset fifoqty = 0>
		  	<cfset ttnewffstkval =0>
      		
			<cfquery name="getrc" datasource="#dts#">
      			select qty, amt, amt_bil, price, price_bil 
				from ictran 
				where itemno='#getitem.itemno#'
      			and type='RC' and (void = '' or void is null)
      			<cfif form.periodfrom neq "" and form.periodto neq "">
        		and fperiod+0 <= '#form.periodto#'
      			</cfif>
      			order by trdatetime desc;
      		</cfquery>
			
			<cfif getrc.recordcount gt 0 and check.recordcount gt 0>
        		<cfset totalrcqty = 0>
        		<cfset cnt = 0>
        		
				<cfloop query="getrc">
          			<cfset cnt = cnt + 1>
          			
					<cfif getrc.qty neq "">
            			<cfset rcqty = getrc.qty>
            		<cfelse>
            			<cfset rcqty = 0>
          			</cfif>
          			
					<cfset lastcost = getrc.price>
          			<cfset totalrcqty = totalrcqty + rcqty>
          			
					<cfif totalrcqty gte ttoutqty>
            			<cfset minusqty = totalrcqty - ttoutqty>
            			
						<cfif minusqty gt 0>
              				<cfset stkval = minusqty * lastcost>
              			<cfelse>
              				<cfset stkval = 0>
            		</cfif>
            		<cfbreak>
          		</cfif>
        	</cfloop>
        	
			<cfif totalrcqty gte ttoutqty>
          		<cfset cnt = cnt + 1>
          		<!--- next record --->
          		<cfset newstkval = 0>
          		
				<cfoutput query="getrc" startrow="#cnt#">
            		<cfset lastcost = getrc.price>
            		<cfset newstkval = newstkval + getrc.amt>
          		</cfoutput>
          		
				<cfloop index="i" from="11" to="50">
            		<cfset ffq = "ffq"&"#i#">
            		<cfset ffc = "ffc"&"#i#">
            		
					<cfquery name="getfifoopq" datasource="#dts#">
            			select #ffq# as xffq, #ffc# as xffc 
						from fifoopq 
						where itemno='#getitem.itemno#';
            		</cfquery>
					
            		<cfif getfifoopq.xffq gt 0>
              			<cfset lastcost = getfifoopq.xffc>
            		</cfif>
            		
					<cfset newffstkval = getfifoopq.xffq * getfifoopq.xffc>
            		<cfset ttnewffstkval = ttnewffstkval + newffstkval>
          		</cfloop>
          		
				<cfset totalstkval = stkval + newstkval + ttnewffstkval>
          	<cfelse>
          		<!--- rc less than out --->
          		<cfset ttnewffstkval = 0>
          		<cfset fifoqty = totalrcqty>
          		
				<cfloop index="i" from="11" to="50">
            		<cfset ffq = "ffq"&"#i#">
            		<cfset ffc = "ffc"&"#i#">
            		
					<cfquery name="getfifoopq" datasource="#dts#">
            			select #ffq# as xffq, #ffc# as xffc 
						from fifoopq 
						where itemno='#getitem.itemno#';
            		</cfquery>
					
            		<cfif getfifoopq.xffq gt 0>
              			<cfset lastcost = getfifoopq.xffc>
            		</cfif>
					
					<cfset fifoqty = fifoqty + getfifoopq.xffq>
            		<cfset newffstkval = getfifoopq.xffq * getfifoopq.xffc>
            		<cfset ttnewffstkval = ttnewffstkval + newffstkval>
            		
					<cfif fifoqty gte ttoutqty>
              			<cfset minusfifoqty = fifoqty - ttoutqty>
              			
						<cfif minusfifoqty gt 0>
                			<cfset stkvalff = minusfifoqty * getfifoopq.xffc>
                		<cfelse>
                			<cfset stkvalff = 0>
              			</cfif>
              			
						<cfset fifocnt = i + 1>
              			<cfbreak>
            		</cfif>
          		</cfloop>
          		
				<cfif fifoqty gte ttoutqty>
            		<cfset ttnewffstkval = 0>
            		
					<cfloop index="i" from="#fifocnt#" to="50">
              			<cfset ffq = "ffq"&"#i#">
              			<cfset ffc = "ffc"&"#i#">
              			
						<cfquery name="getfifoopq2" datasource="#dts#">
              				select #ffq# as xffq, #ffc# as xffc 
							from fifoopq 
							where itemno='#getitem.itemno#';
              			</cfquery>
              			
						<cfif getfifoopq2.xffq gt 0>
                			<cfset lastcost = getfifoopq2.xffc>
              			</cfif>
              				
						<cfset newffstkval = getfifoopq2.xffq * getfifoopq2.xffc>
              			<cfset ttnewffstkval = ttnewffstkval + newffstkval>
            		</cfloop>
          		</cfif>
          		
				<cfset totalstkval = stkvalff + ttnewffstkval>
        	</cfif>
        <cfelseif getrc.recordcount eq 0 and check.recordcount gt 0>
        	<cfset ttnewffstkval = 0>
        	<cfset lastcost = 0>
        		
			<cfloop index="i" from="11" to="50">
          		<cfset ffq = "ffq"&"#i#">
          		<cfset ffc = "ffc"&"#i#">
          		
				<cfquery name="getfifoopq2" datasource="#dts#">
          			select #ffq# as xffq, #ffc# as xffc 
					from fifoopq 
					where itemno='#getitem.itemno#';
          		</cfquery>
				
          		<cfif getfifoopq2.xffq gt 0>
            		<cfset lastcost = getfifoopq2.xffc>
          		</cfif>
          		
				<cfset newffstkval = getfifoopq2.xffq * getfifoopq2.xffc>
          		<cfset ttnewffstkval = ttnewffstkval + newffstkval>
        	</cfloop>
        	
			<cfset totalstkval = ttnewffstkval>
        <cfelse>
        	<cfset totalrcqty = 0>
        	<cfset cnt = 0>
        	<cfset stkval = 0>
        	<cfset newstkval = 0>
        	
			<cfif getrc.recordcount gt 0>
          		<cfloop query="getrc">
            		<cfset cnt = cnt + 1>
            		
					<cfif getrc.qty neq "">
              			<cfset rcqty = getrc.qty>
              		<cfelse>
              			<cfset rcqty = 0>
            		</cfif>
            		
					<cfset lastcost = getrc.price>
            		<cfset totalrcqty = totalrcqty + rcqty>
            		
					<cfif totalrcqty gte ttoutqty>
              			<cfset minusqty = totalrcqty - ttoutqty>
              			
						<cfif minusqty gt 0>
                			<cfset stkval = minusqty * getrc.price>
                		<cfelse>
                			<cfset stkval = 0>
              			</cfif>
              			<cfbreak>
            		</cfif>
          		</cfloop>
          		
				<cfif getrc.recordcount gt cnt>
            		<cfset cnt = cnt + 1>
            		<!--- next record --->
            		<cfset newstkval = 0>
            		
					<cfoutput query="getrc" startrow="#cnt#">
              			<cfset lastcost = getrc.price>
              			<cfset newstkval = newstkval + getrc.amt>
            		</cfoutput>
            	<cfelse>
            		<cfset newstkval = 0>
          		</cfif>
        	</cfif>
        	
			<cfset totalstkval = stkval + newstkval>
      	</cfif>
      	<cfoutput>
        	<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
          		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#itemno#</font></div></td>
          		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#desp#</font></div></td>
          		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#unit#</font></div></td>
          		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#qtybf#</font></div></td>
          		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#innowqty#</font></div></td>
          		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#ttoutnowqty#</font></div></td>
          		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#balnowqty#</font></div></td>
          		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(lastcost,",_.__")#</font></div></td>
          		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(totalstkval,",_.__")#</font></div></td>
        	</tr>
			<cfset grandstkval = grandstkval + totalstkval>         
            <cfset grandqtybf =grandqtybf+val(qtybf)>
            <cfset grandqtyin = grandqtyin + val(innowqty)>
            <cfset grandqtyout = grandqtyout + val(ttoutnowqty)>
            <cfset grandqty = grandqty + val(balnowqty)>
      	</cfoutput>
    </cfloop>
	
		<tr>
			<td colspan="9"><hr></td>
		</tr>
		<!--- <tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">TOTAL:</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(grandstkval,",_.__")#</cfoutput></font></div></td>
		</tr> --->
        <tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">TOTAL:</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(grandqtybf,"0")#</cfoutput></font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(grandqtyin,"0")#</cfoutput></font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(grandqtyout,"0")#</cfoutput></font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(grandqty,"0")#</cfoutput></font></div></td>
			<td>&nbsp;</td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(grandstkval,",_.__")#</cfoutput></font></div></td>
		</tr>
	</table>
</cfif>

<br><br>
<div align="right">
	<font size="1" face="Arial, Helvetica, sans-serif">
		<a href="javascript:print()" class="noprint"><u>Print</u></a>
	</font>
</div>
<p class="noprint">
	<font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font>
</p>
</body>
</html>