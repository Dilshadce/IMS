<html>
<head>
<title>Post to UBS System</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<script language=javascript>function CallPrint(strid){ var prtContent = document.getElementById(strid); var WinPrint = window.open('','','letf=0,top=0,fullscreen=1,toolbar=0,scrollbars=0,status=0'); WinPrint.document.write(prtContent.innerHTML); WinPrint.document.close(); WinPrint.focus(); WinPrint.print(); WinPrint.close(); prtContent.innerHTML=strOldOne;}</script>
        <script type="text/javascript">
		function checkrequired1()
		{
		var datefrom = document.getElementById('datefrom').value;
		var dateto = document.getElementById('dateto').value;
		if (datefrom != "" && dateto != "")
		{
		document.getElementById('submit').disabled = false;
		}
		else
		{
		document.getElementById('submit').disabled = true;
		}
		}
		
		function checkrequired2()
		{
		var period = document.getElementById('period').value;
		
		if (period != "" )
		{
		document.getElementById('submit2').disabled = false;
		}
		else
		{
		document.getElementById('submit2').disabled = true;
		}
		}
		
		function checkrequired3()
		{
		var billnofrom = document.getElementById('billnofrom').value;
		var billnoto = document.getElementById('billnoto').value;
		if (billnofrom != "" && billnoto != "")
		{
		document.getElementById('submit3').disabled = false;
		}
		else
		{
		document.getElementById('submit3').disabled = true;
		}
		}
		
			function checkrequired4()
		{
		var custnofrom = document.getElementById('custnofrom').value;
		var custnoto = document.getElementById('custnoto').value;
		if (custnofrom != "" && custnoto != "")
		{
		document.getElementById('submit4').disabled = false;
		}
		else
		{
		document.getElementById('submit4').disabled = true;
		}
		}

				function checkrequired5()
		{
		var billno2from = document.getElementById('billno2from').value;
		var billno2to = document.getElementById('billno2to').value;
		if (billno2from != "" && billno2to != "")
		{
		document.getElementById('submit5').disabled = false;
		}
		else
		{
		document.getElementById('submit5').disabled = true;
		}
		}
        </script>
        
        
        
     
</head>

<cfparam name = "typesubmit" default = "">
<cfparam name = "post" default = "">
<cfparam name = "posttype" default = "">
<cfparam name = "export" default = "">
<cfparam name = "sort" default = "">
<cfparam name = "noaccno" default = "">

<cfset uuid = createuuid()>

<cfquery name = "getaccno" datasource = "#dts#">
	select * from gsetup;
</cfquery>

<cfquery name = "getmodulecontrol" datasource = "#dts#">
	select * from modulecontrol;
</cfquery>

<body>

<!--- <h4>
	<a href="postingacc.cfm?status=UNPOSTED">View Accounting Post Menu</a>
</h4> --->

<h1 align="center"><a href="#ending">Accounting<cfif isdefined('url.ubs')> UBS</cfif> Post Menu</a></h1>

<cfoutput>
<h3 align="center">
	<a href="postingacc.cfm?status=Unposted<cfif isdefined('url.ubs')>&ubs=yes</cfif>">Unposted Transaction</a>&nbsp;
    <cfif getpin2.h5610 eq 'T'>
    || <a href="postingacc.cfm?status=Posted<cfif isdefined('url.ubs')>&ubs=yes</cfif>">Posted Transaction</a> 
    </cfif>
    <cfif getpin2.h5620 eq 'T'>
    || <a href="postingcheck.cfm<cfif isdefined('url.ubs')>?ubs=yes</cfif>">Posting Check</a> 
    </cfif>
    || 
	<cfif Hlinkams neq "Y" or isdefined('url.ubs')>
		<a href="..\..\..\download\#dts#\ver9.0\glpost9.csv" target="_blank">Download Exported File Accounting Ver 9.0</a> || 
		<a href="..\..\..\download\#dts#\ver9.1\glpost9.csv" target="_blank">Download Exported File Accounting Ver 9.1</a> ||
	</cfif>
    
    <cfif lcase(hcomid) eq 'fixics_i'> 
		<a href="..\..\..\download\#dts#\MYOB\SERVSALE.csv" target="_blank">Download Exported File MYOB</a> ||
	</cfif>
    
    <cfif getpin2.h5630 eq 'T'>
	<a href="glpost.cfm<cfif isdefined('url.ubs')>?ubs=yes</cfif>">List Not Exported</a> </cfif>
    <cfif getpin2.h5640 eq 'T'>|| 
	<a href="unpost.cfm<cfif isdefined('url.ubs')>?ubs=yes</cfif>">Unpost Bill</a>
    </cfif>
    <cfif getpin2.h5650 eq 'T'>
	<cfif Hlinkams eq "Y"  and isdefined('url.ubs') eq false>
		|| <a href="import_to_ams.cfm"><i>Import To AMS</i></a>
	</cfif>
    </cfif>
