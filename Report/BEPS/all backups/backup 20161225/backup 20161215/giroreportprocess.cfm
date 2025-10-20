<cfoutput>
<cfinclude template="/object/dateobject.cfm">
<cfinclude template="/object/stringobject.cfm">
<cfquery name="getpayroll" datasource="#dts#">
SELECT mmonth,myear FROM payroll_main.gsetup WHERE comp_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#replace(dts,'_i','')#">
</cfquery>
<cfset payrollmonth = getpayroll.mmonth>
<cfset payrollyear = getpayroll.myear>

<cfif payrollmonth eq form.month>
<cfquery name="paytra1" datasource="#replace(dts,'_i','_p')#">
SELECT * FROM PAYTRA1
</cfquery>
<cfquery name="paytran" datasource="#replace(dts,'_i','_p')#">
SELECT * FROM PAYTRAN
</cfquery>
<cfset paytra1tbl = "paytra1">
<cfset paytrantbl = "paytran">
<cfelse>
<cfquery name="paytra1" datasource="#replace(dts,'_i','_p')#">
SELECT * FROM pay1_12m_fig WHERE tmonth = "#form.month#"
</cfquery>
<cfquery name="paytran" datasource="#replace(dts,'_i','_p')#">
SELECT * FROM pay2_12m_fig WHERE tmonth = "#form.month#"
</cfquery>
<cfset paytra1tbl = "pay1_12m_fig">
<cfset paytrantbl = "pay2_12m_fig">
</cfif>

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

<cfquery name="getgeneral" datasource="#dts#">
	select lastaccyear,filterall,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION,agentlistuserid,compro from gsetup
</cfquery>

