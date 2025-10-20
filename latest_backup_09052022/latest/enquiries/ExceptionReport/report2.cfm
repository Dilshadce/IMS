<html>
<head>
<title>No Location Report</title>
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
<style type="text/css" media="print">
	.noprint { display: none; }
</style>
</head>

<cfquery name="getgeneral" datasource="#dts#">
	select compro,lastaccyear from gsetup
</cfquery>

<cfquery name="getgsetup2" datasource='#dts#'>
  Select * from gsetup2
</cfquery>

<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
<cfset stDecl_UPrice = ",.">

<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
  <cfset stDecl_UPrice = stDecl_UPrice & "_">
</cfloop>

<cfif isdefined("form.dateFrom") and isdefined("form.dateTo")>
	<cfset dd = dateformat(form.dateFrom, "DD")>	
	<cfif dd greater than '12'>
		<cfset ndatefrom = dateformat(form.dateFrom,"YYYYMMDD")>
	<cfelse>
		<cfset ndatefrom = dateformat(form.dateFrom,"YYYYDDMM")>
	</cfif>
	
	<cfset dd = dateformat(form.dateTo, "DD")>	
	<cfif dd greater than '12'>
		<cfset ndateto = dateformat(form.dateTo,"YYYYMMDD")>
	<cfelse>
		<cfset ndateto = dateformat(form.dateTo,"YYYYDDMM")>
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
		<td colspan="100%"><div align="center"><font size="3" face="Times New Roman,Times,serif"><strong>Print No Agent Report</strong></font></div></td>
	</tr>
    <cfif form.periodFrom neq "" and form.periodTo neq "">
		<tr> 
			<td colspan="100%"><div align="center"><font size="2" face="Times New Roman,Times,serif">PERIOD: #form.periodFrom# - #form.periodTo#</font></div></td>
		</tr>
	</cfif>
	<cfif form.dateFrom neq "" and form.dateTo neq "">
		<tr> 
      		<td colspan="100%"><div align="center"><font size="2" face="Times New Roman,Times,serif">DATE: #dateformat(form.dateFrom,"dd/mm/yyyy")# - #dateformat(form.dateTo,"dd/mm/yyyy")#</font></div></td>
    	</tr>
	</cfif>
    <cfif trim(form.customerFrom) neq "" and trim(form.customerTo) neq "">
        <tr> 
          	<td colspan="100%"><div align="center"><font size="2" face="Times New Roman,Times,serif">CUST: #form.customerFrom# - #form.customerTo#</font></div></td>
        </tr>
    </cfif>
    <cfif trim(form.supplierFrom) neq "" and trim(form.supplierTo) neq "">
        <tr> 
          	<td colspan="100%"><div align="center"><font size="2" face="Times New Roman,Times,serif">SUPP: #form.supplierFrom# - #form.supplierTo#</font></div></td>
        </tr>
    </cfif>
    
    <cfif form.projectFrom neq "" and form.projectTo neq "">
        <tr> 
          	<td colspan="100%"><div align="center"><font size="2" face="Times New Roman,Times,serif">PROJECT NO: #form.projectFrom# - #form.projectTo#</font></div></td>
        </tr>
    </cfif>
	<cfif form.refNoFrom neq "" and form.refto neq "">
        <tr> 
          	<td colspan="100%"><div align="center"><font size="2" face="Times New Roman,Times,serif">REF NO: #form.refNoFrom# - #form.refto#</font></div></td>
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
      	<td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>Type</strong></font></div></td>
	  	<td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>Ref No</strong></font></div></td>
      	<td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>Date</strong></font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>Period</strong></font></div></td>
		
		<td><div align="right"><font size="2" face="Times New Roman,Times,serif"><strong>Amount</strong></font></div></td>
		<td colspan="3"><div align="right"><font size="2" face="Times New Roman,Times,serif"><strong>Agent</strong></font></div></td>

    </tr>
    <tr> 
      	<td colspan="100%"><hr></td>
    </tr>

	<cfquery name="gettran" datasource="#dts#">
		select * from artran where 
		(void='' or void is null) and 
		(<cfloop index="a" from="1" to="#arraylen(str)#">
			<cfif str[a] neq "">
				type='#str[a]#' <cfif a neq 13 and str[a+1] neq ''>or</cfif>
			</cfif>
		 </cfloop>) 
		 <cfif form.refNoFrom neq "" and form.refto neq "">
		 	and refno between '#form.refNoFrom#' and '#form.refto#' 
		 </cfif>
		 <cfif (trim(form.customerFrom) neq "" and trim(form.customerTo) neq "") and (trim(form.supplierFrom) eq "" and trim(form.supplierTo) eq "")>
		 	and custno between '#form.customerFrom#' and '#form.customerTo#' 
		 <cfelseif (trim(form.supplierFrom) neq "" and trim(form.supplierTo) neq "") and (trim(form.customerFrom) eq "" and trim(form.customerTo) eq "")>
			 and custno between '#form.supplierFrom#' and '#form.supplierTo#'
		 </cfif>
		 
         <cfif form.projectFrom neq "" and form.projectTo neq "">
		 	and source between '#form.projectFrom#' and '#form.projectTo#' 
		 </cfif>
		 <cfif form.periodFrom neq "" and form.periodTo neq "">
		 	and fperiod between '#form.periodFrom#' and '#form.periodTo#'
		 </cfif>
		 <cfif form.dateFrom neq "" and form.dateTo neq "">
		 	and wos_date between '#ndatefrom#' and '#ndateto#'
		 </cfif>
          and (agenno ='' or agenno is null)
          
		 order by type,refno,wos_date
	</cfquery>
	
	<cfloop query="gettran">
	
    <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
    <td><div align="left"><font  face="Times New Roman,Times,serif">#gettran.type#</font></div></td>
    <td><div align="left"><font  face="Times New Roman,Times,serif">#gettran.refno#</font></div></td>
    <td><div align="left"><font  face="Times New Roman,Times,serif">#dateformat(gettran.wos_date,'DD/MM/YYYY')#</font></div></td>
    <td><div align="left"><font  face="Times New Roman,Times,serif">#gettran.fperiod#</font></div></td>
    <td><div align="right"><font  face="Times New Roman,Times,serif">#numberformat(gettran.grand,',_.__')#</font></div></td>
    <td><div align="right"><font  face="Times New Roman,Times,serif">#gettran.agenno#</font></div></td>
    </tr>
    
		<tr><td><br></td></tr>
	</cfloop>
	<tr> 
		<td colspan="100%"><hr></td>
	</tr>
	
</table>

</cfoutput>

<cfif gettran.recordcount eq 0>
	<h3 style="color:red">Sorry, No records were found.</h3>
</cfif>

<br><br>

<div align="right">
	<font  face="Arial,Helvetica,sans-serif">
		<a href="javascript:print()" class="noprint"><u>Print</u></a>
	</font>
</div>

<p class="noprint">
	<font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font>
</p>

</body>
</html>