<cfsetting showdebugoutput="yes">
<html>
<cfset tran="">
<cfset refno="">
<cfset tran="">
<cfset wpitemtax="">

<cfquery name="getgsetup" datasource="#dts#">
	select * from gsetup
</cfquery>

<cfquery name="getdiscount" datasource="#dts#">
	select * from discount order by discount
</cfquery>

<head>
	<title>Express Name</title>
	<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
    <script type='text/javascript' src='/ajax/core/engine.js'></script>
	<script type='text/javascript' src='/ajax/core/util.js'></script>
	<script type='text/javascript' src='/ajax/core/settings.js'></script>
    <script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
    <link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
	<script language="javascript" type="text/javascript" src="/scripts/CalendarControl.js"></script>
    <script type="text/javascript">
	function revertback()
	{
	var answer = confirm('Are you sure you want to proceed revert?')
	if(answer)
	{
	var newuuid = document.getElementById('oldlist').value;
	
	window.location.href="index.cfm?uuid="+newuuid;
	}
	}
	
	// begin: supplier search
function getSupp(type,option){
	
		var inputtext = document.invoicesheet.searchsuppfr.value;
		DWREngine._execute(_reportflocation, null, 'supplierlookup', inputtext, option, getSuppResult);

}

function getSuppResult(suppArray){
	DWRUtil.removeAllOptions("custno");
	DWRUtil.addOptions("custno", suppArray,"KEY", "VALUE");
}

