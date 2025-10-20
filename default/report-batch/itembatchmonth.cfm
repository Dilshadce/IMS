<cfswitch expression="#form.result#">
	<cfcase value="HTML">

<html>
<head>
<title>Item Batch Stock Card</title>
<link href="../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
<style type="text/css" media="print">
	.noprint { display: none; }
</style>
</head>

<cfif isdefined('form.locationqty')>

<cfquery name="getgeneral" datasource="#dts#">
	select compro, lastaccyear from gsetup
</cfquery>
<cfquery name="checkcustom" datasource="#dts#">
    select customcompany from dealer_menu
</cfquery>

<cfset totalqtybf=0>
<cfset totalqtyin=0>
<cfset totalqtyout=0>
<cfset totalsoqty=0>

<cfset totalbal=0>
<cfif form.locationqty eq 'no'>

<cfquery name="getitem" datasource="#dts#">
select location from iclocation where right(location,4) not in (
	select right(a.location,4)
	from lobthob as a

	left join
	(	select sum(qty) as getlastin,itemno,batchcode,location  
		from ictran
		where (type = 'RC' or type = 'CN' or type = 'OAI' or type = 'TRIN')
		and (void = '' or void is null) and (fperiod < '#form.period#' or fperiod = 99) and batchcode<>'' and location<>''
		<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
			and batchcode between '#form.batchcodefrom#' and '#form.batchcodeto#'
		</cfif>
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and itemno between '#form.itemfrom#' and '#form.itemto#'
		</cfif>
		<cfif form.locationfrom neq "" and form.locationto neq "">
			and location between '#form.locationfrom#' and '#form.locationto#'
		</cfif>
		<cfif checkcustom.customcompany eq "Y">
			<cfif trim(form.permitno) neq "">
				and (brem5='#form.permitno#' or brem7='#form.permitno#')
			</cfif>
		</cfif>
		<cfif lcase(hcomid) eq "jaynbtrading_i">
			<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
				and custno between '#form.custfrom#' and '#form.custto#'
			</cfif>
		</cfif>
		group by itemno,batchcode,location
	) as b on (a.itemno = b.itemno and a.batchcode=b.batchcode and a.location=b.location)

	left join
	(	select sum(qty) as getlastout,itemno,batchcode,location 
		from ictran
		where (type = 'INV' or type = 'PR' or type = 'CS' or type = 'DN' or type = 'ISS' or type = 'OAR' or type = 'TROU' or type = 'DO')
		and (void = '' or void is null) and (fperiod < '#form.period#' or fperiod = 99) and toinv='' and batchcode<>'' and location<>''
		<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
			and batchcode between '#form.batchcodefrom#' and '#form.batchcodeto#'
		</cfif>
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and itemno between '#form.itemfrom#' and '#form.itemto#'
		</cfif>
		<cfif form.locationfrom neq "" and form.locationto neq "">
			and location between '#form.locationfrom#' and '#form.locationto#'
		</cfif>
		<cfif checkcustom.customcompany eq "Y">
			<cfif trim(form.permitno) neq "">
				and (brem5='#form.permitno#' or brem7='#form.permitno#')
			</cfif>
		</cfif>
		<cfif lcase(hcomid) eq "jaynbtrading_i">
			<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
				and custno between '#form.custfrom#' and '#form.custto#'
			</cfif>
		</cfif>
		group by itemno,batchcode,location
	) as c on (a.itemno = c.itemno and a.batchcode=c.batchcode and a.location=c.location)
	
	left join
	(	select sum(qty) as qin,itemno,batchcode,location 
		from ictran
		where (type = 'RC' or type = 'CN' or type = 'OAI' or type = 'TRIN') 
		and (void = '' or void is null) and batchcode<>''
		and fperiod = '#form.period#'
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and itemno between '#form.itemfrom#' and '#form.itemto#'
		</cfif>
		<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
			and batchcode between '#form.batchcodefrom#' and '#form.batchcodeto#'
		</cfif>
		<cfif form.locationfrom neq "" and form.locationto neq "">
			and location between '#form.locationfrom#' and '#form.locationto#'
		</cfif>
		<cfif checkcustom.customcompany eq "Y">
			<cfif trim(form.permitno) neq "">
				and (brem5='#form.permitno#' or brem7='#form.permitno#')
			</cfif>
		</cfif>
		<cfif lcase(hcomid) eq "jaynbtrading_i">
			<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
				and custno between '#form.custfrom#' and '#form.custto#'
			</cfif>
		</cfif>  
		group by itemno,batchcode,location
	) as e on (a.itemno=e.itemno and a.batchcode=e.batchcode and a.location=e.location)

	left join
	(	select sum(qty) as qout,itemno,batchcode,location 
		from ictran
		where (type = 'INV' or type = 'PR' or type = 'CS' or type = 'DN' or type = 'ISS' or type = 'OAR' or type = 'TROU' or type = 'DO')
		and (void = '' or void is null) and toinv='' and batchcode<>''
		and fperiod = '#form.period#'
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and itemno between '#form.itemfrom#' and '#form.itemto#'
		</cfif>
		<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
			and batchcode between '#form.batchcodefrom#' and '#form.batchcodeto#'
		</cfif>
		<cfif form.locationfrom neq "" and form.locationto neq "">
			and location between '#form.locationfrom#' and '#form.locationto#'
		</cfif>
		<cfif checkcustom.customcompany eq "Y">
			<cfif trim(form.permitno) neq "">
				and (brem5='#form.permitno#' or brem7='#form.permitno#')
			</cfif>
		</cfif>
		<cfif lcase(hcomid) eq "jaynbtrading_i">
			<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
				and custno between '#form.custfrom#' and '#form.custto#'
			</cfif>
		</cfif>  
		group by itemno,batchcode,location
	) as f on (a.itemno=f.itemno and a.batchcode=f.batchcode and a.location=f.location)
    
	left join (select itemno,desp,unit,unit2,factor1,factor2,category,colorid,sizeid from icitem)as d on a.itemno = d.itemno
	
	where a.itemno<>''
		and (ifnull(a.bth_qob,0) + ifnull(a.bth_qin,0) - ifnull(a.bth_qut,0)) <> 0
		and (ifnull(a.bth_qob,0) + ifnull(b.getlastin,0) - ifnull(c.getlastout,0) + ifnull(e.qin,0) - ifnull(f.qout,0))<>0
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
	<cfif checkcustom.customcompany eq "Y">
		<cfif trim(form.permitno) neq "">
			and (a.permit_no='#form.permitno#' or a.permit_no2='#form.permitno#')
		</cfif>
	</cfif>
	<cfif form.locationfrom neq "" and form.locationto neq "">
		and a.location between '#form.locationfrom#' and '#form.locationto#'
	</cfif>
	order by <cfif isdefined('form.bylocation')>a.location,a.batchcode<cfelse>a.itemno,a.batchcode</cfif>
    ) group by right(location,4)
</cfquery>

<cfelse>

