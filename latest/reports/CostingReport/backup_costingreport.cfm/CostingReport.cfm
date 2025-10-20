<cfsetting requesttimeout="1800" >
    
<cfif isdefined('form.customer') eq false>
    <script>
        alert("Please choose a Client to generate.");
        window.close();
    </script>
    <cfabort>
</cfif>
    
<cfset uuid = createuuid()>    

<cfset timenow = "#DateTimeFormat(now(), 'yyyymmddhhnnss')#">
    
<cfif findnocase("PUIG",form.customer,0)>
    <cfset puig = true>
</cfif>
    
<cfif isNumeric(listfirst(form.customer))>
    <cfquery name="getcustname" datasource="#dts#">
        SELECT name FROM arcust 
        WHERE custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#listfirst(form.customer)#">
    </cfquery>

    <cfif findnocase("PUIG",getcustname.name,0)>
        <cfset puig = true>
    </cfif>     
</cfif>
    
<cfquery name="getComp_qry" datasource="payroll_main">
	SELECT * FROM gsetup WHERE comp_id = "#rereplace(HcomID,'_i','')#"
</cfquery>
    
<cfquery name="getGsetup" datasource='#dts#'>
	SELECT * FROM gsetup 
</cfquery>
    
<cfquery name="getgsetup2" datasource='#dts#'>
	select * from gsetup2
</cfquery>
        
<cfquery name="gettaxitems" datasource='#dts#'>
	select taxitemid from taxmethoditem 
    where taxmethodid=3<!---Itemized Rate--->
</cfquery>
        
<cfquery name="getnontaxitems" datasource='#dts#'>
    select shelf from icshelf
    where shelf not in (select taxitemid from taxmethoditem where taxmethodid=3)
</cfquery>
    
<cfquery name="gettaxitemswithAdminFee" datasource='#dts#'>
	select taxitemid from taxmethoditem 
    where taxmethodid=3
    and id < 53
</cfquery>
    
<cfquery name="getnontaxitemswithAdminFee" datasource='#dts#'>
    select shelf from icshelf
    where shelf not in (select taxitemid from taxmethoditem where taxmethodid=3 and id < 53)
</cfquery>
        
<!-- QUERY FOR placement no--->

<cftry>
    
    <cfquery datasource="#dts#" name="getcolumns"> 
        DESC assignmentslip
    </cfquery>

    <cfquery datasource="#dts#">
        insert into assignmentsliptemp 
        (
            #valuelist(getcolumns.field)#,uuid
        )
        select 
            #valuelist(getcolumns.field)#,"#uuid#" as uuid
        from assignmentslip where 1=1
        <cfif form.periodFrom neq ''>
            AND payrollperiod >= #form.periodFrom#
        </cfif>
        <cfif form.periodTo neq ''>
            AND payrollperiod <= #form.periodTo#
        </cfif>
        AND created_on > #createdate(getComp_qry.myear,1,7)#
    </cfquery>

    <cfcatch type="database">
        
        <cfquery datasource="#dts#">
            DROP TABLE IF EXISTS assignmentsliptemp 
        </cfquery>

        <cfquery datasource="#dts#">
            CREATE TABLE assignmentsliptemp LIKE assignmentslip
        </cfquery>
        
        <cfquery datasource="#dts#">
        alter table assignmentsliptemp
        add column (uuid varchar(45) default '')
        </cfquery>
        
        <cfquery datasource="#dts#">
        ALTER TABLE assignmentsliptemp ENGINE=INNODB
        </cfquery>
        
        <cfquery datasource="#dts#" name="getcolumns"> 
            DESC assignmentslip
        </cfquery>

        <cfquery datasource="#dts#">
            insert into assignmentsliptemp 
            (
                #valuelist(getcolumns.field)#,uuid
            )
            select 
                #valuelist(getcolumns.field)#,"#uuid#" as uuid
            from assignmentslip where 1=1
            <cfif form.periodFrom neq ''>
                AND payrollperiod >= #form.periodFrom#
            </cfif>
            <cfif form.periodTo neq ''>
                AND payrollperiod <= #form.periodTo#
            </cfif>
            AND created_on > #createdate(getComp_qry.myear,1,7)#
        </cfquery>
    
    </cfcatch>
</cftry>
        
<cfquery name="getCostingQuery" datasource="#dts#">
  select a.custno,p.location,a.custtotalgross,a.paymenttype,a.custsalaryhrs,a.custsalaryday, a.workd,custusualpay,a.branch as entity,
    cust.arrem5,
    cust.arrem7,
