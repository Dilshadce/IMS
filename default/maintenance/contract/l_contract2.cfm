<html>
<head>
<title>Collection Schedule Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
<style type="text/css" media="print">
	.noprint { display: none; }
</style>
</head>

<cfparam name="i" default="1" type="numeric">

<cfquery name="getitem" datasource="#dts#">
  select * from ictran

  where 0=0
    <cfif form.groupfrom neq "" and form.groupto neq "">
	and itemno >= '#form.groupfrom#' and itemno <= '#form.groupto#'
  </cfif>
  <cfif form.groupfrom2 neq "" and form.groupto2 neq "">
			and custno >= '#form.groupfrom2#' and custno <= '#form.groupto2#'
  		</cfif>
  group by itemno order by itemno
</cfquery>




<body>
<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">Print Date: <cfoutput>#dateformat(now(),"DD/MM/YY")#</cfoutput></font>
<div align="center"><font color="#000000" size="3" face="Arial, Helvetica, sans-serif"><strong>Collection Schedule Report</strong></font></div>

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
    <cfform action="l_contract.cfm" method="post">
      <cfoutput>
        <input type="hidden" name="groupfrom" value="#form.groupfrom#">
        <input type="hidden" name="groupto" value="#form.groupto#">
        <input type="hidden" name="groupfrom2" value="#form.groupfrom2#">
        <input type="hidden" name="groupto2" value="#form.groupto2#">
       
      </cfoutput>
   
    </cfform>
    <table width="100%" border="1" class="" align="center">
      <tr>
        <td colspan="100%"><hr></td>
      </tr>
      <tr>
         <td align="center"><strong><font size="2" face="Arial, Helvetica, sans-serif">NO</font></strong></td>
        <td align="center"><strong><font size="2" face="Arial, Helvetica, sans-serif">CUSTOMER</font></strong></td>
        <td align="center"><strong><font size="2" face="Arial, Helvetica, sans-serif">DATE OF COMMEN</font></strong></td>
        <td align="center"><strong><font size="2" face="Arial, Helvetica, sans-serif">QTY</font></strong></td>
        <td align="center"><strong><font size="2" face="Arial, Helvetica, sans-serif">U/PRICE</font></strong></td>
        <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif"><div align="center">MODE OF BILLING</div></font></strong></td>     
        <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif"><div align="center">BILLING DATE</div></font></strong></td>   
        <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif"><div align="center">JAN</div></font></strong></td>  
        <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif"><div align="center">FEB</div></font></strong></td>  
        <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif"><div align="center">MAR</div></font></strong></td> 
        <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif"><div align="center">APR</div></font></strong></td> 
        <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif"><div align="center">MAY</div></font></strong></td> 
        <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif"><div align="center">JUN</div></font></strong></td> 
        <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif"><div align="center">JUL</div></font></strong></td> 
        <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif"><div align="center">AUG</div></font></strong></td> 
        <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif"><div align="center">SEP</div></font></strong></td> 
        <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif"><div align="center">OCT</div></font></strong></td> 
        <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif"><div align="center">NOV</div></font></strong></td> 
        <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif"><div align="center">DEC</div></font></strong></td> 
      </tr>
      
      <tr>
        <td colspan="100%"><hr></td>
      </tr>
      
      <cfloop query="getitem">
	  
      <cfquery name="getcust" datasource="#dts#">
 		 select a.wos_date,c.*,b.name,d.modebill from artran as a
  
 		 left join #target_arcust# as b on b.custno=a.custno
  		 left join ictran as c on c.refno=a.refno
         left join serviceagree as d on d.servicecode=a.rem5
 		 where 0=0
   		 
 		 and c.itemno ='#getitem.itemno#'
 		 order by custno
	</cfquery>
	  <cfoutput>
      <tr><td colspan="3"><font size="4" face="Arial, Helvetica, sans-serif"><b><u>#itemno#</u></b></font></td></tr></cfoutput>
      
      
      <cfloop query="getcust"><cfoutput>
        <tr>
          <td align="center" ><div align="left">#i#</div></td>
          <td align="center" >#name#</td>
          <td align="center" >#dateformat(wos_date,'DD/MM/YYYY')#</td>
          <td align="center" >#qty_bil#</td>
          <td align="center" >#lsnumberformat(price_bil,',_.__')#</td>
          <td align="center" >#modebill#</td>
          <td align="center" >#dateformat(wos_date,'DD/MM/YYYY')#</td>
          <td align="center" >&nbsp;</td>
          <td align="center" >&nbsp;</td>
          <td align="center" >&nbsp;</td>
          <td align="center" >&nbsp;</td>
          <td align="center" >&nbsp;</td>
          <td align="center" >&nbsp;</td>
          <td align="center" >&nbsp;</td>
          <td align="center" >&nbsp;</td>
          <td align="center" >&nbsp;</td>
          <td align="center" >&nbsp;</td>
          <td align="center" >&nbsp;</td>
          <td align="center" >&nbsp;</td>
          
       
       
        </tr>
        <!--- <cfset i = incrementvalue(#i#)> --->
        <cfset i = incrementvalue(#i#)>
      </cfoutput>
      </cfloop>
      </cfloop>
            <cfoutput>
      
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
