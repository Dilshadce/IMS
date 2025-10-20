<cfoutput>
<cfset uuid = createuuid()>
<style type="text/css">
    @media print
    {
    	##non-printable { display: none; }

    }
    </style>

<cfsetting showdebugoutput="yes">
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
<cfquery name="getlevy" datasource="#replace(dts,'_i','_p')#">
SELECT LEVY_SD,EMPNO,LEVY_FW_W FROM COMM
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
<cfquery name="getlevy" datasource="#replace(dts,'_i','_p')#">
SELECT LEVY_SD,EMPNO,LEVY_FW_W FROM COMM_12m WHERE tmonth = "#form.month#"
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
<!--- <cfif form.areafrom neq "" and form.areato neq "">
and location between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.areafrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.areato#">
</cfif>  --->
</cfquery>

<cfquery name="getgeneral" datasource="#dts#">
	select lastaccyear,filterall,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION,agentlistuserid,compro from gsetup
</cfquery>

<cfquery name="getassignment" datasource="#dts#">
SELECT * FROM (
SELECT aa.*,if(claimadd1 = 'Y',coalesce(addchargeself,0),0)+if(claimadd2 = 'Y',coalesce(addchargeself2,0),0)+if(claimadd3 = 'Y',coalesce(addchargeself3,0),0)+if(claimadd4 = 'Y',coalesce(addchargeself4,0),0)+if(claimadd5 = 'Y',coalesce(addchargeself5,0),0)+if(claimadd6 = 'Y',coalesce(addchargeself6,0),0) as totalamt FROM assignmentslip aa
WHERE month(assignmentslipdate) = "#form.month#"
and year(assignmentslipdate) = "#payrollyear#"
<cfif form.billfrom neq "" and form.billto neq "">
and refno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billto#">
</cfif> 
<cfif form.areafrom neq "" and form.areato neq "">
and branch between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.areafrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.areato#">
</cfif>
<cfif isdefined('form.batches')>
and batches in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.batches#" separator="," list="yes">)
</cfif>
<cfif form.createdfrm neq "" and form.createdto neq "">
and (created_by BETWEEN <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.createdfrm#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.createdto#">)
</cfif>
<!--- <cfif getplacement.recordcount neq 0> --->
and placementno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#VALUELIST(getplacement.placementno)#" list="yes" separator=",">)
<!--- </cfif> ---> ) as a
LEFT JOIN
(SELECT placementno as pno, location,consultant,custno as cno,custname,empname,pm FROM placement) as b on a.placementno = b.pno
LEFT JOIN
(
SELECT priceid,pricename FROM manpowerpricematrix
) as c
on b.pm = c.priceid
LEFT JOIN
(
SELECT custno as xcustno,arrem5 FROM #target_arcust#
) as d
on a.custno = d.xcustno
order by #form.orderby#,refno
</cfquery>
<html>
<head>
</head>
<body>
<table>
<tr>
<th colspan="100%" align="left"><font style="font-size:20px"><b>Batch Control Report</b></font></th>
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
<cfif isdefined('form.batches')>
<tr>
<th colspan="100%" align="left">
Batch : #form.batches#
</th>
</tr>
</cfif>
<tr>
<th colspan="100%" align="left">User : #getassignment.created_by#</th>
</tr>
<cfif isdefined('form.batches')>
<cfquery name="getbanktype" datasource="#dts#">
Select banktype from assignmentslip WHERE batches in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.batches#" list="yes" separator=",">
) GROUP BY batches
</cfquery>
<tr>
<th colspan="100%" align="left">Bank Info : #valuelist(getbanktype.banktype)#</th>
</tr>
</cfif>
<tr>
<td><br>
<br>
</td>
</tr>
</table>
<table>
<tr>
<th align="left" nowrap>Entity</th>
<th align="left" nowrap>Office Code</th>
<th align="left" nowrap>Batch</th>
<th align="left" nowrap>Company</th>
<th align="left" nowrap>Custno</th>
<th align="left" nowrap>VAT</th>
<th align="left" nowrap>Placement No</th>
<th align="left" nowrap>Price Structures</th>
<th align="left" nowrap>Employee Name</th>
<th align="left" nowrap>Employee No</th>
<th align="left" nowrap>Refno</th>
<th align="left" nowrap>Period</th>
<th align="left" nowrap>Item Name</th>
<th align="right" nowrap>Pay Qty</th>
<th align="right" nowrap>Pay Rate</th>
<th align="right" nowrap>Pay Amt</th>
<th align="right" nowrap>Bill Qty</th>
<th align="right" nowrap>Bill Rate</th>
<th align="right" nowrap>Bill Amt</th>
</tr>
<cfloop query="getassignment">
<cfif val(getassignment.selfusualpay) neq 0 or val(getassignment.custusualpay) neq 0>
<tr>
<cfinclude template="startrow.cfm">
<td align="left" nowrap>Normal</td>
<cfif getassignment.paymenttype eq "hr">
<td align="right" nowrap>#numberformat(getassignment.selfsalaryhrs,'.____')#</td>
<cfelseif getassignment.paymenttype eq "day">
<td align="right" nowrap>#numberformat(getassignment.selfsalaryday,'.____')#</td>
<cfelse>
<cfif val(getassignment.workd) neq 0>
<cfset monthprorate = ROUND((val(getassignment.selfsalaryday)/val(getassignment.workd))*100000)/100000>
<cfelse>
<cfset monthprorate = 1>
</cfif>
<td align="right" nowrap>#numberformat(monthprorate,'.____')#</td>
</cfif>
<td align="right" nowrap>#numberformat(getassignment.selfusualpay,'.__')#</td>
<td align="right" nowrap>#numberformat(getassignment.selfsalary,'.__')#</td>
<cfif getassignment.paymenttype eq "hr">
<td align="right" nowrap>#numberformat(getassignment.custsalaryhrs,'.____')#</td>
<cfelseif getassignment.paymenttype eq "day">
<td align="right" nowrap>#numberformat(getassignment.custsalaryday,'.____')#</td>
<cfelse>
<cfif val(getassignment.workd) neq 0>
<cfset monthprorate = ROUND((val(getassignment.custsalaryday)/val(getassignment.workd))*100000)/100000>
<cfelse>
<cfset monthprorate = 1>
</cfif>
<td align="right" nowrap>#numberformat(monthprorate,'.____')#</td>
</cfif>
<td align="right" nowrap>#numberformat(getassignment.custusualpay,'.__')#</td>
<td align="right" nowrap>#numberformat(getassignment.custsalary,'.__')#</td>
</tr>
</cfif>