</h3>

<h3>Status : #status#</h3>

<!--- FORM FILTER --->
<cfinclude template = "postingacc_form_filter.cfm">
<!--- TRANSACTION SELECTION --->
<cfinclude template = "postingacc_transaction_selection.cfm">
<!--- EXPORT TO CSV --->
<cfinclude template = "postingacc_export_to_csv.cfm">
<cfinclude template="postingacc_process.cfm">
<h3><label id="message"></label></h3>
<div id="print_div">
<cfset totdebit = 0>
        <cfset totcredit = 0>
<table class="data" width="100%">
	<tr>
		<th>Type</th>
		<th>Reference No</th>
        <cfif lcase(hcomid) eq "leadbuilders_i"><th>Reference No 2</th></cfif>
		<th>Date</th>
		<th>Debit Amount</th>
		<th>Credit Amount</th>
		<th>GST/Disc</th>
		<th>Period</th>
		<th>Account</th>
		<th>Column</th>
		<th>Customer</th>
        <th>Agent</th>
		<!--- <cfif lcase(HcomID) eq "probulk_i"> --->		<!--- Add On 05-01-2010 --->
			<th>Project</th>
			<th>Job</th>
		<!--- </cfif> --->
	</tr>
	
	<cfset cnt = gettran.recordcount>
	
	<cfif gettran.recordcount gt 0>
		<cfset ptype = target_arcust>
        
        <!--- ADD ON 03-08-2009 --->
		<cfset wpitemtax="">
        <cfif getaccno.wpitemtax eq "1">
            <cfif getaccno.wpitemtax1 neq "">
                <cfif ListFindNoCase(getaccno.wpitemtax1, gettran.type, ",") neq 0>
                    <cfset wpitemtax = "Y">
                </cfif>
            <cfelse>
                <cfset wpitemtax="Y">
            </cfif>
        </cfif>
        <cfset ppts = "">
        <cfif getaccno.PPTS eq "Y">
        <cfset ppts = "Y">
        <!---<cfset wpitemtax="Y">--->
		</cfif>
		
		<cfswitch expression="#trim(gettran.type)#">
			<cfcase value="RC">
				<cfset getacc = "purc">
				<cfset getcode = "rccode">
				<cfset billtype = "Purchase Receive">
				<cfset ptype = target_apvend>
			</cfcase>
			<cfcase value="INV">
				<cfset getacc = "salec">
				<cfset getcode = "invcode">
				<cfset billtype = "Invoice">
			</cfcase>
			<cfcase value="CN">
				<cfset getacc = "salecnc">
				<cfset getcode = "cncode">
				<cfset billtype = "Credit Note">
			</cfcase>
			<cfcase value="DN">
				<cfset getacc = "salec">
				<cfset getcode = "dncode">
				<cfset billtype = "Debit Note">
			</cfcase>
			<cfcase value="CS">
				<cfset getacc = "salecsc">
				<cfset getcode = "cscode">
				<cfset billtype = "Cash Sales">
			</cfcase>
			<cfcase value="PR">
				<cfset getacc = "purprc">
				<cfset getcode = "prcode">
				<cfset billtype = "Purchase Return">
				<cfset ptype = target_apvend>
			</cfcase>
		</cfswitch>
		
		<cfquery name="getcode" datasource="#dts#">
			select 
			#getcode# as result 
			from gsetup;
		</cfquery>
        <cfquery name="getprefix" datasource="#dts#">
            select refnocode as prefix 
            from refnoset
            where type='#gettran.type#'
            and counter='1'
        </cfquery>
		
		<cfif getcode.result neq "">
        <cfset getcode.result = getprefix.prefix>
			<cfset code = getcode.result>
		<cfelse>
			<cfset code = "">
		</cfif>
		<cfset refnobill = "">
        
        <!---Cash Sales Not Tally--->
        <cfif wpitemtax eq "Y" and trim(gettran.type) eq "CS">
        <cfquery name="updateinvgross" datasource="#dts#">
        	update artran set gross_bil=grand_bil-tax_bil+disc_bil-roundadj-mc1_bil-mc2_bil-mc3_bil-mc4_bil-mc5_bil-mc6_bil-mc7_bil,invgross=grand-tax+discount-roundadj-m_charge1-m_charge2-m_charge3-m_charge4-m_charge5-m_charge6-m_charge7 where type="CS"
            AND gross_bil<>grand_bil-tax_bil+disc_bil-roundadj-mc1_bil-mc2_bil-mc3_bil-mc4_bil-mc5_bil-mc6_bil-mc7_bil
        </cfquery>
        </cfif>
        
        <cfif getaccno.locproject eq "Y">
        <cfquery name="getlocationproject" datasource="#dts#">
        	SELECT source,location FROM iclocation
        </cfquery>
        
        <cfloop query="getlocationproject">
        <cfquery name="updatelocationproject" datasource="#dts#">
        	UPDATE ictran SET 
            source=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getlocationproject.source#">
            WHERE
            location=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getlocationproject.location#">
            and fperiod<>"99" and (void="" or void is null)
        </cfquery>
        
        </cfloop>
        
        </cfif>
        
        <!---end Cash Sales Not Tally--->
        
		<cfloop query="gettran" startrow="1" endrow="#cnt#">
			<!--- MASTER RECORD --->
			<cfinclude template = "posting_acc_master_record.cfm">
			<!--- ARTRAN MISC --->
			<cfinclude template = "posting_acc_misc.cfm">
			<!--- ARTRAN CASH --->
			<cfinclude template = "posting_acc_cash.cfm">
			<!--- ARTRAN CHEQUE --->
			<cfinclude template = "posting_acc_cheque.cfm">
			<!--- ARTRAN CREDIT CARD 1 --->
			<cfinclude template = "posting_acc_credit_card1.cfm">
			<!--- ARTRAN CREDIT CARD 2 --->
			<cfinclude template = "posting_acc_credit_card2.cfm">
            <!--- ARTRAN DEBIT CARD --->
			<cfinclude template = "posting_acc_debit_card.cfm">
			<!--- ARTRAN VOUCHER --->
			<cfinclude template = "posting_acc_voucher.cfm">
			<!--- ARTRAN DEPOSIT --->
			<cfinclude template = "posting_acc_deposit.cfm">
            <!--- ARTRAN ROUNDING --->
			<cfinclude template = "posting_acc_rounding.cfm">
			<!--- DETAIL RECORD --->
			<cfinclude template = "posting_acc_detail_record.cfm">
            
            <cfif getartran.postingtaxexcl neq "T">
			<cfif wpitemtax eq "Y">
                <!--- WITH PER ITEM TAX --->
               	<!---  <cfinclude template = "posting_acc_with_per_item_tax.cfm"> --->
			<cfelse>
				<!--- TAX INCLUDED --->
                <cfif isdefined('xaccno')>
                <cfif getartran.taxincl eq "T" <!--- and val(getaccno.gst) neq 0 ---> and (xaccno neq "" and xaccno neq "0000/000")>
                    <cfinclude template = "posting_acc_tax_included.cfm">
                </cfif>
                </cfif>
                <!--- DEFAULT TAX --->
                <cfif getartran.taxincl neq "T" and getartran.tax neq 0 and getartran.tax neq "">
                    <cfinclude template = "posting_acc_tax_default.cfm">
                </cfif>
			</cfif>
            </cfif>
            
			<!--- DISCOUNT --->
			<cfif val(getartran.disc1_bil) neq 0 or val(getartran.discount) neq 0>
            <cfif getartran.type eq "RC" or getartran.type eq "PR">
			<cfset xaccno = getaccno.discpur>
			<cfelse>
            <cfset xaccno = getaccno.discsales>
            </cfif>
            <cfif xaccno neq "" and xaccno neq "0000/000">
				<cfinclude template = "posting_acc_discount.cfm">
			</cfif>
			</cfif>
            <!--- NBT, ADD ON 27-07-09 --->
            <cfif lcase(hcomid) eq "mhsl_i" and getartran.type eq "RC" and val(getartran.taxnbt) neq 0>
				<cfinclude template = "posting_acc_nbt.cfm">
			</cfif>
            
            <!---Calculate and display--->
            <cfinclude template = "posting_acc_calculate_display.cfm">
            <!--- --->
            
			<!--- CLEAR TEMPARARY REORD --->
