<!--- below format are for e-invoice format and P+SL: Perm Module + Standard Format or Lumpsum Format (others than previous format) --->
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

<cfset header_line_1 = [
"RECTYPE",
"CNTBTCH",
"CNTITEM",
"IDCUST",
"IDINVC",
"IDSHPT",
"SPECINST",
"TEXTTRX",
"ORDRNBR",
"CUSTPO",
"INVCDESC",
"DATEINVC",
"FISCYR",
"FISCPER",
"SWMANRTE",
"DATEDUE",
"SWTAXBL",
"SWMANTX",
"CODETAXGRP",
"TAXSTTS1",
"AMTTAX1",
"AMTDUE",
"IDSHIPNBR"
]>
<cfset header_line_2 = [
"RECTYPE",
"CNTBTCH",
"CNTITEM",
"CNTLINE",
"IDDIST",
"TEXTDESC",
"AMTEXTN",
"TAXSTTS1",
"AMTTAX1",
"IDACCTREV"
]>
<cfset header_line_3 = [
"RECTYPE",
"CNTBTCH",
"CNTITEM",
"CNTPAYM",
"DATEDUE",
"AMTDUE"
]>

<cfset header_line_4 = [
"RECTYPE",
"CNTBTCH",
"CNTITEM",
"OPTFIELD",
"VALUE"
]>
<cfset header_line_5 = [
"RECTYPE",
"CNTBTCH",
"CNTITEM",
"CNTLINE",
"OPTFIELD",
"VALUE"
]>

