<html>
<head>
<title>Location Item Batch Stock Card</title>
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

<cfquery name="getlocation" datasource="#dts#">
	select a.location,a.desp 
	from iclocation a,lobthob b 
	where a.location=b.location
    <cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
				and b.itemno between '#form.itemfrom#' and '#form.itemto#'
			</cfif>
	<cfif form.locationfrom neq "" and form.locationto neq "">
		and a.location between '#form.locationfrom#' and '#form.locationto#'
	</cfif>
	<cfif isdefined("form.figure") and form.figure eq "yes">
	<cfelse>
		and (ifnull(b.bth_qob,0) + ifnull(b.bth_qin,0) - ifnull(b.bth_qut,0)) <> 0
	</cfif>
	<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
		and b.batchcode between '#form.batchcodefrom#' and '#form.batchcodeto#'
	</cfif>
	<cfif checkcustom.customcompany eq "Y">
		<cfif trim(form.permitno) neq "">
			and (b.permit_no='#form.permitno#' or b.permit_no2='#form.permitno#')
		</cfif>
	</cfif>
	group by a.location order by a.location
</cfquery>

<body>
<p align="center"><font color="#000000" size="4" face="Times New Roman, Times, serif"><strong>LOCATION ITEM <cfif checkcustom.customcompany eq "Y">- LOT NUMBER<cfelse>BATCH</cfif> STOCK CARD</strong></font></p>

<cfoutput>
<table width="100%" border="0" align="center" cellspacing="0">
	<cfif form.locationfrom neq "" and form.locationto neq "">
		<tr>
        	<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">LOCATION: #form.locationfrom# - #form.locationto#</font></div></td>
      	</tr>
    </cfif>
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
	<tr><td height="10"></td></tr>
</table>

