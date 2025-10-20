<cfoutput>
<cfset uuid = createuuid()>
<cfset timenow = dateformat(now(), 'yyyymmdd_hhmmss')>

<cfsetting showdebugoutput="yes" requesttimeout="0">
<cfinclude template="/object/dateobject.cfm">
<cfinclude template="/object/stringobject.cfm">
<cfquery name="getpayroll" datasource="#dts#">
	SELECT mmonth, myear
    FROM payroll_main.gsetup
    WHERE comp_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#replace(dts,'_i','')#">
</cfquery>
<cfset payrollmonth = getpayroll.mmonth>
<cfset payrollyear = getpayroll.myear>

		<cfquery name="getbatches" datasource="#dts#">
        	SELECT custno, batches, payrollperiod, refno, invoiceno
        	FROM assignmentslip
            WHERE
        	<cfif isdefined('form.batches')>
        		batches in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.batches#" separator="," list="yes">)
        	</cfif>
            AND branch = "#url.branch#"
            Order by batches
        </cfquery>

		<!---BEGIN WRITING CSV--->

		<cffile action="WRITE" file="#HRootPath#\Excel_Report\MPpostingBUR_#timenow#.csv"
        output="RECTYPE,BATCHID,BTCHENTRY,SRCELEDGER,SRCETYPE,DATEENTRY,JRNLDESC,FSCSYR,FSCSPERD"
        addnewline="yes">

        <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingBUR_#timenow#.csv"
        output="RECTYPE,BATCHNBR,JOURNALID,TRANSNBR,ACCTID,TRANSAMT,TRANSREF,TRANSDATE,SRCELDGR,SRCETYPE,COMMENT,TRANSDESC"
  		addnewline="Yes">

		<cfset counter = 1>
        <cfset type2 = "">

 		<cfloop query="getbatches">

 			<cfset itemcounter = 1>

            <cfquery name="getassignmentslip" datasource="#dts#">
            	SELECT refno, selfsalary, placementno, invoiceno, custcpf, custsdf, payrollperiod, assignmentslipdate
                from assignmentslip
                WHERE refno = "#getbatches.refno#"
            </cfquery>

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
				<cfif #getassignmentslip.invoiceno# eq ''>
                	AND refno = "#getassignmentslip.refno#"
                <cfelse>
                	AND refno = "#getassignmentslip.invoiceno#"
                </cfif>
				AND (void='' or void is null)
			</cfquery>
			<!--- To lock artran --->

			<!--- Insert into postlog, [20170418, Alvin] --->
			<cfquery name="InsertPostLog" datasource="#dts#">
				INSERT INTO postlog (Action, billtype, actiondata, user, timeaccess)
				VALUES (
				"PostToAccPacc",
				"Burden",
				<cfif #getassignmentslip.invoiceno# eq ''>
                	"#getassignmentslip.refno#",
                <cfelse>
                	"#getassignmentslip.invoiceno#",
                </cfif>
				"#HuserID#",
				"#DateFormat(now(), 'yyyy-mm-dd hh:mm:ss')#"
				)
			</cfquery>
			<!--- Insert into postlog --->

            <cfquery name="getartran" datasource="#dts#">
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
            </cfquery>

            <!---<cfquery name="chartofaccount" datasource="#dts#">
                            SELECT c_credit, c_creditbranch, c_debit, c_debitbranch
                            FROM chartofaccount
                            WHERE type1_id = "#getplacementno.jobpostype#"
                            AND
                            type2 = "#type2#"
                        </cfquery>--->

            <cfif (#getassignmentslip.custcpf# neq 0) OR (#getassignmentslip.custsdf# neq 0)> <!---generate row with epf or socso only / empty will not be generated--->

				<cfif #getassignmentslip.payrollperiod# gt 12>
                    <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingBUR_#timenow#.csv"
                    output="1,#getbatches.batches#,#counter#,GL,JE,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,Cost of Sales - Burden,#dateformat(getassignmentslip.assignmentslipdate,'yyyy')#,#evaluate('getassignmentslip.payrollperiod MOD 12')#"
                    addnewline="Yes">
                <cfelse>
                    <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingBUR_#timenow#.csv"
                    output="1,#getbatches.batches#,#counter#,GL,JE,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,Cost of Sales - Burden,#dateformat(getassignmentslip.assignmentslipdate,'yyyy')#,#getassignmentslip.payrollperiod#"
                    addnewline="Yes">
                </cfif>

                        <!---EPF--->
                        <cfif #getassignmentslip.custcpf# neq 0>
                            <cfset type2 = "EPF">
                            <cfquery name="chartofaccount" datasource="#dts#">
                                SELECT c_credit, c_creditbranch, c_debit, c_debitbranch
                                FROM chartofaccount
                                WHERE type1_id = "#getplacementno.jobpostype#"
                                AND
                                type2 = "#type2#"
                                <cfif #getplacementno.jobpostype# eq '1'> <!---temp--->
                                    AND c_debit = '4201'
                                <cfelseif #getplacementno.jobpostype# eq '2'> <!---contract--->
                                    AND c_debit = '4202'
                                <cfelseif #getplacementno.jobpostype# eq '5'> <!---wage--->
                                    AND c_debit = '4203'
                                <cfelseif #getplacementno.jobpostype# eq '6'> <!---payroll--->
                                    AND c_debit = '4205'
                                </cfif>
                            </cfquery>

                            <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingBUR_#timenow#.csv"
                                output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#-#getplacementno.location#,#NumberFormat(getassignmentslip.custcpf,".__")#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /Burden ##1 /Item: #type2#,#type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingBUR_#timenow#.csv"
                                output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#,#NumberFormat(getassignmentslip.custcpf,".__")#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /Burden ##1 /Item: #type2#,#type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                            <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingBUR_#timenow#.csv"
                                output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#-#getplacementno.location#,#val(NumberFormat(getassignmentslip.custcpf,".__"))*-1#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /Burden ##1 /Item: #type2#,#type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingBUR_#timenow#.csv"
                                output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#,#val(NumberFormat(getassignmentslip.custcpf,".__"))*-1#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /Burden ##1 /Item: #type2#,#type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                        </cfif>
                        <!---EPF--->

                        <!---SOCSO--->
                        <cfif #getassignmentslip.custsdf# neq 0>
                            <cfset type2 = "Socso">

                            <cfquery name="chartofaccount" datasource="#dts#">
                                SELECT c_credit, c_creditbranch, c_debit, c_debitbranch
                                FROM chartofaccount
                                WHERE type1_id = "#getplacementno.jobpostype#"
                                AND
                                type2 = "#type2#"
                                <cfif #getplacementno.jobpostype# eq '1'> <!---temp--->
                                    AND c_debit = '4201'
                                <cfelseif #getplacementno.jobpostype# eq '2'> <!---contract--->
                                    AND c_debit = '4202'
                                <cfelseif #getplacementno.jobpostype# eq '5'> <!---wage--->
                                    AND c_debit = '4203'
                                <cfelseif #getplacementno.jobpostype# eq '6'> <!---payroll--->
                                    AND c_debit = '4205'
                                </cfif>
                            </cfquery>

                            <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingBUR_#timenow#.csv"
                                output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#-#getplacementno.location#,#NumberFormat(getassignmentslip.custsdf,".__")#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /Burden ##1 /Item: #type2#,#type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingBUR_#timenow#.csv"
                                output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#,#NumberFormat(getassignmentslip.custsdf,".__")#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /Burden ##1 /Item: #type2#,#type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                            <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingBUR_#timenow#.csv"
                                output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#-#getplacementno.location#,#val(NumberFormat(getassignmentslip.custsdf,".__"))*-1#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /Burden ##2 /Item: #type2#,#type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingBUR_#timenow#.csv"
                                output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#,#val(NumberFormat(getassignmentslip.custsdf,".__"))*-1#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /Burden ##2 /Item: #type2#,#type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                        </cfif>
                        <!---SOCSO--->

                    <cfset counter += 1>
        	</cfif>

		</cfloop>

		<!---FINISHED WRITING CSV--->

        <cfheader name="Content-Type" value="csv">
		<cfset filename = "MPpostingBUR_#timenow#.csv">

		<cfheader name="Content-Disposition" value="inline; filename=#filename#">
		<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\MPpostingBUR_#timenow#.csv">


</cfoutput>