<cfif isdefined ('form.groupbyitem')>
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
<cfparam name="sttpo" default="0">
<cfparam name="sttso" default="0">
<cfparam name="sttquo" default="0">
<cfparam name="sttonhand" default="0">
<cfparam name="sttpoohso" default="0">
<cfparam name="ttposoquo" default="0">
<cfparam name="sttposoquo" default="0">


<cfquery name="getgeneral" datasource="#dts#">
	select compro,lastaccyear,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION,lPROJECT,lJOB,lso from gsetup
</cfquery>

<cfquery name="getitem" datasource="#dts#">
	select sum(qty)-sum(shipped)-sum(writeoff) as qty,itemno,desp from ictran
    where type='so' and (toinv='' or toinv is null) and (void='' or void is null)
	<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
		and itemno >= <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.productfrom#"> and itemno <= <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.productto#">
	</cfif>
	<cfif trim(form.billfrom) neq "" and trim(form.billto) neq "">
		and refno >= '#form.billfrom#' and refno <= '#form.billto#'
	</cfif>
    <!---and qty-shipped-writeoff>0--->
	group by itemno
    order by itemno
</cfquery>

<cfset itemlist=valuelist(getitem.itemno)>

<body>

<table width="100%" border="0" align="center" cellspacing="0">
  <cfoutput>
    <tr>
      <td colspan="100%"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>BOM Item FORECAST
          REPORT by SO</strong></font></div></td>
    </tr>
    <cfif trim(billfrom) neq "" and trim(billto) neq "">
      <tr>
        <td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">#getgeneral.lso# No
            From #billfrom# To #billto#</font></div></td>
      </tr>
    </cfif>
    <cfif trim(productfrom) neq "" and trim(productto) neq "">
      <tr>
        <td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">Product
            From #productfrom# To #productto#</font></div></td>
      </tr>
    </cfif>
    <tr>
      <td colspan="5"><cfif getgeneral.compro neq "">
          <font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font> </cfif></td>
      <td colspan="2"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
    </tr>
  </cfoutput>
  <tr>
    <td colspan="100%"><hr></td>
  </tr>
  <tr>
    <td><font size="2" face="Times New Roman, Times, serif">NO</font></td>
    <td><font size="2" face="Times New Roman, Times, serif">PRODUCT</font></td>
    <cfif lcase(hcomid) eq "meisei_i">
     <td><font size="2" face="Times New Roman, Times, serif">SUPPLIER NAME</font></td>
     </cfif>
    <td><font size="2" face="Times New Roman, Times, serif">DESCRIPTION</font></td>
    <td><font size="2" face="Times New Roman, Times, serif">BOM ITEM</font></td>
    
    <td><font size="2" face="Times New Roman, Times, serif">SO QTY</font></td>

    <td width="10%"><div align="right"><font size="2" face="Times New Roman, Times, serif">SO NEED QTY</font></div></td>
    <td width="10%"><div align="right"><font size="2" face="Times New Roman, Times, serif">PO</font></div></td>

    <!---
    <cfif lcase(HcomID) eq "kjcpl_i" or lcase(HcomID) eq "mlpl_i" or lcase(HcomID) eq "viva_i">
    <td width="10%"><div align="right"><font size="2" face="Times New Roman, Times, serif">QUO</font></div></td>
    </cfif>
    <cfif lcase(HcomID) eq "mlpl_i">
    <td width="10%"><div align="right"><font size="2" face="Times New Roman, Times, serif">PO-SO-QUO</font></div></td>
    </cfif>
	--->
    <td width="10%"><div align="right"><font size="2" face="Times New Roman, Times, serif">ON HAND</font></div></td>
    <td width="10%"><div align="right"><font size="2" face="Times New Roman, Times, serif">PO+ONHAND-NEED QTY</font></div></td>
    
	<!---<td><div align="center"><font size="2" face="Times New Roman, Times, serif">ACTION</font></div></td>--->
  </tr>
  <tr>
    <td colspan="100%"><hr></td>
  </tr>

  <!---
    <tr>
      <td colspan="3"><font size="2" face="Times New Roman, Times, serif"><strong><cfoutput>Item No</cfoutput>
        :</strong></font> <strong><font size="2" face="Times New Roman, Times, serif"><cfoutput>#getitem.itemno# - #getitem.desp#</cfoutput></font></strong></td>
        <td colspan="3"><div align="left"><font size="2" face="Times New Roman, Times, serif"><cfoutput>SO QTY:#getitem.qty#</cfoutput></font></td>
    </tr>--->
    <cfquery name="getdata" datasource="#dts#">
    	select * from billmat 
		where itemno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#itemlist#">)
        group by bmitemno
        order by bmitemno
    </cfquery>
    
    <cfoutput query="getdata">
    <cfset tempsoqty=0>
    <cfquery name="getsoqty" datasource="#dts#">
    	select sum(qty)-sum(shipped)-sum(writeoff) as qty from ictran where itemno in (select itemno from billmat where bmitemno='#getdata.bmitemno#')
        <cfif trim(form.billfrom) neq "" and trim(form.billto) neq "">and type='SO' and (toinv='' or toinv is null) and (void='' or void is null)
		and refno >= '#form.billfrom#' and refno <= '#form.billto#'
		</cfif>
        <!---and qty-shipped-writeoff>0--->
    </cfquery>
    
    <cfquery name="getsorefno" datasource="#dts#">
    	select itemno,desp,sum(qty)-sum(shipped)-sum(writeoff) as qty from ictran where itemno in (select itemno from billmat where bmitemno='#getdata.bmitemno#')
        <cfif trim(form.billfrom) neq "" and trim(form.billto) neq "">and type='SO' and (toinv='' or toinv is null) and (void='' or void is null)
		and refno >= '#form.billfrom#' and refno <= '#form.billto#'
		</cfif>
        <!---and qty-shipped-writeoff>0--->
        group by itemno
    </cfquery>
    
    <cfloop query="getsorefno">
    <cfquery name="getrealbmqty" datasource="#dts#">
    select bmqty from billmat where itemno='#getsorefno.itemno#' and bmitemno='#getdata.bmitemno#'
    </cfquery>
    
    <cfset tempsoqty=tempsoqty+(val(getsorefno.qty)*val(getrealbmqty.bmqty))>
    </cfloop>
    <cfquery name="getbomitembal" datasource="#dts#">
    	select qtybf,desp,supp from icitem  
		where itemno='#getdata.bmitemno#'
    </cfquery>
    
    
    
      <cfset sttpo = 0>
      <cfset sttso = 0>
      <cfset sttonhand = 0>
      <cfset sttpoohso = 0>
      <cfset inqty = 0>
      <cfset outqty = 0>
      <cfset doqty = 0>
      <cfset SOqty=val(tempsoqty)>
      <cfset poqty = 0>
      <cfset quoqty = 0>
      <cfset itembal =0>
      <cfset row = row + 1>
       <cfquery name="getsupp" datasource="#dts#">
    select * from #target_apvend# where custno=(select supp from icitem where itemno='#getdata.bmitemno#') 
    </cfquery>
      <cfquery name="getin" datasource="#dts#">
      	select sum(qty)as sumqty from ictran 
		where itemno = '#bmitemno#' and (type = 'RC' or type = 'CN' or type = 'OAI' or type = 'TRIN') 
		and (void = '' or void is null) 
		and wos_date > #getgeneral.lastaccyear#
      </cfquery>
      <cfif getin.sumqty neq "">
        <cfset inqty =val(getin.sumqty)>
      </cfif>
      
      <cfquery name="getout" datasource="#dts#">
      	select sum(qty)as sumqty from ictran where itemno = '#bmitemno#' 
		and (type = 'INV' or type = 'PR' or type = 'CS' or type = 'DN' or type = 'ISS' or type = 'OAR' or type = 'TROU') 
		and (void = '' or void is null) and wos_date > #getgeneral.lastaccyear#
      </cfquery>
      <cfif getout.sumqty neq "">
        <cfset outqty=val(getout.sumqty)>
      </cfif>
      
      <cfquery name="getdo" datasource="#dts#">
      	select sum(qty)as sumqty from ictran where type = 'DO' and itemno = '#bmitemno#'
      	and (toinv = '' or toinv is null) and (void = '' or void is null) and wos_date > #getgeneral.lastaccyear#
      </cfquery>
      <cfif getdo.sumqty neq "">
        <cfset DOqty =val(getdo.sumqty)>
      </cfif>
      
        
      
      <cfquery name="getpo" datasource="#dts#">
      	select sum(qty-shipped-writeoff)as sumqty from ictran where type = 'PO' 
		and itemno = '#bmitemno#' and (void = '' or void is null) and wos_date > #getgeneral.lastaccyear#
        and (toinv='' or toinv is null)
      </cfquery>
      <cfif getpo.sumqty neq "">
        <cfset POqty=val(getpo.sumqty)>
      </cfif>
      <cfif getbomitembal.qtybf neq "">
        <cfset itembal=val(getbomitembal.qtybf)>
      </cfif>


      <cfset stockin=inqty>
      <cfset stockout=doqty+outqty>
      <cfset balonhand=itembal+stockin-stockout>
      <cfset poohso=balonhand+poqty-soqty>
      <cfif isdefined ('form.negative')>
      <cfif poohso lt 0>
      <cfset sttpo = sttpo + poqty>
      <cfset sttso = sttso + soqty>
      <cfset sttquo = sttquo + quoqty>
      <cfset sttposoquo= sttposoquo+(poqty-soqty-quoqty)>
      <cfset ttposoquo= ttposoquo+(poqty-soqty-quoqty)>
      <cfset sttonhand = sttonhand + balonhand>
      <cfset sttpoohso = sttpoohso + poohso>
      <cfset ttpo = ttpo + poqty>
      <cfset ttso = ttso + soqty>
      <cfset ttquo = ttquo + quoqty>
      <cfset ttonhand = ttonhand + balonhand>
      <cfset ttpoohso = ttpoohso + poohso>
      
     
      <tr>
        <td><font size="2" face="Times New Roman, Times, serif">#row#.</font></td>
        <td><font size="2" face="Times New Roman, Times, serif">#bmitemno#</font></td>
         <cfif lcase(hcomid) eq "meisei_i">
        <td><font size="2" face="Times New Roman, Times, serif">#getsupp.custno# #getsupp.name#</font></td>
        </cfif>
        <td><font size="2" face="Times New Roman, Times, serif">#getbomitembal.desp#</font></td>
        <td><font size="2" face="Times New Roman, Times, serif"><cfloop query="getsorefno"><cfif getsorefno.CurrentRow eq 1>#getsorefno.itemno# - #getsorefno.desp#<cfelse><br>#getsorefno.itemno# - #getsorefno.desp#</cfif></cfloop></font></td>
        <td><font size="2" face="Times New Roman, Times, serif">#getsoqty.qty#</font></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#soqty#</font></div></td>
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#poqty#</font></div></td>
        
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#balonhand#</font></div></td>
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#poohso#</font></div></td>
        
      </tr>
      </cfif>
      <cfelse>
      <cfset sttpo = sttpo + poqty>
      <cfset sttso = sttso + soqty>
      <cfset sttquo = sttquo + quoqty>
      <cfset sttposoquo= sttposoquo+(poqty-soqty-quoqty)>
      <cfset ttposoquo= ttposoquo+(poqty-soqty-quoqty)>
      <cfset sttonhand = sttonhand + balonhand>
      <cfset sttpoohso = sttpoohso + poohso>
      <cfset ttpo = ttpo + poqty>
      <cfset ttso = ttso + soqty>
      <cfset ttquo = ttquo + quoqty>
      <cfset ttonhand = ttonhand + balonhand>
      <cfset ttpoohso = ttpoohso + poohso>
      <tr>
        <td><font size="2" face="Times New Roman, Times, serif">#row#.</font></td>
        <td><font size="2" face="Times New Roman, Times, serif">#bmitemno#</font></td>
         <cfif lcase(hcomid) eq "meisei_i">
        <td><font size="2" face="Times New Roman, Times, serif">#getsupp.custno# #getsupp.name#</font></td>
        </cfif>
         <td><font size="2" face="Times New Roman, Times, serif">#getbomitembal.desp#</font></td>
        <td><font size="2" face="Times New Roman, Times, serif"><cfloop query="getsorefno"><cfif getsorefno.CurrentRow eq 1>#getsorefno.itemno# - #getsorefno.desp#<cfelse><br>#getsorefno.itemno# - #getsorefno.desp#</cfif></cfloop></font></td>
        <td><font size="2" face="Times New Roman, Times, serif">#getsoqty.qty#</font></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#soqty#</font></div></td>
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#poqty#</font></div></td>
        
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#balonhand#</font></div></td>
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#poohso#</font></div></td>
        
      </tr>
      </cfif>
      
    </cfoutput> 
    <tr>
    <td><br></td>
    </tr>
    
	<!---
	<cfoutput>
    
      <tr>
        <td colspan="100%"><hr></td>
      </tr>
      
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>

        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">SUB TOTAL:</font></div></td>
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#sttpo#</font></div></td>
        
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#sttso#</font></div></td>
        <!---
        <cfif lcase(HcomID) eq "kjcpl_i" or lcase(HcomID) eq "mlpl_i" or lcase(HcomID) eq "viva_i">
   		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#sttquo#</font></div></td>
    	</cfif>
        <cfif lcase(HcomID) eq "kjcpl_i" or lcase(HcomID) eq "mlpl_i" or lcase(HcomID) eq "viva_i">
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#sttposoquo#</font></div></td>
        </cfif>
		--->
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#sttonhand#</font></div></td>
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#sttpoohso#</font></div></td>
        
      </tr>
    </cfoutput>
  </cfloop>
  <cfoutput>
    <tr>
        <td colspan="100%"><hr></td>
      </tr>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif">TOTAL:</font></div></td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#ttpo#</font></div></td>
      
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#ttso#</font></div></td>
      <!---
      <cfif lcase(HcomID) eq "kjcpl_i" or lcase(HcomID) eq "mlpl_i" or lcase(HcomID) eq "viva_i">
   		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#ttquo#</font></div></td>
    	</cfif>
      <cfif lcase(HcomID) eq "mlpl_i">
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#ttposoquo#</font></div></td>
        </cfif>
		--->
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#ttonhand#</font></div></td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#ttpoohso#</font></div></td>
      
    </tr>
	
  </cfoutput>--->
