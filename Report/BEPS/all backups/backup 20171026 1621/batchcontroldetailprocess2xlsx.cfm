<cfsetting showdebugoutput="true" requesttimeout="0">
<cfoutput>

<cfset totalpay = 0>
<cfset totalbill = 0>

<cfquery name="getpayroll" datasource="#dts#">
    SELECT mmonth,myear FROM payroll_main.gsetup WHERE comp_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#replace(dts,'_i','')#">
</cfquery>

<cfset payrollmonth = getpayroll.mmonth>
<cfset payrollyear = getpayroll.myear>

<cfif (form.getfrom neq "" and form.getto neq "") or  (form.agentfrom neq "" and form.agentto neq "")>
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
</cfif>

<cfquery name="getgeneral" datasource="#dts#">
	select lastaccyear,filterall,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION,agentlistuserid,compro from gsetup
</cfquery>

<cfquery name="getassignment" datasource="#dts#">
    SELECT * FROM 
    (
        SELECT aa.*,if(claimadd1 = 'Y',coalesce(addchargeself,0),0)+if(claimadd2 = 'Y',coalesce(addchargeself2,0),0)+if(claimadd3 = 'Y',coalesce(addchargeself3,0),0)+if(claimadd4 = 'Y',coalesce(addchargeself4,0),0)+if(claimadd5 = 'Y',coalesce(addchargeself5,0),0)+if(claimadd6 = 'Y',coalesce(addchargeself6,0),0) as totalamt FROM assignmentslip aa
        WHERE payrollperiod = "#form.month#"
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

        <cfif isdefined('getplacement')>
            <cfif getplacement.recordcount neq 0>
                and placementno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#VALUELIST(getplacement.placementno)#" list="yes" separator=",">)
            </cfif>
        </cfif>
    
    ) as a
    
    LEFT JOIN
    (
        SELECT placementno as pno, location,consultant,custno as cno,custname,empname,pm FROM placement
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
    order by <cfif form.orderby eq 'custname'>b.</cfif>#form.orderby#,refno
</cfquery>

<cfquery name="getictran" datasource="#dts#">
    SELECT *,e.arrem1 dlocation,a.refno icrefno FROM ictran a
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
    WHERE a.fperiod = #form.month#
    AND YEAR(a.wos_date) = "#payrollyear#"
    AND a.fperiod <>99
        <cfif isdefined('form.cndnonly')>
            AND a.type IN ('CN','DN')   
        <cfelseif isdefined('form.permonly')>
            AND b.rem40 IS NULL AND a.type='INV'
        <cfelse>
            AND (a.type IN ('CN','DN') OR (b.rem40 IS NULL AND a.type='INV'))
        </cfif>
    AND (a.void IS NULL OR a.void='')
        <cfif form.createdfrm neq "" and form.createdto neq "">
            AND (created_by BETWEEN <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.createdfrm#"> AND <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.createdto#">)
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
    ORDER BY a.refno,brem6,a.trancode
</cfquery>

<cfset rowcount = 1>
<cfset boldlist = "">
<cfset excel = SpreadSheetNew(true)>
<cfset temp_query = querynew('Entity,Office_Code,Batch,Invoice,Company,Cust_No,VAT,Placement_No,Price_Structures,Employee_Name,Employee_No,Refno,Period,Item_Name,Pay_Qty,Pay_Rate,Pay_Amt,Bill_Qty,Bill_Rate,Bill_Amt,Amount_remarks')>

<!---Excel Format--->
<cfset s23 = StructNew()>                                    <!---header--->
<cfset s23.font="Arial">
<cfset s23.fontsize="11">
<cfset s23.bold="true">
<cfset s23.alignment="center">
<cfset s23.verticalalignment="vertical_bottom">

<cfset s28 = StructNew()>
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
<cfset s66.dataformat="0.00">

<cfloop from="1" to="21" index="i">
    <cfset SpreadSheetSetColumnWidth(excel,#i#,18)>
</cfloop>

<!---Excel Format--->

<cfset SpreadSheetAddRow(excel,"Entity,Office Code,Batch,Invoice,Company,Cust No,VAT,Placement No,Price Structures,Employee Name,Employee No,Refno,Period,Item Name,Pay Qty,Pay Rate,Pay Amt,Bill Qty,Bill Rate,Bill Amt, ")><!---21 column--->
<cfset SpreadSheetFormatRow(excel, s23, rowcount)>
<cfset rowcount += 1>

<cfloop query="getassignment">

    <!---<cfset startrowvalue = "#getassignment.branch#,#getassignment.location#,#getassignment.batches#,#getassignment.invoiceno#,#getassignment.custname#,#getassignment.custno#,#getassignment.arrem5#,#getassignment.placementno#,#getassignment.pricename#,#getassignment.empname#,#getassignment.empno#,#getassignment.refno#,#dateformat(getassignment.startdate,'dd/mm/yyyy')# - #dateformat(getassignment.completedate,'dd/mm/yyyy')#">--->

    
    <cfif val(getassignment.selfsalary) neq 0 or val(getassignment.custsalary) neq 0>     <!---For normal amount--->
       
        <cfif getassignment.paymenttype eq "hr">
            <cfset normalself = #numberformat(getassignment.selfsalaryhrs,'.____')#>
        <cfelseif getassignment.paymenttype eq "day">
            <cfset normalself = #numberformat(getassignment.selfsalaryday,'.____')#>
        <cfelse>
            <cfif val(getassignment.workd) neq 0>
                <cfset monthprorate = ROUND((val(getassignment.selfsalaryday)/val(getassignment.workd))*100000)/100000>
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
                <cfset monthprorate = ROUND((val(getassignment.custsalaryday)/val(getassignment.workd))*100000)/100000>
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
        Item_Name:"Normal",
        Pay_Qty:"#normalself#",
        Pay_Rate:"#numberformat(getassignment.selfusualpay,'.__')#",
        Pay_Amt:"#numberformat(getassignment.selfsalary,'.__')#",
        Bill_Qty:"#normalcust#",
        Bill_Rate:"#numberformat(getassignment.custusualpay,'.__')#",
        Bill_Amt:"#numberformat(getassignment.custsalary,'.__')#",
        Amount_remarks:"#normalremarks#"})>
        
        <!---<cfset setCellFormat(excel, #rowcount#)>--->
        <cfset rowcount += 1>        
    </cfif>
    
    <cfif val(getassignment.selfottotal) neq 0 or val(getassignment.custottotal) neq 0>     <!---For OT--->
        <cfloop from="1" to="8" index="a">
            <cfif val(evaluate('getassignment.selfot#a#')) neq 0 or val(evaluate('getassignment.custot#a#')) neq 0>

                <cfif a eq 1>
                    <cfset otname = "OT 1.0">
                <cfelseif a eq 2>
                    <cfset otname = "OT 1.5">
                <cfelseif a eq 3>
                    <cfset otname = "OT 2.0">
                <cfelseif a eq 4>
                    <cfset otname = "OT 3.0">
                <cfelseif a eq 5>
                    <cfset otname = "RD 1.0">
                <cfelseif a eq 6>
                    <cfset otname = "RD 2.0">
                <cfelseif a eq 7>
                    <cfset otname = "PH 1.0">
                <cfelseif a eq 8>
                    <cfset otname = "PH 2.0">
                </cfif>

                <cfif numberformat(evaluate('selfot#a#'),'.__') gt numberformat(evaluate('custot#a#'),'.__')>
                    <cfset otremarks = "**">
                <cfelse>
                    <cfset otremarks = ".">
                </cfif>

                <!---<cfset SpreadSheetAddRow(excel,"#startrowvalue#,#otname#,#numberformat(evaluate('selfothour#a#'),'.__')#,#numberformat(evaluate('selfotrate#a#'),'.__')#,#numberformat(evaluate('selfot#a#'),'.__')#,#numberformat(evaluate('custothour#a#'),'.__')#,#numberformat(evaluate('custotrate#a#'),'.__')#,#numberformat(evaluate('custot#a#'),'.__')#,#otremarks#")>--->
                
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
                Item_Name:"#otname#",
                Pay_Qty:"#numberformat(evaluate('selfothour#a#'),'.__')#",
                Pay_Rate:"#numberformat(evaluate('selfotrate#a#'),'.__')#",
                Pay_Amt:"#numberformat(evaluate('selfot#a#'),'.__')#",
                Bill_Qty:"#numberformat(evaluate('custothour#a#'),'.__')#",
                Bill_Rate:"#numberformat(evaluate('custotrate#a#'),'.__')#",
                Bill_Amt:"#numberformat(evaluate('custot#a#'),'.__')#",
                Amount_remarks:"#otremarks#"})>
                
                <!---<cfset setCellFormat(excel, #rowcount#)>--->
                <cfset rowcount += 1>
                
            </cfif> 
        </cfloop>
    </cfif>
    
    <cfloop from="1" to="6" index="a">                                                        <!---For Fix allowance--->
        <cfif val(evaluate('getassignment.fixawee#a#')) neq 0 or val(evaluate('getassignment.fixawer#a#'))>
            
            <cfif val(evaluate('getassignment.fixawee#a#')) neq 0>
                <cfset fixaweeamount = 1.00>
            <cfelse>
                <cfset fixaweeamount = 0.00>
            </cfif>
            
            <cfif val(evaluate('getassignment.fixawer#a#')) neq 0>
                <cfset fixaweramount = 1.00>
            <cfelse>
                <cfset fixaweramount = 0.00>
            </cfif>
            
            <cfif numberformat(val(evaluate('getassignment.fixawee#a#')),'.__') gt numberformat(val(evaluate('getassignment.fixawer#a#')),'.__')>
                <cfset fixawremarks = "**">
            <cfelse>
                <cfset fixawremarks = ".">
            </cfif>
        
        <!---<cfset SpreadSheetAddRow(excel,"#startrowvalue#,#evaluate('fixawdesp#a#')#,#fixaweeamount#,#numberformat(val(evaluate('getassignment.fixawee#a#')),'.__')#,#numberformat(val(evaluate('getassignment.fixawee#a#')),'.__')#,#fixaweramount#,#numberformat(val(evaluate('getassignment.fixawer#a#')),'.__')#,#numberformat(val(evaluate('getassignment.fixawer#a#')),'.__')#,#fixawremarks#")>--->
        
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
        Item_Name:"#evaluate('fixawdesp#a#')#",
        Pay_Qty:"#fixaweeamount#",
        Pay_Rate:"#numberformat(val(evaluate('getassignment.fixawee#a#')),'.__')#",
        Pay_Amt:"#numberformat(val(evaluate('getassignment.fixawee#a#')),'.__')#",
        Bill_Qty:"#fixaweramount#",
        Bill_Rate:"#numberformat(val(evaluate('getassignment.fixawer#a#')),'.__')#",
        Bill_Amt:"#numberformat(val(evaluate('getassignment.fixawer#a#')),'.__')#",
        Amount_remarks:"#fixawremarks#"})>
        
        <!---<cfset setCellFormat(excel, #rowcount#)>--->
        <cfset rowcount += 1>
        
        </cfif>
    </cfloop>
    
    <cfloop from="1" to="18" index="a">                                                        <!---For allowance--->
        <cfif val(evaluate('getassignment.awee#a#')) neq 0 or val(evaluate('getassignment.awer#a#')) neq 0>
            
            <cfif val(evaluate('getassignment.awee#a#')) neq 0>
                <cfset aweeamount = 1.00>
            <cfelse>
                <cfset aweeamount = 0.00>
            </cfif>
            
            <cfif val(evaluate('getassignment.awer#a#')) neq 0>
                <cfset aweramount = 1.00>
            <cfelse>
                <cfset aweramount = 0.00>
            </cfif>
            
            <cfif numberformat(val(evaluate('getassignment.awee#a#')),'.__') gt numberformat(val(evaluate('getassignment.awer#a#')),'.__')>
                <cfset awremarks = "**">
            <cfelse>
                <cfset awremarks = ".">
            </cfif>
            
            <!---<cfset SpreadSheetAddRow(excel,"#startrowvalue#,#evaluate('allowancedesp#a#')#,#aweeamount#,#numberformat(val(evaluate('getassignment.awee#a#')),'.__')#,#numberformat(val(evaluate('getassignment.awee#a#')),'.__')#,#aweramount#,#numberformat(val(evaluate('getassignment.awer#a#')),'.__')#,#numberformat(val(evaluate('getassignment.awer#a#')),'.__')#,#awremarks#")>--->
            
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
            Item_Name:"#evaluate('allowancedesp#a#')#",
            Pay_Qty:"#aweeamount#",
            Pay_Rate:"#numberformat(val(evaluate('getassignment.awee#a#')),'.__')#",
            Pay_Amt:"#numberformat(val(evaluate('getassignment.awee#a#')),'.__')#",
            Bill_Qty:"#aweramount#",
            Bill_Rate:"#numberformat(val(evaluate('getassignment.awer#a#')),'.__')#",
            Bill_Amt:"#numberformat(val(evaluate('getassignment.awer#a#')),'.__')#",
            Amount_remarks:"#awremarks#"})>
           
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
            Item_Name:"NPL",
            Pay_Qty:"#eenpl#",
            Pay_Rate:"#numberformat(val(evaluate('getassignment.lvleerate#a#')),'.__')#",
            Pay_Amt:"#numberformat(val(evaluate('getassignment.lvltotalee#a#')),'.__')#",
            Bill_Qty:"#ernpl#",
            Bill_Rate:"#numberformat(val(evaluate('getassignment.lvlerrate#a#')),'.__')#",
            Bill_Amt:"#numberformat(val(evaluate('getassignment.lvltotaler#a#')),'.__')#",
            Amount_remarks:"#nplremarks#"})>
            
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
        Item_Name:"EPF",
        Pay_Qty:"#eeepfamount#",
        Pay_Rate:"#eeepfvalue#",
        Pay_Amt:"#eeepfvalue2#",
        Bill_Qty:"#erepfamount#",
        Bill_Rate:"#numberformat(val(getassignment.custcpf),'.__')#",
        Bill_Amt:"#numberformat(val(getassignment.custcpf),'.__')#",
        Amount_remarks:"#epfremarks#"})>
            
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
        Item_Name:"SOCSO",
        Pay_Qty:"#eesocsoamount#",
        Pay_Rate:"#eesocsovalue#",
        Pay_Amt:"#eesocsovalue2#",
        Bill_Qty:"#ersocsoamount#",
        Bill_Rate:"#numberformat(val(getassignment.custsdf),'.__')#",
        Bill_Amt:"#numberformat(val(getassignment.custsdf),'.__')#",
        Amount_remarks:"#socsoremarks#"})>
            
        <!---<cfset setCellFormat(excel, #rowcount#)>--->
        <cfset rowcount += 1>
    </cfif>
    
    <cfif val(getassignment.adminfee) neq 0 >                                                  <!---For Admin Fee--->
        
        <!---<cfset SpreadSheetAddRow(excel,"#startrowvalue#,Admin Fee,0.00,0.00,0.00,1,#numberformat(val(getassignment.adminfee),'.__')#,#numberformat(val(getassignment.adminfee),'.__')#,.")>--->
        
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
        Item_Name:"Admin Fee",
        Pay_Qty:"0.00",
        Pay_Rate:"0.00",
        Pay_Amt:"0.00",
        Bill_Qty:"1",
        Bill_Rate:"#numberformat(val(getassignment.adminfee),'.__')#",
        Bill_Amt:"#numberformat(val(getassignment.adminfee),'.__')#",
        Amount_remarks:"."})>    
           
        <!---<cfset setCellFormat(excel, #rowcount#)>--->
        <cfset rowcount += 1>
    </cfif>
    
    <cfif val(getassignment.custdeduction) neq 0 or val(getassignment.selfdeduction) neq 0>    <!---For Deduction--->
       
        <cfloop from="1" to="6" index="a">
            <cfif val(evaluate('getassignment.billitemamt#a#')) neq 0>
                
                <!---<cfset SpreadSheetAddRow(excel,"#startrowvalue#,#evaluate('getassignment.billitemdesp#a#')#,0.00,0.00,0.00,1.00,#numberformat(val(evaluate('getassignment.billitemamt#a#')),'.__')#,#numberformat(val(evaluate('getassignment.billitemamt#a#')),'.__')#,.")>--->
                
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
                Item_Name:"#evaluate('getassignment.billitemdesp#a#')#",
                Pay_Qty:"0.00",
                Pay_Rate:"0.00",
                Pay_Amt:"0.00",
                Bill_Qty:"1",
                Bill_Rate:"#numberformat(val(evaluate('getassignment.billitemamt#a#')),'.__')#",
                Bill_Amt:"#numberformat(val(evaluate('getassignment.billitemamt#a#')),'.__')#",
                Amount_remarks:"."})>
                
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
                Item_Name:"#evaluate('getassignment.addchargedesp#a#')#",
                Pay_Qty:"1.00",
                Pay_Rate:"#numberformat(val(evaluate('getassignment.addchargeself#a#')),'.__')#",
                Pay_Amt:"#numberformat(val(evaluate('getassignment.addchargeself#a#')),'.__')#",
                Bill_Qty:"1",
                Bill_Rate:"#numberformat(val(evaluate('getassignment.addchargecust#a#')),'.__')#",
                Bill_Amt:"#numberformat(val(evaluate('getassignment.addchargecust#a#')),'.__')#",
                Amount_remarks:"#addchargeremarks#"})>
                
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
    Item_Name:"",
    Pay_Qty:"",
    Pay_Rate:"",
    Pay_Amt:"#numberformat(getassignment.selftotal,'.__')#",
    Bill_Qty:"",
    Bill_Rate:"",
    Bill_Amt:"#numberformat(getassignment.custtotalgross,'.__')#",
    Amount_remarks:"#totalremarks#"})>
    
    <!---<cfset setCellFormat(excel, #rowcount#)>
    <cfset SpreadSheetFormatCell(excel, s66, #rowcount#, 17)>
    <cfset SpreadSheetFormatCell(excel, s66, #rowcount#, 20)>--->
    <cfset boldlist = #ListAppend(boldlist, "#rowcount#", ',')#>
    <cfset rowcount += 1>

    <!---<cfset SpreadSheetAddRow(excel, " ")>--->
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
    Item_Name:"",
    Pay_Qty:"",
    Pay_Rate:"",
    Pay_Amt:"",
    Bill_Qty:"",
    Bill_Rate:"",
    Bill_Amt:"",
    Amount_remarks:""})>
    
    <cfset rowcount += 1>
    
    <cfset totalpay += val(getassignment.selftotal)>
    <cfset totalbill += val(getassignment.custtotalgross)>
    
</cfloop>

<cfif #getictran.recordcount# NEQ 0>
    <cfset subtotal=0.00>
    
    <cfloop query="getictran">
        
        <cfif getictran.custname neq ''>
            <cfset clientname = "#getictran.custname#">
        <cfelse>
            <cfset clientname = "#getictran.name#">
        </cfif>

        <cfif getictran.brem1 neq ''>
            <cfset placementJo = "#getictran.brem1#">
            <cfquery name="getpricename" datasource="#dts#">
                SELECT pricename FROM manpowerpricematrix 
                WHERE priceid="#getictran.pm#"
            </cfquery>
            <cfset pricestruct = "#getpricename.pricename#">
        <cfelse>
            <cfset placementJo = "#getictran.placementno#">
            <cfset pricestruct = "#getictran.pricename#">
        </cfif>
            
        <cfset queryaddrow(temp_query, {Entity:"#getictran.rem30#",
        Office_Code:"#getictran.dlocation#",
        Batch:"",
        Invoice:"#getictran.icrefno#",
        Company:"#clientname#",
        Cust_No:"#getictran.custno#",
        VAT:"#getictran.arrem5#",
        Placement_No:"#placementJo#",
        Price_Structures:"#pricestruct#",
        Employee_Name:"#getictran.empname#",
        Employee_No:"#getictran.empno#",
        Refno:"#getictran.brem6#",
        Period:"#dateformat(getassignment.startdate,'dd/mm/yyyy')#-#dateformat(getassignment.completedate,'dd/mm/yyyy')#",
        Item_Name:"#getictran.desp#",
        Pay_Qty:"0.00",
        Pay_Rate:"0.00",
        Pay_Amt:"0.00",
        Bill_Qty:"#numberformat(getictran.qty,'_.__')#",
        Bill_Rate:"#numberformat(getictran.price,'_.__')#",
        Bill_Amt:"#numberformat(getictran.amt_bil,'_.__')#",
        Amount_remarks:"."})>
        
        <cfset rowcount += 1>
        <cfset subtotal += val(getictran.amt_bil)>

        <cfif getictran.brem6[getictran.currentrow]  neq getictran.brem6[getictran.currentrow+1] or getictran.refno[getictran.currentrow]  neq getictran.refno[getictran.currentrow+1]> 
        
            <cfset queryaddrow(temp_query, {Entity:"#getictran.rem30#",
            Office_Code:"#getictran.dlocation#",
            Batch:"",
            Invoice:"#getictran.icrefno#",
            Company:"#clientname#",
            Cust_No:"#getictran.custno#",
            VAT:"#getictran.arrem5#",
            Placement_No:"#placementJo#",
            Price_Structures:"#pricestruct#",
            Employee_Name:"#getictran.empname#",
            Employee_No:"#getictran.empno#",
            Refno:"#getictran.brem6#",
            Period:"",
            Item_Name:"",
            Pay_Qty:"",
            Pay_Rate:"",
            Pay_Amt:"0.00",
            Bill_Qty:"",
            Bill_Rate:"",
            Bill_Amt:"#numberformat(subtotal,'_.__')#",
            Amount_remarks:"."})>
            
            <cfset boldlist = #ListAppend(boldlist, "#rowcount#", ',')#>
            <cfset rowcount += 1>
            
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
            Item_Name:"",
            Pay_Qty:"",
            Pay_Rate:"",
            Pay_Amt:"",
            Bill_Qty:"",
            Bill_Rate:"",
            Bill_Amt:"",
            Amount_remarks:""})>
            
            <cfset rowcount += 1>
                
            <cfset totalbill += val(subtotal)>
            <cfset subtotal =0.00>
        </cfif>

    </cfloop>
</cfif>

<cfif totalpay neq 0.00 and totalbill neq 0.00>

    <!---<cfset SpreadSheetAddRow(excel," ,,,,,,,,,,,,,Total,,,#numberformat(totalpay,'.__')#,,,#numberformat(totalbill,'.__')#,")>--->
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
    Item_Name:"Total",
    Pay_Qty:"",
    Pay_Rate:"",
    Pay_Amt:"#numberformat(totalpay,'.__')#",
    Bill_Qty:"",
    Bill_Rate:"",
    Bill_Amt:"#numberformat(totalbill,'.__')#",
    Amount_remarks:""})>
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

<cfset SpreadSheetAddRows(excel, temp_query)>
<cfset timenow = "#DateTimeFormat(now(), 'yyyy-mm-dd_hhnnss')#">

<cfspreadsheet action="write" filename="#HRootPath#\Excel_Report\Pay&Bill_#timenow#.xlsx" name="excel" overwrite="true">
<!---<cfspreadsheet action="write" filename="#HRootPath#\Excel_Report\Pay&Bill_#timenow#.xlsx" query="temp_query" overwrite="true">--->

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