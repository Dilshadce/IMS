<cfajaximport tags="cfform">
<cfsetting showdebugoutput="no">
<cfquery name="getgsetup" datasource="#dts#">
SELECT filterall,ECAOTA,ECAMTOTA,negstk,PCBLTC,ddlbilltype,expressdisc,displaycostcode,ldriver,autonextdate,ddllocation ,rem5,rem6,rem11,ngstcustdisabletax FROM gsetup
</cfquery>

<cfquery name="getdealermenu" datasource="#dts#">
SELECT * FROM dealer_menu
</cfquery>
<html>
<head>
<style>
td
{padding:0px;
	}
th
{padding:0px;
	}
</style>
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
    <script type="text/javascript" src="/scripts/prototypenew.js" ></script>
    <script type="text/javascript">
	<cfset uuid = createuuid()>
	<cfif isdefined('url.uuid')>
	<cfset uuid = url.uuid>
	</cfif>
	
	function selectlist(custno,fieldtype){

			for (var idx=0;idx<document.getElementById(fieldtype).options.length;idx++) 
			{
        	if (custno==document.getElementById(fieldtype).options[idx].value) 
			{
            document.getElementById(fieldtype).options[idx].selected=true;
        	}
    		} 
			
									}
	
	function gettitle()
	{

	var ajaxurl5 = '/default/transaction/expressbill/locationajax.cfm?type='+document.getElementById('tran').value;
	ajaxFunction(document.getElementById('ajaxField5'),ajaxurl5);
	
	var ajaxurl6 = '/default/transaction/expressbill/itemlocationajax.cfm?type='+document.getElementById('tran').value;
	ajaxFunction(document.getElementById('itemlocationajax'),ajaxurl6);
	
	<cfif hcomid eq "acht_i">
	if(document.getElementById('tran').value =="CS")
	{
		document.getElementById('refno').readOnly=true;
	}
	else
	{
		document.getElementById('refno').readOnly=false;
	}
	</cfif>
	
	if(document.getElementById('tran').value =="TR")
	{
	document.getElementById("timemachine").style.visibility = "hidden";
	document.getElementById("custno").value = "3000/000";
	}
	else{
	document.getElementById("timemachine").style.visibility = "visible";
	document.getElementById("custno").value = "";
	}
	
	}
	
	function setunitprice()
	{
		var ajaxurl = '/default/transaction/expressbill/getunitpriceAjax.cfm?itemno='+document.getElementById('expressservicelist').value+'&unit='+document.getElementById('expunit').value;
		 new Ajax.Request(ajaxurl,
      {
        method:'get',
        onSuccess: function(getdetailback){
		document.getElementById('ajaxfieldgetunitprice').innerHTML = trim(getdetailback.responseText);
        },
        onFailure: function(){ 
		alert('Error Found!'); },		
		onComplete: function(transport){
		 document.getElementById('expprice').value=document.getElementById('priceforunit').value;
        }
      })	  
		<!--- ajaxFunction(document.getElementById('ajaxfieldgetunitprice'),'/default/transaction/expressbill/getunitpriceAjax.cfm?itemno='+document.getElementById('expressservicelist').value+'&unit='+document.getElementById('expunit').value);
	setTimeout("document.getElementById('expprice').value=document.getElementById('priceforunit').value;",500) --->
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
		document.getElementById('custname2').focus()
		window.clearInterval(t1);
		t1 = null;
		}
		}
		catch(err)
		{
			
		}
	}
	
	function nextIndex(e,thisid,id)
	{
	var itemno = document.getElementById('expressservicelist').value;
	var custno = document.getElementById('custno').value;
	
	if (thisid == 'expressservicelist' && itemno == '')
	{
		if(e.keyCode==40){
		
		document.getElementById('searchitembtn').focus();
		}
	}
	<cfif getGsetup.filterall eq "1">
	else if (thisid == 'custno' && custno == '')
	{	if(e.keyCode==13){
		document.getElementById('Scust1').focus();
		}
	}
	</cfif>
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
	
	function updateDetails(columnvalue){
			var tran = document.invoicesheet.tran.value;
			var tablename = document.invoicesheet.ptype.value;
			DWREngine._execute(_tranflocation, null, 'getCustSuppDetails', tablename, columnvalue, tran, showCustSuppDetails);
		}
	
	function updateDetails2(columnvalue){
			setTimeout("updateDetails(document.getElementById('custno').value);",1000)
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
			if (CustSuppObject.TAXINCLUDED == 'T')
			{
			document.getElementById('taxincl').checked = true;
			}
			
			<cfif getgsetup.ngstcustdisabletax eq '1'>
			if (CustSuppObject.NGST_CUST == 'T')
			{
			if (document.getElementById('tran').value == 'PO' || document.getElementById('tran').value == 'PR' || document.getElementById('tran').value == 'RC')
			{
			selectOptionByValue(document.getElementById('taxcode'),'ZP');
			document.getElementById('taxper').value = 0;
			}
			else
			{
			selectOptionByValue(document.getElementById('taxcode'),'ZR');
			document.getElementById('taxper').value = 0;
			}
			}
			else
			{
				if (document.getElementById('tran').value == 'PO' || document.getElementById('tran').value == 'PR' || document.getElementById('tran').value == 'RC')
			{
			selectOptionByValue(document.getElementById('taxcode'),'TX7');
			document.getElementById('taxper').value = 7;
			}
			else
			{
			selectOptionByValue(document.getElementById('taxcode'),'SR');
			document.getElementById('taxper').value = 7;
			}
				
			}
			</cfif>
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
	try
	{
	document.getElementById('expressservicelist').value = unescape(decodeURI(document.getElementById('replaceitemno').value));
	}
	catch(err)
	{
	}
	document.getElementById('desp2').value = unescape(decodeURI(document.getElementById('desphid').value));
	document.getElementById('desp2a').value = unescape(decodeURI(document.getElementById('despahid').value));
	document.getElementById('expcomment').value = unescape(decodeURI(document.getElementById('commenthid').value));
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
	var locationfr = encodeURI(document.getElementById('locationfr').value);
	var locationto = encodeURI(document.getElementById('locationto').value);
	var wos_date = encodeURI(document.getElementById('wos_date').value);
	
	<cfif lcase(HcomID) eq "simplysiti_i">	
	var ajaxurl = '/default/transaction/expressbill/addproductsAjax.cfm?servicecode='+escape(expressservice)+'&desp='+escape(desp)+'&despa='+escape(despa)+'&expressamt='+escape(expressamt)+'&expqty='+escape(expqty)+'&expprice='+escape(expprice)+'&comment='+escape(expcomment)+'&unit='+escape(expunit)+'&dispec1='+escape(expunitdis1)+'&dispec2='+escape(expunitdis2)+'&dispec3='+escape(expunitdis3)+'&dis='+escape(expdis)+'&tran='+escape(tran)+'&tranno='+refno+'&uuid=#URLEncodedFormat(uuid)#&custno='+escape(custno)+'&isservi='+escape(isservi)+'&trancode='+escape(trancode)+'&glacc='+escape(glacc)+'&locfr='+escape(locationfr)+'&locto='+escape(locationto)+'&date='+escape(wos_date)+'&tranferlimit='+document.getElementById('allowtransferlimit').value;
	<cfelse>
	var ajaxurl = '/default/transaction/expressbill/addproductsAjax.cfm?servicecode='+escape(expressservice)+'&desp='+escape(desp)+'&despa='+escape(despa)+'&expressamt='+escape(expressamt)+'&expqty='+escape(expqty)+'&expprice='+escape(expprice)+'&comment='+escape(expcomment)+'&unit='+escape(expunit)+'&dispec1='+escape(expunitdis1)+'&dispec2='+escape(expunitdis2)+'&dispec3='+escape(expunitdis3)+'&dis='+escape(expdis)+'&tran='+escape(tran)+'&tranno='+refno+'&uuid=#URLEncodedFormat(uuid)#&custno='+escape(custno)+'&isservi='+escape(isservi)+'&trancode='+escape(trancode)+'&glacc='+escape(glacc)+'&locfr='+escape(locationfr)+'&locto='+escape(locationto)+'&date='+escape(wos_date);
	</cfif>
	<!--- ajaxFunction(document.getElementById('ajaxFieldPro'),ajaxurl); --->
		 new Ajax.Request(ajaxurl,
		  {
			method:'get',
			onSuccess: function(getdetailback){
			document.getElementById('ajaxFieldPro').innerHTML = trim(getdetailback.responseText);
			
			},
			onFailure: function(){ 
			alert('Error Found!');clearformadvance(); },		
			onComplete: function(transport){ 
			 calculatefooter();
			 refreshlist();
			 blockaddress();
			 <cfif lcase(HcomID) neq "simplysiti_i">	
			 clearformadvance();
			 </cfif>
			}
		  })	  
	  
	<!--- clearformadvance();
	setTimeout('calculatefooter();',750);
	setTimeout('refreshlist();',750);
	setTimeout('blockaddress();',750); --->
	</cfoutput>
	}
	
	function clearformadvance()
	{
	document.getElementById('expressservicelist').value = '';
	document.getElementById('desp2').value = '';
	document.getElementById('desp2a').value = '';
	document.getElementById('expressamt').value = '0.00';
	<cfif hcomid eq "hairo_i" or hcomid eq "freshways_i">
	document.getElementById('expqty').value = '';
	<cfelse>
	document.getElementById('expqty').value = '1';
	</cfif>
	document.getElementById('expprice').value = '0.00';
	document.getElementById('expunit').value = '';
	document.getElementById('expdis').value = '0.00';
	document.getElementById('expunitdis1').value = '0';
	document.getElementById('expunitdis2').value = '0';
	document.getElementById('expunitdis3').value = '0';
	document.getElementById('expcomment').value = '';
	<cfif hcomid eq "hairo_i" or hcomid eq "freshways_i">
	document.getElementById('searchitembtn').focus();
	<cfelse>
	document.getElementById('expressservicelist').focus();
	</cfif>
	<cfif getgsetup.expressdisc neq "1">
	document.getElementById('expunitdis').value = '0.00';
	document.getElementById('expqtycount').value = '1';
	</cfif>
	document.getElementById('btn_add').disabled = true; 
	}
	
	function refreshlist()
	{
	ColdFusion.Grid.refresh('itemlist',false);
	}
	
	function getitemdetail(detailitemno)
	{
    var urlloaditemdetail = '/default/transaction/expressbill/addItemAjax.cfm?itemno='+escape(encodeURI(detailitemno.split('___', 1)))+'&custno='+document.getElementById('custno').value+'&reftype='+document.getElementById('tran').value+'&locationto='+escape(document.getElementById('locationto').value)+'&date='+escape(document.getElementById('wos_date').value);
	
	  new Ajax.Request(urlloaditemdetail,
      {
        method:'get',
        onSuccess: function(getdetailback){
		document.getElementById('itemDetail').innerHTML = trim(getdetailback.responseText);
        },
        onFailure: function(){ 
		alert('Item Not Found'); },		
		onComplete: function(transport){
		 getlocationbal(detailitemno);
		 updateVal();
        }
      })
	}
	
	function getlocationbal(itemnobal)
	{
	  var urlloaditembal = '/default/transaction/expressbill/balonhand.cfm?itemno='+encodeURI(itemnobal)+'&location='+escape(document.getElementById('locationfr').value);
	
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
    var urlload = '/default/transaction/expressbill/recalculateAjax.cfm?uuid=#URLEncodedFormat(uuid)#';
	</cfoutput>
    new Ajax.Request(urlload,
      {
        method:'get',
        onSuccess: function(flyback){
		document.getElementById('ajaxFieldPro').innerHTML = trim(flyback.responseText);
		calculatefooter2();
        },
        onFailure: function(){ 
		alert('Error Found'); },		
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
	document.getElementById("locationfr").disabled=false;
	document.getElementById("locationto").disabled=false;	
	recalculateall();
	}
	else
	{
	}
	}
	
	function calculatefooter()
	{
	<cfif lcase(HcomID) eq "simplysiti_i">	
	if (document.getElementById('itemtransferlimit').value == 1)
	{
		ColdFusion.Window.show('transferlimitstock');
	}
	else{clearformadvance();document.getElementById('allowtransferlimit').value=0;}
	</cfif>
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
	
	 new Ajax.Request(ajaxurl,
      {
        method:'get',
        onSuccess: function(getdetailback){
		document.getElementById('ajaxFieldPro').innerHTML = trim(getdetailback.responseText);
        },
        onFailure: function(){ 
		alert('Error Found'); },		
		onComplete: function(transport){
		 calculatefooter();
        }
      })
	
	<!--- ajaxFunction(document.getElementById('ajaxFieldPro'),ajaxurl);
	setTimeout('calculatefooter();',750); --->
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
	
	

	function copygrandtocash()
	{
	if(document.getElementById("checkcash").checked == true)
	{
	document.getElementById("cash").value=document.getElementById("grand").value;
	}
	else{
	document.getElementById("cash").value='0.00';
	}
	
	}
	
	function copygrandtocheq()
	{
	if(document.getElementById("checkcheq").checked == true)
	{
	document.getElementById("cheque").value=document.getElementById("grand").value;
	}
	else{
	document.getElementById("cheque").value='0.00';
	}
	}
	function limitText(field,maxlimit){
		if (field.value.length > maxlimit) // if too long...trim it!
			field.value = field.value.substring(0, maxlimit);
			// otherwise, update 'characters left' counter
	}
	function blockaddress(){
		if (document.getElementById("tran").value =='TR' && document.getElementById("nextransac").value !='1'){
			document.getElementById("locationfr").disabled=true;
			document.getElementById("locationto").disabled=true;
			document.getElementById("findlocationfrom2").disabled=true;
			document.getElementById("findlocationto2").disabled=true;
		}
	}
	
	
    </script>
    
    
</head>
<cfquery name="getmodule" datasource="#dts#">
	select * 
	from modulecontrol;
</cfquery>
<body onLoad="document.getElementById('tran').focus()">

<cfoutput>
<cfform name="invoicesheet" id="invoicesheet" action="process.cfm" method="post">
<div id="CollapsiblePanel1" class="CollapsiblePanel">
  <div class="CollapsiblePanelTab" tabindex="0" onClick="expand();">HEADER</div>
  <div class="CollapsiblePanelContent">
<cfinput type="hidden" name="ptype" id="ptype" bind="cfc:custsupp.getname({tran},'#target_arcust#','#target_apvend#')" bindonload="yes">
<input type="hidden" name="uuid" id="uuid" value="#uuid#"><cfif lcase(HcomID) eq "simplysiti_i"><input type="hidden" name="allowtransferlimit" id="allowtransferlimit" value="0"></cfif>
<table width="100%"  >
<tr>
<th width="10%">Bill Type</th>
<td width="20%">
<select name="tran" id="tran" onKeyUp="nextIndex(event,'tran','refno');" onChange="gettitle();" onBlur="updateDetails(document.getElementById('custno').value);">
<cfif getpin2.h2401 eq "T"><option value="INV" <cfif getgsetup.ddlbilltype eq "INV">selected</cfif>>Invoice</option></cfif>
<cfif getpin2.h2871 eq "T"><option value="QUO" <cfif getgsetup.ddlbilltype eq "QUO">selected</cfif>>Quotation</option></cfif>
<cfif getpin2.h2881 eq "T"><option value="SO" <cfif getgsetup.ddlbilltype eq "SO">selected</cfif>>Sales Order</option></cfif>
<cfif getpin2.h2501 eq "T"><option value="CS" <cfif getgsetup.ddlbilltype eq "CS">selected</cfif>>Cash Sales</option></cfif>
<cfif getpin2.h2861 eq "T"><option value="PO" <cfif getgsetup.ddlbilltype eq "PO">selected</cfif>>Order Purchase</option></cfif>
<cfif getpin2.h2301 eq "T"><option value="DO" <cfif getgsetup.ddlbilltype eq "DO">selected</cfif>>Delivery Order</option></cfif>
<cfif getpin2.h2102 eq "T"><option value="RC" <cfif getgsetup.ddlbilltype eq "RC">selected</cfif>>Purchase Receive</option></cfif>
<cfif getpin2.h2201 eq "T"><option value="PR" <cfif getgsetup.ddlbilltype eq "PR">selected</cfif>>Return Purchase</option></cfif>
<cfif getpin2.h2601 eq "T"><option value="CN" <cfif getgsetup.ddlbilltype eq "CN">selected</cfif>>Credit Note</option></cfif>
<cfif getpin2.h2701 eq "T"><option value="DN" <cfif getgsetup.ddlbilltype eq "DN">selected</cfif>>Debit Note</option></cfif>
<cfif getpin2.h28A0 eq "T"><option value="TR" <cfif getgsetup.ddlbilltype eq "TR">selected</cfif>>Transfer</option></cfif>
</select><cfselect name="refnoset" id="refnoset" bind="cfc:refnobill.getrefnoset({tran},'#dts#')" bindonload="yes" display="lastno" value="counter" /></td>
<td width="5%"></td>
<th width="10%">Refno</th>
<td width="20%">
<cfif hcomid eq "hairo_i" or hcomid eq "simplysiti_i"  or hcomid eq "freshways_i">
<cfinput type="text" name="refno" id="refno" bind="cfc:refnobill.getrefno({tran},'#dts#',{refnoset})" bindonload="yes" required="yes" onKeyUp="nextIndex(event,'refno','custno');" readonly>
<cfelse>
<cfinput type="text" name="refno" id="refno" bind="cfc:refnobill.getrefno({tran},'#dts#',{refnoset})" bindonload="yes" required="yes" onKeyUp="nextIndex(event,'refno','custno');" >
</cfif>
</td>
<td width="5%">&nbsp;</td>
<th width="10%">Refno2</th>
<td width="20%"><cfinput type="text" name="refno2" id="refno2" value="" /></td>
</tr>
<tr>
<th>Cust / Supp Code</th>
<td colspan="2">
<cfif getGsetup.filterall eq "1">
<cfif lcase(hcomid) eq 'acht_i'>
<cfselect name="custno" id="custno" bind="cfc:custsupp.getlist({tran},'#target_arcust#','#target_apvend#','#dts#',{zcustno})" bindonload="yes" required="yes" selected="3060/Z95" display="custname" value="custno" onChange="updateDetails(this.value);" onKeyUp="nextIndex(event,'custno','wos_date');" message="Customer/Supplier is Required" />
<cfinput name="zcustno" id="zcustno" type="text" value=""  size="20" maxlength="8" onKeyUp="nextIndex(event,'custno','wos_date');" onBlur="updateDetails2();">
<input type="button" name="Scust1" value="Ajax Search" onClick="javascript:ColdFusion.Window.show('achtfindCustomer');getfocus();" >
<cfelse>
<cfinput name="custno" id="custno" type="text" value=""  size="20" maxlength="8" onKeyUp="nextIndex(event,'custno','wos_date');" onBlur="updateDetails(this.value);" required="yes" readonly message="Customer/Supplier is Required">
<cfif getdealermenu.custformat eq '2'>
<input type="button" name="Scust1" value="Ajax Search" onClick="javascript:ColdFusion.Window.show('findCustomer');getfocus4();" >
<cfelse>
<input type="button" name="Scust1" value="Ajax Search" onClick="javascript:ColdFusion.Window.show('findCustomer');getfocus();" >
</cfif>
</cfif>
<cfelse>
<cfselect name="custno" id="custno" bind="cfc:custsupp.getlist({tran},'#target_arcust#','#target_apvend#','#dts#',{zcustno})" bindonload="yes" required="yes" display="custname" value="custno" onChange="updateDetails(this.value);" onKeyUp="nextIndex(event,'custno','wos_date');" message="Customer/Supplier is Required" />

<cfinput name="zcustno" id="zcustno" type="text" value=""  size="20" maxlength="8" onKeyUp="nextIndex(event,'custno','wos_date');" onBlur="updateDetails2();">
</cfif></td>
<th>Date</th>
<cfset datenow=now()>
<cfif getGsetup.autonextdate lte timeformat(now(),'HH')>
<cfset datenow=dateadd('d',1,now())>
<cfelse>
<cfset datenow=now()>
</cfif>
<td><cfif hcomid eq "hairo_i"  or hcomid eq "freshways_i"><input type="text" name="wos_date" id="wos_date" value="#dateformat(datenow,'DD/MM/YYYY')#" onKeyUp="nextIndex(event,'wos_date','searchitembtn');" /><cfelse><input type="text" name="wos_date" id="wos_date" value="#dateformat(datenow,'DD/MM/YYYY')#" onKeyUp="nextIndex(event,'wos_date','expressservicelist');" /></cfif><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(wos_date);">&nbsp;(DD/MM/YYYY)</td>
<td></td>
<th><cfif hcomid eq "ulp_i"><cfelse>Agent</cfif></th>
<td><cfif hcomid eq "ulp_i"><div style="visibility:hidden"><cfselect name="agent" id="agent" bind="cfc:custsupp.getagent('#dts#')" bindonload="yes" display="agentdesp" value="agent" /><input type="hidden" name="agenthid" id="agenthid" value=""></div><cfelse><cfselect name="agent" id="agent" bind="cfc:custsupp.getagent('#dts#')" bindonload="yes" display="agentdesp" value="agent" /><input type="hidden" name="agenthid" id="agenthid" value=""></cfif></td>
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
<td><input type="text" name="bcode" id="bcode" value="Profile" <cfif getgsetup.ECAOTA eq "N" and (HUserGrpID neq "admin" and HUserGrpID neq "super")>readonly</cfif> /></td>
<td><cfinput type="text" name="b_name2" id="b_name2" size="40" maxlength="35" /></td>
<td></td>
<td><input type="text" name="DCode" id="DCode" value="Profile" <cfif getgsetup.ECAOTA eq "N" and (HUserGrpID neq "admin" and HUserGrpID neq "super")>readonly</cfif> /></td>
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
<cfif getmodule.job eq "1"><div style="visibility:hidden">
<th>Job</th>
</div>
</cfif>
<cfif getmodule.job eq "1"><div style="visibility:hidden">
<td><cfselect name="job" id="job" bind="cfc:custsupp.getjob('#dts#')" bindonload="yes" display="jobdesp" value="source" /></td>
</div>
</cfif>
</tr>
<tr>
<td><cfquery name="getlastran" datasource="#dts#">
SELECT type,refno FROM artran WHERE created_by = <cfqueryparam cfsqltype="cf_sql_varchar" value="#huserid#"> order by created_on desc limit 1
</cfquery>Last Transaction:</td>

<td><cfinput type="text" name="b_add2" id="b_add2" size="40" maxlength="35" /></td>
<td></td>
<td><cfinput type="button" name="changedaddr" id="changedaddr" onClick="ColdFusion.Window.show('changedaddr');" value="Change Del Add"></td>
<td><cfinput type="text" name="d_add2" id="d_add2" size="40" maxlength="35" /></td>
<td>&nbsp;</td>
<th><cfif hcomid eq "ulp_i"><cfelse>#getgsetup.ldriver#</cfif></th>
<td><cfif hcomid eq "ulp_i"><div style="visibility:hidden"><cfselect name="driver" id="driver" bind="cfc:custsupp.geteu('#dts#')" bindonload="yes" display="eudesp" value="driverno" /> <input type="hidden" name="driverhid" id="driverhid" value=""></div><cfelse><cfselect name="driver" id="driver" bind="cfc:custsupp.geteu('#dts#')" bindonload="yes" display="eudesp" value="driverno" /> <input type="hidden" name="driverhid" id="driverhid" value=""></cfif></td>
</tr>
<tr>
<td>#getlastran.type#--#getlastran.refno#</td>
<td><cfinput type="text" name="b_add3" id="b_add3" size="40" maxlength="35" /></td>
<td></td>
<td></td>
<td><cfinput type="text" name="d_add3" id="d_add3" size="40" maxlength="35" /></td>
<td>&nbsp;</td>
<th><cfif hcomid eq "ulp_i"><cfelse>Currency</cfif></th>
<td><cfif hcomid eq "ulp_i">

<cfinput type="hidden" name="currcode" id="currcode" size="10"  /><input type="hidden" name="currcodehid" id="currcodehid" value="">&nbsp;<cfinput type="hidden" name="currrate" id="currrate" bind="cfc:custsupp.getcurrrate('#dts#',{currcode},'#target_currency#')" bindonload="yes" size="5" />

<cfelse><cfinput type="text" name="currcode" id="currcode" size="10"  /><input type="hidden" name="currcodehid" id="currcodehid" value="">&nbsp;<cfinput type="text" name="currrate" id="currrate" bind="cfc:custsupp.getcurrrate('#dts#',{currcode},'#target_currency#')" bindonload="yes" size="5" /></cfif></td>
</tr>
<tr>
<td></td>
<td><cfinput type="text" name="b_add4" id="b_add4" size="40" maxlength="35" /></td>
<td></td>
<td></td>
<td><cfinput type="text" name="d_add4" id="d_add4" size="40" maxlength="35" /></td>
<td>&nbsp;</td>
<th><cfif hcomid eq "ulp_i"><cfelse>PONO</cfif></th>
<td><cfif hcomid eq "ulp_i"><cfinput type="hidden" name="PONO" id="PONO" size="30" /><cfelse><cfinput type="text" name="PONO" id="PONO" size="30" /></cfif></td>
</tr>
<tr>
<th>Attn</th>
<td><cfinput type="text" name="b_attn" id="b_attn" size="40" maxlength="35" /></td>
<td></td>
<th>Del Attn</th>
<td><cfinput type="text" name="d_attn" id="d_attn" size="40" maxlength="35" /></td>
<td>&nbsp;</td>
<th><cfif hcomid eq "ulp_i"><cfelse>DONO</cfif></th>
<td><cfif hcomid eq "ulp_i"><cfinput type="hidden" name="DONO" id="DONO" size="30" /><cfelse><cfinput type="text" name="DONO" id="DONO" size="30" /></cfif></td>
</tr>
<tr>
<th>Telephone</th>
<td><cfinput type="text" name="b_phone" id="b_phone" size="40" maxlength="35" /></td>
<td></td>
<th>Del Telephone</th>
<td><cfinput type="text" name="d_phone" id="d_phone" size="40" maxlength="35" /></td>
<td>&nbsp;</td>
<th><cfif hcomid eq "ulp_i"><cfelse>DESP</cfif></th>
<td><cfif hcomid eq "ulp_i"><cfinput type="hidden" name="desp" id="desp" size="40" maxlength="40" /><cfelse><cfinput type="text" name="desp" id="desp" size="40" maxlength="40" /></cfif></td>
</tr>
<tr>
<th>Telephone 2</th>
<td><cfinput type="text" name="b_phone2" id="b_phone2" size="40" maxlength="35" /></td>
<td></td>
<th>Del Fax</th>
<td><cfinput type="text" name="d_fax" id="d_fax" size="40" maxlength="35" /></td>
<td>&nbsp;</td>
<td rowspan="2"><a href="##" id="timemachine" onClick="ColdFusion.Window.show('timemanchine');"><img src="/images/appointment.png" height="32" width="32" border="0" alt="Time Manchines" /></a></td>
<td><cfif hcomid eq "ulp_i"><cfinput type="hidden" name="despa" id="despa" size="40" maxlength="40" /><cfelse><cfinput type="text" name="despa" id="despa" size="40" maxlength="40" /></cfif></td>
</tr>
<tr>
<th>Fax</th>
<td><cfinput type="text" name="b_fax" id="b_fax" size="40" maxlength="35" />
<input type="hidden" name="B_add5" id="B_add5" value="">
<input type="hidden" name="d_add5" id="d_add5" value=""></td>
<td></td>
<th colspan="2" rowspan="2">
<cfquery datasource="#dts#" name="getlocation">
	select 
	location,
	desp 
	from iclocation 
    where 0=0
    and (noactivelocation ='' or noactivelocation is null)
    <cfif (lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjctrial_i") and (HUserGrpID neq 'Van Sales')>
    <cfelse>
    <cfif Huserloc neq "All_loc">
	and location='#Huserloc#'
	</cfif>
    </cfif>
	order by location;
</cfquery>
<div id="ajaxField5" name="ajaxField5"></div></th>
<td></td>
</tr>
<cfif lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "kjctrial_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i">
<tr><td></td></tr>
<tr>
<th>#getgsetup.rem5#</th><td><input type="text" name="rem5" id="rem5" value="" size="40" maxlength="35"></td>
<td></td>
<th>#getgsetup.rem6#</th><td><input type="text" name="rem6" id="rem6" value="" size="40" maxlength="35"></td><td></td>
<th>#getgsetup.rem11#</th><td><textarea name="rem11" id="rem11" cols='40' rows='3' onKeyDown="limitText(this.form.rem11,200);" onKeyUp="limitText(this.form.rem11,200);"></textarea></td>
</tr>
</cfif>


</table>
</div>
  <div class="CollapsiblePanelTab" tabindex="1">Footer</div>
  <div class="CollapsiblePanelContent">
<table width="100%" border="0">
<tr>
<th width="10%">Choose a product</th>
<td  width="23%">
<cfif hcomid eq "hairo_i"  or hcomid eq "freshways_i">
<cfinput type="text" name="expressservicelist" id="expressservicelist" size="26" onBlur="this.value = this.value.split('___', 1);getitemdetail(this.value);" onKeyUp="getitemdetail(this.value);nextIndex(event,'expressservicelist','desp2');" autosuggest="cfc:itemno.findItem({cfautosuggestvalue},'#dts#')" autosuggestminlength="1" autosuggestBindDelay="1" readonly/>

<cfelseif lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "kjctrial_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i">

<cfinput type="text" name="expressservicelist" id="expressservicelist" size="26" onBlur="this.value = this.value.split('___', 1);getitemdetail(this.value);" onKeyUp="getitemdetail(this.value);nextIndex(event,'expressservicelist','desp2');" autosuggest="cfc:itemno.findItem({cfautosuggestvalue},'#dts#','#hcomid#','#Huserloc#')" autosuggestminlength="1"/>

<cfelseif lcase(hcomid) eq "simplysiti_i">

<cfinput type="text" name="expressservicelist" id="expressservicelist" size="26" onBlur="this.value = this.value.split('___', 1);getitemdetail(this.value);" onKeyUp="nextIndex(event,'expressservicelist','desp2');" autosuggest="cfc:itemno.findItem({cfautosuggestvalue},'#dts#','#hcomid#','#Huserid#')" autosuggestminlength="1"/>

<cfelse>

<cfinput type="text" name="expressservicelist" id="expressservicelist" size="26" onBlur="this.value = this.value.split('___', 1);getitemdetail(this.value);" onKeyUp="getitemdetail(this.value);nextIndex(event,'expressservicelist','desp2');" autosuggest="cfc:itemno.findItem({cfautosuggestvalue},'#dts#')" autosuggestminlength="1"/>
</cfif>
<cfif getdealermenu.itemformat eq '2'>
<input type="button" id="searchitembtn" onClick="ColdFusion.Window.show('searchitem');getfocus3();" value="Search" align="right" />
<cfelse>
<input type="button" id="searchitembtn" onClick="ColdFusion.Window.show('searchitem');getfocus2();" value="Search" align="right" />
</cfif>
<cfif getpin2.h1310 eq 'T'><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="window.open('/default/maintenance/icitem2.cfm?type=Create&express=1');">CNI</a></cfif>
<cfif lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "kjctrial_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i">
<input type="button" value="Location balance" onClick="ColdFusion.Window.show('itembalance');">
</cfif>
</td>
<td width="1%">&nbsp;</td>
<th width="10%">Description</th>
<td width="20%"><input type="text" name="desp2" id="desp2" size="40" onKeyUp="nextIndex(event,'desp','<cfif lcase(hcomid) eq "hairo_i"  or hcomid eq "freshways_i">expqty<cfelse>expcomment</cfif>');" ></td>
<td width="1%">&nbsp;</td>
<th width="10%">Comment</th>
<td rowspan="2" width="20%"><textarea name="expcomment" id="expcomment" cols="40" rows="3" onKeyUp="nextIndex(event,'expcomment','expqty');" ></textarea></td>
</tr>
<tr>
  <td><div id="itembal"></div></td>
  <td><div id="itemDetail"></div></td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td><input type="text" name="desp2a" id="desp2a" size="40" onKeyUp="nextIndex(event,'desp','expcomment');"></td>
  <td>&nbsp;</td>
  <td><input type="button" name="SearchComment" value="Search Comment" onClick="javascript:ColdFusion.Window.show('findComment');"></td>
  </tr>
<tr>
  <th>Quantity</th>
  <td>
  <cfif hcomid eq "hairo_i" or hcomid eq "freshways_i">
  <input type="text" style="font: large bolder" name="expqty" id="expqty" size="10" maxlength="10" value="" onKeyUp="calamtadvance();nextIndex(event,'expqty','<cfif getpin2.h1360 eq 'T'>expprice<cfelse>btn_add</cfif>');<cfif getgsetup.expressdisc neq "1">document.getElementById('expqtycount').value = this.value;</cfif>" >
  <cfelse>
  <input type="text" style="font: large bolder" name="expqty" id="expqty" size="10" maxlength="10" value="1" onKeyUp="calamtadvance();nextIndex(event,'expqty','<cfif getpin2.h1360 eq 'T'>expunit<cfelse>btn_add</cfif>');<cfif getgsetup.expressdisc neq "1">document.getElementById('expqtycount').value = this.value;</cfif>" >
  </cfif>
  </td>
  <td>&nbsp;</td>
  <th>Unit</th>
  <td><cfselect name="expunit" id="expunit"  onKeyUp="nextIndex(event,'expunit','expprice');" onChange="setunitprice();"></cfselect></td>
  
  <td><div id="ajaxfieldgetunitprice">
  </div>&nbsp;</td>
  <th>Price</th>
  <td><input type="<cfif getpin2.h1360 eq 'T'>text<cfelse>hidden</cfif>" name="expprice" id="expprice" size="15" maxlength="15" value="0.00" onKeyUp="calamtadvance();nextIndex(event,'expprice',<cfif hcomid eq "hairo_i" or hcomid eq "freshways_i">'btn_add'<cfelse><cfif getgsetup.expressdisc eq "1">'expunitdis1'<cfelse>'expqtycount'</cfif></cfif>)"  ></td>
</tr>
<tr>
  <th>Discount</th>
  <td>
  <cfif getgsetup.expressdisc eq "1">
  <input <cfif hcomid eq "hairo_i" or hcomid eq "freshways_i">style="visibility:hidden"</cfif> type="<cfif getpin2.h1360 eq 'T'>text<cfelse>hidden</cfif>" name="expunitdis1" id="expunitdis1" size="5" value="0" onKeyUp="caldisamt();calamtadvance();nextIndex(event,'expunitdis1','expunitdis2')"  >
%&nbsp;&nbsp;
<input <cfif hcomid eq "hairo_i" or hcomid eq "freshways_i">style="visibility:hidden"</cfif> type="<cfif getpin2.h1360 eq 'T' >text<cfelse>hidden</cfif>" name="expunitdis2" id="expunitdis2" size="5" value="0" onKeyUp="caldisamt();calamtadvance();nextIndex(event,'expunitdis2','expunitdis3')" />
%&nbsp;&nbsp;
<input <cfif hcomid eq "hairo_i" or hcomid eq "freshways_i">style="visibility:hidden"</cfif> type="<cfif getpin2.h1360 eq 'T'>text<cfelse>hidden</cfif>" name="expunitdis3" id="expunitdis3" size="5" value="0" onKeyUp="caldisamt();calamtadvance();nextIndex(event,'expunitdis3','expdis')" />%
<br>
<cfelse>
<input type="hidden" name="expunitdis1" id="expunitdis1" size="5" value="0" />
<input type="hidden" name="expunitdis2" id="expunitdis2" size="5" value="0" />
<input type="hidden" name="expunitdis3" id="expunitdis3" size="5" value="0" />
<input <cfif hcomid eq "hairo_i" or hcomid eq "freshways_i">style="visibility:hidden"</cfif> type="<cfif getpin2.h1360 eq 'T'>text<cfelse>hidden</cfif>" name="expqtycount" id="expqtycount" size="3" value="1" onKeyUp="caldisamt();calamtadvance();nextIndex(event,'expqtycount','expunitdis')" >
&nbsp;&nbsp;
<input <cfif hcomid eq "hairo_i" or hcomid eq "freshways_i">style="visibility:hidden"</cfif> type="<cfif getpin2.h1360 eq 'T'>text<cfelse>hidden</cfif>" name="expunitdis" id="expunitdis" size="5" value="0.00" onKeyUp="caldisamt();calamtadvance();nextIndex(event,'expdis','btn_add')" />
&nbsp;&nbsp;
</cfif>

<input <cfif hcomid eq "hairo_i" or hcomid eq "freshways_i">style="visibility:hidden"</cfif> type="<cfif getpin2.h1360 eq 'T'>text<cfelse>hidden</cfif>" name="expdis" id="expdis" size="10" maxlength="10" value="0.00" onKeyUp="calamtadvance();nextIndex(event,'expdis','btn_add')" onBlur="calamtadvance();"></td>
  <td>&nbsp;</td>
  <th>Amount</th>
  <td><input type="<cfif getpin2.h1360 eq 'T'>text<cfelse>hidden</cfif>" style="font: large bolder" name="expressamt" id="expressamt" size="10" value="0.00" readonly >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <input name="btn_add" style="font: medium bolder" id="btn_add" type="button" value="Add" onClick="this.disabled=true;addnewitem2();" disabled></td>
  <td>&nbsp;</td>
  <th><!--- Activate Barcode Scan --->Next Transaction No</th>
  <td><cfselect name="nextransac" id="nextransac" bind="cfc:nextran.newtran('#dts#','#uuid#',{expressservicelist})" bindonload="yes" display="trancode" value="trancode"/><input type="checkbox" style="display:none" name="activatebarcode" id="activatebarcode" value="Y" /><input type="hidden" name="pagesize" id="pagesize" value="7" /><div id="ajaxFieldPro" name="ajaxFieldPro"></div>  </td>
</tr>
<tr>
  <th>GL Account No</th>
  <td><cfinput type="text" name="glacc" id="glacc" maxlength="10" size="10" mask="9999/999" /></td>
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
  <th>
  Location</th>
  <td><div id="itemlocationajax"><select name="locationfr" id="locationfr" onChange="ajaxFunction(window.document.getElementById('itembal'),'/default/transaction/expressbill/balonhand.cfm?itemno='+encodeURI(document.getElementById('expressservicelist').value)+'&location='+escape(this.value));getitemdetail(this.value);">
<option value="">Select a location</option>
<cfloop query="getlocation">
<option value="#location#" <cfif getgsetup.ddllocation eq location>selected</cfif>>#location# - #desp#</option>
</cfloop>
</select>
<input type="hidden" id="locationto" name="locationto" value="" />
</div>
</td>
</tr>
<tr onClick="setTimeout('recalculateamt();',750)">
<td colspan="8" height="200">
<cfset datashow = "yes">
<cfif getpin2.h1360 neq 'T'>
<cfset datashow = "no">
</cfif>
<cfgrid name="itemlist" pagesize="7" format="html" width="100%" height="100%"
bind="cfc:itemlist.getictran({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},'#dts#','#uuid#',{pagesize})"
                                onchange="cfc:itemlist.editictran({cfgridaction},
                                            {cfgridrow},
                                            {cfgridchanged},'#dts#','#HUserID#')" selectmode="edit" textcolor="##000000" delete="yes" deletebutton="Delete" selectonload="false">
                                
                    <cfgridcolumn name="trancode" header="No" dataalign="center" select="no" width="30">
                    <cfgridcolumn name="itemno" header="Item Code" dataalign="left" select="no" width="100">
                    <cfgridcolumn name="desp" header="Description" dataalign="left" select="no" width="300">
                    <cfgridcolumn name="qty_bil" header="Quantity" dataalign="center" select="no" width="100">
                    <cfgridcolumn name="price_bil" header="Price" dataalign="right" select="no" width="150" display="#datashow#">
                    <cfgridcolumn name="amt_bil" header="Amount" dataalign="right" select="no" width="150" display="#datashow#">
                    <cfgridcolumn name="uuid" header="uuid" dataalign="right" display="no">       
							</cfgrid></td>
</tr>
<tr>
  <th>Sub Total</th>
  <td>
  <cfif getpin2.h1360 eq 'T'><cfset inputtype = "text"><cfelse><cfset inputtype = "hidden"></cfif>
  <cfinput type="#inputtype#" name="gross" id="gross" readonly="yes" value="0.00"  /></td>
  <td>&nbsp;</td>
  <th>Discount</th>
  <td>
  <cfinput type="#inputtype#" size="3" name="dispec1" id="dispec1" value="0" validate="float" validateat="onblur" message="Please key in numeric value" onKeyUp="calcdisc();caltax();calcfoot();" />%<input type="hidden" name="disbil1" id="disbil1" />&nbsp;+&nbsp;
  <cfinput type="#inputtype#" size="3" name="dispec2" id="dispec2" value="0" validate="float" validateat="onblur" message="Please key in numeric value" onKeyUp="calcdisc();caltax();calcfoot();"/>%<input type="hidden" name="disbil2" id="disbil2" />&nbsp;+&nbsp;
  <cfinput type="#inputtype#" size="3" name="dispec3" id="dispec3" value="0" validate="float" validateat="onblur" message="Please key in numeric value" onKeyUp="calcdisc();caltax();calcfoot();"/>%<input type="hidden" name="disbil3" id="disbil3" />&nbsp;&nbsp;=&nbsp;
  <cfinput type="#inputtype#" size="5" name="disamt_bil" id="disamt_bil" value="0.00" validate="float" validateat="onblur" message="Please key in numeric value" onKeyUp="caltax();calcfoot();" />  </td>
  <td>&nbsp;</td>
  <th>NET</th>
  <td><cfinput type="#inputtype#" name="net" id="net" value="0.00" readonly="yes" /></td>
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
  <td>
  <cfif lcase(hcomid) eq "acht_i">
  <cfselect name="taxcode" id="taxcode" bind="CFC:tax.getTaxQry('#dts#','#target_taxtable#',{tran})" value="code" display="code" onChange="setTimeout('caltax()',500);" bindonload="yes"/>&nbsp;&nbsp;<cfinput type="#inputtype#" name="taxper" id="taxper" value="7" size="8" onKeyUp="caltax()" bind="CFC:tax.getTax('#dts#','#target_taxtable#',{taxcode})" />&nbsp;&nbsp;&nbsp;
  <cfelse>
  <cfselect name="taxcode" id="taxcode" bind="CFC:tax.getTaxQry('#dts#','#target_taxtable#',{tran})" value="code" display="code" onChange="setTimeout('caltax()',500);" bindonload="yes"/>&nbsp;&nbsp;<cfinput type="#inputtype#" name="taxper" id="taxper" readonly value="0" size="8" bind="CFC:tax.getTax('#dts#','#target_taxtable#',{taxcode})" onKeyUp="caltax()" bindonload="yes"  />&nbsp;&nbsp;&nbsp;
  </cfif>
  <cfinput type="#inputtype#" name="taxamt" id="taxamt" value="0.00" size="10" onKeyUp="calcfoot();" />  </td>
  <td>&nbsp;</td>
  <th>Grand</th>
  <td><cfinput type="#inputtype#" style="font: large bolder" name="grand" id="grand" value="0.00" readonly="yes" /></td>
</tr>
<cfif lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "kjctrial_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i">
<tr>
<th>Cash</th><td><cfinput name="cash" type="hidden" value="0.00" maxlength="15">  <input type="checkbox" name="checkcash" onClick="copygrandtocash();"></td>
<td></td>
<th>Cheque</th><td><cfinput name="cheque" type="hidden" value="0.00" maxlength="15">  <input type="checkbox" name="checkcheq" onClick="copygrandtocheq();"></td>
</tr>
</cfif>
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
<cfif getdealermenu.custformat eq '2'>
<cfwindow center="true" width="550" height="400" name="findCustomer" refreshOnShow="true"
        title="Find Customer or Supplier" initshow="false"
        source="/default/transaction/expressbill/findCustomer2.cfm?type={tran}&custno={custno}" />
<cfelse>
<cfwindow center="true" width="550" height="400" name="findCustomer" refreshOnShow="true"
        title="Find Customer or Supplier" initshow="false"
        source="/default/transaction/expressbill/findCustomer.cfm?type={tran}&custno={custno}" />
</cfif>
<cfif lcase(hcomid) eq 'acht_i'>
<cfwindow center="true" width="550" height="400" name="achtfindCustomer" refreshOnShow="true"
        title="Find Customer or Supplier" initshow="false"
        source="/default/transaction/expressbill/achtfindCustomer.cfm?type={tran}&custno={custno}" />
</cfif>
<cfif getdealermenu.itemformat eq '2'>
<cfwindow center="true" width="700" height="500" name="searchitem" refreshOnShow="true" closable="true" modal="false" title="Search Item" initshow="false"
        source="/default/transaction/expressbill/searchitem2.cfm?reftype={tran}" />
<cfelse>
<cfwindow center="true" width="700" height="500" name="searchitem" refreshOnShow="true" closable="true" modal="false" title="Search Item" initshow="false"
        source="/default/transaction/expressbill/searchitem.cfm?reftype={tran}" />
</cfif>
        
<cfwindow center="true" width="600" height="400" name="changedaddr" refreshOnShow="true" closable="true" modal="false" title="Search Address" initshow="false"
        source="/default/transaction/expressbill/searchaddress.cfm" />
<cfif getgsetup.negstk neq "1">
<cfwindow center="true" width="300" height="300" name="negativestock" refreshOnShow="true" closable="true" modal="true" title="Negative Stock" initshow="false"
        source="negativestock.cfm" />
</cfif>
<cfif lcase(HcomID) eq "simplysiti_i">
<cfwindow center="true" width="300" height="300" name="transferlimitstock" refreshOnShow="true" closable="true" modal="true" title="Transfer Limit" initshow="false"
        source="transferlimitstock.cfm" />
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
<cfwindow center="true" width="700" height="500" name="findComment" refreshOnShow="true"
        title="Find Comment" initshow="false"
        source="/default/transaction/expressbill/findComment.cfm" />
        
<cfwindow center="true" width="700" height="500" name="itembalance" refreshOnShow="true" closable="true" modal="false" title="Location Qty Balance" initshow="false"
        source="/default/transaction/itembal2.cfm?itemno={expressservicelist}&project=&job=&batchcode=" />        

<script type="text/javascript">
gettitle();
<!--
var CollapsiblePanel1 = new Spry.Widget.CollapsiblePanel("CollapsiblePanel1");
//-->
</script>
 <cfquery name="getlast" datasource="#dts#">
SELECT uuid from ictrantemp group by uuid order by trdatetime desc limit 50 
</cfquery>
<cfquery name="emptytemp" datasource="#dts#">
Delete from ictrantemp where trdatetime < "#dateformat(dateadd('d','-2',now()),'YYYY-MM-DD')#" and onhold <> "Y" and uuid not in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getlast.uuid)#" list="yes" separator=",">)
</cfquery>