<cfloop query="getlocation">
	<table width="100%" border="0" align="center" cellspacing="0">
		<tr>
			<td><div align="left"><font size="3" face="Times New Roman, Times, serif"><strong>#getlocation.location#</strong></font></div></td>
			<td></td>
			<td><div align="left"><font size="3" face="Times New Roman, Times, serif"><strong>#getlocation.desp#</strong></font></div></td>
		</tr>
		<tr><td height="10"></td></tr>
	</table>

	<cfquery name="getitem" datasource="#dts#">
		select a.itemno,d.desp as itemdesp,a.batchcode,a.milcert,a.importpermit<cfif checkcustom.customcompany eq "Y">,a.permit_no,a.permit_no2</cfif>,a.location,a.bth_qob,a.bth_qin,a.bth_qut,a.expdate,b.getlastin,c.getlastout,(ifnull(a.bth_qob,0) + ifnull(b.getlastin,0) - ifnull(c.getlastout,0)) as balance
		from lobthob as a

		left join
		(	select sum(qty) as getlastin,itemno,batchcode,location  
			from ictran
			where (type = 'RC' or type = 'CN' or type = 'OAI' or type = 'TRIN')
			and (void = '' or void is null) and fperiod < '#form.periodfrom#' and batchcode<>'' and location<>''
			<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
				and batchcode between '#form.batchcodefrom#' and '#form.batchcodeto#'
			</cfif>
			<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
				and itemno between '#form.itemfrom#' and '#form.itemto#'
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
			group by itemno,batchcode
		) as b on a.itemno = b.itemno and a.batchcode=b.batchcode and a.location=b.location

		left join
		(	select sum(qty) as getlastout,itemno,batchcode,location 
			from ictran
			where (type = 'INV' or type = 'PR' or type = 'CS' or type = 'DN' or type = 'ISS' or type = 'OAR' or type = 'TROU' or type = 'DO')
			and (void = '' or void is null) and fperiod < '#form.periodfrom#' and toinv='' and batchcode<>'' and location<>''
			<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
				and batchcode between '#form.batchcodefrom#' and '#form.batchcodeto#'
			</cfif>
			<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
				and itemno between '#form.itemfrom#' and '#form.itemto#'
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
			group by itemno,batchcode
		) as c on a.itemno = c.itemno and a.batchcode=c.batchcode and a.location=c.location
		
		left join (select itemno,desp,unit,unit2,factor1,factor2,category,colorid,sizeid from icitem)as d on a.itemno = d.itemno

		where a.itemno<>'' and a.location='#getlocation.location#'
		<cfif isdefined("form.figure") and form.figure eq "yes">
		<cfelse>
			and (ifnull(a.bth_qob,0) + ifnull(a.bth_qin,0) - ifnull(a.bth_qut,0)) <> 0
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

	<cfloop query="getitem">
		<cfquery name="getictran" datasource="#dts#">
			select itemno,refno,type,wos_date,custno,name,qty,toinv,dono 
			from ictran
			where itemno = '#getitem.itemno#' and batchcode='#getitem.batchcode#' and (void = '' or void is null) and location='#getitem.location#'
			and (type = 'INV' or type = 'CN' or type = 'DN' or type = 'CS' or type = 'PR' or type = 'RC' or type = 'DO'
			or type = 'ISS' or type = 'OAI' or type = 'OAR' or type = 'TRIN' or type = 'TROU')
			<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod between '#form.periodfrom#' and '#form.periodto#'
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
			order by wos_date,trdatetime
		</cfquery>

		<table width="100%" border="0" align="center" cellspacing="0">
          <cfquery name="getunit" datasource="#dts#">
                    select unit from icitem where itemno='#getitem.itemno#'
                    </cfquery>
			<tr>
				<td colspan="3"><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>#getitem.itemno#&nbsp;&nbsp;&nbsp;#getitem.itemdesp#<br>UNITS:'#getunit.unit#'</strong></font></div></td>
				<td colspan="2"><cfif checkcustom.customcompany eq "Y"><font size="2" face="Times New Roman, Times, serif">PERMIT NO: <strong><cfif getitem.permit_no neq "">#getitem.permit_no#<cfelseif getitem.permit_no2 neq "">#getitem.permit_no2#</cfif></strong></font></cfif></td>
				<td colspan="2"><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>#getitem.batchcode#</strong></font></div>
                <font size="2" face="Times New Roman, Times, serif"><strong>
            <br>
            <cfif lcase(hcomid) eq "marquis_i">Lot Number<cfelse>Mil Cert</cfif> : #getitem.milcert#
            <br>
            Import Permit : #getitem.importpermit#
            </strong></font>
                </td>
			</tr>
			<tr>
				<td colspan="100%"><hr></td>
			</tr>
			<tr>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">DATE</font></div></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">TYPE</font></div></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">REF NO.</font></div></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">CUST NO.</font></div></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">NAME</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">IN</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">OUT</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">BALANCE</font></div></td>
			</tr>
			<tr>
				<td colspan="100%"><hr></td>
			</tr>
			<tr>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td><font size="1" face="Times New Roman, Times, serif">Balance B/F:</font></td>
				<td></td>
				<td></td>
				<td><font size="1" face="Times New Roman, Times, serif"><div align="right">#getitem.balance#</div></font></td>
			</tr>

			<cfset totalin = 0>
			<cfset totalout = 0>
			<cfset bal = val(getitem.balance)>

			<cfloop query="getictran">
				<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
					<td><div align="left"><font size="1" face="Times New Roman, Times, serif">#dateformat(getictran.wos_date,"dd-mm-yy")#</font></div></td>
					<td><div align="left"><font size="1" face="Times New Roman, Times, serif">#getictran.type#</font></div></td>
					<td><div align="left"><font size="1" face="Times New Roman, Times, serif">#getictran.refno#</font></div></td>
					<td><div align="left"><font size="1" face="Times New Roman, Times, serif">#getictran.custno#</font></div></td>
					<td><div align="left"><font size="1" face="Times New Roman, Times, serif">#getictran.name#</font></div></td>

					<cfif getictran.type eq "RC" or getictran.type eq "CN" or getictran.type eq "OAI" or getictran.type eq "TRIN">
						<cfset totalin = totalin + val(getictran.qty)>
						<cfset bal = bal + val(getictran.qty)>
						<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#val(getictran.qty)#</font></div></td>
						<td></td>
					<cfelse>
                    	<td></td>
                    
	            		<td>	
                        <div align="right">
                        <cfif type eq "DO" and toinv neq ""><font size="2" face="Times New Roman, Times, serif"><div align="right">INV #toinv#</div></font>
						<cfelse>
						<cfset totalout = totalout + val(getictran.qty)>
						<cfset bal = bal - val(getictran.qty)>
						<font size="1" face="Times New Roman, Times, serif">#val(getictran.qty)#</font>
                        </cfif>
                        </div>
                        </td>
					</cfif>

					<td><div align="right"><font size="1" face="Times New Roman, Times, serif">#val(bal)#</font></div></td>
				</tr>
			</cfloop>
			<tr>
				<td colspan="100%"><hr></td>
			</tr>
			<tr><td><br><br><br></td></tr>
		</table>
	</cfloop>
</cfloop>
</cfoutput>
<br>
<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
</body>
</html>