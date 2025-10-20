<cfajaximport tags="cfform">
<cfajaximport tags="cfwindow,cflayout-tab">
<cfsetting showdebugoutput="no">
<cfquery name="getgsetup" datasource="#dts#">
SELECT * FROM gsetup
</cfquery>
<html>
<head>
<script src="/SpryAssets/SpryCollapsiblePanel.js" type="text/javascript"></script>
<link href="/SpryAssets/SpryCollapsiblePanel.css" rel="stylesheet" type="text/css" />
	<title>Express Name</title>
	<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
    <script type='text/javascript' src='/ajax/core/engine.js'></script>
	<script type='text/javascript' src='/ajax/core/util.js'></script>
	<script type='text/javascript' src='/ajax/core/settings.js'></script>
    <script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
    <link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
	<script language="javascript" type="text/javascript" src="/scripts/CalendarControl.js"></script>
    <script type="text/javascript">
	<cfset uuid = createuuid()>
	<cfif isdefined('url.uuid')>
	<cfset uuid = url.uuid>
	</cfif>
	
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
	
	function getSupp(type,option){
		var inputtext = document.invoicesheet.searchsuppfr.value;
		DWREngine._execute(_reportflocation, null, 'supplierlookup', inputtext, option, getSuppResult);
}

function getSuppResult(suppArray){
	DWRUtil.removeAllOptions("custno");
	myoption = document.createElement("OPTION");
	myoption.text = "Choose a Customer/Supplier No";
	myoption.value = "";
	document.invoicesheet.custno.options.add(myoption);
	DWRUtil.addOptions("custno", suppArray,"KEY", "VALUE");
}
	
	
	function getProduct(type){
		var inputtext = document.invoicesheet.searchitemfr.value;
		DWREngine._execute(_reportflocation, null, 'productlookup', inputtext, getProductResult2);
}

function getProductResult2(itemArray){
	DWRUtil.removeAllOptions("expressservicelist");
	myoption = document.createElement("OPTION");
	myoption.text = "Choose a Item No";
	myoption.value = "";
	document.invoicesheet.expressservicelist.options.add(myoption);
	DWRUtil.addOptions("expressservicelist", itemArray,"KEY", "VALUE");
}

function getdriver(type){
		var inputtext = document.invoicesheet.searchdriver.value;
		DWREngine._execute(_reportflocation, null, 'enduserlookup', inputtext, getdriverResult2);
}

