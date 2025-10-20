<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1285,1269,1088,666,668,673,185,690,665,664,188,689,667,1270,1271,147,1116,1272,1273,1274,1275,1276,1277,877,16,23,65,1278,1279,1280,1281,1282,1283,120,126,1121,1096,1097,702,1284,1241">
<cfinclude template="/latest/words.cfm">
<cfajaximport tags="cfform">
<cfajaximport tags="CFINPUT-AUTOSUGGEST"> 
<html>
<head>
	<title><cfoutput>#words[1285]#</cfoutput></title>
	<cfajaxproxy bind="javascript:getrowbill({usersgrid.type},{usersgrid.refno},{usersgrid.custno})">
    <link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
    <link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
	<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
	<script language="javascript" type="text/javascript" src="/scripts/CalendarControl.js"></script>
    <script type="text/javascript">
	function submitinvoice() {
		ColdFusion.Grid.refresh('detailgrid',false);
		ColdFusion.Window.hide('expressproduct');
	}
	function refreshgrid() {
		ColdFusion.Grid.refresh('usersgrid',false);
	}
	function updateVal() {
		var validdesp = document.getElementById('desphid').value;
		var droplist = document.getElementById('expunit');
		while (droplist.length > 0) {
			droplist.remove(droplist.length - 1);
		}
		if (validdesp == "itemisnoexisted") {
			document.getElementById('btn_add').value = "Item No Existed";
			document.getElementById('btn_add').disabled = true; 
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
			document.getElementById('desp').value = document.getElementById('desphid').value;
			document.getElementById('expunit').selectedIndex =0;
			document.getElementById('expprice').value = document.getElementById('pricehid').value;
			document.getElementById('btn_add').value = "Add";
			document.getElementById('btn_add').disabled = false; 
		}
	}
	function calamtadvance() {
		var expqty = trim(document.getElementById('expqty').value);
		var expprice = trim(document.getElementById('expprice').value);
		var expdis = trim(document.getElementById('expdis').value);
		expqty = expqty * 1;
		expprice = expprice * 1;
		expdis = expdis * 1;
		var itemamt = (expqty * expprice) - expdis;
		document.getElementById('expressamt').value =  itemamt.toFixed(2);
	}
	function caldisamt() {
		var qtydis = document.getElementById('expqtycount').value;
		var disamt = document.getElementById('expunitdis').value;
		qtydis = qtydis * 1;
		disamt = disamt * 1;
		var totaldiscount = qtydis * disamt;
		document.getElementById('expdis').value = totaldiscount.toFixed(2);
	}
	function init() {
		grid = ColdFusion.Grid.getGridObject("detailgrid");
		var gridHead = grid.getView().getHeaderPanel(true);
		var tbar = new Ext.Toolbar(gridHead);
		tbar.addButton({text:"Add Item", handler:onAdd });
	}
	function onAdd(button,event) {
		ColdFusion.Window.show('expressproduct');
	}
	function getrowbill(type,bill,custno) {
		document.getElementById('rowbill').value = bill;
		document.getElementById('rowtype').value = type;
		document.getElementById('rowcustno').value = custno;
		ColdFusion.Grid.refresh('detailgrid',false);
	}
	function getrowbill1() {
		ColdFusion.Grid.refresh('detailgrid',false);
	}
	function checkexpress(addType) {
		var expressservice=trim(document.getElementById('expressservicelist').value);
		var desp = trim(document.getElementById('desp').value);
		if (addType == "Products") {
			var expressamt = trim(document.getElementById('expqty').value);
			var expprice = trim(document.getElementById('expprice').value);
		}
		else {
			var expressamt = trim(document.getElementById('expressamt').value);
		}
		var intvalid = true;
		if (addType == "Products") {
			try {
				expressamt = expressamt * 1;
				expprice = expprice * 1;
			}
			catch(err) {
				intvalid = false;
			}
		}
		var msg = "";
		if (expressservice == "") {
			if (addType == "Products") {
				msg = msg + "-Please select a product\n";
			}
			else {
				msg = msg + "-Please select a service\n";
			}
		}
		if ( desp == "") {
			msg = msg + "-Description field is required\n";
		}
		if (addType == "Products") {
			if ( expressamt == "" || expressamt <= 0 ) {
				msg = msg + "-Quantity field is required\n";
			}
			if ( expprice == "" || expprice <= 0 ) {
				msg = msg + "-Price field is required\n";
			}
			if (intvalid == false) {
				msg = msg + "-Price or quantity field is invalid\n";
			}
			else {
				if ( expressamt == "") {
					msg = msg + "-Amount field is required\n";
				}
			}
		}
		if (expressservice == "" || desp == "" || expressamt == "" || intvalid == false) {
			alert(msg);
			return false;
		}
	}
	function addItemAdvance() {
		var validatefield = checkexpress('Products');
		if (validatefield == false) {
		}
		else {
			var expressservice=trim(document.getElementById('expressservicelist').value);
			var desp = escape(trim(document.getElementById('desp').value));
			var expressamt = trim(document.getElementById('expressamt').value);
			var expqty = trim(document.getElementById('expqty').value);
			var expprice = trim(document.getElementById('expprice').value);
			var expcomment = escape(trim(document.getElementById('expcomment').value));
			var expunit = trim(document.getElementById('expunit').value);
			var expdis = trim(document.getElementById('expdis').value);
			var tranno = document.getElementById("rowbill").value;
			var trannolen = tranno.length;
			tranno = Right(tranno,trannolen - 2);
			var ajaxurl = '/default/transaction/recurringtran/addproductsAjax.cfm?servicecode='+expressservice+'&desp='+desp+'&expressamt='+expressamt+'&expqty='+expqty+'&expprice='+expprice+'&comment='+expcomment+'&unit='+expunit+'&dis='+expdis+'&tran='+document.getElementById("rowtype").value+'&tranno='+tranno+'&custno='+document.getElementById("rowcustno").value;
			ajaxFunction(document.getElementById('ajaxFieldPro'),ajaxurl);
			clearformadvance();
		}
	}
	function Right(str, n) {
		if (n <= 0)
		   return "";
		else if (n > String(str).length)
		   return str;
		else {
		   var iLen = String(str).length;
		   return String(str).substring(iLen, iLen - n);
		}
	}
	function clearform(addType) {
		document.getElementById('expressservicelist').selectedIndex = 0;
		document.getElementById('desp').value = '';
		document.getElementById('expressamt').value = '0.00';
		if (addType == "Products") {
			document.getElementById('expqty').value = '0';
			document.getElementById('expprice').value = '0.00';
		}
	}
	function clearformadvance() {
		document.getElementById('expressservicelist').value = '';
		document.getElementById('desp').value = '';
		document.getElementById('expressamt').value = '0.00';
		document.getElementById('expqty').value = '1';
		document.getElementById('expqtycount').value = '1';
		document.getElementById('expprice').value = '0.00';
		document.getElementById('expunit').value = '';
		document.getElementById('expdis').value = '0.00';
		document.getElementById('expunitdis').value = '0.00';
		document.getElementById('expcomment').value = '';
		document.getElementById('expressservicelist').focus();
	}
	function nextIndex(thisid,id) {
		var itemno = document.getElementById('expressservicelist').value;
		if (thisid == 'expressservicelist' && itemno == '') {
		}
		else {
			if(event.keyCode==13){
				document.getElementById(''+id+'').focus();
				document.getElementById(''+id+'').select();
			}
		}
	}
	function checkstring(strText) {
		var strReplaceAll = strText;
		var intIndexOfMatch = strReplaceAll.indexOf( "%" );
		// Loop over the string value replacing out each matching
		// substring.
		while (intIndexOfMatch != -1){
			// Relace out the current instance.
			strReplaceAll = strReplaceAll.replace( "%", "925925925925" )
			// Get the index of any next matching substring.
			intIndexOfMatch = strReplaceAll.indexOf( "%" );
		}
		return strReplaceAll;
	}
	function trim(strval) {
		return strval.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	}
	</script>
    <cfset projectlist=''>
    <cfset joblist=''>
    <cfquery name="getproject" datasource="#dts#">
        SELECT source 
        FROM project 
        WHERE porj='P'
    </cfquery>
    <cfquery name="getjob" datasource="#dts#">
        SELECT source 
        FROM project 
        WHERE porj='J'
    </cfquery>
    <cfloop query="getproject">
		<cfif projectlist eq ''>
			<cfset projectlist=getproject.source>
        <cfelse>
			<cfset projectlist=projectlist&","&getproject.source>
        </cfif>
    </cfloop>
    <cfloop query="getjob">
		<cfif joblist eq ''>
			<cfset joblist=getjob.source>
        <cfelse>
			<cfset joblist=joblist&","&getjob.source>
        </cfif>
    </cfloop>
