<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "98,805,95,1151,1152,1153,1154,1162,1155,1163,16,11,1168,879,878,23,29,30,6,1164,1165,40,42,300,1166,120,11,65,482,1082,1167">
<cfinclude template="/latest/words.cfm">
<cfajaximport tags="cfform,cftooltip">
<cfajaximport tags="cfwindow,cflayout-tab">
<html>
<head>
	<title><cfoutput>#words[1162]#</cfoutput></title>
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
	<script type="text/javascript">
	<cfoutput>
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
				if (item1.charCodeAt(i) < item2.charCodeAt(i) || item1.charCodeAt(i) > item3.charCodeAt(i)){		
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
				if (item1.charCodeAt(i) < item2.charCodeAt(i) || item1.charCodeAt(i) > item3.charCodeAt(i)){		
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
			document.repairserviceform.custno.options.add(myoption);
			var indexvalue = document.getElementById("custno").length-1;
			document.getElementById("custno").selectedIndex=indexvalue;
			updateDetails(document.repairserviceform.custno[indexvalue].value);
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
		function updateDetails(columnvalue) {
			var tran = document.repairserviceform.tran.value;
			var tablename = document.repairserviceform.ptype.value;
			DWREngine._execute(_tranflocation, null, 'getCustSuppDetails', tablename, columnvalue, tran, showCustSuppDetails);
		}
			
		function selectOptionByValue(selObj, val) { 
			var A= selObj.options, L= A.length; 
			while(L){ 
				if (A[--L].value== val){ 
					selObj.selectedIndex= L; 
					L= 0; 
				} 
			} 
		}
		function showCustSuppDetails(CustSuppObject) {
			DWRUtil.setValue("name", CustSuppObject.B_NAME);
		}
			
		function selectOptionByValue(selObj, val) { 
			var A= selObj.options, L= A.length; 
			while(L){ 
				if (A[--L].value== val){ 
					selObj.selectedIndex= L; 
					L= 0; 
				} 
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
		function updatecustomerdetail() {
			<!---document.getElementById('hidadd1').value=document.getElementById('hidname2').value;--->
			document.getElementById('b_add1').value=document.getElementById('hidadd1').value;
			document.getElementById('b_add2').value=document.getElementById('hidadd2').value;
			document.getElementById('b_add3').value=document.getElementById('hidadd3').value;
			document.getElementById('b_add4').value=document.getElementById('hidadd4').value;
			document.getElementById('b_phone').value=document.getElementById('hidphone').value;
			document.getElementById('b_phone2').value=document.getElementById('hidphone2').value;
			document.getElementById('b_fax').value=document.getElementById('hidfax').value;
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
			if(trim(document.getElementById('repairno').value) != ''){
				addItemControl();
			}
			else{
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
	</cfoutput>
    </script>
</head>
<cfoutput>
<body>
    <cfquery name="getdisplaysetup2" datasource="#dts#">
        SELECT * 
        FROM displaysetup2
    </cfquery>
    <cfswitch expression="#url.type#">
        <cfcase value="Edit,Delete" delimiters=",">
            <cfquery name="getRepair" datasource="#dts#">
                select * from Repairtran where repairno = '#url.repairno#'
            </cfquery>
        </cfcase>
    </cfswitch>
	<cfswitch expression="#url.type#">
        <cfcase value="Edit">
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
			<cfset mode="Edit">
			<cfset title="Edit Repair">
			<cfset button="Receive">
			<cfset modeWords="#words[98]#">
			<cfset pageTitle="Update Repair Service">
		</cfcase>
		<cfcase value="Delete">
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
			<cfset mode="Delete">
			<cfset title="Delete Repair">
			<cfset button="Delete">
			<cfset modeWords="#words[805]#">
			<cfset pageTitle="Delete Repair Service">
		</cfcase>
		<cfcase value="Create">
            <cfquery name="getlastrepairno" datasource="#dts#">
                SELECT max(repairno) AS repairno 
                FROM Repairtran
            </cfquery>
			<cfif getlastrepairno.repairno eq ''>
                <cfset getlastrepairno.repairno='RP00000000'>
            </cfif>
            <cftry>
                <cfinvoke component="cfc.IncrementValue" method="getIncreament" input="#getlastrepairno.repairno#" returnvariable="repairno"/>
            <cfcatch>
                <cfinvoke component="cfc.refno" method="processNum" oldNum="#getlastrepairno.repairno#" returnvariable="repairno" />	
            </cfcatch>
            </cftry>
            <!---
            <cfquery name="addrepair" datasource="#dts#">
                insert into repairtran (repairno,status) values (<cfqueryparam cfsqltype="cf_sql_varchar" value="#repairno#">,'Receive')
            </cfquery>--->
			<cfset repairno=repairno>
            <cfset wos_date=dateformat(now(),'DD/MM/YYYY')>
            <cfset custno=''>
            <cfset name=''>
            <cfset completedate=dateformat(now(),'DD/MM/YYYY')>
            <cfset repairitem=''>
            <cfset grossamt='0'>
            <cfset xagent=''>
            <cfset rem5=''>
            <cfset rem6=''>
            <cfset rem7=''>
            <cfset rem8=''>
            <cfset rem9=''>
            <cfset rem10=''>
            <cfset rem11=''>
            <cfset mode="Create">
            <cfset title="Create Repair">
            <cfset button="Create">
			<cfset modeWords="#words[95]#">
			<cfset pageTitle="#words[1162]#">
        </cfcase>
	</cfswitch>
	<cfquery datasource="#dts#" name="getlocation">
        SELECT location, desp 
        FROM iclocation 
        WHERE 0=0 AND (noactivelocation='' or noactivelocation IS NULL)
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
	<cfform name="repairserviceform" action="createrepairservicetableprocess.cfm" method="post">
    	<input type="hidden" name="mode" value="#mode#">
		<cfinput type="hidden" name="ptype" id="ptype" bind="cfc:custsupp.getname({tran},'#target_arcust#','#target_apvend#')" bindonload="yes" >
        <cfinput type="hidden" name="tran" id="tran" value="INV">
		<h1 align="center">#words[1162]#</h1>
		<table align="center" class="data" width="70%">
      		<tr>
        		<th width="100">#words[1155]#: </th>
        		<td>
				<cfif mode eq "Delete" or mode eq "Edit">
            		<cfinput type="text" size="12" name="repairno" value="#repairno#" readonly>
            	<cfelse>
            		<cfinput type="text" size="12" name="repairno" required="yes" value="#repairno#" maxlength="12">
          		</cfif>
				</td>
                <th width="100">#words[1163]#: </th>
            <td>
                <cfinput type="text" name="wos_date" size="10" value="#dateformat(now(),"dd/mm/yyyy")#" validate="eurodate" maxlength="10"> <img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('wos_date'));">(DD/MM/YYYY) 
                </td>
      		</tr>
            
            <tr>
            <th width="100">#words[16]#: </th>
            <td colspan="3">
            <cfif checkrccreated.recordcount neq 0>
                <input type="text" name="custno" id="custno" value="#custno#" readonly>
            <cfelse>
                <cfquery name="geteuqry" datasource="#dts#">
                    SELECT " Choose an Customer" as eudesp, "" as custNO
                    UNION ALL 
                    SELECT concat(custno,' - ',name) AS eudesp, custno 
                    FROM #target_arcust#
                    ORDER BY eudesp
                </cfquery>
                <cfselect name="custno" id="custno" query="geteuqry" display="eudesp" value="custno" onChange="getcustomer();" onKeyUp="getcustomer();" required="yes" message="Please Choose a Customer" />
                <cfif url.type eq 'PR' or  url.type eq 'RC' or url.type eq 'PO'>
                    <input type="button" name="Scust1" value="#words[11]#" onClick="javascript:ColdFusion.Window.show('findCustomer');getfocus();" >
                <cfelse>
                    <input type="button" name="Scust1" value="#words[1168]#" onClick="javascript:ColdFusion.Window.show('findCustomer');getfocus();" >
                </cfif>
                <input type="hidden" name="custhid" id="custhid"> &nbsp;&nbsp;  <input type="hidden" name="custhid" id="custhid">&nbsp;&nbsp;
            </cfif>              
            <cfif url.type eq 'PR' or  url.type eq 'RC' or url.type eq 'PO'>
                <a onClick="javascript:ColdFusion.Window.show('createSupplier');" onMouseOver="this.style.cursor='hand';">#words[879]#</a>
            <cfelse>
                <a onClick="javascript:ColdFusion.Window.show('createCustomer');" onMouseOver="this.style.cursor='hand';">#words[878]#</a>
            </cfif>         
                </td>
            </tr>
            
      		<tr>
        		<th>#words[23]#:</th>
        		<td><cfif mode eq "Delete" or mode eq "Edit">
						<cfinput type="text" size="40" name="name" id="name" required="no" value="#getRepair.name#" maxlength="40" readonly>
					<cfelse>
                        <div id="getcustomerdetailajax">
                            <cfinput type="text" size="40" name="name" id="name" required="no" maxlength="40">
						</div>
                    </cfif>
				</td>
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
        		<th>#words[6]#: </th>
        		<td><input type="text" name="b_add1" id="b_add1" value="" maxlength="35" size="40">
				</td>
                <th>#words[1164]#: </th>
                <td>
                <cfinput type="text" name="completedate" size="10" value="#dateformat(now(),"dd/mm/yyyy")#" validate="eurodate" maxlength="10"> <img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('completedate'));">(DD/MM/YYYY) 
                </td>
      		</tr>
            <tr>
                <th nowrap></th>
                <td>
                <input type="text" name="b_add2" id="b_add2" value="" maxlength="35" size="40">
                </td>
                <th>#words[1165]#</th>
                <td>
                <cfinput type="text" size="40" name="deliverystatus" id="deliverystatus" required="no" maxlength="40">
                </td>
            </tr>
            
            <tr>
                <th nowrap></th>
                <td>
                <input type="text" name="b_add3" id="b_add3" value="" maxlength="35" size="40">
                </td>
                <th nowrap <cfif getdisplaysetup2.hremark5 neq "Y">style="visibility:hidden"</cfif>>#getGsetup.rem5# :</th>
                <td <cfif getdisplaysetup2.hremark5 neq "Y">style="visibility:hidden"</cfif>>
                <cfinput type="text" size="40" name="rem5" id="rem5" value="#rem5#" required="no" maxlength="80">
                </td>
            </tr>
            
            <tr>
                <th nowrap></th>
                <td>
                <input type="text" name="b_add4" id="b_add4" value="" maxlength="35" size="40">
                </td>
                <th <cfif getdisplaysetup2.hremark6 neq "Y">style="visibility:hidden"</cfif> nowarp>#getGsetup.rem6# :</th>
                <td <cfif getdisplaysetup2.hremark6 neq "Y">style="visibility:hidden"</cfif>>
                <cfinput type="text" size="40" name="rem6" id="rem6" value="#rem6#" required="no" maxlength="80">
                </td>
            </tr>
            
            <tr>
                <th nowrap>#words[40]#</th>
                <td>
                <input type="text" name="b_phone" id="b_phone" value="" maxlength="25" size="40">
                </td>
                <th  nowrap <cfif getdisplaysetup2.hremark7 neq "Y">style="visibility:hidden"</cfif> nowarp>#getGsetup.rem7# :</th>
                <td <cfif getdisplaysetup2.hremark7 neq "Y">style="visibility:hidden"</cfif>>
                    <cfinput type="text" size="40" name="rem7" id="rem7" value="#rem7#" required="no" maxlength="80">
                </td>
            </tr>
            
            
            <tr>
                <th nowrap>#words[42]#</th>
                <td><input type="text" name="b_phone2" id="b_phone2" value="" maxlength="25" size="40">
                </td>
                <th <cfif getdisplaysetup2.hremark8 neq "Y">style="visibility:hidden"</cfif> nowarp>#getGsetup.rem8# :</th>
                <td <cfif getdisplaysetup2.hremark8 neq "Y">style="visibility:hidden"</cfif>>
                <cfinput type="text" size="40" name="rem8" id="rem8" value="#rem8#" required="no" maxlength="80">
                </td>
            </tr>
            
            <tr>
                <th nowrap>#words[300]#</th>
                <td><input type="text" name="b_fax" id="b_fax" value="" maxlength="25" size="40">
                </td>
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
        		<td><cfinput type="text" name="repairitem" id="repairitem" size="26" readonly required="yes" message="Please choose item to repair"/>
<input type="button" id="searchitembtn" onClick="ColdFusion.Window.show('searchrepairitem');getfocus2();" value="#words[11]#" align="right" />
				</td>
      		</tr>
            <tr>
        		<th>#words[65]#</th>
        		<td><cfinput type="text" name="desp" id="desp" value="" size="70" maxlength="100"/>
				</td>
      		</tr>
            <tr>
        		<th>#words[482]#</th>
        		<td>
                <select name="location" id="location">
                    <option value="">#words[1082]#</option>
                    <cfloop query="getlocation">
                        <option value="#getlocation.location#">#getlocation.location# - #getlocation.desp#</option>
                    </cfloop>
                </select>
				</td>
      		</tr>
            <tr>
                <td colspan="100%"><hr></td>
            </tr>
            <tr style="display:none">
        		<th><b>#words[1167]#:</b></th>
        		<td><cfif mode eq "Delete" or mode eq "Edit">
						<cfinput type="text" size="40" name="grossamt" required="no" value="#numberformat(getRepair.grossamt,'_.__')#" maxlength="40" readonly>
					<cfelse>
						<cfinput type="text" size="40" name="grossamt" required="no" maxlength="40" readonly>
					</cfif>
                </td>
      		</tr>
            <tr>
        		<td align="center" colspan="100%"><cfinput name="subbtn" id="subbtn" type="submit" value="#modeWords#"></td>
      		</tr>
        </table>
	</cfform>
</body>
</cfoutput>

</html>
<cfwindow x="10" y="10" modal="true"  width="1100" height="600" name="createCustomer" refreshOnShow="true"
    title="Add New Customer" initshow="false"
    source="/default/maintenance/createCustomerAjax.cfm" />
<cfwindow x="10" y="10" modal="true"  width="1100" height="600" name="createSupplier" refreshOnShow="true"
    title="Add New Supplier" initshow="false"
    source="/default/maintenance/createSupplierAjax.cfm" />

<cfwindow center="true" width="700" height="500" name="searchrepairitem" refreshOnShow="true" closable="true" modal="false" 
	title="Search Repair Item" initshow="false"
    source="searchrepairitem.cfm" />
<cfwindow center="true" width="700" height="500" name="searchitem" refreshOnShow="true" closable="true" modal="false" 
	title="Search Item" initshow="false"
    source="searchitem.cfm" />
<cfwindow center="true" width="700" height="500" name="findCustomer" refreshOnShow="true"
    title="Find Customer or Supplier" initshow="false"
    source="findCustomer.cfm?custno={custno}" />
