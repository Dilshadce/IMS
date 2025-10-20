<cfoutput>
<h1>Existed in Weekly Pay but Not Existed at Assignment</h1>
<cfinclude template="/object/dateobject.cfm">
<table border="1">
<tr>
<th>Employee No</th>
<th>Payweek</th>
<th>Placement No</th>
<th>Calculated By</th>
<th>Calculated On</th>
</tr>
<cfset dts2=replace(dts,'_i','','all')>
 <cfquery name="getmonth" datasource="payroll_main">
  SELECT myear,mmonth FROM gsetup WHERE comp_id = "#dts2#"
 </cfquery>


<cfloop from="1" to="6" index="i">

<cfquery name="getlistemployee" datasource="#dts#">
select empno from assignmentslip where assignmentslipdate between <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformatnew(form.datefrom,'YYYY-MM-DD')#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformatnew(form.dateto,'YYYY-MM-DD')#"> and emppaymenttype = "payweek#i#"
</cfquery>

<cfquery name="checkwrongpaydate" datasource="#dts#">
select * from #replace(dts,'_i','_p')#.payweek#i# where payyes = "Y" and empno not in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getlistemployee.empno)#" list="yes" separator=",">)
</cfquery>

<cfif checkwrongpaydate.recordcount neq 0>
<cfloop query="checkwrongpaydate">
<tr>
<td>#checkwrongpaydate.empno#</td>
<td>Payweek#i#</td>
<cfquery name="getdata" datasource="#dts#">
SELECT * FROM calpayat WHERE empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#checkwrongpaydate.empno#"> and payweek = "payweek#i#" ORDER BY cal_on DESC
</cfquery>
<cfif getdata.recordcount neq 0>
<td>#getdata.placementno#</td>
<td>#getdata.cal_by#</td>
<td>#dateformat(getdata.cal_on,'dd/mm/yyyy')# #timeformat(getdata.cal_on,'HH:MM:SS')#</td>
<cfelse>
<td></td>
<td></td>
<td></td>
</cfif>
</tr>
</cfloop>
</cfif>
</cfloop>
</table>

<h1>Existed in Assignment but Not Existed at Weekly Pay</h1>

<table border="1">
<tr>
<th>Employee No</th>
<th>Payweek</th>
<th>Assignment No</th>
<th>User ID</th>
</tr>
<cfloop from="1" to="6" index="i">


<cfquery name="checkwrongpaydate" datasource="#dts#">
select empno from #replace(dts,'_i','_p')#.payweek#i# where payyes = "Y"
</cfquery>

<cfquery name="getlistemployee" datasource="#dts#">
select empno,refno,created_by from assignmentslip where 
assignmentslipdate between <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformatnew(form.datefrom,'YYYY-MM-DD')#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformatnew(form.dateto,'YYYY-MM-DD')#"> 
and emppaymenttype = "payweek#i#" 
and empno not in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(checkwrongpaydate.empno)#" list="yes" separator=",">)
</cfquery>


<cfif getlistemployee.recordcount neq 0>
<cfloop query="getlistemployee">
<tr>
<td>#getlistemployee.empno#</td>
<td>Payweek#i#</td>
<td>#getlistemployee.refno#</td>
<td>#getlistemployee.created_by#</td>
</tr>
</cfloop>
</cfif>
</cfloop>
</table>

<h1>Existed in Normal Pay but Not Existed at Assignment</h1>

<table border="1">
<tr>
<th>Employee No</th>
<th>Payday</th>
<th>Placement No</th>
<th>Calculated By</th>
<th>Calculated On</th>
</tr>
<cfloop list="paytra1,paytran" index="i">

<cfquery name="getlistemployee" datasource="#dts#">
select empno from assignmentslip where assignmentslipdate between <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformatnew(form.datefrom,'YYYY-MM-DD')#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformatnew(form.dateto,'YYYY-MM-DD')#"> and paydate = "#i#"
</cfquery>

<cfquery name="checkwrongpaydate" datasource="#dts#">
select * from #replace(dts,'_i','_p')#.#i# where payyes = "Y" and empno not in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getlistemployee.empno)#" list="yes" separator=",">) and netpay is not null and netpay <> 0
</cfquery>

<cfif checkwrongpaydate.recordcount neq 0>
<cfloop  query="checkwrongpaydate">
<tr>
<td>#checkwrongpaydate.empno#</td>
<td><cfif i eq "paytra1">1st Half<cfelse>2nd Half</cfif></td>
<cfquery name="getdata" datasource="#dts#">
SELECT * FROM calpayat WHERE empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#checkwrongpaydate.empno#"> and paydate = "#i#" ORDER BY cal_on DESC
</cfquery>
<cfif getdata.recordcount neq 0>
<td>#getdata.placementno#</td>
<td>#getdata.cal_by#</td>
<td>#dateformat(getdata.cal_on,'dd/mm/yyyy')# #timeformat(getdata.cal_on,'HH:MM:SS')#</td>
<cfelse>
<td></td>
<td></td>
<td></td>
</cfif>
</tr>
</cfloop>
</cfif>
</cfloop>
</table>

<h1>Existed in Assignment but Not Existed at Normal Pay</h1>

<table border="1">
<tr>
<th>Employee No</th>
<th>Payday</th>
<th>Assignment No</th>
<th>User ID</th>
</tr>
<cfloop list="paytra1,paytran" index="i">


