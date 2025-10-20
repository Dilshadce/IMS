<html>
<head>
<title>Item Batch Stock Card</title>
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
<style type="text/css" media="print">
	.noprint { display: none; }
</style>
</head>
<cfquery name="getgeneral" datasource="#dts#">
	select compro, lastaccyear from gsetup
</cfquery>
<cfquery name="checkcustom" datasource="#dts#">
    select customcompany from dealer_menu
</cfquery>

<cfif form.datefrom neq "" and form.dateto neq "">
	<cfset date1=createDate(ListGetAt(form.datefrom,3,"/"),ListGetAt(form.datefrom,2,"/"),ListGetAt(form.datefrom,1,"/"))>
	<cfset date2=createDate(ListGetAt(form.dateto,3,"/"),ListGetAt(form.dateto,2,"/"),ListGetAt(form.dateto,1,"/"))>
</cfif>
<cfquery name="getictran" datasource="#dts#">
	select a.itemno,a.refno,a.type,a.wos_date,a.custno,a.name,a.qty,a.amt,a.location,a.batchcode,a.milcert,a.importpermit<cfif checkcustom.customcompany eq "Y">,a.brem5,a.brem7,a.brem8,a.brem9,a.brem10</cfif>,b.*
	from ictran a
	
	left join(
		select a.itemno,a.desp as itemdesp,a.unit,a.unit2,a.factor1,a.factor2,a.category,b.desp as sizeid,c.desp as countryoforigin
		from icitem a
		left join icsizeid b on a.sizeid=b.sizeid
		left join iccolorid c on a.colorid=c.colorid
		<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
			where a.itemno between '#form.productfrom#' and '#form.productto#'
		</cfif>
	)as b on (a.itemno=b.itemno)
	
	where (a.void = '' or a.void is null) and a.batchcode<>'' and a.location<>'' and (linecode <> 'SV' or linecode is null)
	and (type = 'INV' or type = 'CN' or type = 'DN' or type = 'CS' or type = 'PR' or type = 'RC' or type = 'DO'
	or type = 'ISS' or type = 'OAI' or type = 'OAR' or type = 'TRIN' or type = 'TROU')
	<cfif form.datefrom neq "" and form.dateto neq "">
		and wos_date between #date1# and #date2#
	</cfif>
	<cfif form.locationfrom neq "" and form.locationto neq "">
		and a.location between '#form.locationfrom#' and '#form.locationto#'
	</cfif>
	<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
		and a.itemno between '#form.productfrom#' and '#form.productto#'
	</cfif>
	<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
		and a.batchcode between '#form.batchcodefrom#' and '#form.batchcodeto#'
	</cfif>
    <cfif form.milcert neq "">
				and a.milcert = "#form.milcert#"
	</cfif>
    <cfif form.importpermit neq "">
				and a.importpermit = "#form.importpermit#"
	</cfif>
	<cfif lcase(hcomid) eq "jaynbtrading_i">
		<cfif trim(form.customerfrom) neq "" and trim(form.customerto) neq "">
			and a.custno between '#form.customerfrom#' and '#form.customerto#'
		</cfif>
	</cfif>
	<cfif checkcustom.customcompany eq "Y">
		<!--- <cfif trim(form.permitno) neq "">
			and (a.brem5='#form.permitno#' or a.brem7='#form.permitno#' or a.brem8='#form.permitno#' or a.brem9='#form.permitno#' or a.brem10='#form.permitno#')
		</cfif> --->
        <cfif trim(form.permitno) neq "">
			and a.batchcode in 
            (
            	select batchcode from ictran
                where batchcode<>'' and (void = '' or void is null) and location<>'' and (linecode <> 'SV' or linecode is null)
                and (type = 'INV' or type = 'CN' or type = 'DN' or type = 'CS' or type = 'PR' or type = 'RC' or type = 'DO'
                or type = 'ISS' or type = 'OAI' or type = 'OAR' or type = 'TRIN' or type = 'TROU')
                and (brem5='#form.permitno#' or brem7='#form.permitno#' or brem8='#form.permitno#' or brem9='#form.permitno#' or brem10='#form.permitno#')
                <cfif form.datefrom neq "" and form.dateto neq "">
                    and wos_date between #date1# and #date2#
                </cfif>
                <cfif form.locationfrom neq "" and form.locationto neq "">
                    and location between '#form.locationfrom#' and '#form.locationto#'
                </cfif>
                <cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
                    and itemno between '#form.productfrom#' and '#form.productto#'
                </cfif>
                <cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
                    and batchcode between '#form.batchcodefrom#' and '#form.batchcodeto#'
                </cfif>
                group by batchcode
            )
		</cfif>
	</cfif>
	order by a.itemno,a.wos_date
