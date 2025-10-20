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

<cfif isdefined("form.datefrom") and isdefined("form.dateto")>
	<cfif form.datefrom neq "" and form.dateto neq "">
		<cfset date1 = createDate(ListGetAt(form.datefrom,3,"/"),ListGetAt(form.datefrom,2,"/"),ListGetAt(form.datefrom,1,"/"))>
		<cfset date2 = createDate(ListGetAt(form.dateto,3,"/"),ListGetAt(form.dateto,2,"/"),ListGetAt(form.dateto,1,"/"))>
	</cfif>
</cfif>

<cfif isdefined("form.marktype") and form.marktype neq "">
	<cfset typelist=form.marktype>
<cfelse>
	<cfset typelist="rc,pr,inv,do,cs,cn,dn,iss,oai,oar,trin,trou"> 
</cfif>

<cfquery name="getresult" datasource="#dts#">
	select a.type,a.refno,a.fperiod,a.wos_date,a.itemno,a.desp,a.despa,a.comment,a.itemcount,a.custno,a.name,a.dono,a.qty,a.price,a.amt <cfif hcomid eq "fdipx_i">,a.joborderno</cfif>
	from ictran a
	where 
	type in (#ListQualify(typelist,"'")#)
    <cfif isdefined('form.showfoc')>
    and foc='Y'
    </cfif>
	<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
		and a.itemno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemto#">
	</cfif>
	<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		and a.wos_group between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.groupfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.groupto#">
	</cfif>
	<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "" and trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
		and ((a.custno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custto#">) 
		or (a.custno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.suppfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.suppto#">))
	<cfelseif (trim(form.custfrom) neq "" and trim(form.custto) neq "") and (trim(form.suppfrom) eq "" or trim(form.suppto) eq "")>
		and a.custno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custto#">
	<cfelseif (trim(form.suppfrom) neq "" and trim(form.suppto) neq "") and (trim(form.custfrom) eq "" or trim(form.custto) eq "")>
		and a.custno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.suppfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.suppto#">
	</cfif>
	<cfif form.periodfrom neq "" and form.periodto neq "">
		and a.fperiod between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.periodfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.periodto#">
	</cfif>
	<cfif form.datefrom neq "" and form.dateto neq "">
		and wos_date between #date1# and #date2#
	<cfelse>
		and wos_date > #getgeneral.lastaccyear#
	</cfif>
	<cfif trim(form.locfrom) neq "" and trim(form.locto) neq "">
		and a.location between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.locfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.locto#">
	</cfif>
	<cfif form.billagent neq "">
		and agenno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billagent#">
	</cfif>
	<cfif form.reffrom neq "" and form.refto neq "">
		and a.refno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.reffrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.refto#">
	</cfif>
	<cfif isdefined("form.includeservice")>
	<cfelse>
		and (linecode <> 'SV' or linecode is null)
	</cfif>
    <cfif hcomid eq "fdipx_i">
    group by a.custno
    </cfif>
	order by #sortby#
</cfquery>

<cfoutput>
<table width="100%" border="0" cellspacing="0" cellpadding="2">
	<tr> 
		<td colspan="100%"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>LIST HISTORICAL PRICE</strong></font></div></td>
	</tr>
	<cfif trim(form.heading) neq "">
		<tr> 
			<td colspan="100%"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>#form.heading#</strong></font></div></td>
		</tr>
	</cfif>
	<cfif isdefined("form.periodfrom") and form.periodfrom neq "" and form.periodto neq "">
		<tr>
			<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">PERIOD: #form.periodfrom# - #form.periodto#</font></div></td>
		</tr>
	</cfif>
	<cfif isdefined("form.datefrom") and form.datefrom neq "" and form.dateto neq "">
		<tr> 
      		<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">DATE: #dateformat(form.datefrom,"dd/mm/yyyy")# - #dateformat(form.dateto,"dd/mm/yyyy")#</font></div></td>
    	</tr>
	</cfif>
	<cfif isdefined("form.reffrom") and form.reffrom neq "" and form.refto neq "">
		<tr>
			<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">REF NO: #form.reffrom# - #form.refto#</font></div></td>
		</tr>
	</cfif>
	<cfif isdefined("form.custfrom") and trim(form.custfrom) neq "" and trim(form.custto) neq "">
		<tr>
			<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">CUST: #form.custfrom# - #form.custto#</font></div></td>
		</tr>
	</cfif>
	<cfif isdefined("form.suppfrom") and trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
		<tr>
			<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">SUPP: #form.suppfrom# - #form.suppto#</font></div></td>
		</tr>
	</cfif>
	<cfif isdefined("form.billagent") and form.billagent neq "">
		<tr>
			<td colspan="13"><div align="center"><font size="2" face="Times New Roman, Times, serif">AGENT: #form.billagent#</font></div></td>
		</tr>
	</cfif>
    <cfif hcomid neq "fdipx_i">
	<tr> 
		<td colspan="5"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
		<td colspan="5"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
	</tr>
	<tr> 
		<td colspan="100%"><hr></td>
	</tr>
	<tr> 
		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">PD</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">DATE</font></div></td>
	 	<td><div align="center"><font size="2" face="Times New Roman, Times, serif">TYPE</font></div></td>
      	<td><div align="left"><font size="2" face="Times New Roman, Times, serif">REF NO</font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">DESP/SUPP.</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">ITEM NO.</font></div></td>
	 	<td><div align="left"><font size="2" face="Times New Roman, Times, serif">X-REFNO</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">QTY</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">U.PRICE</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">AMOUNT</font></div></td>
    </tr>
    <tr> 
    	<td colspan="100%"><hr></td>
    </tr>
    </cfif>
	
	<cfset ttqty=0>
	<cfset ttamt=0>
	<cfset counter=0>
    
    <cfif hcomid eq "fdipx_i">
    
    <cfloop query="getresult">
    
    <cfquery name="getresult2" datasource="#dts#">
	select a.type,a.refno,a.fperiod,a.wos_date,a.itemno,a.desp,a.despa,a.comment,a.itemcount,a.custno,a.name,a.dono,a.qty,a.price,a.amt <cfif hcomid eq "fdipx_i">,a.joborderno</cfif>
	from ictran a
	where 
	type in (#ListQualify(typelist,"'")#)
    <cfif isdefined('form.showfoc')>
    and foc='Y'
    </cfif>
	<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
		and a.itemno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemto#">
	</cfif>
	<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		and a.wos_group between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.groupfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.groupto#">
	</cfif>
	<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "" and trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
		and ((a.custno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custto#">) 
		or (a.custno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.suppfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.suppto#">))
	<cfelseif (trim(form.custfrom) neq "" and trim(form.custto) neq "") and (trim(form.suppfrom) eq "" or trim(form.suppto) eq "")>
		and a.custno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custto#">
	<cfelseif (trim(form.suppfrom) neq "" and trim(form.suppto) neq "") and (trim(form.custfrom) eq "" or trim(form.custto) eq "")>
		and a.custno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.suppfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.suppto#">
	</cfif>
	<cfif form.periodfrom neq "" and form.periodto neq "">
		and a.fperiod between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.periodfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.periodto#">
	</cfif>
	<cfif form.datefrom neq "" and form.dateto neq "">
		and wos_date between #date1# and #date2#
	<cfelse>
		and wos_date > #getgeneral.lastaccyear#
	</cfif>
	<cfif trim(form.locfrom) neq "" and trim(form.locto) neq "">
		and a.location between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.locfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.locto#">
	</cfif>
	<cfif form.billagent neq "">
		and agenno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billagent#">
	</cfif>
	<cfif form.reffrom neq "" and form.refto neq "">
		and a.refno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.reffrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.refto#">
	</cfif>
	<cfif isdefined("form.includeservice")>
	<cfelse>
		and (linecode <> 'SV' or linecode is null)
	</cfif>
    and custno='#getresult.custno#'
	order by #sortby#
</cfquery>
<tr> 
		<td colspan="5"><font size="2" face="Times New Roman, Times, serif">#getresult.name#</font></td>
		<td colspan="5"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
	</tr>
	<tr> 
		<td colspan="100%"><hr></td>
	</tr>
	<tr> 
		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">PD</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">DATE</font></div></td>
	 	<td><div align="center"><font size="2" face="Times New Roman, Times, serif">TYPE</font></div></td>
      	<td><div align="left"><font size="2" face="Times New Roman, Times, serif">REF NO</font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">DESP/SUPP.</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">ITEM NO.</font></div></td>
	 	<td><div align="left"><font size="2" face="Times New Roman, Times, serif">X-REFNO</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">QTY</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">U.PRICE</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">AMOUNT</font></div></td>
    </tr>
    <tr> 
    	<td colspan="100%"><hr></td>
    </tr>
    <cfloop query="getresult2">

		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getresult2.fperiod#</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#dateformat(getresult2.wos_date,"dd-mm-yyyy")#</font></div></td>
			<td><div align="center"><font size="2" face="Times New Roman, Times, serif">#getresult2.type#</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><a href="bill.cfm?type=#getresult.type#&refno=#getresult.refno#">#getresult2.refno#</a></font></div></td>
            <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getresult2.desp#<cfif getresult2.despa neq "">&nbsp;/&nbsp;#getresult2.despa#</cfif><cfif replace(tostring(getresult2.comment),chr(10)," ","all") neq "">&nbsp;/&nbsp;#replace(tostring(getresult2.comment),chr(10)," ","all")#</cfif><cfif hcomid eq "fdipx_i"><cfif joborderno neq ''>&nbsp;/&nbsp;Job Order No. #joborderno#</cfif></cfif></font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getresult2.itemno#</font></div></td>
			
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getresult2.custno#</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getresult2.qty,".___")#</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getresult2.price,stDecl_UPrice)#</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getresult2.amt,stDecl_UPrice)#</font></div></td>
		</tr>
		<cfset ttqty=ttqty+val(getresult2.qty)>
		<cfset ttamt=ttamt+val(getresult2.amt)>
		<cfset counter=counter+1>
        </cfloop>
        <tr><td>&nbsp;</td></tr>
	</cfloop>	
    
    
    <cfelse>
    
	<cfloop query="getresult">
		<cfif counter neq 0>
			<tr><td colspan="100%"><hr></td></tr>
		</cfif>
		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getresult.fperiod#</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#dateformat(getresult.wos_date,"dd-mm-yyyy")#</font></div></td>
			<td><div align="center"><font size="2" face="Times New Roman, Times, serif">#getresult.type#</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><a href="bill.cfm?type=#getresult.type#&refno=#getresult.refno#">#getresult.refno#</a></font></div></td>
            <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getresult.desp#<cfif getresult.despa neq "">&nbsp;/&nbsp;#getresult.despa#</cfif><cfif getresult.name neq "">&nbsp;/&nbsp;#getresult.name#</cfif><cfif replace(tostring(getresult.comment),chr(10)," ","all") neq "">&nbsp;/&nbsp;#replace(tostring(getresult.comment),chr(10)," ","all")#</cfif><cfif hcomid eq "fdipx_i"><cfif joborderno neq ''>&nbsp;/&nbsp;Job Order No. #joborderno#</cfif></cfif></font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getresult.itemno#</font></div></td>
			
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getresult.custno#</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getresult.qty,".___")#</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getresult.price,stDecl_UPrice)#</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getresult.amt,stDecl_UPrice)#</font></div></td>
		</tr>
		<cfset ttqty=ttqty+val(getresult.qty)>
		<cfset ttamt=ttamt+val(getresult.amt)>
		<cfset counter=counter+1>
	</cfloop>	
    </cfif>
	<tr><td height="5"></td></tr>
	<tr>
		<td colspan="6" style="border-top:1px solid black;">&nbsp;</td>
		<td style="border-top:1px solid black;"><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>TOTAL</strong></font></div>&nbsp;</td>
		<td style="border-top:1px solid black;"><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(ttqty,".___")#</font></div></td>
		<td style="border-top:1px solid black;">&nbsp;</td>
		<td style="border-top:1px solid black;"><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(ttamt,stDecl_UPrice)#</font></div></td>
	</tr>	
	</table>
</cfoutput>

<!--- <cfif getresult.recordcount eq 0>
	<h4 style="color:red">Sorry, No records were found.</h4>
</cfif> ---> 

<br>
<br>
<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
</body>
</html>