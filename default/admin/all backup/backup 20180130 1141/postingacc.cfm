<html>
<head>
<title>Post to UBS System</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfparam name = "typesubmit" default = "">
<cfparam name = "post" default = "">
<cfparam name = "posttype" default = "">
<cfparam name = "export" default = "">
<cfparam name = "sort" default = "">

<cfquery name = "getaccno" datasource = "#dts#">
	select 
	* 
	from gsetup;
</cfquery>

<body>

<h4>
	<a href="posting.cfm">View Posting Main Menu</a> || 
	<a href="postingacc.cfm?status=UNPOSTED">View Accounting Post Menu</a>
</h4>

<h1 align="center"><a href="#ending">Accounting Post Menu</a></h1>

<cfoutput>
<h3 align="center">
	<a href="postingacc.cfm?status=Unposted">Unposted Transaction</a>&nbsp;|| 
	<a href="postingacc.cfm?status=Posted">Posted Transaction</a> || 
	<a href="..\..\download\#dts#\ver9.0\glpost9.csv">Download Exported File Accounting Ver 9.0</a> || 
	<a href="..\..\download\#dts#\ver9.1\glpost9.csv">Download Exported File Accounting Ver 9.1</a> || 
	<a href="glpost.cfm">List Not Exported</a> || 
	<a href="unpost.cfm">Unpost Bill</a>
	<cfif Hlinkams eq "Y">
		|| <a href="import_to_ams.cfm"><i>Import To AMS</i></a>
	</cfif>
</h3>

<h3>Status : #status#</h3>

<!--- FORM FILTER --->
<cfinclude template = "postingacc_form_filter.cfm">
<!--- TRANSACTION SELECTION --->
<cfinclude template = "postingacc_transaction_selection.cfm">
<!--- EXPORT TO CSV --->
<cfinclude template = "postingacc_export_to_csv.cfm">

<table class="data" width="100%">
	<tr>
		<th>Type</th>
		<th>Reference No</th>
		<th>Date</th>
		<th>Debit Amount</th>
		<th>Credit Amount</th>
		<th>GST/Disc</th>
		<th>Period</th>
		<th>Account</th>
		<th>Column</th>
		<th>Customer</th>
	</tr>
	
	<cfset cnt = gettran.recordcount>
	
	<cfif gettran.recordcount gt 0>
		<cfset ptype = target_arcust>
		
		<cfswitch expression="#gettran.type#">
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
		
		<cfif getcode.result neq "">
			<cfset code = getcode.result>
		<cfelse>
			<cfset code = "">
		</cfif>

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
			<!--- ARTRAN VOUCHER --->
			<cfinclude template = "posting_acc_voucher.cfm">
			<!--- ARTRAN DEPOSIT --->
			<cfinclude template = "posting_acc_deposit.cfm">
			<!--- DETAIL RECORD --->
			<cfinclude template = "posting_acc_detail_record.cfm">
			<!--- TAX INCLUDED --->
			<cfif getartran.taxincl eq "T" and val(getaccno.gst) neq 0 and (xaccno neq "" and xaccno neq "0000/000")>
				<cfinclude template = "posting_acc_tax_included.cfm">
			</cfif>
			<!--- DEFAULT TAX --->
			<cfif getartran.tax neq 0 and getartran.tax neq "">
				<cfinclude template = "posting_acc_tax_default.cfm">
			</cfif>
			<!--- DISCOUNT --->
			<cfif val(getartran.disc1_bil) neq 0 or val(getartran.discount) neq 0>
				<cfinclude template = "posting_acc_discount.cfm">
			</cfif>
			<!--- CLEAR TEMPARARY REORD --->
			<cfquery name = "deltemp" datasource = "#dts#">
				truncate temptrx;
			</cfquery>  
		</cfloop>
	</cfif>
</table>

<a name="ending">Total of Transactions: #gettran.recordcount#</a>

<cfinclude template="postingacc_process.cfm">

</cfoutput>

</body>
</html>