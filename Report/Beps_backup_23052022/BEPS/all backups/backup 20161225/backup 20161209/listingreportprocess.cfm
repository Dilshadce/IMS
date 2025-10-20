<cfoutput>
<cfinclude template="/object/dateobject.cfm">
<cfinclude template="/object/stringobject.cfm">
<cfquery name="getplacement" datasource="#dts#">
SELECT * FROM placement
WHERE 1 = 1
<cfif form.getfrom neq "" and form.getto neq "">
and custno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.getfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.getto#">
</cfif> 
<cfif form.agentfrom neq "" and form.agentto neq "">
and consultant between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.agentfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.agentto#">
</cfif> 
<cfif form.areafrom neq "" and form.areato neq "">
and location between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.areafrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.areato#">
</cfif> 
</cfquery>
<cfif url.type neq "Sales"> 
<cfquery name="getassignment" datasource="#dts#">
SELECT * FROM (
SELECT * FROM assignmentslip
WHERE 1=1
<cfif form.billfrom neq "" and form.billto neq "">
and refno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billto#">
</cfif> 
<cfif form.datefrom neq "" and form.dateto neq "">
and assignmentslipdate between <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformatnew(form.datefrom,'YYYY-MM-DD')#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformatnew(form.dateto,'YYYY-MM-DD')#">
</cfif> 
<!--- <cfif getplacement.recordcount neq 0> --->
and placementno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#VALUELIST(getplacement.placementno)#" list="yes" separator=",">)
<!--- </cfif> ---> ) as a
LEFT JOIN
(SELECT placementno as pno, location,consultant,custno as cno,custname,empname FROM placement) as b on a.placementno = b.pno
<cfif url.type eq "cheque listing">
where (
claimadd1 = "Y"
or claimadd2 = "Y"
or claimadd3 = "Y"
or claimadd4 = "Y"
or claimadd5 = "Y"
or claimadd6 = "Y")
and (coalesce(addchargeself,0)+coalesce(addchargeself2,0)+coalesce(addchargeself3,0)+coalesce(addchargeself4,0)+coalesce(addchargeself5,0)+coalesce(addchargeself6,0) > 0)
</cfif>
order by <cfif form.orderby eq "date">a.assignmentslipdate<cfelseif form.orderby eq "Empnoname">b.empname<cfelseif form.orderby eq "chequeno">a.chequeno<cfelseif form.orderby eq "refno">a.refno<cfelse>b.custname</cfif>
<cfif form.orderby2 neq "">,
<cfif form.orderby2 eq "date">a.assignmentslipdate<cfelseif form.orderby2 eq "Empnoname">b.empname<cfelseif form.orderby2 eq "chequeno">a.chequeno<cfelseif form.orderby2 eq "refno">a.refno<cfelse>b.custname</cfif>
</cfif>
</cfquery>

