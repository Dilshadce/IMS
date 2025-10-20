<html>
<head>
<title>Item Batch Stock Card</title>
<link href="../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
<style type="text/css" media="print">
	.noprint { display: none; }
</style>
</head>

<cfif form.datefrom neq "" and form.dateto neq "">
	<cfset date1=createDate(ListGetAt(form.datefrom,3,"/"),ListGetAt(form.datefrom,2,"/"),ListGetAt(form.datefrom,1,"/"))>
	<cfset date2=createDate(ListGetAt(form.dateto,3,"/"),ListGetAt(form.dateto,2,"/"),ListGetAt(form.dateto,1,"/"))>
</cfif>

<cfquery name="getgeneral" datasource="#dts#">
	select compro, lastaccyear from gsetup
</cfquery>
<cfquery name="checkcustom" datasource="#dts#">
    select customcompany from dealer_menu
</cfquery>

<cfquery name="getitem" datasource="#dts#">
	select a.itemno,d.desp as itemdesp,d.unit,d.unit2,d.factor1,d.factor2,d.sizeid,d.category,(select desp from iccolorid where colorid=d.colorid) as countryoforigin,
	a.batchcode,a.milcert,a.importpermit<cfif checkcustom.customcompany eq "Y">,a.permit_no,a.permit_no2</cfif>,
	a.bth_qob,a.bth_qin,a.bth_qut,a.exp_date,b.getlastin,c.getlastout,(ifnull(a.bth_qob,0) + ifnull(b.getlastin,0) - ifnull(c.getlastout,0)) as balance
	from obbatch as a

	left join
	(	select sum(qty) as getlastin,itemno,batchcode  
		from ictran
		where (type = 'RC' or type = 'CN' or type = 'OAI' or type = 'TRIN')
		and (void = '' or void is null) 
		and fperiod < '#form.periodfrom#' and batchcode<>''
		<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date < #date1#
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
		<cfif lcase(hcomid) eq "jaynbtrading_i">
			<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
				and custno between '#form.custfrom#' and '#form.custto#'
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
		<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date < #date1#
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
		<cfif lcase(hcomid) eq "jaynbtrading_i">
			<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
				and custno between '#form.custfrom#' and '#form.custto#'
			</cfif>
		</cfif>
		group by itemno,batchcode
	) as c on a.itemno = c.itemno and a.batchcode=c.batchcode

	left join (select itemno,desp,unit,unit2,factor1,factor2,category,colorid,sizeid,wos_group from icitem)as d on a.itemno = d.itemno
	
	where a.itemno<>''
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

<body>
<p align="center"><font color="#000000" size="4" face="Times New Roman, Times, serif"><strong>ITEM <cfif checkcustom.customcompany eq "Y">- LOT NUMBER<cfelse>BATCH</cfif> STOCK CARD</strong></font></p>

<cfoutput>
<table width="80%" border="0" align="center" cellspacing="0">
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
      	<td colspan="4"><cfif getgeneral.compro neq ""><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></cfif></td>
		<td colspan="2"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
    </tr>
</table>

