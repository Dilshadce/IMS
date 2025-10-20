<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1149,98,1151,1152,1153,1154,1155,16,23,29,30,6,1164,1165,40,42,300,1166,120,65,482,1167,120,227,1096,592,1097,58,10">
<cfinclude template="/latest/words.cfm">
<html>
<head>
	<title><cfoutput>#words[1149]#</cfoutput></title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
    <script type='text/javascript' src='/ajax/core/engine.js'></script>
	<script type='text/javascript' src='/ajax/core/util.js'></script>
	<script type='text/javascript' src='/ajax/core/settings.js'></script>
    <script type='text/javascript' src='/ajax/core/shortcut.js'></script>
    <script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
    <link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
	<script language="javascript" type="text/javascript" src="/scripts/CalendarControl.js"></script>
    <script type="text/javascript" src="/scripts/prototypenew.js" ></script>

<cfquery name="getgsetup" datasource="#dts#">
	SELECT * 
    FROM gsetup
</cfquery>
<cfoutput>
<script type="text/javascript">
	function test_prefix(form,field,value) {
		var allNum = "";
		var chkVal = allNum;
		var prsVal = parseInt(allNum);
		var item1 = value;
		var item2 = '#getgsetup.debtorfr#'; 
		var item3 = '#getgsetup.debtorto#'; 		
		var checkOK = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		var allValid = true;
		var decPoints = 0;
		var allNum = "";
		for (i = 0;  i < item1.length;  i++) {
			ch = item1.charAt(i);
			for (j = 0;  j < checkOK.length;  j++)
				if (ch == checkOK.charAt(j))
			break;
			if (j == checkOK.length) {
				allValid = false;
				break;
			}
			if (ch != ",")
				allNum += ch;
		}
		if (!allValid) {
			return false;
		}
		for (var i = 0; i<value.length; i++) {		
	    	if (item1.charCodeAt(i) < item2.charCodeAt(i) || item1.charCodeAt(i) > item3.charCodeAt(i)) {		
				return false;
			}
		} 
		return true;
	}
	function addOption(selectbox,text,value ) {
		var optn = document.createElement("OPTION");
		optn.text = text;
		optn.value = value;
		selectbox.options.add(optn);
	}
	function test_prefix1(form,field,value) {
		var allNum = "";
		var chkVal = allNum;
		var prsVal = parseInt(allNum);		
		var item1 = value;
		var item2 = '#getgsetup.creditorfr#'; 
		var item3 = '#getgsetup.creditorto#';	
		var checkOK = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		var allValid = true;
		var decPoints = 0;
		var allNum = "";		
		for (i = 0;  i < item1.length;  i++) {
			ch = item1.charAt(i);
			for (j = 0;  j < checkOK.length;  j++)
				if (ch == checkOK.charAt(j))
					break;
			if (j == checkOK.length) {
				allValid = false;
				break;
			}
			if (ch != ",")
				allNum += ch;
		}
		if (!allValid) {
			return false;
		}
		for (var i = 0; i<value.length; i++) {		
			if (item1.charCodeAt(i) < item2.charCodeAt(i) || item1.charCodeAt(i) > item3.charCodeAt(i)) {		
				return false;
			}
		} 
		return true;
	}
	
	function test_suffix(form,field,value) {
		// require that at least one character be entered
		if (value.length < 3) {
			return false;
		}
		if (value == '000') {
			return false;
		}
		return true;
	}
	function getCustSupp2(custno,custname) {
		myoption = document.createElement("OPTION");
		myoption.text = custno + " - " + custname;
		myoption.value = custno;
		document.invoicesheet.custno.options.add(myoption);
		var indexvalue = document.getElementById("custno").length-1;
		document.getElementById("custno").selectedIndex=indexvalue;
		updateDetails(document.invoicesheet.custno[indexvalue].value);
	}
	
	function getKey(keyStroke) {
		var t = window.event.srcElement.type;
		var keyCode = (document.layers) ? keyStroke.which : event.keyCode;
		var keyString = String.fromCharCode(keyCode).toLowerCase();
		var leftArrowKey = 37;
		var backSpaceKey = 8;
		var escKey = 27;
		if(t && (t =='text' || t =='textarea' || t =='file')) {
			//do not cancel the event
		}
		else {
			if( (window.event.altKey && window.event.keyCode==leftArrowKey) || (keyCode == escKey) || (keyCode == backSpaceKey)) {
				return false;
			}
		}
	}

	function getitemdetail(detailitemno) {
		if(detailitemno.indexOf('*') != -1) {
			var thisitemno = detailitemno.split('*');
			document.getElementById('itemno').value=thisitemno[1];
			document.getElementById('qty_bil').value=thisitemno[0];
			detailitemno=thisitemno[1];
		}
		if(trim(document.getElementById('itemno').value) != "") {
			var urlloaditemdetail = 'addItemAjax.cfm?itemno='+escape(encodeURI(detailitemno));
			<!---alert('1');
			ajaxFunction(document.getElementById('itemDetailfield'),urlloaditemdetail);
			alert('2');--->
			new Ajax.Request(urlloaditemdetail, {
				method:'get',
				onSuccess: function(getdetailback){
					document.getElementById('itemDetailfield').innerHTML = trim(getdetailback.responseText);
				},
				onFailure: function(){ 
					alert('Item Not Found');
				},		
				onComplete: function(transport){
					 <!--- getlocationbal(detailitemno);--->
					 updateVal();
				}
			})
		}
	}
	function updaterow(rowno) {
		var varcoltype = 'coltypelist'+rowno;
		var varqtylist = 'qtylist'+rowno;
		var repairno = document.getElementById('repairno').value;
		var coltypedata = document.getElementById(varcoltype).value;
		var qtylistdata = document.getElementById(varqtylist).value;
		var updateurl = 'updaterow.cfm?repairno='+escape(repairno)+'&coltype='+escape(coltypedata)+'&qty='+escape(qtylistdata)+'&trancode='+rowno;
		new Ajax.Request(updateurl, {
			method:'get',
			onSuccess: function(getdetailback){
				document.getElementById('ajaxFieldPro').innerHTML = trim(getdetailback.responseText);
			},
			onFailure: function(){ 
				alert('Error Update Item');
			},		
			onComplete: function(transport){
				calculatefooter();
				refreshlist();
			}
		})
	}
	function deleterow(rowno) {
		var repairno = document.getElementById('repairno').value;
		var updateurl = 'deleterow.cfm?repairno='+escape(repairno)+'&trancode='+rowno;
		<!---ajaxFunction(document.getElementById('ajaxFieldPro'),updateurl);--->
		new Ajax.Request(updateurl, {
			method:'get',
			onSuccess: function(getdetailback){
				document.getElementById('ajaxFieldPro').innerHTML = trim(getdetailback.responseText);
			},
			onFailure: function(){ 
				alert('Error Delete Item');
			},		
			onComplete: function(transport){
				document.getElementById('grossamt').value=document.getElementById('hidsubtotal').value;
				refreshlist();
			}
		})
	}
	var opt = 'Width=500px, Height=250px, Top=300px, left=400px, scrollbars=yes, status=no, resizable=1';
	var t1;
	var t2;
	function getfocus() {	
		t1 = setTimeout("document.getElementById('custno1').focus();",750);
	}
	function getfocus2() {
		t2 = setTimeout("document.getElementById('itemno1').focus();",1000);
	}
	function getfocus3() {
		t2 = setTimeout("document.getElementById('aitemno').focus();",1000);
	}
	function getfocus4() {
		setTimeout("document.getElementById('price_bil1').focus();",1000);
	}
	function getfocus5() {
		setTimeout("selectcopy();",2000);
	}
	function updateVal() {
		var validdesp = unescape(document.getElementById('desphid').value);
		if (validdesp == "itemisnoexisted") {
			document.getElementById('btn_add').value = "Item No Existed";
			document.getElementById('btn_add').disabled = true; 
			alert('Item Not Found');
		}
		else {
			try {
				document.getElementById('itemno').value = unescape(decodeURI(document.getElementById('replaceitemno').value));
			}
			catch(err) {
			}
			document.getElementById('itemdesp').value = unescape(decodeURI(document.getElementById('desphid').value));
			document.getElementById('price_bil').value = document.getElementById('pricehid').value;
			document.getElementById('btn_add').value = "Add";
			document.getElementById('btn_add').disabled = false; 
		}
		calamtadvance();
		if(document.getElementById('btn_add').value == "Add") {
		}
	}
	function caldisamt() {
		var qty_bil = trim(document.getElementById('qty_bil').value);
		var expprice = trim(document.getElementById('price_bil').value);
		var disamt1 = document.getElementById('dispec1').value;
		var disamt2 = document.getElementById('dispec2').value;
		var disamt3 = document.getElementById('dispec3').value;
		disamt1 = disamt1 * 0.01;
		disamt2 = disamt2 * 0.01;
		disamt3 = disamt3 * 0.01;
		var totaldiscount = ((((qty_bil * expprice) * disamt1)+ (((qty_bil * expprice)-(qty_bil * expprice) * disamt1))*disamt2)+(((qty_bil * expprice)-(((qty_bil * expprice)-(qty_bil * expprice) * disamt1))*disamt2))*disamt3);
		document.getElementById('disamt_bil').value = totaldiscount.toFixed(2);
	}
	function getcustomer() {
		var customerurl = '/default/transaction/repairservice/memberdetailajax.cfm?detail=1&member='+document.getElementById("custno").value;
		new Ajax.Request(customerurl, {
			method:'get',
			onSuccess: function(getdetailback){
				document.getElementById('getcustomerdetailajax').innerHTML = trim(getdetailback.responseText);
			},
			onFailure: function(){ 
				alert('Error Get Customer');
			},		
			onComplete: function(transport){
				updatecustomerdetail();
			}
		})
	}
	function calamtadvance() {
		var qty_bil = trim(document.getElementById('qty_bil').value);
		var expprice = trim(document.getElementById('price_bil').value);
		var expdis = trim(document.getElementById('disamt_bil').value);
		qty_bil = qty_bil * 1;
		expprice = expprice * 1;
		expdis = expdis * 1;
		var itemamt = (qty_bil * expprice) - expdis;
		document.getElementById('amt_bil').value =  itemamt.toFixed(2);
	}
	function trim(strval) {
		return strval.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	}
	function addItemAdvance() {
		document.getElementById('repairno').readOnly=true;
		var itemno=encodeURI(trim(document.getElementById('itemno').value));
		var desp = encodeURI(document.getElementById('desp').value);
		var itemdesp = encodeURI(document.getElementById('itemdesp').value);
		var itemdespa = encodeURI(document.getElementById('itemdespa').value);
		var amt_bil = trim(document.getElementById('amt_bil').value);
		var qty_bil = trim(document.getElementById('qty_bil').value);
		var price_bil = trim(document.getElementById('price_bil').value);
		var repairno = trim(document.getElementById('repairno').value);
		var wos_date = trim(document.getElementById('wos_date').value);
		var custno = trim(document.getElementById('custno').value);
		var name = trim(document.getElementById('name').value);
		var completedate = trim(document.getElementById('completedate').value);
		var repairitem = trim(document.getElementById('repairitem').value);
		var desp = trim(document.getElementById('desp').value);
		var dispec1 = trim(document.getElementById('dispec1').value);
		var dispec2 = trim(document.getElementById('dispec2').value);
		var dispec3 = trim(document.getElementById('dispec3').value);
		var disamt_bil = trim(document.getElementById('disamt_bil').value);
		var ajaxurl = 'addproductsAjax.cfm?itemno='+escape(itemno)+'&wos_date='+escape(wos_date)+'&custno='+escape(custno)+'&name='+escape(name)+'&completedate='+escape(completedate)+'&repairitem='+escape(repairitem)+'&desp='+escape(desp)+'&itemdesp='+escape(itemdesp)+'&itemdespa='+escape(itemdespa)+'&amt_bil='+escape(amt_bil)+'&qty_bil='+escape(qty_bil)+'&price_bil='+escape(price_bil)+'&repairno='+escape(repairno)+'&dispec1='+escape(dispec1)+'&dispec2='+escape(dispec2)+'&dispec3='+escape(dispec3)+'&disamt_bil='+escape(disamt_bil);
		<!---ajaxFunction(document.getElementById('ajaxFieldPro'),ajaxurl);--->
		 new Ajax.Request(ajaxurl, {
			method:'get',
			onSuccess: function(getdetailback){
				document.getElementById('ajaxFieldPro').innerHTML = trim(getdetailback.responseText);
			},
			onFailure: function(){ 
				alert('Error Add Item');
			},		
			onComplete: function(transport){
				document.getElementById('grossamt').value=document.getElementById('hidsubtotal').value;
				clearformadvance();
				refreshlist();
			}
		})
	}
	function clearformadvance() {
		document.getElementById('itemno').value = '';
		document.getElementById('itemdesp').value = '';
		document.getElementById('itemdespa').value = '';
		document.getElementById('qty_bil').value = '1';
		document.getElementById('price_bil').value = '0.00';
		document.getElementById('amt_bil').value = '';
		document.getElementById('disamt_bil').value = '0.00';
		document.getElementById('dispec1').value = '0';
		document.getElementById('dispec2').value = '0';
		document.getElementById('dispec3').value = '0';
		document.getElementById('itemno').focus();
		<!---<cfif getgsetup.expressdisc neq "1">
		document.getElementById('qty_bilcount').value = '1';
		</cfif>--->
	}
	function refreshlist() {
		ajaxFunction(document.getElementById('itemlist'),'getBody.cfm?repairno='+document.getElementById('repairno').value);
	}
	function getlocationbal(itemnobal) {
		var urlloaditembal = 'balonhand.cfm?itemno='+encodeURI(itemnobal)+'&location='+escape(document.getElementById('locationfr').value);
		new Ajax.Request(urlloaditembal, {
			method:'get',
			onSuccess: function(getbalback){
				document.getElementById('itembal').innerHTML = trim(getbalback.responseText);
			},
			onFailure: function(){ 
				alert('Item Not Found');
			}
		})
	}
	<!---function recalculateall()
	{
	<cfoutput>
    var urlload = 'recalculateAjax.cfm?uuid=#URLEncodedFormat(uuid)#';
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
	}--->
	function validformfield() {
		var formvar = document.getElementById('invoicesheet');
		var answer = _CF_checkinvoicesheet(formvar);
		if (answer) {
			recalculateall();
		}
		else {
		}
	}
	function addOption(selectbox,text,value ) {
		var optn = document.createElement("OPTION");
		optn.text = text;
		optn.value = value;
		selectbox.options.add(optn);
	}
	<!---
	
	function recalculateamt()
	{
	var ajaxurl = 'recalculateAjax.cfm?uuid=#URLEncodedFormat(uuid)#';
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
	}--->
	function addnewitem2() {
		if(document.getElementById('amt_bil').value=='NaN') {
			alert('Error in Qty / Price / Discount / Amt');
			return false;
		}
		calamtadvance();
		if(trim(document.getElementById('repairno').value) != '') {
			addItemControl();
		}
		else {
			alert('Please key in Repair Code');
		}
	}
	function addItemControl() {
		var itemno = document.getElementById('itemno').value;
		var qtyser = document.getElementById('qty_bil').value;
		if (itemno == "") {
			alert("Please select item");
		}
		else {
			addItemAdvance();
		}
	}
	function selectlist(varval,varattb){		
		for (var idx=0;idx<document.getElementById(varattb).options.length;idx++) {
			if (varval==document.getElementById(varattb).options[idx].value) {
				document.getElementById(varattb).options[idx].selected=true;
			}
		}
	}
