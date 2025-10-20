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
	select compro,lastaccyear,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION,lPROJECT,lJOB from gsetup
</cfquery>


<cfquery name="getitem" datasource="#dts#">
	select a.itemno, a.desp, a.qtybf,a.price,a.wos_group,ifnull(b.sumqtyin,0) as sumqtyin,ifnull(c.sumqtyout,0) as sumqtyout,ifnull(d.sumqtydo,0) as sumqtydo,ifnull(e.sumqtyso,0) as sumqtyso,ifnull(f.sumqtypo,0) as sumqtypo,ifnull(g.sumqtyquo,0) as sumqtyquo from icitem as a
    left join (
    select sum(qty)as sumqtyin,itemno from ictran 
		where (type = 'RC' or type = 'CN' or type = 'OAI' or type = 'TRIN') 
		and (void = '' or void is null) 
		and wos_date > #getgeneral.lastaccyear#
        <cfif trim(form.projectfrom) neq "" and trim(form.projectto) neq "">
			and source >= '#form.projectfrom#' and source <= '#form.projectto#'
		</cfif>
         group by itemno
    )as b on a.itemno=b.itemno
    
    left join (
    select sum(qty)as sumqtyout,itemno from ictran where (type = 'INV' or type = 'PR' or type = 'CS' or type = 'DN' or type = 'ISS' or type = 'OAR' or type = 'TROU') 
		and (void = '' or void is null) and wos_date > #getgeneral.lastaccyear#
        <cfif trim(form.projectfrom) neq "" and trim(form.projectto) neq "">
			and source >= '#form.projectfrom#' and source <= '#form.projectto#'
		</cfif>
         group by itemno
    )as c on a.itemno=c.itemno
    
    left join (
    select sum(qty)as sumqtydo,itemno from ictran where type = 'DO'
      	and (toinv = '' or toinv is null) and (void = '' or void is null) and wos_date > #getgeneral.lastaccyear#
        <cfif trim(form.projectfrom) neq "" and trim(form.projectto) neq "">
			and source >= '#form.projectfrom#' and source <= '#form.projectto#'
		</cfif>
         group by itemno
    )as d on a.itemno=d.itemno
    
    left join (
    select sum(qty-shipped-writeoff)as sumqtyso,itemno from ictran where type = 'SO' 
 	and (void = '' or void is null) <cfif lcase(HcomID) eq "kjcpl_i" or lcase(HcomID) eq "mlpl_i" or lcase(HcomID) eq "viva_i" or lcase(HcomID) eq "tlxil_i" or lcase(HcomID) eq "uniq_i"><cfelse>and wos_date > #getgeneral.lastaccyear#</cfif>
 	and (toinv='' or toinv is null)
        <cfif trim(form.projectfrom) neq "" and trim(form.projectto) neq "">
			and source >= '#form.projectfrom#' and source <= '#form.projectto#'
		</cfif>
         group by itemno
    )as e on a.itemno=e.itemno
    
    
    left join (
    select sum(qty-shipped-writeoff)as sumqtypo,itemno from ictran where type = 'PO' 
 and (void = '' or void is null) <cfif lcase(HcomID) eq "kjcpl_i" or lcase(HcomID) eq "mlpl_i" or lcase(HcomID) eq "viva_i" or lcase(HcomID) eq "tlxil_i" or lcase(HcomID) eq "uniq_i"><cfelse>and wos_date > #getgeneral.lastaccyear#</cfif>
        and (toinv='' or toinv is null)
        <cfif trim(form.projectfrom) neq "" and trim(form.projectto) neq "">
			and source >= '#form.projectfrom#' and source <= '#form.projectto#'
		</cfif>
         group by itemno
    )as f on a.itemno=f.itemno
    
    left join (
    select sum(qty-shipped-writeoff)as sumqtyquo,itemno from ictran where type = 'QUO' 
 and (void = '' or void is null) <cfif lcase(HcomID) eq "kjcpl_i" or lcase(HcomID) eq "mlpl_i" or lcase(HcomID) eq "viva_i" or lcase(HcomID) eq "tlxil_i" or lcase(HcomID) eq "uniq_i"><cfelse>and wos_date > #getgeneral.lastaccyear#</cfif>  and (toinv='' or toinv is null)
        group by itemno
    )as g on a.itemno=g.itemno
    
    
    
    
    
    where
	a.itemno <> ''
	<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
		and a.itemno >= <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.productfrom#"> and a.itemno <= <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.productto#">
	</cfif>
	<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and a.category >= '#form.catefrom#' and a.category <= '#form.cateto#'
	</cfif>
	<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		and a.wos_group >= '#form.groupfrom#' and a.wos_group <= '#form.groupto#'
	</cfif>
	<cfif (lcase(HcomID) eq "chemline_i" or lcase(HcomID) eq "mphcranes_i") and form.brand neq "">
		and a.brand like <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.brand#%">
	</cfif>
    
    <cfif isdefined('form.itemtba')>
		and a.releasedate = "9999-12-31"
    <cfelse>
    <cfif trim(form.releasedatefrom) neq "" and trim(form.releasedateto) neq "">
    	and a.releasedate >= '#form.releasedatefrom#' and a.releasedate <= '#form.releasedateto#'
    </cfif>
    </cfif>
    
	order by a.itemno
