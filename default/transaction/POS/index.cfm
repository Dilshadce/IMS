<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1329,702,1330,1087,1303,1331,11,482,1082,58,121,65,1332,227,1096,592,1097,10,805,1131,1333,744,1334,786,1116,1336,1337,1338,1339,1340,1335,1294,1099,1341,1342,1343,1344,1345,1346,1347">
<cfinclude template="/latest/words.cfm">
<cfajaximport tags="cfform,cftooltip">
<cfajaximport tags="cfwindow,cflayout-tab">
<cfset tran = "cs">
<cfsetting showdebugoutput="no">
<cfquery name="getgsetup" datasource="#dts#">
    SELECT filterall,ECAOTA,ECAMTOTA,negstk,PCBLTC,ddlbilltype,expressdisc,displaycostcode,ldriver,autonextdate,ddllocation,disclimit ,rem5,rem6,rem11,taxincluded,df_cs_cust,dfpos,wpitemtax 
    FROM gsetup
</cfquery>
<cfquery name="getgsetup2" datasource="#dts#">
    SELECT * 
    FROM gsetup2
</cfquery>
<cfquery name="getdealermenu" datasource="#dts#">
    SELECT * 
    FROM dealer_menu
</cfquery>

<cfquery name="getagentqry" datasource="#dts#">
            SELECT "Please select an agent" as agentdesp, "" as agent
            union all
            SELECT concat(agent,' - ',desp) as agentdesp, agent FROM #target_icagent#
            </cfquery>

