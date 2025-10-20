<cfsetting showdebugoutput="no">
<html>
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
	<cfset uuid = createuuid()>
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
	var ajaxurl = '/default/transaction/expressbill/addproductsAjax.cfm?servicecode='+escape(expressservice)+'&desp='+escape(desp)+'&despa='+escape(despa)+'&expressamt='+escape(expressamt)+'&expqty='+escape(expqty)+'&expprice='+escape(expprice)+'&comment='+escape(expcomment)+'&unit='+escape(expunit)+'&dis='+escape(expdis)+'&tran='+escape(tran)+'&tranno='+refno+'&uuid=#URLEncodedFormat(uuid)#&custno='+escape(custno)+'&isservi='+escape(isservi);
	ajaxFunction(document.getElementById('ajaxFieldPro'),ajaxurl);
	clearformadvance();
	setTimeout('calculatefooter();',1000);
	setTimeout('refreshlist();',1000);
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
	var ajaxurl = '/default/transaction/expressbill/recalculateAjax.cfm?uuid=#URLEncodedFormat(uuid)#';
	ajaxFunction(document.getElementById('ajaxFieldPro'),ajaxurl);
	setTimeout('calculatefooter();',1000);
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
<th width="10%">Bill Type</th>
<td width="20%">
<select name="tran" id="tran" onKeyUp="nextIndex('tran','refno');">
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
</select></td>
<td width="5%"></td>
<th width="10%">Refno</th>
<td width="20%">
<cfinput type="text" name="refno" id="refno" bind="cfc:refnobill.getrefno({tran},'#dts#')" bindonload="yes" required="yes" onKeyUp="nextIndex('refno','custno');" ></td>
<td width="5%">&nbsp;</td>
<th width="10%">Refno2</th>
<td width="20%"><cfinput type="text" name="refno2" id="refno2" value="" /></td>
</tr>
<tr>
<th>Cust / Supp Code</th>
<td colspan="2">
<cfselect name="custno" id="custno" bind="cfc:custsupp.getlist({tran},'#target_arcust#','#target_apvend#','#dts#')" bindonload="yes" required="yes" display="custname" value="custno" onChange="updateDetails(this.value);" onKeyUp="nextIndex('custno','wos_date');"  /></td>
<th>Date</th>
<td><input type="text" name="wos_date" id="wos_date" value="#dateformat(now(),'DD/MM/YYYY')#" onKeyUp="nextIndex('wos_date','expressservicelist');" /><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(wos_date);">&nbsp;(DD/MM/YYYY)</td>
<td></td>
<th>Agent</th>
<td><cfselect name="agent" id="agent" bind="cfc:custsupp.getagent('#dts#')" bindonload="yes" display="agentdesp" value="agent" /><input type="hidden" name="agenthid" id="agenthid" value=""></td>
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
<td>&nbsp;</td>
<th>Terms</th>
<td><cfselect name="term" id="term" bind="cfc:custsupp.getterms('#dts#','#target_icterm#')" bindonload="yes" display="termdesp" value="term" /><input type="hidden" name="termhid" id="termhid" value=""></td>
</tr>
<tr>
<td><input type="text" name="bcode" id="bcode" value="Profile" /></td>
<td><cfinput type="text" name="b_name2" id="b_name2" size="40" maxlength="35" /></td>
<td></td>
<td><input type="text" name="DCode" id="DCode" value="Profile" /></td>
<td><cfinput type="text" name="d_name2" id="d_name2" size="40" maxlength="35" /></td>
<td>&nbsp;</td>
<th>Project</th>
<td><cfselect name="project" id="project" bind="cfc:custsupp.getproject('#dts#')" bindonload="yes" display="projectdesp" value="source" /></td>
</tr>
<tr>
<th>Bill To</th>
<td>
<cfinput type="text" name="b_add1" id="b_add1" size="40" maxlength="35" /></td>
<td></td>
<th>Delivery To</th>
<td>
<cfinput type="text" name="d_add1" id="d_add1" size="40" maxlength="35" /></td>
<td>&nbsp;</td>
<th>Job</th>
<td><cfselect name="job" id="job" bind="cfc:custsupp.getjob('#dts#')" bindonload="yes" display="jobdesp" value="source" /></td>
</tr>
<tr>
<td></td>
<td><cfinput type="text" name="b_add2" id="b_add2" size="40" maxlength="35" /></td>
<td></td>
<td></td>
<td><cfinput type="text" name="d_add2" id="d_add2" size="40" maxlength="35" /></td>
<td>&nbsp;</td>
<th>End User</th>
<td><cfselect name="driver" id="driver" bind="cfc:custsupp.geteu('#dts#')" bindonload="yes" display="eudesp" value="driverno" /> <input type="hidden" name="driverhid" id="driverhid" value=""></td>
</tr>
<tr>
<td></td>
<td><cfinput type="text" name="b_add3" id="b_add3" size="40" maxlength="35" /></td>
<td></td>
<td></td>
<td><cfinput type="text" name="d_add3" id="d_add3" size="40" maxlength="35" /></td>
<td>&nbsp;</td>
<th>Currency</th>
<td><cfinput type="text" name="currcode" id="currcode" size="10"  /><input type="hidden" name="currcodehid" id="currcodehid" value="">&nbsp;<cfinput type="text" name="currrate" id="currrate" bind="cfc:custsupp.getcurrrate('#dts#',{currcode},'#target_currency#')" bindonload="yes" size="5" /></td>
</tr>
<tr>
<td></td>
<td><cfinput type="text" name="b_add4" id="b_add4" size="40" maxlength="35" /></td>
<td></td>
<td></td>
<td><cfinput type="text" name="d_add4" id="d_add4" size="40" maxlength="35" /></td>
<td>&nbsp;</td>
<th>PONO</th>
<td><cfinput type="text" name="PONO" id="PONO" size="30" /></td>
</tr>
<tr>
<th>Attn</th>
<td><cfinput type="text" name="b_attn" id="b_attn" size="40" maxlength="35" /></td>
<td></td>
<th>Del Attn</th>
<td><cfinput type="text" name="d_attn" id="d_attn" size="40" maxlength="35" /></td>
<td>&nbsp;</td>
<th>DONO</th>
<td><cfinput type="text" name="DONO" id="DONO" size="30" /></td>
</tr>
<tr>
<th>Telephone</th>
<td><cfinput type="text" name="b_phone" id="b_phone" size="40" maxlength="35" /></td>
<td></td>
<th>Del Telephone</th>
<td><cfinput type="text" name="d_phone" id="d_phone" size="40" maxlength="35" /></td>
<td>&nbsp;</td>
<th>DESP</th>
<td><cfinput type="text" name="desp" id="desp" size="40" maxlength="40" /></td>
</tr>
<tr>
<th>Telephone 2</th>
<td><cfinput type="text" name="b_phone2" id="b_phone2" size="40" maxlength="35" /></td>
<td></td>
<th>Del Fax</th>
<td><cfinput type="text" name="d_fax" id="d_fax" size="40" maxlength="35" /></td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td><cfinput type="text" name="despa" id="despa" size="40" maxlength="40" /></td>
</tr>
<tr>
<th>Fax</th>
<td><cfinput type="text" name="b_fax" id="b_fax" size="40" maxlength="35" />
<input type="hidden" name="B_add5" id="B_add5" value="">
<input type="hidden" name="d_add5" id="d_add5" value="">
</td>
</tr>
<tr>
<th>&nbsp;</th>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<tD>&nbsp;</tD>
</tr>
<tr>
<th>Choose a product</th>
<td rowspan="2"><cfinput type="text" name="expressservicelist" id="expressservicelist" size="40" onBlur="this.value = this.value.split('___', 1);ajaxFunction(window.document.getElementById('itemDetail'),'/default/transaction/expressbill/addItemAjax.cfm?itemno='+this.value+'&custno='+document.getElementById('custno').value);setTimeout('updateVal();',1000);" onKeyUp="nextIndex('expressservicelist','desp2');" autosuggest="cfc:itemno.findItem({cfautosuggestvalue},'#dts#')" autosuggestminlength="1" /></td>
<td>&nbsp;</td>
<th>Description</th>
<td><input type="text" name="desp2" id="desp2" size="40" onKeyUp="nextIndex('desp','expcomment');" readonly ></td>
<td>&nbsp;</td>
<th>Comment</th>
<td rowspan="2"><textarea name="expcomment" id="expcomment" cols="40" rows="3" onKeyUp="nextIndex('expcomment','expqty');" ></textarea></td>
</tr>
<tr>
  <td><div id="itemDetail">
