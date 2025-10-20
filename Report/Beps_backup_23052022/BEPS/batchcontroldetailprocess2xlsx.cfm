<cfsetting showdebugoutput="yes" requesttimeout="1800">
<cfoutput>

<cfset totalpay = 0>
<cfset totalbill = 0>

<cfquery name="getpayroll" datasource="#dts#">
    SELECT mmonth,myear FROM payroll_main.gsetup WHERE comp_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#replace(dts,'_i','')#">
</cfquery>

<cfset payrollmonth = getpayroll.mmonth>
<cfset payrollyear = getpayroll.myear>

<cfif (form.getfrom neq "" and form.getto neq "") or  (form.agentfrom neq "" and form.agentto neq "") or (form.getempfrom neq "" and form.getempto neq "")>
    <cfquery name="getplacement" datasource="#dts#">
    SELECT * FROM placement
    WHERE 1 = 1
        
    <cfif form.getcust neq "">
        and custname like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#form.getcust#%">
    </cfif> 
    
    <cfif form.getfrom neq "" and form.getto neq "">
        and custno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.getfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.getto#">
    </cfif> 
    
    <cfif form.agentfrom neq "" and form.agentto neq "">
        and consultant between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.agentfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.agentto#">
    </cfif> 
        
    <!---Added by Nieo 20171117 1038 for new filter requirement--->
    <cfif form.getempfrom neq "" and form.getempto neq "">
    and empno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.getempfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.getempto#">
    </cfif> 
    <!---Added by Nieo 20171117 1038 for new filter requirement--->
    
    <!--- <cfif form.areafrom neq "" and form.areato neq "">
    and location between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.areafrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.areato#">
    </cfif>  --->
    </cfquery>
</cfif>

<cfquery name="getgeneral" datasource="#dts#">
	select lastaccyear,filterall,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION,agentlistuserid,compro from gsetup
</cfquery>

