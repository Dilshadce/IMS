<html>
<head>
<title>Job Listing Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
<style type="text/css" media="print">
	.noprint { display: none; }
</style>
</head>
<cfinclude template="/object/dateobject.cfm">
<cfparam name="i" default="1" type="numeric">

<!--- <cfquery name="getarea" datasource="#dts#">
  select location from placement 
  where 0=0
  <cfif form.result eq 'active'>
  <cfif form.contractdate neq "">
  and completedate >= '#trim(dateformatnew(form.contractdate,'yyyy-mm-dd'))#'
  <cfelse>
  and completedate > '#dateformat(now(),'yyyy-mm-dd')#'
  </cfif>
  <cfelseif form.result eq 'ended'>
  <cfif form.contractdate neq "">
  and completedate <= '#trim(dateformatnew(form.contractdate,'yyyy-mm-dd'))#'
  <cfelse>
  and completedate <= '#dateformat(now(),'yyyy-mm-dd')#'
  </cfif>
  <cfelse>
  </cfif>
  <cfif form.locfrom neq "" and form.locto neq "">
	and location >= '#form.locfrom#' and location <= '#form.locto#'
  </cfif>
  <cfif form.custfrom neq "" and form.custto neq "">
	and custno >= '#form.custfrom#' and custno <= '#form.custto#'
  </cfif>
  <cfif form.groupfrom neq "" and form.groupto neq "">
	and placementno >= '#form.groupfrom#' and placementno <= '#form.groupto#'
  </cfif>
  group by location
  order by location
</cfquery> --->


<body>
<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">Print Date: <cfoutput>#dateformat(now(),"DD/MM/YY")#</cfoutput></font>
<div align="center"><font color="#000000" size="3" face="Arial, Helvetica, sans-serif"><strong>Welfare Report</strong></font></div>

    <table width="100%" border="0" class="" align="center">
      <tr>
        <td colspan="100%"><hr></td>
      </tr>
      <tr>
        <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Placement No</cfoutput></font></strong></td>
        <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Consultant</cfoutput></font></strong></td>
         <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Customer<br>
 No.</cfoutput></font></strong></td>
        <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Customer<br>
 Name</cfoutput></font></strong></td>
         <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Employee<br>
 No.</cfoutput></font></strong></td>
        <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Employee<br>
 Name</cfoutput></font></strong></td>
        
        <td align="right" ><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Welfare</cfoutput></font></strong></td>
        <td align="right" ><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Claimable<br>
 Date</cfoutput></font></strong></td>
        <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Claimed<br>
 Date</cfoutput></font></strong></td>
        <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Disqualification<br>
 Date</cfoutput></font></strong></td>
        <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Qualify</cfoutput></font></strong></td>
       
      </tr>
      <tr>
        <td colspan="100%"><hr></td>
      </tr>
      <cfoutput>
