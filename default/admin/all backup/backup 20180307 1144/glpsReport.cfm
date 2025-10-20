<cfoutput>
<cfset uuid = createuuid()>
<cfset timenow = dateformat(now(), 'yyyymmdd_hhmmss')>

<cfsetting showdebugoutput="yes" requesttimeout="0">
    
<cfquery name="getpayroll" datasource="#dts#">
	SELECT mmonth, myear
    FROM payroll_main.gsetup
    WHERE comp_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#replace(dts,'_i','')#">
</cfquery>
    
<cfset payrollmonth = getpayroll.mmonth>
<cfset payrollyear = getpayroll.myear>
        
    <cfquery name="getchartofaccount" datasource="#dts#">
        SELECT * FROM chartofaccount
    </cfquery>

    <cfquery name="ICShelf" datasource="#dts#">
        SELECT * FROM
        (
            SELECT * FROM 
            (
                SELECT itemno,case WHEN MITEMNO != "" THEN MITEMNO ELSE Desp END as desp 
                FROM icitem ORDER BY itemno
            ) AS a
            UNION ALL
            SELECT *  FROM 
            (
                SELECT cate AS itemno, desp FROM iccate
                ORDER BY cate
            ) AS b
            UNION ALL
            SELECT *  FROM 
            (
                SELECT
                shelf AS itemno, desp FROM icshelf
                ORDER BY length(shelf),shelf
            ) AS c
            UNION ALL
            SELECT * FROM 
            (
                SELECT servi AS itemno, case WHEN despa != "" THEN despa ELSE desp END AS desp
                FROM icservi
                ORDER BY servi
            ) AS d
        ) AS main
    </cfquery>

    <cfquery name="getbatches" datasource="#dts#">
        SELECT slip.custno, slip.batches, slip.payrollperiod, slip.refno, slip.invoiceno, slip.placementno, pm.location, pm.jobpostype,
        slip.payrollperiod, slip.selftotal, slip.assignmentslipdate, slip.selfsalary
        <cfloop from="1" to="18" index="a">
            <cfif #a# LTE '10'>
                <cfif #a# LTE '8'>
                    <cfif #a# LTE '6'>
                        <cfif #a# LTE '3'>
                            <cfif #a# EQ '1'>
                                , slip.addchargeself, slip.addchargedesp, slip.addchargecode
                            <cfelse>
                                , slip.addchargeself#a#, slip.addchargedesp#a#, slip.addchargecode#a#
                            </cfif>
                        </cfif>
                        , slip.fixawee#a#, slip.fixawdesp#a#, slip.fixawcode#a#
                    </cfif>
                    , slip.selfot#a#
                </cfif>
                , slip.lvltotalee#a#, slip.lvldesp#a#, slip.lvltype#a#
            </cfif>
            , slip.awee#a#, slip.allowance#a#, slip.allowancedesp#a#
        </cfloop>
        FROM assignmentslip AS slip
        LEFT JOIN placement AS pm ON slip.placementno = pm.placementno
        WHERE
        <cfif isdefined('form.batches')>
            slip.batches in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.batches#" separator="," list="yes">)
        </cfif>
        AND slip.branch = "#url.branch#"
        ORDER BY slip.batches
    </cfquery>

    <!---BEGIN WRITING CSV--->

    <cffile action="WRITE" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv"
    output="RECTYPE,BATCHID,BTCHENTRY,SRCELEDGER,SRCETYPE,DATEENTRY,JRNLDESC,FSCSYR,FSCSPERD"
    addnewline="yes">

    <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv"
    output="RECTYPE,BATCHNBR,JOURNALID,TRANSNBR,ACCTID,TRANSAMT,TRANSREF,TRANSDATE,SRCELDGR,SRCETYPE,COMMENT,TRANSDESC"
    addnewline="Yes">

    <cfset counter = 1>
    <cfset type2 = "">

    <cfloop query="getbatches">

        <cfset itemcounter = 1>

        <!--- lock assignmentslip from editing, [20170418, Alvin] --->
        <cfquery name="lockassign" datasource="#dts#">
            UPDATE assignmentslip SET posted = 'P'
            WHERE refno = "#getbatches.refno#"
        </cfquery>
        <!--- lock assignmentslip --->

        <!--- To lock artran from editing, [20170418, Alvin] --->
        <cfquery name="lockartran" datasource="#dts#">
            UPDATE artran SET posted = 'P'
            WHERE 1=1
            <cfif #getbatches.invoiceno# eq ''>
                AND refno = "#getbatches.refno#"
            <cfelse>
                AND refno = "#getbatches.invoiceno#"
            </cfif>
            AND (void='' or void is null)
        </cfquery>
        <!--- To lock artran --->

        <!--- Insert into postlog, [20170418, Alvin] --->
        <cfquery name="InsertPostLog" datasource="#dts#">
            INSERT INTO postlog (Action, billtype, actiondata, user, timeaccess)
            VALUES (
            "PostToAccPacc",
            "Pay",
            <cfif #getbatches.invoiceno# eq ''>
                "#getbatches.refno#",
            <cfelse>
                "#getbatches.invoiceno#",
            </cfif>
            "#HuserID#",
            "#DateFormat(now(), 'yyyy-mm-dd hh:mm:ss')#"
            )
        </cfquery>
        <!--- Insert into postlog --->

        <cfif #getbatches.selftotal# neq 0>

            <cfif #getbatches.payrollperiod# gt 12>
                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv"
                output="1,#getbatches.batches#,#counter#,GL,JE,#dateformat(getbatches.assignmentslipdate,'yyyymmdd')#,Cost of Sales - Pays,#dateformat(getbatches.assignmentslipdate,'yyyy')#,#evaluate('getbatches.payrollperiod MOD 12')#"
                addnewline="Yes">
            <cfelse>
                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv"
                output="1,#getbatches.batches#,#counter#,GL,JE,#dateformat(getbatches.assignmentslipdate,'yyyymmdd')#,Cost of Sales - Pays,#dateformat(getbatches.assignmentslipdate,'yyyy')#,#getbatches.payrollperiod#"
                addnewline="Yes">
            </cfif>

            <!---Normal--->
            <cfif #getbatches.selfsalary# neq 0>
                <cfset type2 = "Normal">

                <cfquery name="chartofaccount" dbtype="query">
                    SELECT c_credit, c_creditbranch, c_debit, c_debitbranch
                    FROM getchartofaccount
                    WHERE type1_id = #getbatches.jobpostype#
                    AND
                    type2 = '#type2#'
                    AND c_debit != ''
                </cfquery>

                <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                    <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv"
                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#-#getbatches.location#,#getbatches.selfsalary#,/TS## /Job###getbatches.placementno#,#dateformat(getbatches.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                    addnewline="yes">
                <cfelse>
                    <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv"
                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#,#getbatches.selfsalary#,/TS## /Job###getbatches.placementno#,#dateformat(getbatches.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                    addnewline="yes">
                </cfif>

                <cfset itemcounter += 1>

                <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                    <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv"
                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#-#getbatches.location#,#val(getbatches.selfsalary)*-1#,/TS## /Job###getbatches.placementno#,#dateformat(getbatches.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                    addnewline="yes">
                <cfelse>
                    <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv"
                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#,#val(getbatches.selfsalary)*-1#,/TS## /Job###getbatches.placementno#,#dateformat(getbatches.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                    addnewline="yes">
                </cfif>

                <cfset itemcounter += 1>
            </cfif>
            <!---Normal--->


            <!--- OT --->
            <!---ot1,   ot2,   ot3,   ot4,   ot5,   ot6,   ot7,   ot8--->
            <cfset otList = "OT 1.0,OT 1.5,OT 2.0,OT 3.0,RD 1.0,RD 2.0,PH 1.0,PH 2.0">
            <cfloop from="8" to="1" step="-1" index="ot">
                <cfif #evaluate('getbatches.selfot#ot#')# neq 0>
                    <cfset type2 = "#ListGetAt(otList, ot, ',')#">
                    <cfif "#type2#" EQ "PH 1.0">
                        <cfset type2 = "PH 2.0">  <!---according to kangwei ph1.0 is same as ph 2.0 for gl account--->
                    </cfif>

                    <cfquery name="chartofaccount" dbtype="query">
                        SELECT c_credit, c_creditbranch, c_debit, c_debitbranch
                        FROM getchartofaccount
                        WHERE type1_id = #getbatches.jobpostype#
                        AND
                        type2 = '#type2#'
                        AND c_debit != ''
                    </cfquery>

                    <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                        <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv"
                        output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#-#getbatches.location#,#evaluate('getbatches.selfot#ot#')#,/TS## /Job###getbatches.placementno#,#dateformat(getbatches.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                        addnewline="yes">
                    <cfelse>
                        <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv" output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#,#evaluate('getbatches.selfot#ot#')#,/TS## /Job###getbatches.placementno#,#dateformat(getbatches.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                        addnewline="yes">
                    </cfif>

                    <cfset itemcounter += 1>

                    <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                        <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv"
                        output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#-#getbatches.location#,#val(evaluate('getbatches.selfot#ot#'))*-1#,/TS## /Job###getbatches.placementno#,#dateformat(getbatches.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                        addnewline="yes">
                    <cfelse>
                        <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv" output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#,#val(evaluate('getbatches.selfot#ot#'))*-1#,/TS## /Job###getbatches.placementno#,#dateformat(getbatches.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                        addnewline="yes">
                    </cfif>

                    <cfset itemcounter += 1>
                </cfif>
            </cfloop>
            <!--- OT --->

            <!---fixed allowance--->
            <cfloop from="1" to="6" index="a">
                <cfif evaluate('getbatches.fixawee#a#') neq 0>
                    <cfset type2 = evaluate('getbatches.fixawdesp#a#')>

                    <cfquery name="getICShelf" dbtype="query">
                        SELECT itemno, desp FROM ICSHELF
                        WHERE itemno = '#Evaluate('getbatches.fixawcode#a#')#'
                    </cfquery>

                    <cfset type3 = "#getICShelf.desp#">

                    <cfquery name="chartofaccount" dbtype="query">
                        SELECT c_credit, c_creditbranch, c_debit, c_debitbranch
                        FROM getchartofaccount
                        WHERE type1_id = #getbatches.jobpostype#
                        AND
                        type2 = '#type3#'
                        AND c_debit != ''
                    </cfquery>

                    <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                        <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv"
                        output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#-#getbatches.location#,#evaluate('getbatches.fixawee#a#')#,/TS## /Job###getbatches.placementno#,#dateformat(getbatches.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                        addnewline="yes">
                    <cfelse>
                        <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv"
                        output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#,#evaluate('getbatches.fixawee#a#')#,/TS## /Job###getbatches.placementno#,#dateformat(getbatches.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                        addnewline="yes">
                    </cfif>

                    <cfset itemcounter += 1>

                    <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                        <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv"
                        output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#-#getbatches.location#,#val(evaluate('getbatches.fixawee#a#'))*-1#,/TS## /Job###getbatches.placementno#,#dateformat(getbatches.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                        addnewline="yes">
                    <cfelse>
                        <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv" output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#,#val(evaluate('getbatches.fixawee#a#'))*-1#,/TS## /Job###getbatches.placementno#,#dateformat(getbatches.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                        addnewline="yes">
                    </cfif>

                    <cfset itemcounter += 1>
                </cfif>
            </cfloop>
            <!---fixed allowance--->

            <!---Allowance --->
            <cfloop from="1" to="18" index="a">
                <cfif "#evaluate('getbatches.awee#a#')#" NEQ 0 AND "#Evaluate('getbatches.allowance#a#')#" NEQ '1003'>

                    <cfquery name="getICShelf" dbtype="query">
                        SELECT itemno, desp FROM ICSHELF
                        WHERE itemno = '#Evaluate('getbatches.allowance#a#')#'
                    </cfquery>

                    <cfset type2 = evaluate('getbatches.allowancedesp#a#')>
                    <cfset type3 = "#getICShelf.desp#">

                    <cfquery name="chartofaccount" dbtype="query">
                        SELECT c_credit, c_creditbranch, c_debit, c_debitbranch
                        FROM getchartofaccount
                        WHERE type1_id = #getbatches.jobpostype#
                        AND
                        type2 = '#type3#'
                        AND c_debit != ''
                    </cfquery>

                    <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                        <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv"
                        output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#-#getbatches.location#,#evaluate('getbatches.awee#a#')#,/TS## /Job###getbatches.placementno#,#dateformat(getbatches.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                        addnewline="yes">
                    <cfelse>
                        <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv"
                        output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#,#evaluate('getbatches.awee#a#')#,/TS## /Job###getbatches.placementno#,#dateformat(getbatches.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                        addnewline="yes">
                    </cfif>

                    <cfset itemcounter += 1>

                    <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                        <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv"
                        output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#-#getbatches.location#,#val(evaluate('getbatches.awee#a#'))*-1#,/TS## /Job###getbatches.placementno#,#dateformat(getbatches.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                        addnewline="yes">
                    <cfelse>
                        <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv" output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#,#val(evaluate('getbatches.awee#a#'))*-1#,/TS## /Job###getbatches.placementno#,#dateformat(getbatches.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                        addnewline="yes">
                    </cfif>

                    <cfset itemcounter += 1>
                </cfif>
            </cfloop>
            <!---Allowance --->

            <!---Additional Item--->
            <cfloop from="1" to="3" index="a">

                <cfif #a# eq 1>
                    <cfset addchargeself1 = "addchargeself">
                    <cfset addchargedesp1 = "addchargedesp">
                    <cfset addchargecode1 = "addchargecode">
                <cfelse>
                    <cfset addchargeself1 = "addchargeself#a#">
                    <cfset addchargedesp1 = "addchargedesp#a#">
                    <cfset addchargecode1 = "addchargecode#a#">
                </cfif>

                <cfif "#evaluate('getbatches.#addchargedesp1#')#" CONTAINS "tax refund" OR "#Evaluate('getbatches.#addchargecode1#')#" EQ '1003'>
                    <cfcontinue>    <!---first item doesnt have numbering, ignore tax refund--->
                </cfif>

                <cfif "#evaluate('getbatches.#addchargeself1#')#" neq 0>
                    <cfset type2 = "#evaluate('getbatches.#addchargedesp1#')#">

                    <cfquery name="getICShelf" dbtype="query">
                        SELECT itemno, desp FROM ICSHELF
                        WHERE itemno = '#Evaluate('getbatches.#addchargecode1#')#'
                    </cfquery>

                    <cfset type3 = "#getICShelf.desp#">

                    <cfquery name="chartofaccount" dbtype="query">
                    SELECT c_credit, c_creditbranch, c_debit, c_debitbranch
                    FROM getchartofaccount
                    WHERE type1_id = #getbatches.jobpostype#
                    AND
                    type2 = '#type3#'
                    AND c_debit != ''
                    </cfquery>

                    <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                        <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv"
                        output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#-#getbatches.location#,#evaluate('getbatches.#addchargeself1#')#,/TS## /Job###getbatches.placementno#,#dateformat(getbatches.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                        addnewline="yes">
                    <cfelse>
                        <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv"
                        output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#,#evaluate('getbatches.#addchargeself1#')#,/TS## /Job###getbatches.placementno#,#dateformat(getbatches.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                        addnewline="yes">
                    </cfif>

                    <cfset itemcounter += 1>

                    <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                        <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv"
                        output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#-#getbatches.location#,#val(evaluate('getbatches.#addchargeself1#'))*-1#,/TS## /Job###getbatches.placementno#,#dateformat(getbatches.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                        addnewline="yes">
                    <cfelse>
                        <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv"
                        output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#,#val(evaluate('getbatches.#addchargeself1#'))*-1#,/TS## /Job###getbatches.placementno#,#dateformat(getbatches.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                        addnewline="yes">
                    </cfif>

                    <cfset itemcounter += 1>
                </cfif>
            </cfloop>

            <!---additional item--->

            <!---NPL--->
            <cfloop from="1" to="10" index="a">

                <cfif evaluate("getbatches.lvltotalee#a#") neq 0>
                    <cfif #Evaluate('getbatches.lvltype#a#')# CONTAINS "NPL">
                        <cfset type2 = "Unpaid Leave">
                    <cfelse>
                        <cfset type2 = "">
                    </cfif>

                    <cfquery name="chartofaccount" dbtype="query">
                        SELECT c_credit, c_creditbranch, c_debit, c_debitbranch
                        FROM getchartofaccount
                        WHERE type1_id = #getbatches.jobpostype#
                        AND
                        type2 = '#type2#'
                        AND c_debit != ''
                    </cfquery>

                    <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                        <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv"
                        output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#-#getbatches.location#,#evaluate('getbatches.lvltotalee#a#')#,/TS## /Job###getbatches.placementno#,#dateformat(getbatches.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                        addnewline="yes">
                    <cfelse>
                        <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv"
                        output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#,#evaluate('getbatches.lvltotalee#a#')#,/TS## /Job###getbatches.placementno#,#dateformat(getbatches.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                        addnewline="yes">
                    </cfif>

                    <cfset itemcounter += 1>

                    <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                        <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv"
                        output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#-#getbatches.location#,#val(evaluate('getbatches.lvltotalee#a#')*-1)#,/TS## /Job###getbatches.placementno#,#dateformat(getbatches.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                        addnewline="yes">
                    <cfelse>
                        <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv"
                        output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#, #val(evaluate('getbatches.lvltotalee#a#')*-1)#,/TS## /Job###getbatches.placementno#,#dateformat(getbatches.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                        addnewline="yes">
                    </cfif>

                    <cfset itemcounter += 1>
                </cfif>
            </cfloop>
            <!---NPL--->

            <cfset counter += 1>
        </cfif>
    </cfloop>

    <!---FINISHED WRITING CSV--->

    <cfheader name="Content-Type" value="csv">
    <cfset filename = "MPpostingPS_#url.branch#_#timenow#.csv">

    <cfheader name="Content-Disposition" value="inline; filename=#filename#">
    <cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv">

</cfoutput>