(SELECT attn from address where custno = p.custno) as request,
p.department as dept,
p.po_no,
a.empname as `staffname`,
a.placementno as JO,
<!---(SELECT MONTH(wos_date) from artran where refno = a.invoiceno limit 1) as --->billingMth, invoiceno,
a.startdate,
<!---Updated by Nieo 20171219 1641--->
p.workorderid,
p.costcenter,
p.cLocation,
p.businessunit,
hm.username as hrmgr,
p.jobid,
p.jobposting,
p.securityID,
p.site,
<cfloop from='1' to='6' index='i'>
a.fixawcode#i#,a.fixawer#i#,
</cfloop>
<!---a.fixawcode1,a.fixawcode2,a.fixawcode3, a.fixawcode4, a.fixawcode5,a.fixawcode6,
a.fixawer1, a.fixawer2,a.fixawer3,a.fixawer4, a.fixawer5,a.fixawer6,--->
<!---Updated by Nieo 20171219 1641--->
a.custsalary,a.custtotal,a.adminfee,a.custcpf,a.custsdf,a.custeis,
CASE WHEN billitem1 = '17' then billitemamt1
when billitem2 = '17' then billitemamt2
when billitem3 = '17' then billitemamt3
when billitem4 = '17' then billitemamt4
when billitem5 = '17' then billitemamt5
when billitem6 = '17' then billitemamt6
else 0 end as medical,
CASE WHEN billitem1 = '136' then billitemamt1
when billitem2 = '136' then billitemamt2
when billitem3 = '136' then billitemamt3
when billitem4 = '136' then billitemamt4
when billitem5 = '136' then billitemamt5
when billitem6 = '136' then billitemamt6
else 0 end as hrdf,
CASE WHEN billitem1 = '102' then billitemamt1
when billitem2 = '102' then billitemamt2
when billitem3 = '102' then billitemamt3
when billitem4 = '102' then billitemamt4
when billitem5 = '102' then billitemamt5
when billitem6 = '102' then billitemamt6
else 0 end as equip,
lvltotaler1,
lvltotaler2,
billitem1,billitemamt1,
billitem2,billitemamt2,
billitem3,billitemamt3,
billitem4,billitemamt4,
billitem5,billitemamt5,
billitem6,billitemamt6,
addchargecode,addchargecust,
addchargecode2,addchargecust2,
addchargecode3,addchargecust3,
<cfloop from='1' to='8' index='i'>
custot#i#, custothour#i#,
</cfloop>
<cfloop from='1' to='4' index='i'>
a.billitem#i#,a.billitemamt#i#,
</cfloop>
<cfloop from='1' to='18' index='i'>
a.allowance#i#,a.awer#i#,a.allowancedesp#i#,
</cfloop>
a.completedate,
a.taxper,
payrollperiod
    
from assignmentsliptemp a 
left join placement p 
on a.placementno = p.placementno
left join arcust cust 
on p.custno = cust.custno
left join address addr
on p.custno=addr.custno
left join (SELECT refno,MONTH(wos_date) billingMth,taxp1 from artran) art
on art.refno=a.invoiceno
LEFT JOIN payroll_main.hmusers hm 
ON hm.entryid=p.hrmgr
    
where a.uuid = "#uuid#"
    
AND a.created_on > #createdate(getComp_qry.myear,1,7)#

<!---<cfif form.customer neq ''>
	AND a.custno >= "#form.customerFrom#"
</cfif>
<cfif form.customerTo neq ''>
	AND a.custno <=  "#form.customerTo#"
</cfif>--->
<!---Added by Nieo 20171020 1143--->
<cfif form.customer neq ''>
    and a.custno IN (
        <cfqueryparam value="#form.customer#" cfsqltype="CF_SQL_VARCHAR" list="yes" />
    )
</cfif>
<!---Added by Nieo 20171020 1143--->
<cfif form.placementNoFrom neq ''>
	AND a.placementno >= "#form.placementNoFrom#"

</cfif>
<cfif form.placementNoTo neq ''>
	AND a.placementno <= "#form.placementNoTo#"
</cfif>
<cfif form.periodFrom neq ''>
	AND a.payrollperiod >= #form.periodFrom#
</cfif>
<cfif form.periodTo neq ''>
	AND a.payrollperiod <= #form.periodTo#
</cfif>

<cfif form.dateFrom neq ''>
	AND a.assignmentslipdate >= "#form.dateFrom#"
</cfif>
<cfif form.dateTo neq ''>
	AND a.assignmentslipdate <= "#form.dateTo#"
</cfif>
ORDER BY a.empno
</cfquery>
    
<cfquery name="cleartempdata" datasource="#dts#">
    delete from assignmentsliptemp
    where uuid = "#uuid#"
</cfquery>
    
