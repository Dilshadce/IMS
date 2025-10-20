<cfinclude template="/object/dateobject.cfm">
<html>
<head>
<title>No Batch Code Report</title>
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

<cfif isdefined("form.datefrom")>
	<cfset dd = dateformat(form.datefrom, "DD")>	
	<cfif dd greater than '12'>
		<cfset ndatefrom = dateformat(form.datefrom,"YYYYMMDD")>
	<cfelse>
		<cfset ndatefrom = dateformat(form.datefrom,"YYYYDDMM")>
	</cfif>
</cfif>

<cfset totalnet= 0>
<cfset totaltax = 0>
<cfset totalgrand = 0>

<body>
<cfoutput>
<table width="100%" border="0" cellspacing="0" cellpadding="2" class="data">
	<tr>
		<td colspan="100%"><div align="center"><font size="3" face="Times New Roman,Times,serif"><strong>Print Overdue Delivery Order(Over 21 Days Not Updated)</strong></font></div></td>
	</tr>
    <!---<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
        <tr> 
          	<td colspan="100%"><div align="center"><font size="2" face="Times New Roman,Times,serif">CUST: #form.custfrom# - #form.custto#</font></div></td>
        </tr>
    </cfif>--->
    <tr> 
      	<td colspan="4"><font size="2" face="Times New Roman,Times,serif">#getgeneral.compro#</font></td>
      	<td colspan="8"><div align="right"><font size="2" face="Times New Roman,Times,serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
    </tr>
    <tr> 
      	<td colspan="100%"><hr></td>
    </tr>
    <tr>
	  	<td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>Ref No</strong></font></div></td>
      	<td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>Date</strong></font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>Period</strong></font></div></td>
		
      	<td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>Customer</strong></font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman,Times,serif"><strong>Net Amount</strong></font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman,Times,serif"><strong>Tax Amount</strong></font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman,Times,serif"><strong>Grand Amount</strong></font></div></td>
    </tr>
    <tr> 
      	<td colspan="100%"><hr></td>
    </tr>

	<cfquery name="gettran" datasource="#dts#">
		select * from artran where type="DO"
		and (void='' or void is null) and 
		(toinv="" or toinv is null)
        
		 <!---<cfif (trim(form.custfrom) neq "" and trim(form.custto) neq "")>
		 	and custno between '#form.custfrom#' and '#form.custto#' 
		 </cfif>--->
		 <cfif form.datefrom neq "">
		 	and wos_date < '#dateformat(dateadd('d','-21',dateformatnew(form.datefrom,'yyyy-mm-dd')),'yyyy-mm-dd')#'
         <cfelse>
         	and wos_date < #dateformat(dateadd('d','-21',now()),'yyyy-mm-dd')#
		 </cfif>
         
         <!---UNION ALL
         
        select a.* from artran left join (select wos_date from artran where type="INV" and (void='' or void is null) and fperiod<>"99")as b on a.toinv=b.refno
        where type="DO"
		and (void='' or void is null) and 
		(toinv <> "")
		 <cfif form.datefrom neq "">
		 	and DATE_ADD(wos_date,INTERVAL 21 DAY) > '#ndatefrom#'
         <cfelse>
         	and DATE_ADD(wos_date,INTERVAL 21 DAY) > now()
		 </cfif> --->
         
         
		 order by wos_date
	</cfquery>
	
	<cfloop query="gettran">
	
    <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
    <td><div align="left"><font  face="Times New Roman,Times,serif">#gettran.refno#</font></div></td>
    <td><div align="left"><font  face="Times New Roman,Times,serif">#dateformat(gettran.wos_date,'DD/MM/YYYY')#</font></div></td>
    <td><div align="left"><font  face="Times New Roman,Times,serif">#gettran.fperiod#</font></div></td>
    <td><div align="left"><font  face="Times New Roman,Times,serif">#gettran.custno# #gettran.name#</font></div></td>
    <td><div align="right"><font  face="Times New Roman,Times,serif">#numberformat(gettran.net,'_.__')#</font></div></td>
    <td><div align="right"><font  face="Times New Roman,Times,serif">#numberformat(gettran.tax,'_.__')#</font></div></td>
    <td><div align="right"><font  face="Times New Roman,Times,serif">#numberformat(gettran.grand,'_.__')#</font></div></td>
    </tr>
    <cfset totalnet= totalnet+gettran.net>
	<cfset totaltax = totaltax+gettran.tax>
    <cfset totalgrand = totalgrand+gettran.grand>
		<tr><td><br></td></tr>
	</cfloop>
	<tr> 
		<td colspan="100%"><hr></td>
	</tr>
    <tr>
    <td><div align="left"><font  face="Times New Roman,Times,serif"></font></div></td>
    <td><div align="left"><font  face="Times New Roman,Times,serif"></font></div></td>
    <td><div align="left"><font  face="Times New Roman,Times,serif"></font></div></td>
    <td><div align="left"><font  face="Times New Roman,Times,serif"></font></div></td>
    <td><div align="right"><font  face="Times New Roman,Times,serif">#numberformat(totalnet,'_.__')#</font></div></td>
    <td><div align="right"><font  face="Times New Roman,Times,serif">#numberformat(totaltax,'_.__')#</font></div></td>
    <td><div align="right"><font  face="Times New Roman,Times,serif">#numberformat(totalgrand,'_.__')#</font></div></td>
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