<cfquery name="getitem" datasource="#dts#">
select location from iclocation where right(location,4) in (
	select right(a.location,4)
	from lobthob as a

	left join
	(	select sum(qty) as getlastin,itemno,batchcode,location  
		from ictran
		where (type = 'RC' or type = 'CN' or type = 'OAI' or type = 'TRIN')
		and (void = '' or void is null) and (fperiod < '#form.period#' or fperiod = 99) and batchcode<>'' and location<>''
		<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
			and batchcode between '#form.batchcodefrom#' and '#form.batchcodeto#'
		</cfif>
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and itemno between '#form.itemfrom#' and '#form.itemto#'
		</cfif>
		<cfif form.locationfrom neq "" and form.locationto neq "">
			and location between '#form.locationfrom#' and '#form.locationto#'
		</cfif>
		<cfif checkcustom.customcompany eq "Y">
			<cfif trim(form.permitno) neq "">
				and (brem5='#form.permitno#' or brem7='#form.permitno#')
			</cfif>
		</cfif>
		<cfif lcase(hcomid) eq "jaynbtrading_i">
			<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
				and custno between '#form.custfrom#' and '#form.custto#'
			</cfif>
		</cfif>
		group by itemno,batchcode,location
	) as b on (a.itemno = b.itemno and a.batchcode=b.batchcode and a.location=b.location)

	left join
	(	select sum(qty) as getlastout,itemno,batchcode,location 
		from ictran
		where (type = 'INV' or type = 'PR' or type = 'CS' or type = 'DN' or type = 'ISS' or type = 'OAR' or type = 'TROU' or type = 'DO')
		and (void = '' or void is null) and (fperiod < '#form.period#' or fperiod = 99) and toinv='' and batchcode<>'' and location<>''
		<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
			and batchcode between '#form.batchcodefrom#' and '#form.batchcodeto#'
		</cfif>
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and itemno between '#form.itemfrom#' and '#form.itemto#'
		</cfif>
		<cfif form.locationfrom neq "" and form.locationto neq "">
			and location between '#form.locationfrom#' and '#form.locationto#'
		</cfif>
		<cfif checkcustom.customcompany eq "Y">
			<cfif trim(form.permitno) neq "">
				and (brem5='#form.permitno#' or brem7='#form.permitno#')
			</cfif>
		</cfif>
		<cfif lcase(hcomid) eq "jaynbtrading_i">
			<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
				and custno between '#form.custfrom#' and '#form.custto#'
			</cfif>
		</cfif>
		group by itemno,batchcode,location
	) as c on (a.itemno = c.itemno and a.batchcode=c.batchcode and a.location=c.location)
	
	left join
	(	select sum(qty) as qin,itemno,batchcode,location 
		from ictran
		where (type = 'RC' or type = 'CN' or type = 'OAI' or type = 'TRIN') 
		and (void = '' or void is null) and batchcode<>''
		and fperiod = '#form.period#'
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and itemno between '#form.itemfrom#' and '#form.itemto#'
		</cfif>
		<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
			and batchcode between '#form.batchcodefrom#' and '#form.batchcodeto#'
		</cfif>
		<cfif form.locationfrom neq "" and form.locationto neq "">
			and location between '#form.locationfrom#' and '#form.locationto#'
		</cfif>
		<cfif checkcustom.customcompany eq "Y">
			<cfif trim(form.permitno) neq "">
				and (brem5='#form.permitno#' or brem7='#form.permitno#')
			</cfif>
		</cfif>
		<cfif lcase(hcomid) eq "jaynbtrading_i">
			<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
				and custno between '#form.custfrom#' and '#form.custto#'
			</cfif>
		</cfif>  
		group by itemno,batchcode,location
	) as e on (a.itemno=e.itemno and a.batchcode=e.batchcode and a.location=e.location)

	left join
	(	select sum(qty) as qout,itemno,batchcode,location 
		from ictran
		where (type = 'INV' or type = 'PR' or type = 'CS' or type = 'DN' or type = 'ISS' or type = 'OAR' or type = 'TROU' or type = 'DO')
		and (void = '' or void is null) and toinv='' and batchcode<>''
		and fperiod = '#form.period#'
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and itemno between '#form.itemfrom#' and '#form.itemto#'
		</cfif>
		<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
			and batchcode between '#form.batchcodefrom#' and '#form.batchcodeto#'
		</cfif>
		<cfif form.locationfrom neq "" and form.locationto neq "">
			and location between '#form.locationfrom#' and '#form.locationto#'
		</cfif>
		<cfif checkcustom.customcompany eq "Y">
			<cfif trim(form.permitno) neq "">
				and (brem5='#form.permitno#' or brem7='#form.permitno#')
			</cfif>
		</cfif>
		<cfif lcase(hcomid) eq "jaynbtrading_i">
			<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
				and custno between '#form.custfrom#' and '#form.custto#'
			</cfif>
		</cfif>  
		group by itemno,batchcode,location
	) as f on (a.itemno=f.itemno and a.batchcode=f.batchcode and a.location=f.location)
	
	left join (select itemno,desp,unit,unit2,factor1,factor2,category,colorid,sizeid from icitem)as d on a.itemno = d.itemno
	
	where a.itemno<>''
		and (ifnull(a.bth_qob,0) + ifnull(a.bth_qin,0) - ifnull(a.bth_qut,0)) <> 0
		and (ifnull(a.bth_qob,0) + ifnull(b.getlastin,0) - ifnull(c.getlastout,0) + ifnull(e.qin,0) - ifnull(f.qout,0))<>0
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
	<cfif checkcustom.customcompany eq "Y">
		<cfif trim(form.permitno) neq "">
			and (a.permit_no='#form.permitno#' or a.permit_no2='#form.permitno#')
		</cfif>
	</cfif>
	<cfif form.locationfrom neq "" and form.locationto neq "">
		and a.location between '#form.locationfrom#' and '#form.locationto#'
	</cfif>
	order by <cfif isdefined('form.bylocation')>a.location,a.batchcode<cfelse>a.itemno,a.batchcode</cfif>
    ) group by right(location,4)
</cfquery>

</cfif>

<body>
<p align="center"><font color="#000000" size="4" face="Times New Roman, Times, serif"><strong><cfif form.locationqty eq 'no'>EMPTY LOCATION REPORT<cfelse>WITH QTY LOCATION REPORT</cfif></strong></font></p>
<cfoutput>
<table width="100%" border="0" align="center" cellspacing="0">
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
		<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">MONTH : #ucase(dateformat(dateadd('m',val(form.period),getgeneral.lastaccyear),"mmm yy"))#</font></div></td>
	</tr>
    <tr>
      	<td colspan="5"><cfif getgeneral.compro neq ""><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></cfif></td>
		<td colspan="3"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
    </tr>
	<tr>
		<td colspan="100%"><hr></td>
	</tr>
	<tr>
    <td><div align="left"><font size="2" face="Times New Roman, Times, serif">Index</font></div></td>
    	<td><div align="left"><font size="2" face="Times New Roman, Times, serif">Location</font></div></td>
	</tr>
	<tr>
		<td colspan="100%"><hr></td>
	</tr>
    <cfset i=1>
	<cfloop query="getitem">
		
		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#i#</font></div></td>
    		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#right(getitem.location,4)#</font></div></td>
            <cfset i=i+1>
        	
		</tr>
	</cfloop>

</table>
</cfoutput>
</body>
<br>
<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>


<cfelse>

<cfquery name="getgeneral" datasource="#dts#">
	select compro, lastaccyear from gsetup
</cfquery>
<cfquery name="checkcustom" datasource="#dts#">
    select customcompany from dealer_menu
</cfquery>

<cfset totalqtybf=0>
<cfset totalqtyin=0>
<cfset totalqtyout=0>
<cfset totalsoqty=0>
<cfset totalbal=0>