// end: supplier search
function setID(comid)
{
document.getElementById("hiddentext").value = comid;

}
	function gettitle()
	{

	var ajaxurl5 = '/default/transaction/verjasexpressbill/locationajax.cfm?type='+document.getElementById('tran').value;
	ajaxFunction(document.getElementById('ajaxField5'),ajaxurl5);
	
	if(document.getElementById('tran').value =="PO" ||document.getElementById('tran').value =="PR"||document.getElementById('tran').value =="RC"){
	document.getElementById('title').value="Supplier"}
	else
	{
	document.getElementById('title').value="Customer"
	}
	}
	<cfset uuid = createuuid()>
	<cfif isdefined('url.uuid')>
	<cfset uuid = url.uuid>
	
	setTimeout('refreshlist();',2000);
	</cfif>
	
	function additemnew()
	{
	if(event.keyCode==13 && document.getElementById('expressservicelist').value !='' )
	{
ajaxFunction(window.document.getElementById('itemDetail'),'/default/transaction/verjasexpressbill/addItemAjax.cfm?itemno='+document.getElementById('expressservicelist').value+'&custno='+document.getElementById('custno').value);
	setTimeout('updateVal()',700);
	}
	}
	function nextIndex(thisid,id)
	{
	
	
	if(event.keyCode==13){
	
	}
	var itemno = document.getElementById('expressservicelist').value;
	if (thisid == 'expressservicelist' && itemno == '')
	{
	
	
	
	}
	else
	{
	if(event.keyCode==13){
	
	document.getElementById(''+id+'').focus;
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
		
	function updateVal()
	{
	
	var validdesp = document.getElementById('desphid').value;
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
	document.getElementById('desp2').value = document.getElementById('desphid').value;
	document.getElementById('desp2a').value = document.getElementById('despahid').value;
	document.getElementById('expunit').selectedIndex =0;
	document.getElementById('expprice').value = document.getElementById('pricehid').value;
	document.getElementById('btn_add').value = "Add";
	document.getElementById('btn_add').disabled = false; 
	}
	calamtadvance();
	if(document.getElementById('activatebarcode').checked == true && document.getElementById('btn_add').value == "Add")
	{
	
	addItemAdvance();
	}
	}
	
	function caldisamt()
	{
	var qtydis = document.getElementById('expqtycount').value;
	var disamt = document.getElementById('expunitdis').value;
	qtydis = qtydis * 1;
	disamt = disamt * 1;
	var totaldiscount = qtydis * disamt;
	document.getElementById('expdis').value = totaldiscount.toFixed(2);
	}
	
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
	var expressservice=trim(document.getElementById('expressservicelist').value);
	var desp = escape(trim(document.getElementById('desp2').value));
	var despa = escape(trim(document.getElementById('desp2a').value));
	var expressamt = trim(document.getElementById('expressamt').value);
	var expqty = trim(document.getElementById('expqty').value);
	var expprice = trim(document.getElementById('expprice').value);
	var expcomment = escape(trim(document.getElementById('expcomment').value));
	var expunit = trim(document.getElementById('expunit').value);
	var expdis = trim(document.getElementById('expdis').value);
	var isservi = trim(document.getElementById('isservi').value);
	var tran = trim(document.getElementById('tran').value);
	var custno = trim(document.getElementById('custno').value);
	var refno = trim(document.getElementById('refno').value);
	var locationfr = trim(document.getElementById('locationfr').value);
	var locationto = trim(document.getElementById('locationto').value);
	var wosdate = trim(document.getElementById('wos_date').value);
	var ajaxurl = '/default/transaction/verjasexpressbill/addproductsAjax.cfm?servicecode='+escape(expressservice)+'&desp='+escape(desp)+'&despa='+escape(despa)+'&expressamt='+escape(expressamt)+'&expqty='+escape(expqty)+'&expprice='+escape(expprice)+'&comment='+escape(expcomment)+'&unit='+escape(expunit)+'&dis='+escape(expdis)+'&tran='+escape(tran)+'&tranno='+refno+'&uuid=#URLEncodedFormat(uuid)#&custno='+escape(custno)+'&isservi='+escape(isservi)+'&locfr='+escape(locationfr)+'&locto='+escape(locationto)+'&wosdate='+escape(wosdate);
	ajaxFunction(document.getElementById('ajaxFieldPro'),ajaxurl);

	setTimeout('calculatefooter();',700);
	setTimeout('refreshlist();',700);
	

	
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
	document.getElementById('expunitdis').value = '0.00';
	document.getElementById('expqtycount').value = '1';
	document.getElementById('expcomment').value = '';
	document.getElementById('expressservicelist').focus();
	}
	
	function refreshlist()
	{
	var ajaxurl2 = '/default/transaction/verjasexpressbill/icitemadd.cfm?refno='+document.getElementById('refno').value+'&type='+document.getElementById('tran').value+'&uuid='+document.getElementById('uuid').value;
	ajaxFunction(document.getElementById('ajaxField1'),ajaxurl2);
	
	var ajaxurl10 = '/default/transaction/verjasexpressbill/totalprs.cfm?refno='+document.getElementById('refno').value+'&type='+document.getElementById('tran').value+'&uuid='+document.getElementById('uuid').value;
	ajaxFunction(document.getElementById('ajaxField10'),ajaxurl10);
	
	clearformadvance();
	}
	
	function validformfield()
	{
	var formvar = document.getElementById('invoicesheet');
	var answer = _CF_checkinvoicesheet(formvar);
	
	if (answer && document.getElementById('custno').value !="")
	{
	invoicesheet.submit();
	}
	else
	{
	alert('Please Select a Customer')
	}
	}
	
	function calculatefooter()
	{
	
	document.getElementById('gross').value = document.getElementById('hidsubtotal').value;
	
	var hiditemcount = document.getElementById('hiditemcount').value;
	if (hiditemcount == 0)
	{
	document.getElementById('Submit').disabled = true;
	}
	else
	{
	document.getElementById('Submit').disabled = false;
	}
	
	calcdisc();
	caltax();
	calcfoot();
	}
	
	function calculatefooter2()
	{
	
	document.getElementById('gross').value = document.getElementById('hidsubtotal2').value;
	
	var hiditemcount = document.getElementById('hiditemcount').value;
	if (hiditemcount == 0)
	{
	document.getElementById('Submit').disabled = true;
	}
	else
	{
	document.getElementById('Submit').disabled = false;
	}
	
	calcdisc();
	caltax();
	calcfoot();
	}

	function calcfoot()
	{
	
	var gross = document.getElementById('gross').value * 1;
	var disamt = document.getElementById('disamt_bil').value * 1;
	var net = document.getElementById('net');
	var taxincl = document.getElementById('taxincl').checked;
	var taxamt = document.getElementById('taxamt').value * 1;
	var grand = document.getElementById('grand');
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
	var ajaxurl = '/default/transaction/verjasexpressbill/recalculateAjax.cfm?uuid=#URLEncodedFormat(uuid)#';
	ajaxFunction(document.getElementById('ajaxFieldPro'),ajaxurl);
	setTimeout('calculatefooter2();',700);
	}
	</cfoutput>
    </script>
    <script type="text/javascript" src="/scripts/prototypenew.js" ></script>
	<script type="text/javascript">
	<cfoutput>
	function additemnew1()
	{
	if(event.keyCode==13 && document.getElementById('expressservicelist').value !='' )
	{
    var urlload = '/default/transaction/verjasexpressbill/addItemnew.cfm?itemno='+encodeURI(document.getElementById('expressservicelist').value)+'&custno='+encodeURI(document.getElementById('custno').value)+'&type='+encodeURI(document.getElementById('tran').value)+'&refno='+encodeURI(document.getElementById('refno').value)+'&wosdate='+escape(document.getElementById('wos_date').value)+'&uuid=#URLEncodedFormat(uuid)#'+'&locfr='+encodeURI(document.getElementById('locationfr').value)+'&locto='+encodeURI(document.getElementById('locationto').value);
	
    new Ajax.Request(urlload,
      {
        method:'get',
        onSuccess: function(flyback){
		document.getElementById('gross').value = trim(flyback.responseText)||"0.00";
		document.getElementById('Submit').disabled = false;
        refreshlist();
		calcdisc();
		caltax();
		calcfoot();
        },
        onFailure: function(){ 
		alert('Item Not Found'); }
      });
    }
	}
    </cfoutput>
    </script>
    
</head>
<body onLoad="document.getElementById('tran').focus()">

<cfoutput>

<cfform name="invoicesheet" id="invoicesheet" action="process.cfm" method="post">
<cfinput type="hidden" name="ptype" id="ptype" bind="cfc:custsupp.getname({tran},'#target_arcust#','#target_apvend#')" bindonload="yes">
<input type="hidden" name="uuid" id="uuid" value="#uuid#">
<table width="100%" >
<tr>
<th width="7%">Bill Type</th>
<td width="12%">
<select name="tran" id="tran" onKeyUp="nextIndex('tran','refno');" onChange="gettitle()">
<cfif isdefined('url.uuid')>
<cfquery name="getuuidtype" datasource="#dts#">
select type from ictrantemp where uuid='#url.uuid#'
</cfquery>
<option value="INV" <cfif getuuidtype.type eq 'INV'>selected</cfif>>Invoice</option>
<option value="QUO" <cfif getuuidtype.type eq 'QUO'>selected</cfif>>Quotation</option>
<option value="SO" <cfif getuuidtype.type eq 'SO'>selected</cfif>>Sales Order</option>
<option value="CS" <cfif getuuidtype.type eq 'CS'>selected</cfif>>Cash Sales</option>
<option value="PO" <cfif getuuidtype.type eq 'PO'>selected</cfif>>Order Purchase</option>
<option value="DO" <cfif getuuidtype.type eq 'DO'>selected</cfif>>Delivery Order</option>
<option value="RC" <cfif getuuidtype.type eq 'RC'>selected</cfif>>Purchase Receive</option>
<option value="PR" <cfif getuuidtype.type eq 'PR'>selected</cfif>>Return Purchase</option>
<option value="CN" <cfif getuuidtype.type eq 'CN'>selected</cfif>>Credit Note</option>
<option value="DN" <cfif getuuidtype.type eq 'DN'>selected</cfif>>Debit Note</option>
<option value="TR" <cfif getuuidtype.type eq 'TROU' or getuuidtype.type eq 'TRIN'>selected</cfif>>Transfer</option>
<cfelse>
<option value="INV">Invoice</option>
<option value="QUO">Quotation</option>
<option value="SO">Sales Order</option>
<option value="CS">Cash Sales</option>
<option value="PO">Order Purchase</option>
<option value="DO">Delivery Order</option>
<option value="RC">Purchase Receive</option>
<option value="PR">Return Purchase</option>
<option value="CN">Credit Note</option>
<option value="DN">Debit Note</option>
<option value="TR">Transfer</option>
</cfif>
</select></td>
<td width="3%"><cfselect name="refnoset" id="refnoset" bind="cfc:refnobill.getrefnoset({tran},'#dts#')" bindonload="yes" display="lastno" value="counter" /></td>
<th width="12%">Refno</th>
<td colspan="2">
<cfinput type="text" name="refno" id="refno" bind="cfc:refnobill.getrefno({tran},'#dts#',{refnoset})" bindonload="yes" required="yes" onKeyUp="nextIndex('refno','custno');" ></td>


</tr>
<tr>
<th>Cust / Supp Code</th>
<td colspan="2">
<cfselect name="custno" id="custno" bind="cfc:custsupp.getlist({tran},'#target_arcust#','#target_apvend#','#dts#')" bindonload="yes" required="yes" display="custname" value="custno" onChange="updateDetails(this.value);" onKeyUp="nextIndex('custno','wos_date');"  />
				<cfinput type="hidden" name="title" id="title">
				<cfinput type="text" name="searchsuppfr" onKeyUp="getSupp('custno',document.getElementById('title').value);">
</td>
<th>Date</th>
<td colspan="2"><input type="text" name="wos_date" id="wos_date" value="#dateformat(now(),'DD/MM/YYYY')#" onKeyUp="nextIndex('wos_date','expressservicelist');" /><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(wos_date);">&nbsp;(DD/MM/YYYY)</td>

</tr>

<tr>
<th>
Name
&nbsp;&nbsp; </th>
<td><cfinput type="text" name="b_name" id="b_name" size="40" maxlength="35" /> </td>
<td></td>
<th>
Name
&nbsp;&nbsp; </th>
<td><cfinput type="text" name="d_name" id="d_name" size="40" maxlength="35" /> </td>


<th>Terms</th>
<td colspan="2"><cfselect name="term" id="term" bind="cfc:custsupp.getterms('#dts#','#target_icterm#')" bindonload="yes" display="termdesp" value="term" /><input type="hidden" name="termhid" id="termhid" value=""></td>
</tr>
<tr>
<td><input type="text" name="bcode" id="bcode" value="Profile" size="15"/></td>
<td><cfinput type="text" name="b_name2" id="b_name2" size="40" maxlength="35" /></td>
<td></td>
<td><input type="text" name="DCode" id="DCode" value="Profile" /></td>
<td><cfinput type="text" name="d_name2" id="d_name2" size="40" maxlength="35" /></td>

<th>Agent</th>
<td colspan="2"><cfselect name="agent" id="agent" bind="cfc:custsupp.getagent('#dts#','#Hlinkams#')" bindonload="yes" display="agentdesp" value="agent" /><input type="hidden" name="agenthid" id="agenthid" value=""></td>
</tr>
<tr>
<th>Bill To</th>
<td>
<cfinput type="text" name="b_add1" id="b_add1" size="40" maxlength="35" /></td>
<td></td>
<th>Delivery To</th>
<td>
<cfinput type="text" name="d_add1" id="d_add1" size="40" maxlength="35" /></td>
<th>Currency</th>
<td colspan="2"><cfinput type="text" name="currcode" id="currcode" size="10"  /><input type="hidden" name="currcodehid" id="currcodehid" value="">&nbsp;<cfinput type="text" name="currrate" id="currrate" bind="cfc:custsupp.getcurrrate('#dts#',{currcode},'#target_currency#')" bindonload="yes" size="5" /></td>
</tr>
<tr>
<td></td>
<td><cfinput type="text" name="b_add2" id="b_add2" size="40" maxlength="35" /></td>
<td></td>
<td></td>
<td><cfinput type="text" name="d_add2" id="d_add2" size="40" maxlength="35" /></td>
<th>PONO</th>
<td colspan="2"><cfinput type="text" name="PONO" id="PONO" size="30" /></td>
</tr>
<tr>
<td></td>
<td><cfinput type="text" name="b_add3" id="b_add3" size="40" maxlength="35" /></td>
<td></td>
<td></td>
<td><cfinput type="text" name="d_add3" id="d_add3" size="40" maxlength="35" /></td>
<th>DONO</th>
<td colspan="2"><cfinput type="text" name="DONO" id="DONO" size="30" /></td>

</tr>
<tr>
<td></td>
<td><cfinput type="text" name="b_add4" id="b_add4" size="40" maxlength="35" /></td>
<td></td>
<td></td>
<td><cfinput type="text" name="d_add4" id="d_add4" size="40" maxlength="35" /></td>
<th>#getgsetup.rem5#</th>
  <cfquery name="getbrand" datasource="#dts#">
  select * from brand
  </cfquery>
<td colspan="2"><select name="rem5" id="rem5">
<option value="">Select a brand</option>
<cfloop query="getbrand">
<option value="#getbrand.desp#">#getbrand.brand# - #getbrand.desp#</option>
</cfloop>
</select></td>
</tr>
<tr>
<th>Attn</th>
<td><cfinput type="text" name="b_attn" id="b_attn" size="40" maxlength="35" /></td>
<td></td>
<th>Del Attn</th>
<td><cfinput type="text" name="d_attn" id="d_attn" size="40" maxlength="35" /></td>

<th colspan="2" rowspan="2">
  <cfquery name="getlocation" datasource="#dts#">
  select location,desp from iclocation
  </cfquery>
<div id="ajaxField5" name="ajaxField5">

Location &nbsp;&nbsp;&nbsp;&nbsp;<select name="locationfr" id="locationfr">
<option value="">Select a location</option>
<cfloop query="getlocation">
<option value="#location#" <cfif getgsetup.ddllocation eq location>selected</cfif>>#location# - #desp#</option>
</cfloop>
</select>
<input type="hidden" id="locationto" name="locationto" value="" />


</div></th>

</tr>
<tr>
<th>Telephone</th>
<td><cfinput type="text" name="b_phone" id="b_phone" size="40" maxlength="35" /></td>
<td></td>
<th>Del Telephone</th>
<td><cfinput type="text" name="d_phone" id="d_phone" size="40" maxlength="35" /></td>
</tr>
<tr>
<th>Telephone 2</th>
<td><cfinput type="text" name="b_phone2" id="b_phone2" size="40" maxlength="35" /></td>
<td></td>
<th>Fax</th>
<td colspan="2"><cfinput type="text" name="b_fax" id="b_fax" size="40" maxlength="35" />
<input type="hidden" name="B_add5" id="B_add5" value="">
<input type="hidden" name="d_add5" id="d_add5" value="">
</tr>
<tr>

</td>
</tr>
<tr>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td width="8%">&nbsp;</td>
<td width="15%">&nbsp;</td>
<td>&nbsp;</td>
<tD>&nbsp;</tD>
</tr>

<tr>
<th>#getgsetup.rem6#</th>
<td><cfinput type="text" name="rem6" id="rem6" size="40" maxlength="100" /></td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td rowspan="2"><a href="##" onClick="ColdFusion.Window.show('timemanchine');"><img src="/images/appointment.png" height="32" width="32" border="0" alt="Time Manchines" /></a></td>
<td width="15%">&nbsp;</td>
<td>&nbsp;</td>
<tD>&nbsp;</tD>
</tr>

<tr>
<th>#getgsetup.rem7#</th>
<td><cfinput type="text" name="rem7" id="rem7" size="40" maxlength="100" /></td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td width="8%">&nbsp;</td>
<td width="15%">&nbsp;</td>
<td>&nbsp;</td>
<tD>&nbsp;</tD>
</tr>
<tr>
<td></td>
<th>Choose a product</th>
<td></td>
<td><cfinput type="text" name="expressservicelist" id="expressservicelist" size="40"  onKeyUp="additemnew1()"/></td>
<td colspan="2"><input type="hidden" name="hiddentext" id="hiddentext" value=""/></td>
</tr>


<tr>
<td colspan="10" height="200" >
<div id="ajaxField1" name="ajaxField1">

<table align="middle" class="data" width="1000px">
    <tr> 
	<th rowspan="4">Article</th>
    <th rowspan="4">Colour</th>
    <th>38</th>
    <th></th>
    <th>39</th>
    <th></th>
    <th>40</th>
    <th></th>
    <th>41</th>
    <th></th>
    <th>42</th>
    <th></th>
    <th>43</th>
    <th></th>
    <th>44</th>
    <th></th>
    <th>45</th>
    <th rowspan="4">Qty<br>PRS</th>
	<th rowspan="4">Unit<br>Price</th>
	<th rowspan="4">Amount</th>
	<th rowspan="4">Action</th>
      		</tr>
<tr>
    <th>4</th>
    <th>1/2</th>
    <th>5</th>
    <th>1/2</th>
    <th>6</th>
    <th>1/2</th>
    <th>7</th>
    <th>1/2</th>
    <th>8</th>
    <th>1/2</th>
    <th>9</th>
    <th>1/2</th>
    <th>10</th>
    <th>1/2</th>
    <th>11</th>
</tr>
<tr>
	<th>22</th>
    <th>1/2</th>
    <th>23</th>
    <th>1/2</th>
    <th>24</th>
    <th>1/2</th>
    <th>25</th>
    <th>1/2</th>
    <th>26</th>
    <th>1/2</th>
    <th>27</th>
    <th>1/2</th>
    <th>28</th>
    <th>1/2</th>
    <th>29</th>
</tr>
<tr>
	<th>35</th>
    <th></th>
    <th>36</th>
    <th></th>
    <th>37</th>
    <th></th>
    <th>38</th>
    <th></th>
    <th>39</th>
    <th></th>
    <th>40</th>
    <th></th>
    <th>41</th>
    <th></th>
    <th>42</th>
</tr>


</table>

</div>
<!---
<cfgrid name="itemlist" pagesize="7" format="html" width="95%" height="190"
bind="cfc:itemlist.getictran({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},'#dts#','#uuid#')"
                                onchange="cfc:itemlist.editictran({cfgridaction},
                                            {cfgridrow},
                                            {cfgridchanged},'#dts#','#HUserID#')" selectmode="edit" textcolor="##000000" delete="yes" deletebutton="Delete">
                                
                    <cfgridcolumn name="trancode" header="No" dataalign="center" select="no" width="30">
                    <cfgridcolumn name="itemno" header="Item Code" dataalign="left" select="no" width="100">
                    <cfgridcolumn name="desp" header="Description" dataalign="left" select="no" width="300">
                    <cfgridcolumn name="qty_bil" header="Quantity" dataalign="center" select="no" width="100">
                    <cfgridcolumn name="price_bil" header="Price" dataalign="right" select="no" width="150">
                    <cfgridcolumn name="amt_bil" header="Amount" dataalign="right" select="no" width="150">
                    <cfgridcolumn name="uuid" header="uuid" dataalign="right" display="no">       
							</cfgrid>--->