<!--- <cfif lcase(huserid) neq "ultracai" and lcase(huserid) neq "ultralung"> --->
			<cfquery name = "deltemp" datasource = "#dts#">
				truncate temptrx;
			</cfquery> 
<!--- </cfif> --->
            
		</cfloop>
	</cfif>
    <cfif Hlinkams eq "Y" and isdefined('url.ubs') eq false>
    <cfquery name="updatedespe" datasource="#dts#">
    update glpost91 as a,#replacenocase(LCASE(dts),"_i","_a","all")#.gldata as b SET a.despe = b.desp where a.accno = b.accno
    </cfquery>
    <cfquery name="updatedespe" datasource="#dts#">
    update glpost9 as a,#replacenocase(LCASE(dts),"_i","_a","all")#.gldata as b SET a.despe = b.desp where a.accno = b.accno
    </cfquery>
    </cfif>
    <tr>
    <td></td>
    <td></td>
    <cfif lcase(hcomid) eq "leadbuilders_i"><td></td></cfif>
    <th>Total:</th>
    <th align="right"><div align="right">#numberformat(val(totdebit),'.__')#</div></th>
    <th align="right"><div align="right">#numberformat(val(totcredit),'.__')#</div></th>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    </tr>
</table>
</div>
<a name="ending">Total of Transactions: #gettran.recordcount#</a>
<cfif noaccno neq "">
	<script language="javascript" type="text/javascript">
		showMessage();
		
		function showMessage(){
			document.getElementById('message').innerHTML = "Attention!!!  One or More Record(s) No Assigned Account Number!!!  You Are Not Allowed to Proceed!!";
			document.getElementById('post').disabled=true;
		}
	</script>
