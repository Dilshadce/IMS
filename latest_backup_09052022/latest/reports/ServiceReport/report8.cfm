<cfquery name="getgeneral" datasource="#dts#">
	select a.compro,date_format(a.lastaccyear,'%Y-%m-%d') as lastaccyear,concat(',.',repeat('_',b.decl_uprice))as decl_uprice
	from gsetup as a, gsetup2 as b;
</cfquery>

<cfset grandtotal = 0>
<cfset monthtotal = arraynew(1)>


		<cfset stDecl_UPrice = getgeneral.decl_uprice>


<cfswitch expression="#form.period#">
	<cfcase value="1">
		<cfloop index="a" from="1" to="6">
			<cfset monthtotal[a] = 0>
		</cfloop>
		<cfinvoke component="salesmonth11" method="getmonthitem" returnvariable="getitem">
			<cfinvokeargument name="dts" value="#dts#">
			<cfinvokeargument name="lastaccyear" value="#getgeneral.lastaccyear#">
			<cfinvokeargument name="agentfrom" value="#form.agentfrom#">
			<cfinvokeargument name="agentto" value="#form.agentto#">
			<cfinvokeargument name="include" value="#IIF(isdefined('form.include'),'form.include',DE(isdefined('form.include')))#">
			<cfinvokeargument name="include0" value="#IIF(isdefined('form.include0'),'form.include0',DE(isdefined('form.include0')))#">
		</cfinvoke>
	</cfcase>
	<cfcase value="2">
		<cfloop index="a" from="1" to="6">
			<cfset monthtotal[a] = 0>
		</cfloop>
		<cfinvoke component="salesmonth12" method="getmonthitem" returnvariable="getitem">
			<cfinvokeargument name="dts" value="#dts#">
			<cfinvokeargument name="lastaccyear" value="#getgeneral.lastaccyear#">
			<cfinvokeargument name="agentfrom" value="#form.agentfrom#">
			<cfinvokeargument name="agentto" value="#form.agentto#">
			<cfinvokeargument name="include" value="#IIF(isdefined('form.include'),'form.include',DE(isdefined('form.include')))#">
			<cfinvokeargument name="include0" value="#IIF(isdefined('form.include0'),'form.include0',DE(isdefined('form.include0')))#">
		</cfinvoke>
	</cfcase>
	<cfcase value="3">
		<cfloop index="a" from="1" to="6">
			<cfset monthtotal[a] = 0>
		</cfloop>
		<cfinvoke component="salesmonth13" method="getmonthitem" returnvariable="getitem">
			<cfinvokeargument name="dts" value="#dts#">
			<cfinvokeargument name="lastaccyear" value="#getgeneral.lastaccyear#">
			<cfinvokeargument name="agentfrom" value="#form.agentfrom#">
			<cfinvokeargument name="agentto" value="#form.agentto#">
			<cfinvokeargument name="include" value="#IIF(isdefined('form.include'),'form.include',DE(isdefined('form.include')))#">
			<cfinvokeargument name="include0" value="#IIF(isdefined('form.include0'),'form.include0',DE(isdefined('form.include0')))#">
		</cfinvoke>
	</cfcase>
	<cfcase value="4">
		<cfloop index="a" from="1" to="18">
			<cfset monthtotal[a] = 0>
		</cfloop>
		<cfinvoke component="salesmonth14" method="getmonthitem" returnvariable="getitem">
			<cfinvokeargument name="dts" value="#dts#">
			<cfinvokeargument name="lastaccyear" value="#getgeneral.lastaccyear#">
			<cfinvokeargument name="agentfrom" value="#form.agentfrom#">
			<cfinvokeargument name="agentto" value="#form.agentto#">
			<cfinvokeargument name="include" value="#IIF(isdefined('form.include'),'form.include',DE(isdefined('form.include')))#">
			<cfinvokeargument name="include0" value="#IIF(isdefined('form.include0'),'form.include0',DE(isdefined('form.include0')))#">
		</cfinvoke>
	</cfcase>
    <cfcase value="5">
		<cfloop index="a" from="1" to="1">
			<cfset monthtotal[a] = 0>
		</cfloop>
		<cfinvoke component="salesmonthbymonth" method="getmonthitem" returnvariable="getitem">
			<cfinvokeargument name="dts" value="#dts#">
			<cfinvokeargument name="lastaccyear" value="#getgeneral.lastaccyear#">
			<cfinvokeargument name="catefrom" value="#trim(form.catefrom)#">
			<cfinvokeargument name="cateto" value="#trim(form.cateto)#">
			<cfinvokeargument name="itemfrom" value="#trim(form.itemfrom)#">
			<cfinvokeargument name="itemto" value="#trim(form.itemto)#">
			<cfinvokeargument name="agentfrom" value="#form.agentfrom#">
			<cfinvokeargument name="agentto" value="#form.agentto#">
			<cfinvokeargument name="groupfrom" value="#trim(form.groupfrom)#">
			<cfinvokeargument name="groupto" value="#trim(form.groupto)#">
			<cfinvokeargument name="label" value="#form.label#">
			<cfinvokeargument name="include" value="#IIF(isdefined('form.include'),'form.include',DE(isdefined('form.include')))#">
			<cfinvokeargument name="include0" value="#IIF(isdefined('form.include0'),'form.include0',DE(isdefined('form.include0')))#">
            <cfinvokeargument name="period" value="#form.poption#">
		</cfinvoke>
	</cfcase>