</div></td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td><input type="text" name="desp2a" id="desp2a" size="40" onKeyUp="nextIndex('desp','expcomment');" readonly ></td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  </tr>
<tr>
  <th>Quantity</th>
  <td><input type="text" name="expqty" id="expqty" size="10" maxlength="10" value="1" onKeyUp="calamtadvance();nextIndex('expqty','expunit');document.getElementById('expqtycount').value = this.value;" ></td>
  <td>&nbsp;</td>
  <th>Unit</th>
  <td><cfselect name="expunit" id="expunit"  onKeyUp="nextIndex('expunit','expprice');"></cfselect></td>
  <td>&nbsp;</td>
  <th>Price</th>
  <td><input type="text" name="expprice" id="expprice" size="15" maxlength="15" value="0.00" onKeyUp="calamtadvance();nextIndex('expprice','expqtycount')" ></td>
</tr>
<tr>
  <th>Discount</th>
  <td><input type="text" name="expqtycount" id="expqtycount" size="3" value="1" onKeyUp="caldisamt();calamtadvance();nextIndex('expqtycount','expunitdis')" >
&nbsp;&nbsp;
<input type="text" name="expunitdis" id="expunitdis" size="5" value="0.00" onKeyUp="caldisamt();calamtadvance();nextIndex('expdis','btn_add')" />
&nbsp;&nbsp;
<input type="text" name="expdis" id="expdis" size="10" maxlength="10" value="0.00" onKeyUp="calamtadvance();nextIndex('expdis','btn_add')" onBlur="calamtadvance();"></td>
  <td>&nbsp;</td>
  <th>Amount</th>
  <td><input type="text" name="expressamt" id="expressamt" size="10" value="0.00" readonly >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <input name="btn_add" id="btn_add" type="button" value="Add" onClick="addItemAdvance();"></td>
  <td>&nbsp;</td>
  <th>Activate Barcode Scan</th>
  <td><input type="checkbox" name="activatebarcode" id="activatebarcode" value="Y" /><div id="ajaxFieldPro" name="ajaxFieldPro"></div>
  </td>
