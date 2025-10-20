<cfajaximport tags="cfform">
<cfset tran = "cs">
<cfsetting showdebugoutput="no">
<cfquery name="getgsetup" datasource="#dts#">
SELECT filterall,ECAOTA,ECAMTOTA,negstk,PCBLTC,ddlbilltype,expressdisc,displaycostcode,ldriver,autonextdate,ddllocation ,rem5,rem6,rem11,taxincluded,df_cs_cust,dfpos FROM gsetup
</cfquery>

<cfquery name="getgsetup2" datasource="#dts#">
select * from gsetup2

</cfquery>
<cfquery name="getdealermenu" datasource="#dts#">
SELECT * FROM dealer_menu
</cfquery>

<cfquery datasource="#dts#" name="getGeneralInfo">
			select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse 
            from refnoset
			where type = 'CS'
			and counter = '1'
		</cfquery>
        
        <cfif getGeneralInfo.arun eq "1">
        <cfinvoke component="cfc.refno" method="processNum" oldNum="#getGeneralInfo.tranno#" returnvariable="newnextNum" />
        	<cfset actual_nexttranno = newnextNum>
            <cfif (getGeneralInfo.refnocode2 neq "" or getGeneralInfo.refnocode neq "") and getGeneralInfo.presuffixuse eq "1">
				<cfset nexttranno = "CS"&"-"&getGeneralInfo.refnocode&actual_nexttranno&getGeneralInfo.refnocode2>
            <cfelse>
            	<cfset nexttranno = "CS"&"-"&actual_nexttranno>
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
	<title>POS Transaction</title>
	<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
    <script type='text/javascript' src='/ajax/core/engine.js'></script>
	<script type='text/javascript' src='/ajax/core/util.js'></script>
	<script type='text/javascript' src='/ajax/core/settings.js'></script>
    <script type='text/javascript' src='/ajax/core/shortcut.js'></script>
    <script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
    <link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
	<script language="javascript" type="text/javascript" src="/scripts/CalendarControl.js"></script>
    <script type="text/javascript" src="/scripts/prototypenew.js" ></script>
    <script type="text/javascript">
	
	function fillsearch(driverno,name,contact,add1,add2,add3)
	{
		document.getElementById('memberidsearch').value=unescape(driverno);
		document.getElementById('membernamesearch').value=unescape(name);
		document.getElementById('membertelsearch').value=unescape(contact);
		document.getElementById('memberadd1search').value=unescape(add1);
		document.getElementById('memberadd2search').value=unescape(add2);
		document.getElementById('memberadd3search').value=unescape(add3);
	}
	
	