</td>
</tr>
<tr><th>Total Prs</th><td><div id="ajaxField10" name="ajaxField10"><input type="Text" name="totalprs" id="totalprs" readonly value="0"  /></div></td></tr>
<tr>
  <th>Sub Total</th>
  <td><cfinput type="Text" name="gross" id="gross" readonly="yes" value="0.00"  /></td>

  <th>Discount</th>
  <td>
  <cfselect  onChange="calcdisc();caltax();calcfoot();"  name="dispec1" id="dispec1">
  <cfloop query="getdiscount">
  <option value="#val(getdiscount.discount)#" <cfif val(getdiscount.discount) eq '50'>selected</cfif>>#getdiscount.desp#</option>
  </cfloop>
  </cfselect>
  <input type="hidden" name="disbil1" id="disbil1" />
  <cfinput type="hidden" size="5" name="dispec2" id="dispec2" value="0" validate="float" validateat="onblur" message="Please key in numeric value" onKeyUp="calcdisc();caltax();calcfoot();"/>
  <input type="hidden" name="disbil2" id="disbil2" />&nbsp;&nbsp;
  <cfinput type="hidden" size="5" name="dispec3" id="dispec3" value="0" validate="float" validateat="onblur" message="Please key in numeric value" onKeyUp="calcdisc();caltax();calcfoot();"/><input type="hidden" name="disbil3" id="disbil3" />&nbsp;&nbsp;&nbsp;
  <cfinput type="text" size="8" name="disamt_bil" id="disamt_bil" value="0.00" validate="float" validateat="onblur" message="Please key in numeric value" onKeyUp="caltax();calcfoot();" />
  </td>

  <th>NET</th>
  <td><cfinput type="text" name="net" id="net" value="0.00" readonly="yes" /></td>