<!---       <cfloop query="getarea" startrow="1">
      <tr>
      <td align="center" colspan="100%"><strong>#getarea.location#</strong></td>
      </tr> --->
      
  <cfquery name="getplacement" datasource="#dts#">
  select * from placement 
  where ((welfare1 <> "" and welfare1 is not null) or (welfare2 <> "" and welfare2 is not null) or (welfare3 <> "" and welfare3 is not null))
  <cfif form.agentfrom neq "" and form.agentto neq "">
  and consultant between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.agentfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.agentto#">
  </cfif>
  <cfif form.claimablefrom neq "" and form.claimableto neq "">
  and ((welfareclaimdate1 between "#dateformatnew(form.claimablefrom,'yyyy-mm-dd')#" and "#dateformatnew(form.claimableto,'yyyy-mm-dd')#") or 
  (welfareclaimdate2 between "#dateformatnew(form.claimablefrom,'yyyy-mm-dd')#" and "#dateformatnew(form.claimableto,'yyyy-mm-dd')#")
  or
  (welfareclaimdate3 between "#dateformatnew(form.claimablefrom,'yyyy-mm-dd')#" and "#dateformatnew(form.claimableto,'yyyy-mm-dd')#"))
  </cfif>
  
  <cfif form.claimedfrom neq "" and form.claimedto neq "">
  and ((welfareclaimeddate1 between "#dateformatnew(form.claimedfrom,'yyyy-mm-dd')#" and "#dateformatnew(form.claimedto,'yyyy-mm-dd')#") or 
  (welfareclaimeddate2 between "#dateformatnew(form.claimedfrom,'yyyy-mm-dd')#" and "#dateformatnew(form.claimedto,'yyyy-mm-dd')#")
  or
  (welfareclaimeddate3 between "#dateformatnew(form.claimedfrom,'yyyy-mm-dd')#" and "#dateformatnew(form.claimedto,'yyyy-mm-dd')#"))
  </cfif>
  
  <cfif isdefined('form.qualify')>
  and ((welfareeg1 = "Y" and welfaredisq1 <> "Y") or (welfareeg2 = "Y" and welfaredisq2 <> "Y") or (welfareeg3 = "Y" and welfaredisq3 <> "Y"))
  </cfif>
  <cfif form.result eq 'active'>
  and completedate > <cfif form.contractdate neq "">'#trim(dateformatnew(form.contractdate,'yyyy-mm-dd'))#'<cfelse>'#dateformat(now(),'yyyy-mm-dd')#'</cfif>
  <cfelseif form.result eq 'ended'>
  and completedate <= <cfif form.contractdate neq "">'#trim(dateformatnew(form.contractdate,'yyyy-mm-dd'))#'<cfelse>'#dateformat(now(),'yyyy-mm-dd')#'</cfif>
  <cfelse>
  </cfif>
<!--- 	and location ='#getarea.location#' --->
  <cfif form.custfrom neq "" and form.custto neq "">
	and custno >= '#form.custfrom#' and custno <= '#form.custto#'
  </cfif>
  
  <cfif form.groupfrom neq "" and form.groupto neq "">
	and placementno >= '#form.groupfrom#' and placementno <= '#form.groupto#'
  </cfif>
  order by <cfif form.orderby eq "custname">custname<cfelse>welfareclaimdate1,welfareclaimdate2,welfareclaimdate3</cfif>
	</cfquery>
    
    
      <cfloop query="getplacement" startrow="1">
     	<cfloop from="1" to="3" index="a">
        <cfif evaluate('getplacement.welfare#a#') neq "">
         <cfif isdefined('form.qualify') and (evaluate('getplacement.welfareeg#a#') neq "Y" or evaluate('getplacement.welfaredisq#a#') eq "Y")>
         <cfelseif form.claimablefrom neq "" and form.claimableto neq "">
        	<cfif dateformat(evaluate('getplacement.welfareclaimdate#a#'),'yyyy-mm-dd') gte dateformatnew(form.claimablefrom,'yyyy-mm-dd') and dateformat(evaluate('getplacement.welfareclaimdate#a#'),'yyyy-mm-dd') lte dateformatnew(form.claimableto,'yyyy-mm-dd')>
            <cfinclude template="body.cfm">
            </cfif>
         <cfelseif form.claimedfrom neq "" and form.claimedto neq "">
        	<cfif dateformat(evaluate('getplacement.welfareclaimeddate#a#'),'yyyy-mm-dd') gte dateformatnew(form.claimedfrom,'yyyy-mm-dd') and dateformat(evaluate('getplacement.welfareclaimeddate#a#'),'yyyy-mm-dd') lte dateformatnew(form.claimedto,'yyyy-mm-dd')>
            <cfinclude template="body.cfm">
            </cfif>
         <cfelse>
         
         
         
        <cfinclude template="body.cfm">
        </cfif>
        </cfif>
        </cfloop>
      </cfloop>
<!---       <tr>
      <td colspan="100%"><hr></td>
      </tr>
      </cfloop> --->
      
      </cfoutput>
    </table>
    <br>
    <div align="right">

    </div>

  <cfif getplacement.recordCount gt 0><cfelse>
  <strong><font size="2" face="Arial, Helvetica, sans-serif">No Records were found.
  </font> </strong>
</cfif>
<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>


</body>
</html>
