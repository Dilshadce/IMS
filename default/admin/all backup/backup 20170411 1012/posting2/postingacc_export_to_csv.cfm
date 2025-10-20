<cfif export eq "Export">
<cfif isdefined('url.ubs') and lcase(hcomid) eq "hairo_i">
<cfquery name="updatetax" datasource="#dts#">
UPDATE glpost9ubs SET rem4 = "STAX" WHERE rem4 = "SR"
</cfquery>
<cfquery name="updatetax" datasource="#dts#">
UPDATE glpost91ubs SET rem4 = "STAX" WHERE rem4 = "SR"
</cfquery>
<cfquery name="updatetax" datasource="#dts#">
UPDATE glpost9ubs SET rem4 = "PTAX" WHERE rem4 = "TX7"
</cfquery>
<cfquery name="updatetax" datasource="#dts#">
UPDATE glpost91ubs SET rem4 = "PTAX" WHERE rem4 = "TX7"
</cfquery>
</cfif>

<!---fixics myob--->
<cfif lcase(hcomid) eq 'fixics_i'> 
<cfquery datasource='#dts#' name="getglpost9myob">
		select entry,reference,acc_code from glpost9
        group by reference,acc_code;
	</cfquery>
    <cfloop query="getglpost9myob">
    
    <cfquery datasource='#dts#' name="checkexist1myob">
		select a.name,a.frem1,a.frem2,a.frem3,a.frem4,a.frem5,b.taxincl,a.refno,a.wos_date,a.pono,b.brem3,b.brem4,b.desp,b.amt,b.taxamt,b.job,b.comment,a.agenno,b.note_a,a.currcode,b.currrate,b.disamt,a.cs_pm_cash,a.cs_pm_cheq,a.cs_pm_crcd,a.cs_pm_crc2,a.cs_pm_vouc,a.cs_pm_dbcd,a.deposit,a.checkno,a.custno from ictran as b
        left join (select * from artran)as a on a.refno=b.refno and a.type=b.type
        where a.refno='#getglpost9myob.reference#' and a.type='#getglpost9myob.acc_code#'
	</cfquery>
    
    <cfloop query="checkexist1myob">
    <cfquery datasource='#dts#' name="insertmyob">
		insert into myobpost (lastname,firstname,add1,add2,add3,add4,country,Inclusive,invoice,date,CustomerPO,ShipVia,DeliveryStatus,Description,account,Amount,TaxAmount,Job,Comment,JournalMemo,SalespersonLastName,SalespersonFirstName,ShippingDate,ReferralSource,TaxCode,NonGSTAmount,GSTAmount,FreightAmount,IncTaxFreightAmount,FreightTaxCode,FreightNonGSTAmount,FreightGSTAmount,SaleStatus,CurrencyCode,ExchangeRate,TermsPaymentisDue,DiscountDays,BalanceDueDays,Discountpercent,MonthlyCharge,AmountPaid,PaymentMethod,PaymentNotes,NameonCard,CardNumber,ExpiryDate,AuthorisationCode,AccountNumber,AccountName,ChequeNumber,Category,CardID,RecordID) 
        
        values 
        ('#checkexist1myob.name#','#checkexist1myob.frem1#','#checkexist1myob.frem2#','#checkexist1myob.frem3#','#checkexist1myob.frem4#','#checkexist1myob.frem5#','',<cfif checkexist1myob.taxincl eq 'T'>'X'<cfelse>''</cfif>,'#checkexist1myob.refno#','#dateformat(checkexist1myob.wos_date,'dd/mm/yyyy')#','#checkexist1myob.pono#','#checkexist1myob.brem3#','A','#checkexist1myob.desp#','#checkexist1myob.brem4#',<cfif checkexist1myob.taxincl eq 'T'>'#checkexist1myob.amt-checkexist1myob.taxamt#'<cfelse>'#checkexist1myob.amt#'</cfif>,<cfif checkexist1myob.taxincl eq 'T'>'#checkexist1myob.amt#'<cfelse>'#checkexist1myob.amt+checkexist1myob.taxamt#'</cfif>,'#checkexist1myob.job#','#tostring(checkexist1myob.comment)#','Sales;#checkexist1myob.name#','#checkexist1myob.agenno#','','','',<cfif checkexist1myob.note_a eq 'SR'>'GST'<cfelse>'N-T'</cfif>,'0.00','#checkexist1myob.taxamt#','','','GST','0.00','0.00','I','#checkexist1myob.currcode#','#checkexist1myob.currrate#','5','1','30','#checkexist1myob.disamt#','','#cs_pm_cash+cs_pm_cheq+cs_pm_crcd+cs_pm_crc2+cs_pm_vouc+cs_pm_dbcd+deposit#',<cfif checkexist1myob.cs_pm_cash neq '0'>'Cash'<cfelseif checkexist1myob.cs_pm_cheq neq '0'>'Cheque'<cfelseif checkexist1myob.cs_pm_crcd neq '0'>'Credit Card'<cfelseif checkexist1myob.cs_pm_crc2 neq '0'>'Credit Card'<cfelseif checkexist1myob.cs_pm_dbcd neq '0'>'Debit Card'<cfelseif checkexist1myob.deposit neq '0'>'Deposit'<cfelse>''</cfif>,'','','','','','','','#checkexist1myob.checkno#','','*None','#right(checkexist1myob.custno,3)#')
        
  
  
  
	</cfquery>
    </cfloop>
    
    </cfloop>

	<cfset folder = "/Download/"&dts&"/MYOB">
    <cfif not DirectoryExists(ExpandPath(folder))>
    <cfdirectory action="create" directory="#ExpandPath(folder)#" />
    </cfif>

    <cftry>
	<cffile action = "delete" file = "C:\\NEWSYSTEM\\IMS\Download\\#dts#\\MYOB\\SERVSALE.csv">
		
	<cfcatch type="any">
	</cfcatch>
	</cftry>
    
	<cfquery name="outfile" datasource="#dts#">		
		select * 
		into outfile 'C:\\NEWSYSTEM\\IMS\\Download\\#dts#\\MYOB\\SERVSALE.csv' 
		fields terminated by ',' 
		enclosed by '"' 
		lines terminated by '\r\n' 
		from myobpost;
	</cfquery>
    
