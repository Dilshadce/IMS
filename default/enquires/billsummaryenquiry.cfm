<cfif form.result eq "HTML">

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
	
    <cfquery name="getdisplay" datasource="#dts#">
    	select report_aitemno from displaysetup
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
    <cfset grandForeignTotal = 0>
    <cfset grandForeignTax = 0>
    <cfset grandForeignDiscount = 0>
	
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
            <cfif getdisplay.report_aitemno eq 'Y'>
            <td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>Product Code</strong></font></div></td>
            </cfif>
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
			<cfset ftotal = ftotal + numberformat(gettran.net_bil,".__")>
			<cfset total= total + numberformat(gettran.net,".__")>
			<cfset dftotal = dtotal + numberformat(gettran.disc_bil,".__")>
			<cfset dtotal = dtotal + numberformat(gettran.discount,".__")>
			<cfset tftotal = tftotal + numberformat(tax_bil,".__")>
			<cfset ttotal = ttotal + numberformat(gettran.tax,".__")>
	
			
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
				#getitem.source#<br/>
			</cfloop></font></div></td>
		<td><div align="left"><font size="1" face="Times New Roman,Times,serif">
			<cfloop query="getitem">
				#getitem.job#<br/>
			</cfloop></font></div></td>
			<td><div align="left"><font size="1" face="Times New Roman,Times,serif">
			<cfloop query="getitem">
				#getitem.brem1#<br/>
			</cfloop>
			</font></div></td>
		<td><div align="left"><font size="1" face="Times New Roman,Times,serif">
			<cfloop query="getitem">
				#getitem.location#<br/>
			</cfloop>
			</font></div></td>
			</cfif>
				<cfif lcase(hcomid) eq "ecraft_i" or lcase(hcomid) eq "ovas_i">
					<td><div align="left"><font size="1" face="Times New Roman,Times,serif">
					<cfloop query="getitem">
						#getitem.location#<br/>
					</cfloop>
					</font></div></td>
				</cfif>
				<td><div align="left"><font size="1" face="Times New Roman,Times,serif">
				<cfloop query="getitem">
					#getitem.itemno# - #getitem.desp#<br/>
					<cfif lcase(hcomid) eq "bestform_i">Drawing No. :#getitem.batchcode#<br/></cfif>
				</cfloop>
				</font></div></td>
                <cfif getdisplay.report_aitemno eq 'Y'>
                <td><div align="left"><font size="1" face="Times New Roman,Times,serif">
				<cfloop query="getitem">
                <cfquery name="getproductcode" datasource="#dts#">
                select aitemno from icitem where itemno='#getitem.itemno#'
                </cfquery>
					#getproductcode.aitemno#<br/>
				</cfloop>
				</font></div></td>
                </cfif>
				<td><div align="right"><font size="1" face="Times New Roman,Times,serif">
				
				<cfloop query="getitem">
					<cfset subqty = subqty + getitem.qty>
					<cfset totalqty = totalqty + getitem.qty>
					#numberformat(getitem.qty,"0")#<br/>
					<cfif lcase(hcomid) eq "bestform_i"><br/></cfif>
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
                <cfif gettran.currrate neq 1>
                <cfset grandForeignDiscount = grandForeignDiscount+gettran.disc_bil>
				<td><div align="right"><font size="1" face="Times New Roman,Times,serif">F.DISC=#gettran.disc_bil#</font></div></td>
                <cfset grandForeignTax = grandForeignTax+gettran.tax_bil>
				<td><div align="right"><font size="1" face="Times New Roman,Times,serif">F.TAX=#gettran.tax_bil#</font></div></td> 
                <cfset grandForeignTotal = NumberFormat(grandForeignTotal+gettran.net_bil,".__")>
				<td><div align="right"><font size="1" face="Times New Roman,Times,serif">F.TOTAL=#NumberFormat(gettran.net_bil,",.__")#</font></div></td>
                <cfelse>
                <td></td>
                <td></td>
                <td></td>
                </cfif>
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
			<td><div align="right"><font size="1" face="Times New Roman,Times,serif"><strong>F.DISC=#NumberFormat(grandForeignDiscount,",.__")#</strong></font></div></td>
			<td><div align="right"><font size="1" face="Times New Roman,Times,serif"><strong>F.TAX=#NumberFormat(grandForeignTax,",.__")#</strong></font></div></td>
			<td><div align="right"><font size="1" face="Times New Roman,Times,serif"><strong>F.TOTAL=#NumberFormat(grandForeignTotal,",.__")#</strong></font></div></td>
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
<cfelse>

			<cfquery name="getgeneral" datasource="#dts#">
                select compro,lastaccyear,projectbybill from gsetup
            </cfquery>
            
            <cfquery name="getgsetup2" datasource='#dts#'>
              Select * from gsetup2
            </cfquery>
            
            <cfquery name="getdisplay" datasource="#dts#">
                select report_aitemno from displaysetup
            </cfquery>
            
                        
            
            <cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
            <cfset stDecl_UPrice = ",.">
            
            <cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
              <cfset stDecl_UPrice = stDecl_UPrice & "_">
            </cfloop>
            
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
            
	<cfxml variable="data">
			<?xml version="1.0"?>
			<?mso-application progid="Excel.Sheet"?>
			<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet" xmlns:html="http://www.w3.org/TR/REC-html40">
			<DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">
				<Author>Netiquette Technology</Author>
				<LastAuthor>Netiquette Technology</LastAuthor>
				<Company>Netiquette Technology</Company>
			</DocumentProperties>
			<Styles>
		  		<Style ss:ID="Default" ss:Name="Normal">
			   		<Alignment ss:Vertical="Bottom"/>
			   		<Borders/>
			   		<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9"/>
			   		<Interior/>
			   		<NumberFormat/>
			   		<Protection/>
		  		</Style>
		  		<Style ss:ID="s22">
		   			<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
		   			<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="12" ss:Bold="1"/>
		  		</Style>
			 	<Style ss:ID="s24">
			   		<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
			   		<Font ss:FontName="Verdana" x:Family="Swiss"/>
			  	</Style>
		  		<Style ss:ID="s26">
		   			<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
		   			<Font ss:FontName="Verdana" x:Family="Swiss"/>
		  		</Style>
		  		<Style ss:ID="s27">
		   			<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		  		</Style>
		  		<Style ss:ID="s30">
		   			<NumberFormat ss:Format="dd-mm-yy;@"/>
		  		</Style>
		  		<Style ss:ID="s31">
		  			<Alignment ss:Horizontal="Right" ss:Vertical="Center"/>
		   			<Font ss:FontName="Verdana" x:Family="Swiss"/>
		  		</Style>
		  		<Style ss:ID="s32">
		  	 		<NumberFormat ss:Format="@"/>
		  		</Style>
		  		<Style ss:ID="s33">
		   			<NumberFormat ss:Format="#,###,###,##0.<cfoutput>00</cfoutput>"/>
		  		</Style>
		  		<Style ss:ID="s34">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		   			<NumberFormat ss:Format="dd/mm/yyyy;@"/>
		  		</Style>
		  		<Style ss:ID="s35">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		   			<NumberFormat ss:Format="#,###,###,##0"/>
		  		</Style>
		  		<Style ss:ID="s36">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		   			<NumberFormat ss:Format="@"/>
		  		</Style>
		  		<Style ss:ID="s37">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		   			<NumberFormat ss:Format="#,###,###,##0.<cfoutput>00</cfoutput>"/>
		  		</Style>
		  		<Style ss:ID="s38">
		   			<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
		  		</Style>
		  		<Style ss:ID="s39">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
		   			</Borders>
		   			<NumberFormat ss:Format="#,###,###,##0.<cfoutput>00</cfoutput>"/>
		  		</Style>
		  		<Style ss:ID="s41">
		   			<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
		   			<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1" ss:Underline="Single"/>
		  		</Style>
		 	</Styles>

            
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
            <cfset grandForeignDiscount = 0>
			<cfset grandForeignTax = 0>
			<cfset grandForeignTotal = 0>
	
			<Worksheet ss:Name="Print Bill Summary Report">
				<cfoutput>
				<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="64.5"/>
					<Column ss:Width="165.25"/>
					<Column ss:Width="140.75"/>
                    <Column ss:AutoFitWidth="0" ss:Width="183.75"/>
					<Column ss:Width="30.75"/>
					<Column ss:Width="73.25"/>
					<Column ss:Width="73.25"/>
					<Column ss:Width="79.25"/>
                    <Column ss:Width="73.25"/>
                    <Column ss:Width="73.25"/>
                    <Column ss:Width="79.25"/>
                    <Column ss:Width="73.25"/>
					<cfset c="30">
						<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<cfset c=c+1>
				<!---Heading---->
		   
                <cfwddx action = "cfml2wddx" input = "Print Bill Summary Report" output = "wddxText">
                <Row ss:AutoFitHeight="0" ss:Height="23.0625">
                    <Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
                </Row>
				
            	<cfif form.periodfrom neq "" and form.periodto neq "">
                    <cfwddx action = "cfml2wddx" input = "PERIOD: #form.periodfrom# - #form.periodto#" output = "wddxText">
                        <Row ss:AutoFitHeight="0" ss:Height="23.0625">
                            <Cell  ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
                        </Row>
                </cfif>
                
				<cfif form.datefrom neq "" and form.dateto neq "">
                <cfwddx action = "cfml2wddx" input = "DATE: #dateformat(form.datefrom,"dd/mm/yyyy")# - #dateformat(form.dateto,"dd/mm/yyyy")#" output = "wddxText">
                        <Row ss:AutoFitHeight="0" ss:Height="23.0625">
                            <Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
                        </Row>
                </cfif>
                
                <cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
                    <cfwddx action = "cfml2wddx" input = "CUST: #form.custfrom# - #form.custto#" output = "wddxText">
                        <Row ss:AutoFitHeight="0" ss:Height="23.0625">
                            <Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
                        </Row>
                </cfif>
                
                <cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
                    <cfwddx action = "cfml2wddx" input = "SUPP: #form.suppfrom# - #form.suppto#" output = "wddxText">
                        <Row ss:AutoFitHeight="0" ss:Height="23.0625">
                            <Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
                        </Row>
                </cfif>
            
            	<cfif form.agentfrom neq "" and form.agentto neq "">
                    <cfwddx action = "cfml2wddx" input = "AGENT NO: #form.agentfrom# - #form.agentto#" output = "wddxText">
                        <Row ss:AutoFitHeight="0" ss:Height="23.0625">
                            <Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
                        </Row>
                </cfif>
                
                <cfif form.projectfrom neq "" and form.projectto neq "">
                    <cfwddx action = "cfml2wddx" input = "PROJECT NO: #form.projectfrom# - #form.projectto#" output = "wddxText">
                        <Row ss:AutoFitHeight="0" ss:Height="23.0625">
                            <Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
                        </Row>
                </cfif>
                
                <cfif form.reffrom neq "" and form.refto neq "">
                    <cfwddx action = "cfml2wddx" input = "REF NO: #form.reffrom# - #form.refto#" output = "wddxText">
                        <Row ss:AutoFitHeight="0" ss:Height="23.0625">
                            <Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
                        </Row>
                </cfif>
                
                <cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
                	<cfwddx action = "cfml2wddx" input = "ITEM NO: #form.itemfrom# - #form.itemto#" output = "wddxText">
                    	<Row ss:AutoFitHeight="0" ss:Height="23.0625">
                            <Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
                        </Row>
                </cfif>
                
				<cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText">
					<Row ss:AutoFitHeight="0" ss:Height="20.0625">
						<Cell ss:MergeAcross="#c-1#" ss:StyleID="s26"><Data ss:Type="String">#wddxText#</Data></Cell>
						<Cell ss:StyleID="s26"><Data ss:Type="String">#dateformat(now(),"dd/mm/yyyy")#</Data></Cell>
					</Row>
				</cfoutput>
		
				<Row ss:AutoFitHeight="0" ss:Height="23.0625">
					<Cell ss:StyleID="s27"><Data ss:Type="String">TYPE</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">REF NO</Data></Cell>
                    
					<cfif lcase(hcomid) eq "leadbuilders_i" or lcase(hcomid) eq "yushita_i" or lcase(hcomid) eq "walmart_i" or lcase(hcomid) eq "aurumbuilds_i ">
                    	<Cell ss:StyleID="s27"><Data ss:Type="String">REF NO 2</Data></Cell>
                        <Cell ss:StyleID="s27"><Data ss:Type="String">PONO</Data></Cell>
                     </cfif>
                     
					 <cfif lcase(hcomid) eq "colorinc_i">
                     	<Cell ss:StyleID="s27"><Data ss:Type="String">PROJECT</Data></Cell>
                        <Cell ss:StyleID="s27"><Data ss:Type="String">JOB</Data></Cell>
                     </cfif>
					
                    <Cell ss:StyleID="s27"><Data ss:Type="String">CUST NO</Data></Cell>
                    <cfif lcase(hcomid) eq "mastercare_i" or lcase(hcomid) eq "gorgeous_i">
                    <Cell ss:StyleID="s27"><Data ss:Type="String">SO NO</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">DO NO</Data></Cell>
                    </cfif>
					<cfif lcase(hcomid) eq "leadbuilders_i" or lcase(hcomid) eq "yushita_i" or lcase(hcomid) eq "walmart_i" or lcase(hcomid) eq "aurumbuilds_i ">
                    	<Cell ss:StyleID="s27"><Data ss:Type="String">PROJECT</Data></Cell>	
                        <Cell ss:StyleID="s27"><Data ss:Type="String">JOB</Data></Cell>
                        <Cell ss:StyleID="s27"><Data ss:Type="String">BODY REMARK 1</Data></Cell>
                        <Cell ss:StyleID="s27"><Data ss:Type="String">LOCATION</Data></Cell>
                    </cfif>    
                    
                    <cfif lcase(hcomid) eq "ecraft_i" or lcase(hcomid) eq "ovas_i">
                    	<Cell ss:StyleID="s27"><Data ss:Type="String">LOCATION</Data></Cell>	
                    </cfif>
                    
                    <Cell ss:StyleID="s27"><Data ss:Type="String">ITEMS</Data></Cell>
                    
					<cfif getdisplay.report_aitemno eq 'Y'>
						<Cell ss:StyleID="s27"><Data ss:Type="String">PRODUCT CODE</Data></Cell>
                    </cfif>
                    
					<Cell ss:StyleID="s27"><Data ss:Type="String">QTY</Data></Cell>
                    
                    <cfif lcase(hcomid) eq "leadbuilders_i" or lcase(hcomid) eq "yushita_i" or lcase(hcomid) eq "walmart_i" or lcase(hcomid) eq "aurumbuilds_i ">
						<Cell ss:StyleID="s27"><Data ss:Type="String">UNIT</Data></Cell>
                    </cfif>
                    
                    <!--- Still need colspan=3 --->
                    <cfif lcase(hcomid) eq "leadbuilders_i" or lcase(hcomid) eq "yushita_i" or lcase(hcomid) eq "walmart_i" or lcase(hcomid) eq "aurumbuilds_i ">
                        <Cell ss:StyleID="s27" ss:MergeAcross="3"><Data ss:Type="String">UNIT PRICE</Data></Cell>
                    <cfelse>
                        <Cell ss:StyleID="s27"  ss:MergeAcross="3"><Data ss:Type="String">FOREIGN PRICE</Data></Cell>
                    </cfif>
                    <cfif lcase(hcomid) eq "leadbuilders_i" or lcase(hcomid) eq "yushita_i" or lcase(hcomid) eq "walmart_i" or lcase(hcomid) eq "aurumbuilds_i ">
                    	<Cell ss:StyleID="s27"  ss:MergeAcross="3"><Data ss:Type="String">DISC</Data></Cell>
						<Cell ss:StyleID="s27" ss:MergeAcross="3"><Data ss:Type="String">GST</Data></Cell>
                    </cfif>
                    <cfif lcase(hcomid) eq "leadbuilders_i" or lcase(hcomid) eq "yushita_i">
                        <Cell ss:StyleID="s27"  ss:MergeAcross="3"><Data ss:Type="String">AMOUNT</Data></Cell>
                    <cfelse>
                        <Cell ss:StyleID="s27"  ss:MergeAcross="1"><Data ss:Type="String">PRICE</Data></Cell>
                    </cfif>
                   		<Cell ss:StyleID="s27"><Data ss:Type="String">CREATED BY</Data></Cell>
                        
				</Row>
			
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
			<cfset ftotal = ftotal + numberformat(gettran.net_bil,".__")>
			<cfset total= total + numberformat(gettran.net,".__")>
			<cfset dftotal = dtotal + numberformat(gettran.disc_bil,".__")>
			<cfset dtotal = dtotal + numberformat(gettran.discount,".__")>
			<cfset tftotal = tftotal + numberformat(tax_bil,".__")>
			<cfset ttotal = ttotal + numberformat(gettran.tax,".__")>
            	
			
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
				
        	
				<cfoutput>
					
                    <cfloop query="getitem">
                        <cfwddx action = "cfml2wddx" input = "#gettran.currentrow#. #gettran.type#" output = "wddxText">
                        <cfwddx action = "cfml2wddx" input = "#gettran.refno#" output = "wddxText2">
                        <cfwddx action = "cfml2wddx" input = "#lsdateformat(gettran.wos_date,'dd/mm/yyyy')#" output = "wddxText3">
                        <cfwddx action = "cfml2wddx" input = "#gettran.fperiod#" output = "wddxText4">           
                        <cfwddx action = "cfml2wddx" input = "#gettran.refno2#" output = "wddxText5">
                        <cfwddx action = "cfml2wddx" input = "#gettran.pono#" output = "wddxText6">
                        <cfwddx action = "cfml2wddx" input = "#gettran.source#" output = "wddxText7">
                        <cfwddx action = "cfml2wddx" input = "#gettran.job#" output = "wddxText8">
                        <cfwddx action = "cfml2wddx" input = "#gettran.custno# - #gettran.name#" output = "wddxText25">
                        <cfwddx action = "cfml2wddx" input = "#gettran.sono#" output = "wddxText9">
                        <cfwddx action = "cfml2wddx" input = "#gettran.dono#" output = "wddxText10">    
                        <cfwddx action = "cfml2wddx" input = "#getitem.source#" output = "wddxText11">
                        <cfwddx action = "cfml2wddx" input = "#getitem.job#" output = "wddxText12">
                        <cfwddx action = "cfml2wddx" input = "#getitem.brem1#" output = "wddxText13">
                        <cfwddx action = "cfml2wddx" input = "#getitem.location#" output = "wddxText14">
                        <cfwddx action = "cfml2wddx" input = "#getitem.itemno# - #getitem.desp#" output = "wddxText15">
                        <cfwddx action = "cfml2wddx" input = "#getitem.batchcode#" output = "wddxText16">
                        <cfwddx action = "cfml2wddx" input = "#getitem.itemno#" output = "wddxText17">
                        <cfwddx action = "cfml2wddx" input = "#getitem.unit_bil#" output = "wddxText19">
                        <cfwddx action = "cfml2wddx" input = "#gettran.userid#" output = "wddxText20">            
                        <cfwddx action = "cfml2wddx" input = "#gettran.disc_bil#" output = "wddxText21">
                        <cfwddx action = "cfml2wddx" input = "#gettran.tax_bil#" output = "wddxText22">
                        <cfwddx action = "cfml2wddx" input = "#gettran.discount#" output = "wddxText23">
                        <cfwddx action = "cfml2wddx" input = "#gettran.tax#" output = "wddxText24">
					
                    <Row ss:AutoFitHeight="0">
                    	<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText#</Data></Cell>
						<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText2# - #wddxText3# - #wddxText4#</Data></Cell>   
                         <cfif lcase(hcomid) eq "leadbuilders_i" or lcase(hcomid) eq "yushita_i" or lcase(hcomid) eq "walmart_i" or lcase(hcomid) eq "aurumbuilds_i ">               
							<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText5#</Data></Cell>
                            <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText6#</Data></Cell>
                        </cfif>
                        
                        <cfif lcase(hcomid) eq "colorinc_i">
                        	<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText7#</Data></Cell>
                            <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText8#</Data></Cell>
                        </cfif>
                     	<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText25#</Data></Cell>
                        
                        <cfif lcase(hcomid) eq "mastercare_i" or lcase(hcomid) eq "gorgeous_i">
                        	<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText9#</Data></Cell>
                            <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText10#</Data></Cell>
                        </cfif>
                        
                        <cfif lcase(hcomid) eq "leadbuilders_i" or lcase(hcomid) eq "yushita_i" or lcase(hcomid) eq "walmart_i" or lcase(hcomid) eq "aurumbuilds_i ">
                        	<Cell ss:StyleID="s32"><Data ss:Type="String">
                                	<cfwddx action = "cfml2wddx" input = "#getitem.source#" output = "wddxText11">
									#wddxText11# <br/>                                                    
                            </Data></Cell>
                         
                        
                            <Cell ss:StyleID="s32"><Data ss:Type="String">
                                    <cfwddx action = "cfml2wddx" input = "#getitem.job#" output = "wddxText12">
                                    #wddxText12# <>
                             </Data></Cell>
                             
                             
                             <Cell ss:StyleID="s32"><Data ss:Type="String">
                                    <cfwddx action = "cfml2wddx" input = "#getitem.brem1#" output = "wddxText13">
                                    #wddxText13# <br/>
                             </Data></Cell>
                             
                             <Cell ss:StyleID="s32"><Data ss:Type="String">
                                    <cfwddx action = "cfml2wddx" input = "#getitem.location#" output = "wddxText14">
                                    #wddxText14# <br/>
                             </Data></Cell>
                         </cfif>
                                  
                         <cfif lcase(hcomid) eq "ecraft_i" or lcase(hcomid) eq "ovas_i">
                         	<Cell ss:StyleID="s32"><Data ss:Type="String">
                                    <cfwddx action = "cfml2wddx" input = "#getitem.location#" output = "wddxText14">
                                    #wddxText14# <br/>
                             </Data></Cell>
                         </cfif>
                         
                         <Cell ss:StyleID="s32"><Data ss:Type="String"><cfwddx action = "cfml2wddx" input = "#getitem.itemno# - #getitem.desp#" output = "wddxText15"><cfwddx action = "cfml2wddx" input = "#getitem.batchcode#" output = "wddxText16">#wddxText15#<cfif lcase(hcomid) eq "bestform_i">- Drawing No. : #wddxText16#<br/></cfif>
                         </Data></Cell>
                          
                        <cfif getdisplay.report_aitemno eq 'Y'>
                       		<Cell ss:StyleID="s32"><Data ss:Type="String">	
                                	<cfquery name="getproductcode" datasource="#dts#">
                						select aitemno from icitem where itemno='#getitem.itemno#'
                					</cfquery>
                                   <cfwddx action = "cfml2wddx" input = "#getproductcode.aitemno#" output = "wddxText18">#wddxText18#
                             </Data></Cell>
                         </cfif>
                         
                         <Cell ss:StyleID="s33"><Data ss:Type="Number"><cfset subqty = subqty + getitem.qty><cfset totalqty = totalqty + getitem.qty>#numberformat(getitem.qty,"0")#<cfif lcase(hcomid) eq "bestform_i"></cfif></Data></Cell>
                         
                          <cfif lcase(hcomid) eq "leadbuilders_i" or lcase(hcomid) eq "yushita_i" or lcase(hcomid) eq "walmart_i" or lcase(hcomid) eq "aurumbuilds_i ">
                         <Cell ss:StyleID="s32"><Data ss:Type="String">
                                #wddxText19#<br/>
                                <cfif lcase(hcomid) eq "bestform_i"><br/></cfif>
                                <cfwddx action = "cfml2wddx" input = "#getitem.unit_bil#" output = "wddxText19">                 
                          </Data></Cell>	
						</cfif>                         
                        
                        <Cell ss:StyleID="s33" ss:MergeAcross="3"><Data ss:Type="Number"><cfif lcase(hcomid) eq "leadbuilders_i" or lcase(hcomid) eq "yushita_i" or lcase(hcomid) eq "walmart_i" or lcase(hcomid) eq "aurumbuilds_i ">#numberformat(getitem.price,stDecl_UPrice)#<br/><cfelse><cfif getitem.currrate eq 1 or getitem.currrate eq 0><cfelse>#numberformat(getitem.price_bil,stDecl_UPrice)#</cfif><br/><cfif lcase(hcomid) eq "bestform_i"><br/></cfif></cfif></Data></Cell>
                         
                         <cfif lcase(hcomid) eq "leadbuilders_i" or lcase(hcomid) eq "yushita_i" or lcase(hcomid) eq "walmart_i" or lcase(hcomid) eq "aurumbuilds_i ">
                             <Cell ss:StyleID="s24"><Data ss:Type="Number">
                             	#numberformat(getitem.disamt_bil,stDecl_UPrice)#<br/>
                             </Data></Cell>
                             
                             <Cell ss:StyleID="s24"><Data ss:Type="Number">
                             	#numberformat(getitem.taxamt_bil,stDecl_UPrice)#<br/>
                             </Data></Cell>        
                         </cfif>
                         
                          <Cell ss:StyleID="s24" ss:MergeAcross="1"><Data ss:Type="Number"><cfif lcase(hcomid) eq "leadbuilders_i" or lcase(hcomid) eq "yushita_i" or lcase(hcomid) eq "walmart_i" or lcase(hcomid) eq "aurumbuilds_i "><cfif getitem.taxincl eq 'T'>#numberformat(getitem.amt,stDecl_UPrice)#<cfelse>#numberformat(getitem.amt+getitem.taxamt_bil,stDecl_UPrice)#</cfif><br/><cfelse>#numberformat(getitem.price,stDecl_UPrice)#<br/></cfif><cfif lcase(hcomid) eq "bestform_i"><br/></cfif></Data></Cell> 

                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText20#</Data></Cell>  
					</Row>                
                	</cfloop>
                    
                    <Row ss:AutoFitHeight="0">
                        
                        <cfif lcase(hcomid) eq "ecraft_i" or lcase(hcomid) eq "ovas_i">
                            <Cell ss:StyleID="s27"></Cell>
                        </cfif>
                        
                        <cfif lcase(hcomid) eq "colorinc_i">
                            <Cell ss:StyleID="s27"></Cell>
                            <Cell ss:StyleID="s27"></Cell>
                            <Cell ss:StyleID="s27"></Cell>
                            <Cell ss:StyleID="s27"></Cell>
                        </cfif>
                        
                        <cfif lcase(hcomid) eq "leadbuilders_i" or lcase(hcomid) eq "yushita_i" or lcase(hcomid) eq "walmart_i" or lcase(hcomid) eq "aurumbuilds_i ">
                            <Cell ss:StyleID="s27"></Cell>
                            <Cell ss:StyleID="s27"></Cell>
                            <Cell ss:StyleID="s27"></Cell>
                            <Cell ss:StyleID="s27"></Cell>
                            <Cell ss:StyleID="s27"></Cell>
                            <Cell ss:StyleID="s27"></Cell>
                            <Cell ss:StyleID="s27"></Cell>
                        </cfif>
                        
                        <Cell ss:StyleID="s27"><Data ss:Type="String">SUB TOTAL:</Data></Cell> 	
                        <cfif lcase(hcomid) neq "colorinc_i">
                        <Cell ss:StyleID="s27"></Cell>
                        <Cell ss:StyleID="s27"></Cell>
                        </cfif>
                        <Cell ss:StyleID="s27"></Cell>
                        
                        <Cell ss:StyleID="s27"><Data ss:Type="Number">#NumberFormat(subqty,"0")#</Data></Cell> 
                       	<cfif gettran.currrate neq 1>
                        <cfset grandForeignDiscount = grandForeignDiscount+gettran.disc_bil>
                        <Cell ss:StyleID="s27"><Data ss:Type="String">F.DISC=#wddxText21#</Data></Cell>
                        <cfset grandForeignTax = grandForeignTax+gettran.tax_bil>
                        <Cell ss:StyleID="s27"><Data ss:Type="String">F.TAX=#wddxText22#</Data></Cell>
                        <cfset grandForeignTotal = NumberFormat(grandForeignTotal+gettran.net_bil,".__")>
                        <Cell ss:StyleID="s27"><Data ss:Type="String">F.TOTAL=#NumberFormat(gettran.net_bil,",.__")#</Data></Cell>
                        <cfelse>
                        	<Cell ss:StyleID="s27"></Cell>
                            <Cell ss:StyleID="s27"></Cell>
                            <Cell ss:StyleID="s27"></Cell>
                        </cfif>
                        <Cell ss:StyleID="s27"><Data ss:Type="String">DISC=#wddxText23#</Data></Cell>
                        <Cell ss:StyleID="s27"><Data ss:Type="String">TAX=#wddxText24#</Data></Cell>
                        <Cell ss:StyleID="s27"><Data ss:Type="String">TOTAL=#NumberFormat(gettran.net,",.__")#</Data></Cell>
                        <Cell ss:StyleID="s27"></Cell>
                        
                      </Row>
               </cfoutput>
               <Row ss:AutoFitHeight="0" ss:Height="12"/>
    		</cfloop>	 
				
            	<cfoutput>
 					<cfwddx action = "cfml2wddx" input = "#grandForeignDiscount#" output = "wddxText25">
                    <cfwddx action = "cfml2wddx" input = "#grandForeignTax#" output = "wddxText26">
                    <cfwddx action = "cfml2wddx" input = "#dtotal#" output = "wddxText27">
                    <cfwddx action = "cfml2wddx" input = "#ttotal#" output = "wddxText28">
                    
                  	<Row ss:AutoFitHeight="0">
 
                        <cfif lcase(hcomid) eq "ecraft_i" or lcase(hcomid) eq "ovas_i">     
                            <Cell ss:StyleID="s27"></Cell>
                        </cfif>   
                        
                        <cfif lcase(hcomid) eq "colorinc_i">
                            <Cell ss:StyleID="s27"></Cell>   
                            <Cell ss:StyleID="s27"></Cell>
                            <Cell ss:StyleID="s27"></Cell> 
                        	<Cell ss:StyleID="s27"></Cell> 
                        </cfif>
                        
                        <cfif lcase(hcomid) eq "leadbuilders_i" or lcase(hcomid) eq "yushita_i" or lcase(hcomid) eq "walmart_i" or lcase(hcomid) eq "aurumbuilds_i ">
                            <Cell ss:StyleID="s27"></Cell>   
                            <Cell ss:StyleID="s27"></Cell>
                            <Cell ss:StyleID="s27"></Cell>   
                            <Cell ss:StyleID="s27"></Cell>
                            <Cell ss:StyleID="s27"></Cell>   
                            <Cell ss:StyleID="s27"></Cell>
                            <Cell ss:StyleID="s27"></Cell>   
                        </cfif>
                        
                        <Cell ss:StyleID="s27"><Data ss:Type="String">TOTAL:</Data></Cell> 
                        <Cell ss:StyleID="s27"></Cell>
                        <Cell ss:StyleID="s27"><Data ss:Type="Number">#NumberFormat(totalqty,"0")#</Data></Cell>
                        <Cell ss:StyleID="s27"><Data ss:Type="String">F.DISC: #wddxText25#</Data></Cell> 
                        <Cell ss:StyleID="s27"><Data ss:Type="String">F.TAX: #wddxText26#</Data></Cell> 
                        <Cell ss:StyleID="s27"><Data ss:Type="String">F.TOTAL=#NumberFormat(grandForeignTotal,",.__")#</Data></Cell>
                        <Cell ss:StyleID="s27"><Data ss:Type="String">DISC: #wddxText27#</Data></Cell> 
                        <Cell ss:StyleID="s27"><Data ss:Type="String">TAX: #wddxText28#</Data></Cell> 
                        <Cell ss:StyleID="s27"><Data ss:Type="String">TOTAL=#NumberFormat(total,",.__")#</Data></Cell>
                        <Cell ss:StyleID="s27"></Cell>
                  </Row>	
	        	</cfoutput>
			</Table>
            
              
            
			<WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">
		   	<Unsynced/>
		   	<Print>
				<ValidPrinterInfo/>
				<Scale>60</Scale>
				<HorizontalResolution>600</HorizontalResolution>
				<VerticalResolution>600</VerticalResolution>
		   	</Print>
		   	<Selected/>
		   	<Panes>
				<Pane>
					<Number>3</Number>
			 		<ActiveRow>20</ActiveRow>
			 		<ActiveCol>3</ActiveCol>
				</Pane>
		   	</Panes>
		   	<ProtectObjects>False</ProtectObjects>
		   	<ProtectScenarios>False</ProtectScenarios>
		  	</WorksheetOptions>
		 	</Worksheet>
			</Workbook>
		</cfxml>

		<cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\#dts#_BL_#huserid#.xls" output="#tostring(data)#" charset="utf-8">
		<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\#dts#_BL_#huserid#.xls">

</cfif>