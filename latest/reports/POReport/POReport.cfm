<cfset uuid = createuuid()>
    
<cfif isdefined('form.customer') eq false>
    <script>
        alert("Please select a client ID.");
        window.close();
    </script>
    <cfabort>
</cfif>
    
<cfif form.customer eq ''>
    <script>
        alert("Please select a client ID.");
        window.close();
    </script>
    <cfabort>
</cfif>

<cfquery name="getAllShelf" datasource="#dts#">
	SELECT * FROM icshelf;
</cfquery>
    
<cfquery name="getAllItem" datasource="#dts#">
	SELECT itemno FROM icitem
</cfquery>
    
<cfsetting showdebugoutput="true">
    
<cfsetting requesttimeout=1800>

<cfquery datasource="#dts#">
	SET SESSION binlog_format = 'MIXED';
</cfquery>

<cfquery name="getComp_qry" datasource="payroll_main">
SELECT * FROM gsetup WHERE comp_id = "#replace(HcomID,'_i','')#"
</cfquery>
    
<cfquery name="getGsetup" datasource='#dts#'>
	SELECT * FROM gsetup 
</cfquery>
    
<cfquery name="gettaxitems" datasource='#dts#'>
	select taxitemid from taxmethoditem 
    where taxmethodid=3<!---Itemized Rate--->
</cfquery>
    
<cfquery name="gettaxitemswithAdminFee" datasource='#dts#'>
	select taxitemid from taxmethoditem 
    where taxmethodid=3
    and id < 23
</cfquery>
    
<cfset diff = val(form.periodTo) - (val(form.periodFrom)-1)>

<cfset cachetime = val(diff) * 3>

<cftry>
    
    <cfquery datasource="#dts#">
        insert into assignmentslip_po select *,"#uuid#" from assignmentslip 
        where payrollperiod 
        between #form.periodFrom# and #form.periodTo# 
        and batches<>''
        AND created_on > #createdate(getComp_qry.myear,1,7)#
        <cfif isdefined('form.customer')>
           <cfif form.customer neq ''>
            and custno IN (
                <cfqueryparam value="#form.customer#" cfsqltype="CF_SQL_VARCHAR" list="yes" />
            )
            </cfif>
        </cfif>
    </cfquery>
    
    <cfcatch type="database">
        <cfquery datasource="#dts#">
        drop table if exists assignmentslip_po
        </cfquery>

        <cfquery datasource="#dts#">
        create table if not exists assignmentslip_po like assignmentslip
        </cfquery>
    
        <cfquery datasource="#dts#">
        alter table assignmentslip_po
        add column (uuid varchar(45) default '')
        </cfquery>
        
        <cfquery name="prepareassignmentslip_po" datasource="#dts#">
        ALTER TABLE assignmentslip_po ENGINE=INNODB
        </cfquery>
    
        <cfquery name="prepareassignmentslip_po" datasource="#dts#">
        ALTER TABLE assignmentslip_po 
        CHANGE COLUMN `uuid` `uuid` VARCHAR(45) NOT NULL DEFAULT '' ,
        DROP PRIMARY KEY,
        ADD PRIMARY KEY (`refno`, `uuid`)
        </cfquery>

        <cfquery datasource="#dts#">
        insert into assignmentslip_po select *,"#uuid#" from assignmentslip 
            where payrollperiod 
            between #form.periodFrom# and #form.periodTo# 
            and batches<>''
            AND created_on > #createdate(getComp_qry.myear,1,7)#
            <cfif isdefined('form.customer')>
               <cfif form.customer neq ''>
                and custno IN (
                    <cfqueryparam value="#form.customer#" cfsqltype="CF_SQL_VARCHAR" list="yes" />
                )
                </cfif>
            </cfif>
        </cfquery>
    </cfcatch>
</cftry>
        
<cftry>
    <cfquery datasource="#dts#">
    insert into arcust_po select *,"#uuid#" from arcust where 1=1
    <cfif isdefined('form.customer')>
       <cfif form.customer neq ''>
        and custno IN (
            <cfqueryparam value="#form.customer#" cfsqltype="CF_SQL_VARCHAR" list="yes" />
        )
        </cfif>
    </cfif>
    </cfquery>
    
    <cfcatch type="database">
        <cfquery datasource="#dts#">
        drop table if exists arcust_po
        </cfquery>

        <cfquery datasource="#dts#">
        create table if not exists arcust_po like arcust
        </cfquery>
        
        <cfquery datasource="#dts#">
        alter table arcust_po
        add column (uuid varchar(45) default '')
        </cfquery>
        
        <cfquery name="prepare_po" datasource="#dts#">
        ALTER TABLE arcust_po ENGINE=INNODB
        </cfquery>
        
        <cfquery name="prepare_po" datasource="#dts#">
        ALTER TABLE arcust_po
        CHANGE COLUMN `uuid` `uuid` VARCHAR(45) NOT NULL DEFAULT '' ,
        DROP PRIMARY KEY,
        ADD PRIMARY KEY (`CUSTNO`, `uuid`)
        </cfquery>

        <cfquery datasource="#dts#">
        insert into arcust_po select *,"#uuid#" from arcust where 1=1
        <cfif isdefined('form.customer')>
           <cfif form.customer neq ''>
            and custno IN (
                <cfqueryparam value="#form.customer#" cfsqltype="CF_SQL_VARCHAR" list="yes" />
            )
            </cfif>
        </cfif>
        </cfquery>
    </cfcatch>
</cftry>
        
<cftry>
    <cfquery datasource="#dts#">
    insert into artran_po select *,"#uuid#" from artran where fperiod<>99
        and type in ('inv','cn','dn')
    <cfif isdefined('form.customer')>
       <cfif form.customer neq ''>
        and custno IN (
            <cfqueryparam value="#form.customer#" cfsqltype="CF_SQL_VARCHAR" list="yes" />
        )
        </cfif>
    </cfif>
    </cfquery>
    
    <cfcatch type="database">
        <cfquery datasource="#dts#">
        drop table if exists artran_po 
        </cfquery>

        <cfquery datasource="#dts#">
        create table if not exists artran_po like artran
        </cfquery>
        
        <cfquery datasource="#dts#">
        alter table artran_po
        add column (uuid varchar(45) default '')
        </cfquery>
        
        <cfquery name="prepare_po" datasource="#dts#">
        ALTER TABLE artran_po ENGINE=INNODB
        </cfquery>
        
        <cfquery name="prepare_po" datasource="#dts#">
        ALTER TABLE artran_po
        CHANGE COLUMN `uuid` `uuid` VARCHAR(45) NOT NULL DEFAULT '' ,
        DROP PRIMARY KEY,
        ADD PRIMARY KEY (`TYPE`, `REFNO`, `CUSTNO`, `WOS_DATE`, `uuid`)
        </cfquery>

        <cfquery datasource="#dts#">
        insert into artran_po select *,"#uuid#" from artran where fperiod<>99
            and type in ('inv','cn','dn')
        <cfif isdefined('form.customer')>
           <cfif form.customer neq ''>
            and custno IN (
                <cfqueryparam value="#form.customer#" cfsqltype="CF_SQL_VARCHAR" list="yes" />
            )
            </cfif>
        </cfif>
        </cfquery>
    </cfcatch>
</cftry>
        
