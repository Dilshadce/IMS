<cfinclude template = "../../CFC/convert_single_double_quote_script.cfm">

<cfquery name="getGsetup" datasource="#dts#">
	SELECT *,refno2#tran# as refno2valid
	FROM gsetup;
</cfquery>

<cfquery name="getmodule" datasource="#dts#">
    select * from modulecontrol
</cfquery>

<cfquery datasource="#dts#" name="getdisplaysetup2">
	Select * from displaysetup2
</cfquery>
<cfquery name="getuserdefault" datasource="#dts#">
    select * from userdefault
</cfquery>

<cfquery name="listCurrency" datasource="#dts#">
	SELECT currcode,currency,currency1 
	FROM #target_currency#
	ORDER BY currcode;
</cfquery>

<cfquery name="listAttention" datasource="#dts#">
	SELECT attentionno,name 
	FROM attention;
</cfquery>

<cfquery name="getdealer_menu" datasource="#dts#">
	select custSuppSortBy,productSortBy,transactionSortBy,tran_edit_name from dealer_menu limit 1
</cfquery>

<!--- --->
<cfloop list="RC,PR,DO,INV,CS,CN,DN,PO,RQ,QUO,SO,SAM" index="i">

<cfif tran eq i>
  	<cfset tran = i>
  	<cfset tranname = evaluate('getGsetup.l#i#')>
  	<cfset trancode = i&"no">
  	<cfset tranarun = i&"arun">
</cfif>
</cfloop>

<!--- --->
<cfinclude template="transaction3b.cfm">


<!--- --->

<!---getartran--->
	<cfquery name='getartran' datasource='#dts#'>
		select * from artran where refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#nexttranno#"> and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tran#">
	</cfquery>
    
    <cfset xdebt=getartran.grand_bil>
	<cfif val(getartran.deposit) neq 0>
		<cfset xdebt=xdebt-val(getartran.deposit)>
    </cfif>
	<cfif val(getartran.cs_pm_cash) neq 0>
		<cfset xdebt=xdebt-val(getartran.cs_pm_cash)>
    </cfif>
	<cfif val(getartran.cs_pm_cheq) neq 0>
		<cfset xdebt=xdebt-val(getartran.cs_pm_cheq)>
    </cfif>
	<cfif val(getartran.cs_pm_crcd) neq 0>
		<cfset xdebt=xdebt-val(getartran.cs_pm_crcd)>
    </cfif>
	<cfif val(getartran.cs_pm_crc2) neq 0>
		<cfset xdebt=xdebt-val(getartran.cs_pm_crc2)>
    </cfif>
    <cfif val(getartran.cs_pm_dbcd) neq 0>
		<cfset xdebt=xdebt-val(getartran.cs_pm_dbcd)>
    </cfif>
	<cfif val(getartran.cs_pm_vouc) neq 0>
		<cfset xdebt=xdebt-val(getartran.cs_pm_vouc)>
    </cfif>
	
	<cfif (lcase(hcomid) eq "ecraft_i" or lcase(hcomid) eq "ovas_i") and (tran eq 'PO' or tran eq "RC" or tran eq "PR")>
		<cfif val(getartran.cs_pm_tt) neq 0>
			<cfset xdebt=xdebt-val(getartran.cs_pm_tt)>
		</cfif>
    </cfif>
    
    
<!--- --->

<cfset buttonStatus = "btn btn-primary active" >
<cfset buttonStatus2 = "btn btn-default" >

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!---<meta name="viewport" content="width=device-width, initial-scale=1.0">--->
<title><cfoutput>#mode# #tranname#</cfoutput></title>
<link rel="stylesheet" type="text/css" href="/latest/css/bootstrap/bootstrap.css">
<link rel="stylesheet" type="text/css" href="/latest/css/bootstrap-datepicker/datepicker3.css">

<!--[if lt IE 9]>
	<script type="text/javascript" src="/latest/js/html5shiv/html5shiv.js"></script>
	<script type="text/javascript" src="/latest/js/respond/respond.min.js"></script>
<![endif]-->
<script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="/latest/js/bootstrap/bootstrap.min.js"></script>
<script type="text/javascript" src="/latest/js/bootstrap-datepicker/bootstrap-datepicker.js"></script>

<script>
	var dts='#dts#';
	var target='#url.target#';
	var action='#mode#';