</cfquery>
<cfquery name="getgroup" datasource="#dts#">
	select distinct ifnull(wos_group,'') as wos_group from icitem where
	itemno <> ''
	<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
		and itemno >= <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.productfrom#"> and itemno <= <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.productto#">
	</cfif>
	<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and category >= '#form.catefrom#' and category <= '#form.cateto#'
	</cfif>
	<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		and wos_group >= '#form.groupfrom#' and wos_group <= '#form.groupto#'
	</cfif>
	<cfif trim(form.projectfrom) neq "" and trim(form.projectto) neq "">
		and itemno in (
		select distinct itemno from ictran
		where wos_date > #getgeneral.lastaccyear#
		and (void = '' or void is null)
		and source >= '#form.projectfrom#' and source <= '#form.projectto#'
		)	
	</cfif>
	<cfif (lcase(HcomID) eq "chemline_i" or lcase(HcomID) eq "mphcranes_i") and form.brand neq "">
		and brand like <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.brand#%">
	</cfif>
	order by wos_group
</cfquery>

<body>

<table width="100%" border="0" align="center" cellspacing="0">
  <cfoutput>
    <tr>
      <td colspan="100%"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>FORECAST
          REPORT</strong></font></div></td>
    </tr>
    <cfif trim(catefrom) neq "" and trim(cateto) neq "">
      <tr>
        <td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">#getgeneral.lCATEGORY#
            From #catefrom# To #cateto#</font></div></td>
      </tr>
    </cfif>
    <cfif trim(groupfrom) neq "" and trim(groupto) neq "">
      <tr>
        <td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">#getgeneral.lGROUP#
            From #groupfrom#To #Groupto#</font></div></td>
      </tr>
    </cfif>
    <cfif trim(productfrom) neq "" and trim(productto) neq "">
      <tr>
        <td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">Product
            From #productfrom# To #productto#</font></div></td>
      </tr>
    </cfif>
	<cfif trim(projectfrom) neq "" and trim(projectto) neq "">
    	<tr>
        	<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">#getgeneral.lPROJECT# From #projectfrom# To #projectto#</font></div></td>
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
    <td><font size="2" face="Times New Roman, Times, serif">DESCRIPTION</font></td>
    <cfif lcase(HcomID) eq "kjcpl_i" or lcase(HcomID) eq "mlpl_i" or lcase(HcomID) eq "viva_i" or lcase(HcomID) eq "tlxil_i" or lcase(HcomID) eq "uniq_i">
    <td><font size="2" face="Times New Roman, Times, serif">BRAND</font></td>
    </cfif>
    <td width="10%"><div align="right"><font size="2" face="Times New Roman, Times, serif">PO</font></div></td>
    <td width="10%"><div align="right"><font size="2" face="Times New Roman, Times, serif">SO</font></div></td>
    <cfif lcase(HcomID) eq "kjcpl_i" or lcase(HcomID) eq "mlpl_i" or lcase(HcomID) eq "viva_i" or lcase(HcomID) eq "tlxil_i" or lcase(HcomID) eq "uniq_i">
    <td width="10%"><div align="right"><font size="2" face="Times New Roman, Times, serif">QUO</font></div></td>
    </cfif>
    <cfif lcase(HcomID) eq "mlpl_i">
    <td width="10%"><div align="right"><font size="2" face="Times New Roman, Times, serif">PO-SO-QUO</font></div></td>
    </cfif>
    <td width="10%"><div align="right"><font size="2" face="Times New Roman, Times, serif">ON HAND</font></div></td>
    <td width="10%"><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfif lcase(HcomID) eq "kjcpl_i" or lcase(HcomID) eq "mlpl_i" or lcase(HcomID) eq "viva_i" or lcase(HcomID) eq "tlxil_i" or lcase(HcomID) eq "uniq_i">PO+OH-SO-QUO<cfelse>PO+OH-SO</cfif></font></div></td>
    
	<td><div align="center"><font size="2" face="Times New Roman, Times, serif">ACTION</font></div></td>
  </tr>
  <tr>
    <td colspan="100%"><hr></td>
  </tr>
  <cfloop query="getgroup">
    <tr>
      <td colspan="100%"><font size="2" face="Times New Roman, Times, serif"><strong><cfoutput>#getgeneral.lGROUP#</cfoutput>
        :</strong></font> <strong><font size="2" face="Times New Roman, Times, serif"><cfoutput>#wos_group#</cfoutput></font></strong></td>
    </tr>
    <cfquery name="getdata" dbtype="query">
    	select * from getitem 
		where <cfif getitem.wos_group eq "">(wos_group = '#wos_group#' or wos_group is null)<cfelse>wos_group = '#wos_group#'</cfif> order by itemno
    </cfquery>
    <cfoutput query="getdata">
      <cfset sttpo = 0>
      <cfset sttso = 0>
      <cfset sttonhand = 0>
      <cfset sttpoohso = 0>
      <cfset inqty = 0>
      <cfset outqty = 0>
      <cfset doqty = 0>
      <cfset soqty = 0>
      <cfset poqty = 0>
      <cfset quoqty = 0>
      <cfset itembal =0>
      <cfset row = row + 1>
        <cfset inqty =val(getdata.sumqtyin)>
        <cfset outqty=val(getdata.sumqtyout)>
        <cfset DOqty =val(getdata.sumqtydo)>
        <cfset SOqty=val(getdata.sumqtyso)>
        <cfset POqty=val(getdata.sumqtypo)>
        <cfset itembal=val(getdata.qtybf)>
        <cfset quoqty=val(getdata.sumqtyquo)>
      <cfset stockin=inqty>
      <cfset stockout=doqty+outqty>
      
     
      <cfset balonhand=itembal+stockin-stockout>

	  <cfif lcase(HcomID) eq "kjcpl_i" or lcase(HcomID) eq "mlpl_i" or lcase(HcomID) eq "viva_i" or lcase(HcomID) eq "tlxil_i" or lcase(HcomID) eq "uniq_i">
      <cfset poohso=balonhand+poqty-soqty-quoqty>
      <cfelse>
      <cfset poohso=balonhand+poqty-soqty>
      </cfif>
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
        <td><font size="2" face="Times New Roman, Times, serif">#itemno#</font></td>
        <td><font size="2" face="Times New Roman, Times, serif">#desp#</font></td>
         <cfif lcase(HcomID) eq "kjcpl_i" or lcase(HcomID) eq "mlpl_i" or lcase(HcomID) eq "viva_i" or lcase(HcomID) eq "tlxil_i" or lcase(HcomID) eq "uniq_i">
         <cfquery name="getbrand" datasource="#dts#">
         select brand from icitem where itemno='#itemno#'
         </cfquery>
         <td><font size="2" face="Times New Roman, Times, serif">#getbrand.brand#</font></td>
         </cfif>
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#poqty#</font></div></td>
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#soqty#</font></div></td>
        <cfif lcase(HcomID) eq "kjcpl_i" or lcase(HcomID) eq "mlpl_i" or lcase(HcomID) eq "viva_i" or lcase(HcomID) eq "tlxil_i" or lcase(HcomID) eq "uniq_i">
   		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#quoqty#</font></div></td>
    	</cfif>
        <cfif lcase(HcomID) eq "mlpl_i">
    	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#poqty-soqty-quoqty#</font></div></td>
    </cfif>
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#balonhand#</font></div></td>
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#poohso#</font></div></td>
        
		<td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">
			<a href="inforecastreport2.cfm?itemno=#urlencodedformat(itemno)#&itembal=#balonhand#&pf=#urlencodedformat(productfrom)#&pt=#urlencodedformat(productto)#&cf=#catefrom#&ct=#cateto#&gpf=#groupfrom#&gpt=#groupto#&projfr=#projectfrom#&projto=#projectto#">View Details</a></font></div></td>
      </tr>
    </cfoutput> <cfoutput>
      <tr>
        <td colspan="100%"><hr></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <cfif lcase(HcomID) eq "kjcpl_i" or lcase(HcomID) eq "mlpl_i" or lcase(HcomID) eq "viva_i" or lcase(HcomID) eq "tlxil_i" or lcase(HcomID) eq "uniq_i">
        <td>&nbsp;</td>
        </cfif>
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">SUB TOTAL:</font></div></td>
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#sttpo#</font></div></td>
        
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#sttso#</font></div></td>
        <cfif lcase(HcomID) eq "kjcpl_i" or lcase(HcomID) eq "mlpl_i" or lcase(HcomID) eq "viva_i" or lcase(HcomID) eq "tlxil_i" or lcase(HcomID) eq "uniq_i">
   		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#sttquo#</font></div></td>
    	</cfif>
        <cfif lcase(HcomID) eq "kjcpl_i" or lcase(HcomID) eq "mlpl_i" or lcase(HcomID) eq "viva_i" or lcase(HcomID) eq "tlxil_i" or lcase(HcomID) eq "uniq_i">
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#sttposoquo#</font></div></td>
        </cfif>
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
      <cfif lcase(HcomID) eq "kjcpl_i" or lcase(HcomID) eq "mlpl_i" or lcase(HcomID) eq "viva_i" or lcase(HcomID) eq "tlxil_i" or lcase(HcomID) eq "uniq_i">
        <td>&nbsp;</td>
        </cfif>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif">TOTAL:</font></div></td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#ttpo#</font></div></td>
      
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#ttso#</font></div></td>
      <cfif lcase(HcomID) eq "kjcpl_i" or lcase(HcomID) eq "mlpl_i" or lcase(HcomID) eq "viva_i" or lcase(HcomID) eq "tlxil_i" or lcase(HcomID) eq "uniq_i">
   		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#ttquo#</font></div></td>
    	</cfif>
      <cfif lcase(HcomID) eq "mlpl_i">
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#ttposoquo#</font></div></td>
        </cfif>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#ttonhand#</font></div></td>
      <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#ttpoohso#</font></div></td>
      
    </tr>
  </cfoutput>
</table>
</body>
</html>
