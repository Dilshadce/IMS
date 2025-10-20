<cfoutput>
<cfset uuid = createuuid()>

<cfsetting showdebugoutput="yes">
<cfinclude template="/object/dateobject.cfm">
<cfinclude template="/object/stringobject.cfm">

<cfquery name="getpayroll" datasource="#dts#">
SELECT mmonth,myear FROM payroll_main.gsetup WHERE comp_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#replace(dts,'_i','')#">
</cfquery>
<cfset payrollmonth = getpayroll.mmonth>
<cfset payrollyear = getpayroll.myear>


		<cfquery name="getartran" datasource="#dts#">
            SELECT grand_bil, tax_bil, fperiod, custno, refno
            FROM artran
            WHERE 1=1
            <cfif #form.refNoFrom# neq "" AND #form.refNoTo# neq "">
                	AND refno
                    BETWEEN "#form.refNoFrom#"
                    AND
                    "#form.refNoTo#"
                 <cfelseif #form.refNoFrom# neq "">
                 	AND refno = "#form.refNoFrom#"
                 <cfelseif #form.refNoTo# neq "">
                 	AND refno = "#form.refNoTo#"
            </cfif>
			AND (void='' or void is null)
    	</cfquery>

        <cfquery name="getbatches" datasource="#dts#">
            SELECT batches, custtotalgross, invoiceno, placementno
            FROM assignmentslip
            WHERE invoiceno = "#getartran.refno#"
            OR refno = "#getartran.refno#"
        </cfquery>
        
	<cfif #getbatches.custtotalgross# eq 0>
        <h1> Invoice is Empty! </h1>
    <cfelse>
		<!---BEGIN WRITING CSV--->
        
		<cffile action="WRITE" file="#HRootPath#\Excel_Report\MPpostingInv#dateformat(now(),'ddmmyyyy')#.csv"
    	output="RECTYPE,CNTBTCH,CNTITEM,IDCUST,IDINVC,TEXTTRX,INVCDESC,DATEINVC,SWMANRTE,DATEDUE,SWTAXBL,SWMANTX,CODETAXGRP,TAXSTTS1,AMTTAX1,FISCYR,FISCPER," 
        addnewline="yes">
        
        <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingInv#dateformat(now(),'ddmmyyyy')#.csv" 
   		output="RECTYPE,CNTBTCH,CNTITEM,CNTLINE,TEXTDESC,AMTEXTN,SWMANLTX,TAXSTTS1,IDACCTREV,COMMENT,ITEMTAX,,,,,,,"
  		addnewline="Yes"> 
        
        <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingInv#dateformat(now(),'ddmmyyyy')#.csv" 
   		output="RECTYPE,CNTBTCH,CNTITEM,CNTPAYM,DATEDUE,AMTDUE,,,,,,,,,,,,"
  		addnewline="Yes">

		<cfset counter = 1>
    
    	<cfloop query="getartran">
        
 			<cfset itemcounter = 1>  
            
            <!---modified query with left join, [20170205, Alvin]--->
            <cfquery name="getdate" datasource="#dts#">
                SELECT date_add(atran.wos_date,INTERVAL acust.arrem6 DAY) as duedate, atran.wos_date
                FROM artran as atran
                LEFT JOIN arcust as acust
                ON atran.custno = acust.custno
                WHERE refno = "#getartran.refno#"
				AND (atran.void='' or atran.void is null)
        	</cfquery>
            <!---modified query--->
            
            <cfquery name="getbatches2" datasource="#dts#">
                SELECT batches
                FROM assignmentslip
                WHERE invoiceno = "#getartran.refno#"
                OR refno = "#getartran.refno#"
            </cfquery> 
            
            <!---modified query with inner join and left join, [20170208, Alvin]--->
            <cfquery name="getictran" datasource="#dts#">
                SELECT ic.desp, ic.amt_bil, ic.taxamt_bil, ic.brem5, ic.brem6, aslip.placementno, pmt.location, pmt.jobpostype
                FROM ictran as ic
                LEFT JOIN assignmentslip as aslip
                ON ic.brem6 = aslip.refno
                LEFT JOIN manpower_i.placement as pmt
				ON aslip.placementno = pmt.placementno
                WHERE ic.refno = "#getartran.refno#"
                AND
                ic.itemno <> "Name"
				AND (ic.void='' or ic.void is null)
                ORDER by ic.desp
        	</cfquery> 
            <!---modified query--->

			<cfif #getartran.fperiod# GT 12>
            	<cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingInv#dateformat(now(),'ddmmyyyy')#.csv" 
   				output="1,#getbatches2.batches#,#counter#,#getartran.custno#,#getartran.refno#,1,AP-MONTH=#evaluate('getartran.fperiod MOD 12')#,#dateformat(getdate.wos_date,'yyyymmdd')#,0,#dateformat(getdate.duedate,'yyyymmdd')#,1,1,GST,3,#NumberFormat(getartran.tax_bil, '.__')#,#dateformat(getdate.wos_date,'yyyy')#,#evaluate('getartran.fperiod MOD 12')#,"
  				addnewline="Yes">
            <cfelse>
            	<cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingInv#dateformat(now(),'ddmmyyyy')#.csv" 
   				output="1,#getbatches2.batches#,#counter#,#getartran.custno#,#getartran.refno#,1,AP-MONTH=#getartran.fperiod#,#dateformat(getdate.wos_date,'yyyymmdd')#,0,#dateformat(getdate.duedate,'yyyymmdd')#,1,1,GST,3,#NumberFormat(getartran.tax_bil, '.__')#,#dateformat(getdate.wos_date,'yyyy')#,#getartran.fperiod#,"
  				addnewline="Yes">
            </cfif>
			                 
                 <!---#getdata.taxpec1# for the gst code--->
				
                <cfloop query="getictran">
        
                    <!---<cfquery name="getplacementno" datasource="#dts#">
                        SELECT placementno
                        FROM placement
                        WHERE empno = "#getictran.brem5#"
                        AND
                        custno = "#getartran.custno#"
                	</cfquery>
					getplacementno.placementno change to getbatches.placementno, [20170106, Alvin]--->
                 
        	
            		<!---<cfquery name="getjobno" datasource="#dts#">
                        select location, jobpostype
                        from placement 
                        where placementno = "#getbatches.placementno#"
                    </cfquery>--->
            
             		<cfquery name="chartofaccount" datasource="#dts#">
                        SELECT s_credit, s_creditbranch
                        FROM chartofaccount
                        WHERE type1_id = "#getictran.jobpostype#"
                        AND
                        <cfif #getictran.desp# contains "SOCSO YER">
                        	type2 = "+SOCSO"
                            AND
                            s_credit != ""
                        <cfelseif #getictran.desp# contains "No Pay Leave">
                        	type2 = "Unpaid Leave"
                            AND
                            s_credit != ""
                        <cfelseif #getictran.desp# contains "Over Time 1.5">
                        	type2 =  "OT 1.5"
                            AND
                            s_credit != ""
                        <cfelseif #getictran.desp# contains "Over Time 2.0">
                        	type2 = "OT 2.0"
                            AND
                            s_credit != ""
                        <cfelseif #getictran.desp# contains "Over Time 3.0">
                        	type2 = "OT 3.0"
                            AND
                            s_credit != "" 
                        <cfelseif #getictran.desp# contains "Public Holiday 2.0">
                        	type2 = "Public Holiday"
                            AND
                            s_credit != ""      
                        <cfelseif #getictran.desp# contains "Rest Day 2.0">
                        	type2 = "Rest 2.0"
                            AND
                            s_credit != ""
                        <cfelseif #getictran.desp# contains "OT2.0">
                        	type2 = "OT 2.0"
                            AND
                            s_credit != "" 
                        <cfelseif #getictran.desp# contains "PH2.0">
                        	type2 = "PH 2.0"
                            AND
                            s_credit != "" 
                        <cfelseif #getictran.desp# contains "OT2.0">
                        	type2 = "OT 2.0"
                            AND
                            s_credit != ""
                        <cfelseif #getictran.desp# contains "OT1.5">
                        	type2 = "OT 1.5"
                            AND
                            s_credit != ""                    
                        <cfelse>
                        	type2 = "#getictran.desp#"
                        </cfif>        
                    </cfquery>
                    
                    
     
                    <!---To handle if else because if else cannot be put inside cfoutput * this is body---> 
                    
                    <cfif #getictran.taxamt_bil# neq 0>
                    	<cfset taxatts1 = 1>
                    <cfelseif #getictran.taxamt_bil# eq 0>
                    	<cfset taxatts1 = 2>
                    </cfif>
                    
                    <cfif #chartofaccount.s_creditbranch# eq 'Y'>
                    	<cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingInv#dateformat(now(),'ddmmyyyy')#.csv" 
   							output="2,#getbatches2.batches#,#counter#,#itemcounter#,#getictran.desp# /TS## /Job###getictran.placementno#,#getictran.amt_bil#,0,#taxatts1#,#chartofaccount.s_credit#-#getictran.location#, /Batch ###getbatches2.batches# /Timesheet ##,#getictran.taxamt_bil#,,,,,,,"
                        	addnewline="yes">
                        <cfelse>
                        <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingInv#dateformat(now(),'ddmmyyyy')#.csv" 
   							output="2,#getbatches2.batches#,#counter#,#itemcounter#,#getictran.desp# /TS## /Job###getictran.placementno#,#getictran.amt_bil#,0,#taxatts1#,#chartofaccount.s_credit#, /Batch ###getbatches2.batches# /Timesheet ##,#getictran.taxamt_bil#,,,,,,,"
                        	addnewline="yes">
                    </cfif>  
                    
                    <!---end of if else handling--->
                
                    <cfset itemcounter += 1>
      
                </cfloop>
                
                	<cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingInv#dateformat(now(),'ddmmyyyy')#.csv" 
   						output="3,#getbatches2.batches#,#counter#,1,#dateformat(getdate.duedate,'yyyymmdd')#,#getartran.grand_bil#,,,,,,,,,,,,"
  						addnewline="Yes">            
		</cfloop>
        
		<!---FINISHED WRITING CSV--->
		
        <cfheader name="Content-Type" value="csv">
		<cfset filename = "MPpostingInv#dateformat(now(),'ddmmyyyy')#.csv">

		<cfheader name="Content-Disposition" value="inline; filename=#filename#">		
		<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\MPpostingInv#dateformat(now(),'ddmmyyyy')#.csv">
	</cfif>
</cfoutput>