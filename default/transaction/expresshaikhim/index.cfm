<cfajaximport tags="cfform,cftooltip">
<cfajaximport tags="cfwindow,cflayout-tab">
<cfinclude template = "/CFC/convert_single_double_quote_script.cfm">
<cfset tran = url.type>
<cfsetting showdebugoutput="yes">
<cfquery name="getgsetup" datasource="#dts#">
SELECT * FROM gsetup
</cfquery>
<cfquery datasource="#dts#" name="getdisplay">
	select * from displaysetup
</cfquery>

<cfquery datasource="#dts#" name="getdisplaysetup2">
	select * from displaysetup2
</cfquery>

<cfquery datasource="#dts#" name="getmodule">
	select * from modulecontrol
</cfquery>

<cfif url.type eq 'PR' or  url.type eq 'RC' or url.type eq 'PO' or url.type eq 'RQ'>
<cfset dbtype=target_apvend>
<cfset dbname='Supplier'>
<cfelse>
<cfset dbtype=target_arcust>
<cfset dbname='Customer'>
</cfif>

<cfset title="Purchase Requsition">
<cfset target="Supplier">
<cfset targetTable="apvend">

<cfset itemPriceType="ucost">

<cfquery name="getdealer_menu" datasource="#dts#">
	select custSuppSortBy,productSortBy,transactionSortBy,tran_edit_name from dealer_menu limit 1
</cfquery>

<cfquery name="getgsetup2" datasource="#dts#">
select * from gsetup2

</cfquery>
<cfquery name="getdealermenu" datasource="#dts#">
SELECT * FROM dealer_menu
</cfquery>