<cfquery name="getitem" datasource="#dts#">
	select a.itemno,d.desp as itemdesp,d.unit,d.unit2,d.factor1,d.factor2,(select desp from icsizeid where sizeid=d.sizeid) as sizeid,d.category,(select desp from iccolorid where colorid=d.colorid) as countryoforigin,
	a.batchcode,a.location,a.importpermit,a.milcert<cfif checkcustom.customcompany eq "Y">,a.permit_no,a.permit_no2</cfif>,
	a.location,a.bth_qob,a.bth_qin,a.bth_qut,a.expdate,b.getlastin,c.getlastout,(ifnull(a.bth_qob,0) + ifnull(b.getlastin,0) - ifnull(c.getlastout,0)) as qtybf,
	ifnull(e.qin,0) as qin,ifnull(f.qout,0) as qout,(ifnull(a.bth_qob,0) + ifnull(b.getlastin,0) - ifnull(c.getlastout,0) + ifnull(e.qin,0) - ifnull(f.qout,0)) as balance,ifnull(g.soqty,0) as soqty
	from lobthob as a

	left join
	(	select sum(qty) as getlastin,itemno,batchcode,location  
		from ictran
		where (type = 'RC' or type = 'CN' or type = 'OAI' or type = 'TRIN')
		and (void = '' or void is null) and (fperiod < '#form.period#' or fperiod = 99) and batchcode<>'' and location<>''
		<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
			and batchcode between '#form.batchcodefrom#' and '#form.batchcodeto#'
		</cfif>
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and itemno between '#form.itemfrom#' and '#form.itemto#'
		</cfif>
		<cfif form.locationfrom neq "" and form.locationto neq "">
			and location between '#form.locationfrom#' and '#form.locationto#'
		</cfif>
		<cfif checkcustom.customcompany eq "Y">
			<cfif trim(form.permitno) neq "">
				and (brem5='#form.permitno#' or brem7='#form.permitno#')
			</cfif>
		</cfif>
		<cfif lcase(hcomid) eq "jaynbtrading_i">
			<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
				and custno between '#form.custfrom#' and '#form.custto#'
			</cfif>
		</cfif>
		group by itemno,batchcode,location
	) as b on (a.itemno = b.itemno and a.batchcode=b.batchcode and a.location=b.location)

	left join
	(	select sum(qty) as getlastout,itemno,batchcode,location 
		from ictran
		where (type = 'INV' or type = 'PR' or type = 'CS' or type = 'DN' or type = 'ISS' or type = 'OAR' or type = 'TROU' or type = 'DO')
		and (void = '' or void is null) and (fperiod < '#form.period#' or fperiod = 99) and toinv='' and batchcode<>'' and location<>''
		<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
			and batchcode between '#form.batchcodefrom#' and '#form.batchcodeto#'
		</cfif>
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and itemno between '#form.itemfrom#' and '#form.itemto#'
		</cfif>
		<cfif form.locationfrom neq "" and form.locationto neq "">
			and location between '#form.locationfrom#' and '#form.locationto#'
		</cfif>
		<cfif checkcustom.customcompany eq "Y">
			<cfif trim(form.permitno) neq "">
				and (brem5='#form.permitno#' or brem7='#form.permitno#')
			</cfif>
		</cfif>
		<cfif lcase(hcomid) eq "jaynbtrading_i">
			<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
				and custno between '#form.custfrom#' and '#form.custto#'
			</cfif>
		</cfif>
		group by itemno,batchcode,location
	) as c on (a.itemno = c.itemno and a.batchcode=c.batchcode and a.location=c.location)
	
	left join
	(	select sum(qty) as qin,itemno,batchcode,location 
		from ictran
		where (type = 'RC' or type = 'CN' or type = 'OAI' or type = 'TRIN') 
		and (void = '' or void is null) and batchcode<>''
		and fperiod = '#form.period#'
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and itemno between '#form.itemfrom#' and '#form.itemto#'
		</cfif>
		<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
			and batchcode between '#form.batchcodefrom#' and '#form.batchcodeto#'
		</cfif>
		<cfif form.locationfrom neq "" and form.locationto neq "">
			and location between '#form.locationfrom#' and '#form.locationto#'
		</cfif>
		<cfif checkcustom.customcompany eq "Y">
			<cfif trim(form.permitno) neq "">
				and (brem5='#form.permitno#' or brem7='#form.permitno#')
			</cfif>
		</cfif>
		<cfif lcase(hcomid) eq "jaynbtrading_i">
			<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
				and custno between '#form.custfrom#' and '#form.custto#'
			</cfif>
		</cfif>  
		group by itemno,batchcode,location
	) as e on (a.itemno=e.itemno and a.batchcode=e.batchcode and a.location=e.location)

	left join
	(	select sum(qty) as qout,itemno,batchcode,location 
		from ictran
		where (type = 'INV' or type = 'PR' or type = 'CS' or type = 'DN' or type = 'ISS' or type = 'OAR' or type = 'TROU' or type = 'DO')
		and (void = '' or void is null) and toinv='' and batchcode<>''
		and fperiod = '#form.period#'
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and itemno between '#form.itemfrom#' and '#form.itemto#'
		</cfif>
		<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
			and batchcode between '#form.batchcodefrom#' and '#form.batchcodeto#'
		</cfif>
		<cfif form.locationfrom neq "" and form.locationto neq "">
			and location between '#form.locationfrom#' and '#form.locationto#'
		</cfif>
		<cfif checkcustom.customcompany eq "Y">
			<cfif trim(form.permitno) neq "">
				and (brem5='#form.permitno#' or brem7='#form.permitno#')
			</cfif>
		</cfif>
		<cfif lcase(hcomid) eq "jaynbtrading_i">
			<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
				and custno between '#form.custfrom#' and '#form.custto#'
			</cfif>
		</cfif>  
		group by itemno,batchcode,location
	) as f on (a.itemno=f.itemno and a.batchcode=f.batchcode and a.location=f.location)
	
    left join
	(	select sum(qty) as SOqty,itemno,batchcode,location 
		from ictran
		where type='SO'
		and (void = '' or void is null) and toinv='' and batchcode<>''
		and fperiod = '#form.period#'
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and itemno between '#form.itemfrom#' and '#form.itemto#'
		</cfif>
		<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
			and batchcode between '#form.batchcodefrom#' and '#form.batchcodeto#'
		</cfif>
		<cfif form.locationfrom neq "" and form.locationto neq "">
			and location between '#form.locationfrom#' and '#form.locationto#'
		</cfif>
		<cfif checkcustom.customcompany eq "Y">
			<cfif trim(form.permitno) neq "">
				and (brem5='#form.permitno#' or brem7='#form.permitno#')
			</cfif>
		</cfif>
		<cfif lcase(hcomid) eq "jaynbtrading_i">
			<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
				and custno between '#form.custfrom#' and '#form.custto#'
			</cfif>
		</cfif>  
		group by itemno,batchcode,location
	) as g on (a.itemno=g.itemno and a.batchcode=g.batchcode and a.location=g.location)
    
	left join (select itemno,desp,unit,unit2,factor1,factor2,category,colorid,sizeid from icitem)as d on a.itemno = d.itemno
	
	where a.itemno<>''
	<cfif isdefined("form.figure") and form.figure eq "yes">
	<cfelse>
		and (ifnull(a.bth_qob,0) + ifnull(a.bth_qin,0) - ifnull(a.bth_qut,0)) <> 0
		and (ifnull(a.bth_qob,0) + ifnull(b.getlastin,0) - ifnull(c.getlastout,0) + ifnull(e.qin,0) - ifnull(f.qout,0))<>0
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
	<cfif checkcustom.customcompany eq "Y">
		<cfif trim(form.permitno) neq "">
			and (a.permit_no='#form.permitno#' or a.permit_no2='#form.permitno#')
		</cfif>
	</cfif>
	<cfif form.locationfrom neq "" and form.locationto neq "">
		and a.location between '#form.locationfrom#' and '#form.locationto#'
	</cfif>
	order by <cfif isdefined('form.bylocation')>a.location,a.batchcode<cfelse>a.itemno,a.batchcode</cfif>