<cftry>
    <cfquery datasource="#dts#">
    insert into ictran_po
        (refno,type,wos_date,trancode,itemcount,itemno,desp,taxpec1,fperiod,custno,brem5,
            price_bil,qty_bil,amt_bil,brem6,brem1,uuid)
            select refno,type,wos_date,trancode,itemcount,itemno,desp,taxpec1,fperiod,custno,brem5,
            price_bil,qty_bil,amt_bil,brem6,brem1,
            "#uuid#" from ictran where fperiod<>99
            and type in ('inv','cn','dn')
    <cfif isdefined('form.customer')>
       <cfif form.customer neq ''>
        and custno IN (
            <cfqueryparam value="#form.customer#" cfsqltype="CF_SQL_VARCHAR" list="yes" />
        )
        </cfif>
    </cfif>
    </cfquery>
    
    <cfcatch type="database">
        <cfquery datasource="#dts#">
        drop table if exists ictran_po
        </cfquery>

        <cfquery datasource="#dts#">
        create table if not exists ictran_po like ictran
        </cfquery>
        
        <cfquery datasource="#dts#">
        alter table ictran_po
        add column (uuid varchar(45) default '')
        </cfquery>
        
        <cfquery name="prepare_po" datasource="#dts#">
        ALTER TABLE ictran_po ENGINE=INNODB
        </cfquery>
        
        <cfquery name="prepare_po" datasource="#dts#">
        ALTER TABLE ictran_po
        DROP INDEX `brem3` ,
        DROP INDEX `brem6` ,
        DROP INDEX `brem1` ,
        DROP INDEX `brem5` ,
        DROP INDEX `ITEMNO` ,
        DROP INDEX `checkserv` ,
        DROP INDEX `itemhis` ,
        DROP INDEX `CUSTREPORT` ,
        DROP INDEX `ITEMREPORT` ,
        DROP INDEX `BATCHITEM` ,
        DROP INDEX `ASSMITEM` ,
        DROP INDEX `COSTING` 
        </cfquery>
        
        <cfquery name="prepare_po" datasource="#dts#">
        ALTER TABLE ictran_po
        CHANGE COLUMN `uuid` `uuid` VARCHAR(45) NOT NULL DEFAULT '' ,
        DROP PRIMARY KEY,
        ADD PRIMARY KEY (`TYPE`, `REFNO`, `CUSTNO`, `TRANCODE`, `ITEMCOUNT`, `ITEMNO`, `WOS_DATE`, `uuid`)
        </cfquery>

        <cfquery datasource="#dts#">
        insert into ictran_po
        (refno,type,wos_date,trancode,itemcount,itemno,desp,taxpec1,fperiod,custno,brem5,
            price_bil,qty_bil,amt_bil,brem6,brem1,uuid)
            select refno,type,wos_date,trancode,itemcount,itemno,desp,taxpec1,fperiod,custno,brem5,
            price_bil,qty_bil,amt_bil,brem6,brem1,
            "#uuid#" from ictran where fperiod<>99
            and type in ('inv','cn','dn')
        <cfif isdefined('form.customer')>
        <cfif form.customer neq ''>
            and custno IN (
                <cfqueryparam value="#form.customer#" cfsqltype="CF_SQL_VARCHAR" list="yes" />
            )
            </cfif>
        </cfif>
        </cfquery>
    </cfcatch>
</cftry>
        
<cftry>
    <cfquery datasource="#dts#">
    insert into hmsers_po select *,"#uuid#" from payroll_main.hmusers 
    </cfquery>
    
    <cfcatch type="database">
        <cfquery datasource="#dts#">
        drop table if exists hmsers_po
        </cfquery>

        <cfquery datasource="#dts#">
        create table if not exists hmsers_po like payroll_main.hmusers
        </cfquery>
        
        <cfquery datasource="#dts#">
        alter table hmsers_po
        add column (uuid varchar(45) default '')
        </cfquery>
        
        <cfquery name="prepare_po" datasource="#dts#">
        ALTER TABLE hmsers_po ENGINE=INNODB
        </cfquery>
        
        <cfquery name="prepare_po" datasource="#dts#">
        ALTER TABLE hmsers_po
        CHANGE COLUMN `uuid` `uuid` VARCHAR(45) NOT NULL DEFAULT '' ,
        DROP PRIMARY KEY,
        ADD PRIMARY KEY (`entryid`, `uuid`)
        </cfquery>

        <cfquery datasource="#dts#">
        insert into hmsers_po select *,"#uuid#" from payroll_main.hmusers 
        </cfquery>
    </cfcatch>
</cftry>
    
<!-- QUERY FOR placement no--->
<cfquery name="getAssignment" datasource="#dts#" cachedwithin="#createtimespan(0,0,cachetime,0)#">
    SELECT
        p.location as branch,
        p.po_no as PO,
        p.empname as candidate,
        p.custno as clientID,
        p.custname as company,
        hm.username as `HM`,
        cust.attn as `billingName`,
        p.department as `dept`,
        p.placementNO as JO,
        DATE_FORMAT(p.startDate,'%d-%m-%Y') as `StartDate`,
        DATE_FORMAT(p.completedate,'%d-%m-%Y') as `EndDate`,
        a.startDate as startd,
        a.completedate as completed,
		DATE_FORMAT(DATE_ADD(a.assignmentslipdate,INTERVAL cust.arrem6 DAY),'%d-%m-%Y') as `invoiceDue`,
 		DATE_FORMAT(a.assignmentslipdate,'%d-%m-%Y') as `invoiceIssue`,
        a.branch as a_entity,
        a.*,
        a.taxper as taxp1,
        cust.arrem5,
        cust.arrem7

    FROM
		(SELECT * FROM assignmentslip_po where uuid = "#uuid#") a
    	LEFT JOIN placement p ON a.placementno = p.placementno
        LEFT JOIN (SELECT * FROM hmsers_po WHERE uuid = "#uuid#") hm ON hm.entryid=p.hrmgr
        LEFT JOIN (SELECT * FROM arcust_po WHERE uuid = "#uuid#") cust ON cust.custno=p.custno
        LEFT JOIN (SELECT * FROM artran_po WHERE uuid = "#uuid#") art ON art.refno=a.invoiceno
    WHERE 1 =1
        <cfif isdefined('form.customer')>
           <cfif form.customer neq ''>
            and a.custno IN (
                <cfqueryparam value="#form.customer#" cfsqltype="CF_SQL_VARCHAR" list="yes" />
            )
            </cfif>
        </cfif>
		and
		a.payrollperiod >= #form.periodFrom#
		AND a.payrollperiod <= #form.periodTo#       

		<cfif form.dateFrom neq ''>
			AND assignmentslipdate >= "#form.dateFrom#"
		</cfif>

		<cfif form.dateTo neq ''>
			AND assignmentslipdate <= "#form.dateTo#"
		</cfif>
    ORDER by empno

</cfquery>
    
<cfquery name="getAssignmentcndn" datasource="#dts#" cachedwithin="#createtimespan(0,0,0,30)#">
    SELECT
        p.location as branch,
        case when ar.rem5 != '' then ar.rem5 else p.po_no end as PO,
        p.empname as candidate,
        ic.custno as clientID,
        cust.name as company,
        hm.username as `HM`,
        cust.attn as `billingName`,
        cust.business as `dept`,
        p.placementNO as JO,
        DATE_FORMAT(p.startDate,'%d-%m-%Y') as `StartDate`,
        DATE_FORMAT(p.completedate,'%d-%m-%Y') as `EndDate`,
        a.startDate as startd,
        a.completedate as completed,
		DATE_FORMAT(DATE_ADD(ic.wos_date,INTERVAL cust.arrem6 DAY),'%d-%m-%Y') as `invoiceDue`,
 		DATE_FORMAT(ic.wos_date,'%d-%m-%Y') as `invoiceIssue`,
        a.branch as a_entity,
        ic.fperiod as payrollperiod,
        p.empno,
        ic.*,
        ic.taxpec1 as taxp1,
        cust.arrem5,
        cust.arrem7
    
    FROM (
            select refno,type,wos_date,trancode,itemcount,itemno,desp,taxpec1,fperiod,custno,brem5,
            price_bil,qty_bil,amt_bil,brem6,brem1
            from ictran_po 
            where (void is null or void ='')
            and itemno != 'Name'
            and uuid = "#uuid#"
        )ic
        LEFT JOIN (SELECT * FROM artran_po WHERE uuid = "#uuid#") ar ON ar.refno=ic.refno
		LEFT JOIN (SELECT * FROM assignmentslip_po WHERE uuid = "#uuid#") a ON a.refno=ic.brem6 
    	LEFT JOIN placement p ON ic.brem1=p.placementno 
        LEFT JOIN (SELECT * FROM hmsers_po WHERE uuid = "#uuid#") hm ON hm.entryid=p.hrmgr
        LEFT JOIN (SELECT * FROM arcust_po WHERE uuid = "#uuid#") cust ON cust.custno=ic.custno
    WHERE 1 =1
        AND (ar.type='cn' or ar.type='dn')
        AND (ar.void is null or ar.void ='')
        AND ar.fperiod >= '#numberformat(form.periodFrom,'00')#'
        AND ar.fperiod <= '#numberformat(form.periodTo,'00')#'
                        
        <cfif isdefined('form.customer')>
           <cfif form.customer neq ''>
            and ic.custno IN (
                <cfqueryparam value="#form.customer#" cfsqltype="CF_SQL_VARCHAR" list="yes" />
            )
            </cfif>
        </cfif>    

		<cfif form.dateFrom neq ''>
			AND ic.wos_date >= "#form.dateFrom#"
		</cfif>

		<cfif form.dateTo neq ''>
			AND ic.wos_date <= "#form.dateTo#"
		</cfif>
    ORDER by ic.refno,ic.brem5,trancode