</tr>
<tr>
  <th>Included Tax</th>
  <td><input type="checkbox" name="taxincl" id="taxincl" value="Y" onClick="caltax()" /></td>

  <th>Tax</th>
  <cfquery name="getTaxCode" datasource="#dts#">
  SELECT "" as code, "" as rate1
  union all
  SELECT code,rate1 FROM #target_taxtable#
  </cfquery>
  <td><cfselect name="taxcode" id="taxcode" query="getTaxCode" value="code" display="code" onChange="setTimeout('caltax()',500);" selected="#getgsetup.df_salestax#"/>&nbsp;&nbsp;<cfinput type="text" name="taxper" id="taxper" value="0" size="8" bind="CFC:tax.getTax('#dts#','#target_taxtable#',{taxcode})" onKeyUp="caltax()" bindonload="yes"  />&nbsp;&nbsp;&nbsp;
  <cfinput type="text" name="taxamt" id="taxamt" value="0.00" size="10" onKeyUp="calcfoot();" readonly/>
  </td>

  <th rowspan="2"><font size="+2">Grand</font></th>
  <td rowspan="2"><cfinput type="text" style="font: large bolder" name="grand" id="grand" value="0.00" readonly="yes" /></td>
</tr>
<tr>
<td>&nbsp;</td>

