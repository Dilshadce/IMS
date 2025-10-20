<cfquery datasource="#dts#" name="getgeneral">
	Select ljob as layer from gsetup
</cfquery>

<html>
<head>
<title><cfoutput>Identifier Listing Report</cfoutput></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
<style type="text/css" media="print">
	.noprint { display: none; }
</style>
</head>

<cfparam name="i" default="1" type="numeric">

<cfquery name="getproject" datasource="#dts#">
  select * from identifier 
  where 
  <cfif form.groupfrom neq "" and form.groupto neq "">
	identifierno >= '#form.groupfrom#' and identifierno <= '#form.groupto#'
  </cfif>
  order by identifierno
</cfquery>


<body>
<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">Print Date: <cfoutput>#dateformat(now(),"DD/MM/YY")#</cfoutput></font>
<div align="center"><font color="#000000" size="3" face="Arial, Helvetica, sans-serif"><strong><cfoutput>Identifier</cfoutput> Listing Report</strong></font></div>

  <cfif #getproject.recordCount# neq 0>
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
         <td align="center" width="2%"><strong><font size="2" face="Arial, Helvetica, sans-serif">No</font></strong></td>
        <td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Identifier Code</cfoutput></font></strong></td>
        <td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Description</cfoutput></font></strong></td>
        
      </tr>
      <tr>
        <td colspan="100%"><hr></td>
      </tr>
      
      <cfoutput query="getproject" startrow="1">
        <tr>
          <td align="center" width="2%"><div align="left">#i#</div></td>
          <td align="center" width="9%">#identifierno#</td>
         <td align="center" width="9%">#desp#</td>
      
     
        
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
  <cfif getproject.recordCount gt 0><cfelse>
  <strong><font size="2" face="Arial, Helvetica, sans-serif">No Records were found.
  </font> </strong>
</cfif>
<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>


</body>
</html>