</cfquery>
    <!---<cfoutput><br>Please be patient. This Report under maintenance. </cfoutput> 
    <cfif left(GetAuthUser(),5) eq 'ultra'>
        <cfloop query="getAssignmentcndn">       
            <cfoutput><br>#getAssignmentcndn.refno#,#getAssignmentcndn.itemno#, #getAssignmentcndn.taxp1#, #getAssignmentcndn.a_entity#, #getAssignmentcndn.brem6#, #getAssignmentcndn.brem1# </cfoutput>
        </cfloop>
    </cfif>
    <cfabort>--->
    
<cfset totalrecord = val(getAssignment.recordcount) + val(getAssignmentcndn.recordcount)>
    
<cfoutput>#totalrecord#</cfoutput>
    
<cfset recordlimit = 300>
<!-- ============ SETTING table headers for excel file ==================== --->
<cfif totalrecord lt recordlimit>
<cfset headerFields = [
	"Branch", "PO", "Candidate", "ClientID", "Company",
	"Hiring Mgr", "Billing name", "Order Dept", "JO", "StartDate",
	"EndDate", "Acc Period", "Bill Item", "Bill Qty", "Bill Rate", "Bill Amount",
	"Pay Qty", "Pay Rate", "Pay Amount", "Taxable", "Tax%",
	"Tax Amount","Total With Tax","Invoice No","Invoice Issue","Invoice Due",
	"Timesheet Remarks"
	] />
<cfelse>
    <cfset excel = SpreadSheetNew(true)>
    <cfset temp_query = querynew("Branch,PO,Candidate,ClientID,Company,Hiring_Mgr,Billing_name,Order_Dept,JO,StartDate,EndDate,Acc_Period,Bill_Item, Bill_Qty,Bill_Rate,Bill_Amount,Pay_Qty,Pay_Rate,Pay_Amount,Taxable,Tax_Percentage,Tax_Amount,Total_With_Tax,Invoice_No,Invoice_Issue,Invoice_Due,Timesheet_Remarks") />   
