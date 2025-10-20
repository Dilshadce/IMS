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

<cfquery name="getarea" datasource="#dts#">
  select location from placement 
  where 0=0
  <cfif form.result eq 'active'>
  <cfif form.contractdate neq "">
  and completedate >= '#dateformatnew(form.contractdate,'yyyy-mm-dd')#'
  <cfelse>
  and completedate > '#dateformat(now(),'yyyy-mm-dd')#'
  </cfif>
  <cfelseif form.result eq 'ended'>
  <cfif form.contractdate neq "">
  and completedate <= '#dateformatnew(form.contractdate,'yyyy-mm-dd')#'
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
        <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Bank Code</cfoutput></font></strong></td>
        <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Branch Code</cfoutput></font></strong></td>
        <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Bank Account No</cfoutput></font></strong></td>
          <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Created By</cfoutput></font></strong></td>      
          <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Updated By</cfoutput></font></strong></td>  
          <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>PO Number</cfoutput></font></strong></td>      
          <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>PO Date</cfoutput></font></strong></td>     
          <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>PO Amount</cfoutput></font></strong></td>
          <td align="center" ><strong><font size="1" face="Arial, Helvetica, sans-serif"><cfoutput>Price Matrix</cfoutput></font></strong></td> 
          <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Description 1</cfoutput></font></strong></td>     
        <td align="center" ><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Description 2</cfoutput></font></strong></td> 
      </tr>
      <tr>
        <td colspan="100%"><hr></td>
      </tr>
      <cfoutput>
      <cfloop query="getarea" startrow="1">
      <tr>
      <td align="center" colspan="100%"><strong>#getarea.location#</strong></td>
      </tr>
          
<cfquery datasource='#dts#' name="getpmlist">
			select pm from (
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
                  order by custname
            ) a
            where pm !=''
            group by pm;
		</cfquery>
                      
        <cfset pm_list = []>
        <cfloop query="getpmlist">
            <cfscript>
            ArrayAppend(pm_list,getpmlist.pm,true);
            </cfscript>
        </cfloop>
      
  <cfquery name="getplacement" datasource="#dts#">
    <cfif getpmlist.RecordCount gt 0>
        select p.*,pm.pricename as "pricename"  from placement p
        left join (
          select * from manpowerpricematrix
            where priceid in (#arraytolist(pm_list)#)
        ) pm
        on p.pm = pm.priceid
    <cfelse>
        select *,'' as 'pricename' from placement p
    </cfif>
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
  order by custname
	</cfquery>
    
    <cfquery name="getpmast" datasource="#replace(dts,'_i','_p')#">
    select bankcode,brancode,bankaccno,empno from pmast
    </cfquery>
    
      <cfloop query="getplacement" startrow="1">
     
     <cfquery name="getbank" dbtype="query">
     SELECT bankcode,brancode,bankaccno FROM getpmast WHERE UPPER(empno) = <cfqueryparam cfsqltype="cf_sql_varchar" value="#UCASE(getplacement.empno)#">
     </cfquery> 
     
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
          <td align="center">#getbank.bankcode#</td>
          <td align="center">'#getbank.brancode#</td>
          <td align="center">'#getbank.bankaccno#</td>
          <td align="center">#getplacement.created_by#</td>
		  <td align="center">#getplacement.updated_by#</td>
          <td align="center">#getplacement.po_no#</td>
          <td align="center"><cfif getplacement.po_date neq "">#dateformat(getplacement.po_date,'dd/mm/yyyy')#</cfif></td>
          <td align="center">#numberformat(getplacement.po_amount,'.__')#</td>
          <td align="center">#getplacement.pricename#</td>
          <td align="center">#getplacement.description1#</td>
          <td align="center">#getplacement.description2#</td>
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