</cfquery>
<body>
<p align="center"><font color="#000000" size="4" face="Times New Roman, Times, serif"><strong>LOT NUMBER MONTHLY REPORT</strong></font></p>
<cfoutput>
<table width="100%" border="0" align="center" cellspacing="0">
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
		<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">MONTH : #ucase(dateformat(dateadd('m',val(form.period),getgeneral.lastaccyear),"mmm yy"))#</font></div></td>
	</tr>
    <tr>
      	<td colspan="5"><cfif getgeneral.compro neq ""><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></cfif></td>
		<td colspan="3"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
    </tr>
	<tr>
		<td colspan="100%"><hr></td>
	</tr>
	<tr>
    	<cfif lcase(hcomid) eq "hempel_i">
    	<td><div align="left"><font size="2" face="Times New Roman, Times, serif">ITEM CODE</font></div></td>
        </cfif>
		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">ITEM DESCRIPTION</font></div></td>
		<td><div align="center"><font size="2" face="Times New Roman, Times, serif">ORIGIN COUNTRY</font></div></td>
		<cfif checkcustom.customcompany eq "Y">
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">PERMIT NO</font></div></td>
		</cfif>
		<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><cfif checkcustom.customcompany eq "Y">LOT NUMBER<cfelse>ITEM BATCH</cfif></font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">LOCATION</font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman, Times, serif"><cfif lcase(hcomid) eq "marquis_i">Lot Number<cfelse>Mil Cert</cfif></font></div></td>
        
        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">Import Permit</font></div></td>
        <cfif lcase(hcomid) eq "hempel_i">
        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">Pack Size</font></div></td>
        </cfif>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">B/F</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">IN</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">OUT</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">RESERVED QTY</font></div></td>
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">BALANCE</font></div></td>
        
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">UNITS</font></div></td>
	</tr>
	<tr>
		<td colspan="100%"><hr></td>
	</tr>
	<cfloop query="getitem">
		<cfset xfactor1=getitem.factor1>
		<cfset xfactor2=getitem.factor2>
		<cfset xunit=getitem.unit>
		<cfset xunit2=getitem.unit2>
		
		<cfif val(xfactor1) neq 0>
			<cfif val(getitem.qtybf) gte 0>
				<cfset xqtybf=val(getitem.qtybf)/val(xfactor1)*val(xfactor2)>
			<cfelse>
				<cfset xqtybf=-(val(getitem.qtybf)/val(xfactor1)*val(xfactor2))>
			</cfif>			
			<cfif val(getitem.qin) gte 0>
				<cfset xqin=val(getitem.qin)/val(xfactor1)*val(xfactor2)>
			<cfelse>
				<cfset xqin=-(val(getitem.qin)/val(xfactor1)*val(xfactor2))>
			</cfif>
			<cfif val(getitem.qout) gte 0>
				<cfset xqout=val(getitem.qout)/val(xfactor1)*val(xfactor2)>
			<cfelse>
				<cfset xqout=-(val(getitem.qout)/val(xfactor1)*val(xfactor2))>
			</cfif>
			<cfif val(getitem.balance) gte 0>
				<cfset xbal=val(getitem.balance)/val(xfactor1)*val(xfactor2)>
			<cfelse>
				<cfset xbal=-(val(getitem.balance)/val(xfactor1)*val(xfactor2))>
			</cfif>
			
			<cfset xqtybf=Int(xqtybf)>
			<cfset xqin=Int(xqin)>
			<cfset xqout=Int(xqout)>
			<cfset xbal=Int(xbal)>
			
			<cfif val(xfactor2) neq 0>
				<cfset yqtybf=val(getitem.qtybf)-(xqtybf*val(xfactor1)/val(xfactor2))>
				<cfset yqin=val(getitem.qin)-(xqin*val(xfactor1)/val(xfactor2))>
				<cfset yqout=val(getitem.qout)-(xqout*val(xfactor1)/val(xfactor2))>
				<cfset ybal=val(getitem.balance)-(xbal*val(xfactor1)/val(xfactor2))>
			<cfelse>
				<cfset yqtybf=0>
				<cfset yqin=0>
				<cfset yqout=0>
				<cfset ybal=0>
			</cfif>
		<cfelse>
			<cfset xqtybf=0>
			<cfset yqtybf=val(getitem.qtybf)>
			
			<cfset xqin=0>
			<cfset yqin=val(getitem.qin)>
			
			<cfset xqout=0>
			<cfset yqout=val(getitem.qout)>
			
			<cfset xbal=0>
			<cfset ybal=val(getitem.balance)>
		</cfif>
        <cfset totalqtybf=totalqtybf+getitem.qtybf>
		<cfset totalqtyin=totalqtyin+getitem.qin>
		<cfset totalqtyout=totalqtyout+getitem.qout>
        <cfset totalsoqty=totalsoqty+getitem.soqty>
		<cfset totalbal=totalbal+(getitem.balance-getitem.soqty)>
		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
            <cfif lcase(hcomid) eq "hempel_i">
    		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.itemno#</font></div></td>
        	</cfif>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.itemdesp#  #getitem.category#<cfif getitem.sizeid neq ""> (#getitem.sizeid#)</cfif></font></div></td>
            <cfif lcase(hcomid) eq "hempel_i">
            <cfquery name="getcountryoforigin" datasource="#dts#">
            select countryoforigin from ictran where itemno='#getitem.itemno#' and batchcode='#getitem.batchcode#' and location='#getitem.location#' and type='RC'
            </cfquery>
            </cfif>
			<td><div align="center"><font size="2" face="Times New Roman, Times, serif"><cfif lcase(hcomid) eq "hempel_i">#getcountryoforigin.countryoforigin#<cfelse>#getitem.countryoforigin#</cfif></font></div></td>
			<cfif checkcustom.customcompany eq "Y">
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><cfif getitem.permit_no neq "">#getitem.permit_no#<cfelseif getitem.permit_no2 neq "">#getitem.permit_no2#</cfif></font></div></td>
			</cfif>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.batchcode#</font></div></td>
            <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.location#</font></div></td>
            <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.milcert#</font></div></td>
            <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.importpermit#</font></div></td>
            <cfif lcase(hcomid) eq "hempel_i">
            <cfquery name="getpacksize" datasource="#dts#">
            select price from ictran where batchcode='#getitem.batchcode#' and location='#getitem.location#'
            </cfquery>
        	<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getpacksize.price#</font></div></td>
        	</cfif>
            <cfif lcase(hcomid) eq "hempel_i">
            <td><font size="2" face="Times New Roman, Times, serif"><div align="right">#getitem.qtybf#</div></font></td>
			<td><font size="2" face="Times New Roman, Times, serif"><div align="right">#getitem.qin#</div></font></td>
			<td><font size="2" face="Times New Roman, Times, serif"><div align="right">#getitem.qout#</div></font></td>
            <td><font size="2" face="Times New Roman, Times, serif"><div align="right">#getitem.soqty#</div></font></td>
			<td><font size="2" face="Times New Roman, Times, serif"><div align="right">#getitem.balance-getitem.soqty#</div></font></td>
            <cfelse>
			<td><font size="2" face="Times New Roman, Times, serif"><div align="right">#xqtybf# #xunit2# #yqtybf# #xunit#</div></font></td>
			<td><font size="2" face="Times New Roman, Times, serif"><div align="right">#xqin# #xunit2# #yqin# #xunit#</div></font></td>
			<td><font size="2" face="Times New Roman, Times, serif"><div align="right">#xqout# #xunit2# #yqout# #xunit#</div></font></td>
            <td><font size="2" face="Times New Roman, Times, serif"><div align="right">#getitem.soqty#</div></font></td>
			<td><font size="2" face="Times New Roman, Times, serif"><div align="right">#xbal# #xunit2# #ybal# #xunit#</div></font></td>
            </cfif>
             <cfquery name="getunit" datasource="#dts#">
                    select unit from icitem where itemno='#getitem.itemno#'
                    </cfquery>
            <td><font size="2" face="Times New Roman, Times, serif"><div align="right">#getunit.unit#</div></font></td>
		</tr>
	</cfloop>
    <tr><td colspan="100%"><hr></td></tr>
    <tr>
    		<cfif lcase(hcomid) eq "hempel_i">
            <td></td>
            </cfif>
			<td>Total :</td>
			<td></td>
			<cfif checkcustom.customcompany eq "Y">
			<td></td>
			</cfif>
			<td></td>
            <td></td>
            <td></td>
            <td></td>
            <cfif lcase(hcomid) eq "hempel_i">
            <td></td>
            </cfif>
			<td><font size="2" face="Times New Roman, Times, serif"><div align="right">#totalqtybf#</div></font></td>
			<td><font size="2" face="Times New Roman, Times, serif"><div align="right">#totalqtyin#</div></font></td>
			<td><font size="2" face="Times New Roman, Times, serif"><div align="right">#totalqtyout#</div></font></td>
            <td><font size="2" face="Times New Roman, Times, serif"><div align="right">#totalsoqty#</div></font></td>
			<td><font size="2" face="Times New Roman, Times, serif"><div align="right">#totalbal#</div></font></td>
            <td></td>
		</tr>
</table>
</cfoutput>
</body>
<br>
<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>

</cfif>
</html>
</cfcase>

<cfcase value="EXCELDEFAULT">

<cfif isdefined('form.locationqty')>

<cfquery name="getgeneral" datasource="#dts#">
	select compro, lastaccyear from gsetup
</cfquery>
<cfquery name="checkcustom" datasource="#dts#">
    select customcompany from dealer_menu
</cfquery>

<cfset totalqtybf=0>
<cfset totalqtyin=0>
<cfset totalqtyout=0>
<cfset totalsoqty=0>

<cfset totalbal=0>
<cfif form.locationqty eq 'no'>