</cfquery>
<body>
<p align="center"><font color="#000000" size="4" face="Times New Roman, Times, serif"><strong>LOT NUMBER STOCK MOVEMENT REPORT</strong></font></p>
<cfoutput>
<table width="100%" border="0" align="center" cellspacing="0">
    <cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
      	<tr>
        	<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif"><cfif checkcustom.customcompany eq "Y">LOT NUMBER<cfelse>BATCH CODE</cfif>: #form.batchcodefrom# - #form.batchcodeto#</font></div></td>
      	</tr>
    </cfif>
	<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
		<tr>
			<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">ITEM NO: #form.productfrom# - #form.productto#</font></div></td>
		</tr>
	</cfif>
	<cfif form.datefrom neq "" and form.dateto neq "">
		<tr>
			<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">DATE: #dateformat(date1,"dd/mm/yyyy")# - #dateformat(date2,"dd/mm/yyyy")#</font></div></td>
		</tr>
	</cfif>
    <tr>
      	<td colspan="5"><cfif getgeneral.compro neq ""><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></cfif></td>
		<td colspan="4"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
    </tr>
	<tr>
		<td colspan="100%"><hr></td>
	</tr>
	<tr>
		<td><div align="left"><font size="1" face="Times New Roman, Times, serif">LOCATION</font></div></td>
		<td><div align="left"><font size="1" face="Times New Roman, Times, serif">DATE</font></div></td>
    	<td><div align="left"><font size="1" face="Times New Roman, Times, serif">REF NO.</font></div></td>
		<cfif lcase(hcomid) eq "jaynbtrading_i">
			<td><div align="left"><font size="1" face="Times New Roman, Times, serif">CUSTOMER/SUPPLIER</font></div></td>
		</cfif>
		<td><div align="left"><font size="1" face="Times New Roman, Times, serif">DESCRIPTION</font></div></td>
		<td><div align="center"><font size="1" face="Times New Roman, Times, serif">ORI. COUNTRY</font></div></td>
		<cfif checkcustom.customcompany eq "Y">
			<td><div align="left"><font size="1" face="Times New Roman, Times, serif">PERMIT NO</font></div></td>
		</cfif>
		<td><div align="left"><font size="1" face="Times New Roman, Times, serif"><cfif checkcustom.customcompany eq "Y">LOT NUMBER<cfelse>ITEM BATCH</cfif></font></div></td>
        
        
        <td><div align="left"><font size="2" face="Times New Roman, Times, serif"><cfif lcase(hcomid) eq "marquis_i">Lot Number<cfelse>Mil Cert</cfif></font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">Import Permit</font></div></td>
		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">IN</font></div></td>
		<td><div align="right"><font size="1" face="Times New Roman, Times, serif">OUT</font></div></td>
        
        <td><div align="right"><font size="1" face="Times New Roman, Times, serif">UNITS</font></div></td>
		<!--- <td><div align="right"><font size="2" face="Times New Roman, Times, serif">AMOUNT</font></div></td> --->
	</tr>
	<tr>
		<td colspan="100%"><hr></td>
	</tr>
	<cfloop query="getictran">
		<cfset xfactor1=getictran.factor1>
		<cfset xfactor2=getictran.factor2>
		<cfset xunit=getictran.unit>
		<cfset xunit2=getictran.unit2>
		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
			<td><div align="left"><font size="1" face="Times New Roman, Times, serif">#getictran.location#</font></div></td>
			<td><div align="left"><font size="1" face="Times New Roman, Times, serif">#dateformat(getictran.wos_date,"dd-mm-yy")#</font></div></td>
			<td><div align="left"><font size="1" face="Times New Roman, Times, serif">#getictran.type# #getictran.refno#</font></div></td>
			<cfif lcase(hcomid) eq "jaynbtrading_i">
				<td><div align="left"><font size="1" face="Times New Roman, Times, serif">#getictran.name#</font></div></td>
			</cfif>
			<td><div align="left"><font size="1" face="Times New Roman, Times, serif">#getictran.itemdesp#  #getictran.category#<cfif getictran.sizeid neq ""> (#getictran.sizeid#)</cfif></font></div></td>
			<td><div align="center"><font size="1" face="Times New Roman, Times, serif">#getictran.countryoforigin#</font></div></td>
			<cfif checkcustom.customcompany eq "Y">
			<td><div align="left"><font size="1" face="Times New Roman, Times, serif">
				<cfif getictran.type eq "RC" or getictran.type eq "OAI" or getictran.type eq "TRIN" or getictran.type eq "CN">
					<cfif getictran.brem5 neq "">
						#getictran.brem5#
					<cfelseif getictran.brem7 neq "">
						#getictran.brem7#
					</cfif>
				<cfelse>
					<cfif getictran.brem8 neq "">
						#getictran.brem8#
					<cfelseif getictran.brem9 neq "">
						#getictran.brem9#
					<cfelseif getictran.brem10 neq "">
						#getictran.brem10#
					</cfif>
				</cfif>
			</font></div></td>
			</cfif>
			<td><div align="left"><font size="1" face="Times New Roman, Times, serif">#getictran.batchcode#</font></div></td>
            
            
            
            
            <td><div align="left"><font size="1" face="Times New Roman, Times, serif">#getictran.milcert#</font></div></td>
            <td><div align="left"><font size="1" face="Times New Roman, Times, serif">#getictran.importpermit#</font></div></td>
			<cfif val(xfactor1) neq 0>
				<cfif val(getictran.qty) gte 0>
					<cfset xqty=val(getictran.qty)/val(xfactor1)*val(xfactor2)>
				<cfelse>
					<cfset xqty=-(val(getictran.qty)/val(xfactor1)*val(xfactor2))>
				</cfif>
						
				<cfset xqty=Int(xqty)>
				<cfif val(xfactor2) neq 0>
					<cfset yqty=val(getictran.qty)-(xqty*val(xfactor1)/val(xfactor2))>
				<cfelse>
					<cfset yqty=0>
				</cfif>
			<cfelse>
				<cfset xqty=0>
				<cfset yqty=val(getictran.qty)>
			</cfif>
			<cfif getictran.type eq "RC" or getictran.type eq "CN" or getictran.type eq "OAI" or getictran.type eq "TRIN">
				<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#xqty# #xunit2# #yqty# #xunit#</font></div></td>
				<td>&nbsp;</td>
                <td><div align="left"><font size="1" face="Times New Roman, Times, serif">#getictran.unit#</font></div></td>
			<cfelse>
				<td></td>
				<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#xqty# #xunit2# #yqty# #xunit#</font></div></td>
			</cfif>
			<!--- <td><font size="2" face="Times New Roman, Times, serif"><div align="right">#numberformat(getictran.amt,",.____")#</div></font></td> --->
		</tr>
	</cfloop>
</table>
</cfoutput>
</body>
<br>
<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
</body>
</html>