<cfquery datasource="#dts#" name="getlocation">
	select 
	location,
	desp 
	from iclocation 
    where 0=0
    <cfif (lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjctrial_i") and (HUserGrpID neq 'Cust Svr' and HUserGrpID neq 'Van Sales')>
    <cfelse>
    <cfif Huserloc neq "All_loc">
	and location='#Huserloc#'
	</cfif>
    <cfif dts eq "tcds_i" and url.type eq "RC">
    and location = 'stock'
	</cfif>
    </cfif>
	order by location;
</cfquery>

<cfquery datasource="#dts#" name="getjob">
	select * from #target_project# where porj='J'
</cfquery>

<cfquery datasource="#dts#" name="getGeneralInfo">
			select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse 
            from refnoset
			where type = "#url.type#"
			and counter = '1'
		</cfquery>
        
        <cfif getGeneralInfo.arun eq "1">
        <cfinvoke component="cfc.refno" method="processNum" oldNum="#getGeneralInfo.tranno#" returnvariable="newnextNum" />
        	<cfset actual_nexttranno = newnextNum>
            <cfif (getGeneralInfo.refnocode2 neq "" or getGeneralInfo.refnocode neq "") and getGeneralInfo.presuffixuse eq "1">
				<cfset nexttranno = "#url.type#"&"-"&getGeneralInfo.refnocode&actual_nexttranno&getGeneralInfo.refnocode2>
            <cfelse>
            	<cfset nexttranno = "#url.type#"&"-"&actual_nexttranno>
			</cfif>
            <cfset tranarun_1 = getGeneralInfo.arun>
		<cfelse>
			<cfset nexttranno = "">
            <cfset tranarun_1 = "0">
		</cfif>
        <cfset nexttranno = tostring(nexttranno)>

<html>
<head>
<script src="/SpryAssets/SpryCollapsiblePanel.js" type="text/javascript"></script>
<link href="/SpryAssets/SpryCollapsiblePanel.css" rel="stylesheet" type="text/css" />
<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=utf-8" />
	<link rel="stylesheet" type="text/css" href="simpleNew.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="/latest/css/bootstrap/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="/latest/css/dataTables/dataTables_bootstrap.css" />
    <link rel="stylesheet" href="/latest/css/select2/select2.css" />
    <link rel="stylesheet" type="text/css" href="/latest/css/bootstrap-datepicker/datepicker3.css">
    
	<script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="/latest/js/jqueryui/jquery-ui-1.10.3.custom.min.js"></script>
    <script type="text/javascript" src="/latest/js/dataTables/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>
    <script type="text/javascript" src="/latest/js/bootstrap-datepicker/bootstrap-datepicker.js"></script>
    <link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
	<script language="javascript" type="text/javascript" src="/scripts/CalendarControl.js"></script>
	<cfoutput>
	<script type="text/javascript">
	
		var dts='#dts#';
		var target='#target#';
		var targetTable='#targetTable#';
		var type='#type#';
		var title='#title#';
		
	</script>
    </cfoutput>
    <style>
		.input-xs {
			height: 22px;
			padding: 5px 5px;
			font-size: 12px;
			line-height: 1.5;
			border-radius: 3px;
		}
	</style>
    
	<script type="text/javascript" src="simpleNew.js"></script>
    
    
	<title>Simple Transaction</title>

	<script type='text/javascript' src='/ajax/core/settings.js'></script>
    <script type='text/javascript' src='/ajax/core/shortcut.js'></script>
    <script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
	<script type="text/javascript" src="/scripts/prototypenew.js" ></script>
    <script type="text/javascript">
	
	function addpackagefunc()
	{
	<cfoutput>
	var tran = trim(document.getElementById('tran').value);
	var refno = trim(document.getElementById('refno').value);
	var trancode = trim(document.getElementById('nextransac').value);
	var custno = trim(document.getElementById('custno').value);
	var packagecode=document.getElementById('hidpackagecode').value;
	var location = document.getElementById('coltype').value;
	var ajaxurl2 = '/default/transaction/expresshaikhim/addpackageprocessAjax.cfm?tran='+escape(tran)+'&tranno='+refno+'&uuid='+document.getElementById('uuid').value+'&trancode='+escape(trancode)+'&custno='+escape(custno)+'&packagecode='+escape(packagecode)+'&location='+escape(location);
<!---ajaxFunction(document.getElementById('ajaxFieldPro2'),ajaxurl2);--->
	new Ajax.Request(ajaxurl2,
      {
        method:'get',
        onSuccess: function(getdetailback){
		document.getElementById('ajaxFieldPro').innerHTML = trim(getdetailback.responseText);
        },
        onFailure: function(){ 
		alert('Error Add Package'); },		
		
		onComplete: function(transport){
		clearformadvance();
		setTimeout('calculatefooter();',500);
		refreshlist();
        }
      })
	</cfoutput>
	}
	
	function itemcheckbox(itembox)
	{
				
		 for (m=1;m<=160;m=m+1)
		{
		if (document.getElementById('btn'+m) == null)
		{
		}
		else
		{	
		document.getElementById('btn'+m).style.visibility='hidden';
		}
		}
		
		if (itembox.checked == true)
		{
			var actionpick = 'add';	
		}	  
		else 
		{	
		var actionpick = 'delete';		
		}
			var updateurl = 'pickitemlist.cfm?action='+actionpick+'&uuid='+escape(document.getElementById('pickitemuuid').value)+'&itemno='+escape(itembox.value);
				new Ajax.Request(updateurl,
			  {
				method:'get',
				onSuccess: function(getdetailback){
				document.getElementById('pickitemlist').innerHTML = trim(getdetailback.responseText);
				},
				onFailure: function(){ 
				alert('Error Pick Item'); },		
				
				onComplete: function(transport){
				}
			  })
				  
	
	
	}
	
	function test_prefix(form,field,value)
	{
		
		
		
		var allNum = "";
		var chkVal = allNum;
		var prsVal = parseInt(allNum);
		
		var item1 = value;
		var item2 = '<cfoutput>#getgsetup.debtorfr#</cfoutput>'; 
		var item3 = '<cfoutput>#getgsetup.debtorto#</cfoutput>'; 		
	
		var checkOK = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		var allValid = true;
		var decPoints = 0;
		var allNum = "";
		
		for (i = 0;  i < item1.length;  i++)
		{
		ch = item1.charAt(i);
		for (j = 0;  j < checkOK.length;  j++)
		if (ch == checkOK.charAt(j))
		break;
		if (j == checkOK.length)
		{
		allValid = false;
		break;
		}
		if (ch != ",")
		allNum += ch;
		
		}
		if (!allValid)
		{
		return false;
		}
				
		for (var i = 0; i<value.length; i++)
		{		
		
    	if (item1.charCodeAt(i) < item2.charCodeAt(i) || item1.charCodeAt(i) > item3.charCodeAt(i)){		

		return false;
		
		}
		} 
		
		return true;
				
	}
	function addOption(selectbox,text,value )
{
var optn = document.createElement("OPTION");
optn.text = text;
optn.value = value;
selectbox.options.add(optn);
}
	
	function test_prefix1(form,field,value)
	{
		var allNum = "";
		var chkVal = allNum;
		var prsVal = parseInt(allNum);
		
		var item1 = value;
		var item2 = '<cfoutput>#getgsetup.creditorfr#</cfoutput>'; 
		var item3 = '<cfoutput>#getgsetup.creditorto#</cfoutput>'; 		
	
		var checkOK = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		var allValid = true;
		var decPoints = 0;
		var allNum = "";
		
		for (i = 0;  i < item1.length;  i++)
		{
		ch = item1.charAt(i);
		for (j = 0;  j < checkOK.length;  j++)
		if (ch == checkOK.charAt(j))
		break;
		if (j == checkOK.length)
		{
		allValid = false;
		break;
		}
		if (ch != ",")
		allNum += ch;
		
		}
		if (!allValid)
		{
		return false;
		}
				
		for (var i = 0; i<value.length; i++)
		{		
		
    	if (item1.charCodeAt(i) < item2.charCodeAt(i) || item1.charCodeAt(i) > item3.charCodeAt(i)){		

		return false;
		
		}
		} 
		
		return true;
				
	}
	
	function test_suffix(form,field,value)
{
		
		// require that at least one character be entered
		if (value.length < 3)
		{
		return false;
		}
		
		if (value == '000')
		{
		return false;
		}
		
		return true;
}
	
	function getKey(keyStroke) {
var t = window.event.srcElement.type;
var keyCode = (document.layers) ? keyStroke.which : event.keyCode;
var keyString = String.fromCharCode(keyCode).toLowerCase();
var leftArrowKey = 37;
var backSpaceKey = 8;
var escKey = 27;
if(t && (t =='text' || t =='textarea' || t =='file')){
//do not cancel the event
}else{
if( (window.event.altKey && window.event.keyCode==leftArrowKey) || (keyCode == escKey) || (keyCode == backSpaceKey)){
return false;
}
}
}
	
	function fillsearch(custno,name,contact,add1,add2,add3)
	{
		document.getElementById('memberidsearch').value=unescape(custno);
		document.getElementById('membernamesearch').value=unescape(name);
		document.getElementById('membertelsearch').value=unescape(contact);
		document.getElementById('memberadd1search').value=unescape(add1);
		document.getElementById('memberadd2search').value=unescape(add2);
		document.getElementById('memberadd3search').value=unescape(add3);
	}
		
	function selectOptionByValue(selObj, val){ 
    var A= selObj.options, L= A.length; 
    while(L){ 
        if (A[--L].value== val){ 
            selObj.selectedIndex= L; 
            L= 0; 
        } 
    } 
	}
	
	function updateremark()
	{
	document.getElementById('rem5').value=document.getElementById('hidrem5').value;
	document.getElementById('rem6').value=document.getElementById('hidrem6').value;
	document.getElementById('rem7').value=document.getElementById('hidrem7').value;
	document.getElementById('rem8').value=document.getElementById('hidrem8').value;
	document.getElementById('rem9').value=document.getElementById('hidrem9').value;
	document.getElementById('rem10').value=document.getElementById('hidrem10').value;
	document.getElementById('rem11').value=document.getElementById('hidrem11').value;
	}
	
	function updateremark2()
	{
	if (document.getElementById('rem5').value !=''){
	<cfif trim(getGsetup.remark5list) neq ''>
	selectOptionByValue(document.getElementById('hidrem5'),document.getElementById('rem5').value);
	<cfelse>
	document.getElementById('hidrem5').value=document.getElementById('rem5').value;
	</cfif>
	}
	if (document.getElementById('rem6').value !=''){
	<cfif trim(getGsetup.remark6list) neq ''>
	selectOptionByValue(document.getElementById('hidrem6'),document.getElementById('rem6').value);
	<cfelse>
	document.getElementById('hidrem6').value=document.getElementById('rem6').value;
	</cfif>
	}
	if (document.getElementById('rem7').value !=''){
	<cfif trim(getGsetup.remark7list) neq ''>
	selectOptionByValue(document.getElementById('hidrem7'),document.getElementById('rem7').value);
	<cfelse>
	document.getElementById('hidrem7').value=document.getElementById('rem7').value;
	</cfif>
	}
	if (document.getElementById('rem8').value !=''){
	<cfif trim(getGsetup.remark8list) neq ''>
	selectOptionByValue(document.getElementById('hidrem8'),document.getElementById('rem8').value);
	<cfelse>
	document.getElementById('hidrem8').value=document.getElementById('rem8').value;
	</cfif>
	}
	if (document.getElementById('rem9').value !=''){
	<cfif trim(getGsetup.remark9list) neq ''>
	selectOptionByValue(document.getElementById('hidrem9'),document.getElementById('rem9').value);
	<cfelse>
	document.getElementById('hidrem9').value=document.getElementById('rem9').value;
	</cfif>
	}
	if (document.getElementById('rem10').value !=''){
	<cfif trim(getGsetup.remark10list) neq ''>
	selectOptionByValue(document.getElementById('hidrem10'),document.getElementById('rem10').value);
	<cfelseif (lcase(hcomid) eq "bnbm_i" or lcase(HcomID) eq "bnbp_i") and tran eq 'QUO'>
	selectOptionByValue(document.getElementById('hidrem10'),document.getElementById('rem10').value);
	<cfelse>
	document.getElementById('hidrem10').value=document.getElementById('rem10').value;
	</cfif>
	}
	if (document.getElementById('rem11').value !=''){
	document.getElementById('hidrem11').value=document.getElementById('rem11').value;
	}

	}
	
	function getCheckedValue(radioObj) {
	if(!radioObj) return "";
	var radioLength = radioObj.length;
	
	if(radioLength == undefined)
	{
		if(radioObj.checked)
			return radioObj.value;
		else
			return "";
	}
	for(var i = 0; i < radioLength; i++) {
		if(radioObj[i].checked) {
			return radioObj[i].value;
		}
	}
	return "";
}

	
	function searchSel(fieldid,textid) {
  var input=document.getElementById(textid).value.toLowerCase();
  var output=document.getElementById(fieldid).options;
  for(var i=0;i<output.length;i++) {
    if(output[i].text.toLowerCase().indexOf(input)>=0 && i != 0){
      output[i].selected=true;
	  break;
      }
    if(document.getElementById(textid).value==''){
      output[0].selected=true;
      }
  }
}
	function updaterow(rowno)
	{
		var varcoltype = 'coltypelist'+rowno;
		var varpromotiontype = 'promotiontype'+rowno;
		var varqtylist = 'qtylist'+rowno;
		var varunitlist = 'unitlist'+rowno;
		
		var brem4 = 'brem4'+rowno;
		var job = 'joblist'+rowno;
		var brem1 = 'brem1list'+rowno;
		var brem2 = 'brem2list'+rowno;
		
		var uuid = document.getElementById('uuid').value;
		var coltypedata = document.getElementById(varcoltype).value;
		var promotiontypedata = document.getElementById(varpromotiontype).value;
		var qtylistdata = document.getElementById(varqtylist).value;
		var unitlistdata = document.getElementById(varunitlist).value;
		var joblistdata = document.getElementById(job).value;
		
		var brem4data = document.getElementById(brem4).value;
		var brem1data = document.getElementById(brem1).value;
		var brem2data = document.getElementById(brem2).value;
		
		var updateurl = 'updaterow.cfm?uuid='+escape(uuid)+'&coltype='+escape(coltypedata)+'&qty='+escape(qtylistdata)+'&unit='+escape(unitlistdata)+'&trancode='+rowno+'&brem4='+escape(brem4data)+'&brem1='+escape(brem1data)+'&brem2='+escape(brem2data)+'&job='+escape(joblistdata)+'&promotiontype='+escape(promotiontypedata);
		
		new Ajax.Request(updateurl,
      {
        method:'get',
        onSuccess: function(getdetailback){
		document.getElementById('ajaxFieldPro').innerHTML = trim(getdetailback.responseText);
        },
        onFailure: function(){ 
		alert('Error Update Item'); },		
		
		onComplete: function(transport){
		calculatefooter();
		refreshlist();
        }
      })
		
	}
	
	function deleterow(rowno)
	{

		var uuid = document.getElementById('uuid').value;

		var updateurl = 'deleterow.cfm?uuid='+escape(uuid)+'&trancode='+rowno;
		new Ajax.Request(updateurl,
      {
        method:'get',
        onSuccess: function(getdetailback){
		document.getElementById('ajaxFieldPro').innerHTML = trim(getdetailback.responseText);
        },
        onFailure: function(){ 
		alert('Error Delete Item'); },		
		
		onComplete: function(transport){
		calculatefooter();
		refreshlist();
        }
      })
		
	}
	
	function gopay(payname)
	{
	var itemcount = 0;
			try{
				itemcount = document.getElementById('hiditemcount').value * 1;
			}
			catch(err)
			{
			}
			if(itemcount != 0)
			{
				ColdFusion.Window.show(payname);
			}	
	}
	function submitpay()
	{
		var paytypeno = document.getElementById('paytype').value;
		var cashamt = parseFloat(document.getElementById('paycash'+paytypeno).value);
		if(document.getElementById('paycash'+paytypeno).value == ""){cashamt = 0;}
		var cc1amt = parseFloat(document.getElementById('cc1'+paytypeno).value);
		if(document.getElementById('cc1'+paytypeno).value == ""){cc1amt = 0;}
		var cc2amt = parseFloat(document.getElementById('cc2'+paytypeno).value);
		if(document.getElementById('cc2'+paytypeno).value == ""){cc2amt = 0;}
		var dbcamt = parseFloat(document.getElementById('dbc'+paytypeno).value);
		if(document.getElementById('dbc'+paytypeno).value == ""){dbcamt = 0;}
		var cheqamt = parseFloat(document.getElementById('cheq'+paytypeno).value);
		if(document.getElementById('cheq'+paytypeno).value == ""){cheqamt = 0;}
		var voucheramt = parseFloat(document.getElementById('voucheramt'+paytypeno).value);
		if(document.getElementById('voucheramt'+paytypeno).value == ""){voucheramt = 0;}
		var depositamt = parseFloat(document.getElementById('depositamt'+paytypeno).value);
		if(document.getElementById('depositamt'+paytypeno).value == ""){depositamt = 0;}
		var cashcamt = parseFloat(document.getElementById('cashc'+paytypeno).value);
		if(document.getElementById('cashc'+paytypeno).value == ""){cashcamt = 0;}
		if (paytypeno == 5)
		{
			document.getElementById('cctype').value=getCheckedValue(document.ccform5.cctype15);
			document.getElementById('cctype2').value=getCheckedValue(document.ccform5.cctype25);
			document.getElementById('checkno').value=document.getElementById('chequeno5').value;
		}
		if (paytypeno == 6)
		{
			document.getElementById('custno').value=document.getElementById('custno6').value;
			<cfoutput>
			document.getElementById('tran').value="#url.type#";
			</cfoutput>
			<!---document.getElementById('refno').value=document.getElementById('refnoinv').value;--->
			document.getElementById('cctype').value=getCheckedValue(document.ccform6.cctype16);
			document.getElementById('cctype2').value=getCheckedValue(document.ccform6.cctype26);
			document.getElementById('checkno').value=document.getElementById('chequeno6').value;
		}
		try{
		document.getElementById('cctype').value=getCheckedValue(document.ccform.cctype1);
		}
		catch(err)
		{
		}
		try{
		document.getElementById('checkno').value=document.getElementById('chequeno').value;
		}
		catch(err)
		{
		}
		document.invoicesheet.cash.value = cashamt-parseFloat(document.getElementById('change'+paytypeno).value);
		document.invoicesheet.credit_card1.value=cc1amt;
		document.invoicesheet.credit_card2.value=cc2amt;
		document.invoicesheet.debit_card.value=dbcamt;
		document.invoicesheet.cheque.value=cheqamt;
		document.invoicesheet.voucher.value=voucheramt;
		document.invoicesheet.deposit.value=depositamt;
		document.invoicesheet.cashcamt.value=cashcamt;
		document.invoicesheet.changeamt1.value=parseFloat(document.getElementById('change'+paytypeno).value);
		<!--- document.getElementById('rem9').value=document.getElementById('rem9desp'+paytypeno).value; --->
		document.invoicesheet.submit();
	}
	function calculatetotal(e,nextflow,upflow)
	{
		var paytypeno = document.getElementById('paytype').value;
		var gtamt = parseFloat(document.getElementById('hidgt'+paytypeno).value);
		var cashamt = parseFloat(document.getElementById('paycash'+paytypeno).value);
		if(document.getElementById('paycash'+paytypeno).value == ""){cashamt = 0;}
		var cc1amt = parseFloat(document.getElementById('cc1'+paytypeno).value);
		if(document.getElementById('cc1'+paytypeno).value == ""){cc1amt = 0;}
		var cc2amt = parseFloat(document.getElementById('cc2'+paytypeno).value);
		if(document.getElementById('cc2'+paytypeno).value == ""){cc2amt = 0;}
		var dbcamt = parseFloat(document.getElementById('dbc'+paytypeno).value);
		if(document.getElementById('dbc'+paytypeno).value == ""){dbcamt = 0;}
		var cheqamt = parseFloat(document.getElementById('cheq'+paytypeno).value);
		if(document.getElementById('cheq'+paytypeno).value == ""){cheqamt = 0;}
		var voucheramt = parseFloat(document.getElementById('voucheramt'+paytypeno).value);
		if(document.getElementById('voucheramt'+paytypeno).value == ""){voucheramt = 0;}
		var depositamt = parseFloat(document.getElementById('depositamt'+paytypeno).value);
		if(document.getElementById('depositamt'+paytypeno).value == ""){depositamt = 0;}
		var cashcamt = parseFloat(document.getElementById('cashc'+paytypeno).value);
		if(document.getElementById('cashc'+paytypeno).value == ""){cashcamt = 0;}
		var payamt = cashamt + cc1amt + cc2amt + dbcamt + cheqamt + voucheramt + depositamt + cashcamt;
		 if(e.keyCode==40 && nextflow != "" && paytypeno == '5'){
		document.getElementById(nextflow).focus();
		document.getElementById(nextflow).select();
		}
		else if(e.keyCode==38 && upflow != "" && paytypeno == '5'){
		document.getElementById(upflow).focus();
		document.getElementById(upflow).select();
		}
		else{
		document.getElementById('payamt'+paytypeno).value=payamt;
		document.getElementById('change'+paytypeno).value=(payamt-gtamt).toFixed(2);
		if(gtamt <= payamt)
		{
			document.getElementById('balanceamt'+paytypeno).value="0.00";
		}
		else
		{
			document.getElementById('balanceamt'+paytypeno).value=(gtamt-payamt).toFixed(2);
		}
		}
	}
	
	<cfset uuid = createuuid()>
	<cfset custno = "">
	<cfset rem9 = "">
	<cfif isdefined('url.uuid')>
	<cfset uuid = url.uuid>
	<cfquery name='getcustremark' datasource='#dts#'>
	select custno,rem9 from ictrantemp where uuid='#url.uuid#'
	</cfquery>
	<cfset custno = getcustremark.custno>
	<cfset rem9 = getcustremark.rem9>
	</cfif>
	
	var opt = 'Width=500px, Height=250px, Top=300px, left=400px, scrollbars=yes, status=no, resizable=1';
	
	shortcut.add("Ctrl+1",function() {
	
	var answer = confirm('Are you sure to hold on the Order?');
	if(answer)
	{
	var onholdurl = '/default/transaction/expresshaikhim/onholdajax.cfm?uuid='+document.getElementById("uuid").value;
	ajaxFunction(document.getElementById('onholdajax'),onholdurl);
	<cfoutput>
	window.location.href="index.cfm?type=#url.type#";
	</cfoutput>
	}
	
	});
	
	
	shortcut.add("Ctrl+2",function() {
	document.getElementById('paytype').value='0';
	gopay('totalup');
	});
	
	shortcut.add("Ctrl+3",function() {
	document.getElementById('paytype').value='1';
	gopay('totalup1');
	});
	
	shortcut.add("Ctrl+4",function() {
	document.getElementById('paytype').value='2';
	gopay('totalup2');
	});
	
	shortcut.add("Ctrl+5",function() {
	document.getElementById('paytype').value='3';
	gopay('totalup3');
	});
	
	shortcut.add("Ctrl+6",function() {
	document.getElementById('paytype').value='4';
	gopay('totalup4');
	});
	
	shortcut.add("Ctrl+7",function() {
	document.getElementById('paytype').value='5';
	gopay('totalup5');
	});
	
	shortcut.add("Ctrl+8",function() {
	<cfoutput>
	window.open('timemanchine.cfm?type=#url.type#&uuid='+escape(document.getElementById("uuid").value), '',opt);
		</cfoutput>
	});
	
	shortcut.add("Ctrl+9",function() {
	cancel();
	});
	
	function cancel()
	{
	var answer = confirm('Are you sure to cancel the Order?');
	if(answer)
	{
		<cfoutput>
	window.location.href="index.cfm?first=true&type=#url.type#";
	</cfoutput>
	}
	}
	
	function ctrl1()
	{
	var answer = confirm('Are you sure to hold on the Order?');
	if(answer)
	{
	var onholdurl = '/default/transaction/expresshaikhim/onholdajax.cfm?uuid='+document.getElementById("uuid").value+'&remark='+document.getElementById("rem9").value;
	ajaxFunction(document.getElementById('onholdajax'),onholdurl);
	
	<cfoutput>
	window.location.href="index.cfm?type=#url.type#";
	</cfoutput>
	}
	}
	
	function ctrl2()
	{
	window.open('cash.cfm?amt='+escape(document.getElementById("grand").value), '',opt);
	}
	
	function ctrl3()
	{
	window.open('creditcard.cfm?amt='+escape(document.getElementById("grand").value), '',opt);
	}
	
	function ctrl4()
	{
	window.open('multipayment.cfm?amt='+escape(document.getElementById("grand").value), '',opt);
	}

	function ctrl5()
	{
	window.open('net.cfm?amt='+escape(document.getElementById("grand").value), '',opt);
	}
	
	function ctrl7()
	{
	<cfoutput>
	window.open('timemanchine.cfm?type=#url.type#&uuid='+escape(document.getElementById("uuid").value), '',opt);
		</cfoutput>
	}
	
	function revertback()
	{
	var answer = confirm('Are you sure you want to proceed revert?')
	if(answer)
	{
	var newuuid = document.getElementById('oldlist').value;
	<cfoutput>
	window.location.href="index.cfm?type=#type#&uuid="+newuuid;
	</cfoutput>
	}
	}
	
		var t1;
	var t2;
	function getfocus()
	{	
	t1 = window.setInterval("getfocusreal();",100);
	}
	
	function getfocusreal()
	{
		try{
			if(t1 != null)
		{
		document.getElementById('custno1').focus()
		window.clearInterval(t1);
		t1 = null;
		}
		}
		catch(err)
		{
			
		}
	}
	
	
	function getfocus2()
	{
	t2 = window.setInterval("getfocus2real();",100);
	}
	
	function getfocus2real()
	{
		try{
			if(t2 != null)
		{
		document.getElementById('itemno1').focus()
		window.clearInterval(t2);
		t2 = null;
		}
		}
		catch(err)
		{
			
		}
	}
	
	function getfocus3()
	{
	t2 = window.setInterval("getfocus3real();",100);
	}
	
	function getfocus3real()
	{
		try{
		if(t2 != null)
		{
		document.getElementById('aitemno').focus()
		window.clearInterval(t2);
		t2 = null;
		}
		}
		catch(err)
		{
			
		}
	}
	
	function getfocus4()
	{
	t1 = window.setInterval("getfocus4real();",100);
	}
	
	function getfocus4real()
	{
		try{
			if(t1 != null)
		{
		document.getElementById('price_bil1').focus()
		window.clearInterval(t1);
		t1 = null;
		}
		}
		catch(err)
		{
			
		}
	}
	
	function getfocus5()
	{
	t1 = window.setInterval("getfocus5real();",100);
	}
	
	function getfocus5real()
	{
		try{
			if(t1 != null)
		{
		selectcopy();
		window.clearInterval(t1);
		t1 = null;
		}
		}
		catch(err)
		{
			
		}
	}
	
	function getfocus6()
	{
	t1 = window.setInterval("getfocus6real();",100);
	}
	
	function getfocus6real()
	{
		try{
			if(t1 != null)
		{
		document.getElementById('passwordString').focus();
		window.clearInterval(t1);
		t1 = null;
		}
		}
		catch(err)
		{
			
		}
	}
	
	function getfocus7()
	{
	t1 = window.setInterval("getfocus7real();",100);
	}
	
	function getfocus7real()
	{
		try{
			if(t1 != null)
		{
		document.getElementById('serviceamount').focus();
		window.clearInterval(t1);
		t1 = null;
		}
		}
		catch(err)
		{
			
		}
	}
	
	function getfocus8()
	{
	t1 = window.setInterval("getfocus8real();",100);
	}
	
	function getfocus8real()
	{
		try{
			if(t1 != null)
		{
		document.getElementById('freeqty1').focus();
		window.clearInterval(t1);
		t1 = null;
		}
		}
		catch(err)
		{
			
		}
	}
	

	
	
	
	function selectcopy()
	{
	document.getElementById('price_bil1').focus();
	}
	
	function nextIndex(e,thisid,id)
	{
	var itemno = document.getElementById('expressservicelist').value;
	
	if (thisid == 'expressservicelist' && itemno == '')
	{
		if(e.keyCode==40){
		document.getElementById('expqty').focus();
		document.getElementById('expqty').select();
		}
		if(e.keyCode==39){
		document.getElementById('coltype').focus();
		}
		if(e.keyCode==38){
		document.getElementById('eulist').focus();
		}
		if(e.keyCode==13){
			var itemcount = 0;
			try{
				itemcount = document.getElementById('hiditemcount').value * 1;
			}
			catch(err)
			{
			}
			if(itemcount != 0)
			{
				<!---document.getElementById('paytype').value='0';
				ColdFusion.Window.show('totalup');--->
			}
		}
	}
	
	else if (thisid == 'expunitdis1')
	{
		if(e.keyCode==13){
			addnewitem2();
		}
		
	}
	else if (thisid == 'eulist')
	{
		if(e.keyCode==13){
			searchSel('custno','eulist');
			document.getElementById(''+id+'').focus();
		}
		else
		{
			searchSel('custno','eulist');
		}
	}
	else if (thisid == 'searchmembername')
	{
		if(e.keyCode==13){
			ajaxFunction(document.getElementById('searchmemberajax'),'searchmemberajax.cfm?custno='+escape(document.getElementById('searchmemberid').value)+'&name='+escape(document.getElementById('searchmembername').value)+'&contact='+escape(document.getElementById('searchmembertel').value)+'&address='+escape(document.getElementById('searchmemberadd').value)+'&main='+document.getElementById('checkmain').value);
		}
	}
	else
	{
	if(e.keyCode==13){
	document.getElementById(''+id+'').focus();
	try{
	document.getElementById(''+id+'').select();
	}
	catch(err)
	{
	}
	}
	}
	}
	

		
	function selectOptionByValue(selObj, val){ 
    var A= selObj.options, L= A.length; 
    while(L){ 
        if (A[--L].value== val){ 
            selObj.selectedIndex= L; 
            L= 0; 
        } 
    } 
	}
		
	function selectOptionByValue(selObj, val){ 
    var A= selObj.options, L= A.length; 
    while(L){ 
        if (A[--L].value== val){ 
            selObj.selectedIndex= L; 
            L= 0; 
        } 
    } 
	} 
	function convertToEntities(valin) {
    var tstr = valin;
    var bstr = '';

    for (i=0; i<tstr.length; i++) {

        if (tstr.charCodeAt(i)>127) {
            bstr += '&#' + tstr.charCodeAt(i) + ';';
        } else {
            bstr += tstr.charAt(i);
        }
    }
    return bstr;
}
		
	function updateVal()
	{
		
	var validdesp = unescape(document.getElementById('desphid').value);
	
	if (validdesp == "itemisnoexisted")
	{
	document.getElementById('btn_add').value = "Item No Existed";
	document.getElementById('btn_add').disabled = true; 
	
	}
	else
	{
	try
	{
		
	document.getElementById('expressservicelist').value = unescape(decodeURI(document.getElementById('replaceitemno').value));
	}
	catch(err)
	{
	}
	document.getElementById('desp2').value = unescape(decodeURI(document.getElementById('desphid').value));
	document.getElementById('expprice').value = document.getElementById('pricehid').value;
	document.getElementById('costformula').value = document.getElementById('costformulaid').value;
	document.getElementById('btn_add').value = "Add";
	document.getElementById('btn_add').disabled = false; 
	}
	calamtadvance();
	if(document.getElementById('btn_add').value == "Add")
	{
	if(document.getElementById('autoadditem').checked==true)
	{
	addItemAdvance();
	}
	else
	{
		document.getElementById('expqty').focus();
	}
	}
	}
	<cfif getgsetup.expressdisc eq "1">
	function caldisamt()
	{
	var expqty = trim(document.getElementById('expqty').value);
	var expprice = trim(document.getElementById('expprice').value);
	var d1 = document.getElementById('expunitdis1').value;
	var d2 = document.getElementById('expunitdis2').value;
	var d3 = document.getElementById('expunitdis3').value;
	
	var subtotal=expqty*expprice;
	
	temp=(subtotal*d1/100);
	totaldiscount=temp;
	temp=(subtotal-totaldiscount);
	temp=(temp*d2/100);
	totaldiscount=(parseFloat(totaldiscount)+parseFloat(temp));
	temp=(subtotal-totaldiscount);
	temp=(temp*d3/100);
	totaldiscount=(parseFloat(totaldiscount)+parseFloat(temp));
	
	document.getElementById('expdis').value = totaldiscount.toFixed(2);
	}
	<cfelse>
	function caldisamt()
	{
	var qtydis = document.getElementById('expqtycount').value;
	var disamt = document.getElementById('expunitdis').value;
	qtydis = qtydis * 1;
	disamt = disamt * 1;
	var totaldiscount = qtydis * disamt;
	document.getElementById('expdis').value = totaldiscount.toFixed(2);
	}
	</cfif>
	function calamtadvance()
	{
	var expqty = trim(document.getElementById('expqty').value);
	var expprice = trim(document.getElementById('expprice').value);
	var expdis = trim(document.getElementById('expdis').value);
	
	expqty = expqty * 1;
	expprice = expprice * 1;
	expdis = expdis * 1;
	var itemamt = (expqty * expprice) - expdis;
	document.getElementById('expressamt').value =  itemamt.toFixed(2);
	}
	
	function trim(strval)
	{
	return strval.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	}
	
<!--- 	function changeitemdesp()
	{
	var itemdesptrancode = trim(document.getElementById('itemdesptrancode').value);
	var itemdesp = encodeURIComponent(trim(document.getElementById('itemdesp').value));
	var itemdespa = encodeURIComponent(trim(document.getElementById('itemdesp2').value));
	var itemcomment = encodeURIComponent(trim(document.getElementById('itemcomment').value));
	var glaccno = trim(document.getElementById('glt6').value);
<cfoutput>
	var itemdespurl = '/default/transaction/expresshaikhim/itemdespprocess.cfm?uuid=#URLEncodedFormat(uuid)#&trancode='+escape(itemdesptrancode)+'&itemdesp='+escape(itemdesp)+'&itemdespa='+escape(itemdespa)+'&itemcomment='+escape(itemcomment)+'&glaccno='+escape(glaccno);
	ajaxFunction(document.getElementById('changedespajax'),itemdespurl);
	</cfoutput>
	}
	 --->
	function addItemAdvance()
	{
		
	<cfoutput>
	var expressservice=encodeURI(trim(document.getElementById('expressservicelist').value));
	var desp = encodeURI(document.getElementById('desp2').value);
	var expressamt = trim(document.getElementById('expressamt').value);
	var expqty = trim(document.getElementById('expqty').value);
	var expprice = trim(document.getElementById('expprice').value);
	var expunitdis1 = trim(document.getElementById('expunitdis1').value);
	var expunitdis2 = trim(document.getElementById('expunitdis2').value);
	var expunitdis3 = trim(document.getElementById('expunitdis3').value);
	var expdis = trim(document.getElementById('expdis').value);
	var isservi = trim(document.getElementById('isservi').value);
	var tran = trim(document.getElementById('tran').value);
	var driver = trim(document.getElementById('driver').value);
	var refno = trim(document.getElementById('refno').value);
	var trancode = trim(document.getElementById('nextransac').value);
	var glacc = trim(document.getElementById('glacc').value);
	var location = trim(document.getElementById('coltype').value);
	var custno = trim(document.getElementById('custno').value);
	var rem9 = trim(document.getElementById('rem9').value);
	var jobbody = trim(document.getElementById('job').value);
	if (isNaN(expqty))
	{
		alert('Quantity Format is Not Correct');
		return false;
	}
	

	var ajaxurl = '/default/transaction/expresshaikhim/addproductsAjax.cfm?servicecode='+escape(expressservice)+'&desp='+escape(desp)+'&expressamt='+escape(expressamt)+'&expqty='+escape(expqty)+'&expprice='+escape(expprice)+'&dispec1='+escape(expunitdis1)+'&dispec2='+escape(expunitdis2)+'&dispec3='+escape(expunitdis3)+'&dis='+escape(expdis)+'&tran='+escape(tran)+'&tranno='+refno+'&uuid=#URLEncodedFormat(uuid)#&driver='+escape(driver)+'&isservi='+escape(isservi)+'&trancode='+escape(trancode)+'&glacc='+escape(glacc)+'&location='+escape(location)+'&custno='+escape(custno)+'&rem9='+escape(rem9)+'&jobbody='+escape(jobbody);

	 new Ajax.Request(ajaxurl,
      {
        method:'get',
        onSuccess: function(getdetailback){
		document.getElementById('ajaxFieldPro').innerHTML = trim(getdetailback.responseText);
        },
        onFailure: function(){ 
		alert('Error Add Item'); },		
		
		onComplete: function(transport){
		clearformadvance();
		calculatefooter();
		refreshlist();
        }
      })
	
	<!---ajaxFunction(document.getElementById('ajaxFieldPro'),ajaxurl);
	clearformadvance();
	setTimeout('calculatefooter();',750);
	setTimeout('refreshlist();',750);--->
	</cfoutput>
	}
	
	function addmultiitem()
	{
	var itemlisting=document.getElementById('pickitemuuid').value;
	<cfoutput>
<!--- 	for (k=1;k<=200;k=k+1)
	{
	if (document.getElementById('additem_'+k) == null)
	{
	}
	else
	{	
	if (document.getElementById('additem_'+k).checked == true)
	{
	var itemlisting=itemlisting+"&servicecode"+k+"="+document.getElementById('additem_'+k).value;
	}
	}
	} --->
	
	

	var tran = trim(document.getElementById('tran').value);
	var refno = trim(document.getElementById('refno').value);
	var location = trim(document.getElementById('coltype').value);
	var trancode = trim(document.getElementById('nextransac').value);
	var custno = trim(document.getElementById('custno').value);
	
	var ajaxurl2 = '/default/transaction/expresshaikhim/addmultiproductsAjax.cfm?tran='+escape(tran)+'&tranno='+refno+'&uuid=#URLEncodedFormat(uuid)#&trancode='+escape(trancode)+'&custno='+escape(custno)+'&location='+escape(location)+'&itemlisting='+escape(itemlisting);
	
	new Ajax.Request(ajaxurl2,
      {
        method:'get',
        onSuccess: function(getdetailback){
		document.getElementById('ajaxFieldPro').innerHTML = trim(getdetailback.responseText);
        },
        onFailure: function(){ 
		alert('Error Add Item'); },		
		
		onComplete: function(transport){
		clearformadvance();
		setTimeout('calculatefooter();',500);
		refreshlist();
        }
      })
	</cfoutput>
	}
	
	
	function clearformadvance()
	{
	document.getElementById('expressservicelist').value = '';
	document.getElementById('desp2').value = '';
	document.getElementById('expressamt').value = '0.00';
	document.getElementById('expqty').value = '1';
	document.getElementById('expprice').value = '0.00';
	document.getElementById('expdis').value = '0.00';
	document.getElementById('expunitdis1').value = '0';
	document.getElementById('expunitdis2').value = '0';
	document.getElementById('expunitdis3').value = '0';
	
	jQuery.noConflict();
	(function($) {
	  $(function() {
	$('#expressservicelist').select2('data',{id:"",text:"Choose an Item"});
	<!---$('#expressservicelist').select2('open');--->
		  });
	})(jQuery);
	
	<cfif getgsetup.expressdisc neq "1">
	document.getElementById('expunitdis').value = '0.00';
	document.getElementById('expqtycount').value = '1';
	</cfif>
	}
	

	
	function refreshlist()
	{
	ajaxFunction(document.getElementById('itemlist'),'getBody.cfm?<cfif dts eq "tcds_i"><cfoutput>type=#url.type#&</cfoutput></cfif>uuid='+document.getElementById('uuid').value);
	ajaxFunction(document.getElementById('getqtytotal'),'getqtytotal.cfm?uuid='+document.getElementById('uuid').value);
	}

	function bluradditem(detailitemno)
	{
		
		setTimeout("getitemdetail(document.getElementById('expressservicelist').value);",500);
	}
	
	function getitemdetail(detailitemno)
	{
	if(detailitemno.indexOf('*') != -1)
	{
	var thisitemno = detailitemno.split('*');
	<!---document.getElementById('expressservicelist').value=thisitemno[1];--->
	document.getElementById('expqty').value=1;
	detailitemno=thisitemno[1];
	}
	if(trim(document.getElementById('expressservicelist').value) != "")
	{
    var urlloaditemdetail = '/default/transaction/expresshaikhim/addItemAjax.cfm?itemno='+escape(encodeURI(detailitemno))+'&reftype='+document.getElementById('tran').value+'&custno='+document.getElementById('custno').value;
	
	  new Ajax.Request(urlloaditemdetail,
      {
        method:'get',
        onSuccess: function(getdetailback){
		document.getElementById('itemDetail').innerHTML = trim(getdetailback.responseText);
        },
        onFailure: function(){ 
		alert('Item Not Found'); },		
		
		onComplete: function(transport){
		 <!--- getlocationbal(detailitemno);--->
		
		 updateVal();
        }
      })
	}
	}
	
	function getlocationbal(itemnobal)
	{
	  var urlloaditembal = '/default/transaction/expresshaikhim/balonhand.cfm?itemno='+encodeURI(itemnobal)+'&location='+escape(document.getElementById('locationfr').value);
	
	  new Ajax.Request(urlloaditembal,
      {
        method:'get',
        onSuccess: function(getbalback){
		document.getElementById('itembal').innerHTML = trim(getbalback.responseText);
        },
        onFailure: function(){ 
		alert('Item Not Found'); }
      })
	}
	
	function recalculateall()
	{
	<cfoutput>
    var urlload = '/default/transaction/expresshaikhim/recalculateAjax.cfm?uuid=#URLEncodedFormat(uuid)#';
	</cfoutput>
    new Ajax.Request(urlload,
      {
        method:'get',
        onSuccess: function(flyback){
		document.getElementById('ajaxFieldPro').innerHTML = trim(flyback.responseText);
		calculatefooter2();
        },
        onFailure: function(){ 
		alert('Item Not Found'); },		
		onComplete: function(transport){
			if(document.getElementById('tracksubmit').value == '0')
			 {
			 document.getElementById('tracksubmit').value = '1';	
		 invoicesheet.submit();
			 }
        }
      });
	}
	
	function validformfield()
	{
	var formvar = document.getElementById('invoicesheet');
	var answer = _CF_checkinvoicesheet(formvar);
	recalculateall();
	}
	
	function calculatefooter()
	{
	document.getElementById('gross').value = document.getElementById('hidsubtotal').value;
	var hiditemcount = document.getElementById('hiditemcount').value * 1;
	if (hiditemcount == 0)
	{
	document.getElementById('Submit').disabled = true;
	}
	else
	{
	document.getElementById('nextransac').options.length = 0;
	var droplistmenu = document.getElementById('nextransac');
	for (var i=hiditemcount+1; i > 0;--i){
	addOption(droplistmenu, i, i);
	}

	document.getElementById('Submit').disabled = false;
	}
	calcdisc();
	caltax();
	calcfoot();
	}
	
	function calculatefooter2()
	{
	document.getElementById('gross').value = document.getElementById('hidsubtotal').value;
	var hiditemcount = document.getElementById('hiditemcount').value * 1;
	if (hiditemcount == 0)
	{
	document.getElementById('Submit').disabled = true;
	}
	else
	{
	document.getElementById('nextransac').options.length = 0;
	var droplistmenu = document.getElementById('nextransac');
	for (var i=hiditemcount+1; i > 0;--i){
	addOption(droplistmenu, i, i);
	}

	document.getElementById('Submit').disabled = false;
	}
	if(document.getElementById('dispec1').value * 1 == 0 && document.getElementById('dispec2').value * 1 == 0 && document.getElementById('dispec2').value * 3 == 0)
	{
	calcdisc2();
	}
	else{
	calcdisc();
	}
	caltax();
	calcfoot();
	}
	
	function addOption(selectbox,text,value )
	{
	var optn = document.createElement("OPTION");
	optn.text = text;
	optn.value = value;
	selectbox.options.add(optn);
	}
	function calcfoot()
	{
	var gross = document.getElementById('gross').value * 1;
	var disamt = document.getElementById('disamt_bil').value * 1;
	var taxincl = document.getElementById('taxincl').checked;
	var net = document.getElementById('net');
	var taxamt = document.getElementById('taxamt').value * 1;
	var grand = document.getElementById('grand');
	<cfoutput>
	<cfif getgsetup.dfpos eq "0.05">
	net.value = ((((gross-disamt)*2).toFixed(1))/2).toFixed(2);
	<cfelse>
	net.value = (gross-disamt).toFixed(2);
	</cfif>
	</cfoutput>

	if(taxincl == true)
	{
	
	grand.value = net.value;
	
	}
	else
	{
	var netb = ((net.value * 1) + (taxamt * 1));
	<cfoutput>
	<cfif getgsetup.dfpos eq "0.05">
	grand.value = (((netb*2).toFixed(1))/2).toFixed(2);
	<cfelse>
	grand.value = netb.toFixed(2);
	</cfif>
	</cfoutput>
	}

	
	}
	
	function calcdisc()
	{
	var gross = document.getElementById('gross').value * 1;
	var dispec1 = document.getElementById('dispec1').value * 1;
	var dispec2 = document.getElementById('dispec2').value * 1;
	var dispec3 = document.getElementById('dispec3').value * 1;
	var disamt = document.getElementById('disamt_bil');
	var net = document.getElementById('net');
	var disval = 0;
	
	disval = gross - (gross * (dispec1/100));
	document.getElementById('disbil1').value = gross * (dispec1/100);
	disval = disval - (disval * (dispec2 /100));
	document.getElementById('disbil2').value =disval * (dispec2 /100);
	disval = disval - (disval * (dispec3 /100));
	document.getElementById('disbil3').value = disval * (dispec3 /100);
	net.value = disval.toFixed(2);
	disamtlas = gross - disval;
	disamt.value = disamtlas.toFixed(2);
	
	}
	
	function calcdisc2()
	{
	var gross = document.getElementById('gross').value * 1;
	var dispec1 = document.getElementById('dispec1').value * 1;
	var dispec2 = document.getElementById('dispec2').value * 1;
	var dispec3 = document.getElementById('dispec3').value * 1;
	var disamt = document.getElementById('disamt_bil');
	var net = document.getElementById('net');
	var disval = 0;
	
	disval = disamt;
	net.value = disval.toFixed(2);
	disamtlas = gross - disval;
	disamt.value = disamtlas.toFixed(2);
	
	}
	
	
	function caltax()
	{
	var net = document.getElementById('net').value;
	var taxincl = document.getElementById('taxincl').checked;
	var taxper = document.getElementById('taxper').value;
	var taxamt = document.getElementById('taxamt');
	var grand = document.getElementById('grand');
	var taxval = 0;
	taxper = parseFloat(taxper);
	net = parseFloat(net);

	if (taxincl == true)
	{
	taxval = ((taxper/(100+taxper))*net).toFixed(2);
	taxamt.value = taxval;
	<cfoutput>
	<cfif getgsetup.dfpos eq "0.05">
	grand.value = (((net*2).toFixed(1))/2).toFixed(2);
	<cfelse>
	grand.value = net.toFixed(2);
	</cfif>
	</cfoutput>
	}
	else
	{
	taxval = ((taxper/100)*net).toFixed(2);
	taxamt.value = taxval;
	var netb = (net * 1) + (taxval * 1);
	<cfoutput>
	<cfif getgsetup.dfpos eq "0.05">
	grand.value =(((netb*2).toFixed(1))/2).toFixed(2);
	<cfelse>
	grand.value =netb.toFixed(2);
	</cfif>
	</cfoutput>
	}

	}
	<cfoutput>
	function recalculateamt()
	{
	var ajaxurl = '/default/transaction/expresshaikhim/recalculateAjax.cfm?uuid=#URLEncodedFormat(uuid)#';
	new Ajax.Request(ajaxurl,
      {
        method:'get',
        onSuccess: function(getdetailback){
		document.getElementById('ajaxFieldPro').innerHTML = trim(getdetailback.responseText);
        },
        onFailure: function(){ 
		alert('Error Update Item'); },		
		
		onComplete: function(transport){
		calculatefooter();
        }
      })
	}
	function expand()
	{
	var psnow = document.getElementById('pagesize').value * 1;
	if (psnow == 7)
	{
	document.getElementById('pagesize').value = 20;
	}
	else
	{
	document.getElementById('pagesize').value = 7;
	}
	setTimeout('refreshlist();',750);
	}
	function addnewitem2()
	{
	if(document.getElementById('expressamt').value=='NaN')
	{
	alert('Error in Qty / Price / Discount / Amt');
	return false;
	}
	calamtadvance();

	if(document.invoicesheet.glacc.value == '' || document.invoicesheet.glacc.value.length == 8){
	<cfif getgsetup.PCBLTC eq "Y">
	try
	{
	var stkcost = document.getElementById('stkcost').value * 1;
	var stkprice = document.getElementById('expprice').value * 1;
	if (stkprice < stkcost)
	{
	ColdFusion.Window.show('stkcostcontrol');
	getfocus6();
	}
	else
	{
	addItemControl();
	}
	}
	catch(e)
	{
	addItemControl();
	}
	<cfelse>
	addItemControl();
	</cfif>
	}
	else{
	alert('Check GL account no');
	}
	}
	function addItemControl()
	{
	var itemno = document.getElementById('expressservicelist').value;
	var isservi = document.getElementById('isservi').value;
	var qtyser = document.getElementById('expqty').value;
	
	if (itemno == "")
	{
	alert("Please select item");
	}
	
	else if (isservi == "1" && (qtyser == "" || qtyser == 0))
	{
	<cfif getgsetup.ECAMTOTA eq "Y">
	ColdFusion.Window.show('serviceamount');
	getfocus7();
	<cfelse>
	addItemAdvance();
	</cfif>
	}
	else
	{
	<cfif getgsetup.negstk eq "1">
	addItemAdvance();
	<cfelse>
	try
	{
	var trantype = document.getElementById('tran').value;
	var balstk = document.getElementById('balonhand').value * 1;
	var qtyneeded = document.getElementById('expqty').value * 1;
	var balance = balstk - qtyneeded;
	if (balance < 0 && trantype != "RC" && trantype != "CN" && trantype != "PO")
	{
	ColdFusion.Window.show('negativestock');
	getfocus6();
	}
	else
	{
	addItemAdvance();
	}
	}
	catch(e)
	{
	addItemAdvance();
	}
	</cfif>
	}
	}
	</cfoutput>
	function selectlist(varval,varattb){		
		for (var idx=0;idx<document.getElementById(varattb).options.length;idx++) 
		{
			if (varval==document.getElementById(varattb).options[idx].value) 
			{
				document.getElementById(varattb).options[idx].selected=true;
				
			}
		}
		}
	
	function closetran()
	{
	var answer = confirm('Are you sure to close the Order?');
	if(answer)
	{
	window.close();
	}
	}
	
	function updateProject(Projectno){
			myoption = document.createElement("OPTION");
			myoption.text = Projectno;
			myoption.value = Projectno;
			document.invoicesheet.project.options.add(myoption);
			var indexvalue = document.getElementById("project").length-1;
			document.getElementById("project").selectedIndex=indexvalue;
		}
    </script>
    
    
</head>

<body onkeydown="return getKey()"
<cfif isdefined('url.uuid')>
onLoad="document.getElementById('eulist').focus();"
<cfelseif isdefined('url.first') eq false>
onLoad="document.getElementById('expressservicelist').focus();"
</cfif>
>
<input type="hidden" name="tracksubmit" id="tracksubmit" value="0">
<cfform name="invoicesheet" id="invoicesheet" action="process.cfm" method="post">
<cfoutput>
<input type="hidden" name="checkmain" id="checkmain" value="">
<input type="hidden" name="itemdesptrancode" id="itemdesptrancode" value="">
<input type="hidden" name="hidtrancode" id="hidtrancode" value="">

<input type="hidden" name="b_name" id="b_name" value="" maxlength="35" size="40"/>
<input type="hidden" name="d_name" id="d_name" value="" maxlength="35" size="40" >
<input type="hidden" name="bcode" id="bcode" value="Profile"/>
<input type="hidden" name="b_name2" id="b_name2" value="" maxlength="35" size="40" />
<input type="hidden" name="DCode" id="DCode" value="Profile">
<input type="hidden" name="d_name2" id="d_name2" value="" maxlength="35" size="40" >
<input type="hidden" name="b_add1" id="b_add1" value="" maxlength="35" size="40">
<input type="hidden" name="d_add1" id="d_add1" value="" maxlength="35" size="40">
<input type="hidden" name="b_add2" id="b_add2" value="" maxlength="35" size="40">
<input type="hidden" name="d_add2" id="d_add2" value="" maxlength="35" size="40">
<input type="hidden" name="b_add3" id="b_add3" value="" maxlength="35" size="40">
<input type="hidden" name="d_add3" id="d_add3" value="" maxlength="35" size="40">
<input type="hidden" name="b_add4" id="b_add4" value="" maxlength="35" size="40">
<input type="hidden" name="d_add4" id="d_add4" value="" maxlength="35" size="40">
<input type="hidden" name="b_phone" id="b_phone" value="" maxlength="25" size="40">
<input type="hidden" name="d_phone" id="d_phone" value="" maxlength="25" size="40">
<input type="hidden" name="b_phone2" id="b_phone2" value="" maxlength="25" size="40">
<input type="hidden" name="d_phone2" id="d_phone2" value="" maxlength="25" size="40">
<input type="hidden" name="b_attn" id="b_attn" value="" maxlength="35" size="20">
<input type="hidden" name="d_attn" id="d_attn" value="" maxlength="35" size="20">

<cfset custinputtype='hidden'>

<cfinput type="hidden" name="ptype" id="ptype" bind="cfc:custsupp.getname({tran},'#target_arcust#','#target_apvend#')" bindonload="yes" ><input type="hidden" name="uuid" id="uuid" value="#uuid#">
</cfoutput>

<cfoutput>
<div class="colmask rightmenu">
		<div class="colleft">
			<div class="col1">

<table>
<tr>
<td><label for="dateLabel">Date</label></td>
<cfset datenow=now()>
<cfif getGsetup.autonextdate lte timeformat(now(),'HH')>
<cfset datenow=dateadd('d',1,now())>
<cfelse>
<cfset datenow=now()>
</cfif>
<td style="vertical-align:top;">
        <div class="input-group date">
            <input type="text" id="wos_date" name="wos_date" value="#DateFormat(NOW(),'dd/mm/yyyy')#" class="form-control input-sm"/>
            <span class="input-group-addon">
                <i class="glyphicon glyphicon-calendar" onClick="showCalendarControl(document.getElementById('wos_date'));"></i>

            </span>
        </div>
    
</td>
</tr>
<tr>
<td><label for="suppLabel">Supplier</label></td>
<td style="vertical-align:top;">
<input type="hidden" id="custno" name="custno" />
<a onClick="javascript:ColdFusion.Window.show('createSupplier');" onMouseOver="this.style.cursor='hand';">New</a>
</td>
</tr>

<tr>
<td><label for="suppaddLabel">Supplier Address</label></td>
<td><div id="custinfo"></div></td>
</tr>
<tr>
<th><label for="projectLabel">Project</label></th>
<td style="vertical-align:top;"> 
<cfselect class="form-control input-sm" onChange="ajaxFunction(document.getElementById('projectusageajaxfield'),'projectusage.cfm?project='+this.value)" name="project" id="project" bind="cfc:custsupp.getproject('#dts#','#Hlinkams#')" bindonload="yes" display="projectdesp" value="source" />
</td>
</tr>

<tr>
<th><label for="jobLabel">Job</label></th>
<td style="vertical-align:top;">
<cfselect class="form-control input-sm" name="job" id="job" bind="cfc:custsupp.getjob('#dts#','#Hlinkams#')" bindonload="yes" display="jobdesp" value="source" />
</td>
</tr>

</table>

</div>
<div class="col2">


<table>
<tr>
<th><label for="refnoLabel">Refno</label></th>
<td style="font-family:'Times New Roman', Times, serif; font-size:14">
<cfinput class="form-control input-sm" type="hidden" name="tran" id="tran" value="#url.type#">

<div class="col-sm-6">      
<div class="form-group">  
<cfinput type="text" name="refno" class="form-control input-sm" id="refno" bind="cfc:refnobill.getrefno({tran},'#dts#',{refnoset})" bindonload="yes" required="yes" onKeyUp="nextIndex('refno','custno');">
</div>
</div>
<div class="col-sm-6">      
<div class="form-group"> 
<cfselect class="form-control input-sm" name="refnoset" id="refnoset" bind="cfc:refnobill.getrefnoset({tran},'#dts#')" bindonload="yes" display="lastno" value="counter" />
</div></div>
</td>
</tr>
<tr>
	<cfquery name="getnewtrancode" datasource="#dts#">
		select max(trancode) as newtrancode
		from ictrantemp
		where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
        </cfquery>
        <cfif getnewtrancode.recordcount eq 0>
            <cfset newtrancode=1>
        <cfelse>
            <cfset newtrancode = val(getnewtrancode.newtrancode)+1>
        </cfif>
        <cfquery name="newtranqy" datasource="#dts#">
        SELECT #newtrancode# as trancode
        union
        SELECT trancode FROM ictrantemp where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#"> 
        ORDER BY trancode desc
        </cfquery>
  
  <input type="checkbox" style="display:none" name="activatebarcode" id="activatebarcode" value="Y" />
  <input type="hidden" name="pagesize" id="pagesize" value="7" />
  <cfinput type="hidden" name="glacc" id="glacc" maxlength="10" size="10" mask="9999/999" />
<input type="hidden" name="costformula" id="costformula" value="" readonly>


<td><div id="ajaxFieldPro" name="ajaxFieldPro" style="display:none"> </div><div id="ajaxFieldPro2" name="ajaxFieldPro2" style="display:none"> </div><label for="currencyLabel">Currency</label></td>
<td>
<div class="col-sm-6">      
<div class="form-group">  
<cfinput class="form-control input-sm" type="text" name="currcode" id="currcode" size="10"  /><input type="hidden" name="currcodehid" id="currcodehid" value="">
</div></div>
<div class="col-sm-6">      
<div class="form-group">  
<cfinput type="text" class="form-control input-sm" name="currrate" id="currrate" bind="cfc:custsupp.getcurrrate('#dts#',{currcode},'#target_currency#')" bindonload="yes" size="5" />
</div></div>
</td>
</tr>

<tr>
<th><label for="agentLabel">Agent</label></th>
<td>
<div class="col-sm-8">      
<div class="form-group">  
<cfselect name="agent" class="form-control input-sm" id="agent" bind="cfc:custsupp.getagent('#dts#','#Hlinkams#')" bindonload="yes" display="agentdesp" value="agent" />
<input type="hidden" name="agenthid" id="agenthid" value="">
</div></div>
</td>
<div id="changedespajax"></div>
<div id="onholdajax"></div>
</tr>

<tr>
<th><label for="termLabel">Term</label></th>
<td>
<div class="col-sm-5">      
<div class="form-group">  
<cfselect name="term" class="form-control input-sm" id="term" bind="cfc:custsupp.getterms('#dts#','#target_icterm#')" bindonload="yes" display="termdesp" value="term" /><input type="hidden" name="termhid" id="termhid" value="">
</div></div>
<div class="col-sm-5">      
<div class="form-group"> 
<input type="button" class="form-control input-sm" style="font: medium bolder;background-color:##FF0000; color:##FFFFFF" name="remarkbtn" id="remarkbtn" value="Remarks" onClick="ColdFusion.Window.show('remarks');setTimeout('updateremark2();',1000);">
</div></div>

</td>
</tr>

</table>
</div></div></div>

<div style="display:none">
<cfselect name="driver" id="driver" bind="cfc:custsupp.geteu('#dts#')" bindonload="yes" display="eudesp" value="driverno" /> <input type="hidden" name="driverhid" id="driverhid" value="">
</div>
<table width="100%">
<td colspan="4" height="150">
<cfset datashow = "yes">
<cfif getpin2.h1360 neq 'T'>
<cfset datashow = "no">
</cfif>
<cfquery name="getictrantemp" datasource="#dts#">
SELECT * FROM ictrantemp WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#"> order by trancode
</cfquery>
<div id="itemlist" style="height:178px; overflow:scroll;">
<a onMouseOver="JavaScript:this.style.cursor='hand'" onClick="document.getElementById('itemdesptrancode').value='#getictrantemp.trancode#';ColdFusion.Window.show('itemdesp');">#getictrantemp.desp#</a>
<table width="100%">
<tr>
<th width="2%">No</th>
<cfif getdisplay.simple_itemno eq 'Y'><th width="15%" ><label for="termLabel">Item Code</label></th></cfif>
<cfif getdisplay.simple_desp eq 'Y'><th width="30%" ><label for="termLabel">Description</label></th></cfif>
<cfif getdisplay.simple_qty eq 'Y'><th width="10%" ><label for="termLabel">Quantity</label></th></cfif>
<th width="10%" align="center"><label for="termLabel">Unit</label></th>
<th width="10%"><label for="termLabel">Action</label></th>
</tr>

<cfloop query="getictrantemp">

<cfquery name="getiteminfo" datasource="#dts#">
select sizeid,colorid,brand,category,wos_group,shelf,costcode,unit,unit2,unit3,unit4,unit5,unit6 from icitem where itemno='#getictrantemp.itemno#'
</cfquery>

<tr <cfif (getictrantemp.currentrow mod 2) eq 0>style="background-color:##33FFFF"</cfif> onMouseOut="javascript:this.style.backgroundColor='<cfif (getictrantemp.currentrow mod 2) eq 0>33FFFF</cfif>';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
<td nowrap>#getictrantemp.currentrow#</td>
<cfif getdisplay.simple_itemno eq 'Y'><td nowrap ><a onMouseOver="JavaScript:this.style.cursor='hand'" onClick="document.getElementById('itemdesptrancode').value='#getictrantemp.trancode#';ColdFusion.Window.show('itemdesp');">#getictrantemp.itemno#</a></td></cfif>
<cfif getdisplay.simple_desp eq 'Y'><td nowrap><a onMouseOver="JavaScript:this.style.cursor='hand'" onClick="document.getElementById('itemdesptrancode').value='#getictrantemp.trancode#';ColdFusion.Window.show('itemdesp');"><cfif getictrantemp.rem10 neq "">(PACKAGE : #getictrantemp.rem10#) 
</cfif>
</a></td></cfif>
<cfif getdisplay.simple_location eq 'Y'><td nowrap>
<select name="coltypelist#getictrantemp.trancode#" id="coltypelist#getictrantemp.trancode#" onChange="updaterow('#getictrantemp.trancode#');">
<option value="">Choose a location</option>
<cfloop query="getlocation">
<option value="#getlocation.location#" <cfif getictrantemp.location eq getlocation.location>selected</cfif>>#getlocation.location# - #getlocation.desp#</option>
</cfloop>
</select>
</td></cfif>

<cfif getdisplay.simple_qty eq 'Y'><td nowrap align="right"><input type="text" name="qtylist#getictrantemp.trancode#" id="qtylist#getictrantemp.trancode#" value="#val(getictrantemp.qty_bil)#" size="5" onBlur="updaterow('#getictrantemp.trancode#');" onKeyup="if(this.value != '#val(getictrantemp.qty_bil)#'){document.getElementById('updatebtn#getictrantemp.trancode#').style.display='block';}else{document.getElementById('updatebtn#getictrantemp.trancode#').style.display='none';}"></td></cfif>

<td align="center"><select name="unitlist#getictrantemp.trancode#" id="unitlist#getictrantemp.trancode#" onChange="updaterow('#getictrantemp.trancode#');">
<option value="">Select a Unit</option>
<cfif getiteminfo.unit neq "">
<option value="#getiteminfo.unit#" <cfif getictrantemp.unit_bil eq getiteminfo.unit>selected</cfif>>#getiteminfo.unit#</option>
</cfif>
<cfif getiteminfo.unit2 neq "">
<option value="#getiteminfo.unit2#" <cfif getictrantemp.unit_bil eq getiteminfo.unit2>selected</cfif>>#getiteminfo.unit2#</option>
</cfif>
<cfif getiteminfo.unit3 neq "">
<option value="getiteminfo.unit3" <cfif getictrantemp.unit_bil eq getiteminfo.unit3>selected</cfif>>#getiteminfo.unit3#</option>
</cfif>
<cfif getiteminfo.unit4 neq "">
<option value="#getiteminfo.unit4#" <cfif getictrantemp.unit_bil eq getiteminfo.unit4>selected</cfif>>#getiteminfo.unit4#</option>
</cfif>
<cfif getiteminfo.unit5 neq "">
<option value="#getiteminfo.unit5#" <cfif getictrantemp.unit_bil eq getiteminfo.unit5>selected</cfif>>#getiteminfo.unit5#</option>
</cfif>
<cfif getiteminfo.unit6 neq "">
<option value="#getiteminfo.unit6#" <cfif getictrantemp.unit_bil eq getiteminfo.unit6>selected</cfif>>#getiteminfo.unit6#</option>
</cfif>
</select>
</td>

<td nowrap><input type="button" name="deletebtn#getictrantemp.trancode#" id="deletebtn#getictrantemp.trancode#" onClick="if(confirm('Are You Sure You Want To Delete?')){deleterow('#getictrantemp.trancode#')}" value="DELETE"/>&nbsp;<img id="updatebtn#getictrantemp.trancode#" name="updatebtn#getictrantemp.trancode#" src="/images/tick.gif" width="15" height="15" style="cursor:pointer; display:none;"></td>
<cfif getdisplay.simple_location neq 'Y'>
<input type="hidden" name="coltypelist#getictrantemp.trancode#" id="coltypelist#getictrantemp.trancode#" value="#getictrantemp.location#" />
</cfif>

<cfif getdisplay.simple_job neq 'Y'>
<input type="hidden" name="joblist#getictrantemp.trancode#" id="joblist#getictrantemp.trancode#" value="#getictrantemp.job#" />
</cfif>

<cfif getdisplay.simple_brem1 neq 'Y'>
<input type="hidden" name="brem1list#getictrantemp.trancode#" id="brem1list#getictrantemp.trancode#" value="#getictrantemp.brem1#" />
</cfif>
<cfif getdisplay.simple_brem2 neq 'Y'>
<input type="hidden" name="brem2list#getictrantemp.trancode#" id="brem2list#getictrantemp.trancode#" value="#getictrantemp.brem2#" />
</cfif>

<cfif getdisplay.simple_qty neq 'Y'>
<input type="hidden" name="qtylist#getictrantemp.trancode#" id="qtylist#getictrantemp.trancode#" value="#val(getictrantemp.qty_bil)#" />
</cfif>
<cfif getdisplay.simple_packing neq 'Y'>
<input type="hidden" name="promotiontype#getictrantemp.trancode#" id="promotiontype#getictrantemp.trancode#" value="" />
</cfif>

<input type="hidden" name="brem4#getictrantemp.trancode#" id="brem4#getictrantemp.trancode#" value="#getictrantemp.brem4#" />

</tr>
</cfloop>
<cfquery name="getsumictrantemp" datasource="#dts#">
SELECT sum(qty_bil)as sumqty FROM ictrantemp WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#"> order by trancode desc
</cfquery>
</table>
</div>

</td>
</tr>

<cfset inputtype = "text">

<tr>
<th><cfselect style="display:none" name="nextransac" id="nextransac" query="newtranqy" display="trancode" value="trancode" />
<label for="productLabel">Choose a product</label><input type="checkbox" name="autoadditem" id="autoadditem" value="1" checked style="visibility:hidden">
</th>
<td>

<div class="col-sm-6">      
<div class="form-group">

<input type="hidden"  id="expressservicelist" class="itemno" name="expressservicelist" onKeyUp="nextIndex(event,'expressservicelist','expqty');"   data-placeholder="Choose an Item" />
<br>
<br>
<input type="button" id="searchitembtn" onClick="ColdFusion.Window.show('searchitem');getfocus2();" value="Search" align="right" />
</div></div>
<!---
<cfinput type="text" name="expressservicelist" id="expressservicelist" size="26" onKeyUp="nextIndex(event,'expressservicelist','expqty');"/>--->


<cfif getmodule.location neq '1'>
<div style="visibility:hidden">
<select name="coltype" id="coltype" onKeyUp="nextIndex(event,'coltype','expressservicelist');">
<option value="">Choose a location</option>
<cfloop query="getlocation">
<option value="#getlocation.location#" <cfif getgsetup.ddllocation eq getlocation.location>selected</cfif>>#getlocation.location# - #getlocation.desp#</option>
</cfloop>
</select>
<cfelse>
<select name="coltype" id="coltype" onKeyUp="nextIndex(event,'coltype','expressservicelist');">
<option value="">Choose a location</option>
<cfloop query="getlocation">
<option value="#getlocation.location#" <cfif getgsetup.ddllocation eq getlocation.location>selected</cfif>>#getlocation.location# - #getlocation.desp#</option>
</cfloop>
</select>
</div>
</cfif>

</td>
<td width="50%" colspan="2" rowspan="4">
<div id="projectusageajaxfield"  style="height:178px; overflow:scroll;">

</div>
</td>
</tr>
<cfinput type="hidden" class="form-control input-sm" name="dispec2" id="dispec2" value="0" validate="float" validateat="onblur" message="Please key in numeric value" onKeyUp="calcdisc();caltax();calcfoot();"/><input type="hidden" name="disbil2" id="disbil2" />
  <cfinput type="hidden" class="form-control input-sm" name="dispec3" id="dispec3" value="0" validate="float" validateat="onblur" message="Please key in numeric value" onKeyUp="calcdisc();caltax();calcfoot();"/><input type="hidden" name="disbil3" id="disbil3" />
<input type="hidden" name="desp2" id="desp2" size="40" onKeyUp="nextIndex(event,'desp','expqty');" >
<cfinput type="hidden" name="gross" id="gross" readonly="yes" value="0.00"  />
<input type="hidden" style="font: large bolder" name="expqty" id="expqty" size="10" maxlength="10" value="1" onKeyUp="calamtadvance();nextIndex(event,'expqty','expprice');<cfif getgsetup.expressdisc neq "1">document.getElementById('expqtycount').value = this.value;</cfif>" >
<div style="display:none"><input name="btn_add" style="font: medium bolder" id="btn_add" type="button" value="Add" onClick="addnewitem2();"></div>
<tr>
  <td></td>
  <td></td>
  <td></td>
<td style="display:none">
<div class="col-sm-5">      
  <div class="form-group">   
  <cfinput type="text" class="form-control input-sm" name="dispec1" id="dispec1" value="0" validate="float" validateat="onblur" message="Please key in numeric value" onKeyUp="calcdisc();caltax();calcfoot();" /><input type="hidden" name="disbil1" id="disbil1" />
  </div></div>
  <div class="col-sm-8">      
  <div class="form-group">  
  <cfinput type="text" class="form-control input-sm" name="disamt_bil" id="disamt_bil" value="0.00" validate="float" validateat="onblur" message="Please key in numeric value" onKeyUp="caltax();calcfoot();" />
  </div>
  </div>
<div class="col-sm-8">      
  <div class="form-group">
<input type="text" class="form-control input-sm" name="net" id="net" value="0.00" readonly />
</div></div>
</td>
</tr>

<tr>
<td></td>
<td></td>
<input type="hidden" name="expprice" id="expprice" size="15" maxlength="15" value="0.00" onKeyUp="calamtadvance();nextIndex(event,'expprice','expqtycount')"  >
<input type="hidden" name="expqtycount" id="expqtycount" size="3" value="1" onKeyUp="caldisamt();calamtadvance();nextIndex(event,'expqtycount','expunitdis')" >
<input type="hidden" name="expunitdis" id="expunitdis" size="5" value="0.00" onKeyUp="caldisamt();calamtadvance();nextIndex(event,'expdis','btn_add')" />
<input type="hidden" name="expressamt" id="expressamt" size="10" value="0.00" readonly >
  <td></td>
<td style="display:none">
<div class="col-sm-2">      
  <div class="form-group">
<input type="checkbox" name="taxincl" id="taxincl" value="T" onClick="caltax()" <cfif getgsetup.taxincluded eq "Y">checked </cfif> />&nbsp;
  <cfquery name="getTaxCode" datasource="#dts#">
  SELECT "" as code, "" as rate1
  union all
  SELECT code,rate1 FROM #target_taxtable#
  </cfquery>
  <cfquery name="getdf" datasource="#dts#">
        SELECT df_salestax,df_purchasetax FROM gsetup
        </cfquery>
        
        <cfquery name="taxrate" datasource="#dts#">
        
		<cfif (tran eq 'RC' or tran eq 'PO' or tran eq 'PR') and getdf.df_purchasetax neq "">
        SELECT 
        "#getdf.df_purchasetax#" as code
         union all
        <cfelseif tran eq 'DN' or tran eq 'CN'>
        <cfelseif getdf.df_salestax neq "">
        SELECT 
        "#getdf.df_salestax#" as code
         union all
		</cfif>
        SELECT code FROM #target_taxtable# 
        <cfif tran eq 'RC' or tran eq 'PO' or tran eq 'PR' >
        WHERE tax_type <> "ST"
        <cfif getdf.df_purchasetax neq "">
        and code <> "#getdf.df_purchasetax#"
		</cfif>
        <cfelseif tran eq 'DN' or tran eq 'CN' >
        <cfelse>
        WHERE tax_type <> "PT"
        <cfif getdf.df_purchasetax neq "">
        and code <> "#getdf.df_salestax#"
		</cfif>
        </cfif>
        </cfquery>
  </div></div>
  <div class="col-sm-3">      
  <div class="form-group">
  <cfselect name="taxcode" class="form-control input-sm" id="taxcode" query="taxrate" value="code" display="code" onChange="setTimeout('caltax()',500);" bindonload="yes"/>
  </div></div>
  <div class="col-sm-3">      
  <div class="form-group">
  <cfinput type="#inputtype#" class="form-control input-sm" name="taxper" id="taxper" value="0" size="8" bind="CFC:tax.getTax('#dts#','#target_taxtable#',{taxcode})" onKeyUp="caltax()" bindonload="yes"  />
  </div></div>
  <div class="col-sm-3">      
  <div class="form-group">
  <cfinput type="#inputtype#" class="form-control input-sm" name="taxamt" id="taxamt" value="0.00" size="10" onKeyUp="calcfoot();" />  
  </div></div>
</td>

</tr>
<tr>
<td></td>
<td></td>
<td></td><td style="display:none">
<div class="col-sm-8">      
<div class="form-group">
<input type="text" class="form-control input-sm" style="font: x-large bolder; color:##000; background-color:##FFFF66" name="grand" id="grand" value="0.00" readonly />
</div></div>
</td>
<input type="hidden" name="expunitdis1" id="expunitdis1" size="5" value="0" onKeyUp="caldisamt();calamtadvance();nextIndex(event,'expunitdis1','expunitdis2')"  >
<input type="hidden" name="expunitdis2" id="expunitdis2" size="5" value="0" onKeyUp="caldisamt();calamtadvance();nextIndex(event,'expunitdis2','expunitdis3')" />
<input type="hidden" name="expunitdis3" id="expunitdis3" size="5" value="0" onKeyUp="caldisamt();calamtadvance();nextIndex(event,'expunitdis3','expdis')" />
<input type="hidden" name="expdis" id="expdis" size="10" maxlength="10" value="0.00" onKeyUp="calamtadvance();nextIndex(event,'expdis','btn_add')" onBlur="calamtadvance();">

</tr>
<div id="itembal" style="display:none"></div><div id="itemDetail"  ></div>
<cfinput type="hidden" name="cash" id="cash" value="0.00">
  <cfinput type="hidden" name="credit_card1" id="credit_card1" value="0.00">
  <cfinput type="hidden" name="credit_card2" id="credit_card2" value="0.00">
  <cfinput type="hidden" name="creditcardtype" id="creditcardtype" value="">
  <cfinput type="hidden" name="debit_card" id="debit_card" value="0.00">
  <cfinput type="hidden" name="cheque" id="cheque" value="0.00">
  <cfinput type="hidden" name="voucher" id="voucher" value="0.00">
  <cfinput type="hidden" name="deposit" id="deposit" value="0.00">
  <cfinput type="hidden" name="balance" id="balance" value="0.00">
  <cfinput type="hidden" name="changeamt1" id="changeamt1" value="0.00">
  <cfinput type="hidden" name="cashcamt" id="cashcamt" value="0.00">
  <cfinput type="hidden" name="cctype" id="cctype" value="">
  <cfinput type="hidden" name="cctype2" id="cctype2" value="">
  <cfinput type="hidden" name="checkno" id="checkno" value="">
  <cfinput type="hidden" name="rem7" id="rem7" value="">
  <cfinput type="hidden" name="rem6" id="rem6" value="">
  <input type="hidden" name="rem5" id="rem5" value="">
  <input type="hidden" name="rem6" id="rem6" value="">
  <input type="hidden" name="rem7" id="rem7" value="">
  <input type="hidden" name="rem8" id="rem8" value="">
  <input type="hidden" name="rem9" id="rem9" value="">
  <input type="hidden" name="rem10" id="rem10" value="">
  <input type="hidden" name="rem11" id="rem11" value="">
  <cfset counter = "">

  <tr><td colspan="4" height="2px"><hr></td></tr>
<tr style="display:none">
  <td height="1px" colspan="4" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<cfinput type="button" style="font: medium bolder; display:none" name="Close" id="Close" value="Close" onClick="window.close();"/></td>
</tr>

<tr>

<td colspan="4" align="center">
<input name="cancel_btn" class="btn btn-primary"  style="font: large bolder;background-color:##6600CC; color:##CCCC66" id="cancel_btn" type="button" value="9.CANCEL" onClick="cancel();" size="15" />&nbsp;&nbsp;&nbsp;
<cfinput type="button" class="btn btn-primary" style="font: large bolder;" name="Submit" id="Submit" value="Accept" onClick="validformfield();" disabled/>
</td>
</tr>

</table>
</cfoutput>
</cfform>
        
<cfif getgsetup.negstk neq "1">
<cfwindow center="true" width="300" height="300" name="negativestock" refreshOnShow="true" closable="true" modal="true" title="Negative Stock" initshow="false"
        source="negativestock.cfm" />
</cfif>
<cfif getgsetup.ECAMTOTA eq "Y">
<cfwindow center="true" width="300" height="300" name="serviceamount" refreshOnShow="true" closable="true" modal="true" title="Service Amount" initshow="false"
        source="serviceamount.cfm" />
</cfif>
<cfif getgsetup.PCBLTC eq "Y">
<cfwindow center="true" width="300" height="300" name="stkcostcontrol" refreshOnShow="true" closable="true" modal="true" title="Stock Price Is Lower Than Cost" initshow="false"
        source="stkcostcontrol.cfm" />
</cfif>
 <cfwindow center="true" width="300" height="300" name="timemanchine" refreshOnShow="true" closable="true" modal="true" title="Revert Back To Previous Entry" initshow="false"
        source="timemanchine.cfm?uuid=#uuid#&type=#tran#" /> 

<cfwindow center="true" width="700" height="300" name="totalup" refreshOnShow="true" closable="true" modal="true" title="Total" initshow="false" source="total.cfm?grandtotal={grand}&uuid=#uuid#" />   
<cfwindow center="true" width="700" height="250" name="totalup1" refreshOnShow="true" closable="true" modal="true" title="Total" initshow="false" source="total1.cfm?grandtotal={grand}&uuid=#uuid#" /> 
<cfwindow center="true" width="700" height="250" name="totalup2" refreshOnShow="true" closable="true" modal="true" title="Total" initshow="false" source="total2.cfm?grandtotal={grand}&uuid=#uuid#" /> 
<cfwindow center="true" width="700" height="250" name="totalup3" refreshOnShow="true" closable="true" modal="true" title="Total" initshow="false" source="total3.cfm?grandtotal={grand}&uuid=#uuid#" /> 
<cfwindow center="true" width="700" height="250" name="totalup4" refreshOnShow="true" closable="true" modal="true" title="Total" initshow="false" source="total4.cfm?grandtotal={grand}&uuid=#uuid#" /> 
<cfwindow center="true" width="700" height="600" name="totalup5" refreshOnShow="true" closable="true" modal="true" title="Total" initshow="false" source="total5.cfm?grandtotal={grand}&uuid=#uuid#" />  
<cfwindow center="true" width="700" height="600" name="totalup6" refreshOnShow="true" closable="true" modal="true" title="Payment" initshow="false" source="total6.cfm?grandtotal={grand}&uuid=#uuid#&custno={custno}&type={tran}" /> 
<cfwindow center="true" width="600" height="600" name="neweu" refreshOnShow="true" closable="true" modal="true" title="Create New Member" initshow="false" source="neweu.cfm" />  
<cfwindow center="true" width="700" height="500" name="changeprice" refreshOnShow="true" closable="true" modal="true" title="Edit Price" initshow="false" source="changeprice.cfm?uuid=#uuid#&trancode={hidtrancode}&custno={custno}" />  
<cfif dts eq "tcds_i" and url.type eq "RC">
<cfwindow center="true" width="250" height="150" name="changesellingprice" refreshOnShow="true" closable="true" modal="true" title="Edit Selling Price" initshow="false" source="changesellingprice.cfm?uuid=#uuid#&trancode={hidtrancode}" />  
</cfif>
<cfwindow center="true" width="250" height="150" name="updatefreeqty" refreshOnShow="true" closable="true" modal="true" title="Edit Free Quantity" initshow="false" source="updatefreeqty.cfm?uuid=#uuid#&trancode={hidtrancode}" />  
<cfwindow center="true" width="700" height="550" name="searchmember" refreshOnShow="true" closable="true" modal="true" title="Search Member" initshow="false" source="searchmember.cfm?main={checkmain}" />  
<cfwindow center="true" width="700" height="550" name="remarks" refreshOnShow="true" closable="true" modal="true" title="Search Member" initshow="false" source="remarks.cfm?custno={custno}&tran={tran}" />  
<cfwindow center="true" width="700" height="550" name="itemdesp" refreshOnShow="true" closable="true" modal="true" title="Change Item Description" initshow="false" source="itemdesp.cfm?uuid={uuid}&trancode={itemdesptrancode}" /> 


<cfwindow x="10" y="10" modal="true"  width="1100" height="600" name="createCustomer" refreshOnShow="true"
        title="Add New Customer" initshow="false"
        source="/default/maintenance/createCustomerAjax.cfm" />

<cfwindow x="10" y="10" modal="true"  width="1100" height="600" name="createSupplier" refreshOnShow="true"
        title="Add New Supplier" initshow="false"
        source="/default/maintenance/createSupplierAjax.cfm" />


<cfwindow center="true" width="600" height="400" name="createProjectAjax" refreshOnShow="true"
        title="Create Project" initshow="false"
        source="/default/transaction/createProjectAjax.cfm" />

<cfwindow center="true" width="600" height="400" name="creditlimitcontrol" refreshOnShow="true"
        title="Credit limit" initshow="false"
        source="creditlimitpassword.cfm" />
        
<cfwindow center="true" width="1100" height="500" name="searchitem" refreshOnShow="true" closable="true" modal="false" title="Search Item" initshow="false"
        source="/default/transaction/expresshaikhim/searchitem.cfm?reftype={tran}" />
        
<cfif tran eq 'QUO' and getgsetup.quotationlead eq 'Y'>
        <cfwindow center="true" width="580" height="400" name="findlead" refreshOnShow="true"
        title="Find Lead" initshow="false"
        source="/default/transaction/expresshaikhim/findlead.cfm" />
        </cfif>
 <cfif isdefined('url.uuid')>
 <script type="text/javascript">
 recalculateamt();
 setTimeout('caltax()','1000');
 </script>
 </cfif>
 
<cfquery name="getlast" datasource="#dts#">
SELECT uuid from ictrantemp group by uuid order by trdatetime desc limit 50 
</cfquery>
<cfquery name="emptytemp" datasource="#dts#">
Delete from ictrantemp where trdatetime < "#dateformat(dateadd('d','-14',now()),'YYYY-MM-DD')#" and onhold <> "Y" and uuid not in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getlast.uuid)#" list="yes" separator=",">)
</cfquery>
<cfquery name="cleartemppick" datasource="#dts#">
DELETE FROM expresspickitem WHERE created_on < "#dateformat(dateadd('d','-2',now()),'YYYY-MM-DD')#"
</cfquery>