function selectmemberlist(driverno){	
	for (var idx=0;idx<document.getElementById('driver').options.length;idx++) {
		if (driverno==document.getElementById('driver').options[idx].value) {
		document.getElementById('driver').options[idx].selected=true;
		}
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
		var varqtylist = 'qtylist'+rowno;
		var brem4 = 'brem4'+rowno;
		var uuid = document.getElementById('uuid').value;
		var coltypedata = document.getElementById(varcoltype).value;
		var qtylistdata = document.getElementById(varqtylist).value;
		var brem4data = document.getElementById(brem4).value;
		var updateurl = 'updaterow.cfm?uuid='+escape(uuid)+'&coltype='+escape(coltypedata)+'&qty='+escape(qtylistdata)+'&trancode='+rowno+'&brem4='+escape(brem4data);
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
			document.getElementById('tran').value="INV";
			document.getElementById('refno').value=document.getElementById('refnoinv').value;
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
<!--- 		if(nextflow != "")
		{
		nextflow = nextflow +paytypeno;
		}
		if(upflow != ""){
		upflow = upflow + +paytypeno;
		} --->
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
	<cfset driver = "">
	<cfset rem9 = "">
	<cfif isdefined('url.uuid')>
	<cfset uuid = url.uuid>
	<cfquery name='getdriverremark' datasource='#dts#'>
	select driver,rem9 from ictrantemp where uuid='#url.uuid#'
	</cfquery>
	<cfset driver = getdriverremark.driver>
	<cfset rem9 = getdriverremark.rem9>
	</cfif>
	
	var opt = 'Width=500px, Height=250px, Top=300px, left=400px, scrollbars=yes, status=no, resizable=1';
	
	shortcut.add("Ctrl+1",function() {
	
	var answer = confirm('Are you sure to hold on the Order?');
	if(answer)
	{
	var onholdurl = '/default/transaction/POS/onholdajax.cfm?uuid='+document.getElementById("uuid").value;
	ajaxFunction(document.getElementById('onholdajax'),onholdurl);
	
	window.location.href="index.cfm";
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
	window.open('timemanchine.cfm?uuid='+escape(document.getElementById("uuid").value), '',opt);
	});
	
	shortcut.add("Ctrl+9",function() {
	cancel();
	});
	
	function cancel()
	{
	var answer = confirm('Are you sure to cancel the Order?');
	if(answer)
	{
	window.location.href="index.cfm";
	}
	}
	
	function ctrl1()
	{
	var answer = confirm('Are you sure to hold on the Order?');
	if(answer)
	{
	var onholdurl = '/default/transaction/POS/onholdajax.cfm?uuid='+document.getElementById("uuid").value+'&remark='+document.getElementById("rem9").value;
	ajaxFunction(document.getElementById('onholdajax'),onholdurl);
	
	setTimeout('window.location.href="index.cfm";',1000);
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
	window.open('timemanchine.cfm?uuid='+escape(document.getElementById("uuid").value), '',opt);
	}
	
	
	function setunitprice()
	{
	setTimeout("document.getElementById('expprice').value=document.getElementById('priceforunit').value;",500)
	}
	
	function revertback()
	{
	var answer = confirm('Are you sure you want to proceed revert?')
	if(answer)
	{
	var newuuid = document.getElementById('oldlist').value;
	window.location.href="index.cfm?uuid="+newuuid;
	}
	}
	var t1;
	var t2;
	
	function getfocus2()
	{
	t2 = setTimeout("document.getElementById('itemno1').focus();",1000);
	}
	function getfocus3()
	{
	t2 = setTimeout("document.getElementById('aitemno').focus();",1000);
	}
	
	function getfocus4()
	{

	setTimeout("document.getElementById('price_bil1').focus();",1000);

	}
	
	function getfocus5()
	{

	setTimeout("selectcopy();",2000);

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
				document.getElementById('paytype').value='0';
				ColdFusion.Window.show('totalup');
			}
		}
	}
	else if (thisid == 'eulist')
	{
		if(e.keyCode==13){
			searchSel('driver','eulist');
			document.getElementById(''+id+'').focus();
		}
		else
		{
			searchSel('driver','eulist');
		}
	}
	else if (thisid == 'searchmembername')
	{
		if(e.keyCode==13){
			ajaxFunction(document.getElementById('searchmemberajax'),'searchmemberajax.cfm?driverno='+escape(document.getElementById('searchmemberid').value)+'&name='+escape(document.getElementById('searchmembername').value)+'&contact='+escape(document.getElementById('searchmembertel').value)+'&address='+escape(document.getElementById('searchmemberadd').value)+'&main='+document.getElementById('checkmain').value);
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
	var droplist = document.getElementById('expunit');
	
	  while (droplist.length > 0)
	  {
		  droplist.remove(droplist.length - 1);
	  }

	
	if (validdesp == "itemisnoexisted")
	{
	document.getElementById('btn_add').value = "Item No Existed";
	document.getElementById('btn_add').disabled = true; 
	alert('Item Not Found');
	}
	else
	{
	var commaSeparatedValueList = document.getElementById('unithid').value;
	var valueArray = commaSeparatedValueList.split(",");
	for(var i=0; i<valueArray.length; i++){
		var opt = document.createElement("option");
        document.getElementById("expunit").options.add(opt);  
        opt.text = valueArray[i];
        opt.value = valueArray[i];

	}
	try
	{
	document.getElementById('expressservicelist').value = unescape(decodeURI(document.getElementById('replaceitemno').value));
	}
	catch(err)
	{
	}
	document.getElementById('desp2').value = unescape(decodeURI(document.getElementById('desphid').value));
	document.getElementById('expunit').selectedIndex =0;
	document.getElementById('expprice').value = document.getElementById('pricehid').value;
	document.getElementById('costformula').value = document.getElementById('costformulaid').value;
	document.getElementById('btn_add').value = "Add";
	document.getElementById('btn_add').disabled = false; 
	}
	calamtadvance();
	
	if(document.getElementById('btn_add').value == "Add")
	{
	<cfif lcase(HcomID) neq "ssuni_i">
	addItemAdvance();
	</cfif>
	}
	}
	<cfif getgsetup.expressdisc eq "1">
	function caldisamt()
	{
	var expqty = trim(document.getElementById('expqty').value);
	var expprice = trim(document.getElementById('expprice').value);
	var disamt1 = document.getElementById('expunitdis1').value;
	var disamt2 = document.getElementById('expunitdis2').value;
	var disamt3 = document.getElementById('expunitdis3').value;
	disamt1 = disamt1 * 0.01;
	disamt2 = disamt2 * 0.01;
	disamt3 = disamt3 * 0.01;
	var totaldiscount = ((((expqty * expprice) * disamt1)+ (((expqty * expprice)-(expqty * expprice) * disamt1))*disamt2)+(((expqty * expprice)-(((expqty * expprice)-(expqty * expprice) * disamt1))*disamt2))*disamt3);
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
	document.getElementById('expressamt').value =  itemamt.toFixed(3);
	}
	
	function trim(strval)
	{
	return strval.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	}
	
	function addItemAdvance()
	{
	<cfoutput>
	var expressservice=encodeURI(trim(document.getElementById('expressservicelist').value));
	var desp = encodeURI(document.getElementById('desp2').value);
	var expressamt = trim(document.getElementById('expressamt').value);
	var expqty = trim(document.getElementById('expqty').value);
	var expprice = trim(document.getElementById('expprice').value);
	var expunit = trim(document.getElementById('expunit').value);
	var expunitdis1 = trim(document.getElementById('expunitdis1').value);
	var expunitdis2 = trim(document.getElementById('expunitdis2').value);
	var expunitdis3 = trim(document.getElementById('expunitdis3').value);
	var expdis = trim(document.getElementById('expdis').value);
	var isservi = trim(document.getElementById('isservi').value);
	var tran = trim(document.getElementById('tran').value);
	var custno = trim(document.getElementById('custno').value);
	var refno = trim(document.getElementById('refno').value);
	var trancode = trim(document.getElementById('nextransac').value);
	var glacc = trim(document.getElementById('glacc').value);
	var brem1 = trim(document.getElementById('coltype').value);
	var driver = trim(document.getElementById('driver').value);
	var rem9 = trim(document.getElementById('rem9').value);
	
	
	var ajaxurl = '/default/transaction/POS/addproductsAjax.cfm?servicecode='+escape(expressservice)+'&desp='+escape(desp)+'&expressamt='+escape(expressamt)+'&expqty='+escape(expqty)+'&expprice='+escape(expprice)+'&unit='+escape(expunit)+'&dispec1='+escape(expunitdis1)+'&dispec2='+escape(expunitdis2)+'&dispec3='+escape(expunitdis3)+'&dis='+escape(expdis)+'&tran='+escape(tran)+'&tranno='+refno+'&uuid=#URLEncodedFormat(uuid)#&custno='+escape(custno)+'&isservi='+escape(isservi)+'&trancode='+escape(trancode)+'&glacc='+escape(glacc)+'&brem1='+escape(brem1)+'&driver='+escape(driver)+'&rem9='+escape(rem9);
	
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
	
	function clearformadvance()
	{
	document.getElementById('expressservicelist').value = '';
	document.getElementById('desp2').value = '';
	document.getElementById('expressamt').value = '0.00';
	document.getElementById('expqty').value = '1';
	document.getElementById('expprice').value = '0.00';
	document.getElementById('expunit').value = '';
	document.getElementById('expdis').value = '0.00';
	document.getElementById('expunitdis1').value = '0';
	document.getElementById('expunitdis2').value = '0';
	document.getElementById('expunitdis3').value = '0';
	document.getElementById('expressservicelist').focus();
	<cfif getgsetup.expressdisc neq "1">
	document.getElementById('expunitdis').value = '0.00';
	document.getElementById('expqtycount').value = '1';
	</cfif>
	}
	
	function refreshlist()
	{
	ajaxFunction(document.getElementById('itemlist'),'getBody.cfm?uuid='+document.getElementById('uuid').value);
	ajaxFunction(document.getElementById('getqtytotal'),'getqtytotal.cfm?uuid='+document.getElementById('uuid').value);
	}
	
	function getitemdetail(detailitemno)
	{
	if(detailitemno.indexOf('*') != -1)
	{
	var thisitemno = detailitemno.split('*');
	document.getElementById('expressservicelist').value=thisitemno[1];
	document.getElementById('expqty').value=thisitemno[0];
	detailitemno=thisitemno[1];
	}
	if(trim(document.getElementById('expressservicelist').value) != "")
	{
    var urlloaditemdetail = '/default/transaction/POS/addItemAjax.cfm?itemno='+escape(encodeURI(detailitemno))+'&reftype='+document.getElementById('tran').value;
	
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
	  var urlloaditembal = '/default/transaction/POS/balonhand.cfm?itemno='+encodeURI(itemnobal)+'&location='+escape(document.getElementById('locationfr').value);
	
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
    var urlload = '/default/transaction/POS/recalculateAjax.cfm?uuid=#URLEncodedFormat(uuid)#';
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
		 invoicesheet.submit();
        }
      });
	}
	
	function validformfield()
	{
	var formvar = document.getElementById('invoicesheet');
	var answer = _CF_checkinvoicesheet(formvar);
	if (answer)
	{
	recalculateall();
	}
	else
	{
	}
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
	var ajaxurl = '/default/transaction/POS/recalculateAjax.cfm?uuid=#URLEncodedFormat(uuid)#';
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
	setTimeout("document.getElementById('passwordString').focus();",500);
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
	setTimeout("document.getElementById('serviceamount').focus();",500);
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
	setTimeout("document.getElementById('passwordString').focus();",500);
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
	function getmember()
	{
	if (document.getElementById('memberdetail').checked)
	{
	var memberurl = '/default/transaction/POS/memberdetailajax.cfm?detail=1&member='+document.getElementById("driver").value;
	ajaxFunction(document.getElementById('getmemberajax'),memberurl);
	}
	else
	{
	var memberurl = '/default/transaction/POS/memberdetailajax.cfm?detail=0&member='+document.getElementById("driver").value;
	ajaxFunction(document.getElementById('getmemberajax'),memberurl);
	}
	}
    </script>
    
    
</head>

<body 
<cfif isdefined('url.uuid')>
onLoad="document.getElementById('expressservicelist').focus();"
<cfelseif isdefined('url.first') eq false>
onLoad="document.getElementById('expressservicelist').focus();"
</cfif>
>

<cfform name="invoicesheet" id="invoicesheet" action="process.cfm" method="post">
<cfoutput>
<input type="hidden" name="checkmain" id="checkmain" value="">
<input type="hidden" name="hidtrancode" id="hidtrancode" value="">
<cfinput type="hidden" name="ptype" id="ptype" bind="cfc:custsupp.getname({tran},'#target_arcust#','#target_apvend#')" bindonload="yes" ><input type="hidden" name="uuid" id="uuid" value="#uuid#">
</cfoutput>

<cfoutput>
<table width="100%">
<tr>
<th width="20%">Date</th>
<cfset datenow=now()>
<cfif getGsetup.autonextdate lte timeformat(now(),'HH')>
<cfset datenow=dateadd('d',1,now())>
<cfelse>
<cfset datenow=now()>
</cfif>
<td width="30%"><input type="text" name="wos_date" id="wos_date" value="#dateformat(datenow,'DD/MM/YYYY')#" onKeyUp="nextIndex(event,'wos_date','expressservicelist');" readonly /><!--- <img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('wos_date'));">&nbsp;(DD/MM/YYYY) ---></td>
<th style="font-size:20px; color:##000" rowspan="2"><div align="right">Total Pay Amount :</div></th>
<td width="30%" rowspan="2"><div id="onholdajax"></div>
<cfinput type="text" style="font: xx-large bolder; color:##000; background-color:##FFFF66" name="grand" id="grand" value="0.00" readonly="yes" />
</td>
</tr>
<tr>
<th width="20%">Refno</th>
<td width="30%">
<cfinput type="hidden" name="tran" id="tran" value="CS">
<cfif getgsetup.df_cs_cust eq ''>
<cfinput type="hidden" name="custno" id="custno" value="3000/CS1">
<cfelse>
<cfinput type="hidden" name="custno" id="custno" value="#getgsetup.df_cs_cust#">
</cfif>
<cfinput type="text" name="refno" id="refno" required="yes" onKeyUp="nextIndex(event,'refno','wos_date');" value="#nexttranno#" readonly></td>
</tr>

<tr>
<th>Member</th>
<td><input type="text" name="eulist" id="eulist" value="#driver#" onKeyUp="nextIndex(event,'eulist','expressservicelist');getmember();" onBlur="nextIndex(event,'eulist','expressservicelist');getmember();">&nbsp;&nbsp;
 <cfquery name="getdriverdef" datasource="#dts#">
   	 select ldriver from gsetup
</cfquery>
        
<cfquery name="geteuqry" datasource="#dts#">
SELECT "Choose an #getdriverdef.ldriver#" as eudesp, "" as DRIVERNO
union all 
SELECT concat(driverno,' - ',name) as eudesp, driverno FROM driver
</cfquery>
<cfselect name="driver" id="driver" query="geteuqry" display="eudesp" value="driverno" onChange="getmember();" /><input type="checkbox" id="memberdetail" name="memberdetail" value="" onClick="getmember();">&nbsp;&nbsp;<a style="cursor:pointer" onClick="ColdFusion.Window.show('neweu')">New</a> <input type="hidden" name="driverhid" id="driverhid"> &nbsp;&nbsp;<a style="cursor:pointer" onClick="document.getElementById('checkmain').value='out';ColdFusion.Window.show('searchmember')">Search</a>  <input type="hidden" name="driverhid" id="driverhid"></td>
<td colspan="2">
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
  <cfselect style="display:none" name="nextransac" id="nextransac" query="newtranqy" display="trancode" value="trancode" />
  <input type="checkbox" style="display:none" name="activatebarcode" id="activatebarcode" value="Y" />
  <input type="hidden" name="pagesize" id="pagesize" value="7" />
  <cfinput type="hidden" name="glacc" id="glacc" maxlength="10" size="10" mask="9999/999" />
<input type="hidden" name="costformula" id="costformula" value="" readonly>
<div id="ajaxFieldPro" name="ajaxFieldPro" style="display:none"> </div>
<cfinput type="hidden" name="currcode" id="currcode" size="10"  /><input type="hidden" name="currcodehid" id="currcodehid" value="">&nbsp;<cfinput type="hidden" name="currrate" id="currrate" bind="cfc:custsupp.getcurrrate('#dts#',{currcode},'#target_currency#')" bindonload="yes" size="5" />
<div id="getmemberajax">
<input type="hidden" name="membername" id="membername" value="">
<input type="hidden" name="membertel" id="membertel" value="">
<input type="hidden" name="memberadd1" id="memberadd1" value="">
<input type="hidden" name="memberadd2" id="memberadd2" value="">
<input type="hidden" name="memberadd3" id="memberadd3" value="">
</div>
</td>
</tr>
<tr><td colspan="4"><hr /></td></tr>
<tr>
<td colspan="4" height="200">
<cfset datashow = "yes">
<cfif getpin2.h1360 neq 'T'>
<cfset datashow = "no">
</cfif>
<div id="itemlist" style="height:238px; overflow:scroll;">
<table width="100%">
<tr>
<th width="2%">No</th>
<th width="15%">Product Code</th>
<th width="30%">Description</th>
<th width="10%">Collection Type</th>
<th width="10%">Quantity</th>
<th width="8%">Price</th>
<th width="8%">Discount</th>
<th width="8%">Amount</th>
<th width="10%">Action</th>
</tr>
<cfquery name="getictrantemp" datasource="#dts#">
SELECT * FROM ictrantemp WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#"> order by trancode desc
</cfquery>
<cfloop query="getictrantemp">
<tr <cfif (getictrantemp.currentrow mod 2) eq 0>style="background-color:##33FFFF"</cfif> onMouseOut="javascript:this.style.backgroundColor='<cfif (getictrantemp.currentrow mod 2) eq 0>33FFFF</cfif>';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
<td nowrap>#getictrantemp.currentrow#</td>
<cfquery name="getaitemnoictran" datasource="#dts#">
select aitemno from icitem where itemno='#getictrantemp.itemno#'
</cfquery>
<td nowrap>#getaitemnoictran.aitemno#</td>
<td nowrap>#getictrantemp.desp#</td>
<td nowrap>
<!--- <select name="coltypelist#getictrantemp.trancode#" id="coltypelist#getictrantemp.trancode#" onChange="if(this.value != '#getictrantemp.brem1#'){document.getElementById('updatebtn#getictrantemp.trancode#').style.display='block';}else{document.getElementById('updatebtn#getictrantemp.trancode#').style.display='none';}" onclick="if(this.value == '' ">
<option value="Cash n Carry" <cfif getictrantemp.brem1 eq "Cash n Carry">Selected</cfif>>Cash & Carry</option>
<option value="Cash n Delivery" <cfif getictrantemp.brem1 eq "Cash n Delivery">Selected</cfif>>Cash & Delivery</option> 
</select> --->
<input type="text" name="coltypelist#getictrantemp.trancode#" id="coltypelist#getictrantemp.trancode#" value="#getictrantemp.brem1#" onClick="if(this.value=='Collection'){this.value = 'Delivery';updaterow('#getictrantemp.trancode#');} else {this.value = 'Collection';updaterow('#getictrantemp.trancode#');}"  readonly="readonly">
</td>
<td nowrap align="right"><input type="text" name="qtylist#getictrantemp.trancode#" id="qtylist#getictrantemp.trancode#" value="#val(getictrantemp.qty_bil)#" size="5" onBlur="updaterow('#getictrantemp.trancode#');" onKeyup="if(this.value != '#val(getictrantemp.qty_bil)#'){document.getElementById('updatebtn#getictrantemp.trancode#').style.display='block';}else{document.getElementById('updatebtn#getictrantemp.trancode#').style.display='none';}"></td>
<td nowrap align="right"><a style="cursor:pointer" onClick="document.getElementById('hidtrancode').value='#getictrantemp.trancode#';ColdFusion.Window.show('changeprice');getfocus5();">#numberformat(val(getictrantemp.price_bil),',.___')#</a></td>
<td nowrap align="right"><input type="text" name="brem4#getictrantemp.trancode#" id="brem4#getictrantemp.trancode#" value="#getictrantemp.brem4#" size="5" onBlur="updaterow('#getictrantemp.trancode#');" onKeyup="if(this.value != '#getictrantemp.brem4#'){document.getElementById('updatebtn#getictrantemp.trancode#').style.display='block';}else{document.getElementById('updatebtn#getictrantemp.trancode#').style.display='none';}"></td>
<td nowrap align="right">#numberformat(val(getictrantemp.amt_bil),',.__')#</td>
<td nowrap><input type="button" name="deletebtn#getictrantemp.trancode#" id="deletebtn#getictrantemp.trancode#" onClick="if(confirm('Are You Sure You Want To Delete?')){deleterow('#getictrantemp.trancode#')}" value="DELETE"/>&nbsp;<img id="updatebtn#getictrantemp.trancode#" name="updatebtn#getictrantemp.trancode#" src="/images/tick.gif" width="15" height="15" style="cursor:pointer; display:none;"><!--- &nbsp;&nbsp;<input type="button" name="Updatebtn#getictrantemp.trancode#" id="updatebtn#getictrantemp.trancode#" onClick="updaterow('#getictrantemp.trancode#');" value="UPDATE" style="display:none"/> ---></td>
</tr>
</cfloop>
<cfquery name="getsumictrantemp" datasource="#dts#">
SELECT sum(qty_bil)as sumqty FROM ictrantemp WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#"> order by trancode desc
</cfquery>
</table>
</div>

</td>
</tr>

<tr>
<th>Choose a product</th>
<td colspan="1">
<cfinput type="text" name="expressservicelist" id="expressservicelist" style="font: large bolder" size="10" onBlur="this.value = this.value.split('___', 1);getitemdetail(this.value);" onKeyUp="nextIndex(event,'expressservicelist','expqty');" <!---autosuggest="cfc:itemno.findItem({cfautosuggestvalue},'#dts#')" autosuggestminlength="1"--->/>
<select name="coltype" id="coltype" onKeyUp="nextIndex(event,'coltype','expressservicelist');">
<option value="Collection">Collection</option>
<option value="Delivery">Delivery</option> 
</select>
<input type="button" id="searchitembtn" onClick="ColdFusion.Window.show('searchitem');getfocus2();" value="Search" align="right" />
</td>
<th>Total Qty</th>
<td><div id="getqtytotal">
<cfquery name="getsumictrantemp" datasource="#dts#">
SELECT sum(qty_bil)as sumqty FROM ictrantemp WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#"> order by trancode desc
</cfquery>
#getsumictrantemp.sumqty#
</div></td>
<td></td>
</tr>

<tr style="display:none">
<th>Description</th>
<td colspan="2"><input type="text" name="desp2" id="desp2" size="30" onKeyUp="nextIndex(event,'desp','expqty');" ></td>
<td rowspan="4">
<div id="itembal" style="display:none"></div><div id="itemDetail"  style="display:none"></div></td>
</tr>

<tr>
  <th>Quantity</th>
  <td colspan="2">
  <input type="text" style="font: large bolder" name="expqty" id="expqty" size="10" maxlength="10" value="1" onKeyUp="calamtadvance();nextIndex(event,'expqty','expressservicelist');<cfif getgsetup.expressdisc neq "1">document.getElementById('expqtycount').value = this.value;</cfif>" >
<cfif lcase(HcomID) eq "ssuni_i">
  <cfselect name="expunit" id="expunit"  onKeyUp="nextIndex(event,'expunit','expprice');" onChange="ajaxFunction(document.getElementById('ajaxfieldgetunitprice'),'/default/transaction/POS/getunitpriceAjax.cfm?itemno='+document.getElementById('expressservicelist').value+'&unit='+document.getElementById('expunit').value);setunitprice();"></cfselect>
  <cfelse>
  <cfselect style="display:none" name="expunit" id="expunit"  onKeyUp="nextIndex(event,'expunit','expprice');" onChange="ajaxFunction(document.getElementById('ajaxfieldgetunitprice'),'/default/transaction/POS/getunitpriceAjax.cfm?itemno='+document.getElementById('expressservicelist').value+'&unit='+document.getElementById('expunit').value);setunitprice();"></cfselect>
  </cfif>
  <div id="ajaxfieldgetunitprice"></div>
  </td>
</tr>

<tr>
  <th>Price</th>
  <td colspan="2"><input type="<cfif getpin2.h1360 eq 'T'>text<cfelse>hidden</cfif>" name="expprice" id="expprice" size="15" maxlength="15" value="0.00" onKeyUp="calamtadvance();nextIndex(event,'expprice',<cfif getgsetup.expressdisc eq "1">'expunitdis1'<cfelse>'expqtycount'</cfif>)"  ></td>
</tr>
<tr>
<th>Discount</th>
<td colspan='2'>
  <cfif getgsetup.expressdisc eq "1">
  <input type="<cfif getpin2.h1360 eq 'T'>text<cfelse>hidden</cfif>" name="expunitdis1" id="expunitdis1" size="5" value="0" onKeyUp="caldisamt();calamtadvance();nextIndex(event,'expunitdis1','expunitdis2')"  >
%&nbsp;&nbsp;
<input type="<cfif getpin2.h1360 eq 'T' >text<cfelse>hidden</cfif>" name="expunitdis2" id="expunitdis2" size="5" value="0" onKeyUp="caldisamt();calamtadvance();nextIndex(event,'expunitdis2','expunitdis3')" />
%&nbsp;&nbsp;
<input type="<cfif getpin2.h1360 eq 'T'>text<cfelse>hidden</cfif>" name="expunitdis3" id="expunitdis3" size="5" value="0" onKeyUp="caldisamt();calamtadvance();nextIndex(event,'expunitdis3','expdis')" />%
<cfelse>
<input type="hidden" name="expunitdis1" id="expunitdis1" size="5" value="0" />
<input type="hidden" name="expunitdis2" id="expunitdis2" size="5" value="0" />
<input type="hidden" name="expunitdis3" id="expunitdis3" size="5" value="0" />
<input type="<cfif getpin2.h1360 eq 'T'>text<cfelse>hidden</cfif>" name="expqtycount" id="expqtycount" size="3" value="1" onKeyUp="caldisamt();calamtadvance();nextIndex(event,'expqtycount','expunitdis')" >
&nbsp;&nbsp;
<input type="<cfif getpin2.h1360 eq 'T'>text<cfelse>hidden</cfif>" name="expunitdis" id="expunitdis" size="5" value="0.00" onKeyUp="caldisamt();calamtadvance();nextIndex(event,'expdis','btn_add')" />
&nbsp;&nbsp;
</cfif>
<input type="<cfif getpin2.h1360 eq 'T'>text<cfelse>hidden</cfif>" name="expdis" id="expdis" size="10" maxlength="10" value="0.00" onKeyUp="calamtadvance();nextIndex(event,'expdis','btn_add')" onBlur="calamtadvance();"></td>
  </tr>
<input type="hidden" name="expressamt" id="expressamt" size="10" value="0.00" readonly >




<tr <cfif lcase(HcomID) neq "ssuni_i">style="display:none"</cfif>><td colspan="4" align="center"><input type="hidden" name="paytype" id="paytype" value=""><input name="btn_add" style="font: medium bolder" id="btn_add" type="button" value="Add" onClick="addnewitem2();">&nbsp;&nbsp;&nbsp;
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
  <cfinput type="hidden" name="cashcamt" id="cashcamt" value="">
  <cfinput type="hidden" name="cctype" id="cctype" value="">
  <cfinput type="hidden" name="cctype2" id="cctype2" value="">
  <cfinput type="hidden" name="checkno" id="checkno" value="">
  <cfinput type="hidden" name="rem7" id="rem7" value="">
  <cfinput type="hidden" name="rem6" id="rem6" value="">
  <cfset counter = "">
  <cfif isdefined('form.counterchoose')>
  <cfset counter = form.counterchoose>
  </cfif>
  <cfinput type="hidden" name="counterinfo" id="counterinfo" value="#counter#">
  
  <!--- <cfinput type="hidden" name="rem9" id="rem9" value=""> --->
</td></tr>
  <tr><td colspan="4" height="2px"><hr></td></tr>
<tr style="display:none">
  <td height="1px" colspan="4" align="center"><cfinput type="button" style="font: medium bolder; display:none" name="Submit" id="Submit" value="Accept" onClick="validformfield();" disabled/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<cfinput type="button" style="font: medium bolder; display:none" name="Close" id="Close" value="Close" onClick="window.close();"/></td>
</tr>

<cfset inputtype = "text">
<tr>
<td colspan="2">
<table align="left" border="1">
<tr>
<td align="center" valign="middle" style="font:'Times New Roman', Times, serif; font-size:16px;" bgcolor="##CCFF33" onMouseOver="this.style.cursor='hand'"><a onClick="ctrl1();" style="cursor:pointer">On Hold<br><font size="1">ctrl+1</font></a></td>
<!--- <a onClick="ctrl2();"><td align="center" valign="middle" style="font:'Times New Roman', Times, serif; font-size:18px" bgcolor="##CCFF33" onMouseOver="this.style.cursor='hand'">Cash<br><font size="1">ctrl+2</font></td></a>

<a onClick="ctrl3();"><td align="center" valign="middle" style="font:'Times New Roman', Times, serif; font-size:18px" bgcolor="##CCFF33" onMouseOver="this.style.cursor='hand'">Credit Card<br><font size="1">ctrl+3</font></td></a>
<a onClick="ctrl4();"><td align="center" valign="middle" style="font:'Times New Roman', Times, serif; font-size:18px" bgcolor="##CCFF33" onMouseOver="this.style.cursor='hand'">Multi Payment<br><font size="1">ctrl+4</font></td></a>

<a onClick="ctrl5();"><td align="center" valign="middle" style="font:'Times New Roman', Times, serif; font-size:18px" bgcolor="##CCFF33" onMouseOver="this.style.cursor='hand'">Net<br><font size="1">ctrl+5</font></td></a>

<td align="center" valign="middle" style="font:'Times New Roman', Times, serif; font-size:18px"  bgcolor="##CCFF33" >Fast Key<br><font size="1">ctrl+6</font></td> --->
<td align="center" valign="middle" style="font:'Times New Roman', Times, serif; font-size:16px" bgcolor="##CCFF33" onMouseOver="this.style.cursor='hand'"><a onClick="ctrl7();" style="cursor:pointer">On Hold Transactions<br><font size="1">ctrl+8</font></a></td>
<td align="center" valign="middle" style="font:'Times New Roman', Times, serif; font-size:16px" bgcolor="##CCFF33" onMouseOver="this.style.cursor='hand'"><a onClick="document.getElementById('paytype').value='6';gopay('totalup6');" style="cursor:pointer">Save As Invoice</a></td>
</tr>
<tr>
<td colspan="3">
<textarea name="rem9" id="rem9" cols="50" rows="3">#rem9#</textarea>
</td>
</tr>
</table></td>
<td colspan="2">
<table>
<tr>
<th width="100px">Gross</th>
<td><cfinput type="#inputtype#" name="gross" id="gross" readonly="yes" value="0.00"  />
</td>
</tr>
<tr>
<th>Discount</th>
<td>
 <cfinput type="#inputtype#" size="3" name="dispec1" id="dispec1" value="0" validate="float" validateat="onblur" message="Please key in numeric value" onKeyUp="calcdisc();caltax();calcfoot();" />%<input type="hidden" name="disbil1" id="disbil1" />&nbsp;&nbsp;
  <cfinput type="#inputtype#" size="3" name="dispec2" id="dispec2" value="0" validate="float" validateat="onblur" message="Please key in numeric value" onKeyUp="calcdisc();caltax();calcfoot();"/>%<input type="hidden" name="disbil2" id="disbil2" />&nbsp;&nbsp;
  <cfinput type="#inputtype#" size="3" name="dispec3" id="dispec3" value="0" validate="float" validateat="onblur" message="Please key in numeric value" onKeyUp="calcdisc();caltax();calcfoot();"/>%<input type="hidden" name="disbil3" id="disbil3" />&nbsp;&nbsp;&nbsp;
  <cfinput type="#inputtype#" size="5" name="disamt_bil" id="disamt_bil" value="0.00" validate="float" validateat="onblur" message="Please key in numeric value" onKeyUp="caltax();calcfoot();" />
</td> 
</tr>

<tr>
<th>NET</th>
<td><cfinput type="#inputtype#" name="net" id="net" value="0.00" readonly="yes" /> </td>
</tr>
<tr>
<th>Tax</th>
<td>
<div style="visibility:hidden">
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
<cfselect name="taxcode" id="taxcode" query="taxrate" value="code" display="code" onChange="setTimeout('caltax()',500);" bindonload="yes"/></div>
  <!---<input type="hidden" name="taxcode" id="taxcode" value="ZR">--->
  &nbsp;&nbsp;<cfinput type="#inputtype#" name="taxper" id="taxper" value="0" size="8" bind="CFC:tax.getTax('#dts#','#target_taxtable#',{taxcode})" onKeyUp="caltax()" bindonload="yes"  />&nbsp;&nbsp;&nbsp;
  <cfinput type="#inputtype#" name="taxamt" id="taxamt" value="0.00" size="10" onKeyUp="calcfoot();" />  
</td>
</tr>
</table>
</td>
</tr>
  <tr><td colspan="4"><hr></td></tr>
<tr>
<td colspan="4" align="center">
<input name="cancel_btn" style="font: medium bolder;background-color:##6600CC; color:##CCCC66" id="btn_add" type="button" value="9.CANCEL" onClick="cancel();" size="15" />&nbsp;&nbsp;&nbsp;
<input name="pay_btn" style="font: medium bolder;background-color:" id="btn_add" type="button" value="2.CASH" onClick="document.getElementById('paytype').value='0';gopay('totalup');" size="15" />&nbsp;&nbsp;&nbsp;
<input name="pay_btn" style="font: medium bolder;background-color:##996633; color:##00FFFF" id="btn_add" type="button" value="3.NETS" onClick="document.getElementById('paytype').value='1';gopay('totalup1');" >&nbsp;&nbsp;&nbsp;
<input name="pay_btn" style="font: medium bolder;background-color:##666; color:##0F0" id="btn_add" type="button" value="4.CREDIT CARD" onClick="document.getElementById('paytype').value='2';gopay('totalup2');">&nbsp;&nbsp;&nbsp;
<input name="pay_btn" style="font: medium bolder;background-color:##3C0" id="btn_add" type="button" value="5.CHEQUE" onClick="document.getElementById('paytype').value='3';gopay('totalup3');" >&nbsp;&nbsp;&nbsp;
<input name="pay_btn" style="font: medium bolder; background-color:##C30; color:##0F0" id="btn_add" type="button" value="6.CASH CARD" onClick="document.getElementById('paytype').value='4';gopay('totalup4');">&nbsp;&nbsp;&nbsp;
<input name="pay_btn" style="font: medium bolder;background-color:##0F0" id="btn_add" type="button" value="7.MULTI PAYMENT" onClick="document.getElementById('paytype').value='5';gopay('totalup5');" size="15" />
</td>
</tr>
</table>
</cfoutput>
</cfform>


<cfif getdealermenu.itemformat eq '2'>
<cfwindow center="true" width="700" height="500" name="searchitem" refreshOnShow="true" closable="true" modal="false" title="Search Item" initshow="false"
        source="/default/transaction/POS/searchitem2.cfm?reftype={tran}" />
<cfelse>
<cfwindow center="true" width="700" height="500" name="searchitem" refreshOnShow="true" closable="true" modal="false" title="Search Item" initshow="false"
        source="/default/transaction/POS/searchitem.cfm?reftype={tran}" />
</cfif>
        
<!--- <cfwindow center="true" width="600" height="400" name="changedaddr" refreshOnShow="true" closable="true" modal="false" title="Search Address" initshow="false"
        source="/default/transaction/POS/searchaddress.cfm" /> --->
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
<!--- <cfwindow center="true" width="300" height="300" name="timemanchine" refreshOnShow="true" closable="true" modal="true" title="Revert Back To Previous Entry" initshow="false"
        source="timemanchine.cfm?uuid=#uuid#" /> --->

        
<!--- <cfwindow center="true" width="700" height="500" name="itembalance" refreshOnShow="true" closable="true" modal="false" title="Location Qty Balance" initshow="false"
        source="/default/transaction/itembal2.cfm?itemno={expressservicelist}&project=&job=&batchcode=" /> --->     
        
<cfwindow center="true" width="700" height="300" name="totalup" refreshOnShow="true" closable="true" modal="true" title="Total" initshow="false" source="total.cfm?grandtotal={grand}&uuid=#uuid#" />   
<cfwindow center="true" width="700" height="250" name="totalup1" refreshOnShow="true" closable="true" modal="true" title="Total" initshow="false" source="total1.cfm?grandtotal={grand}&uuid=#uuid#" /> 
<cfwindow center="true" width="700" height="250" name="totalup2" refreshOnShow="true" closable="true" modal="true" title="Total" initshow="false" source="total2.cfm?grandtotal={grand}&uuid=#uuid#" /> 
<cfwindow center="true" width="700" height="250" name="totalup3" refreshOnShow="true" closable="true" modal="true" title="Total" initshow="false" source="total3.cfm?grandtotal={grand}&uuid=#uuid#" /> 
<cfwindow center="true" width="700" height="250" name="totalup4" refreshOnShow="true" closable="true" modal="true" title="Total" initshow="false" source="total4.cfm?grandtotal={grand}&uuid=#uuid#" /> 
<cfwindow center="true" width="700" height="600" name="totalup5" refreshOnShow="true" closable="true" modal="true" title="Total" initshow="false" source="total5.cfm?grandtotal={grand}&uuid=#uuid#" />  
<cfwindow center="true" width="700" height="600" name="totalup6" refreshOnShow="true" closable="true" modal="true" title="Save as Invoice" initshow="false" source="total6.cfm?grandtotal={grand}&uuid=#uuid#&custno={custno}" /> 
<cfwindow center="true" width="600" height="600" name="neweu" refreshOnShow="true" closable="true" modal="true" title="Create New Member" initshow="false" source="neweu.cfm" />  
<cfwindow center="true" width="250" height="150" name="changeprice" refreshOnShow="true" closable="true" modal="true" title="Edit Price" initshow="false" source="changeprice.cfm?uuid=#uuid#&trancode={hidtrancode}" />  
<cfwindow center="true" width="700" height="550" name="searchmember" refreshOnShow="true" closable="true" modal="true" title="Search Member" initshow="false" source="searchmember.cfm?main={checkmain}" />  
 <cfif isdefined('url.uuid')>
 <script type="text/javascript">
 recalculateamt();
 setTimeout('caltax()','1000');
 </script>
 </cfif>
  <cfif isdefined('url.first')>
 <cfwindow center="true" width="260" height="160" name="choosecounter" refreshOnShow="true" closable="false" modal="true" title="Choose Counter" initshow="true" source="choosecounter.cfm" />
 </cfif>
<cfquery name="emptytemp" datasource="#dts#">
Delete from ictrantemp where trdatetime < "#dateformat(dateadd('d','-2',now()),'YYYY-MM-DD')#" and onhold <> "Y"</cfquery>