<cfswitch expression="#form.result#">
	<cfcase value="EXCEL">
        <cfset iDecl_UPrice=getgsetup2.Decl_UPrice>
        <cfset stDecl_UPrice="">
        <cfset stDecl_UPrice2 = ",.">
        <cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
            <cfset stDecl_UPrice=stDecl_UPrice&"0">
            <cfset stDecl_UPrice2 = stDecl_UPrice2 & "_">
        </cfloop>
		<!-- ============ SETTING table headers for excel file ==================== --->
        <cfif isdefined('form.fieldglass') eq true>
            <cfset headerFields = [
			"Client ID", "Office Code", "Request", "Dept", "PO",
			"Staff name","JO",
            "Work Order ID","Cost Allocation / Center","Location","Business Unit","Hiring Manager",
            "Job Seeker ID","Job Posting","Security ID","Site",
            "Billing Mth","Invoice No","Start Date",
			"End Date","Basic Salary","No Month Work","Salary","Admin Fee",
			"EPF","SOCSO","EIS","Medical","HRDF","Equipment Changes","Sub-total","",
			"","","",
			"OT1.5(QTY)","OT1.5(RM)",
			"OT2.0(QTY)","OT2.0(RM)",
			"OT3.0(QTY)","OT3.0(RM)",
			"RD1.0(QTY)","RD1.0(RM)",
			"RD2.0(QTY)","RD2.0(RM)",
			"PH2.0(QTY)","PH2.0(RM)",
			"OT Sub-total",
			"Housing Allowance","Fixed Alowance","Var. Allowance",
			"Night Shift Allowance",
			"Afternoon Shift (KA Industrial)","Auto Allowance","Meal Allowance",
			"Reimb Claim","Bonus","+Bonus Accrued","Bonus Incentive","KPI","+KPI Incentive",
			"AL in Lieu","Unpaid Leave","Notice in Lieu","Disbursement","","Outsource Fee","Other Admin Fee","Commission","Deposit Deduction",
			"Professional Fee","Recruitment Fee","SOCSO OT","Day Shift Allowance",
			"Language Allowance","Advance Pay","Pay Adjustment","OT Adjustment","Piece Work","Consultancy Fee","Ex-Gratia","Fluctuation Service Fee","Grooming Allowance","Perfect Attendance","Phone allowance","Scope Allowance","Technical Allowance","Training fee","Transport Charges","Travel Claims","Miscellaneous",
            "Training Allowance",
			"Taxable","Non Taxable","GST/Service Tax","Total","Entity"
			] />
        <cfelseif isdefined('PUIG') eq true>
            <cfset headerFields = [
			"Client ID", "Office Code", "Request", "Dept", "PO",
			"Staff name","JO","Billing Mth","Invoice No","Start Date",
			"End Date","Basic Salary","No Month Work","Salary","EPF",
			"SOCSO","EIS","Medical","HRDF","Sub-Total",
			"OT1.5(QTY)","OT1.5(RM)",
			"OT2.0(QTY)","OT2.0(RM)",
			"OT3.0(QTY)","OT3.0(RM)",
			"RD1.0(QTY)","RD1.0(RM)",
			"RD2.0(QTY)","RD2.0(RM)",
			"PH2.0(QTY)","PH2.0(RM)",
			"OT Sub-total",
            "Equipment Changes",
			"Housing Allowance","Fixed Alowance","Var. Allowance",
			"Night Shift Allowance",
			"Afternoon Shift (KA Industrial)","Auto Allowance","Meal Allowance",
			"Reimb Claim","Bonus","+Bonus Accrued","Bonus Incentive","KPI","+KPI Incentive",
			"AL in Lieu","Unpaid Leave","Notice in Lieu","Disbursement","","Outsource Fee","Other Admin Fee","Commission","Deposit Deduction",
			"Professional Fee","Recruitment Fee","SOCSO OT","Day Shift Allowance",
			"Language Allowance","Advance Pay","Pay Adjustment","OT Adjustment","Piece Work","Consultancy Fee","Ex-Gratia","Fluctuation Service Fee","Grooming Allowance","Perfect Attendance","Phone allowance","Scope Allowance","Technical Allowance","Training fee","Transport Charges","Travel Claims","Miscellaneous","Others-Sub Total","Admin Fee","Total",
			"Taxable","Non Taxable","GST/Service Tax","Grand Total","Entity"
			] />
        <cfelse>
            <cfset headerFields = [
			"Client ID", "Office Code", "Request", "Dept", "PO",
			"Staff name","JO","Billing Mth","Invoice No","Start Date",
			"End Date","Basic Salary","No Month Work","Salary","Admin Fee",
			"EPF","SOCSO","EIS","Medical","HRDF","Equipment Changes","Sub-total","",
			"","","",
			"OT1.5(QTY)","OT1.5(RM)",
			"OT2.0(QTY)","OT2.0(RM)",
			"OT3.0(QTY)","OT3.0(RM)",
            "RD1.0(QTY)","RD1.0(RM)",
			"RD2.0(QTY)","RD2.0(RM)",
			"PH2.0(QTY)","PH2.0(RM)",
			"OT Sub-total",
			"Housing Allowance","Fixed Alowance","Var. Allowance",
			"Night Shift Allowance",
			"Afternoon Shift (KA Industrial)","Auto Allowance","Meal Allowance",
			"Reimb Claim","Bonus","+Bonus Accrued","Bonus Incentive","KPI","+KPI Incentive",
			"AL in Lieu","Unpaid Leave","Notice in Lieu","Disbursement","","Outsource Fee","Other Admin Fee","Commission","Deposit Deduction",
			"Professional Fee","Recruitment Fee","SOCSO OT","Day Shift Allowance",
			"Language Allowance","Advance Pay","Pay Adjustment","OT Adjustment","Piece Work","Consultancy Fee","Ex-Gratia","Fluctuation Service Fee","Grooming Allowance","Perfect Attendance","Phone allowance","Scope Allowance","Technical Allowance","Training fee","Transport Charges","Travel Claims","Miscellaneous",
            "Training Allowance","Sub-vendor's Commission","+Sub-vendor's Commission","Shift Allowance",
			"Taxable","Non Taxable","GST/Service Tax","Total","Entity"
			] />
        </cfif>
		
		<cfset colList = getCostingQuery.columnList >
		<!-- ============CREATING THE TABLE FOR THE EXCEL FILE==================== --->
		<cfxml variable="data">
			<cfinclude template='/excel_template/excel_header.cfm'>
			<Worksheet ss:Name="Costing Report">
			<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
				<Column ss:Width="64.5"/>
				<Column ss:Width="60.25"/>
				<Column ss:Width="183.75"/>
				<Column ss:AutoFitWidth="0" ss:Width="60"/>
				<Column ss:Width="47.25"/>
				<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
				<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
				<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
				<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
				<Row ss:AutoFitHeight="0" ss:Height="23.0625">
					<cfloop array="#headerFields#" index="field" >
						<Cell ss:StyleID="s27">
							<Data ss:Type="String">
								<cfoutput>
									#field#
								</cfoutput>
							</Data>
						</Cell>
					</cfloop>
				</Row>
				<cfset subtotal2 = 0>
				<cfset grandTotal = 0>
				<cfloop query="getCostingQuery" >
					<cfset OTTotal = getCostingQuery.custot2 + getCostingQuery.custot3 + getCostingQuery.custot4 + getCostingQuery.custot5 + getCostingQuery.custot6 + getCostingQuery.custot8  />
                    <cfif isdefined('PUIG') eq true>
                        <cfset subtotal1 = getCostingQuery.custsalary + getCostingQuery.custcpf + getCostingQuery.custsdf + getCostingQuery.custeis + getCostingQuery.medical + getCostingQuery.hrdf />
                    <cfelse>
                        <cfset subtotal1 = getCostingQuery.custsalary + getCostingQuery.adminfee + getCostingQuery.custcpf + getCostingQuery.custsdf + getCostingQuery.custeis + getCostingQuery.medical+ getCostingQuery.equip + getCostingQuery.hrdf />
                    </cfif>					
					<cfscript>

								if(getCostingQuery.paymenttype == "hr"){
									noMonthWork = numberFormat(getCostingQuery.custsalaryhrs,'.__');

								}else if(getCostingQuery.paymenttype == "day"){
									noMonthWork = numberFormat(getCostingQuery.custsalaryday,'.__');

								}else{
									noMonthWork = numberFormat( val(trim(getCostingQuery.workd)) != 0 ? ROUND((val(DateDiff("d", getCostingQuery.startdate, getCostingQuery.completedate) + 1)/val(getCostingQuery.workd)) * 100000) / 100000  : 0,'.__');
								}

								if(getCostingQuery.arrem5 == "GSTITEMIZED" || (year(getCostingQuery.completedate)>2018 && getCostingQuery.arrem5 == "GSTBILLRATE" && getCostingQuery.arrem7 == 1) || (month(getCostingQuery.completedate)>=9 && year(getCostingQuery.completedate)==2018 && getCostingQuery.arrem5 == "GSTBILLRATE" && getCostingQuery.arrem7 == 1)){
                                    if(getCostingQuery.adminfee != 0){
                                        nonTaxableAllowances = listtoarray(valuelist(getnontaxitemswithAdminFee.shelf));
                                        taxableAllowances = listtoarray(valuelist(gettaxitemswithAdminFee.taxitemid));
                                    }else{
                                        nonTaxableAllowances = listtoarray(valuelist(getnontaxitems.shelf));
                                        taxableAllowances = listtoarray(valuelist(gettaxitems.taxitemid));
                                    }

									taxable = getCostingQuery.adminfee;
                        
                                    if(isdefined('PUIG') eq true){
                                        nonTaxable = subtotal1 + OTTotal - getCostingQuery.medical - getCostingQuery.hrdf + val(getCostingQuery.lvltotaler1) + val(getCostingQuery.lvltotaler2);
                                    }else{
                                        nonTaxable = subtotal1 + OTTotal - getCostingQuery.adminfee - getCostingQuery.medical - getCostingQuery.hrdf + val(getCostingQuery.lvltotaler1) + val(getCostingQuery.lvltotaler2);
                                    }
									

								}else{
									nonTaxableAllowances = [];
									taxableAllowances = [];

									taxable = getCostingQuery.custtotalgross;
									nonTaxable = 0 ;

								}

								for(i = 1; i <= ArrayLen(taxableAllowances); i = i +1 ){
										taxable = taxable + findItem(taxableAllowances[i],getCostingQuery);
								}

								for(i = 1; i <= ArrayLen(nonTaxableAllowances); i = i +1 ){
										nonTaxable = nonTaxable + findItem(nonTaxableAllowances[i],getCostingQuery);
								}

								subtotal2 += subtotal1;

							</cfscript>
                    
					<cfset gst  = val(val(taxable) * (val(getCostingQuery.taxper)/100))>
					<cfset grandTotal += val((taxable + nonTaxable + gst))>
					<cfset billingMonth = getCostingQuery.billingMth eq '' ? '' : MonthAsString(getCostingQuery.billingMth) >
					<cfscript>
                        if(isdefined('PUIG') == true){
								numbersPosition = [12,13,14,15,16,17,18,19,20,
													21,22,23,24,25,26,27,28,29,
                                                    30,31,32,33,34,35,36,37,38,39,
                                                    40,41,42,43,44,45,46,47,48,49,
                                                    50,52,53,54,55,56,57,58,59,
                                                    60,61,62,63,64,65,66,67,68,69,
                                                    70,71,72,73,74,75,76,77,78,79,
                                                    80,81,82,83
									];
                        }else{
                            numbersPosition = [12,13,14,15,16,17,18,19,20,
													21,26,27,28,29,
                                                    30,31,32,33,34,35,36,37,38,39,
                                                    40,41,42,43,44,45,46,47,48,49,
                                                    50,51,52,53,54,55,57,58,59,
                                                    60,61,62,63,64,65,66,67,68,69,
                                                    70,71,72,73,74,75,76,77,78,79,
                                                    80,81,82,83,84,85,86,87,88,89
									];
                        }
                        
                        if(isdefined('form.fieldglass') == true){
                            fieldValues = [
									getCostingQuery.custno,
									getCostingQuery.location,
									getCostingQuery.request,
									getCostingQuery.dept,
									getCostingQuery.po_no,
									getCostingQuery.staffName,
									getCostingQuery.JO,
                            getCostingQuery.workorderid,
                            getCostingQuery.costcenter,
                            getCostingQuery.cLocation,
                            getCostingQuery.businessunit,
                            getCostingQuery.hrmgr,
                            getCostingQuery.jobid,
                            getCostingQuery.jobposting,
                            getCostingQuery.securityID,
                            getCostingQuery.site,
									billingMonth,
									getCostingQuery.invoiceno,
									DateFormat(getCostingQuery.startdate,"YYYY-mm-dd"),

									DateFormat(getCostingQuery.completedate,"YYYY-mm-dd"),//array number 11
									getCostingQuery.custusualpay,
									noMonthWork,
									custsalary,
									getCostingQuery.adminfee,
									getCostingQuery.custcpf,
									getCostingQuery.custsdf,
                                    getCostingQuery.custeis,
									getCostingQuery.medical,
									getCostingQuery.hrdf,
                                    getCostingQuery.equip,
									subtotal1,
									"",

									"",
									 "",
									  "",
									getCostingQuery.custothour2,
									getCostingQuery.custot2,
									getCostingQuery.custothour3,
									getCostingQuery.custot3,
									getCostingQuery.custothour4,
									getCostingQuery.custot4,
                                    getCostingQuery.custothour5,
									getCostingQuery.custot5,
									getCostingQuery.custothour6,

									getCostingQuery.custot6,
									getCostingQuery.custothour8,
									getCostingQuery.custot8,
									OTTotal, //column number 34
									findItem(52,getCostingQuery), // housing
									findItem(3,getCostingQuery), // fixed
									findItem(5,getCostingQuery), // var.
									findItem(48,getCostingQuery), //night shift
                                    findItem(69,getCostingQuery), //Afternoon Shift (KA Industrial)
                                    findItem(32,getCostingQuery), // auto allowance
                                    findItem(58,getCostingQuery), // meal allowance									
									findItem(6,getCostingQuery), //reimb claim

									findItem(9,getCostingQuery), //bonus
                                    findItem(36,getCostingQuery), //+bonus accrued
                                    findItem(98,getCostingQuery), //Bonus Incentive
									findItem(72,getCostingQuery), //KPI
                                    findItem(73,getCostingQuery), //+KPI Incentive
									findItem(14,getCostingQuery), // AL
									val(findItem(19,getCostingQuery))+val(getCostingQuery.lvltotaler1)+val(getCostingQuery.lvltotaler2), // Unpaid Leave
									findItem(13,getCostingQuery), // notice in lieu
									findItem(33,getCostingQuery), // disbursement
									"",
									findItem(18,getCostingQuery), // outsource
									val(findItem(86,getCostingQuery))+val(findItem(1,getCostingQuery))+val(findItem(20,getCostingQuery))+val(findItem(21,getCostingQuery)), //other admin
                                    findItem(7,getCostingQuery), // Commission
                                    findItem(53,getCostingQuery), // Deposit Deduction
									findItem(43,getCostingQuery), // professional

									findItem(4,getCostingQuery), // recruitment
									findItem(42,getCostingQuery),  // socso ot
									findItem(47,getCostingQuery),  // day shift
									findItem(75,getCostingQuery),  // language
                                    findItem(40,getCostingQuery),  // Advance Pay
									findItem(11,getCostingQuery),  // pay adjustment
									findItem(12,getCostingQuery),  // ot adjustment
                                    findItem(8,getCostingQuery),  // Piece Work
                                    findItem(54,getCostingQuery),  // Consultancy Fee
                                    findItem(10,getCostingQuery),  // Ex-Gratia
                                    findItem(104,getCostingQuery),  // Fluctuation Service Fee
                                    findItem(79,getCostingQuery),  // Grooming Allowance
                                    findItem(57,getCostingQuery),  // Perfect Attendance
                                    findItem(94,getCostingQuery),  // Phone allowance
                                    findItem(59,getCostingQuery),  // Scope Allowance
                                    findItem(106,getCostingQuery),  // Technical Allowance
                                    findItem(97,getCostingQuery),  // Training fee
                                    findItem(51,getCostingQuery),  // Transport Charges
                                    findItem(30,getCostingQuery),  // Travel Claims
                                    findItem(38,getCostingQuery), //Miscellaneous
                                    findItem(107,getCostingQuery),  // Training Allowance
									taxable,
									nonTaxable,
									val(gst),
									val(taxable + nonTaxable + gst),
									getCostingQuery.entity
								];
                        }else if(isdefined('PUIG') == true){
                            fieldValues = [
									getCostingQuery.custno,
									getCostingQuery.location,
									getCostingQuery.request,
									getCostingQuery.dept,
									getCostingQuery.po_no,
									getCostingQuery.staffName,
									getCostingQuery.JO,
									billingMonth,
									getCostingQuery.invoiceno,
									DateFormat(getCostingQuery.startdate,"YYYY-mm-dd"), //column 10

									DateFormat(getCostingQuery.completedate,"YYYY-mm-dd"),
									getCostingQuery.custusualpay,
									noMonthWork,
									custsalary,
									getCostingQuery.custcpf,
									getCostingQuery.custsdf,
                                    getCostingQuery.custeis,
									getCostingQuery.medical,
									getCostingQuery.hrdf,
									subtotal1,
									getCostingQuery.custothour2,//column 20
                        
									getCostingQuery.custot2,
									getCostingQuery.custothour3,
									getCostingQuery.custot3,
									getCostingQuery.custothour4,
									getCostingQuery.custot4,
                                    getCostingQuery.custothour5,
									getCostingQuery.custot5,
									getCostingQuery.custothour6,
									getCostingQuery.custot6,
									getCostingQuery.custothour8,
									getCostingQuery.custot8,
									OTTotal, //column 30
                        
                                    getCostingQuery.equip,
									findItem(52,getCostingQuery), // housing
									findItem(3,getCostingQuery), // fixed
									findItem(5,getCostingQuery), // var.
									findItem(48,getCostingQuery), //night shift
                                    findItem(69,getCostingQuery), //Afternoon Shift (KA Industrial)
                                    findItem(32,getCostingQuery), // auto allowance
                                    findItem(58,getCostingQuery), // meal allowance									
									findItem(6,getCostingQuery), //reimb claim
									findItem(9,getCostingQuery), //bonus, column 40
                        
                                    findItem(36,getCostingQuery), //+bonus accrued
                                    findItem(98,getCostingQuery), //Bonus Incentive
									findItem(72,getCostingQuery), //KPI
                                    findItem(73,getCostingQuery), //+KPI Incentive
									findItem(14,getCostingQuery), // AL
									val(findItem(19,getCostingQuery))+val(getCostingQuery.lvltotaler1)+val(getCostingQuery.lvltotaler2), // Unpaid Leave
									findItem(13,getCostingQuery), // notice in lieu
									findItem(33,getCostingQuery), // disbursement
									"",
									findItem(18,getCostingQuery), // outsource, column 50
                                    val(findItem(86,getCostingQuery))+val(findItem(1,getCostingQuery))+val(findItem(20,getCostingQuery))+val(findItem(21,getCostingQuery)), //other admin
                                    findItem(7,getCostingQuery), // Commission
                                    findItem(53,getCostingQuery), // Deposit Deduction
									findItem(43,getCostingQuery), // professional
									findItem(4,getCostingQuery), // recruitment
									findItem(42,getCostingQuery),  // socso ot
									findItem(47,getCostingQuery),  // day shift
									findItem(75,getCostingQuery),  // language
                                    findItem(40,getCostingQuery),  // Advance Pay
									findItem(11,getCostingQuery),  // pay adjustment, column 60
                        
									findItem(12,getCostingQuery),  // ot adjustment
                                    findItem(8,getCostingQuery),  // Piece Work
                                    findItem(54,getCostingQuery),  // Consultancy Fee
                                    findItem(10,getCostingQuery),  // Ex-Gratia
                                    findItem(104,getCostingQuery),  // Fluctuation Service Fee
                                    findItem(79,getCostingQuery),  // Grooming Allowance
                                    findItem(57,getCostingQuery),  // Perfect Attendance
                                    findItem(94,getCostingQuery),  // Phone allowance
                                    findItem(59,getCostingQuery),  // Scope Allowance
                                    findItem(106,getCostingQuery),  // Technical Allowance
                        
                                    findItem(97,getCostingQuery),  // Training fee
                                    findItem(51,getCostingQuery),  // Transport Charges
                                    findItem(30,getCostingQuery),  // Travel Claims
                                    findItem(38,getCostingQuery), //Miscellaneous
                                    getCostingQuery.custtotalgross-val(OTTotal)-val(subtotal1)-val(getCostingQuery.adminfee), //Other-Subtotal
                                    getCostingQuery.adminfee,
                                    getCostingQuery.custtotalgross, //Total
									taxable,
									nonTaxable,
									val(gst),
									val(taxable + nonTaxable + gst),
									getCostingQuery.entity
								];
                        }else{
                            fieldValues = [
									getCostingQuery.custno,
									getCostingQuery.location,
									getCostingQuery.request,
									getCostingQuery.dept,
									getCostingQuery.po_no,
									getCostingQuery.staffName,
									getCostingQuery.JO,
									billingMonth,
									getCostingQuery.invoiceno,
									DateFormat(getCostingQuery.startdate,"YYYY-mm-dd"),

									DateFormat(getCostingQuery.completedate,"YYYY-mm-dd"),//array number 11
									getCostingQuery.custusualpay,
									noMonthWork,
									custsalary,
									getCostingQuery.adminfee,
									getCostingQuery.custcpf,
									getCostingQuery.custsdf,
                                    getCostingQuery.custeis,
									getCostingQuery.medical,
									getCostingQuery.hrdf,
                                    getCostingQuery.equip,
									subtotal1,
									"",

									"",
									 "",
									  "",
									getCostingQuery.custothour2,
									getCostingQuery.custot2,
									getCostingQuery.custothour3,
									getCostingQuery.custot3,
									getCostingQuery.custothour4,
									getCostingQuery.custot4,
                                    getCostingQuery.custothour5,
									getCostingQuery.custot5,
									getCostingQuery.custothour6,

									getCostingQuery.custot6,
									getCostingQuery.custothour8,
									getCostingQuery.custot8,
									OTTotal, //column number 34
									findItem(52,getCostingQuery), // housing
									findItem(3,getCostingQuery), // fixed
									findItem(5,getCostingQuery), // var.
									findItem(48,getCostingQuery), //night shift
                                    findItem(69,getCostingQuery), //Afternoon Shift (KA Industrial)
                                    findItem(32,getCostingQuery), // auto allowance
                                    findItem(58,getCostingQuery), // meal allowance									
									findItem(6,getCostingQuery), //reimb claim

									findItem(9,getCostingQuery), //bonus
                                    findItem(36,getCostingQuery), //+bonus accrued
                                    findItem(98,getCostingQuery), //Bonus Incentive
									findItem(72,getCostingQuery), //KPI
                                    findItem(73,getCostingQuery), //+KPI Incentive
									findItem(14,getCostingQuery), // AL
									val(findItem(19,getCostingQuery))+val(getCostingQuery.lvltotaler1)+val(getCostingQuery.lvltotaler2), // Unpaid Leave
									findItem(13,getCostingQuery), // notice in lieu
									findItem(33,getCostingQuery), // disbursement
									"",
									findItem(18,getCostingQuery), // outsource
									val(findItem(86,getCostingQuery))+val(findItem(1,getCostingQuery))+val(findItem(20,getCostingQuery))+val(findItem(21,getCostingQuery)), //other admin
                                    findItem(7,getCostingQuery), // Commission
                                    findItem(53,getCostingQuery), // Deposit Deduction
									findItem(43,getCostingQuery), // professional

									findItem(4,getCostingQuery), // recruitment
									findItem(42,getCostingQuery),  // socso ot
									findItem(47,getCostingQuery),  // day shift
									findItem(75,getCostingQuery),  // language
                                    findItem(40,getCostingQuery),  // Advance Pay
									findItem(11,getCostingQuery),  // pay adjustment
									findItem(12,getCostingQuery),  // ot adjustment
                                    findItem(8,getCostingQuery),  // Piece Work
                                    findItem(54,getCostingQuery),  // Consultancy Fee
                                    findItem(10,getCostingQuery),  // Ex-Gratia
                                    findItem(104,getCostingQuery),  // Fluctuation Service Fee
                                    findItem(79,getCostingQuery),  // Grooming Allowance
                                    findItem(57,getCostingQuery),  // Perfect Attendance
                                    findItem(94,getCostingQuery),  // Phone allowance
                                    findItem(59,getCostingQuery),  // Scope Allowance
                                    findItem(106,getCostingQuery),  // Technical Allowance
                                    findItem(97,getCostingQuery),  // Training fee
                                    findItem(51,getCostingQuery),  // Transport Charges
                                    findItem(30,getCostingQuery),  // Travel Claims
                                    findItem(38,getCostingQuery), //Miscellaneous
                                    findItem(107,getCostingQuery),  // Training Allowance
                                    findItem(41,getCostingQuery),  // Sub-vendor's Commission
                                    findItem(125,getCostingQuery), // +Sub-vendor's Commission
                                    findItem(109,getCostingQuery),  // Shift Allowance, added 20190129
									taxable,
									nonTaxable,
									val(gst),
									val(taxable + nonTaxable + gst),
									getCostingQuery.entity
								];
                        }
								
								</cfscript>
					<Row>
						<cfloop from="1" to="#ArrayLen(fieldValues)#" index="i">
                            <cfif isdefined('form.fieldglass')>
                                <cfif ArrayContains(numbersPosition,(i-9))>
                                    <cfoutput>
                                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(fieldValues[i])#</Data></Cell>
                                    </cfoutput>
                                <cfelse>
                                    <cfwddx action = "cfml2wddx" input = "#fieldValues[i]#" output = "wddxText#i#">
                                    <cfoutput>
                                        <Cell><Data ss:Type="String">#evaluate('wddxText#i#')#</Data></Cell>
                                    </cfoutput>
                                </cfif>
                            <cfelse>
                                <cfif ArrayContains(numbersPosition,i)>
                                    <cfoutput>
                                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(fieldValues[i])#</Data></Cell>
                                    </cfoutput>
                                <cfelse>
                                    <cfwddx action = "cfml2wddx" input = "#fieldValues[i]#" output = "wddxText#i#">
                                    <cfoutput>
                                        <Cell><Data ss:Type="String">#evaluate('wddxText#i#')#</Data></Cell>
                                    </cfoutput>
                                </cfif>
                            </cfif>
						</cfloop>
					</Row>
				</cfloop>
				<Row>
                    
                    <cfset arraylen =ArrayLen(headerFields)-3> 
					<cfloop from="1" to="#arraylen#" index="i">
						<Cell>
							<Data ss:Type="String">
							</Data>
						</Cell>
					</cfloop>
					<Cell>
						<Data ss:Type="String">
							Total :
						</Data>
					</Cell>
					<Cell ss:StyleID="s50">
						<Data ss:Type="Number"><cfoutput>#grandTotal#</cfoutput></Data>
					</Cell>
					<Cell>
					</Cell>
				</Row>
				<Row ss:AutoFitHeight="0" ss:Height="12">
				</Row>
			</Table>
			<cfinclude template='/excel_template/excel_footer.cfm'>
		</cfxml>
		<cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\CostingReport.xls" output="#tostring(data)#" charset="utf-8">
            
		<cfheader name="Content-Disposition" value="inline; filename=#dts#_CostingReport_#huserid#_#timenow#.xls">
		<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\CostingReport.xls">
	</cfcase>