</table>
</body>
</html>

<cfelse>
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
<cfparam name="sttpo" default="0">
<cfparam name="sttso" default="0">
<cfparam name="sttquo" default="0">
<cfparam name="sttonhand" default="0">
<cfparam name="sttpoohso" default="0">
<cfparam name="ttposoquo" default="0">
<cfparam name="sttposoquo" default="0">


<cfquery name="getgeneral" datasource="#dts#">
	select compro,lastaccyear,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION,lPROJECT,lJOB,lso from gsetup
</cfquery>

<cfquery name="getitem" datasource="#dts#">
	select sum(qty-shipped-writeoff) as qty,itemno,desp from ictran
    where type='so' and (toinv='' or toinv is null) and (void='' or void is null)
	<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
		and itemno >= <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.productfrom#"> and itemno <= <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.productto#">
	</cfif>
	<cfif trim(form.billfrom) neq "" and trim(form.billto) neq "">
		and refno >= '#form.billfrom#' and refno <= '#form.billto#'
	</cfif>
    and qty-shipped-writeoff>0
	group by itemno
    order by itemno
</cfquery>

<body>

<table width="100%" border="0" align="center" cellspacing="0">
  <cfoutput>
    <tr>
      <td colspan="100%"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>BOM Item FORECAST
          REPORT by SO</strong></font></div></td>
    </tr>
    <cfif trim(billfrom) neq "" and trim(billto) neq "">
      <tr>
        <td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">#getgeneral.lso# No
            From #billfrom# To #billto#</font></div></td>
      </tr>
    </cfif>
    <cfif trim(productfrom) neq "" and trim(productto) neq "">
      <tr>
        <td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">Product
            From #productfrom# To #productto#</font></div></td>
      </tr>
    </cfif>
    <tr>
      <td colspan="5"><cfif getgeneral.compro neq "">
          <font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font> </cfif></td>
      <td colspan="2"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
    </tr>
  </cfoutput>
  <tr>
    <td colspan="100%"><hr></td>
  </tr>
  <tr>
    <td><font size="2" face="Times New Roman, Times, serif">NO</font></td>
    <td><font size="2" face="Times New Roman, Times, serif">PRODUCT</font></td>
     <cfif lcase(hcomid) eq "meisei_i">
    <td><font size="2" face="Times New Roman, Times, serif">SUPPLIER NAME</font></td>
    </cfif>
    <td><font size="2" face="Times New Roman, Times, serif">DESCRIPTION</font></td>

    <td width="10%"><div align="right"><font size="2" face="Times New Roman, Times, serif">SO NEED QTY</font></div></td>
    <td width="10%"><div align="right"><font size="2" face="Times New Roman, Times, serif">PO</font></div></td>

    <!---
    <cfif lcase(HcomID) eq "kjcpl_i" or lcase(HcomID) eq "mlpl_i" or lcase(HcomID) eq "viva_i">
    <td width="10%"><div align="right"><font size="2" face="Times New Roman, Times, serif">QUO</font></div></td>
    </cfif>
    <cfif lcase(HcomID) eq "mlpl_i">
    <td width="10%"><div align="right"><font size="2" face="Times New Roman, Times, serif">PO-SO-QUO</font></div></td>
    </cfif>
	--->
    <td width="10%"><div align="right"><font size="2" face="Times New Roman, Times, serif">ON HAND</font></div></td>
    <td width="10%"><div align="right"><font size="2" face="Times New Roman, Times, serif">PO+ONHAND-NEED QTY</font></div></td>
    
	<!---<td><div align="center"><font size="2" face="Times New Roman, Times, serif">ACTION</font></div></td>--->
  </tr>


  <tr>
    <td colspan="100%"><hr></td>
  </tr>
  <cfloop query="getitem">
    <tr>
      <td colspan="3"><font size="2" face="Times New Roman, Times, serif"><strong><cfoutput>Item No</cfoutput>
        :</strong></font> <strong><font size="2" face="Times New Roman, Times, serif"><cfoutput>#getitem.itemno# - #getitem.desp#</cfoutput></font></strong></td>
        <td colspan="3"><div align="left"><font size="2" face="Times New Roman, Times, serif"><cfoutput>SO QTY:#getitem.qty#</cfoutput></font></td>
    </tr>
    <cfquery name="getdata" datasource="#dts#">
    	select * from billmat 
		where itemno='#getitem.itemno#' order by itemno
    </cfquery>
    <cfoutput query="getdata">
    <cfquery name="getbomitembal" datasource="#dts#">
    	select qtybf,desp,supp from icitem  
		where itemno='#getdata.bmitemno#'
    </cfquery>
    
      <cfset sttpo = 0>
      <cfset sttso = 0>
      <cfset sttonhand = 0>
      <cfset sttpoohso = 0>
      <cfset inqty = 0>
      <cfset outqty = 0>
      <cfset doqty = 0>
      <cfset SOqty=val(getitem.qty)*getdata.bmqty>
      <cfset poqty = 0>
      <cfset quoqty = 0>
      <cfset itembal =0>
      <cfset row = row + 1>
      <cfquery name="getsupp" datasource="#dts#">
    select * from #target_apvend# where custno=(select supp from icitem where itemno='#getdata.bmitemno#') 
    </cfquery>
      <cfquery name="getin" datasource="#dts#">
      	select sum(qty)as sumqty from ictran 
		where itemno = '#bmitemno#' and (type = 'RC' or type = 'CN' or type = 'OAI' or type = 'TRIN') 
		and (void = '' or void is null) 
		and wos_date > #getgeneral.lastaccyear#
      </cfquery>
      <cfif getin.sumqty neq "">
        <cfset inqty =val(getin.sumqty)>
      </cfif>
      
      <cfquery name="getout" datasource="#dts#">
      	select sum(qty)as sumqty from ictran where itemno = '#bmitemno#' 
		and (type = 'INV' or type = 'PR' or type = 'CS' or type = 'DN' or type = 'ISS' or type = 'OAR' or type = 'TROU') 
		and (void = '' or void is null) and wos_date > #getgeneral.lastaccyear#
      </cfquery>
      <cfif getout.sumqty neq "">
        <cfset outqty=val(getout.sumqty)>
      </cfif>
      
      <cfquery name="getdo" datasource="#dts#">
      	select sum(qty)as sumqty from ictran where type = 'DO' and itemno = '#bmitemno#'
      	and (toinv = '' or toinv is null) and (void = '' or void is null) and wos_date > #getgeneral.lastaccyear#
      </cfquery>
      <cfif getdo.sumqty neq "">
        <cfset DOqty =val(getdo.sumqty)>
      </cfif>
      
        
      
      <cfquery name="getpo" datasource="#dts#">
      	select sum(qty-shipped-writeoff)as sumqty from ictran where type = 'PO' 
		and itemno = '#bmitemno#' and (void = '' or void is null) and wos_date > #getgeneral.lastaccyear#
        and (toinv='' or toinv is null)
      </cfquery>
      <cfif getpo.sumqty neq "">
        <cfset POqty=val(getpo.sumqty)>
      </cfif>
      <cfif getbomitembal.qtybf neq "">
        <cfset itembal=val(getbomitembal.qtybf)>
      </cfif>


      <cfset stockin=inqty>
      <cfset stockout=doqty+outqty>
      <cfset balonhand=itembal+stockin-stockout>
      <cfset poohso=balonhand+poqty-soqty>
      
       <cfif isdefined ('form.negative')>
      <cfif poohso lt 0>
      <cfset sttpo = sttpo + poqty>
      <cfset sttso = sttso + soqty>
      <cfset sttquo = sttquo + quoqty>
      <cfset sttposoquo= sttposoquo+(poqty-soqty-quoqty)>
      <cfset ttposoquo= ttposoquo+(poqty-soqty-quoqty)>
      <cfset sttonhand = sttonhand + balonhand>
      <cfset sttpoohso = sttpoohso + poohso>
      <cfset ttpo = ttpo + poqty>
      <cfset ttso = ttso + soqty>
      <cfset ttquo = ttquo + quoqty>
      <cfset ttonhand = ttonhand + balonhand>
      <cfset ttpoohso = ttpoohso + poohso>
      <tr>
        <td><font size="2" face="Times New Roman, Times, serif">#row#.</font></td>
        <td><font size="2" face="Times New Roman, Times, serif">#bmitemno#</font></td>
        <cfif lcase(hcomid) eq "meisei_i">
        <td><font size="2" face="Times New Roman, Times, serif">#getsupp.custno# #getsupp.name#</font></td>
        </cfif>
        <td><font size="2" face="Times New Roman, Times, serif">#getbomitembal.desp#</font></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#soqty#</font></div></td>
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#poqty#</font></div></td>
        
        <!---
        <cfif lcase(HcomID) eq "kjcpl_i" or lcase(HcomID) eq "mlpl_i" or lcase(HcomID) eq "viva_i">
   		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#quoqty#</font></div></td>
    	</cfif>
        <cfif lcase(HcomID) eq "mlpl_i">
    	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#poqty-soqty-quoqty#</font></div></td>
    </cfif>
		--->
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#balonhand#</font></div></td>
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#poohso#</font></div></td>
        
		<!---<td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">
			<a href="inforecastreport2.cfm?itemno=#urlencodedformat(itemno)#&itembal=#balonhand#&pf=#urlencodedformat(productfrom)#&pt=#urlencodedformat(productto)#&cf=#catefrom#&ct=#cateto#&gpf=#groupfrom#&gpt=#groupto#&projfr=#projectfrom#&projto=#projectto#">View Details</a></font></div></td>--->
      </tr>
      </cfif>
      <cfelse>
      <cfset sttpo = sttpo + poqty>
      <cfset sttso = sttso + soqty>
      <cfset sttquo = sttquo + quoqty>
      <cfset sttposoquo= sttposoquo+(poqty-soqty-quoqty)>
      <cfset ttposoquo= ttposoquo+(poqty-soqty-quoqty)>
      <cfset sttonhand = sttonhand + balonhand>
      <cfset sttpoohso = sttpoohso + poohso>
      <cfset ttpo = ttpo + poqty>
      <cfset ttso = ttso + soqty>
      <cfset ttquo = ttquo + quoqty>
      <cfset ttonhand = ttonhand + balonhand>
      <cfset ttpoohso = ttpoohso + poohso>
      <tr>
        <td><font size="2" face="Times New Roman, Times, serif">#row#.</font></td>
        <td><font size="2" face="Times New Roman, Times, serif">#bmitemno#</font></td>
         <td><font size="2" face="Times New Roman, Times, serif">#getsupp.custno# #getsupp.name#</font></td>
        <td><font size="2" face="Times New Roman, Times, serif">#getbomitembal.desp#</font></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#soqty#</font></div></td>
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#poqty#</font></div></td>
        
        <!---
        <cfif lcase(HcomID) eq "kjcpl_i" or lcase(HcomID) eq "mlpl_i" or lcase(HcomID) eq "viva_i">
   		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#quoqty#</font></div></td>
    	</cfif>
        <cfif lcase(HcomID) eq "mlpl_i">
    	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#poqty-soqty-quoqty#</font></div></td>
    </cfif>
		--->
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#balonhand#</font></div></td>
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#poohso#</font></div></td>
        
		<!---<td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">
			<a href="inforecastreport2.cfm?itemno=#urlencodedformat(itemno)#&itembal=#balonhand#&pf=#urlencodedformat(productfrom)#&pt=#urlencodedformat(productto)#&cf=#catefrom#&ct=#cateto#&gpf=#groupfrom#&gpt=#groupto#&projfr=#projectfrom#&projto=#projectto#">View Details</a></font></div></td>--->
      </tr>
      </cfif>
    </cfoutput> 
    <tr>
    <td><br></td>
    </tr>
    
    </cfloop>
	<!---
	<cfoutput>
    
      <tr>
        <td colspan="100%"><hr></td>
      </tr>
      
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>

        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">SUB TOTAL:</font></div></td>
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#sttpo#</font></div></td>
        
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#sttso#</font></div></td>
        <!---
        <cfif lcase(HcomID) eq "kjcpl_i" or lcase(HcomID) eq "mlpl_i" or lcase(HcomID) eq "viva_i">
   		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#sttquo#</font></div></td>
    	</cfif>
        <cfif lcase(HcomID) eq "kjcpl_i" or lcase(HcomID) eq "mlpl_i" or lcase(HcomID) eq "viva_i">
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#sttposoquo#</font></div></td>
        </cfif>
		--->
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#sttonhand#</font></div></td>
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#sttpoohso#</font></div></td>
        
      </tr>
    </cfoutput>
  </cfloop>
  <cfoutput>
    <tr>
        <td colspan="100%"><hr></td>
      </tr>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif">TOTAL:</font></div></td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#ttpo#</font></div></td>
      
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#ttso#</font></div></td>
      <!---
      <cfif lcase(HcomID) eq "kjcpl_i" or lcase(HcomID) eq "mlpl_i" or lcase(HcomID) eq "viva_i">
   		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#ttquo#</font></div></td>
    	</cfif>
      <cfif lcase(HcomID) eq "mlpl_i">
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#ttposoquo#</font></div></td>
        </cfif>
		--->
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#ttonhand#</font></div></td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#ttpoohso#</font></div></td>
      
    </tr>
	
  </cfoutput>--->
</table>
</body>
</html>

</cfif>