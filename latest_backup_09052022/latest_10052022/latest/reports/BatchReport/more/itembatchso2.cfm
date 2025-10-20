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
	select itemno,refno,type,wos_date,custno,name,qty,shipped,location,batchcode,milcert,importpermit,unit
	from ictran a	
	where (void = '' or void is null) and batchcode<>'' and location<>'' and fperiod <> '99' and (linecode <> 'SV' or linecode is null)
	and type = 'SO'
	and (qty-shipped) > 0
	and location ='#url.location#'
	and itemno ='#url.itemno#'
	and batchcode ='#url.batchcode#'
	
	order by a.itemno,a.wos_date
</cfquery>
<body>
<p align="center"><font color="#000000" size="4" face="Times New Roman, Times, serif"><strong>LOT NUMBER OUTSTANDING SALES ORDER REPORT</strong></font></p>

<table width="100%" border="0" align="center" cellspacing="0">
    <cfoutput>
    <tr>
       <td colspan="100%"><div align="left"><font size="2" face="Times New Roman, Times, serif"><cfif checkcustom.customcompany eq "Y">LOT NUMBER<cfelse>BATCH CODE</cfif>: #url.batchcode#</font></div></td>
    </tr>
	<tr>
		<td colspan="100%"><div align="left"><font size="2" face="Times New Roman, Times, serif">ITEM: #url.itemno# #url.itemdesp#</font></div></td>
	</tr>
	<tr>
		<td colspan="100%"><div align="left"><font size="2" face="Times New Roman, Times, serif">BALANCE: #url.itembal#</font></div></td>
	</tr>
	<tr><td colspan="100%" height="5"></td></tr>
    <tr>
      	<td colspan="4"><cfif getgeneral.compro neq ""><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></cfif></td>
		<td colspan="3"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
    </tr>
	</cfoutput>
	<tr>
		<td colspan="100%"><hr></td>
	</tr>
	<tr>
		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">CUSTOMER NAME</font></div></td>
    	<td><div align="left"><font size="2" face="Times New Roman, Times, serif">SALES ORDER</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">DATE</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><cfif checkcustom.customcompany eq "Y">LOT NUMBER<cfelse>ITEM BATCH</cfif></font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman, Times, serif"><cfif lcase(hcomid) eq "marquis_i">Lot Number<cfelse>Mil Cert</cfif></font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">Import Permit</font></div></td>
		<td><div align="center"><font size="2" face="Times New Roman, Times, serif">UOM</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">QTY ORDERED</font></div></td>	
	</tr>
	<tr>
		<td colspan="100%"><hr></td>
	</tr>
	<cfoutput query="getinfo">
		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getinfo.name#</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getinfo.refno#</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#dateformat(getinfo.wos_date,"dd-mm-yyyy")#</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getinfo.batchcode#</font></div></td>
            <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getinfo.milcert#</font></div></td>
            <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getinfo.importpermit#</font></div></td>
			<td><div align="center"><font size="2" face="Times New Roman, Times, serif">#getinfo.unit#</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#getinfo.qty#</font></div></td>
		</tr>	
	</cfoutput>
</table>

</body>
<br>
<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
</body>
</html>