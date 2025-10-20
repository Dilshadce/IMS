<html>
<head>
<title>Vehicle Listing</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
<style type="text/css" media="print">
	.noprint { display: none; }
</style>
</head>

<cfparam name="i" default="1" type="numeric">

<cfquery name="getVehicles" datasource="#dts#">
  select * from vehicles 
  where 0=0
  <cfif form.groupfrom neq "" and form.groupto neq "">
	and carno >= '#form.groupfrom#' and carno <= '#form.groupto#'
  </cfif>
    <cfif form.groupfrom2 neq "" and form.groupto2 neq "">
	and custcode >= '#form.groupfrom2#' and custcode <= '#form.groupto2#'
  </cfif>
  order by carno
</cfquery>


<body>
<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">Print Date: <cfoutput>#dateformat(now(),"DD/MM/YY")#</cfoutput></font>
<div align="center"><font color="#000000" size="3" face="Arial, Helvetica, sans-serif"><strong><cfoutput>Vehicles</cfoutput> Listing</strong></font></div>

  <cfif #getVehicles.recordCount# neq 0>
    <cfif isdefined("form.skeypage")>
      <cfset noOfPage=round(#getPersonal.recordcount#/20)>
      <cfif #getPersonal.recordcount# mod 20 LT 20 and #getPersonal.recordcount# mod 20 neq 0>
        <cfset noOfPage=#noOfPage#+1>
      </cfif>
      <cfif form.skeypage gt noofpage OR form.skeypage lt 1>
        <cfabort>
      </cfif>
    </cfif>
    <cfform action="l_vehicles.cfm" method="post">
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
          <cfif isdefined("form.cbinexpdate")>
          <input type="hidden" name="cbinexpdate" value="#form.cbinexpdate#">
        </cfif>
      </cfoutput>
   
    </cfform>
    <table width="100%" border="0" class="" align="center">
      <tr>
        <td colspan="100%"><hr></td>
      </tr>
      <tr>
         <td align="center" width="2%"><strong><font size="2" face="Arial, Helvetica, sans-serif">No</font></strong></td>
        <td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Vehicle No</cfoutput></font></strong></td>

                        <cfif isdefined("form.cbmodel")>
        <td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif">Model</font></strong></td>
        </cfif>
            <cfif isdefined("form.cbcustname")>
        <td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif">custname</font></strong></td>
        </cfif>
        <cfif isdefined("form.cbcustic")>
          <td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif">Customer IC</font></strong></td>
        </cfif>
        <cfif isdefined("form.cbgender")>
          <td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif">Gender</font></strong></td>
        </cfif>
        <cfif isdefined("form.cbmarstatus")>
          <td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif">Martial status</font></strong></td>
        </cfif>
        <cfif isdefined("form.cbcustadd")>
          <td align="center" width="17%"><strong><font size="2" face="Arial, Helvetica, sans-serif">Address</font></strong></td>
        </cfif>
        <cfif isdefined("form.cbdob")>
          <td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif">Date of Birth</font></strong></td>
        </cfif>
        <cfif isdefined("form.cbNCD")>
          <td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif">NCD</font></strong></td>
        </cfif>
        <cfif isdefined("form.cbcom")>
          <td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif">Certificate of Merit</font></strong></td>
        </cfif>
        <cfif isdefined("form.cbscheme")>
          <td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif">Vehicle Scheme</font></strong></td>
        </cfif>
        <cfif isdefined("form.cbmake")>
          <td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif">Vehicle Make</font></strong></td>
        </cfif>
        <cfif isdefined("form.cbchasisno")>
          <td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif">Chasis No</font></strong></td>
        </cfif>
        <cfif isdefined("form.cbyearmade")>
          <td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif">Year of manufacture</font></strong></td>
        </cfif>
        <cfif isdefined("form.cboriregdate")>
          <td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif">Original Reg Date</font></strong></td>
        </cfif>
        <cfif isdefined("form.cbcapacity")>
          <td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif">Capacity</font></strong></td>
        </cfif>
        <cfif isdefined("form.cbcoveragetype")>
          <td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif">Coverage type</font></strong></td>
        </cfif>
        <cfif isdefined("form.cbsuminsured")>
          <td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif">Sum Insured</font></strong></td>
        </cfif>
        <cfif isdefined("form.cbinsurance")>
          <td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif">Insurance</font></strong></td>
        </cfif>
        <cfif isdefined("form.cbpremium")>
          <td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif">Premium</font></strong></td>
        </cfif>
        <cfif isdefined("form.cbfinancecom")>
          <td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif">Finance</font></strong></td>
        </cfif>
        <cfif isdefined("form.cbcommision")>
          <td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif">Commision</font></strong></td>
        </cfif>
        <cfif isdefined("form.cbcontract")>
          <td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif">Contact</font></strong></td>
        </cfif>
        <cfif isdefined("form.cbpayment")>
          <td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif">Payment</font></strong></td>
        </cfif>
        <cfif isdefined("form.cbcustrefer")>
          <td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif">Refered By</font></strong></td>
        </cfif>
        <cfif isdefined("form.cbinexpdate")>
          <td align="center" width="9%"><strong><font size="2" face="Arial, Helvetica, sans-serif">Insurance Expire Date</font></strong></td>
        </cfif>
      </tr>
      <tr>
        <td colspan="100%"><hr></td>
      </tr>
      
      <cfoutput query="getvehicles" startrow="1">
        <tr>
          <td align="center" width="2%"><div align="left">#i#</div></td>
          <td align="center" width="9%">#carno#</td>
          <cfif isdefined("form.cbmodel")>
            <td align="center" width="9%">#model#</td>
          </cfif>
          <cfif isdefined("form.cbcustname")>
            <td align="center" width="9%">#custname#</td>
          </cfif>
          <cfif isdefined("form.cbcustic")>
            <td align="center" width="9%">#custic#</td>
          </cfif>
          <cfif isdefined("form.cbgender")>
            <td align="center" width="9%">#gender#</td>
          </cfif>
          <cfif isdefined("form.cbmarstatus")>
            <td align="center" width="9%">#marstatus#</td>
          </cfif>
          <cfif isdefined("form.cbcustadd")>
            <td align="center" width="17%">#custadd#</td>
          </cfif>
          <cfif isdefined("form.cbdob")>
            <td align="center" width="9%">#dateformat(dob,'DD-MM-YYYY')#</td>
          </cfif>
          <cfif isdefined("form.cbNCD")>
            <td align="center" width="9%">#NCD#</td>
          </cfif>
          <cfif isdefined("form.cbcom")>
            <td align="center" width="9%">#com#</td>
          </cfif>
          <cfif isdefined("form.cbscheme")>
            <td align="center" width="9%">#scheme#</td>
          </cfif>
          <cfif isdefined("form.cbmake")>
            <td align="center" width="9%">#make#</td>
          </cfif>
          <cfif isdefined("form.cbchasisno")>
            <td align="center" width="9%">#chasisno#</td>
          </cfif>
          <cfif isdefined("form.cbyearmade")>
            <td align="center" width="9%">#yearmade#</td>
          </cfif>
          <cfif isdefined("form.cboriregdate")>
            <td align="center" width="9%">#dateformat(oriregdate,'DD-MM-YYYY')#</td>
          </cfif>
          <cfif isdefined("form.cbcapacity")>
            <td align="center" width="9%">#capacity#</td>
          </cfif>
          <cfif isdefined("form.cbcoveragetype")>
            <td align="center" width="9%">#coveragetype#</td>
          </cfif>
          <cfif isdefined("form.cbsuminsured")>
            <td align="center" width="9%">#suminsured#</td>
          </cfif>
          <cfif isdefined("form.cbinsurance")>
            <td align="center" width="9%"><div align="center">#insurance#</div></td>
          </cfif>
          <cfif isdefined("form.cbpremium")>
            <td align="center" width="9%"><div align="right">#premium#</div></td>
          </cfif>
          <cfif isdefined("form.cbfinancecom")>
            <td align="center" width="9%"><div align="center">#financecom#</div></td>
          </cfif>
          <cfif isdefined("form.cbcommission")>
            <td align="center" width="9%"><div align="right">#commission#</div></td>
          </cfif>
          <cfif isdefined("form.cbcontract")>
            <td align="center" width="9%"><div align="right">#contract#</div></td>
          </cfif>
                    <cfif isdefined("form.cbpayment")>
            <td align="center" width="9%"><div align="right">#payment#</div></td>
          </cfif>
                    <cfif isdefined("form.cbcustrefer")>
            <td align="center" width="9%"><div align="right">#custrefer#</div></td>
          </cfif>
              <cfif isdefined("form.cbinexpdate")>
            <td align="center" width="9%"><div align="right">#dateformat(inexpdate,'DD-MM-YYYY')#</div></td>
          </cfif>
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
  <cfif getVehicles.recordCount gt 0><cfelse>
  <strong><font size="2" face="Arial, Helvetica, sans-serif">No Records were found.
  </font> </strong>
</cfif>
<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>


</body>
</html>