<cfif val(getassignment.selfottotal) neq 0 or val(getassignment.custottotal) neq 0>
<cfloop from="1" to="8" index="a">
<cfif val(evaluate('getassignment.selfot#a#')) neq 0 or val(evaluate('getassignment.custot#a#')) neq 0>
<tr>
<cfinclude template="startrow.cfm">
<td><cfif a eq 1>OT 1.0<cfelseif a eq 2>OT 1.5<cfelseif a eq 3>OT 2.0<cfelseif a eq 4>OT 3.0<cfelseif a eq 5>RD 1.0<cfelseif a eq 6>RD 2.0<cfelseif a eq 7>PH 1.0<cfelseif a eq 8>PH 2.0</cfif></td>
<td align="right" nowrap>#numberformat(evaluate('selfothour#a#'),'.__')#</td>
<td align="right" nowrap>#numberformat(evaluate('selfotrate#a#'),'.__')#</td>
<td align="right" nowrap>#numberformat(evaluate('selfot#a#'),'.__')#</td>
<td align="right" nowrap>#numberformat(evaluate('custothour#a#'),'.__')#</td>
<td align="right" nowrap>#numberformat(evaluate('custotrate#a#'),'.__')#</td>
<td align="right" nowrap>#numberformat(evaluate('custot#a#'),'.__')#</td>
</tr>
</cfif> 
</cfloop>
</cfif>
<cfif val(getassignment.selfallowance) neq 0 or val(getassignment.custallowance) neq 0>
<cfloop from="1" to="6" index="a">
<cfif val(evaluate('getassignment.fixawee#a#')) neq 0 or val(evaluate('getassignment.fixawer#a#'))>
<tr>
<cfinclude template="startrow.cfm">
<td align="left" nowrap>#evaluate('fixawdesp#a#')#</td>
<td align="right" nowrap><cfif val(evaluate('getassignment.fixawee#a#')) neq 0>1.00<cfelse>0.00</cfif></td>
<td align="right" nowrap>#numberformat(val(evaluate('getassignment.fixawee#a#')),'.__')#</td>
<td align="right" nowrap>#numberformat(val(evaluate('getassignment.fixawee#a#')),'.__')#</td>
<td align="right" nowrap><cfif val(evaluate('getassignment.fixawer#a#')) neq 0>1.00<cfelse>0.00</cfif></td>
<td align="right" nowrap>#numberformat(val(evaluate('getassignment.fixawer#a#')),'.__')#</td>
<td align="right" nowrap>#numberformat(val(evaluate('getassignment.fixawer#a#')),'.__')#</td>
</tr>
</cfif>
</cfloop>
<cfloop from="1" to="18" index="a">
<cfif val(evaluate('getassignment.awee#a#')) neq 0 or val(evaluate('getassignment.awer#a#'))>
<tr>
<cfinclude template="startrow.cfm">
<td align="left" nowrap>#evaluate('allowancedesp#a#')#</td>
<td align="right" nowrap><cfif val(evaluate('getassignment.awee#a#')) neq 0>1.00<cfelse>0.00</cfif></td>
<td align="right" nowrap>#numberformat(val(evaluate('getassignment.awee#a#')),'.__')#</td>
<td align="right" nowrap>#numberformat(val(evaluate('getassignment.awee#a#')),'.__')#</td>
<td align="right" nowrap><cfif val(evaluate('getassignment.awer#a#')) neq 0>1.00<cfelse>0.00</cfif></td>
<td align="right" nowrap>#numberformat(val(evaluate('getassignment.awer#a#')),'.__')#</td>
<td align="right" nowrap>#numberformat(val(evaluate('getassignment.awer#a#')),'.__')#</td>
</tr>
</cfif>
</cfloop>
</cfif>
<cfif val(getassignment.selfcpf) neq 0 or val(getassignment.custcpf) neq 0>
<tr>
<cfinclude template="startrow.cfm">
<td align="left" nowrap>EPF</td>
<td align="right" nowrap><cfif val(getassignment.selfcpf) neq 0>1.00<cfelse>0.00</cfif></td>
<td align="right" nowrap>#numberformat(val(getassignment.selfcpf),'.__')#</td>
<td align="right" nowrap>#numberformat(val(getassignment.selfcpf),'.__')#</td>
<td align="right" nowrap><cfif val(getassignment.custcpf) neq 0>1.00<cfelse>0.00</cfif></td>
<td align="right" nowrap>#numberformat(val(getassignment.custcpf),'.__')#</td>
<td align="right" nowrap>#numberformat(val(getassignment.custcpf),'.__')#</td>
</tr>
</cfif>
<cfif val(getassignment.selfcpf) neq 0 or val(getassignment.custcpf) neq 0>
<tr>
<cfinclude template="startrow.cfm">
<td align="left" nowrap>SOCSO</td>
<td align="right" nowrap><cfif val(getassignment.selfsdf) neq 0>1.00<cfelse>0.00</cfif></td>
<td align="right" nowrap>#numberformat(val(getassignment.selfsdf),'.__')#</td>
<td align="right" nowrap>#numberformat(val(getassignment.selfsdf),'.__')#</td>
<td align="right" nowrap><cfif val(getassignment.custsdf) neq 0>1.00<cfelse>0.00</cfif></td>
<td align="right" nowrap>#numberformat(val(getassignment.custsdf),'.__')#</td>
<td align="right" nowrap>#numberformat(val(getassignment.custsdf),'.__')#</td>
</tr>
</cfif>

