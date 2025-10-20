<cfif isdefined('form.empnofield') eq false>
<h1>No Employee Selected</h1>
<cfabort>
</cfif>
<html>
<head>
<title>Placement Leave Detail Listing</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>


<cfquery name="getplacementlist" datasource="#dts#">
SELECT * FROM placement
WHERE empno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empnofield#" list="yes" separator=",">)
ORDER BY custname,empname,custno
</cfquery>

<cfquery name="leavelist" datasource="#dts#">
Select * from iccostcode  WHERE costcode not in ('AL','CC1','HPL','MC','NPL')  order by costcode
</cfquery>

<body>
<cfoutput>

      <cfloop query="getplacementlist">
       <cfquery name="getleavedetail" datasource="#dts#">
      SELECT sum(days) as days,leavetype FROM leavelist WHERE placementno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getplacementlist.placementno#"> <!--- and contractenddate = "#dateformat(getplacementlist.completedate,'YYYY-MM-DD')#" ---> GROUP BY leavetype
      </cfquery>
      <cfloop query="getleavedetail">
      <cfset "#getleavedetail.leavetype##getplacementlist.placementno#day" = getleavedetail.days>
      </cfloop>
      <table>
      <tr>
      <td colspan="100%" align="right">Date Printed: #dateformat(now(),'dd/mm/yyyy')#</td>
      </tr>
      <tr>
      <td colspan="100%">
      <table width="100%">
      <tr>
      <th align="left">Name</th>
      <td>#getplacementlist.empname#</td>
      <th align="left">Customer</th>
      <td>#getplacementlist.custname#</td>
      </tr>
      <tr>
      <th align="left">IC Number</th>
      <td>#getplacementlist.nric#</td>
      <th align="left">Placement No</th>
      <td>#getplacementlist.placementno#</td>
      </tr>
      <tr>
      <th align="left">Contract Start Date</th>
      <td>#dateformat(getplacementlist.startdate,'dd/mm/yyyy')#</td>
      <th align="left">Contract End Date</th>
      <td>#dateformat(getplacementlist.completedate,'dd/mm/yyyy')#</td>
      </tr>
      </table>
      </td>
      </tr>
      <tr>
      <td colspan="100%"></td>
      </tr>
      <tr>
      <th align="left">Leave Type</th>
      <th align="left">Entitlement</th>
      <th align="left">Carry Forward</th>
      <th align="left">Taken</th>
      <th align="left">Balance</th>
      <td></td>
      </tr>
       <cfif isdefined("AL#getplacementlist.placementno#day")>
	  <cfset altaken = val(evaluate("AL#getplacementlist.placementno#day"))>
      <cfelse>
      <cfset altaken = 0>
	  </cfif>
      <cfif altaken neq 0 or val(getplacementlist.ALdays) + val(getplacementlist.ALbfdays) neq 0>
      <tr>
      <td>Annual Leave</td>
      <td>#val(getplacementlist.ALdays)#</td>
      <td>#val(getplacementlist.ALbfdays)#</td>
      <td>#altaken#</td>
      <td>#val(getplacementlist.ALdays)+val(getplacementlist.ALbfdays) - val(altaken)#</td>
 
      </tr>
       </cfif>
      <cfif isdefined("MC#getplacementlist.placementno#day")>
	  <cfset mctaken = val(evaluate("MC#getplacementlist.placementno#day"))>
      <cfelse>
      <cfset mctaken = 0>
	  </cfif>
      <cfif mctaken neq 0 or val(getplacementlist.MCdays) neq 0>
      <tr>
      <td>Medical Leave</td>
       <td>#val(getplacementlist.MCdays)#</td>
      
      <td></td>
      <td>#mctaken#</td>
      <td>#val(getplacementlist.MCdays)- val(mctaken)#</td>
     
      </tr> 
      </cfif>
	  <cfif isdefined("hpl#getplacementlist.placementno#day")>
	  <cfset hpltaken = val(evaluate("hpl#getplacementlist.placementno#day"))>
      <cfelse>
      <cfset hpltaken = 0>
	  </cfif>
      <cfif hpltaken neq 0 or val(getplacementlist.hpldays)> 
      <tr>
      <td>Hospitalisation</td>
      <td>#val(getplacementlist.hpldays)#</td>
      
      <td></td>
      <td>#hpltaken#</td>
      <td>#val(getplacementlist.hpldays)- val(hpltaken)#</td>
  
      </tr>
      </cfif>
	  <cfif isdefined("cc1#getplacementlist.placementno#day")>
	  <cfset cc1taken = val(evaluate("cc1#getplacementlist.placementno#day"))>
      <cfelse>
      <cfset cc1taken = 0>
	  </cfif>
      <cfif cc1taken neq 0 or val(getplacementlist.cc1days) neq 0>
      <tr>
      <td>Childcare</td>
       <td>#val(getplacementlist.cc1days)#</td>
      
      <td></td>
      <td>#cc1taken#</td>
      <td>#val(getplacementlist.cc1days)- val(cc1taken)#</td>
     
      </tr>
      </cfif>
	  <cfif isdefined("npl#getplacementlist.placementno#day")>
	  <cfset npltaken = val(evaluate("npl#getplacementlist.placementno#day"))>
      <cfelse>
      <cfset npltaken = 0>
	  </cfif>
      <cfif npltaken neq 0>
      <tr>
      <td>NPL</td>
      <td></td>
      <td></td>

      
      <td>#npltaken#</td>
          <td></td>
      </tr>
      </cfif>
      <cfloop query="leavelist">
      <cfif evaluate('getplacementlist.#leavelist.costcode#entitle') eq 'Y'>
      <tr>
      <td>#leavelist.Desp#</td>
      <td>#evaluate('getplacementlist.#leavelist.costcode#days')#</td>
      <td></td>
      <cfif isdefined("#leavelist.costcode##getplacementlist.placementno#day")>
	  <cfset leavetaken = val(evaluate("#leavelist.costcode##getplacementlist.placementno#day"))>
      <cfelse>
      <cfset leavetaken = 0>
	  </cfif>
      <td>#leavetaken#</td>
      <td>#val(evaluate('getplacementlist.#leavelist.costcode#days')) - val(leavetaken)#</td>
    
      </tr>
	  </cfif>
      </cfloop>
      <tr>
      <td colspan="100%"></td>
      </tr>
      <tr>
      <th align="left">Leave Details</th>
      </tr>
      <tr>
      <th align="left">Leave</th>
      <th align="left">Start Date</th>
      <th align="left">End Date</th>
      <th align="left">Leave Taken</th>
      </tr>
      <cfquery name="getleavedetail" datasource="#dts#">
      SELECT * FROM (
      SELECT leavetype,days,startdate,enddate FROM leavelist WHERE placementno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getplacementlist.placementno#"> <!--- and contractenddate = "#dateformat(getplacementlist.completedate,'YYYY-MM-DD')#" --->) as a
      LEFT JOIN
      (SELECT desp,costcode from iccostcode) as b
      on a.leavetype = b.costcode
      ORDER BY a.leavetype,a.startdate desc
      </cfquery>
      <cfloop query="getleavedetail">
      <tr>
      <td>#getleavedetail.desp#</td>
      <td>#dateformat(getleavedetail.startdate,'dd/mm/yyyy')#</td>
      <td>#dateformat(getleavedetail.enddate,'dd/mm/yyyy')#</td>
      <td>#val(getleavedetail.days)#</td>
      </tr>
      </cfloop>
   </table>
   <cfif getplacementlist.recordcount neq getplacementlist.currentrow>
   <p style="page-break-after:always">
   </p>
   </cfif>
	</cfloop>
     </cfoutput>

</body>
</html>
