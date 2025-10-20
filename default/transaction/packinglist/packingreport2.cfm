
<cfif isdefined("form.datefrom") and isdefined("form.dateto")>
				<cfset dd = dateformat(form.datefrom, 'DD')>
		<cfif dd greater than '12'>
		<cfset ndatefrom = dateformat(form.datefrom,"YYYY-MM-DD")>
		<cfelse>
		<cfset ndatefrom = dateformat(form.datefrom,"YYYY-DD-MM")>
		</cfif>

						<cfset dd = dateformat(form.dateto, 'DD')>
		<cfif dd greater than '12'>
		<cfset ndateto= dateformat(form.dateto,"YYYY-MM-DD")>
		<cfelse>
		<cfset ndateto = dateformat(form.dateto,"YYYY-DD-MM")>
		</cfif>

</cfif>
<cfquery name="getgsetup" datasource="#dts#">
select * from gsetup
</cfquery>


<cfswitch expression="#form.result#">
	<cfcase value="PDF">

<cfquery name="getgsetup" datasource="#dts#">
select * from gsetup
</cfquery>

<cfquery name="getSumItem" datasource="#dts#">
SELECT a.type,a.refno,a.custno,a.frem7,a.frem8,a.rem3,a.comm0,a.comm1,a.comm2,a.comm3,a.rem14,a.rem12,a.comm4,a.rem1,a.van,b.itemno,b.desp,b.qty,b.unit FROM 
(SELECT type,refno,custno,frem7,frem8,rem3,comm0,comm1,comm2,comm3,rem14,rem12,comm4,rem1,van,wos_date FROM artran
WHERE 0=0
<cfif form.groupfrom2 neq "">
	and van = '#form.groupfrom2#' 
  </cfif>
   <cfif form.datefrom neq "" and form.dateto neq "">
   and wos_date between '#ndatefrom#' and '#ndateto#'
   </cfif>
 )as a 
left join 
(
select refno,itemno,desp,qty,unit from ictran
<cfif form.datefrom neq "" and form.dateto neq "">
WHERE wos_date between '#ndatefrom#' and '#ndateto#'
   </cfif>
) as b on 
a.refno=b.refno 
where 0=0

<cfif form.groupfrom2 neq "">
	and a.van = '#form.groupfrom2#' 
  </cfif>
   <cfif form.datefrom neq "" and form.dateto neq "">
   and a.wos_date between '#ndatefrom#' and '#ndateto#'
   </cfif>
</cfquery>
<cfreport template="packinglist2.cfr" format="PDF" query="getSumItem"><!--- or "FlashPaper" or "Excel" or "RTF" --->
	<cfreportparam name="compro" value="#getGSetup.compro#">
	<cfreportparam name="compro2" value="#getGSetup.compro2#">
	<cfreportparam name="compro3" value="#getGSetup.compro3#">
	<cfreportparam name="compro4" value="#getGSetup.compro4#">
	<cfreportparam name="compro5" value="#getGSetup.compro5#">
	<cfreportparam name="compro6" value="#getGSetup.compro6#">
	<cfreportparam name="compro7" value="#getGSetup.compro7#">
    <cfreportparam name="datefrom" value="#ndatefrom#">
    <cfreportparam name="dateto" value="#ndateto#">
    <cfreportparam name="dts" value="#dts#">
    
</cfreport>
</cfcase>

<cfcase value="HTML">
<cfoutput>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="/stylesheet/reportprint.css"/>
<title>PACKING Report</title>
</head>
<body style="width:100%; margin:0 auto; text-align:left">





<table width="100%" >
<tr><th align="center" colspan="100%">#getgsetup.compro#</th></tr>
<tr><th align="center" colspan="100%">#getgsetup.compro2#</th></tr>
<tr><th align="center" colspan="100%">#getgsetup.compro3#</th></tr>
<tr><th align="center" colspan="100%">#getgsetup.compro4#</th></tr>
<tr><th align="center" colspan="100%"><hr /></th></tr>
</table>

<cfquery name="getSumItem" datasource="#dts#">
SELECT type,refno,custno,frem7,frem8,rem3,comm0,comm1,comm2,comm3,rem14,rem12,comm4,rem1,custno,van FROM artran where 0=0
<cfif form.groupfrom2 neq "">
	and van = '#form.groupfrom2#' 
  </cfif>
   <cfif form.datefrom neq "" and form.dateto neq "">
   and wos_date between '#ndatefrom#' and '#ndateto#'
   </cfif>
</cfquery>
<cfquery name="getdriverdetail" datasource="#dts#">
select * from driver where driverno='#getSumItem.van#'
</cfquery>

<table>

<tr>
<th align="left">DATE</th>
<td>:</td>
<td>#dateformat(ndatefrom,'yyyy-mmm-dd')# - #dateformat(ndateto,'yyyy-mmm-dd')# </td>
</tr>
<tr>
<tr>
<th align="left">DRIVER</th>
<td>:</td>
<td>#getSumItem.van# - #getdriverdetail.name#</td>
</tr>

<tr>
<td colspan="5">
<br/>
</td>
</tr>
<tr>
<td colspan="5">
<table border="1">
<tr></tr>
<tr>
<th width="50px"><cfif lcase(hcomid) eq "accord_i">Inv No<cfelse>Bill No</cfif></th>
<th width="100px">A/C No</th>
<th width="100px">Address Code</th>
<th width="100px">Product No</th>
<th width="300px">Product Name</th>
<th width="100px">Qty</th>
</tr>
<cfloop query="getSumItem">
<cfquery name="getitem" datasource="#dts#">
select itemno,desp,qty,unit from ictran where refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getsumitem.refno#"> 
and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getsumitem.type#">
</cfquery>
<tr>
<td>
#getSumItem.refno#
</td>
<td>
#getSumItem.custno#
</td>
<td>#getSumItem.rem1#
</td>
<td><cfloop query="getitem">
#itemno#<br />
</cfloop></td>
<td><cfloop query="getitem">
#desp#<br />
</cfloop></td>
<td><cfloop query="getitem">
#qty# #unit#<br />
</cfloop></td>
</tr>
<tr>
</tr>
</cfloop>
</table>
</td>
</tr>

</table>
<br />
<div align="right">
	<font size="3" face="Arial, Helvetica, sans-serif">
		<a href="javascript:print()" class="noprint"><u>Print</u></a>
	</font>
</div>
<p class="noprint">
	<font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font>
</p>

</body>
</html>
</cfoutput>
</cfcase>
</cfswitch>