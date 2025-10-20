
<cfoutput>
<!---   <cfset datestart = createdate(listlast(form.datefrom,'/'),listgetat(form.datefrom,'2','/'),listfirst(form.datefrom,'/'))>
  <cfset dateend = createdate(listlast(form.dateto,'/'),listgetat(form.dateto,'2','/'),listfirst(form.dateto,'/'))> --->
  
<cfquery name="getclaimlist" datasource="#dts#">
	SELECT wos_group,desp FROM icgroup ORDER BY wos_group
</cfquery>

<cfquery name="getplacement" datasource="#dts#">
SELECT * FROM placement
WHERE
1=1 
and 
(
<cfloop query="getclaimlist">
(total#getclaimlist.wos_group#claimable <> 0 and total#getclaimlist.wos_group#claimable <> '')
<cfif  getclaimlist.recordcount neq getclaimlist.currentrow>
OR
</cfif>
</cfloop>
)
<cfif form.comfrm neq "" and form.comto neq "">
and custno Between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.comfrm#">
and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.comto#">
</cfif>
<cfif form.empfrom neq "" and form.empto neq "">
and empno BETWEEN <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empto#">
</cfif>
<cfif form.placementfrom neq "" and form.placementto neq "">
and Placementno BETWEEN <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.placementfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.placementto#">
</cfif>
<cfif form.createdfrm neq "" and form.createdto neq "">
and (created_by BETWEEN <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.createdfrm#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.createdto#">)
</cfif>
ORDER BY empno 
</cfquery>



<cfquery name="getall" datasource="#dts#">
SELECT addchargecode,addchargeself,addchargecode2,addchargeself2,addchargecode3,addchargeself3,placementno,assignmentslipdate FROM assignmentslip WHERE placementno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getplacement.placementno)#" separator="," list="yes">) ORDER BY assignmentslipdate
</cfquery>

<h3>Claim Capping Report</h3>
<cfloop query="getplacement">
<table>
<tr>
<td colspan="100%" align="left">Date Printed: #dateformat(now(),'dd/mm/yyyy')#</td>
</tr>
<tr>
<th align="left">Name</th>
<td>#getplacement.empname#</td>
<td>&nbsp;</td>
<th align="left">Customer</th>
<td>#getplacement.custname#</td>
</tr>
<tr>
<th align="left">IC Number</th>
<td>#getplacement.nric#</td>
<td>&nbsp;</td>
<th align="left">Placement No</th>
<td>#getplacement.placementno#</td>
</tr>
<tr>
<th align="left">Contract Start Date</th>
<td>#dateformat(getplacement.startdate,'dd/mm/yyyy')#</td>
<td>&nbsp;</td>
<th align="left">Contract End Date</th>
<td>#dateformat(getplacement.completedate,'dd/mm/yyyy')#</td>
</tr>
<tr>
<td colspan="100%">
<table width="100%">
<tr>
<th align="left">Claim Type</th>
<th align="left">Cap</th>
<th align="right">Amount Claimed</th>
<th align="right">Balance</th>
</tr>
<cfquery name="getclaimdetail" dbtype="query">
SELECT addchargecode,addchargeself,addchargecode2,addchargeself2,addchargecode3,addchargeself3,placementno,assignmentslipdate FROM getall WHERE placementno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getplacement.placementno#">
</cfquery>
<cfloop query="getclaimlist" >
<cfif numberformat(evaluate('getplacement.total#getclaimlist.wos_group#claimable'),'.__') neq 0>
<cfset totalclaimedamount = 0>
<cfloop query="getclaimdetail">
<cfif getclaimdetail.addchargecode eq getclaimlist.wos_group and val(getclaimdetail.addchargeself) neq 0>
<cfset totalclaimedamount = totalclaimedamount + val(getclaimdetail.addchargeself)>
</cfif>
<cfif getclaimdetail.addchargecode2 eq getclaimlist.wos_group and val(getclaimdetail.addchargeself2) neq 0>
<cfset totalclaimedamount = totalclaimedamount + val(getclaimdetail.addchargeself2)>
</cfif>
<cfif getclaimdetail.addchargecode3 eq getclaimlist.wos_group and val(getclaimdetail.addchargeself3) neq 0>
<cfset totalclaimedamount = totalclaimedamount + val(getclaimdetail.addchargeself3)>
</cfif>
</cfloop>
<cfset totalclaimedamount = totalclaimedamount + val(evaluate('getplacement.#getclaimlist.wos_group#claimedamt'))>
<tr>
<td>#getclaimlist.wos_group#</td>
<cfif numberformat(evaluate('getplacement.total#getclaimlist.wos_group#claimable'),'.__') eq 0>
<td >0</td>
<cfelse>
<td >#numberformat(evaluate('getplacement.total#getclaimlist.wos_group#claimable'),'.__')#</td>
</cfif>

<td align="right">#numberformat(totalclaimedamount,'.__')#</td>
<cfif numberformat(evaluate('getplacement.total#getclaimlist.wos_group#claimable'),'.__') eq 0>
<th align="right">NA</th>
<cfelse>
<cfset claimbal = numberformat(evaluate('getplacement.total#getclaimlist.wos_group#claimable'),'.__') - numberformat(totalclaimedamount,'.__')>
<td align="right">#numberformat(claimbal,'.__')#</td>
</cfif>
</tr>
</cfif>
</cfloop>
</table>
</td>
</tr>
<tr>
<td>&nbsp;</td>
</tr>
<tr>
<th align="left">Claim Details</th>
</tr>
<tr>
<td colspan="100%">
<table width="100%">
<tr>
<th align="left">Claim Type</th>
<th align="left">Payment Month</th>
<th align="right">Amount</th>
</tr>
<cfloop query="getclaimlist" >
<cfif numberformat(evaluate('getplacement.total#getclaimlist.wos_group#claimable'),'.__') neq 0>
<cfloop query="getclaimdetail">
<cfif getclaimdetail.addchargecode eq getclaimlist.wos_group and val(getclaimdetail.addchargeself) neq 0>
<tr>
<td>#getclaimlist.wos_group#</td>
<td>#dateformat(getclaimdetail.assignmentslipdate,'mmm yyyy')#</td>
<td align="right">#numberformat(val(getclaimdetail.addchargeself),'.__')#</td>
</tr>
</cfif>
<cfif getclaimdetail.addchargecode2 eq getclaimlist.wos_group and val(getclaimdetail.addchargeself2) neq 0>
<tr>
<td>#getclaimlist.wos_group#</td>
<td>#dateformat(getclaimdetail.assignmentslipdate,'mmm yyyy')#</td>
<td align="right">#numberformat(val(getclaimdetail.addchargeself2),'.__')#</td>
</tr>
</cfif>
<cfif getclaimdetail.addchargecode3 eq getclaimlist.wos_group and val(getclaimdetail.addchargeself3) neq 0>
<tr>
<td>#getclaimlist.wos_group#</td>
<td>#dateformat(getclaimdetail.assignmentslipdate,'mmm yyyy')#</td>
<td align="right">#numberformat(val(getclaimdetail.addchargeself3),'.__')#</td>
</tr>
</cfif>
</cfloop>
</cfif>
</cfloop>
</table>
</td>
</tr></table>
<p style="page-break-after:always"></p>
</cfloop>

</cfoutput>
