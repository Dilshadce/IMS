<!doctype html>
<html>
<head>
<meta charset="utf-8">
<cfoutput>
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<title>Invoice Report - #form.invoicetext#</title>
</cfoutput>
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

<!---<cfquery name="getpayroll" datasource="#dts#">
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
</cfquery>--->

    <cfquery name="getartran" datasource="#dts#">
        SELECT grand_bil, tax_bil, fperiod, custno, refno
        FROM artran
        WHERE refno = "#form.invoicetext#"
    </cfquery>
    
    <cfquery name="getictran" datasource="#dts#">
        SELECT desp, amt_bil, taxamt_bil, brem5, brem6
        FROM ictran
        WHERE refno ="#form.invoicetext#"
        AND
        itemno <> "Name"
        ORDER by desp
    </cfquery>

    <cfquery name="getbatches" datasource="#dts#">
        SELECT batches, payrollperiod
        FROM assignmentslip
        WHERE invoiceno = "#form.invoicetext#"
    </cfquery>
    
    <cfquery name="getdate" datasource="#dts#">
        SELECT date_add(a.wos_date,INTERVAL b.arrem6 DAY) as duedate, a.wos_date
        FROM artran a
        LEFT JOIN arcust b
        ON a.custno = b.custno
        WHERE refno = "#form.invoicetext#"
	</cfquery>

<body >
<cfoutput>
	<table border="0" align="center" width="95%">
    <!---Prefix--->
    	<tr class="theader">
        	<td> RECTYPE </td> <td> CNTBTCH </td> <td> CNITEM </td> <td> IDCUST </td> <td> IDINVC </td> <td> TEXTTRX </td> <td> INVCDESC </td> <td> DATEINVC </td> <td> SWMANRTE </td> <td> DATEDUE </td>
            <td> SWTAXBL </td> <td> SWMANTX </td> <td> CODETAXGRP </td> <td> TAXSTTS1 </td> <td> AMTTAX1 </td> <td> FISCYR </td> <td> FISCPER </td>
        </tr>
        
        <tr class="theader">
        	<td> RECTYPE </td> <td> CNTBTCH </td> <td> CNITEM </td> <td> CNTLINE </td> <td> TEXTDESC </td> <td> AMTEXTN </td> <td> SWMANLTX </td> <td> TAXSTTS1 </td> <td> IDACCTREV </td> <td> COMMENT </td>
            <td> ITEMTAX </td>
        </tr>
        
        <tr class="theader">
        	<td> RECTYPE </td> <td> CNTBTCH </td> <td> CNITEM </td> <td> CNTPAYM </td> <td> DATEDUE </td> <td> AMTDUE </td> 
        </tr>
    <!---end of prefix--->
    
    <tr class="border_bottom"> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> </tr>
    
	<!---Header--->
    	<tr>
        	<td>1</td> <td>#getbatches.batches#</td> <td>1</td> <td>#getartran.custno#</td> <td>#form.invoicetext#</td> <td>1</td> <td>AP-MONTH=#getartran.fperiod#</td> <td>#dateformat(getdate.wos_date,'yyyymmdd')#</td> <td>0</td>
            <td>#dateformat(getdate.duedate,'yyyymmdd')#</td> <td>1</td> <td>1</td> <td>GST</td> <td>3</td> <td>#getartran.tax_bil#</td> <td>#dateformat(getdate.wos_date,'yyyy')#</td> <td>#getbatches.payrollperiod#</td> 
        </tr>
    <!---end of header--->
    
    <cfset itemcounter = 1>
    <tr class="border_bottom"> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> </tr>
    
	<!---body--->
    	<cfloop query="getictran">
        
            <cfquery name="getplacementno" datasource="#dts#">
                SELECT placementno
                FROM placement
                WHERE empno = "#getictran.brem5#"
                AND
                custno = "#getartran.custno#"
            </cfquery>
        	
            <cfquery name="getjobno" datasource="#dts#">
                select location, placementtype
                from placement 
                where placementno = #getplacementno.placementno#
            </cfquery>
            
            <cfquery name="getbatches2" datasource="#dts#">
                SELECT batches
                FROM assignmentslip
                WHERE placementno = "#getplacementno.placementno#"
                AND
                invoiceno = "#form.invoicetext#"
            </cfquery>
            
            <cfquery name="chartofaccount" datasource="#dts#">
                SELECT s_credit, s_creditbranch
                FROM chartofaccount
                WHERE type1 = "#getjobno.placementtype#"
                AND
                <cfif #getictran.desp# contains "SOCSO YER">
                    type2 = "+SOCSO"
                    AND
                    s_credit != ""
                <cfelse>
                	type2 = "#getictran.desp#"
                </cfif>        
            </cfquery> 
        
            <tr>
                <td>2</td> <td>#getbatches2.batches#</td> <td>1</td> <td>#itemcounter#</td> <td>#getictran.desp# /TS## /Job###getplacementno.placementno#</td> <td>#getictran.amt_bil#</td> 
                <td>1</td> <td>1</td> <td> <cfif #chartofaccount.s_creditbranch# eq 'Y'> 
                						   		#chartofaccount.s_credit#-#getjobno.location# 
                						   <cfelse>
                                           		#chartofaccount.s_credit#
                						   </cfif></td>
                <td>/Batch ###getbatches2.batches# /Timesheet ##</td> <td>#getictran.taxamt_bil#</td>
            </tr>
            <cfset itemcounter += 1>
        </cfloop>
    <!---end of body--->
    
    <tr class="border_bottom"> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> </tr>
   
    <!---footer--->
    	<tr>
        	<td>3</td> <td>#getbatches.batches#</td> <td>1</td> <td>1</td> <td>#dateformat(getdate.duedate,'yyyymmdd')#</td> <td>#getartran.grand_bil#</td> 
        </tr>
    <!---end of footer--->
    
    <tr class="border_bottom"> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> </tr>
    
    </table>
</cfoutput>
</body>
</html>