<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Forecast Report</title>
<link href="../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<cfparam name="row" default="0">
<cfparam name="ttpo" default="0">
<cfparam name="ttso" default="0">
<cfparam name="ttquo" default="0">
<cfparam name="ttonhand" default="0">
<cfparam name="ttpoohso" default="0">

<cfquery name="getgeneral" datasource="#dts#">
	select compro,lastaccyear,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION,lPROJECT,lJOB from gsetup
</cfquery>

<cfquery name="getitem" datasource="#dts#">
	select itemno, desp, despa from icitem 
	where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.itemno#">
</cfquery>

<cfquery name="gettran" datasource="#dts#">
	select a.type,a.refno,a.wos_date,a.custno,a.name,(a.qty-a.shipped-a.writeoff) as xqty<cfif lcase(HcomID) eq "chemline_i" or lcase(HcomID) eq "mphcranes_i">,p.project as p_project</cfif>
	from ictran a
	<cfif lcase(HcomID) eq "chemline_i" or lcase(HcomID) eq "mphcranes_i">
		left join (
			select * from artran
		) as b on (a.type=b.type and a.refno=b.refno)
		left join (
			select * FROM #target_project# where PORJ ='P'
			<cfif trim(url.projfr) neq "" and trim(url.projto) neq "">
				and source >= '#url.projfr#' and source <= '#url.projto#'
			</cfif>
		)as p on b.source=p.source
	</cfif>
	where a.type in ('SO','PO'<cfif lcase(HcomID) eq "kjcpl_i" or lcase(HcomID) eq "mlpl_i" or lcase(HcomID) eq "viva_i" or lcase(HcomID) eq "tlxil_i">,'QUO'</cfif>) and (a.void = '' or a.void is null) <cfif lcase(HcomID) eq "kjcpl_i" or lcase(HcomID) eq "mlpl_i" or lcase(HcomID) eq "viva_i" or lcase(HcomID) eq "tlxil_i"><cfelse>and a.wos_date > #getgeneral.lastaccyear#</cfif>
	and a.itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.itemno#"> 
	and (a.qty-a.shipped-a.writeoff) <> 0
    and (a.toinv='' or a.toinv is null)
	<cfif trim(url.projfr) neq "" and trim(url.projto) neq "">
		and a.source >= '#url.projfr#' and a.source <= '#url.projto#'
	</cfif>
	order by a.wos_date,a.trdatetime
</cfquery>
<body>

