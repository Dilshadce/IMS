<cfoutput>
<cfset uuid = createuuid()>

<cfsetting showdebugoutput="yes">
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
        
		<cffile action="WRITE" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv"
    	output="RECTYPE,BATCHID,BTCHENTRY,SRCELEDGER,SRCETYPE,DATEENTRY,JRNLDESC,FSCSYR,FSCSPERD" 
        addnewline="yes">
        
        <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
   		output="RECTYPE,BATCHNBR,JOURNALID,TRANSNBR,ACCTID,TRANSAMT,TRANSREF,TRANSDATE,SRCELDGR,SRCETYPE,COMMENT,TRANSDESC"
  		addnewline="Yes"> 

		<cfset counter = 1>
        <cfset type2 = "">
     
 		<cfloop query="getbatches">
                
 			<cfset itemcounter = 1>   
            
            <cfquery name="getassignmentslip" datasource="#dts#">
            	SELECT *
                FROM assignmentslip
                WHERE refno = "#getbatches.refno#"
            </cfquery>
            
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
            
            <cfquery name="chartofaccount" datasource="#dts#">
                SELECT c_credit, c_creditbranch, c_debit, c_debitbranch
                FROM chartofaccount
                WHERE type1_id = "#getplacementno.jobpostype#"
                AND
                <cfif #getictran.desp# CONTAINS "OT1.5" OR #getictran.desp# CONTAINS "OT 1.5">
                    type2 = "OT 1.5"
                    AND c_debit != ""
                <cfelseif #getictran.desp# CONTAINS "OT2.0" OR #getictran.desp# CONTAINS "OT 2.0">
                    type2 = "OT 2.0"
                    AND c_debit != ""
                <cfelse>
                    type2 = "#type2#"  
                    AND c_debit != ""
                </cfif>     
            </cfquery> 
            
            <cfif #getassignmentslip.selftotal# neq 0>
            
				<cfif #getassignmentslip.payrollperiod# gt 12>
                    <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                    output="1,#getbatches.batches#,#counter#,GL,JE,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,Cost of Sales - Pays,#dateformat(getassignmentslip.assignmentslipdate,'yyyy')#,#evaluate('getassignmentslip.payrollperiod MOD 12')#"
                    addnewline="Yes">
                <cfelse>
                    <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                    output="1,#getbatches.batches#,#counter#,GL,JE,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,Cost of Sales - Pays,#dateformat(getassignmentslip.assignmentslipdate,'yyyy')#,#getassignmentslip.payrollperiod#"
                    addnewline="Yes">
                </cfif>
                                 
      
    
                        <!---Normal--->
                        <cfif #getassignmentslip.selfsalary# gt 0>
                            <cfset type2 = "Normal">
                            
                            <cfquery name="chartofaccount" datasource="#dts#">
                                SELECT c_credit, c_creditbranch, c_debit, c_debitbranch
                                FROM chartofaccount
                                WHERE type1_id = "#getplacementno.jobpostype#"
                                AND
                                type2 = "#type2#"  
                                AND c_debit != ""    
                            </cfquery>  
                            
                            <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#-#getplacementno.location#,#getassignmentslip.selfsalary#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#,#getassignmentslip.selfsalary#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                            <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#-#getplacementno.location#,-#getassignmentslip.selfsalary#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#,-#getassignmentslip.selfsalary#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                        </cfif>
                        <!---Normal--->
                        
                        
                        <!--- OT --->
                        <cfif #getassignmentslip.selfot8# gt 0>
                            <cfset type2 = "PH 1.0">
                            
                            <cfquery name="chartofaccount" datasource="#dts#">
                                SELECT c_credit, c_creditbranch, c_debit, c_debitbranch
                                FROM chartofaccount
                                WHERE type1_id = "#getplacementno.jobpostype#"
                                AND
                                type2 = "#type2#"  
                                AND c_debit != ""    
                            </cfquery> 
                            
                            <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#-#getplacementno.location#,#getassignmentslip.selfot8#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#,#getassignmentslip.selfot8#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                            <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#-#getplacementno.location#,-#getassignmentslip.selfot8#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#,-#getassignmentslip.selfot8#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                        </cfif>  
                          
                        <cfif #getassignmentslip.selfot7# gt 0>
                            <cfset type2 = "PH 1.0">
                            
                            <cfquery name="chartofaccount" datasource="#dts#">
                                SELECT c_credit, c_creditbranch, c_debit, c_debitbranch
                                FROM chartofaccount
                                WHERE type1_id = "#getplacementno.jobpostype#"
                                AND
                                type2 = "#type2#"  
                                AND c_debit != ""    
                            </cfquery> 
                            
                            <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#-#getplacementno.location#,#getassignmentslip.selfot7#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#,#getassignmentslip.selfot7#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                            <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#-#getplacementno.location#,-#getassignmentslip.selfot7#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#,-#getassignmentslip.selfot7#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                        </cfif>
                            
                        <cfif #getassignmentslip.selfot6# gt 0>
                            <cfset type2 = "RD 2.0">
                            
                            <cfquery name="chartofaccount" datasource="#dts#">
                                SELECT c_credit, c_creditbranch, c_debit, c_debitbranch
                                FROM chartofaccount
                                WHERE type1_id = "#getplacementno.jobpostype#"
                                AND
                                type2 = "#type2#"  
                                AND c_debit != ""    
                            </cfquery> 
                            
                            <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#-#getplacementno.location#,#getassignmentslip.selfot6#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#,#getassignmentslip.selfot6#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                            <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#-#getplacementno.location#,-#getassignmentslip.selfot6#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#,-#getassignmentslip.selfot6#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                        </cfif>
                            
                        <cfif #getassignmentslip.selfot5# gt 0>
                            <cfset type2 = "RD 1.0">
                            
                            <cfquery name="chartofaccount" datasource="#dts#">
                                SELECT c_credit, c_creditbranch, c_debit, c_debitbranch
                                FROM chartofaccount
                                WHERE type1_id = "#getplacementno.jobpostype#"
                                AND
                                type2 = "#type2#"  
                                AND c_debit != ""    
                            </cfquery> 
                            
                            <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#-#getplacementno.location#,#getassignmentslip.selfot5#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#,#getassignmentslip.selfot5#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                            <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#-#getplacementno.location#,-#getassignmentslip.selfot5#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#,-#getassignmentslip.selfot5#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                        </cfif>
                            
                        <cfif #getassignmentslip.selfot4# gt 0>
                            <cfset type2 = "OT 3.0">
                            
                            <cfquery name="chartofaccount" datasource="#dts#">
                                SELECT c_credit, c_creditbranch, c_debit, c_debitbranch
                                FROM chartofaccount
                                WHERE type1_id = "#getplacementno.jobpostype#"
                                AND
                                type2 = "#type2#"  
                                AND c_debit != ""    
                            </cfquery> 
                            
                            <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#-#getplacementno.location#,#getassignmentslip.selfot4#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#,#getassignmentslip.selfot4#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                            <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#-#getplacementno.location#,-#getassignmentslip.selfot4#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#,-#getassignmentslip.selfot4#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                        </cfif>
                            
                        <cfif #getassignmentslip.selfot3# gt 0>
                            <cfset type2 = "OT 2.0">
                            
                            <cfquery name="chartofaccount" datasource="#dts#">
                                SELECT c_credit, c_creditbranch, c_debit, c_debitbranch
                                FROM chartofaccount
                                WHERE type1_id = "#getplacementno.jobpostype#"
                                AND
                                type2 = "#type2#"  
                                AND c_debit != ""    
                            </cfquery> 
                            
                            <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#-#getplacementno.location#,#getassignmentslip.selfot3#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#,#getassignmentslip.selfot3#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                            <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#-#getplacementno.location#,-#getassignmentslip.selfot3#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#,-#getassignmentslip.selfot3#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                        </cfif>
                        
                        <cfif #getassignmentslip.selfot2# gt 0>
                            <cfset type2 = "OT 1.5">
                            
                            <cfquery name="chartofaccount" datasource="#dts#">
                                SELECT c_credit, c_creditbranch, c_debit, c_debitbranch
                                FROM chartofaccount
                                WHERE type1_id = "#getplacementno.jobpostype#"
                                AND
                                type2 = "#type2#"  
                                AND c_debit != ""    
                            </cfquery> 
                            
                            <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#-#getplacementno.location#,#getassignmentslip.selfot2#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#,#getassignmentslip.selfot2#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                            <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#-#getplacementno.location#,-#getassignmentslip.selfot2#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#,-#getassignmentslip.selfot2#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                        </cfif>
                        
                        <cfif #getassignmentslip.selfot1# gt 0>
                            <cfset type2 = "OT 1.0">
                            
                            <cfquery name="chartofaccount" datasource="#dts#">
                                SELECT c_credit, c_creditbranch, c_debit, c_debitbranch
                                FROM chartofaccount
                                WHERE type1_id = "#getplacementno.jobpostype#"
                                AND
                                type2 = "#type2#"  
                                AND c_debit != ""    
                            </cfquery> 
                            
                            <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#-#getplacementno.location#,#getassignmentslip.selfot1#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#,#getassignmentslip.selfot1#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                            <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#-#getplacementno.location#,-#getassignmentslip.selfot1#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#,-#getassignmentslip.selfot1#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>           
                        </cfif>
                        <!---OT--->
                        
                      <!---fixed allowance--->
                      
                      <cfloop from="1" to="6" index="a">
                          <cfif evaluate('getassignmentslip.fixawee#a#') gt 0>                      
                              <cfset type2 = evaluate('getassignmentslip.fixawdesp#a#')>
                              
                              <cfquery name="chartofaccount" datasource="#dts#">
                                SELECT c_credit, c_creditbranch, c_debit, c_debitbranch
                                FROM chartofaccount
                                WHERE type1_id = "#getplacementno.jobpostype#"
                                AND
                                <cfif #type2# CONTAINS "OT1.5" OR #type2# CONTAINS "OT 1.5">
                                    type2 = "OT 1.5"
                                    AND c_debit != ""
                                <cfelseif #type2# CONTAINS "OT2.0" OR #type2# CONTAINS "OT 2.0">
                                    type2 = "OT 2.0"
                                    AND c_debit != ""
                                <cfelse>
                                    type2 = "#type2#"  
                                    AND c_debit != ""
                                </cfif>     
                            </cfquery>  
                              
                                  <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                                          <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv"
                                          output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#-#getplacementno.location#,#evaluate('getassignmentslip.fixawee#a#')#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                              addnewline="yes">
                                          <cfelse>
                                          <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv"
                                          output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#,#evaluate('getassignmentslip.fixawee#a#')#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                              addnewline="yes">
                                      </cfif>
                                      <cfset itemcounter += 1>
                                      <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                                          <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv"
                                          output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#-#getplacementno.location#,- #evaluate('getassignmentslip.fixawee#a#')#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                              addnewline="yes">
                                          <cfelse>
                                          <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv"
                                          output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#,- #evaluate('getassignmentslip.fixawee#a#')#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                              addnewline="yes">
                                      </cfif>
                                      <cfset itemcounter += 1>
                           <cfelse>
                         </cfif>
                      </cfloop>
                      
                      
                      <!---fixed allowance--->
                        
                      <!---Allowance 1--->
                      
                      <cfloop from="1" to="18" index="a">
                          <cfif evaluate('getassignmentslip.awee#a#') gt 0>
                              <cfset type2 = evaluate('getassignmentslip.allowancedesp#a#')>
                               
                              <cfquery name="chartofaccount" datasource="#dts#">
                                SELECT c_credit, c_creditbranch, c_debit, c_debitbranch
                                FROM chartofaccount
                                WHERE type1_id = "#getplacementno.jobpostype#"
                                AND
                                <cfif #type2# CONTAINS "OT1.5" OR #type2# CONTAINS "OT 1.5">
                                    type2 = "OT 1.5"
                                    AND c_debit != ""
                                <cfelseif #type2# CONTAINS "OT2.0" OR #type2# CONTAINS "OT 2.0">
                                    type2 = "OT 2.0"
                                    AND c_debit != ""
                                <cfelse>
                                    type2 = "#type2#"  
                                    AND c_debit != ""
                                </cfif>     
                            </cfquery> 
                                  
                                      <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                                          <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv"
                                          output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#-#getplacementno.location#,#evaluate('getassignmentslip.awee#a#')#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                              addnewline="yes">
                                          <cfelse>
                                          <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv"
                                          output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#,#evaluate('getassignmentslip.awee#a#')#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                              addnewline="yes">
                                      </cfif>
                                      <cfset itemcounter += 1>
                                      <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                                          <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv"
                                          output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#-#getplacementno.location#,- #evaluate('getassignmentslip.awee#a#')#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                              addnewline="yes">
                                          <cfelse>
                                          <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv"
                                          output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#,- #evaluate('getassignmentslip.awee#a#')#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                              addnewline="yes">
                                      </cfif>
                                      <cfset itemcounter += 1>
                           <cfelse>
                         </cfif>
                      </cfloop>
        
                    <cfset counter += 1>
        	</cfif>
		</cfloop>
        <!---<cfabort>--->

		<!---FINISHED WRITING CSV--->
		
        <cfheader name="Content-Type" value="csv">
		<cfset filename = "MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv">

		<cfheader name="Content-Disposition" value="inline; filename=#filename#">		
		<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv">
      
        
</cfoutput>