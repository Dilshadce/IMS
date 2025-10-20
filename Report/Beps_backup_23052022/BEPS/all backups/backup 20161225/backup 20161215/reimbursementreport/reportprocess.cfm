
<cfoutput>
<cfset datestart = createdate(listlast(form.datefrom,'/'),listgetat(form.datefrom,'2','/'),listfirst(form.datefrom,'/'))>
  <cfset dateend = createdate(listlast(form.dateto,'/'),listgetat(form.dateto,'2','/'),listfirst(form.dateto,'/'))>
  
<cfquery name="getclaimlist" datasource="#dts#">
	SELECT wos_group,desp FROM icgroup ORDER BY wos_group
</cfquery>

<cfquery name="getassign" datasource="#dts#">
SELECT * FROM (
SELECT * FROM assignmentslip
WHERE
((addchargeself <> 0 and addchargeself <> '') or (addchargeself2 <> 0 and addchargeself2 <> '')  or (addchargeself3 <> 0 and addchargeself3 <> ''))
and assignmentslipdate BETWEEN "#dateformat(datestart,'yyyy-mm-dd')#" and "#dateformat(dateend,'yyyy-mm-dd')#"
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
</cfif> ) as  a
LEFT JOIN
(
SELECT location, placementno as pno FROM placement
) as b
on a.placementno = b.pno
ORDER BY location 
</cfquery>

<cfset dts2=replace(dts,'_i','','all')>

<cfquery name="getmonth" datasource="payroll_main">
SELECT myear,mmonth FROM gsetup WHERE comp_id = "#dts2#"
</cfquery> 
<cfif getmonth.mmonth eq "13">
    <cfset getmonth.mmonth = "12">
	</cfif>
<cfset currentmonth = val(getmonth.mmonth)>
<cfset dts3=replace(dts,'_i','_p','all')>
<cfquery name="getcurrentmonthpaytra1" datasource="#dts3#">
SELECT cheque_no,empno FROM paytra1 WHERE empno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getassign.empno)#" separator="," list="yes">)
</cfquery>

<cfquery name="getcurrentmonthpaytran" datasource="#dts3#">
SELECT cheque_no,empno FROM paytran WHERE empno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getassign.empno)#" separator="," list="yes">)
</cfquery>


<cfquery name="getoldmonthpaytra1" datasource="#dts3#">
SELECT cheque_no,empno,tmonth FROM pay1_12m_fig WHERE empno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getassign.empno)#" separator="," list="yes">)
</cfquery>

<cfquery name="getoldmonthpaytran" datasource="#dts3#">
SELECT cheque_no,empno,tmonth FROM pay2_12m_fig WHERE empno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getassign.empno)#" separator="," list="yes">)
</cfquery>
    

<h3>Reimbursement Report</h3>
<table>
<tr>
<th>Branch</th>
<th>CHQ No</th>
<th>Invoice No</th>
<th>Emp Name</th>
<th align="right">Amount</th>
<cfloop query="getclaimlist">
<cfset "totalrow#getclaimlist.currentrow#" = 0>
<th align="right" width="150px">#replacenocase(getclaimlist.desp,'(to describe)','')#</th>
</cfloop>
</tr>

<cfset newrow = getassign.location>
<cfset totalrowamount = 0>
<cfloop query="getassign">
<cfif getassign.location neq newrow>

<tr>
<td colspan="100%"><hr /></td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td><b>Total for #newrow#</b></td>
<td align="right">#numberformat(totalrowamount,'.__')#</td>
<cfloop query="getclaimlist">
<td align="right">#numberformat(val(evaluate("totalrow#getclaimlist.currentrow#")),'.__')#</td>
<cfset "totalrow#getclaimlist.currentrow#" = 0>
<cfset newrow = getassign.location>
</cfloop>
</tr>
<tr>
<td colspan="100%"><hr /></td>
</tr>
<tr>
<td colspan="100%"></td>
</tr>
<cfset totalrowamount = 0>
</cfif>
<tr>
<td>#getassign.location#</td>
<cfif dateformat(getassign.assignmentslipdate,'m') eq currentmonth>
<cfquery name="getcheqno" dbtype="query">
SELECT cheque_no FROM getcurrentmonth#getassign.paydate# WHERE UPPER(empno) = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ucase(getassign.empno)#"> 
</cfquery>
<cfelse>
<cfquery name="getcheqno" dbtype="query">
SELECT cheque_no FROM getoldmonth#getassign.paydate# WHERE UPPER(empno) = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ucase(getassign.empno)#">
AND tmonth = <cfqueryparam cfsqltype="cf_sql_integer" value="#val(dateformat(getassign.assignmentslipdate,'m'))#">
</cfquery>
</cfif>
<td>#getcheqno.cheque_no#</td>
<td>#getassign.refno#</td>
<td>#getassign.empname#</td>
<cfset rowamount = val(getassign.addchargeself) + val(getassign.addchargeself2) +val(getassign.addchargeself3)>
<cfset totalrowamount = totalrowamount + numberformat(rowamount,'.__')>
<td align="right">#numberformat(rowamount,'.__')#</td>
<cfloop query="getclaimlist">
<cfset nowamount = 0>
<cfif getassign.addchargecode eq getclaimlist.wos_group and val(getassign.addchargeself) neq 0>
<cfset nowamount = nowamount + val(getassign.addchargeself)>
</cfif>
<cfif getassign.addchargecode2 eq getclaimlist.wos_group and val(getassign.addchargeself2) neq 0>
<cfset nowamount = nowamount + val(getassign.addchargeself2)>
</cfif>
<cfif getassign.addchargecode3 eq getclaimlist.wos_group and val(getassign.addchargeself3) neq 0>
<cfset nowamount = nowamount + val(getassign.addchargeself3)>
</cfif>
<td align="right">
#numberformat(nowamount,'.__')#
</td>
<cfset "totalrow#getclaimlist.currentrow#" = val(evaluate("totalrow#getclaimlist.currentrow#")) + numberformat(nowamount,'.__')>
</cfloop>
</tr>

<cfif getassign.currentrow eq getassign.recordcount>
<tr>
<td colspan="100%"><hr /></td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td><b>Total for #newrow#</b></td>
<td align="right">#numberformat(totalrowamount,'.__')#</td>
<cfloop query="getclaimlist">
<td align="right">#numberformat(val(evaluate("totalrow#getclaimlist.currentrow#")),'.__')#</td>
<cfset "totalrow#getclaimlist.currentrow#" = 0>
</cfloop>
</tr>
<tr>
<td colspan="100%"><hr /></td>
</tr>
<cfset totalrowamount = 0>
</cfif>
</cfloop>
</table>
</cfoutput>
