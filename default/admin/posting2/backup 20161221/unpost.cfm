      <cfset nowuuid = createuuid()>
        <cfset comlist = "svcmm_i,svcnvn_i,svctm_i,svcyr_i,svcdm_i,svcbd_i,svcnv_i">
    <cfif listfindnocase(comlist,hcomid) neq 0 >
    <cfset hlinkams = "Y">
	</cfif>
<html>
<head>
<title>Post to UBS System</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
 <script type="text/javascript">
 <cfoutput>
 function updatepercent()
{
	try{
ajaxFunction(document.getElementById('ajaxcontrol'),'checkpost.cfm?uuid=#nowuuid#');
setTimeout('updatepercent();',1000);
	}
	catch(err)
	{
	}
}
</cfoutput>
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
        </script>
</head>

<cfparam name = "typesubmit" default = "">
<cfparam name = "unpost" default = "">
<cfparam name = "posttype" default = "">
<cfparam name = "sort" default = "">

<cfquery name="getaccno" datasource="#dts#">
	select 
	* 
	from gsetup;
</cfquery>

<body>

<!--- <h4>
	<a href="postingacc.cfm?status=UNPOSTED">View Accounting Post Menu</a> 
</h4> --->

<h1 align="center"><a href="ending">Unpost Bill</a></h1>
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
</cfoutput>
<!--- FORM FILTER --->
<cfinclude template="unpost_form_filter.cfm">
<!--- TRANSACTION SELECTION --->
<cfinclude template="unpost_transaction_selection.cfm">
<h3><label id="message"></label></h3>
<cfoutput>

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
		<!--- <cfif lcase(HcomID) eq "probulk_i"> --->		<!--- Add On 05-01-2010 --->
			<th>Project</th>
			<th>Job</th>
		<!--- </cfif> --->
	</tr>
	
	<cfset cnt = gettran.recordcount>
    <cfset xaccno="">
	
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
		
		<cfif getcode.result neq "">
			<cfset code = getcode.result>
		<cfelse>
			<cfset code = "">
		</cfif>
        
        <cfif Hlinkams eq "Y">
		
		<cfquery name="getbatchdetail" datasource="#dts#">
        SELECT recno,lokstatus 
        FROM <cfif listfindnocase(comlist,LCASE(hcomid)) neq 0 >ssa0804_a<cfelse>#replace(LCASE(dts),"_i","_a","all")#</cfif>.glbatch WHERE lokstatus = "0"
        </cfquery>
		
        <cfquery name="getlocktran" datasource="#dts#">
        select reference,acc_code from <cfif listfindnocase(comlist,LCASE(hcomid)) neq 0 >ssa0804_a<cfelse>#replace(LCASE(dts),"_i","_a","all")#</cfif>.glpost where 
        reference in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(gettran.refno)#" list="yes" separator=",">) 
        and batchno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getbatchdetail.recno)#" list="yes" separator=",">) 
        and acc_code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#gettran.type#"> 
        </cfquery>
        </cfif>
        
        <cfif gettran.recordcount neq 0 and isdefined('form.isuuid') >
        
        <cfquery name="insertinto" datasource="#dts#">
        INSERT INTO postlog
        (
        action,
        billtype,
        actiontype,
        actiondata,
        user,
        timeaccess
        )
        VALUES
        (
        "Pre-Unpost",
        "#gettran.type#",
        "1",
        "#gettran.recordcount#-#form.isuuid#",
        "#getauthuser()#",
        now()
        )
        </cfquery>
        
        <cfquery name="getlastid" datasource="#dts#">
        SELECT LAST_INSERT_ID() as lastid
        </cfquery>
        
        <cfset getuuid = getlastid.lastid>
       
        
        </cfif>
		<cfloop query="gettran" startrow="1" endrow="#cnt#">
        
        <cfquery name="getglpostdetail" datasource="#replace(LCASE(dts),"_i","_a","all")#">
        	SELECT * FROM glpost
            WHERE
            reference=<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettran.refno#">
            AND acc_code=<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettran.type#">
        </cfquery>
        
        <cfif getglpostdetail.recordcount neq 0>
        <cfloop query="getglpostdetail">
        <tr>
		<td>#gettran.type#</td>
		<td>#getglpostdetail.reference#</td>
		<td>#dateformat(getglpostdetail.date,"dd/mm/yyyy")#</td>
		<td><div align="right">#numberformat(getglpostdetail.debitamt,".__")#</div></td>
		<td><div align="right">#numberformat(getglpostdetail.creditamt,".__")#</div></td>
		<td><div align="left">#getglpostdetail.rem4#
		</div></td>
		<td>#getglpostdetail.fperiod#</td>
		<td>#getglpostdetail.accno#</td>
		<td><cfif getglpostdetail.debitamt eq 0>Cr<cfelse>D</cfif></td>
		<td nowrap>#getglpostdetail.desp#</td>
		<td nowrap>#getglpostdetail.source#</td>
		<td nowrap>#getglpostdetail.job#</td>
		</tr>	
        </cfloop>
        
        <cfelse>
			<!--- MASTER RECORD --->
			<cfinclude template = "unpost_master_record.cfm">
			<!--- ARTRAN MISC --->
			<cfinclude template = "unpost_misc.cfm">
			<!--- ARTRAN CASH --->
			<cfinclude template = "unpost_cash.cfm">
			<!--- ARTRAN CHEQUE --->
			<cfinclude template = "unpost_cheque.cfm">
			<!--- ARTRAN CREDIT CARD 1 --->
			<cfinclude template = "unpost_credit_card1.cfm">
			<!--- ARTRAN CREDIT CARD 2 --->
			<cfinclude template = "unpost_credit_card2.cfm">
			<!--- ARTRAN VOUCHER --->
			<cfinclude template = "unpost_voucher.cfm">
			<!--- ARTRAN DEPOSIT --->
			<cfinclude template = "unpost_deposit.cfm">
			<!--- DETAIL RECORD --->
			<cfinclude template = "unpost_detail_record.cfm">
            
            <cfif wpitemtax eq "Y">
                <!--- WITH PER ITEM TAX --->
                <!--- <cfinclude template = "unpost_with_per_item_tax.cfm"> --->
			<cfelse>
				<!--- TAX INCLUDED --->
                <cfif getartran.taxincl eq "T" and val(getaccno.gst) neq 0 and (xaccno neq "" and xaccno neq "0000/000")>
                    <cfinclude template = "unpost_tax_included.cfm">
                </cfif>
                <!--- DEFAULT TAX --->
                <cfif getartran.taxincl neq "T" and getartran.tax neq 0 and getartran.tax neq "">
                    <cfinclude template = "unpost_tax_default.cfm">
                </cfif>
			</cfif>
			<!--- DISCOUNT --->
			<cfif val(getartran.disc1_bil) neq 0 or val(getartran.discount) neq 0>
				<cfinclude template = "unpost_discount.cfm">
			</cfif>
            <!--- NBT, ADD ON 27-07-09 --->
            <cfif lcase(hcomid) eq "mhsl_i" and getartran.type eq "RC" and val(getartran.taxnbt) neq 0>
				<cfinclude template = "unpost_nbt.cfm">
			</cfif>
			<!--- CLEAR TEMPARARY REORD --->
			<cfquery name = "deltemp" datasource = "#dts#">
				truncate temptrx;
			</cfquery>
		</cfif>
		</cfloop>
	</cfif>
</table>

<a name="ending">Total of Transactions: </a>#gettran.recordcount#

<!--- UNPOST PROCESS --->
<cfinclude template="unpost_process.cfm">
<cfif unpost eq "unpost">
<cfquery name="insertlog" datasource="#dts#">
    INSERT INTO postlog (action,billtype,actiondata,user,timeaccess)
    VALUES
    ("Unpost","#form.posttype#","#valuelist(gettran.refno)#","#huserid#",now())
    </cfquery>
</cfif>
</cfoutput>

</body>
</html>

<cfwindow name="processing" width="300" height="300" initshow="false" center="true" closable="false" draggable="false" title="Processing....Please Wait" modal="true" resizable="false" >
<h1>Processing....Please Wait</h1>
<img src="/images/loading.gif" align="middle" />
<h3>WARNING : Running Posting will cause system to be slow for other users.</h3>
<div id="ajaxcontrol"></div>
</cfwindow>