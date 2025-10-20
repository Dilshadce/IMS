<html>
<head>
<title>Job Listing Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
<style type="text/css" media="print">
	.noprint { display: none; }
</style>
</head>

<cfparam name="i" default="1" type="numeric">

<cfquery name="getarea" datasource="#dts#">
  select location from placement 
  where 0=0
  <cfif form.result eq 'active'>
  and completedate > '#dateformat(now(),'yyyy-mm-dd')#'
  <cfelseif form.result eq 'ended'>
  and completedate <= '#dateformat(now(),'yyyy-mm-dd')#'
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
</cfquery>


<body>
<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">Print Date: <cfoutput>#dateformat(now(),"DD/MM/YY")#</cfoutput></font>
<div align="center"><font color="#000000" size="3" face="Arial, Helvetica, sans-serif"><strong><cfoutput>Placement</cfoutput> Listing Report</strong></font></div>

    <table width="100%" border="0" class="" align="center">
      <tr>
        <td colspan="100%"><hr></td>
      </tr>
      <tr>
        <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Placement No</cfoutput></font></strong></td>
        <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Placement Date</cfoutput></font></strong></td>
        <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Customer</cfoutput></font></strong></td>
        <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Employee</cfoutput></font></strong></td>
        <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Consultant</cfoutput></font></strong></td>
        <td align="right" ><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Charge Rate</cfoutput></font></strong></td>
        <td align="right" ><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Pay Rate</cfoutput></font></strong></td>
        <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Start Date</cfoutput></font></strong></td>
        <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Complete Date</cfoutput></font></strong></td>
        <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Last Invoice Date</cfoutput></font></strong></td> 
        
      </tr>
      <tr>
        <td colspan="100%"><hr></td>
      </tr>
      <cfoutput>
      <cfset empnolist = "">
      <cfif isdefined('form.showactive')>
       	<cfquery name="getemplist" datasource="#replace(dts,'_i','_p')#">
        	SELECT empno FROM pmast WHERE paystatus = "#form.activelist#"
        </cfquery>
        <cfif getemplist.recordcount neq 0>
        	<cfset empnolist = valuelist(getemplist.empno)>
		</cfif>
	  </cfif>
      <cfloop query="getarea" startrow="1">
      <tr>
      <td align="center" colspan="100%"><strong>#getarea.location#</strong></td>
      </tr>
      
  <cfquery name="getplacement" datasource="#dts#">
  SELECT * FROM (
  select * from placement 
  where 0=0
  <cfif form.result eq 'active'>
  and completedate > '#dateformat(now(),'yyyy-mm-dd')#'
  <cfelseif form.result eq 'ended'>
  and completedate <= '#dateformat(now(),'yyyy-mm-dd')#'
  <cfelse>
  </cfif>
	and location ='#getarea.location#'
  <cfif form.custfrom neq "" and form.custto neq "">
	and custno >= '#form.custfrom#' and custno <= '#form.custto#'
  </cfif>
  
  <cfif form.groupfrom neq "" and form.groupto neq "">
	and placementno >= '#form.groupfrom#' and placementno <= '#form.groupto#'
  </cfif>
  <cfif empnolist neq "">
  and empno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#empnolist#" list="yes" separator=",">)
  </cfif>
  
  order by custname ) as a
  LEFT JOIN 
  (select * from (select placementno as pno,assignmentslipdate from assignmentslip order by assignmentslipdate desc ) as aa
group by aa.pno) as b
on a.placementno = b.pno
	</cfquery>
      <cfloop query="getplacement" startrow="1">
        <tr>
          <td align="center">#placementno#</td>
          <td align="center" >#dateformat(placementdate,'dd/mm/yyyy')#</td>
          <td align="center" >#custname#</td>
          <td align="center" >#empname#</td>
          <td align="center" >#consultant#</td>
          <td align="right" >#numberformat(clientrate,',_.__')#</td>
          <td align="right" >#numberformat(newrate,',_.__')#</td>
          <td align="center" >#dateformat(startdate,'dd/mm/yyyy')#</td>
          <td align="center" >#dateformat(completedate,'dd/mm/yyyy')#</td>
         <td align="center" >#dateformat(getplacement.assignmentslipdate,'dd/mm/yyyy')#</td>
         
        </tr>
      </cfloop>
      <tr>
      <td colspan="100%"><hr></td>
      </tr>
      </cfloop>
      
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