</cfswitch>

<html>
<head>
<title>Product Service By Month Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
<style type="text/css" media="print">
	.noprint { display: none; }
</style>
</head>

<body>
<cfoutput>
<table width="100%" border="0" cellspacing="0" cellpadding="2">
	<tr>
	<cfif isdefined("form.include")>
		<td colspan="25"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong> SERVICE BY MONTH REPORT (Included DN/CN)</strong></font></div></td>
    <cfelse>
		<td colspan="25"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong> SERVICE BY MONTH REPORT (Excluded DN/CN)</strong></font></div></td>
	</cfif>
	</tr>
    <tr>
      	<td colspan="25"><div align="center"><font size="2" face="Times New Roman, Times, serif">
	  		<cfswitch expression="#form.period#">
				<cfcase value="1">PERIOD 1 - 6</cfcase>
				<cfcase value="2">PERIOD 7 - 12</cfcase>
				<cfcase value="3">PERIOD 13 - 18</cfcase>
                <cfcase value="5">PERIOD #form.Poption#</cfcase>
				<cfdefaultcase>ONE YEAR</cfdefaultcase>
			</cfswitch>
	  	</font></div>
	  	</td>
    </tr>
   
  
    <cfif form.agentfrom neq "" and form.agentto neq "">
        <tr>
          	<td colspan="25"><div align="center"><font size="2" face="Times New Roman, Times, serif">AGENT: #form.agentfrom# - #form.agentto#</font></div></td>
        </tr>
    </cfif>

    <tr>
      	<td colspan="3"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
      	<td>&nbsp;</td>
      	<td>&nbsp;</td>
      	<td>&nbsp;</td>
      	<td colspan="19"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
    </tr>
    <tr>
      	<td colspan="25"><hr></td>
    </tr>
    <tr>
		<td><font size="2" face="Times New Roman, Times, serif">NO</font></td>
      	<td><font size="2" face="Times New Roman, Times, serif">SERVICES NO.</font></td>
	  	<td><font size="2" face="Times New Roman, Times, serif">DESP</font></td>
		<cfswitch expression="#form.period#">
			<cfcase value="1">
				<cfloop index="l" from="1" to="6">
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(dateadd('m',l,getgeneral.lastaccyear),"mmm yy")#</font></div></td>
				</cfloop>
			</cfcase>
			<cfcase value="2">
				<cfloop index="l" from="7" to="12">
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(dateadd('m',l,getgeneral.lastaccyear),"mmm yy")#</font></div></td>
				</cfloop>
			</cfcase>
			<cfcase value="3">
				<cfloop index="l" from="13" to="18">
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(dateadd('m',l,getgeneral.lastaccyear),"mmm yy")#</font></div></td>
				</cfloop>
			</cfcase>
            <cfcase value="5">
				<cfloop index="l" from="#form.poption#" to="#form.poption#">
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(dateadd('m',l,getgeneral.lastaccyear),"mmm yy")#</font></div></td>
				</cfloop>
			</cfcase>
			<cfdefaultcase>
				<cfloop index="l" from="1" to="18">
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(dateadd('m',l,getgeneral.lastaccyear),"mmm yy")#</font></div></td>
				</cfloop>
			</cfdefaultcase>
		</cfswitch>
	  	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">TOTAL</font></div></td>
    </tr>
    <tr>
      	<td colspan="25"><hr></td>
    </tr>

	<cfloop query="getitem">
		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
			<td><font size="2" face="Times New Roman, Times, serif">#getitem.currentrow#.</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#getitem.servi#</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#getitem.desp#</font></td>

			<cfswitch expression="#form.period#">
				<cfcase value="1,2,3" delimiters=",">
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.sump1,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.sump2,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.sump3,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.sump4,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.sump5,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.sump6,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.total,stDecl_UPrice)#</font></div></td>
					<cfset monthtotal[1] = monthtotal[1] + getitem.sump1>
					<cfset monthtotal[2] = monthtotal[2] + getitem.sump2>
					<cfset monthtotal[3] = monthtotal[3] + getitem.sump3>
					<cfset monthtotal[4] = monthtotal[4] + getitem.sump4>
					<cfset monthtotal[5] = monthtotal[5] + getitem.sump5>
					<cfset monthtotal[6] = monthtotal[6] + getitem.sump6>
					<cfset grandtotal = grandtotal + getitem.total>
				</cfcase>
                <cfcase value="5">
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.sump1,stDecl_UPrice)#</font></div></td>
                <cfset monthtotal[1] = monthtotal[1] + getitem.sump1>
				<cfset grandtotal = grandtotal + getitem.total>
                </cfcase>
				<cfdefaultcase>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.sump1,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.sump2,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.sump3,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.sump4,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.sump5,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.sump6,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.sump7,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.sump8,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.sump9,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.sump10,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.sump11,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.sump12,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.sump13,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.sump14,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.sump15,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.sump16,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.sump17,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.sump18,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.total,stDecl_UPrice)#</font></div></td>
					<cfset monthtotal[1] = monthtotal[1] + getitem.sump1>
					<cfset monthtotal[2] = monthtotal[2] + getitem.sump2>
					<cfset monthtotal[3] = monthtotal[3] + getitem.sump3>
					<cfset monthtotal[4] = monthtotal[4] + getitem.sump4>
					<cfset monthtotal[5] = monthtotal[5] + getitem.sump5>
					<cfset monthtotal[6] = monthtotal[6] + getitem.sump6>
					<cfset monthtotal[7] = monthtotal[7] + getitem.sump7>
					<cfset monthtotal[8] = monthtotal[8] + getitem.sump8>
					<cfset monthtotal[9] = monthtotal[9] + getitem.sump9>
					<cfset monthtotal[10] = monthtotal[10] + getitem.sump10>
					<cfset monthtotal[11] = monthtotal[11] + getitem.sump11>
					<cfset monthtotal[12] = monthtotal[12] + getitem.sump12>
					<cfset monthtotal[13] = monthtotal[13] + getitem.sump13>
					<cfset monthtotal[14] = monthtotal[14] + getitem.sump14>
					<cfset monthtotal[15] = monthtotal[15] + getitem.sump15>
					<cfset monthtotal[16] = monthtotal[16] + getitem.sump16>
					<cfset monthtotal[17] = monthtotal[17] + getitem.sump17>
					<cfset monthtotal[18] = monthtotal[18] + getitem.sump18>
					<cfset grandtotal = grandtotal + getitem.total>
				</cfdefaultcase>
			</cfswitch>
		</tr>
	</cfloop>
	<tr>
    	<td colspan="25"><hr></td>
    </tr>
    <tr>
		<td></td>
		<td></td>
    	<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>TOTAL:</strong></font></div></td>
		<cfswitch expression="#form.period#">
			<cfcase value="1,2,3" delimiters=",">
				<cfloop index="a" from="1" to="6">
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(monthtotal[a],stDecl_UPrice)#<strong></strong></font></div></td>
				</cfloop>
			</cfcase>

			<cfdefaultcase>
				<cfloop index="a" from="1" to="18">
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(monthtotal[a],stDecl_UPrice)#<strong></strong></font></div></td>
				</cfloop>
			</cfdefaultcase>
		</cfswitch>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(grandtotal,stDecl_UPrice)#</strong></font></div></td>
	</tr>
</table>
</cfoutput>

<cfif getitem.recordcount eq 0>
	<h3>Sorry, No records were found.</h3>
	<cfabort>
</cfif>

<br>
<br>
<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
</body>
</html>