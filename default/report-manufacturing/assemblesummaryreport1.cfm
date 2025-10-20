<html>
<head>
<title>Print Assemble Summary Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
</head>

<cfquery name="getgeneral" datasource="#dts#">
	select a.compro,concat(',.',repeat('_',b.decl_uprice)) as decl_uprice ,a.LASTACCYEAR
	from gsetup as a, gsetup2 as b
</cfquery>

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

<cfquery datasource="#dts#" name="gettran">
	select refno from ictran
	where 
	type='RC' 
	and (void='' or void is null)
    and custno ='ASSM/999'
	
	<cfif ndatefrom neq "" and ndateto neq "">
		and wos_date between '#ndatefrom#' and '#ndateto#'
	<cfelse>
		and wos_date > #getgeneral.lastaccyear#
	</cfif>
		
	<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod between '#form.periodfrom#' and '#form.periodto#' 
	</cfif>
	<cfif form.billfrom neq "" and form.billto neq "">
		and refno between '#form.billfrom#' and '#form.billto#'
	</cfif>
	<cfif form.locationfrom neq "" and form.locationto neq "">
		and location between '#form.locationfrom#' and '#form.locationto#'
	</cfif>
    group by refno
	order by refno
</cfquery>


<cfset totalqtyrec=0>

<body>
<div align="center"><font color="#000000" size="4" face="Times New Roman, Times, serif">Assemble Summary Report</font></div>

<cfif gettran.recordcount gt 0>
  <table width="100%" border="0" cellpadding="3" align="center">
    <cfoutput>
			<cfif form.billfrom neq "" and form.billto neq "">
				<tr>
					<td colspan="11"><div align="center"><font size="1.5" face="Arial, Helvetica, sans-serif">Ref No From #form.billfrom# To #form.billto#</font></div></td>
				</tr>
			</cfif>
			<cfif ndatefrom neq "" and ndateto neq "">
				<tr>
					<td colspan="11"><div align="center"><font size="1.5" face="Arial, Helvetica, sans-serif">#form.datefrom# - #form.dateto#</font></div></td>
				</tr>
			</cfif>
			<cfif form.periodfrom neq "" and form.periodto neq "">
				<tr>
					<td colspan="11"><div align="center"><font size="1.5" face="Arial, Helvetica, sans-serif">Period From #form.periodfrom# To #form.periodto#</font></div></td>
				</tr>
			</cfif>
			<cfif form.locationfrom neq "" and form.locationto neq "">
				<tr>
					<td colspan="11"><div align="center"><font size="1.5" face="Arial, Helvetica, sans-serif">Location From #form.locationfrom# To #form.locationto#</font></div></td>
				</tr>
			</cfif>
    </cfoutput>
    <tr>
      <td colspan="7"><cfif getgeneral.compro neq "">
          <font size="2" face="Times New Roman, Times, serif"><cfoutput>#getgeneral.compro#</cfoutput></font> </cfif> </td>
      <td>&nbsp;</td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#dateformat(now(),"dd/mm/yyyy")#</cfoutput></font></div></td>
    </tr>
    <tr>
      <td colspan="100%"><hr></td>
    </tr>
    <tr>
      <td><font size="2" face="Times New Roman, Times, serif"><strong>ITEM
        NO</strong></font></td>
       <td><font size="2" face="Times New Roman, Times, serif"><strong>RC NO</strong></font></td> 
        
      <td><font size="2" face="Times New Roman, Times, serif"><div align="right">QTY REC</div></font></td>
      <td colspan="2"><font size="2" face="Times New Roman, Times, serif"><strong>MATERIAL</strong></font></td>
      <td><div align="center"><font size="2" face="Times New Roman, Times, serif">ISS NO</font></div></td>
	  <td><div align="center"><font size="2" face="Times New Roman, Times, serif">QTY REQ</font></div></td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif">Price</font></div></td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif">Amount</font></div></td>
    </tr>
    <tr>
      <td colspan="100%"><hr></td>
    </tr>
    <cfloop query="gettran">
    <cfquery name="getpono" datasource="#dts#">
    select pono,refno from artran where refno='#gettran.refno#' and type='RC'
    </cfquery>
    
    <cftry>
    	  <cfif getpono.pono neq ''>
          <cfset issueno=getpono.pono>
          <cfelse>
          <cfset issueno=getpono.refno>
          </cfif>
          <cfcatch>
          <cfset issueno=''>
          </cfcatch>
          </cftry>
    
      <cfquery name="getdata" datasource="#dts#">
      select itemno,price,qty,desp,refno from ictran where refno='#issueno#' and type='ISS'
      </cfquery>
      <cfquery name="getitemrec" datasource="#dts#">
      select itemno,refno,qty from ictran where refno='#gettran.refno#' and type='RC'
      </cfquery>
        <cfoutput>
        <cfloop query="getitemrec">
        <cfset totalqtyrec=totalqtyrec+getitemrec.qty>
          <tr>
            <td><font size="2" face="Times New Roman, Times, serif">#getitemrec.Itemno#</font> <div align="left"></div></td>
            <td> <font size="2" face="Times New Roman, Times, serif">#getitemrec.refno# </font> <div align="center"><font size="2" face="Times New Roman, Times, serif"></font></div></td>
            <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#getitemrec.qty# </font> </div></td>
          </tr>
          </cfloop>
        </cfoutput>
        <cfset totalcost = 0>
        <cfset totalqty = 0>
        <cfoutput>
        <cfloop query="getdata">
          
          <cfif getdata.recordcount neq 0>
          <cfset itemcost = getdata.price*getdata.qty>
          <cfset totalcost = totalcost + itemcost>
          <cfset totalqty = totalqty + getdata.qty>

          <tr>
            <td><div align="center"></div></td>
            <td></td>
            <TD></TD>
            <td><font size="2" face="Times New Roman, Times, serif">&nbsp;#getdata.itemno#</font></td>
            <td nowrap><div align="left"><font size="2" face="Times New Roman, Times, serif">#getdata.desp#</font></div></td>
            <td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">#getdata.refno#</font></div></td>
            <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#getdata.qty#</font></div></td>
            <td nowrap><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getdata.price,getgeneral.decl_uprice)#</font></div></td>
            <td> <div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(itemcost,getgeneral.decl_uprice)#</font></div></td>
          </tr>
          </cfif>
          </cfloop>
        </cfoutput>
        <!--- getdata --->
        <cfoutput>
          <tr>
            <td colspan="5">&nbsp;</td>
            <td colspan="4"><div align="right">________________________________________________</div></td>
          </tr>
          <tr>
            <td><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></td>
          
            <td colspan="4"><font size="2" face="Times New Roman, Times, serif"></font></td>
            <td nowrap><div align="right"><font size="2" face="Times New Roman, Times, serif">Total Qty</font></div></td>
            <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#totalqty#</font></div></td>
            <td><div align="right"><font size="2" face="Times New Roman, Times, serif">Total Amount</font></div></td>
            <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(totalcost,getgeneral.decl_uprice)#</font></div></td>
          </tr>
        </cfoutput>

      <tr>
        <td colspan="100%"><hr></td>
      </tr>

    </cfloop>
    <cfoutput>
    <tr>
    <td></td>
    <td nowrap><font size="2" face="Times New Roman, Times, serif">Total:</font></td>
    <td nowrap><div align="right"><font size="2" face="Times New Roman, Times, serif">#totalqtyrec#</font></div></td>
    </tr>
    </cfoutput>
    <!--- gettran --->
  </table>

<cfelse>
  Sorry. No Records.

</cfif>
</body>
</html>