<cfif isdefined('form.cndnonly') neq true and isdefined('form.permonly')  neq true>
<cfquery name="getassignment" datasource="#dts#">
    SELECT * FROM 
    (
        SELECT aa.*,if(claimadd1 = 'Y',coalesce(addchargeself,0),0)+if(claimadd2 = 'Y',coalesce(addchargeself2,0),0)+if(claimadd3 = 'Y',coalesce(addchargeself3,0),0)+if(claimadd4 = 'Y',coalesce(addchargeself4,0),0)+if(claimadd5 = 'Y',coalesce(addchargeself5,0),0)+if(claimadd6 = 'Y',coalesce(addchargeself6,0),0) as totalamt 
        FROM assignmentslip aa
        WHERE 
            <!---Added by Nieo 20171117 1038 for new filter requirement--->
            payrollperiod between #form.month# and #form.monthto#
            <!---Added by Nieo 20171117 1038 for new filter requirement--->
        <!---Updated by Nieo 20180103 0928--->
        and created_on > #createdate(payrollyear,1,7)#
        <!---Updated by Nieo 20180103 0928--->
        <!---Added by Nieo 20171114 1400 where assignmentslip created in previous month showing--->
        <!---<cfif form.month eq form.monthto>
        and (month(created_on) = #form.month# or month(created_on) = #form.month#+1)        
        </cfif>--->
        <!---Added by Nieo 20171114 1400 where assignmentslip created in previous month showing--->
        
        <cfif form.getcust neq "">
            and custname like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#form.getcust#%">
        </cfif> 
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

        <cfif isdefined('getplacement')>
            <cfif getplacement.recordcount neq 0>
                and placementno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#VALUELIST(getplacement.placementno)#" list="yes" separator=",">)
            </cfif>
        </cfif>
    
    ) as a
    
    LEFT JOIN
    (
        SELECT placementno as pno, location,consultant,custno as cno,custname,empname,pm,
        case when jobpostype ='1' 
        then "Temp" 
        else 
            case when jobpostype ='2' 
            then "Contract" 
            else 
                case when jobpostype ='3' 
                then "Perm" 
                else
                    case when jobpostype ='5' 
                    then "Wage Master" 
                    else "" end
                end
            end
        end as 'jobtype'    
        FROM placement
        WHERE year(completedate) >= (#getpayroll.myear#-1)
    ) as b on a.placementno = b.pno
    
    LEFT JOIN
    (
        SELECT priceid,pricename FROM manpowerpricematrix
    ) as c on b.pm = c.priceid
    
    LEFT JOIN
    (
        SELECT custno as xcustno,arrem5 FROM #target_arcust#
    ) as d
    
    on a.custno = d.xcustno
            
    LEFT JOIN
    (
        SELECT empno as pempno,case when national="MY" then "Local" else "Foreigner" end candtype FROM #replace(dts,'_i','_p')#.pmast
    ) as e
    
    on a.empno = e.pempno
            
    order by <cfif form.orderby eq 'custname'>b.<cfelseif form.orderby eq 'empno'>a.</cfif>#form.orderby#,refno
</cfquery>            
</cfif>
    
<cfquery name="getictran" datasource="#dts#">
    SELECT *,e.arrem1 dlocation,a.refno icrefno,
    case when d.jobpostype ='1' 
        then "Temp" 
        else 
            case when d.jobpostype ='2' 
            then "Contract" 
            else 
                case when d.jobpostype ='3' 
                then "Perm" 
                else
                    case when d.jobpostype ='5' 
                    then "Wage Master" 
                    else "" end
                end
            end
        end as 'xjobtype' 
    FROM ictran a
    LEFT JOIN artran b
    ON a.refno=b.refno AND a.type=b.type
    LEFT JOIN assignmentslip c
    ON a.brem6=c.refno
    LEFT JOIN placement d
    ON c.placementno=d.placementno
    LEFT JOIN arcust e
    ON a.custno=e.custno
    LEFT JOIN manpowerpricematrix f
    ON d.pm=f.priceid
    LEFT JOIN
    (
        SELECT empno as pempno,case when national="MY" then "Local" else "Foreigner" end candtype FROM #replace(dts,'_i','_p')#.pmast
    ) as g
    on c.empno = g.pempno
    WHERE 
    <!---Added by Nieo 20171117 1038 for new filter requirement--->
    a.fperiod between #form.month# and #form.monthto#
    <!---Added by Nieo 20171117 1038 for new filter requirement--->
    AND b.created_on > #createdate(payrollyear,1,7)#
    AND a.fperiod <>99
        <cfif isdefined('form.cndnonly')>
            AND a.type IN ('CN','DN')   
        <cfelseif isdefined('form.permonly')>
            AND b.rem40 IS NULL AND a.type='INV'
        <cfelse>
            AND (a.type IN ('CN','DN') OR (b.rem40 IS NULL AND a.type='INV'))
        </cfif>
    AND (a.void IS NULL OR a.void='')
    AND (b.void IS NULL OR b.void='')
    <cfif form.getfrom neq "" and form.getto neq "">
        and a.custno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.getfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.getto#">
    </cfif> 
        <cfif form.billfrom neq "" and form.billto neq "">
        and a.refno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billto#">
        </cfif> 
        <cfif form.createdfrm neq "" and form.createdto neq "">
            AND (b.created_by BETWEEN <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.createdfrm#"> AND <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.createdto#">)
        </cfif>
        <cfif form.areafrom neq "" and form.areato neq "">
            AND rem30 BETWEEN <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.areafrom#"> AND <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.areato#">
        </cfif>
        <cfif isdefined('getplacement')>
            <cfif getplacement.recordcount neq 0>
                AND (c.placementno IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#VALUELIST(getplacement.placementno)#" list="yes" separator=",">)
                OR a.brem1 IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#VALUELIST(getplacement.placementno)#" list="yes" separator=",">))
            </cfif>
        </cfif>
    ORDER BY <cfif form.orderby eq 'empno'>brem5<cfelseif form.orderby eq 'refno'>a.refno<cfelseif form.orderby eq 'assignmentslipdate'>a.wos_date<cfelseif form.orderby eq 'custname'>b.name<cfelseif form.orderby eq 'payrollperiod'>a.fperiod<cfelse>a.refno</cfif>,brem6,a.trancode
</cfquery>
          
<cfif getictran.recordcount neq 0>
<cfquery name="getplacementdetails" datasource="#dts#">
    SELECT placementno,empno,empname FROM placement 
    WHERE 
    placementno in (
        SELECT placementno FROM assignmentslip
        WHERE 
        <!---Added by Nieo 20171117 1038 for new filter requirement--->
        payrollperiod between #form.month# and #form.monthto#
        <!---Added by Nieo 20171117 1038 for new filter requirement--->
        <!---Updated by Nieo 20180103 0928--->
        and created_on > #createdate(payrollyear,1,7)#
        <!---Updated by Nieo 20180103 0928--->
    )
    or placementno in (
        SELECT brem1 FROM ictran
        WHERE (type='cn' OR type='dn' OR type='inv')
        AND fperiod<>99
        AND brem1 != ''
    )
</cfquery>
</cfif>
                
<cfset rowcount = 1>
<cfset boldlist = "">
<cfset excel = SpreadSheetNew(true)>
    <cfif isdefined('form.StaffCode')>
        <cfset temp_query = querynew('Entity,Office_Code,Batch,Invoice,Company,Cust_No,StaffCode,Associate_Type,Contract_Type,VAT,Placement_No,Price_Structures,Employee_Name,Employee_No,Refno,Period,Payrollperiod,Item_Name,Pay_Qty,Pay_Rate,Pay_Amt,Bill_Qty,Bill_Rate,Bill_Amt,Amount_remarks')>
    <cfelseif isdefined('showitemno')>
        <cfset temp_query = querynew('Entity,Office_Code,Batch,Invoice,Company,Cust_No,VAT,Placement_No,Price_Structures,Employee_Name,Employee_No,Refno,Period,Payrollperiod,Item_No,Item_Name,Pay_Qty,Pay_Rate,Pay_Amt,Bill_Qty,Bill_Rate,Bill_Amt,Amount_remarks')>
    <cfelse>
        <cfset temp_query = querynew('Entity,Office_Code,Batch,Invoice,Company,Cust_No,VAT,Placement_No,Price_Structures,Employee_Name,Employee_No,Refno,Period,Payrollperiod,Item_Name,Pay_Qty,Pay_Rate,Pay_Amt,Bill_Qty,Bill_Rate,Bill_Amt,Amount_remarks')>
    </cfif>

<!---Excel Format--->
<cfset s23 = StructNew()>                                    <!---header--->
<cfset s23.font="Arial">
<cfset s23.fontsize="11">
<cfset s23.bold="true">
<cfset s23.alignment="center">
<cfset s23.verticalalignment="vertical_bottom">

<!---<cfset s28 = StructNew()>
<cfset s28.font="Arial">
<cfset s28.fontsize="10">
<cfset s28.alignment="left">
<cfset s28.verticalalignment="vertical_bottom">
                
<cfset s29 = StructNew()>
<cfset s29.font="Arial">
<cfset s29.fontsize="10">
<cfset s29.alignment="right">
<cfset s29.verticalalignment="vertical_bottom">

<cfset s65 = StructNew()>
<cfset s65.font="Arial">
<cfset s65.fontsize="10">
<cfset s65.alignment="right">
<cfset s65.verticalalignment="vertical_bottom">
<cfset s65.dataformat="0.00">

<cfset s67 = StructNew()>
<cfset s67.dataformat="0.00">

<cfset s66 = StructNew()>
<cfset s66.font="Arial">
<cfset s66.fontsize="10">
<cfset s66.bold="true">
<cfset s66.alignment="right">
<cfset s66.verticalalignment="vertical_bottom">
<cfset s66.dataformat="0.00">--->

<!---<cfloop from="1" to="21" index="i">
    <cfset SpreadSheetSetColumnWidth(excel,#i#,18)>
</cfloop>--->

<!---Excel Format--->

<!---<cfset SpreadSheetAddRow(excel,"Entity,Office Code,Batch,Invoice,Company,Cust No,VAT,Placement No,Price Structures,Employee Name,Employee No,Refno,Period,Payroll Period,Item Name,Pay Qty,Pay Rate,Pay Amt,Bill Qty,Bill Rate,Bill Amt, ")><!---21 column--->
<cfset SpreadSheetFormatRow(excel, s23, rowcount)>
<cfset rowcount += 1>--->

<cfif isdefined('form.cndnonly') neq true and isdefined('form.permonly')  neq true>
    <cfloop query="getassignment">

        <!---<cfset startrowvalue = "#getassignment.branch#,#getassignment.location#,#getassignment.batches#,#getassignment.invoiceno#,#getassignment.custname#,#getassignment.custno#,#getassignment.arrem5#,#getassignment.placementno#,#getassignment.pricename#,#getassignment.empname#,#getassignment.empno#,#getassignment.refno#,#dateformat(getassignment.startdate,'dd/mm/yyyy')# - #dateformat(getassignment.completedate,'dd/mm/yyyy')#">--->


        <cfif val(getassignment.selfsalary) neq 0 or val(getassignment.custsalary) neq 0>     <!---For normal amount--->

            <cfif getassignment.paymenttype eq "hr">
                <cfset normalself = #numberformat(getassignment.selfsalaryhrs,'.____')#>
            <cfelseif getassignment.paymenttype eq "day">
                <cfset normalself = #numberformat(getassignment.selfsalaryday,'.____')#>
            <cfelse>
                <cfif val(getassignment.workd) neq 0>
                    
                    <cfset datediff = DateDiff("d", getassignment.startdate, getassignment.completedate) + 1>
                    
                    <cfif lcase(getassignment.cosworkday) eq 't'>
                        <cfset datediff = getassignment.selfsalaryday>
                    </cfif>
                        
                    <cfset monthprorate = ROUND((val(datediff)/val(getassignment.workd))*100000)/100000>
                    <!---<cfset monthprorate = ROUND((val(getassignment.selfsalaryday)/val(getassignment.workd))*100000)/100000>--->
                <cfelse>
                    <cfset monthprorate = 1>
                </cfif>
                <cfset normalself = #numberformat(monthprorate,'.____')#>
            </cfif>

            <cfif getassignment.paymenttype eq "hr">
                <cfset normalcust = #numberformat(getassignment.custsalaryhrs,'.____')#>
            <cfelseif getassignment.paymenttype eq "day">
                <cfset normalcust = #numberformat(getassignment.custsalaryday,'.____')#>
            <cfelse>
                <cfif val(getassignment.workd) neq 0>
                    
                    <cfset datediff = DateDiff("d", getassignment.startdate, getassignment.completedate) + 1>
                    
                    <cfif lcase(getassignment.cosworkday) eq 't'>
                        <cfset datediff = getassignment.custsalaryday>
                    </cfif>
                        
                    <cfset monthprorate = ROUND((val(datediff)/val(getassignment.workd))*100000)/100000>
                    <!---<cfset monthprorate = ROUND((val(getassignment.custsalaryday)/val(getassignment.workd))*100000)/100000>--->
                <cfelse>
                    <cfset monthprorate = 1>
                </cfif>
                <cfset normalcust = #numberformat(monthprorate,'.____')#>
            </cfif>

            <cfif numberformat(getassignment.selfsalary,'.__') gt numberformat(getassignment.custsalary,'.__')>
                <cfset normalremarks = "**">
            <cfelse>
                <cfset normalremarks = ".">
            </cfif>

            <!---<cfset SpreadSheetAddRow(excel,"#startrowvalue#,Normal,#normalself#,#numberformat(getassignment.selfusualpay,'.__')#,#numberformat(getassignment.selfsalary,'.__')#,#normalcust#,#numberformat(getassignment.custusualpay,'.__')#,#numberformat(getassignment.custsalary,'.__')#,#normalremarks#")>--->
                
            <cfif isdefined('form.StaffCode')>
                <cfset queryaddrow(temp_query, {Entity:"#getassignment.branch#",
                Office_Code:"#getassignment.location#",
                Batch:"#getassignment.batches#",
                Invoice:"#getassignment.invoiceno#",
                Company:"#getassignment.custname#",
                Cust_No:"#getassignment.custno#",
                StaffCode:"#getassignment.consultant#",
                Associate_Type:"#getassignment.candtype#",
                Contract_Type:"#getassignment.jobtype#",
                VAT:"#getassignment.arrem5#",
                Placement_No:"#getassignment.placementno#",
                Price_Structures:"#getassignment.pricename#",
                Employee_Name:"#getassignment.empname#",
                Employee_No:"#getassignment.empno#",
                Refno:"#getassignment.refno#",
                Period:"#dateformat(getassignment.startdate,'dd/mm/yyyy')#-#dateformat(getassignment.completedate,'dd/mm/yyyy')#",
                Payrollperiod:"#getassignment.payrollperiod#",
                Item_Name:"Normal",
                Pay_Qty:"#normalself#",
                Pay_Rate:"#numberformat(getassignment.selfusualpay,'.__')#",
                Pay_Amt:"#numberformat(getassignment.selfsalary,'.__')#",
                Bill_Qty:"#normalcust#",
                Bill_Rate:"#numberformat(getassignment.custusualpay,'.__')#",
                Bill_Amt:"#numberformat(getassignment.custsalary,'.__')#",
                Amount_remarks:"#normalremarks#"})>
            <cfelseif isdefined('showitemno')>
                <cfset queryaddrow(temp_query, {Entity:"#getassignment.branch#",
                Office_Code:"#getassignment.location#",
                Batch:"#getassignment.batches#",
                Invoice:"#getassignment.invoiceno#",
                Company:"#getassignment.custname#",
                Cust_No:"#getassignment.custno#",
                VAT:"#getassignment.arrem5#",
                Placement_No:"#getassignment.placementno#",
                Price_Structures:"#getassignment.pricename#",
                Employee_Name:"#getassignment.empname#",
                Employee_No:"#getassignment.empno#",
                Refno:"#getassignment.refno#",
                Period:"#dateformat(getassignment.startdate,'dd/mm/yyyy')#-#dateformat(getassignment.completedate,'dd/mm/yyyy')#",
                Payrollperiod:"#getassignment.payrollperiod#",
                Item_No:"Salary",
                Item_Name:"Normal",
                Pay_Qty:"#normalself#",
                Pay_Rate:"#numberformat(getassignment.selfusualpay,'.__')#",
                Pay_Amt:"#numberformat(getassignment.selfsalary,'.__')#",
                Bill_Qty:"#normalcust#",
                Bill_Rate:"#numberformat(getassignment.custusualpay,'.__')#",
                Bill_Amt:"#numberformat(getassignment.custsalary,'.__')#",
                Amount_remarks:"#normalremarks#"})>
            <cfelse>
                <cfset queryaddrow(temp_query, {Entity:"#getassignment.branch#",
                Office_Code:"#getassignment.location#",
                Batch:"#getassignment.batches#",
                Invoice:"#getassignment.invoiceno#",
                Company:"#getassignment.custname#",
                Cust_No:"#getassignment.custno#",
                VAT:"#getassignment.arrem5#",
                Placement_No:"#getassignment.placementno#",
                Price_Structures:"#getassignment.pricename#",
                Employee_Name:"#getassignment.empname#",
                Employee_No:"#getassignment.empno#",
                Refno:"#getassignment.refno#",
                Period:"#dateformat(getassignment.startdate,'dd/mm/yyyy')#-#dateformat(getassignment.completedate,'dd/mm/yyyy')#",
                Payrollperiod:"#getassignment.payrollperiod#",
                Item_Name:"Normal",
                Pay_Qty:"#normalself#",
                Pay_Rate:"#numberformat(getassignment.selfusualpay,'.__')#",
                Pay_Amt:"#numberformat(getassignment.selfsalary,'.__')#",
                Bill_Qty:"#normalcust#",
                Bill_Rate:"#numberformat(getassignment.custusualpay,'.__')#",
                Bill_Amt:"#numberformat(getassignment.custsalary,'.__')#",
                Amount_remarks:"#normalremarks#"})>
            </cfif>

            <!---<cfset setCellFormat(excel, #rowcount#)>--->
            <cfset rowcount += 1>        
        </cfif>

        <cfif val(getassignment.selfottotal) neq 0 or val(getassignment.custottotal) neq 0>     <!---For OT--->
            <cfloop from="1" to="8" index="a">
                <cfif val(evaluate('getassignment.selfot#a#')) neq 0 or val(evaluate('getassignment.custot#a#')) neq 0>

                    <cfif a eq 1>
                        <cfset otno = "OT1">
                        <cfset otname = "OT 1.0">
                    <cfelseif a eq 2>
                        <cfset otno = "OT15">
                        <cfset otname = "OT 1.5">
                    <cfelseif a eq 3>
                        <cfset otno = "OT2">
                        <cfset otname = "OT 2.0">
                    <cfelseif a eq 4>
                        <cfset otno = "OT3">
                        <cfset otname = "OT 3.0">
                    <cfelseif a eq 5>
                        <cfset otno = "OT5">
                        <cfset otname = "RD 1.0">
                    <cfelseif a eq 6>
                        <cfset otno = "OT6">
                        <cfset otname = "RD 2.0">
                    <cfelseif a eq 7>
                        <cfset otno = "OT7">
                        <cfset otname = "PH 1.0">
                    <cfelseif a eq 8>
                        <cfset otno = "OT8">
                        <cfset otname = "PH 2.0">
                    </cfif>

                    <cfif numberformat(evaluate('selfot#a#'),'.__') gt numberformat(evaluate('custot#a#'),'.__')>
                        <cfset otremarks = "**">
                    <cfelse>
                        <cfset otremarks = ".">
                    </cfif>

                    <!---<cfset SpreadSheetAddRow(excel,"#startrowvalue#,#otname#,#numberformat(evaluate('selfothour#a#'),'.__')#,#numberformat(evaluate('selfotrate#a#'),'.__')#,#numberformat(evaluate('selfot#a#'),'.__')#,#numberformat(evaluate('custothour#a#'),'.__')#,#numberformat(evaluate('custotrate#a#'),'.__')#,#numberformat(evaluate('custot#a#'),'.__')#,#otremarks#")>--->

                        
                    <cfif isdefined('form.StaffCode')>
                        <cfset queryaddrow(temp_query, {Entity:"#getassignment.branch#",
                        Office_Code:"#getassignment.location#",
                        Batch:"#getassignment.batches#",
                        Invoice:"#getassignment.invoiceno#",
                        Company:"#getassignment.custname#",
                        Cust_No:"#getassignment.custno#",
                        StaffCode:"#getassignment.consultant#",
                        Associate_Type:"#getassignment.candtype#",
                        Contract_Type:"#getassignment.jobtype#",
                        VAT:"#getassignment.arrem5#",
                        Placement_No:"#getassignment.placementno#",
                        Price_Structures:"#getassignment.pricename#",
                        Employee_Name:"#getassignment.empname#",
                        Employee_No:"#getassignment.empno#",
                        Refno:"#getassignment.refno#",
                        Period:"#dateformat(getassignment.startdate,'dd/mm/yyyy')#-#dateformat(getassignment.completedate,'dd/mm/yyyy')#",
                        Payrollperiod:"#getassignment.payrollperiod#",
                        Item_Name:"#otname#",
                        Pay_Qty:"#numberformat(evaluate('selfothour#a#'),'.__')#",
                        Pay_Rate:"#numberformat(evaluate('selfotrate#a#'),'.__')#",
                        Pay_Amt:"#numberformat(evaluate('selfot#a#'),'.__')#",
                        Bill_Qty:"#numberformat(evaluate('custothour#a#'),'.__')#",
                        Bill_Rate:"#numberformat(evaluate('custotrate#a#'),'.__')#",
                        Bill_Amt:"#numberformat(evaluate('custot#a#'),'.__')#",
                        Amount_remarks:"#otremarks#"})> 
                    <cfelseif isdefined('showitemno')>
                        <cfset queryaddrow(temp_query, {Entity:"#getassignment.branch#",
                        Office_Code:"#getassignment.location#",
                        Batch:"#getassignment.batches#",
                        Invoice:"#getassignment.invoiceno#",
                        Company:"#getassignment.custname#",
                        Cust_No:"#getassignment.custno#",
                        VAT:"#getassignment.arrem5#",
                        Placement_No:"#getassignment.placementno#",
                        Price_Structures:"#getassignment.pricename#",
                        Employee_Name:"#getassignment.empname#",
                        Employee_No:"#getassignment.empno#",
                        Refno:"#getassignment.refno#",
                        Period:"#dateformat(getassignment.startdate,'dd/mm/yyyy')#-#dateformat(getassignment.completedate,'dd/mm/yyyy')#",
                        Payrollperiod:"#getassignment.payrollperiod#",
                        Item_No:"#otno#",
                        Item_Name:"#otname#",
                        Pay_Qty:"#numberformat(evaluate('selfothour#a#'),'.__')#",
                        Pay_Rate:"#numberformat(evaluate('selfotrate#a#'),'.__')#",
                        Pay_Amt:"#numberformat(evaluate('selfot#a#'),'.__')#",
                        Bill_Qty:"#numberformat(evaluate('custothour#a#'),'.__')#",
                        Bill_Rate:"#numberformat(evaluate('custotrate#a#'),'.__')#",
                        Bill_Amt:"#numberformat(evaluate('custot#a#'),'.__')#",
                        Amount_remarks:"#otremarks#"})>
                    <cfelse>
                        <cfset queryaddrow(temp_query, {Entity:"#getassignment.branch#",
                        Office_Code:"#getassignment.location#",
                        Batch:"#getassignment.batches#",
                        Invoice:"#getassignment.invoiceno#",
                        Company:"#getassignment.custname#",
                        Cust_No:"#getassignment.custno#",
                        VAT:"#getassignment.arrem5#",
                        Placement_No:"#getassignment.placementno#",
                        Price_Structures:"#getassignment.pricename#",
                        Employee_Name:"#getassignment.empname#",
                        Employee_No:"#getassignment.empno#",
                        Refno:"#getassignment.refno#",
                        Period:"#dateformat(getassignment.startdate,'dd/mm/yyyy')#-#dateformat(getassignment.completedate,'dd/mm/yyyy')#",
                        Payrollperiod:"#getassignment.payrollperiod#",
                        Item_Name:"#otname#",
                        Pay_Qty:"#numberformat(evaluate('selfothour#a#'),'.__')#",
                        Pay_Rate:"#numberformat(evaluate('selfotrate#a#'),'.__')#",
                        Pay_Amt:"#numberformat(evaluate('selfot#a#'),'.__')#",
                        Bill_Qty:"#numberformat(evaluate('custothour#a#'),'.__')#",
                        Bill_Rate:"#numberformat(evaluate('custotrate#a#'),'.__')#",
                        Bill_Amt:"#numberformat(evaluate('custot#a#'),'.__')#",
                        Amount_remarks:"#otremarks#"})>
                    </cfif>
                    

                    <!---<cfset setCellFormat(excel, #rowcount#)>--->
                    <cfset rowcount += 1>

                </cfif> 
            </cfloop>
        </cfif>

        <cfloop from="1" to="6" index="a">                                                        <!---For Fix allowance--->
            <cfif val(evaluate('getassignment.fixawee#a#')) neq 0 or val(evaluate('getassignment.fixawer#a#'))>

                <!---Updated by Nieo 20171219 1628 to add qty and rate into invoices--->
                <cfif val(evaluate('getassignment.fixawee#a#')) neq 0 and val(evaluate('getassignment.fixaweeqty#a#')) neq 0>
                    <cfset fixaweeamount = val(evaluate('getassignment.fixaweeqty#a#'))>
                <cfelseif val(evaluate('getassignment.fixawee#a#')) neq 0>
                    <cfset fixaweeamount = 1.00>
                <cfelse>
                    <cfset fixaweeamount = 0.00>
                </cfif>

                <cfif val(evaluate('getassignment.fixawer#a#')) neq 0 and val(evaluate('getassignment.fixawerqty#a#')) neq 0>
                    <cfset fixaweramount = val(evaluate('getassignment.fixawerqty#a#'))>
                <cfelseif val(evaluate('getassignment.fixawer#a#')) neq 0>
                    <cfset fixaweramount = 1.00>
                <cfelse>
                    <cfset fixaweramount = 0.00>
                </cfif>
                <!---Updated by Nieo 20171219 1628 to add qty and rate into invoices--->

                <!---Updated by Nieo 20171228 to add qty and rate into invoices--->
                <cfif val(evaluate('getassignment.fixaweerate#a#')) neq 0>
                    <cfset fixaweerate = val(evaluate('getassignment.fixaweerate#a#'))>
                <cfelseif val(evaluate('getassignment.fixawee#a#')) neq 0>
                    <cfset fixaweerate = val(evaluate('getassignment.fixawee#a#'))>
                <cfelse>
                    <cfset fixaweerate = 0.00>
                </cfif>  

                <cfif val(evaluate('getassignment.fixawerrate#a#')) neq 0>
                    <cfset fixawerrate = val(evaluate('getassignment.fixawerrate#a#'))>
                <cfelseif val(evaluate('getassignment.fixawer#a#')) neq 0>
                    <cfset fixawerrate = val(evaluate('getassignment.fixawer#a#'))>
                <cfelse>
                    <cfset fixawerrate = 0.00>
                </cfif>    
                <!---Updated by Nieo 20171228 to add qty and rate into invoices--->

                <cfif numberformat(val(evaluate('getassignment.fixawee#a#')),'.__') gt numberformat(val(evaluate('getassignment.fixawer#a#')),'.__')>
                    <cfset fixawremarks = "**">
                <cfelse>
                    <cfset fixawremarks = ".">
                </cfif>

            <!---<cfset SpreadSheetAddRow(excel,"#startrowvalue#,#evaluate('fixawdesp#a#')#,#fixaweeamount#,#numberformat(val(evaluate('getassignment.fixawee#a#')),'.__')#,#numberformat(val(evaluate('getassignment.fixawee#a#')),'.__')#,#fixaweramount#,#numberformat(val(evaluate('getassignment.fixawer#a#')),'.__')#,#numberformat(val(evaluate('getassignment.fixawer#a#')),'.__')#,#fixawremarks#")>--->

            <cfif isdefined('form.StaffCode')>
                <cfset queryaddrow(temp_query, {Entity:"#getassignment.branch#",
                Office_Code:"#getassignment.location#",
                Batch:"#getassignment.batches#",
                Invoice:"#getassignment.invoiceno#",
                Company:"#getassignment.custname#",
                Cust_No:"#getassignment.custno#",
                StaffCode:"#getassignment.consultant#",
                Associate_Type:"#getassignment.candtype#",
                Contract_Type:"#getassignment.jobtype#",
                VAT:"#getassignment.arrem5#",
                Placement_No:"#getassignment.placementno#",
                Price_Structures:"#getassignment.pricename#",
                Employee_Name:"#getassignment.empname#",
                Employee_No:"#getassignment.empno#",
                Refno:"#getassignment.refno#",
                Period:"#dateformat(getassignment.startdate,'dd/mm/yyyy')#-#dateformat(getassignment.completedate,'dd/mm/yyyy')#",
                Payrollperiod:"#getassignment.payrollperiod#",
                Item_Name:"#evaluate('fixawdesp#a#')#",
                Pay_Qty:"#fixaweeamount#",
                Pay_Rate:"#numberformat(val(fixaweerate),'.__')#",
                Pay_Amt:"#numberformat(val(evaluate('getassignment.fixawee#a#')),'.__')#",
                Bill_Qty:"#fixaweramount#",
                Bill_Rate:"#numberformat(val(fixawerrate),'.__')#",
                Bill_Amt:"#numberformat(val(evaluate('getassignment.fixawer#a#')),'.__')#",
                Amount_remarks:"#fixawremarks#"})>
            <cfelseif isdefined('showitemno')>
                <cfset queryaddrow(temp_query, {Entity:"#getassignment.branch#",
                Office_Code:"#getassignment.location#",
                Batch:"#getassignment.batches#",
                Invoice:"#getassignment.invoiceno#",
                Company:"#getassignment.custname#",
                Cust_No:"#getassignment.custno#",
                VAT:"#getassignment.arrem5#",
                Placement_No:"#getassignment.placementno#",
                Price_Structures:"#getassignment.pricename#",
                Employee_Name:"#getassignment.empname#",
                Employee_No:"#getassignment.empno#",
                Refno:"#getassignment.refno#",
                Period:"#dateformat(getassignment.startdate,'dd/mm/yyyy')#-#dateformat(getassignment.completedate,'dd/mm/yyyy')#",
                Payrollperiod:"#getassignment.payrollperiod#",
                Item_No:"#evaluate('fixawcode#a#')#",
                Item_Name:"#evaluate('fixawdesp#a#')#",
                Pay_Qty:"#fixaweeamount#",
                Pay_Rate:"#numberformat(val(fixaweerate),'.__')#",
                Pay_Amt:"#numberformat(val(evaluate('getassignment.fixawee#a#')),'.__')#",
                Bill_Qty:"#fixaweramount#",
                Bill_Rate:"#numberformat(val(fixawerrate),'.__')#",
                Bill_Amt:"#numberformat(val(evaluate('getassignment.fixawer#a#')),'.__')#",
                Amount_remarks:"#fixawremarks#"})>
            <cfelse>
                <cfset queryaddrow(temp_query, {Entity:"#getassignment.branch#",
                Office_Code:"#getassignment.location#",
                Batch:"#getassignment.batches#",
                Invoice:"#getassignment.invoiceno#",
                Company:"#getassignment.custname#",
                Cust_No:"#getassignment.custno#",
                VAT:"#getassignment.arrem5#",
                Placement_No:"#getassignment.placementno#",
                Price_Structures:"#getassignment.pricename#",
                Employee_Name:"#getassignment.empname#",
                Employee_No:"#getassignment.empno#",
                Refno:"#getassignment.refno#",
                Period:"#dateformat(getassignment.startdate,'dd/mm/yyyy')#-#dateformat(getassignment.completedate,'dd/mm/yyyy')#",
                Payrollperiod:"#getassignment.payrollperiod#",
                Item_Name:"#evaluate('fixawdesp#a#')#",
                Pay_Qty:"#fixaweeamount#",
                Pay_Rate:"#numberformat(val(fixaweerate),'.__')#",
                Pay_Amt:"#numberformat(val(evaluate('getassignment.fixawee#a#')),'.__')#",
                Bill_Qty:"#fixaweramount#",
                Bill_Rate:"#numberformat(val(fixawerrate),'.__')#",
                Bill_Amt:"#numberformat(val(evaluate('getassignment.fixawer#a#')),'.__')#",
                Amount_remarks:"#fixawremarks#"})>
            </cfif>
            

            <!---<cfset setCellFormat(excel, #rowcount#)>--->
            <cfset rowcount += 1>

            </cfif>
        </cfloop>

        <cfloop from="1" to="18" index="a">                                                        <!---For allowance--->
            <cfif val(evaluate('getassignment.awee#a#')) neq 0 or val(evaluate('getassignment.awer#a#')) neq 0>

                <!---Updated by Nieo 20171219 1628 to add qty and rate into invoices--->
                <cfif val(evaluate('getassignment.awee#a#')) neq 0 and val(evaluate('getassignment.aweeqty#a#')) neq 0>
                    <cfset aweeamount = val(evaluate('getassignment.aweeqty#a#'))>
                <cfelseif val(evaluate('getassignment.awee#a#')) neq 0>
                    <cfset aweeamount = 1.00>
                <cfelse>
                    <cfset aweeamount = 0.00>
                </cfif>

                <cfif val(evaluate('getassignment.awer#a#')) neq 0 and val(evaluate('getassignment.awerqty#a#')) neq 0>
                    <cfset aweramount = val(evaluate('getassignment.awerqty#a#'))>
                <cfelseif val(evaluate('getassignment.awer#a#')) neq 0>
                    <cfset aweramount = 1.00>
                <cfelse>
                    <cfset aweramount = 0.00>
                </cfif>
                <!---Updated by Nieo 20171219 1628 to add qty and rate into invoices--->

                <!---Updated by Nieo 20171228 to add qty and rate into invoices--->
                <cfif val(evaluate('getassignment.aweerate#a#')) neq 0>
                    <cfset aweerate = val(evaluate('getassignment.aweerate#a#'))>
                <cfelseif val(evaluate('getassignment.awee#a#')) neq 0>
                    <cfset aweerate = val(evaluate('getassignment.awee#a#'))>
                <cfelse>
                    <cfset aweerate = 0.00>
                </cfif>

                <cfif val(evaluate('getassignment.awerrate#a#')) neq 0>
                    <cfset awerrate = val(evaluate('getassignment.awerrate#a#'))>
                <cfelseif val(evaluate('getassignment.awer#a#')) neq 0>
                    <cfset awerrate = val(evaluate('getassignment.awer#a#'))>
                <cfelse>
                    <cfset awerrate = 0.00>
                </cfif>
                <!---Updated by Nieo 20171228 to add qty and rate into invoices--->

                <cfif numberformat(val(evaluate('getassignment.awee#a#')),'.__') gt numberformat(val(evaluate('getassignment.awer#a#')),'.__')>
                    <cfset awremarks = "**">
                <cfelse>
                    <cfset awremarks = ".">
                </cfif>

                <!---<cfset SpreadSheetAddRow(excel,"#startrowvalue#,#evaluate('allowancedesp#a#')#,#aweeamount#,#numberformat(val(evaluate('getassignment.awee#a#')),'.__')#,#numberformat(val(evaluate('getassignment.awee#a#')),'.__')#,#aweramount#,#numberformat(val(evaluate('getassignment.awer#a#')),'.__')#,#numberformat(val(evaluate('getassignment.awer#a#')),'.__')#,#awremarks#")>--->
                        
                <cfif isdefined('form.StaffCode')>
                    <cfset queryaddrow(temp_query, {Entity:"#getassignment.branch#",
                    Office_Code:"#getassignment.location#",
                    Batch:"#getassignment.batches#",
                    Invoice:"#getassignment.invoiceno#",
                    Company:"#getassignment.custname#",
                    Cust_No:"#getassignment.custno#",
                    StaffCode:"#getassignment.consultant#",
                    Associate_Type:"#getassignment.candtype#",
                    Contract_Type:"#getassignment.jobtype#",
                    VAT:"#getassignment.arrem5#",
                    Placement_No:"#getassignment.placementno#",
                    Price_Structures:"#getassignment.pricename#",
                    Employee_Name:"#getassignment.empname#",
                    Employee_No:"#getassignment.empno#",
                    Refno:"#getassignment.refno#",
                    Period:"#dateformat(getassignment.startdate,'dd/mm/yyyy')#-#dateformat(getassignment.completedate,'dd/mm/yyyy')#",
                    Payrollperiod:"#getassignment.payrollperiod#",
                    Item_Name:"#evaluate('allowancedesp#a#')#",
                    Pay_Qty:"#aweeamount#",
                    Pay_Rate:"#numberformat(val(aweerate),'.__')#",
                    Pay_Amt:"#numberformat(val(evaluate('getassignment.awee#a#')),'.__')#",
                    Bill_Qty:"#aweramount#",
                    Bill_Rate:"#numberformat(val(awerrate),'.__')#",
                    Bill_Amt:"#numberformat(val(evaluate('getassignment.awer#a#')),'.__')#",
                    Amount_remarks:"#awremarks#"})>
                <cfelseif isdefined('showitemno')>
                    <cfset queryaddrow(temp_query, {Entity:"#getassignment.branch#",
                    Office_Code:"#getassignment.location#",
                    Batch:"#getassignment.batches#",
                    Invoice:"#getassignment.invoiceno#",
                    Company:"#getassignment.custname#",
                    Cust_No:"#getassignment.custno#",
                    VAT:"#getassignment.arrem5#",
                    Placement_No:"#getassignment.placementno#",
                    Price_Structures:"#getassignment.pricename#",
                    Employee_Name:"#getassignment.empname#",
                    Employee_No:"#getassignment.empno#",
                    Refno:"#getassignment.refno#",
                    Period:"#dateformat(getassignment.startdate,'dd/mm/yyyy')#-#dateformat(getassignment.completedate,'dd/mm/yyyy')#",
                    Payrollperiod:"#getassignment.payrollperiod#",
                    Item_No:"#evaluate('allowance#a#')#",
                    Item_Name:"#evaluate('allowancedesp#a#')#",
                    Pay_Qty:"#aweeamount#",
                    Pay_Rate:"#numberformat(val(aweerate),'.__')#",
                    Pay_Amt:"#numberformat(val(evaluate('getassignment.awee#a#')),'.__')#",
                    Bill_Qty:"#aweramount#",
                    Bill_Rate:"#numberformat(val(awerrate),'.__')#",
                    Bill_Amt:"#numberformat(val(evaluate('getassignment.awer#a#')),'.__')#",
                    Amount_remarks:"#awremarks#"})>
                <cfelse>
                    <cfset queryaddrow(temp_query, {Entity:"#getassignment.branch#",
                    Office_Code:"#getassignment.location#",
                    Batch:"#getassignment.batches#",
                    Invoice:"#getassignment.invoiceno#",
                    Company:"#getassignment.custname#",
                    Cust_No:"#getassignment.custno#",
                    VAT:"#getassignment.arrem5#",
                    Placement_No:"#getassignment.placementno#",
                    Price_Structures:"#getassignment.pricename#",
                    Employee_Name:"#getassignment.empname#",
                    Employee_No:"#getassignment.empno#",
                    Refno:"#getassignment.refno#",
                    Period:"#dateformat(getassignment.startdate,'dd/mm/yyyy')#-#dateformat(getassignment.completedate,'dd/mm/yyyy')#",
                    Payrollperiod:"#getassignment.payrollperiod#",
                    Item_Name:"#evaluate('allowancedesp#a#')#",
                    Pay_Qty:"#aweeamount#",
                    Pay_Rate:"#numberformat(val(aweerate),'.__')#",
                    Pay_Amt:"#numberformat(val(evaluate('getassignment.awee#a#')),'.__')#",
                    Bill_Qty:"#aweramount#",
                    Bill_Rate:"#numberformat(val(awerrate),'.__')#",
                    Bill_Amt:"#numberformat(val(evaluate('getassignment.awer#a#')),'.__')#",
                    Amount_remarks:"#awremarks#"})>
                </cfif>                    
                

                <!---<cfset setCellFormat(excel, #rowcount#)>--->
                <cfset rowcount += 1>
            </cfif>
        </cfloop>

        <cfloop from="1" to="10" index="a">                                                        <!---For NPL--->
            <cfif val(evaluate('getassignment.lvltotalee#a#')) neq 0 or val(evaluate('getassignment.lvltotaler#a#')) neq 0>

                <cfif val(evaluate('getassignment.lvleedayhr#a#')) neq 0>
                    <cfset eenpl = #val(evaluate('getassignment.lvleedayhr#a#'))#>
                <cfelse>
                    <cfset eenpl = 0.00>
                </cfif>

                <cfif val(evaluate('getassignment.lvlerdayhr#a#')) neq 0>
                    <cfset ernpl = #val(evaluate('getassignment.lvlerdayhr#a#'))#>
                <cfelse>
                    <cfset ernpl = "0.00">
                </cfif>

                <cfif numberformat(val(evaluate('getassignment.lvltotalee#a#')),'.__') gt numberformat(val(evaluate('getassignment.lvltotaler#a#')),'.__')>
                    <cfset nplremarks = "**">
                <cfelse>
                    <cfset nplremarks = ".">
                        </cfif>

                <!---<cfset SpreadSheetAddRow(excel,"#startrowvalue#,NPL,#eenpl#,#numberformat(val(evaluate('getassignment.lvleerate#a#')),'.__')#,#numberformat(val(evaluate('getassignment.lvltotalee#a#')),'.__')#,#ernpl#,#numberformat(val(evaluate('getassignment.lvlerrate#a#')),'.__')#,#numberformat(val(evaluate('getassignment.lvltotaler#a#')),'.__')#,#nplremarks#")>--->

                <cfif isdefined('form.StaffCode')>
                    <cfset queryaddrow(temp_query, {Entity:"#getassignment.branch#",
                    Office_Code:"#getassignment.location#",
                    Batch:"#getassignment.batches#",
                    Invoice:"#getassignment.invoiceno#",
                    Company:"#getassignment.custname#",
                    Cust_No:"#getassignment.custno#",
                    StaffCode:"#getassignment.consultant#",
                    Associate_Type:"#getassignment.candtype#",
                    Contract_Type:"#getassignment.jobtype#",
                    VAT:"#getassignment.arrem5#",
                    Placement_No:"#getassignment.placementno#",
                    Price_Structures:"#getassignment.pricename#",
                    Employee_Name:"#getassignment.empname#",
                    Employee_No:"#getassignment.empno#",
                    Refno:"#getassignment.refno#",
                    Period:"#dateformat(getassignment.startdate,'dd/mm/yyyy')#-#dateformat(getassignment.completedate,'dd/mm/yyyy')#",
                    Payrollperiod:"#getassignment.payrollperiod#",
                    Item_Name:"NPL",
                    Pay_Qty:"#eenpl#",
                    Pay_Rate:"#numberformat(val(evaluate('getassignment.lvleerate#a#')),'.__')#",
                    Pay_Amt:"#numberformat(val(evaluate('getassignment.lvltotalee#a#')),'.__')#",
                    Bill_Qty:"#ernpl#",
                    Bill_Rate:"#numberformat(val(evaluate('getassignment.lvlerrate#a#')),'.__')#",
                    Bill_Amt:"#numberformat(val(evaluate('getassignment.lvltotaler#a#')),'.__')#",
                    Amount_remarks:"#nplremarks#"})>
                <cfelseif isdefined('showitemno')>
                    <cfset queryaddrow(temp_query, {Entity:"#getassignment.branch#",
                    Office_Code:"#getassignment.location#",
                    Batch:"#getassignment.batches#",
                    Invoice:"#getassignment.invoiceno#",
                    Company:"#getassignment.custname#",
                    Cust_No:"#getassignment.custno#",
                    VAT:"#getassignment.arrem5#",
                    Placement_No:"#getassignment.placementno#",
                    Price_Structures:"#getassignment.pricename#",
                    Employee_Name:"#getassignment.empname#",
                    Employee_No:"#getassignment.empno#",
                    Refno:"#getassignment.refno#",
                    Period:"#dateformat(getassignment.startdate,'dd/mm/yyyy')#-#dateformat(getassignment.completedate,'dd/mm/yyyy')#",
                    Payrollperiod:"#getassignment.payrollperiod#",
                    Item_No:"19",
                    Item_Name:"NPL",
                    Pay_Qty:"#eenpl#",
                    Pay_Rate:"#numberformat(val(evaluate('getassignment.lvleerate#a#')),'.__')#",
                    Pay_Amt:"#numberformat(val(evaluate('getassignment.lvltotalee#a#')),'.__')#",
                    Bill_Qty:"#ernpl#",
                    Bill_Rate:"#numberformat(val(evaluate('getassignment.lvlerrate#a#')),'.__')#",
                    Bill_Amt:"#numberformat(val(evaluate('getassignment.lvltotaler#a#')),'.__')#",
                    Amount_remarks:"#nplremarks#"})>
                <cfelse>
                    <cfset queryaddrow(temp_query, {Entity:"#getassignment.branch#",
                    Office_Code:"#getassignment.location#",
                    Batch:"#getassignment.batches#",
                    Invoice:"#getassignment.invoiceno#",
                    Company:"#getassignment.custname#",
                    Cust_No:"#getassignment.custno#",
                    VAT:"#getassignment.arrem5#",
                    Placement_No:"#getassignment.placementno#",
                    Price_Structures:"#getassignment.pricename#",
                    Employee_Name:"#getassignment.empname#",
                    Employee_No:"#getassignment.empno#",
                    Refno:"#getassignment.refno#",
                    Period:"#dateformat(getassignment.startdate,'dd/mm/yyyy')#-#dateformat(getassignment.completedate,'dd/mm/yyyy')#",
                    Payrollperiod:"#getassignment.payrollperiod#",
                    Item_Name:"NPL",
                    Pay_Qty:"#eenpl#",
                    Pay_Rate:"#numberformat(val(evaluate('getassignment.lvleerate#a#')),'.__')#",
                    Pay_Amt:"#numberformat(val(evaluate('getassignment.lvltotalee#a#')),'.__')#",
                    Bill_Qty:"#ernpl#",
                    Bill_Rate:"#numberformat(val(evaluate('getassignment.lvlerrate#a#')),'.__')#",
                    Bill_Amt:"#numberformat(val(evaluate('getassignment.lvltotaler#a#')),'.__')#",
                    Amount_remarks:"#nplremarks#"})>
                </cfif>
                    
                

                <!---<cfset setCellFormat(excel, #rowcount#)>--->
                <cfset rowcount += 1>
            </cfif>
        </cfloop>

        <cfif val(getassignment.selfcpf) neq 0 or val(getassignment.custcpf) neq 0>                <!---For EPF--->

            <cfif val(getassignment.selfcpf) neq 0>
                <cfset eeepfamount = 1.00>
            <cfelse>
                <cfset eeepfamount = 0.00>
            </cfif>

            <cfif findnocase('-',getassignment.selfcpf)>
                <cfset eeepfvalue = #numberformat(val(replace(getassignment.selfcpf,'-','')),'.__')#>
            <cfelse>
                <cfset eeepfvalue = #numberformat(val(getassignment.selfcpf),'.__')# * -1>
            </cfif>

            <cfif findnocase('-',getassignment.selfcpf)>
                <cfset eeepfvalue2 = #numberformat(val(replace(getassignment.selfcpf,'-','')),'.__')#>
            <cfelse>
                <cfset eeepfvalue2 = #numberformat(val(getassignment.selfcpf),'.__')# * -1>
            </cfif>

            <cfif val(getassignment.custcpf) neq 0>
                <cfset erepfamount = 1.00>
            <cfelse>
                <cfset erepfamount = 0.00>
            </cfif>

            <cfif numberformat(val(selfcpf),'.__') gt numberformat(val(custcpf),'.__')>
                <cfset epfremarks = "**">
            <cfelse>
                <cfset epfremarks = ".">
            </cfif>

            <!---<cfset SpreadSheetAddRow(excel,"#startrowvalue#,EPF,#eeepfamount#,#eeepfvalue#,#eeepfvalue2#,#erepfamount#,#numberformat(val(getassignment.custcpf),'.__')#,#numberformat(val(getassignment.custcpf),'.__')#,#epfremarks#")>--->

            <cfif isdefined('form.StaffCode')>
                <cfset queryaddrow(temp_query, {Entity:"#getassignment.branch#",
                Office_Code:"#getassignment.location#",
                Batch:"#getassignment.batches#",
                Invoice:"#getassignment.invoiceno#",
                Company:"#getassignment.custname#",
                Cust_No:"#getassignment.custno#",
                StaffCode:"#getassignment.consultant#",
                Associate_Type:"#getassignment.candtype#",
                Contract_Type:"#getassignment.jobtype#",
                VAT:"#getassignment.arrem5#",
                Placement_No:"#getassignment.placementno#",
                Price_Structures:"#getassignment.pricename#",
                Employee_Name:"#getassignment.empname#",
                Employee_No:"#getassignment.empno#",
                Refno:"#getassignment.refno#",
                Period:"#dateformat(getassignment.startdate,'dd/mm/yyyy')#-#dateformat(getassignment.completedate,'dd/mm/yyyy')#",
                Payrollperiod:"#getassignment.payrollperiod#",
                Item_Name:"EPF",
                Pay_Qty:"#eeepfamount#",
                Pay_Rate:"#eeepfvalue#",
                Pay_Amt:"#eeepfvalue2#",
                Bill_Qty:"#erepfamount#",
                Bill_Rate:"#numberformat(val(getassignment.custcpf),'.__')#",
                Bill_Amt:"#numberformat(val(getassignment.custcpf),'.__')#",
                Amount_remarks:"#epfremarks#"})>
            <cfelseif isdefined('showitemno')>
                <cfset queryaddrow(temp_query, {Entity:"#getassignment.branch#",
                Office_Code:"#getassignment.location#",
                Batch:"#getassignment.batches#",
                Invoice:"#getassignment.invoiceno#",
                Company:"#getassignment.custname#",
                Cust_No:"#getassignment.custno#",
                VAT:"#getassignment.arrem5#",
                Placement_No:"#getassignment.placementno#",
                Price_Structures:"#getassignment.pricename#",
                Employee_Name:"#getassignment.empname#",
                Employee_No:"#getassignment.empno#",
                Refno:"#getassignment.refno#",
                Period:"#dateformat(getassignment.startdate,'dd/mm/yyyy')#-#dateformat(getassignment.completedate,'dd/mm/yyyy')#",
                Payrollperiod:"#getassignment.payrollperiod#",
                Item_No:"EPFYER",
                Item_Name:"EPF",
                Pay_Qty:"#eeepfamount#",
                Pay_Rate:"#eeepfvalue#",
                Pay_Amt:"#eeepfvalue2#",
                Bill_Qty:"#erepfamount#",
                Bill_Rate:"#numberformat(val(getassignment.custcpf),'.__')#",
                Bill_Amt:"#numberformat(val(getassignment.custcpf),'.__')#",
                Amount_remarks:"#epfremarks#"})>
            <cfelse>
                <cfset queryaddrow(temp_query, {Entity:"#getassignment.branch#",
                Office_Code:"#getassignment.location#",
                Batch:"#getassignment.batches#",
                Invoice:"#getassignment.invoiceno#",
                Company:"#getassignment.custname#",
                Cust_No:"#getassignment.custno#",
                VAT:"#getassignment.arrem5#",
                Placement_No:"#getassignment.placementno#",
                Price_Structures:"#getassignment.pricename#",
                Employee_Name:"#getassignment.empname#",
                Employee_No:"#getassignment.empno#",
                Refno:"#getassignment.refno#",
                Period:"#dateformat(getassignment.startdate,'dd/mm/yyyy')#-#dateformat(getassignment.completedate,'dd/mm/yyyy')#",
                Payrollperiod:"#getassignment.payrollperiod#",
                Item_Name:"EPF",
                Pay_Qty:"#eeepfamount#",
                Pay_Rate:"#eeepfvalue#",
                Pay_Amt:"#eeepfvalue2#",
                Bill_Qty:"#erepfamount#",
                Bill_Rate:"#numberformat(val(getassignment.custcpf),'.__')#",
                Bill_Amt:"#numberformat(val(getassignment.custcpf),'.__')#",
                Amount_remarks:"#epfremarks#"})>
            </cfif>
                
            

            <!---<cfset setCellFormat(excel, #rowcount#)>--->
            <cfset rowcount += 1>
        </cfif>

        <cfif val(getassignment.selfsdf) neq 0 or val(getassignment.custsdf) neq 0>                <!---For Socso--->

            <cfif val(getassignment.selfsdf) neq 0>
                <cfset eesocsoamount = 1.00>
            <cfelse>
                <cfset eesocsoamount = 0.00>
            </cfif>

            <cfif findnocase('-',getassignment.selfsdf)>
                <cfset eesocsovalue = #numberformat(val(replace(getassignment.selfsdf,'-','')),',.__')#>
            <cfelse>
                <cfset eesocsovalue = #numberformat(val(getassignment.selfsdf),',.__')# * -1>
            </cfif>

            <cfif findnocase('-',getassignment.selfsdf)>
                <cfset eesocsovalue2 = #numberformat(val(replace(getassignment.selfsdf,'-','')),',.__')#>
            <cfelse>
                <cfset eesocsovalue2 = #numberformat(val(getassignment.selfsdf),',.__')# * -1>
            </cfif>

            <cfif val(getassignment.custsdf) neq 0>
                <cfset ersocsoamount = 1.00>
            <cfelse>
                <cfset ersocsoamount = 0.00>
            </cfif>

            <cfif numberformat(val(selfsdf),'.__') gt numberformat(val(custsdf),'.__')>
                <cfset socsoremarks = "**">
            <cfelse>
                <cfset socsoremarks = ".">
            </cfif>

            <!---<cfset SpreadSheetAddRow(excel,"#startrowvalue#,SOCSO,#eesocsoamount#,#eesocsovalue#,#eesocsovalue2#,#ersocsoamount#,#numberformat(val(getassignment.custsdf),'.__')#,#numberformat(val(getassignment.custsdf),'.__')#,#socsoremarks#")>--->

            <cfif isdefined('form.StaffCode')>
                <cfset queryaddrow(temp_query, {Entity:"#getassignment.branch#",
                Office_Code:"#getassignment.location#",
                Batch:"#getassignment.batches#",
                Invoice:"#getassignment.invoiceno#",
                Company:"#getassignment.custname#",
                Cust_No:"#getassignment.custno#",
                StaffCode:"#getassignment.consultant#",
                Associate_Type:"#getassignment.candtype#",
                Contract_Type:"#getassignment.jobtype#",
                VAT:"#getassignment.arrem5#",
                Placement_No:"#getassignment.placementno#",
                Price_Structures:"#getassignment.pricename#",
                Employee_Name:"#getassignment.empname#",
                Employee_No:"#getassignment.empno#",
                Refno:"#getassignment.refno#",
                Period:"#dateformat(getassignment.startdate,'dd/mm/yyyy')#-#dateformat(getassignment.completedate,'dd/mm/yyyy')#",
                Payrollperiod:"#getassignment.payrollperiod#",
                Item_Name:"SOCSO",
                Pay_Qty:"#eesocsoamount#",
                Pay_Rate:"#eesocsovalue#",
                Pay_Amt:"#eesocsovalue2#",
                Bill_Qty:"#ersocsoamount#",
                Bill_Rate:"#numberformat(val(getassignment.custsdf),'.__')#",
                Bill_Amt:"#numberformat(val(getassignment.custsdf),'.__')#",
                Amount_remarks:"#socsoremarks#"})>
            <cfelseif isdefined('showitemno')>
                <cfset queryaddrow(temp_query, {Entity:"#getassignment.branch#",
                Office_Code:"#getassignment.location#",
                Batch:"#getassignment.batches#",
                Invoice:"#getassignment.invoiceno#",
                Company:"#getassignment.custname#",
                Cust_No:"#getassignment.custno#",
                VAT:"#getassignment.arrem5#",
                Placement_No:"#getassignment.placementno#",
                Price_Structures:"#getassignment.pricename#",
                Employee_Name:"#getassignment.empname#",
                Employee_No:"#getassignment.empno#",
                Refno:"#getassignment.refno#",
                Period:"#dateformat(getassignment.startdate,'dd/mm/yyyy')#-#dateformat(getassignment.completedate,'dd/mm/yyyy')#",
                Payrollperiod:"#getassignment.payrollperiod#",
                Item_No:"SOCSOYER",
                Item_Name:"SOCSO",
                Pay_Qty:"#eesocsoamount#",
                Pay_Rate:"#eesocsovalue#",
                Pay_Amt:"#eesocsovalue2#",
                Bill_Qty:"#ersocsoamount#",
                Bill_Rate:"#numberformat(val(getassignment.custsdf),'.__')#",
                Bill_Amt:"#numberformat(val(getassignment.custsdf),'.__')#",
                Amount_remarks:"#socsoremarks#"})>
            <cfelse>
                <cfset queryaddrow(temp_query, {Entity:"#getassignment.branch#",
                Office_Code:"#getassignment.location#",
                Batch:"#getassignment.batches#",
                Invoice:"#getassignment.invoiceno#",
                Company:"#getassignment.custname#",
                Cust_No:"#getassignment.custno#",
                VAT:"#getassignment.arrem5#",
                Placement_No:"#getassignment.placementno#",
                Price_Structures:"#getassignment.pricename#",
                Employee_Name:"#getassignment.empname#",
                Employee_No:"#getassignment.empno#",
                Refno:"#getassignment.refno#",
                Period:"#dateformat(getassignment.startdate,'dd/mm/yyyy')#-#dateformat(getassignment.completedate,'dd/mm/yyyy')#",
                Payrollperiod:"#getassignment.payrollperiod#",
                Item_Name:"SOCSO",
                Pay_Qty:"#eesocsoamount#",
                Pay_Rate:"#eesocsovalue#",
                Pay_Amt:"#eesocsovalue2#",
                Bill_Qty:"#ersocsoamount#",
                Bill_Rate:"#numberformat(val(getassignment.custsdf),'.__')#",
                Bill_Amt:"#numberformat(val(getassignment.custsdf),'.__')#",
                Amount_remarks:"#socsoremarks#"})>
            </cfif>
                
            

            <!---<cfset setCellFormat(excel, #rowcount#)>--->
            <cfset rowcount += 1>
        </cfif>

        <cfif isdefined('getassignment.selfeis')>   
        <cfif val(getassignment.selfeis) neq 0 or val(getassignment.custeis) neq 0>                <!---For EIS--->

            <cfif val(getassignment.selfeis) neq 0>
                <cfset eeeisamount = 1.00>
            <cfelse>
                <cfset eeeisamount = 0.00>
            </cfif>

            <cfif findnocase('-',getassignment.selfeis)>
                <cfset eeeisvalue = #numberformat(val(replace(getassignment.selfeis,'-','')),',.__')#>
            <cfelse>
                <cfset eeeisvalue = #numberformat(val(getassignment.selfeis),',.__')# * -1>
            </cfif>

            <cfif findnocase('-',getassignment.selfeis)>
                <cfset eeeisvalue2 = #numberformat(val(replace(getassignment.selfeis,'-','')),',.__')#>
            <cfelse>
                <cfset eeeisvalue2 = #numberformat(val(getassignment.selfeis),',.__')# * -1>
            </cfif>

            <cfif val(getassignment.custeis) neq 0>
                <cfset ereisamount = 1.00>
            <cfelse>
                <cfset ereisamount = 0.00>
            </cfif>

            <cfif numberformat(val(selfeis),'.__') gt numberformat(val(custeis),'.__')>
                <cfset eisremarks = "**">
            <cfelse>
                <cfset eisremarks = ".">
            </cfif>

            <!---<cfset SpreadSheetAddRow(excel,"#startrowvalue#,SOCSO,#eesocsoamount#,#eesocsovalue#,#eesocsovalue2#,#ersocsoamount#,#numberformat(val(getassignment.custsdf),'.__')#,#numberformat(val(getassignment.custsdf),'.__')#,#socsoremarks#")>--->

            <cfif isdefined('form.StaffCode')>
                <cfset queryaddrow(temp_query, {Entity:"#getassignment.branch#",
                Office_Code:"#getassignment.location#",
                Batch:"#getassignment.batches#",
                Invoice:"#getassignment.invoiceno#",
                Company:"#getassignment.custname#",
                Cust_No:"#getassignment.custno#",
                StaffCode:"#getassignment.consultant#",
                Associate_Type:"#getassignment.candtype#",
                Contract_Type:"#getassignment.jobtype#",
                VAT:"#getassignment.arrem5#",
                Placement_No:"#getassignment.placementno#",
                Price_Structures:"#getassignment.pricename#",
                Employee_Name:"#getassignment.empname#",
                Employee_No:"#getassignment.empno#",
                Refno:"#getassignment.refno#",
                Period:"#dateformat(getassignment.startdate,'dd/mm/yyyy')#-#dateformat(getassignment.completedate,'dd/mm/yyyy')#",
                Payrollperiod:"#getassignment.payrollperiod#",
                Item_Name:"EIS",
                Pay_Qty:"#eeeisamount#",
                Pay_Rate:"#eeeisvalue#",
                Pay_Amt:"#eeeisvalue2#",
                Bill_Qty:"#ereisamount#",
                Bill_Rate:"#numberformat(val(getassignment.custeis),'.__')#",
                Bill_Amt:"#numberformat(val(getassignment.custeis),'.__')#",
                Amount_remarks:"#eisremarks#"})>
            <cfelseif isdefined('showitemno')>
                <cfset queryaddrow(temp_query, {Entity:"#getassignment.branch#",
                Office_Code:"#getassignment.location#",
                Batch:"#getassignment.batches#",
                Invoice:"#getassignment.invoiceno#",
                Company:"#getassignment.custname#",
                Cust_No:"#getassignment.custno#",
                VAT:"#getassignment.arrem5#",
                Placement_No:"#getassignment.placementno#",
                Price_Structures:"#getassignment.pricename#",
                Employee_Name:"#getassignment.empname#",
                Employee_No:"#getassignment.empno#",
                Refno:"#getassignment.refno#",
                Period:"#dateformat(getassignment.startdate,'dd/mm/yyyy')#-#dateformat(getassignment.completedate,'dd/mm/yyyy')#",
                Payrollperiod:"#getassignment.payrollperiod#",
                Item_No:"EISYER",
                Item_Name:"EIS",
                Pay_Qty:"#eeeisamount#",
                Pay_Rate:"#eeeisvalue#",
                Pay_Amt:"#eeeisvalue2#",
                Bill_Qty:"#ereisamount#",
                Bill_Rate:"#numberformat(val(getassignment.custeis),'.__')#",
                Bill_Amt:"#numberformat(val(getassignment.custeis),'.__')#",
                Amount_remarks:"#eisremarks#"})>
            <cfelse>
                <cfset queryaddrow(temp_query, {Entity:"#getassignment.branch#",
                Office_Code:"#getassignment.location#",
                Batch:"#getassignment.batches#",
                Invoice:"#getassignment.invoiceno#",
                Company:"#getassignment.custname#",
                Cust_No:"#getassignment.custno#",
                VAT:"#getassignment.arrem5#",
                Placement_No:"#getassignment.placementno#",
                Price_Structures:"#getassignment.pricename#",
                Employee_Name:"#getassignment.empname#",
                Employee_No:"#getassignment.empno#",
                Refno:"#getassignment.refno#",
                Period:"#dateformat(getassignment.startdate,'dd/mm/yyyy')#-#dateformat(getassignment.completedate,'dd/mm/yyyy')#",
                Payrollperiod:"#getassignment.payrollperiod#",
                Item_Name:"EIS",
                Pay_Qty:"#eeeisamount#",
                Pay_Rate:"#eeeisvalue#",
                Pay_Amt:"#eeeisvalue2#",
                Bill_Qty:"#ereisamount#",
                Bill_Rate:"#numberformat(val(getassignment.custeis),'.__')#",
                Bill_Amt:"#numberformat(val(getassignment.custeis),'.__')#",
                Amount_remarks:"#eisremarks#"})>
            </cfif>
                
            

            <!---<cfset setCellFormat(excel, #rowcount#)>--->
            <cfset rowcount += 1>
        </cfif>
        </cfif>

        <cfif val(getassignment.adminfee) neq 0 >                                                  <!---For Admin Fee--->

            <!---<cfset SpreadSheetAddRow(excel,"#startrowvalue#,Admin Fee,0.00,0.00,0.00,1,#numberformat(val(getassignment.adminfee),'.__')#,#numberformat(val(getassignment.adminfee),'.__')#,.")>--->

            <cfif isdefined('form.StaffCode')>
                <cfset queryaddrow(temp_query, {Entity:"#getassignment.branch#",
                Office_Code:"#getassignment.location#",
                Batch:"#getassignment.batches#",
                Invoice:"#getassignment.invoiceno#",
                Company:"#getassignment.custname#",
                Cust_No:"#getassignment.custno#",
                StaffCode:"#getassignment.consultant#",
                Associate_Type:"#getassignment.candtype#",
                Contract_Type:"#getassignment.jobtype#",
                VAT:"#getassignment.arrem5#",
                Placement_No:"#getassignment.placementno#",
                Price_Structures:"#getassignment.pricename#",
                Employee_Name:"#getassignment.empname#",
                Employee_No:"#getassignment.empno#",
                Refno:"#getassignment.refno#",
                Period:"#dateformat(getassignment.startdate,'dd/mm/yyyy')#-#dateformat(getassignment.completedate,'dd/mm/yyyy')#",
                Payrollperiod:"#getassignment.payrollperiod#",
                Item_Name:"Admin Fee",
                Pay_Qty:"0.00",
                Pay_Rate:"0.00",
                Pay_Amt:"0.00",
                Bill_Qty:"1",
                Bill_Rate:"#numberformat(val(getassignment.adminfee),'.__')#",
                Bill_Amt:"#numberformat(val(getassignment.adminfee),'.__')#",
                Amount_remarks:"."})>  
            <cfelseif isdefined('showitemno')>
                <cfset queryaddrow(temp_query, {Entity:"#getassignment.branch#",
                Office_Code:"#getassignment.location#",
                Batch:"#getassignment.batches#",
                Invoice:"#getassignment.invoiceno#",
                Company:"#getassignment.custname#",
                Cust_No:"#getassignment.custno#",
                VAT:"#getassignment.arrem5#",
                Placement_No:"#getassignment.placementno#",
                Price_Structures:"#getassignment.pricename#",
                Employee_Name:"#getassignment.empname#",
                Employee_No:"#getassignment.empno#",
                Refno:"#getassignment.refno#",
                Period:"#dateformat(getassignment.startdate,'dd/mm/yyyy')#-#dateformat(getassignment.completedate,'dd/mm/yyyy')#",
                Payrollperiod:"#getassignment.payrollperiod#",
                Item_No:"adminfee",
                Item_Name:"Admin Fee",
                Pay_Qty:"0.00",
                Pay_Rate:"0.00",
                Pay_Amt:"0.00",
                Bill_Qty:"1",
                Bill_Rate:"#numberformat(val(getassignment.adminfee),'.__')#",
                Bill_Amt:"#numberformat(val(getassignment.adminfee),'.__')#",
                Amount_remarks:"."})>
            <cfelse>
                <cfset queryaddrow(temp_query, {Entity:"#getassignment.branch#",
                Office_Code:"#getassignment.location#",
                Batch:"#getassignment.batches#",
                Invoice:"#getassignment.invoiceno#",
                Company:"#getassignment.custname#",
                Cust_No:"#getassignment.custno#",
                VAT:"#getassignment.arrem5#",
                Placement_No:"#getassignment.placementno#",
                Price_Structures:"#getassignment.pricename#",
                Employee_Name:"#getassignment.empname#",
                Employee_No:"#getassignment.empno#",
                Refno:"#getassignment.refno#",
                Period:"#dateformat(getassignment.startdate,'dd/mm/yyyy')#-#dateformat(getassignment.completedate,'dd/mm/yyyy')#",
                Payrollperiod:"#getassignment.payrollperiod#",
                Item_Name:"Admin Fee",
                Pay_Qty:"0.00",
                Pay_Rate:"0.00",
                Pay_Amt:"0.00",
                Bill_Qty:"1",
                Bill_Rate:"#numberformat(val(getassignment.adminfee),'.__')#",
                Bill_Amt:"#numberformat(val(getassignment.adminfee),'.__')#",
                Amount_remarks:"."})>  
            </cfif>
            
              

            <!---<cfset setCellFormat(excel, #rowcount#)>--->
            <cfset rowcount += 1>
        </cfif>

        <cfif val(getassignment.custdeduction) neq 0 or val(getassignment.selfdeduction) neq 0>    <!---For Deduction--->

            <cfloop from="1" to="6" index="a">
                <cfif val(evaluate('getassignment.billitemamt#a#')) neq 0>

                    <!---<cfset SpreadSheetAddRow(excel,"#startrowvalue#,#evaluate('getassignment.billitemdesp#a#')#,0.00,0.00,0.00,1.00,#numberformat(val(evaluate('getassignment.billitemamt#a#')),'.__')#,#numberformat(val(evaluate('getassignment.billitemamt#a#')),'.__')#,.")>--->
                    
                    <cfif isdefined('form.StaffCode')>
                        <cfset queryaddrow(temp_query, {Entity:"#getassignment.branch#",
                        Office_Code:"#getassignment.location#",
                        Batch:"#getassignment.batches#",
                        Invoice:"#getassignment.invoiceno#",
                        Company:"#getassignment.custname#",
                        Cust_No:"#getassignment.custno#",
                        StaffCode:"#getassignment.consultant#",
                        Associate_Type:"#getassignment.candtype#",
                        Contract_Type:"#getassignment.jobtype#",
                        VAT:"#getassignment.arrem5#",
                        Placement_No:"#getassignment.placementno#",
                        Price_Structures:"#getassignment.pricename#",
                        Employee_Name:"#getassignment.empname#",
                        Employee_No:"#getassignment.empno#",
                        Refno:"#getassignment.refno#",
                        Period:"#dateformat(getassignment.startdate,'dd/mm/yyyy')#-#dateformat(getassignment.completedate,'dd/mm/yyyy')#",
                        Payrollperiod:"#getassignment.payrollperiod#",
                        Item_Name:"#evaluate('getassignment.billitemdesp#a#')#",
                        Pay_Qty:"0.00",
                        Pay_Rate:"0.00",
                        Pay_Amt:"0.00",
                        Bill_Qty:"1",
                        Bill_Rate:"#numberformat(val(evaluate('getassignment.billitemamt#a#')),'.__')#",
                        Bill_Amt:"#numberformat(val(evaluate('getassignment.billitemamt#a#')),'.__')#",
                        Amount_remarks:"."})> 
                    <cfelseif isdefined('showitemno')>
                        <cfset queryaddrow(temp_query, {Entity:"#getassignment.branch#",
                        Office_Code:"#getassignment.location#",
                        Batch:"#getassignment.batches#",
                        Invoice:"#getassignment.invoiceno#",
                        Company:"#getassignment.custname#",
                        Cust_No:"#getassignment.custno#",
                        VAT:"#getassignment.arrem5#",
                        Placement_No:"#getassignment.placementno#",
                        Price_Structures:"#getassignment.pricename#",
                        Employee_Name:"#getassignment.empname#",
                        Employee_No:"#getassignment.empno#",
                        Refno:"#getassignment.refno#",
                        Period:"#dateformat(getassignment.startdate,'dd/mm/yyyy')#-#dateformat(getassignment.completedate,'dd/mm/yyyy')#",
                        Payrollperiod:"#getassignment.payrollperiod#",
                        Item_No:"#evaluate('getassignment.billitem#a#')#",
                        Item_Name:"#evaluate('getassignment.billitemdesp#a#')#",
                        Pay_Qty:"0.00",
                        Pay_Rate:"0.00",
                        Pay_Amt:"0.00",
                        Bill_Qty:"1",
                        Bill_Rate:"#numberformat(val(evaluate('getassignment.billitemamt#a#')),'.__')#",
                        Bill_Amt:"#numberformat(val(evaluate('getassignment.billitemamt#a#')),'.__')#",
                        Amount_remarks:"."})> 
                    <cfelse>
                        <cfset queryaddrow(temp_query, {Entity:"#getassignment.branch#",
                        Office_Code:"#getassignment.location#",
                        Batch:"#getassignment.batches#",
                        Invoice:"#getassignment.invoiceno#",
                        Company:"#getassignment.custname#",
                        Cust_No:"#getassignment.custno#",
                        VAT:"#getassignment.arrem5#",
                        Placement_No:"#getassignment.placementno#",
                        Price_Structures:"#getassignment.pricename#",
                        Employee_Name:"#getassignment.empname#",
                        Employee_No:"#getassignment.empno#",
                        Refno:"#getassignment.refno#",
                        Period:"#dateformat(getassignment.startdate,'dd/mm/yyyy')#-#dateformat(getassignment.completedate,'dd/mm/yyyy')#",
                        Payrollperiod:"#getassignment.payrollperiod#",
                        Item_Name:"#evaluate('getassignment.billitemdesp#a#')#",
                        Pay_Qty:"0.00",
                        Pay_Rate:"0.00",
                        Pay_Amt:"0.00",
                        Bill_Qty:"1",
                        Bill_Rate:"#numberformat(val(evaluate('getassignment.billitemamt#a#')),'.__')#",
                        Bill_Amt:"#numberformat(val(evaluate('getassignment.billitemamt#a#')),'.__')#",
                        Amount_remarks:"."})> 
                    </cfif>
                    
                    

                    <!---<cfset setCellFormat(excel, #rowcount#)>--->
                    <cfset rowcount += 1>
                </cfif>
            </cfloop>

            <cfloop from="1" to="3" index="a">
                <cfif a eq 1>
                    <cfset a = "">
                </cfif>

                <cfif val(evaluate('getassignment.addchargeself#a#')) neq 0 or val(evaluate('getassignment.addchargecust#a#')) neq 0>

                    <cfif numberformat(val(evaluate('getassignment.addchargeself#a#')),'.__') gt numberformat(val(evaluate('getassignment.addchargecust#a#')),'.__')>
                        <cfset addchargeremarks = "**">
                    <cfelse>
                        <cfset addchargeremarks = ".">
                    </cfif>

                   <!---<cfset SpreadSheetAddRow(excel,"#startrowvalue#,#evaluate('getassignment.addchargedesp#a#')#,1.00,#numberformat(val(evaluate('getassignment.addchargeself#a#')),'.__')#,#numberformat(val(evaluate('getassignment.addchargeself#a#')),'.__')#,1.00,#numberformat(val(evaluate('getassignment.addchargecust#a#')),'.__')#,#numberformat(val(evaluate('getassignment.addchargecust#a#')),'.__')#,#addchargeremarks#")>--->

                    <cfif isdefined('form.StaffCode')>
                        <cfset queryaddrow(temp_query, {Entity:"#getassignment.branch#",
                        Office_Code:"#getassignment.location#",
                        Batch:"#getassignment.batches#",
                        Invoice:"#getassignment.invoiceno#",
                        Company:"#getassignment.custname#",
                        Cust_No:"#getassignment.custno#",
                        StaffCode:"#getassignment.consultant#",
                        Associate_Type:"#getassignment.candtype#",
                        Contract_Type:"#getassignment.jobtype#",
                        VAT:"#getassignment.arrem5#",
                        Placement_No:"#getassignment.placementno#",
                        Price_Structures:"#getassignment.pricename#",
                        Employee_Name:"#getassignment.empname#",
                        Employee_No:"#getassignment.empno#",
                        Refno:"#getassignment.refno#",
                        Period:"#dateformat(getassignment.startdate,'dd/mm/yyyy')#-#dateformat(getassignment.completedate,'dd/mm/yyyy')#",
                        Payrollperiod:"#getassignment.payrollperiod#",
                        Item_Name:"#evaluate('getassignment.addchargedesp#a#')#",
                        Pay_Qty:"1.00",
                        Pay_Rate:"#numberformat(val(evaluate('getassignment.addchargeself#a#')),'.__')#",
                        Pay_Amt:"#numberformat(val(evaluate('getassignment.addchargeself#a#')),'.__')#",
                        Bill_Qty:"1",
                        Bill_Rate:"#numberformat(val(evaluate('getassignment.addchargecust#a#')),'.__')#",
                        Bill_Amt:"#numberformat(val(evaluate('getassignment.addchargecust#a#')),'.__')#",
                        Amount_remarks:"#addchargeremarks#"})>
                    <cfelseif isdefined('showitemno')>
                        <cfset queryaddrow(temp_query, {Entity:"#getassignment.branch#",
                        Office_Code:"#getassignment.location#",
                        Batch:"#getassignment.batches#",
                        Invoice:"#getassignment.invoiceno#",
                        Company:"#getassignment.custname#",
                        Cust_No:"#getassignment.custno#",
                        VAT:"#getassignment.arrem5#",
                        Placement_No:"#getassignment.placementno#",
                        Price_Structures:"#getassignment.pricename#",
                        Employee_Name:"#getassignment.empname#",
                        Employee_No:"#getassignment.empno#",
                        Refno:"#getassignment.refno#",
                        Period:"#dateformat(getassignment.startdate,'dd/mm/yyyy')#-#dateformat(getassignment.completedate,'dd/mm/yyyy')#",
                        Payrollperiod:"#getassignment.payrollperiod#",
                        Item_No:"#evaluate('getassignment.addchargecode#a#')#",
                        Item_Name:"#evaluate('getassignment.addchargedesp#a#')#",
                        Pay_Qty:"1.00",
                        Pay_Rate:"#numberformat(val(evaluate('getassignment.addchargeself#a#')),'.__')#",
                        Pay_Amt:"#numberformat(val(evaluate('getassignment.addchargeself#a#')),'.__')#",
                        Bill_Qty:"1",
                        Bill_Rate:"#numberformat(val(evaluate('getassignment.addchargecust#a#')),'.__')#",
                        Bill_Amt:"#numberformat(val(evaluate('getassignment.addchargecust#a#')),'.__')#",
                        Amount_remarks:"#addchargeremarks#"})> 
                    <cfelse>
                        <cfset queryaddrow(temp_query, {Entity:"#getassignment.branch#",
                        Office_Code:"#getassignment.location#",
                        Batch:"#getassignment.batches#",
                        Invoice:"#getassignment.invoiceno#",
                        Company:"#getassignment.custname#",
                        Cust_No:"#getassignment.custno#",
                        VAT:"#getassignment.arrem5#",
                        Placement_No:"#getassignment.placementno#",
                        Price_Structures:"#getassignment.pricename#",
                        Employee_Name:"#getassignment.empname#",
                        Employee_No:"#getassignment.empno#",
                        Refno:"#getassignment.refno#",
                        Period:"#dateformat(getassignment.startdate,'dd/mm/yyyy')#-#dateformat(getassignment.completedate,'dd/mm/yyyy')#",
                        Payrollperiod:"#getassignment.payrollperiod#",
                        Item_Name:"#evaluate('getassignment.addchargedesp#a#')#",
                        Pay_Qty:"1.00",
                        Pay_Rate:"#numberformat(val(evaluate('getassignment.addchargeself#a#')),'.__')#",
                        Pay_Amt:"#numberformat(val(evaluate('getassignment.addchargeself#a#')),'.__')#",
                        Bill_Qty:"1",
                        Bill_Rate:"#numberformat(val(evaluate('getassignment.addchargecust#a#')),'.__')#",
                        Bill_Amt:"#numberformat(val(evaluate('getassignment.addchargecust#a#')),'.__')#",
                        Amount_remarks:"#addchargeremarks#"})> 
                    </cfif>
                        
                    

                    <!---<cfset setCellFormat(excel, #rowcount#)>--->
                    <cfset rowcount += 1>
                </cfif>
            </cfloop>

        </cfif>

        <cfif numberformat(getassignment.selftotal,'.__') gt numberformat(getassignment.custtotalgross,'.__')>
            <cfset totalremarks = "Err">
        <cfelse>
            <cfset totalremarks = ".">
        </cfif>

        <!---<cfset SpreadSheetAddRow(excel,"#startrowvalue#,,,,#numberformat(getassignment.selftotal,'.__')#,,,#numberformat(getassignment.custtotalgross,'.__')#,#totalremarks#")>--->

        <cfif isdefined('form.StaffCode')>
            <cfset queryaddrow(temp_query, {Entity:"#getassignment.branch#",
            Office_Code:"#getassignment.location#",
            Batch:"#getassignment.batches#",
            Invoice:"#getassignment.invoiceno#",
            Company:"#getassignment.custname#",
            Cust_No:"#getassignment.custno#",
            StaffCode:"#getassignment.consultant#",
            Associate_Type:"#getassignment.candtype#",
            Contract_Type:"#getassignment.jobtype#",
            VAT:"#getassignment.arrem5#",
            Placement_No:"#getassignment.placementno#",
            Price_Structures:"#getassignment.pricename#",
            Employee_Name:"#getassignment.empname#",
            Employee_No:"#getassignment.empno#",
            Refno:"#getassignment.refno#",
            Period:"#dateformat(getassignment.startdate,'dd/mm/yyyy')#-#dateformat(getassignment.completedate,'dd/mm/yyyy')#",
            Payrollperiod:"#getassignment.payrollperiod#",
            Item_Name:"",
            Pay_Qty:"",
            Pay_Rate:"",
            Pay_Amt:"#numberformat(getassignment.selftotal,'.__')#",
            Bill_Qty:"",
            Bill_Rate:"",
            Bill_Amt:"#numberformat(getassignment.custtotalgross,'.__')#",
            Amount_remarks:"#totalremarks#"})>
        <cfelseif isdefined('showitemno')>
            <cfset queryaddrow(temp_query, {Entity:"#getassignment.branch#",
            Office_Code:"#getassignment.location#",
            Batch:"#getassignment.batches#",
            Invoice:"#getassignment.invoiceno#",
            Company:"#getassignment.custname#",
            Cust_No:"#getassignment.custno#",
            VAT:"#getassignment.arrem5#",
            Placement_No:"#getassignment.placementno#",
            Price_Structures:"#getassignment.pricename#",
            Employee_Name:"#getassignment.empname#",
            Employee_No:"#getassignment.empno#",
            Refno:"#getassignment.refno#",
            Period:"#dateformat(getassignment.startdate,'dd/mm/yyyy')#-#dateformat(getassignment.completedate,'dd/mm/yyyy')#",
            Payrollperiod:"#getassignment.payrollperiod#",
            Item_No:"",
            Item_Name:"",
            Pay_Qty:"",
            Pay_Rate:"",
            Pay_Amt:"#numberformat(getassignment.selftotal,'.__')#",
            Bill_Qty:"",
            Bill_Rate:"",
            Bill_Amt:"#numberformat(getassignment.custtotalgross,'.__')#",
            Amount_remarks:"#totalremarks#"})>
        <cfelse>
            <cfset queryaddrow(temp_query, {Entity:"#getassignment.branch#",
            Office_Code:"#getassignment.location#",
            Batch:"#getassignment.batches#",
            Invoice:"#getassignment.invoiceno#",
            Company:"#getassignment.custname#",
            Cust_No:"#getassignment.custno#",
            VAT:"#getassignment.arrem5#",
            Placement_No:"#getassignment.placementno#",
            Price_Structures:"#getassignment.pricename#",
            Employee_Name:"#getassignment.empname#",
            Employee_No:"#getassignment.empno#",
            Refno:"#getassignment.refno#",
            Period:"#dateformat(getassignment.startdate,'dd/mm/yyyy')#-#dateformat(getassignment.completedate,'dd/mm/yyyy')#",
            Payrollperiod:"#getassignment.payrollperiod#",
            Item_Name:"",
            Pay_Qty:"",
            Pay_Rate:"",
            Pay_Amt:"#numberformat(getassignment.selftotal,'.__')#",
            Bill_Qty:"",
            Bill_Rate:"",
            Bill_Amt:"#numberformat(getassignment.custtotalgross,'.__')#",
            Amount_remarks:"#totalremarks#"})>
        </cfif>
            
        

        <!---<cfset setCellFormat(excel, #rowcount#)>
        <cfset SpreadSheetFormatCell(excel, s66, #rowcount#, 17)>
        <cfset SpreadSheetFormatCell(excel, s66, #rowcount#, 20)>--->
        <cfset boldlist = #ListAppend(boldlist, "#rowcount#", ',')#>
        <cfset rowcount += 1>

        <!---<cfset SpreadSheetAddRow(excel, " ")>--->
            
        <cfif isdefined('form.StaffCode')>
            <cfset queryaddrow(temp_query, {Entity:"",
            Office_Code:"",
            Batch:"",
            Invoice:"",
            Company:"",
            Cust_No:"",
            StaffCode:"",
            Associate_Type:"",
            Contract_Type:"",
            VAT:"",
            Placement_No:"",
            Price_Structures:"",
            Employee_Name:"",
            Employee_No:"",
            Refno:"",
            Period:"",
            Payrollperiod:"",
            Item_Name:"",
            Pay_Qty:"",
            Pay_Rate:"",
            Pay_Amt:"",
            Bill_Qty:"",
            Bill_Rate:"",
            Bill_Amt:"",
            Amount_remarks:""})>
        <cfelseif isdefined('showitemno')>
            <cfset queryaddrow(temp_query, {Entity:"",
            Office_Code:"",
            Batch:"",
            Invoice:"",
            Company:"",
            Cust_No:"",
            VAT:"",
            Placement_No:"",
            Price_Structures:"",
            Employee_Name:"",
            Employee_No:"",
            Refno:"",
            Period:"",
            Payrollperiod:"",
            Item_No:"",
            Item_Name:"",
            Pay_Qty:"",
            Pay_Rate:"",
            Pay_Amt:"",
            Bill_Qty:"",
            Bill_Rate:"",
            Bill_Amt:"",
            Amount_remarks:""})>
        <cfelse>
            <cfset queryaddrow(temp_query, {Entity:"",
            Office_Code:"",
            Batch:"",
            Invoice:"",
            Company:"",
            Cust_No:"",
            VAT:"",
            Placement_No:"",
            Price_Structures:"",
            Employee_Name:"",
            Employee_No:"",
            Refno:"",
            Period:"",
            Payrollperiod:"",
            Item_Name:"",
            Pay_Qty:"",
            Pay_Rate:"",
            Pay_Amt:"",
            Bill_Qty:"",
            Bill_Rate:"",
            Bill_Amt:"",
            Amount_remarks:""})>
        </cfif>
        

        <cfset rowcount += 1>

        <cfset totalpay += val(getassignment.selftotal)>
        <cfset totalbill += val(getassignment.custtotalgross)>

    </cfloop>
</cfif>

<cfif getictran.recordcount neq 0 and isdefined('form.assignonly') neq true>
    <cfset subtotal=0.00>
    
    <cfloop query="getictran">
        
        
        <cfset clientname = "#getictran.name#">
        
        <cfif left(getictran.refno,1) eq '5' or mid(getictran.refno,3,1) eq '5'>
            <cfset entity =  "MSS">
        <cfelseif left(getictran.refno,1) eq '6' or mid(getictran.refno,3,1) eq '6'>
            <cfset entity =  "MBS">
        <cfelseif left(getictran.refno,1) eq '2' or mid(getictran.refno,3,1) eq '2'>
            <cfset entity =  "TC">
        <cfelse>
            <cfset entity =  "APMR">
        </cfif>

        <cfif getictran.brem1 neq ''>
            <cfquery name="getplacementno" dbtype="query">
                SELECT * FROM getplacementdetails 
                WHERE placementno='#getictran.brem1#'
            </cfquery>
            <cfset placementJo = "#getictran.brem1#">
            <cfquery name="getpricename" datasource="#dts#">
                SELECT pricename FROM manpowerpricematrix 
                WHERE priceid="#getictran.pm#"
            </cfquery>
            <cfset pricestruct = "#getpricename.pricename#">
            <cfset xempname = getplacementno.empname>
            <cfset xempno = getplacementno.empno>
        <cfelse>
            <cfset placementJo = "#getictran.placementno#">
            <cfset pricestruct = "#getictran.pricename#">
            <cfset xempname = getictran.empname>
            <cfset xempno = getictran.empno>
        </cfif>
                
        <cfset xperiod = getictran.brem3>
            
        <cfif isdefined('form.StaffCode')>
            <cfset queryaddrow(temp_query, {Entity:"#entity#",
            Office_Code:"#getictran.dlocation#",
            Batch:"",
            Invoice:"#getictran.icrefno#",
            Company:"#clientname#",
            Cust_No:"#getictran.custno#",
            StaffCode:"#getictran.consultant#",
            Associate_Type:"#getictran.candtype#",
            Contract_Type:"#getictran.xjobtype#",
            VAT:"#getictran.arrem5#",
            Placement_No:"#placementJo#",
            Price_Structures:"#pricestruct#",
            Employee_Name:"#xempname#",
            Employee_No:"#xempno#",
            Refno:"#getictran.brem6#",
            Period:"#xperiod#",
            Payrollperiod:"#getictran.fperiod#",
            Item_Name:"#getictran.desp#",
            Pay_Qty:"0.00",
            Pay_Rate:"0.00",
            Pay_Amt:"0.00",
            Bill_Qty:"#numberformat(getictran.qty,'_.__')#",
            Bill_Rate:"#numberformat(getictran.price,'_.__')#",
            Bill_Amt:"#numberformat(getictran.amt_bil,'_.__')#",
            Amount_remarks:"."})>
        <cfelseif isdefined('showitemno')>
            <cfset queryaddrow(temp_query, {Entity:"#entity#",
            Office_Code:"#getictran.dlocation#",
            Batch:"",
            Invoice:"#getictran.icrefno#",
            Company:"#clientname#",
            Cust_No:"#getictran.custno#",
            VAT:"#getictran.arrem5#",
            Placement_No:"#placementJo#",
            Price_Structures:"#pricestruct#",
            Employee_Name:"#xempname#",
            Employee_No:"#xempno#",
            Refno:"#getictran.brem6#",
            Period:"#xperiod#",
            Payrollperiod:"#getictran.fperiod#",
            Item_No:"#getictran.itemno#",
            Item_Name:"#getictran.desp#",
            Pay_Qty:"0.00",
            Pay_Rate:"0.00",
            Pay_Amt:"0.00",
            Bill_Qty:"#numberformat(getictran.qty,'_.__')#",
            Bill_Rate:"#numberformat(getictran.price,'_.__')#",
            Bill_Amt:"#numberformat(getictran.amt_bil,'_.__')#",
            Amount_remarks:"."})>
        <cfelse>
            <cfset queryaddrow(temp_query, {Entity:"#entity#",
            Office_Code:"#getictran.dlocation#",
            Batch:"",
            Invoice:"#getictran.icrefno#",
            Company:"#clientname#",
            Cust_No:"#getictran.custno#",
            VAT:"#getictran.arrem5#",
            Placement_No:"#placementJo#",
            Price_Structures:"#pricestruct#",
            Employee_Name:"#xempname#",
            Employee_No:"#xempno#",
            Refno:"#getictran.brem6#",
            Period:"#xperiod#",
            Payrollperiod:"#getictran.fperiod#",
            Item_Name:"#getictran.desp#",
            Pay_Qty:"0.00",
            Pay_Rate:"0.00",
            Pay_Amt:"0.00",
            Bill_Qty:"#numberformat(getictran.qty,'_.__')#",
            Bill_Rate:"#numberformat(getictran.price,'_.__')#",
            Bill_Amt:"#numberformat(getictran.amt_bil,'_.__')#",
            Amount_remarks:"."})>
        </cfif>
            
        
        
        <cfset rowcount += 1>
        <cfset subtotal += val(getictran.amt_bil)>

        <cfif getictran.brem6[getictran.currentrow]  neq getictran.brem6[getictran.currentrow+1] or getictran.refno[getictran.currentrow]  neq getictran.refno[getictran.currentrow+1] or getictran.brem1[getictran.currentrow]  neq getictran.brem1[getictran.currentrow+1]> 
            
            <cfif isdefined('form.StaffCode')>
                <cfset queryaddrow(temp_query, {Entity:"#entity#",
                Office_Code:"#getictran.dlocation#",
                Batch:"",
                Invoice:"#getictran.icrefno#",
                Company:"#clientname#",
                Cust_No:"#getictran.custno#",
                StaffCode:"#getictran.consultant#",
                Associate_Type:"#getictran.candtype#",
                Contract_Type:"#getictran.xjobtype#",
                VAT:"#getictran.arrem5#",
                Placement_No:"#placementJo#",
                Price_Structures:"#pricestruct#",
                Employee_Name:"#xempname#",
                Employee_No:"#xempno#",
                Refno:"#getictran.brem6#",
                Period:"#xperiod#",
                Payrollperiod:"#getictran.fperiod#",
                Item_Name:"",
                Pay_Qty:"",
                Pay_Rate:"",
                Pay_Amt:"0.00",
                Bill_Qty:"",
                Bill_Rate:"",
                Bill_Amt:"#numberformat(subtotal,'_.__')#",
                Amount_remarks:"."})>
            <cfelseif isdefined('showitemno')>
                <cfset queryaddrow(temp_query, {Entity:"#entity#",
                Office_Code:"#getictran.dlocation#",
                Batch:"",
                Invoice:"#getictran.icrefno#",
                Company:"#clientname#",
                Cust_No:"#getictran.custno#",
                VAT:"#getictran.arrem5#",
                Placement_No:"#placementJo#",
                Price_Structures:"#pricestruct#",
                Employee_Name:"#xempname#",
                Employee_No:"#xempno#",
                Refno:"#getictran.brem6#",
                Period:"#xperiod#",
                Payrollperiod:"#getictran.fperiod#",
                Item_No:"",
                Item_Name:"",
                Pay_Qty:"",
                Pay_Rate:"",
                Pay_Amt:"0.00",
                Bill_Qty:"",
                Bill_Rate:"",
                Bill_Amt:"#numberformat(subtotal,'_.__')#",
                Amount_remarks:"."})>
            <cfelse>
                <cfset queryaddrow(temp_query, {Entity:"#entity#",
                Office_Code:"#getictran.dlocation#",
                Batch:"",
                Invoice:"#getictran.icrefno#",
                Company:"#clientname#",
                Cust_No:"#getictran.custno#",
                VAT:"#getictran.arrem5#",
                Placement_No:"#placementJo#",
                Price_Structures:"#pricestruct#",
                Employee_Name:"#xempname#",
                Employee_No:"#xempno#",
                Refno:"#getictran.brem6#",
                Period:"#xperiod#",
                Payrollperiod:"#getictran.fperiod#",
                Item_Name:"",
                Pay_Qty:"",
                Pay_Rate:"",
                Pay_Amt:"0.00",
                Bill_Qty:"",
                Bill_Rate:"",
                Bill_Amt:"#numberformat(subtotal,'_.__')#",
                Amount_remarks:"."})>
            </cfif>
        
            
            
            <cfset boldlist = #ListAppend(boldlist, "#rowcount#", ',')#>
            <cfset rowcount += 1>
            
            <cfif isdefined('form.StaffCode')>
                <cfset queryaddrow(temp_query, {Entity:"",
                Office_Code:"",
                Batch:"",
                Invoice:"",
                Company:"",
                Cust_No:"",
                StaffCode:"",
                Associate_Type:"",
                Contract_Type:"",
                VAT:"",
                Placement_No:"",
                Price_Structures:"",
                Employee_Name:"",
                Employee_No:"",
                Refno:"",
                Period:"",
                Payrollperiod:"",
                Item_Name:"",
                Pay_Qty:"",
                Pay_Rate:"",
                Pay_Amt:"",
                Bill_Qty:"",
                Bill_Rate:"",
                Bill_Amt:"",
                Amount_remarks:""})>
            <cfelseif isdefined('showitemno')>
                <cfset queryaddrow(temp_query, {Entity:"",
                Office_Code:"",
                Batch:"",
                Invoice:"",
                Company:"",
                Cust_No:"",
                VAT:"",
                Placement_No:"",
                Price_Structures:"",
                Employee_Name:"",
                Employee_No:"",
                Refno:"",
                Period:"",
                Payrollperiod:"",
                Item_No:"",
                Item_Name:"",
                Pay_Qty:"",
                Pay_Rate:"",
                Pay_Amt:"",
                Bill_Qty:"",
                Bill_Rate:"",
                Bill_Amt:"",
                Amount_remarks:""})>
            <cfelse>
                <cfset queryaddrow(temp_query, {Entity:"",
                Office_Code:"",
                Batch:"",
                Invoice:"",
                Company:"",
                Cust_No:"",
                VAT:"",
                Placement_No:"",
                Price_Structures:"",
                Employee_Name:"",
                Employee_No:"",
                Refno:"",
                Period:"",
                Payrollperiod:"",
                Item_Name:"",
                Pay_Qty:"",
                Pay_Rate:"",
                Pay_Amt:"",
                Bill_Qty:"",
                Bill_Rate:"",
                Bill_Amt:"",
                Amount_remarks:""})>
            </cfif>
                
            
            
            <cfset rowcount += 1>
                
            <cfset totalbill += val(subtotal)>
            <cfset subtotal =0.00>
        </cfif>

    </cfloop>
</cfif>

<cfif totalpay neq 0.00 and totalbill neq 0.00>

    <!---<cfset SpreadSheetAddRow(excel," ,,,,,,,,,,,,,Total,,,#numberformat(totalpay,'.__')#,,,#numberformat(totalbill,'.__')#,")>--->
    
    <cfif isdefined('form.StaffCode')>
        <cfset queryaddrow(temp_query, {Entity:"",
        Office_Code:"",
        Batch:"",
        Invoice:"",
        Company:"",
        Cust_No:"",
        StaffCode:"",
        Associate_Type:"",
        Contract_Type:"",
        VAT:"",
        Placement_No:"",
        Price_Structures:"",
        Employee_Name:"",
        Employee_No:"",
        Refno:"",
        Period:"",
        Payrollperiod:"",
        Item_Name:"Total",
        Pay_Qty:"",
        Pay_Rate:"",
        Pay_Amt:"#numberformat(totalpay,'.__')#",
        Bill_Qty:"",
        Bill_Rate:"",
        Bill_Amt:"#numberformat(totalbill,'.__')#",
        Amount_remarks:""})>
    <cfelseif isdefined('showitemno')>
        <cfset queryaddrow(temp_query, {Entity:"",
        Office_Code:"",
        Batch:"",
        Invoice:"",
        Company:"",
        Cust_No:"",
        VAT:"",
        Placement_No:"",
        Price_Structures:"",
        Employee_Name:"",
        Employee_No:"",
        Refno:"",
        Period:"",
        Payrollperiod:"",
        Item_No:"",
        Item_Name:"Total",
        Pay_Qty:"",
        Pay_Rate:"",
        Pay_Amt:"#numberformat(totalpay,'.__')#",
        Bill_Qty:"",
        Bill_Rate:"",
        Bill_Amt:"#numberformat(totalbill,'.__')#",
        Amount_remarks:""})>
    <cfelse>
        <cfset queryaddrow(temp_query, {Entity:"",
        Office_Code:"",
        Batch:"",
        Invoice:"",
        Company:"",
        Cust_No:"",
        VAT:"",
        Placement_No:"",
        Price_Structures:"",
        Employee_Name:"",
        Employee_No:"",
        Refno:"",
        Period:"",
        Payrollperiod:"",
        Item_Name:"Total",
        Pay_Qty:"",
        Pay_Rate:"",
        Pay_Amt:"#numberformat(totalpay,'.__')#",
        Bill_Qty:"",
        Bill_Rate:"",
        Bill_Amt:"#numberformat(totalbill,'.__')#",
        Amount_remarks:""})>
    </cfif>
    
    
    <!---<cfset SpreadSheetFormatCell(excel, s66, #rowcount#, 17)>
    <cfset SpreadSheetFormatCell(excel, s66, #rowcount#, 20)>--->
    
    <cfset boldlist = #ListAppend(boldlist, "#val(rowcount)#", ',')#>

</cfif>

<!---<cfif #temp_query.recordcount# LTE 2000>
    <cfloop query="temp_query">
        <cfset SpreadSheetAddRow(excel,"'#temp_query.entity#','#temp_query.office_code#','#temp_query.batch#','#temp_query.invoice#','#temp_query.company#','#temp_query.cust_no#','#temp_query.vat#','#temp_query.placement_no#','#temp_query.price_structures#','#temp_query.employee_name#','#temp_query.employee_no#','#temp_query.refno#','#temp_query.period#','#temp_query.item_name#','#temp_query.pay_qty#','#temp_query.pay_rate#','#temp_query.pay_amt#','#temp_query.bill_qty#','#temp_query.bill_rate#','#temp_query.bill_amt#','#temp_query.amount_remarks#'")>
        
        <cfset setCellFormat(excel, #temp_query.currentrow#)>
    </cfloop>
    
    <cfloop list="#boldlist#" index="i">
        <cfset SpreadSheetFormatCell(excel, s66, #i#, 17)>
        <cfset SpreadSheetFormatCell(excel, s66, #i#, 20)>
    </cfloop>
<cfelse>
    <cfset SpreadSheetAddRows(excel, temp_query)>
    <cfset SpreadSheetFormatColumns(excel, s67, "17,20")>
</cfif>--->

<!---<cfset SpreadSheetAddRows(excel, temp_query)>--->
<cfset timenow = "#DateTimeFormat(now(), 'yyyy-mm-dd_hhnnss')#">
    
<cfspreadsheet action="write" filename="#HRootPath#\Excel_Report\Pay&Bill_#timenow#.xlsx" query="temp_query" overwrite="true">

<cfheader name="Content-Disposition" value="inline; filename=Pay&Bill_#timenow#.xlsx">
<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\Pay&Bill_#timenow#.xlsx">

</cfoutput>

<cffunction name="setCellFormat" access="public">
    <cfargument name="excel_object">
    <cfargument name="row">
    
    <!---<cfloop from="1" to="21" index="i">
        <cfif (#i# GTE '1' AND #i# LTE '9') OR (#i# EQ '14') OR (#i# EQ '21')>
            <cfset SpreadSheetFormatCell(#excel_object#, s28, #row#, #i#)>
        <cfelseif #i# GTE '10' AND #i# LTE '13'>
            <cfset SpreadSheetFormatCell(#excel_object#, s29, #row#, #i#)>
        <cfelseif #i# GTE '14' AND #i# LTE '20'>
            <cfset SpreadSheetFormatCell(#excel_object#, s65, #row#, #i#)>
        </cfif>
        <cfset SpreadSheetSetRowHeight(#excel_object#, #row#, 11)> 
    </cfloop>--->
    <!---<cfset SpreadSheetFormatCell(#excel_object#, s28, #row#, 1)>
    <cfset SpreadSheetFormatCell(#excel_object#, s28, #row#, 2)>
    <cfset SpreadSheetFormatCell(#excel_object#, s28, #row#, 3)>
    <cfset SpreadSheetFormatCell(#excel_object#, s28, #row#, 4)>
    <cfset SpreadSheetFormatCell(#excel_object#, s28, #row#, 5)>
    <cfset SpreadSheetFormatCell(#excel_object#, s28, #row#, 6)>
    <cfset SpreadSheetFormatCell(#excel_object#, s28, #row#, 7)>
    <cfset SpreadSheetFormatCell(#excel_object#, s28, #row#, 8)>
    <cfset SpreadSheetFormatCell(#excel_object#, s28, #row#, 9)>
    <cfset SpreadSheetFormatCell(#excel_object#, s28, #row#, 14)>
    <cfset SpreadSheetFormatCell(#excel_object#, s28, #row#, 21)>
    <cfset SpreadSheetFormatCell(#excel_object#, s29, #row#, 10)>
    <cfset SpreadSheetFormatCell(#excel_object#, s29, #row#, 11)>
    <cfset SpreadSheetFormatCell(#excel_object#, s29, #row#, 12)>
    <cfset SpreadSheetFormatCell(#excel_object#, s29, #row#, 13)>
    <cfset SpreadSheetFormatCell(#excel_object#, s65, #row#, 14)>
    <cfset SpreadSheetFormatCell(#excel_object#, s65, #row#, 15)>
    <cfset SpreadSheetFormatCell(#excel_object#, s65, #row#, 16)>
    <cfset SpreadSheetFormatCell(#excel_object#, s65, #row#, 17)>
    <cfset SpreadSheetFormatCell(#excel_object#, s65, #row#, 18)>
    <cfset SpreadSheetFormatCell(#excel_object#, s65, #row#, 19)>
    <cfset SpreadSheetFormatCell(#excel_object#, s65, #row#, 20)>
    <cfset SpreadSheetSetRowHeight(#excel_object#, #row#, 11)>--->
    <cfset SpreadSheetFormatCellRange(#excel_object#, s28, #row#, 1, #row#, 9)>
    <cfset SpreadSheetFormatCellRange(#excel_object#, s28, #row#, 14, #row#, 14)>
    <cfset SpreadSheetFormatCellRange(#excel_object#, s28, #row#, 21, #row#, 21)>
    <cfset SpreadSheetFormatCellRange(#excel_object#, s29, #row#, 10, #row#, 13)>
    <cfset SpreadSheetFormatCellRange(#excel_object#, s65, #row#, 14, #row#, 20)>
    <!---<cfset SpreadSheetFormatColumns(#excel_object#, s28, "14,21")>
    <cfset SpreadSheetFormatColumns(#excel_object#, s29, "10-13")>
    <cfset SpreadSheetFormatColumns(#excel_object#, s65, "14-20")>
    <cfset SpreadSheetFormatRow(#excel_object#, s23, 1)>--->
    
    
</cffunction>