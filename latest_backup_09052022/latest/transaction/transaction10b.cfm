
<cfquery name="getgeneral" datasource="#dts#">
	select printoption,voucher,voucherbal,voucherb4disc,crcdtype,voucherasdisc from gsetup;
</cfquery>
<!--- ADD ON 27-07-2009 --->
<cfif getgeneral.voucher eq "Y" and (tran eq "INV" or tran eq "DO" or tran eq "CN" or tran eq "SO" or tran eq "CS")>
<cfquery name="reversevoucher" datasource="#dts#">
SELECT Voucher,wos_date From artran where type='#tran#' and refno='#nexttranno#';
</cfquery>
<cfif reversevoucher.voucher neq "">
<cfquery name="updatevoucher" datasource="#dts#">
update voucher set used = "N",updated_by ="#HuserId#",updated_on = now() where voucherno = "#reversevoucher.voucher#"
</cfquery>
<cfif getgeneral.voucherbal eq "Y">
<cfquery name="updatevoucher" datasource="#dts#">
delete from vouchertran WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#nexttranno#"> and type = '#tran#'
</cfquery>
</cfif>
</cfif>
</cfif>

<cfquery datasource="#dts#" name="updateartran">
  	Update artran set 
   <cfif getgeneral.voucher eq "Y" and (tran eq "INV" or tran eq "DO" or tran eq "CN" or tran eq "SO" or tran eq "CS")>
    voucher=<cfif form.gift_voucher neq 0>'#form.vouchernum#'<cfelseif getgeneral.voucherasdisc eq 'Y'>'#form.vouchernum#'<cfelse>''</cfif>,
    </cfif> 
	<!--- multipayment mode --->
	deposit='#val(form.deposit)#',
	cs_pm_cash='#val(form.cash)#',
	cs_pm_cheq='#val(form.cheque)#',
	cs_pm_crcd='#val(form.credit_card1)#',
    cs_pm_dbcd='#val(form.Debit_card)#',
    <cfif lcase(hcomid) eq "manhattan_i" or lcase(hcomid) eq "elmanhattan_i">
    creditcardtype1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.creditcardtype1#">,
    creditcardtype2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.creditcardtype2#">,
    <cfelse>
    <cfif getgeneral.crcdtype eq 'Y'>
    <cfif isdefined('form.creditcardtype1')>
    creditcardtype1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.creditcardtype1#">,
    </cfif>
    <cfif  isdefined('form.creditcardtype2')>
    creditcardtype2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.creditcardtype2#">,
    </cfif>
    </cfif>
    </cfif>
	cs_pm_crc2='#val(form.credit_card2)#',
	cs_pm_vouc='#val(form.gift_voucher)#',
	cs_pm_debt='#val(form.debt)#'
	<cfif (lcase(hcomid) eq "ecraft_i" or lcase(hcomid) eq "ovas_i") and (tran eq 'PO' or tran eq "RC" or tran eq "PR")>
		cs_pm_tt='#val(form.telegraph_transfer)#',
	</cfif>
	<!--- multipayment mode --->
	<!--- tax already included --->
    <cfif isdefined('form.checkno')>
    	,checkno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.checkno#" >
	</cfif>
    <cfif (lcase(hcomid) eq "polypet_i") and (tran eq 'CS')>
    	,checkno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.checkno#" >
        ,cs_pm_cashCD = '#val(cashCD)#'
    </cfif>
	where type='#tran#' and refno='#nexttranno#';
</cfquery>

<cfif getgeneral.voucher eq "Y" and (tran eq "INV" or tran eq "DO" or tran eq "CN" or tran eq "SO" or tran eq "CS")>
<cfif getgeneral.voucherbal eq "Y">
<cfquery name="insertvouchertran" datasource="#dts#">
INSERT INTO vouchertran (voucherno,usagevalue,wos_date,refno,type,created_by,created_on)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.vouchernum#">,
<cfif tran eq "CN">
<cfif getgeneral.voucherbal eq "Y">
"#val(form.subtotal)*-1#",
<cfelse>
"#val(form.gift_voucher)*-1#",
</cfif>
<cfelse>
<cfif getgeneral.voucherbal eq "Y">
"#val(form.subtotal)#",
<cfelse>
"#form.gift_voucher#",
</cfif>
</cfif>
"#dateformat(reversevoucher.wos_date,'YYYY-MM-DD')#",
<cfqueryparam cfsqltype="cf_sql_varchar" value="#nexttranno#">,
'#tran#',
'#huserid#',
now()
)
</cfquery>

<cfquery name="checkfull" datasource="#dts#">
SELECT a.voucherno,coalesce(a.value,0)-coalesce(b.usagevalue,0) as value,a.type from voucher as a
            left join
            (
            SELECT sum(usagevalue) as usagevalue,voucherno FROM vouchertran
            group by voucherno
            )
            as b on a.voucherno = b.voucherno
            where a.voucherno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.vouchernum#">
</cfquery>

<cfif val(checkfull.value) lte 0>
<cfquery name="updatevouchery" datasource="#dts#">
Update voucher set used = "Y",invoiceno ='#nexttranno#',updated_by ="#HuserId#",updated_on = now()  where voucherno = '#form.vouchernum#'
</cfquery>
</cfif>