<table width="100%" border="0" align="center" cellspacing="0">
	<cfoutput>
    <tr>
    	<td colspan="100%"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>FORECAST REPORT</strong></font></div></td>
    </tr>
    <tr>
      	<td colspan="5"><cfif getgeneral.compro neq "">
          	<font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font> </cfif></td>
      	<td colspan="2"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
    </tr>
	<tr><td colspan="100%"><br></td></tr>
	<tr>
    	<td colspan="100%"><font size="2" face="Times New Roman, Times, serif"><strong>ITEM : #url.itemno#</strong></font></td>
  	</tr>
	<tr>
    	<td colspan="100%"><font size="2" face="Times New Roman, Times, serif"><strong>DESCRIPTION : #getitem.desp#&nbsp;#getitem.despa#</strong></font></td>
  	</tr>
  	</cfoutput>
  	<tr>
    	<td colspan="100%"><hr></td>
  	</tr>
  	<tr>
	    <td><font size="2" face="Times New Roman, Times, serif">NO</font></td>
	    <td><font size="2" face="Times New Roman, Times, serif">DATE</font></td>
	    <td><font size="2" face="Times New Roman, Times, serif">CUSTOMER / SUPPLIER</font></td>
		<cfif lcase(HcomID) eq "chemline_i" or lcase(HcomID) eq "mphcranes_i">
	    	<td><font size="2" face="Times New Roman, Times, serif"><cfoutput>#ucase(getgeneral.lPROJECT)#</cfoutput></font></td>
		</cfif>
	    <td><font size="2" face="Times New Roman, Times, serif">PURCHASE ORDER</font></td>
		<td><font size="2" face="Times New Roman, Times, serif">SALES ORDER</font></td>
        <cfif lcase(HcomID) eq "kjcpl_i" or lcase(HcomID) eq "mlpl_i" or lcase(HcomID) eq "viva_i" or lcase(HcomID) eq "tlxil_i">
        <td><font size="2" face="Times New Roman, Times, serif">QUOTATION</font></td>
   		</cfif>
	    <td><div align="right"><font size="2" face="Times New Roman, Times, serif">ON HAND</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">PO</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">SO</font></div></td>
        <cfif lcase(HcomID) eq "kjcpl_i" or lcase(HcomID) eq "mlpl_i" or lcase(HcomID) eq "viva_i" or lcase(HcomID) eq "tlxil_i">
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">QUO</font></div></td>
   		</cfif>
	    <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfif lcase(HcomID) eq "kjcpl_i" or lcase(HcomID) eq "mlpl_i" or lcase(HcomID) eq "viva_i" or lcase(HcomID) eq "tlxil_i">PO+OH-SO-QUO<cfelse>PO+OH-SO</cfif></font></div></td>
	</tr>
  	<tr>
    	<td colspan="100%"><hr></td>
  	</tr>
	<cfset poohso=itembal>
  	<tr>
    	<td colspan="5"></td>
		<cfif lcase(HcomID) eq "chemline_i" or lcase(HcomID) eq "mphcranes_i">
    		<td></td>
		</cfif>
        <cfif lcase(HcomID) eq "kjcpl_i" or lcase(HcomID) eq "mlpl_i" or lcase(HcomID) eq "viva_i" or lcase(HcomID) eq "tlxil_i">
        <td></td>
        </cfif>
    	<td><font size="2" face="Times New Roman, Times, serif"><div align="right"><cfoutput>#itembal#</cfoutput></div></font></td>
		<td colspan="2"></td>
        <cfif lcase(HcomID) eq "kjcpl_i" or lcase(HcomID) eq "mlpl_i" or lcase(HcomID) eq "viva_i" or lcase(HcomID) eq "tlxil_i">
        <td></td>
        </cfif>
    	<td><font size="2" face="Times New Roman, Times, serif"><div align="right"><cfoutput>#poohso#</cfoutput></div></font></td>
  	</tr>
    <cfset ttonhand=itembal>
	<cfoutput query="gettran">
		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
			<td><font size="2" face="Times New Roman, Times, serif">#gettran.currentrow#</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#dateformat(wos_date,"dd/mm/yyyy")#</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#gettran.name#</font></td>
			<cfif lcase(HcomID) eq "chemline_i" or lcase(HcomID) eq "mphcranes_i">
	    		<td><font size="2" face="Times New Roman, Times, serif">#gettran.p_project#</font></td>
			</cfif>
            <cfif lcase(HcomID) eq "kjcpl_i" or lcase(HcomID) eq "mlpl_i" or lcase(HcomID) eq "viva_i" or lcase(HcomID) eq "tlxil_i">
        	<cfif gettran.type eq "SO">
				<td></td>
				<td><font size="2" face="Times New Roman, Times, serif">#gettran.refno#</font></td>
                <td></td>
            <cfelseif gettran.type eq "QUO">
				<td></td>
                <td></td>
				<td><font size="2" face="Times New Roman, Times, serif">#gettran.refno#</font></td>
			<cfelse>
				<td><font size="2" face="Times New Roman, Times, serif">#gettran.refno#</font></td>
				<td></td>
                <td></td>
			</cfif>
   		<cfelse>
        
			<cfif gettran.type eq "SO">
				<td></td>
				<td><font size="2" face="Times New Roman, Times, serif">#gettran.refno#</font></td>
			<cfelse>
				<td><font size="2" face="Times New Roman, Times, serif">#gettran.refno#</font></td>
				<td></td>
			</cfif>
            </cfif>
			<td></td>
            <cfif lcase(HcomID) eq "kjcpl_i" or lcase(HcomID) eq "mlpl_i" or lcase(HcomID) eq "viva_i" or lcase(HcomID) eq "tlxil_i">
            <cfif gettran.type eq "SO">
				<td></td>
				<td><font size="2" face="Times New Roman, Times, serif"><div align="right">#gettran.xqty#</div></font></td>
                <td></td>
				<cfset poohso=poohso-val(gettran.xqty)>
				<cfset ttso=ttso+val(gettran.xqty)>
            <cfelseif gettran.type eq "QUO">
				<td></td>
                <td></td>
				<td><font size="2" face="Times New Roman, Times, serif"><div align="right">#gettran.xqty#</div></font></td>
				<cfset poohso=poohso-val(gettran.xqty)>
				<cfset ttquo=ttquo+val(gettran.xqty)>
			<cfelse>
				<td><font size="2" face="Times New Roman, Times, serif"><div align="right">#gettran.xqty#</div></font></td>
				<td></td>
                <td></td>
				<cfset poohso=poohso+val(gettran.xqty)>
				<cfset ttpo=ttpo+val(gettran.xqty)>
			</cfif>
            <cfelse>
			<cfif gettran.type eq "SO">
				<td></td>
				<td><font size="2" face="Times New Roman, Times, serif"><div align="right">#gettran.xqty#</div></font></td>
				<cfset poohso=poohso-val(gettran.xqty)>
				<cfset ttso=ttso+val(gettran.xqty)>
			<cfelse>
				<td><font size="2" face="Times New Roman, Times, serif"><div align="right">#gettran.xqty#</div></font></td>
				<td></td>
				<cfset poohso=poohso+val(gettran.xqty)>
				<cfset ttpo=ttpo+val(gettran.xqty)>
			</cfif>
            </cfif>
			<td><font size="2" face="Times New Roman, Times, serif"><div align="right">#poohso#</div></font></td>
		</tr>
	</cfoutput>
  	<cfoutput>
	<tr>
        <td colspan="100%"><hr></td>
	</tr>
    <tr>
      	<td colspan="4">&nbsp;</td>
		<cfif lcase(HcomID) eq "chemline_i" or lcase(HcomID) eq "mphcranes_i">
			<td>&nbsp;</td>
		</cfif>
        <cfif lcase(HcomID) eq "kjcpl_i" or lcase(HcomID) eq "mlpl_i" or lcase(HcomID) eq "viva_i" or lcase(HcomID) eq "tlxil_i">
        <td>&nbsp;</td>
        </cfif>
      	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">TOTAL:</font></div></td>
      	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#ttonhand#</font></div></td>
      	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#ttpo#</font></div></td>
      	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#ttso#</font></div></td>
        <cfif lcase(HcomID) eq "kjcpl_i" or lcase(HcomID) eq "mlpl_i" or lcase(HcomID) eq "viva_i" or lcase(HcomID) eq "tlxil_i">
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#ttquo#</font></div></td>
        </cfif>
      	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#poohso#</font></div></td>
    </tr>
  </cfoutput>
</table>
</body>
</html>