<cfquery name="getitem" datasource="#dts#">
select location from iclocation where right(location,4) not in (
	select right(a.location,4)
	from lobthob as a

	left join
	(	select sum(qty) as getlastin,itemno,batchcode,location  
		from ictran
		where (type = 'RC' or type = 'CN' or type = 'OAI' or type = 'TRIN')
		and (void = '' or void is null) and (fperiod < '#form.period#' or fperiod = 99) and batchcode<>'' and location<>''
		<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
			and batchcode between '#form.batchcodefrom#' and '#form.batchcodeto#'
		</cfif>
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and itemno between '#form.itemfrom#' and '#form.itemto#'
		</cfif>
		<cfif form.locationfrom neq "" and form.locationto neq "">
			and location between '#form.locationfrom#' and '#form.locationto#'
		</cfif>
		<cfif checkcustom.customcompany eq "Y">
			<cfif trim(form.permitno) neq "">
				and (brem5='#form.permitno#' or brem7='#form.permitno#')
			</cfif>
		</cfif>
		<cfif lcase(hcomid) eq "jaynbtrading_i">
			<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
				and custno between '#form.custfrom#' and '#form.custto#'
			</cfif>
		</cfif>
		group by itemno,batchcode,location
	) as b on (a.itemno = b.itemno and a.batchcode=b.batchcode and a.location=b.location)

	left join
	(	select sum(qty) as getlastout,itemno,batchcode,location 
		from ictran
		where (type = 'INV' or type = 'PR' or type = 'CS' or type = 'DN' or type = 'ISS' or type = 'OAR' or type = 'TROU' or type = 'DO')
		and (void = '' or void is null) and (fperiod < '#form.period#' or fperiod = 99) and toinv='' and batchcode<>'' and location<>''
		<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
			and batchcode between '#form.batchcodefrom#' and '#form.batchcodeto#'
		</cfif>
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and itemno between '#form.itemfrom#' and '#form.itemto#'
		</cfif>
		<cfif form.locationfrom neq "" and form.locationto neq "">
			and location between '#form.locationfrom#' and '#form.locationto#'
		</cfif>
		<cfif checkcustom.customcompany eq "Y">
			<cfif trim(form.permitno) neq "">
				and (brem5='#form.permitno#' or brem7='#form.permitno#')
			</cfif>
		</cfif>
		<cfif lcase(hcomid) eq "jaynbtrading_i">
			<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
				and custno between '#form.custfrom#' and '#form.custto#'
			</cfif>
		</cfif>
		group by itemno,batchcode,location
	) as c on (a.itemno = c.itemno and a.batchcode=c.batchcode and a.location=c.location)
	
	left join
	(	select sum(qty) as qin,itemno,batchcode,location 
		from ictran
		where (type = 'RC' or type = 'CN' or type = 'OAI' or type = 'TRIN') 
		and (void = '' or void is null) and batchcode<>''
		and fperiod = '#form.period#'
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and itemno between '#form.itemfrom#' and '#form.itemto#'
		</cfif>
		<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
			and batchcode between '#form.batchcodefrom#' and '#form.batchcodeto#'
		</cfif>
		<cfif form.locationfrom neq "" and form.locationto neq "">
			and location between '#form.locationfrom#' and '#form.locationto#'
		</cfif>
		<cfif checkcustom.customcompany eq "Y">
			<cfif trim(form.permitno) neq "">
				and (brem5='#form.permitno#' or brem7='#form.permitno#')
			</cfif>
		</cfif>
		<cfif lcase(hcomid) eq "jaynbtrading_i">
			<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
				and custno between '#form.custfrom#' and '#form.custto#'
			</cfif>
		</cfif>  
		group by itemno,batchcode,location
	) as e on (a.itemno=e.itemno and a.batchcode=e.batchcode and a.location=e.location)

	left join
	(	select sum(qty) as qout,itemno,batchcode,location 
		from ictran
		where (type = 'INV' or type = 'PR' or type = 'CS' or type = 'DN' or type = 'ISS' or type = 'OAR' or type = 'TROU' or type = 'DO')
		and (void = '' or void is null) and toinv='' and batchcode<>''
		and fperiod = '#form.period#'
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and itemno between '#form.itemfrom#' and '#form.itemto#'
		</cfif>
		<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
			and batchcode between '#form.batchcodefrom#' and '#form.batchcodeto#'
		</cfif>
		<cfif form.locationfrom neq "" and form.locationto neq "">
			and location between '#form.locationfrom#' and '#form.locationto#'
		</cfif>
		<cfif checkcustom.customcompany eq "Y">
			<cfif trim(form.permitno) neq "">
				and (brem5='#form.permitno#' or brem7='#form.permitno#')
			</cfif>
		</cfif>
		<cfif lcase(hcomid) eq "jaynbtrading_i">
			<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
				and custno between '#form.custfrom#' and '#form.custto#'
			</cfif>
		</cfif>  
		group by itemno,batchcode,location
	) as f on (a.itemno=f.itemno and a.batchcode=f.batchcode and a.location=f.location)
    
	left join (select itemno,desp,unit,unit2,factor1,factor2,category,colorid,sizeid from icitem)as d on a.itemno = d.itemno
	
	where a.itemno<>''
		and (ifnull(a.bth_qob,0) + ifnull(a.bth_qin,0) - ifnull(a.bth_qut,0)) <> 0
		and (ifnull(a.bth_qob,0) + ifnull(b.getlastin,0) - ifnull(c.getlastout,0) + ifnull(e.qin,0) - ifnull(f.qout,0))<>0
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
	<cfif checkcustom.customcompany eq "Y">
		<cfif trim(form.permitno) neq "">
			and (a.permit_no='#form.permitno#' or a.permit_no2='#form.permitno#')
		</cfif>
	</cfif>
	<cfif form.locationfrom neq "" and form.locationto neq "">
		and a.location between '#form.locationfrom#' and '#form.locationto#'
	</cfif>
	order by <cfif isdefined('form.bylocation')>a.location,a.batchcode<cfelse>a.itemno,a.batchcode</cfif>
    ) group by right(location,4)
</cfquery>

<cfelse>

<cfquery name="getitem" datasource="#dts#">
select location from iclocation where right(location,4) in (
	select right(a.location,4)
	from lobthob as a

	left join
	(	select sum(qty) as getlastin,itemno,batchcode,location  
		from ictran
		where (type = 'RC' or type = 'CN' or type = 'OAI' or type = 'TRIN')
		and (void = '' or void is null) and (fperiod < '#form.period#' or fperiod = 99) and batchcode<>'' and location<>''
		<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
			and batchcode between '#form.batchcodefrom#' and '#form.batchcodeto#'
		</cfif>
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and itemno between '#form.itemfrom#' and '#form.itemto#'
		</cfif>
		<cfif form.locationfrom neq "" and form.locationto neq "">
			and location between '#form.locationfrom#' and '#form.locationto#'
		</cfif>
		<cfif checkcustom.customcompany eq "Y">
			<cfif trim(form.permitno) neq "">
				and (brem5='#form.permitno#' or brem7='#form.permitno#')
			</cfif>
		</cfif>
		<cfif lcase(hcomid) eq "jaynbtrading_i">
			<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
				and custno between '#form.custfrom#' and '#form.custto#'
			</cfif>
		</cfif>
		group by itemno,batchcode,location
	) as b on (a.itemno = b.itemno and a.batchcode=b.batchcode and a.location=b.location)

	left join
	(	select sum(qty) as getlastout,itemno,batchcode,location 
		from ictran
		where (type = 'INV' or type = 'PR' or type = 'CS' or type = 'DN' or type = 'ISS' or type = 'OAR' or type = 'TROU' or type = 'DO')
		and (void = '' or void is null) and (fperiod < '#form.period#' or fperiod = 99) and toinv='' and batchcode<>'' and location<>''
		<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
			and batchcode between '#form.batchcodefrom#' and '#form.batchcodeto#'
		</cfif>
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and itemno between '#form.itemfrom#' and '#form.itemto#'
		</cfif>
		<cfif form.locationfrom neq "" and form.locationto neq "">
			and location between '#form.locationfrom#' and '#form.locationto#'
		</cfif>
		<cfif checkcustom.customcompany eq "Y">
			<cfif trim(form.permitno) neq "">
				and (brem5='#form.permitno#' or brem7='#form.permitno#')
			</cfif>
		</cfif>
		<cfif lcase(hcomid) eq "jaynbtrading_i">
			<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
				and custno between '#form.custfrom#' and '#form.custto#'
			</cfif>
		</cfif>
		group by itemno,batchcode,location
	) as c on (a.itemno = c.itemno and a.batchcode=c.batchcode and a.location=c.location)
	
	left join
	(	select sum(qty) as qin,itemno,batchcode,location 
		from ictran
		where (type = 'RC' or type = 'CN' or type = 'OAI' or type = 'TRIN') 
		and (void = '' or void is null) and batchcode<>''
		and fperiod = '#form.period#'
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and itemno between '#form.itemfrom#' and '#form.itemto#'
		</cfif>
		<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
			and batchcode between '#form.batchcodefrom#' and '#form.batchcodeto#'
		</cfif>
		<cfif form.locationfrom neq "" and form.locationto neq "">
			and location between '#form.locationfrom#' and '#form.locationto#'
		</cfif>
		<cfif checkcustom.customcompany eq "Y">
			<cfif trim(form.permitno) neq "">
				and (brem5='#form.permitno#' or brem7='#form.permitno#')
			</cfif>
		</cfif>
		<cfif lcase(hcomid) eq "jaynbtrading_i">
			<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
				and custno between '#form.custfrom#' and '#form.custto#'
			</cfif>
		</cfif>  
		group by itemno,batchcode,location
	) as e on (a.itemno=e.itemno and a.batchcode=e.batchcode and a.location=e.location)

	left join
	(	select sum(qty) as qout,itemno,batchcode,location 
		from ictran
		where (type = 'INV' or type = 'PR' or type = 'CS' or type = 'DN' or type = 'ISS' or type = 'OAR' or type = 'TROU' or type = 'DO')
		and (void = '' or void is null) and toinv='' and batchcode<>''
		and fperiod = '#form.period#'
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and itemno between '#form.itemfrom#' and '#form.itemto#'
		</cfif>
		<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
			and batchcode between '#form.batchcodefrom#' and '#form.batchcodeto#'
		</cfif>
		<cfif form.locationfrom neq "" and form.locationto neq "">
			and location between '#form.locationfrom#' and '#form.locationto#'
		</cfif>
		<cfif checkcustom.customcompany eq "Y">
			<cfif trim(form.permitno) neq "">
				and (brem5='#form.permitno#' or brem7='#form.permitno#')
			</cfif>
		</cfif>
		<cfif lcase(hcomid) eq "jaynbtrading_i">
			<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
				and custno between '#form.custfrom#' and '#form.custto#'
			</cfif>
		</cfif>  
		group by itemno,batchcode,location
	) as f on (a.itemno=f.itemno and a.batchcode=f.batchcode and a.location=f.location)
	
	left join (select itemno,desp,unit,unit2,factor1,factor2,category,colorid,sizeid from icitem)as d on a.itemno = d.itemno
	
	where a.itemno<>''
		and (ifnull(a.bth_qob,0) + ifnull(a.bth_qin,0) - ifnull(a.bth_qut,0)) <> 0
		and (ifnull(a.bth_qob,0) + ifnull(b.getlastin,0) - ifnull(c.getlastout,0) + ifnull(e.qin,0) - ifnull(f.qout,0))<>0
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
	<cfif checkcustom.customcompany eq "Y">
		<cfif trim(form.permitno) neq "">
			and (a.permit_no='#form.permitno#' or a.permit_no2='#form.permitno#')
		</cfif>
	</cfif>
	<cfif form.locationfrom neq "" and form.locationto neq "">
		and a.location between '#form.locationfrom#' and '#form.locationto#'
	</cfif>
	order by <cfif isdefined('form.bylocation')>a.location,a.batchcode<cfelse>a.itemno,a.batchcode</cfif>
    ) group by right(location,4)
