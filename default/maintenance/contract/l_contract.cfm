<html>
<head>
<title>Pro Server Agreement Record 2010 A'</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
<style type="text/css" media="print">
	.noprint { display: none; }
</style>
</head>

<cfparam name="i" default="1" type="numeric">

<cfquery name="getitem" datasource="#dts#">
  select a.refno,a.rem5,a.custno,a.wos_date,a.grand,b.* from artran as a
  left join proseragree as b on a.refno=b.refno
  where a.rem5 !="" and a.type="INV"
  
  <cfif form.groupfrom neq "" and form.groupto neq "">
	and a.rem5 >= '#form.groupfrom#' and a.rem5 <= '#form.groupto#'
  </cfif>
    <cfif form.groupfrom2 neq "" and form.groupto2 neq "">
	and a.custno >= '#form.groupfrom2#' a.and custno <= '#form.groupto2#'
  </cfif>

</cfquery>

 <cfquery name="getcolumn" datasource="#dts#">
          select * from proseragree2
          </cfquery>
  <cfquery name="getcolumn2" datasource="#dts#">
          select * from proseragree2 group by itemno
          </cfquery>

<body>
<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">Print Date: <cfoutput>#dateformat(now(),"DD/MM/YY")#</cfoutput></font>
<div align="center"><font color="#000000" size="3" face="Arial, Helvetica, sans-serif"><strong>Pro Server Agreement
 Record 2010 A'</strong></font></div>

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
    <cfform action="l_contractprocess.cfm" method="post">
      <cfoutput>
        <input type="hidden" name="groupfrom" value="#form.groupfrom#">
        <input type="hidden" name="groupto" value="#form.groupto#">
        <input type="hidden" name="groupfrom2" value="#form.groupfrom2#">
        <input type="hidden" name="groupto2" value="#form.groupto2#">
       
      </cfoutput>
   
    </cfform>
     <form action="l_contractprocess.cfm" method="post">
    <table width="100%" border="1" class="" align="center">
      <tr>
        <td colspan="100%"><hr></td>
      </tr>
      <tr>
         <td align="center"rowspan="3"><strong><font size="2" face="Arial, Helvetica, sans-serif">No</font></strong></td>
        <td align="center"rowspan="3"><strong><font size="2" face="Arial, Helvetica, sans-serif">Date Of Comm</font></strong></td>
        <td align="center"rowspan="3"><strong><font size="2" face="Arial, Helvetica, sans-serif">AGRM NO</font></strong></td>
        <td align="center"rowspan="3"><strong><font size="2" face="Arial, Helvetica, sans-serif">Chop & Sign</font></strong></td>
        <td align="center"rowspan="3"><strong><font size="2" face="Arial, Helvetica, sans-serif">RMKS</font></strong></td>
        <td align="center"rowspan="3"><strong><font size="2" face="Arial, Helvetica, sans-serif">Customer</font></strong></td>
        <td align="center" colspan=<cfoutput>"#getcolumn.recordcount#"</cfoutput>><strong><font size="2" face="Arial, Helvetica, sans-serif"><div align="center">Items</div></font></strong></td>
         <td align="center"rowspan="3"><strong><font size="2" face="Arial, Helvetica, sans-serif">Type of Service</font></strong></td>
          <td align="center"rowspan="3"><strong><font size="2" face="Arial, Helvetica, sans-serif">Amount of Invoice</font></strong></td>
           <td align="center"rowspan="3"><strong><font size="2" face="Arial, Helvetica, sans-serif">Billing Date</font></strong></td>     
      </tr>
      <tr>
      <cfloop query="getcolumn2">
      <cfoutput>
       <cfquery name="getcolumnspan" datasource="#dts#">
          select * from proseragree2 where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getcolumn2.itemno#">
          </cfquery>
      <td align="center"colspan="#getcolumnspan.recordcount#"><strong><font size="2" face="Arial, Helvetica, sans-serif"><div align="center">#getcolumn2.itemno#</div></font></strong></td>
      </cfoutput>
     </cfloop>
      </tr>
      <tr>
      <cfloop query="getcolumn">
      <td align="center"><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>#getcolumn.itemsize#</cfoutput></font></strong></td>
      </cfloop>
      </tr>
      <tr>
        <td colspan="100%"><hr></td>
      </tr>
      <cfset count=0>
      <cfoutput query="getitem" startrow="1">
      <cfset count=count+1>
      <cfquery name="getdate" datasource="#dts#">
              select modebill from serviceagree where servicecode='#getitem.rem5#'
              </cfquery>
        <tr>
          <td align="center" ><div align="left">#i#</div></td>
          <td align="center" >#dateformat(wos_date,'DD/MM/YYYY')#</td>
          <td align="center" >#rem5#</td>
          <td align="center" >&nbsp;</td>
          <td align="center" >&nbsp;</td>
          <td align="center" >#custno#</td>
          <input type="hidden" size="2" name="refno#count#" id="refno#count#" value="#getitem.refno#">
          <input type="hidden" size="2" name="date#count#" id="date#count#" value="#getitem.wos_date#">
          <input type="hidden" size="2" name="custno#count#" id="custno#count#" value="#getitem.custno#">
          <input type="hidden" size="2" name="argmno#count#" id="argmno#count#" value="#getitem.rem5#">
          <input type="hidden" size="2" name="amt#count#" id="amt#count#" value="#getitem.grand#">
          <input type="hidden" size="2" name="billing#count#" id="billing#count#" value="#getdate.modebill#">
          
          <cfloop from="1" to="#getcolumn.recordcount#" index="j">
          
          <td align="center" ><div align="right"><input type="text" size="2" name="qty#j#z#count#" id="qty#j#z#count#" value="#jsstringformat(evaluate("getitem.qty#j#"))#"></div></td>
         </cfloop>
         	<td align="center" ><div align="right"><input type="text" size="4" name="serv#count#" id="serv#count#" value="#getitem.serv#"></div></td>
              <td align="center" ><div align="right">#numberformat(grand,',_.__')#</div></td>
              
              
                <td align="center" ><div align="right">#getdate.modebill#</div></td>
       
      
        </tr>
        
        <!--- <cfset i = incrementvalue(#i#)> --->
        <cfset i = incrementvalue(#i#)>
      </cfoutput>
      <tr>
      
        <td colspan="50">
        <cfoutput>
        <input type="hidden" name="totalqty" id="totalqty" value="#getcolumn.recordcount#">
        <input type="hidden" name="totalrecord" id="totalrecord" value="#count#"></cfoutput>
        
        <input type="submit" name="submit" id="submit" value="Save">
        </td>
        </tr>
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
