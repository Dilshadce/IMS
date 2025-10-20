<cfoutput>
<cfset uuid = createuuid()>
<cfset timenow = dateformat(now(), 'yyyymmdd_hhmmss')>

<cfsetting showdebugoutput="yes">
<cfinclude template="/object/dateobject.cfm">
<cfinclude template="/object/stringobject.cfm">

<cfquery name="getpayroll" datasource="#dts#">
SELECT mmonth,myear FROM payroll_main.gsetup WHERE comp_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#replace(dts,'_i','')#">
</cfquery>
<cfset payrollmonth = getpayroll.mmonth>
<cfset payrollyear = getpayroll.myear>


		<cfquery name="getartran" datasource="#dts#">
            SELECT grand_bil, tax_bil, fperiod, custno, refno, wos_date
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

        <!--- moved down, [20180406, Nieo] --->
		<!--- To lock artran from editing, [20170417, Alvin] --->
		<!---<cfquery name="lockartran" datasource="#dts#">
			UPDATE artran SET posted = 'P'
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
		</cfquery>--->
		<!--- To lock artran --->

        <cfquery name="getbatches" datasource="#dts#">
            SELECT batches, custtotalgross, invoiceno, placementno
            FROM assignmentslip
            WHERE invoiceno = "#getartran.refno#"
            OR refno = "#getartran.refno#"
        </cfquery>

        <cfquery name="getbatchestotal" datasource="#dts#">
            SELECT sum(custtotalgross) as custtotalgross
            FROM assignmentslip
            WHERE invoiceno = "#getartran.refno#"
            OR refno = "#getartran.refno#"
        </cfquery>

	<cfif #getbatchestotal.custtotalgross# eq 0>
        <h1> Invoice is Empty! </h1>
    <cfelse>
		<!---BEGIN WRITING CSV--->

		<cffile action="WRITE" file="#HRootPath#\Excel_Report\MPpostingInv#timenow#.csv"
    	output="RECTYPE,CNTBTCH,CNTITEM,IDCUST,IDINVC,TEXTTRX,INVCDESC,DATEINVC,SWMANRTE,DATEDUE,SWTAXBL,SWMANTX,CODETAXGRP,TAXSTTS1,AMTTAX1,FISCYR,FISCPER,"
        addnewline="yes">

        <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingInv#timenow#.csv"
   		output="RECTYPE,CNTBTCH,CNTITEM,CNTLINE,TEXTDESC,AMTEXTN,SWMANLTX,TAXSTTS1,IDACCTREV,COMMENT,ITEMTAX,,,,,,,"
  		addnewline="Yes">

        <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingInv#timenow#.csv"
   		output="RECTYPE,CNTBTCH,CNTITEM,CNTPAYM,DATEDUE,AMTDUE,,,,,,,,,,,,"
  		addnewline="Yes">

		<cfset counter = 1>

    	<cfloop query="getartran">

 			<cfset itemcounter = 1>
                    
            <!--- lock assignmentslip from editing, [20170417, Alvin] 
            <cfquery name="checkassignmentslipdata" datasource="#dts#">
                SELECT refno,sum(custtotalgross) tcusttotalgross,count(refno) tcount
                FROM assignmentslip 
                WHERE invoiceno="#getartran.refno#" 
            </cfquery>

            <cfquery name="checkartrandata" datasource="#dts#">
                SELECT gross_bil 
                FROM artran 
                WHERE refno="#getartran.refno#" 
            </cfquery>

            <cfif checkassignmentslipdata.recordcount neq 0>
                <cfif checkassignmentslipdata.tcusttotalgross eq checkartrandata.gross_bil>
                    <cfquery name="lockartran" datasource="#dts#">
                        UPDATE artran SET posted = 'P'
                        WHERE refno = "#getartran.refno#"
                        AND (void='' or void is null)
                    </cfquery>
                <cfelse>
                    <cfquery name="lockartran" datasource="#dts#">
                        UPDATE artran SET posted = ''
                        WHERE refno = "#getartran.refno#"
                        AND (void='' or void is null)
                    </cfquery>
                </cfif>
            <cfelse>
                <cfquery name="lockartran" datasource="#dts#">
                    UPDATE artran SET posted = 'P'
                    WHERE refno = "#getartran.refno#"
                    AND (void='' or void is null)
                </cfquery>
            </cfif>
            lock assignmentslip --->
                    
            <!--- lock assignmentslip from editing version 2.0 (lock for perm or CN DN only), [20180806, Nieo] --->
            <cfquery name="checkassignmentslip" datasource="#dts#">
                SELECT *
                FROM assignmentslip 
                WHERE invoiceno="#getartran.refno#" 
            </cfquery>

            <cfif checkassignmentslip.recordcount eq 0>
                <cfquery name="lockartran" datasource="#dts#">
                    UPDATE artran SET posted = 'P'
                    WHERE refno = "#getartran.refno#"
                    AND (void='' or void is null)
                </cfquery>
            </cfif>
            <!--- lock assignmentslip --->

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

			<!--- Insert into postlog, [20170418, Alvin] --->
			<cfquery name="InsertPostLog" datasource="#dts#">
				INSERT INTO postlog (Action, billtype, actiondata, user, timeaccess)
				VALUES (
				"PostToAccPacc",
				"INV",
				"#getartran.refno#",
				"#HuserID#",
				"#DateFormat(now(), 'yyyy-mm-dd hh:mm:ss')#"
				)
			</cfquery>
			<!--- Insert into postlog --->

            <cfquery name="getbatches2" datasource="#dts#">
                SELECT batches
                FROM assignmentslip
                WHERE invoiceno = "#getartran.refno#"
                OR refno = "#getartran.refno#"
            </cfquery>

            <!---modified query with inner join and left join, [20170208, Alvin]--->
            <cfquery name="getictran" datasource="#dts#">
                SELECT ic.itemno, ic.trancode, ics.desp as icsdesp, ic.desp, ic.amt_bil, ic.taxamt_bil, ic.brem5, ic.brem6,
                ic.brem3,ic.note_a,aslip.placementno,ic.type,ic.refno,aslip.completedate,
				CASE WHEN pmt.location IS NULL THEN cust.arrem1 ELSE pmt.location END as location, pmt.jobpostype
                FROM ictran as ic
                LEFT JOIN assignmentslip as aslip
                ON ic.brem6 = aslip.refno
                LEFT JOIN placement as pmt
				ON aslip.placementno = pmt.placementno
                LEFT JOIN
				(
					select * from (SELECT itemno,case when MITEMNO != "" THEN MITEMNO ELSE Desp end as desp FROM icitem ORDER by itemno) as a
                    union all
                    SELECT *  FROM (
                    SELECT cate as itemno, desp FROM iccate
                    order by cate
                    ) as b
                    union all
                    SELECT *  FROM (
                    SELECT
                    shelf as itemno, desp from icshelf
            		order by length(shelf),shelf
                    ) as c
                    union all
                    SELECT * FROM (
                    SELECT servi as itemno, case when despa != "" THEN despa else desp end as desp
                    FROM icservi
                    order by servi
                    ) as d
				) AS ics
                ON ic.itemno = ics.itemno
				LEFT JOIN arcust as cust
				ON ic.custno = cust.custno
                WHERE ic.refno = "#getartran.refno#"
                AND
                ic.itemno <> "Name"
				AND (ic.void='' or ic.void is null)
                GROUP BY ic.trancode
                ORDER by ic.desp
        	</cfquery>
            <!---modified query--->

			<!---Added by Nieo 20180925, for SST new layout--->
            <cfset sstformat = "">

            <cfif ((len(getartran.refno) eq 5 or left(getartran.refno,1) eq 7) and datediff('d',lsdateformat("07/09/2018",'YYYY-MM-DD', 'en_AU'),lsdateformat((getartran.wos_date),'YYYY-MM-DD', 'en_AU')) gt 0) or datediff('d',lsdateformat("07/09/2018",'YYYY-MM-DD', 'en_AU'),lsdateformat((getartran.wos_date),'YYYY-MM-DD', 'en_AU')) gt 0>
                <cfif isdefined('getassignment.completedate')>
                    <cfif getassignment.completedate neq "">
                        <cfif datediff('d',lsdateformat("31/08/2018",'YYYY-MM-DD', 'en_AU'),lsdateformat((getassignment.completedate),'YYYY-MM-DD', 'en_AU')) gt 0>

                            <cfset sstformat = "sst">

                        </cfif>
                    <cfelseif len(getartran.refno) eq 5 or left(getartran.refno,1) eq 7 or getartran.type eq 'cn' or getartran.type eq 'dn'>
                        <cfquery name="getbrem3" datasource="#dts#">
                        SELECT brem3 FROM ictran 
                        WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.refno#">
                        AND type="#getartran.type#"
                        AND (void ="" or void is null)
                        LIMIT 1
                        </cfquery>

                        <cfset monthsample1 = ["January",
                        "February",
                        "March",
                        "April",
                        "May",
                        "June",
                        "July",
                        "August",
                        "September",
                        "October",
                        "November",
                        "December"]>

                        <cfset monthsample2 = ["Jan",
                        "Feb",
                        "Mar",
                        "Apr",
                        "May",
                        "Jun",
                        "Jul",
                        "Aug",
                        "Sep",
                        "Oct",
                        "Nov",
                        "Dec"]>

                        <cfif trim(getbrem3.brem3) neq ''>

                            <cfset servperiod = right(getbrem3.brem3,4)>

                            <cfif servperiod gte 2018>

                                <cfset tempdate = ReReplaceNoCase(trim(listlast(getbrem3.brem3,'-')),'[^a-zA-Z]','','ALL')>

                                <cfset servmonth = arrayFindNoCase(monthsample1,tempdate)>

                                <cfif servmonth eq 0>
                                    <cfset servmonth = arrayFindNoCase(monthsample2,tempdate)>
                                </cfif>

                                <cfif servmonth gte 9>
                                    <cfset sstformat = "sst">
                                </cfif>

                            </cfif>

                        <cfelse>
                            <cfif getartran.type eq 'cn' or getartran.type eq 'dn'>
                                <cfquery name="getrefno2period" datasource="#dts#">
                                SELECT wos_date FROM artran 
                                WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getheaderinfo.refno2#">
                                </cfquery>

                                <cfif getrefno2period.recordcount neq 0>
                                    <cfif year(getrefno2period.wos_date) gte 2018>
                                        <cfif month(getrefno2period.wos_date) gte 9>
                                            <cfset sstformat = "sst">
                                        </cfif>
                                    </cfif>
                                </cfif>
                            <cfelse>
                                <cfset sstformat = "sst">
                            </cfif>
                        </cfif>
                    </cfif>
                <cfelse>
                    <cfset sstformat = "sst">
                </cfif>
            </cfif>
                
            <cfset CODETAXGRP = 'GST'>
                
            <cfset TAXSTTS1 = '3'>
                
            <cfif sstformat neq ''>
                <cfset CODETAXGRP = 'SST'>
                
                <cfset TAXSTTS1 = '1'>
            </cfif>
                                    
            <!---Added by Nieo 20180925, for SST new layout--->

			<cfif #getartran.fperiod# GT 12>
            	<cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingInv#timenow#.csv"
   				output="1,#getbatches2.batches#,#counter#,#getartran.custno#,#getartran.refno#,1,AP-MONTH=#evaluate('getartran.fperiod MOD 12')#,#dateformat(getdate.wos_date,'yyyymmdd')#,0,#dateformat(getdate.duedate,'yyyymmdd')#,1,0,#CODETAXGRP#,#TAXSTTS1#,#NumberFormat(getartran.tax_bil, '.__')#,#dateformat(getdate.wos_date,'yyyy')#,#evaluate('getartran.fperiod MOD 12')#,"
  				addnewline="Yes">
            <cfelse>
            	<cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingInv#timenow#.csv"
   				output="1,#getbatches2.batches#,#counter#,#getartran.custno#,#getartran.refno#,1,AP-MONTH=#getartran.fperiod#,#dateformat(getdate.wos_date,'yyyymmdd')#,0,#dateformat(getdate.duedate,'yyyymmdd')#,1,0,#CODETAXGRP#,#TAXSTTS1#,#NumberFormat(getartran.tax_bil, '.__')#,#dateformat(getdate.wos_date,'yyyy')#,#getartran.fperiod#,"
  				addnewline="Yes">
            </cfif>

                 <!---#getdata.taxpec1# for the gst code--->

                <cfloop query="getictran">

                    
                    <!--- lock assignmentslip from editing, [20170417, Alvin]
                    <cfif checkassignmentslipdata.tcusttotalgross eq checkartrandata.gross_bil>
                        <cfquery name="lockassign" datasource="#dts#">
                            UPDATE assignmentslip SET posted = 'P'
                            WHERE refno = "#getictran.brem6#"
                        </cfquery>
                    <cfelse>
                        <cfquery name="lockassign" datasource="#dts#">
                            UPDATE assignmentslip SET posted = ''
                            WHERE refno = "#getictran.brem6#"
                        </cfquery>
                    </cfif> lock assignmentslip --->
                
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
                        WHERE type1_id = <cfif #IsNull(getictran.jobpostype)# OR #getictran.jobpostype# EQ "">'3'<cfelse>"#getictran.jobpostype#"</cfif>
						and type2 = <cfif (#IsNull(getictran.jobpostype)# OR #getictran.jobpostype# EQ "") AND "#getictran.icsdesp#" EQ "Bonus"> "Bonus Incentive"
                       <cfelse> <cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.icsdesp#"> </cfif> 
                        <!--- <cfif #IsNumeric(getictran.itemno)#>
                        	AND
							type2 = "#getictran.icsdesp#"
                        <cfelseif #getictran.itemno# EQ "OT15">
							AND
                       		type2 = "OT 1.5"
                       	<cfelseif #getictran.itemno# EQ "OT2">
							AND
                       		type2 = "OT 2.0"
                       	<cfelseif #getictran.itemno# EQ "OT3">
							AND
                       		type2 = "OT 3.0"
                       	<cfelseif #getictran.itemno# EQ "OT5">
							AND
                       		type2 = "RD 1.0"
                       	<cfelseif #getictran.itemno# EQ "OT6">
							AND
                       		type2 = "RD 2.0"
                       	<cfelseif #getictran.itemno# EQ "OT8">
							AND
                       		type2 = "PH 2.0"
                        </cfif> --->
                        <!---<cfif #getictran.desp# contains "SOCSO YER">
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
                        <cfelseif #getictran.desp# contains "Rest Day 1.0">
                        	type2 = "Rest 1.0"
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
                        </cfif>--->
                    </cfquery>


                    <!---To handle if else because if else cannot be put inside cfoutput * this is body--->

                    <cfif #getictran.taxamt_bil# neq 0>
                    	<cfset taxatts1 = 1>
                    <cfelseif #getictran.taxamt_bil# eq 0>
                    	<cfset taxatts1 = 2>
                    </cfif>

                    <cfif #chartofaccount.s_creditbranch# eq 'Y'>
                    	<cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingInv#timenow#.csv"
   							output="2,#getbatches2.batches#,#counter#,#itemcounter#,""#getictran.desp# /TS## /Job###getictran.placementno#"",#NumberFormat(getictran.amt_bil, '.__')#,0,#taxatts1#,#chartofaccount.s_credit#-#getictran.location#, /Batch ###getbatches2.batches# /Timesheet ##,#NumberFormat(getictran.taxamt_bil, '.__')#,,,,,,,"
                        	addnewline="yes">
                        <cfelse>
                        <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingInv#timenow#.csv"
   							output="2,#getbatches2.batches#,#counter#,#itemcounter#,""#getictran.desp# /TS## /Job###getictran.placementno#"",#NumberFormat(getictran.amt_bil, '.__')#,0,#taxatts1#,#chartofaccount.s_credit#, /Batch ###getbatches2.batches# /Timesheet ##,#NumberFormat(getictran.taxamt_bil, '.__')#,,,,,,,"
                        	addnewline="yes">
                    </cfif>

                    <!---end of if else handling--->

                    <cfset itemcounter += 1>

                </cfloop>

                	<cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingInv#timenow#.csv"
   						output="3,#getbatches2.batches#,#counter#,1,#dateformat(getdate.duedate,'yyyymmdd')#,#numberformat(getartran.grand_bil, '.__')#,,,,,,,,,,,,"
  						addnewline="Yes">
		<cfset counter += 1>
        </cfloop>

		<!---FINISHED WRITING CSV--->
                        
        <cfheader name="Content-Type" value="csv">
		<cfset filename = "MPpostingInv#timenow#.csv">

		<cfheader name="Content-Disposition" value="inline; filename=#filename#">
		<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\MPpostingInv#timenow#.csv">
	</cfif>
</cfoutput>