</cfif>
<!--- ============CREATING THE TABLE FOR THE EXCEL FILE==================== --->
<!--- ===============================================================================  --->
<cfif totalrecord lt recordlimit>
<cfxml variable="data">
	<cfinclude template="/excel_template/excel_header.cfm">
	<Worksheet ss:Name="PO Report">
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
		<cfscript>
						payTotal = 0;
						billTotal = 0;
						gstTotal = 0;
						empTotal  = 0;

						grandPayTotal = 0;
						grandBillTotal = 0;
						grandGstTotal = 0;
						grandEmpTotal = 0;

						tempEmp = getAssignment.empno;

						


		</cfscript>
		<cfloop query="#getAssignment#">
			<cfscript>
                if(getAssignment.arrem5 == 'GSTITEMIZED' || getAssignment.arrem7 == 1){
                    if(getAssignment.adminfee != 0 && ((month(getAssignment.completedate) >= 9 && year(getAssignment.completedate) == 2018) || year(getAssignment.completedate) > 2018) ){
                        taxableItems = listtoarray(valuelist(gettaxitemswithAdminFee.taxitemid));
                    }else{
                        taxableItems = listtoarray(valuelist(gettaxitems.taxitemid));
                    }

                }else{

                    taxableItems = [];
                    for(i = 1; i <= 111; i++){
                        ArrayAppend(taxableItems,i);
                    }
                }

						if(tempEmp != getAssignment['empno'][getAssignment.currentRow]){
							printTotal();
						}
						// init variables for template
						//payTotal = 0;
						//billTotal = 0;
						entity = getAssignment.branch;
						billAmt = 0; billRate = 0; billQty = 0;
						payAmt = 0; payRate = 0; payQty = 0;
						label = "";
						// printRow( label, billrate, bill quantity, bill amount, pay rate , pay quantity, pay amount, check = true)


					//print normal
					if(getassignment.paymenttype == "hr"){
						 pay_qty = numberformat(getassignment.selfsalaryhrs,'.____');
						 bill_qty = numberformat(getassignment.custsalaryhrs,'.____');

					}
					else if( getassignment.paymenttype == 'day'){
						pay_qty = numberformat(getassignment.selfsalaryday,'.____');
						bill_qty = numberformat(getassignment.custsalaryday,'.____');
					}
					else if(val(getassignment.workd) != 0){
							pay_qty = numberformat(ROUND((val(DateDiff("d", getassignment.startd, getassignment.completed) + 1)/val(getassignment.workd))*100000)/100000 ,'.___');
							bill_qty = numberformat(ROUND((val(DateDiff("d", getassignment.startd, getassignment.completed) + 1)/val(getassignment.workd))*100000)/100000 ,'.___');
					}
					else{
							pay_qty = 1;
							bill_qty = 1;
						}

					//print normal
					printRow( "Normal",
						getAssignment.custusualpay, bill_qty, getAssignment.custsalary,
						getAssignment.selfusualpay, pay_qty, getAssignment.selfsalary,getAssignment.taxp1);



					// print OT
					OTLabel =["OT 1.0","OT 1.5","OT 2.0", "OT 3.0", "RD 1.0", "RD 2.0", "PH 1.0", "PH 2.0"];
                
					for(i=1; i <= 8; i++){
							printRow(
							 OTLabel[i],
							 getAssignment['custotrate'& i][getAssignment.currentRow],
						     getAssignment['custothour'& i][getAssignment.currentRow],
							 getAssignment['custot'& i][getAssignment.currentRow],
							 getAssignment['selfotrate'& i][getAssignment.currentRow],
							 getAssignment['selfothour'& i][getAssignment.currentRow],
							 getAssignment['selfot'& i][getAssignment.currentRow],
                            getAssignment.taxp1
							 );
					}


					// print fixed allowance
					for(i =1; i<=6; i++){
						isTaxable = false;
						if(ArrayContains(taxableItems,getAssignment['fixawcode'&i][getAssignment.currentRow])){
							isTaxable = true;
						}

						printRow( getAssignment['fixawdesp' & i][getAssignment.currentRow],
						getAssignment['fixawer' & i][getAssignment.currentRow],
						1,
						getAssignment['fixawer' & i][getAssignment.currentRow],
						getAssignment['fixawee' & i][getAssignment.currentRow],
						1,
						getAssignment['fixawee' & i][getAssignment.currentRow],
                        getAssignment.taxp1,
						isTaxable
					);
					}


					// print var. allowance
					for(i = 1; i<=18; i++){
						isTaxable = false;
						if(ArrayContains(taxableItems,getAssignment['allowance'&i][getAssignment.currentRow])){
							isTaxable = true;
						}

						printRow(
							getICShelfName(getAssignment['allowance'&i][getAssignment.currentRow]),

							getAssignment['awer' & i][getAssignment.currentRow],
							1,
							getAssignment['awer' & i][getAssignment.currentRow],
							getAssignment['awee' & i][getAssignment.currentRow],
							1,
							getAssignment['awee' & i][getAssignment.currentRow],
                            getAssignment.taxp1,
							isTaxable
						);
				}


					// print Non paid leave
                    for(i = 1; i<=10; i++){
                        if(getAssignment['lvltotaler'&i][getAssignment.currentRow] != 0 or getAssignment['lvltotalee'&i][getAssignment.currentRow] != 0){
                            printRow(
                                "Non Paid leave",
                                getAssignment['lvlerrate#i#'][getAssignment.currentRow],
                                getAssignment['lvlerdayhr#i#'][getAssignment.currentRow],
                                getAssignment['lvltotaler#i#'][getAssignment.currentRow],
                                getAssignment['lvleerate#i#'][getAssignment.currentRow],
                                getAssignment['lvleedayhr#i#'][getAssignment.currentRow],
                                getAssignment['lvltotalee#i#'][getAssignment.currentRow],
                                getAssignment.taxp1
                            );
                        }
                        
                    }


					// print EPF, EIS and SOCSO

					printRow(
						"EPF",
						getAssignment['custCPF'][getAssignment.currentRow],
						1,
						getAssignment['custcpf'][getAssignment.currentRow],
						getAssignment['selfcpf'][getAssignment.currentRow],
						1,
						(getAssignment['selfcpf'][getAssignment.currentRow]) * -1,
                        getAssignment.taxp1
					);

					printRow(
						"SOCSO",
						getAssignment['custSDF'][getAssignment.currentRow],
						1,
						getAssignment['custSDF'][getAssignment.currentRow],
						getAssignment['selfSDF'][getAssignment.currentRow],
						1,
						(getAssignment['selfSDF'][getAssignment.currentRow]) * -1,
                        getAssignment.taxp1
					);
                                     
                    printRow(
						"EIS",
						getAssignment['custEIS'][getAssignment.currentRow],
						1,
						getAssignment['custEIS'][getAssignment.currentRow],
						getAssignment['selfEIS'][getAssignment.currentRow],
						1,
						(getAssignment['selfEIS'][getAssignment.currentRow]) * -1,
                        getAssignment.taxp1
					);

					// print admin fee
					printRow(
					"Admin Fee",
					getAssignment['adminfee'][getAssignment.currentRow],
					1,
					getAssignment['adminfee'][getAssignment.currentRow], 0,0,0,
                    getAssignment.taxp1,
					true,                    
					 true
					 );

					for(i = 1; i<= 6; i++){
						isTaxable = false;
						if(ArrayContains(taxableItems,getAssignment['billitem'&i][getAssignment.currentRow])){
							isTaxable = true;
						}
						printRow(
							getAssignment['billitemdesp' & i][getAssignment.currentRow],
							getAssignment['billitemamt' & i][getAssignment.currentRow],
							1,
							getAssignment['billitemamt' & i][getAssignment.currentRow],
							0,0,0,getAssignment.taxp1,isTaxable
						);
					}

					// add charge

					isTaxable = false;
					if(ArrayContains(taxableItems,getAssignment['addchargecode'][getAssignment.currentRow])){
						isTaxable = true;
					}
					printRow(
							getICShelfName(getAssignment['addchargecode'][getAssignment.currentRow]),
							getAssignment['addchargecust' ][getAssignment.currentRow],
							1,
							getAssignment['addchargecust'][getAssignment.currentRow],
							getAssignment['addchargeself'][getAssignment.currentRow],
							1,
							getAssignment['addchargeself'][getAssignment.currentRow],
                            getAssignment.taxp1,
							isTaxable
						);
					for(i = 2; i <= 3; i++){
						isTaxable = false;
						if(ArrayContains(taxableItems,getAssignment['addchargecode'&i][getAssignment.currentRow])){
							isTaxable = true;
						}
						printRow(
							getAssignment['addchargedesp' & i][getAssignment.currentRow],
							getAssignment['addchargecust'& i ][getAssignment.currentRow],
							1,
							getAssignment['addchargecust'&i][getAssignment.currentRow],
							getAssignment['addchargeself'&i][getAssignment.currentRow],
							1,
							getAssignment['addchargeself' &i][getAssignment.currentRow],
                            getAssignment.taxp1,
							isTaxable
						);

					}
					</cfscript>
		</cfloop>
        <cfscript>
            printTotal();
            tempbrem5 = trim(getAssignmentcndn.brem5);
        </cfscript>
        <cfloop query="getAssignmentcndn">
            <cfscript>
                if(tempbrem5 != trim(getAssignmentcndn.brem5)){
                    printTotal();
                    tempbrem5 = trim(getAssignmentcndn.brem5);
                }
                
                entity = getAssignmentcndn.branch;
                billAmt = 0; billRate = 0; billQty = 0;
                payAmt = 0; payRate = 0; payQty = 0;
                label = "";
                isTaxable = false;
                
                if(ArrayContains(taxableItems,getAssignmentcndn.itemno)){
                    isTaxable = true;
                }
                
                if(getAssignmentcndn.itemno == 'adminfee'){
                    isTaxable = true;
                }
                
                
                printRowcndn( getAssignmentcndn.desp,
                    getAssignmentcndn.price_bil, getAssignmentcndn.qty_bil, getAssignmentcndn.amt_bil,
                    0, 0, 0,getAssignmentcndn.taxp1,isTaxable);
                
            </cfscript>
        </cfloop>
		<cfscript>
			// print last employee and grand total

			if(getAssignment.recordCount > 0){
				printTotal();

				payTotal = grandPayTotal; billTotal = grandBillTotal;
				gstTotal = grandGstTotal; empTotal  = grandEmpTotal;

				printTotal();
			}
		</cfscript>
		<Row ss:AutoFitHeight="0" ss:Height="12"/>
	</Table>
	<cfinclude template="/excel_template/excel_footer.cfm">
</cfxml>
       
<cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\POTracker.xls" output="#tostring(data)#" charset="utf-8">

<cftry>
    
    <cfquery datasource="#dts#">
        delete from assignmentslip_po 
        where uuid = "#uuid#"
    </cfquery>

    <cfcatch type="database">
    </cfcatch>
</cftry>
    
<cftry>

    <cfquery datasource="#dts#">
        delete from hmusers_po 
        where uuid = "#uuid#"
    </cfquery>

    <cfcatch type="database">
    </cfcatch>
</cftry>
    
<cftry>

    <cfquery datasource="#dts#">
        delete from ictran_po 
        where uuid = "#uuid#"
    </cfquery>

    <cfcatch type="database">
    </cfcatch>
</cftry>
    
<cftry>

    <cfquery datasource="#dts#">
        delete from artran_po 
        where uuid = "#uuid#"
    </cfquery>
    <cfcatch type="database">
    </cfcatch>
</cftry>
    
<cftry>

    <cfquery datasource="#dts#">
        delete from arcust_po 
        where uuid = "#uuid#"
    </cfquery>

    <cfcatch type="database">
    </cfcatch>
</cftry>

<cfheader name="Content-Disposition" value="inline; filename=POTracker_#huserid#.xls">
<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\POTracker.xls">
    