<cfelse>
<cfquery name="updatevouchery" datasource="#dts#">
Update voucher set used = "Y",invoiceno ='#nexttranno#',updated_by ="#HuserId#",updated_on = now()  where voucherno = '#form.vouchernum#'
</cfquery>
</cfif>
</cfif>

<cfif isdefined ('form.submit')>

<cfif form.submit eq 'Accept & Create New'>
<cfquery name='getgeneralinfo' datasource='#dts#'>
	select gst,filteritem,filterall, 
	invoneset,rc_oneset,pr_oneset,do_oneset,cs_oneset,cn_oneset,dn_oneset,iss_oneset,
	po_oneset,so_oneset, quo_oneset, assm_oneset, tr_oneset, oai_oneset, oar_oneset, sam_oneset, multilocation,wpitemtax,wpitemtax1,EAPT,voucher,filteritemAJAX,voucherbal,asvoucher,crcdtype
	from gsetup
</cfquery>

<cfif getgeneralinfo.invoneset neq '1' and tran eq 'INV'>
				<cflocation url="transaction0.cfm?tran=#tran#">
			<cfelseif getgeneralinfo.rc_oneset neq '1' and tran eq 'RC'>
				<cflocation url="transaction0.cfm?tran=#tran#">
			<cfelseif getgeneralinfo.pr_oneset neq '1' and tran eq 'PR'>
				<cflocation url="transaction0.cfm?tran=#tran#">
			<cfelseif getgeneralinfo.do_oneset neq '1' and tran eq 'DO'>
				<cflocation url="transaction0.cfm?tran=#tran#">
			<cfelseif getgeneralinfo.cs_oneset neq '1' and tran eq 'CS'>
				<cflocation url="transaction0.cfm?tran=#tran#">
			<cfelseif getgeneralinfo.cn_oneset neq '1' and tran eq 'CN'>
				<cflocation url="transaction0.cfm?tran=#tran#">
			<cfelseif getgeneralinfo.dn_oneset neq '1' and tran eq 'DN'>
				<cflocation url="transaction0.cfm?tran=#tran#">
			<cfelseif getgeneralinfo.iss_oneset neq '1' and tran eq 'ISS'>
				<cflocation url="transaction0.cfm?tran=#tran#">
			<cfelseif getgeneralinfo.po_oneset neq '1' and tran eq 'PO'>
				<cflocation url="transaction0.cfm?tran=#tran#">
			<cfelseif getgeneralinfo.so_oneset neq '1' and tran eq 'SO'>
				<cflocation url="transaction0.cfm?tran=#tran#">
			<cfelseif getgeneralinfo.quo_oneset neq '1' and tran eq 'QUO'>
				<cflocation url="transaction0.cfm?tran=#tran#">
			<cfelseif getgeneralinfo.assm_oneset neq '1' and tran eq 'ASSM'>
				<cflocation url="transaction0.cfm?tran=#tran#">
			<cfelseif getgeneralinfo.tr_oneset neq '1' and tran eq 'TR'>
				<cflocation url="transaction0.cfm?tran=#tran#">
			<cfelseif getgeneralinfo.oai_oneset neq '1' and tran eq 'OAI'>
				<cflocation url="transaction0.cfm?tran=#tran#">
			<cfelseif getgeneralinfo.oar_oneset neq '1' and tran eq 'OAR'>
				<cflocation url="transaction0.cfm?tran=#tran#">
			<cfelseif getgeneralinfo.sam_oneset neq '1' and tran eq 'SAM'>
				<cflocation url="transaction0.cfm?tran=#tran#">
			<cfelse>
            <cflocation url="/latest/transaction/transaction1.cfm?action=create&tran=#tran#&nexttranno=&bcode=&dcode=&first=0">
			</cfif>

<cfelse>


	<cfif getgeneral.printoption eq "1">

		<cflocation url="transaction3c.cfm?tran=#tran#&nexttranno=#nexttranno#">

	<cfelse>
		<cfoutput>
			<form name="done" action="transaction.cfm?tran=#tran#" method="post">
			</form>
		</cfoutput>
		<script>
			<cfoutput>window.open('/billformat/#dts#/transactionformat.cfm?tran=#tran#&nexttranno=#nexttranno#');</cfoutput>
			done.submit();
			
		</script>
	</cfif>	
</cfif>

<cfelse>

	<cfif getgeneral.printoption eq "1">
   		
		<cflocation url="transaction3c.cfm?tran=#tran#&nexttranno=#nexttranno#">
  
	<cfelse>
		<!--- <cflocation url="../../billformat/#dts#/transactionformat.cfm?tran=#tran#&nexttranno=#nexttranno#"> --->
		<!--- Modified on 06-02-2009 --->
		<cfoutput>
			<form name="done" action="transaction.cfm?tran=#tran#" method="post">
			</form>
		</cfoutput>
		<script>
			<cfoutput>window.open('../../billformat/#dts#/transactionformat.cfm?tran=#tran#&nexttranno=#nexttranno#');</cfoutput>
			done.submit();
			
		</script>
	</cfif>

</cfif>