<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Forecast Report</title>
<link href="../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>


<!---- The coding is based on inforecastreport2.cfm, the additional extension is due to when link from the outstanding and tracking report, the balance 
quantity cannot be retrive and therefore will be added in this page------->

<cfquery name="getgeneral" datasource="#dts#">
	select lcategory,lgroup,compro,lastaccyear from gsetup
</cfquery>





<!--- End of the additioanl Code------>

<cfparam name="row" default="0">
<cfparam name="ttpo" default="0">
<cfparam name="ttso" default="0">
<cfparam name="ttonhand" default="0">
<cfparam name="ttpoohso" default="0">

<cfquery name="getgeneral" datasource="#dts#">
	select lcategory,lgroup,compro,lastaccyear from gsetup
</cfquery>

<cfquery name="getitem" datasource="#dts#">
	select itemno, desp, despa from icitem 
	where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.itemno#">
</cfquery>

<cfquery name="gettran" datasource="#dts#">
	select a.type,a.refno,a.wos_date,a.custno,a.name,a.brem1,a.brem2,(a.qty-a.shipped) as xqty<cfif lcase(HcomID) eq "chemline_i" or lcase(HcomID) eq "mphcranes_i">,p.project as p_project</cfif>
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
	where a.type in ('SO','PO') and (a.void = '' or a.void is null) and a.wos_date > #getgeneral.lastaccyear#
	and a.itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.itemno#"> 
	and (a.qty-a.shipped) <> 0
	<cfif trim(url.projfr) neq "" and trim(url.projto) neq "">
		and a.source >= '#url.projfr#' and a.source <= '#url.projto#'
	</cfif>
	order by a.wos_date,a.trdatetime
</cfquery>
<body>

<table align="center">
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
<td>
<cfform name="display" width="1600" height="800">
<cfgrid name="usersgrid" align="middle" format="html" maxrows="10" query="gettran">
	        
	<cfgridcolumn name="wos_date" header="Date" width="80"  select="no">
	<cfgridcolumn name="custno" header="Account Code" width="100" select="no">
      <cfgridcolumn name="name" header="Cust / Supp" width="250">
	<cfgridcolumn name="type" header="Type" width="50">
      <cfgridcolumn name="refno" header="Reference No." width="100">
	<cfgridcolumn name="xqty" header="Quantity" width="80">
	<cfgridcolumn name="Brem1" header="Delivery Date" width="100">
	<cfgridcolumn name="Brem2" header="Confirm Date" width="100">

      <!---<cfgridcolumn name="Sales_Order" header="SO No." width="100">
      <cfgridcolumn name="ETD" header="ETD" width="80">
      <cfgridcolumn name="Balance" header="Balance" width="80">
      <cfgridcolumn name="Balance" header="PO QTY" width="80">
      <cfgridcolumn name="Balance" header="SO QTY" width="80">
      <cfgridcolumn name="Balance" header="NET BAL" width="80">--->
</cfgrid>
</cfform>
</td>
</tr>
</table>



</body>
</html>