<!---<cfelseif totalrecord gt 5000>
    <!---Added by Nieo on 20181130, to improve the Report download speed and lower the risk to eat up a lot of server ram--->
    
        <cfscript>
						payTotal = 0;
						billTotal = 0;
						gstTotal = 0;
						empTotal  = 0;

						grandPayTotal = 0;
						grandBillTotal = 0;
						grandGstTotal = 0;
						grandEmpTotal = 0;

						tempEmp = getAssignment.empno;

						


		</cfscript>
		<cfloop query="#getAssignment#">
			<cfscript>
                if(getAssignment.arrem5 == 'GSTITEMIZED' || getAssignment.arrem7 == 1){
                    if(getAssignment.adminfee != 0 && ((month(getAssignment.completedate) >= 9 && year(getAssignment.completedate) == 2018) || year(getAssignment.completedate) > 2018) ){
                        taxableItems = listtoarray(valuelist(gettaxitemswithAdminFee.taxitemid));
                    }else{
                        taxableItems = listtoarray(valuelist(gettaxitems.taxitemid));
                    }
                }else{

                    taxableItems = [];
                    for(i = 1; i <= 111; i++){
                        ArrayAppend(taxableItems,i);
                    }
                }

						if(tempEmp != getAssignment['empno'][getAssignment.currentRow]){
							printTotal();
						}
						// init variables for template
						//payTotal = 0;
						//billTotal = 0;
						entity = getAssignment.branch;
						billAmt = 0; billRate = 0; billQty = 0;
						payAmt = 0; payRate = 0; payQty = 0;
						label = "";
						// printRow( label, billrate, bill quantity, bill amount, pay rate , pay quantity, pay amount, check = true)


					//print normal
					if(getassignment.paymenttype == "hr"){
						 pay_qty = numberformat(getassignment.selfsalaryhrs,'.____');
						 bill_qty = numberformat(getassignment.custsalaryhrs,'.____');

					}
					else if( getassignment.paymenttype == 'day'){
						pay_qty = numberformat(getassignment.selfsalaryday,'.____');
						bill_qty = numberformat(getassignment.custsalaryday,'.____');
					}
					else if(val(getassignment.workd) != 0){
							pay_qty = numberformat(ROUND((val(DateDiff("d", getassignment.startd, getassignment.completed) + 1)/val(getassignment.workd))*100000)/100000 ,'.___');
							bill_qty = numberformat(ROUND((val(DateDiff("d", getassignment.startd, getassignment.completed) + 1)/val(getassignment.workd))*100000)/100000 ,'.___');
					}
					else{
							pay_qty = 1;
							bill_qty = 1;
						}

					//print normal
					printRow( "Normal",
						getAssignment.custusualpay, bill_qty, getAssignment.custsalary,
						getAssignment.selfusualpay, pay_qty, getAssignment.selfsalary,getAssignment.taxp1);



					// print OT
					OTLabel =["OT 1.0","OT 1.5","OT 2.0", "OT 3.0", "RD 1.0", "RD 2.0", "PH 1.0", "PH 2.0"];
					for(i=1; i <= 8; i++){
							printRow(
							 OTLabel[i],
							 getAssignment['custotrate'& i][getAssignment.currentRow],
						     getAssignment['custothour'& i][getAssignment.currentRow],
							 getAssignment['custot'& i][getAssignment.currentRow],
							 getAssignment['selfotrate'& i][getAssignment.currentRow],
							 getAssignment['selfothour'& i][getAssignment.currentRow],
							 getAssignment['selfot'& i][getAssignment.currentRow],
                            getAssignment.taxp1
							 );
					}


					// print fixed allowance
					for(i =1; i<=6; i++){
						isTaxable = false;
						if(ArrayContains(taxableItems,getAssignment['fixawcode'&i][getAssignment.currentRow])){
							isTaxable = true;
						}

						printRow( getAssignment['fixawdesp' & i][getAssignment.currentRow],
						getAssignment['fixawer' & i][getAssignment.currentRow],
						1,
						getAssignment['fixawer' & i][getAssignment.currentRow],
						getAssignment['fixawee' & i][getAssignment.currentRow],
						1,
						getAssignment['fixawee' & i][getAssignment.currentRow],
                        getAssignment.taxp1,
						isTaxable
					);
					}


					// print var. allowance
					for(i = 1; i<=18; i++){
						isTaxable = false;
						if(ArrayContains(taxableItems,getAssignment['allowance'&i][getAssignment.currentRow])){
							isTaxable = true;
						}

						printRow(
							getICShelfName(getAssignment['allowance'&i][getAssignment.currentRow]),

							getAssignment['awer' & i][getAssignment.currentRow],
							1,
							getAssignment['awer' & i][getAssignment.currentRow],
							getAssignment['awee' & i][getAssignment.currentRow],
							1,
							getAssignment['awee' & i][getAssignment.currentRow],
                            getAssignment.taxp1,
							isTaxable
						);
				}


					// print Non paid leave
                    for(i = 1; i<=10; i++){
                        if(getAssignment['lvltotaler'&i][getAssignment.currentRow] != 0 or getAssignment['lvltotalee'&i][getAssignment.currentRow] != 0){
                            printRow(
                                "Non Paid leave",
                                getAssignment['lvlerrate#i#'][getAssignment.currentRow],
                                getAssignment['lvlerdayhr#i#'][getAssignment.currentRow],
                                getAssignment['lvltotaler#i#'][getAssignment.currentRow],
                                getAssignment['lvleerate#i#'][getAssignment.currentRow],
                                getAssignment['lvleedayhr#i#'][getAssignment.currentRow],
                                getAssignment['lvltotalee#i#'][getAssignment.currentRow],
                                getAssignment.taxp1
                            );
                        }
                    }


					// print EPF, EIS and SOCSO

					printRow(
						"EPF",
						getAssignment['custCPF'][getAssignment.currentRow],
						1,
						getAssignment['custcpf'][getAssignment.currentRow],
						getAssignment['selfcpf'][getAssignment.currentRow],
						1,
						(getAssignment['selfcpf'][getAssignment.currentRow]) * -1,
                        getAssignment.taxp1
					);

					printRow(
						"SOCSO",
						getAssignment['custSDF'][getAssignment.currentRow],
						1,
						getAssignment['custSDF'][getAssignment.currentRow],
						getAssignment['selfSDF'][getAssignment.currentRow],
						1,
						(getAssignment['selfSDF'][getAssignment.currentRow]) * -1,
                        getAssignment.taxp1
					);
                                     
                    printRow(
						"EIS",
						getAssignment['custEIS'][getAssignment.currentRow],
						1,
						getAssignment['custEIS'][getAssignment.currentRow],
						getAssignment['selfEIS'][getAssignment.currentRow],
						1,
						(getAssignment['selfEIS'][getAssignment.currentRow]) * -1,
                        getAssignment.taxp1
					);

					// print admin fee
					printRow(
					"Admin Fee",
					getAssignment['adminfee'][getAssignment.currentRow],
					1,
					getAssignment['adminfee'][getAssignment.currentRow], 0,0,0,
                    getAssignment.taxp1,
					true,                    
					 true
					 );

					for(i = 1; i<= 6; i++){
						isTaxable = false;
						if(ArrayContains(taxableItems,getAssignment['billitem'&i][getAssignment.currentRow])){
							isTaxable = true;
						}
						printRow(
							getAssignment['billitemdesp' & i][getAssignment.currentRow],
							getAssignment['billitemamt' & i][getAssignment.currentRow],
							1,
							getAssignment['billitemamt' & i][getAssignment.currentRow],
							0,0,0,getAssignment.taxp1,isTaxable
						);
					}

					// add charge

					isTaxable = false;
					if(ArrayContains(taxableItems,getAssignment['addchargecode'][getAssignment.currentRow])){
						isTaxable = true;
					}
					printRow(
							getICShelfName(getAssignment['addchargecode'][getAssignment.currentRow]),
							getAssignment['addchargecust' ][getAssignment.currentRow],
							1,
							getAssignment['addchargecust'][getAssignment.currentRow],
							getAssignment['addchargeself'][getAssignment.currentRow],
							1,
							getAssignment['addchargeself'][getAssignment.currentRow],
                            getAssignment.taxp1,
							isTaxable
						);
					for(i = 2; i <= 3; i++){
						isTaxable = false;
						if(ArrayContains(taxableItems,getAssignment['addchargecode'&i][getAssignment.currentRow])){
							isTaxable = true;
						}
						printRow(
							getAssignment['addchargedesp' & i][getAssignment.currentRow],
							getAssignment['addchargecust'& i ][getAssignment.currentRow],
							1,
							getAssignment['addchargecust'&i][getAssignment.currentRow],
							getAssignment['addchargeself'&i][getAssignment.currentRow],
							1,
							getAssignment['addchargeself' &i][getAssignment.currentRow],
                            getAssignment.taxp1,
							isTaxable
						);

					}
					</cfscript>
		</cfloop>
        <cfscript>
            printTotal();
            tempbrem5 = trim(getAssignmentcndn.brem5);
        </cfscript>
        <cfloop query="getAssignmentcndn">
            <cfscript>
                if(tempbrem5 != trim(getAssignmentcndn.brem5)){
                    printTotal();
                    tempbrem5 = trim(getAssignmentcndn.brem5);
                }
                
                entity = getAssignmentcndn.branch;
                billAmt = 0; billRate = 0; billQty = 0;
                payAmt = 0; payRate = 0; payQty = 0;
                label = "";
                isTaxable = false;
                
                if(ArrayContains(taxableItems,getAssignmentcndn.itemno)){
                    isTaxable = true;
                }
                
                if(getAssignmentcndn.itemno == 'adminfee'){
                    isTaxable = true;
                }
                
                printRowcndn( getAssignmentcndn.desp,
                    getAssignmentcndn.price_bil, getAssignmentcndn.qty_bil, getAssignmentcndn.amt_bil,
                    0, 0, 0,getAssignmentcndn.taxp1,isTaxable);
            </cfscript>
        </cfloop>
		<cfscript>
			// print last employee and grand total

			if(getAssignment.recordCount > 0){
				printTotal();

				payTotal = grandPayTotal; billTotal = grandBillTotal;
				gstTotal = grandGstTotal; empTotal  = grandEmpTotal;

				printTotal();
			}
		</cfscript>
    
    <cfset timenow = "#DateTimeFormat(now(), 'yyyy-mm-dd_hhnnss')#">
    
    <cfspreadsheet action="write" filename="#HRootPath#\Excel_Report\POreport_#timenow#.xlsx" query="temp_query" overwrite="true">
        
    <cftry>
    
        <cfquery datasource="#dts#">
            delete from assignmentslip_po 
            where uuid = "#uuid#"
        </cfquery>
        
        <cfquery datasource="#dts#">
            delete from hmusers_po 
            where uuid = "#uuid#"
        </cfquery>
        
        <cfquery datasource="#dts#">
            delete from ictran_po 
            where uuid = "#uuid#"
        </cfquery>
        
        <cfquery datasource="#dts#">
            delete from artran_po 
            where uuid = "#uuid#"
        </cfquery>
        
        <cfquery datasource="#dts#">
            delete from arcust_po 
            where uuid = "#uuid#"
        </cfquery>

        <cfcatch type="database">
        </cfcatch>
    </cftry>

    <cfheader name="Content-Disposition" value="inline; filename=POreport_#timenow#.xlsx">
    <cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\POreport_#timenow#.xlsx">
    <!---Added by Nieo on 20181130, to improve the Report download speed and lower the risk to eat up a lot of server ram--->--->