function getdriverResult2(itemArray){
	DWRUtil.removeAllOptions("driver");
	myoption = document.createElement("OPTION");
	myoption.text = "Choose a End User No";
	myoption.value = "";
	document.invoicesheet.driver.options.add(myoption);
	DWRUtil.addOptions("driver", itemArray,"KEY", "VALUE");
}
	function getCustSupp2(custno,custname){
				myoption = document.createElement("OPTION");
				myoption.text = custno + " - " + custname;
				myoption.value = custno;
				document.invoicesheet.custno.options.add(myoption);
				var indexvalue = document.getElementById("custno").length-1;
				document.getElementById("custno").selectedIndex=indexvalue;
				updateDetails(document.invoicesheet.custno[indexvalue].value);
		}
	function updateDriver(drno,drname){
			myoption = document.createElement("OPTION");
			myoption.text = drno + " - " + drname;
			myoption.value = drno;
			document.invoicesheet.driver.options.add(myoption);
			var indexvalue = document.getElementById("driver").length-1;
			document.getElementById("driver").selectedIndex=indexvalue;
		}
		
	function updateitem(itemno,desp){
			myoption = document.createElement("OPTION");
			myoption.text = itemno + " - " + desp;
			myoption.value = itemno;
			document.invoicesheet.expressservicelist.options.add(myoption);
			var indexvalue = document.getElementById("expressservicelist").length-1;
			document.getElementById("expressservicelist").selectedIndex=indexvalue;
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
	function nextIndex(thisid,id)
	{
	var itemno = document.getElementById('expressservicelist').value;
	if (thisid == 'expressservicelist' && itemno == '')
	{
	}
	else
	{
	if(event.keyCode==13){
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
	
	function updateDetails(columnvalue){
			var tran = document.invoicesheet.tran.value;
			var tablename = document.invoicesheet.ptype.value;
			DWREngine._execute(_tranflocation, null, 'getCustSuppDetails', tablename, columnvalue, tran, showCustSuppDetails);
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
	
	function showCustSuppDetails(CustSuppObject){
			DWRUtil.setValue("b_name", CustSuppObject.B_NAME);
			DWRUtil.setValue("b_name2", CustSuppObject.B_NAME2);
			DWRUtil.setValue("b_add1", CustSuppObject.B_ADD1);
			DWRUtil.setValue("b_add2", CustSuppObject.B_ADD2);
			DWRUtil.setValue("b_add3", CustSuppObject.B_ADD3);
			DWRUtil.setValue("b_add4", CustSuppObject.B_ADD4);
			DWRUtil.setValue("b_attn", CustSuppObject.B_ATTN);
			DWRUtil.setValue("b_phone", CustSuppObject.B_PHONE);
			DWRUtil.setValue("b_fax", CustSuppObject.B_FAX);
			DWRUtil.setValue("b_phone2", CustSuppObject.B_PHONE2);
			DWRUtil.setValue("agenthid", CustSuppObject.AGENT);
			DWRUtil.setValue("termhid", CustSuppObject.TERM);
			DWRUtil.setValue("driverhid", CustSuppObject.END_USER);
			DWRUtil.setValue("currcodehid", CustSuppObject.CURRCODE);
			DWRUtil.setValue("currrate", CustSuppObject.CURRRATE);
	selectOptionByValue(document.getElementById('agent'),document.getElementById('agenthid').value);
	selectOptionByValue(document.getElementById('term'),document.getElementById('termhid').value);
	selectOptionByValue(document.getElementById('driver'),document.getElementById('driverhid').value);
			if(CustSuppObject.TRAN == 'PO' || CustSuppObject.TRAN == 'SO' || CustSuppObject.TRAN == 'INV' || CustSuppObject.TRAN == 'DO'){
				DWRUtil.setValue("DCode", CustSuppObject.DCODE);
				DWRUtil.setValue("d_name", CustSuppObject.D_NAME);		
				DWRUtil.setValue("d_name2", CustSuppObject.D_NAME2);
				DWRUtil.setValue("d_add1", CustSuppObject.D_ADD1);
				DWRUtil.setValue("d_add2", CustSuppObject.D_ADD2);
				DWRUtil.setValue("d_add3", CustSuppObject.D_ADD3);
				DWRUtil.setValue("d_add4", CustSuppObject.D_ADD4);
				DWRUtil.setValue("d_attn", CustSuppObject.D_ATTN);
				DWRUtil.setValue("d_phone", CustSuppObject.D_PHONE);
				DWRUtil.setValue("d_fax", CustSuppObject.D_FAX);
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
	document.getElementById('desp2').value = unescape(decodeURI(document.getElementById('desphid').value));
	document.getElementById('desp2a').value = unescape(decodeURI(document.getElementById('despahid').value));
	document.getElementById('expunit').selectedIndex =0;
	document.getElementById('expprice').value = document.getElementById('pricehid').value;
	document.getElementById('costformula').value = document.getElementById('costformulaid').value;
	document.getElementById('btn_add').value = "Add";
	document.getElementById('btn_add').disabled = false; 
	}
	calamtadvance();
	if(document.getElementById('activatebarcode').checked == true && document.getElementById('btn_add').value == "Add")
	{
	addItemAdvance();
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
	document.getElementById('expressamt').value =  itemamt.toFixed(2);
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
	var despa = encodeURI(document.getElementById('desp2a').value);
	var expressamt = trim(document.getElementById('expressamt').value);
	var expqty = trim(document.getElementById('expqty').value);
	var expprice = trim(document.getElementById('expprice').value);
	var expcomment = convertToEntities(document.getElementById('expcomment').value);
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
	var locationfr = trim(document.getElementById('locationfr').value);
	var ajaxurl = '/default/transaction/ovasexpressbill/addproductsAjax.cfm?servicecode='+escape(expressservice)+'&desp='+escape(desp)+'&despa='+escape(despa)+'&expressamt='+escape(expressamt)+'&expqty='+escape(expqty)+'&expprice='+escape(expprice)+'&comment='+escape(expcomment)+'&unit='+escape(expunit)+'&dispec1='+escape(expunitdis1)+'&dispec2='+escape(expunitdis2)+'&dispec3='+escape(expunitdis3)+'&dis='+escape(expdis)+'&tran='+escape(tran)+'&tranno='+refno+'&uuid=#URLEncodedFormat(uuid)#&custno='+escape(custno)+'&isservi='+escape(isservi)+'&trancode='+escape(trancode)+'&glacc='+escape(glacc)+'&locfr='+escape(locationfr);
	ajaxFunction(document.getElementById('ajaxFieldPro'),ajaxurl);
	clearformadvance();
	setTimeout('calculatefooter();',750);
	setTimeout('refreshlist();',750);
	</cfoutput>
	}
	
	function clearformadvance()
	{
	document.getElementById('expressservicelist').value = '';
	document.getElementById('desp2').value = '';
	document.getElementById('desp2a').value = '';
	document.getElementById('expressamt').value = '0.00';
	document.getElementById('expqty').value = '1';
	document.getElementById('expprice').value = '0.00';
	document.getElementById('expunit').value = '';
	document.getElementById('expdis').value = '0.00';
	document.getElementById('expunitdis1').value = '0';
	document.getElementById('expunitdis2').value = '0';
	document.getElementById('expunitdis3').value = '0';
	document.getElementById('expcomment').value = '';
	document.getElementById('expressservicelist').focus();
	<cfif getgsetup.expressdisc neq "1">
	document.getElementById('expunitdis').value = '0.00';
	document.getElementById('expqtycount').value = '1';
	</cfif>
	}
	
	function refreshlist()
	{
	ColdFusion.Grid.refresh('itemlist',false);
	}
	
	function validformfield()
	{
	var formvar = document.getElementById('invoicesheet');
	var answer = _CF_checkinvoicesheet(formvar);
	if (answer)
	{
	invoicesheet.submit();
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
	var net = document.getElementById('net');
	var taxincl = document.getElementById('taxincl').checked;
	var taxamt = document.getElementById('taxamt').value * 1;
	var grand = document.getElementById('grand');
	var debt = document.getElementById('debt');
	var deposit = document.getElementById('deposit');
	net.value = (gross-disamt).toFixed(2);
	if(taxincl == true)
	{
	grand.value = net.value;
	}
	else
	{
	var netb = ((net.value * 1) + (taxamt * 1));
	grand.value = netb.toFixed(2);
	}
	debt.value = ((grand.value * 1) - (deposit.value * 1)).toFixed(2);
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
	grand.value = net.toFixed(2);
	}
	else
	{
	taxval = ((taxper/100)*net).toFixed(2);
	taxamt.value = taxval;
	var netb = (net * 1) + (taxval * 1);
	grand.value = netb.toFixed(2);
	}
	}
	<cfoutput>
	function recalculateamt()
	{
	var ajaxurl = '/default/transaction/ovasexpressbill/recalculateAjax.cfm?uuid=#URLEncodedFormat(uuid)#';
	ajaxFunction(document.getElementById('ajaxFieldPro'),ajaxurl);
	setTimeout('calculatefooter();',750);
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
    </script>
    
    
</head>
<body onLoad="document.getElementById('tran').focus()">

<cfoutput>
<cfform name="invoicesheet" id="invoicesheet" action="process.cfm" method="post">
<div id="CollapsiblePanel1" class="CollapsiblePanel">
  <div class="CollapsiblePanelTab" tabindex="0" onClick="expand();">HEADER</div>
  <div class="CollapsiblePanelContent">
<cfinput type="hidden" name="ptype" id="ptype" bind="cfc:custsupp.getname({tran},'#target_arcust#','#target_apvend#')" bindonload="yes">
<input type="hidden" name="uuid" id="uuid" value="#uuid#">
<table width="100%" >
<tr>
<th width="10%">Bill Type</th>
<td width="20%">
<select name="tran" id="tran" onKeyUp="nextIndex('tran','refno');" onChange="ajaxFunction(window.document.getElementById('lastusenoajax'),'/default/transaction/ovasexpressbill/lastusenoajax.cfm?type='+encodeURI(this.value));ajaxFunction(window.document.getElementById('changecustsuppsearch'),'/default/transaction/ovasexpressbill/changecustsuppsearch.cfm?type='+encodeURI(this.value));">
<cfif getpin2.h2400 eq 'T'><option value="INV" <cfif getgsetup.ddlbilltype eq "INV">selected</cfif>>Invoice</option></cfif>
<cfif getpin2.h2870 eq 'T'><option value="QUO" <cfif getgsetup.ddlbilltype eq "QUO">selected</cfif>>Quotation</option></cfif>
<cfif getpin2.h2880 eq 'T'><option value="SO" <cfif getgsetup.ddlbilltype eq "SO">selected</cfif>>Sales Order</option></cfif>
<cfif getpin2.h2500 eq 'T'><option value="CS" <cfif getgsetup.ddlbilltype eq "CS">selected</cfif>>Cash Sales</option></cfif>
<cfif getpin2.h2860 eq 'T'><option value="PO" <cfif getgsetup.ddlbilltype eq "PO">selected</cfif>>Order Purchase</option></cfif>
<cfif getpin2.h2300 eq 'T'><option value="DO" <cfif getgsetup.ddlbilltype eq "DO">selected</cfif>>Delivery Order</option></cfif>
<cfif getpin2.h2100 eq 'T'><option value="RC" <cfif getgsetup.ddlbilltype eq "RC">selected</cfif>>Purchase Receive</option></cfif>
<cfif getpin2.h2200 eq 'T'><option value="PR" <cfif getgsetup.ddlbilltype eq "PR">selected</cfif>>Return Purchase</option></cfif>
<cfif getpin2.h2600 eq 'T'><option value="CN" <cfif getgsetup.ddlbilltype eq "CN">selected</cfif>>Credit Note</option></cfif>
<cfif getpin2.h2700 eq 'T'><option value="DN" <cfif getgsetup.ddlbilltype eq "DN">selected</cfif>>Debit Note</option></cfif>
</select><cfselect name="refnoset" id="refnoset" bind="cfc:refnobill.getrefnoset({tran},'#dts#','#huserid#')" bindonload="yes" display="lastno" value="counter" /></td>
<td width="5%">
</td>
<th width="10%">Refno</th>
<cfif lcase(hcomid) eq "ovas_i">
<td width="20%">

<cfinput type="text" name="refno" id="refno" bind="cfc:refnobill.getrefno({tran},'#dts#',{refnoset})" bindonload="yes" required="yes" onKeyUp="nextIndex('refno','custno');" readonly></td>
<cfelse>
<td width="20%">

<cfinput type="text" name="refno" id="refno" bind="cfc:refnobill.getrefno({tran},'#dts#',{refnoset})" bindonload="yes" required="yes" onKeyUp="nextIndex('refno','custno');"></td>
</cfif>
<td width="5%">&nbsp;</td>
<th width="10%">Refno2</th>
<td width="20%"><cfinput type="text" name="refno2" id="refno2" value="" /></td>
</tr>
<tr>
<th>Cust / Supp Code</th>
<td colspan="2">

<cfselect name="custno" id="custno" bind="cfc:custsupp.getlist({tran},'#target_arcust#','#target_apvend#','#dts#')" bindonload="yes" required="yes" display="custname" value="custno" onChange="updateDetails(this.value);" onKeyUp="nextIndex('custno','wos_date');"  />
<div id='changecustsuppsearch'>
<input type="text" name="searchsuppfr" onKeyUp="getSupp('cust','Customer');">
</div>

<a onClick="javascript:ColdFusion.Window.show('createSupplier');" onMouseOver="this.style.cursor='hand';">New Supp</a>
&nbsp;&nbsp;&nbsp;&nbsp;
<a onClick="javascript:ColdFusion.Window.show('createCustomer');" onMouseOver="this.style.cursor='hand';">New Cust</a>

</td>
<th>Date</th>
<cfset datenow=now()>
<cfif getGsetup.autonextdate lte timeformat(now(),'HH')>
<cfset datenow=dateadd('d',1,now())>
<cfelse>
<cfset datenow=now()>
</cfif>
<cfif lcase(hcomid) eq "ovas_i">
<td><input type="text" name="wos_date" id="wos_date" value="#dateformat(datenow,'DD/MM/YYYY')#" onKeyUp="nextIndex('wos_date','expressservicelist');" readonly/></td>
<cfelse>
<td><input type="text" name="wos_date" id="wos_date" value="#dateformat(datenow,'DD/MM/YYYY')#" onKeyUp="nextIndex('wos_date','expressservicelist');" /><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(wos_date);">&nbsp;(DD/MM/YYYY)</td>
</cfif>
<td></td>
<th>Agent</th>
<td><cfselect name="agent" id="agent" bind="cfc:custsupp.getagent('#dts#','#Hlinkams#')" bindonload="yes" display="agentdesp" value="agent" /><input type="hidden" name="agenthid" id="agenthid" value=""></td>
</tr>
<tr>
<cfif lcase(hcomid) eq "ovas_i">
<th style="visibility:hidden">
Name
&nbsp;&nbsp; </th>
<cfelse>
<th>
Name
&nbsp;&nbsp; </th>
</cfif>
<cfif lcase(hcomid) eq "ovas_i">
<td style="visibility:hidden"><cfinput type="text" name="b_name" id="b_name" size="40" maxlength="35" /> </td>
<td></td>
<cfelse>
<td ><cfinput type="text" name="b_name" id="b_name" size="40" maxlength="35" /> </td>
<td></td>
</cfif>

<th <cfif lcase(hcomid) eq "ovas_i">style="visibility:hidden" </cfif>>
Name
&nbsp;&nbsp; </th>
<td <cfif lcase(hcomid) eq "ovas_i">style="visibility:hidden" </cfif>><cfinput type="text" name="d_name" id="d_name" size="40" maxlength="35" /> </td>
<td>&nbsp;</td>
<th>Terms</th>
<td><cfselect name="term" id="term" bind="cfc:custsupp.getterms('#dts#','#target_icterm#')" bindonload="yes" display="termdesp" value="term" /><input type="hidden" name="termhid" id="termhid" value=""></td>
</tr>
<tr>
<cfif lcase(hcomid) eq "ovas_i">
<td style="visibility:hidden"><input type="text" name="bcode" id="bcode" value="Profile" <cfif getgsetup.ECAOTA eq "N" and (HUserGrpID neq "admin" and HUserGrpID neq "super")>readonly</cfif> /></td>
<cfelse>
<td ><input type="text" name="bcode" id="bcode" value="Profile" <cfif getgsetup.ECAOTA eq "N" and (HUserGrpID neq "admin" and HUserGrpID neq "super")>readonly</cfif> /></td>
</cfif>
<cfif lcase(hcomid) eq "ovas_i">
<td style="visibility:hidden"><cfinput type="text" name="b_name2" id="b_name2" size="40" maxlength="35" /></td>
<cfelse>
<td ><cfinput type="text" name="b_name2" id="b_name2" size="40" maxlength="35" /></td>
</cfif>
<td></td>
<td <cfif lcase(hcomid) eq "ovas_i">style="visibility:hidden" </cfif>><input type="text" name="DCode" id="DCode" value="Profile" <cfif getgsetup.ECAOTA eq "N" and (HUserGrpID neq "admin" and HUserGrpID neq "super")>readonly</cfif> /></td>
<td <cfif lcase(hcomid) eq "ovas_i">style="visibility:hidden" </cfif>><cfinput type="text" name="d_name2" id="d_name2" size="40" maxlength="35" /></td>
<td>&nbsp;</td>
<th>#getgsetup.ldriver#</th>
<td><cfselect name="driver" id="driver" bind="cfc:custsupp.geteu('#dts#')" bindonload="yes" display="eudesp" value="driverno" />
	<input id="searchdriver" name="searchdriver" type="text" size="8" onKeyup="getdriver('driver');">
    <input type="hidden" name="driverhid" id="driverhid" value=""><a href="driver.cfm?type=Create" target="_blank">Create New End User</a><cfinput type="hidden" name="project" id="project" value=""></td>
</tr>
<tr>
<th <cfif lcase(hcomid) eq "ovas_i">style="visibility:hidden" </cfif>>Bill To</th>
<td <cfif lcase(hcomid) eq "ovas_i">style="visibility:hidden" </cfif>>
<cfinput type="text" name="b_add1" id="b_add1" size="40" maxlength="35" /></td>
<td></td>
<th <cfif lcase(hcomid) eq "ovas_i">style="visibility:hidden" </cfif>>Delivery To</th>
<td <cfif lcase(hcomid) eq "ovas_i">style="visibility:hidden" </cfif>>
<cfinput type="text" name="d_add1" id="d_add1" size="40" maxlength="35" /></td>
<td>&nbsp;</td>
<th>Currency</th>
<td><cfinput type="text" name="currcode" id="currcode" size="10"  /><input type="hidden" name="currcodehid" id="currcodehid" value="">&nbsp;<cfinput type="text" name="currrate" id="currrate" bind="cfc:custsupp.getcurrrate('#dts#',{currcode},'#target_currency#')" bindonload="yes" size="5" /><cfinput type="hidden" name="job" id="job" value=""></td>
</tr>
<tr>
<td <cfif lcase(hcomid) eq "ovas_i">style="visibility:hidden" </cfif>><cfquery name="getlastran" datasource="#dts#">
SELECT type,refno FROM artran WHERE created_by = <cfqueryparam cfsqltype="cf_sql_varchar" value="#huserid#"> order by created_on desc limit 1
</cfquery>Last Transaction:</td>

<td <cfif lcase(hcomid) eq "ovas_i">style="visibility:hidden" </cfif>><cfinput type="text" name="b_add2" id="b_add2" size="40" maxlength="35" /></td>
<td></td>
<td <cfif lcase(hcomid) eq "ovas_i">style="visibility:hidden" </cfif>><cfinput type="button" name="changedaddr" id="changedaddr" onClick="ColdFusion.Window.show('changedaddr');" value="Change Del Add"></td>
<td <cfif lcase(hcomid) eq "ovas_i">style="visibility:hidden" </cfif>><cfinput type="text" name="d_add2" id="d_add2" size="40" maxlength="35" /></td>
<td>&nbsp;</td>
<th rowspan="2"><a href="##" onClick="ColdFusion.Window.show('timemanchine');"><img src="/images/appointment.png" height="32" width="32" border="0" alt="Time Manchines" /></a></th>
<td><cfinput type="text" name="despa" id="despa" size="40" maxlength="40" />
</td>
</tr>
<tr>
<td <cfif lcase(hcomid) eq "ovas_i">style="visibility:hidden" </cfif>><div id="lastusenoajax">#getlastran.type#--#getlastran.refno#</div></td>
<td <cfif lcase(hcomid) eq "ovas_i">style="visibility:hidden" </cfif>><cfinput type="text" name="b_add3" id="b_add3" size="40" maxlength="35" /></td>
<td></td>
<td></td>
<td <cfif lcase(hcomid) eq "ovas_i">style="visibility:hidden" </cfif>><cfinput type="text" name="d_add3" id="d_add3" size="40" maxlength="35" /></td>
<td>&nbsp;</td>
</tr>
<tr>
<td></td>
<td <cfif lcase(hcomid) eq "ovas_i">style="visibility:hidden" </cfif>><cfinput type="text" name="b_add4" id="b_add4" size="40" maxlength="35" /></td>
<td></td>
<td></td>
<td <cfif lcase(hcomid) eq "ovas_i">style="visibility:hidden" </cfif>><cfinput type="text" name="d_add4" id="d_add4" size="40" maxlength="35" /></td>
<td>&nbsp;</td>
<td colspan="2" rowspan="5"><div id="getitemlocationqty"></div><cfinput type="hidden" name="PONO" id="PONO" size="30" /></td>
</tr>
<tr>
<th <cfif lcase(hcomid) eq "ovas_i">style="visibility:hidden" </cfif>>Attn</th>
<td <cfif lcase(hcomid) eq "ovas_i">style="visibility:hidden" </cfif>><cfinput type="text" name="b_attn" id="b_attn" size="40" maxlength="35" /></td>
<td></td>
<th <cfif lcase(hcomid) eq "ovas_i">style="visibility:hidden" </cfif>>Del Attn</th>
<td <cfif lcase(hcomid) eq "ovas_i">style="visibility:hidden" </cfif>><cfinput type="text" name="d_attn" id="d_attn" size="40" maxlength="35" /></td>
<td>&nbsp;<cfinput type="hidden" name="DONO" id="DONO" size="30" /></td>
</tr>
<tr>
<th <cfif lcase(hcomid) eq "ovas_i">style="visibility:hidden" </cfif>>Telephone</th>
<td <cfif lcase(hcomid) eq "ovas_i">style="visibility:hidden" </cfif>><cfinput type="text" name="b_phone" id="b_phone" size="40" maxlength="35" /></td>
<td></td>
<th <cfif lcase(hcomid) eq "ovas_i">style="visibility:hidden" </cfif>>Del Telephone</th>
<td <cfif lcase(hcomid) eq "ovas_i">style="visibility:hidden" </cfif>><cfinput type="text" name="d_phone" id="d_phone" size="40" maxlength="35" /></td>
<td>&nbsp;<cfinput type="hidden" name="desp" id="desp" size="40" maxlength="40" /></td>
</tr>
<tr>
<th <cfif lcase(hcomid) eq "ovas_i">style="visibility:hidden" </cfif>>Telephone 2</th>
<td <cfif lcase(hcomid) eq "ovas_i">style="visibility:hidden" </cfif>><cfinput type="text" name="b_phone2" id="b_phone2" size="40" maxlength="35" /></td>
<td></td>
<th <cfif lcase(hcomid) eq "ovas_i">style="visibility:hidden" </cfif>>Del Fax</th>
<td <cfif lcase(hcomid) eq "ovas_i">style="visibility:hidden" </cfif>><cfinput type="text" name="d_fax" id="d_fax" size="40" maxlength="35" /></td>
<td>&nbsp;</td>
<td></td>
</tr>
<tr>
<th <cfif lcase(hcomid) eq "ovas_i">style="visibility:hidden" </cfif>>Fax</th>
<td <cfif lcase(hcomid) eq "ovas_i">style="visibility:hidden" </cfif>><cfinput type="text" name="b_fax" id="b_fax" size="40" maxlength="35" />
<input type="hidden" name="B_add5" id="B_add5" value="">
<input type="hidden" name="d_add5" id="d_add5" value="">
</td>
<td></td>
<th <cfif lcase(hcomid) eq "ovas_i">style="visibility:hidden" </cfif>>Remark 11</th>
<td <cfif lcase(hcomid) eq "ovas_i">style="visibility:hidden" </cfif>><textarea name="remark11" id="remark11" cols='40' rows='3' onKeyDown="limitText(this.form.remark11,300);" onKeyUp="limitText(this.form.remark11,300);"></textarea></td>
<td></td>
</tr>
</table>
</div>
  <div class="CollapsiblePanelTab" tabindex="1">Footer</div>
  <div class="CollapsiblePanelContent">
<table width="100%" border="0">
<tr>
<th width="10%">Choose a product</th>
<td  width="23%">
<cfselect id="expressservicelist" name='expressservicelist' width="26" onBlur="this.value = this.value.split('___', 1);ajaxFunction(window.document.getElementById('itemDetail'),'/default/transaction/ovasexpressbill/addItemAjax.cfm?itemno='+encodeURI(this.value)+'&custno='+document.getElementById('custno').value+'&reftype='+document.getElementById('tran').value);setTimeout('updateVal();',750);ajaxFunction(window.document.getElementById('itembal'),'/default/transaction/ovasexpressbill/balonhand.cfm?itemno='+encodeURI(this.value));ajaxFunction(window.document.getElementById('getitemlocationqty'),'/default/transaction/ovasexpressbill/getitemlocationqty.cfm?itemno='+encodeURI(this.value));" onKeyUp="nextIndex('expressservicelist','desp2');" autosuggest="cfc:itemno.findItem({cfautosuggestvalue},'#dts#')" autosuggestminlength="1" >
					<option value=''>Please Filter The Item</option>
				</cfselect>
<input id="searchitemfr" name="searchitemfr" type="text" size="8" onKeyup="getProduct('expressservicelist');">
<a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="window.open('/default/maintenance/icitem2.cfm?type=Create&express=1');">CNI</a></td>
<td width="1%">&nbsp;</td>
<th width="10%">Description</th>
<td width="20%"><input type="text" name="desp2" id="desp2" size="40" onKeyUp="nextIndex('desp','expcomment');" ></td>
<td width="1%">&nbsp;</td>
<th width="10%">Comment</th>
<td rowspan="2" width="20%"><textarea name="expcomment" id="expcomment" cols="40" rows="3" onKeyUp="nextIndex('expcomment','expqty');" ></textarea></td>
</tr>
<tr>
  <td><div id="itembal"></div></td>
  <td><div id="itemDetail"></div></td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td><input type="text" name="desp2a" id="desp2a" size="40" onKeyUp="nextIndex('desp','expcomment');"></td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  </tr>
<tr>
  <th>Quantity</th>
  <td><input type="text" style="font: large bolder" name="expqty" id="expqty" size="10" maxlength="10" value="1" onKeyUp="calamtadvance();nextIndex('expqty','expunit');<cfif getgsetup.expressdisc neq "1">document.getElementById('expqtycount').value = this.value;</cfif>" ></td>
  <td>&nbsp;</td>
  <th>Unit</th>
  <td><cfselect name="expunit" id="expunit"  onKeyUp="nextIndex('expunit','expprice');" onChange="ajaxFunction(document.getElementById('ajaxfieldgetunitprice'),'/default/transaction/ovasexpressbill/getunitpriceAjax.cfm?itemno='+document.getElementById('expressservicelist').value+'&unit='+document.getElementById('expunit').value);setunitprice();"></cfselect></td>
  
  <td><div id="ajaxfieldgetunitprice">
  </div>&nbsp;</td>
  <th>Price</th>
  <td><input type="text" name="expprice" id="expprice" size="15" maxlength="15" value="0.00" onKeyUp="calamtadvance();nextIndex('expprice',<cfif getgsetup.expressdisc eq "1">'expunitdis1'<cfelse>'expqtycount'</cfif>)" ></td>
</tr>
<tr>
  <th></th>
  <td>

<input type="hidden" name="expunitdis1" id="expunitdis1" size="5" value="0" />
<input type="hidden" name="expunitdis2" id="expunitdis2" size="5" value="0" />
<input type="hidden" name="expunitdis3" id="expunitdis3" size="5" value="0" />
<input type="hidden" name="expqtycount" id="expqtycount" size="3" value="1" onKeyUp="caldisamt();calamtadvance();nextIndex('expqtycount','expunitdis')" >
&nbsp;&nbsp;
<input type="hidden" name="expunitdis" id="expunitdis" size="5" value="0.00" onKeyUp="caldisamt();calamtadvance();nextIndex('expdis','btn_add')" />
&nbsp;&nbsp;

<input type="hidden" name="expdis" id="expdis" size="10" maxlength="10" value="0.00" onKeyUp="calamtadvance();nextIndex('expdis','btn_add')" onBlur="calamtadvance();"></td>
  <td>&nbsp;</td>
  <th>Amount</th>
  <td><input type="text" style="font: large bolder" name="expressamt" id="expressamt" size="10" value="0.00" readonly >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <input name="btn_add" style="font: medium bolder" id="btn_add" type="button" value="Add" onClick="addnewitem2();"></td>
  <td>&nbsp;</td>
  <th><!--- Activate Barcode Scan --->Next Transaction No</th>
  <td><cfselect name="nextransac" id="nextransac" bind="cfc:nextran.newtran('#dts#','#uuid#',{expressservicelist})" bindonload="yes" display="trancode" value="trancode" /><input type="checkbox" style="display:none" name="activatebarcode" id="activatebarcode" value="Y" /><input type="hidden" name="pagesize" id="pagesize" value="7" /><div id="ajaxFieldPro" name="ajaxFieldPro"></div>  </td>
</tr>
<tr>
  <th></th>
  <td><cfinput type="hidden" name="glacc" id="glacc" maxlength="10" size="10" mask="9999/999" /></td>
  <td>&nbsp;</td>
  <cfif getgsetup.displaycostcode eq 'Y'>
  <th>Cost Code</th>
  <td><input type="text" name="costformula" id="costformula" value="" readonly></td>
  <td>&nbsp;</td>
  <cfelse>
  <th></th>
  <td><input type="hidden" name="costformula" id="costformula" value="" readonly></td>
  <td>&nbsp;</td>
  </cfif>
  
  <th>Location</th>
  <cfquery name="getlocation" datasource="#dts#">
  select location,desp from iclocation
  </cfquery>
  <td><select name="locationfr" id="locationfr">
<option value="">Select a location</option>
<cfloop query="getlocation">
<option value="#location#" <cfif getgsetup.ddllocation eq location>selected</cfif>>#location# - #desp#</option>
</cfloop>
</select></td>
</tr>
<tr onClick="setTimeout('recalculateamt();',750)">
<td colspan="8" height="200">
<cfgrid name="itemlist" pagesize="7" format="html" width="95%" height="100%"
bind="cfc:itemlist.getictran({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},'#dts#','#uuid#',{pagesize})"
                                onchange="cfc:itemlist.editictran({cfgridaction},
                                            {cfgridrow},
                                            {cfgridchanged},'#dts#','#HUserID#')" selectmode="edit" textcolor="##000000" delete="yes" deletebutton="Delete" selectonload="false">
                                
                    <cfgridcolumn name="trancode" header="No" dataalign="center" select="no" width="30">
                    <cfgridcolumn name="itemno" header="Item Code" dataalign="left" select="no" width="100">
                    <cfgridcolumn name="desp" header="Description" dataalign="left" select="no" width="300">
                    <cfgridcolumn name="qty_bil" header="Quantity" dataalign="center" select="no" width="100">
                    <cfgridcolumn name="price_bil" header="Price" dataalign="right" select="no" width="150">
                    <cfgridcolumn name="amt_bil" header="Amount" dataalign="right" select="no" width="150">
                    <cfgridcolumn name="uuid" header="uuid" dataalign="right" display="no">       
							</cfgrid></td>
</tr>
<tr>
  <th>Sub Total</th>
  <td><cfinput type="Text" name="gross" id="gross" readonly="yes" value="0.00"  /></td>
  <td>&nbsp;</td>
  <th>Discount</th>
  <td>
  <cfinput type="text" size="3" name="dispec1" id="dispec1" value="0" validate="float" validateat="onblur" message="Please key in numeric value" onKeyUp="calcdisc();caltax();calcfoot();" />%<input type="hidden" name="disbil1" id="disbil1" />
  <cfinput type="hidden" size="3" name="dispec2" id="dispec2" value="0" validate="float" validateat="onblur" message="Please key in numeric value" onKeyUp="calcdisc();caltax();calcfoot();"/><input type="hidden" name="disbil2" id="disbil2" />
  <cfinput type="hidden" size="3" name="dispec3" id="dispec3" value="0" validate="float" validateat="onblur" message="Please key in numeric value" onKeyUp="calcdisc();caltax();calcfoot();"/><input type="hidden" name="disbil3" id="disbil3" />&nbsp;&nbsp;=&nbsp;
  <cfinput type="text" size="5" name="disamt_bil" id="disamt_bil" value="0.00" validate="float" validateat="onblur" message="Please key in numeric value" onKeyUp="caltax();calcfoot();" />  </td>
  <td>&nbsp;</td>
  <th>NET</th>
  <td><cfinput type="text" name="net" id="net" value="0.00" readonly="yes" /></td>
</tr>
<tr>
  <th>Included Tax</th>
  <td><input type="checkbox" name="taxincl" id="taxincl" value="T" onClick="caltax()" /></td>
  <td>&nbsp;</td>
  <th>Tax</th>
  <cfquery name="getTaxCode" datasource="#dts#">
  SELECT "" as code, "" as rate1
  union all
  SELECT code,rate1 FROM #target_taxtable#
  </cfquery>
  <td><cfselect name="taxcode" id="taxcode" bind="CFC:tax.getTaxQry('#dts#','#target_taxtable#',{tran})" value="code" display="code" onChange="setTimeout('caltax()',500);" bindonload="yes"/>&nbsp;&nbsp;<cfinput type="text" name="taxper" id="taxper" value="0" size="8" bind="CFC:tax.getTax('#dts#','#target_taxtable#',{taxcode})" onKeyUp="caltax()" bindonload="yes"  />&nbsp;&nbsp;&nbsp;
  <cfinput type="text" name="taxamt" id="taxamt" value="0.00" size="10" onKeyUp="calcfoot();" />  </td>
  <td>&nbsp;</td>
  <th>Grand</th>
  <td><cfinput type="text" style="font: large bolder" name="grand" id="grand" value="0.00" readonly="yes" /></td>
</tr>

<tr>
  <th>&nbsp;</th>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <th>Deposit</th>
  
  <td><cfinput type="text" name="deposit" id="deposit" value="0.00" onKeyUp="calcfoot();" /></td>
  <td>&nbsp;</td>
  <th>Debt</th>
  <td><cfinput type="text" style="font: large bolder" name="debt" id="debt" value="0.00" readonly="yes" /></td>
</tr>

<tr>
  <th>&nbsp;</th>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <th><cfinput type="button" style="font: medium bolder" name="Submit" id="Submit" value="Accept" onClick="validformfield();" disabled/></th>
  <td><cfinput type="button" style="font: medium bolder" name="Close" id="Close" value="Close" onClick="window.close();"/></td>
  <td>&nbsp;</td>
  <th>&nbsp;</th>
  <td>&nbsp;</td>
</tr>
</table>
</div>
</div>
</cfform>
</cfoutput>
<cfwindow center="true" width="550" height="400" name="findCustomer" refreshOnShow="true"
        title="Find Customer or Supplier" initshow="false"
        source="/default/transaction/ovasexpressbill/findCustomer.cfm?type={tran}&custno={custno}" />
<cfwindow center="true" width="600" height="400" name="searchitem" refreshOnShow="true" closable="true" modal="false" title="Search Item" initshow="false"
        source="/default/transaction/ovasexpressbill/searchitem.cfm?reftype={tran}" />
<cfwindow center="true" width="600" height="400" name="changedaddr" refreshOnShow="true" closable="true" modal="false" title="Search Address" initshow="false"
        source="/default/transaction/ovasexpressbill/searchaddress.cfm" />
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
        source="timemanchine.cfm?uuid=#uuid#" />
<cfwindow x="10" y="10" modal="true"  width="1100" height="600" name="createCustomer" refreshOnShow="true"
        title="Add New Customer" initshow="false"
        source="/default/maintenance/createCustomerAjax.cfm" />
<cfwindow x="10" y="10" modal="true"  width="1100" height="600" name="createSupplier" refreshOnShow="true"
        title="Add New Supplier" initshow="false"
        source="/default/maintenance/createSupplierAjax.cfm" />

<script type="text/javascript">
<!--
var CollapsiblePanel1 = new Spry.Widget.CollapsiblePanel("CollapsiblePanel1");
//-->
</script>