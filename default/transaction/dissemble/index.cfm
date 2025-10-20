<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1118,1024,1031,65,1106,1107,1119,482,1082,1067,1120,120,227,1096,1097,58,1121,10,805,58,1122,1067,11,1116,1104">
<cfinclude template="/latest/words.cfm">
<cfajaximport tags="cfform">
<html>
<head>
<title><cfoutput>#words[1118]#</cfoutput></title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
<cfinclude template = "/CFC/convert_single_double_quote_script.cfm">
<script src="/SpryAssets/SpryCollapsiblePanel.js" type="text/javascript"></script>
<script type='text/javascript' src='/ajax/core/engine.js'></script>
<script type='text/javascript' src='/ajax/core/util.js'></script>
<script type='text/javascript' src='/ajax/core/settings.js'></script>
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<script language="javascript" type="text/javascript" src="/scripts/CalendarControl.js"></script>
<script type="text/javascript" src="/scripts/prototypenew.js" ></script>
<cfset uuid = createuuid()>
<cfoutput>
<script type="text/javascript">
	function nextIndex(e,thisid,id) {
		if(e.keyCode==13){
			document.getElementById(id).focus();
			try {
				document.getElementById(id).select();
			}
			catch(err) {
			}
		}
	}
	function validformfield() {
		diseembleform.submit();
	}
	function calamtadvance() {
		var qty = document.getElementById('qty').value;
		var price = document.getElementById('price').value;
		qty = qty * 1;
		price = price * 1;
		var itemamt = (qty * price);
		document.getElementById('amount').value =  itemamt.toFixed(2);
	}
	function calamtadvance2() {
		var qty2 = document.getElementById('qty2').value;
		var price2 = document.getElementById('price2').value;
		qty2 = qty2 * 1;
		price2 = price2 * 1;
		var itemamt2 = (qty2 * price2);
		document.getElementById('amount2').value =  itemamt2.toFixed(2);
	}
	function getitemdetail(detailitemno) {
		var urlloaditemdetail = '/default/transaction/dissemble/addItemAjax.cfm?itemno='+escape(encodeURI(detailitemno));
		<!---ajaxFunction(document.getElementById('itemDetail'),urlloaditemdetail);
		updateVal();--->
		new Ajax.Request(urlloaditemdetail, {
			method:'get',
			onSuccess: function(getdetailback) {
				document.getElementById('itemDetail').innerHTML = getdetailback.responseText;
			},
			onFailure: function() { 
				alert('Item Not Found');
			},		
			onComplete: function(transport) {
				updateVal();
			}
		})
	}
	function getbatchdetail(batchno,location,itemno) {
		var urlissbatch = '/default/transaction/dissemble/issdissemble_batchajax.cfm?batchno='+escape(encodeURI(batchno))+'&location='+escape(encodeURI(location))+'&itemno='+escape(encodeURI(itemno));
	<!---ajaxFunction(document.getElementById('batchdetail'),urlissbatch);
	--->
		new Ajax.Request(urlissbatch, {
			method:'get',
			onSuccess: function(getdetailback) {
				document.getElementById('batchdetail').innerHTML = getdetailback.responseText;
			},
			onFailure: function() { 
				alert('batch Not Found');
			},		
			onComplete: function(transport) {
				document.getElementById('expdate').value = document.getElementById('issexpdatehid').value;
				document.getElementById('milcert').value = document.getElementById('issmilcerthid').value;
				document.getElementById('pallet').value = document.getElementById('isspallethid').value;
			}
		})
	}
	function getitemdetail2(detailitemno) {
		var urlloaditemdetail = '/default/transaction/dissemble/addItemAjax.cfm?itemno='+escape(encodeURI(detailitemno));
		new Ajax.Request(urlloaditemdetail, {
			method:'get',
			onSuccess: function(getdetailback){
				document.getElementById('itemDetail').innerHTML = getdetailback.responseText;
			},
			onFailure: function(){ 
				alert('Item Not Found');
			},		
			onComplete: function(transport){
				updateVal2();
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
				refreshlist();
			}
		})
	}
	function deleterow2(rowno) {
		var uuid = document.getElementById('uuid').value;
		var updateurl = 'deleterow2.cfm?uuid='+escape(uuid)+'&trancode='+rowno;
		new Ajax.Request(updateurl, {
			method:'get',
			onSuccess: function(getdetailback){
				document.getElementById('ajaxFieldPro').innerHTML = trim(getdetailback.responseText);
			},
			onFailure: function(){ 
				alert('Error Delete Item');
			},		
			onComplete: function(transport){
				refreshlist2();
			}
		})
	}
	function updaterow(rowno) {
		var varcoltype = 'coltypelist'+rowno;
		var varqtylist = 'qtylist'+rowno;
		var varpricelist = 'pricelist'+rowno;
		var uuid = document.getElementById('uuid').value;
		var coltypedata = document.getElementById(varcoltype).value;
		var pricelistdata = document.getElementById(varpricelist).value;
		var qtylistdata = document.getElementById(varqtylist).value;
		var updateurl = 'updaterow.cfm?uuid='+escape(uuid)+'&coltype='+escape(coltypedata)+'&qty='+escape(qtylistdata)+'&trancode='+rowno+'&price='+escape(pricelistdata);
		new Ajax.Request(updateurl, {
			method:'get',
			onSuccess: function(getdetailback){
				document.getElementById('ajaxFieldPro').innerHTML = trim(getdetailback.responseText);
			},
			onFailure: function(){ 
				alert('Error Update Item');
			},		
			onComplete: function(transport){
				refreshlist();
			}
		})
	}
	function updaterow2(rowno) {
		var varcoltype = 'coltypelist2'+rowno;
		var varqtylist = 'qtylist2'+rowno;
		var varpricelist = 'pricelist2'+rowno;
		var uuid = document.getElementById('uuid').value;
		var coltypedata = document.getElementById(varcoltype).value;
		var pricelistdata = document.getElementById(varpricelist).value;
		var qtylistdata = document.getElementById(varqtylist).value;
		var updateurl = 'updaterow2.cfm?uuid='+escape(uuid)+'&coltype='+escape(coltypedata)+'&qty='+escape(qtylistdata)+'&trancode='+rowno+'&price='+escape(pricelistdata);
		new Ajax.Request(updateurl, {
			method:'get',
			onSuccess: function(getdetailback){
				document.getElementById('ajaxFieldPro').innerHTML = trim(getdetailback.responseText);
			},
			onFailure: function(){ 
				alert('Error Update Item');
			},		
			onComplete: function(transport){
				refreshlist2();
			}
		})
	}
	function updateVal() {
		var validdesp = unescape(document.getElementById('desphid').value);
		if (validdesp == "itemisnoexisted") {
			document.getElementById('issbtn_add').value = "Item No Existed";
			document.getElementById('issbtn_add').disabled = true; 
		}
		else {
			try {
				document.getElementById('itemno').value = unescape(decodeURI(document.getElementById('replaceitemno').value));
			}
			catch(err) {
			}
			document.getElementById('desp').value = unescape(decodeURI(document.getElementById('desphid').value));
			document.getElementById('despa').value = unescape(decodeURI(document.getElementById('despahid').value));
			document.getElementById('price').value = document.getElementById('pricehid').value;
			document.getElementById('issbtn_add').value = "#words[1116]#";
			document.getElementById('issbtn_add').disabled = false; 
		}
		calamtadvance();
	}
	function updateVal2() {
		var validdesp = unescape(document.getElementById('desphid').value);
		if (validdesp == "itemisnoexisted") {
			document.getElementById('rcbtn_add').value = "Item No Existed";
			document.getElementById('rcbtn_add').disabled = true;
		}
		else {
			try {
				document.getElementById('itemno2').value = unescape(decodeURI(document.getElementById('replaceitemno').value));
			}
			catch(err) {
			}
			document.getElementById('desp2').value = unescape(decodeURI(document.getElementById('desphid').value));
			document.getElementById('despa2').value = unescape(decodeURI(document.getElementById('despahid').value));
			document.getElementById('price2').value = document.getElementById('pricehid').value;
			document.getElementById('rcbtn_add').value = "#words[1116]#";
			document.getElementById('rcbtn_add').disabled = false; 
		}
		calamtadvance2();
	}
	function addnewitem() {
		if(document.getElementById('amount').value=='NaN') {
			alert('Error in Qty / Price / Discount / Amt');
			return false;
			calamtadvance();
		}
		else {
			calamtadvance();
			addItemControl();
		}
	}
	function addItemControl() {
		var itemno = document.getElementById('itemno').value;
		var qtyser = document.getElementById('qty').value;
		if (itemno == "") {
			alert("Please select item");
		}
		else {
			addItemAdvance();
		}
	}
	function addnewitem2() {
		if(document.getElementById('amount2').value=='NaN') {
			alert('Error in Qty / Price / Discount / Amt');
			return false;
			calamtadvance2();
		}
		else {
			calamtadvance2();
			addItemControl2();
		}
	}
	function addItemControl2() {
		var itemno = document.getElementById('itemno2').value;
		var qtyser = document.getElementById('qty2').value;
		if (itemno == "") {
			alert("Please select item");
		}
		else {
			addItemAdvance2();
		}
	}
	function addItemAdvance() {
		var expressservice=encodeURI(trim(document.getElementById('itemno').value));
		var desp = encodeURI(document.getElementById('desp').value);
		var despa = encodeURI(document.getElementById('despa').value);
		var expressamt = trim(document.getElementById('amount').value);
		var expqty = trim(document.getElementById('qty').value);
		var expprice = trim(document.getElementById('price').value);
		var location = trim(document.getElementById('location').value);
		var refno = trim(document.getElementById('refno').value);
		var trancode = trim(document.getElementById('nextransac').value);
		var ajaxurl = '/default/transaction/dissemble/addproductsAjax.cfm?tran=iss&servicecode='+escape(expressservice)+'&desp='+escape(desp)+'&despa='+escape(despa)+'&expressamt='+escape(expressamt)+'&expqty='+escape(expqty)+'&expprice='+escape(expprice)+'&tranno='+refno+'&uuid=#URLEncodedFormat(uuid)#'+'&trancode='+escape(trancode)+'&location='+escape(location);
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
				refreshlist();
				document.getElementById('Submit').disabled = false;
			}
		})
	}
	function addItemAdvancebom() {
		var expressservice=encodeURI(trim(document.getElementById('bomitemno').value));
		var location = trim(document.getElementById('bomlocation').value);
		var bomno = trim(document.getElementById('bomno').value);
		var expqty = trim(document.getElementById('bomqty').value);
		var refno = trim(document.getElementById('refno').value);
		var trancode = trim(document.getElementById('nextransac').value);
		var ajaxurl = '/default/transaction/dissemble/addbomproductsAjax.cfm?servicecode='+escape(expressservice)+'&tranno='+refno+'&uuid=#URLEncodedFormat(uuid)#'+'&trancode='+escape(trancode)+'&location='+escape(location)+'&expqty='+escape(expqty)+'&bomno='+escape(bomno);
	<!---ajaxFunction(document.getElementById('ajaxFieldPro'),ajaxurl);
	updateVal();--->
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
				refreshlist();
				clearformadvance2();
				refreshlist2();
				document.getElementById('Submit').disabled = false;
			}
		})
	}
	function addItemAdvance2() {
		var expressservice=encodeURI(trim(document.getElementById('itemno2').value));
		var desp = encodeURI(document.getElementById('desp2').value);
		var despa = encodeURI(document.getElementById('despa2').value);
		var expressamt = document.getElementById('amount2').value;
		var expqty = document.getElementById('qty2').value;
		var expprice = document.getElementById('price2').value;
		var location = trim(document.getElementById('location2').value);
		var refno = trim(document.getElementById('refno').value);
		var trancode = trim(document.getElementById('nextransac2').value);
		var ajaxurl = '/default/transaction/dissemble/addproductsAjax.cfm?tran=rc&servicecode='+escape(expressservice)+'&desp='+escape(desp)+'&despa='+escape(despa)+'&expressamt='+escape(expressamt)+'&expqty='+escape(expqty)+'&expprice='+escape(expprice)+'&tranno='+refno+'&uuid=#URLEncodedFormat(uuid)#'+'&trancode='+escape(trancode)+'&location='+escape(location);
		new Ajax.Request(ajaxurl, {
			method:'get',
			onSuccess: function(getdetailback){
				document.getElementById('ajaxFieldPro').innerHTML = trim(getdetailback.responseText);
			},
			onFailure: function(){ 
				alert('Error Add Item');
			},		
			onComplete: function(transport){
				clearformadvance2();
				refreshlist2();
				document.getElementById('Submit').disabled = false;
			}
		})
	}
	function trim(strval) {
		return strval.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	}
	function clearformadvance() {
		document.getElementById('itemno').value = '';
		document.getElementById('desp').value = '';
		document.getElementById('amount').value = '0.00';
		document.getElementById('qty').value = '1';
		document.getElementById('price').value = '0.00';
		document.getElementById('itemno').focus();
	}
	function refreshlist() {
		ajaxFunction(document.getElementById('issuebodyajax'),'getissBody.cfm?uuid='+document.getElementById('uuid').value);
	}
	function clearformadvance2() {
		document.getElementById('itemno2').value = '';
		document.getElementById('desp2').value = '';
		document.getElementById('amount2').value = '0.00';
		document.getElementById('qty2').value = '1';
		document.getElementById('price2').value = '0.00';
		document.getElementById('itemno2').focus();
	}
	function refreshlist2() {
		ajaxFunction(document.getElementById('receivebodyajax'),'getrcBody.cfm?uuid='+document.getElementById('uuid').value);
	}
