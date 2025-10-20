<cfoutput>
<cfinclude template="/object/dateobject.cfm">
<cfinclude template="/object/stringobject.cfm">
<cfquery name="getpayroll" datasource="#dts#">
SELECT mmonth,myear FROM payroll_main.gsetup WHERE comp_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#replace(dts,'_i','')#">
</cfquery>
<cfset payrollmonth = getpayroll.mmonth>
<cfset payrollyear = getpayroll.myear>

<cfif payrollmonth eq form.month>
<cfset paytra1 = "paytra1">
<cfset paytran = "paytran">
<cfelse>
<cfset paytra1 = "pay1_12m_fig">
<cfset paytran = "pay2_12m_fig">
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

<cfquery name="getassignment" datasource="#dts#">
SELECT giropaydate,paydate,batches,empno,created_by,sum(if(claimadd1 = 'Y',coalesce(addchargeself,0),0)+if(claimadd2 = 'Y',coalesce(addchargeself2,0),0)+if(claimadd3 = 'Y',coalesce(addchargeself3,0),0)+if(claimadd4 = 'Y',coalesce(addchargeself4,0),0)+if(claimadd5 = 'Y',coalesce(addchargeself5,0),0)+if(claimadd6 = 'Y',coalesce(addchargeself6,0),0)) as totalamt, sum(coalesce(ded1,0)+coalesce(ded2,0)+coalesce(ded3,0)) as totalded,sum(round(coalesce(custtotal,0)+0.00000001,2)) as custtotal FROM assignmentslip aa
WHERE month(assignmentslipdate) = "#form.month#"
and year(assignmentslipdate) = "#payrollyear#"
and batches <> "" and batches is not null
<cfif form.billfrom neq "" and form.billto neq "">
and refno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billto#">
</cfif> 
<cfif isdefined('form.batches')>
and batches in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.batches#" separator="," list="yes">)
</cfif>
<cfif form.createdfrm neq "" and form.createdto neq "">
and (created_by BETWEEN <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.createdfrm#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.createdto#">)
</cfif>
<!--- <cfif getplacement.recordcount neq 0> --->
and placementno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#VALUELIST(getplacement.placementno)#" list="yes" separator=",">)
<!--- </cfif> ---> 
GROUP BY batches
order by #form.orderby#
</cfquery>

<table>
<tr>
<th colspan="100%" align="left"><font style="font-size:20px"><b>Batch Total Summary Report</b></font></th>
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
<tr>
<td><br>
<br>
</td>
</tr>
</table>
<table border="1">
<tr>
<th valign="top" align="left">Batch No</th>
<th valign="top" align="left">Giro Pay Date</th>
<th valign="top" align="left">User</th>
<th valign="top" align="left">Payment Type</th>
<th valign="top" align="Right">No of EEs</th>
<th valign="top" align="Right">Invoice Amount</th>
<th valign="top" align="Right">Net Pay / Giro Amount</th>
<th valign="top" align="Right">Batch Lock Ref</th>
</tr>
<cfset invamt = 0>
<cfset allnetpay = 0>
<cfset empcount = 0>
<cfloop query="getassignment">
<tr>
<td  nowrap="nowrap">#getassignment.batches#</td>
<td  nowrap="nowrap">#dateformat(getassignment.giropaydate,'dd/mm/yyyy')#</td>
<td  nowrap="nowrap">#getassignment.created_by#</td>
<cfquery name="getpaymenttype" datasource="#replace(dts,'_i','_p')#">
SELECT paymeth FROM pmast WHERE empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.empno#">
</cfquery>
<td  nowrap="nowrap"><cfif getpaymenttype.paymeth eq "Q">Cheque<cfelseif getpaymenttype.paymeth eq "B">Bank<cfelse>Cash</cfif></td>

<cfquery name="getemplist" datasource="#dts#">
SELECT empno FROM assignmentslip WHERE batches = "#getassignment.batches#"
</cfquery>

<cfquery name="getpayroll" datasource="#replace(dts,'_i','_p')#">
SELECT sum(round(netpay+0.0000001,2)) as netpay,cheque_no,count(empno) as noofemp FROM #evaluate('#getassignment.paydate#')#
WHERE EMPNO in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getemplist.empno)#" separator="," list="yes">)
<cfif payrollmonth neq form.month>
and tmonth = "#form.month#"
</cfif>
</cfquery>
<cfset empcount = empcount + val(getpayroll.noofemp)>
<td  nowrap="nowrap" align="right">#val(getpayroll.noofemp)#</td>
<td  nowrap="nowrap" align="right">
<cfset invamt = invamt + numberformat(val(getassignment.custtotal),'.__')>
#numberformat(val(getassignment.custtotal),',.__')#</td>
<td  nowrap="nowrap" align="right">
<cfset nnetpay = numberformat(val(getpayroll.netpay),'.__') + numberformat(val(getassignment.totalamt),'.__') - numberformat(val(getassignment.totalded),'.__')>
#numberformat(val(nnetpay),',.__')#</td>
<cfset allnetpay = allnetpay + nnetpay>
<td  nowrap="nowrap" align="right">#getpayroll.cheque_no#</td>

</tr>
</cfloop>
<tr>
<td colspan="100%"><hr /></td>
</tr>
<tr>
<th align="left" colspan="4">Total Amount</th>
<th align="right">#val(empcount)#</th>
<th align="right">#numberformat(invamt,',.__')#</th>
<th align="right">#numberformat(allnetpay,',.__')#</th>
</tr>

</table>



</cfoutput>
