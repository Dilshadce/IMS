<html>
<head>
	<title>Maintenance Package</title>
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

<script type="text/javascript">

	function getitemdetail(detailitemno)
	{
	if(detailitemno.indexOf('*') != -1)
	{
	var thisitemno = detailitemno.split('*');
	document.getElementById('itemno').value=thisitemno[1];
	document.getElementById('qty_bil').value=thisitemno[0];
	detailitemno=thisitemno[1];
	}
	if(trim(document.getElementById('itemno').value) != "")
	{
    var urlloaditemdetail = 'addItemAjax.cfm?itemno='+escape(encodeURI(detailitemno));
	<!---alert('1');
	ajaxFunction(document.getElementById('itemDetailfield'),urlloaditemdetail);
	alert('2');--->
	 new Ajax.Request(urlloaditemdetail,
      {
        method:'get',
        onSuccess: function(getdetailback){
		document.getElementById('itemDetailfield').innerHTML = trim(getdetailback.responseText);
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
	
	function updaterow(rowno)
	{
		var varcoltype = 'coltypelist'+rowno;
		var varqtylist = 'qtylist'+rowno;
		var packcode = document.getElementById('packcode').value;
		var coltypedata = document.getElementById(varcoltype).value;
		var qtylistdata = document.getElementById(varqtylist).value;
		var updateurl = 'updaterow.cfm?packcode='+escape(packcode)+'&coltype='+escape(coltypedata)+'&qty='+escape(qtylistdata)+'&trancode='+rowno;
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

		var packcode = document.getElementById('packcode').value;

		var updateurl = 'deleterow.cfm?packcode='+escape(packcode)+'&trancode='+rowno;
		<!---ajaxFunction(document.getElementById('ajaxFieldPro'),updateurl);--->
		new Ajax.Request(updateurl,
      {
        method:'get',
        onSuccess: function(getdetailback){
		document.getElementById('ajaxFieldPro').innerHTML = trim(getdetailback.responseText);
        },
        onFailure: function(){ 
		alert('Error Delete Item'); },		
		
		onComplete: function(transport){
		document.getElementById('grossamt').value=document.getElementById('hidsubtotal').value;
		refreshlist();
        }
      })
		
	}
	
	var opt = 'Width=500px, Height=250px, Top=300px, left=400px, scrollbars=yes, status=no, resizable=1';
	
	var t1;
	var t2;

	function getfocus()
	{	
	t1 = setTimeout("document.getElementById('custno1').focus();",750);
	}
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
		
	function updateVal()
	{
	var validdesp = unescape(document.getElementById('desphid').value);
	
	if (validdesp == "itemisnoexisted")
	{
	document.getElementById('btn_add').value = "Item No Existed";
	document.getElementById('btn_add').disabled = true; 
	alert('Item Not Found');
	}
	else
	{
	try
	{
	document.getElementById('itemno').value = unescape(decodeURI(document.getElementById('replaceitemno').value));
	}
	catch(err)
	{
	}
	document.getElementById('itemdesp').value = unescape(decodeURI(document.getElementById('desphid').value));
	document.getElementById('price_bil').value = document.getElementById('pricehid').value;
	document.getElementById('btn_add').value = "Add";
	document.getElementById('btn_add').disabled = false; 
	}
	calamtadvance();
	
	if(document.getElementById('btn_add').value == "Add")
	{
	
	}
	}
	
	function caldisamt()
	{
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
	
	function calamtadvance()
	{
	var qty_bil = trim(document.getElementById('qty_bil').value);
	var expprice = trim(document.getElementById('price_bil').value);
	var expdis = trim(document.getElementById('disamt_bil').value);
	qty_bil = qty_bil * 1;
	expprice = expprice * 1;
	expdis = expdis * 1;
	var itemamt = (qty_bil * expprice) - expdis;
	document.getElementById('amt_bil').value =  itemamt.toFixed(2);
	}
	
	function trim(strval)
	{
	return strval.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	}
	
	
	function addItemAdvance()
	{
	document.getElementById('packcode').readOnly=true;
	<cfoutput>
	var itemno=encodeURI(trim(document.getElementById('itemno').value));
	var desp = encodeURI(document.getElementById('desp').value);
	var itemdesp = encodeURI(document.getElementById('itemdesp').value);
	var itemdespa = encodeURI(document.getElementById('itemdespa').value);
	var amt_bil = trim(document.getElementById('amt_bil').value);
	var qty_bil = trim(document.getElementById('qty_bil').value);
	var price_bil = trim(document.getElementById('price_bil').value);
	var packcode = trim(document.getElementById('packcode').value);
	var dispec1 = trim(document.getElementById('dispec1').value);
	var dispec2 = trim(document.getElementById('dispec2').value);
	var dispec3 = trim(document.getElementById('dispec3').value);
	var disamt_bil = trim(document.getElementById('disamt_bil').value);
	var ajaxurl = 'addproductsAjax.cfm?itemno='+escape(itemno)+'&desp='+escape(desp)+'&itemdesp='+escape(itemdesp)+'&itemdespa='+escape(itemdespa)+'&amt_bil='+escape(amt_bil)+'&qty_bil='+escape(qty_bil)+'&price_bil='+escape(price_bil)+'&packcode='+escape(packcode)+'&dispec1='+escape(dispec1)+'&dispec2='+escape(dispec2)+'&dispec3='+escape(dispec3)+'&disamt_bil='+escape(disamt_bil);
	
	<!---ajaxFunction(document.getElementById('ajaxFieldPro'),ajaxurl);--->
	 new Ajax.Request(ajaxurl,
      {
        method:'get',
        onSuccess: function(getdetailback){
		document.getElementById('ajaxFieldPro').innerHTML = trim(getdetailback.responseText);
        },
        onFailure: function(){ 
		alert('Error Add Item'); },		
		
		onComplete: function(transport){
		document.getElementById('grossamt').value=document.getElementById('hidsubtotal').value;
		clearformadvance();
		refreshlist();
        }
      })

	</cfoutput>
	}
	
	function clearformadvance()
	{
		
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
	

	
	function refreshlist()
	{
	ajaxFunction(document.getElementById('itemlist'),'getBody.cfm?packcode='+document.getElementById('packcode').value);
	}
	
	
	function getlocationbal(itemnobal)
	{
	  var urlloaditembal = 'balonhand.cfm?itemno='+encodeURI(itemnobal)+'&location='+escape(document.getElementById('locationfr').value);
	
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

	

	
	function addOption(selectbox,text,value )
	{
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
	<cfoutput>
	function addnewitem2()
	{
	if(document.getElementById('amt_bil').value=='NaN')
	{
	alert('Error in Qty / Price / Discount / Amt');
	return false;
	}
	calamtadvance();
	if(trim(document.getElementById('packcode').value) != ''){
	addItemControl();
	}
	else{
	alert('Please key in package Code');
	}
	}
	
	function addItemControl()
	{
	var itemno = document.getElementById('itemno').value;
	var qtyser = document.getElementById('qty_bil').value;
	
	if (itemno == "")
	{
	alert("Please select item");
	}
	else
	{
	addItemAdvance();
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
	
    </script>


</head>

<body>
<cfoutput>
	<cfswitch expression="#url.type#">
		<cfcase value="Edit,Delete" delimiters=",">
			<cfquery name="getPackage" datasource="#dts#">
				select * from package where packcode = '#url.packcode#'
			</cfquery>
		</cfcase>
	</cfswitch>

	<cfswitch expression="#url.type#">
		<cfcase value="Edit">
         <cfset packcode='#url.packcode#'>
			<cfset mode="Edit">
			<cfset title="Edit Package">
			<cfset button="Edit">
		</cfcase>
		<cfcase value="Delete">
         <cfset packcode='#url.packcode#'>
			<cfset mode="Delete">
			<cfset title="Delete Package">
			<cfset button="Delete">
		</cfcase>
		<cfcase value="Create">
        
        <cfset packcode=''>
			<cfset mode="Create">
			<cfset title="Create Package">
			<cfset button="Create">
		</cfcase>
	</cfswitch>

	<h1>#title#</h1>
	<h4>
	<cfif getpin2.h1F10 eq 'T'><a href="Packagetable2.cfm?type=Create">Creating A Package Area</a> </cfif>
	<cfif getpin2.h1F20 eq 'T'>|| <a href="Packagetable.cfm">List All Package</a> </cfif>
	<cfif getpin2.h1F30 eq 'T'>|| <a href="s_Packagetable.cfm?type=icPackage">Search For Package</a></cfif>
    
    
    <cfif getpin2.h1630 eq 'T'>|| <a href="p_Package.cfm">Package Listing</a></cfif></h4>

	<cfform name="Packageform" action="Packagetableprocess.cfm" method="post">
    	<input type="hidden" name="mode" value="#mode#">

		<h1 align="center">Package File Maintenance</h1>

		<table align="center" class="data" width="500">
      		<tr>
        		<td width="100">Package :</td>
        		<td>
				<cfif mode eq "Delete" or mode eq "Edit">
            		<cfinput type="text" size="12" name="packcode" value="#getPackage.packcode#" readonly>
            	<cfelse>
            		<cfinput type="text" size="12" name="packcode" required="yes" maxlength="12">
          		</cfif>
				</td>
      		</tr>
      		<tr>
        		<td>Description:</td>
        		<td><cfif mode eq "Delete" or mode eq "Edit">
						<cfinput type="text" size="40" name="desp" required="no" value="#getPackage.packdesp#" maxlength="40">
					<cfelse>
						<cfinput type="text" size="40" name="desp" required="no" maxlength="40">
					</cfif>
				</td>
      		</tr>
            <tr>
        		<td>Total Amount:</td>
        		<td><cfif mode eq "Delete" or mode eq "Edit">
						<cfinput type="text" size="40" name="grossamt" required="no" value="#getPackage.grossamt#" maxlength="40">
					<cfelse>
						<cfinput type="text" size="40" name="grossamt" required="no" maxlength="40">
					</cfif>
				</td>
      		</tr>
            <tr>
            <td colspan="100%"><hr></td>
            </tr>
            <tr>
            <td>Item No</td>
            <td><cfinput type="text" name="itemno" id="itemno" size="26" onBlur="this.value = this.value.split('___', 1);getitemdetail(this.value);" autosuggest="cfc:itemno.findItem({cfautosuggestvalue},'#dts#')" autosuggestminlength="1"/>
<input type="button" id="searchitembtn" onClick="ColdFusion.Window.show('searchitem');getfocus2();" value="Search" align="right" /><div id="itemDetailfield"></div><div id="ajaxFieldPro"></div></td>
            </tr>
            <tr>
            <td>Description</td>
            <td><cfinput type="text" name="itemdesp" id="itemdesp" value="" size="70" maxlength="100"></td>
            </tr>
            <tr>
            <td></td>
            <td><cfinput type="text" name="itemdespa" id="itemdespa" value="" size="70" maxlength="100"></td>
            </tr>
            <tr>
            <td>Quantity</td>
            <td><cfinput type="text" name="qty_bil" id="qty_bil" value="1" onKeyUp="calamtadvance();"></td>
            </tr>
            <tr>
            <td>Price</td>
            <td><cfinput type="text" name="price_bil" id="price_bil" value="0.00" onKeyUp="calamtadvance();"></td>
            </tr>
            <tr>
            <td>Discount</td>
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
            <td>Amount</td>
            <td><cfinput type="text" name="amt_bil" id="amt_bil" value="" readonly="yes"></td>
            
            </tr>
            <tr><td align="center" colspan="100%"><input name="btn_add" style="font: medium bolder" id="btn_add" type="button" value="Add" onClick="addnewitem2();"></td></tr>
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
			<th width="2%">No</th>
			<th width="15%">Item Code</th>
			<th width="30%">Description</th>
			<th width="10%">Quantity</th>
			<th width="8%">Price</th>
			<th width="8%">Discount</th>
			<th width="8%">Amount</th>
			<th width="10%">Action</th>
			</tr>
<cfquery name="getictrantemp" datasource="#dts#">
SELECT * FROM packdet WHERE packcode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#packcode#"> order by trancode desc
</cfquery>
<cfloop query="getictrantemp">
<tr <cfif (getictrantemp.currentrow mod 2) eq 0>style="background-color:##33FFFF"</cfif> onMouseOut="javascript:this.style.backgroundColor='<cfif (getictrantemp.currentrow mod 2) eq 0>33FFFF</cfif>';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
<td nowrap>#getictrantemp.currentrow#</td>
<td nowrap>#getictrantemp.itemno#</td>
<td nowrap>#getictrantemp.desp#</td>
<td nowrap>
</td>
<td nowrap align="right">#val(getictrantemp.qty_bil)#</td>
<td nowrap align="right">#numberformat(val(getictrantemp.price_bil),',.__')#</td>
<td nowrap align="right">#numberformat(val(getictrantemp.disamt_bil),',.__')#</td>
<td nowrap align="right">#numberformat(val(getictrantemp.amt_bil),',.__')#</td>
<td nowrap><input type="button" name="deletebtn#getictrantemp.trancode#" id="deletebtn#getictrantemp.trancode#" onClick="if(confirm('Are You Sure You Want To Delete?')){deleterow('#getictrantemp.trancode#')}" value="DELETE"/>&nbsp;<img id="updatebtn#getictrantemp.trancode#" name="updatebtn#getictrantemp.trancode#" src="/images/tick.gif" width="15" height="15" style="cursor:pointer; display:none;"><!--- &nbsp;&nbsp;<input type="button" name="Updatebtn#getictrantemp.trancode#" id="updatebtn#getictrantemp.trancode#" onClick="updaterow('#getictrantemp.trancode#');" value="UPDATE" style="display:none"/> ---></td>
</tr>
</cfloop>
<cfquery name="getsumictrantemp" datasource="#dts#">
SELECT sum(qty_bil)as sumqty FROM packdet WHERE packcode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#packcode#"> order by trancode desc
</cfquery>
</table>
</div>
</td>
</tr>
            
      		<tr>
        		<td></td>
        		<td align="center"><cfinput name="submit" type="submit" value="  #button#  "></td>
      		</tr>
		</table>
	</cfform>
</body>
</cfoutput>
</html>


<cfwindow center="true" width="700" height="500" name="searchitem" refreshOnShow="true" closable="true" modal="false" title="Search Item" initshow="false"
        source="searchitem.cfm" />