<cfif val(getassignment.adminfee) neq 0 >
<tr>
<cfinclude template="startrow.cfm">
<td align="left" nowrap>Admin Fee</td>
<td align="right" nowrap>0.00</td>
<td align="right" nowrap>0.00</td>
<td align="right" nowrap>0.00</td>
<td align="right" nowrap>1</td>
<td align="right" nowrap>#numberformat(val(getassignment.adminfee),'.__')#</td>
<td align="right" nowrap>#numberformat(val(getassignment.adminfee),'.__')#</td>
</tr>
</cfif>

<cfif val(getassignment.custdeduction) neq 0>
<cfloop from="1" to="6" index="a">
<cfif val(evaluate('getassignment.billitemamt#a#')) neq 0>
<tr>
<cfinclude template="startrow.cfm">
<td align="left" nowrap>#evaluate('getassignment.billitemdesp#a#')#</td>
<td align="right" nowrap>0.00</td>
<td align="right" nowrap>0.00</td>
<td align="right" nowrap>0.00</td>
<td align="right" nowrap>1.00</td>
<td align="right" nowrap>#numberformat(val(evaluate('getassignment.billitemamt#a#')),'.__')#</td>
<td align="right" nowrap>#numberformat(val(evaluate('getassignment.billitemamt#a#')),'.__')#</td>
</tr>
</cfif>
</cfloop>
</cfif>
<tr>
<td colspan="13"></td>
<td align="right" nowrap><b>#numberformat(getassignment.selftotal,'.__')#</b></td>
<td></td>
<td></td>
<td align="right" nowrap><b>#numberformat(getassignment.custtotalgross,'.__')#</b></td>
</tr>
<tr>
<td><br>
</td>
</tr>
</cfloop>

</table>
</body>
</html>


</cfoutput>