</script>
</cfoutput>
</head>

<body>
<cfoutput>
<cfquery name="getdisplaysetup2" datasource="#dts#">
	SELECT * 
    FROM displaysetup2
</cfquery>

<cfquery name="getRepair" datasource="#dts#">
    SELECT * 
    FROM Repairtran 
    WHERE repairno = '#url.repairno#'
</cfquery>
<cfset repairno=url.repairno>
<cfset wos_date=getRepair.wos_date>
<cfset custno=getRepair.custno>
<cfset name=getRepair.name>
<cfset completedate=getRepair.completedate>
<cfset repairitem=getRepair.repairitem>
<cfset grossamt=getRepair.grossamt>
<cfset xagent=getRepair.agent>

<cfset rem5=getRepair.rem5>
<cfset rem6=getRepair.rem6>
<cfset rem7=getRepair.rem7>
<cfset rem8=getRepair.rem8>
<cfset rem9=getRepair.rem9>
<cfset rem10=getRepair.rem10>
<cfset rem11=getRepair.rem11>
<cfset status=getRepair.status>

<cfset add1=getRepair.add1>
<cfset add2=getRepair.add2>
<cfset add3=getRepair.add3>
<cfset add4=getRepair.add4>
<cfset phone=getRepair.phone>
<cfset phonea=getRepair.phonea>
<cfset fax=getRepair.fax>
<cfset DELIVERYSTATUS=getRepair.DELIVERYSTATUS>
<cfset location=getrepair.location>

