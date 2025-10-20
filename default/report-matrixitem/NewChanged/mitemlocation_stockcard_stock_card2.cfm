<html>
<head>
<title>View <cfif lcase(hcomid) eq "mhca_i">Marketer<cfelse>Location</cfif> Item Details</title>
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
</head>

<cfparam name="totalin" default="0">
<cfparam name="totalout" default="0">

		<cfset ndateto=dateformat(url.dt,"YYYYMMDD")>


<cfquery name="getgeneral" datasource="#dts#">
	select compro, lastaccyear from gsetup
</cfquery>

<cfquery name="getqtybf" datasource="#dts#">
select locqfield from locqdbf where itemno='#url.itemno#' and location='#url.location#'
</cfquery>
<cfset itembal='#getqtybf.locqfield#'>

<cfquery name="getictran" datasource="#dts#">
	select 
	a.itemno,
	a.desp,
	a.qtybf,
	b.refno,
	b.itemno,
	b.type,
	b.dono,
	b.wos_date,
	<cfif lcase(hcomid) eq "ovas_i">
		if(b.type='TROU' or b.type='TRIN',concat('Transfer - ',b.name),b.name) as name,
	<cfelse>
		if(b.type in ('TROU','TRIN'),'Transfer',b.name) as name,
	</cfif>
	b.price,
	b.qty,
	b.toinv,
	(b.amt+b.m_charge1+b.m_charge2+b.m_charge3+b.m_charge4+b.m_charge5+b.m_charge6+b.m_charge7) as amt
	<cfif lcase(hcomid) eq "ovas_i">
		,c.drivername
	</cfif>
	from icitem a,ictran b
	<cfif lcase(hcomid) eq "ovas_i">
		,(
			select a.type,a.refno,a.van,concat(dr.name,' ',dr.name2) as drivername 
			from artran a
			left join driver dr on a.van=dr.driverno
					
			where 0=0
			<cfif url.pet neq "">
				and a.fperiod <= '#pet#'
			</cfif>
			<cfif url.dt neq "">
				and a.wos_date <= '#ndateto#'
			<cfelse>
				and a.wos_date > #getgeneral.lastaccyear#
			</cfif>
		)as c
	</cfif>
	where a.itemno=b.itemno 
	and a.itemno='#url.itemno#' 
	and (b.void = '' or b.void is null)
	and (b.linecode <> 'SV' or linecode is null)
	and b.type in ('INV','CN','DN','CS','PR','RC','DO','ISS','OAI','OAR','TRIN','TROU') 
	and b.fperiod<>'99'
	and b.location='#url.location#'
	<cfif url.pet neq "">
		and b.fperiod <= '#pet#'
	</cfif>
	<cfif url.dt neq "">
		and b.wos_date <= '#ndateto#'
	<cfelse>
		and b.wos_date > #getgeneral.lastaccyear#
	</cfif>
	<cfif lcase(hcomid) eq "ovas_i">
		and if(b.type='TROU' or b.type='TRIN','TR',b.type)=c.type and b.refno=c.refno
	</cfif>
	order by b.wos_date, b.trdatetime
</cfquery>

<body>
<p align="center"><font size="4" face="Times New Roman, Times, serif"><strong>Item DETAILS</strong></font></p>

<table width="100%" border="0" align="center" cellspacing="0">
<cfoutput>
	<cfif url.cf neq "" and url.ct neq "">
		<tr>
        	<td colspan="9" align="center"><font size="2" face="Times New Roman, Times, serif">Category From #url.cf# To #url.ct#</font></td>
      	</tr>
    </cfif>
    <cfif url.gpf neq "" and url.gpt neq "">
      	<tr>
        	<td colspan="9" align="center"><font size="2" face="Times New Roman, Times, serif">Group From #url.gpf# To #url.gpt#</font></td>
		</tr>
    </cfif>
    <cfif url.pet neq "">
      	<tr>
        	<td colspan="9" align="center"><font size="2" face="Times New Roman, Times, serif">Period #url.pet#</font></td>
      	</tr>
    </cfif>
    <cfif url.dt neq "">
      	<tr>
        	<td colspan="9" align="center"><font size="2" face="Times New Roman, Times, serif">Date #dateformat(url.dt,'dd/mm/yyyy')#</font></td>
      	</tr>
    </cfif>
    <tr>
      	<td colspan="7"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
		<td colspan="2"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
    </tr>
	<tr>
        <td colspan="9"><font size="2" face="Times New Roman, Times, serif"><cfif lcase(hcomid) eq "mhca_i">MARKETER<cfelse>LOCATION</cfif>: #url.location#</font></td>
    </tr>
	<tr>
        <td colspan="9"><font size="2" face="Times New Roman, Times, serif">ITEM NO: #url.itemno# </font></td>
    </tr>
	<tr>
    	<td colspan="12"><hr></td>
  	</tr>