</tr>
<tr onClick="setTimeout('recalculateamt();',1000)">
<td colspan="8" height="200">
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
							</cfgrid>
</td>
</tr>
<tr>
  <th>Sub Total</th>
  <td><cfinput type="Text" name="gross" id="gross" readonly="yes" value="0.00"  /></td>
  <td>&nbsp;</td>
  <th>Discount</th>
  <td>
  <cfinput type="text" size="5" name="dispec1" id="dispec1" value="0" validate="float" validateat="onblur" message="Please key in numeric value" onKeyUp="calcdisc();caltax();calcfoot();" />%<input type="hidden" name="disbil1" id="disbil1" />&nbsp;+&nbsp;
  <cfinput type="text" size="5" name="dispec2" id="dispec2" value="0" validate="float" validateat="onblur" message="Please key in numeric value" onKeyUp="calcdisc();caltax();calcfoot();"/>%<input type="hidden" name="disbil2" id="disbil2" />&nbsp;+&nbsp;
  <cfinput type="text" size="5" name="dispec3" id="dispec3" value="0" validate="float" validateat="onblur" message="Please key in numeric value" onKeyUp="calcdisc();caltax();calcfoot();"/>%<input type="hidden" name="disbil3" id="disbil3" />&nbsp;&nbsp;=&nbsp;
  <cfinput type="text" size="8" name="disamt_bil" id="disamt_bil" value="0.00" validate="float" validateat="onblur" message="Please key in numeric value" onKeyUp="caltax();calcfoot();" />
  </td>
  <td>&nbsp;</td>
  <th>NET</th>
  <td><cfinput type="text" name="net" id="net" value="0.00" readonly="yes" /></td>
</tr>
<tr>
  <th>Included Tax</th>
  <td><input type="checkbox" name="taxincl" id="taxincl" value="Y" onClick="caltax()" /></td>
  <td>&nbsp;</td>
  <th>Tax</th>
  <cfquery name="getTaxCode" datasource="#dts#">
  SELECT "" as code, "" as rate1
  union all
  SELECT code,rate1 FROM #target_taxtable#
  </cfquery>
  <td><cfselect name="taxcode" id="taxcode" query="getTaxCode" value="code" display="code" onChange="setTimeout('caltax()',500);"/>&nbsp;&nbsp;<cfinput type="text" name="taxper" id="taxper" value="0" size="8" bind="CFC:tax.getTax('#dts#','#target_taxtable#',{taxcode})" onKeyUp="caltax()"  />&nbsp;&nbsp;&nbsp;
  <cfinput type="text" name="taxamt" id="taxamt" value="0.00" size="10" onKeyUp="calcfoot();" />
  </td>
  <td>&nbsp;</td>
  <th>Grand</th>
  <td><cfinput type="text" name="grand" id="grand" value="0.00" readonly="yes" /></td>
</tr>
<tr>
  <th>&nbsp;</th>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <th><cfinput type="button" name="Submit" id="Submit" value="Accept" onClick="validformfield();" disabled/></th>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <th>&nbsp;</th>
  <td>&nbsp;</td>
</tr>
</table>
</cfform>
</cfoutput>

</body>