<cfquery datasource="#dts#" name="getGeneralInfo">
    SELECT lastUsedNo AS tranno, refnoused AS arun,refnocode,refnocode2,presuffixuse 
    FROM refnoset
    WHERE type = 'CS' AND counter = '1'
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
	<title><cfoutput>#words[1329]#</cfoutput></title>
	<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
    <link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
    <link href="/SpryAssets/SpryCollapsiblePanel.css" rel="stylesheet" type="text/css" />
    <script type='text/javascript' src='/ajax/core/engine.js'></script>
	<script type='text/javascript' src='/ajax/core/util.js'></script>
	<script type='text/javascript' src='/ajax/core/settings.js'></script>
    <script type='text/javascript' src='/ajax/core/shortcut.js'></script>
	<script src="/SpryAssets/SpryCollapsiblePanel.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
	<script language="javascript" type="text/javascript" src="/scripts/CalendarControl.js"></script>
    <script type="text/javascript" src="/scripts/prototypenew.js" ></script>
    <script type="text/javascript">
		function PopupCenter(pageURL, title,w,h) {
		var left = (screen.width/2)-(w/2);
		var top = (screen.height/2)-(h/2);
		var targetWin = window.open (pageURL, title, 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, copyhistory=no, width='+w+', height='+h+', top='+top+', left='+left);
	} 
	
		function addpackagefunc() {
			<cfoutput>
			var tran = trim(document.getElementById('tran').value);
			var refno = trim(document.getElementById('refno').value);
			var trancode = trim(document.getElementById('nextransac').value);
			var custno = trim(document.getElementById('custno').value);
			var packagecode=document.getElementById('hidpackagecode').value;
			var location = document.getElementById('coltype').value;
			var ajaxurl2 = '/default/transaction/expresstran/addpackageprocessAjax.cfm?tran='+escape(tran)+'&tranno='+refno+'&uuid='+document.getElementById('uuid').value+'&trancode='+escape(trancode)+'&custno='+escape(custno)+'&packagecode='+escape(packagecode)+'&location='+escape(location);
		<!---ajaxFunction(document.getElementById('ajaxFieldPro2'),ajaxurl2);--->
			new Ajax.Request(ajaxurl2,{
				method:'get',
				onSuccess: function(getdetailback){
					document.getElementById('ajaxFieldPro').innerHTML = trim(getdetailback.responseText);
				},
				onFailure: function(){ 
					alert('Error Add Package');
				},		
				onComplete: function(transport){
					clearformadvance();
					setTimeout('calculatefooter();',500);
					refreshlist();
				}
			})
			</cfoutput>
		}
		function fillsearch(driverno,name,contact,add1,add2,add3) {
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
		function updaterow(rowno) {
			var varcoltype = 'coltypelist'+rowno;
			var varqtylist = 'qtylist'+rowno;
			<!---var brem4 = 'brem4'+rowno;--->
			var uuid = document.getElementById('uuid').value;
			var coltypedata = document.getElementById(varcoltype).value;
			var qtylistdata = document.getElementById(varqtylist).value;
			<!---var brem4data = document.getElementById(brem4).value;--->
			var updateurl = 'updaterow.cfm?uuid='+escape(uuid)+'&coltype='+escape(coltypedata)+'&qty='+escape(qtylistdata)+'&trancode='+rowno;
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
			var uuid = document.getElementById('uuid').value;
			var updateurl = 'deleterow.cfm?uuid='+escape(uuid)+'&trancode='+rowno;
			new Ajax.Request(updateurl, {
				method:'get',
				onSuccess: function(getdetailback){
					document.getElementById('ajaxFieldPro').innerHTML = trim(getdetailback.responseText);
				},
				onFailure: function(){ 
					alert('Error Delete Item');
				},		
				
				onComplete: function(transport){
					calculatefooter();
					refreshlist();
				}
			})
		}
		function gopay(payname) {
			setTimeout(function() {
			gopay2(payname);
			}, 250)
		}
		
		
		
		
		function gopay2(payname) {
			var itemcount = 0;
			try {
				itemcount = document.getElementById('hiditemcount').value * 1;
			}
			catch(err) {
			}
			if(itemcount != 0) {
				ColdFusion.Window.show(payname);
			}	
		}
		
		function submitpay() {
			var paytypeno = document.getElementById('paytype').value;
			var cashamt = parseFloat(document.getElementById('paycash'+paytypeno).value);
			if(document.getElementById('paycash'+paytypeno).value == "") {
				cashamt = 0;
			}
			var cc1amt = parseFloat(document.getElementById('cc1'+paytypeno).value);
			if(document.getElementById('cc1'+paytypeno).value == "") {
				cc1amt = 0;
			}
			var cc2amt = parseFloat(document.getElementById('cc2'+paytypeno).value);
			if(document.getElementById('cc2'+paytypeno).value == "") {
				cc2amt = 0;
			}
			var dbcamt = parseFloat(document.getElementById('dbc'+paytypeno).value);
			if(document.getElementById('dbc'+paytypeno).value == "") {
				dbcamt = 0;
			}
			var cheqamt = parseFloat(document.getElementById('cheq'+paytypeno).value);
			if(document.getElementById('cheq'+paytypeno).value == "") {
				cheqamt = 0;
			}
			var voucheramt = parseFloat(document.getElementById('voucheramt'+paytypeno).value);
			if(document.getElementById('voucheramt'+paytypeno).value == "") {
				voucheramt = 0;
			}
			var depositamt = parseFloat(document.getElementById('depositamt'+paytypeno).value);
			if(document.getElementById('depositamt'+paytypeno).value == "") {
				depositamt = 0;
			}
			var cashcamt = parseFloat(document.getElementById('cashc'+paytypeno).value);
			if(document.getElementById('cashc'+paytypeno).value == "") {
				cashcamt = 0;
			}
			if (paytypeno == 5) {
				document.getElementById('cctype').value=getCheckedValue(document.ccform5.cctype15);
				document.getElementById('cctype2').value=getCheckedValue(document.ccform5.cctype25);
				document.getElementById('checkno').value=document.getElementById('chequeno5').value;
			}
			if (paytypeno == 6) {
				document.getElementById('custno').value=document.getElementById('custno6').value;
				document.getElementById('tran').value="INV";
				document.getElementById('refno').value=document.getElementById('refnoinv').value;
				document.getElementById('cctype').value=getCheckedValue(document.ccform6.cctype16);
				document.getElementById('cctype2').value=getCheckedValue(document.ccform6.cctype26);
				document.getElementById('checkno').value=document.getElementById('chequeno6').value;
			}
			try {
				document.getElementById('cctype').value=getCheckedValue(document.ccform.cctype1);
			}
			catch(err) {
			}
			try {
				document.getElementById('checkno').value=document.getElementById('chequeno').value;
			}
			catch(err) {
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
			if(document.getElementById('refno').value != ""){
			document.getElementById('eulist').disabled = false;
			document.getElementById('driver').disabled = false;	
			document.invoicesheet.submit();
			}
			else{
			alert("Please Key In Reference Number")
			}
		}
		function calculatetotal(e,nextflow,upflow) {
			var paytypeno = document.getElementById('paytype').value;
			<!---if(nextflow != "")
			{
			nextflow = nextflow +paytypeno;
			}
			if(upflow != ""){
			upflow = upflow + +paytypeno;
			}--->
			var gtamt = parseFloat(document.getElementById('hidgt'+paytypeno).value);
			var cashamt = parseFloat(document.getElementById('paycash'+paytypeno).value);
			if(document.getElementById('paycash'+paytypeno).value == "") {
				cashamt = 0;
			}
			
			var TTamt = 0
			if(paytypeno==5){
			if(document.getElementById('paycash'+paytypeno).value == "") {
				TTamt = 0;
			}
			else{
				var TTamt = parseFloat(document.getElementById('tt'+paytypeno).value);
			}
			}
			var cc1amt = parseFloat(document.getElementById('cc1'+paytypeno).value);
			if(document.getElementById('cc1'+paytypeno).value == "") {
				cc1amt = 0;
			}
			var cc2amt = parseFloat(document.getElementById('cc2'+paytypeno).value);
			if(document.getElementById('cc2'+paytypeno).value == "") {
				cc2amt = 0;
			}
			var dbcamt = parseFloat(document.getElementById('dbc'+paytypeno).value);
			if(document.getElementById('dbc'+paytypeno).value == "") {
				dbcamt = 0;
			}
			var cheqamt = parseFloat(document.getElementById('cheq'+paytypeno).value);
			if(document.getElementById('cheq'+paytypeno).value == "") {
				cheqamt = 0;
			}
			var voucheramt = parseFloat(document.getElementById('voucheramt'+paytypeno).value);
			if(document.getElementById('voucheramt'+paytypeno).value == "") {
				voucheramt = 0;
			}
			var depositamt = parseFloat(document.getElementById('depositamt'+paytypeno).value);
			if(document.getElementById('depositamt'+paytypeno).value == "") {
				depositamt = 0;
			}
			var cashcamt = parseFloat(document.getElementById('cashc'+paytypeno).value);
			if(document.getElementById('cashc'+paytypeno).value == "") {
				cashcamt = 0;
			}
			
			var payamt = cashamt + cc1amt + cc2amt + dbcamt + cheqamt + voucheramt + depositamt + cashcamt + TTamt;
			if(e.keyCode==40 && nextflow != "" && paytypeno == '5') {
				document.getElementById(nextflow).focus();
				document.getElementById(nextflow).select();
			}
			else if(e.keyCode==38 && upflow != "" && paytypeno == '5'){
				document.getElementById(upflow).focus();
				document.getElementById(upflow).select();
			}
			else{
				document.getElementById('payamt'+paytypeno).value=payamt;
				
				if(voucheramt != 0 && payamt-gtamt >= 0){
					document.getElementById('change'+paytypeno).value="0.00";
				}
				else
				{
					document.getElementById('change'+paytypeno).value=(payamt-gtamt).toFixed(2);
				}
				
				
				if(gtamt <= payamt) {
					document.getElementById('balanceamt'+paytypeno).value="0.00";
				}
				else {
					
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
				SELECT driver,rem9 
				FROM ictrantemp 
				WHERE uuid='#url.uuid#'
			</cfquery>
			<cfset driver = getdriverremark.driver>
			<cfset rem9 = getdriverremark.rem9>
		</cfif>
		var opt = 'Width=500px, Height=250px, Top=300px, left=400px, scrollbars=yes, status=no, resizable=1';
		shortcut.add("Ctrl+1",function() {
			var answer = confirm('Are you sure to hold on the Order?');
			if(answer) {
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
		function cancel() {
			var answer = confirm('Are you sure to cancel the Order?');
			if(answer) {
				window.location.href="index.cfm";
			}
		}
		function ctrl1() {
			var answer = confirm('Are you sure to hold on the Order?');
			if(answer) {
				var onholdurl = '/default/transaction/POS/onholdajax.cfm?uuid='+document.getElementById("uuid").value+'&remark='+document.getElementById("rem9").value;
				ajaxFunction(document.getElementById('onholdajax'),onholdurl);
				setTimeout('window.location.href="index.cfm";',1000);
			}
		}
		function ctrl2() {
			window.open('cash.cfm?amt='+escape(document.getElementById("grand").value), '',opt);
		}
		function ctrl3() {
			window.open('creditcard.cfm?amt='+escape(document.getElementById("grand").value), '',opt);
		}
		function ctrl4() {
			window.open('multipayment.cfm?amt='+escape(document.getElementById("grand").value), '',opt);
		}
		function ctrl5() {
			window.open('net.cfm?amt='+escape(document.getElementById("grand").value), '',opt);
		}
		function ctrl7() {
			window.open('timemanchine.cfm?uuid='+escape(document.getElementById("uuid").value), '',opt);
		}
		function setunitprice() {
			setTimeout("document.getElementById('expprice').value=document.getElementById('priceforunit').value;",500)
		}
		function revertback() {
			var answer = confirm('Are you sure you want to proceed revert?')
			if(answer) {
				var newuuid = document.getElementById('oldlist').value;
				window.location.href="index.cfm?uuid="+newuuid;
			}
		}
		var t1;
		var t2;
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
		function getfocus6() {
			setTimeout("document.getElementById('disp1').focus();",1000);
		}
		function selectcopy() {
			document.getElementById('price_bil1').focus();
		}
		function nextIndex(e,thisid,id) {
			var itemno = document.getElementById('expressservicelist').value;
			if (thisid == 'expressservicelist' && itemno == '') {
				if(e.keyCode==40) {
					document.getElementById('expqty').focus();
					document.getElementById('expqty').select();
				}
				if(e.keyCode==39) {
					document.getElementById('coltype').focus();
				}
				if(e.keyCode==38) {
					document.getElementById('eulist').focus();
				}
				if(e.keyCode==13) {
					var itemcount = 0;
					try {
						itemcount = document.getElementById('hiditemcount').value * 1;
					}
					catch(err) {
					}
					if(itemcount != 0) {
						document.getElementById('paytype').value='0';
						ColdFusion.Window.show('totalup');
					}
				}
			}
			else if (thisid == 'eulist') {
				if(e.keyCode==13) {
					searchSel('driver','eulist');
					document.getElementById(''+id+'').focus();
				}
				else {
					searchSel('driver','eulist');
				}
			}
			else if (thisid == 'searchmembername') {
				if(e.keyCode==13) {
					ajaxFunction(document.getElementById('searchmemberajax'),'searchmemberajax.cfm?driverno='+escape(document.getElementById('searchmemberid').value)+'&name='+escape(document.getElementById('searchmembername').value)+'&contact='+escape(document.getElementById('searchmembertel').value)+'&address='+escape(document.getElementById('searchmemberadd').value)+'&main='+document.getElementById('checkmain').value);
				}
			}
			else {
				if(e.keyCode==13) {
					document.getElementById(''+id+'').focus();
					try {
						document.getElementById(''+id+'').select();
					}
					catch(err) {
					}
				}
			}
		}
		function selectOptionByValue(selObj, val) {
			var A= selObj.options, L= A.length; 
			while(L) { 
				if (A[--L].value== val) { 
					selObj.selectedIndex= L; 
					L= 0; 
				} 
			} 
		}
		function selectOptionByValue(selObj, val) {
			var A= selObj.options, L= A.length; 
			while(L) { 
				if (A[--L].value== val) { 
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
		function updateVal() {
			var validdesp = unescape(document.getElementById('desphid').value);
			var droplist = document.getElementById('expunit');
			while (droplist.length > 0)  {
				droplist.remove(droplist.length - 1);
			}
			if (validdesp == "itemisnoexisted") {
				document.getElementById('btn_add').value = "Item No Existed";
				document.getElementById('btn_add').disabled = true; 
				alert('Item Not Found');
			}
			else {
				var commaSeparatedValueList = document.getElementById('unithid').value;
				var valueArray = commaSeparatedValueList.split(",");
				for(var i=0; i<valueArray.length; i++) {
					var opt = document.createElement("option");
					document.getElementById("expunit").options.add(opt);  
					opt.text = valueArray[i];
					opt.value = valueArray[i];
				}
				try {
				document.getElementById('expressservicelist').value = unescape(decodeURI(document.getElementById('replaceitemno').value));
				}
				catch(err) {
				}
				document.getElementById('desp2').value = unescape(decodeURI(document.getElementById('desphid').value));
				document.getElementById('expunit').selectedIndex =0;
				document.getElementById('expprice').value = document.getElementById('pricehid').value;
				document.getElementById('costformula').value = document.getElementById('costformulaid').value;
				document.getElementById('btn_add').value = "Add";
				document.getElementById('btn_add').disabled = false; 
			}
			calamtadvance();
			if(document.getElementById('btn_add').value == "Add") {
				<cfif lcase(HcomID) neq "ssuni_i">
					addItemAdvance();
				</cfif>
			}
		}
		<cfif getgsetup.expressdisc eq "1">
			function caldisamt() {
				var expqty = trim(document.getElementById('expqty').value);
				var expprice = trim(document.getElementById('expprice').value);
				<cfif getgsetup.disclimit neq 100>
				<cfoutput>
				<cfif lcase(hcomid) eq "mika_i" or lcase(hcomid) eq "nil_i">
				if(document.getElementById('driver').value==""){
						var dislimit = #getgsetup.disclimit#*1;	
				}
				else{
					var dislimit = 0*1;
				}
				<cfelse>
					var dislimit = #getgsetup.disclimit#*1;
				</cfif>
				</cfoutput>
				
				
				<!---discountcontrol mika--->
				
				if((document.getElementById('expunitdis1').value*1)> dislimit)
				{
					var disamt1 = 0;
					document.getElementById('expunitdis1').value=0;
					alert('Discount Percent cannot be over '+dislimit+'%')
				}
				else
				{
					var disamt1 = document.getElementById('expunitdis1').value;
				}
				
				
				var disamt2 = 0;
				var disamt3 = 0;
				document.getElementById('expunitdis2').value=0;
				document.getElementById('expunitdis3').value=0;
				
				<cfelse>
				var disamt1 = document.getElementById('expunitdis1').value;
				var disamt2 = document.getElementById('expunitdis2').value;
				var disamt3 = document.getElementById('expunitdis3').value;
				</cfif>
				disamt1 = disamt1 * 0.01;
				disamt2 = disamt2 * 0.01;
				disamt3 = disamt3 * 0.01;
				var totaldiscount = ((((expqty * expprice) * disamt1)+ (((expqty * expprice)-(expqty * expprice) * disamt1))*disamt2)+(((expqty * expprice)-(((expqty * expprice)-(expqty * expprice) * disamt1))*disamt2))*disamt3);
				document.getElementById('expdis').value = totaldiscount.toFixed(2);
			
			   
			}
		<cfelse>
			function caldisamt() {
				var qtydis = document.getElementById('expqtycount').value;
				var disamt = document.getElementById('expunitdis').value;
				qtydis = qtydis * 1;
				disamt = disamt * 1;
				var totaldiscount = qtydis * disamt;
				document.getElementById('expdis').value = totaldiscount.toFixed(2);
			}
		</cfif>
		function calamtadvance() {
			var expqty = trim(document.getElementById('expqty').value);
			var expprice = trim(document.getElementById('expprice').value);
			var expdis = trim(document.getElementById('expdis').value);
			expqty = expqty * 1;
			expprice = expprice * 1;
			expdis = expdis * 1;
			var itemamt = (expqty * expprice) - expdis;
			document.getElementById('expressamt').value =  itemamt.toFixed(3);
		}
		function trim(strval) {
			return strval.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
		}
		function addItemAdvance() {
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
			var location = trim(document.getElementById('location').value);
			var ajaxurl = '/default/transaction/POS/addproductsAjax.cfm?servicecode='+escape(expressservice)+'&desp='+escape(desp)+'&expressamt='+escape(expressamt)+'&expqty='+escape(expqty)+'&expprice='+escape(expprice)+'&unit='+escape(expunit)+'&dispec1='+escape(expunitdis1)+'&dispec2='+escape(expunitdis2)+'&dispec3='+escape(expunitdis3)+'&dis='+escape(expdis)+'&tran='+escape(tran)+'&tranno='+refno+'&uuid=#URLEncodedFormat(uuid)#&custno='+escape(custno)+'&isservi='+escape(isservi)+'&trancode='+escape(trancode)+'&glacc='+escape(glacc)+'&brem1='+escape(brem1)+'&driver='+escape(driver)+'&rem9='+escape(rem9)+'&location='+escape(location);
			new Ajax.Request(ajaxurl, {
				method:'get',
				onSuccess: function(getdetailback){
					document.getElementById('ajaxFieldPro').innerHTML = trim(getdetailback.responseText);
				},
				onFailure: function(){ 
					alert('Error Add Item');
				},		
				
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
		function clearformadvance() {
			calcPromotion();
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
		function refreshlist() {
			ajaxFunction(document.getElementById('itemlist'),'getBody.cfm?uuid='+document.getElementById('uuid').value);
			ajaxFunction(document.getElementById('getqtytotal'),'getqtytotal.cfm?uuid='+document.getElementById('uuid').value);
		}
		function getitemdetail(detailitemno) {
			if(detailitemno.indexOf('*') != -1) {
				var thisitemno = detailitemno.split('*');
				document.getElementById('expressservicelist').value=thisitemno[1];
				document.getElementById('expqty').value=thisitemno[0];
				detailitemno=thisitemno[1];
			}
			if(trim(document.getElementById('expressservicelist').value) != "") {
				var urlloaditemdetail = '/default/transaction/POS/addItemAjax.cfm?itemno='+escape(encodeURI(detailitemno))+'&reftype='+document.getElementById('tran').value+'&member='+document.getElementById('driver').value;
				new Ajax.Request(urlloaditemdetail, {
					method:'get',
					onSuccess: function(getdetailback){
						document.getElementById('itemDetail').innerHTML = trim(getdetailback.responseText);
					},
					onFailure: function(){ 
						alert('Item Not Found');
					},		
					onComplete: function(transport){
					
					<cfif getgsetup.negstk eq "1">
					updateVal();
					<cfelse>
					getlocationbal(detailitemno);
					 </cfif>
					
					}
				})
			}
		}
		function getlocationbal(itemnobal) {

			var urlloaditembal = '/default/transaction/POS/balonhand.cfm?itemno='+encodeURI(itemnobal)+'&location='+escape(document.getElementById('location').value);

			new Ajax.Request(urlloaditembal, {
				method:'get',
				onSuccess: function(getbalback){
					document.getElementById('itembal').innerHTML = trim(getbalback.responseText);
					var trantype = document.getElementById('tran').value;
					var balstk = document.getElementById('balonhand').value * 1;
					var qtyneeded = document.getElementById('expqty').value * 1;
					var balance = balstk - qtyneeded;
					if (balance < 0 && trantype != "RC" && trantype != "CN" && trantype != "PO") {
						alert('Item Balance qty Is Lower Than 0!')
								//ColdFusion.Window.show('negativestock');
								//setTimeout("document.getElementById('passwordString').focus();",500);
						}
						else {
								updateVal();
						}
					
					
				},
				onFailure: function(){ 
					alert('Item Not Found');
				}
			})

		}
		function recalculateall() {
			<cfoutput>
			var urlload = '/default/transaction/POS/recalculateAjax.cfm?uuid=#URLEncodedFormat(uuid)#';
			</cfoutput>
			new Ajax.Request(urlload, {
				method:'get',
				onSuccess: function(flyback){
					document.getElementById('ajaxFieldPro').innerHTML = trim(flyback.responseText);
					calculatefooter2();
				},
				onFailure: function(){ 
					alert('Item Not Found');
				},		
				onComplete: function(transport){
					if(document.getElementById('refno').value != ""){
					document.getElementById('eulist').disabled = false;
					document.getElementById('driver').disabled = false;	
					invoicesheet.submit();
					}
					else{
					alert("Please Key In Reference Number")
					}
				}
			});
		}
		function validformfield() {
			var formvar = document.getElementById('invoicesheet');
			var answer = _CF_checkinvoicesheet(formvar);
			if (answer) {
				recalculateall();
			}
			else {
			}
		}
		function calculatefooter() {
			document.getElementById('gross').value = document.getElementById('hidsubtotal').value;
			if(document.getElementById('dispec1').value==0 && document.getElementById('dispec2').value==0 && document.getElementById('dispec3').value==0 && document.getElementById('updatefooterdiscount').value==1)
			{
			document.getElementById('disamt_bil').value = document.getElementById('hidfooterdiscount').value;
			}
			<cfif getgsetup.wpitemtax eq "1">
			
			document.getElementById('taxamt').value = document.getElementById('hidtaxtotal').value;
			
			</cfif>
			
			
			var hiditemcount = document.getElementById('hiditemcount').value * 1;
			if (hiditemcount == 0) {
				document.getElementById('Submit').disabled = true;
				document.getElementById('eulist').disabled = false;
				document.getElementById('driver').disabled = false;
			}
			else {
				document.getElementById('nextransac').options.length = 0;
				var droplistmenu = document.getElementById('nextransac');
				for (var i=hiditemcount+1; i > 0;--i){
					addOption(droplistmenu, i, i);
				}
				document.getElementById('Submit').disabled = false;
				document.getElementById('eulist').disabled = true;
				document.getElementById('driver').disabled = true;
			}
			calcdisc();
			caltax();
			calcfoot();
		}
		function calculatefooter2() {
			document.getElementById('gross').value = document.getElementById('hidsubtotal').value;
			<cfif getgsetup.wpitemtax eq "1">
			document.getElementById('taxamt').value = document.getElementById('hidtaxtotal').value;
			</cfif>
			var hiditemcount = document.getElementById('hiditemcount').value * 1;
			if (hiditemcount == 0) {
				document.getElementById('Submit').disabled = true;
			}
			else {
				document.getElementById('nextransac').options.length = 0;
				var droplistmenu = document.getElementById('nextransac');
				for (var i=hiditemcount+1; i > 0;--i) {
					addOption(droplistmenu, i, i);
				}
				document.getElementById('Submit').disabled = false;
			}
			if(document.getElementById('dispec1').value * 1 == 0 && document.getElementById('dispec2').value * 1 == 0 && document.getElementById('dispec2').value * 3 == 0) {
				calcdisc2();
			}
			else {
				calcdisc();
			}
			caltax();
			calcfoot();
		}
		function addOption(selectbox,text,value ) {
			var optn = document.createElement("OPTION");
			optn.text = text;
			optn.value = value;
			selectbox.options.add(optn);
		}
		function calcfoot() {
			var gross = document.getElementById('gross').value * 1;
			var disamt = document.getElementById('disamt_bil').value * 1;
			var taxincl = document.getElementById('taxincl').checked;
			var net = document.getElementById('net');
			var taxamt = document.getElementById('taxamt').value * 1;
			var grand = document.getElementById('grand');
			<cfoutput>
				net.value = (gross-disamt).toFixed(2);
			</cfoutput>
			
			
			<cfif getgsetup.wpitemtax eq "1">
			<!---Per Item Tax--->
			<cfif getgsetup.taxincluded eq "Y">
			var netb = ((net.value * 1));
			grand.value = netb.toFixed(2);
			<cfelse>
			var netb = ((net.value * 1) + (taxamt * 1));
			grand.value = netb.toFixed(2);
			</cfif>
			
			<cfelse>
			if(taxincl == true) {
				grand.value = net.value;
			}
			else {
				var netb = ((net.value * 1) + (taxamt * 1));
				<cfoutput>
				<cfif getgsetup.dfpos eq "0.05">
					grand.value = (((netb*2).toFixed(1))/2).toFixed(2);
				<cfelse>
					grand.value = netb.toFixed(2);
				</cfif>
				</cfoutput>
			}
			</cfif>
		}
		
		
		
		
		function calcdisc() {
			var gross = document.getElementById('gross').value * 1;
			
			<cfif getgsetup.disclimit neq 100>
			<cfoutput>
				<cfif lcase(hcomid) eq "mika_i" or lcase(hcomid) eq "nil_i">
				if(document.getElementById('driver').value==""){
					var dislimit = #getgsetup.disclimit#*1;
				}
				else{
					var dislimit = 0*1;
				}
				<cfelse>
					var dislimit = #getgsetup.disclimit#*1;
				</cfif>
			</cfoutput>
			
			
			if((document.getElementById('dispec1').value*1)> dislimit)
			{
				var dispec1 = 0;
				document.getElementById('dispec1').value=0;
				alert('Discount Percent cannot be over '+dislimit+'%')
			}
			else
			{
				var dispec1 = document.getElementById('dispec1').value;
			}
			var dispec2 = 0;
			var dispec3 = 0;
			document.getElementById('dispec2').value=0;
			document.getElementById('dispec3').value=0;
			<cfelse>
			var dispec1 = document.getElementById('dispec1').value * 1;
			var dispec2 = document.getElementById('dispec2').value * 1;
			var dispec3 = document.getElementById('dispec3').value * 1;
			</cfif>
			
			var disamt = document.getElementById('disamt_bil');
			var net = document.getElementById('net');
			var disval = 0;
			
			
			
			try{
				var el=window.event.target.id || window.event.srcElement.id;
			}
			catch(err)
			{
				var el=""
			}
			
			if((dispec1+dispec2+dispec3) != 0 || el=="dispec1" || el=="dispec2" || el=="dispec3"){
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
			else{
				document.getElementById('disbil1').value=0;
				document.getElementById('disbil2').value=0;
				document.getElementById('disbil3').value=0;
				net.value = (gross-(disamt.value*1)).toFixed(2);

			}
		}
		function calcdisc2() {
			var gross = document.getElementById('gross').value * 1;
			<cfif getgsetup.disclimit neq 100>
			
			<cfoutput>
				<cfif lcase(hcomid) eq "mika_i" or lcase(hcomid) eq "nil_i">
				if(document.getElementById('driver').value==""){
					var dislimit = #getgsetup.disclimit#*1;
				}
				else{
					var dislimit = 0*1;
				}
				<cfelse>
					var dislimit = #getgsetup.disclimit#*1;
				</cfif>
			</cfoutput>
			
			if((document.getElementById('dispec1').value*1)> dislimit)
			{
				var dispec1 = 0;
				document.getElementById('dispec1').value=0;
				alert('Discount Percent cannot be over '+dislimit+'%')
			}
			else
			{
				var dispec1 = document.getElementById('dispec1').value;
			}
			var dispec2 = 0;
			var dispec3 = 0;
			document.getElementById('dispec2').value=0;
			document.getElementById('dispec3').value=0;
			<cfelse>
			var dispec1 = document.getElementById('dispec1').value * 1;
			var dispec2 = document.getElementById('dispec2').value * 1;
			var dispec3 = document.getElementById('dispec3').value * 1;
			</cfif>
			var disamt = document.getElementById('disamt_bil');
			var net = document.getElementById('net');
			var disval = 0;
			disval = disamt;
			net.value = disval.toFixed(2);
			disamtlas = gross - disval;
			disamt.value = disamtlas.toFixed(2);
		}
		function caltax() {
			var net = document.getElementById('net').value;
			var taxincl = document.getElementById('taxincl').checked;
			var taxper = document.getElementById('taxper').value;
			var taxamt = document.getElementById('taxamt');
			var grand = document.getElementById('grand');
			var taxval = 0;
			taxper = parseFloat(taxper);
			net = parseFloat(net);
			<cfif getgsetup.wpitemtax neq "1">
			if (taxincl == true) {
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
			else {
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
			</cfif>
		}
		<cfoutput>
		function recalculateamt() {
			var ajaxurl = '/default/transaction/POS/recalculateAjax.cfm?uuid=#URLEncodedFormat(uuid)#';
			new Ajax.Request(ajaxurl, {
				method:'get',
				onSuccess: function(getdetailback){
					document.getElementById('ajaxFieldPro').innerHTML = trim(getdetailback.responseText);
				},
				onFailure: function(){ 
					alert('Error Update Item');
				},		
				onComplete: function(transport){
					calculatefooter();
				}
			})
		}
		function expand() {
			var psnow = document.getElementById('pagesize').value * 1;
			if (psnow == 7) {
				document.getElementById('pagesize').value = 20;
			}
			else {
				document.getElementById('pagesize').value = 7;
			}
			setTimeout('refreshlist();',750);
		}
		function addnewitem2() {
			if(document.getElementById('expressamt').value=='NaN') {
				alert('Error in Qty / Price / Discount / Amt');
				return false;
			}
			calamtadvance();
			if(document.invoicesheet.glacc.value == '' || document.invoicesheet.glacc.value.length == 8) {
				<cfif getgsetup.PCBLTC eq "Y">
					try {
						var stkcost = document.getElementById('stkcost').value * 1;
						var stkprice = document.getElementById('expprice').value * 1;
						if (stkprice < stkcost) {
							ColdFusion.Window.show('stkcostcontrol');
							setTimeout("document.getElementById('passwordString').focus();",500);
						}
						else {
							addItemControl();
						}
					}
					catch(e) {
						addItemControl();
					}
				<cfelse>
					addItemControl();
				</cfif>
			}
			else {
				alert('Check GL account no');
			}
		}
		function addItemControl() {
			
			var itemno = document.getElementById('expressservicelist').value;
			var isservi = document.getElementById('isservi').value;
			var qtyser = document.getElementById('expqty').value;
			if (itemno == "") {
				alert("Please select item");
			}
			else if (isservi == "1" && (qtyser == "" || qtyser == 0)) {
				<cfif getgsetup.ECAMTOTA eq "Y">
					ColdFusion.Window.show('serviceamount');
					setTimeout("document.getElementById('serviceamount').focus();",500);
				<cfelse>
					addItemAdvance();
				</cfif>
			}
			else {
				<cfif getgsetup.negstk eq "1">
					addItemAdvance();
				<cfelse>
				
					try {
						var trantype = document.getElementById('tran').value;
						var balstk = document.getElementById('balonhand').value * 1;
						var qtyneeded = document.getElementById('expqty').value * 1;
						var balance = balstk - qtyneeded;
						if (balance < 0 && trantype != "RC" && trantype != "CN" && trantype != "PO") {
							ColdFusion.Window.show('negativestock');
							setTimeout("document.getElementById('passwordString').focus();",500);
						}
						else {
							addItemAdvance();
						}
					}
					catch(e) {
						addItemAdvance();
					}
				</cfif>
			}
		}
		</cfoutput>
		function selectlist(varval,varattb) {		
			for (var idx=0;idx<document.getElementById(varattb).options.length;idx++)  {
				if (varval==document.getElementById(varattb).options[idx].value) {
					document.getElementById(varattb).options[idx].selected=true;
				}
			}
		}
		function getmember() {
			if (document.getElementById('memberdetail').checked) {
				var memberurl = '/default/transaction/POS/memberdetailajax.cfm?detail=1&member='+document.getElementById("driver").value;
				ajaxFunction(document.getElementById('getmemberajax'),memberurl);
			}
			else {
				var memberurl = '/default/transaction/POS/memberdetailajax.cfm?detail=0&member='+document.getElementById("driver").value;
				ajaxFunction(document.getElementById('getmemberajax'),memberurl);
			}
		}
		
		function getDiscount()
	{
	var subtotal=document.getElementById("amtfordiscount").value;
	<cfif getgsetup.disclimit neq 100>
	
	<cfoutput>
				<cfif lcase(hcomid) eq "mika_i" or lcase(hcomid) eq "nil_i">
				if(document.getElementById('driver').value==""){
					if(document.getElementById('getpassdiscount').value != ""){
						document.getElementById('disp1').value=document.getElementById('getpassdiscount').value*1;
						var dislimit = document.getElementById('getpassdiscount').value*1;
					}
					else{
					    var dislimit = #getgsetup.disclimit#*1;
					}
				}
				else{
					var dislimit = 0*1;
				}
				<cfelse>
					var dislimit = #getgsetup.disclimit#*1;
				</cfif>
	</cfoutput>
	
	<cfif lcase(hcomid) eq "nil_i"  or lcase(hcomid) eq "mika_i">
	if((document.getElementById('disp1').value*1)> dislimit)
	{
		document.getElementById('mikauserdiscount').value=document.getElementById('disp1').value
		
		if(document.getElementById('driver').value==""){
		ColdFusion.Window.show('mikadiscountpassword');
		setTimeout("document.getElementById('passwordString').focus();",300);
		var d1 = 0;
		document.getElementById('disp1').value=0;
		
		}
		else{
		var d1 = 0;
		document.getElementById('disp1').value=0;
		alert('Discount Percent cannot be over '+dislimit+'%');
		}
	}
	else
	{
		var d1 = document.getElementById('disp1').value;
	}
	
	<cfelse>
	
	
	if((document.getElementById('disp1').value*1)> dislimit)
	{
		var d1 = 0;
		document.getElementById('disp1').value=0;
		alert('Discount Percent cannot be over '+dislimit+'%')
	}
	else
	{
		var d1 = document.getElementById('disp1').value;
	}
	</cfif>
	var d2 = 0;
	var d3 = 0;
	document.getElementById('disp2').value=0;
	document.getElementById('disp3').value=0;

	<cfelse>
	var d1=document.getElementById("disp1").value
	var d2=document.getElementById("disp2").value
	var d3=document.getElementById("disp3").value
	</cfif>
	var ttld=document.getElementById("disamt_bil1").value
	var totaldiscount=0;
	var temp=0;
	document.getElementById('getpassdiscount').value = "";
	
	if((parseFloat(d1)+parseFloat(d2)+parseFloat(d3))!=0)
	{
		
		temp=(subtotal*d1/100).toFixed(2);
		totaldiscount=temp;
		temp=(subtotal-totaldiscount).toFixed(2);
		temp=(temp*d2/100).toFixed(2);
		totaldiscount=(parseFloat(totaldiscount)+parseFloat(temp)).toFixed(2);
		temp=(subtotal-totaldiscount).toFixed(2);
		temp=(temp*d3/100).toFixed(2);
		totaldiscount=(parseFloat(totaldiscount)+parseFloat(temp)).toFixed(2);
		
	}
	else
	{

		totaldiscount=0;
	}
	document.getElementById("disamt_bil1").value=totaldiscount;
	}
		
	<cfoutput>
	function tradeinaddItemAdvance()
	{
	var expressservice=escape(trim(document.getElementById('tradeinitemno').value));
	var desp = escape(trim(document.getElementById('tradeindesp').value));
	var expdespa = escape(trim(document.getElementById('tradeindespa').value));
	var expressamt = trim(document.getElementById('tradeinamt').value);
	var expqty = trim(document.getElementById('tradeinqty').value);
	var expprice = trim(document.getElementById('tradeinprice').value);
	var expcomment = escape(trim(document.getElementById('tradeincomment').value));
	var expunit = trim(document.getElementById('tradeinunit').value);
	var expdis = trim(document.getElementById('tradeindis').value);
	var explocation = escape(trim(document.getElementById('location').value))
	
	var ajaxurl = '/default/transaction/POS/addtradeinajax.cfm?servicecode='+expressservice+'&desp='+desp+'&expressamt='+expressamt+'&expqty='+expqty+'&expprice='+expprice+'&comment='+expcomment+'&despa='+expdespa+'&unit='+expunit+'&dis='+expdis+'&location='+explocation+'&uuid=#uuid#&action=create';
	ajaxFunction(document.getElementById('tradeinAjaxField'),ajaxurl);
	tradeinclearformadvance();
	setTimeout('updatetradeintotal();',1000);
	}
	
	function tradeindeleterow(rowno){
			
			var ajaxurl = '/default/transaction/POS/addtradeinajax.cfm?uuid=#uuid#&action=delete'+'&trancode='+rowno;
			ajaxFunction(document.getElementById('tradeinAjaxField'),ajaxurl);
			setTimeout('updatetradeintotal();',1000);
			
	}
	
	function updatetradeintotal(){
		document.getElementById('telegraph_transfer').value=document.getElementById('hidtradein').value;
	}
	
	</cfoutput>
	
	
	function tradeinclearformadvance()
	{
	document.getElementById('tradeinitemno').value = '';
	document.getElementById('tradeindesp').value = '';
	document.getElementById('tradeinamt').value = '0.00';
	document.getElementById('tradeinqty').value = '1';
	document.getElementById('tradeinqtycount').value = '1';
	document.getElementById('tradeinprice').value = '0.00';
	document.getElementById('tradeinunit').value = '';
	document.getElementById('tradeindis').value = '0.00';
	document.getElementById('tradeinunitdis').value = '0.00';
	document.getElementById('tradeincomment').value = '';
	document.getElementById('tradeinitemno').focus();
	}
	
	
	function tradeinupdateVal()
	{
	var validdesp = document.getElementById('tradeindesphid').value;
	
	var droplist = document.getElementById('tradeinunit');
	
	  while (droplist.length > 0)
	  {
		  droplist.remove(droplist.length - 1);
	  }

	
	if (validdesp == "itemisnoexisted")
	{
	document.getElementById('tradeinbtn_add').value = "Item No Existed";
	document.getElementById('tradeinbtn_add').disabled = true; 
	}
	else
	{
	var commaSeparatedValueList = document.getElementById('tradeinunithid').value;
	var valueArray = commaSeparatedValueList.split(",");
	for(var i=0; i<valueArray.length; i++){
		var opt = document.createElement("option");
        document.getElementById("tradeinunit").options.add(opt);  
        opt.text = valueArray[i];
        opt.value = valueArray[i];

	}
	document.getElementById('tradeindesp').value = document.getElementById('tradeindesphid').value;
	document.getElementById('tradeinunit').selectedIndex =0;
	document.getElementById('tradeinprice').value = document.getElementById('tradeinpricehid').value;
	document.getElementById('tradeindespa').value = document.getElementById('tradeindespahid').value;
	document.getElementById('tradeincomment').value = document.getElementById('tradeincommenthid').value;
	document.getElementById('tradeinbtn_add').value = "Add";
	document.getElementById('tradeinbtn_add').disabled = false; 
	}
	}
	
	
	function tradeincalamtadvance()
	{
	var expqty = trim(document.getElementById('tradeinqty').value);
	var expprice = trim(document.getElementById('tradeinprice').value);
	var expdis = trim(document.getElementById('tradeindis').value);
	expqty = expqty * 1;
	expprice = expprice * 1;
	expdis = expdis * 1;
	var itemamt = (expqty * expprice) - expdis;
	document.getElementById('tradeinamt').value =  itemamt.toFixed(2);
	}
	
	function updatebodydisclistcontrol()
	{
		<cfif getgsetup.disclimit neq 100>
		<cfoutput>
		if(document.getElementById('driver').value==""){
			if(document.getElementById('getpassdiscount').value != ""){
				var dislimit = document.getElementById('getpassdiscount').value;
			}
			else{
			    var dislimit = #getgsetup.disclimit#*1;
			}
		}
		else{
			var dislimit = 0*1;
		}
		var discountlist = document.getElementById('discountbody').value.replace('%','')*1
		
		
		</cfoutput>
		
		
		if(discountlist > dislimit)
		{
			if(document.getElementById('driver').value==""){
				document.getElementById('mikauserdiscount').value=discountlist;
				ColdFusion.Window.show('mikadiscountpassword2');
			}
			else{
			alert('Discount Percent cannot be over '+dislimit+'%')
			}
		}
		else
		{
			updatebodydisclist();
			document.getElementById('getpassdiscount').value=""
		}
		<cfelse>
			updatebodydisclist();
		</cfif>
	}
		
	function updatebodydisclist()
	{
		
		var uuid = document.getElementById('uuid').value;
		var brem4data = document.getElementById('discountbody').value;
		var updateurl = 'updatediscountajax.cfm?uuid='+escape(uuid)+'&brem4='+escape(brem4data);
		
		new Ajax.Request(updateurl,
      {
        method:'get',
        onSuccess: function(getdetailback){
		document.getElementById('updatebodydiscajax').innerHTML = trim(getdetailback.responseText);
        },
        onFailure: function(){ 
		alert('Error Update Discount'); },		
		
		onComplete: function(transport){
		refreshlist();
		calculatefooter3();
        }
      })
	  
	}
	
	function calculatefooter3()
	{
	document.getElementById('gross').value = document.getElementById('hidsubtotal2').value;
	<cfif getgsetup.wpitemtax eq "1">
	document.getElementById('taxamt').value = document.getElementById('hidtaxtotal2').value;
	</cfif>
	var hiditemcount = document.getElementById('hiditemcount2').value * 1;
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
	
	function calcPromotion(){
		var uuid = document.getElementById('uuid').value;
		var updateurl = 'calculatePromotion.cfm?uuid='+escape(uuid);
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
	
	function calcDiscLimit(){
		var itemAmt = document.getElementById("itemAmt").value;
		var discAmt = document.getElementById("disamt_bil1").value;
		var discPerc=0;
		var discAmtLimit = 0;
		
		<cfif getgsetup.expressdisc eq "1">
			<cfif getgsetup.disclimit neq 100>
				<cfoutput>
					<cfif lcase(hcomid) eq "mika_i" or lcase(hcomid) eq "nil_i">
						if(document.getElementById('driver').value==""){
							var dislimit = #getgsetup.disclimit#*1;	
						}
						else{
							var dislimit = 0*1;
						}	
					<cfelse>
						var dislimit = #getgsetup.disclimit#*1;
					</cfif>
				</cfoutput>
			<cfelse>
				var dislimit = 0*1;
			</cfif>
		<cfelse>
			var dislimit = 0*1;
		</cfif>
			
		if(isNaN(discAmt)){
			alert("The value is not a number. Please try again");
			document.getElementById("disamt_bil1").value = "0";
		}
		else{
			discPerc = discAmt/itemAmt*100;
			discAmtLimit = itemAmt * dislimit / 100;
			discAmtLimit = discAmtLimit.toFixed(2);
			
			if(discAmt>discAmtLimit){
				document.getElementById('mikauserdiscount').value=discPerc;
				
				if(document.getElementById('driver').value==""){
					ColdFusion.Window.show('mikadiscountpassword');
					setTimeout("document.getElementById('passwordString').focus();",300);
					var d1 = 0;
					document.getElementById('disp1').value=0;
					document.getElementById("disamt_bil1").value = "0";
				}
				else{
					var d1 = 0;
					document.getElementById('disp1').value=0;
					document.getElementById("disamt_bil1").value = "0";
					alert('Discount Percent cannot be over '+dislimit+'%');
				}		
			}
		}	
	}	
    </script>
</head>

<cfoutput>
<body onLoad="document.getElementById('expressservicelist').focus();">
    <cfform name="invoicesheet" id="invoicesheet" action="process.cfm" method="post">
        <input type="hidden" name="checkmain" id="checkmain" value="">
        <input type="hidden" name="hidtrancode" id="hidtrancode" value="">
        <input type="hidden" name="getpassdiscount" id="getpassdiscount" value="">
        <input type="hidden" name="mikauserdiscount" id="mikauserdiscount" value="">
        <cfinput type="hidden" name="ptype" id="ptype" bind="cfc:custsupp.getname({tran},'#target_arcust#','#target_apvend#')" bindonload="yes" >
        <input type="hidden" name="uuid" id="uuid" value="#uuid#">
        <table width="100%">
            <tr>
                <th width="20%">#words[702]#</th>
				<cfset datenow=now()>
                <cfif getGsetup.autonextdate lte timeformat(now(),'HH')>
					<cfset datenow=dateadd('d',1,now())>
                <cfelse>
					<cfset datenow=now()>
                </cfif>
                <td width="30%">
                <input type="text" name="wos_date" id="wos_date" value="#dateformat(datenow,'DD/MM/YYYY')#" onKeyUp="nextIndex(event,'wos_date','expressservicelist');" readonly />
				<!--- <img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('wos_date'));">&nbsp;(DD/MM/YYYY) --->
                </td>
                <th style="font-size:20px; color:##000" rowspan="2">
                <div align="right">
                	#words[1330]# :
                </div>
                </th>
                <td width="30%" rowspan="2">
                <div id="onholdajax"></div>
                <cfinput type="text" style="font: xx-large bolder; color:##000; background-color:##FFFF66" name="grand" id="grand" value="0.00" readonly="yes" />
                </td>
            </tr>
            <tr>
                <th width="20%">#words[1087]#</th>
                <td width="30%">
                <cfinput type="hidden" name="tran" id="tran" value="CS">
				<cfif getgsetup.df_cs_cust eq ''>
                    <cfinput type="hidden" name="custno" id="custno" value="3000/CS1">
                <cfelse>
                    <cfinput type="hidden" name="custno" id="custno" value="#getgsetup.df_cs_cust#">
                </cfif>
                <cfinput type="text" name="refno" id="refno" bind="cfc:refnobill.getrefno({tran},'#dts#',{refnoset},'#huserloc#')" bindonload="yes" required="yes" onKeyUp="nextIndex(event,'refno','wos_date');" readonly>

<cfselect name="refnoset" id="refnoset" bind="cfc:refnobill.getrefnoset({tran},'#dts#','#huserloc#')" bindonload="yes" display="lastno" value="counter" />
                </td>
            </tr>
            <tr>
                <th>#words[1303]#</th>
                <td>
                <input type="text" <cfif lcase(hcomid) eq "mika_i">style="display:none"</cfif> name="eulist" id="eulist" value="#driver#" onKeyUp="nextIndex(event,'eulist','expressservicelist');getmember();" onBlur="nextIndex(event,'eulist','expressservicelist');getmember();">&nbsp;&nbsp;
                <cfquery name="getdriverdef" datasource="#dts#">
                    SELECT ldriver 
                    FROM gsetup
                </cfquery>
                <cfquery name="geteuqry" datasource="#dts#">
                    SELECT "Choose an #getdriverdef.ldriver#" AS eudesp, "" AS DRIVERNO
                    UNION ALL 
                    SELECT concat(driverno,' - ',name) AS eudesp, driverno 
                    FROM driver
                </cfquery>
                <cfif lcase(hcomid) eq "mika_i">
                <cfinput  type="text" name="driver" id="driver" value="" readonly onChange="getmember();" />
                <cfelse>
                <cfselect name="driver" id="driver" query="geteuqry" display="eudesp" value="driverno" onChange="getmember();" />
                </cfif>
                <input type="checkbox" id="memberdetail" name="memberdetail" value="" onClick="getmember();">
                &nbsp;&nbsp;
                <a style="cursor:pointer" onClick="ColdFusion.Window.show('neweu')">#words[1331]#</a>
                <input type="hidden" name="driverhid" id="driverhid">
                <a style="cursor:pointer" onClick="document.getElementById('checkmain').value='out';ColdFusion.Window.show('searchmember')">#words[11]#</a>
                <input type="hidden" name="driverhid" id="driverhid">
                </td>
                <th>#words[482]#</th>
                <td>
                <cfquery datasource="#dts#" name="getlocation">
                    SELECT location,desp 
                    FROM iclocation 
                    WHERE 0=0 AND (noactivelocation='' OR noactivelocation IS NULL)
					<cfif Huserloc neq "All_loc">
                        AND location='#Huserloc#'
                    </cfif>
                    ORDER BY location;
                </cfquery>
                <select name="location" id="location">
					<cfif Huserloc eq "All_loc">
                        <option value="">#words[1082]#</option>
                    </cfif>
                    <cfloop query="getlocation">
                        <option value="#getlocation.location#" <cfif dts EQ "umwstaffshop_i" AND getlocation.location EQ "Staffshop">selected</cfif>>#getlocation.location# - #getlocation.desp#</option>
                    </cfloop>
                </select>
                <cfquery name="getnewtrancode" datasource="#dts#">
                    SELECT max(trancode) AS newtrancode
                    FROM ictrantemp
                    WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
                </cfquery>
                <cfif getnewtrancode.recordcount eq 0>
					<cfset newtrancode=1>
                <cfelse>
					<cfset newtrancode = val(getnewtrancode.newtrancode)+1>
                </cfif>
                <cfquery name="newtranqy" datasource="#dts#">
                    SELECT #newtrancode# AS trancode
                    UNION
                    SELECT trancode 
                    FROM ictrantemp 
                    WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#"> 
                    ORDER BY trancode DESC
                </cfquery>
                <cfselect style="display:none" name="nextransac" id="nextransac" query="newtranqy" display="trancode" value="trancode" />
                <input type="checkbox" style="display:none" name="activatebarcode" id="activatebarcode" value="Y" />
                <input type="hidden" name="pagesize" id="pagesize" value="7" />
                <cfinput type="hidden" name="glacc" id="glacc" maxlength="10" size="10" mask="9999/999" />
                <input type="hidden" name="costformula" id="costformula" value="" readonly>
                <div id="ajaxFieldPro" name="ajaxFieldPro" ></div>
                <cfinput type="hidden" name="currcode" id="currcode" size="10"  />
                <input type="hidden" name="currcodehid" id="currcodehid" value="">&nbsp;
                <cfinput type="hidden" name="currrate" id="currrate" bind="cfc:custsupp.getcurrrate('#dts#',{currcode},'#target_currency#')" bindonload="yes" size="5" />
                <div id="getmemberajax">
                    <input type="hidden" name="membername" id="membername" value="">
                    <input type="hidden" name="membertel" id="membertel" value="">
                    <input type="hidden" name="memberadd1" id="memberadd1" value="">
                    <input type="hidden" name="memberadd2" id="memberadd2" value="">
                    <input type="hidden" name="memberadd3" id="memberadd3" value="">
                </div>
                </td>
            </tr>
            <tr>
            <th></th>
            <td><cfif lcase(hcomid) eq "amgworld_i" or lcase(hcomid) eq "netilung_i"><input type="button" name="tradeinbtn" id="tradeinbtn" value="Trade In" onClick="ColdFusion.Window.show('addtradein');"></cfif></td>
            <th>Agent</th>
            <td>
            <cfselect name="agent" id="agent" query="getagentqry" style="font: large bolder; color:##000" display="agentdesp" value="agent" />
            </td>
            </tr>
            <tr>
                <td colspan="4"><hr /></td>
            </tr>
            <tr>
                <td colspan="4" height="200">
                <cfset datashow = "yes">
                <cfif getpin2.h1360 neq 'T'>
					<cfset datashow = "no">
                </cfif>
                <div id="itemlist" style="height:238px; overflow:scroll;">
                    <table width="100%">
                        <tr>
                            <th width="2%" nowrap>#words[58]#</th>
                            <th width="15%"><div align="left">#words[121]#</div></th>
                            <th width="30%"><div align="left">#words[65]#</div></th>
                            <th width="10%"><div align="left">#words[1332]#</div></th>
                            <th width="10%">#words[227]#</th>
                            <th width="8%">#words[1096]#</th>
                            <th width="8%">#words[592]#</th>
                            <th width="8%">#words[1097]#</th>
                            <th width="10%">#words[10]#</th>
                        </tr>
                        <cfquery name="getictrantemp" datasource="#dts#">
                            SELECT * 
                            FROM ictrantemp 
                            WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#"> 
                            ORDER BY trancode DESC
                        </cfquery>
                        <cfloop query="getictrantemp">
                            <tr <cfif (getictrantemp.currentrow mod 2) eq 0>style="background-color:##33FFFF"</cfif> onMouseOut="javascript:this.style.backgroundColor='<cfif (getictrantemp.currentrow mod 2) eq 0>33FFFF</cfif>';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
                                <td nowrap>#getictrantemp.currentrow#</td>
                                <cfquery name="getaitemnoictran" datasource="#dts#">
                                    SELECT aitemno 
                                    FROM icitem 
                                    WHERE itemno='#getictrantemp.itemno#'
                                </cfquery>
                                <td nowrap>#getictrantemp.itemno#<cfif wserialno eq "T">&nbsp;&nbsp;<input type="button" name="addserial" id="addserial" value="S" onClick="PopupCenter('serial.cfm?tran=#type#&nexttranno=#refno#&itemno=#URLEncodedFormat(itemno)#&itemcount=#trancode#&uuid=#uuid#&qty=#qty#&custno=#custno#&price=#price#&location=#URLEncodedFormat(location)#','Add Serial','400','400');"></cfif></td>
                                <td nowrap>#getictrantemp.desp#</td>
                                <td nowrap>
                                <!--- <select name="coltypelist#getictrantemp.trancode#" id="coltypelist#getictrantemp.trancode#" onChange="if(this.value != '#getictrantemp.brem1#'){document.getElementById('updatebtn#getictrantemp.trancode#').style.display='block';}else{document.getElementById('updatebtn#getictrantemp.trancode#').style.display='none';}" onclick="if(this.value == '' ">
                                <option value="Cash n Carry" <cfif getictrantemp.brem1 eq "Cash n Carry">Selected</cfif>>Cash & Carry</option>
                                <option value="Cash n Delivery" <cfif getictrantemp.brem1 eq "Cash n Delivery">Selected</cfif>>Cash & Delivery</option> 
                                </select> --->
                                <input type="text" name="coltypelist#getictrantemp.trancode#" id="coltypelist#getictrantemp.trancode#" value="#getictrantemp.brem1#" onClick="if(this.value=='Collection'){this.value = 'Delivery';updaterow('#getictrantemp.trancode#');} else {this.value = 'Collection';updaterow('#getictrantemp.trancode#');}"  readonly="readonly">
                                </td>
                                <td nowrap align="right">
                                <input type="text" name="qtylist#getictrantemp.trancode#" id="qtylist#getictrantemp.trancode#" value="#val(getictrantemp.qty_bil)#" size="5" onBlur="updaterow('#getictrantemp.trancode#');" onKeyup="if(this.value != '#val(getictrantemp.qty_bil)#'){document.getElementById('updatebtn#getictrantemp.trancode#').style.display='block';}else{document.getElementById('updatebtn#getictrantemp.trancode#').style.display='none';}">
                                </td>
                                <td nowrap align="right">
                                <cfif getpin2.h2F00 neq "T">
                                #numberformat(val(getictrantemp.price_bil),',.___')#
                                <cfelse>
                                <a style="cursor:pointer" onClick="document.getElementById('hidtrancode').value='#getictrantemp.trancode#';ColdFusion.Window.show('changeprice');getfocus5();">#numberformat(val(getictrantemp.price_bil),',.___')#</a>
                                </cfif>
                                </td>
                                <td nowrap align="right">
                                <a  style="cursor:pointer;" onClick="document.getElementById('hidtrancode').value='#getictrantemp.trancode#';ColdFusion.Window.show('changediscount');getfocus4();">#numberformat(val(getictrantemp.disamt_bil),'.__')#</a>
                                <input type="hidden" name="brem4#getictrantemp.trancode#" id="brem4#getictrantemp.trancode#" value="#getictrantemp.brem4#" size="5" onBlur="updaterow('#getictrantemp.trancode#');" onKeyup="if(this.value != '#getictrantemp.brem4#'){document.getElementById('updatebtn#getictrantemp.trancode#').style.display='block';}else{document.getElementById('updatebtn#getictrantemp.trancode#').style.display='none';}">
                                </td>
                                <td nowrap align="right">#numberformat(val(getictrantemp.amt_bil),',.__')#</td>
                                <td nowrap>
                                <input type="button" name="deletebtn#getictrantemp.trancode#" id="deletebtn#getictrantemp.trancode#" onClick="if(confirm('Are You Sure You Want To Delete?')){deleterow('#getictrantemp.trancode#')}" value="#words[805]#"/>&nbsp;
                                <img id="updatebtn#getictrantemp.trancode#" name="updatebtn#getictrantemp.trancode#" src="/images/tick.gif" width="15" height="15" style="cursor:pointer; display:none;"><!--- &nbsp;&nbsp;<input type="button" name="Updatebtn#getictrantemp.trancode#" id="updatebtn#getictrantemp.trancode#" onClick="updaterow('#getictrantemp.trancode#');" value="UPDATE" style="display:none"/> --->
                                </td>
                            </tr>
                        </cfloop>
                        <cfquery name="getsumictrantemp" datasource="#dts#">
                            SELECT sum(qty_bil)AS sumqty 
                            FROM ictrantemp 
                            WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#"> 
                            ORDER BY trancode DESC
                        </cfquery>
                    </table>
                </div>
                </td>
            </tr>
            <tr>
                <th>#words[1131]#<cfinput type="hidden" name="telegraph_transfer" id="telegraph_transfer" value="0.00"></th>
                <td colspan="1">
                <cfinput type="text" name="expressservicelist" id="expressservicelist" style="font: large bolder" size="10" onBlur="this.value = this.value.split('___', 1);getitemdetail(this.value);" onKeyUp="nextIndex(event,'expressservicelist','expqty');" <!---autosuggest="cfc:itemno.findItem({cfautosuggestvalue},'#dts#')" autosuggestminlength="1"--->/>
                <select name="coltype" id="coltype" onKeyUp="nextIndex(event,'coltype','expressservicelist');">
                    <option value="Collection">#words[1333]#</option>
                    <option value="Delivery">#words[744]#</option> 
                </select>
                <input type="button" id="searchitembtn" onClick="ColdFusion.Window.show('searchitem');getfocus2();" value="#words[11]#" align="right" />
                <input type="button" id="packagebtn" onClick="ColdFusion.Window.show('addpackage');" value="#words[1334]#" align="right" />
                </td>
                <th>#words[786]#</th>
                <td>
                <div id="getqtytotal">
                    <cfquery name="getsumictrantemp" datasource="#dts#">
                        SELECT sum(qty_bil)AS sumqty 
                        FROM ictrantemp 
                        WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#"> 
                        ORDER BY trancode DESC
                    </cfquery>
                    #getsumictrantemp.sumqty#
                </div>
                </td>
                <td></td>
            </tr>
             <tr style="display:none">
                <th>#words[65]#</th>
                <td colspan="2"><input type="text" name="desp2" id="desp2" size="30" onKeyUp="nextIndex(event,'desp','expqty');" ></td>
                
                
                
            </tr>
            <tr>
                <th>#words[227]#</th>
                <td>
                <input type="text" style="font: large bolder" name="expqty" id="expqty" size="10" maxlength="10" value="1" onKeyUp="calamtadvance();nextIndex(event,'expqty','expressservicelist');<cfif getgsetup.expressdisc neq "1">document.getElementById('expqtycount').value = this.value;</cfif>" >
                <cfif lcase(HcomID) eq "ssuni_i">
                    <cfselect name="expunit" id="expunit"  onKeyUp="nextIndex(event,'expunit','expprice');" onChange="ajaxFunction(document.getElementById('ajaxfieldgetunitprice'),'/default/transaction/POS/getunitpriceAjax.cfm?itemno='+document.getElementById('expressservicelist').value+'&unit='+document.getElementById('expunit').value);setunitprice();"></cfselect>
                <cfelse>
                    <cfselect style="display:none" name="expunit" id="expunit"  onKeyUp="nextIndex(event,'expunit','expprice');" onChange="ajaxFunction(document.getElementById('ajaxfieldgetunitprice'),'/default/transaction/POS/getunitpriceAjax.cfm?itemno='+document.getElementById('expressservicelist').value+'&unit='+document.getElementById('expunit').value);setunitprice();"></cfselect>
                </cfif>
                <div id="ajaxfieldgetunitprice"></div>
                </td>
                <cfif lcase(hcomid) eq "nil_i"  or lcase(hcomid) eq "mika_i">
                <th>Discount</th>
                <td>
                  <cfquery name="getdiscount" datasource="#dts#">
                  select * from discount order by discount
                  </cfquery>
                  <select name="discountbody" id="discountbody">
                  <option value="0%">Discount</option>
                  <cfloop query="getdiscount">
                  <option value="#getdiscount.discount#%">#getdiscount.discount#%</option>
                  </cfloop>
                  </select>&nbsp;&nbsp;&nbsp;<input type="button" name="updatebodydisc" id="updatebodydisc" value="Update" onClick="updatebodydisclistcontrol();">
                  <div id="updatebodydiscajax"></div>
  				
                
                </td>
                </cfif>
            </tr>
            <tr>
                <th>#words[1096]#</th>
                <td colspan="2"><input type="<cfif getpin2.h1360 eq 'T'>text<cfelse>hidden</cfif>" name="expprice" id="expprice" size="15" maxlength="15" value="0.00" onKeyUp="calamtadvance();nextIndex(event,'expprice',<cfif getgsetup.expressdisc eq "1">'expunitdis1'<cfelse>'expqtycount'</cfif>)"  ></td>
            </tr>
            <tr>
                <th>#words[592]#</th>
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
                <input type="<cfif getpin2.h1360 eq 'T'>text<cfelse>hidden</cfif>" name="expdis" id="expdis" size="10" maxlength="10" value="0.00" onKeyUp="calamtadvance();nextIndex(event,'expdis','btn_add')" onBlur="calamtadvance();">
                </td>
                <td rowspan="2">
                <div id="itembal" style="display:none"></div>
                <div id="itemDetail"  style="display:none"></div>
                </td>
            </tr>
            
            <input type="hidden" name="expressamt" id="expressamt" size="10" value="0.00" readonly >
            <tr <cfif lcase(HcomID) neq "ssuni_i">style="display:none"</cfif>>
                <td colspan="4" align="center">
                <input type="hidden" name="paytype" id="paytype" value=""><input name="btn_add" style="font: medium bolder" id="btn_add" type="button" value="#words[1116]#" onClick="addnewitem2();">&nbsp;&nbsp;&nbsp;
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
                </td>
            </tr>
            <tr>
                <td colspan="4" height="2px"><hr></td>
            </tr>
            <tr style="display:none">
                <td height="1px" colspan="4" align="center">
                <cfinput type="button" style="font: medium bolder; display:none" name="Submit" id="Submit" value="Accept" onClick="validformfield();" disabled/>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <cfinput type="button" style="font: medium bolder; display:none" name="Close" id="Close" value="Close" onClick="window.close();"/>
                </td>
            </tr>
			<cfset inputtype = "text">
            <tr>
                <td colspan="2">
                <table align="left" border="1">
                    <tr>
                        <td align="center" valign="middle" style="font:'Times New Roman', Times, serif; font-size:16px;" bgcolor="##CCFF33" onMouseOver="this.style.cursor='hand'">
                        <a onClick="ctrl1();" style="cursor:pointer">#words[1336]#<br><font size="1">#words[1337]#</font></a>
                        </td>
                        <!--- <a onClick="ctrl2();"><td align="center" valign="middle" style="font:'Times New Roman', Times, serif; font-size:18px" bgcolor="##CCFF33" onMouseOver="this.style.cursor='hand'">Cash<br><font size="1">ctrl+2</font></td></a>
                        
                        <a onClick="ctrl3();"><td align="center" valign="middle" style="font:'Times New Roman', Times, serif; font-size:18px" bgcolor="##CCFF33" onMouseOver="this.style.cursor='hand'">Credit Card<br><font size="1">ctrl+3</font></td></a>
                        <a onClick="ctrl4();"><td align="center" valign="middle" style="font:'Times New Roman', Times, serif; font-size:18px" bgcolor="##CCFF33" onMouseOver="this.style.cursor='hand'">Multi Payment<br><font size="1">ctrl+4</font></td></a>
                        
                        <a onClick="ctrl5();"><td align="center" valign="middle" style="font:'Times New Roman', Times, serif; font-size:18px" bgcolor="##CCFF33" onMouseOver="this.style.cursor='hand'">Net<br><font size="1">ctrl+5</font></td></a>
                        
                        <td align="center" valign="middle" style="font:'Times New Roman', Times, serif; font-size:18px"  bgcolor="##CCFF33" >Fast Key<br><font size="1">ctrl+6</font></td> --->
                        <td align="center" valign="middle" style="font:'Times New Roman', Times, serif; font-size:16px" bgcolor="##CCFF33" onMouseOver="this.style.cursor='hand'">
                        <a onClick="ctrl7();" style="cursor:pointer">#words[1338]#<br><font size="1">#words[1339]#</font></a>
                        </td>
                        <td align="center" valign="middle" style="font:'Times New Roman', Times, serif; font-size:16px" bgcolor="##CCFF33" onMouseOver="this.style.cursor='hand'">
                        <a onClick="document.getElementById('paytype').value='6';gopay('totalup6');" style="cursor:pointer">#words[1340]#</a>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                        <textarea name="rem9" id="rem9" cols="50" rows="3">#rem9#</textarea>
                        </td>
                    </tr>
                </table>
                </td>
                <td colspan="2">
                <table>
                    <tr>
                        <th width="100px">#words[1335]#</th>
                        <td><cfinput type="#inputtype#" name="gross" id="gross" readonly="yes" value="0.00"  /></td>
                    </tr>
                    <tr>
                        <th>#words[592]#</th>
                        <td>
                        <cfinput type="#inputtype#" size="3" name="dispec1" id="dispec1" value="0" validate="float" validateat="onblur" message="Please key in numeric value" onKeyUp="calcdisc();caltax();calcfoot();" />%
                        <input type="hidden" name="disbil1" id="disbil1" />&nbsp;&nbsp;
                        <cfinput type="#inputtype#" size="3" name="dispec2" id="dispec2" value="0" validate="float" validateat="onblur" message="Please key in numeric value" onKeyUp="calcdisc();caltax();calcfoot();"/>%
                        <input type="hidden" name="disbil2" id="disbil2" />&nbsp;&nbsp;
                        <cfinput type="#inputtype#" size="3" name="dispec3" id="dispec3" value="0" validate="float" validateat="onblur" message="Please key in numeric value" onKeyUp="calcdisc();caltax();calcfoot();"/>%
                        <input type="hidden" name="disbil3" id="disbil3" />&nbsp;&nbsp;&nbsp;
                        <cfif dts EQ "mika_i">
                        	<cfinput type="#inputtype#" size="5" name="disamt_bil" id="disamt_bil" value="0.00" validate="float" validateat="onblur" message="Please key in numeric value" onKeyUp="caltax();calcfoot();" readonly="true"/>
                        <cfelse>
                        	<cfinput type="#inputtype#" size="5" name="disamt_bil" id="disamt_bil" value="0.00" validate="float" validateat="onblur" message="Please key in numeric value" onKeyUp="caltax();calcfoot();" />
                        </cfif>
                        </td> 
                    </tr>
                    <tr>
                        <th>#words[1294]#</th>
                        <td><cfinput type="#inputtype#" name="net" id="net" value="0.00" readonly="yes" /> </td>
                    </tr>
                    <tr>
                        <th>#words[1099]#</th>
                        <td>
                        <cfif getgsetup.wpitemtax neq "1">
                        <div style="visibility:hidden">
                            
                            <cfquery name="getTaxCode" datasource="#dts#">
                                SELECT "" AS code, "" AS rate1
                                UNION ALL
                                SELECT code,rate1 
                                FROM #target_taxtable#
                            </cfquery>
                            <cfquery name="getdf" datasource="#dts#">
                                SELECT df_salestax,df_purchasetax 
                                FROM gsetup
                            </cfquery>
                            <cfquery name="taxrate" datasource="#dts#">
								<cfif (tran eq 'RC' or tran eq 'PO' or tran eq 'PR') and getdf.df_purchasetax neq "">
                                    SELECT 
                                    "#getdf.df_purchasetax#" AS code
                                    UNION ALL
								<cfelseif tran eq 'DN' or tran eq 'CN'>
								<cfelseif getdf.df_salestax neq "">
                                    SELECT 
                                    "#getdf.df_salestax#" AS code
                                    UNION ALL
                                </cfif>
                                SELECT code FROM #target_taxtable# 
								<cfif tran eq 'RC' or tran eq 'PO' or tran eq 'PR' >
                                    WHERE tax_type <> "ST"
									<cfif getdf.df_purchasetax neq "">
                                        AND code <> "#getdf.df_purchasetax#"
                                    </cfif>
								<cfelseif tran eq 'DN' or tran eq 'CN' >
                                <cfelse>
                                    WHERE tax_type <> "PT"
                                    <cfif getdf.df_purchasetax neq "">
                                        AND code <> "#getdf.df_salestax#"
                                    </cfif>
                                </cfif>
                            </cfquery>
                            <cfselect name="taxcode" id="taxcode" query="taxrate" value="code" display="code" onChange="setTimeout('caltax()',500);" bindonload="yes"/>
                        </div>
						<!---<input type="hidden" name="taxcode" id="taxcode" value="ZR">--->
                        <input type="checkbox" name="taxincl" id="taxincl" value="T" onClick="caltax()" <cfif getgsetup.taxincluded eq "Y">checked </cfif> />&nbsp;
                        &nbsp;&nbsp;<cfinput type="#inputtype#" name="taxper" id="taxper" value="0" size="8" bind="CFC:tax.getTax('#dts#','#target_taxtable#',{taxcode})" onKeyUp="caltax()" bindonload="yes"  />&nbsp;&nbsp;&nbsp;
                        <cfelse>
                        <input type="checkbox" name="taxincl" id="taxincl" value="T" onClick="caltax()" style="display:none">
                        
                        <input type="hidden" name="taxcode" id="taxcode" value="">
						<input type="hidden" name="taxper" id="taxper" value="0">
                        
                        </cfif>
                        <cfinput type="#inputtype#" name="taxamt" id="taxamt" value="0.00" size="10" onKeyUp="calcfoot();" />  
                        
                        </td>
                    </tr>
                </table>
                </td>
            </tr>
            <tr>
                <td colspan="4"><hr></td>
            </tr>
            <tr>
                <td colspan="4" align="center">
                <input name="cancel_btn" style="font: medium bolder;background-color:##6600CC; color:##CCCC66" id="btn_add" type="button" value="#words[1341]#" onClick="cancel();" size="15" />&nbsp;&nbsp;&nbsp;
                <input name="pay_btn" style="font: medium bolder;background-color:" id="btn_add" type="button" value="#words[1342]#" onClick="document.getElementById('paytype').value='0';gopay('totalup');" size="15" />&nbsp;&nbsp;&nbsp;
                	<cfif dts NEQ "umwstaffshop_i">
                        <input name="pay_btn" style="font: medium bolder;background-color:##996633; color:##00FFFF" id="btn_add" type="button" value="#words[1343]#" onClick="document.getElementById('paytype').value='1';gopay('totalup1');" />&nbsp;&nbsp;&nbsp;
                        <input name="pay_btn" style="font: medium bolder;background-color:##666; color:##0F0" id="btn_add" type="button" value="#words[1344]#" onClick="document.getElementById('paytype').value='2';gopay('totalup2');" />&nbsp;&nbsp;&nbsp;
                        <input name="pay_btn" style="font: medium bolder;background-color:##3C0" id="btn_add" type="button" value="#words[1345]#" onClick="document.getElementById('paytype').value='3';gopay('totalup3');" />&nbsp;&nbsp;&nbsp;
                        <input name="pay_btn" style="font: medium bolder; background-color:##C30; color:##0F0" id="btn_add" type="button" value="#words[1346]#" onClick="document.getElementById('paytype').value='4';gopay('totalup4');"/>&nbsp;&nbsp;&nbsp;
                        <input name="pay_btn" style="font: medium bolder;background-color:##0F0" id="btn_add" type="button" value="#words[1347]#" onClick="document.getElementById('paytype').value='5';gopay('totalup5');" size="15" />
                	</cfif>
                </td>
            </tr>
        </table>
    </cfform>
	<cfif getdealermenu.itemformat eq '2'>
        <cfwindow center="true" width="700" height="500" name="searchitem" refreshOnShow="true" closable="true" modal="false" 
            title="Search Item" initshow="false"
            source="/default/transaction/POS/searchitem2.cfm?reftype={tran}" />
    <cfelse>
        <cfwindow center="true" width="700" height="500" name="searchitem" refreshOnShow="true" closable="true" modal="false" 
            title="Search Item" initshow="false"
            source="/default/transaction/POS/searchitem.cfm?reftype={tran}" />
    </cfif>
    
	<cfwindow center="true" width="700" height="500" name="searchitemtradein" refreshOnShow="true" closable="true" modal="false" 
            title="Search Item" initshow="false"
            source="/default/transaction/POS/searchitemtradein.cfm?reftype={tran}" />
			
			
    <!--- <cfwindow center="true" width="600" height="400" name="changedaddr" refreshOnShow="true" closable="true" modal="false" title="Search Address" initshow="false"
            source="/default/transaction/POS/searchaddress.cfm" /> --->
    <cfif getgsetup.negstk neq "1">
        <cfwindow center="true" width="300" height="300" name="negativestock" refreshOnShow="true" closable="true" modal="true" 
            title="Negative Stock" initshow="false"
            source="negativestock.cfm" />
    </cfif>
    
    <cfif lcase(hcomid) eq "nil_i"  or lcase(hcomid) eq "mika_i">
    <cfwindow center="true" width="300" height="300" name="mikadiscountpassword" refreshOnShow="true" closable="true" modal="true" 
            title="Discount Limit" initshow="false"
            source="mikadiscount.cfm?discount={mikauserdiscount}&type=1" />
    <cfwindow center="true" width="300" height="300" name="mikadiscountpassword2" refreshOnShow="true" closable="true" modal="true" 
            title="Discount Limit" initshow="false"
            source="mikadiscount.cfm?discount={mikauserdiscount}&type=2" />
    </cfif>
    
    <cfif getgsetup.ECAMTOTA eq "Y">
        <cfwindow center="true" width="300" height="300" name="serviceamount" refreshOnShow="true" closable="true" modal="true"
             title="Service Amount" initshow="false"
                source="serviceamount.cfm" />
    </cfif>
    <cfif getgsetup.PCBLTC eq "Y">
        <cfwindow center="true" width="300" height="300" name="stkcostcontrol" refreshOnShow="true" closable="true" modal="true" 
            title="Stock Price Is Lower Than Cost" initshow="false"
            source="stkcostcontrol.cfm" />
    </cfif>
<!--- <cfwindow center="true" width="300" height="300" name="timemanchine" refreshOnShow="true" closable="true" modal="true" title="Revert Back To Previous Entry" initshow="false"
        source="timemanchine.cfm?uuid=#uuid#" /> --->
<!--- <cfwindow center="true" width="700" height="500" name="itembalance" refreshOnShow="true" closable="true" modal="false" title="Location Qty Balance" initshow="false"
        source="/default/transaction/itembal2.cfm?itemno={expressservicelist}&project=&job=&batchcode=" /> --->     

    <cfwindow center="true" width="700" height="500" name="addpackage" refreshOnShow="true" closable="true" modal="false" 
        title="Package" initshow="false"
        source="/default/transaction/expresstran/addpackage.cfm?reftype={tran}" /> 
    
    <cfwindow center="true" width="800" height="500" name="addtradein" refreshOnShow="true" closable="true" modal="false" 
        title="Add Trade In" initshow="false"
        source="/default/transaction/POS/addtradein.cfm?uuid={uuid}" /> 
    
    <cfwindow center="true" width="700" height="300" name="totalup" refreshOnShow="true" closable="true" modal="true" 
        title="Total" initshow="false" 
        source="total.cfm?grandtotal={grand}&uuid=#uuid#" />   
    <cfwindow center="true" width="700" height="250" name="totalup1" refreshOnShow="true" closable="true" modal="true" 
        title="Total" initshow="false" 
        source="total1.cfm?grandtotal={grand}&uuid=#uuid#" /> 
    <cfwindow center="true" width="700" height="250" name="totalup2" refreshOnShow="true" closable="true" modal="true" 
        title="Total" initshow="false" 
        source="total2.cfm?grandtotal={grand}&uuid=#uuid#" /> 
    <cfwindow center="true" width="700" height="250" name="totalup3" refreshOnShow="true" closable="true" modal="true" 
        title="Total" initshow="false" 
        source="total3.cfm?grandtotal={grand}&uuid=#uuid#" /> 
    <cfwindow center="true" width="700" height="250" name="totalup4" refreshOnShow="true" closable="true" modal="true" 
        title="Total" initshow="false" 
        source="total4.cfm?grandtotal={grand}&uuid=#uuid#" /> 
    <cfwindow center="true" width="700" height="600" name="totalup5" refreshOnShow="true" closable="true" modal="true" 
        title="Total" initshow="false" 
        source="total5.cfm?grandtotal={grand}&uuid=#uuid#&driverno={driver}&TT={telegraph_transfer}" />  
    <cfwindow center="true" width="700" height="600" name="totalup6" refreshOnShow="true" closable="true" modal="true" 
        title="Save as Invoice" initshow="false" 
        source="total6.cfm?grandtotal={grand}&uuid=#uuid#&custno={custno}" /> 
    <cfwindow center="true" width="600" height="600" name="neweu" refreshOnShow="true" closable="true" modal="true" 
        title="Create New Member" initshow="false" 
        source="neweu.cfm" />  
    <cfwindow center="true" width="250" height="150" name="changeprice" refreshOnShow="true" closable="true" modal="true" 
        title="Edit Price" initshow="false" 
        source="changeprice.cfm?uuid=#uuid#&trancode={hidtrancode}" />  
    <cfwindow center="true" width="500" height="200" name="changediscount" refreshOnShow="true" closable="true" modal="true" 
        title="Edit Discount" initshow="false" 
        source="changediscount.cfm?uuid=#uuid#&trancode={hidtrancode}" />  
    <cfwindow center="true" width="700" height="550" name="searchmember" refreshOnShow="true" closable="true" modal="true" 
        title="Search Member" initshow="false" 
        source="searchmember.cfm?main={checkmain}" />  
	<cfif isdefined('url.uuid')>
		<script type="text/javascript">
			recalculateamt();
			setTimeout('caltax()','1000');
        </script>
    </cfif>
	<!---<cfif isdefined('url.first') and lcase(hcomid) neq "mika_i" and lcase(hcomid) neq "sinleanhin_i">
        <cfwindow center="true" width="260" height="160" name="choosecounter" refreshOnShow="true" closable="false" modal="true" 
            title="Choose Counter" initshow="true" 
            source="choosecounter.cfm" />
    </cfif>--->
    <cfquery name="emptytemp" datasource="#dts#">
        DELETE FROM ictrantemp 
        WHERE trdatetime < "#dateformat(dateadd('d','-2',now()),'YYYY-MM-DD')#" AND onhold <> "Y"
    </cfquery>
</body>
</cfoutput>
