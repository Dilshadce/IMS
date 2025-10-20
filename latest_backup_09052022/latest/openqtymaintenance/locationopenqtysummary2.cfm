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
	select cost,compro,lastaccyear 
	from gsetup;
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
		<cfset costingmethod = "Fixed Cost Method">
	</cfcase>
	<cfdefaultcase>
		<cfset costingmethod = "Fixed Cost Method">
	</cfdefaultcase>
</cfswitch>

<cfquery name="getgsetup2" datasource='#dts#'>
  	select * 
	from gsetup2;
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

<body>

<h3 align="center"><font face="Times New Roman, Times, serif">List Location Opening Value</font></h3>
<h4 align="center"><font face="Times New Roman, Times, serif">Calculated by <cfoutput>#costingmethod#</cfoutput></font></h4>

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
        <td><div align="left"><font size="1" face="Times New Roman, Times, serif">No.</font></div></td>
			<td><div align="left"><font size="1" face="Times New Roman, Times, serif">Item No.</font></div></td>
            <td><div align="left"><font size="1" face="Times New Roman, Times, serif">Location</font></div></td>
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
			<cfquery name="getitem" datasource="#dts#">
				select a.location,b.itemno, b.desp,b.despa, b.ucost, b.avcost, a.avcost2, a.locqfield as qtybf from locqdbf as a
                left join (select itemno,desp,despa,ucost,avcost,category,wos_group from icitem where 0=0
                <cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				and wos_group >='#form.groupfrom#' and wos_group <='#form.groupto#'
				</cfif>
                
				<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
				and category >='#form.catefrom#' and category <='#form.cateto#'
				</cfif>
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and itemno >='#form.productfrom#' and itemno <= '#form.productto#'
				</cfif>
                
                )as b on a.itemno=b.itemno
				where 0=0
                <cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				and b.wos_group >='#form.groupfrom#' and b.wos_group <='#form.groupto#'
				</cfif>
                <cfif trim(form.locfrom) neq "" and trim(form.locto) neq "">
				and a.location >='#form.locfrom#' and a.location <='#form.locto#'
				</cfif>
                
				<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
				and b.category >='#form.catefrom#' and b.category <='#form.cateto#'
				</cfif>
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and a.itemno >='#form.productfrom#' and a.itemno <= '#form.productto#'
				</cfif>
                <cfif isdefined('form.include0')>
                <cfelse>
                and a.locqfield <> 0
                </cfif>
				order by a.itemno,a.location
			</cfquery>
			
		
	<cfloop query="getitem">
  		
  		
			<cfset valueqty= (val(getitem.ucost) * val(qtybf))>
			<cfset valuemthave= numberformat(val(getitem.avcost) * val(getitem.qtybf),'.__')>
			<cfset valuemovave= numberformat(val(getitem.avcost2) * val(getitem.qtybf),'.__')>

			<cfset totalqty=totalqty+val(getitem.qtybf)>
			<cfset totalfc = totalfc+valueqty>
			<cfset totalmth = totalmth+valuemthave>
			<cfset totalmov = totalmov+valuemovave>	
		
			
			<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
				<cfoutput>
                <td><div align="left"><font size="1" face="Times New Roman, Times, serif">#i#</font></div></td>
				<td><div align="left"><font size="1" face="Times New Roman, Times, serif">#getitem.itemno#</font></div></td>
                <td><div align="left"><font size="1" face="Times New Roman, Times, serif">#getitem.location#</font></div></td>
				<td><div align="left"><font size="1" face="Times New Roman, Times, serif">#getitem.desp#</font></div></td>
                <td><div align="left"><font size="1" face="Times New Roman, Times, serif">#getitem.despa#</font></div></td>
				<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#numberformat(val(qtybf),",_.___")#</font></div></td>
				<cfswitch expression="#getgeneral.cost#">
					<cfcase value="FIXED,FIFO,LIFO">
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
					<cfcase value="FIXED,FIFO,LIFO">
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
		<tr>
			<td colspan="1"></td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>TOTAL:</strong></font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong><cfoutput>#numberformat(totalqty,",_.__")#</cfoutput></strong></font></div></td>
			<td>&nbsp;</td>
			<cfswitch expression="#getgeneral.cost#">
					<cfcase value="FIXED,FIFO,LIFO">
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

	<cfif getitem.recordcount eq 0>
		<h3>Sorry, No records were found.</h3>
		<cfabort>
	</cfif>
	</table>



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