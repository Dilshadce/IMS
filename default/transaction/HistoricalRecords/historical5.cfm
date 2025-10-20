<html>
<head>
<title>Historical Records Items Order</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
<style type="text/css" media="print">
	.noprint { display: none; }
</style>
</head>

<body>
<cfquery name="getgeneral" datasource="#dts#">
	select compro,lastaccyear,brem1,brem2,brem3,brem4,lgroup from gsetup
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

<cfif isdefined("form.type") and form.type neq "">
	<cfset typelist=form.type>
<cfelse>
	<cfset typelist="PO,SO,QUO,SAM"> 
</cfif>

<cfquery name="getresult" datasource="#dts#">
	select a.type,a.refno,a.fperiod,a.wos_date,a.itemno,a.desp,a.despa,a.comment,a.brem1,a.brem2,a.brem3,a.brem4,a.batchcode,a.itemcount,a.custno,a.name,b.dono,a.qty,a.price,a.amt,a.brem1,a.brem2,a.brem3,a.brem4,b.source
	from ictran a
    
    left join artran as b on (a.type=b.type and a.refno=b.refno)
	where 
	a.type in (#ListQualify(typelist,"'")#)
	<cfif lcase(hcomid) eq "nikbra_i">
		<cfif form.searchitemfr neq "">
			and a.desp like '%#form.searchitemfr#%'
		</cfif>
	<cfelse>
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and a.itemno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemto#">
		</cfif>
	</cfif>
	<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		and a.wos_group between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.groupfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.groupto#">
	</cfif>
	<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "" and trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
		and (a.custno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custto#"> 
		or a.custno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.suppfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.suppto#">)
	<cfelseif (trim(form.custfrom) neq "" and trim(form.custto) neq "") and (trim(form.suppfrom) eq "" or trim(form.suppto) eq "")>
		and a.custno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custto#">
	<cfelseif (trim(form.suppfrom) neq "" and trim(form.suppto) neq "") and (trim(form.custfrom) eq "" or trim(form.custto) eq "")>
		and a.custno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.suppfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.suppto#">
	</cfif>
	<cfif form.periodfrom neq "" and form.periodto neq "">
		and a.fperiod between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.periodfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.periodto#">
	</cfif>
	<cfif form.datefrom neq "" and form.dateto neq "">
		and a.wos_date between #date1# and #date2#
	<cfelse>
		and a.wos_date > #getgeneral.lastaccyear#
	</cfif>
	<cfif trim(form.locfrom) neq "" and trim(form.locto) neq "">
		and a.location between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.locfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.locto#">
	</cfif>
	<cfif form.billagent neq "">
		and a.agenno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billagent#">
	</cfif>
	<cfif form.reffrom neq "" and form.refto neq "">
		and a.refno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.reffrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.refto#">
	</cfif>
	<cfif isdefined("form.includeservice")>
	<cfelse>
		and (a.linecode <> 'SV' or a.linecode is null)
	</cfif>
    <cfif form.glaccount neq "">
		and a.GLTRADAC =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.glaccount#">
	</cfif>
    <cfif form.dono neq "">
		and b.dono = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dono#">
	</cfif>
    <cfif form.project neq "">
		and b.source = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.project#">
	</cfif>
    <cfif form.brem1 neq "">
		and a.brem1 =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.brem1#">
	</cfif>
    <cfif form.brem2 neq "">
		and a.brem2 =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.brem2#">
	</cfif>
    <cfif form.brem3 neq "">
		and a.brem3 =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.brem3#">
	</cfif>
    <cfif form.brem4 neq "">
		and a.brem4 =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.brem4#">
	</cfif>
    <cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
			and batchcode between '#form.batchcodefrom#' and '#form.batchcodeto#'
		</cfif>
	<!--- group by refno --->
	order by #form.sort#
</cfquery>

<cfoutput>
<table width="100%" border="0" cellspacing="0" cellpadding="2">
	<tr> 
		<td colspan="100%"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>LIST HISTORICAL ITEMS ORDER</strong></font></div></td>
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
			<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">AGENT: #form.billagent#</font></div></td>
		</tr>
	</cfif>
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
	 	<td><div align="center"><font size="2" face="Times New Roman, Times, serif">REF NO</font></div></td>
      	<td><div align="left"><font size="2" face="Times New Roman, Times, serif"></font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">ITEM NO./DESP/SUPP./CUST.</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">X-REFNO</font></div></td>
	 	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">QTY</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">U-PRICE</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">AMOUNT</font></div></td>
        <cfif lcase(hcomid) eq "bestform_i">
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">Batch Code</font></div></td>
        </cfif>
        <cfif isdefined("form.includebrem1")>
			<td><div align="center"><font size="2" face="Times New Roman, Times, serif">#ucase(getgeneral.brem1)#</font></div></td>
		</cfif>
        <cfif isdefined("form.includebrem2")>
			<td><div align="center"><font size="2" face="Times New Roman, Times, serif">#ucase(getgeneral.brem2)#</font></div></td>
		</cfif>
        <cfif isdefined("form.includebrem3")>
			<td><div align="center"><font size="2" face="Times New Roman, Times, serif">#ucase(getgeneral.brem3)#</font></div></td>
		</cfif>
        <cfif isdefined("form.includebrem4")>
			<td><div align="center"><font size="2" face="Times New Roman, Times, serif">#ucase(getgeneral.brem4)#</font></div></td>
		</cfif>
    </tr>
    <tr> 
    	<td colspan="100%"><hr></td>
    </tr>
	
	<cfset ttqty=0>
	<cfset ttamt=0>
	<cfloop query="getresult">
			<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getresult.fperiod#</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#dateformat(getresult.wos_date,"dd-mm-yyyy")#</font></div></td>
			<td><div align="center"><font size="2" face="Times New Roman, Times, serif">#getresult.type#</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getresult.refno#</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getresult.itemno#<br>#getresult.desp#<br><cfif getresult.despa neq ""><br>#getresult.despa#</cfif><cfif getresult.name neq ""><br>#getresult.name#</cfif><cfif replace(tostring(getresult.comment),chr(10)," ","all") neq "">#replace(tostring(getresult.comment),chr(10)," ","all")#<br></cfif><cfif getresult.brem1 neq ""><br>#getresult.brem1#</cfif><cfif getresult.brem2 neq ""><br>#getresult.brem2#</cfif><cfif getresult.brem3 neq ""><br>#getresult.brem3#</cfif><cfif getresult.brem4 neq ""><br>#getresult.brem4#</cfif></font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getresult.custno#</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getresult.qty,".___")#</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getresult.price,stDecl_UPrice)#</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getresult.amt,stDecl_UPrice)#</font></div></td>
            <cfif lcase(hcomid) eq "bestform_i">
            <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#getresult.batchcode#</font></div></td>
            </cfif>
            <cfif isdefined("form.includebrem1")>
                <td><div align="center"><font size="2" face="Times New Roman, Times, serif">#getresult.brem1#</font></div></td>
            </cfif>
            <cfif isdefined("form.includebrem2")>
                <td><div align="center"><font size="2" face="Times New Roman, Times, serif">#getresult.brem2#</font></div></td>
            </cfif>
            <cfif isdefined("form.includebrem3")>
                <td><div align="center"><font size="2" face="Times New Roman, Times, serif">#getresult.brem3#</font></div></td>
            </cfif>
            <cfif isdefined("form.includebrem4")>
                <td><div align="center"><font size="2" face="Times New Roman, Times, serif">#getresult.brem4#</font></div></td>
            </cfif>
		</tr>
		<cfset ttqty=ttqty+val(getresult.qty)>
		<cfset ttamt=ttamt+val(getresult.amt)>
	</cfloop>	
	<tr><td height="5"></td></tr>
	<tr>
		<td colspan="6" style="border-top:1px solid black;">&nbsp;</td>
		<td style="border-top:1px solid black;"><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>TOTAL</strong></font></div>&nbsp;</td>
		<td style="border-top:1px solid black;"><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(ttqty,".___")#</font></div></td>
		<td style="border-top:1px solid black;"><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(ttamt,stDecl_UPrice)#</font></div></td>
		<td style="border-top:1px solid black;">&nbsp;</td>
		<cfif isdefined("form.includebrem1")>
            <td style="border-top:1px solid black;">&nbsp;</td>
        </cfif>
        <cfif isdefined("form.includebrem2")>
           <td style="border-top:1px solid black;">&nbsp;</td>
        </cfif>
        <cfif isdefined("form.includebrem3")>
            <td style="border-top:1px solid black;">&nbsp;</td>
        </cfif>
        <cfif isdefined("form.includebrem4")>
            <td style="border-top:1px solid black;">&nbsp;</td>
        </cfif>
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