</cfquery>

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
			
			<Worksheet ss:Name="Location Report">
				<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="64.5"/>
					<Column ss:Width="60.25"/>
					<Column ss:Width="60.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="183.75"/>
					<Column ss:Width="27.75"/>
					<Column ss:Width="47.25"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<cfset c="8">
						<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
						<cfset c=c+1>
		   <cfoutput>
           <cfif form.locationqty eq 'no'>
           <cfwddx action = "cfml2wddx" input = "With Qty Location Report" output = "wddxText">
           <cfelse>
		   <cfwddx action = "cfml2wddx" input = "Without Qty Location Report" output = "wddxText">
           </cfif>
					<Row ss:AutoFitHeight="0" ss:Height="23.0625">
						<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
					</Row>
			
            
            <cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
            <cfif checkcustom.customcompany eq "Y">
            <cfwddx action = "cfml2wddx" input = "LOT NUMBER : #form.batchcodefrom# - #form.batchcodeto#" output = "wddxText">
            <cfelse>
            <cfwddx action = "cfml2wddx" input = "BATCH CODE : #form.batchcodefrom# - #form.batchcodeto#" output = "wddxText">
            </cfif>
			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
			<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
			</Row>
    		</cfif>
			<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
            <cfwddx action = "cfml2wddx" input = "ITEM NO: #form.itemfrom# - #form.itemto#" output = "wddxText">
            <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            <Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
            </Row>
            </cfif>
	
					
			<cfwddx action = "cfml2wddx" input = "MONTH : #ucase(dateformat(dateadd('m',val(form.period),getgeneral.lastaccyear),"mmm yy"))#" output = "wddxText">
			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
			<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
			</Row>
					<cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText">
			
					<Row ss:AutoFitHeight="0" ss:Height="20.0625">
						<Cell ss:MergeAcross="#c-1#" ss:StyleID="s26"><Data ss:Type="String">#wddxText#</Data></Cell>
						<Cell ss:StyleID="s26"><Data ss:Type="String">#dateformat(now(),"dd/mm/yyyy")#</Data></Cell>
					</Row>
				</cfoutput>
		
				<Row ss:AutoFitHeight="0" ss:Height="23.0625">
					<Cell ss:StyleID="s27"><Data ss:Type="String">Index</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">LOCATION</Data></Cell>
					
				</Row>
                <cfoutput>
                <cfset i=1>
		<cfloop query="getitem">

					<cfwddx action = "cfml2wddx" input = "#right(getitem.location,4)#" output = "wddxText">
					<Row ss:AutoFitHeight="0">
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#i#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText#</Data></Cell>
                    
					</Row>
					<cfset i=i+1>
				</cfloop>
		</cfoutput>
				<Row ss:AutoFitHeight="0" ss:Height="12"/>
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


<cfelse>


	
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
			
			<Worksheet ss:Name="Item Batch Stock Card">
				<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="64.5"/>
					<Column ss:Width="60.25"/>
					<Column ss:Width="60.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="183.75"/>
					<Column ss:Width="27.75"/>
					<Column ss:Width="47.25"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<cfset c="15">
						<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
						<cfset c=c+1>
	<cfquery name="getgeneral" datasource="#dts#">
	select compro, lastaccyear from gsetup
</cfquery>
<cfquery name="checkcustom" datasource="#dts#">
    select customcompany from dealer_menu
</cfquery>

<cfset totalqtybf=0>
<cfset totalqtyin=0>
<cfset totalqtyout=0>
<cfset totalsoqty=0>
<cfset totalbal=0>