<table>
<tr>
<th colspan="100%" align="left"><font style="font-size:20px"><b>Giro Control Report</b></font></th>
</tr>
<tr>
<th colspan="100%" align="left">
#getgeneral.compro#
</th>
</tr>
<tr>
<th colspan="100%" align="left">
For Pay Period: #dateformat(createdate('#payrollyear#','#form.month#','1'),'mmmm yyyy')#
</th>
</tr>
<cfif form.batch neq "">
<tr>
<th colspan="100%" align="left">
Batch : #form.batch#
</th>
</tr>
</cfif>
<tr>
<td><br>
<br>
</td>
</tr>
</table>
<table border="1">
<tr>
<th align="left">Invoice No</th>
<th align="left">Cust ID</th>
<th align="left">Customer</th>
<th align="left">Invoice Amt<br>
(w/o GST)</th>
<th align="left">GST</th>
<th align="left">Total Amt</th>
<th align="left">Cheque No</th>
<th align="left">MA</th>
<th align="left">Employee No</th>
<th align="left">Employee</th>
<th align="left">Gross Pay</th>
<th align="left">Reimb</th>
<th align="left">EE CPF</th>
<th align="left">FUND DD</th>
<th align="left">NET PAY</th>
<th align="left">ER CPF</th>
<th align="left">Invoice less Payroll</th>
</tr>
<cfquery name="getassignment" datasource="#dts#">
SELECT * FROM (
SELECT aa.*,if(claimadd1 = 'Y',coalesce(addchargeself,0),0)+if(claimadd2 = 'Y',coalesce(addchargeself2,0),0)+if(claimadd3 = 'Y',coalesce(addchargeself3,0),0)+if(claimadd4 = 'Y',coalesce(addchargeself4,0),0)+if(claimadd5 = 'Y',coalesce(addchargeself5,0),0)+if(claimadd6 = 'Y',coalesce(addchargeself6,0),0) as totalamt FROM assignmentslip aa
WHERE month(assignmentslipdate) = "#form.month#"
and year(assignmentslipdate) = "#payrollyear#"
<cfif form.billfrom neq "" and form.billto neq "">
and refno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billto#">
</cfif> 
<cfif form.batch neq "">
and batches = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.batch#">
</cfif>
<!--- <cfif getplacement.recordcount neq 0> --->
and placementno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#VALUELIST(getplacement.placementno)#" list="yes" separator=",">)
<!--- </cfif> ---> ) as a
LEFT JOIN
(SELECT placementno as pno, location,consultant,custno as cno,custname,empname FROM placement) as b on a.placementno = b.pno
order by #form.orderby#
</cfquery>
<cfset totalcustnet = 0>
<cfset totalgst = 0>
<cfset totaltotal = 0>
<cfset totalgrosspay = 0>
<cfset totalreimb = 0>
<cfset totalepfww = 0>
<cfset totalnetpay = 0>
<cfset totalepfcc = 0>
<cfset totalinvoiceless = 0>
<cfset ma1list = "">
<cfset ma2list = "">
<cfloop query="getassignment">
<tr>
<td>#getassignment.refno#</td>
<td>#getassignment.custno#</td>
<td>#getassignment.custname#</td>
<td>#numberformat(val(getassignment.custnet),',.__')#</td>
<cfset totalcustnet = totalcustnet + numberformat(val(getassignment.custnet),'.__') >
<td>#numberformat(val(getassignment.taxamt),',.__')#</td>
<cfset totalgst = totalgst + numberformat(val(getassignment.taxamt),'.__')>
<td>#numberformat(val(getassignment.custtotal),',.__')#</td>
<cfset totaltotal = totaltotal + numberformat(val(getassignment.custtotal),'.__')>
<cfquery name="getpayroll" dbtype="query">
SELECT * FROM #getassignment.paydate#
WHERE EMPNO = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.empno#">
</cfquery>
<td>#getpayroll.cheque_no#</td>
<cfquery name="checkma" datasource="#dts#">
SELECT empno FROM assignmentslip WHERE empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.empno#"> and month(assignmentslipdate) = "#form.month#"
and year(assignmentslipdate) = "#payrollyear#"
and paydate = "#getassignment.paydate#"
</cfquery>
<cfif getassignment.paydate eq "paytra1">
<cfif listfind(ma1list,#getassignment.empno#) neq 0>
<cfset getpayroll.grosspay = 0>
<cfset getpayroll.epfww = 0>
<cfset getpayroll.tded = 0>
<cfset getpayroll.epfcc = 0>
<cfset getpayroll.netpay = 0>
</cfif>
<cfelse>
<cfif listfind(ma2list,#getassignment.empno#) neq 0>
<cfset getpayroll.grosspay = 0>
<cfset getpayroll.epfww = 0>
<cfset getpayroll.tded = 0>
<cfset getpayroll.epfcc = 0>
<cfset getpayroll.netpay = 0>
</cfif>
</cfif>
<cfif checkma.recordcount neq 1>
<cfset ma = "Y">
<cfif getassignment.paydate eq "paytra1">
<cfset ma1list = ma1list&trim(getassignment.empno)&",">
<cfelse>
<cfset ma2list = ma2list&trim(getassignment.empno)&",">
</cfif>
<cfelse>
<cfset ma = "">
</cfif>
<td>#ma#</td>
<td>#getassignment.empno#</td>
<td>#getassignment.empname#</td>
<td>#numberformat(val(getpayroll.grosspay),',.__')#</td>
<cfset totalgrosspay = totalgrosspay + numberformat(val(getpayroll.grosspay),'.__')>
<td>#numberformat(val(getassignment.totalamt),',.__')#</td>
<cfset totalreimb = totalreimb + numberformat(val(getassignment.totalamt),'.__')>
<td>#numberformat(val(getpayroll.epfww),',.__')#</td>
<cfset totalepfww = totalepfww + numberformat(val(getpayroll.epfww),'.__')>
<td>#numberformat(val(getpayroll.tded),',.__')#</td>
<td>#numberformat(val(getpayroll.netpay)+numberformat(val(getassignment.totalamt),'.__'),',.__')#</td>
<cfset totalnetpay = totalnetpay + numberformat(val(getpayroll.netpay)+numberformat(val(getassignment.totalamt),'.__'),'.__')>
<td>#numberformat(val(getpayroll.epfcc),',.__')#</td>
<cfset totalepfcc = totalepfcc + numberformat(val(getpayroll.epfcc),'.__')>
<td>
<cfset invlesspay = numberformat(val(getassignment.custnet),'.__') - numberformat(val(getpayroll.grosspay),'.__')- numberformat(val(getassignment.totalamt),'.__')>
#numberformat(invlesspay,',.__')#
<cfset totalinvoiceless = totalinvoiceless + numberformat(invlesspay,'.__')>
</td>
</tr>
</cfloop>
<tr>
<th colspan="3" align="right">Total Invoice Amount</th>
<th align="left">#numberformat(val(totalcustnet),',.__')#</th>
<th align="left">#numberformat(val(totalgst),',.__')#</th>
<th align="left">#numberformat(val(totaltotal),',.__')#</th>
<td colspan="4"></td>
<th align="right">#numberformat(val(totalgrosspay),',.__')#</th>
<th align="right">#numberformat(val(totalreimb),',.__')#</th>
<th align="right">#numberformat(val(totalepfww),',.__')#</th>
<td></td>
<td></td>
<th align="left">#numberformat(val(totalepfcc),',.__')#</th>
<th align="left">#numberformat(val(totalinvoiceless),',.__')#</th>
</tr>
<td colspan="14" align="right">Total Giro Amount</td>
<th align="left">#numberformat(val(totalnetpay),',.__')#</th>
</table>



</cfoutput>
