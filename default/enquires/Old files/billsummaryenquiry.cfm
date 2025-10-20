<html>
<head>
<title>Bill Summary Report</title>
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
<style type="text/css" media="print">
	.noprint { display: none; }
</style>
</head>

<cfquery name="getgeneral" datasource="#dts#">
	select compro,lastaccyear,projectbybill from gsetup
</cfquery>

<cfquery name="getgsetup2" datasource='#dts#'>
  Select * from gsetup2
</cfquery>

<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
<cfset stDecl_UPrice = ",.">

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

<cfset str=arraynew(1)>

<cfif isdefined("form.purchasereceive")>
	<cfset str[1]="RC">
<cfelse>
	<cfset str[1]=''>
</cfif>
<cfif isdefined("form.purchasereturn")>
	<cfset str[2]="PR">
<cfelse>
	<cfset str[2]=''>
</cfif>
<cfif isdefined("form.invoice")>
	<cfset str[3]="INV">
<cfelse>
	<cfset str[3]=''>
</cfif>
<cfif isdefined("form.cashsales")>
	<cfset str[4]="CS">
<cfelse>
	<cfset str[4]=''>
</cfif>
<cfif isdefined("form.debitnote")>
	<cfset str[5]="DN">
<cfelse>
	<cfset str[5]=''>
</cfif>
<cfif isdefined("form.creditnote")>
	<cfset str[6]="CN">
<cfelse>
	<cfset str[6]=''>
</cfif>
<cfif isdefined("form.deliveryorder")>
	<cfset str[7]="DO">
<cfelse>
	<cfset str[7]=''>
</cfif>
<cfif isdefined("form.salesorder")>
	<cfset str[8]="SO">
<cfelse>
	<cfset str[8]=''>
</cfif>
<cfif isdefined("form.purchaseorder")>
	<cfset str[9]="PO">
<cfelse>
	<cfset str[9]=''>
</cfif>
<cfif isdefined("form.quotation")>
	<cfset str[10]="QUO">
<cfelse>
	<cfset str[10]=''>
</cfif>
<cfif isdefined("form.adjustmentincrease")>
	<cfset str[11]="OAI">
<cfelse>
	<cfset str[11]=''>
</cfif>
<cfif isdefined("form.adjustmentreduce")>
	<cfset str[12]="OAR">
<cfelse>
	<cfset str[12]=''>
</cfif>
<cfif isdefined("form.issue")>
	<cfset str[13]="ISS">
<cfelse>
	<cfset str[13]=''>
</cfif>

<cfset arraysort(str,"textnocase","desc")>

<cfset totalqty = 0>
<cfset ftotal = 0>
<cfset total= 0>
<cfset dftotal = 0>
<cfset dtotal = 0>
<cfset tftotal = 0>
<cfset ttotal = 0>

