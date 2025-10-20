<html>
<head>
<title>Item History Price Listing</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
<style type="text/css" media="print">
	.noprint { display: none; }
</style>
</head>

<cfparam name="i" default="1" type="numeric">

<cfquery name="getVoucher" datasource="#dts#">
  select * from icitemhistran
  where 0=0
  <cfif form.groupfrom neq "" and form.groupto neq "">
	and itemno >= '#form.groupfrom#' and itemno <= '#form.groupto#'
  </cfif>
  order by itemno
</cfquery>


<body>
<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">Print Date: <cfoutput>#dateformat(now(),"DD/MM/YY")#</cfoutput></font>
<div align="center"><font color="#000000" size="3" face="Arial, Helvetica, sans-serif"><strong><cfoutput>Item History Price</cfoutput> Listing</strong></font></div>

  <cfif #getVoucher.recordCount# neq 0>
    <cfif isdefined("form.skeypage")>
      <cfset noOfPage=round(#getPersonal.recordcount#/20)>
      <cfif #getPersonal.recordcount# mod 20 LT 20 and #getPersonal.recordcount# mod 20 neq 0>
        <cfset noOfPage=#noOfPage#+1>
      </cfif>
      <cfif form.skeypage gt noofpage OR form.skeypage lt 1>
        <cfabort>
      </cfif>
    </cfif>
    <cfform action="l_voucher.cfm" method="post">
      <cfoutput>
        <input type="hidden" name="groupfrom" value="#form.groupfrom#">
        <input type="hidden" name="groupto" value="#form.groupto#">
        <cfif isdefined("form.cbmodel")>
          <input type="hidden" name="cbmodel" value="#form.cbmodel#">
        </cfif>
        <cfif isdefined("form.cbcustname")>
          <input type="hidden" name="cbcustname" value="#form.cbcustname#">
        </cfif>
        <cfif isdefined("form.cbcustic")>
          <input type="hidden" name="cbcustic" value="#form.cbcustic#">
        </cfif>
        <cfif isdefined("form.cbgender")>
          <input type="hidden" name="cbgender" value="#form.cbgender#">
        </cfif>
        <cfif isdefined("form.cbmarstatus")>
          <input type="hidden" name="cbmarstatus" value="#form.cbmarstatus#">
        </cfif>
        <cfif isdefined("form.cbcustadd")>
          <input type="hidden" name="cbAttn" value="#form.cbcustadd#">
        </cfif>
        <cfif isdefined("form.cbdob")>
          <input type="hidden" name="cbdob" value="#form.cbdob#">
        </cfif>
        <cfif isdefined("form.cbNCD")>
          <input type="hidden" name="cbNCD" value="#form.cbNCD#">
        </cfif>
        <cfif isdefined("form.cbcom")>
          <input type="hidden" name="cbcom" value="#form.cbcom#">
        </cfif>
        <cfif isdefined("form.cbscheme")>
          <input type="hidden" name="cbscheme" value="#form.cbscheme#">
        </cfif>
        <cfif isdefined("form.cbmake")>
          <input type="hidden" name="cbmake" value="#form.cbmake#">
        </cfif>
        <cfif isdefined("form.cbchasisno")>
          <input type="hidden" name="cbchasisno" value="#form.cbchasisno#">
        </cfif>
        <cfif isdefined("form.cbyearmade")>
          <input type="hidden" name="cbyearmade" value="#form.cbyearmade#">
        </cfif>
        <cfif isdefined("form.cboriregdate")>
          <input type="hidden" name="cboriregdate" value="#form.cboriregdate#">
        </cfif>
        <cfif isdefined("form.cbcapacity")>
          <input type="hidden" name="cbcapacity" value="#form.cbcapacity#">
        </cfif>
        <cfif isdefined("form.cbcoveragetype")>
          <input type="hidden" name="cbcoveragetype" value="#form.cbcoveragetype#">
        </cfif>
        <cfif isdefined("form.cbsuminsured")>
          <input type="hidden" name="cbsuminsured" value="#form.cbsuminsured#">
        </cfif>
        <cfif isdefined("form.cbinsurance")>
          <input type="hidden" name="cbinsurance" value="#form.cbinsurance#">
        </cfif>
        <cfif isdefined("form.cbpremium")>
          <input type="hidden" name="cbpremium" value="#form.cbpremium#">
        </cfif>
        <cfif isdefined("form.cbfinancecom")>
          <input type="hidden" name="cbfinancecom" value="#form.cbfinancecom#">
        </cfif>
        <cfif isdefined("form.cbcommission")>
          <input type="hidden" name="cbcommission" value="#form.cbcommission#">
        </cfif>
        <cfif isdefined("form.cbcontract")>
          <input type="hidden" name="cbcontract" value="#form.cbcontract#">
        </cfif>
                <cfif isdefined("form.cbpayment")>
          <input type="hidden" name="cbpayment" value="#form.cbpayment#">
        </cfif>
                <cfif isdefined("form.cbcustrefer")>
          <input type="hidden" name="cbcustrefer" value="#form.cbcustrefer#">
        </cfif>
      </cfoutput>
   
    </cfform>
    <table width="100%" border="0" class="" align="center">
      <tr>
        <td colspan="100%"><hr></td>
      </tr>
      <tr>
        <td><strong><font size="2" face="Arial, Helvetica, sans-serif">No</font></strong></td>
        <td><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Item No</cfoutput></font></strong></td>

        <td><strong><font size="2" face="Arial, Helvetica, sans-serif">Price</font></strong></td>
          <td><strong><font size="2" face="Arial, Helvetica, sans-serif">End Date</font></strong></td>

      </tr>
      <tr>
        <td colspan="100%"><hr></td>
      </tr>
      
      <cfoutput query="getvoucher" startrow="1">
        <tr>
          <td><div align="left">#i#</div></td>
          <td>#itemno#</td>
          <td>#numberformat(price,',_.__')#</td>
            <td>#dateformat(enddate,'DD/MM/YYYY')#</td>

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
  <cfif getvoucher.recordCount gt 0><cfelse>
  <strong><font size="2" face="Arial, Helvetica, sans-serif">No Records were found.
  </font> </strong>
</cfif>
<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>


</body>
</html>