<cfset mode="Edit">
<cfset title="Edit Repair">
<cfset button="Repair">
<cfset modeWords="#words[98]#">
<cfset pageTitle="Update Repair Service">

<cfquery datasource="#dts#" name="getlocation">
    SELECT location, desp 
    FROM iclocation 
    WHERE 0=0
    AND (noactivelocation='' or noactivelocation is null)
    <cfif (lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjctrial_i") and (HUserGrpID neq 'Van Sales')>
    <cfelse>
		<cfif Huserloc neq "All_loc">
            AND location='#Huserloc#'
        </cfif>
    </cfif>
    ORDER BY location;
</cfquery>
<cfquery datasource="#dts#" name="checkrccreated">
    SELECT refno 
    FROM artran 
    WHERE type='RC' AND refno='#repairno#'
</cfquery>
<cfquery datasource="#dts#" name="getagent">
    SELECT * 
    FROM #target_icagent# 
    ORDER BY agent
</cfquery>
<h1>#pageTitle#</h1>
<h4>
<a href="createrepairservicetable.cfm?type=Create">#words[1151]#</a>
|| <a href="repairservicetable.cfm">#words[1152]#</a>
|| <a href="s_repairservicetable.cfm?type=Repair">#words[1153]#</a>
|| <a href="p_repairservice.cfm">#words[1154]#</a>
</h4>
<cfform name="repairserviceform" action="repairservicetableprocess.cfm" method="post">
    <input type="hidden" name="mode" value="#modeWords#">
    <h1 align="center">Repair Service Process</h1>
    <table align="center" class="data" width="70%">
        <tr>
            <th width="100">#words[1155]#: </th>
            <td><cfinput type="text" size="12" name="repairno" value="#repairno#" readonly></td>
            <th width="100">Repair Date :</th>
            <td><cfinput type="text" name="wos_date" size="10" value="#dateformat(now(),"dd/mm/yyyy")#" validate="eurodate" maxlength="10">(DD/MM/YYYY)</td>
        </tr>
        <tr>
            <th width="100">#words[16]#: </th>
            <td colspan="3">
            <cfif checkrccreated.recordcount neq 0>
                <input type="text" name="custno" id="custno" value="#custno#" readonly>
            <cfelse>
                <cfquery name="geteuqry" datasource="#dts#">
                    SELECT " Choose an Customer" AS eudesp, "" AS custNO
                    UNION ALL 
                    SELECT concat(custno,' - ',name) AS eudesp, custno 
                    FROM #target_arcust#
                    order by eudesp
                </cfquery>
                <cfselect name="custno" id="custno" query="geteuqry" display="eudesp" value="custno" onChange="getcustomer();" onKeyUp="getcustomer();" required="yes" message="Please Choose a Customer" />
                <input type="button" name="Scust1" value="Customer Search" onClick="javascript:ColdFusion.Window.show('findCustomer');getfocus();" >
                <input type="hidden" name="custhid" id="custhid"> &nbsp;&nbsp;
                <input type="hidden" name="custhid" id="custhid">&nbsp;&nbsp;
            </cfif>         
            </td>
        </tr>
        <tr>
            <th>#words[23]#: </th>
            <td><cfinput type="text" size="40" name="name" id="name" required="no" value="#getRepair.name#" maxlength="40" readonly></td>
            <th>#words[29]#</th>
            <td>
            <select name="agent" id="agent">
                <option value="">#words[30]#</option>
                <cfloop query="getagent">
                    <option value="#getagent.agent#" <cfif xagent eq getagent.agent>selected</cfif>>#getagent.agent# - #getagent.desp#</option>
                </cfloop>
            </select>
            </td>
        </tr>
        <tr>
            <th>#words[6]#:</th>
            <td><input type="text" name="b_add1" id="b_add1" value="#add1#" maxlength="35" size="40"></td>
            <th>#words[1164]#: </th>
            <td><cfinput type="text" name="completedate" size="10" value="#dateformat(completedate,"dd/mm/yyyy")#" readonly maxlength="10">(DD/MM/YYYY)</td>
        </tr>
        <tr>
            <th></th>
            <td><input type="text" name="b_add2" id="b_add2" value="#add2#" maxlength="35" size="40"></td>
            <th>#words[1165]#</th>
            <td><cfinput type="text" size="40" name="deliverystatus" id="deliverystatus" value="#deliverystatus#" required="no" maxlength="40" readonly></td>
        </tr>
        <tr>
            <th></th>
            <td><input type="text" name="b_add3" id="b_add3" value="#add3#" maxlength="35" size="40"></td>
            <th nowrap <cfif getdisplaysetup2.hremark5 neq "Y">style="visibility:hidden"</cfif>>#getGsetup.rem5# :</th>
            <td <cfif getdisplaysetup2.hremark5 neq "Y">style="visibility:hidden"</cfif>>
            <cfinput type="text" size="40" name="rem5" id="rem5" value="#rem5#" required="no" maxlength="80">
            </td>
        </tr>
        <tr>
            <th></th>
            <td><input type="text" name="b_add4" id="b_add4" value="#add4#" maxlength="35" size="40"></td>
            <th <cfif getdisplaysetup2.hremark6 neq "Y">style="visibility:hidden"</cfif> nowarp>#getGsetup.rem6# :</th>
            <td <cfif getdisplaysetup2.hremark6 neq "Y">style="visibility:hidden"</cfif>>
            <cfinput type="text" size="40" name="rem6" id="rem6" value="#rem6#" required="no" maxlength="80">
            </td>
        </tr>
        <tr>
            <th>#words[40]#:</th>
            <td><input type="text" name="b_phone" id="b_phone" value="#phone#" maxlength="35" size="40"></td>
            <th  nowrap <cfif getdisplaysetup2.hremark7 neq "Y">style="visibility:hidden"</cfif> nowarp>#getGsetup.rem7# :</th>
            <td <cfif getdisplaysetup2.hremark7 neq "Y">style="visibility:hidden"</cfif>>
            <cfinput type="text" size="40" name="rem7" id="rem7" value="#rem7#" required="no" maxlength="80">
        </tr>
        <tr>
            <th>#words[42]#:</th>
            <td><input type="text" name="b_phone2" id="b_phone2" value="#phonea#" maxlength="35" size="40"></td>
            <th <cfif getdisplaysetup2.hremark8 neq "Y">style="visibility:hidden"</cfif> nowarp>#getGsetup.rem8# :</th>
            <td <cfif getdisplaysetup2.hremark8 neq "Y">style="visibility:hidden"</cfif>>
            <cfinput type="text" size="40" name="rem8" id="rem8" value="#rem8#" required="no" maxlength="80">
            </td>
        </tr>
        <tr>
            <th>#words[300]#:</th>
            <td><input type="text" name="b_fax" id="b_fax" value="#fax#" maxlength="35" size="40"></td>
            <th nowrap <cfif getdisplaysetup2.hremark9 neq "Y">style="visibility:hidden"</cfif>>#getGsetup.rem9# :</th>
            <td <cfif getdisplaysetup2.hremark9 neq "Y">style="visibility:hidden"</cfif>>
            <cfinput type="text" size="40" name="rem9" id="rem9" value="#rem9#" required="no" maxlength="80">
            </td>
        </tr>
        <tr>
            <th></th>
            <td></td>
            <th nowrap <cfif getdisplaysetup2.hremark10 neq "Y">style="visibility:hidden"</cfif> nowarp>#getGsetup.rem10# :</th>
            <td <cfif getdisplaysetup2.hremark10 neq "Y">style="visibility:hidden"</cfif>>
            <cfinput type="text" size="40" name="rem10" id="rem10" value="#rem10#" required="no" maxlength="80">
            </td>
        </tr>
        <tr>
            <th></th>
            <td></td>
            <th nowrap <cfif getdisplaysetup2.hremark11 neq "Y">style="visibility:hidden"</cfif>>#getGsetup.rem11# :</th>
            <td <cfif getdisplaysetup2.hremark11 neq "Y">style="visibility:hidden"</cfif>>
            <cfinput type="text" size="40" name="rem11" id="rem11" value="#rem11#" required="no" maxlength="80">
            </td>
        </tr>
        <tr>
            <th colspan="100%"><div align="center">#words[1166]#</div></th>
        </tr>
        <tr>
            <th>#words[120]#</th>
            <td><cfinput type="text" name="repairitem" id="repairitem" size="26" value="#repairitem#" readonly required="yes" message="Please choose item to repair"/></td>
        </tr>
        <tr>
            <th>#words[65]#</th>
            <td><cfinput type="text" name="desp" id="desp" value="" size="70" maxlength="100" readonly/></td>
        </tr>
        <tr>
            <th>#words[482]#</th>
            <td><input type="text" id="location" name="location" value="#location#" readonly></td>
        </tr>
        <tr>
            <td colspan="100%"><hr></td>
        </tr>
        <tr>
            <th><b>#words[1167]#:</b></th>
            <td>
            <cfinput type="text" size="40" name="grossamt" required="no" value="#numberformat(getRepair.grossamt,'_.__')#" maxlength="40" readonly>
            </td>
        </tr>
    </table>
    <table align="center" class="data" width="90%">
        <tr>
            <th colspan="100%"><div align="center">Service Charges/Item Charges.</div></th>
        </tr>
        <tr>
            <th>#words[120]#</th>
            <td><cfinput type="text" name="itemno" id="itemno" size="26" onBlur="this.value = this.value.split('___', 1);getitemdetail(this.value);" autosuggest="cfc:itemno.findItem({cfautosuggestvalue},'#dts#')" autosuggestminlength="1"/>
            <input type="button" id="searchitembtn" onClick="ColdFusion.Window.show('searchitem');getfocus2();" value="Search" align="right" />
            <div id="itemDetailfield"></div>
            <div id="ajaxFieldPro"></div></td>
        </tr>
        <tr>
            <th>#words[65]#</th>
            <td><cfinput type="text" name="itemdesp" id="itemdesp" value="" size="70" maxlength="100"></td>
        </tr>
        <tr>
            <th></th>
            <td><cfinput type="text" name="itemdespa" id="itemdespa" value="" size="70" maxlength="100"></td>
        </tr>
        <tr>
            <th>#words[227]#</th>
            <td><cfinput type="text" name="qty_bil" id="qty_bil" value="1" onKeyUp="calamtadvance();"></td>
        </tr>
        <tr>
            <th>#words[1096]#</th>
            <td><cfinput type="text" name="price_bil" id="price_bil" value="0.00" onKeyUp="calamtadvance();"></td>
        </tr>
        <tr>
            <th>#words[592]#</th>
            <td>
            <input type="text" name="dispec1" id="dispec1" size="5" value="0" onKeyUp="caldisamt();calamtadvance();nextIndex('expunitdis1','expunitdis2')"  >
            %&nbsp;&nbsp;
            <input type="text" name="dispec2" id="dispec2" size="5" value="0" onKeyUp="caldisamt();calamtadvance();nextIndex('expunitdis2','expunitdis3')" />
            %&nbsp;&nbsp;
            <input type="text" name="dispec3" id="dispec3" size="5" value="0" onKeyUp="caldisamt();calamtadvance();nextIndex('expunitdis3','expdis')" />%
            &nbsp;&nbsp;
            <input type="text" name="disamt_bil" id="disamt_bil" size="10" maxlength="10" value="0.00" onKeyUp="calamtadvance();" onBlur="calamtadvance();">
            </td>
        </tr>
        <tr>
            <th>#words[1097]#</th>
            <td><cfinput type="text" name="amt_bil" id="amt_bil" value="" readonly="yes"></td>
        </tr>
        <tr>
            <td align="center" colspan="100%"><input name="btn_add" style="font: medium bolder" id="btn_add" type="button" value="Add" onClick="addnewitem2();"></td>
        </tr>
        <!---
        <tr>
        <td>Tax</td>
        <td>
        <cfquery name="getTaxCode" datasource="#dts#">
        SELECT "" as code, "" as rate1
        union all
        SELECT code,rate1 FROM #target_taxtable#
        </cfquery>
        <cfselect name="taxcode" id="taxcode" bind="CFC:tax.getTaxQry('#dts#','#target_taxtable#','INV')" value="code" display="code" onChange="setTimeout('caltax()',500);" bindonload="yes"/>&nbsp;&nbsp;<cfinput type="#inputtype#" name="taxper" id="taxper" value="0" size="8" bind="CFC:tax.getTax('#dts#','#target_taxtable#',{taxcode})" onKeyUp="caltax()" bindonload="yes"  />&nbsp;&nbsp;&nbsp;
        <cfinput type="#inputtype#" name="taxamt" id="taxamt" value="0.00" size="10" onKeyUp="calcfoot();" />  
        </td>
        </tr>--->
        <tr>
            <td colspan="4" height="200">
            <div id="itemlist" style="height:238px; overflow:scroll;">
                <table width="100%">
                    <tr>
                        <th width="2%">#words[58]#</th>
                        <th width="15%">#words[120]#</th>
                        <th width="30%">#words[65]#</th>
                        <th width="10%">#words[227]#</th>
                        <th width="8%">#words[1096]#</th>
                        <th width="8%">#words[592]#</th>
                        <th width="8%">#words[1097]#</th>
                        <th width="10%">#words[10]#</th>
                    </tr>
                    <cfquery name="getictrantemp" datasource="#dts#">
                        SELECT * 
                        FROM repairdet 
                        WHERE repairno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#repairno#"> 
                        ORDER BY trancode DESC
                    </cfquery>
                    <cfloop query="getictrantemp">
                        <tr <cfif (getictrantemp.currentrow mod 2) eq 0>style="background-color:##33FFFF"</cfif> onMouseOut="javascript:this.style.backgroundColor='<cfif (getictrantemp.currentrow mod 2) eq 0>33FFFF</cfif>';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
                            <td nowrap>#getictrantemp.currentrow#</td>
                            <td nowrap>#getictrantemp.itemno#</td>
                            <td nowrap>#getictrantemp.desp#</td>
                            <td nowrap></td>
                            <td nowrap align="right">#val(getictrantemp.qty_bil)#</td>
                            <td nowrap align="right">#numberformat(val(getictrantemp.price_bil),',.__')#</td>
                            <td nowrap align="right">#numberformat(val(getictrantemp.disamt_bil),',.__')#</td>
                            <td nowrap align="right">#numberformat(val(getictrantemp.amt_bil),',.__')#</td>
                            <td nowrap><input type="button" name="deletebtn#getictrantemp.trancode#" id="deletebtn#getictrantemp.trancode#" onClick="if(confirm('Are You Sure You Want To Delete?')){deleterow('#getictrantemp.trancode#')}" value="DELETE"/>&nbsp;<img id="updatebtn#getictrantemp.trancode#" name="updatebtn#getictrantemp.trancode#" src="/images/tick.gif" width="15" height="15" style="cursor:pointer; display:none;"><!--- &nbsp;&nbsp;<input type="button" name="Updatebtn#getictrantemp.trancode#" id="updatebtn#getictrantemp.trancode#" onClick="updaterow('#getictrantemp.trancode#');" value="UPDATE" style="display:none"/> ---></td>
                        </tr>
                    </cfloop>
                    <cfquery name="getsumictrantemp" datasource="#dts#">
                        SELECT sum(qty_bil)AS sumqty 
                        FROM repairdet 
                        WHERE repairno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#repairno#"> 
                        ORDER BY trancode DESC
                    </cfquery>
                </table>
            </div>
            </td>
        </tr>
        <tr>
            <td></td>
            <td align="center"><cfinput name="subbtn" id="subbtn" type="button" value="  #button#  " onClick="repairserviceform.submit();"></td>
        </tr>
    </table>
</cfform>
</body>
</cfoutput>
</html>

<cfwindow x="10" y="10" modal="true"  width="1100" height="600" name="createSupplier" refreshOnShow="true"
        title="Add New Supplier" initshow="false"
        source="/default/maintenance/createSupplierAjax.cfm" />

<cfwindow center="true" width="700" height="500" name="searchrepairitem" refreshOnShow="true" closable="true" modal="false" title="Search Repair Item" initshow="false"
        source="searchrepairitem.cfm" />
<cfwindow center="true" width="700" height="500" name="searchitem" refreshOnShow="true" closable="true" modal="false" title="Search Item" initshow="false"
        source="searchitem.cfm" />
<cfwindow center="true" width="700" height="500" name="findCustomer" refreshOnShow="true"
        title="Find Customer or Supplier" initshow="false"
        source="findCustomer.cfm?custno={custno}" />