</cfswitch>
<cfscript>
	function findItem(value, row){
		var limit = 18;
		var valPrefix = "awer";
		var prefix = "allowance";
		var allowance_amt = 0;
		 for(var i = 1; i < limit; i = i+1){
		 	if(row[prefix&i][row.currentRow] == value){
		 		allowance_amt += row[valPrefix&i][row.currentRow];

		 	}
		 }

		limit = 6;
		valPrefix = "fixawer";
		prefix = "fixawcode";
		var fixAW_amt = 0;

		 for(var i = 1; i < limit; i = i+1){
		 	if(row[prefix&i][row.currentRow] == value){
		 		fixAW_amt += row[valPrefix&i][row.currentRow];

		 	}
		 }

		 limit = 6;
		valPrefix = "billitemamt";
		prefix = "billitem";
		var bill_amt = 0;

		 for(var i = 1; i < limit; i = i+1){
		 	if(row[prefix&i][row.currentRow] == value){
		 		bill_amt += row[valPrefix&i][row.currentRow];

		 	}
		 }
                                  
        limit = 3;
		valPrefix = "addchargecust";
		prefix = "addchargecode";
		var addcharge_amt = 0;

		 for(var i = 1; i < limit; i = i+1){
            if(i ==1){
                if(row[prefix][row.currentRow] == value){
                    addcharge_amt += val(row[valPrefix][row.currentRow]);
                }
            }else if(row[prefix&i][row.currentRow] == value){
		 		addcharge_amt += row[valPrefix&i][row.currentRow];

		 	}
		 }

		 return fixAW_amt + allowance_amt + bill_amt + addcharge_amt;
	}

</cfscript>