</head>
<cfoutput>
<body>
    <cfform action="process.cfm" method="post" name="form1" onsubmit="return confirm('Are you sure you want to generate?')" >
        <table width="100%">
            <tr>
                <th colspan="12">#words[1269]#</th>
            </tr>
            <tr>
                <th>#words[1088]#</th>
                <td>:</td>
                <td>
                <select name="tran" id="tran">
                    <option value="INV">#words[666]#</option>
                    <option value="QUO">#words[668]#</option>
                    <option value="SO">#words[673]#</option>
                    <option value="CS">#words[185]#</option>
                    <option value="PO">#words[690]#</option>
                    <option value="DO">#words[665]#</option>
                    <option value="RC">#words[664]#</option>
                    <option value="PR">#words[188]#</option>
                    <option value="CN">#words[689]#</option>
                    <option value="DN">#words[667]#</option>
                </select>
                </td>
                <td></td>
                <th>#words[1270]#</th>
                <td>:</td>
                <td>
                <cfselect name="billno" id="billno" bind="cfc:billno.getlist({tran},'#dts#')" bindonload="yes" value="refno" display="billdesp" />
                </td>
                <th>#words[1271]#</th>
                <td>:</td>
                <td colspan="2">
                <cfquery name="getgroup" datasource="#dts#">
                    SELECT "" AS groupid, "#words[147]#" AS desp
                    UNION ALL
                    SELECT groupid,desp 
                    FROM recurrgroup
                </cfquery>
                <cfselect name="groupid" id="groupid" query="getgroup" display="desp" value="groupid" />
                <input type="button" name="addbill" id="addbill" onClick="ajaxFunction(document.getElementById('ajaxField'),'/default/transaction/recurringtran/addbill.cfm?tran='+document.getElementById('tran').value + '&refno=' + escape(document.getElementById('billno').value)+ '&groupid=' + escape(document.getElementById('groupid').value));setTimeout('refreshgrid();',1000);" value="#words[1116]#" />
                </td>
            </tr>
            <tr>
                <td colspan="12" align="left">
                <table border="1" width="90%" align="center">
                    <tr>
                        <td>
                        <cfquery name="getgroup1" datasource="#dts#">
                            SELECT "ALL" AS groupid, "#words[1272]#" AS desp
                            UNION ALL
                            SELECT "" AS groupid, "#words[1273]#" AS desp
                            UNION ALL
                            SELECT groupid,desp 
                            FROM recurrgroup
                        </cfquery>
                        #words[1274]#:
                        <cfselect name="groupid1" id="groupid1" query="getgroup1" display="desp" value="groupid" />
                        #words[1241]#:
                        <cfselect id="filtercolumn" name="filtercolumn" bind="cfc:addbill.getBillColumns('#dts#')"
                        display="ColumnName" value="ColumnName" bindOnLoad="true" />
                        #words[1275]#:
                        <cfinput type="text" id="filter" name="filter">
                        <cfinput type="button" name="filterbutton" value="#words[1276]#" id="filterbutton" onclick="ColdFusion.Grid.refresh('usersgrid',false)">
                        </td>
                    </tr>
                    <tr>
                        <td id="gridtd" style="padding-top:10px;">
                        <cfset listyn = "Y,N">
                        <div style="min-heigh:200px;">
                            <cfgrid name="usersgrid" pagesize="10" format="html" width="1500" height="255"
                            bind="cfc:addbill.getBill({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},{filtercolumn},{filter},'#dts#',{groupid1})"
                            onchange="cfc:addbill.editBill({cfgridaction},{cfgridrow},{cfgridchanged},'#dts#','#HUserID#','#target_apvend#','#target_arcust#')" 
                            selectmode="edit" textcolor="##000000" delete="yes" deletebutton="Delete">
                                <cfgridcolumn name="wos_date" header="#words[1277]#" select="no" width="150">
                                <cfgridcolumn name="type" header="#words[877]#" width="50" select="no" >
                                <cfgridcolumn name="refno" header="#words[1270]#" width="70" select="no">
                                <cfgridcolumn name="custno" header="#words[16]# " width="80">
                                <cfgridcolumn name="name" header="#words[23]#" width="200">
                                <cfgridcolumn name="desp" header="#words[65]#" width="200">
                                <cfgridcolumn name="void" header="#words[1278]#" select="yes"  values="Y,N" >
                                <cfgridcolumn name="counter" header="#words[1279]#" select="yes">
                                <cfgridcolumn name="eInvoice_Submited" header="#words[1280]#" select="no">
                                <cfgridcolumn name="nextdate" header="#words[1281]#" select="no" width="150">
                                <cfgridcolumn name="source" header="#words[1282]#" values="#projectlist#" select="yes">
                                <cfgridcolumn name="job" header="#words[1283]#" values="#joblist#" select="yes">
                            </cfgrid>
                        </div>
                        </td>
                    </tr>
                </table>
                </td>
            </tr>
            <tr>
                <td colspan="12" align="left">
                <table border="1" width="90%" align="center">
                    <tr>
                        <td>
                        #words[1088]#:<input type="text" name="rowtype" id="rowtype" readonly size="5" />
                        &nbsp;&nbsp;
                        #words[1270]#:<input type="text" name="rowbill" id="rowbill" readonly />
                        &nbsp;&nbsp;
                        #words[16]#:<input type="text" name="rowcustno" id="rowcustno" value="" />
                        </td>
                    </tr>
                    <tr>
                        <td id="gridtd" style="padding-top:10px;">
                        <div style="min-heigh:200px;">
                            <cfgrid name="detailgrid" pagesize="7" format="html" width="1500" height="200"
                            bind="cfc:additem.getItem({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},{rowbill},{rowtype},'#dts#',{rowcustno})"
                            onchange="cfc:additem.editItem({cfgridaction},{cfgridrow},{cfgridchanged},'#dts#','#HUserID#',{rowbill},{rowtype},{rowcustno})" 
                            selectmode="edit" textcolor="##000000" delete="yes" deletebutton="Delete">
                                <cfgridcolumn name="trancode" header="ID" select="no" width="50" display="no">
                                <cfgridcolumn name="itemno" header="#words[120]#" width="150" select="no" type="string_nocase" >
                                <cfgridcolumn name="desp" header="#words[65]#" width="300">
                                <cfgridcolumn name="despa" header="#words[126]#" width="200">
                                <cfgridcolumn name="qty_bil" header="#words[1121]#" width="70">
                                <cfgridcolumn name="price_bil" header="#words[1096]#" width="100">
                                <cfgridcolumn name="amt_bil" header="#words[1097]#" width="100" select="no">
                            </cfgrid>
                        </div>
                        </td>
                    </tr>
                </table>
                </td>
            </tr>
            <tr>
                <th>#words[702]#: </th>
                <td></td>
                <td>
                    <cfinput type="text" name="date" id="date" value="#dateformat(now(),'DD/MM/YYYY')#" />
                    <img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(date);">(DD/MM/YYYY)
                </td>
                <td></td>
                <th>#words[1284]#</th>
                <td><input type="checkbox" name="generategroup" id="generategroup" value="generate"></td>
                <td>
                <cfquery name="getgroup2" datasource="#dts#">
                    SELECT "" as groupid, "#words[1273]#" as desp
                    union all
                    SELECT groupid,desp FROM recurrgroup
                </cfquery>
                <cfselect name="groupid2" id="groupid2" query="getgroup2" display="desp" value="groupid" />
                <input type="Submit" name="submitbtn" id="submitbtn" value="#words[1278]#" /></td>
                <td>&nbsp;</td>
                <td></td>
            </tr>
            <tr>
                <td colspan="12">
                <cfquery name="getrefnoset" datasource="#dts#">
                    SELECT * 
                    FROM refnoset
                </cfquery>
                <table width="100%">
                    <tr>
                        <th>#words[666]#</th>
                        <cfquery name="getinv" dbtype="query">
                            SELECT counter,lastUsedNo 
                            FROM getrefnoset 
                            WHERE type = <cfqueryparam cfsqltype="cf_sql_varchar" value="INV" >
                        </cfquery>
                        <td>
                        <cfselect query="getinv" name="invrefno" id="invrefno" value="counter" display="lastUsedNo" selected="1" />
                        </td>
                        <th>#words[668]#</th>
                        <cfquery name="getquo" dbtype="query">
                            SELECT counter,lastUsedNo 
                            FROM getrefnoset 
                            WHERE type = <cfqueryparam cfsqltype="cf_sql_varchar" value="QUO" >
                        </cfquery>
                        <td>
                        <cfselect query="getquo" name="quorefno" id="quorefno" value="counter" display="lastUsedNo" selected="1" />
                        </td>
                        <th>#words[673]#</th>
                        <cfquery name="getso" dbtype="query">
                            SELECT counter,lastUsedNo 
                            FROM getrefnoset 
                            WHERE type = <cfqueryparam cfsqltype="cf_sql_varchar" value="SO" >
                        </cfquery>
                        <td>
                        <cfselect query="getso" name="sorefno" id="sorefno" value="counter" display="lastUsedNo" selected="1" />
                        </td>
                        <th>#words[185]#</th>
                        <cfquery name="getcs" dbtype="query">
                            SELECT counter,lastUsedNo 
                            FROM getrefnoset 
                            WHERE type = <cfqueryparam cfsqltype="cf_sql_varchar" value="CS" >
                        </cfquery>
                        <td>
                        <cfselect query="getcs" name="csrefno" id="csrefno" value="counter" display="lastUsedNo" selected="1" />
                        </td>
                        <th>#words[667]#</th>
                        <cfquery name="getdn" dbtype="query">
                            SELECT counter,lastUsedNo 
                            FROM getrefnoset 
                            WHERE type = <cfqueryparam cfsqltype="cf_sql_varchar" value="DN" >
                        </cfquery>
                        <td>
                        <cfselect query="getdn" name="dnrefno" id="dnrefno" value="counter" display="lastUsedNo" selected="1" />
                        </td>
                    </tr>
                    <tr>
                        <th>#words[690]#</th>
                        <cfquery name="getpo" dbtype="query">
                            SELECT counter,lastUsedNo 
                            FROM getrefnoset 
                            WHERE type = <cfqueryparam cfsqltype="cf_sql_varchar" value="PO" >
                        </cfquery>
                        <td>
                        <cfselect query="getpo" name="porefno" id="porefno" value="counter" display="lastUsedNo" selected="1" />
                        </td>
                        <th>#words[665]#</th>
                        <cfquery name="getdo" dbtype="query">
                            SELECT counter,lastUsedNo 
                            FROM getrefnoset 
                            WHERE type = <cfqueryparam cfsqltype="cf_sql_varchar" value="DO" >
                        </cfquery>
                        <td>
                        <cfselect query="getdo" name="dorefno" id="dorefno" value="counter" display="lastUsedNo" selected="1" />
                        </td>
                        <th>#words[188]#</th>
                        <cfquery name="getpr" dbtype="query">
                            SELECT counter,lastUsedNo 
                            FROM getrefnoset 
                            WHERE type = <cfqueryparam cfsqltype="cf_sql_varchar" value="PR" >
                        </cfquery>
                        <td>
                        <cfselect query="getpr" name="prrefno" id="prrefno" value="counter" display="lastUsedNo" selected="1" />
                        </td>
                        <th>#words[664]#</th>
                        <cfquery name="getrc" dbtype="query">
                            SELECT counter,lastUsedNo 
                            FROM getrefnoset 
                            WHERE type = <cfqueryparam cfsqltype="cf_sql_varchar" value="RC" >
                        </cfquery>
                        <td>
                        <cfselect query="getrc" name="rcrefno" id="rcrefno" value="counter" display="lastUsedNo" selected="1" />
                        </td>
                        <th>#words[689]#</th>
                        <cfquery name="getcn" dbtype="query">
                            SELECT counter,lastUsedNo 
                            FROM getrefnoset 
                            WHERE type = <cfqueryparam cfsqltype="cf_sql_varchar" value="CN" >
                        </cfquery>
                        <td>
                        <cfselect query="getcn" name="cnrefno" id="cnrefno" value="counter" display="lastUsedNo" selected="1" />
                        </td>
                    </tr>
                </table>
                </td>
            </tr>
        </table>
    </cfform>
    <div id="ajaxField">
    </div>
    <cfset ewidth = "700" >
    <cfset eheight = "300" >
    <cfwindow center="true" width="#ewidth#" height="#eheight#" name="expressproduct" refreshOnShow="true" closable="false" modal="true" 
        title="Add Products" initshow="false" 
        source="/default/transaction/recurringtran/addproducts.cfm?tran={rowtype}&custno={rowcustno}&tranno={rowbill}" />
    <cfset ajaxOnLoad("init")>
</body>
</cfoutput>
</html>