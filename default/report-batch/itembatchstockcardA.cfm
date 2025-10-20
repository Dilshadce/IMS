<html>
<head>
<title>Item Batch Stock Card 2</title>
<link href="../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
<style type="text/css" media="print">
	.noprint { display: none; }
</style>
</head>

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

<cfquery name="getgeneral" datasource="#dts#">
	select compro, lastaccyear from gsetup
</cfquery>
<cfquery name="checkcustom" datasource="#dts#">
    select customcompany from dealer_menu
</cfquery>

<cfquery name="getitem" datasource="#dts#">
	select a.itemno,d.desp as itemdesp,d.unit,a.batchcode,a.manu_date,a.milcert,a.importpermit<cfif checkcustom.customcompany eq "Y">,a.permit_no,a.permit_no2</cfif>,a.bth_qob,a.bth_qin,a.bth_qut,a.exp_date,b.getlastin,c.getlastout,(ifnull(a.bth_qob,0) + ifnull(b.getlastin,0) - ifnull(c.getlastout,0)) as balance,e.getin,f.getout,(ifnull(a.bth_qob,0) + ifnull(b.getlastin,0) - ifnull(c.getlastout,0)+ ifnull(e.getin,0)- ifnull(f.getout,0)) as lastbalance
	from obbatch as a

	left join
	(	select sum(qty) as getlastin,itemno,batchcode  
		from ictran
		where (type = 'RC' or type = 'CN' or type = 'OAI' or type = 'TRIN')
		and (void = '' or void is null) 
		and fperiod < '#form.periodfrom#' and batchcode<>''
        <cfif trim(form.datefrom) neq "" and trim(form.dateto) neq "">
        and wos_date < '#ndatefrom#'
        </cfif>
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and itemno between '#form.itemfrom#' and '#form.itemto#'
		</cfif>
		<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
			and batchcode between '#form.batchcodefrom#' and '#form.batchcodeto#'
		</cfif>
		<cfif checkcustom.customcompany eq "Y">
			<cfif trim(form.permitno) neq "">
				and (brem5='#form.permitno#' or brem7='#form.permitno#')
			</cfif>
		</cfif>
		group by itemno,batchcode
	) as b on a.itemno = b.itemno and a.batchcode=b.batchcode

	left join
	(	select sum(qty) as getlastout,itemno,batchcode 
		from ictran
		where (type = 'INV' or type = 'PR' or type = 'CS' or type = 'DN' or type = 'ISS' or type = 'OAR' or type = 'TROU' or type = 'DO')
		and (void = '' or void is null) 
		and fperiod < '#form.periodfrom#' and toinv='' and batchcode<>''
        <cfif trim(form.datefrom) neq "" and trim(form.dateto) neq "">
        and wos_date < '#ndatefrom#'
        </cfif>
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and itemno between '#form.itemfrom#' and '#form.itemto#'
		</cfif>
		<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
			and batchcode between '#form.batchcodefrom#' and '#form.batchcodeto#'
		</cfif>
		<cfif checkcustom.customcompany eq "Y">
			<cfif trim(form.permitno) neq "">
				and (brem5='#form.permitno#' or brem7='#form.permitno#')
			</cfif>
		</cfif>
		group by itemno,batchcode
	) as c on a.itemno = c.itemno and a.batchcode=c.batchcode

	left join (select itemno,desp,unit,unit2,factor1,factor2,category,colorid,sizeid from icitem)as d on a.itemno = d.itemno
    
    left join
	(	select sum(qty) as getin,itemno,batchcode  
		from ictran
		where (type = 'RC' or type = 'CN' or type = 'OAI' or type = 'TRIN')
		and (void = '' or void is null) 
		and batchcode<>''
        <cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod between '#form.periodfrom#' and '#form.periodto#'
		</cfif>
        <cfif trim(form.datefrom) neq "" and trim(form.dateto) neq "">
        and wos_date between '#ndatefrom#' and '#ndateto#'
        </cfif>
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and itemno between '#form.itemfrom#' and '#form.itemto#'
		</cfif>
		<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
			and batchcode between '#form.batchcodefrom#' and '#form.batchcodeto#'
		</cfif>
		<cfif checkcustom.customcompany eq "Y">
			<cfif trim(form.permitno) neq "">
				and (brem5='#form.permitno#' or brem7='#form.permitno#')
			</cfif>
		</cfif>
		group by itemno,batchcode
	) as e on a.itemno = e.itemno and a.batchcode=e.batchcode

	left join
	(	select sum(qty) as getout,itemno,batchcode 
		from ictran
		where (type = 'INV' or type = 'PR' or type = 'CS' or type = 'DN' or type = 'ISS' or type = 'OAR' or type = 'TROU' or type = 'DO')
		and (void = '' or void is null) 
		and (toinv='' or toinv is null) and batchcode<>''
        <cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod between '#form.periodfrom#' and '#form.periodto#'
		</cfif>
        <cfif trim(form.datefrom) neq "" and trim(form.dateto) neq "">
        and wos_date between '#ndatefrom#' and '#ndateto#'
        </cfif>
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and itemno between '#form.itemfrom#' and '#form.itemto#'
		</cfif>
		<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
			and batchcode between '#form.batchcodefrom#' and '#form.batchcodeto#'
		</cfif>
		<cfif checkcustom.customcompany eq "Y">
			<cfif trim(form.permitno) neq "">
				and (brem5='#form.permitno#' or brem7='#form.permitno#')
			</cfif>
		</cfif>
		group by itemno,batchcode
	) as f on a.itemno = f.itemno and a.batchcode=f.batchcode
    
	
	where a.itemno<>''
	<cfif isdefined("form.figure") and form.figure eq "yes">
	<cfelse>
		and (ifnull(a.bth_qob,0) + ifnull(b.getlastin,0) - ifnull(c.getlastout,0)+ ifnull(e.getin,0)- ifnull(f.getout,0)) <> 0
	</cfif>
	<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
		and a.itemno between '#form.itemfrom#' and '#form.itemto#'
	</cfif>
	<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and d.category between '#form.catefrom#' and '#form.cateto#'
	</cfif>
	<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		and d.wos_group between '#form.groupfrom#' and '#form.groupto#'
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
	<cfif checkcustom.customcompany eq "Y">
		<cfif trim(form.permitno) neq "">
			and (a.permit_no='#form.permitno#' or a.permit_no2='#form.permitno#')
		</cfif>
	</cfif>
	order by a.itemno,a.batchcode