</script>

    <!---Filter Template--->
    <cfinclude template="/latest/transaction/filter/filterService.cfm">
    <cfinclude template="/latest/transaction/filter/filterItem.cfm">
    <script type="text/javascript" src="/latest/transaction/transaction3itemlist.js"></script>
    <!--- --->
    <link rel="stylesheet" href="/latest/css/select2/select2.css" />
    <script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>

   <!--- --->
   <script language="JavaScript">
	function validate(){
	<cfif getdisplaysetup2.project_compulsory eq "Y">
	if(document.getElementById("Source").value == ""){
		alert('Please Choose a Project!');
		return false;
	}
	</cfif>
	
	}
	</script>
   <!--- --->

</head>
<body>
<cfoutput>
       
<cfset hidestatus="text">
        
        
		<form class="form-horizontal" role="form" action="transaction10b.cfm" method="post"><!--- onsubmit="document.getElementById('custno').disabled=false";--->
			<input type='hidden' name='tran' id="tran" value='#listfirst(tran)#'>
            <input type='hidden' name='currrate' value='#listfirst(currrate)#'>
            <input type='hidden' name='agenno' value='#listfirst(agenno)#'>
            <input type='hidden' name='refno3' value='#listfirst(refno3)#'>
            <input type="hidden" name="hidtrancode" id="hidtrancode" value="">
            <input type='hidden' name='nexttranno' value='#listfirst(nexttranno)#'>
            <input type='hidden' name='mode' value='#listfirst(mode)#'>
            <input type='hidden' name='custno' id="custno" value='#listfirst(custno)#'>
            <input type='hidden' name='readperiod' value='#listfirst(readperiod)#'>
            <input type='hidden' name='nDateCreate' value='#dateformat(listfirst(invoicedate),'dd/mm/yyyy')#'>
            <input type='hidden' name='nDateNow' value='#dateformat(now(),'dd/mm/yyyy')#'>
            <input type='hidden' name='invoicedate' value='#dateformat(listfirst(invoicedate),'dd/mm/yyyy')#'>
            
            <table width="100%">
            <tr>
            <td colspan="100%">
            <img src="/images/transaction page header-04.png" width="100%" >
            </td>
            </tr>
            <tr>
            <td rowspan="4" width="30%">
            <table style="margin:5% 5% 5% 5%" border="1" width="80%" height="80">
            <tr>
            <td width="50%" height="100%" style=" background-color:##999; font-size:14px" align="center">Last Sales Order<br><font size="+1">1111</font></td>
			<td width="50%" height="100%" style=" font-size:14px" align="center">New Sales Order<br><font size="+1">
            #nexttranno#
            </font></td>
            </tr>
            </table>

            
            </td>
            <th>Customer</th>
            <th colspan="2">Date</th>
            
            </tr>
            <tr>
 			<td width="30%" nowrap>
            #getartran.custno# - #getartran.name#
            </td>
            <td width="40%" colspan="2">
            #dateformat(getartran.wos_date,'dd/mm/yyyy')#
            </td>
            </tr>
            <tr>
            <th>Reference No 2</th>
            <th colspan="2">Outstanding Amount</th>
            </tr>
            <tr>
            <td>#getartran.refno2#</td>
            <td colspan="2">
            <cfif getdisplaysetup2.f_crlimit eq 'Y'>
            <cfquery name="get_dealer_menu_info" datasource="#dts#">
				select 
				(
					select 
					selling_above_credit_limit 
					from dealer_menu 
				) as selling_above_credit_limit, 
				(
					select 
					crlimit 
					from #target_arcust#
					where custno='#jsstringformat(preservesinglequotes(custno))#' 
				) as credit_limit,
				(
					ifnull(
						(
							select 
							ifnull(sum(grand_bil),0)
							from artran 
							where custno='#jsstringformat(preservesinglequotes(custno))#'
							and type in ('INV','DN','CS')
							and posted='' 
							group by custno 
						)
					,0)
                    -
                    ifnull(
						(
							select 
							ifnull(sum(grand_bil),0)
							from artran 
							where custno='#jsstringformat(preservesinglequotes(custno))#'
							and type='CN'
							and posted='' 
							group by custno 
						)
					,0)
					+<!--- - --->
                    <cfif Hlinkams eq 'Y'>
					ifnull(
						(
							select 
							ifnull((sum(debitamt)- sum(creditamt)),0)
							from #replacenocase(dts,"_i","_a","all")#.glpost 
							where accno='#jsstringformat(preservesinglequotes(custno))#'  and fperiod <> '99'
							group by accno
						) 
					,0) 
                    
                    +
                    ifnull(
						(
							select 
							ifnull(lastybal,0)
							from #replacenocase(dts,"_i","_a","all")#.gldata 
							where accno='#jsstringformat(preservesinglequotes(form.custno))#' 
							group by accno
						) 
					,0) 
                    <cfelse>
                    0
                    </cfif>
				) as credit_balance;
			</cfquery>
            #numberformat(get_dealer_menu_info.credit_balance,',_.__')#
            </cfif>
            </td>
            </tr>
            
            </table>
            <table width="100%">
            <tr>
            <th>Grand Amount :</th>
            <td colspan="3">
           	#form.viewGrand#
            </td>
            </tr>
            
            <tr>
            <th colspan="100%">Payment</th>
            </tr>
            <tr>
            <td>Cash</td>
            <td align="right"><input tabindex="0" name="cash" id="cash" type="#hidestatus#" value="#numberformat(getartran.cs_pm_cash,'0.00')#" size="10" maxlength="15" onKeyUp="getCashCount();"></td>
            </td>
            </tr>
            <tr>
            <td>Cheque</td>
            <td align="right"><input name="cheque" id="cheque" type="#hidestatus#" value="#numberformat(getartran.cs_pm_cheq,'0.00')#" size="10" maxlength="15" onKeyUp="getChequeCount();"></td>
            </td>
            </tr>
            <tr>
            <td>
            <cfif lcase(hcomid) eq "ecraft_i" or lcase(hcomid) eq "ovas_i" >AMEX<cfelseif HcomID eq "bama_i">VISA/MASTER<cfelseif lcase(hcomid) eq "manhattan_i" or lcase(hcomid) eq "elmanhattan_i" or lcase(hcomid) eq "manhattan09_i" or lcase(HcomID) eq "ascend_i">Credit Card 1 
            <select name="creditcardtype1" id="creditcardtype1">
            <option value="">Choose a type of credit card</option>
            <option value="VISA" <cfif getartran.creditcardtype1 eq 'VISA'>selected</cfif>>VISA</option>
            <option value="MASTER" <cfif getartran.creditcardtype1 eq 'MASTER'>selected</cfif>>MASTER</option>
            <option value="AMEX" <cfif getartran.creditcardtype1 eq 'AMEX'>selected</cfif>>AMEX</option>
            <option value="JCB" <cfif getartran.creditcardtype1 eq 'JCB'>selected</cfif>>JCB</option>
            <option value="DINERS" <cfif getartran.creditcardtype1 eq 'DINERS'>selected</cfif>>DINERS</option>
			<option value="CUP" <cfif getartran.creditcardtype1 eq 'CUP'>selected</cfif>>CUP</option>
            </select>
            <cfelse>
            <cfif getgsetup.crcdtype eq 'Y'>
            <select name="creditcardtype1" id="creditcardtype1">
            <option value="">Choose a type of credit card</option>
            <option value="VISA" <cfif getartran.creditcardtype1 eq 'VISA'>selected</cfif>>VISA</option>
            <option value="MASTER" <cfif getartran.creditcardtype1 eq 'MASTER'>selected</cfif>>MASTER</option>
            <option value="AMEX" <cfif getartran.creditcardtype1 eq 'AMEX'>selected</cfif>>AMEX</option>
            <option value="JCB" <cfif getartran.creditcardtype1 eq 'JCB'>selected</cfif>>JCB</option>
            <option value="DINERS" <cfif getartran.creditcardtype1 eq 'DINERS'>selected</cfif>>DINERS</option>
			<option value="CUP" <cfif getartran.creditcardtype1 eq 'CUP'>selected</cfif>>CUP</option>
            </select>
            <cfelse>
            <cfif HcomID eq "bama_i">VISA/MASTER<cfelseif lcase(hcomid) eq "lafa_i" or lcase(hcomid) eq "johorlafa_i">Credit card (MBF)<cfelse>Credit Card 1</cfif>
            </cfif>
			</cfif>
            </td>
            <td align="right"><input name="credit_card1" id="credit_card1" type="#hidestatus#" value="#numberformat(getartran.cs_pm_crcd,'0.00')#" size="10" maxlength="15" onKeyUp="getCredit_Card1Count();"><cfif HcomID eq "atc2005_i"><input type="button" name="ccdetail" id="ccdetail" value="Detail" onClick="javascript:ColdFusion.Window.show('addccdetail');"></cfif></td>
            </td>
            </tr>
            <tr>
            <td>
            <cfif HcomID eq "pnp_i">NET<cfelseif lcase(hcomid) eq "ecraft_i" or lcase(hcomid) eq "ovas_i">VISA/MC<cfelseif HcomID eq "bama_i">AMEX/PAYPAL<cfelseif lcase(hcomid) eq "lafa_i" or lcase(hcomid) eq "johorlafa_i">Credit card (PBB)<cfelseif lcase(hcomid) eq "manhattan_i" or lcase(hcomid) eq "elmanhattan_i" or lcase(hcomid) eq "manhattan09_i">Credit Card 2
			<select name="creditcardtype2">
            <option value="">Choose a type of credit card</option>
            <option value="VISA" <cfif getartran.creditcardtype2 eq 'VISA'>selected</cfif>>VISA</option>
            <option value="MASTER" <cfif getartran.creditcardtype2 eq 'MASTER'>selected</cfif>>MASTER</option>
            <option value="AMEX" <cfif getartran.creditcardtype2 eq 'AMEX'>selected</cfif>>AMEX</option>
            <option value="JCB" <cfif getartran.creditcardtype2 eq 'JCB'>selected</cfif>>JCB</option>
            <option value="DINERS" <cfif getartran.creditcardtype2 eq 'DINERS'>selected</cfif>>DINERS</option>
			<option value="CUP" <cfif getartran.creditcardtype2 eq 'CUP'>selected</cfif>>CUP</option>
            </select>
            <cfelse>
            <cfif getgsetup.crcdtype eq 'Y'>
            <select name="creditcardtype2">
            <option value="">Choose a type of credit card</option>
            <option value="VISA" <cfif getartran.creditcardtype2 eq 'VISA'>selected</cfif>>VISA</option>
            <option value="MASTER" <cfif getartran.creditcardtype2 eq 'MASTER'>selected</cfif>>MASTER</option>
            <option value="AMEX" <cfif getartran.creditcardtype2 eq 'AMEX'>selected</cfif>>AMEX</option>
            <option value="JCB" <cfif getartran.creditcardtype2 eq 'JCB'>selected</cfif>>JCB</option>
            <option value="DINERS" <cfif getartran.creditcardtype2 eq 'DINERS'>selected</cfif>>DINERS</option>
			<option value="CUP" <cfif getartran.creditcardtype2 eq 'CUP'>selected</cfif>>CUP</option>
            </select>
            <cfelse>
            <cfif HcomID eq "bama_i">AMEX/PAYPAL<cfelse>Credit Card 2</cfif>
            </cfif>
			</cfif>
            
            </td>
            <td align="right"><input name="credit_card2" id="credit_card2" type="#hidestatus#" value="#numberformat(getartran.cs_pm_crc2,'0.00')#" size="10" maxlength="15" onKeyUp="getCredit_Card2Count();"></td>
            </td>
            </tr>
            <tr>
            <td>T.T.</td>
            <td align="right"><input name="telegraph_transfer" id="telegraph_transfer" type="#hidestatus#" value="#numberformat(getartran.cs_pm_tt,'0.00')#" size="10" maxlength="15" onKeyUp="getTelegraph_Transfer();"></td>
            </td>
            </tr>
            <tr>
            <td>Cash Card</td>
            <td align="right"><input name="cashcd" id="cashcd" type="#hidestatus#" value="#numberformat(getartran.cs_pm_cashCD,'0.00')#" size="10" maxlength="15" onKeyUp="getCashCDCount();"></td>
            </td>
            </tr>
            <tr>
            <td>Gift Voucher</td>
            <td align="right"><input name="gift_voucher" id="gift_voucher" type="#hidestatus#" value="#numberformat(getartran.cs_pm_vouc,'0.00')#" size="10" maxlength="15" onKeyUp="getGift_VoucherCount();"></td>
            </td>
            <td <cfif getdisplaysetup2.f_pay_gvoucher neq "Y">style="visibility:hidden"</cfif>>
			<cfif getGsetup.voucher eq "Y" and (tran eq "INV" or tran eq "DO" or tran eq "CN" or tran eq "SO" or tran eq "CS")> 
            <cfquery name="getusedvoucher" datasource="#dts#">
            SELECT a.voucherno,coalesce(a.value,0)-coalesce(b.usagevalue,0) as value,a.type from voucher as a
            left join
            (
            SELECT sum(usagevalue) as usagevalue,voucherno FROM vouchertran
            <cfif lcase(hcomid) eq "dental_i" or lcase(hcomid) eq "dental10_i" or lcase(hcomid) eq "mfss_i" or lcase(hcomid) eq "hcss_i" or lcase(hcomid) eq "mfssmy_i">
where type in('DO','CN','Transfer')
</cfif>
            group by voucherno
            )
            as b on a.voucherno = b.voucherno
            where <cfif lcase(hcomid) eq "lafa_i" or lcase(hcomid) eq "johorlafa_i"> (a.custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#"> or a.custno="" or a.custno is null) and<cfelse><cfif getGsetup.asvoucher eq "Y"> a.custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#"> and</cfif></cfif> (a.used = "N" or a.used = "" or a.used is null)
            </cfquery>
            
            <select name="vouchernum" id="vouchernum" onChange="assignvoucher(this.value,this.options[this.selectedIndex].id,this.options[this.selectedIndex].title);">
			<option value="">Select a voucher</option>
            <cfif getartran.voucher neq "">
			<option value="#getartran.voucher#" id="#numberformat(getartran.cs_pm_vouc,'0.00')#" title="#numberformat(getartran.cs_pm_vouc,'0.00')#" selected>#getartran.voucher#-#numberformat(getartran.cs_pm_vouc,'0.00')#</option>
			</cfif> 
            <cfloop query="getusedvoucher">
            <option value="#getusedvoucher.voucherno#" id="#getusedvoucher.value#" title="#getusedvoucher.type#">
            #getusedvoucher.voucherno#-<cfif getusedvoucher.type eq "Value">$ #numberformat(getusedvoucher.value,'.__')#<cfelse>#getusedvoucher.value#%</cfif>
            </option>
            </cfloop>
            
            </select>
	   </cfif>
       
       		</td>
			<td><cfif getGsetup.voucherb4disc eq "Y"><input type="text" name="voucherb4disc" id="voucherb4disc" value="#numberformat(getictran2.subtotal,'.__')#" size="10"></cfif></td>
            </tr>
            <tr>
            <td><cfif lcase(hcomid) eq "bama_i" or lcase(hcomid) eq "dgalleria_i">NETS<cfelseif lcase(hcomid) eq "lafa_i" or lcase(hcomid) eq "johorlafa_i">Debit Card (MBF)<cfelseif getmodule.auto eq '1'>NETS<cfelse>Debit Card</cfif></td>
            <td><input name="debit_card" id="debit_card" type="#hidestatus#" value="#numberformat(getartran.cs_pm_dbcd,'0.00')#" size="10" maxlength="15" onKeyUp="getDebit_cardCount();" <cfif lcase(hcomid) eq "gel_i" and husergrpid neq "Admin" and husergrpid neq "Super">readonly</cfif>></td>
            </tr>
            
            <tr>
            <td><cfif lcase(hcomid) eq "visionlaw_i">Legal Subsidy<cfelseif lcase(hcomid) eq "bama_i">Bank Transfer<cfelseif lcase(hcomid) eq "lafa_i" or lcase(hcomid) eq "johorlafa_i">Debit Card (PBB)<cfelse>Deposit</cfif></td>
            <td><input name="deposit" id="deposit" type="#hidestatus#" value="#numberformat(getartran.deposit,'0.00')#" size="10" maxlength="15" onKeyUp="getDepositCount();" <cfif lcase(hcomid) eq "gel_i" and husergrpid neq "Admin" and husergrpid neq "Super">readonly</cfif>></td>
            </tr>
            
            <tr>
            <td>As Debt</td>
            <td><input name="debt" id="debt" type="#hidestatus#" size="10" value="#xdebt#" style="background-color:##FFFF99" readonly></td>
            </tr>
            
            </table>
            
            <!---End Header--->
            
            <table class="table table-bordered table-hover" id="resultTable" style="table-layout:fixed">
			<thead>
			</thead>
			<tbody>
			</tbody>
			</table>
            
			
			<div align="center">
				<button type="submit" class="btn btn-primary" id="submit">Accept And Print</button>
				<button type="button" class="btn btn-default" onclick="window.history(-1)" >Back</button>
			</div>
		</form>		
	</div>
</cfoutput>
</body>
</html>