</cfif>
<!--- --->

	<cfquery datasource='#dts#' name="checkexist1">
		select 
		entry 
		from glpost9<cfif isdefined('url.ubs')>ubs</cfif>;
	</cfquery>
	
	<cfquery datasource='#dts#' name="checkexist2">
		select 
		entry 
		from glpost91<cfif isdefined('url.ubs')>ubs</cfif>;
	</cfquery>
	
	<cfif checkexist1.recordcount eq 0 and checkexist2.recordcount eq 0>
		<h1>No Posted Record!</h1>
		<cfabort>
	</cfif>
    <cfset folder = "/Download/"&dts&"/ver9.0">
    <cfif not DirectoryExists(ExpandPath(folder))>
    <cfdirectory action="create" directory="#ExpandPath(folder)#" />
    </cfif>
    <cfset folder = "/Download/"&dts&"/ver9.1">
    <cfif not DirectoryExists(ExpandPath(folder))>
    <cfdirectory action="create" directory="#ExpandPath(folder)#" />
    </cfif>
	
	<!--- <cffile action = "delete" file = "C:\\NEWSYSTEM\\GLOBAL ECN\Download\\#dts#\\ver9.0\\glpost9.csv">
	<cffile action = "delete" file = "C:\\Inetpub\\wwwroot\\GLOBAL ECN\Download\\#dts#\\ver9.1\\glpost9.csv"> --->
	<cftry>
		<cffile action = "delete" file = "C:\\INEWSYSTEM\\IMS\Download\\#dts#\\ver9.0\\glpost9.csv">
		
	<cfcatch type="any">
	</cfcatch>
	</cftry>
	<cftry>
	<cffile action = "delete" file = "C:\\NEWSYSTEM\\IMS\Download\\#dts#\\ver9.1\\glpost9.csv">
	<cfcatch type="any">
	</cfcatch>
	</cftry>

	<cftry>
	<cffile action = "delete" file = "C:\\NEWSYSTEM\\IMS\Download\\#dts#\\ver9.0\\glpost91.csv">
	<cfcatch type="any">
	</cfcatch>
	</cftry>

	<cftry>
	<cffile action = "delete" file = "C:\\NEWSYSTEM\\IMS\Download\\#dts#\\ver9.1\\glpost91.csv">
	<cfcatch type="any">
	</cfcatch>
	</cftry>


	<cfoutput>
 	<cfscript>
	go_to = createObject("java", "java.lang.Thread");
	go_to.sleep(5000); //sleep time in milliseconds 
	</cfscript>
 	</cfoutput>	


	<!--- <cfquery name="outfile" datasource="#dts#">		
		select * 
		into outfile 'C:\\NEWSYSTEM\\GLOBAL ECN\\Download\\#dts#\\ver9.0\\glpost9.csv' 
		fields terminated by ',' 
		enclosed by '"' 
		lines terminated by '\r\n' 
		from glpost9;
	</cfquery> --->
	<cfquery name="getDefaultCurr" datasource="#dts#">
    SELECT bcurr from gsetup
    </cfquery>
    
	<cfquery name="outfile" datasource="#dts#">		
		select 
		`ENTRY`,`ACC_CODE`,`ACCNO`,`FPERIOD`,concat(day(DATE),'/',month(DATE),'/',right(year(DATE),2)) as DATE,`BATCHNO`,
		`TRANNO`,`VOUC_SEQ`,`VOUC_SEQ2`,`TTYPE`,`REFERENCE`,`REFNO`,
		`DESP`,`DESPA`,`DESPB`,`DESPC`,`DESPD`,`DESPE`,`TAXPEC`,
		`DEBITAMT`,`CREDITAMT`,`FCAMT`,`DEBIT_FC`,`CREDIT_FC`,`EXC_RATE`,
		`ARAPTYPE`,`AGE`,`SOURCE`,`JOB`,`SUBJOB`,`POSTED`,`EXPORTED`,`EXPORTED1`,`EXPORTED2`,`EXPORTED3`,
		`REM1`,`REM2`,`REM3`,`REM4`,`REM5`,`RPT_ROW`,`AGENT`,`STRAN`,`TAXPUR`,`PAYMODE`,`TRDATETIME`,
		`CORR_ACC`,`ACCNO2`,`ACCNO3`,`DATE2`,`USERID`,`TCURRCODE`,`TCURRAMT`,`BPERIOD`,`BDATE`,`VPERIOD` 
		into outfile 'C:\\NEWSYSTEM\\IMS\\Download\\#dts#\\ver9.0\\glpost9.csv' 
		fields terminated by ',' 
		enclosed by '"' 
		lines terminated by '\r\n' 
		from glpost9<cfif isdefined('url.ubs')>ubs</cfif>;
	</cfquery>
	
	<!--- <cfquery name="outfile" datasource="#dts#">		
		select * 
		into outfile 'C:\\Inetpub\\wwwroot\\GLOBAL ECN\\Download\\#dts#\\ver9.1\\glpost9.csv' 
		fields terminated by ',' 
		enclosed by '"' 
		lines terminated by '\r\n' 
		from glpost91;
	</cfquery> --->
	
	<cfquery name="outfile" datasource="#dts#">		
		select 
		`ENTRY`,`ACC_CODE`,`ACCNO`,`FPERIOD`,concat(day(DATE),'/',month(DATE),'/',right(year(DATE),2)) as DATE,`BATCHNO`,
		`TRANNO`,`VOUC_SEQ`,`VOUC_SEQ2`,`TTYPE`,`REFERENCE`,`REFNO`,
		`DESP`,`DESPA`,`DESPB`,`DESPC`,`DESPD`,`DESPE`,`TAXPEC`,`DEBITAMT`,`CREDITAMT`,
		`FCAMT`,`DEBIT_FC`,`CREDIT_FC`,`EXC_RATE`,`ARAPTYPE`,`AGE`,`SOURCE`,`JOB`,`JOB2`,`SUBJOB`,`JOB_VALUE`,`JOB_VALUE2`,
		`POSTED`,`EXPORTED`,`EXPORTED1`,`EXPORTED2`,`EXPORTED3`,`REM1`,`REM2`,`REM3`,`REM4`,`REM5`,
		`RPT_ROW`,`AGENT`,`STRAN`,`TAXPUR`,`PAYMODE`,`TRDATETIME`,`CORR_ACC`,`ACCNO2`,`ACCNO3`,`DATE2`,
		`USERID`,`TCURRCODE`,`TCURRAMT`,`BPERIOD`,`BDATE`,`VPERIOD` 
		into outfile 'C:\\NEWSYSTEM\\IMS\\Download\\#dts#\\ver9.1\\glpost9.csv' 
		fields terminated by ',' 
		enclosed by '"' 
		lines terminated by '\r\n' 
		from glpost91<cfif isdefined('url.ubs')>ubs</cfif>;
	</cfquery>
	
	<cfquery name="deletepreviouspost" datasource="#dts#">
		truncate glpost9<cfif isdefined('url.ubs')>ubs</cfif>
	</cfquery>
	
	<cfquery name="deletepreviouspost" datasource="#dts#">
		truncate glpost91<cfif isdefined('url.ubs')>ubs</cfif>
	</cfquery>
	<h1>You have exported the transaction successfully.</h1>
    <cfabort >	
</cfif>