<cfelse>
<cfquery name="getassignment" datasource="#dts#">
SELECT * FROM (
SELECT * FROM (
SELECT refno, wos_date as assignmentslipdate, net,tax,grand,name as custname,void,rem30 from artran WHERE 1=1 and type = "INV"
<cfif isdefined('form.voidtrans') eq false>
and (void = "" or void is null)
</cfif>
<cfif form.billfrom neq "" and form.billto neq "">
and refno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billto#">
</cfif> 
<cfif form.datefrom neq "" and form.dateto neq "">
and wos_date between <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformatnew(form.datefrom,'YYYY-MM-DD')#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformatnew(form.dateto,'YYYY-MM-DD')#">
</cfif> 
<cfif form.getfrom neq "" and form.getto neq "">
and custno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.getfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.getto#">
</cfif> 
<cfif form.orderbysales eq "location">ORDER BY refno<cfelse>ORDER BY #form.orderbysales#</cfif>) as a
UNION ALL
SELECT * FROM (
SELECT refno, wos_date as assignmentslipdate, if(type = "CN",net  * -1,net) as net,if(type = "CN",tax * -1,tax) as tax,if(type = "CN",grand * -1,grand) as grand,name as custname,void,rem30 from artran WHERE 1=1 and (type = "CN" or type = "DN")
<cfif form.billfrom neq "" and form.billto neq "">
and refno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billto#">
</cfif> 
<cfif form.datefrom neq "" and form.dateto neq "">
and wos_date between <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformatnew(form.datefrom,'YYYY-MM-DD')#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformatnew(form.dateto,'YYYY-MM-DD')#">
</cfif> 
<cfif form.getfrom neq "" and form.getto neq "">
and custno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.getfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.getto#">
</cfif> 
<cfif form.orderbysales eq "location">ORDER BY refno<cfelse>ORDER BY #form.orderbysales#</cfif>) as b ) as aa
LEFT JOIN
(SELECT refno as asrefno, placementno FROM assignmentslip ) as bb
on aa.refno = bb.asrefno
LEFT JOIN
(SELECT location, placementno as ppno FROM placement) as cc
on bb.placementno = cc.ppno
<cfif form.orderbysales eq "location">ORDER BY cc.location<cfelse>ORDER BY aa.#form.orderbysales#</cfif>
</cfquery>
</cfif>

<cfquery name="getgeneral" datasource="#dts#">
	select lastaccyear,filterall,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION,agentlistuserid,compro from gsetup
</cfquery>

<table align="center" width="90%" style="font-size:12px;">
<tr>
<th colspan="100%"><h1 style="font-size:16px">#url.type# Report</h1></th>
</tr>
<cfif form.billfrom neq "" and form.billto neq "">
<tr>
<th colspan="100%">Assignment From #form.billfrom# To #form.billto#</th>
</tr>
</cfif>
<cfif form.getfrom neq "" and form.getto neq "">
<tr>
<cfquery name="getcustomernamefrom" datasource="#dts#">
SELECT name FROM #target_arcust# WHERE custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.getfrom#">
</cfquery>
<cfquery name="getcustomernameto" datasource="#dts#">
SELECT name FROM #target_arcust# WHERE custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.getto#">
</cfquery>
<th colspan="100%">Customer From #form.getfrom#@#getcustomernamefrom.name# To #form.getto#@#getcustomernameto.name#</th>
</tr>
</cfif>
<cfif form.agentfrom neq "" and form.agentto neq "">
<tr>
<th colspan="100%">For #getgeneral.lAGENT# Code <cfif form.agentfrom eq form.agentto>#form.agentfrom#<cfelse>From #form.agentfrom# To #form.agentto#</cfif></th>
</tr>
</cfif>
<cfif form.areafrom neq "" and form.areato neq "">
<tr>
<th colspan="100%">Location From #form.areafrom# To #form.areato#</th>
</tr>
</cfif>
<cfif form.datefrom neq "" and form.dateto neq "">
<tr>
<th colspan="100%">Date From #form.datefrom# To #form.dateto#</th>
</tr>
</cfif>
<tr>
<td colspan="100%"><div align="left"  style="display:inline"><b>#UCASE(getgeneral.compro)#</b></div><div align="right"><div align="right" style="display:inline"><b>#dateformat(now(),'YYYY-MM-DD')# #timeformat(now(),'HH:MM:SS')#</b></div></div></td>
</tr>
<cfif url.type eq "costing" or url.type eq "CPF listing">
<cfquery name="getpayrollmonth" datasource="#dts#">
SELECT mmonth FROM payroll_main.gsetup WHERE comp_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#replace(dts,'_i','')#">
</cfquery>
<cfquery name="getcurrentmonth" datasource="#dts#">
SELECT GROSSPAY as NETPAY,EPFCC,EMPNO,EPFWW,DED111,DED113,DED114,DED101 FROM #replace(dts,'_i','_p')#.pay_tm WHERE empno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getassignment.empno)#" list="yes" separator=",">) 
</cfquery>
<cfquery name="getcurrentmonthsdl" datasource="#dts#">
SELECT LEVY_SD,EMPNO,levy_fw_w FROM #replace(dts,'_i','_p')#.comm WHERE empno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getassignment.empno)#" list="yes" separator=",">) 
</cfquery>
<cfquery name="getoldmonth" datasource="#dts#">
SELECT GROSSPAY as NETPAY,EPFCC,UPPER(EMPNO) as EMPNO,TMONTH,EPFWW,DED111,DED113,DED114,DED101 FROM #replace(dts,'_i','_p')#.pay_12m WHERE empno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getassignment.empno)#" list="yes" separator=",">) 
</cfquery>
<cfquery name="getoldmonthsdl" datasource="#dts#">
SELECT LEVY_SD,UPPER(EMPNO) as EMPNO,TMONTH,levy_fw_w FROM #replace(dts,'_i','_p')#.comm_12m WHERE empno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getassignment.empno)#" list="yes" separator=",">) 
</cfquery>

</cfif>
<tr>
<td colspan="100%"><hr/></td>
</tr>
<tr>
<cfif url.type neq "Cheque Listing">
<td><b>Ref No</b></td>
</cfif>
<cfif url.type neq "CPF Listing" and url.type neq "Costing">
<td><b>Date</b></td>
</cfif>
<cfif url.type neq "Cheque Listing">
<td><b>Customer</b></td>
</cfif>
<!--- <td><b>#getgeneral.lAGENT#</b></td>
<td><b>Location</b></td>
<td><b>Employee</b></td>
<td><b>Work Period</b></td> --->
<cfif url.type eq "Costing">
<td align="right"><b><u>Billed Amt</u></b></td>
<!--- <td align="right"><b>GST</b></td>
<td align="right"><b>Total</b></td> --->
<td align="right"><b>Cost</b></td>
<td align="right"><b>FWL</b></td>
<td align="right"><b>WI 1%</b></td>
<td align="right"><b>Claim</b></td>
<td align="right"><b><u>All Cost</u></b></td>
<td align="left"><b>Employee</b></td>
<td align="left"><b>IND Consultant</b></td>
<td align="left"><b>Consultant</b></td>
<td align="right"><b>Profit</b></td>
<td align="right"><b>Margin</b></td>

<cfset totalgross = 0>
<cfset totalgst = 0>
<cfset totalbill = 0>
<cfset totalcost = 0>
<cfset totalcost1 = 0>
<cfset totalclaim = 0>
<cfset totalallcost = 0>
<cfset totalprofit = 0>
<cfset totalfwl = 0>
</cfif>
<cfif url.type eq "CPF Listing">
<td><b>#getgeneral.lAGENT#</b></td>
<td><b>Location</b></td>
<td><b>Employee</b></td>
<!--- <td align="right"><b>Total</b></td>
<td align="right"><b>Month Total</b></td>
<td align="right"><b>Month Pay</b></td>
<td align="right"><b>Month CPF'EE</b></td>
<td align="right"><b>Month CPF'ER</b></td> --->
<td align="right"><b>CPF'EE</b></td>
<td align="right"><b>CPF'ER</b></td>
<td align="right"><b>SDF</b></td>
<td align="right"><b>CDAC</b></td>
<td align="right"><b>MBMF</b></td>
<td align="right"><b>SINDA</b></td>
<cfset totalepfww = 0>
<cfset totalepfcc = 0>
<cfset totalsdf = 0>
<cfset totalcdac = 0>
<cfset totalmbmf = 0>
<cfset totalsinda = 0>
</cfif>
<cfif url.type eq "Cheque Listing">
<td align="left"><b>Cheque No.</b></td>
<td align="left"><b>Name of Payee</b></td>
<td align="left"><b>NRIC No.</b></td>
<td align="left"><b>Bank</b></td>
<td align="left"><b>A/C No.</b></td>
<td align="right"><b>Claim Total</b></td>
<td align="center"><b>Refno</b></td>
<td align="left"><b>Customer</b></td>
<cfset totalclaim = 0>
</cfif>
<cfif url.type eq "Sales">
<td align="left"><b>Branch</b></td>
<cfif isdefined('form.voidtrans')><td align="left">Void & Reason</td></cfif>
<td align="right"><b>Gross</b></td>
<td align="right"><b>GST</b></td>
<td align="right"><b>Total</b></td>

<cfset totalgross = 0>
<cfset totalgst = 0>
<cfset totalbill = 0>
</cfif>
<cfif url.type eq "GST">
<td align="right"><b>Gross</b></td>
<td align="right"><b>GST</b></td>
<cfset totalgst = 0>
<cfset totalgross = 0>
</cfif>
</tr>
<tr>
<td colspan="100%"><hr/></td>
</tr>
<cfquery name="getagentlist" datasource="#dts#">
select left(agent,2) as agent from icagent WHERE agent <> "A/C" group by left(agent,2)
</cfquery>
<CFSET ACbillamt = 0>
<CFSET ACcost = 0>
<CFSET ACprofit = 0>
<cfloop query="getagentlist">
<cfset "#getagentlist.agent#billamt" = 0>
<cfset "#getagentlist.agent#cost" = 0>
<cfset "#getagentlist.agent#profit" = 0>
</cfloop>
<cfloop query="getassignment">
<tr>
<cfif url.type neq "Cheque Listing">
<td>#getassignment.refno#</td>
</cfif>
<cfif url.type neq "CPF Listing" and url.type neq "Costing">
<td>#dateformat(getassignment.assignmentslipdate,'YYYY-MM-DD')#</td>
</cfif>
<cfif url.type neq "Cheque Listing">
<td>#truncate(getassignment.custname,'30')#</td>
</cfif>
<!--- <td>#getassignment.consultant#</td>
<td>#getassignment.location#</td>
<td><!--- #getassignment.empno# -  --->#truncate(getassignment.empname,'30')#</td>
<td>#dateformat(getassignment.startdate,'YYYY-MM-DD')# - #dateformat(getassignment.completedate,'YYYY-MM-DD')#</td> --->
<cfif url.type eq "CPF Listing">
<td>#getassignment.consultant#</td>
<td>#getassignment.location#</td>
<td><!--- #getassignment.empno# -  --->#truncate(getassignment.empname,'30')#</td>
</cfif>
<cfif url.type eq "costing" or url.type eq "CPF listing">
<cfset gross = numberformat(val(getassignment.custtotal),'.__') - numberformat(val(getassignment.taxamt),'.__')>
<cfquery name="getcurrenttotal" datasource="#dts#">
SELECT sum(custtotal) as cmtotal FROM assignmentslip WHERE empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.empno#"> and month(assignmentslipdate) = "#val(dateformat(getassignment.assignmentslipdate,'MM'))#"
and year(assignmentslipdate) = "#val(dateformat(getassignment.assignmentslipdate,'yyyy'))#"
</cfquery>
<cfset thiscostrate = 1>
<cfif numberformat(val(getcurrenttotal.cmtotal),'.__') neq numberformat(val(getassignment.custtotal),'.__')>
	<Cfif numberformat(val(getcurrenttotal.cmtotal),'.__') neq 0>
    	<cfset thiscostrate = numberformat(val(getassignment.custtotal),'.__')/numberformat(val(getcurrenttotal.cmtotal),'.__')>
    </Cfif>
</cfif>
<cfquery name="gettotalpay" dbtype="query">
SELECT NETPAY,EPFCC,EPFWW,DED111,DED113,DED114,DED101 FROM <cfif val(dateformat(getassignment.assignmentslipdate,'MM')) eq val(getpayrollmonth.mmonth)>getcurrentmonth<cfelse>getoldmonth</cfif> WHERE EMPNO = <cfqueryparam cfsqltype="cf_sql_varchar" value="#UCASE(getassignment.empno)#"><cfif val(dateformat(getassignment.assignmentslipdate,'MM')) neq val(getpayrollmonth.mmonth)>
 AND TMONTH = <cfqueryparam cfsqltype="cf_sql_integer" value="#val(dateformat(getassignment.assignmentslipdate,'MM'))#">
</cfif>
</cfquery>

<cfquery name="gettotalsdl" dbtype="query">
SELECT LEVY_SD,levy_fw_w FROM <cfif val(dateformat(getassignment.assignmentslipdate,'MM')) eq val(getpayrollmonth.mmonth)>getcurrentmonthsdl<cfelse>getoldmonthsdl</cfif> WHERE EMPNO = <cfqueryparam cfsqltype="cf_sql_varchar" value="#UCASE(getassignment.empno)#"><cfif val(dateformat(getassignment.assignmentslipdate,'MM')) neq val(getpayrollmonth.mmonth)>
 AND TMONTH = <cfqueryparam cfsqltype="cf_sql_integer" value="#val(dateformat(getassignment.assignmentslipdate,'MM'))#">
</cfif>
</cfquery>

<cfif gettotalpay.recordcount eq 0>
<cfset allcost = 0>
<cfset fwlevy = 0>
<cfelse>
<cfset allcost = val(gettotalpay.netpay) + val(gettotalpay.EPFCC)+val(gettotalsdl.levy_sd) - val(gettotalpay.ded101)>
<cfset fwlevy = val(gettotalsdl.levy_fw_w)>
<cfset allcost = numberformat(val(allcost) * val(thiscostrate),'.__')>
</cfif>
<cfset cost = allcost>
<cfset cost1 = val(gettotalpay.netpay) *0.01 * val(thiscostrate)>
<cfset claimtotal = val(getassignment.addchargeself)+val(getassignment.addchargeself2)+val(getassignment.addchargeself3)+val(getassignment.addchargeself4)+val(getassignment.addchargeself5)+val(getassignment.addchargeself6)>
<cfset allcost = cost+ cost1 + claimtotal+numberformat(val(fwlevy),'.__')>
<cfset profit = numberformat(val(gross),'.__') - numberformat(val(allcost),'.__')>
	<cfif numberformat(val(gross),'.__') neq 0>
        <cfset margin = numberformat(val(profit),'.__')/numberformat(val(gross),'.__') * 100>
    <cfelse>
        <cfset margin = 100>
    </cfif>
</cfif>

<cfif url.type eq "Costing">
<cfif mid(getassignment.consultant,3,1) eq "/" and isdefined('form.splitbased')>
<cfset gross = numberformat(val(gross)/2,'.__')>
<cfset cost = numberformat(val(cost)/2,'.__')>
<cfset fwlevy = numberformat(val(fwlevy)/2,'.__')>
<cfset cost1 = numberformat(val(cost1)/2,'.__')>
<cfset claimtotal = numberformat(val(claimtotal) / 2,'.__')>
<cfset allcost = cost+ cost1 + claimtotal+numberformat(val(fwlevy),'.__')>
<cfset profit = numberformat(val(gross),'.__') - numberformat(val(allcost),'.__')>
	<cfif numberformat(val(gross),'.__') neq 0>
        <cfset margin = numberformat(val(profit),'.__')/numberformat(val(gross),'.__') * 100>
    <cfelse>
        <cfset margin = 100>
    </cfif>
<td align="right">#numberformat(val(gross),'.__')#</td>
<!--- <td align="right">#numberformat(val(getassignment.taxamt),'.__')#</td>
<td align="right">#numberformat(val(getassignment.custtotal),'.__')#</td> --->
<td align="right">#numberformat(val(cost),'.__')#</td>
<td align="right">#numberformat(val(fwlevy),'.__')#</td>
<td align="right">#numberformat(val(cost1),'.__')#</td>
<td align="right">#numberformat(val(claimtotal),'.__')#</td>
<td align="right">#numberformat(val(allcost),'.__')#</td>
<td>#truncate(getassignment.empname,'30')#</td>
<td>#listfirst(getassignment.consultant,'/')#</td>
<td>#getassignment.consultant#</td>
<td align="right">#numberformat(val(profit),'.__')#</td>
<td align="right">#numberformat(val(margin),'.__')# %</td>

<cfset totalgross = totalgross + numberformat(val(gross),'.__')>
<cfset totalcost = totalcost + numberformat(val(cost),'.__')>
<cfset totalcost1 = totalcost1 + numberformat(val(cost1),'.__')>
<cfset totalclaim = totalclaim + numberformat(val(claimtotal),'.__')>
<cfset totalallcost = totalallcost + numberformat(val(allcost),'.__')>
<cfset totalprofit = totalprofit + numberformat(val(profit),'.__')>
<cfset totalfwl = totalfwl + numberformat(val(fwlevy),'.__')>
<cfset "#listfirst(getassignment.consultant,'/')#billamt" =  evaluate("#listfirst(getassignment.consultant,'/')#billamt") + numberformat(val(gross),'.__')>
<cfset "#listfirst(getassignment.consultant,'/')#cost" = evaluate("#listfirst(getassignment.consultant,'/')#cost") + numberformat(val(allcost),'.__')>
<cfset "#listfirst(getassignment.consultant,'/')#profit" = evaluate("#listfirst(getassignment.consultant,'/')#profit")  + numberformat(val(profit),'.__')>
</tr><tr><td>#getassignment.refno#</td><td>#truncate(getassignment.custname,'30')#</td>
<td align="right">#numberformat(val(gross),'.__')#</td>
<!--- <td align="right">#numberformat(val(getassignment.taxamt),'.__')#</td>
<td align="right">#numberformat(val(getassignment.custtotal),'.__')#</td> --->
<td align="right">#numberformat(val(cost),'.__')#</td>
<td align="right">#numberformat(val(fwlevy),'.__')#</td>
<td align="right">#numberformat(val(cost1),'.__')#</td>
<td align="right">#numberformat(val(claimtotal),'.__')#</td>
<td align="right">#numberformat(val(allcost),'.__')#</td>
<td>#truncate(getassignment.empname,'30')#</td>
<td>#listlast(getassignment.consultant,'/')#</td>
<td>#getassignment.consultant#</td>
<td align="right">#numberformat(val(profit),'.__')#</td>
<td align="right">#numberformat(val(margin),'.__')# %</td>

<cfset totalgross = totalgross + numberformat(val(gross),'.__')>
<cfset totalcost = totalcost + numberformat(val(cost),'.__')>
<cfset totalcost1 = totalcost1 + numberformat(val(cost1),'.__')>
<cfset totalclaim = totalclaim + numberformat(val(claimtotal),'.__')>
<cfset totalallcost = totalallcost + numberformat(val(allcost),'.__')>
<cfset totalprofit = totalprofit + numberformat(val(profit),'.__')>
<cfset totalfwl = totalfwl + numberformat(val(fwlevy),'.__')>

<cfset "#listlast(getassignment.consultant,'/')#billamt" =  evaluate("#listlast(getassignment.consultant,'/')#billamt") + numberformat(val(gross),'.__')>
<cfset "#listlast(getassignment.consultant,'/')#cost" = evaluate("#listlast(getassignment.consultant,'/')#cost") + numberformat(val(allcost),'.__')>
<cfset "#listlast(getassignment.consultant,'/')#profit" = evaluate("#listlast(getassignment.consultant,'/')#profit")  + numberformat(val(profit),'.__')>
<cfelse>
<td align="right">#numberformat(val(gross),'.__')#</td>
<!--- <td align="right">#numberformat(val(getassignment.taxamt),'.__')#</td>
<td align="right">#numberformat(val(getassignment.custtotal),'.__')#</td> --->
<td align="right">#numberformat(val(cost),'.__')#</td>
<td align="right">#numberformat(val(fwlevy),'.__')#</td>
<td align="right">#numberformat(val(cost1),'.__')#</td>
<td align="right">#numberformat(val(claimtotal),'.__')#</td>
<td align="right">#numberformat(val(allcost),'.__')#</td>
<td>#truncate(getassignment.empname,'30')#</td>
<td></td>
<td>#getassignment.consultant#</td>
<td align="right">#numberformat(val(profit),'.__')#</td>
<td align="right">#numberformat(val(margin),'.__')# %</td>

<cfset totalgross = totalgross + numberformat(val(gross),'.__')>
<cfset totalgst = totalgst + numberformat(val(getassignment.taxamt),'.__')>
<cfset totalbill = totalbill + numberformat(val(getassignment.custtotal),'.__')>
<cfset totalcost = totalcost + numberformat(val(cost),'.__')>
<cfset totalcost1 = totalcost1 + numberformat(val(cost1),'.__')>
<cfset totalclaim = totalclaim + numberformat(val(claimtotal),'.__')>
<cfset totalallcost = totalallcost + numberformat(val(allcost),'.__')>
<cfset totalprofit = totalprofit + numberformat(val(profit),'.__')>
<cfset totalfwl = totalfwl + numberformat(val(fwlevy),'.__')>
<cfif isdefined('form.splitbased')>
<cfif getassignment.consultant  eq "A/C">
<cfset getassignment.consultant = "AC">
</cfif>
<cfset "#listfirst(getassignment.consultant,'/')#billamt" =  evaluate("#getassignment.consultant#billamt") + numberformat(val(gross),'.__')>
<cfset "#listfirst(getassignment.consultant,'/')#cost" = evaluate("#getassignment.consultant#cost") + numberformat(val(allcost),'.__')>
<cfset "#listfirst(getassignment.consultant,'/')#profit" = evaluate("#getassignment.consultant#profit")  + numberformat(val(profit),'.__')>
</cfif>
</cfif>
</cfif>
<cfif url.type eq "CPF Listing">
<td align="right">#numberformat(val(gettotalpay.epfww)*val(thiscostrate),'.__')#</td>
<td align="right">#numberformat(val(gettotalpay.epfcc)*val(thiscostrate),'.__')#</td>
<td align="right">#numberformat(val(gettotalsdl.levy_sd)*val(thiscostrate),'.__')#</td>
<td align="right">#numberformat(val(gettotalpay.ded114)*val(thiscostrate),'.__')#</td>
<td align="right">#numberformat(val(gettotalpay.ded111)*val(thiscostrate),'.__')#</td>
<td align="right">#numberformat(val(gettotalpay.ded113)*val(thiscostrate),'.__')#</td>
<cfset totalepfww = totalepfww + numberformat(val(gettotalpay.epfww)*val(thiscostrate),'.__')>
<cfset totalepfcc = totalepfcc + numberformat(val(gettotalpay.epfcc)*val(thiscostrate),'.__')>
<cfset totalsdf = totalsdf + numberformat(val(gettotalsdl.levy_sd)*val(thiscostrate),'.__')>
<cfset totalcdac = totalcdac + numberformat(val(gettotalpay.ded114)*val(thiscostrate),'.__')>
<cfset totalmbmf = totalmbmf + numberformat(val(gettotalpay.ded111)*val(thiscostrate),'.__')>
<cfset totalsinda = totalsinda + numberformat(val(gettotalpay.ded113)*val(thiscostrate),'.__')>
</cfif>
<cfif url.type eq "Cheque Listing">
<cfquery name="getempdetail" datasource="#replace(dts,'_i','_p')#">
SELECT * FROM pmast WHERE empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.empno#">
</cfquery>
<cfquery name="getbankname" datasource="payroll_main">
SELECT bankcode,bankname FROM bankcode where bankcode = "#getempdetail.bankcode#"
</cfquery>
<td align="left">#getassignment.chequeno#</td>
<td align="left">#getassignment.empname#</td>
<td align="left">#getempdetail.nric#</td>
<td align="left">#getbankname.bankname#</td>
<td align="left">#getempdetail.bankaccno#</td>
<td align="right"><cfset claimtotal = val(getassignment.addchargeself)+val(getassignment.addchargeself2)+val(getassignment.addchargeself3)+val(getassignment.addchargeself4)+val(getassignment.addchargeself5)+val(getassignment.addchargeself6)>#numberformat(val(claimtotal),'.__')#</td>
<cfset totalclaim = totalclaim + numberformat(val(claimtotal),'.__')>
<td align="center">#getassignment.refno#</td>
<td>#truncate(getassignment.custname,10)#</td>
</cfif>
<cfif url.type eq "Sales">
<td align="left">#getassignment.location#</td>
<cfif isdefined('form.voidtrans')><td align="left">#getassignment.void#<cfif getassignment.void neq ""> #getassignment.rem30#</cfif></td></cfif>
<cfif getassignment.void eq ""><td align="right">#numberformat(val(getassignment.net),'.__')#</td>
<td align="right">#numberformat(val(getassignment.tax),'.__')#</td>
<td align="right">#numberformat(val(getassignment.grand),'.__')#</td>

<cfset totalgross = totalgross + numberformat(val(getassignment.net),'.__')>
<cfset totalgst = totalgst + numberformat(val(getassignment.tax),'.__')>
<cfset totalbill = totalbill + numberformat(val(getassignment.grand),'.__')>
<cfelse>
<td align="right">0.00</td>
<td align="right">0.00</td>
<td align="right">0.00</td>
</cfif>
</cfif>
<cfif url.type eq "GST">
<cfset gross = numberformat(val(getassignment.custtotal),'.__') - numberformat(val(getassignment.taxamt),'.__')>
<td align="right">#numberformat(val(gross),'.__')#</td>
<td align="right">#numberformat(val(getassignment.taxamt),'.__')#</td>
<cfset totalgst = totalgst + numberformat(val(getassignment.taxamt),'.__')>
<cfset totalgross = totalgross + numberformat(val(gross),'.__')>
</tr></cfif>

</cfloop>

<tr>
<td colspan="100%"><hr/></td>
</tr>
<tr>
<td align="right" colspan="<cfif url.type eq "CPF Listing">5<cfelseif url.type eq "Costing">2<cfelseif url.type eq "Cheque Listing">6<cfelse>3</cfif>">
Total Record Count: #getassignment.recordcount#
</td>
<cfif url.type eq "costing">
<th align="right">#numberformat(val(totalgross),'.__')#</th>
<!--- <th align="right">#numberformat(val(totalgst),'.__')#</th>
<th align="right">#numberformat(val(totalbill),'.__')#</th> --->
<th align="right">#numberformat(val(totalcost),'.__')#</th>
<th align="right">#numberformat(val(totalfwl),'.__')#</th>
<th align="right">#numberformat(val(totalcost1),'.__')#</th>
<th align="right">#numberformat(val(totalclaim),'.__')#</th>
<th align="right">#numberformat(val(totalallcost),'.__')#</th>
<th></th>
<th></th>
<th></th>
<th align="right">#numberformat(val(totalprofit),'.__')#</th>
<cfif val(totalgross) eq 0>
<cfset totalgross = 1>
</cfif>
<cfset totalmargin = numberformat(val(totalprofit),'.__')/numberformat(val(totalgross),'.__') * 100>
<th align="right">#numberformat(val(totalmargin),'.__')#%</th>

</cfif>
<cfif url.type eq "CPF Listing">
<th align="right">#numberformat(val(totalepfww),'.__')#</th>
<th align="right">#numberformat(val(totalepfcc),'.__')#</th>
<td align="right">#numberformat(val(totalsdf),'.__')#</td>
<td align="right">#numberformat(val(totalcdac),'.__')#</td>
<td align="right">#numberformat(val(totalmbmf),'.__')#</td>
<td align="right">#numberformat(val(totalsinda),'.__')#</td>
</cfif>
<cfif url.type eq "Cheque Listing">
<th align="right">#numberformat(val(totalclaim),'.__')#</th>
<td></td>
<td></td>
</cfif>
<cfif url.type eq "Sales">
<td></td>
<th align="right">#numberformat(val(totalgross),'.__')#</th>
<th align="right">#numberformat(val(totalgst),'.__')#</th>
<th align="right">#numberformat(val(totalbill),'.__')#</th>
</cfif>
<cfif url.type eq "GST">
<th align="right">#numberformat(val(totalgross),'.__')#</th>
<th align="right">#numberformat(val(totalgst),'.__')#</th>
</cfif>
</tr>


</table>
<br />
<br />
<br />

<cfif url.type eq "Costing" and isdefined('form.splitbased')>
<cfset totalbill = 0 >
<cfset totalcost = 0 >
<cfset totalprofit = 0 >
<table align="center" width="40%">
<tr>
<th>Consultant</th>
<th>Total Bill Amount</th>
<th>Total Cost</th>
<th>Total Profit</th>
</tr>
<tr>
<td>A/C</td>
<td>#ACbillamt#</td>
<td>#ACcost#</td>
<td>#ACprofit#</td>
</tr>
<cfset totalbill = totalbill + ACbillamt >
<cfset totalcost = totalcost + ACcost >
<cfset totalprofit = totalprofit + ACprofit >
<cfloop query="getagentlist">
<tr>
<td>#getagentlist.agent#</td>
<td>#evaluate("#getagentlist.agent#billamt")#</td>
<td>#evaluate("#getagentlist.agent#cost")#</td>
<td>#evaluate("#getagentlist.agent#profit")#</td>
</tr>
<cfset totalbill = totalbill + evaluate("#getagentlist.agent#billamt")>
<cfset totalcost = totalcost +evaluate("#getagentlist.agent#cost") >
<cfset totalprofit = totalprofit + evaluate("#getagentlist.agent#profit") >
</cfloop>
<tr>
<td></td>
<td>#numberformat(totalbill,',.__')#</td>
<td>#numberformat(totalcost,',.__')#</td>
<td>#numberformat(totalprofit,',.__')#</td>
</tr>
</table>
</cfif>

</cfoutput>