<cfquery name="getitem" datasource="#dts#">
	select a.itemno,d.desp as itemdesp,d.unit,d.unit2,d.factor1,d.factor2,(select desp from icsizeid where sizeid=d.sizeid) as sizeid,d.category,(select desp from iccolorid where colorid=d.colorid) as countryoforigin,
	a.batchcode,a.location,a.importpermit,a.milcert<cfif checkcustom.customcompany eq "Y">,a.permit_no,a.permit_no2</cfif>,
	a.location,a.bth_qob,a.bth_qin,a.bth_qut,a.expdate,b.getlastin,c.getlastout,(ifnull(a.bth_qob,0) + ifnull(b.getlastin,0) - ifnull(c.getlastout,0)) as qtybf,
	ifnull(e.qin,0) as qin,ifnull(f.qout,0) as qout,(ifnull(a.bth_qob,0) + ifnull(b.getlastin,0) - ifnull(c.getlastout,0) + ifnull(e.qin,0) - ifnull(f.qout,0)) as balance,ifnull(g.soqty,0) as soqty
	from lobthob as a

	left join
	(	select sum(qty) as getlastin,itemno,batchcode,location  
		from ictran
		where (type = 'RC' or type = 'CN' or type = 'OAI' or type = 'TRIN')
		and (void = '' or void is null) and (fperiod < '#form.period#' or fperiod = 99) and batchcode<>'' and location<>''
		<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
			and batchcode between '#form.batchcodefrom#' and '#form.batchcodeto#'
		</cfif>
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and itemno between '#form.itemfrom#' and '#form.itemto#'
		</cfif>
		<cfif form.locationfrom neq "" and form.locationto neq "">
			and location between '#form.locationfrom#' and '#form.locationto#'
		</cfif>
		<cfif checkcustom.customcompany eq "Y">
			<cfif trim(form.permitno) neq "">
				and (brem5='#form.permitno#' or brem7='#form.permitno#')
			</cfif>
		</cfif>
		<cfif lcase(hcomid) eq "jaynbtrading_i">
			<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
				and custno between '#form.custfrom#' and '#form.custto#'
			</cfif>
		</cfif>
		group by itemno,batchcode,location
	) as b on (a.itemno = b.itemno and a.batchcode=b.batchcode and a.location=b.location)

	left join
	(	select sum(qty) as getlastout,itemno,batchcode,location 
		from ictran
		where (type = 'INV' or type = 'PR' or type = 'CS' or type = 'DN' or type = 'ISS' or type = 'OAR' or type = 'TROU' or type = 'DO')
		and (void = '' or void is null) and (fperiod < '#form.period#' or fperiod = 99) and toinv='' and batchcode<>'' and location<>''
		<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
			and batchcode between '#form.batchcodefrom#' and '#form.batchcodeto#'
		</cfif>
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and itemno between '#form.itemfrom#' and '#form.itemto#'
		</cfif>
		<cfif form.locationfrom neq "" and form.locationto neq "">
			and location between '#form.locationfrom#' and '#form.locationto#'
		</cfif>
		<cfif checkcustom.customcompany eq "Y">
			<cfif trim(form.permitno) neq "">
				and (brem5='#form.permitno#' or brem7='#form.permitno#')
			</cfif>
		</cfif>
		<cfif lcase(hcomid) eq "jaynbtrading_i">
			<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
				and custno between '#form.custfrom#' and '#form.custto#'
			</cfif>
		</cfif>
		group by itemno,batchcode,location
	) as c on (a.itemno = c.itemno and a.batchcode=c.batchcode and a.location=c.location)
	
	left join
	(	select sum(qty) as qin,itemno,batchcode,location 
		from ictran
		where (type = 'RC' or type = 'CN' or type = 'OAI' or type = 'TRIN') 
		and (void = '' or void is null) and batchcode<>''
		and fperiod = '#form.period#'
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and itemno between '#form.itemfrom#' and '#form.itemto#'
		</cfif>
		<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
			and batchcode between '#form.batchcodefrom#' and '#form.batchcodeto#'
		</cfif>
		<cfif form.locationfrom neq "" and form.locationto neq "">
			and location between '#form.locationfrom#' and '#form.locationto#'
		</cfif>
		<cfif checkcustom.customcompany eq "Y">
			<cfif trim(form.permitno) neq "">
				and (brem5='#form.permitno#' or brem7='#form.permitno#')
			</cfif>
		</cfif>
		<cfif lcase(hcomid) eq "jaynbtrading_i">
			<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
				and custno between '#form.custfrom#' and '#form.custto#'
			</cfif>
		</cfif>  
		group by itemno,batchcode,location
	) as e on (a.itemno=e.itemno and a.batchcode=e.batchcode and a.location=e.location)

	left join
	(	select sum(qty) as qout,itemno,batchcode,location 
		from ictran
		where (type = 'INV' or type = 'PR' or type = 'CS' or type = 'DN' or type = 'ISS' or type = 'OAR' or type = 'TROU' or type = 'DO')
		and (void = '' or void is null) and toinv='' and batchcode<>''
		and fperiod = '#form.period#'
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and itemno between '#form.itemfrom#' and '#form.itemto#'
		</cfif>
		<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
			and batchcode between '#form.batchcodefrom#' and '#form.batchcodeto#'
		</cfif>
		<cfif form.locationfrom neq "" and form.locationto neq "">
			and location between '#form.locationfrom#' and '#form.locationto#'
		</cfif>
		<cfif checkcustom.customcompany eq "Y">
			<cfif trim(form.permitno) neq "">
				and (brem5='#form.permitno#' or brem7='#form.permitno#')
			</cfif>
		</cfif>
		<cfif lcase(hcomid) eq "jaynbtrading_i">
			<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
				and custno between '#form.custfrom#' and '#form.custto#'
			</cfif>
		</cfif>  
		group by itemno,batchcode,location
	) as f on (a.itemno=f.itemno and a.batchcode=f.batchcode and a.location=f.location)
	
    left join
	(	select sum(qty) as SOqty,itemno,batchcode,location 
		from ictran
		where type='SO'
		and (void = '' or void is null) and toinv='' and batchcode<>''
		and fperiod = '#form.period#'
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and itemno between '#form.itemfrom#' and '#form.itemto#'
		</cfif>
		<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
			and batchcode between '#form.batchcodefrom#' and '#form.batchcodeto#'
		</cfif>
		<cfif form.locationfrom neq "" and form.locationto neq "">
			and location between '#form.locationfrom#' and '#form.locationto#'
		</cfif>
		<cfif checkcustom.customcompany eq "Y">
			<cfif trim(form.permitno) neq "">
				and (brem5='#form.permitno#' or brem7='#form.permitno#')
			</cfif>
		</cfif>
		<cfif lcase(hcomid) eq "jaynbtrading_i">
			<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
				and custno between '#form.custfrom#' and '#form.custto#'
			</cfif>
		</cfif>  
		group by itemno,batchcode,location
	) as g on (a.itemno=g.itemno and a.batchcode=g.batchcode and a.location=g.location)
    
	left join (select itemno,desp,unit,unit2,factor1,factor2,category,colorid,sizeid from icitem)as d on a.itemno = d.itemno
	
	where a.itemno<>''
	<cfif isdefined("form.figure") and form.figure eq "yes">
	<cfelse>
		and (ifnull(a.bth_qob,0) + ifnull(a.bth_qin,0) - ifnull(a.bth_qut,0)) <> 0
		and (ifnull(a.bth_qob,0) + ifnull(b.getlastin,0) - ifnull(c.getlastout,0) + ifnull(e.qin,0) - ifnull(f.qout,0))<>0
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
	<cfif checkcustom.customcompany eq "Y">
		<cfif trim(form.permitno) neq "">
			and (a.permit_no='#form.permitno#' or a.permit_no2='#form.permitno#')
		</cfif>
	</cfif>
	<cfif form.locationfrom neq "" and form.locationto neq "">
		and a.location between '#form.locationfrom#' and '#form.locationto#'
	</cfif>
	order by <cfif isdefined('form.bylocation')>a.location,a.batchcode<cfelse>a.itemno,a.batchcode</cfif>