</script>
</cfoutput>
</head>
<cfquery name="getGsetup" datasource="#dts#">
	SELECT bcurr 
    FROM gsetup
</cfquery>

<cfquery datasource="#dts#" name="getlocation">
	SELECT location, desp 
	FROM iclocation 
    WHERE 0=0
    <cfif (lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjctrial_i") and (HUserGrpID neq 'Cust Svr' and HUserGrpID neq 'Van Sales')>
    <cfelse>
		<cfif Huserloc neq "All_loc">
            AND location='#Huserloc#'
        </cfif>
    </cfif>
	ORDER BY location;
</cfquery>

<cfquery name="getassmno" datasource="#dts#">
	SELECT lastUsedNo as refno, counter
    FROM refnoset
    WHERE type = 'ASSM';
</cfquery>



<cfif getassmno.refno eq ''>
	<cfset nexttranno='ASSM00001'>
<cfelse>
    <cftry>
        <cfinvoke component="cfc.IncrementValue" method="getIncreament" input="#getassmno.refno#" returnvariable="nexttranno"/>
	<cfcatch>
        <cfinvoke component="cfc.refno" method="processNum" oldNum="#getassmno.refno#" returnvariable="nexttranno" />	
	</cfcatch>
    </cftry>
</cfif>


<cfquery name="getitem" datasource="#dts#">
	SELECT a.itemno,b.desp 
    FROM billmat AS a 
    LEFT JOIN(
    	SELECT desp,itemno 
        FROM icitem) AS b
    ON a.itemno=b.itemno 
    GROUP BY a.itemno
</cfquery>
<body>
<h1 align="center"><cfoutput>#words[1118]#</cfoutput></h1>
<cfif isdefined('form.status')>
    <h3><cfoutput>#form.status#</cfoutput></h3>
</cfif>
<cfform name="diseembleform" id="diseembleform" action="process.cfm" method="post">
<cfoutput> 
	<table width="80%" border="0" cellspacing="0" cellpadding="0" align="center" class="data">
    	
    	<tr> 
        	<th height="21">#words[1024]#
            	<cfinput type="hidden" name="uuid" id="uuid" value="#uuid#">
            </th>
        	<td colspan="3">
            	<!---<h3>#nexttranno#</h3>--->
                <select name="refno" id="refno" onChange="document.getElementById('refnoCounter').value=document.getElementById('refno')[document.getElementById('refno').selectedIndex].title">
                	<cfloop query="getassmno">
                		<option value="#refno#" title="#counter#">#refno#</option>
                    </cfloop>
                </select>
                <input type="hidden" name="refnoCounter" id="refnoCounter" value="1"> 
              	<!---<cfinput name="refno" id="refno" type="text" value="#nexttranno#" onValidate="javascript:test()" size="10" maxlength="8" onKeyUp="nextIndex(event,'refno','wos_date');">--->
			</td>
        	<td>&nbsp;</td>
      	</tr>
    	
    	<tr> 
      		<th>#words[1031]#</th>
      		<td>
            	<cfinput type="text" name="wos_date" id="wos_date" size="10" value="#dateformat(now(),"dd/mm/yyyy")#" validate="eurodate" maxlength="10" onKeyUp="nextIndex(event,'wos_date','headerdesp');">(DD/MM/YYYY)
            </td>
    	</tr>
    	<tr> 
    		<th>#words[65]#</th>
      		<td colspan="3">
            	<cfinput name="headerdesp" type="text" size="50" maxlength="40" value="Receive" onKeyUp="nextIndex(event,'headerdesp','headerdespa');">
            </td>
      		<td>
            <cfquery name="getnewtrancode" datasource="#dts#">
                SELECT max(trancode) AS newtrancode
                FROM issuetemp
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
                FROM issuetemp 
                WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#"> 
                ORDER BY trancode DESC
        	</cfquery>
  			<cfselect style="display:none"  name="nextransac" id="nextransac" query="newtranqy" display="trancode" value="trancode" />
            <cfquery name="getnewtrancode2" datasource="#dts#">
                SELECT max(trancode) AS newtrancode
                FROM receivetemp
                WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
            </cfquery>
        	<cfif getnewtrancode2.recordcount eq 0>
				<cfset newtrancode2=1>
       		<cfelse>
				<cfset newtrancode2 = val(getnewtrancode2.newtrancode)+1>
        	</cfif>
        	<cfquery name="newtranqy2" datasource="#dts#">
                SELECT #newtrancode2# AS trancode
                UNION
                SELECT trancode 
                FROM receivetemp 
                WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#"> 
                ORDER BY trancode DESC
        	</cfquery>
  			<cfselect style="display:none" name="nextransac2" id="nextransac2" query="newtranqy2" display="trancode" value="trancode" />
            </td>
    	</tr>
    	<tr> 
      		<th>&nbsp;</th>
      		<td colspan="3">
          	<cfinput name="headerdespa" type="text" size="50" maxlength="40" value="Issue" onKeyUp="nextIndex(event,'headerdespa','headerdesp');">
          	</td>
      		<td>&nbsp;</td>
    	</tr>
        
        <tr>
        	<td colspan="100%"><hr><div id="ajaxFieldPro" name="ajaxFieldPro"></div></td>
        </tr>
        <tr> 
      		<th>#words[1118]#</th>
      		<td colspan="3">
          	<select name="bomitemno"  id="bomitemno" onChange="ajaxFunction(document.getElementById('bomnoajax'),'bomnoajax.cfm?itemno='+escape(this.value));">
                <option value="">#words[1106]#</option>
                <cfloop query="getitem">
                    <option value="#convertquote(itemno)#">#itemno# - #desp#</option>
                </cfloop>
      		</select>
            </td>
      		<td>&nbsp;</td>
    	</tr>
        <tr> 
      		<th>#words[1107]#</th>
      		<td colspan="3">

            <div id="bomnoajax">
            <select name="bomno" id="bomno">
			<option value="">#words[1119]#</option>
      		</select>
			</div>
            </td>
      		<td>&nbsp;</td>
    	</tr>
        <tr> 
      		<th>#words[482]#</th>
      		<td colspan="3">
            <select name="bomlocation"  id="bomlocation">
                <option value="">#words[1082]#</option>
                <cfloop query="getlocation">
                    <option value="#getlocation.location#">#getlocation.location# - #getlocation.desp#</option>
                </cfloop>
      		</select>
            </td>
      		<td>&nbsp;</td>
    	</tr>
        <tr> 
      		<th>#words[227]#</th>
      		<td colspan="3">
                <cfinput type="text" name="bomqty" id="bomqty" size="10" maxlength="10" value="1" onKeyUp="nextIndex(event,'bomqty','btn_add');" >
        	</td>
      		<td>&nbsp;</td>
    	</tr>
        <tr> 
      		<td colspan="4" align="center">
                <cfinput name="btn_add" id="btn_add" type="button" value="#words[1122]#" onClick="addItemAdvancebom();">
        	</td>
      		<td>&nbsp;</td>
    	</tr>
        <tr>
        	<td colspan="100%"><hr><div id="ajaxFieldPro" name="ajaxFieldPro"></div></td>
        </tr>
        <tr>
            <td colspan="2" align="center"><strong>#words[1067]#</strong></td>
            <td></td>
            <td colspan="2" align="center"><strong>#words[1120]#</strong>
            <input type="hidden" name="issbatchtrancode" id="issbatchtrancode" value=""><input type="hidden" name="rcbatchtrancode" id="rcbatchtrancode" value=""><input type="hidden" name="rcserialtrancode" id="rcserialtrancode" value="">
            </td>
        </tr>
        <tr>
            <th>#words[120]#</th>
            <td>
            <cfinput type="text" name="itemno" id="itemno" size="26" onBlur="this.value = this.value.split('___', 1);getitemdetail(this.value);" autosuggest="cfc:itemno.findItem({cfautosuggestvalue},'#dts#')" autosuggestminlength="1" autosuggestBindDelay="1" onKeyUp="nextIndex(event,'itemno','desp');">
            &nbsp;
            <cfinput type="button" name="searchitembtn" id="searchitembtn" onClick="document.getElementById('searchitemtype').value='itemno';ColdFusion.Window.show('searchitem');" value="#words[11]#" align="right" /><div id="itemDetail"></div></td>
            <td>&nbsp;</td>
            <th>#words[120]#</th>
            <td>
            <cfinput type="text" name="itemno2" id="itemno2" size="26" onBlur="this.value = this.value.split('___', 1);getitemdetail2(this.value);" autosuggest="cfc:itemno.findItem({cfautosuggestvalue},'#dts#')" autosuggestminlength="1" autosuggestBindDelay="1" onKeyUp="nextIndex(event,'itemno2','desp2');">
            &nbsp;
            <cfinput type="button" name="searchitembtn" id="searchitembtn" onClick="document.getElementById('searchitemtype').value='itemno2';ColdFusion.Window.show('searchitem2');" value="#words[11]#" align="right" /><cfinput type="hidden" name="searchitemtype" id="searchitemtype" value="">
            </td>
        </tr>
        <tr>
            <th>#words[65]#</th>
            <td><cfinput type="text" name="desp" id="desp" size="40" onKeyUp="nextIndex(event,'desp','despa');" ></td>
            <td>&nbsp;</td>
            <th>#words[65]#</th>
            <td><cfinput type="text" name="desp2" id="desp2" size="40" onKeyUp="nextIndex(event,'desp2','despa2');" ></td>
        </tr>
        <tr>
            <th></th>
            <td><cfinput type="text" name="despa" id="despa" size="40" onKeyUp="nextIndex(event,'despa','location');" ></td>
            <td>&nbsp;</td>
            <th></th>
            <td><cfinput type="text" name="despa2" id="despa2" size="40" onKeyUp="nextIndex(event,'despa2','location2');" ></td>
        </tr>
        <tr>
            <th>#words[482]#</th>
            <td>
            <select name="location"  id="location">
                <option value="">#words[1082]#</option>
                <cfloop query="getlocation">
                    <option value="#getlocation.location#">#getlocation.location# - #getlocation.desp#</option>
                </cfloop>
            </select>
            </td>
            <td>&nbsp;</td>
            <th>#words[482]#</th>
            <td>
            <select name="location2"  id="location2">
                <option value="">#words[1082]#</option>
                <cfloop query="getlocation">
                    <option value="#getlocation.location#">#getlocation.location# - #getlocation.desp#</option>
                </cfloop>
            </select>
            </td>
        </tr>
        <tr>
            <th>#words[227]#</th>
            <td><cfinput type="text" name="qty" id="qty" size="10" maxlength="10" value="1" onKeyUp="calamtadvance();nextIndex(event,'qty','price');" onBlur="calamtadvance();"></td>
            <td>&nbsp;</td>
            <th>#words[227]#</th>
            <td><cfinput type="text" name="qty2" id="qty2" size="10" maxlength="10" value="1" onKeyUp="calamtadvance2();nextIndex(event,'qty2','price2');" ></td>
        </tr>
        
        <tr>
            <th>#words[1096]#</th>
            <td><cfinput type="text" name="price" id="price" size="15" maxlength="15" value="0.00" onKeyUp="calamtadvance();nextIndex(event,'price','amount');" onBlur="calamtadvance();"></td>
            <td>&nbsp;</td>
            <th>#words[1096]#</th>
            <td><cfinput type="text" name="price2" id="price2" size="15" maxlength="15" value="0.00" onKeyUp="calamtadvance2();nextIndex(event,'price2','amount2');" ></td>
        </tr>
        <tr>
            <th>#words[1097]#</th>
            <td><cfinput type="text" name="amount" id="amount" size="10" value="0.00" readonly  onKeyUp="nextIndex(event,'amount','btn_add');" >&nbsp;&nbsp;&nbsp;&nbsp;
            <cfinput name="issbtn_add" id="issbtn_add" type="button" value="#words[1116]#" onClick="addnewitem();"></td>
            <td>&nbsp;</td>
            <th>#words[1097]#</th>
            <td><cfinput type="text" name="amount2" id="amount2" size="10" value="0.00" readonly  onKeyUp="nextIndex(event,'amount2','btn_add2');" >&nbsp;&nbsp;&nbsp;&nbsp;
            <cfinput name="rcbtn_add"  id="rcbtn_add" type="button" value="#words[1116]#" onClick="addnewitem2();"></td>
        </tr>
        <tr>
            <td colspan="2">
            <div id="issuebodyajax">
                <table>
                    <tr>
                        <th>#words[58]#</th>
                        <th>#words[120]#</th>
                        <th>#words[65]#</th>
                        <th>#words[1121]#</th>
                        <th>#words[1096]#</th>
                        <th>#words[1097]#</th>
                        <th nowrap>#words[10]#</th>
                    </tr>
                    <cfquery name="getissuetemp" datasource="#dts#">
                        SELECT * 
                        FROM issuetemp 
                        WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
                        ORDER BY trancode DESC
                    </cfquery>
                    <cfloop query="getissuetemp">
                    <tr <cfif (getissuetemp.currentrow mod 2) eq 0>style="background-color:##33FFFF"</cfif> onMouseOut="javascript:this.style.backgroundColor='<cfif (getissuetemp.currentrow mod 2) eq 0>33FFFF</cfif>';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
                        <td nowrap>#getissuetemp.currentrow#</td>
                        <td nowrap>#getissuetemp.itemno#</td>
                        <td nowrap>#getissuetemp.desp#</td>
                        <td nowrap>
                        #getissuetemp.qty#
                        <input type="button" name="issbatchbtn" id="issbatchbtn" value="B" onClick="document.getElementById('issbatchtrancode').value='#getissuetemp.trancode#';ColdFusion.Window.show('issbatch');" >
                        </td>
                        
                        <td nowrap>#getissuetemp.price#</td>
                        <td nowrap>#getissuetemp.amt#</td>
                        <td>
                        <cfinput type="button" name="deletebtn#getissuetemp.trancode#" id="deletebtn#getissuetemp.trancode#" onClick="if(confirm('Are You Sure You Want To Delete?')){deleterow('#getissuetemp.trancode#')}" value="#words[805]#"/>
                        </td>
                    </tr>
                    </cfloop>
                </table>
            </div>
            </td>
            <td>&nbsp;</td>
            <td colspan="2">
            <div id="receivebodyajax">
                <table>
                    <tr>
                        <th>#words[58]#</th>
                        <th>#words[120]#</th>
                        <th>#words[65]#</th>
                        <th>#words[1121]#</th>
                        <th>#words[1096]#</th>
                        <th>#words[1097]#</th>
                        <th nowrap>#words[10]#</th>
                    </tr>
                    <cfquery name="getreceivetemp" datasource="#dts#">
                        SELECT * 
                        FROM receivetemp 
                        WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
                        ORDER BY trancode DESC
                    </cfquery>
                    <cfloop query="getreceivetemp">
                    <tr <cfif (getreceivetemp.currentrow mod 2) eq 0>style="background-color:##33FFFF"</cfif> onMouseOut="javascript:this.style.backgroundColor='<cfif (getreceivetemp.currentrow mod 2) eq 0>33FFFF</cfif>';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
                        <td nowrap>#getreceivetemp.currentrow#</td>
                        <td nowrap>#getreceivetemp.itemno#</td>
                        <td nowrap>#getreceivetemp.desp#</td>
                        <td nowrap>#getreceivetemp.qty#</td>
                        <td nowrap>#getreceivetemp.price#</td>
                        <td nowrap>#getreceivetemp.amt#</td>
                        <td><cfinput type="button" name="deletebtn#getreceivetemp.trancode#" id="deletebtn#getreceivetemp.trancode#" onClick="if(confirm('Are You Sure You Want To Delete?')){deleterow2('#getreceivetemp.trancode#')}" value="#words[805]#"/></td>
                    </tr>
                    </cfloop>
                </table>
            </div>
            </td>
        </tr>
        <tr>
            <td colspan="100%" align="center">
            <cfinput type="button" name="subbtn" id="subbtn" value="#words[1104]#" onClick="validformfield();">
            </td>
        </tr>
  	</table>
</cfoutput>
</cfform>
<cfwindow center="true" width="700" height="500" name="searchitem" refreshOnShow="true" closable="true" modal="false" title="Search Item" initshow="false"
        source="searchitem.cfm?reftype={searchitemtype}" />
<cfwindow center="true" width="700" height="500" name="searchitem2" refreshOnShow="true" closable="true" modal="false" title="Search Item" initshow="false"
        source="searchitem2.cfm?reftype={searchitemtype}" />
<cfwindow center="true" width="700" height="500" name="issbatch" refreshOnShow="true" closable="true" modal="false" title="Issue Batch" initshow="false"
        source="issdissemble_batch.cfm?uuid={uuid}&trancode={issbatchtrancode}" />

<cfwindow center="true" width="700" height="500" name="rcbatch" refreshOnShow="true" closable="true" modal="false" title="Receive Batch" initshow="false"
        source="rcdissemble_batch.cfm?uuid={uuid}&trancode={rcbatchtrancode}" />
<cfwindow center="true" width="700" height="500" name="rcserial" refreshOnShow="true" closable="true" modal="false" title="Receive Serial" initshow="false"
        source="serial.cfm?uuid={uuid}&trancode={rcserialtrancode}" />
</body>
</html>