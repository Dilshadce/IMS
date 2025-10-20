<html>
<head>
<title>Voucher Usage Report</title>
</head>
<cfquery name="getusage" datasource="#dts#">
SELECT * FROM voucher WHERE voucherno in (
SELECT voucherno FROM vouchertran 
WHERE 1=1

<cfif form.custfrom neq "" and form.custto neq "">
and custno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custto#">
</cfif>
<cfif form.voucherto neq "" and form.voucherfrom neq "">
and voucherno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.voucherfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.voucherto#">
</cfif>
<cfif form.datefrom neq "" and form.dateto neq "">
<cfset ndate = createdate(right(form.datefrom,4),mid(form.datefrom,4,2),left(form.datefrom,2))>
<cfset ndate1 = createdate(right(form.dateto,4),mid(form.dateto,4,2),left(form.dateto,2))>
and wos_date between "#dateformat(ndate,'YYYY-MM-DD')#" and "#dateformat(ndate1,'YYYY-MM-DD')#"
</cfif>
group by voucherno
) 
order by voucherno
</cfquery>
<cfoutput>
<table width="80%">
<tr>
<th colspan="100%">Voucher Usage Listing</th>
</tr>
<cfif form.custfrom neq "" and form.custto neq "">
<tr>
<td align="center" colspan="100%">Customer From #form.custfrom# To #form.custto#</td>
</tr>
</cfif>
<cfif form.voucherto neq "" and form.voucherfrom neq "">
<tr>
<td align="center" colspan="100%">Voucher From #form.voucherfrom# To #form.voucherto#</td>
</tr>
</cfif>
<cfif form.datefrom neq "" and form.dateto neq "">
<tr>
<td align="center" colspan="100%">Date From #form.datefrom # To #form.dateto#</td>
</tr>
</cfif>
<tr>
<td></td>
</tr>
<tr>
<td colspan="100%"><hr /></td>
</tr>
<tr>
<th align="left">Voucher No</th>
<th align="left">Date</th>
<th align="left">Transaction</th>
<th align="right">Value</th>
<th align="right">Balance</th>
</tr>
<tr>
<td colspan="100%"><hr/></td>
</tr>
<cfloop query="getusage">
<tr>
<td><b>#getusage.voucherno#</b></td>
<td>#dateformat(getusage.created_on,"YYYY-MM-DD")#</td>
<td>Created With <cfif getusage.invoiceno neq "">INV-#getusage.invoiceno#<cfelse>Voucher Profile</cfif></td>
<td align="right">#numberformat(getusage.value,',.__')#</td>
<td align="right">#numberformat(getusage.value,',.__')#</td>
<cfset balance=getusage.value>
</tr>
<cfquery name="getvouchertran" datasource="#dts#">
SELECT * FROM vouchertran WHERE voucherno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getusage.voucherno#">
<cfif lcase(hcomid) eq "dental_i" or lcase(hcomid) eq "dental10_i" or lcase(hcomid) eq "mfss_i" or lcase(hcomid) eq "hcss_i" or lcase(hcomid) eq "mfssmy_i">
and type ='DO'
</cfif>
</cfquery>
<cfloop query="getvouchertran">
<tr>
<td></td>
<td>#dateformat(getvouchertran.wos_date,'YYYY-MM-DD')#</td>
<td>#getvouchertran.type#-#getvouchertran.refno#</td>
<td align="right">#numberformat(val(getvouchertran.usagevalue) * -1,',.__')#</td>
<cfset balance = balance - val(getvouchertran.usagevalue)>
<td align="right">#numberformat(val(balance),',.__')#</td>
</tr>
</cfloop>
<tr>
<td colspan="100%"><hr /></td>
</tr>
</cfloop>
</table>
</cfoutput>
</html>
