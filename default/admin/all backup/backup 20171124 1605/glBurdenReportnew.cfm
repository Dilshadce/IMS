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
<cfset leftjoinslip = "LEFT JOIN #dts#.assignmentslip b ON a.empno = b.empno AND a.entity = b.branch">
<cfset leftjoinplacement = "LEFT JOIN #dts#.placement c ON b.placementno = c.placementno">

		<cfquery name="getpayout" datasource="#replace(dts, '_i', '_p')#">
            SELECT * FROM
            (
                SELECT a.empno, a.socsocc, a.epfcc, b.assignmentslipdate, b.batches, b.placementno, c.jobpostype, c.location
                FROM 
                <cfif "#getpayroll.mmonth#" EQ "#form.monthselected#">
                    payout_stat a
                    #leftjoinslip#
                    #leftjoinplacement#
                    WHERE 1=1
                <cfelse>
                    payout_stat_12m a
                    #leftjoinslip#
                    #leftjoinplacement#
                    WHERE 1=1
                    AND a.tmonth = "#form.monthselected#"
                </cfif>
                AND (a.socsocc != 0 OR a.epfcc != 0)
                AND a.entity = "#url.entity#"
                AND b.payrollperiod = "#form.monthselected#"
                AND YEAR(b.assignmentslipdate) = "#payrollyear#"
                ORDER BY b.refno DESC
            ) AS sort
            GROUP BY sort.empno
        </cfquery>
        
		<!---BEGIN WRITING CSV--->

		<cffile action="WRITE" file="#HRootPath#\Excel_Report\MPpostingBUR_#url.entity#_#timenow#.csv"
        output="RECTYPE,BATCHID,BTCHENTRY,SRCELEDGER,SRCETYPE,DATEENTRY,JRNLDESC,FSCSYR,FSCSPERD"
        addnewline="yes">

        <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingBUR_#url.entity#_#timenow#.csv"
        output="RECTYPE,BATCHNBR,JOURNALID,TRANSNBR,ACCTID,TRANSAMT,TRANSREF,TRANSDATE,SRCELDGR,SRCETYPE,COMMENT,TRANSDESC"
  		addnewline="Yes">

		<cfset counter = 1>
        <cfset type2 = "">

 		<cfloop query="getpayout">

 			<cfset itemcounter = 1>

            <!---<cfquery name="getassignmentslip" datasource="#dts#">
            	SELECT refno, selfsalary, placementno, invoiceno, custcpf, custsdf, payrollperiod, assignmentslipdate
                from assignmentslip
                WHERE refno = "#getbatches.refno#"
            </cfquery>--->

			<!--- lock assignmentslip from editing, [20170418, Alvin] --->
			<!---<cfquery name="lockassign" datasource="#dts#">
				UPDATE assignmentslip SET posted = 'P'
				WHERE refno = "#getbatches.refno#"
			</cfquery>--->
			<!--- lock assignmentslip --->

			<!--- To lock artran from editing, [20170418, Alvin] --->
			<!---<cfquery name="lockartran" datasource="#dts#">
				UPDATE artran SET posted = 'P'
				WHERE 1=1
				<cfif #getassignmentslip.invoiceno# eq ''>
                	AND refno = "#getassignmentslip.refno#"
                <cfelse>
                	AND refno = "#getassignmentslip.invoiceno#"
                </cfif>
				AND (void='' or void is null)
			</cfquery>--->
			<!--- To lock artran --->

			<!--- Insert into postlog, [20170418, Alvin] --->
			<cfquery name="InsertPostLog" datasource="#dts#">
				INSERT INTO postlog (Action, billtype, actiondata, user, timeaccess)
				VALUES (
				"PostToAccPacc",
				"Burden",
				"#url.entity#",
				"#HuserID#",
				"#DateFormat(now(), 'yyyy-mm-dd hh:mm:ss')#"
				)
			</cfquery>
			<!--- Insert into postlog --->

            <!---<cfquery name="getartran" datasource="#dts#">
            	SELECT wos_date, custno, fperiod
                FROM artran
                <cfif #getassignmentslip.invoiceno# eq ''>
                	WHERE refno = "#getassignmentslip.refno#"
                <cfelse>
                	WHERE refno = "#getassignmentslip.invoiceno#"
                </cfif>
            </cfquery>

            <cfquery name="getictran" datasource="#dts#">
                SELECT desp, brem5, brem6
                FROM ictran
                <cfif #getassignmentslip.invoiceno# eq ''>
                	WHERE refno = "#getassignmentslip.refno#"
                <cfelse>
                	WHERE refno = "#getassignmentslip.invoiceno#"
                </cfif>
                AND
                itemno <> "Name"
                ORDER by desp
        	</cfquery>

            <cfquery name="getplacementno" datasource="#dts#">
                SELECT location, jobpostype
                FROM placement
                WHERE placementno = "#getassignmentslip.placementno#"
            </cfquery>--->

            <!---<cfquery name="chartofaccount" datasource="#dts#">
                            SELECT c_credit, c_creditbranch, c_debit, c_debitbranch
                            FROM chartofaccount
                            WHERE type1_id = "#getplacementno.jobpostype#"
                            AND
                            type2 = "#type2#"
                        </cfquery>--->

            <!---<cfif (#getassignmentslip.custcpf# neq 0) OR (#getassignmentslip.custsdf# neq 0)>---> <!---generate row with epf or socso only / empty will not be generated--->

				<!---<cfif #getassignmentslip.payrollperiod# gt 12>
                    <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingBUR_#url.entity#_#timenow#.csv"
                    output="1,#getbatches.batches#,#counter#,GL,JE,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,Cost of Sales - Burden,#dateformat(getassignmentslip.assignmentslipdate,'yyyy')#,#evaluate('getassignmentslip.payrollperiod MOD 12')#"
                    addnewline="Yes">
                <cfelse>
                    <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingBUR_#url.entity#_#timenow#.csv"
                    output="1,#getbatches.batches#,#counter#,GL,JE,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,Cost of Sales - Burden,#dateformat(getassignmentslip.assignmentslipdate,'yyyy')#,#getassignmentslip.payrollperiod#"
                    addnewline="Yes">
                </cfif>--->
                        
                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingBUR_#url.entity#_#timenow#.csv"
                    output="1,#getpayout.batches#,#counter#,GL,JE,#dateformat(getpayout.assignmentslipdate,'yyyymmdd')#,Cost of Sales - Burden,#payrollyear#,#form.monthselected#"
                    addnewline="Yes">

                        <!---EPF--->
                        <cfif #getpayout.epfcc# neq 0>
                            <cfset type2 = "EPF">
                            <cfquery name="chartofaccount" datasource="#dts#">
                                SELECT c_credit, c_creditbranch, c_debit, c_debitbranch
                                FROM chartofaccount
                                WHERE type1_id = "#getpayout.jobpostype#"
                                AND
                                type2 = "#type2#"
                                <cfif #getpayout.jobpostype# eq '1'> <!---temp--->
                                    AND c_debit = '4201'
                                <cfelseif #getpayout.jobpostype# eq '2'> <!---contract--->
                                    AND c_debit = '4202'
                                <cfelseif #getpayout.jobpostype# eq '5'> <!---wage--->
                                    AND c_debit = '4203'
                                <cfelseif #getpayout.jobpostype# eq '6'> <!---payroll--->
                                    AND c_debit = '4205'
                                </cfif>
                            </cfquery>

                            <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingBUR_#url.entity#_#timenow#.csv"
                                output="2,#getpayout.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#-#getpayout.location#,#NumberFormat(getpayout.epfcc,".__")#,/TS## /Job###getpayout.placementno#,#dateformat(getpayout.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getpayout.batches# /TSheet ## /Burden ##1 /Item: #type2#,#type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingBUR_#url.entity#_#timenow#.csv"
                                output="2,#getpayout.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#,#NumberFormat(getpayout.epfcc,".__")#,/TS## /Job###getpayout.placementno#,#dateformat(getpayout.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getpayout.batches# /TSheet ## /Burden ##1 /Item: #type2#,#type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                            <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingBUR_#url.entity#_#timenow#.csv"
                                output="2,#getpayout.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#-#getpayout.location#,#val(NumberFormat(getpayout.epfcc,".__"))*-1#,/TS## /Job###getpayout.placementno#,#dateformat(getpayout.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getpayout.batches# /TSheet ## /Burden ##1 /Item: #type2#,#type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingBUR_#url.entity#_#timenow#.csv"
                                output="2,#getpayout.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#,#val(NumberFormat(getpayout.epfcc,".__"))*-1#,/TS## /Job###getpayout.placementno#,#dateformat(getpayout.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getpayout.batches# /TSheet ## /Burden ##1 /Item: #type2#,#type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                        </cfif>
                        
                        <!---<cfset type2 = "EPF">
                        <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingBUR_#url.entity#_#timenow#.csv"
                                output="2,,#counter#,#itemcounter#,,#NumberFormat(getpayout.epfcc,".__")#,/TS## /Job##,,GL,JE,/Batch ## /TSheet ## /Burden ##1 /Item: #type2#,#type2#"
                                    addnewline="yes">
                        <cfset itemcounter += 1>--->
                        <!---EPF--->

                        <!---SOCSO--->
                        <cfif #getpayout.socsocc# neq 0>
                            <cfset type2 = "Socso">

                            <cfquery name="chartofaccount" datasource="#dts#">
                                SELECT c_credit, c_creditbranch, c_debit, c_debitbranch
                                FROM chartofaccount
                                WHERE type1_id = "#getpayout.jobpostype#"
                                AND
                                type2 = "#type2#"
                                <cfif #getpayout.jobpostype# eq '1'> <!---temp--->
                                    AND c_debit = '4201'
                                <cfelseif #getpayout.jobpostype# eq '2'> <!---contract--->
                                    AND c_debit = '4202'
                                <cfelseif #getpayout.jobpostype# eq '5'> <!---wage--->
                                    AND c_debit = '4203'
                                <cfelseif #getpayout.jobpostype# eq '6'> <!---payroll--->
                                    AND c_debit = '4205'
                                </cfif>
                            </cfquery>

                            <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingBUR_#url.entity#_#timenow#.csv"
                                output="2,#getpayout.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#-#getpayout.location#,#NumberFormat(getpayout.socsocc,".__")#,/TS## /Job###getpayout.placementno#,#dateformat(getpayout.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getpayout.batches# /TSheet ## /Burden ##1 /Item: #type2#,#type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingBUR_#url.entity#_#timenow#.csv"
                                output="2,#getpayout.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#,#NumberFormat(getpayout.socsocc,".__")#,/TS## /Job###getpayout.placementno#,#dateformat(getpayout.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getpayout.batches# /TSheet ## /Burden ##1 /Item: #type2#,#type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                            <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingBUR_#url.entity#_#timenow#.csv"
                                output="2,#getpayout.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#-#getpayout.location#,#val(NumberFormat(getpayout.socsocc,".__"))*-1#,/TS## /Job###getpayout.placementno#,#dateformat(getpayout.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getpayout.batches# /TSheet ## /Burden ##2 /Item: #type2#,#type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingBUR_#url.entity#_#timenow#.csv"
                                output="2,#getpayout.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#,#val(NumberFormat(getpayout.socsocc,".__"))*-1#,/TS## /Job###getpayout.placementno#,#dateformat(getpayout.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getpayout.batches# /TSheet ## /Burden ##2 /Item: #type2#,#type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                        </cfif>
                        
                        <!---<cfset type2 = "SOCSO">
                        <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingBUR_#url.entity#_#timenow#.csv"
                                output="2,,#counter#,#itemcounter#,,#NumberFormat(getpayout.socsocc,".__")#,/TS## /Job##,,GL,JE,/Batch ## /TSheet ## /Burden ##1 /Item: #type2#,#type2#"
                                    addnewline="yes">
                                    
                        <cfset itemcounter += 1>--->
                        <!---SOCSO--->

                    <cfset counter += 1>
        	<!---</cfif>--->

		</cfloop>

		<!---FINISHED WRITING CSV--->

        <cfheader name="Content-Type" value="csv">
		<cfset filename = "MPpostingBUR_#url.entity#_#timenow#.csv">

		<cfheader name="Content-Disposition" value="inline; filename=#filename#">
		<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\MPpostingBUR_#url.entity#_#timenow#.csv">


</cfoutput>