</tr>
<tr>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <th colspan="2"><div align="center"><cfinput type="button" name="Submit" id="Submit" value="Accept" onClick="validformfield();document.getElementById('Submit').disabled = true;" disabled/></div></th>
  <td colspan="2">&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
</tr>
<tr style="visibility:hidden">
<th >Description</th>
<td ><input type="text" name="desp2" id="desp2" size="40" onKeyUp="nextIndex('desp','expcomment');" readonly ></td>
<th >Comment</th>
<td colspan="2"><textarea name="expcomment" id="expcomment" cols="40" rows="3" onKeyUp="nextIndex('expcomment','expqty');" ></textarea></td>
</tr>

<tr style="visibility:hidden">
  <td><div id="itemDetail">
</div></td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td colspan="2"><input type="text" name="desp2a" id="desp2a" size="40" onKeyUp="nextIndex('desp','expcomment');" readonly ></td>
  <td>&nbsp;</td>
  </tr>
<tr style="visibility:hidden">
  <th>Quantity</th>
  <td><input type="text" name="expqty" id="expqty" size="10" maxlength="10" value="1" onKeyUp="calamtadvance();nextIndex('expqty','expunit');document.getElementById('expqtycount').value = this.value;" ></td>
  <td>&nbsp;</td>
  <th>Unit</th>
  <td colspan="2"><cfselect name="expunit" id="expunit"  onKeyUp="nextIndex('expunit','expprice');"></cfselect></td>
  <td>&nbsp;</td>
  <th>Price</th>
  <td><input type="text" name="expprice" id="expprice" size="15" maxlength="15" value="0.00" onKeyUp="calamtadvance();nextIndex('expprice','expqtycount')" ></td>
