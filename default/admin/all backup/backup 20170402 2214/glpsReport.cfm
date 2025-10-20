<cfoutput>
<cfset uuid = createuuid()>
<cfset timenow = dateformat(now(), 'yyyymmdd_hhmmss')>

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
                <cfelseif #getictran.desp# CONTAINS "PH1.0" or #getictran.desp# CONTAINS "PH 1.0">
                	type2 = "PH 2.0"		<!---according to kangwei ph1.0 is same as ph 2.0 for gl account--->
                    AND c_debit != ""
                <cfelse>
                    type2 = "#type2#"  
                    AND c_debit != ""
                </cfif>     
            </cfquery> 
            
            <cfif #getassignmentslip.selftotal# neq 0>
            
				<cfif #getassignmentslip.payrollperiod# gt 12>
                    <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv" 
                    output="1,#getbatches.batches#,#counter#,GL,JE,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,Cost of Sales - Pays,#dateformat(getassignmentslip.assignmentslipdate,'yyyy')#,#evaluate('getassignmentslip.payrollperiod MOD 12')#"
                    addnewline="Yes">
                <cfelse>
                    <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv" 
                    output="1,#getbatches.batches#,#counter#,GL,JE,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,Cost of Sales - Pays,#dateformat(getassignmentslip.assignmentslipdate,'yyyy')#,#getassignmentslip.payrollperiod#"
                    addnewline="Yes">
                </cfif>
                                 
      
    
                        <!---Normal--->
                        <cfif #getassignmentslip.selfsalary# neq 0>
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
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#-#getplacementno.location#,#getassignmentslip.selfsalary#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#,#getassignmentslip.selfsalary#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                            <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#-#getplacementno.location#,#val(getassignmentslip.selfsalary)*-1#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#,#val(getassignmentslip.selfsalary)*-1#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                        </cfif>
                        <!---Normal--->
                        
                        
                        <!--- OT --->
                        <cfif #getassignmentslip.selfot8# neq 0>
                            <cfset type2 = "PH 2.0">
                            
                            <cfquery name="chartofaccount" datasource="#dts#">
                                SELECT c_credit, c_creditbranch, c_debit, c_debitbranch
                                FROM chartofaccount
                                WHERE type1_id = "#getplacementno.jobpostype#"
                                AND
                                type2 = "#type2#"  
                                AND c_debit != ""    
                            </cfquery> 
                            
                            <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#-#getplacementno.location#,#getassignmentslip.selfot8#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#,#getassignmentslip.selfot8#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                            <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#-#getplacementno.location#,#val(getassignmentslip.selfot8)*-1#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#,#val(getassignmentslip.selfot8)*-1#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                        </cfif>  
                          
                        <cfif #getassignmentslip.selfot7# neq 0>
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
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#-#getplacementno.location#,#getassignmentslip.selfot7#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#,#getassignmentslip.selfot7#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                            <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#-#getplacementno.location#,#val(getassignmentslip.selfot7)*-1#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#,#val(getassignmentslip.selfot7)*-1#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                        </cfif>
                            
                        <cfif #getassignmentslip.selfot6# neq 0>
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
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#-#getplacementno.location#,#getassignmentslip.selfot6#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#,#getassignmentslip.selfot6#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                            <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#-#getplacementno.location#,#val(getassignmentslip.selfot6)*-1#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#,#val(getassignmentslip.selfot6)*-1#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                        </cfif>
                            
                        <cfif #getassignmentslip.selfot5# neq 0>
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
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#-#getplacementno.location#,#getassignmentslip.selfot5#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#,#getassignmentslip.selfot5#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                            <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#-#getplacementno.location#,#val(getassignmentslip.selfot5)*-1#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#,#val(getassignmentslip.selfot5)*-1#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item:"" #type2#"",""#type2#"""
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                        </cfif>
                            
                        <cfif #getassignmentslip.selfot4# neq 0>
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
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#-#getplacementno.location#,#getassignmentslip.selfot4#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#,#getassignmentslip.selfot4#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                            <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#-#getplacementno.location#,#val(getassignmentslip.selfot4)*-1#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#,#val(getassignmentslip.selfot4)*-1#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                        </cfif>
                            
                        <cfif #getassignmentslip.selfot3# neq 0>
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
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#-#getplacementno.location#,#getassignmentslip.selfot3#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#,#getassignmentslip.selfot3#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                            <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#-#getplacementno.location#,#val(getassignmentslip.selfot3)*-1#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#,#val(getassignmentslip.selfot3)*-1#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                        </cfif>
                        
                        <cfif #getassignmentslip.selfot2# neq 0>
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
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#-#getplacementno.location#,#getassignmentslip.selfot2#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#,#getassignmentslip.selfot2#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                            <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#-#getplacementno.location#,#val(getassignmentslip.selfot2)*-1#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#,#val(getassignmentslip.selfot2)*-1#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                        </cfif>
                        
                        <cfif #getassignmentslip.selfot1# neq 0>
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
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#-#getplacementno.location#,#getassignmentslip.selfot1#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",#type2#"""
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#,#getassignmentslip.selfot1#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                            <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#-#getplacementno.location#,#val(getassignmentslip.selfot1)*-1#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#,#val(getassignmentslip.selfot1)*-1#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>           
                        </cfif>
                        <!---OT--->
                        
                      <!---fixed allowance--->
                      
                      <cfloop from="1" to="6" index="a">
                          <cfif evaluate('getassignmentslip.fixawee#a#') neq 0>                      
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
                                <cfelseif #getictran.desp# CONTAINS "PH1.0" or #getictran.desp# CONTAINS "PH 1.0">
                                    type2 = "PH 2.0"
                                    AND c_debit != ""
                                <cfelse>
                                    type2 = "#type2#"  
                                    AND c_debit != ""
                                </cfif>     
                            </cfquery>  
                              
                                  <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                                          <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv"
                                          output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#-#getplacementno.location#,#evaluate('getassignmentslip.fixawee#a#')#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                                              addnewline="yes">
                                          <cfelse>
                                          <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv"
                                          output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#,#evaluate('getassignmentslip.fixawee#a#')#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                                              addnewline="yes">
                                      </cfif>
                                      <cfset itemcounter += 1>
                                      <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                                          <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv"
                                          output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#-#getplacementno.location#,#val(evaluate('getassignmentslip.fixawee#a#'))*-1#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                                              addnewline="yes">
                                          <cfelse>
                                          <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv"
                                          output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#,#val(evaluate('getassignmentslip.fixawee#a#'))*-1#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                                              addnewline="yes">
                                      </cfif>
                                      <cfset itemcounter += 1>
                           <cfelse>
                         </cfif>
                      </cfloop>
                      
                      
                      <!---fixed allowance--->
                        
                      <!---Allowance 1--->
                      
                      <cfloop from="1" to="18" index="a">
                          <cfif evaluate('getassignmentslip.awee#a#') neq 0>
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
                                <cfelseif #getictran.desp# CONTAINS "PH1.0" or #getictran.desp# CONTAINS "PH 1.0">
                                    type2 = "PH 2.0"
                                    AND c_debit != ""
                                <cfelse>
                                    type2 = "#type2#"  
                                    AND c_debit != ""
                                </cfif>     
                            </cfquery> 
                                  
                                      <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                                          <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv"
                                          output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#-#getplacementno.location#,#evaluate('getassignmentslip.awee#a#')#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                                              addnewline="yes">
                                          <cfelse>
                                          <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv"
                                          output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#,#evaluate('getassignmentslip.awee#a#')#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                                              addnewline="yes">
                                      </cfif>
                                      <cfset itemcounter += 1>
                                      <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                                          <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv"
                                          output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#-#getplacementno.location#,#val(evaluate('getassignmentslip.awee#a#'))*-1#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                                              addnewline="yes">
                                          <cfelse>
                                          <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv"
                                          output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#,#val(evaluate('getassignmentslip.awee#a#'))*-1#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                                              addnewline="yes">
                                      </cfif>
                                      <cfset itemcounter += 1>
                           <cfelse>
                         </cfif>
                      </cfloop>
                      
                      <!---Allowance --->
                      
                      <!---Additional Item--->
                      
                        <cfloop from="1" to="3" index="a">
                        
                        	<cfif #a# eq 1>
                            	<cfset addchargeself = "addchargeself">
                                <cfset addchargedesp = "addchargedesp">
                            <cfelse>
                            	<cfset addchargeself = "addchargeself#a#">
                                <cfset addchargedesp = "addchargedesp#a#">
                            </cfif>
                            
							<cfif evaluate('getassignmentslip.#addchargeself#') neq 0>
								<cfset type2 = evaluate('getassignmentslip.#addchargedesp#')>
                                
                                <cfquery name="chartofaccount" datasource="#dts#">
                                    SELECT c_credit, c_creditbranch, c_debit, c_debitbranch
                                    FROM chartofaccount
                                    WHERE type1_id = "#getplacementno.jobpostype#"
                                    AND
                                    <!---<cfif #type2# CONTAINS "+Med Benefit Reimburse">
                                        type2 = "+Med Benefit Reimburse"
                                        AND c_debit != ""
                                    <cfelseif #type2# CONTAINS "Admin Fee -variable" OR #type2# CONTAINS "OT 2.0">
                                        type2 = "OT 2.0"
                                        AND c_debit != ""
                                    <cfelseif #getictran.desp# CONTAINS "PH1.0" or #getictran.desp# CONTAINS "PH 1.0">
                                        type2 = "PH 2.0"
                                        AND c_debit != ""
                                    <cfelse>--->
                                        type2 = "#type2#"  
                                        AND c_debit != ""
                                    <!---</cfif>  --->   
                                </cfquery> 
                                
                                <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                                    <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv"
                                        output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#-#getplacementno.location#,#evaluate('getassignmentslip.#addchargeself#')#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                                        addnewline="yes">
                                <cfelse>
                                    <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv"
                                        output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#,#evaluate('getassignmentslip.#addchargeself#')#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                                        addnewline="yes">
                                </cfif>
                                <cfset itemcounter += 1>
                                <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                                    <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv"
                                        output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#-#getplacementno.location#,#val(evaluate('getassignmentslip.#addchargeself#'))*-1#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                                        addnewline="yes">
                                <cfelse>
                                    <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv"
                                        output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#,#val(evaluate('getassignmentslip.#addchargeself#'))*-1#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                                        addnewline="yes">
                                </cfif>
                                <cfset itemcounter += 1>
                                <cfelse>
                            </cfif>
                        </cfloop>
                      
                      <!---additional item--->
                      
                      <!---NPL--->
                      
                          <cfloop from="1" to="10" index="a">
                          
							<cfif evaluate("getassignmentslip.lvltotalee#a#") neq 0>
								<cfset type2 = evaluate('getassignmentslip.lvldesp#a#')>
                                
                                <cfquery name="chartofaccount" datasource="#dts#">
                                    SELECT c_credit, c_creditbranch, c_debit, c_debitbranch
                                    FROM chartofaccount
                                    WHERE type1_id = "#getplacementno.jobpostype#"
                                    AND
                                    <cfif #type2# CONTAINS "No Pay Leave">
                                        type2 = "Unpaid Leave"
                                        AND c_debit != ""
                                    <cfelse>
                                        type2 = "#type2#"  
                                        AND c_debit != ""
                                    </cfif>     
                                </cfquery> 
                                
                                <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                                    <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv"
                                     output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#-#getplacementno.location#,#evaluate('getassignmentslip.lvltotalee#a#')#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                                        addnewline="yes">
                                <cfelse>
                                    <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv"
                                     output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#,#evaluate('getassignmentslip.lvltotalee#a#')#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                                        addnewline="yes">
                                </cfif>
                                <cfset itemcounter += 1>
                                <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                                    <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv"
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#-#getplacementno.location#,#val(evaluate('getassignmentslip.lvltotalee#a#')*-1)#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                                    	addnewline="yes">
                                <cfelse>
                                    <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv"
                                     output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#, #val(evaluate('getassignmentslip.lvltotalee#a#')*-1)#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getassignmentslip.assignmentslipdate,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: ""#type2#"",""#type2#"""
                                        addnewline="yes">
                                </cfif>
                                <cfset itemcounter += 1>
                                <cfelse>
                            </cfif>
                        </cfloop>
                      
                      <!---NPL--->
        
                    <cfset counter += 1>
        	</cfif>
		</cfloop>
        <!---<cfabort>--->

		<!---FINISHED WRITING CSV--->
		
        <cfheader name="Content-Type" value="csv">
		<cfset filename = "MPpostingPS_#url.branch#_#timenow#.csv">

		<cfheader name="Content-Disposition" value="inline; filename=#filename#">		
		<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\MPpostingPS_#url.branch#_#timenow#.csv">
      
        
</cfoutput>