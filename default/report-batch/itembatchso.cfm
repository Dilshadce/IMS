<html>
<head>
<title>Item Batch SO</title>
<link href="../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
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

<cfquery name="getinfo" datasource="#dts#">
	select sum(a.qty) as soqty,a.itemno,a.location,a.batchcode,a.unit,a.milcert,a.importpermit,b.itemdesp,
	(ifnull(c.bth_qob,0)+ifnull(d.lastin,0)-ifnull(e.lastout,0)) as balance
	from ictran a
	
	left join(
		select a.itemno,a.desp as itemdesp
		from icitem a
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			where a.itemno between '#form.itemfrom#' and '#form.itemto#'
		</cfif>
	)as b on (a.itemno=b.itemno)
	
	left join(
		select bth_qob,itemno,location,batchcode
		from lobthob
		where itemno <> ''
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and itemno between '#form.itemfrom#' and '#form.itemto#'
		</cfif>
		<cfif form.locationfrom neq "" and form.locationto neq "">
			and location between '#form.locationfrom#' and '#form.locationto#'
		</cfif>
		<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
			and batchcode between '#form.batchcodefrom#' and '#form.batchcodeto#'
		</cfif>
	)as c on (a.itemno=c.itemno and a.batchcode=c.batchcode and a.location=c.location)
	
	left join
	(	select sum(qty) as lastin,itemno,location,batchcode 
		from ictran
		where (type = 'RC' or type = 'CN' or type = 'OAI' or type = 'TRIN') 
		and (void = '' or void is null) and batchcode<>''
		and fperiod <> '99' and (linecode <> 'SV' or linecode is null)
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and itemno between '#form.itemfrom#' and '#form.itemto#'
		</cfif>
		<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
			and batchcode between '#form.batchcodefrom#' and '#form.batchcodeto#'
		</cfif>
		<cfif form.locationfrom neq "" and form.locationto neq "">
			and location between '#form.locationfrom#' and '#form.locationto#'
		</cfif>
		<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
			and custno between '#form.custfrom#' and '#form.custto#'
		</cfif>
		group by itemno,location,batchcode
	) as d on (a.itemno=d.itemno and a.batchcode=d.batchcode and a.location=d.location)

	left join
	(	select sum(qty) as lastout,itemno,location,batchcode 
		from ictran
		where (type = 'INV' or type = 'PR' or type = 'CS' or type = 'DN' or type = 'ISS' or type = 'OAR' or type = 'TROU' or type = 'DO')
		and (void = '' or void is null) and toinv='' and batchcode<>''
		and fperiod <> '99' and (linecode <> 'SV' or linecode is null)
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and itemno between '#form.itemfrom#' and '#form.itemto#'
		</cfif>
		<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
			and batchcode between '#form.batchcodefrom#' and '#form.batchcodeto#'
		</cfif>
		<cfif form.locationfrom neq "" and form.locationto neq "">
			and location between '#form.locationfrom#' and '#form.locationto#'
		</cfif>
		<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
			and custno between '#form.custfrom#' and '#form.custto#'
		</cfif>
		group by itemno,batchcode
	) as e on (a.itemno=e.itemno and a.batchcode=e.batchcode and a.location=e.location)
	
	where (a.void = '' or a.void is null) and a.batchcode<>'' and a.location<>'' and fperiod <> '99' and (linecode <> 'SV' or linecode is null)
	and type = 'SO'
	and (a.qty-a.shipped) > 0
	<cfif form.locationfrom neq "" and form.locationto neq "">
		and a.location between '#form.locationfrom#' and '#form.locationto#'
	</cfif>
	<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
		and a.itemno between '#form.itemfrom#' and '#form.itemto#'
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
	<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
		and a.custno between '#form.custfrom#' and '#form.custto#'
	</cfif>
	group by a.itemno,a.location,a.batchcode,b.itemdesp
	order by a.itemno,a.location
</cfquery>
<body>
<p align="center"><font color="#000000" size="4" face="Times New Roman, Times, serif"><strong>LOT NUMBER OUTSTANDING SALES ORDER REPORT</strong></font></p>

<table width="100%" border="0" align="center" cellspacing="0">
    <cfoutput>
	<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
      	<tr>
        	<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif"><cfif checkcustom.customcompany eq "Y">LOT NUMBER<cfelse>BATCH CODE</cfif>: #form.batchcodefrom# - #form.batchcodeto#</font></div></td>
      	</tr>
    </cfif>
	<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
		<tr>
			<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">ITEM NO: #form.itemfrom# - #form.itemto#</font></div></td>
		</tr>
	</cfif>
    <tr>
      	<td colspan="4"><cfif getgeneral.compro neq ""><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></cfif></td>
		<td colspan="3"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
    </tr>
	</cfoutput>
	<tr>
		<td colspan="100%"><hr></td>
	</tr>
	<tr>
		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">ITEM NO</font></div></td>
    	<td><div align="left"><font size="2" face="Times New Roman, Times, serif">ITEM DESCRIPTION</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><cfif checkcustom.customcompany eq "Y">LOT NUMBER<cfelse>ITEM BATCH</cfif></font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman, Times, serif"><cfif lcase(hcomid) eq "marquis_i">Lot Number<cfelse>Mil Cert</cfif></font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">Import Permit</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">LOCATION</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">QTY ORDERED</font></div></td>
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">UNITS</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">BALANCE</font></div></td>
		<td><div align="center"><font size="2" face="Times New Roman, Times, serif">ACTION</font></div></td>		
	</tr>
	<tr>
		<td colspan="100%"><hr></td>
	</tr>
	<cfoutput query="getinfo">
		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getinfo.itemno#</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getinfo.itemdesp#</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getinfo.batchcode#</font></div></td>
            <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getinfo.milcert#</font></div></td>
            <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getinfo.importpermit#</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getinfo.location#</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#getinfo.soqty#</font></div></td>
            
            <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#getinfo.unit#</font></div></td>
            
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#getinfo.balance#</font></div></td>
			<td><div align="center"><font size="2" face="Times New Roman, Times, serif">
				<a href="itembatchso2.cfm?itemno=#urlencodedformat(itemno)#&itemdesp=#urlencodedformat(getinfo.itemdesp)#&batchcode=#urlencodedformat(getinfo.batchcode)#&location=#getinfo.location#&itembal=#getinfo.balance#&cf=#urlencodedformat(custfrom)#&ct=#urlencodedformat(custto)#">View Details</a>
			</font></div></td>
		</tr>
	</cfoutput>
</table>

</body>
<br>
<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
</body>
</html>