<cfloop query="getitem">
	<cfset xfactor1=getitem.factor1>
	<cfset xfactor2=getitem.factor2>
	<cfset xunit=getitem.unit>
	<cfset xunit2=getitem.unit2>
	
	<cfquery name="getictran" datasource="#dts#">
		select itemno,refno,type,wos_date,custno,name,qty,toinv,dono,price,
		(amt+m_charge1+m_charge2+m_charge3+m_charge4+m_charge5+m_charge6+m_charge7) as amt 
		from ictran
		where itemno = '#getitem.itemno#' 
		and batchcode='#getitem.batchcode#' and (void = '' or void is null)
		and (type = 'INV' or type = 'CN' or type = 'DN' or type = 'CS' or type = 'PR' or type = 'RC' or type = 'DO'
		or type = 'ISS' or type = 'OAI' or type = 'OAR' or type = 'TRIN' or type = 'TROU')
		<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod between '#form.periodfrom#' and '#form.periodto#'
		</cfif>
		<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date between #date1# and #date2#
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
		<tr><td height="10"></td></tr>
         <cfquery name="getunit" datasource="#dts#">
                    select unit from icitem where itemno='#getitem.itemno#'
                    </cfquery>
		<tr>
			<td colspan="3"><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>#getitem.itemno#&nbsp;&nbsp;&nbsp;#getitem.itemdesp# #getitem.category#<br>UNITS:'#getunit.unit#'</strong></font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>#getitem.countryoforigin#</strong></font></div></td>  
			<td colspan="2"><cfif checkcustom.customcompany eq "Y"><font size="2" face="Times New Roman, Times, serif">PERMIT NO: <strong><cfif getitem.permit_no neq "">#getitem.permit_no#<cfelseif getitem.permit_no2 neq "">#getitem.permit_no2#</cfif></strong></font></cfif></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>#getitem.batchcode#</strong></font></div>
            <font size="2" face="Times New Roman, Times, serif"><strong>
            <br>
            <cfif lcase(hcomid) eq "marquis_i">Lot Number<cfelse>Mil Cert</cfif> : #getitem.milcert#
            <br>
            Import Permit : #getitem.importpermit#
            </strong></font>
            </td>
			<td colspan="2"><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#xfactor2# #xunit2# = #xfactor1# #xunit#</strong></font></div></td>
		</tr>
		<tr>
    		<td colspan="100%"><hr></td>
  		</tr>
  		<tr>
    		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">DATE</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">TYPE</font></div></td>
    		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">REF NO.</font></div></td>
    		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">IN</font></div></td>
    		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">OUT</font></div></td>
    		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">BALANCE</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">COST P/#xunit#</font></div></td>
    		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">SELL P/#xunit#</font></div></td>
    		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">AMOUNT</font></div></td>
            <cfif lcase(hcomid) eq "laihock_i"><td><div align="right"><font size="2" face="Times New Roman, Times, serif">Outward Permit</font></div></td></cfif>
  		</tr>
  		<tr>
    		<td colspan="100%"><hr></td>
  		</tr>
  		<tr>
    		<td></td>
    		<td></td>
    		<td><font size="2" face="Times New Roman, Times, serif">Balance B/F:</font></td>
    		<td></td>
   	 		<td></td>
			<cfif val(xfactor1) gt 1>
				<cfif val(getitem.balance) gte 0>
					<cfset xqtybf=val(getitem.balance)/val(xfactor1)*val(xfactor2)>				
				<cfelse>
					<cfset xqtybf=-(val(getitem.balance)/val(xfactor1)*val(xfactor2))>	
				</cfif>
				<cfset xqtybf=Int(xqtybf)>
				<cfif val(xfactor2) neq 0>
					<cfset yqtybf=val(getitem.balance)-(xqtybf*val(xfactor1)/val(xfactor2))>
				<cfelse>
					<cfset yqtybf=0>
				</cfif>
			<cfelse>
				<cfset xqtybf=0>
				<cfset yqtybf=val(getitem.balance)>
			</cfif>
    		<td><font size="2" face="Times New Roman, Times, serif"><div align="right"><cfif xqtybf neq 0>#xqtybf# #xunit2# </cfif>#yqtybf# #xunit#</div></font></td>
  		</tr>

		<cfset totalin = 0>
		<cfset totalout = 0>
		<cfset bal = val(getitem.balance)>

		<cfloop query="getictran">
			<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#dateformat(getictran.wos_date,"dd-mm-yy")#</font></div></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getictran.type#</font></div></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getictran.refno#</font></div></td>

				<cfif getictran.type eq "RC" or getictran.type eq "CN" or getictran.type eq "OAI" or getictran.type eq "TRIN">
					<cfset totalin = totalin + val(getictran.qty)>
					<cfset bal = bal + val(getictran.qty)>
					<cfif val(xfactor1) gt 1>
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
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfif xqty neq 0>#xqty# #xunit2# </cfif>#yqty# #xunit#</font></div></td>
					<td></td>
				<cfelse>
                <cfif getictran.toinv eq ''>
					<cfset totalout=totalout+val(getictran.qty)>
					<cfset bal= bal-val(getictran.qty)>
                </cfif>
					<cfif val(xfactor1) gt 1>
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
					<td></td>
                    <cfif getictran.toinv eq ''>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfif xqty neq 0>#xqty# #xunit2# </cfif>#yqty# #xunit#</font></div></td><cfelse><td></td></cfif>
				</cfif>
				<cfif val(xfactor1) gt 1>
					<cfif val(bal) gte 0>
						<cfset xbal=val(bal)/val(xfactor1)*val(xfactor2)>
					<cfelse>
						<cfset xbal=-(val(bal)/val(xfactor1)*val(xfactor2))>
					</cfif>
					
					<cfset xbal=Int(xbal)>
					<cfif val(xfactor2) neq 0>
						<cfset ybal=val(bal)-(xbal*val(xfactor1)/val(xfactor2))>
					<cfelse>
						<cfset ybal=0>
					</cfif>
				<cfelse>
					<cfset xbal=0>
					<cfset ybal=val(bal)>
				</cfif>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfif xbal neq 0>#xbal# #xunit2# </cfif>#ybal# #xunit#</font></div></td>
				<td><cfif type eq "RC" or type eq "CN" or type eq "OAI" or type eq "TRIN">
	          			<div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getictran.price,",.____")#</font> </div>
	        		</cfif>
				</td>
	      		<td><cfif type eq "INV" or type eq "DO" or type eq "DN" or type eq "CS" or type eq "PR" or type eq "ISS" or type eq "OAR" or type eq "TROU">
	         	 		<font size="2" face="Times New Roman, Times, serif"><div align="right">#numberformat(getictran.price,",.____")#</div></font>
	          		</cfif>
				</td>
	      		<td><font size="2" face="Times New Roman, Times, serif"><div align="right">#numberformat(getictran.amt,",.__")#</div></font></td>
               <cfif lcase(hcomid) eq "laihock_i"> 
               <cfquery name="getrem6" datasource="#dts#">
               select rem6 from artran where refno='#getictran.refno#' and type='#getictran.type#'
               </cfquery>
               <td><font size="2" face="Times New Roman, Times, serif"><div align="right">#getrem6.rem6#</div></font></td></cfif>
			</tr>
  		</cfloop>
		<tr>
    		<td colspan="100%"><hr></td>
  		</tr>
		<cfif val(xfactor1) gt 1>
			<cfif val(bal) gte 0>
				<cfset xbal=val(bal)/val(xfactor1)*val(xfactor2)>
			<cfelse>
				<cfset xbal=-(val(bal)/val(xfactor1)*val(xfactor2))>
			</cfif>
			<cfif val(totalin) gte 0>
				<cfset xtotalin=val(totalin)/val(xfactor1)*val(xfactor2)>
			<cfelse>
				<cfset xtotalin=-(val(totalin)/val(xfactor1)*val(xfactor2))>
			</cfif>
			<cfif val(totalout) gte 0>
				<cfset xtotalout=val(totalout)/val(xfactor1)*val(xfactor2)>
			<cfelse>
				<cfset xtotalout=-(val(totalout)/val(xfactor1)*val(xfactor2))>
			</cfif>
			
			<cfset xbal=Int(xbal)>
			<cfset xtotalin=Int(xtotalin)>
			<cfset xtotalout=Int(xtotalout)>
			<cfif val(xfactor2) neq 0>
				<cfset ybal=val(bal)-(xbal*val(xfactor1)/val(xfactor2))>
				<cfset ytotalin=val(totalin)-(xtotalin*val(xfactor1)/val(xfactor2))>
				<cfset ytotalout=val(totalout)-(xtotalout*val(xfactor1)/val(xfactor2))>
			<cfelse>
				<cfset ybal=0>
				<cfset ytotalin=0>
				<cfset ytotalout=0>
			</cfif>
		<cfelse>
			<cfset xbal=0>
			<cfset xtotalin=0>
			<cfset xtotalout=0>
			
			<cfset ybal=val(bal)>
			<cfset ytotalin=val(totalin)>
			<cfset ytotalout=val(totalout)>
		</cfif>
		<tr>
	      	<td></td>
	      	<td></td>
	      	<td><font size="2" face="Times New Roman, Times, serif"><div align="right"><strong>Total:</strong></div></font></td>
	      	<td><font size="2" face="Times New Roman, Times, serif"><div align="right"><strong><cfif xtotalin neq 0>#xtotalin# #xunit2# </cfif>#ytotalin# #xunit#</strong></div></font></td>
	      	<td><font size="2" face="Times New Roman, Times, serif"><div align="right"><strong><cfif xtotalout neq 0>#xtotalout# #xunit2# </cfif>#ytotalout# #xunit#</strong></div></font></td>
	      	<td><font size="2" face="Times New Roman, Times, serif"><div align="right"><strong><cfif xbal neq 0>#xbal# #xunit2# </cfif>#ybal# #xunit#</strong></div></font></td>
	      	<td></td>
	      	<td></td>
	      	<td></td>
	    </tr>
		<tr><td><br><br><br></td></tr>
	</table>
</cfloop>
</cfoutput>
<br>
<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
</body>
</html>