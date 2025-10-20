<html>
<head>
<title>Historical Reports</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
<style type="text/css" media="print">
	.noprint { display: none; }
</style>
</head>

<body>
<cfquery name="getgeneral" datasource="#dts#">
	select compro,lastaccyear from gsetup
</cfquery>

<cfquery name="getgsetup2" datasource='#dts#'>
  Select * from gsetup2
</cfquery>

<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
<cfset stDecl_UPrice = ",___.">

<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
  <cfset stDecl_UPrice = stDecl_UPrice & "_">
</cfloop>

<cfoutput>
	<table width="100%" border="0" cellspacing="0" cellpadding="2" on>
		<tr> 
		  <td colspan="13"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>View Batch Summary</strong></font></div></td>
		</tr>
		<tr>
			<cfif isdefined("form.periodfrom") and form.periodfrom neq "" and form.periodto neq "">
			<td colspan="13"><div align="center"><font size="2" face="Times New Roman, Times, serif">PERIOD: #form.periodfrom# - #form.periodto#</font></div></td>
			</cfif>
		</tr>
		<tr> 
			<td colspan="2"><font size="2" face="Times New Roman, Times, serif"> 
				<cfif getgeneral.compro neq "">
			  	#getgeneral.compro# 
				</cfif>
				</font>
			</td>
		  	<td>&nbsp;</td>
		  	<td>&nbsp;</td>
		  	<td>&nbsp;</td>
		  	<td colspan="8"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
		</tr>
		<tr> 
			<td colspan="13"><hr></td>
		</tr>
		<tr> 
		  	<td><div align="left"><font size="2" face="Times New Roman, Times, serif">PERIOD</font></div></td>
		  	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">RC</font></div></td>
	 	 	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">PR</font></div></td>
      		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">DO</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">INV</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">CS</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">CN</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">DN</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">ISS</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">OAI</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">OAR</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">TR</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">TOTAL</font></div></td>
    	</tr>
    	<tr> 
      		<td colspan="13"><hr></td>
    	</tr>
	
	<cfset pfrom = val(form.periodfrom)>
	<cfset pto = val(form.periodto)>
	<cfset vtotal = arraynew(1)>
	
	<cfloop index="q" from="1" to="11">
		<cfset vtotal[#q#] = 0>
	</cfloop>
	
	<cfloop index="a" from="#pfrom#" to="#pto#">
		<cfset mperiod = a>
		
		<cfquery name="getresult" datasource="#dts#">
			select count(type) as notype, type, fperiod from artran where wos_date > #getgeneral.lastaccyear# 
			and fperiod = #mperiod# and void = ""
			group by type order by type 
		</cfquery>
		
		<tr> 
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#a#</font></div></td>
		
		<cfset norc = 0>
		<cfset nopr = 0>
		<cfset nodo = 0>
		<cfset noinv = 0>
		<cfset nocs = 0>
		<cfset nocn = 0>
		<cfset nodn = 0>
		<cfset noiss = 0>
		<cfset nooai = 0>
		<cfset nooar = 0>
		<cfset notr = 0>
		
		<cfloop query="getresult">
			<cfswitch expression="#getresult.type#">
				<cfcase value="rc"><cfset norc = val(getresult.notype)><cfset vtotal[1] = vtotal[1] + norc></cfcase>
				<cfcase value="pr"><cfset nopr = val(getresult.notype)><cfset vtotal[2] = vtotal[2] + nopr></cfcase>
				<cfcase value="do"><cfset nodo = val(getresult.notype)><cfset vtotal[3] = vtotal[3] + nodo></cfcase>
				<cfcase value="inv"><cfset noinv = val(getresult.notype)><cfset vtotal[4] = vtotal[4] + noinv></cfcase>
				<cfcase value="cs"><cfset nocs = val(getresult.notype)><cfset vtotal[5] = vtotal[5] + nocs></cfcase>
				<cfcase value="cn"><cfset nocn = val(getresult.notype)><cfset vtotal[6] = vtotal[6] + nocn></cfcase>
				<cfcase value="dn"><cfset nodn = val(getresult.notype)><cfset vtotal[7] = vtotal[7] + nodn></cfcase>
				<cfcase value="iss"><cfset noiss = val(getresult.notype)><cfset vtotal[8] = vtotal[8] + noiss></cfcase>
				<cfcase value="oai"><cfset nooai = val(getresult.notype)><cfset vtotal[9] = vtotal[9] + nooai></cfcase>
				<cfcase value="oar"><cfset nooar = val(getresult.notype)><cfset vtotal[10] = vtotal[10] + nooar></cfcase>
				<cfcase value="tr"><cfset notr = val(getresult.notype)><cfset vtotal[11] = vtotal[11] + notr></cfcase>
			</cfswitch>
		</cfloop>
		
		<cfif norc neq 0>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#norc#</font></div></td>
		<cfelse>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">-</font></div></td>
		</cfif>
		<cfif nopr neq 0>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#nopr#</font></div></td>
		<cfelse>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">-</font></div></td>
		</cfif>
		<cfif nodo neq 0>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#nodo#</font></div></td>
		<cfelse>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">-</font></div></td>
		</cfif>
		<cfif noinv neq 0>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#noinv#</font></div></td>
		<cfelse>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">-</font></div></td>
		</cfif>
		<cfif nocs neq 0>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#nocs#</font></div></td>
		<cfelse>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">-</font></div></td>
		</cfif>
		<cfif nocn neq 0>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#nocn#</font></div></td>
		<cfelse>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">-</font></div></td>
		</cfif>
		<cfif nodn neq 0>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#nodn#</font></div></td>
		<cfelse>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">-</font></div></td>
		</cfif>
		<cfif noiss neq 0 >
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#noiss#</font></div></td>
		<cfelse>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">-</font></div></td>
		</cfif>
		<cfif nooai neq 0>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#nooai#</font></div></td>
		<cfelse>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">-</font></div></td>
		</cfif>
		<cfif nooar neq 0>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#nooar#</font></div></td>
		<cfelse>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">-</font></div></td>
		</cfif>
		<cfif notr neq 0>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#notr#</font></div></td>
		<cfelse>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">-</font></div></td>
		</cfif>
			
		<cfset total = norc + nopr + nodo + noinv + nocs + nocn + nodn + noiss + nooai + nooar + notr>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#total#</font></div></td>
		<cfflush>
	</cfloop>
		</tr>
	<tr> 
		<td colspan="13"><hr></td>
	</tr>
	<tr>
		<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>TOTAL:</strong></font></div></td>
		<cfloop index="z" from="1" to="11">
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(vtotal[z],"0")#</strong></font></div></td>
		</cfloop>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(arraysum(vtotal),"0")#</strong></font></div></td>
	</tr>
  </table>
</cfoutput>

<cfif getresult.recordcount eq 0>
	<h4 style="color:red">Sorry, No records were found.</h4>
</cfif> 

<br>
<br>
<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
</body>
</html>