<cfset monthsample1 = [
"January",
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

<cfset monthsample2 = [
"Jan",
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

<cfset row_items_list_for_rectype = [
"FV",
"PERIOD",
"QTY",
"RATE",
"UNIT"
]>

<cfset row_items_list_for_rectype_value = [
"numberformat(getictran.foreign_amt, '.__')",
"getictran.assignment_period",
"getictran.qty_bil",
"getictran.price_bil",
"getictran.unit_bil"
]>

<!--- rem5 is PO number, rem7 is Your Order Department in below query, rem3 is currency symbol, currrate for currency rate --->
<!--- invoiceformat filter in below statement are the invoice groupping format --->
		<cfquery name="getartran" datasource="#dts#">
            SELECT gross_bil, grand_bil, tax_bil, currrate, fperiod, artran.custno, refno, refno2, wos_date, artran.type, rem5, rem7, rem3, business
            FROM artran as artran
            LEFT JOIN arcust as arcust
            ON artran.custno = arcust.custno
            WHERE (artran.void='' or artran.void is null)
            <cfif #form.refNoFrom# neq "" AND #form.refNoTo# neq "">
                	AND refno
                    BETWEEN #form.refNoFrom#
                    AND
                    #form.refNoTo#
                 <cfelseif #form.refNoFrom# neq "">
                 	AND refno = #form.refNoFrom#
                 <cfelseif #form.refNoTo# neq "">
                 	AND refno = #form.refNoTo#
            </cfif>
            AND artran.refno NOT IN (
                SELECT DISTINCT invoiceno
                FROM assignmentslip
                WHERE payrollperiod != 99
                OR (
                    payrollperiod = 99
                    AND year(assignmentslipdate) = #payrollyear - 1#
                )
            )
            AND fperiod != 99
            AND artran.type = 'INV'
    	</cfquery>

        <cfset currency_symbol = "MYR">
        <cfif len(getartran.rem3) neq 0>
            <cfset currency_symbol = getartran.rem3>
        </cfif>

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
    	output="#arrayToList(header_line_1)#"
        addnewline="yes">

        <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingInv#timenow#.csv"
   		output="#arrayToList(header_line_2)#"
  		addnewline="Yes">

        <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingInv#timenow#.csv"
   		output="#arrayToList(header_line_3)#"
  		addnewline="Yes">

        <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingInv#timenow#.csv"
        output="#arrayToList(header_line_4)#"
        addnewline="Yes">

        <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingInv#timenow#.csv"
        output="#arrayToList(header_line_5)#"
        addnewline="Yes">

		<cfset counter = 1>

    	<cfloop query="getartran">

 			<cfset itemcounter = 1>
                    
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
                SELECT batches,completedate
                FROM assignmentslip
                WHERE invoiceno = "#getartran.refno#"
                OR refno = "#getartran.refno#"
            </cfquery>

            <!---modified query with inner join and left join, [20170208, Alvin]--->
            <cfquery name="getictran" datasource="#dts#">
                SELECT ic.itemno, ic.trancode, ics.desp as icsdesp, ic.desp, ic.amt_bil, ic.taxamt_bil, ic.brem5, ic.brem6, ic.taxpec1, ic.qty_bil, ic.price_bil, ic.unit_bil, (ic.amt_bil/ic.currrate) as foreign_amt,
                ic.brem3,ic.note_a,aslip.placementno,ic.type,ic.refno,aslip.completedate,
                    concat(date_format(aslip.startdate, '%e %b %Y'),'-',date_format(aslip.completedate, '%e %b %Y')) as assignment_period,
				CASE WHEN pmt.location IS NULL THEN cust.arrem1 ELSE pmt.location END as location, pmt.jobpostype,
                pmt.supervisor
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
                AND ic.type='inv'
				AND (ic.void='' or ic.void is null)
                GROUP BY ic.itemno,ic.trancode
                ORDER by ic.refno, ic.itemcount
        	</cfquery>
            <!---modified query--->

			<!---Added by Nieo 20180925, for SST new layout--->
            <cfset sstformat = "">

            <cfif ((len(getartran.refno) eq 5 or left(getartran.refno,1) eq 7) and datediff('d',lsdateformat("07/09/2018",'YYYY-MM-DD', 'en_AU'),lsdateformat((getartran.wos_date),'YYYY-MM-DD', 'en_AU')) gt 0) or datediff('d',lsdateformat("07/09/2018",'YYYY-MM-DD', 'en_AU'),lsdateformat((getartran.wos_date),'YYYY-MM-DD', 'en_AU')) gt 0>
                <cfif isdefined('getbatches2.completedate')>
                    <cfif getbatches2.completedate neq "">
                        <cfif datediff('d',lsdateformat("31/08/2018",'YYYY-MM-DD', 'en_AU'),lsdateformat((getbatches2.completedate),'YYYY-MM-DD', 'en_AU')) gt 0>

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

                        <cfif trim(getbrem3.brem3) neq ''>

                            <cfset servperiod = right(getbrem3.brem3,4)>

                            <cfif servperiod gte 2018>

                                <cfset tempdate = ReReplaceNoCase(trim(listlast(getbrem3.brem3,'-')),'[^a-zA-Z]','','ALL')>

                                <cfset servmonth = arrayFindNoCase(monthsample1,tempdate)>

                                <cfif servmonth eq 0>
                                    <cfset servmonth = arrayFindNoCase(monthsample2,tempdate)>
                                </cfif>
                                    
                                <cfif servmonth eq 0>
                                    <cfset servmonth = arrayFindNoCase(monthsample2,right(tempdate,3))>
                                </cfif>
                                    
                                <cfif servmonth eq 0>
                                    <cfset servmonth = arrayFindNoCase(monthsample2,right(tempdate,3))>
                                </cfif>

                                <cfif servmonth gte 9>
                                    <cfset sstformat = "sst">
                                </cfif>

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

            <!--- set ap month --->
            <cfset ap_month = getartran.fperiod>

            <!--- handle fperiod more than 12 --->
			<cfif #getartran.fperiod# GT 12>
            	<cfset ap_month = evaluate('getartran.fperiod MOD 12')>
            </cfif>

            <!--- set frequently used values --->
            <cfset gross_bil_amt = "#numberformat(getartran.gross_bil, '.__')#">
            <cfset tax_bil_amt = "#numberformat(getartran.tax_bil, '.__')#">
            <cfset grand_bil_amt = "#numberformat(getartran.grand_bil, '.__')#">
            <cfset current_date = "#dateformat(getdate.wos_date,'yyyymmdd')#">

            <cfset your_order_dept = getartran.rem7>
            <cfif getartran.rem7 eq ''>
                <cfset your_order_dept = getartran.business>
            </cfif>

            <!--- set rectype 1 line --->
            <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingInv#timenow#.csv"
                output="1,#getbatches2.batches#,#counter#,#getartran.custno#,#getartran.refno#,,#getartran.refno2#,1,,#getartran.rem5#,AP-MONTH=#ap_month#,#current_date#,#dateformat(getdate.wos_date,'yyyy')#,#ap_month#,0,#dateformat(getdate.duedate,'yyyymmdd')#,1,0,#CODETAXGRP#,#TAXSTTS1#,#tax_bil_amt#,#grand_bil_amt#,#your_order_dept#"
                addnewline="Yes">

                 <!---#getdata.taxpec1# for the gst code--->

                <cfloop query="getictran">

             		<cfquery name="chartofaccount" datasource="#dts#">
                        SELECT s_credit, s_creditbranch
                        FROM chartofaccount
                        WHERE type1_id = <cfif #IsNull(getictran.jobpostype)# OR #getictran.jobpostype# EQ "">'3'<cfelse>"#getictran.jobpostype#"</cfif>
						and type2 = <cfif (#IsNull(getictran.jobpostype)# OR #getictran.jobpostype# EQ "") AND "#getictran.icsdesp#" EQ "Bonus"> "Bonus Incentive"
                       <cfelse> <cfqueryparam cfsqltype="cf_sql_varchar" value="#getictran.icsdesp#"> </cfif> 
                    </cfquery>


                    <!---To handle if else because if else cannot be put inside cfoutput * this is body--->

                    <cfif #getictran.taxamt_bil# neq 0>
                    	<cfset taxatts1 = 1>
                    <cfelseif #getictran.taxamt_bil# eq 0>
                    	<cfset taxatts1 = 2>
                    </cfif>

                    <!--- handle chart of account value --->
                    <cfset chartofaccount_value = chartofaccount.s_credit>

                    <cfif #chartofaccount.s_creditbranch# eq 'Y'>
                        <cfset chartofaccount_value = "#chartofaccount.s_credit#-#getictran.location#">
                    </cfif>

                    <!--- handle distribution code column for ACCPAC --->
                    <cfset distribution_code = "">
                    <cfif getictran.itemno eq "Name">
                        <cfset distribution_code = "S">
                        <cfset chartofaccount_value = 9999>
                    </cfif>
                    <cfset taxamt_bil_value = "#numberformat(getictran.taxamt_bil, '.__')#">
                    <cfset amt_bil_value = "#numberformat(getictran.amt_bil, '.__')#">

                    <!--- set rectype 2 line --->
                    <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingInv#timenow#.csv"
                        output="2,#getbatches2.batches#,#counter#,#itemcounter#,#distribution_code#,#replaceNoCase(getictran.desp, '+', '')#,#amt_bil_value#,#taxatts1#,#taxamt_bil_value#,#chartofaccount_value#"
                        addnewline="yes">

                    <cfloop index="i" from="1" to="#arrayLen(row_items_list_for_rectype)#">
                        <cfset field_value = '#evaluate('#row_items_list_for_rectype_value[i]#')#'>
                        <cfif row_items_list_for_rectype[i] eq 'PERIOD' and field_value eq ''>
                            <cfset field_value = getictran.brem3>
                        </cfif>
                        <cfif row_items_list_for_rectype[i] eq 'UNIT' and field_value eq ''>
                            <cfset field_value = 'Unit'>
                        </cfif>
                        <!--- set rectype 5 line --->
                        <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingInv#timenow#.csv"
                            output="5,#getbatches2.batches#,#counter#,#itemcounter#,#row_items_list_for_rectype[i]#,#field_value#"
                            addnewline="yes">
                    </cfloop> 

                    <!---end of if else handling--->

                    <cfset itemcounter += 1>

                </cfloop>

                <cfset currency_rate = 1>
                <cfif getartran.currrate neq ''>
                    <cfset currency_rate = getartran.currrate>
                </cfif>

                	<cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingInv#timenow#.csv"
                        output="3,#getbatches2.batches#,#counter#,1,#dateformat(getdate.duedate,'yyyymmdd')#,#numberformat(getartran.grand_bil, '.__')#"
                        addnewline="Yes">

                    <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingInv#timenow#.csv"
                        output="4,#getbatches2.batches#,#counter#,BRANCH,"
                        addnewline="Yes">

                    <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingInv#timenow#.csv"
                        output="4,#getbatches2.batches#,#counter#,CONV,#currency_rate#"
                        addnewline="Yes">

                    <cffile action="APPEND" file="#HRootPath#\Excel_Report\MPpostingInv#timenow#.csv"
                        output="4,#getbatches2.batches#,#counter#,FC,#currency_symbol#"
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