<body>
<cfoutput>
<table width="100%" border="0" cellspacing="0" cellpadding="2" class="data">
	<tr>
		<td colspan="100%"><div align="center"><font size="3" face="Times New Roman,Times,serif"><strong>Print Bill Summary Report</strong></font></div></td>
	</tr>
    <cfif form.periodfrom neq "" and form.periodto neq "">
		<tr> 
			<td colspan="100%"><div align="center"><font size="2" face="Times New Roman,Times,serif">PERIOD: #form.periodfrom# - #form.periodto#</font></div></td>
		</tr>
	</cfif>
	<cfif form.datefrom neq "" and form.dateto neq "">
		<tr> 
      		<td colspan="100%"><div align="center"><font size="2" face="Times New Roman,Times,serif">DATE: #dateformat(form.datefrom,"dd/mm/yyyy")# - #dateformat(form.dateto,"dd/mm/yyyy")#</font></div></td>
    	</tr>
	</cfif>
    <cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
        <tr> 
          	<td colspan="100%"><div align="center"><font size="2" face="Times New Roman,Times,serif">CUST: #form.custfrom# - #form.custto#</font></div></td>
        </tr>
    </cfif>
    <cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
        <tr> 
          	<td colspan="100%"><div align="center"><font size="2" face="Times New Roman,Times,serif">SUPP: #form.suppfrom# - #form.suppto#</font></div></td>
        </tr>
    </cfif>
    <cfif form.agentfrom neq "" and form.agentto neq "">
        <tr> 
          	<td colspan="100%"><div align="center"><font size="2" face="Times New Roman,Times,serif">AGENT NO: #form.agentfrom# - #form.agentto#</font></div></td>
        </tr>
    </cfif>
    <cfif form.projectfrom neq "" and form.projectto neq "">
        <tr> 
          	<td colspan="100%"><div align="center"><font size="2" face="Times New Roman,Times,serif">PROJECT NO: #form.projectfrom# - #form.projectto#</font></div></td>
        </tr>
    </cfif>
	<cfif form.reffrom neq "" and form.refto neq "">
        <tr> 
          	<td colspan="100%"><div align="center"><font size="2" face="Times New Roman,Times,serif">REF NO: #form.reffrom# - #form.refto#</font></div></td>
        </tr>
    </cfif>
	<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
        <tr> 
          	<td colspan="100%"><div align="center"><font size="2" face="Times New Roman,Times,serif">ITEM NO: #form.itemfrom# - #form.itemto#</font></div></td>
        </tr>
    </cfif>
    <tr> 
      	<td colspan="4"><font size="2" face="Times New Roman,Times,serif">#getgeneral.compro#</font></td>
      	<td colspan="8"><div align="right"><font size="2" face="Times New Roman,Times,serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
    </tr>
    <tr> 
      	<td colspan="100%"><hr></td>
    </tr>
    <tr>
      	<td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>TYPE</strong></font></div></td>
	  	<td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>REF.NO</strong></font></div></td>
        <cfif lcase(hcomid) eq "leadbuilders_i" or lcase(hcomid) eq "yushita_i" or lcase(hcomid) eq "walmart_i" or lcase(hcomid) eq "aurumbuilds_i ">
        <td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>REF.NO 2</strong></font></div></td>
	<td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>PONO</strong></font></div></td>
        </cfif>
        <cfif lcase(hcomid) eq "colorinc_i">
        <td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>PROJECT</strong></font></div></td>
	<td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>JOB</strong></font></div></td>
        </cfif>
        
      	<td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>CUST.NO</strong></font></div></td>
        <cfif lcase(hcomid) eq "mastercare_i" or lcase(hcomid) eq "gorgeous_i">
        <td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>SO NO</strong></font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>DO NO</strong></font></div></td>
        </cfif>
        <cfif lcase(hcomid) eq "leadbuilders_i" or lcase(hcomid) eq "yushita_i" or lcase(hcomid) eq "walmart_i" or lcase(hcomid) eq "aurumbuilds_i ">
        <td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>Project</strong></font></div></td>
	<td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>Job</strong></font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>Body Remark 1</strong></font></div></td>
	<td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>Location</strong></font></div></td>
        </cfif>
		<cfif lcase(hcomid) eq "ecraft_i" or lcase(hcomid) eq "ovas_i">
			<td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>LOCATION</strong></font></div></td>
		</cfif>
      	<td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>ITEMS</strong></font></div></td>
      	<td><div align="right"><font size="2" face="Times New Roman,Times,serif"><strong>QTY</strong></font></div></td>
        <cfif lcase(hcomid) eq "leadbuilders_i" or lcase(hcomid) eq "yushita_i" or lcase(hcomid) eq "walmart_i" or lcase(hcomid) eq "aurumbuilds_i ">
        <td><div align="right"><font size="2" face="Times New Roman,Times,serif"><strong>UNIT</strong></font></div></td>
        </cfif>
		<td colspan="3"><div align="right"><font size="2" face="Times New Roman,Times,serif"><strong><cfif lcase(hcomid) eq "leadbuilders_i" or lcase(hcomid) eq "yushita_i" or lcase(hcomid) eq "walmart_i" or lcase(hcomid) eq "aurumbuilds_i ">UNIT PRICE<cfelse>FOREIGN PRICE</cfif></strong></font></div></td>
		<cfif lcase(hcomid) eq "leadbuilders_i" or lcase(hcomid) eq "yushita_i" or lcase(hcomid) eq "walmart_i" or lcase(hcomid) eq "aurumbuilds_i ">
		<td colspan="3"><div align="right"><font size="2" face="Times New Roman,Times,serif"><strong>Disc</strong></font></div></td>
		<td colspan="3"><div align="right"><font size="2" face="Times New Roman,Times,serif"><strong>GST</strong></font></div></td>
		</cfif>
		<td colspan="3"><div align="right"><font size="2" face="Times New Roman,Times,serif"><strong><cfif lcase(hcomid) eq "leadbuilders_i" or lcase(hcomid) eq "yushita_i">AMOUNT<cfelse>PRICE</cfif></strong></font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman,Times,serif"><strong>CREATED BY</strong></font></div></td>
    </tr>
    <tr> 
      	<td colspan="100%"><hr></td>
    </tr>

	<cfquery name="gettran" datasource="#dts#">
		select 
		a.type,
		a.refno,
        a.refno2,
        a.dono,
        a.sono,
        a.job,
	a.pono,
		a.custno,
		a.name,
		a.currcode,
		a.currrate,
		a.wos_date,
		a.fperiod,
		a.agenno,
        a.source,
		a.disc_bil,
		a.discount,
		a.tax_bil,
		a.tax,
		a.net_bil,
		a.net,
		a.userid 
		from artran as a, (select type,refno,itemno,source,job<cfif lcase(hcomid) eq "ecraft_i" or lcase(hcomid) eq "ovas_i">,location</cfif> from ictran order by type,refno,itemno<cfif lcase(hcomid) eq "ecraft_i" or lcase(hcomid) eq "ovas_i">,location</cfif>) as b 
		where a.type=b.type 
		and a.refno=b.refno 
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and b.itemno between '#form.itemfrom#' and '#form.itemto#'
		</cfif>
		and (a.void='' or a.void is null) and 
		(<cfloop index="a" from="1" to="#arraylen(str)#">
			<cfif str[a] neq "">
				a.type='#str[a]#' <cfif a neq 13 and str[a+1] neq ''>or</cfif>
			</cfif>
		 </cfloop>) 
		 <cfif form.reffrom neq "" and form.refto neq "">
		 	and a.refno between '#form.reffrom#' and '#form.refto#' 
		 </cfif>
		 <cfif (trim(form.custfrom) neq "" and trim(form.custto) neq "") and (trim(form.suppfrom) eq "" and trim(form.suppto) eq "")>
		 	and a.custno between '#form.custfrom#' and '#form.custto#' 
		 <cfelseif (trim(form.suppfrom) neq "" and trim(form.suppto) neq "") and (trim(form.custfrom) eq "" and trim(form.custto) eq "")>
			 and a.custno between '#form.suppfrom#' and '#form.suppto#'
		 </cfif>
		 <cfif form.agentfrom neq "" and form.agentto neq "">
		 	and a.agenno between '#form.agentfrom#' and '#form.agentto#' 
		 </cfif>
	<cfif getgeneral.projectbybill eq '1'>
         <cfif form.projectfrom neq "" and form.projectto neq "">
		 	and a.source between '#form.projectfrom#' and '#form.projectto#' 
		 </cfif>
	<cfelse>
	<cfif form.projectfrom neq "" and form.projectto neq "">
		 	and b.source between '#form.projectfrom#' and '#form.projectto#' 
		 </cfif>
	</cfif>

	<cfif getgeneral.projectbybill eq '1'>
         <cfif form.jobfrom neq "" and form.jobto neq "">
		 	and a.job between '#form.jobfrom#' and '#form.jobto#' 
		 </cfif>
	<cfelse>
	<cfif form.jobfrom neq "" and form.jobto neq "">
		 	and b.job between '#form.jobfrom#' and '#form.jobto#' 
		 </cfif>
	</cfif>
	
		 <cfif form.periodfrom neq "" and form.periodto neq "">
		 	and a.fperiod between '#form.periodfrom#' and '#form.periodto#'
		 </cfif>
		 <cfif form.datefrom neq "" and form.dateto neq "">
		 	and a.wos_date between '#ndatefrom#' and '#ndateto#'
		 </cfif>
		<cfif lcase(hcomid) eq "ecraft_i" or lcase(hcomid) eq "ovas_i">
			 <cfif form.locfrom neq "" and form.locto neq "">
				 and b.location between '#form.locfrom#' and '#form.locto#' 
			 </cfif>
		</cfif>
		 group by a.type,a.refno
		 order by a.type,a.refno,a.wos_date
	</cfquery>
	
	<cfloop query="gettran">
		<cfset subqty = 0>
		<cfset ftotal = ftotal + gettran.net_bil>
		<cfset total= total + gettran.net>
		<cfset dftotal = dtotal + gettran.disc_bil>
		<cfset dtotal = dtotal + gettran.discount>
		<cfset tftotal = tftotal + tax_bil>
		<cfset ttotal = ttotal + gettran.tax>

		
		<cfquery name="getitem" datasource="#dts#">
			select 
			itemno,
            taxincl,
			desp,
			price_bil,
            currrate,
            unit,
			price,
            source,
			batchcode,
			disamt_bil,
			taxamt_bil,
            unit_bil,
			job,
			amt_bil,
            brem1,
			amt,
			qty,
			location
			from ictran 
			where type='#gettran.type#' 
			and refno='#gettran.refno#' 
			and (void='' or void is null)
			<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and itemno between '#form.itemfrom#' and '#form.itemto#'
			</cfif>
			<cfif lcase(hcomid) eq "ecraft_i" or lcase(hcomid) eq "ovas_i">
				<cfif form.locfrom neq "" and form.locto neq "">
					and location between '#form.locfrom#' and '#form.locto#' 
			 	</cfif>
			</cfif>
			<cfif getgeneral.projectbybill neq '1'>
         		<cfif form.projectfrom neq "" and form.projectto neq "">
		 	and source between '#form.projectfrom#' and '#form.projectto#' 
		 	</cfif>
			</cfif>
			<cfif getgeneral.projectbybill neq '1'>
         		<cfif form.jobfrom neq "" and form.jobto neq "">
		 	and job between '#form.jobfrom#' and '#form.jobto#' 
		 	</cfif>
			</cfif>
		</cfquery>
		
		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
			<td><div align="left"><font size="1" face="Times New Roman,Times,serif">#gettran.currentrow#. #gettran.type#</font></div></td>
			<td><div align="left"><font size="1" face="Times New Roman,Times,serif"><a href="../../billformat/#dts#/transactionformat.cfm?tran=#gettran.type#&nexttranno=#gettran.refno#" target="_blank">#gettran.refno#</a><br/>#lsdateformat(gettran.wos_date,"dd/mm/yyyy")#<br/>#gettran.fperiod#</font></div></td>
            <cfif lcase(hcomid) eq "leadbuilders_i" or lcase(hcomid) eq "yushita_i" or lcase(hcomid) eq "walmart_i" or lcase(hcomid) eq "aurumbuilds_i ">
            <td><div align="left"><font size="1" face="Times New Roman,Times,serif">#gettran.refno2#</font></div></td>
	    <td><div align="left"><font size="1" face="Times New Roman,Times,serif">#gettran.pono#</font></div></td>
            </cfif>
            <cfif lcase(hcomid) eq "colorinc_i">
        <td><div align="left"><font size="1" face="Times New Roman,Times,serif">#gettran.source#</font></div></td>
	    <td><div align="left"><font size="1" face="Times New Roman,Times,serif">#gettran.job#</font></div></td>
        	</cfif>
            
			<td><div align="left"><font size="1" face="Times New Roman,Times,serif">#gettran.custno# - #gettran.name#</font></div></td>
            <cfif lcase(hcomid) eq "mastercare_i" or lcase(hcomid) eq "gorgeous_i">
        <td><div align="left"><font size="1" face="Times New Roman,Times,serif">#gettran.sono#</font></div></td>
        <td><div align="left"><font size="1" face="Times New Roman,Times,serif">#gettran.dono#</font></div></td>
        </cfif>
        <cfif lcase(hcomid) eq "leadbuilders_i" or lcase(hcomid) eq "yushita_i" or lcase(hcomid) eq "walmart_i" or lcase(hcomid) eq "aurumbuilds_i ">
        <td><div align="left"><font size="1" face="Times New Roman,Times,serif">
        <cfloop query="getitem">
			#getitem.source#<br>
		</cfloop></font></div></td>
	<td><div align="left"><font size="1" face="Times New Roman,Times,serif">
        <cfloop query="getitem">
			#getitem.job#<br>
		</cfloop></font></div></td>
        <td><div align="left"><font size="1" face="Times New Roman,Times,serif">
        <cfloop query="getitem">
			#getitem.brem1#<br>
		</cfloop>
        </font></div></td>
	<td><div align="left"><font size="1" face="Times New Roman,Times,serif">
        <cfloop query="getitem">
			#getitem.location#<br>
		</cfloop>
        </font></div></td>
        </cfif>
			<cfif lcase(hcomid) eq "ecraft_i" or lcase(hcomid) eq "ovas_i">
				<td><div align="left"><font size="1" face="Times New Roman,Times,serif">
				<cfloop query="getitem">
					#getitem.location#<br>
				</cfloop>
				</font></div></td>
			</cfif>
			<td><div align="left"><font size="1" face="Times New Roman,Times,serif">
			<cfloop query="getitem">
				#getitem.itemno# - #getitem.desp#<br>
				<cfif lcase(hcomid) eq "bestform_i">Drawing No. :#getitem.batchcode#<br></cfif>
			</cfloop>
			</font></div></td>
			<td><div align="right"><font size="1" face="Times New Roman,Times,serif">
            
			<cfloop query="getitem">
				<cfset subqty = subqty + getitem.qty>
				<cfset totalqty = totalqty + getitem.qty>
				#numberformat(getitem.qty,"0")#<br>
                <cfif lcase(hcomid) eq "bestform_i"><br></cfif>
			</cfloop>
			</font></div></td>
            <cfif lcase(hcomid) eq "leadbuilders_i" or lcase(hcomid) eq "yushita_i" or lcase(hcomid) eq "walmart_i" or lcase(hcomid) eq "aurumbuilds_i ">
            <td><div align="right"><font size="1" face="Times New Roman,Times,serif">
			<cfloop query="getitem">
				#getitem.unit_bil#<br>
                <cfif lcase(hcomid) eq "bestform_i"><br></cfif>
			</cfloop>
			</font></div></td>
            </cfif>
			<td colspan="3"><div align="right"><font size="1" face="Times New Roman,Times,serif">
			<cfloop query="getitem">
				<cfif lcase(hcomid) eq "leadbuilders_i" or lcase(hcomid) eq "yushita_i" or lcase(hcomid) eq "walmart_i" or lcase(hcomid) eq "aurumbuilds_i ">
                #numberformat(getitem.price,stDecl_UPrice)#<br>
                <cfelse>
                <cfif getitem.currrate eq 1 or getitem.currrate eq 0><cfelse>#numberformat(getitem.price_bil,stDecl_UPrice)#</cfif><br><cfif lcase(hcomid) eq "bestform_i"><br></cfif>
                </cfif>
                
			</cfloop>
			</font></div></td>
			<cfif lcase(hcomid) eq "leadbuilders_i" or lcase(hcomid) eq "yushita_i" or lcase(hcomid) eq "walmart_i" or lcase(hcomid) eq "aurumbuilds_i ">
			<td colspan="3"><div align="right"><font size="1" face="Times New Roman,Times,serif">
			<cfloop query="getitem">
				#numberformat(getitem.disamt_bil,stDecl_UPrice)#<br>
			</cfloop>
			</font></div></td>

			<td colspan="3"><div align="right"><font size="1" face="Times New Roman,Times,serif">
			<cfloop query="getitem">
				#numberformat(getitem.taxamt_bil,stDecl_UPrice)#<br>
			</cfloop>
			</font></div></td>

			</cfif>
			<td colspan="3"><div align="right"><font size="1" face="Times New Roman,Times,serif">
			<cfloop query="getitem">
            	<cfif lcase(hcomid) eq "leadbuilders_i" or lcase(hcomid) eq "yushita_i" or lcase(hcomid) eq "walmart_i" or lcase(hcomid) eq "aurumbuilds_i ">
                <cfif getitem.taxincl eq 'T'>
                #numberformat(getitem.amt,stDecl_UPrice)#
                <cfelse>
                #numberformat(getitem.amt+getitem.taxamt_bil,stDecl_UPrice)#
                </cfif>
                <br>
                <cfelse>
				#numberformat(getitem.price,stDecl_UPrice)#<br>
                </cfif>
                <cfif lcase(hcomid) eq "bestform_i"><br></cfif>
			</cfloop>
			</font></div></td>
			<td><div align="right"><font size="1" face="Times New Roman,Times,serif">#gettran.userid#</font></div></td>
		</tr>
		<tr> 
			<td colspan="100%"><hr></td>
		</tr>
		<tr>
			<td></td>
			<td></td>
			<cfif lcase(hcomid) eq "ecraft_i" or lcase(hcomid) eq "ovas_i">
				<td></td>
			</cfif>
            <cfif lcase(hcomid) eq "colorinc_i">
            <td></td><td></td>
            </cfif>
            <cfif lcase(hcomid) eq "leadbuilders_i" or lcase(hcomid) eq "yushita_i" or lcase(hcomid) eq "walmart_i" or lcase(hcomid) eq "aurumbuilds_i ">
            <td></td>
            <td></td>
		<td></td>	
       
		<td></td>	
			<td></td>
			<td></td>
			<td></td>
            </cfif>
			<td><div align="left"><font size="1" face="Times New Roman,Times,serif">SUB TOTAL:</font></div></td>
			<td><div align="left"><font size="1" face="Times New Roman,Times,serif"></font></div></td>
			<td><div align="right"><font size="1" face="Times New Roman,Times,serif">#NumberFormat(subqty,"0")#</font></div></td>
			<td><div align="right"><font size="1" face="Times New Roman,Times,serif">F.DISC=#gettran.disc_bil#</font></div></td>
			<td><div align="right"><font size="1" face="Times New Roman,Times,serif">F.TAX=#gettran.tax_bil#</font></div></td>
			<td><div align="right"><font size="1" face="Times New Roman,Times,serif">F.TOTAL=#NumberFormat(gettran.net_bil,",.__")#</font></div></td>
			<td><div align="right"><font size="1" face="Times New Roman,Times,serif">DISC=#gettran.discount#</font></div></td>
			<td><div align="right"><font size="1" face="Times New Roman,Times,serif">TAX=#gettran.tax#</font></div></td>
			<td><div align="right"><font size="1" face="Times New Roman,Times,serif">TOTAL=#NumberFormat(gettran.net,",.__")#</font></div></td>
		</tr>
		<tr><td><br></td></tr>
	</cfloop>
	<tr> 
		<td colspan="100%"><hr></td>
	</tr>
	<tr>
		<td></td>
		<td></td>
		<cfif lcase(hcomid) eq "ecraft_i" or lcase(hcomid) eq "ovas_i">
			<td></td>
		</cfif>
        <cfif lcase(hcomid) eq "colorinc_i">
        <td></td>
        <td></td>
        </cfif>
        <cfif lcase(hcomid) eq "leadbuilders_i" or lcase(hcomid) eq "yushita_i" or lcase(hcomid) eq "walmart_i" or lcase(hcomid) eq "aurumbuilds_i ">
            <td></td>
            <td></td>
	    <td></td>
	    <td></td>
	<td></td>
    <td></td>
			<td></td>
        </cfif>
		<td><div align="left"><font size="1" face="Times New Roman,Times,serif"><strong>TOTAL:</strong></font></div></td>
		<td></td>
		<td><div align="right"><font size="1" face="Times New Roman,Times,serif"><strong>#NumberFormat(totalqty,"0")#</strong></font></div></td>
		<td><div align="right"><font size="1" face="Times New Roman,Times,serif"><strong>F.DISC=#dftotal#</strong></font></div></td>
		<td><div align="right"><font size="1" face="Times New Roman,Times,serif"><strong>F.TAX=#tftotal#</strong></font></div></td>
		<td><div align="right"><font size="1" face="Times New Roman,Times,serif"><strong>F.TOTAL=#NumberFormat(ftotal,",.__")#</strong></font></div></td>
		<td><div align="right"><font size="1" face="Times New Roman,Times,serif"><strong>DISC=#dtotal#</strong></font></div></td>
		<td><div align="right"><font size="1" face="Times New Roman,Times,serif"><strong>TAX=#ttotal#</strong></font></div></td>
		<td><div align="right"><font size="1" face="Times New Roman,Times,serif"><strong>TOTAL=#NumberFormat(total,",.__")#</strong></font></div></td>
	</tr>
</table>

</cfoutput>

<cfif gettran.recordcount eq 0>
	<h3 style="color:red">Sorry, No records were found.</h3>
</cfif>

<br><br>

<div align="right">
	<font size="1" face="Arial,Helvetica,sans-serif">
		<a href="javascript:print()" class="noprint"><u>Print</u></a>
	</font>
</div>

<p class="noprint">
	<font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font>
</p>

</body>
</html>