</cfquery>

<body>
<p align="center"><font color="#000000" size="4" face="Times New Roman, Times, serif"><strong>ITEM <cfif checkcustom.customcompany eq "Y">- LOT NUMBER<cfelse>BATCH</cfif> STOCK CARD 2</strong></font></p>

<cfoutput>
<table width="100%" border="0" align="center" cellspacing="0">
	<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		<tr>
        	<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">CATEGORY: #form.catefrom# - #form.cateto#</font></div></td>
      	</tr>
    </cfif>
    <cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
      	<tr>
        	<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">GROUP: #form.groupfrom# - #form.groupto#</font></div></td>
		</tr>
    </cfif>
    <cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
      	<tr>
        	<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif"><cfif checkcustom.customcompany eq "Y">LOT NUMBER<cfelse>BATCH CODE</cfif>: #form.batchcodefrom# - #form.batchcodeto#</font></div></td>
      	</tr>
    </cfif>
    <cfif form.periodfrom neq "" and form.periodto neq "">
      	<tr>
        	<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">PERIOD: #form.periodfrom# - #form.periodto#</font></div></td>
      	</tr>
    </cfif>
	<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
		<tr>
			<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">ITEM NO: #form.itemfrom# - #form.itemto#</font></div></td>
		</tr>
	</cfif>
    <tr>
      	<td colspan="5"><cfif getgeneral.compro neq ""><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></cfif></td>
		<td colspan="3"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
    </tr>
</table>
	<table width="100%" border="0" align="center" cellspacing="0">
		<tr><td height="10"></td></tr>
  		<tr>
    		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">ITEM NO</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">DESCRIPTION</font></div></td>
    		<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><cfif checkcustom.customcompany eq "Y">LOT NUMBER<cfelse>BATCH CODE</cfif></font></div></td>
            <td><div align="left"><font size="2" face="Times New Roman, Times, serif"><cfif lcase(hcomid) eq "marquis_i">Lot Number<cfelse>Mil Cert</cfif></font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">Import Permit</font></div></td>
    		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">QTY BF</font></div></td>
    		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">IN</font></div></td>
    		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">OUT</font></div></td>
    		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">BALANCE</font></div></td>            
            <td><div align="right"><font size="2" face="Times New Roman, Times, serif">UNITS</font></div></td>
            <td><div align="right"><font size="2" face="Times New Roman, Times, serif">ACTION</font></div></td>
  		</tr>
  		<tr>
    		<td colspan="10"><hr></td>
  		</tr>
		<cfset totalin = 0>
		<cfset totalout = 0>
		<cfset bal = 0>

		<cfloop query="getitem">
			<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
				
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.itemno#</font></div></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.itemdesp#</font></div></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.batchcode#</font></div></td>
                <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.milcert#</font></div></td>
                <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.importpermit#</font></div></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.balance#</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#val(getitem.getin)#</font></div></td>
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#val(getitem.getout)#</font></div></td>
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#getitem.lastbalance# #getitem.unit#</font></div></td>
                <cfquery name="getunit" datasource="#dts#">
                select unit from icitem where itemno='#getitem.itemno#'
                </cfquery>
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#getunit.unit#</font></div></td>
                
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><a href="itembatchstockcardA2.cfm?itemno=#urlencodedformat(itemno)#&itembal=#getitem.balance#&pf=#urlencodedformat(itemfrom)#&pt=#urlencodedformat(itemto)#&cf=#catefrom#&ct=#cateto#&pef=#periodfrom#&pet=#periodto#&gpf=#groupfrom#&gpt=#groupto#&df=#datefrom#&dt=#dateto#&batchcode=#batchcode#&batchcodefrom=#batchcodefrom#&batchcodeto=#batchcodeto#&expdate=#getitem.exp_date#&manudate=#getitem.manu_date#<cfif isdefined ('form.figure')>&figure=1</cfif>">View</a></font></div></td>
			</tr>
            <cfset totalin = totalin+val(getitem.getin)>
		<cfset totalout = totalout+val(getitem.getout)>
		<cfset bal = bal+val(getitem.lastbalance)>
  		</cfloop>
        
		<tr>
    		<td colspan="100%"><hr></td>
  		</tr>
        <tr>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#totalin#</font></div></td>
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#totalout#</font></div></td>
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#bal#</font></div></td>
        </tr>
		<tr><td><br><br><br></td></tr>
	</table>
</cfoutput>
<br>
<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
</body>
</html>