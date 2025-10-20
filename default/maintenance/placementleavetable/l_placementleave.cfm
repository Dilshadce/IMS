<html>
<head>
<title>Placement Leave Summary Listing Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<cfquery name="getmonthyear" datasource="payroll_main">
SELECT myear,mmonth FROM gsetup WHERE comp_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#replace(dts,'_i','')#">
</cfquery>
<cfset datelastnow = daysinmonth(createdate("#getmonthyear.myear#","#getmonthyear.mmonth#","1"))>
<cfset datenow = createdate("#getmonthyear.myear#","#getmonthyear.mmonth#","#datelastnow#")>
<cfquery name="getplacementlist" datasource="#dts#">
SELECT * FROM placement
WHERE 1=1
<cfif form.result eq 'active'>
  and completedate > '#dateformat(datenow,'yyyy-mm-dd')#'
  <cfelseif form.result eq 'ended'>
  and completedate <= '#dateformat(datenow,'yyyy-mm-dd')#'
  <cfelse>
  </cfif>
<cfif form.custfrom neq "" and form.custto neq "">
AND custno Between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custfrom#">
and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custto#">
</cfif>
<cfif form.departmentfrom neq "" and form.departmentto neq "">
AND department Between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.departmentfrom#">
and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.departmentto#">
</cfif>
<cfif form.supervisorfrom neq "" and form.supervisorto neq "">
AND supervisor Between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.supervisorfrom#">
and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.supervisorto#">
</cfif>
<cfif form.empfrom neq "" and form.empto neq "">
AND empno Between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empfrom#">
and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empto#">
</cfif>
ORDER BY custname,empname,custno
</cfquery>

<cfquery name="getleavelist" datasource="#dts#">
SELECT leavetype FROM leavelist WHERE leavetype not in ('AL','CC1','HPL','MC','NPL') and placementno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getplacementlist.placementno)#" list="yes" separator=",">) GROUP BY leavetype ORDER BY leavetype
</cfquery>

 <cfloop query="getleavelist">
      <cfquery name="checkentitle" datasource="#dts#">
      SELECT #getleavelist.leavetype#entitle FROM placement WHERE (#getleavelist.leavetype#days != "0" or #getleavelist.leavetype#days != "" or #getleavelist.leavetype#days is not null) and placementno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getplacementlist.placementno)#" list="yes" separator=",">)
      </cfquery>
      
      <cfif checkentitle.recordcount neq 0>
      <cfset "#getleavelist.leavetype#entable" = "Y">
      </cfif>
      
