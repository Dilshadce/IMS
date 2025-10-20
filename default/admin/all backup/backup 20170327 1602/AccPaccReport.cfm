<!doctype html>
<html>
<head>
<meta charset="utf-8">

<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<title>Post to AccPacc</title>

<style>
br {
    display: none;
}

tr.border_bottom td {
  border-bottom:1pt solid black;
}

tr.theader td{
	border:1pt solid black;
}

</style>

</head>
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


<!---<cfif (form.getfrom neq "" and form.getto neq "") or  (form.agentfrom neq "" and form.agentto neq "")>
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
</cfif>--->

<cfquery name="getgeneral" datasource="#dts#">
	select lastaccyear,filterall,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION,agentlistuserid,compro from gsetup
</cfquery>

<cfquery name="getassignment" datasource="#dts#">
SELECT * FROM (
SELECT aa.*,if(claimadd1 = 'Y',coalesce(addchargeself,0),0)+if(claimadd2 = 'Y',coalesce(addchargeself2,0),0)+if(claimadd3 = 'Y',coalesce(addchargeself3,0),0)+if(claimadd4 = 'Y',coalesce(addchargeself4,0),0)+if(claimadd5 = 'Y',coalesce(addchargeself5,0),0)+if(claimadd6 = 'Y',coalesce(addchargeself6,0),0) as totalamt FROM assignmentslip aa
WHERE month(assignmentslipdate) = "#form.month#"
and year(assignmentslipdate) = "#payrollyear#" 
<!---<cfif form.billfrom neq "" and form.billto neq "">
and refno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billto#">
</cfif> 
<cfif form.areafrom neq "" and form.areato neq "">
and branch between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.areafrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.areato#">
</cfif>--->
<cfif isdefined('form.batches')>
and batches in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.batches#" separator="," list="yes">)
</cfif>
<!---<cfif form.createdfrm neq "" and form.createdto neq "">
and (created_by BETWEEN <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.createdfrm#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.createdto#">)
</cfif>--->
<cfif isdefined('getplacement')>
<cfif getplacement.recordcount neq 0>
and placementno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#VALUELIST(getplacement.placementno)#" list="yes" separator=",">)
</cfif></cfif>) as a
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
on a.custno = d.xcustno<!---
order by <cfif form.orderby eq 'custname'>b.</cfif>#form.orderby#,refno--->
</cfquery>
<body >
<cfoutput>
<table border="0" align="center" width="95%">

    <tr class="theader">
    	<td> Batch </td>
        <td> Company </td>
        <td> Cust No </td>
        <td> Vat </td>
        <td> Placement No </td>
        <td> Price Structure </td>
        <td> Employee Name </td>
        <td> Employe No </td>
        <td> Ref No </td>
        <td> Item Name </td>
        <td> Pay Amt </td>
        <td> Bill Amt </td>
        <td> Action </td>
    </tr>
    
    <cfloop query="getassignment">
    
		<cfif val(getassignment.selfusualpay) neq 0 or val(getassignment.custusualpay) neq 0>           
            <tr>
                <td> #getassignment.batches# </td>
                <td> #getassignment.custname# </td>
                <td> #getassignment.custno# </td>
                <td> #getassignment.arrem5# </td>
                <td> #getassignment.placementno# </td>
                <td> #getassignment.pricename# </td>
                <td> #getassignment.empname# </td>
                <td> #getassignment.empno# </td>
                <td> #getassignment.refno# </td>
                <td> Normal </td>
                <td> #numberformat(getassignment.selfsalary,',.__')# </td>
                <td> #numberformat(getassignment.custsalary,',.__')# </td><br>
                <td> Download </td>
            </tr>
        </cfif>

		<cfif val(getassignment.selfottotal) neq 0 or val(getassignment.custottotal) neq 0>
            <cfloop from="1" to="8" index="a">
                <cfif val(evaluate('getassignment.selfot#a#')) neq 0 or val(evaluate('getassignment.custot#a#')) neq 0>
                    <tr>
                        <td> #getassignment.batches# </td>
                        <td> #getassignment.custname# </td>
                        <td> #getassignment.custno# </td>
                        <td> #getassignment.arrem5# </td>
                        <td> #getassignment.placementno# </td>
                        <td> #getassignment.pricename# </td>
                        <td> #getassignment.empname# </td>
                        <td> #getassignment.empno# </td>
                        <td> #getassignment.refno# </td>
                        <td> <cfif a eq 1>OT 1.0<cfelseif a eq 2>OT 1.5<cfelseif a eq 3>OT 2.0<cfelseif a eq 4>OT 3.0<cfelseif a eq 5>RD 1.0<cfelseif a eq 6>RD 2.0<cfelseif a eq 7>PH 1.0<cfelseif a eq 8>PH 2.0</cfif> </td>
                        <td> #numberformat(evaluate('selfot#a#'),',.__')# </td>
                        <td> #numberformat(evaluate('custot#a#'),',.__')# </td>
                        <td> Download </td>
                    </tr>
                    
                </cfif> 
            </cfloop>
        </cfif>
    
		<cfif val(getassignment.selfallowance) neq 0 or val(getassignment.custallowance) neq 0>
            <cfloop from="1" to="6" index="a">
                <cfif val(evaluate('getassignment.fixawee#a#')) neq 0 or val(evaluate('getassignment.fixawer#a#'))>
                    <tr>
                        <td> #getassignment.batches# </td>
                        <td> #getassignment.custname# </td>
                        <td> #getassignment.custno# </td>
                        <td> #getassignment.arrem5# </td>
                        <td> #getassignment.placementno# </td>
                        <td> #getassignment.pricename# </td>
                        <td> #getassignment.empname# </td>
                        <td> #getassignment.empno# </td>
                        <td> #getassignment.refno# </td>
                        <td> #evaluate('fixawdesp#a#')# </td>
                        <td> #numberformat(val(evaluate('getassignment.fixawee#a#')),',.__')# </td>
                        <td> #numberformat(val(evaluate('getassignment.fixawer#a#')),',.__')# </td>
                        <td> Download </td>
                    </tr>
                </cfif>
            </cfloop>
            
            <cfloop from="1" to="18" index="a">
                <cfif val(evaluate('getassignment.awee#a#')) neq 0 or val(evaluate('getassignment.awer#a#'))>
                    <tr>
                        <td> #getassignment.batches# </td>
                        <td> #getassignment.custname# </td>
                        <td> #getassignment.custno# </td>
                        <td> #getassignment.arrem5# </td>
                        <td> #getassignment.placementno# </td>
                        <td> #getassignment.pricename# </td>
                        <td> #getassignment.empname# </td>
                        <td> #getassignment.empno# </td>
                        <td> #getassignment.refno# </td>
                        <td> #evaluate('allowancedesp#a#')# </td>
                        <td> #numberformat(val(evaluate('getassignment.awee#a#')),',.__')# </td>
                        <td> #numberformat(val(evaluate('getassignment.awer#a#')),',.__')# </td>
                        <td> Download </td>
                    </tr>
                </cfif>
            </cfloop>
        </cfif>
    
		<cfif val(getassignment.selfcpf) neq 0 or val(getassignment.custcpf) neq 0>
            <tr>
                <td> #getassignment.batches# </td>
                <td> #getassignment.custname# </td>
                <td> #getassignment.custno# </td>
                <td> #getassignment.arrem5# </td>
                <td> #getassignment.placementno# </td>
                <td> #getassignment.pricename# </td>
                <td> #getassignment.empname# </td>
                <td> #getassignment.empno# </td>
                <td> #getassignment.refno# </td>
                <td> EPF </td>
                <td> #numberformat(val(getassignment.selfcpf),',.__')# </td>
                <td> #numberformat(val(getassignment.custcpf),',.__')# </td>
                <td> Download </td>      
            </tr>
        </cfif>
    
		<cfif val(getassignment.selfcpf) neq 0 or val(getassignment.custcpf) neq 0>
            <tr>
                <td> #getassignment.batches# </td>
                <td> #getassignment.custname# </td>
                <td> #getassignment.custno# </td>
                <td> #getassignment.arrem5# </td>
                <td> #getassignment.placementno# </td>
                <td> #getassignment.pricename# </td>
                <td> #getassignment.empname# </td>
                <td> #getassignment.empno# </td>
                <td> #getassignment.refno# </td>
                <td> SOCSO </td>
                <td> #numberformat(val(getassignment.selfsdf),',.__')# </td>
                <td> #numberformat(val(getassignment.custsdf),',.__')# </td>
                <td> Download </td>      
            </tr>
        </cfif>

		<cfif val(getassignment.adminfee) neq 0 >
            <tr>
                <td> #getassignment.batches# </td>
                <td> #getassignment.custname# </td>
                <td> #getassignment.custno# </td>
                <td> #getassignment.arrem5# </td>
                <td> #getassignment.placementno# </td>
                <td> #getassignment.pricename# </td>
                <td> #getassignment.empname# </td>
                <td> #getassignment.empno# </td>
                <td> #getassignment.refno# </td>
                <td> Admin Fee </td>
                <td> 0.00 </td>
                <td> #numberformat(val(getassignment.adminfee),',.__')# </td>
                <td> Download </td>      
            </tr>
        </cfif>

		<cfif val(getassignment.custdeduction) neq 0 or val(getassignment.selfdeduction)>
            <cfloop from="1" to="6" index="a">
                <cfif val(evaluate('getassignment.billitemamt#a#')) neq 0>
                    <tr>
                        <td> #getassignment.batches# </td>
                        <td> #getassignment.custname# </td>
                        <td> #getassignment.custno# </td>
                        <td> #getassignment.arrem5# </td>
                        <td> #getassignment.placementno# </td>
                        <td> #getassignment.pricename# </td>
                        <td> #getassignment.empname# </td>
                        <td> #getassignment.empno# </td>
                        <td> #getassignment.refno# </td>
                        <td> #evaluate('getassignment.billitemdesp#a#')# Fee </td>
                        <td> 0.00 </td>
                        <td> #numberformat(val(evaluate('getassignment.billitemamt#a#')),',.__')# </td>
                        <td> Download </td>      
                    </tr>
                </cfif>
            </cfloop>

            <cfloop from="1" to="3" index="a">
                <cfif a eq 1>
                    <cfset a = "">
                </cfif>
                
                <cfif val(evaluate('getassignment.addchargeself#a#')) neq 0 or val(evaluate('getassignment.addchargecust#a#')) neq 0>
                    <tr>
                            <td> #getassignment.batches# </td>
                            <td> #getassignment.custname# </td>
                            <td> #getassignment.custno# </td>
                            <td> #getassignment.arrem5# </td>
                            <td> #getassignment.placementno# </td>
                            <td> #getassignment.pricename# </td>
                            <td> #getassignment.empname# </td>
                            <td> #getassignment.empno# </td>
                            <td> #getassignment.refno# </td>
                            <td> #evaluate('getassignment.addchargedesp#a#')# Fee </td>
                            <td> #numberformat(val(evaluate('getassignment.addchargeself#a#')),',.__')# </td>
                            <td> #numberformat(val(evaluate('getassignment.addchargecust#a#')),',.__')# </td>
                            <td> Download </td>      
                        </tr>
                </cfif>
            </cfloop>
        </cfif>
    
        <tr>
            <td> #getassignment.batches# </td>
            <td> #getassignment.custname# </td>
            <td> #getassignment.custno# </td>
            <td> #getassignment.arrem5# </td>
            <td> #getassignment.placementno# </td>
            <td> #getassignment.pricename# </td>
            <td> #getassignment.empname# </td>
            <td> #getassignment.empno# </td>
            <td> #getassignment.refno# </td>
            <td> </td>
            <td> <b> #numberformat(getassignment.selftotal,',.__')# </b></td>
            <td> <b> #numberformat(getassignment.custtotalgross,',.__')# </b> </td>
            <td> Download </td>      
        </tr>
        
        <tr class="border_bottom" >
        	<td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>       
        </tr>
      
	</cfloop>
    
</table>
</cfoutput>
</body>
</html>