</tr>
<tr style="visibility:hidden">
  <th>Discount</th>
  <td><input type="text" name="expqtycount" id="expqtycount" size="3" value="1" onKeyUp="caldisamt();calamtadvance();nextIndex('expqtycount','expunitdis')" >
&nbsp;&nbsp;
<input type="text" name="expunitdis" id="expunitdis" size="5" value="0.00" onKeyUp="caldisamt();calamtadvance();nextIndex('expdis','btn_add')" />
&nbsp;&nbsp;
<input type="text" name="expdis" id="expdis" size="10" maxlength="10" value="0.00" onKeyUp="calamtadvance();nextIndex('expdis','btn_add')" onBlur="calamtadvance();"></td>
  <td>&nbsp;</td>
  <th>Amount</th>
  <td colspan="2"><input type="text" name="expressamt" id="expressamt" size="10" value="0.00" readonly >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <input name="btn_add" id="btn_add" type="button" value="Add" onClick="addItemAdvance();"></td><!----,ajaxFunction(document.getElementById('ajaxField1'),'icitemadd.cfm?refno='+document.getElementById('refno').value&type='+document.getElementById('tran').value);"--->
  <td>&nbsp;</td>
  <th>Activate Barcode Scan</th>
  <td><input type="checkbox" name="activatebarcode" id="activatebarcode" value="Y" checked/><div id="ajaxFieldPro" name="ajaxFieldPro"></div>
  </td>
</tr>
<tr style="visibility:hidden">

<th>Project</th>
<td><cfselect name="project" id="project" bind="cfc:custsupp.getproject('#dts#','#Hlinkams#')" bindonload="yes" display="projectdesp" value="source" /></td>
</tr>
<tr style="visibility:hidden">

<td>&nbsp;</td>
<th>Job</th>
<td colspan="2"><cfselect name="job" id="job" bind="cfc:custsupp.getjob('#dts#','#Hlinkams#')" bindonload="yes" display="jobdesp" value="source" /></td>
<th width="11%">DESP</th>
<td width="12%"><cfinput type="text" name="desp" id="desp" size="40" maxlength="40" /></td>
</tr>
<tr style="visibility:hidden">

<td>&nbsp;</td>
<th>End User</th>
<td colspan="2"><cfselect name="driver" id="driver" bind="cfc:custsupp.geteu('#dts#')" bindonload="yes" display="eudesp" value="driverno" /> <input type="hidden" name="driverhid" id="driverhid" value=""></td>
<td></td>
<td><cfinput type="text" name="d_add3" id="d_add3" size="40" maxlength="35" /></td>
<td>&nbsp;</td>
</tr>
<tr style="visibility:hidden">

<td>&nbsp;</td>

<td width="5%">&nbsp;</td>

</tr>
<tr style="visibility:hidden">
<th>Del Fax</th>
<td><cfinput type="text" name="d_fax" id="d_fax" size="40" maxlength="35" /></td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td colspan="2"><cfinput type="text" name="despa" id="despa" size="40" maxlength="40" /></td>
<th width="3%">Refno2</th>
<td width="12%"><cfinput type="text" name="refno2" id="refno2" value="" /></td>

</tr>

</table>
</cfform>
<cfwindow center="true" width="520" height="400" name="edititem" refreshOnShow="true"
        title="Edit Item" initshow="false"
        source="/default/transaction/verjasexpressbill/edititem.cfm?type={invoicesheet:tran}&uuid=#uuid#&itemno={invoicesheet:hiddentext}" />
        <cfwindow center="true" width="300" height="300" name="timemanchine" refreshOnShow="true" closable="true" modal="true" title="Revert Back To Previous Entry" initshow="false"
        source="timemanchine.cfm?uuid=#uuid#" />
</cfoutput>

</body>