<cfelse>
    <cfscript>
						payTotal = 0;
						billTotal = 0;
						gstTotal = 0;
						empTotal  = 0;

						grandPayTotal = 0;
						grandBillTotal = 0;
						grandGstTotal = 0;
						grandEmpTotal = 0;

						tempEmp = getAssignment.empno;

						


		</cfscript>
		<cfloop query="#getAssignment#">
			<cfscript>
                    if(getAssignment.arrem5 == 'GSTITEMIZED' || getAssignment.arrem7 == 1){
                        if(getAssignment.adminfee != 0 && ((month(getAssignment.completedate) >= 9 && year(getAssignment.completedate) == 2018) || year(getAssignment.completedate) > 2018) ){
                            taxableItems = listtoarray(valuelist(gettaxitemswithAdminFee.taxitemid));
                        }else{
                            taxableItems = listtoarray(valuelist(gettaxitems.taxitemid));
                        }
                    }else{

                        taxableItems = [];
                        for(i = 1; i <= 111; i++){
                            ArrayAppend(taxableItems,i);
                        }
                    }

						if(tempEmp != getAssignment['empno'][getAssignment.currentRow]){
							printTotal();
						}
						// init variables for template
						//payTotal = 0;
						//billTotal = 0;
						entity = getAssignment.branch;
						billAmt = 0; billRate = 0; billQty = 0;
						payAmt = 0; payRate = 0; payQty = 0;
						label = "";
						// printRow( label, billrate, bill quantity, bill amount, pay rate , pay quantity, pay amount, check = true)


					//print normal
					if(getassignment.paymenttype == "hr"){
						 pay_qty = numberformat(getassignment.selfsalaryhrs,'.____');
						 bill_qty = numberformat(getassignment.custsalaryhrs,'.____');

					}
					else if( getassignment.paymenttype == 'day'){
						pay_qty = numberformat(getassignment.selfsalaryday,'.____');
						bill_qty = numberformat(getassignment.custsalaryday,'.____');
					}
					else if(val(getassignment.workd) != 0){
							pay_qty = numberformat(ROUND((val(DateDiff("d", getassignment.startd, getassignment.completed) + 1)/val(getassignment.workd))*100000)/100000 ,'.___');
							bill_qty = numberformat(ROUND((val(DateDiff("d", getassignment.startd, getassignment.completed) + 1)/val(getassignment.workd))*100000)/100000 ,'.___');
					}
					else{
							pay_qty = 1;
							bill_qty = 1;
						}

					//print normal
					printRow( "Normal",
						getAssignment.custusualpay, bill_qty, getAssignment.custsalary,
						getAssignment.selfusualpay, pay_qty, getAssignment.selfsalary,getAssignment.taxp1);



					// print OT
					OTLabel =["OT 1.0","OT 1.5","OT 2.0", "OT 3.0", "RD 1.0", "RD 2.0", "PH 1.0", "PH 2.0"];
					for(i=1; i <= 8; i++){
							printRow(
							 OTLabel[i],
							 getAssignment['custotrate'& i][getAssignment.currentRow],
						     getAssignment['custothour'& i][getAssignment.currentRow],
							 getAssignment['custot'& i][getAssignment.currentRow],
							 getAssignment['selfotrate'& i][getAssignment.currentRow],
							 getAssignment['selfothour'& i][getAssignment.currentRow],
							 getAssignment['selfot'& i][getAssignment.currentRow],
                            getAssignment.taxp1
							 );
					}


					// print fixed allowance
					for(i =1; i<=6; i++){
						isTaxable = false;
						if(ArrayContains(taxableItems,getAssignment['fixawcode'&i][getAssignment.currentRow])){
							isTaxable = true;
						}

						printRow( getAssignment['fixawdesp' & i][getAssignment.currentRow],
						getAssignment['fixawer' & i][getAssignment.currentRow],
						1,
						getAssignment['fixawer' & i][getAssignment.currentRow],
						getAssignment['fixawee' & i][getAssignment.currentRow],
						1,
						getAssignment['fixawee' & i][getAssignment.currentRow],
                        getAssignment.taxp1,
						isTaxable
					);
					}


					// print var. allowance
					for(i = 1; i<=18; i++){
						isTaxable = false;
						if(ArrayContains(taxableItems,getAssignment['allowance'&i][getAssignment.currentRow])){
							isTaxable = true;
						}

						printRow(
							getICShelfName(getAssignment['allowance'&i][getAssignment.currentRow]),

							getAssignment['awer' & i][getAssignment.currentRow],
							1,
							getAssignment['awer' & i][getAssignment.currentRow],
							getAssignment['awee' & i][getAssignment.currentRow],
							1,
							getAssignment['awee' & i][getAssignment.currentRow],
                            getAssignment.taxp1,
							isTaxable
						);
				}


					// print Non paid leave
                    for(i = 1; i<=10; i++){
                        if(getAssignment['lvltotaler'&i][getAssignment.currentRow] != 0 or getAssignment['lvltotalee'&i][getAssignment.currentRow] != 0){
                            printRow(
                                "Non Paid leave",
                                getAssignment['lvlerrate#i#'][getAssignment.currentRow],
                                getAssignment['lvlerdayhr#i#'][getAssignment.currentRow],
                                getAssignment['lvltotaler#i#'][getAssignment.currentRow],
                                getAssignment['lvleerate#i#'][getAssignment.currentRow],
                                getAssignment['lvleedayhr#i#'][getAssignment.currentRow],
                                getAssignment['lvltotalee#i#'][getAssignment.currentRow],
                                getAssignment.taxp1
                            );
                        }
                    }


					// print EPF, EIS and SOCSO

					printRow(
						"EPF",
						getAssignment['custCPF'][getAssignment.currentRow],
						1,
						getAssignment['custcpf'][getAssignment.currentRow],
						getAssignment['selfcpf'][getAssignment.currentRow],
						1,
						(getAssignment['selfcpf'][getAssignment.currentRow]) * -1,
                        getAssignment.taxp1
					);

					printRow(
						"SOCSO",
						getAssignment['custSDF'][getAssignment.currentRow],
						1,
						getAssignment['custSDF'][getAssignment.currentRow],
						getAssignment['selfSDF'][getAssignment.currentRow],
						1,
						(getAssignment['selfSDF'][getAssignment.currentRow]) * -1,
                        getAssignment.taxp1
					);
                                     
                    printRow(
						"EIS",
						getAssignment['custEIS'][getAssignment.currentRow],
						1,
						getAssignment['custEIS'][getAssignment.currentRow],
						getAssignment['selfEIS'][getAssignment.currentRow],
						1,
						(getAssignment['selfEIS'][getAssignment.currentRow]) * -1,
                        getAssignment.taxp1
					);

					// print admin fee
					printRow(
					"Admin Fee",
					getAssignment['adminfee'][getAssignment.currentRow],
					1,
					getAssignment['adminfee'][getAssignment.currentRow], 0,0,0,
                    getAssignment.taxp1,
					true,                    
					 true
					 );

					for(i = 1; i<= 6; i++){
						isTaxable = false;
						if(ArrayContains(taxableItems,getAssignment['billitem'&i][getAssignment.currentRow])){
							isTaxable = true;
						}
						printRow(
							getAssignment['billitemdesp' & i][getAssignment.currentRow],
							getAssignment['billitemamt' & i][getAssignment.currentRow],
							1,
							getAssignment['billitemamt' & i][getAssignment.currentRow],
							0,0,0,getAssignment.taxp1,isTaxable
						);
					}

					// add charge

					isTaxable = false;
					if(ArrayContains(taxableItems,getAssignment['addchargecode'][getAssignment.currentRow])){
						isTaxable = true;
					}
					printRow(
							getICShelfName(getAssignment['addchargecode'][getAssignment.currentRow]),
							getAssignment['addchargecust' ][getAssignment.currentRow],
							1,
							getAssignment['addchargecust'][getAssignment.currentRow],
							getAssignment['addchargeself'][getAssignment.currentRow],
							1,
							getAssignment['addchargeself'][getAssignment.currentRow],
                            getAssignment.taxp1,
							isTaxable
						);
					for(i = 2; i <= 3; i++){
						isTaxable = false;
						if(ArrayContains(taxableItems,getAssignment['addchargecode'&i][getAssignment.currentRow])){
							isTaxable = true;
						}
						printRow(
							getAssignment['addchargedesp' & i][getAssignment.currentRow],
							getAssignment['addchargecust'& i ][getAssignment.currentRow],
							1,
							getAssignment['addchargecust'&i][getAssignment.currentRow],
							getAssignment['addchargeself'&i][getAssignment.currentRow],
							1,
							getAssignment['addchargeself' &i][getAssignment.currentRow],
                            getAssignment.taxp1,
							isTaxable
						);

					}
					</cfscript>
		</cfloop>
        <cfscript>
            printTotal();
            tempbrem5 = trim(getAssignmentcndn.brem5);
        </cfscript>
        <cfloop query="getAssignmentcndn">
            <cfscript>
                if(tempbrem5 != trim(getAssignmentcndn.brem5)){
                    printTotal();
                    tempbrem5 = trim(getAssignmentcndn.brem5);
                }
                
                entity = getAssignmentcndn.branch;
                billAmt = 0; billRate = 0; billQty = 0;
                payAmt = 0; payRate = 0; payQty = 0;
                label = "";
                isTaxable = false;
                
                if(ArrayContains(taxableItems,getAssignmentcndn.itemno)){
                    isTaxable = true;
                }
                
                if(getAssignmentcndn.itemno == 'adminfee'){
                    isTaxable = true;
                }
                
                printRowcndn( getAssignmentcndn.desp,
                    getAssignmentcndn.price_bil, getAssignmentcndn.qty_bil, getAssignmentcndn.amt_bil,
                    0, 0, 0,getAssignmentcndn.taxp1,isTaxable);
            </cfscript>
        </cfloop>
		<cfscript>
			// print last employee and grand total

			if(getAssignment.recordCount > 0){
				printTotal();

				payTotal = grandPayTotal; billTotal = grandBillTotal;
				gstTotal = grandGstTotal; empTotal  = grandEmpTotal;

				printTotal();
			}
		</cfscript>
    
    <cfset timenow = "#DateTimeFormat(now(), 'yyyy-mm-dd_hhnnss')#">
    
    <cfspreadsheet action="write" filename="#HRootPath#\Excel_Report\POreport_#timenow#.xlsx" query="temp_query" overwrite="true">
        
    <cftry>
    
        <cfquery datasource="#dts#">
            delete from assignmentslip_po 
            where uuid = "#uuid#"
        </cfquery>
        
        <cfquery datasource="#dts#">
            delete from hmusers_po 
            where uuid = "#uuid#"
        </cfquery>
        
        <cfquery datasource="#dts#">
            delete from ictran_po 
            where uuid = "#uuid#"
        </cfquery>
        
        <cfquery datasource="#dts#">
            delete from artran_po 
            where uuid = "#uuid#"
        </cfquery>
        
        <cfquery datasource="#dts#">
            delete from arcust_po 
            where uuid = "#uuid#"
        </cfquery>

        <cfcatch type="database">
        </cfcatch>
    </cftry>

    <cfheader name="Content-Disposition" value="inline; filename=POreport_#timenow#.xlsx">
    <cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\POreport_#timenow#.xlsx">
