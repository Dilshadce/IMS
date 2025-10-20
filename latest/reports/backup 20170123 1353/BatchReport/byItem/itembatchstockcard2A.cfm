<html>
<head>
<title>Item Batch Stock Card 2 Detail</title>
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
<style type="text/css" media="print">
	.noprint { display: none; }
</style>
</head>

<cfif isdefined("url.df") and isdefined("url.dt")>
	<cfset dd = dateformat(url.df, "DD")>
	<cfif dd greater than '12'>
		<cfset ndf = dateformat(url.df,"YYYYMMDD")>
	<cfelse>
		<cfset ndf = dateformat(url.df,"YYYYDDMM")>
	</cfif>

	<cfset dd = dateformat(url.dt, "DD")>
	<cfif dd greater than '12'>
		<cfset ndt = dateformat(url.dt,"YYYYMMDD")>
	<cfelse>
		<cfset ndt = dateformat(url.dt,"YYYYDDMM")>
	</cfif>
</cfif>

<cfquery name="getgeneral" datasource="#dts#">
	select compro, lastaccyear from gsetup
</cfquery>
<cfquery name="checkcustom" datasource="#dts#">
    select customcompany from dealer_menu
</cfquery>

<body>
<p align="center"><font color="#000000" size="4" face="Times New Roman, Times, serif"><strong>ITEM <cfif checkcustom.customcompany eq "Y">- LOT NUMBER<cfelse>BATCH</cfif> STOCK CARD 2 Detail</strong></font></p>

<cfoutput>
<table width="100%" border="0" align="center" cellspacing="0">
	<cfif trim(url.cf) neq "" and trim(url.ct) neq "">
		<tr>
        	<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">CATEGORY: #url.cf# - #url.ct#</font></div></td>
      	</tr>
    </cfif>
    <cfif trim(url.gpf) neq "" and trim(url.gpt) neq "">
      	<tr>
        	<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">GROUP: #url.gpf# - #url.gpt#</font></div></td>
		</tr>
    </cfif>
    <cfif url.batchcodefrom neq "" and url.batchcodeto neq "">
      	<tr>
        	<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif"><cfif checkcustom.customcompany eq "Y">LOT NUMBER<cfelse>BATCH CODE</cfif>: #url.batchcodefrom# - #url.batchcodeto#</font></div></td>
      	</tr>
    </cfif>
    <cfif url.pef neq "" and url.pet neq "">
      	<tr>
        	<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">PERIOD: #url.pef# - #url.pet#</font></div></td>
      	</tr>
    </cfif>
	<cfif trim(url.pf) neq "" and trim(url.pt) neq "">
		<tr>
			<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">ITEM NO: #url.pf# - #url.pt#</font></div></td>
		</tr>
	</cfif>
    <tr>
      	<td colspan="5"><cfif getgeneral.compro neq ""><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></cfif></td>
		<td colspan="3"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
    </tr>
</table>

	<cfquery name="getictran" datasource="#dts#">
		select itemno,refno,type,wos_date,custno,name,qty,toinv,dono 
		from ictran
		where itemno = '#url.itemno#' 
		and batchcode='#url.batchcode#' and (void = '' or void is null)
		and (type = 'INV' or type = 'CN' or type = 'DN' or type = 'CS' or type = 'PR' or type = 'RC' or type = 'DO'
		or type = 'ISS' or type = 'OAI' or type = 'OAR' or type = 'TRIN' or type = 'TROU')
		<cfif url.pef neq "" and url.pet neq "">
			and fperiod between '#url.pef#' and '#url.pet#'
		</cfif>
        <cfif trim(url.df) neq "" and trim(url.dt) neq "">
        and wos_date between '#ndf#' and '#ndt#'
        </cfif>
		<cfif checkcustom.customcompany eq "Y">
			<cfif trim(url.permitno) neq "">
				and (brem5='#url.permitno#' or brem7='#url.permitno#')
			</cfif>
		</cfif>
		order by wos_date,trdatetime
	</cfquery>

	<table width="100%" border="0" align="center" cellspacing="0">
		<tr><td height="10"></td></tr>
		<tr>
        <cfquery name="getitemdesp" datasource="#dts#">
        select desp from icitem where itemno='#url.itemno#'
        </cfquery>
			<td colspan="3"><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>#url.itemno#&nbsp;&nbsp;&nbsp;#getitemdesp.desp#</strong></font></div></td>
			<td colspan="2"><cfif checkcustom.customcompany eq "Y"><font size="2" face="Times New Roman, Times, serif">PERMIT NO: <strong><cfif url.permit_no neq "">#url.permit_no#<cfelseif url.permit_no2 neq "">#url.permit_no2#</cfif></strong></font></cfif></td>
			<td colspan="2"><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>#url.batchcode#</strong></font></div></td>
			<td></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#dateformat(url.expdate,"dd-mm-yyyy")# #dateformat(url.manudate,"dd-mm-yyyy")#</strong></font></div></td>
		</tr>
		<tr>
    		<td colspan="10"><hr></td>
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
    		<td colspan="10"><hr></td>
  		</tr>
  		<tr>
    		<td></td>
    		<td></td>
			<td></td>
			<td></td>
    		<td><font size="2" face="Times New Roman, Times, serif">Balance B/F:</font></td>
    		<td></td>
   	 		<td></td>
    		<td><font size="2" face="Times New Roman, Times, serif"><div align="right">#url.itembal#</div></font></td>
  		</tr>

		<cfset totalin = 0>
		<cfset totalout = 0>
		<cfset bal = val(url.itembal)>

		<cfloop query="getictran">
			<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#dateformat(getictran.wos_date,"dd-mm-yy")#</font></div></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getictran.type#</font></div></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getictran.refno#</font></div></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getictran.custno#</font></div></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getictran.name#</font></div></td>

				<cfif getictran.type eq "RC" or getictran.type eq "CN" or getictran.type eq "OAI" or getictran.type eq "TRIN">
					<cfset totalin = totalin + val(getictran.qty)>
					<cfset bal = bal + val(getictran.qty)>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#val(getictran.qty)#</font></div></td>
					<td></td>
				<cfelse>
                <cfif getictran.toinv eq "">
					<cfset totalout = totalout + val(getictran.qty)>
					<cfset bal = bal - val(getictran.qty)>
                    </cfif>
					<td></td>
					<td><cfif getictran.toinv eq ""><div align="right"><font size="2" face="Times New Roman, Times, serif">#val(getictran.qty)#</font></div></cfif></td>
				</cfif>

				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#val(bal)#</font></div></td>
			</tr>
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