</cfoutput>
  	<tr>
    	<td><div align="center"><font size="2" face="Times New Roman, Times, serif">DATE</font></div></td>
    	<td><div align="left"><font size="2" face="Times New Roman, Times, serif">REFNO</font></div></td>
    	<td><div align="left"><font size="2" face="Times New Roman, Times, serif">DESCRIPTION</font></div></td>
    	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">IN</font></div></td>
    	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">OUT</font></div></td>
    	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">BALANCE</font></div></td>
    	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">COST P.</font></div></td>
    	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">SELL P.</font></div></td>
    	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">AMOUNT</font></div></td>
  	</tr>
  	<tr>
    	<td colspan="12"><hr></td>
  	</tr>
  	<tr>
    	<td></td>
    	<td></td>
    	<td><font size="2" face="Times New Roman, Times, serif">Balance B/F:</font></td>
    	<td></td>
   	 	<td></td>
    	<td><font size="2" face="Times New Roman, Times, serif"><div align="right"><cfoutput>#itembal#</cfoutput></div></font></td>
    	<td></td>
    	<td></td>
    	<td></td>
  	</tr>
  <cfloop query="getictran">
  <cfoutput>
    	<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
      		<td><div align="center"><font size="2" face="Times New Roman, Times, serif">#dateformat(wos_date,"dd/mm/yy")#</font></div></td>
      		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#type# #refno#</font></div></td>
      		<td><font size="2" face="Times New Roman, Times, serif">#name#<cfif lcase(hcomid) eq "ovas_i" and drivername neq ""> - #drivername#</cfif></font></td>
      		<td><cfif type eq "RC" or type eq "CN" or type eq "OAI" or type eq "TRIN">
          			<cfset itembal = itembal + qty>
          			<cfset totalin = totalin + qty>
         			<font size="2" face="Times New Roman, Times, serif"><div align="right">#qty#</div></font>
				</cfif>
			</td>
      		<td><cfif type eq "INV" or type eq "DO" or type eq "DN" or type eq "CS" or type eq "PR" or type eq "ISS" or type eq "OAR" or type eq "TROU">
          			<cfif type eq "DO" and toinv neq "">
            			<font size="2" face="Times New Roman, Times, serif"><div align="right">INV #toinv#</div></font>
					<cfelse>
            			<cfset itembal = itembal - qty>
            			<cfset totalout = totalout + qty>
            			<font size="2" face="Times New Roman, Times, serif"><div align="right">#qty#</div></font>
          			</cfif>
        		</cfif>
			</td>
      		<td><cfif type eq "DO" and toinv neq "">
          		<cfelse>
          			<font size="2" face="Times New Roman, Times, serif"><div align="right">#itembal#</div></font>
          		</cfif>
			</td>
      		<td><cfif type eq "RC" or type eq "CN" or type eq "OAI" or type eq "TRIN">
          			<div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(price,",.____")#</font> </div>
        		</cfif>
			</td>
      		<td><cfif type eq "INV" or type eq "DO" or type eq "DN" or type eq "CS" or type eq "PR" or type eq "ISS" or type eq "OAR" or type eq "TROU">
         	 		<font size="2" face="Times New Roman, Times, serif"><div align="right">#numberformat(price,",.____")#</div></font>
          		</cfif>
			</td>
      		<td><font size="2" face="Times New Roman, Times, serif"><div align="right">#numberformat(amt,",.__")#</div></font></td>
    	</tr>
	</cfoutput>
  	</cfloop>

	<tr>
    	<td colspan="9"><hr></td>
  	</tr>

	<cfoutput>
    <tr>
      	<td></td>
      	<td></td>
      	<td><font size="2" face="Times New Roman, Times, serif"><div align="right"><strong>Total:</strong></div></font></td>
      	<td><font size="2" face="Times New Roman, Times, serif"><div align="right"><strong>#totalin#</strong></div></font></td>
      	<td><font size="2" face="Times New Roman, Times, serif"><div align="right"><strong>#totalout#</strong></div></font></td>
      	<td><font size="2" face="Times New Roman, Times, serif"><div align="right"><strong>#itembal#</strong></div></font></td>
      	<td></td>
      	<td></td>
      	<td></td>
    </tr>
  	</cfoutput>
</table>
<br>
<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
</body>
</html>