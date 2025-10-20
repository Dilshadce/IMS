<html>
<head>
<title>Commission Listing Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
<style type="text/css" media="print">
	.noprint { display: none; }
</style>
</head>

<cfparam name="i" default="1" type="numeric">

<cfquery name="getCommission" datasource="#dts#">
  select * from commission where 0=0
  <cfif form.groupfrom neq "" and form.groupto neq "">
	and commname >= '#form.groupfrom#' and commname <= '#form.groupto#'
  </cfif>
  order by commname
</cfquery>


<body>
<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">Print Date: <cfoutput>#dateformat(now(),"DD/MM/YY")#</cfoutput></font>
<div align="center"><font color="#000000" size="3" face="Arial, Helvetica, sans-serif"><strong><cfoutput>Commission</cfoutput> Listing Report</strong></font></div>

  <cfif #getCommission.recordCount# neq 0>
    <cfif isdefined("form.skeypage")>
      <cfset noOfPage=round(#getPersonal.recordcount#/20)>
      <cfif #getPersonal.recordcount# mod 20 LT 20 and #getPersonal.recordcount# mod 20 neq 0>
        <cfset noOfPage=#noOfPage#+1>
      </cfif>
      <cfif form.skeypage gt noofpage OR form.skeypage lt 1>
        <cfabort>
      </cfif>
    </cfif>

    <table width="100%" border="0" class="" align="center">
      <tr>
        <td colspan="100%"><hr></td>
      </tr>
      <tr>
         <td align="center" width="2%"><strong><font size="2" face="Arial, Helvetica, sans-serif">Commission Name</font></strong></td>
        <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif">Description</font></strong></td>
        <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif">Group</font></strong></td>
        <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif">Category</font></strong></td>
        <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif">Brand</font></strong></td>
        <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif">Range From</font></strong></td>
        <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif">Range To</font></strong></td>
        <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif">Rate</font></strong></td>
        <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif">Type</font></strong></td>
      </tr>
      <tr>
        <td colspan="100%"><hr></td>
      </tr>
      
      <cfoutput query="getCommission" startrow="1">
        <tr>
          <td align="center"><div align="left">#commname#</div></td>
          <td align="center" >#commdesp#</td>
          <td align="center" >#wos_group#</td>
          <td align="center" >#cate#</td>
          <td align="center" >#brand#</td>
          </tr>
         <cfquery name="getCommission2" datasource="#dts#">
         select * from commRate where commname='#getCommission.commname#'
         </cfquery>
         <cfloop query="getCommission2" startrow="1">
         <tr>
         <td align="center" ></td>
         <td align="center" ></td>
         <td align="center" ></td>
         <td align="center" ></td>
         <td align="center" ></td>
         <td>#rangefrom#</td>
         <td>#rangeto#</td>
         <td align="center" >#rate#%</td>
         <td align="center" >#type#</td>
         </tr>
         </cfloop>
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
  <cfif getCommission.recordCount gt 0><cfelse>
  <strong><font size="2" face="Arial, Helvetica, sans-serif">No Records were found.
  </font> </strong>
</cfif>
<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>


</body>
</html>