</cfif>

<cfif numberformat(totcredit,'.__') neq numberformat(totdebit,'.__')>
<script language="javascript" type="text/javascript">
		showMessage2();
		
		function showMessage2(){
			document.getElementById('message').innerHTML = "Attention!!! Total Debit and Credit is not same.  You Are Not Allowed to Proceed!!";
			<!--- document.getElementById('post').disabled=true; --->
		}
	</script>
</cfif>

</cfoutput>
<cfif post eq "post" and getaccno.APCWP eq "Y">
<script language="javascript" type="text/javascript">
function popup(url) 
{

 newwin=window.open(url,'checkpost','width='+screen.width+'height='+screen.height+', top=0, left=0, status=yes,menubar=no , scrollbars = yes, fullscreen=yes');
 if (window.focus) {newwin.focus()}
 return false;
}
popup('postingcheck.cfm<cfif isdefined('url.ubs')>?ubs=yes</cfif>');

</script>
</cfif>
<cfif post eq "post">
<cfquery name="insertlog" datasource="#dts#">
    INSERT INTO postlog (action,billtype,actiondata,user,timeaccess)
    VALUES
    ("Post","#form.posttype#","#valuelist(gettran.refno)#","#huserid#",now())
    </cfquery>
</cfif>
<cfwindow name="processing" width="300" height="300" initshow="false" center="true" closable="false" draggable="false" title="Processing....Please Wait" modal="true" resizable="false" >
<h1>Processing....Please Wait</h1>
<img src="/images/loading.gif" align="middle" />
<h3>WARNING : Running Posting will cause system to be slow for other users.</h3>
</cfwindow>
</body>
</html>