<cfquery name="checkwrongpaydate" datasource="#dts#">
select empno from #replace(dts,'_i','_p')#.#i# where payyes = "Y" and netpay is not null and netpay <> 0
</cfquery>

<cfquery name="getlistemployee" datasource="#dts#">
select empno,refno,created_by from assignmentslip where 
assignmentslipdate between <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformatnew(form.datefrom,'YYYY-MM-DD')#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformatnew(form.dateto,'YYYY-MM-DD')#"> 
and paydate = "#i#"
and empno not in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(checkwrongpaydate.empno)#" list="yes" separator=",">)
</cfquery>


<cfif getlistemployee.recordcount neq 0>
<cfloop query="getlistemployee">
<tr>
<td>#getlistemployee.empno#</td>
<td><cfif i eq "paytra1">1st Half<cfelse>2nd Half</cfif></td>
<td>#getlistemployee.refno#</td>
<td>#getlistemployee.created_by#</td>
</tr>
</cfloop>
</cfif>
</cfloop>
</table>

<h1>Appear in total pay but not appear in assignment</h1>
(Please go to payroll > House keeping > Pay data reorgranise)
<table border="1">
<tr>
<th>Employee No</th>
<th>Placement No</th>
<th>Calculated By</th>
<th>Calculated On</th>
</tr>

<cfquery name="getlistemployee" datasource="#dts#">
select empno,refno from assignmentslip where 
assignmentslipdate between <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformatnew(form.datefrom,'YYYY-MM-DD')#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformatnew(form.dateto,'YYYY-MM-DD')#"> 
</cfquery>

<cfquery name="checkwrongpaydatenew" datasource="#dts#">
select empno from #replace(dts,'_i','_p')#.pay_tm where payyes = "Y" and netpay is not null and netpay <> 0 and empno not in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getlistemployee.empno)#" list="yes" separator=",">)
</cfquery>



<cfif checkwrongpaydatenew.recordcount neq 0>
<cfloop query="checkwrongpaydatenew">
<tr>
<td>#checkwrongpaydatenew.empno#</td>
<cfquery name="getdata" datasource="#dts#">
SELECT * FROM calpayat WHERE empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#checkwrongpaydatenew.empno#"> ORDER BY cal_on DESC
</cfquery>
<cfif getdata.recordcount neq 0>
<td>#getdata.placementno#</td>
<td>#getdata.cal_by#</td>
<td>#dateformat(getdata.cal_on,'dd/mm/yyyy')# #timeformat(getdata.cal_on,'HH:MM:SS')#</td>
<cfelse>
<td></td>
<td></td>
<td></td>
</cfif>
</tr>
</cfloop>
</cfif>


</table>

<h1>EMPLOYEE PAY IN ASSIGNMENT NOT TALLY WITH PAYROLL (CURRENT PAYROLL MONTH ONLY)</h1>
<table border="1">
<tr>
<th>Assignment No</th>
<th>Employee No</th>
<th>Payweek</th>
<th>User ID</th>
</tr>
<cfloop from="1" to="6" index="i">

<cfquery name="getall1" datasource="#dts#">
SELECT * FROM (select grosspay,empno from #replace(dts,'_i','_p')#.payweek#i#  where payyes = "Y" and paydate = "paytra1" ) as a
left join
(select refno,selfsalary + selfottotal+selfallowance+selfpayback+selfexception + coalesce(SELFPHNLSALARY,0)  + coalesce(selfpbaws,0) as gp,empno as bempno,NPL,created_by,created_on,updated_by,updated_on from assignmentslip
where month(assignmentslipdate) = "#getmonth.mmonth#" and year(assignmentslipdate) = "#getmonth.myear#"
and paydate = "paytra1" and emppaymenttype = "payweek#i#") as b
on a.empno = b.bempno
WHERE a.grosspay <> b.gp
</cfquery>

<cfif getall1.recordcount neq 0>
<cfloop query="getall1">
<tr>
<td>#getall1.refno#</td>
<td>#getall1.empno#</td>
<td>payweek#i#</td>
<td>#getall1.created_by#</td>
</tr>
</cfloop>
</cfif>

<cfquery name="getall2" datasource="#dts#">
SELECT * FROM (select grosspay,empno from #replace(dts,'_i','_p')#.payweek#i#  where payyes = "Y" and paydate = "paytran" ) as a
left join
(select refno,selfsalary + selfottotal+selfallowance+selfpayback+selfexception + coalesce(SELFPHNLSALARY,0)  + coalesce(selfpbaws,0) as gp,empno as bempno,NPL,created_by,created_on,updated_by,updated_on from assignmentslip
where month(assignmentslipdate) = "#getmonth.mmonth#" and year(assignmentslipdate) = "#getmonth.myear#"
and paydate = "paytran" and emppaymenttype = "payweek#i#") as b
on a.empno = b.bempno
WHERE a.grosspay <> b.gp
</cfquery>
<cfif getall1.recordcount neq 0>
<cfloop query="getall2">
<tr>
<td>#getall2.refno#</td>
<td>#getall2.empno#</td>
<td>payweek#i#</td>
<td>#getall2.created_by#</td>
</tr>
</cfloop>
</cfif>

</cfloop>
</table>
</cfoutput>