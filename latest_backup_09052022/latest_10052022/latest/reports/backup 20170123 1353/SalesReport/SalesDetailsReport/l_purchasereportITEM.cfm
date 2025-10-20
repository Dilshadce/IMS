<html>
<head>
<title>Sales Report</title>
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css" media="print">
	.noprint { display: none; }
</style>

<cfquery name="getdisplaydetail" datasource="#dts#">
select * from displaysetup
</cfquery>
</head>
<cfif getpin2.h4G00 eq "T">
<script language="JavaScript"> 
var popup="Sorry, right-click is disabled.";
 function noway(go) { if 
(document.all) { if (event.button == 2) { alert(popup); return false; } } if (document.layers) 
{ if (go.which == 3) { alert(popup); return false; } } } if (document.layers) 
{ document.captureEvents(Event.MOUSEDOWN); } document.onmousedown=noway;
</script>
</cfif>
<cfparam name="i" default="1" type="numeric">

<cfquery name="getitem" datasource="#dts#">
  select * from ictran
  where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.itemno)#"> and (type='INV' or type='CS')
  <cfif isdefined('url.agentid') and isdefined('url.agentidto')>
  and agenno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.agentid)#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.agentidto)#">
  </cfif>
</cfquery>


<body <cfif getpin2.h4G00 eq "T">onBeforePrint="document.body.style.display = 'none';" onAfterPrint="document.body.style.display = '';"</cfif>>
<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">Print Date: <cfoutput>#dateformat(now(),"DD/MM/YY")#</cfoutput></font>
<div align="center"><font color="#000000" size="3" face="Arial, Helvetica, sans-serif"><strong>Sales Report</strong></font></div><br>
<div align="center"><font color="#000000" size="3" face="Arial, Helvetica, sans-serif"><strong><cfoutput>Item No : #getitem.itemno#</cfoutput></strong></font></div><br>

<cfif getdisplaydetail.report_aitemno eq 'Y'>
<cfquery name="getproductcode" datasource="#dts#">
            select aitemno from icitem where itemno='#getitem.itemno#'
            </cfquery>
<div align="center"><font color="#000000" size="3" face="Arial, Helvetica, sans-serif"><strong><cfoutput>Product Code : #getproductcode.aitemno#</cfoutput></strong></font></div><br>
                </cfif>

<div align="center"><font color="#000000" size="3" face="Arial, Helvetica, sans-serif"><strong><cfoutput>Item Description : #getitem.desp#</cfoutput></strong></font></div>
  <cfif #getitem.recordCount# neq 0>
    <cfif isdefined("form.skeypage")>
      <cfset noOfPage=round(#getPersonal.recordcount#/20)>
      <cfif #getPersonal.recordcount# mod 20 LT 20 and #getPersonal.recordcount# mod 20 neq 0>
        <cfset noOfPage=#noOfPage#+1>
      </cfif>
      <cfif form.skeypage gt noofpage OR form.skeypage lt 1>
        <cfabort>
      </cfif>
    </cfif>
    <cfform action="l_outstanding.cfm" method="post">
      <cfoutput>

      </cfoutput>
   
    </cfform>
    <table width="100%" border="0" class="" align="center">
      <tr>
        <td colspan="100%"><hr></td>
      </tr>
      <tr>
         <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif">Ref No</font></strong></td>
        <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif">Date</font></strong></td>
        <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif">Supplier no</font></strong></td>
        <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif">Supplier Name</font></strong></td>
        <td align="center"><strong><font size="2" face="Arial, Helvetica, sans-serif">Qty</font></strong></td>
         <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif">Unit</font></strong></td>
	 <td align="center"><strong><font size="2" face="Arial, Helvetica, sans-serif">Sales Price</font></strong></td>
 	 <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif">Amount</font></strong></td>
                 
      </tr>
      <tr>
        <td colspan="100%"><hr></td>
      </tr>
      
      <cfoutput query="getitem" startrow="1">
      <cfquery name="gettaxincl" datasource="#dts#">
            select taxincl from artran where type='#getitem.type#' and refno='#getitem.refno#'
            </cfquery>
            <cfif gettaxincl.taxincl eq 'T'>
            <cfset getitem.amt=getitem.amt-getitem.taxamt>
            <cfset getitem.price=getitem.amt/getitem.qty>
			</cfif>
		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
          <td align="center">#refno#</div></td>
          <td align="center">#DateFormat(wos_date, 'YYYY-MM-DD')#</div></td>
          <td align="center">#custno#</div></td>
          <td align="left">#name#</div></td>
		  <td align="right">#qty#</td>
          <td align="left">#unit#</td>
          <td align="right">#lsnumberformat(price,',_.__')#</td>
          <td align="right">#lsnumberformat(amt,',_.__')#</td>
          
        </tr>

        <!--- <cfset i = incrementvalue(#i#)> --->
        <cfset i = incrementvalue(#i#)>
      </cfoutput>
    </table>
    <br>
    <div align="right">
      <!---       <cfif #start# neq 1>
        <cfoutput><a href="l_icitem.cfm">Previous</a> ||</cfoutput>
      </cfif>
      <cfif #page# neq #noOfPage#>
        <cfoutput> <a href="l_icitem.cfm">Next</a> ||</cfoutput>
      </cfif> --->
    </div>
    <cfelse>
    <h3><font size="2" face="Arial, Helvetica, sans-serif">No Records were found.</font></h3>
  </cfif>
  <cfif getitem.recordCount gt 0><cfelse>
  <strong><font size="2" face="Arial, Helvetica, sans-serif">No Records were found.
  </font> </strong>
</cfif>
<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>


</body>
</html>