</cfif>
<!-- ===============================================================================  --->
<cfscript>
	function printRow( p_label, p_billRate, p_billQty, p_billAmt, p_payRate, p_payQty, p_payAmt,taxper, p_taxable = false){
        
        if((month(getAssignment.completedate) < 9 && year(getAssignment.completedate) == 2018) || year(getAssignment.completedate) < 2018)
        {
            if(taxper==""){
                taxper = 0;
            }

            if(taxper != 0 || getAssignment.arrem5 == "GSTBILLRATE"){
                p_taxable = true;
            }
        }else{
            if(taxper != 0 && getAssignment.arrem5 == "GSTBILLRATE" && getAssignment.arrem7 != 1){
                p_taxable = true;
            }
        }
    
		//setting the variables to be used in the template
		label = p_label;
		billRate = p_billRate; billQty = p_billQty; billAmt = p_billAmt;
		payRate = p_payRate; payQty = p_payQty; payAmt = p_payAmt;
		taxable = "FALSE";
		gstAmt = 0;

		//check for taxable items
		if(p_taxable){
				taxable = "TRUE";
				gstAmt = numberFormat(billAmt * (taxper/100),'.____');
		}
		lineTotal = numberFormat(gstAmt + billAmt,'.____');

		payTotal += p_payAmt;
		billTotal += p_billAmt;
		gstTotal += gstAmt;
		empTotal += lineTotal;

		if(p_billAmt != 0 OR p_payAmt != 0){
            if(totalrecord < recordlimit){
                include 'PO_commonFields.cfm';                     
            }else{
                if(taxable == 'TRUE'){
                    taxperc = '#taxper#%';
                }else{
                    taxperc = '0';
                }
    
                queryaddrow(temp_query, {Branch:"#getassignment.branch#",
                PO:"#getassignment.po#",
                Candidate:"#getassignment.candidate#",
                ClientID:"#getassignment.clientID#",
                Company:"#getassignment.company#",
                Hiring_Mgr:"#getassignment.HM#",
                Billing_name:"#getassignment.billingName#",
                Order_Dept:"#getassignment.dept#",
                JO:"#getassignment.jo#",
                StartDate:"#getassignment.StartDate#",
                EndDate:"#getassignment.EndDate#",
                Acc_Period:"#getassignment.payrollperiod#",
                Bill_Item:"#p_label#",
                Bill_Qty:"#billQty#",
                Bill_Rate:"#billRate#",
                Bill_Amount:"#numberformat(billAmt,'.__')#",
                Pay_Qty:"#payQty#",
                Pay_Rate:"#payRate#",
                Pay_Amount:"#payAmt#",
                Taxable:"#Taxable#",
                Tax_Percentage:"#taxperc#",
                Tax_Amount:"#gstAmt#",
                Total_With_Tax:"#lineTotal#",
                Invoice_No:"#getAssignment.invoiceno#",
                Invoice_Issue:"#getAssignment.invoiceIssue#",
                Invoice_Due:"#getAssignment.invoiceDue#",
                Timesheet_Remarks:""
                });                
            }		  
		}

	}

    function printRowcndn( p_label, p_billRate, p_billQty, p_billAmt, p_payRate, p_payQty, p_payAmt,taxper, p_taxable = false){
        if( (month(getAssignmentcndn.wos_date) < 9 and year(getAssignmentcndn.wos_date) == 2018) || year(getAssignmentcndn.wos_date) < 2018){
            if(taxper==""){
                taxper = 0;
            }

            if(taxper != 0 || getAssignment.arrem5 == "GSTBILLRATE"){
                p_taxable = true;
            }
        }else{       
            if(getAssignmentcndn.taxp1 != 0 && getAssignmentcndn.arrem5 == "GSTBILLRATE" && getAssignmentcndn.arrem7 != 1){
                p_taxable = true;
            }
        }
        
                                          
		//setting the variables to be used in the template
		label = p_label;
		billRate = p_billRate; billQty = p_billQty; billAmt = p_billAmt;
		payRate = p_payRate; payQty = p_payQty; payAmt = p_payAmt;
		taxable = "FALSE";
		gstAmt = 0;

		//check for taxable items
		if(p_taxable){
				taxable = "TRUE";
				gstAmt = numberFormat(billAmt * (taxper/100),'.____');
		}
		lineTotal = numberFormat(gstAmt + billAmt,'.____');

		payTotal += p_payAmt;
		billTotal += p_billAmt;
		gstTotal += gstAmt;
		empTotal += lineTotal;

		if(p_billAmt != 0 OR p_payAmt != 0){
            if(totalrecord < recordlimit){
		      include 'PO_commonFieldscndn.cfm';
            }else{
                if(taxable == 'TRUE'){
                    taxperc = '#taxper#%';
                }else{
                    taxperc = '0';
                }
    
                queryaddrow(temp_query, {Branch:"#getassignmentcndn.branch#",
                PO:"#getassignmentcndn.po#",
                Candidate:"#getassignmentcndn.candidate#",
                ClientID:"#getassignmentcndn.clientID#",
                Company:"#getassignmentcndn.company#",
                Hiring_Mgr:"#getassignmentcndn.HM#",
                Billing_name:"#getassignmentcndn.billingName#",
                Order_Dept:"#getassignmentcndn.dept#",
                JO:"#getassignmentcndn.jo#",
                StartDate:"#getassignmentcndn.StartDate#",
                EndDate:"#getassignmentcndn.EndDate#",
                Acc_Period:"#getassignmentcndn.payrollperiod#",
                Bill_Item:"#p_label#",
                Bill_Qty:"#billQty#",
                Bill_Rate:"#billRate#",
                Bill_Amount:"#numberformat(billAmt,'.__')#",
                Pay_Qty:"#payQty#",
                Pay_Rate:"#payRate#",
                Pay_Amount:"#payAmt#",
                Taxable:"#Taxable#",
                Tax_Percentage:"#taxperc#",
                Tax_Amount:"#gstAmt#",
                Total_With_Tax:"#lineTotal#",
                Invoice_No:"#getassignmentcndn.refno#",
                Invoice_Issue:"#getassignmentcndn.invoiceIssue#",
                Invoice_Due:"#getassignmentcndn.invoiceDue#",
                Timesheet_Remarks:""
                });  
            }
		}

	}

	function getICShelfName(code){

		for(var i = 1; i <= getAllShelf.recordCount; i ++){
			if(getAllShelf["shelf"][i] == code)	{
				return getAllShelf['DESP'][i];
			}
		}

	   	return '';
	}
	//print total and reset fields
	function printTotal(){
        if(totalrecord < recordlimit){
		var outputStr = "<Row>";
		for(i = 0; i < 14; i++){
			outputStr &= "<Cell></Cell>";
		}
		outputStr &= "<Cell><Data ss:Type='String'>TOTAL : </Data></Cell>";

		outputStr &= "<Cell><Data ss:Type='Number'>"& billTotal &"</Data></Cell>";
		for(i = 0; i < 2; i++){
			outputStr &= "<Cell></Cell>";
		}
		outputStr &= "<Cell><Data ss:Type='Number'>"& payTotal &"</Data></Cell>";
		for(i = 0; i < 2; i++){
			outputStr &= "<Cell></Cell>";
		}
		outputStr &= "<Cell><Data ss:Type='Number'>"& gstTotal &"</Data></Cell>";
		outputStr &= "<Cell><Data ss:Type='Number'>"& empTotal &"</Data></Cell>";


		//CLOSING
		outputStr &= "</Row><Row></Row>";
            WriteOutput(outputStr);
        }else{
            queryaddrow(temp_query, {Branch:"",
                PO:"",
                Candidate:"",
                ClientID:"",
                Company:"",
                Hiring_Mgr:"",
                Billing_name:"",
                Order_Dept:"",
                JO:"",
                StartDate:"",
                EndDate:"",
                Acc_Period:"",
                Bill_Item:"",
                Bill_Qty:"",
                Bill_Rate:"TOTAL : ",
                Bill_Amount:"#numberformat(billTotal,'.__')#",
                Pay_Qty:"",
                Pay_Rate:"",
                Pay_Amount:"#numberformat(payTotal,'.__')#",
                Taxable:"",
                Tax_Percentage:"",
                Tax_Amount:"#gstTotal#",
                Total_With_Tax:"#empTotal#",
                Invoice_No:"",
                Invoice_Issue:"",
                Invoice_Due:"",
                Timesheet_Remarks:""
                });
                         
            queryaddrow(temp_query, {Branch:"",
                PO:"",
                Candidate:"",
                ClientID:"",
                Company:"",
                Hiring_Mgr:"",
                Billing_name:"",
                Order_Dept:"",
                JO:"",
                StartDate:"",
                EndDate:"",
                Acc_Period:"",
                Bill_Item:"",
                Bill_Qty:"",
                Bill_Rate:"",
                Bill_Amount:"",
                Pay_Qty:"",
                Pay_Rate:"",
                Pay_Amount:"",
                Taxable:"",
                Tax_Percentage:"",
                Tax_Amount:"",
                Total_With_Tax:"",
                Invoice_No:"",
                Invoice_Issue:"",
                Invoice_Due:"",
                Timesheet_Remarks:""
                });
        }

		grandPayTotal += payTotal;
		grandBillTotal += billTotal;
		grandGstTotal += gstTotal;
		grandEmpTotal += empTotal;

		payTotal = 0;
		billTotal = 0;
		gstTotal = 0;
		empTotal = 0;
		tempEmp = getAssignment.empno;
	}
</cfscript>