</cfquery>
		   <cfoutput>
					<cfwddx action = "cfml2wddx" input = "Item Batch Stock Card" output = "wddxText">
					<Row ss:AutoFitHeight="0" ss:Height="23.0625">
						<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
					</Row>
			
            
            <cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
            <cfif checkcustom.customcompany eq "Y">
            <cfwddx action = "cfml2wddx" input = "LOT NUMBER : #form.batchcodefrom# - #form.batchcodeto#" output = "wddxText">
            <cfelse>
            <cfwddx action = "cfml2wddx" input = "BATCH CODE : #form.batchcodefrom# - #form.batchcodeto#" output = "wddxText">
            </cfif>
			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
			<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
			</Row>
    		</cfif>
			<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
            <cfwddx action = "cfml2wddx" input = "ITEM NO: #form.itemfrom# - #form.itemto#" output = "wddxText">
            <Row ss:AutoFitHeight="0" ss:Height="20.0625">
            <Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
            </Row>
            </cfif>
	
					
			<cfwddx action = "cfml2wddx" input = "MONTH : #ucase(dateformat(dateadd('m',val(form.period),getgeneral.lastaccyear),"mmm yy"))#" output = "wddxText">
			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
			<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
			</Row>
					<cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText">
			
					<Row ss:AutoFitHeight="0" ss:Height="20.0625">
						<Cell ss:MergeAcross="#c-1#" ss:StyleID="s26"><Data ss:Type="String">#wddxText#</Data></Cell>
						<Cell ss:StyleID="s26"><Data ss:Type="String">#dateformat(now(),"dd/mm/yyyy")#</Data></Cell>
					</Row>
				</cfoutput>
		
				<Row ss:AutoFitHeight="0" ss:Height="23.0625">
                	<cfif lcase(hcomid) eq "hempel_i">
					<Cell ss:StyleID="s27"><Data ss:Type="String">ITEM CODE</Data></Cell>
                    </cfif>
					<Cell ss:StyleID="s27"><Data ss:Type="String">ITEM DESCRIPTION</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">ORIGIN COUNTRY</Data></Cell>
                    <cfif checkcustom.customcompany eq "Y">
                    <Cell ss:StyleID="s27"><Data ss:Type="String">PERMIT NO</Data></Cell>
                    </cfif>
					<Cell ss:StyleID="s27"><Data ss:Type="String"><cfif checkcustom.customcompany eq "Y">LOT NUMBER<cfelse>ITEM BATCH</cfif></Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">LOCATION</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String"><cfif lcase(hcomid) eq "marquis_i">Lot Number<cfelse>Mil Cert</cfif></Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">Import Permit</Data></Cell>
                    <cfif lcase(hcomid) eq "hempel_i">
       				<Cell ss:StyleID="s27"><Data ss:Type="String">Pack Size</Data></Cell>
        			</cfif>
					<Cell ss:StyleID="s27"><Data ss:Type="String">B/F</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">IN</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">OUT</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">RESERVED QTY</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">BALANCE</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">UNITS</Data></Cell>
					
				</Row>
                <cfoutput>
		<cfloop query="getitem">
		<cfset xfactor1=getitem.factor1>
		<cfset xfactor2=getitem.factor2>
		<cfset xunit=getitem.unit>
		<cfset xunit2=getitem.unit2>
		
		<cfif val(xfactor1) neq 0>
			<cfif val(getitem.qtybf) gte 0>
				<cfset xqtybf=val(getitem.qtybf)/val(xfactor1)*val(xfactor2)>
			<cfelse>
				<cfset xqtybf=-(val(getitem.qtybf)/val(xfactor1)*val(xfactor2))>
			</cfif>			
			<cfif val(getitem.qin) gte 0>
				<cfset xqin=val(getitem.qin)/val(xfactor1)*val(xfactor2)>
			<cfelse>
				<cfset xqin=-(val(getitem.qin)/val(xfactor1)*val(xfactor2))>
			</cfif>
			<cfif val(getitem.qout) gte 0>
				<cfset xqout=val(getitem.qout)/val(xfactor1)*val(xfactor2)>
			<cfelse>
				<cfset xqout=-(val(getitem.qout)/val(xfactor1)*val(xfactor2))>
			</cfif>
			<cfif val(getitem.balance) gte 0>
				<cfset xbal=val(getitem.balance)/val(xfactor1)*val(xfactor2)>
			<cfelse>
				<cfset xbal=-(val(getitem.balance)/val(xfactor1)*val(xfactor2))>
			</cfif>
			
			<cfset xqtybf=Int(xqtybf)>
			<cfset xqin=Int(xqin)>
			<cfset xqout=Int(xqout)>
			<cfset xbal=Int(xbal)>
			
			<cfif val(xfactor2) neq 0>
				<cfset yqtybf=val(getitem.qtybf)-(xqtybf*val(xfactor1)/val(xfactor2))>
				<cfset yqin=val(getitem.qin)-(xqin*val(xfactor1)/val(xfactor2))>
				<cfset yqout=val(getitem.qout)-(xqout*val(xfactor1)/val(xfactor2))>
				<cfset ybal=val(getitem.balance)-(xbal*val(xfactor1)/val(xfactor2))>
			<cfelse>
				<cfset yqtybf=0>
				<cfset yqin=0>
				<cfset yqout=0>
				<cfset ybal=0>
			</cfif>
		<cfelse>
			<cfset xqtybf=0>
			<cfset yqtybf=val(getitem.qtybf)>
			
			<cfset xqin=0>
			<cfset yqin=val(getitem.qin)>
			
			<cfset xqout=0>
			<cfset yqout=val(getitem.qout)>
			
			<cfset xbal=0>
			<cfset ybal=val(getitem.balance)>
		</cfif>
        <cfset totalqtybf=totalqtybf+getitem.qtybf>
		<cfset totalqtyin=totalqtyin+getitem.qin>
		<cfset totalqtyout=totalqtyout+getitem.qout>
        <cfset totalsoqty=totalsoqty+getitem.soqty>
		<cfset totalbal=totalbal+(getitem.balance-getitem.soqty)>
				
					
			<cfquery name="getpacksize" datasource="#dts#">
            select price from ictran where type='RC' and batchcode='#getitem.batchcode#' and location='#getitem.location#'
            </cfquery>
			<cfquery name="getunit" datasource="#dts#">
                    select unit from icitem where itemno='#getitem.itemno#'
            </cfquery>
					<cfwddx action = "cfml2wddx" input = "#getitem.itemno#" output = "wddxText">
					<cfwddx action = "cfml2wddx" input = "#getitem.itemdesp#  #getitem.category#" output = "wddxText2">
                    <cfif lcase(hcomid) eq "hempel_i">
                    <cfquery name="getcountryoforigin" datasource="#dts#">
                    select countryoforigin from ictran where itemno='#getitem.itemno#' and batchcode='#getitem.batchcode#' and location='#getitem.location#' and type='RC'
                    </cfquery>
                    <cfwddx action = "cfml2wddx" input = "#getcountryoforigin.countryoforigin#" output = "wddxText3">
                    <cfelse>
                    <cfwddx action = "cfml2wddx" input = "#getitem.countryoforigin#" output = "wddxText3">
                    </cfif>
					
                    <cfif checkcustom.customcompany eq "Y">
                    <cfif getitem.permit_no neq "">
                    <cfwddx action = "cfml2wddx" input = "#getitem.permit_no#" output = "wddxText4">
                    <cfelseif getitem.permit_no2 neq "">
                    <cfwddx action = "cfml2wddx" input = "#getitem.permit_no2#" output = "wddxText4">
                    </cfif>
                    </cfif>
                    <cfwddx action = "cfml2wddx" input = "#getitem.batchcode#" output = "wddxText5">
                    <cfwddx action = "cfml2wddx" input = "#getitem.location#" output = "wddxText6">
                    <cfwddx action = "cfml2wddx" input = "#getitem.milcert#" output = "wddxText7">
                    <cfwddx action = "cfml2wddx" input = "#getitem.importpermit#" output = "wddxText8">
                    <cfif lcase(hcomid) eq "hempel_i">
                    <cfwddx action = "cfml2wddx" input = "#getitem.qtybf#" output = "wddxText9">
                    <cfwddx action = "cfml2wddx" input = "#getitem.qin#" output = "wddxText10">
                    <cfwddx action = "cfml2wddx" input = "#getitem.qout#" output = "wddxText11">
                    <cfwddx action = "cfml2wddx" input = "#getitem.soqty#" output = "wddxText14">
                    <cfwddx action = "cfml2wddx" input = "#getitem.balance-getitem.soqty#" output = "wddxText12">
                    <cfelse>
                    <cfwddx action = "cfml2wddx" input = "#xqtybf# #xunit2# #yqtybf# #xunit#" output = "wddxText9">
                    <cfwddx action = "cfml2wddx" input = "#xqin# #xunit2# #yqin# #xunit#" output = "wddxText10">
                    <cfwddx action = "cfml2wddx" input = "#xqout# #xunit2# #yqout# #xunit#" output = "wddxText11">
                    <cfwddx action = "cfml2wddx" input = "#xbal# #xunit2# #ybal# #xunit#" output = "wddxText12">
                    </cfif>
                    <cfwddx action = "cfml2wddx" input = "#getunit.unit#" output = "wddxText13">
					
					<Row ss:AutoFitHeight="0">
                    <cfif lcase(hcomid) eq "hempel_i">
						<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText#</Data></Cell>
                    </cfif>
						<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText2#</Data></Cell>
						<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText3#</Data></Cell>
                        <cfif checkcustom.customcompany eq "Y">
						<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText4#</Data></Cell>
						</cfif>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText5#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText6#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText7#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText8#</Data></Cell>
                        <cfif lcase(hcomid) eq "hempel_i">
                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#getpacksize.price#</Data></Cell>
                        </cfif>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText9#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText10#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText11#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText14#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText12#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText13#</Data></Cell>
	
					
					</Row>
					
				</cfloop>
		</cfoutput>
				<Row ss:AutoFitHeight="0" ss:Height="12"/>
				
				<cfoutput>
                
				<Row ss:AutoFitHeight="0" ss:Height="12">

					<Cell ss:StyleID="s38"><Data ss:Type="String">Grand Total</Data></Cell>
                    <cfif lcase(hcomid) eq "hempel_i">
                    <Cell ss:StyleID="s38"><Data ss:Type="String"></Data></Cell>
                    </cfif>
                    <Cell ss:StyleID="s38"><Data ss:Type="String"></Data></Cell>
                    <cfif checkcustom.customcompany eq "Y">
                    <Cell ss:StyleID="s38"><Data ss:Type="String"></Data></Cell>
                    </cfif>
                    <Cell ss:StyleID="s38"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s38"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s38"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s38"><Data ss:Type="String"></Data></Cell>
                    <cfif lcase(hcomid) eq "hempel_i">
                    <Cell ss:StyleID="s38"><Data ss:Type="String"></Data></Cell>
                    </cfif>
					<Cell ss:StyleID="s39"><Data ss:Type="Number">#totalqtybf#</Data></Cell>
					<Cell ss:StyleID="s39"><Data ss:Type="Number">#totalqtyin#</Data></Cell>
                    <Cell ss:StyleID="s39"><Data ss:Type="Number">#totalqtyout#</Data></Cell>
                    <Cell ss:StyleID="s39"><Data ss:Type="Number">#totalsoqty#</Data></Cell>
					<Cell ss:StyleID="s39"><Data ss:Type="Number">#totalbal#</Data></Cell>
					<Cell ss:StyleID="s38"/>
					
				</Row>
				</cfoutput>
				
				<Row ss:AutoFitHeight="0" ss:Height="12"/>
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
</cfcase>
</cfswitch>