</cfloop>
<body>
<cfoutput>
<div align="center"><font color="##000000" size="3" face="Arial, Helvetica, sans-serif"><strong><cfoutput>Placement Leave Summary</cfoutput> Listing</strong></font></div>
<cfset startcustno  = "">
    <table width="100%" class="" align="center" border="1">
     
      <cfloop query="getplacementlist">
      <cfif getplacementlist.custno neq startcustno>
      <cfset startcustno = getplacementlist.custno>
      <tr>
      <td colspan="100%"></td>
      </tr>
      <tr>
      <td colspan="100%">
      <table width="100%">
      <tr>
      <th>Customer Name</th>
      <td>#getplacementlist.custname#</td>
      <th>Customer No</th>
      <td>#getplacementlist.custno#</td>
      </tr>
      <tr>
      <th>Date printed</th>
      <td>#dateformat(now(),'dd/mm/yyyy')#</td>
      </tr>
      </table>
      </td>
      </tr>
      <tr>
      <th rowspan="2" valign="top">Emp No</th>
      <th rowspan="2" valign="top">Name</th>
      <th rowspan="2" valign="top">Placement No</th>
      <th rowspan="2" valign="top">Contract<br>Start Date</th>
      <th rowspan="2" valign="top">Contract<br>End Date</th>
      <th colspan="3" valign="top">Annual</th>
      <th colspan="3" valign="top">Medical</th>
      <th colspan="3" valign="top">Hospitalization</th>
      <th colspan="3" valign="top">Childcare</th>
      <th>NPL</th>
      <cfloop query="getleavelist">   
       
      <th  <cfif isdefined("#getleavelist.leavetype#entable")>colspan="3"</cfif> valign="top">#getleavelist.leavetype#</th>
      </cfloop>
      </tr>
      <tr>
      <td>Ent</td>
      <td>Taken</td>
      <td>Bal</td>
      <td>Ent</td>
      <td>Taken</td>
      <td>Bal</td>
      <td>Ent</td>
      <td>Taken</td>
      <td>Bal</td>
      <td>Ent</td>
      <td>Taken</td>
      <td>Bal</td>
      <td>Taken</td>
       <cfloop query="getleavelist">
       <cfif isdefined("#getleavelist.leavetype#entable")>
       <td>Ent</td>
      <td>Bal</td>
      <td>Taken</td>
	   <cfelse>
       <td>taken</td>
	   </cfif>
      </cfloop>
      </tr>
      </cfif>
      <cfquery name="getleavedetail" datasource="#dts#">
      SELECT sum(days) as days,leavetype FROM leavelist WHERE placementno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getplacementlist.placementno#"> and contractenddate = "#dateformat(getplacementlist.completedate,'YYYY-MM-DD')#" GROUP BY leavetype
      </cfquery>
      <cfloop query="getleavedetail">
      <cfset "#getleavedetail.leavetype##getplacementlist.placementno#day" = getleavedetail.days>
      </cfloop>
      <tr>
      <td>#getplacementlist.empno#</td>
      <td>#getplacementlist.empname#</td>
      <td>#getplacementlist.placementno#</td>
      <td>#dateformat(getplacementlist.startdate,'dd/mm/yyyy')#</td>
      <td>#dateformat(getplacementlist.completedate,'dd/mm/yyyy')#</td>
      <td>#val(getplacementlist.ALdays)+val(getplacementlist.ALbfdays)#</td>
	  <cfif isdefined("AL#getplacementlist.placementno#day")>
	  <cfset altaken = val(evaluate("AL#getplacementlist.placementno#day"))>
      <cfelse>
      <cfset altaken = 0>
	  </cfif>
      <td>#altaken#</td>
      <td>#val(getplacementlist.ALdays)+val(getplacementlist.ALbfdays) - val(altaken)#</td>
      <td>#val(getplacementlist.MCdays)#</td>
      <cfif isdefined("MC#getplacementlist.placementno#day")>
	  <cfset mctaken = val(evaluate("MC#getplacementlist.placementno#day"))>
      <cfelse>
      <cfset mctaken = 0>
	  </cfif>
      <td>#mctaken#</td>
      <td>#val(getplacementlist.MCdays)- val(mctaken)#</td>
       <td>#val(getplacementlist.hpldays)#</td>
      <cfif isdefined("hpl#getplacementlist.placementno#day")>
	  <cfset hpltaken = val(evaluate("hpl#getplacementlist.placementno#day"))>
      <cfelse>
      <cfset hpltaken = 0>
	  </cfif>
      <td>#hpltaken#</td>
      <td>#val(getplacementlist.hpldays)- val(hpltaken)#</td>
       <td>#val(getplacementlist.cc1days)#</td>
      <cfif isdefined("cc1#getplacementlist.placementno#day")>
	  <cfset cc1taken = val(evaluate("cc1#getplacementlist.placementno#day"))>
      <cfelse>
      <cfset cc1taken = 0>
	  </cfif>
      <td>#cc1taken#</td>
      <td>#val(getplacementlist.cc1days)- val(cc1taken)#</td>
       <cfif isdefined("npl#getplacementlist.placementno#day")>
	  <cfset npltaken = val(evaluate("npl#getplacementlist.placementno#day"))>
      <cfelse>
      <cfset npltaken = 0>
	  </cfif>
      <td>#npltaken#</td>
      <cfloop query="getleavelist">
      
       <cfif isdefined("#getleavelist.leavetype##getplacementlist.placementno#day")>
	  <cfset leavetaken = val(evaluate("#getleavelist.leavetype##getplacementlist.placementno#day"))>
      <cfelse>
      <cfset leavetaken = 0>
	  </cfif>
      <cfif isdefined("#getleavelist.leavetype#entable")>
      <td>#val(evaluate('getplacementlist.#getleavelist.leavetype#days'))#</td>
      <td>#leavetaken#</td>
      <td>#val(evaluate('getplacementlist.#getleavelist.leavetype#days')) - val(leavetaken)#</td>
      <cfelse>
      <td>#leavetaken#</td>
      </cfif>
      </cfloop>
      </tr>
	</cfloop>
      
 
    </table>
  
<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
     </cfoutput>

</body>
</html>
