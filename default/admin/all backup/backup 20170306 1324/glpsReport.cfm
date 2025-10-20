<!---<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Untitled Document</title>
</head>

<body>

<cfform action="accpaccInvReport.cfm" method="post" name="form123" id="form123" target="_blank">

<cfoutput>
<h3>
	<a><font size="2">Post to AccPacc</font></a>
</h3>
	<cfquery name="getBranch" datasource="#dts#">
        SELECT branch
        FROM assignmentslip 
        WHERE 
        <cfif isdefined('form.batches')> 
            batches in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.batches#" separator="," list="yes">)
        </cfif>
        AND branch = '#url.branch#'
        ORDER by branch
    </cfquery>
    
    <cfdump var = #url.branch#>
    
    &nbsp;&nbsp;&nbsp;<input type="Submit" name="Submit" value="GLPS Report" onClick="document.form123.action = 'glpsReport.cfm';">
    
</cfoutput>
</cfform>
</body>
</html>--->

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
                            type2 = "#type2#"      
                        </cfquery>
            
            <cfif #getartran.recordcount# neq 0>
            
				<cfif #getartran.fperiod# gt 12>
                    <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                    output="1,#getbatches.batches#,#counter#,GL,JE,#dateformat(getartran.wos_date,'yyyymmdd')#,Cost of Sales - Pays,#dateformat(getartran.wos_date,'yyyy')#,#evaluate('getartran.fperiod MOD 12')#"
                    addnewline="Yes">
                <cfelse>
                    <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                    output="1,#getbatches.batches#,#counter#,GL,JE,#dateformat(getartran.wos_date,'yyyymmdd')#,Cost of Sales - Pays,#dateformat(getartran.wos_date,'yyyy')#,#getartran.fperiod#"
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
                            </cfquery> 
                             
                            
                            <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#-#getplacementno.location#,#getassignmentslip.selfsalary#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getartran.wos_date,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#,#getassignmentslip.selfsalary#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getartran.wos_date,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                            <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#-#getplacementno.location#,-#getassignmentslip.selfsalary#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getartran.wos_date,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#,-#getassignmentslip.selfsalary#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getartran.wos_date,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                        </cfif>
                        <!---Normal--->
                        
                        
                        <!--- OT --->
                        <cfif #getassignmentslip.selfot8# gt 0>
                            <cfset type2 = "PH 1.0">
                            <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#-#getplacementno.location#,#getassignmentslip.selfot8#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getartran.wos_date,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#,#getassignmentslip.selfot8#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getartran.wos_date,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                            <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#-#getplacementno.location#,-#getassignmentslip.selfot8#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getartran.wos_date,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#,-#getassignmentslip.selfot8#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getartran.wos_date,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                        </cfif>  
                          
                        <cfif #getassignmentslip.selfot7# gt 0>
                            <cfset type2 = "PH 1.0">
                            <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#-#getplacementno.location#,#getassignmentslip.selfot7#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getartran.wos_date,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#,#getassignmentslip.selfot7#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getartran.wos_date,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                            <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#-#getplacementno.location#,-#getassignmentslip.selfot7#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getartran.wos_date,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#,-#getassignmentslip.selfot7#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getartran.wos_date,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                        </cfif>
                            
                        <cfif #getassignmentslip.selfot6# gt 0>
                            <cfset type2 = "RD 2.0">
                            <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#-#getplacementno.location#,#getassignmentslip.selfot6#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getartran.wos_date,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#,#getassignmentslip.selfot6#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getartran.wos_date,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                            <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#-#getplacementno.location#,-#getassignmentslip.selfot6#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getartran.wos_date,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#,-#getassignmentslip.selfot6#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getartran.wos_date,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                        </cfif>
                            
                        <cfif #getassignmentslip.selfot5# gt 0>
                            <cfset type2 = "RD 1.0">
                            <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#-#getplacementno.location#,#getassignmentslip.selfot5#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getartran.wos_date,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#,#getassignmentslip.selfot5#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getartran.wos_date,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                            <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#-#getplacementno.location#,-#getassignmentslip.selfot5#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getartran.wos_date,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#,-#getassignmentslip.selfot5#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getartran.wos_date,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                        </cfif>
                            
                        <cfif #getassignmentslip.selfot4# gt 0>
                            <cfset type2 = "OT 3.0">
                            <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#-#getplacementno.location#,#getassignmentslip.selfot4#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getartran.wos_date,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#,#getassignmentslip.selfot4#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getartran.wos_date,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                            <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#-#getplacementno.location#,-#getassignmentslip.selfot4#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getartran.wos_date,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#,-#getassignmentslip.selfot4#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getartran.wos_date,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                        </cfif>
                            
                        <cfif #getassignmentslip.selfot3# gt 0>
                            <cfset type2 = "OT 2.0">
                            <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#-#getplacementno.location#,#getassignmentslip.selfot3#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getartran.wos_date,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#,#getassignmentslip.selfot3#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getartran.wos_date,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                            <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#-#getplacementno.location#,-#getassignmentslip.selfot3#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getartran.wos_date,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#,-#getassignmentslip.selfot3#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getartran.wos_date,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                        </cfif>
                        
                        <cfif #getassignmentslip.selfot2# gt 0>
                            <cfset type2 = "OT 1.5">
                            <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#-#getplacementno.location#,#getassignmentslip.selfot2#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getartran.wos_date,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#,#getassignmentslip.selfot2#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getartran.wos_date,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                            <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#-#getplacementno.location#,-#getassignmentslip.selfot2#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getartran.wos_date,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#,-#getassignmentslip.selfot2#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getartran.wos_date,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                        </cfif>
                        
                        <cfif #getassignmentslip.selfot1# gt 0>
                            <cfset type2 = "OT 1.0">
                            <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#-#getplacementno.location#,#getassignmentslip.selfot1#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getartran.wos_date,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#,#getassignmentslip.selfot1#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getartran.wos_date,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                            <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#-#getplacementno.location#,-#getassignmentslip.selfot1#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getartran.wos_date,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#,-#getassignmentslip.selfot1#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getartran.wos_date,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
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
                                type2 = "#type2#"      
                            </cfquery>
                              
                                  <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                                          <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv"
                                          output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#-#getplacementno.location#,#evaluate('getassignmentslip.fixawee#a#')#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getartran.wos_date,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                              addnewline="yes">
                                          <cfelse>
                                          <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv"
                                          output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#,#evaluate('getassignmentslip.fixawee#a#')#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getartran.wos_date,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                              addnewline="yes">
                                      </cfif>
                                      <cfset itemcounter += 1>
                                      <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                                          <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv"
                                          output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#-#getplacementno.location#,- #evaluate('getassignmentslip.fixawee#a#')#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getartran.wos_date,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                              addnewline="yes">
                                          <cfelse>
                                          <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv"
                                          output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#,- #evaluate('getassignmentslip.fixawee#a#')#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getartran.wos_date,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
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
                                type2 = "#type2#"      
                            </cfquery>
                                  
                                      <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                                          <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv"
                                          output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#-#getplacementno.location#,#evaluate('getassignmentslip.awee#a#')#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getartran.wos_date,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                              addnewline="yes">
                                          <cfelse>
                                          <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv"
                                          output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_debit#,#evaluate('getassignmentslip.awee#a#')#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getartran.wos_date,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /Burden /PaySlip ## /Item: #type2#,#type2#"
                                              addnewline="yes">
                                      </cfif>
                                      <cfset itemcounter += 1>
                                      <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                                          <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv"
                                          output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#-#getplacementno.location#,- #evaluate('getassignmentslip.awee#a#')#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getartran.wos_date,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                              addnewline="yes">
                                          <cfelse>
                                          <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv"
                                          output="2,#getbatches.batches#,#counter#,#itemcounter#,#chartofaccount.c_credit#,- #evaluate('getassignmentslip.awee#a#')#,/TS## /Job###getassignmentslip.placementno#,#dateformat(getartran.wos_date,'yyyymmdd')#,GL,JE,/Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#,#type2#"
                                              addnewline="yes">
                                      </cfif>
                                      <cfset itemcounter += 1>
                           <cfelse>
                         </cfif>
                      </cfloop>
                      
                      <!---allowance 1--->
                      
                      
                      <!---<cfif #getassignmentslip.awee1# gt 0>
                          <cfset type2 = "#getassignmentslip.allowancedesp1#">    
                              <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                                  <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                      output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_debit#-#getplacementno.location#, #getassignmentslip.awee1#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                      addnewline="yes">
                                  <cfelse>
                                  <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                      output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_debit#, #getassignmentslip.awee1#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                      addnewline="yes">
                              </cfif>
                              <cfset itemcounter += 1>
                              <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                                  <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                      output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_credit#-#getplacementno.location#, -#getassignmentslip.awee1#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                      addnewline="yes">
                                  <cfelse>
                                  <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                      output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_credit#, -#getassignmentslip.awee1#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                      addnewline="yes">
                              </cfif>
                              <cfset itemcounter += 1>
                      </cfif>
                      <!---allowance 1--->
                      
                      <!---Allowance desp 2--->
                      <cfif "#getassignmentslip.awee2#" gt 0>
                          <cfset type2 = "#getassignmentslip.allowancedesp2#">    
                          <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                              <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                  output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_debit#-#getplacementno.location#, #getassignmentslip.awee2#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                  addnewline="yes">
                              <cfelse>
                              <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                  output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_debit#, #getassignmentslip.awee2#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                  addnewline="yes">
                          </cfif>
                          <cfset itemcounter += 1>
                          <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                              <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                  output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_credit#-#getplacementno.location#, -#getassignmentslip.awee2#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                  addnewline="yes">
                              <cfelse>
                              <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                  output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_credit#, -#getassignmentslip.awee2#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                  addnewline="yes">
                          </cfif>
                          <cfset itemcounter += 1>
                      </cfif>
                      <!---allowance desp 2 --->
                      
                      <!---Allowance desp 3--->
                      <cfif "#getassignmentslip.awee3#" gt 0>
                          <cfset type2 = "#getassignmentslip.allowancedesp3#">    
                          <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                              <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                  output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_debit#-#getplacementno.location#, #getassignmentslip.awee3#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                  addnewline="yes">
                              <cfelse>
                              <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                  output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_debit#, #getassignmentslip.awee3#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                  addnewline="yes">
                          </cfif>
                          <cfset itemcounter += 1>
                          <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                              <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                  output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_credit#-#getplacementno.location#, -#getassignmentslip.awee3#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                  addnewline="yes">
                              <cfelse>
                              <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                  output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_credit#, -#getassignmentslip.awee3#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                  addnewline="yes">
                          </cfif>
                          <cfset itemcounter += 1>
                      </cfif>
                      <!---allowance desp 3--->
                      
                      <!---Allowance desp 4--->
                      <cfif "#getassignmentslip.awee4#" gt 0>
                          <cfset type2 = "#getassignmentslip.allowancedesp4#">    
                          <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                              <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                  output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_debit#-#getplacementno.location#, #getassignmentslip.awee4#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                  addnewline="yes">
                              <cfelse>
                              <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                  output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_debit#, #getassignmentslip.awee4#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                  addnewline="yes">
                          </cfif>
                          <cfset itemcounter += 1>
                          <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                              <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                  output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_credit#-#getplacementno.location#, -#getassignmentslip.awee4#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                  addnewline="yes">
                              <cfelse>
                              <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                  output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_credit#, -#getassignmentslip.awee4#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                  addnewline="yes">
                          </cfif>
                          <cfset itemcounter += 1>
                      </cfif>
                      <!---allowance desp 4---> 
                      
                      <!---Allowance desp 5--->
                      <cfif "#getassignmentslip.awee5#" gt 0>
                          <cfset type2 = "#getassignmentslip.allowancedesp5#">    
                          <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                              <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                  output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_debit#-#getplacementno.location#, #getassignmentslip.awee5#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                  addnewline="yes">
                              <cfelse>
                              <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                  output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_debit#, #getassignmentslip.awee5#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                  addnewline="yes">
                          </cfif>
                          <cfset itemcounter += 1>
                          <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                              <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                  output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_credit#-#getplacementno.location#, -#getassignmentslip.awee5#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                  addnewline="yes">
                              <cfelse>
                              <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                  output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_credit#, -#getassignmentslip.awee5#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                  addnewline="yes">
                          </cfif>
                          <cfset itemcounter += 1>
                      </cfif>
                      <!---allowance desp 5--->
                      
                      <!---Allowance desp 6--->
                      <cfif "#getassignmentslip.awee6#" gt 0>
                          <cfset type2 = "#getassignmentslip.allowancedesp6#">    
                          <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                              <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                  output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_debit#-#getplacementno.location#, #getassignmentslip.awee6#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                  addnewline="yes">
                              <cfelse>
                              <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                  output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_debit#, #getassignmentslip.awee6#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                  addnewline="yes">
                          </cfif>
                          <cfset itemcounter += 1>
                          <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                              <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                  output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_credit#-#getplacementno.location#, -#getassignmentslip.awee6#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                  addnewline="yes">
                              <cfelse>
                              <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                  output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_credit#, -#getassignmentslip.awee6#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                  addnewline="yes">
                          </cfif>
                          <cfset itemcounter += 1>
                      </cfif>
                      <!---allowance desp 6--->
                      
                      <!---Allowance desp 7--->
                      <cfif "#getassignmentslip.awee7#" gt 0>
                          <cfset type2 = "#getassignmentslip.allowancedesp7#">    
                          <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                              <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                  output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_debit#-#getplacementno.location#, #getassignmentslip.awee7#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                  addnewline="yes">
                              <cfelse>
                              <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                  output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_debit#, #getassignmentslip.awee7#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                  addnewline="yes">
                          </cfif>
                          <cfset itemcounter += 1>
                          <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                              <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                  output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_credit#-#getplacementno.location#, -#getassignmentslip.awee7#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                  addnewline="yes">
                              <cfelse>
                              <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                  output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_credit#, -#getassignmentslip.awee7#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                  addnewline="yes">
                          </cfif>
                          <cfset itemcounter += 1>
                      </cfif>
                      <!---allowance desp 7--->
                      
                      <!---Allowance desp 8--->
                      <cfif "#getassignmentslip.awee8#" gt 0>
                          <cfset type2 = "#getassignmentslip.allowancedesp8#">    
                          <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                              <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                  output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_debit#-#getplacementno.location#, #getassignmentslip.awee8#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                  addnewline="yes">
                              <cfelse>
                              <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                  output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_debit#, #getassignmentslip.awee8#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                  addnewline="yes">
                          </cfif>
                          <cfset itemcounter += 1>
                          <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                              <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                  output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_credit#-#getplacementno.location#, -#getassignmentslip.awee8#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                  addnewline="yes">
                              <cfelse>
                              <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                  output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_credit#, -#getassignmentslip.awee8#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                  addnewline="yes">
                          </cfif>
                          <cfset itemcounter += 1>
                      </cfif>
                      <!---allowance desp 8--->
                      
                      <!---Allowance desp 9--->
                        <cfif "#getassignmentslip.awee9#" gt 0>
                            <cfset type2 = "#getassignmentslip.allowancedesp9#">    
                            <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_debit#-#getplacementno.location#, #getassignmentslip.awee9#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_debit#, #getassignmentslip.awee9#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                            <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_credit#-#getplacementno.location#, -#getassignmentslip.awee9#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_credit#, -#getassignmentslip.awee9#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                        </cfif>
                        <!---allowance desp 9--->
                        
                        <!---Allowance desp 10--->
                        <cfif "#getassignmentslip.awee10#" gt 0>
                            <cfset type2 = "#getassignmentslip.allowancedesp10#">    
                            <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_debit#-#getplacementno.location#, #getassignmentslip.awee10#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_debit#, #getassignmentslip.awee10#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                            <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_credit#-#getplacementno.location#, -#getassignmentslip.awee10#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_credit#, -#getassignmentslip.awee10#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                        </cfif>
                        <!---allowance desp 10---> 
                        
                        <!---Allowance desp 11--->
                        <cfif "#getassignmentslip.awee11#" gt 0>
                            <cfset type2 = "#getassignmentslip.allowancedesp11#">    
                            <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_debit#-#getplacementno.location#, #getassignmentslip.awee11#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_debit#, #getassignmentslip.awee11#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                            <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_credit#-#getplacementno.location#, -#getassignmentslip.awee11#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_credit#, -#getassignmentslip.awee11#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                        </cfif>
                        <!---allowance desp 11--->
                        
                        <!---Allowance desp 12--->
                        <cfif "#getassignmentslip.awee12#" gt 0>
                            <cfset type2 = "#getassignmentslip.allowancedesp12#">    
                            <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_debit#-#getplacementno.location#, #getassignmentslip.awee12#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_debit#, #getassignmentslip.awee12#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                            <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_credit#-#getplacementno.location#, -#getassignmentslip.awee12#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_credit#, -#getassignmentslip.awee12#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                        </cfif>
                        <!---allowance desp 12---> 
                        
                        <!---Allowance desp 13--->
                        <cfif "#getassignmentslip.awee13#" gt 0>
                            <cfset type2 = "#getassignmentslip.allowancedesp13#">    
                            <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_debit#-#getplacementno.location#, #getassignmentslip.awee13#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_debit#, #getassignmentslip.awee13#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                            <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_credit#-#getplacementno.location#, -#getassignmentslip.awee13#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_credit#, -#getassignmentslip.awee13#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                        </cfif>
                        <!---allowance desp 13--->
                        
                        <!---Allowance desp 14--->
                        <cfif "#getassignmentslip.awee14#" gt 0>
                            <cfset type2 = "#getassignmentslip.allowancedesp14#">    
                            <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_debit#-#getplacementno.location#, #getassignmentslip.awee14#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_debit#, #getassignmentslip.awee14#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                            <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_credit#-#getplacementno.location#, -#getassignmentslip.awee14#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_credit#, -#getassignmentslip.awee14#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                        </cfif>
                        <!---allowance desp 14---> 
                        
                        <!---Allowance desp 15--->
                        <cfif "#getassignmentslip.awee15#" gt 0>
                            <cfset type2 = "#getassignmentslip.allowancedesp15#">    
                            <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_debit#-#getplacementno.location#, #getassignmentslip.awee15#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_debit#, #getassignmentslip.awee15#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                            <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_credit#-#getplacementno.location#, -#getassignmentslip.awee15#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_credit#, -#getassignmentslip.awee15#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                        </cfif>
                        <!---allowance desp 15---> 
                        
                        <!---Allowance desp 16--->
                        <cfif "#getassignmentslip.awee16#" gt 0>
                            <cfset type2 = "#getassignmentslip.allowancedesp16#">    
                            <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_debit#-#getplacementno.location#, #getassignmentslip.awee16#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_debit#, #getassignmentslip.awee16#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                            <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_credit#-#getplacementno.location#, -#getassignmentslip.awee16#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_credit#, -#getassignmentslip.awee16#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                        </cfif>
                        <!---allowance desp 16--->
                        
                        <!---Allowance desp 17--->
                        <cfif "#getassignmentslip.awee17#" gt 0>
                            <cfset type2 = "#getassignmentslip.allowancedesp17#">    
                            <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_debit#-#getplacementno.location#, #getassignmentslip.awee17#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_debit#, #getassignmentslip.awee17#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                            <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_credit#-#getplacementno.location#, -#getassignmentslip.awee17#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_credit#, -#getassignmentslip.awee17#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                        </cfif>
                        <!---allowance desp 17--->
                        
                        <!---Allowance desp 18--->
                        <cfif "#getassignmentslip.awee18#" gt 0>
                            <cfset type2 = "#getassignmentslip.allowancedesp18#">    
                            <cfif #chartofaccount.c_debitbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_debit#-#getplacementno.location#, #getassignmentslip.awee18#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_debit#, #getassignmentslip.awee18#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                            <cfif #chartofaccount.c_creditbranch# eq 'Y'>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_credit#-#getplacementno.location#, -#getassignmentslip.awee18#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                    addnewline="yes">
                                <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingPS#dateformat(now(),'ddmmyyyy')#.csv" 
                                    output="2, #getbatches.batches#, #counter#, #itemcounter#, #chartofaccount.c_credit#, -#getassignmentslip.awee18#, /TS## /Job###getassignmentslip.placementno#, #dateformat(getartran.wos_date,'yyyymmdd')#, GL, JE, /Batch ###getbatches.batches# /TSheet ## /PaySlip ## /Item: #type2#, #type2#"
                                    addnewline="yes">
                            </cfif>
                            <cfset itemcounter += 1>
                        </cfif>--->
                        <!---allowance desp 18--->  
                        
                        
        
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