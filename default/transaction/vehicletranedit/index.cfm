<cfajaximport tags="cfform">
<cfajaximport tags="cfwindow,cflayout-tab">
<cfset tran = url.tran>
<cfset refno = url.refno>

<cfsetting showdebugoutput="no">

<cfif url.tran eq 'PR' or  url.tran eq 'RC' or url.tran eq 'PO'>
<cfset dbtype=target_apvend>
<cfset dbname='Supplier'>
<cfelse>
<cfset dbtype=target_arcust>
<cfset dbname='Customer'>
</cfif>

<cfquery name="getgsetup" datasource="#dts#">
SELECT * FROM gsetup
</cfquery>

<cfquery name="getmodule" datasource="#dts#">
SELECT * from modulecontrol
</cfquery>

<cfquery name="getgsetup2" datasource="#dts#">
select * from gsetup2

</cfquery>
<cfquery name="getdealermenu" datasource="#dts#">
SELECT * FROM dealer_menu
</cfquery>

<cfquery name="getcategory" datasource="#dts#">
SELECT * FROM iccate order by cate
</cfquery>

<cfquery name="getproject" datasource="#dts#">
SELECT * FROM #target_project# where porj='P' order by source
</cfquery>

<cfquery name="getgroup" datasource="#dts#">
SELECT * FROM icgroup order by wos_group
</cfquery>

<cfquery name="getsupp" datasource="#dts#">
SELECT custno,name FROM #target_apvend# order by custno
</cfquery>

<cfquery datasource="#dts#" name="getlocation">
	select 
	location,
	desp 
	from iclocation 
    where 0=0
    <cfif (lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjctrial_i") and (HUserGrpID neq 'Cust Svr' and HUserGrpID neq 'Van Sales')>
    <cfelse>
    <cfif Huserloc neq "All_loc">
	and location='#Huserloc#'
	</cfif>
    </cfif>
	order by location;
</cfquery>


	<cfquery name='getcustremark' datasource='#dts#'>
	select * from artran where refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#"> and type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#tran#">
	</cfquery>
    
    <cfquery name='getcustremark2' datasource='#dts#'>
	select * from ictran where refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#"> and type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#tran#">
	</cfquery>
	<cfset custno = trim(getcustremark.custno)>
	<cfset zmultiagent1 = trim(getcustremark.multiagent1)>
	<cfset zterm = trim(getcustremark.term)>
	<cfset rem5 = trim(getcustremark.rem5)>
	<cfset rem6 = getcustremark.rem6>
	<cfset rem7 = getcustremark.rem7>
    <cfif isdate('#getcustremark.rem8#')>
	<cfset rem8 = dateformat(getcustremark.rem8,'DD/MM/YYYY')>
    <cfelse>
    <cfset rem8 = ''>
    </cfif>
	<cfset rem9 = getcustremark.rem9>
	<cfset rem10 = getcustremark.rem10>
	<cfset rem11 = getcustremark.rem11>
	<cfset agenno = trim(getcustremark.agenno)>
	<cfset refno2 = getcustremark.refno2>
	<cfset rem31 = getcustremark.rem31>
	<cfset rem32 = getcustremark.rem32>
	<cfset xsource = getcustremark2.source>
	<cfset xwos_group = getcustremark2.brem2>
    <cfset xnote1=getcustremark2.note1>
	<cfset coltype = getcustremark2.location>
    <cfset desp = getcustremark.desp>
    <cfset desp2 = getcustremark.despa>
	<cfset permitno = getcustremark.permitno>

<html>
<head>
<script src="/SpryAssets/SpryCollapsiblePanel.js" type="text/javascript"></script>
<link href="/SpryAssets/SpryCollapsiblePanel.css" rel="stylesheet" type="text/css" />
	<title>Simple Transaction Edit</title>
	<link href="/stylesheet/oldstylesheet.css" rel="stylesheet" type="text/css">
    <script type='text/javascript' src='/ajax/core/engine.js'></script>
    <script type='text/javascript' src='/javascripts/jsDate.js'></script>
	<script type='text/javascript' src='/ajax/core/util.js'></script>
	<script type='text/javascript' src='/ajax/core/settings.js'></script>
    <script type='text/javascript' src='/ajax/core/shortcut.js'></script>
    <script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
    <script language="javascript" type="text/javascript" src="/scripts/check_customer_code.js"></script>
    <link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
	<script language="javascript" type="text/javascript" src="/scripts/CalendarControl.js"></script>
    <script type="text/javascript" src="/scripts/prototypenew.js" ></script>
    <script type="text/javascript" src="/scripts/effects.js"></script>
	<script type="text/javascript" src="/scripts/controls.js"></script>
    
    <!---<OBJECT CLASSID="clsid:333C7BC4-460F-11D0-BC04-0080C7055A83" ID="feedcontact1" WIDTH="0" HEIGHT="0">
<PARAM NAME="FieldDelim" VALUE="|"><PARAM NAME="UseHeader" VALUE="True"></OBJECT>
<script for="feedcontact1" event="ondatasetcomplete">show_info(this.recordset);</script>--->
    <script type="text/javascript">
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

	<!---
	function findVehicle(){
		var text = document.invoicesheet.letter.value;
		if(text != ''){
			document.all.feedcontact1.dataurl="databind/act_getvehi.cfm?text=" + text;
			
			//prompt("D",document.all.feedcontact1.dataurl);
			document.all.feedcontact1.charset=document.charset;
			document.all.feedcontact1.reset();
		}
	}
	
	function show_info(rset){
		rset.MoveFirst();
		DWRUtil.removeAllOptions("rem5");
		newArray = unescape(rset.fields("vehiclelist").value);
		var vehicleArray = newArray.split(";;");
		newArray2 = unescape(rset.fields("vehicledesclist").value);
		var vehicledespArray = newArray2.split(";;");
		for(i=0;i<vehicleArray.length;i++){
			
			myoption = document.createElement("OPTION");
			if(vehicleArray[i] == '-1'){
				myoption.text = vehicledespArray[i];
			}else{
				myoption.text = vehicleArray[i];
			}
			
			myoption.value = vehicleArray[i];
			document.invoicesheet.rem5.options.add(myoption);
		}
		getvehicles();
	}--->
	
	function findVehicle(option){
			var inputtext = document.invoicesheet.letter.value;
			DWREngine._execute(_tranflocation, null, 'vehiclelookup', inputtext, option, findVehicleResult);
	}
	
	function findVehicleResult(vehicleArray){
			DWRUtil.removeAllOptions("rem5");
			DWRUtil.addOptions("rem5", vehicleArray,"KEY", "VALUE");
			getvehicles();
		}
	
	
	function validatetime(fieldid)
	{
		re = /^(\d{1,2})\/(\d{1,2})\/(\d{4}) (\d{1,2}):(\d{2})$/;
		
		
	<!---if(document.getElementById(fieldid).value != '' && !document.getElementById(fieldid).value.match(re)) {
      alert("Invalid datetime format: " + document.getElementById(fieldid).value);
      document.getElementById(fieldid).focus();
    }---->
	
	if(document.getElementById(fieldid).value != '') {
      if(regs = document.getElementById(fieldid).value.match(re)) {
        // day value between 1 and 31
        if(regs[1] < 1 || regs[1] > 31) {
          alert("Invalid value for day: " + regs[1]);
          document.getElementById(fieldid).focus();
        }
        // month value between 1 and 12
        if(regs[2] < 1 || regs[2] > 12) {
          alert("Invalid value for month: " + regs[2]);
          document.getElementById(fieldid).focus();
        }
        // year value between 1902 and 2012
        if(regs[3] < 1902 || regs[3] > 2100) {
          alert("Invalid value for year: " + regs[3] + " - must be between 1902 and 2100");
          document.getElementById(fieldid).focus();
        }
		if(regs[4] > 23) {
            alert("Invalid value for hours: " + regs[4]);
            document.getElementById(fieldid).focus();
          }
		  if(regs[5] > 59) {
          alert("Invalid value for minutes: " + regs[5]);
          document.getElementById(fieldid).focus();
        }
      } else {
        alert("Invalid date format: " + document.getElementById(fieldid).value);
        document.getElementById(fieldid).focus();
      }
	}
	}
	
	function validatedate(fieldid)
	{
		re = /^(\d{1,2})\/(\d{1,2})\/(\d{4})$/;
		
		
	
	if(document.getElementById(fieldid).value != '') {
      if(regs = document.getElementById(fieldid).value.match(re)) {
        // day value between 1 and 31
        if(regs[1] < 1 || regs[1] > 31) {
          alert("Invalid value for day: " + regs[1]);
          document.getElementById(fieldid).focus();
        }
        // month value between 1 and 12
        if(regs[2] < 1 || regs[2] > 12) {
          alert("Invalid value for month: " + regs[2]);
          document.getElementById(fieldid).focus();
        }
        // year value between 1902 and 2012
        if(regs[3] < 1902 || regs[3] > 2100) {
          alert("Invalid value for year: " + regs[3] + " - must be between 1902 and 2100" );
          document.getElementById(fieldid).focus();
        }
      } else {
        alert("Invalid date format: " + document.getElementById(fieldid).value);
        document.getElementById(fieldid).focus();
      }
	}
	}
	
	function fillsearch(custno,name,contact,add1,add2,add3)
	{
		document.getElementById('memberidsearch').value=unescape(custno);
		document.getElementById('membernamesearch').value=unescape(name);
		document.getElementById('membertelsearch').value=unescape(contact);
		document.getElementById('memberadd1search').value=unescape(add1);
		document.getElementById('memberadd2search').value=unescape(add2);
		document.getElementById('memberadd3search').value=unescape(add3);
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
	
	function getCustSupp2(custno,custname){
				myoption = document.createElement("OPTION");
				myoption.text = custno + " - " + custname;
				myoption.value = custno;
				document.invoicesheet.custno.options.add(myoption);
				var indexvalue = document.getElementById("custno").length-1;
				document.getElementById("custno").selectedIndex=indexvalue;
				
				myoption = document.createElement("OPTION");
				myoption.text = custno + " - " + custname;
				myoption.value = custno;
				document.invoicesheet.permitno.options.add(myoption);
				var indexvalue = document.getElementById("permitno").length-1;
				document.getElementById("permitno").selectedIndex=indexvalue;
				
				updateDetails(document.invoicesheet.custno[indexvalue].value);
		}
		
	function getCustSupp3(custno,custname){
				myoption = document.createElement("OPTION");
				myoption.text = custno + " - " + custname;
				myoption.value = custno;
				document.invoicesheet.headersupp.options.add(myoption);
				var indexvalue = document.getElementById("headersupp").length-1;
				document.getElementById("headersupp").selectedIndex=indexvalue;
		}
		
	function getvehicle2(vehino){
		document.getElementById("letter").value=vehino;
		findVehicle('0');
		<!---
				myoption = document.createElement("OPTION");
				myoption.text = vehino;
				myoption.value = vehino;
				document.invoicesheet.rem5.options.add(myoption);
				var indexvalue = document.getElementById("rem5").length-1;
				document.getElementById("rem5").selectedIndex=indexvalue;--->
				getvehicles();
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
			<!---DWRUtil.setValue("agenthid", CustSuppObject.AGENT);--->
			<!---DWRUtil.setValue("termhid", CustSuppObject.TERM);--->
			DWRUtil.setValue("driverhid", CustSuppObject.END_USER);
			DWRUtil.setValue("currcodehid", CustSuppObject.CURRCODE);
			DWRUtil.setValue("currrate", CustSuppObject.CURRRATE);
	<!---selectOptionByValue(document.getElementById('agent'),document.getElementById('agenthid').value);
	selectOptionByValue(document.getElementById('term'),document.getElementById('termhid').value);--->
	selectOptionByValue(document.getElementById('driver'),document.getElementById('driverhid').value);
				DWRUtil.setValue("d_name", CustSuppObject.D_NAME);		
				DWRUtil.setValue("d_name2", CustSuppObject.D_NAME2);
				DWRUtil.setValue("d_add1", CustSuppObject.D_ADD1);
				DWRUtil.setValue("d_add2", CustSuppObject.D_ADD2);
				DWRUtil.setValue("d_add3", CustSuppObject.D_ADD3);
				DWRUtil.setValue("d_add4", CustSuppObject.D_ADD4);
				DWRUtil.setValue("d_attn", CustSuppObject.D_ATTN);
				DWRUtil.setValue("d_phone", CustSuppObject.D_PHONE);
				DWRUtil.setValue("d_fax", CustSuppObject.D_FAX);
			if (CustSuppObject.TAXINCLUDED == 'T')
			{
			document.getElementById('taxincl').checked = true;
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
	
	function updateremark()
	{
	document.getElementById('d_name').value=document.getElementById('delname').value;
	document.getElementById('d_name2').value=document.getElementById('delname2').value;
	document.getElementById('d_add1').value=document.getElementById('deladd1').value;
	document.getElementById('d_add2').value=document.getElementById('deladd2').value;
	document.getElementById('d_add3').value=document.getElementById('deladd3').value;
	document.getElementById('d_add4').value=document.getElementById('deladd4').value;
	document.getElementById('d_attn').value=document.getElementById('delattn').value;
	document.getElementById('d_phone').value=document.getElementById('deltel').value;
	document.getElementById('d_fax').value=document.getElementById('delfax').value;
	document.getElementById('rem6').value=document.getElementById('hidrem6').value;
	document.getElementById('rem7').value=document.getElementById('hidrem7').value;
	document.getElementById('rem8').value=document.getElementById('hidrem8').value;
	document.getElementById('rem9').value=document.getElementById('hidrem9').value;
	document.getElementById('rem10').value=document.getElementById('hidrem10').value;
	document.getElementById('rem11').value=document.getElementById('hidrem11').value;
	document.getElementById('rem30').value=document.getElementById('hidrem30').value;
	}
	
	function updateremark2()
	{
	if (document.getElementById('d_name').value !=''){
	document.getElementById('delname').value=document.getElementById('d_name').value;
	}
	if (document.getElementById('d_name2').value !=''){
	document.getElementById('delname2').value=document.getElementById('d_name2').value;
	}
	if (document.getElementById('d_add1').value !=''){
	document.getElementById('deladd1').value=document.getElementById('d_add1').value;
	}
	if (document.getElementById('d_add2').value !=''){
	document.getElementById('deladd2').value=document.getElementById('d_add2').value;
	}
	if (document.getElementById('d_add3').value !=''){
	document.getElementById('deladd3').value=document.getElementById('d_add3').value;
	}
	if (document.getElementById('d_add4').value !=''){
	document.getElementById('deladd4').value=document.getElementById('d_add4').value;
	}
	if (document.getElementById('d_attn').value !=''){
	document.getElementById('delattn').value=document.getElementById('d_attn').value;
	}
	if (document.getElementById('d_phone').value !=''){
	document.getElementById('deltel').value=document.getElementById('d_phone').value;
	}
	if (document.getElementById('d_fax').value !=''){
	document.getElementById('delfax').value=document.getElementById('d_fax').value;
	}
	if (document.getElementById('rem6').value !=''){
	document.getElementById('hidrem6').value=document.getElementById('rem6').value;
	}
	if (document.getElementById('rem7').value !=''){
	document.getElementById('hidrem7').value=document.getElementById('rem7').value;
	}
	if (document.getElementById('rem8').value !=''){
	document.getElementById('hidrem8').value=document.getElementById('rem8').value;
	}
	if (document.getElementById('rem9').value !=''){
	document.getElementById('hidrem9').value=document.getElementById('rem9').value;
	}
	if (document.getElementById('rem10').value !=''){
	document.getElementById('hidrem10').value=document.getElementById('rem10').value;
	}
	if (document.getElementById('rem11').value !=''){
	document.getElementById('hidrem11').value=document.getElementById('rem11').value;
	}
	if (document.getElementById('rem30').value !=''){
	document.getElementById('hidrem30').value=document.getElementById('rem30').value;
	}

	}
	
	
function selectmemberlist(custno){	
	for (var idx=0;idx<document.getElementById('custno').options.length;idx++) {
		if (custno==document.getElementById('custno').options[idx].value) {
		document.getElementById('custno').options[idx].selected=true;
		}
	} 
	
	for (var idx=0;idx<document.getElementById('permitno').options.length;idx++) {
		if (custno==document.getElementById('permitno').options[idx].value) {
		document.getElementById('permitno').options[idx].selected=true;
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
	function updaterow(rowno)
	{
		var varcoltype = 'coltypelist'+rowno;
		var varqtylist = 'qtylist'+rowno;
		var brem4 = 'brem4'+rowno;
		var brem1 = 'brem1'+rowno;
		var cate = 'catelist'+rowno;
		var supp = 'supplist'+rowno;
		var wos_group = 'grouplist'+rowno;
		var nodisplay = 'nodisplaylist'+rowno;
		var subtotaldisplay = 'subtotallist'+rowno;
		
		var deductitem = 'deductitemlist'+rowno;
		<cfoutput>
		var refno = '#refno#';
		var tran = '#tran#';
		</cfoutput>
		var coltypedata = document.getElementById(varcoltype).value;
		var qtylistdata = document.getElementById(varqtylist).value;
		var brem4data = document.getElementById(brem4).value;
		var brem1data = document.getElementById(brem1).value;
		var catedata = document.getElementById(cate).value;
		var suppdata = document.getElementById(supp).value;
		var groupdata = document.getElementById(wos_group).value;
		var nodisplaydata = document.getElementById(nodisplay).value;
		var subtotaldata = document.getElementById(subtotaldisplay).value;
		var deductitemdata = document.getElementById(deductitem).value;
		
		var updownposition = document.getElementById('updownposition').value;
		var updateurl = 'updaterow.cfm?tran='+escape(tran)+'&refno='+escape(refno)+'&qty='+escape(qtylistdata)+'&trancode='+rowno+'&brem4='+escape(brem4data)+'&updown='+escape(updownposition)+'&brem1='+escape(brem1data)+'&cate='+escape(catedata)+'&group='+escape(groupdata)+'&supp='+escape(suppdata)+'&nodisplay='+escape(nodisplaydata)+'&subtotal='+escape(subtotaldata)+'&deductitem='+escape(deductitemdata)+'&coltype='+escape(coltypedata);
		
		
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
		<cfoutput>
		var refno = '#refno#';
		var tran = '#tran#';
		</cfoutput>
		var updateurl = 'deleterow.cfm?tran='+escape(tran)+'&refno='+escape(refno)+'&trancode='+rowno;
		new Ajax.Request(updateurl,
      {
        method:'get',
        onSuccess: function(getdetailback){
		document.getElementById('ajaxFieldPro').innerHTML = trim(getdetailback.responseText);
        },
        onFailure: function(){ 
		alert('Error Delete Item'); },		
		
		onComplete: function(transport){
		calculatefooter();
		refreshlist();
        }
      })
		
	}
	
	function gopay(payname)
	{
	var itemcount = 0;
			try{
				itemcount = document.getElementById('totalrealqty').value * 1;
			}
			catch(err)
			{
			}
			if(itemcount != 0 )
			{
				ColdFusion.Window.show(payname);
			}	
			
	}
	function submitpay()
	{
		var paytypeno = document.getElementById('paytype').value;
		var cashamt = parseFloat(document.getElementById('paycash'+paytypeno).value);
		if(document.getElementById('paycash'+paytypeno).value == ""){cashamt = 0;}
		var cc1amt = parseFloat(document.getElementById('cc1'+paytypeno).value);
		if(document.getElementById('cc1'+paytypeno).value == ""){cc1amt = 0;}
		var cc2amt = parseFloat(document.getElementById('cc2'+paytypeno).value);
		if(document.getElementById('cc2'+paytypeno).value == ""){cc2amt = 0;}
		var dbcamt = parseFloat(document.getElementById('dbc'+paytypeno).value);
		if(document.getElementById('dbc'+paytypeno).value == ""){dbcamt = 0;}
		var cheqamt = parseFloat(document.getElementById('cheq'+paytypeno).value);
		if(document.getElementById('cheq'+paytypeno).value == ""){cheqamt = 0;}
		var voucheramt = parseFloat(document.getElementById('voucheramt'+paytypeno).value);
		if(document.getElementById('voucheramt'+paytypeno).value == ""){voucheramt = 0;}
		var depositamt = parseFloat(document.getElementById('depositamt'+paytypeno).value);
		if(document.getElementById('depositamt'+paytypeno).value == ""){depositamt = 0;}
		var cashcamt = parseFloat(document.getElementById('cashc'+paytypeno).value);
		if(document.getElementById('cashc'+paytypeno).value == ""){cashcamt = 0;}
		if (paytypeno == 5)
		{
			document.getElementById('cctype').value=getCheckedValue(document.ccform5.cctype15);
			document.getElementById('cctype2').value=getCheckedValue(document.ccform5.cctype25);
			document.getElementById('checkno').value=document.getElementById('chequeno5').value;
		}
		if (paytypeno == 6)
		{
			document.getElementById('custno').value=document.getElementById('custno6').value;
			<cfoutput>
			document.getElementById('tran').value="#url.tran#";
			</cfoutput>
			document.getElementById('refno').value=document.getElementById('refnoinv').value;
			document.getElementById('cctype').value=getCheckedValue(document.ccform6.cctype16);
			document.getElementById('cctype2').value=getCheckedValue(document.ccform6.cctype26);
			document.getElementById('checkno').value=document.getElementById('chequeno6').value;
			document.getElementById('realdeposit').value=document.getElementById('depositno').value;
		}
		try{
		document.getElementById('cctype').value=getCheckedValue(document.ccform.cctype1);
		}
		catch(err)
		{
		}
		try{
		document.getElementById('checkno').value=document.getElementById('chequeno').value;
		}
		catch(err)
		{
		}
		document.invoicesheet.cash.value = cashamt;
		document.invoicesheet.credit_card1.value=cc1amt;
		document.invoicesheet.credit_card2.value=cc2amt;
		document.invoicesheet.debit_card.value=dbcamt;
		document.invoicesheet.cheque.value=cheqamt;
		document.invoicesheet.voucher.value=voucheramt;
		document.invoicesheet.deposit.value=depositamt;
		document.invoicesheet.cashcamt.value=cashcamt;
		document.invoicesheet.changeamt1.value=parseFloat(document.getElementById('change'+paytypeno).value);
		<!--- document.getElementById('rem9').value=document.getElementById('rem9desp'+paytypeno).value; --->
		document.invoicesheet.submit();
	}
	function calculatetotal(e,nextflow,upflow)
	{
		var paytypeno = document.getElementById('paytype').value;
<!--- 		if(nextflow != "")
		{
		nextflow = nextflow +paytypeno;
		}
		if(upflow != ""){
		upflow = upflow + +paytypeno;
		} --->
		var gtamt = parseFloat(document.getElementById('hidgt'+paytypeno).value);
		var cashamt = parseFloat(document.getElementById('paycash'+paytypeno).value);
		if(document.getElementById('paycash'+paytypeno).value == ""){cashamt = 0;}
		var cc1amt = parseFloat(document.getElementById('cc1'+paytypeno).value);
		if(document.getElementById('cc1'+paytypeno).value == ""){cc1amt = 0;}
		var cc2amt = parseFloat(document.getElementById('cc2'+paytypeno).value);
		if(document.getElementById('cc2'+paytypeno).value == ""){cc2amt = 0;}
		var dbcamt = parseFloat(document.getElementById('dbc'+paytypeno).value);
		if(document.getElementById('dbc'+paytypeno).value == ""){dbcamt = 0;}
		var cheqamt = parseFloat(document.getElementById('cheq'+paytypeno).value);
		if(document.getElementById('cheq'+paytypeno).value == ""){cheqamt = 0;}
		var voucheramt = parseFloat(document.getElementById('voucheramt'+paytypeno).value);
		if(document.getElementById('voucheramt'+paytypeno).value == ""){voucheramt = 0;}
		var depositamt = parseFloat(document.getElementById('depositamt'+paytypeno).value);
		if(document.getElementById('depositamt'+paytypeno).value == ""){depositamt = 0;}
		var cashcamt = parseFloat(document.getElementById('cashc'+paytypeno).value);
		if(document.getElementById('cashc'+paytypeno).value == ""){cashcamt = 0;}
		var payamt = cashamt + cc1amt + cc2amt + dbcamt + cheqamt + voucheramt + depositamt + cashcamt;
		 if(e.keyCode==40 && nextflow != "" && paytypeno == '5'){
		document.getElementById(nextflow).focus();
		document.getElementById(nextflow).select();
		}
		else if(e.keyCode==38 && upflow != "" && paytypeno == '5'){
		document.getElementById(upflow).focus();
		document.getElementById(upflow).select();
		}
		else{
		document.getElementById('payamt'+paytypeno).value=payamt;
		document.getElementById('change'+paytypeno).value=(payamt-gtamt).toFixed(2);
		if(gtamt <= payamt)
		{
			document.getElementById('balanceamt'+paytypeno).value="0.00";
		}
		else
		{
			document.getElementById('balanceamt'+paytypeno).value=(gtamt-payamt).toFixed(2);
		}
		}
	}
	
	function calculatetotal2()
	{
		var paytypeno = document.getElementById('paytype').value;
		var gtamt = parseFloat(document.getElementById('hidgt'+paytypeno).value);
		var cashamt = parseFloat(document.getElementById('paycash'+paytypeno).value);
		if(document.getElementById('paycash'+paytypeno).value == ""){cashamt = 0;}
		var cc1amt = parseFloat(document.getElementById('cc1'+paytypeno).value);
		if(document.getElementById('cc1'+paytypeno).value == ""){cc1amt = 0;}
		var cc2amt = parseFloat(document.getElementById('cc2'+paytypeno).value);
		if(document.getElementById('cc2'+paytypeno).value == ""){cc2amt = 0;}
		var dbcamt = parseFloat(document.getElementById('dbc'+paytypeno).value);
		if(document.getElementById('dbc'+paytypeno).value == ""){dbcamt = 0;}
		var cheqamt = parseFloat(document.getElementById('cheq'+paytypeno).value);
		if(document.getElementById('cheq'+paytypeno).value == ""){cheqamt = 0;}
		var voucheramt = parseFloat(document.getElementById('voucheramt'+paytypeno).value);
		if(document.getElementById('voucheramt'+paytypeno).value == ""){voucheramt = 0;}
		var depositamt = parseFloat(document.getElementById('depositamt'+paytypeno).value);
		if(document.getElementById('depositamt'+paytypeno).value == ""){depositamt = 0;}
		var cashcamt = parseFloat(document.getElementById('cashc'+paytypeno).value);
		if(document.getElementById('cashc'+paytypeno).value == ""){cashcamt = 0;}
		var payamt = cashamt + cc1amt + cc2amt + dbcamt + cheqamt + voucheramt + depositamt + cashcamt;
		document.getElementById('payamt'+paytypeno).value=payamt;
		document.getElementById('change'+paytypeno).value=(payamt-gtamt).toFixed(2);
		if(gtamt <= payamt)
		{
			document.getElementById('balanceamt'+paytypeno).value="0.00";
		}
		else
		{
			document.getElementById('balanceamt'+paytypeno).value=(gtamt-payamt).toFixed(2);
		}
	}
	
	
	var opt = 'Width=500px, Height=250px, Top=300px, left=400px, scrollbars=yes, status=no, resizable=1';
	
	
	function setunitprice()
	{
	setTimeout("document.getElementById('expprice').value=document.getElementById('priceforunit').value;",500)
	}
	
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
	
	function selectcopy()
	{
	document.getElementById('price_bil1').focus();
	}
	
	function nextIndex(e,thisid,id)
	{
	var itemno = document.getElementById('expressservicelist').value;
	
	if (thisid == 'expressservicelist' && itemno == '')
	{
		if(e.keyCode==40){
		document.getElementById('expqty').focus();
		document.getElementById('expqty').select();
		}
		if(e.keyCode==39){
		document.getElementById('coltype').focus();
		}
		if(e.keyCode==38){
		document.getElementById('eulist').focus();
		}
		if(e.keyCode==13){
			var itemcount = 0;
			try{
				itemcount = document.getElementById('hiditemcount').value * 1;
			}
			catch(err)
			{
			}
			if(itemcount != 0)
			{
				document.getElementById('paytype').value='0';
				
			}
		}
	}
	else if (thisid == 'eulist')
	{
		if(e.keyCode==13){
			searchSel('custno','eulist');
			document.getElementById(''+id+'').focus();
		}
		else
		{
			searchSel('custno','eulist');
		}
	}
	else if (thisid == 'searchmembername')
	{
		if(e.keyCode==13){
			ajaxFunction(document.getElementById('searchmemberajax'),'searchmemberajax.cfm?custno='+escape(document.getElementById('searchmemberid').value)+'&name='+escape(document.getElementById('searchmembername').value)+'&contact='+escape(document.getElementById('searchmembertel').value)+'&address='+escape(document.getElementById('searchmemberadd').value)+'&main='+document.getElementById('checkmain').value);
		}
	}
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
	

		
	function selectOptionByValue(selObj, val){ 
    var A= selObj.options, L= A.length; 
    while(L){ 
        if (A[--L].value== val){ 
            selObj.selectedIndex= L; 
            L= 0; 
        } 
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
	<!---alert('Item Not Found');--->
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
	document.getElementById('expunit').selectedIndex =0;
	document.getElementById('expprice').value = document.getElementById('pricehid').value;
	document.getElementById('costformula').value = document.getElementById('costformulaid').value;
	document.getElementById('btn_add').value = "Add";
	document.getElementById('btn_add').disabled = false; 
	}
	calamtadvance();
	
	if(document.getElementById('btn_add').value == "Add")
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
	
	function changeitemdesp()
	{
	var itemdesptrancode = trim(document.getElementById('itemdesptrancode').value);
	var itemdesp = trim(document.getElementById('itemdesp').value);
	var itemdespa = trim(document.getElementById('itemdesp2').value);
	var itemcomment = trim(document.getElementById('itemcomment').value);
<cfoutput>
	var itemdespurl = '/default/transaction/vehicletranedit/itemdespprocess.cfm?tran=#URLEncodedFormat(tran)#&refno=#URLEncodedFormat(refno)#&trancode='+escape(itemdesptrancode)+'&itemdesp='+escape(itemdesp)+'&itemdespa='+escape(itemdespa)+'&itemcomment='+escape(itemcomment);
	ajaxFunction(document.getElementById('changedespajax'),itemdespurl);
	</cfoutput>
	}
	
	function addItemAdvance()
	{
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
	var driver = trim(document.getElementById('driver').value);
	var refno = trim(document.getElementById('refno').value);
	var trancode = trim(document.getElementById('nextransac').value);
	var glacc = trim(document.getElementById('glacc').value);
	var location = trim(document.getElementById('coltype').value);
	var custno = trim(document.getElementById('custno').value);
	var rem9 = trim(document.getElementById('rem9').value);
	var rem5 = trim(document.getElementById('rem5').value);
	var rem6 = trim(document.getElementById('rem6').value);
	var rem7 = trim(document.getElementById('rem7').value);
	var rem8 = trim(document.getElementById('rem8').value);
	var rem10 = trim(document.getElementById('rem10').value);
	var rem11 = trim(document.getElementById('rem11').value);
	var agenno = trim(document.getElementById('agent').value);
	var headergroup = trim(document.getElementById('headergroup').value);
	var headercate = trim(document.getElementById('headercate').value);
	var headersupp = trim(document.getElementById('headersupp').value);

	var ajaxurl = '/default/transaction/vehicletranedit/addproductsAjax.cfm?servicecode='+escape(expressservice)+'&desp='+escape(desp)+'&expressamt='+escape(expressamt)+'&expqty='+escape(expqty)+'&expprice='+escape(expprice)+'&unit='+escape(expunit)+'&dispec1='+escape(expunitdis1)+'&dispec2='+escape(expunitdis2)+'&dispec3='+escape(expunitdis3)+'&dis='+escape(expdis)+'&refno=#URLEncodedFormat(refno)#&tran=#URLEncodedFormat(tran)#&driver='+escape(driver)+'&isservi='+escape(isservi)+'&trancode='+escape(trancode)+'&glacc='+escape(glacc)+'&location='+escape(location)+'&custno='+escape(custno)+'&rem9='+escape(rem9)+'&headergroup='+escape(headergroup)+'&headercate='+escape(headercate)+'&headersupp='+escape(headersupp)+'&rem5='+escape(rem5)+'&rem6='+escape(rem6)+'&rem7='+escape(rem7)+'&rem8='+escape(rem8)+'&rem10='+escape(rem10)+'&rem11='+escape(rem11)+'&agenno='+escape(agenno);

	 new Ajax.Request(ajaxurl,
      {
        method:'get',
        onSuccess: function(getdetailback){
		document.getElementById('ajaxFieldPro').innerHTML = trim(getdetailback.responseText);
        },
        onFailure: function(){ 
		alert('Error Add Item'); },		
		
		onComplete: function(transport){
		clearformadvance();
		calculatefooter();
		refreshlist();
        }
      })--->
	</cfoutput>
	}
	
	function addmultiitem()
	{
	var itemlisting='';
	<cfoutput>
	for (k=1;k<=200;k=k+1)
	{
	if (document.getElementById('additem_'+k) == null)
	{
	}
	else
	{	
	if (document.getElementById('additem_'+k).checked == true)
	{
	var itemlisting=itemlisting+"&servicecode"+k+"="+document.getElementById('additem_'+k).value;
	}
	}
	}
	
	

	var tran = trim(document.getElementById('tran').value);
	var refno = trim(document.getElementById('refno').value);
	var trancode = trim(document.getElementById('nextransac').value);
	var custno = trim(document.getElementById('custno').value);
	
	var location = trim(document.getElementById('coltype').value);
	var rem9 = trim(document.getElementById('rem9').value);
	var headergroup = trim(document.getElementById('headergroup').value);
	var headercate = trim(document.getElementById('headercate').value);
	var headersupp = trim(document.getElementById('headersupp').value);
	
	<cfoutput>
	var ajaxurl2 = '/default/transaction/vehicletranedit/addmultiproductsAjax.cfm?refno=#URLEncodedFormat(refno)#&tran=#URLEncodedFormat(tran)#&trancode='+escape(trancode)+'&location='+escape(location)+'&custno='+escape(custno)+'&rem9='+escape(rem9)+'&headergroup='+escape(headergroup)+'&headercate='+escape(headercate)+'&headersupp='+escape(headersupp)+itemlisting;
	</cfoutput>
	new Ajax.Request(ajaxurl2,
      {
        method:'get',
        onSuccess: function(getdetailback){
		document.getElementById('ajaxFieldPro').innerHTML = trim(getdetailback.responseText);
        },
        onFailure: function(){ 
		alert('Error Add Item'); },		
		
		onComplete: function(transport){
		clearformadvance();
		setTimeout('calculatefooter();',500);
		refreshlist();
        }
      })
	</cfoutput>
	}
	
	
	function addpackagefunc()
	{
	<cfoutput>
	var tran = '#tran#';
	var refno = '#refno#';
	var trancode = trim(document.getElementById('nextransac').value);
	var custno = trim(document.getElementById('custno').value);
	var packagecode=document.getElementById('hidpackagecode').value;
	var location = trim(document.getElementById('coltype').value);
	var rem9 = trim(document.getElementById('rem9').value);
	var rem5 = trim(document.getElementById('rem5').value);
	var rem6 = trim(document.getElementById('rem6').value);
	var rem7 = trim(document.getElementById('rem7').value);
	var rem8 = trim(document.getElementById('rem8').value);
	var rem10 = trim(document.getElementById('rem10').value);
	var rem11 = trim(document.getElementById('rem11').value);
	var agenno = trim(document.getElementById('agent').value);
	var headergroup = trim(document.getElementById('headergroup').value);
	var headercate = trim(document.getElementById('headercate').value);
	var headersupp = trim(document.getElementById('headersupp').value);
	var driver = trim(document.getElementById('driver').value);
	
	
	var ajaxurl2 = '/default/transaction/vehicletranedit/addpackageprocessAjax.cfm?tran='+escape(tran)+'&refno='+refno+'&trancode='+escape(trancode)+'&packagecode='+escape(packagecode)+'&location='+escape(location)+'&custno='+escape(custno)+'&rem9='+escape(rem9)+'&headergroup='+escape(headergroup)+'&headercate='+escape(headercate)+'&headersupp='+escape(headersupp)+'&rem5='+escape(rem5)+'&rem6='+escape(rem6)+'&rem7='+escape(rem7)+'&rem8='+escape(rem8)+'&rem10='+escape(rem10)+'&rem11='+escape(rem11)+'&agenno='+escape(agenno)+'&driver='+escape(driver);
	<!---ajaxFunction(document.getElementById('ajaxFieldPro2'),ajaxurl2);--->
	new Ajax.Request(ajaxurl2,
      {
        method:'get',
        onSuccess: function(getdetailback){
		document.getElementById('ajaxFieldPro').innerHTML = trim(getdetailback.responseText);
        },
        onFailure: function(){ 
		alert('Error Add Package'); },		
		
		onComplete: function(transport){
		clearformadvance();
		setTimeout('calculatefooter();',500);
		refreshlist();
        }
      })
	</cfoutput>
	}
	
	
	function clearformadvance()
	{
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
	

	
	function refreshlist()
	{
	<cfoutput>
	ajaxFunction(document.getElementById('itemlist'),'getBody.cfm?refno=#refno#&tran=#tran#');
	ajaxFunction(document.getElementById('getqtytotal'),'getqtytotal.cfm?refno=#refno#&tran=#tran#');
	document.getElementById('itemlist').scrollTop = document.getElementById('itemlist').scrollHeight;
	</cfoutput>
	}
	
	function getitemdetail(detailitemno)
	{
	if(detailitemno.indexOf('*') != -1)
	{
	var thisitemno = detailitemno.split('*');
	document.getElementById('expressservicelist').value=thisitemno[1];
	document.getElementById('expqty').value=thisitemno[0];
	detailitemno=thisitemno[1];
	}
	if(trim(document.getElementById('expressservicelist').value) != "")
	{
    var urlloaditemdetail = '/default/transaction/vehicletranedit/addItemAjax.cfm?itemno='+escape(encodeURI(detailitemno))+'&reftype='+document.getElementById('tran').value+'&custno='+document.getElementById('custno').value;
	
	  new Ajax.Request(urlloaditemdetail,
      {
        method:'get',
        onSuccess: function(getdetailback){
		document.getElementById('itemDetail').innerHTML = trim(getdetailback.responseText);
        },
        onFailure: function(){ 
		<!---alert('Item Not Found');---> },		
		
		onComplete: function(transport){
		 <!--- getlocationbal(detailitemno);--->
		
		 updateVal();
        }
      })
	}
	}
	
	function getlocationbal(itemnobal)
	{
	  var urlloaditembal = '/default/transaction/vehicletranedit/balonhand.cfm?itemno='+encodeURI(itemnobal)+'&location='+escape(document.getElementById('locationfr').value);
	
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
    var urlload = '/default/transaction/vehicletranedit/recalculateAjax.cfm?refno=#URLEncodedFormat(refno)#&tran=#URLEncodedFormat(tran)#';
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
	}
	
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
	
	function calculatefooter()
	{
	document.getElementById('gross').value = document.getElementById('hidsubtotal').value;
	
	var hiditemcount = document.getElementById('hiditemcount').value * 1;
	if (hiditemcount == 0)
	{
	document.getElementById('Submit2').disabled = true;
	document.getElementById('Submit3').disabled = true;
	}
	else
	{
	document.getElementById('nextransac').options.length = 0;
	var droplistmenu = document.getElementById('nextransac');
	for (var i=hiditemcount+1; i > 0;--i){
	addOption(droplistmenu, i, i);
	}
	document.getElementById('Submit2').disabled = false;
	document.getElementById('Submit3').disabled = false;
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
	document.getElementById('Submit2').disabled = true;
	document.getElementById('Submit3').disabled = true;
	}
	else
	{
	document.getElementById('nextransac').options.length = 0;
	var droplistmenu = document.getElementById('nextransac');
	for (var i=hiditemcount+1; i > 0;--i){
	addOption(droplistmenu, i, i);
	}

	document.getElementById('Submit2').disabled = false;
	document.getElementById('Submit3').disabled = false;
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
	var taxincl = document.getElementById('taxincl').checked;
	var net = document.getElementById('net');
	var taxamt = document.getElementById('taxamt').value * 1;
	var grand = document.getElementById('grand');
	<cfoutput>
	net.value = (gross-disamt).toFixed(2);
	</cfoutput>

	if(taxincl == true)
	{
	
	grand.value = net.value;
	
	}
	else
	{
	var netb = ((net.value * 1) + (taxamt * 1));
	<cfoutput>
	grand.value = netb.toFixed(2);
	</cfoutput>
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
	<cfoutput>
	grand.value = net.toFixed(2);
	</cfoutput>
	}
	else
	{
	taxval = ((taxper/100)*net).toFixed(2);
	taxamt.value = taxval;
	var netb = (net * 1) + (taxval * 1);
	<cfoutput>
	grand.value =netb.toFixed(2);
	</cfoutput>
	}

	}
	<cfoutput>
	function recalculateamt()
	{
	var ajaxurl = '/default/transaction/vehicletranedit/recalculateAjax.cfm?tran=#URLEncodedFormat(tran)#&refno=#URLEncodedFormat(refno)#';
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
	function selectlist(varval,varattb){		
		for (var idx=0;idx<document.getElementById(varattb).options.length;idx++) 
		{
			if (varval==document.getElementById(varattb).options[idx].value) 
			{
				document.getElementById(varattb).options[idx].selected=true;
				
			}
		}
		}
	function getcustomer()
	{
		<cfoutput>
	var customerurl = '/default/transaction/vehicletranedit/memberdetailajax.cfm?detail=1&tran=#url.tran#&member='+document.getElementById("custno").value;
	ajaxFunction(document.getElementById('getcustomerdetailajax'),customerurl);
	</cfoutput>
	setTimeout("updatecustomerdetail();",1000);
	}
	
	function getdeposit()
	{
	<cfoutput>
	var depositurl = '/default/transaction/vehicletranedit/getdepositajax.cfm?depositno='+document.getElementById("depositno").value;
	ajaxFunction(document.getElementById('getdepositajax'),depositurl);
	</cfoutput>
	setTimeout("updatedeposit();",300);
	setTimeout("calculatetotal2();",300);
	
	}
	
	function addnewdeposit(deposit){
			myoption = document.createElement("OPTION");
			myoption.text = deposit;
			myoption.value = deposit;
			document.getElementById("depositno").options.add(myoption);
			var indexvalue = document.getElementById("depositno").length-1;
			document.getElementById("depositno").selectedIndex=indexvalue;
			setTimeout("getdeposit();",200);
		}
	
	function updatedeposit()
	{
	
	<!---document.getElementById('paycash6').value=document.getElementById('hidcash').value;
	document.getElementById('cheq6').value=document.getElementById('hidcheq').value;
	document.getElementById('cc16').value=document.getElementById('hidcrcd').value;
	document.getElementById('cc26').value=document.getElementById('hidcrc2').value;
	document.getElementById('dbc6').value=document.getElementById('hiddbcd').value;
	document.getElementById('voucheramt6').value=document.getElementById('hidvouc').value;
	document.getElementById('chequeno6').value=document.getElementById('hidchequeno').value;
	document.getElementById('cctype16'+document.getElementById('hidcctype1').value).checked=true;
	document.getElementById('cctype26'+document.getElementById('hidcctype2').value).checked=true;--->
	document.getElementById('depositamt6').value=((document.getElementById('hidcash').value*1)+(document.getElementById('hidcheq').value*1)+(document.getElementById('hidcrcd').value*1)+(document.getElementById('hidcrc2').value*1)+(document.getElementById('hiddbcd').value*1)+(document.getElementById('hidvouc').value*1)).toFixed(2);
	}
	
	function getvehicles()
	{
	var vehiclesurl = '/default/transaction/vehicletranedit/vehiclesdetailajax.cfm?detail=1&vehicle='+document.getElementById("rem5").value;
	ajaxFunction(document.getElementById('getvehiclesajax'),vehiclesurl);
	setTimeout("getCustSupp2(document.getElementById('hidcustno').value,document.getElementById('hidcustname').value);",250)
	setTimeout("selectOptionByValue(document.getElementById('custno'),document.getElementById('hidcustno').value);",250)
	setTimeout("selectOptionByValue(document.getElementById('permitno'),document.getElementById('hidowner').value);",250)
	setTimeout("getcustomer();",300);
	}
	
	
	function updatecustomerdetail()
	{
	<!---
	if(document.getElementById('ngstcusthid').value=='T'){
	document.getElementById('taxper').value='0'
	<cfoutput>
	document.getElementById('taxcode').value='#getgsetup.df_salestaxzero#'
	</cfoutput>
	}
	else
	{
	<cfoutput>
	document.getElementById('taxper').value='#getgsetup.gst#'
	document.getElementById('taxcode').value='#getgsetup.df_salestax#'
	</cfoutput>
	}--->
	document.getElementById('currcodehid').value=document.getElementById('currcodeajaxhid').value;
	document.getElementById('currrate').value=document.getElementById('currrateajaxhid').value;
	<cfif not isdefined('url.refno')>
	selectOptionByValue(document.getElementById('agent'),document.getElementById('agentajaxhid').value);
	selectOptionByValue(document.getElementById('term'),document.getElementById('termajaxhid').value);
	</cfif>
	selectOptionByValue(document.getElementById('driver'),document.getElementById('driverajaxhid').value);
	}
    </script>
    
    
</head>

<body 
<cfif isdefined('url.refno')>
onLoad="document.getElementById('eulist').focus();"
<cfelseif isdefined('url.first') eq false>
onLoad="document.getElementById('expressservicelist').focus();"
</cfif>
>

<cfif tran eq 'INV'>
<cfset tranname=getgsetup.linv>
<cfelseif tran eq 'CN'>
<cfset tranname=getgsetup.lcn>
<cfelse>
<cfset tranname=getgsetup.lso>
</cfif>



<cfform name="invoicesheet" id="invoicesheet" action="process.cfm" method="post">
<cfoutput>
<input type="hidden" name="checkmain" id="checkmain" value="">
<input type="hidden" name="itemdesptrancode" id="itemdesptrancode" value="">
<input type="hidden" name="hidtrancode" id="hidtrancode" value="">
<cfinput type="hidden" name="ptype" id="ptype" bind="cfc:custsupp.getname({tran},'#target_arcust#','#target_apvend#')" bindonload="yes" >
<input type="hidden" name="updownposition" id="updownposition" value="">
</cfoutput>

<cfoutput>
<table width="100%">
<tr>
<th width="20%">Date</th>
<cfset datenow=now()>
<cfif getGsetup.autonextdate lte timeformat(now(),'HH')>
<cfset datenow=dateadd('d',1,now())>
<cfelse>
<cfset datenow=now()>
</cfif>
<td width="30%"><cfinput type="text" name="wos_date" id="wos_date" value="#dateformat(datenow,'DD/MM/YYYY')#" onKeyUp="nextIndex(event,'wos_date','expressservicelist');" validate="eurodate" required="yes" message="please key in correct date"><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('wos_date'));">&nbsp;(DD/MM/YYYY)</td>
<th width="20%">Refno</th>
<td width="30%" style="font-family:'Times New Roman', Times, serif; font-size:14">
<cfinput type="hidden" name="tran" id="tran" value="#url.tran#">
<cfinput type="text" name="refno" id="refno" value="#url.refno#" readonly>
</td><td align="right"><input type="button" align="right" style="background:##666666;color:##FFF;border:none; font:'Times New Roman', Times, serif; font-weight:bold; font-size:16px;" name="button1" id="button1" value="#tranname#"></td>
</td>
</tr>
<tr>
<td></td><td></td><th>Ref No 2</th><td><input type="text" name="refno2" id="refno2" value="#refno2#" maxlength="15"></td>
</tr>
<tr>
<th>Description</th>
<td><cfinput type="text" name="headerdesp" size="50" id="headerdesp" value="#desp#" onKeyUp="nextIndex(event,'headerdesp','headerdesp2');" maxlength="40" ></td>
<th <cfif lcase(hcomid) eq "sosbat_i">style="display:none"</cfif>>#getgsetup.rem9#</th>
<td <cfif lcase(hcomid) eq "sosbat_i">style="display:none"</cfif>><cfif lcase(hcomid) eq "ltm_i"><cfinput type="text" name="rem9" id="rem9" value="#rem9#" maxlength="15" size="50" required="yes" message="Please Key in #getgsetup.rem9#"><cfelse><cfinput type="text" name="rem9" id="rem9" value="#rem9#" maxlength="15" size="50"></cfif></td>

</tr>
<tr>
<th></th>
<td><cfinput type="text" name="headerdesp2" size="50" id="headerdesp2" value="#desp2#" onKeyUp="nextIndex(event,'headerdesp2','custno');" maxlength="40"></td>
<th <cfif lcase(hcomid) eq "sosbat_i">style="display:none"</cfif>>#getgsetup.rem10#</th>
<td <cfif lcase(hcomid) eq "sosbat_i">style="display:none"</cfif>><input type="text" name="rem10" id="rem10" value="#rem10#" maxlength="15" size="50"></td>
</tr>

<tr>
<th>Vehicle No*</th>
<td>
<cfquery name="getvehiqry" datasource="#dts#">
SELECT "Choose a Vehicle" as eudesp, "" as entryno
union all 
SELECT <!---concat(entryno,' - ',name)---> entryno as eudesp, entryno FROM vehicles
</cfquery>
<!---<cfselect name="rem5" id="rem5" query="getvehiqry" display="eudesp" value="entryno" onChange="getvehicles();" onKeyUp="getvehicles();" />--->
<!---<cfinput type="text" name="rem5" id="rem5" value="" readonly required="yes" message="Please Choose Vehicle">--->
<cfselect id="rem5" name='rem5' required="yes" message="Please Choose Vehicle" selected="#rem5#" onChange="getvehicles();"></cfselect>
<input id="letter" name="letter" type="text" size="8" onKeyUp="findVehicle('0')" value="#rem5#">
<!---<input type="button" name="Svehi1" value="Search" onClick="javascript:ColdFusion.Window.show('findvehicle');getfocus();" >&nbsp;&nbsp;---><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="window.open('/default/maintenance/shellvehicles/vehicles2.cfm?type=Create&express=1');">New</a></td>
<th <cfif lcase(hcomid) eq "sosbat_i">style="display:none"</cfif>>#getgsetup.rem8#</th>
<td <cfif lcase(hcomid) eq "sosbat_i">style="display:none"</cfif>>
<input type="text" name="rem8" id="rem8" value="#rem8#" maxlength="80" size="20" onBlur="validatedate('rem8')"/>
<select name="rem8selectbox" id="rem8selectbox" onChange="DateAdd('m',this.value,Format(document.getElementById('wos_date').value.substring(3,5)+'/'+document.getElementById('wos_date').value.substring(0,2)+'/'+document.getElementById('wos_date').value.substring(6,10),'mm-dd-yyyy'));">
<option value="0">Select Month</option>
<option value="3">3 Month</option>
<option value="6">6 Month</option>
</select>

</td>
</tr>


<tr>
<th>#dbname#*</th>
<td>
<div id="getvehiclesajax">
</div>
<cfquery name="geteuqry" datasource="#dts#">
SELECT "Choose an #dbname#" as eudesp, "" as custNO
union all 
SELECT concat(custno,' - ',name) as eudesp, custno FROM #dbtype#
</cfquery>
<cfselect name="custno" id="custno" query="geteuqry" display="eudesp" value="custno" onChange="getcustomer();" onKeyUp="getcustomer();" required="yes" message="Please Choose Customer No" /><input type="button" name="Scust1" value="Search" onClick="javascript:ColdFusion.Window.show('findCustomer');getfocus();" >&nbsp;&nbsp;<a onClick="javascript:ColdFusion.Window.show('createCustomer');" onMouseOver="this.style.cursor='hand';">New</a>
<input type="hidden" name="eulist" id="eulist" value="#custno#" onKeyUp="nextIndex(event,'eulist','expressservicelist');getcustomer();" onBlur="nextIndex(event,'eulist','expressservicelist');getcustomer();">
 <input type="hidden" name="custhid" id="custhid"> &nbsp;&nbsp;  <input type="hidden" name="custhid" id="custhid">

</td>
	<cfquery name="getnewtrancode" datasource="#dts#">
		select max(trancode) as newtrancode
		from ictran
		where refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#"> and type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#tran#">
        </cfquery>
        <cfif getnewtrancode.recordcount eq 0>
            <cfset newtrancode=1>
        <cfelse>
            <cfset newtrancode = val(getnewtrancode.newtrancode)+1>
        </cfif>
        <cfquery name="newtranqy" datasource="#dts#">
        SELECT #newtrancode# as trancode
        union
        SELECT trancode FROM ictran where refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#"> and type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#tran#">
        ORDER BY trancode desc
        </cfquery>
  <input type="checkbox" style="display:none" name="activatebarcode" id="activatebarcode" value="Y" />
  <input type="hidden" name="pagesize" id="pagesize" value="7" />
  <cfinput type="hidden" name="glacc" id="glacc" maxlength="10" size="10" mask="9999/999" />
<input type="hidden" name="costformula" id="costformula" value="" readonly>


<th <cfif lcase(hcomid) eq "sosbat_i">style="display:none"</cfif>><div id="ajaxFieldPro2" name="ajaxFieldPro2" style="display:none"> </div>Fuel</th>
<td <cfif lcase(hcomid) eq "sosbat_i">style="display:none"</cfif>><select name="rem33" id="rem33">
<option value="1/4">1/4</option>
<option value="1/2">1/2</option>
<option value="3/4">3/4</option>
<option value="Full">Full</option>
</select>

<div style="display:none"><cfinput type="text" name="currcode" id="currcode" size="10"  /><input type="hidden" name="currcodehid" id="currcodehid" value="">&nbsp;<cfinput type="text" name="currrate" id="currrate" bind="cfc:custsupp.getcurrrate('#dts#',{currcode},'#target_currency#')" bindonload="yes" size="5" /></div>

</td>
</tr>
<tr>
<td rowspan="8" colspan="2">
<div id="getcustomerdetailajax">
<table align="left">
<tr>
<th width="50%">Customer Name</th>
<td><input type="text" name="b_name" id="b_name" value="" maxlength="35" size="40"/></td>
</tr>
<tr>
<th></th>
<td><input type="text" name="b_name2" id="b_name2" value="" maxlength="35" size="40"/></td>
</tr>
<tr>
<th>Address</th>
<td>
<input type="text" name="b_add1" id="b_add1" value="" maxlength="35" size="40"></td>
</tr>
<tr>
<th><input type="button" name="changeadd" id="changeadd" onClick="ColdFusion.Window.show('changeadd');" value="Change Bill Add"></th>
<td>
<input type="text" name="b_add2" id="b_add2" value="" maxlength="35" size="40"></td>
</tr>
<tr>
<th></th>
<td>
<input type="text" name="b_add3" id="b_add3" value="" maxlength="35" size="40"></td>
</tr>
<tr>
<th></th>
<td>
<input type="text" name="b_add4" id="b_add4" value="" maxlength="35" size="40"></td>
</tr>
<tr>
<th>Tel</th>
<td>
<input type="text" name="b_phone" id="b_phone" value="" maxlength="35" size="40"></td>
</tr>
</table>

</div>
</td>
<th>#getgsetup.lagent#<cfif lcase(hcomid) eq "ltm_i">*</cfif></th>
<td>
<cfif lcase(hcomid) eq "ltm_i">
<cfselect name="agent" id="agent" bind="cfc:custsupp.getagent('#dts#','#Hlinkams#')" selected="#agenno#" bindonload="yes" display="agentdesp" value="agent" required="yes" message="Please Select Agent"  />
<cfelse>
<cfselect name="agent" id="agent" bind="cfc:custsupp.getagent('#dts#','#Hlinkams#')" selected="#agenno#" bindonload="yes" display="agentdesp" value="agent"  />
</cfif>
<input type="hidden" name="agenthid" id="agenthid" value=""></td>

<div id="onholdajax"></div>
<div id="changedespajax"></div>

</tr>
<tr>
</tr>
<tr>
<th <cfif lcase(hcomid) eq "sosbat_i">style="display:none"</cfif>><cfif lcase(HcomID) eq "imperial1_i" or lcase(HcomID) eq "coolnlite_i">#getgsetup.ldriver#<cfelse>#getgsetup.lagent# 2</cfif></th>
<td width="30%" <cfif lcase(hcomid) eq "sosbat_i">style="display:none"</cfif>>
<div <cfif lcase(HcomID) eq "imperial1_i" or lcase(HcomID) eq "coolnlite_i"><cfelse>style="display:none"</cfif>><cfselect name="driver" id="driver" bind="cfc:custsupp.geteu('#dts#')" bindonload="yes" display="eudesp" value="driverno" /> <input type="hidden" name="driverhid" id="driverhid" value=""></div>
<div <cfif lcase(HcomID) eq "imperial1_i" or lcase(HcomID) eq "coolnlite_i">style="display:none"</cfif>><cfselect name="multiagent1" id="multiagent1" selected="#zmultiagent1#" bind="cfc:custsupp.getagent('#dts#','#Hlinkams#')" bindonload="yes" display="agentdesp" value="agent" /></div>

</tr>
<tr>
<th>Term</th>
<td><cfselect name="term" id="term" bind="cfc:custsupp.getterms('#dts#','#target_icterm#')"  bindonload="yes" display="termdesp" value="term" /><input type="hidden" name="termhid" id="termhid" value=""></td>
</tr>
<tr>

<cfinput type="hidden" name="b_fax" id="b_fax" size="40" maxlength="35" />
<cfinput type="hidden" name="b_attn" id="b_attn" size="40" maxlength="35" />
<cfinput type="hidden" name="b_phone2" id="b_phone2" size="40" maxlength="35" />
<cfinput type="hidden" name="d_fax" id="d_fax" size="40" maxlength="35" />
<th <cfif getmodule.project neq '1'>style="visibility:hidden"</cfif>>Project</th>
<td <cfif getmodule.project neq '1'>style="visibility:hidden"</cfif>>
<cfselect name="project" id="project" bind="cfc:custsupp.getproject('#dts#','#Hlinkams#')" selected="#Huserproject#" bindonload="yes" display="projectdesp" value="source" />
</td>
</tr>
<th <cfif getmodule.project neq '1'>style="visibility:hidden"</cfif>>Job</th>
<td <cfif getmodule.project neq '1'>style="visibility:hidden"</cfif>>
<cfselect name="job" id="job" bind="cfc:custsupp.getjob('#dts#','#Hlinkams#')" bindonload="yes" display="jobdesp" value="source" />
</td>
</tr>
<tr>
<td style="font-size:20px; color:##000" colspan="2"><input type="button" style="font: medium bolder;background-color:##FF0000; color:##FFFFFF" name="remarkbtn" id="remarkbtn" value="Header Detail" onClick="ColdFusion.Window.show('remarks');setTimeout('updateremark2();',500);"></td>
</tr>
<tr>
<th><cfif lcase(hcomid) eq "ltm_i">Job*<cfelse>Location</cfif></th>
<td>
<cfif lcase(hcomid) eq "ltm_i">
<cfselect name="coltype" id="coltype" onKeyUp="nextIndex(event,'coltype','expressservicelist');" required="yes" message="Please Select Job">
<option value="">Choose a location</option>
<cfloop query="getlocation">
<option value="#getlocation.location#" <cfif coltype eq getlocation.location>selected</cfif>>#getlocation.location# - #getlocation.desp#</option>
</cfloop>
</cfselect>

<cfelse>
<cfselect name="coltype" id="coltype" onKeyUp="nextIndex(event,'coltype','expressservicelist');" >
<option value="">Choose a location</option>
<cfloop query="getlocation">
<option value="#getlocation.location#" <cfif getgsetup.ddllocation eq getlocation.location>selected</cfif>>#getlocation.location# - #getlocation.desp#</option>
</cfloop>
</cfselect>

</cfif>
</td></tr>
<tr <cfif lcase(hcomid) eq "sosbat_i">style="display:none"</cfif>>
<th>Owner<cfif lcase(hcomid) eq "ltm_i">*</cfif></th>
<td>
<cfif lcase(hcomid) eq "ltm_i">
<cfselect name="permitno" id="permitno" query="geteuqry" selected="#permitno#" display="eudesp" value="custno" required="yes" message="Please Select Owner"></cfselect>
<cfelse>
<cfselect name="permitno" id="permitno" query="geteuqry" selected="#permitno#" display="eudesp" value="custno" ></cfselect>
</cfif>
<th>R.T.J</th>
<td><select name="rem31" id="rem31">
<option value="No" <cfif rem31 eq "No">selected</cfif>>No</option>
<option value="Yes" <cfif rem31 eq "Yes">selected</cfif>>Yes</option>
</select></td>
</td></tr>

</tr>
<tr <cfif lcase(hcomid) eq "sosbat_i">style="display:none"</cfif>>
<th rowspan="3">Remark</th>
<td rowspan="3"><textarea name="rem11" id="rem11" cols="50" rows="4">#rem11#</textarea></td>
<th>Tow</th>
<td><select name="rem32" id="rem32">
<option value="No" <cfif rem32 eq "No">selected</cfif>>No</option>
<option value="Yes" <cfif rem32 eq "Yes">selected</cfif>>Yes</option>
</select></td>
</tr>
<tr <cfif lcase(hcomid) neq "ltm_i"> style="display:none"</cfif>>

<th>Mechanic*</th>
<td>
<cfif lcase(hcomid) eq "ltm_i">
<cfselect name="headergroup" id="headergroup" required="yes" message="Please Select Mechanic">
<option value="">Choose a #getgsetup.lgroup#</option>
<cfloop query="getgroup">
<option value="#getgroup.wos_group#"  <cfif xwos_group eq getgroup.wos_group>selected</cfif>>#getgroup.wos_group# - #getgroup.desp#</option>
</cfloop>
</cfselect>
<cfelse>
<cfselect name="headergroup" id="headergroup">
<option value="">Choose a #getgsetup.lgroup#</option>
<cfloop query="getgroup">
<option value="#getgroup.wos_group#">#getgroup.wos_group# - #getgroup.desp#</option>
</cfloop>
</cfselect>
</cfif>
</td>
</tr>
<tr <cfif lcase(hcomid) neq "ltm_i"> style="display:none"</cfif>>

<th>Department*</th>
<td>
<cfif lcase(hcomid) eq "ltm_i">
<cfselect name="headercate" id="headercate" required="yes" message="Please Select Department">
<option value="">Choose a #getgsetup.lproject#</option>
<cfloop query="getproject">
<option value="#getproject.source#" <cfif xsource eq getproject.source>selected</cfif>>#getproject.source#</option>
</cfloop>
</cfselect>
<cfelse>
<cfselect name="headercate" id="headercate">
<option value="">Choose a #getgsetup.lproject#</option>
<cfloop query="getproject">
<option value="#getproject.source#">#getproject.source#</option>
</cfloop>
</cfselect>
</cfif>
</td>
</tr>
<tr style="display:none">
<td></td>
<td></td>
<th>Supp</th>
<td><select name="headersupp" id="headersupp">
<option value="">Choose a Supp</option>
<cfloop query="getsupp">
<option value="#getsupp.custno#" <cfif xnote1 eq getsupp.custno>selected</cfif>>#getsupp.custno# - #getsupp.name#</option>
</cfloop>
</select> <a onClick="javascript:ColdFusion.Window.show('createSupplier');" onMouseOver="this.style.cursor='hand';">New</a></td>
</tr>

<tr><td colspan="4"><hr /></td></tr>
<cfif lcase(hcomid) eq "ltm_i">

<tr>
<td colspan="4" height="600">
<cfset datashow = "yes">
<cfif getpin2.h1360 neq 'T'>
<cfset datashow = "no">
</cfif>
<div id="itemlist" style="height:598px; overflow:scroll;">
<table width="100%">
<tr>
<th width="2%">No</th>
<th width="15%">Item Code</th>
<th width="8%" <cfif lcase(hcomid) eq "sosbat_i">style="display:none"</cfif>>S/N</th>
<!---<th width="10%">#getgsetup.laitemno#</th>--->
<th width="30%">Description</th>
<th width="10%" <cfif lcase(hcomid) eq "sosbat_i">style="display:none"</cfif>>Status</th>
<th width="10%">Location</th>
<th width="10%">Quantity</th>

<th width="8%" <cfif lcase(HcomID) eq "imperial1_i" or lcase(HcomID) eq "coolnlite_i"><cfelse>style="display:none"</cfif>>Deductable Item</th>


<th width="8%">Price</th>
<th width="8%">Discount</th>
<th width="8%" <cfif lcase(HcomID) eq "imperial1_i" or lcase(HcomID) eq "coolnlite_i" or lcase(hcomid) eq "sosbat_i">style="display:none"</cfif>>No Display</th>
<th width="8%" <cfif lcase(HcomID) eq "imperial1_i" or lcase(HcomID) eq "coolnlite_i" or lcase(hcomid) eq "sosbat_i">style="display:none"</cfif>>SubTotal</th>
<th width="8%" <cfif lcase(hcomid) eq "sosbat_i">style="display:none"</cfif>>Mechanic</th>
<th width="8%" <cfif lcase(HcomID) eq "imperial1_i" or lcase(HcomID) eq "coolnlite_i" or lcase(hcomid) eq "sosbat_i">style="display:none"</cfif>>Department</th>
<th width="8%" style="display:none">Supp</th>

<th width="8%">Amount</th>
<th width="10%">Action</th>
</tr>
<cfquery name="getictran" datasource="#dts#">
SELECT * FROM ictran WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#"> and type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#tran#"> order by trancode
</cfquery>
<cfloop query="getictran">
<tr <cfif (getictran.currentrow mod 2) eq 0>style="background-color:##33FFFF"</cfif> onMouseOut="javascript:this.style.backgroundColor='<cfif (getictran.currentrow mod 2) eq 0>33FFFF</cfif>';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
<td nowrap>#getictran.currentrow#</td>
<td nowrap>#getictran.itemno#</td>
<!---
<cfquery name="getaitem" datasource="#dts#">
   		select aitemno from icitem where itemno='#getictran.itemno#'
	</cfquery>
<td nowrap>#getaitem.aitemno#</td>--->
<td nowrap align="right" <cfif lcase(hcomid) eq "sosbat_i">style="display:none"</cfif>><input type="text" name="brem1#getictran.trancode#" id="brem1#getictran.trancode#" value="#getictran.brem1#" size="5" onBlur="updaterow('#getictran.trancode#');" onKeyup="if(this.value != '#getictran.brem1#'){document.getElementById('updatebtn#getictran.trancode#').style.display='block';}else{document.getElementById('updatebtn#getictran.trancode#').style.display='none';}"></td>
<cfif getictran.location eq ''>
<cfquery name="getitembalance" datasource="#dts#">
    select 
	a.itemno,
	ifnull(ifnull(a.qtybf,0)+ifnull(b.sumtotalin,0)-ifnull(c.sumtotalout,0),0) as balance
	
	from icitem as a
	
	left join 
	(
		select itemno,sum(qty) as sumtotalin 
		from ictran 
		where type in ('RC','CN','OAI','TRIN') 
		and itemno='#getictran.itemno#' 
		and fperiod<>'99'
		and (void = '' or void is null)
		group by itemno
	) as b on a.itemno=b.itemno
	
	left join 
	(
		select itemno,sum(qty) as sumtotalout 
		from ictran 
		where type in ('INV','DO','DN','CS','OAR','PR','ISS','TROU'<cfif lcase(HcomID) eq "remo_i">,'SO'</cfif>) 
		and itemno='#getictran.itemno#' 
		and fperiod<>'99'
		and (void = '' or void is null)
		and toinv='' 
		group by itemno
	) as c on a.itemno=c.itemno
	
	where a.itemno='#getictran.itemno#' 
    </cfquery>
<cfelse>
<cfquery name="getitembalance" datasource="#dts#">
	select 
	c.balance 
	
	from icitem as a 
	
	left join 
	(
		select 
		location,
		itemno,
		(select desp from iclocation where location=locqdbf.location) as locationdesp 
		from locqdbf
		where itemno=itemno 
		and itemno='#getictran.itemno#' 
		and location = '#getictran.location#' 

	) as b on a.itemno=b.itemno 
	
	left join 
	(
		select 
		a.location,
		a.itemno,
		(ifnull(a.locqfield,0)+ifnull(b.sum_in,0)-ifnull(c.sum_out,0)) as balance 
		
		from locqdbf as a 
		
		left join
		(
			select 
			location,
			itemno,
			sum(qty) as sum_in 
			
			from ictran
			
			where type in ('RC','CN','OAI','TRIN') 
			and fperiod<>'99'
			and itemno='#getictran.itemno#' 
			and location = '#getictran.location#'

			group by location,itemno
			order by location,itemno
		) as b on a.location=b.location and a.itemno=b.itemno
		
		left join
		(
			select 
			location,
            category,
            wos_group,
			itemno,
			sum(qty) as sum_out 
			
			from ictran 
			
			where 
		type in ('INV','DO','DN','CS','OAR','PR','ISS','TROU','SO') 
		and (toinv='' or toinv is null) 
			and fperiod<>'99'
			and itemno='#getictran.itemno#' 
			and location = '#getictran.location#' 
			group by location,itemno
			order by location,itemno
		) as c on a.location=c.location and a.itemno=c.itemno 
		
		where a.itemno=a.itemno
		and a.itemno='#getictran.itemno#' 

		and a.location = '#getictran.location#'

	) as c on a.itemno=c.itemno and b.location=c.location 
	
	where a.itemno=a.itemno 
	and b.location = '#getictran.location#'
    and a.itemno='#getictran.itemno#' 
	order by a.itemno;
</cfquery>
</cfif>

<td nowrap><a onMouseOver="JavaScript:this.style.cursor='hand'" onClick="document.getElementById('itemdesptrancode').value='#getictran.trancode#';ColdFusion.Window.show('itemdesp');">#getictran.desp#</a></td>
<td nowrap <cfif lcase(hcomid) eq "sosbat_i">style="display:none"</cfif>><cfif val(getitembalance.balance) gt 0>STK<cfelse>IND</cfif></td>
<td nowrap>
<!--- <select name="coltypelist#getictran.trancode#" id="coltypelist#getictran.trancode#" onChange="if(this.value != '#getictran.brem1#'){document.getElementById('updatebtn#getictran.trancode#').style.display='block';}else{document.getElementById('updatebtn#getictran.trancode#').style.display='none';}" onclick="if(this.value == '' ">
<option value="Cash n Carry" <cfif getictran.brem1 eq "Cash n Carry">Selected</cfif>>Cash & Carry</option>
<option value="Cash n Delivery" <cfif getictran.brem1 eq "Cash n Delivery">Selected</cfif>>Cash & Delivery</option> 
</select> --->
<select name="coltypelist#getictran.trancode#" id="coltypelist#getictran.trancode#" onChange="updaterow('#getictran.trancode#');">
<option value="">Choose a location</option>
<cfloop query="getlocation">
<option value="#getlocation.location#" <cfif getictran.location eq getlocation.location>selected</cfif>>#getlocation.location# - #getlocation.desp#</option>
</cfloop>
</select>
<!---<input type="text" name="coltypelist#getictran.trancode#" id="coltypelist#getictran.trancode#" value="#getictran.brem1#" onClick="if(this.value=='Collection'){this.value = 'Delivery';updaterow('#getictran.trancode#');} else {this.value = 'Collection';updaterow('#getictran.trancode#');}"  readonly="readonly">---->
</td>
<td nowrap align="right"><input type="text" name="qtylist#getictran.trancode#" id="qtylist#getictran.trancode#" value="#val(getictran.qty_bil)#" size="5" onBlur="updaterow('#getictran.trancode#');" onKeyup="if(this.value != '#val(getictran.qty_bil)#'){document.getElementById('updatebtn#getictran.trancode#').style.display='block';}else{document.getElementById('updatebtn#getictran.trancode#').style.display='none';}"></td>
<!---
<cfquery name="getpacking" datasource="#dts#">
select * from icitem where itemno='#getictran.itemno#'
</cfquery>
<td nowrap align="right">
<select name="promotiontype#getictran.trancode#" id="promotiontype#getictran.trancode#" onChange="updaterow('#getictran.trancode#');">
        <cfloop query="getpacking">
        <option value=""></option>
        </cfloop>
        </select>
        </td>--->
        
        <td <cfif lcase(HcomID) eq "imperial1_i" or lcase(HcomID) eq "coolnlite_i"><cfelse>style="display:none"</cfif>>
        <select name="deductitemlist#getictran.trancode#" id="deductitemlist#getictran.trancode#" onChange="updaterow('#getictran.trancode#');">
<option value="Y" <cfif getictran.deductableitem eq 'Y'>selected</cfif>>Y</option>
<option value="N" <cfif getictran.deductableitem eq 'N' or getictran.deductableitem eq ''>selected</cfif>>N</option>
</select>
        </td>
        
<td nowrap align="right"><a style="cursor:pointer" onClick="document.getElementById('hidtrancode').value='#getictran.trancode#';ColdFusion.Window.show('changeprice');getfocus5();">#numberformat(val(getictran.price_bil),',.__')#</a></td>

<td nowrap align="right"><input type="text" name="brem4#getictran.trancode#" id="brem4#getictran.trancode#" value="#getictran.brem4#" size="5" onBlur="updaterow('#getictran.trancode#');" onKeyup="if(this.value != '#getictran.brem4#'){document.getElementById('updatebtn#getictran.trancode#').style.display='block';}else{document.getElementById('updatebtn#getictran.trancode#').style.display='none';}"></td>

<td <cfif lcase(HcomID) eq "imperial1_i" or lcase(HcomID) eq "coolnlite_i" or lcase(HcomID) eq "sosbat_i">style="display:none"</cfif>>
        <select name="nodisplaylist#getictran.trancode#" id="nodisplaylist#getictran.trancode#" onChange="updaterow('#getictran.trancode#');">
<option value="Y" <cfif getictran.nodisplay eq 'Y'>selected</cfif>>Y</option>
<option value="N" <cfif getictran.nodisplay eq 'N' or getictran.nodisplay eq ''>selected</cfif>>N</option>
</select>
        </td>
<td <cfif lcase(HcomID) eq "imperial1_i" or lcase(HcomID) eq "coolnlite_i" or lcase(HcomID) eq "sosbat_i">style="display:none"</cfif>>
        <select name="subtotallist#getictran.trancode#" id="subtotallist#getictran.trancode#" onChange="updaterow('#getictran.trancode#');">
<option value="Y" <cfif getictran.totalupdisplay eq 'Y'>selected</cfif>>Y</option>
<option value="N" <cfif getictran.totalupdisplay eq 'N' or getictran.totalupdisplay eq ''>selected</cfif>>N</option>
</select>
        </td>
<td nowrap align="right" <cfif lcase(hcomid) eq "sosbat_i">style="display:none"</cfif>><select name="grouplist#getictran.trancode#" id="grouplist#getictran.trancode#" onChange="updaterow('#getictran.trancode#');">
<option value="">Choose a #getgsetup.lgroup#</option>
<cfloop query="getgroup">
<option value="#getgroup.wos_group#" <cfif getictran.brem2 eq getgroup.wos_group>selected</cfif>>#getgroup.wos_group#</option>
</cfloop>
</select></td>
<td nowrap align="right" <cfif lcase(HcomID) eq "imperial1_i" or lcase(HcomID) eq "coolnlite_i" or lcase(HcomID) eq "sosbat_i">style="display:none"</cfif>><select name="catelist#getictran.trancode#" id="catelist#getictran.trancode#" onChange="updaterow('#getictran.trancode#');">
<option value="">Choose a #getgsetup.lproject#</option>
<cfloop query="getproject">
<option value="#getproject.source#" <cfif getictran.source eq getproject.source>selected</cfif>>#getproject.source#</option>
</cfloop>
</select></td>
<td nowrap align="right" style="display:none"><select name="supplist#getictran.trancode#" id="supplist#getictran.trancode#" onChange="updaterow('#getictran.trancode#');">
<option value="">Choose a Supp</option>
<cfloop query="getsupp">
<option value="#getsupp.custno#" <cfif getictran.note1 eq getsupp.custno>selected</cfif>>#getsupp.custno# - #getsupp.name#</option>
</cfloop>
</select></td>


<td nowrap align="right">#numberformat(val(getictran.amt_bil),',.__')#</td>
<td nowrap><input type="button" name="deletebtn#getictran.trancode#" id="deletebtn#getictran.trancode#" onClick="if(confirm('Are You Sure You Want To Delete?')){deleterow('#getictran.trancode#')}" value="DELETE"/>&nbsp;<img id="updatebtn#getictran.trancode#" name="updatebtn#getictran.trancode#" src="/images/tick.gif" width="15" height="15" style="cursor:pointer; display:none;"><!--- &nbsp;&nbsp;<input type="button" name="Updatebtn#getictran.trancode#" id="updatebtn#getictran.trancode#" onClick="updaterow('#getictran.trancode#');" value="UPDATE" style="display:none"/> ---></td>
</tr>
</cfloop>
<cfquery name="getsumictran" datasource="#dts#">
SELECT sum(qty_bil)as sumqty FROM ictran WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#"> and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tran#"> order by trancode desc
</cfquery>
</table>
</div>


</td>
</tr>

<cfelse>
<tr>
<td colspan="4" height="200">
<cfset datashow = "yes">
<cfif getpin2.h1360 neq 'T'>
<cfset datashow = "no">
</cfif>
<div id="itemlist" style="height:238px; overflow:scroll;">
<table width="100%">
<tr>
<th width="2%">No</th>
<th width="15%">Item Code</th>
<th width="8%" <cfif lcase(hcomid) eq "sosbat_i">style="display:none"</cfif>>S/N</th>
<!---<th width="10%">#getgsetup.laitemno#</th>--->
<th width="30%">Description</th>
<th width="10%" <cfif lcase(hcomid) eq "sosbat_i">style="display:none"</cfif>>Status</th>
<th width="10%">Location</th>
<th width="10%">Quantity</th>

<th width="8%" <cfif lcase(HcomID) eq "imperial1_i" or lcase(HcomID) eq "coolnlite_i"><cfelse>style="display:none"</cfif>>Deductable Item</th>


<th width="8%">Price</th>
<th width="8%">Discount</th>
<th width="8%" <cfif lcase(HcomID) eq "imperial1_i" or lcase(HcomID) eq "coolnlite_i" or lcase(hcomid) eq "sosbat_i">style="display:none"</cfif>>No Display</th>
<th width="8%" <cfif lcase(HcomID) eq "imperial1_i" or lcase(HcomID) eq "coolnlite_i" or lcase(hcomid) eq "sosbat_i">style="display:none"</cfif>>SubTotal</th>
<th width="8%" <cfif lcase(hcomid) eq "sosbat_i">style="display:none"</cfif>>Mechanic</th>
<th width="8%" <cfif lcase(HcomID) eq "imperial1_i" or lcase(HcomID) eq "coolnlite_i" or lcase(hcomid) eq "sosbat_i">style="display:none"</cfif>>Department</th>
<th width="8%" style="display:none">Supp</th>

<th width="8%">Amount</th>
<th width="10%">Action</th>
</tr>
<cfquery name="getictran" datasource="#dts#">
SELECT * FROM ictran WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#"> and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tran#"> order by trancode desc
</cfquery>
<cfloop query="getictran">
<tr <cfif (getictran.currentrow mod 2) eq 0>style="background-color:##33FFFF"</cfif> onMouseOut="javascript:this.style.backgroundColor='<cfif (getictran.currentrow mod 2) eq 0>33FFFF</cfif>';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
<td nowrap>#getictran.currentrow#</td>
<td nowrap>#getictran.itemno#</td>
<!---
<cfquery name="getaitem" datasource="#dts#">
   		select aitemno from icitem where itemno='#getictran.itemno#'
	</cfquery>
<td nowrap>#getaitem.aitemno#</td>--->
<td nowrap align="right" <cfif lcase(hcomid) eq "sosbat_i">style="display:none"</cfif>><input type="text" name="brem1#getictran.trancode#" id="brem1#getictran.trancode#" value="#getictran.brem1#" size="5" onBlur="updaterow('#getictran.trancode#');" onKeyup="if(this.value != '#getictran.brem1#'){document.getElementById('updatebtn#getictran.trancode#').style.display='block';}else{document.getElementById('updatebtn#getictran.trancode#').style.display='none';}"></td>
<cfif getictran.location eq ''>
<cfquery name="getitembalance" datasource="#dts#">
    select 
	a.itemno,
	ifnull(ifnull(a.qtybf,0)+ifnull(b.sumtotalin,0)-ifnull(c.sumtotalout,0),0) as balance
	
	from icitem as a
	
	left join 
	(
		select itemno,sum(qty) as sumtotalin 
		from ictran 
		where type in ('RC','CN','OAI','TRIN') 
		and itemno='#getictran.itemno#' 
		and fperiod<>'99'
		and (void = '' or void is null)
		group by itemno
	) as b on a.itemno=b.itemno
	
	left join 
	(
		select itemno,sum(qty) as sumtotalout 
		from ictran 
		where type in ('INV','DO','DN','CS','OAR','PR','ISS','TROU'<cfif lcase(HcomID) eq "remo_i">,'SO'</cfif>) 
		and itemno='#getictran.itemno#' 
		and fperiod<>'99'
		and (void = '' or void is null)
		and toinv='' 
		group by itemno
	) as c on a.itemno=c.itemno
	
	where a.itemno='#getictran.itemno#' 
    </cfquery>
<cfelse>
<cfquery name="getitembalance" datasource="#dts#">
	select 
	c.balance 
	
	from icitem as a 
	
	left join 
	(
		select 
		location,
		itemno,
		(select desp from iclocation where location=locqdbf.location) as locationdesp 
		from locqdbf
		where itemno=itemno 
		and itemno='#getictran.itemno#' 
		and location = '#getictran.location#' 

	) as b on a.itemno=b.itemno 
	
	left join 
	(
		select 
		a.location,
		a.itemno,
		(ifnull(a.locqfield,0)+ifnull(b.sum_in,0)-ifnull(c.sum_out,0)) as balance 
		
		from locqdbf as a 
		
		left join
		(
			select 
			location,
			itemno,
			sum(qty) as sum_in 
			
			from ictran
			
			where type in ('RC','CN','OAI','TRIN') 
			and fperiod<>'99'
			and itemno='#getictran.itemno#' 
			and location = '#getictran.location#'

			group by location,itemno
			order by location,itemno
		) as b on a.location=b.location and a.itemno=b.itemno
		
		left join
		(
			select 
			location,
            category,
            wos_group,
			itemno,
			sum(qty) as sum_out 
			
			from ictran 
			
			where 
		type in ('INV','DO','DN','CS','OAR','PR','ISS','TROU','SO') 
		and (toinv='' or toinv is null) 
			and fperiod<>'99'
			and itemno='#getictran.itemno#' 
			and location = '#getictran.location#' 
			group by location,itemno
			order by location,itemno
		) as c on a.location=c.location and a.itemno=c.itemno 
		
		where a.itemno=a.itemno
		and a.itemno='#getictran.itemno#' 

		and a.location = '#getictran.location#'

	) as c on a.itemno=c.itemno and b.location=c.location 
	
	where a.itemno=a.itemno 
	and b.location = '#getictran.location#'
    and a.itemno='#getictran.itemno#' 
	order by a.itemno;
</cfquery>
</cfif>

<td nowrap><a onMouseOver="JavaScript:this.style.cursor='hand'" onClick="document.getElementById('itemdesptrancode').value='#getictran.trancode#';ColdFusion.Window.show('itemdesp');">#getictran.desp#</a></td>
<td nowrap <cfif lcase(hcomid) eq "sosbat_i">style="display:none"</cfif>><cfif val(getitembalance.balance) gt 0>STK<cfelse>IND</cfif></td>
<td nowrap>
<!--- <select name="coltypelist#getictran.trancode#" id="coltypelist#getictran.trancode#" onChange="if(this.value != '#getictran.brem1#'){document.getElementById('updatebtn#getictran.trancode#').style.display='block';}else{document.getElementById('updatebtn#getictran.trancode#').style.display='none';}" onclick="if(this.value == '' ">
<option value="Cash n Carry" <cfif getictran.brem1 eq "Cash n Carry">Selected</cfif>>Cash & Carry</option>
<option value="Cash n Delivery" <cfif getictran.brem1 eq "Cash n Delivery">Selected</cfif>>Cash & Delivery</option> 
</select> --->
<select name="coltypelist#getictran.trancode#" id="coltypelist#getictran.trancode#" onChange="updaterow('#getictran.trancode#');">
<option value="">Choose a location</option>
<cfloop query="getlocation">
<option value="#getlocation.location#" <cfif getictran.location eq getlocation.location>selected</cfif>>#getlocation.location# - #getlocation.desp#</option>
</cfloop>
</select>
<!---<input type="text" name="coltypelist#getictran.trancode#" id="coltypelist#getictran.trancode#" value="#getictran.brem1#" onClick="if(this.value=='Collection'){this.value = 'Delivery';updaterow('#getictran.trancode#');} else {this.value = 'Collection';updaterow('#getictran.trancode#');}"  readonly="readonly">---->
</td>
<td nowrap align="right"><input type="text" name="qtylist#getictran.trancode#" id="qtylist#getictran.trancode#" value="#val(getictran.qty_bil)#" size="5" onBlur="updaterow('#getictran.trancode#');" onKeyup="if(this.value != '#val(getictran.qty_bil)#'){document.getElementById('updatebtn#getictran.trancode#').style.display='block';}else{document.getElementById('updatebtn#getictran.trancode#').style.display='none';}"></td>
<!---
<cfquery name="getpacking" datasource="#dts#">
select * from icitem where itemno='#getictran.itemno#'
</cfquery>
<td nowrap align="right">
<select name="promotiontype#getictran.trancode#" id="promotiontype#getictran.trancode#" onChange="updaterow('#getictran.trancode#');">
        <cfloop query="getpacking">
        <option value=""></option>
        </cfloop>
        </select>
        </td>--->
        
        <td <cfif lcase(HcomID) eq "imperial1_i" or lcase(HcomID) eq "coolnlite_i"><cfelse>style="display:none"</cfif>>
        <select name="deductitemlist#getictran.trancode#" id="deductitemlist#getictran.trancode#" onChange="updaterow('#getictran.trancode#');">
<option value="Y" <cfif getictran.deductableitem eq 'Y'>selected</cfif>>Y</option>
<option value="N" <cfif getictran.deductableitem eq 'N' or getictran.deductableitem eq ''>selected</cfif>>N</option>
</select>
        </td>
        
<td nowrap align="right"><a style="cursor:pointer" onClick="document.getElementById('hidtrancode').value='#getictran.trancode#';ColdFusion.Window.show('changeprice');getfocus5();">#numberformat(val(getictran.price_bil),',.__')#</a></td>

<td nowrap align="right"><input type="text" name="brem4#getictran.trancode#" id="brem4#getictran.trancode#" value="#getictran.brem4#" size="5" onBlur="updaterow('#getictran.trancode#');" onKeyup="if(this.value != '#getictran.brem4#'){document.getElementById('updatebtn#getictran.trancode#').style.display='block';}else{document.getElementById('updatebtn#getictran.trancode#').style.display='none';}"></td>

<td <cfif lcase(HcomID) eq "imperial1_i" or lcase(HcomID) eq "coolnlite_i" or lcase(HcomID) eq "sosbat_i">style="display:none"</cfif>>
        <select name="nodisplaylist#getictran.trancode#" id="nodisplaylist#getictran.trancode#" onChange="updaterow('#getictran.trancode#');">
<option value="Y" <cfif getictran.nodisplay eq 'Y'>selected</cfif>>Y</option>
<option value="N" <cfif getictran.nodisplay eq 'N' or getictran.nodisplay eq ''>selected</cfif>>N</option>
</select>
        </td>
<td <cfif lcase(HcomID) eq "imperial1_i" or lcase(HcomID) eq "coolnlite_i" or lcase(HcomID) eq "sosbat_i">style="display:none"</cfif>>
        <select name="subtotallist#getictran.trancode#" id="subtotallist#getictran.trancode#" onChange="updaterow('#getictran.trancode#');">
<option value="Y" <cfif getictran.totalupdisplay eq 'Y'>selected</cfif>>Y</option>
<option value="N" <cfif getictran.totalupdisplay eq 'N' or getictran.totalupdisplay eq ''>selected</cfif>>N</option>
</select>
        </td>
<td nowrap align="right" <cfif lcase(hcomid) eq "sosbat_i">style="display:none"</cfif>><select name="grouplist#getictran.trancode#" id="grouplist#getictran.trancode#" onChange="updaterow('#getictran.trancode#');">
<option value="">Choose a #getgsetup.lgroup#</option>
<cfloop query="getgroup">
<option value="#getgroup.wos_group#" <cfif getictran.brem2 eq getgroup.wos_group>selected</cfif>>#getgroup.wos_group#</option>
</cfloop>
</select></td>
<td nowrap align="right" <cfif lcase(HcomID) eq "imperial1_i" or lcase(HcomID) eq "coolnlite_i" or lcase(HcomID) eq "sosbat_i">style="display:none"</cfif>><select name="catelist#getictran.trancode#" id="catelist#getictran.trancode#" onChange="updaterow('#getictran.trancode#');">
<option value="">Choose a #getgsetup.lproject#</option>
<cfloop query="getproject">
<option value="#getproject.source#" <cfif getictran.source eq getproject.source>selected</cfif>>#getproject.source#</option>
</cfloop>
</select></td>
<td nowrap align="right" style="display:none"><select name="supplist#getictran.trancode#" id="supplist#getictran.trancode#" onChange="updaterow('#getictran.trancode#');">
<option value="">Choose a Supp</option>
<cfloop query="getsupp">
<option value="#getsupp.custno#" <cfif getictran.note1 eq getsupp.custno>selected</cfif>>#getsupp.custno# - #getsupp.name#</option>
</cfloop>
</select></td>


<td nowrap align="right">#numberformat(val(getictran.amt_bil),',.__')#</td>
<td nowrap><input type="button" name="deletebtn#getictran.trancode#" id="deletebtn#getictran.trancode#" onClick="if(confirm('Are You Sure You Want To Delete?')){deleterow('#getictran.trancode#')}" value="DELETE"/>&nbsp;<img id="updatebtn#getictran.trancode#" name="updatebtn#getictran.trancode#" src="/images/tick.gif" width="15" height="15" style="cursor:pointer; display:none;"><!--- &nbsp;&nbsp;<input type="button" name="Updatebtn#getictran.trancode#" id="updatebtn#getictran.trancode#" onClick="updaterow('#getictran.trancode#');" value="UPDATE" style="display:none"/> ---></td>
</tr>
</cfloop>
<cfquery name="getsumictran" datasource="#dts#">
SELECT sum(qty_bil)as sumqty FROM ictran WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#"> and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tran#"> order by trancode desc
</cfquery>
</table>
</div>


</td>
</tr>
</cfif>

<cfset inputtype = "text">

<tr>
<th>Choose a product</th>
<td colspan="1">
<cfinput type="text" name="expressservicelist" id="expressservicelist" size="26" onBlur="this.value = this.value.split('___', 1);getitemdetail(this.value);" onKeyUp="nextIndex(event,'expressservicelist','expqty');" autosuggest="cfc:itemno.findItem({cfautosuggestvalue},'#dts#')" autosuggestminlength="1"/>
<input type="button" id="searchitembtn" onClick="ColdFusion.Window.show('searchitem');getfocus2();" value="Search" align="right" />
<cfif getmodule.package eq '1'>
<input type="button" id="packagebtn" onClick="ColdFusion.Window.show('addpackage');" value="Package" align="right" />
</cfif>
&nbsp;<cfif getpin2.h1310 eq 'T'><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="window.open('/default/maintenance/icitem2.cfm?type=Create&express=1');">New</a></cfif>
<br>


</td>
<th>Total Qty</th>
<td><div id="getqtytotal">
<cfquery name="getsumictran" datasource="#dts#">
SELECT sum(qty_bil)as sumqty FROM ictran WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#"> and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tran#"> order by trancode desc
</cfquery>
<input type="hidden" id="totalrealqty" name="totalrealqty" value="#getsumictran.sumqty#"> 
#getsumictran.sumqty#
</div></td>
<td></td>
</tr>

<tr style="display:none">
<th>Description</th>
<td><input type="text" name="desp2" id="desp2" size="40" onKeyUp="nextIndex(event,'desp','expqty');" ></td>
<th width="100px">Gross</th>
<td><cfinput type="#inputtype#" name="gross" id="gross" readonly="yes" value="0.00"  />
<div id="itembal" style="display:none"></div><div id="itemDetail"  style="display:none"></div></td>
</tr>

<tr>
  <th>Quantity</th>
  <td>
  <input type="text" style="font: large bolder" name="expqty" id="expqty" size="10" maxlength="10" value="1" onKeyUp="calamtadvance();nextIndex(event,'expqty','expressservicelist');<cfif getgsetup.expressdisc neq "1">document.getElementById('expqtycount').value = this.value;</cfif>" >

  <cfselect style="display:none" name="expunit" id="expunit"  onKeyUp="nextIndex(event,'expunit','expprice');" onChange="ajaxFunction(document.getElementById('ajaxfieldgetunitprice'),'/default/transaction/vehicletranedit/getunitpriceAjax.cfm?itemno='+document.getElementById('expressservicelist').value+'&unit='+document.getElementById('expunit').value);setunitprice();"></cfselect>
  <div id="ajaxfieldgetunitprice"></div>
  <th>Discount</th>
<td>
 <cfinput type="#inputtype#" size="3" name="dispec1" id="dispec1" value="0" validate="float" validateat="onblur" message="Please key in numeric value" onKeyUp="calcdisc();caltax();calcfoot();" />%<input type="hidden" name="disbil1" id="disbil1" />&nbsp;&nbsp;
  <cfinput type="#inputtype#" size="3" name="dispec2" id="dispec2" value="0" validate="float" validateat="onblur" message="Please key in numeric value" onKeyUp="calcdisc();caltax();calcfoot();"/>%<input type="hidden" name="disbil2" id="disbil2" />&nbsp;&nbsp;
  <cfinput type="#inputtype#" size="3" name="dispec3" id="dispec3" value="0" validate="float" validateat="onblur" message="Please key in numeric value" onKeyUp="calcdisc();caltax();calcfoot();"/>%<input type="hidden" name="disbil3" id="disbil3" />&nbsp;&nbsp;&nbsp;
  <cfinput type="#inputtype#" size="5" name="disamt_bil" id="disamt_bil" value="0.00" validate="float" validateat="onblur" message="Please key in numeric value" onKeyUp="document.getElementById('net').value= ((document.getElementById('gross').value * 1)-(document.getElementById('disamt_bil').value*1)).toFixed(2);caltax();calcfoot();" />
</td> 
  </td>
</tr>

<tr>
  <th>Price</th>
  <td><input type="<cfif getpin2.h1360 eq 'T'>text<cfelse>hidden</cfif>" name="expprice" id="expprice" size="15" maxlength="15" value="0.00" onKeyUp="calamtadvance();nextIndex(event,'expprice',<cfif getgsetup.expressdisc eq "1">'expunitdis1'<cfelse>'expqtycount'</cfif>)"  >
  <input type="hidden" name="expunitdis1" id="expunitdis1" size="5" value="0" />
<input type="hidden" name="expunitdis2" id="expunitdis2" size="5" value="0" />
<input type="hidden" name="expunitdis3" id="expunitdis3" size="5" value="0" />
<input type="hidden" name="expqtycount" id="expqtycount" size="3" value="1" onKeyUp="caldisamt();calamtadvance();nextIndex(event,'expqtycount','expunitdis')" >
<input type="hidden" name="expunitdis" id="expunitdis" size="5" value="0.00" onKeyUp="caldisamt();calamtadvance();nextIndex(event,'expdis','btn_add')" />
<input type="hidden" name="expdis" id="expdis" size="10" maxlength="10" value="0.00" onKeyUp="calamtadvance();nextIndex(event,'expdis','btn_add')" onBlur="calamtadvance();">
<input type="hidden" name="expressamt" id="expressamt" size="10" value="0.00" readonly >
  
  </td>
  <th>NET</th>
<td><cfinput type="#inputtype#" name="net" id="net" value="0.00" readonly="yes" /> </td>
</tr>
<tr>
<th></th><td style="visibility:hidden">
<cfselect name="nextransac" id="nextransac" bind="cfc:nextran.newtran('#dts#','#refno#','#tran#',{expressservicelist})" bindonload="yes" display="trancode" value="trancode"/>
</td>
<th>Tax</th>
<td>

<input type="checkbox" name="taxincl" id="taxincl" value="T" onClick="caltax()" <cfif getcustremark.taxincl eq "T">checked </cfif> />&nbsp;
  <cfquery name="getTaxCode" datasource="#dts#">
  SELECT "" as code, "" as rate1
  union all
  SELECT code,rate1 FROM #target_taxtable#
  </cfquery>
  <cfquery name="getdf" datasource="#dts#">
        SELECT df_salestax,df_purchasetax FROM gsetup
        </cfquery>
        
        <cfquery name="taxrate" datasource="#dts#">
        
		<cfif (tran eq 'RC' or tran eq 'PO' or tran eq 'PR') and getcustremark.note neq "">
        SELECT 
        "#getcustremark.note#" as code
         union all
        <cfelseif tran eq 'DN' or tran eq 'CN'>
        <cfelseif getcustremark.note neq "">
        SELECT 
        "#getcustremark.note#" as code
         union all
		</cfif>
        SELECT code FROM #target_taxtable# 
        <cfif tran eq 'RC' or tran eq 'PO' or tran eq 'PR' >
        WHERE tax_type <> "ST"
        <cfif getcustremark.note neq "">
        and code <> "#getcustremark.note#"
		</cfif>
        <cfelseif tran eq 'DN' or tran eq 'CN' >
        <cfelse>
        WHERE tax_type <> "PT"
        <cfif getcustremark.note neq "">
        and code <> "#getcustremark.note#"
		</cfif>
        </cfif>
        </cfquery>
<cfselect name="taxcode" id="taxcode" query="taxrate" value="code" display="code" onChange="setTimeout('caltax()',500);" bindonload="yes"/>
  <!---<input type="hidden" name="taxcode" id="taxcode" value="ZR">--->
  &nbsp;&nbsp;<cfinput type="#inputtype#" name="taxper" id="taxper" value="#getgsetup.gst#" size="8" bind="CFC:tax.getTax('#dts#','#target_taxtable#',{taxcode})" onKeyUp="caltax()" />&nbsp;&nbsp;&nbsp;
  <cfinput type="#inputtype#" name="taxamt" id="taxamt" value="0.00" size="10" onKeyUp="calcfoot();" />  
</td>
</tr>
<tr>
<td></td><td></td><th>Total Amount</th><td><cfinput type="text" style="font: x-large bolder; color:##000; background-color:##FFFF66" name="grand" id="grand" value="0.00" readonly="yes" onClick="calcfoot();"/></td>
</tr>

<tr style="display:none"><td colspan="4" align="center"><input type="hidden" name="paytype" id="paytype" value=""><input name="btn_add" style="font: medium bolder" id="btn_add" type="button" value="Add" onClick="addnewitem2();" style="display:none">&nbsp;&nbsp;&nbsp;
<cfinput type="hidden" name="cash" id="cash" value="0.00">
  <cfinput type="hidden" name="credit_card1" id="credit_card1" value="0.00">
  <cfinput type="hidden" name="realdeposit" id="realdeposit" value="">
  <cfinput type="hidden" name="credit_card2" id="credit_card2" value="0.00">
  <cfinput type="hidden" name="creditcardtype" id="creditcardtype" value="">
  <cfinput type="hidden" name="debit_card" id="debit_card" value="0.00">
  <cfinput type="hidden" name="cheque" id="cheque" value="0.00">
  <cfinput type="hidden" name="voucher" id="voucher" value="0.00">
  <cfinput type="hidden" name="deposit" id="deposit" value="0.00">
  <cfinput type="hidden" name="balance" id="balance" value="0.00">
  <cfinput type="hidden" name="changeamt1" id="changeamt1" value="0.00">
  <cfinput type="hidden" name="cashcamt" id="cashcamt" value="0.00">
  <cfinput type="hidden" name="cctype" id="cctype" value="">
  <cfinput type="hidden" name="cctype2" id="cctype2" value="">
  <cfinput type="hidden" name="checkno" id="checkno" value="">
  <cfinput type="hidden" name="rem7" id="rem7" value="#rem7#">
  <cfinput type="hidden" name="rem6" id="rem6" value="#rem6#">
  <cfset counter = "">
  
  <!--- <cfinput type="hidden" name="rem9" id="rem9" value=""> --->
</td></tr>
  <tr><td colspan="4" height="2px"><hr></td></tr>
<tr style="display:none">
  <td height="1px" colspan="4" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<cfinput type="button" style="font: medium bolder; display:none" name="Close" id="Close" value="Close" onClick="window.close();"/><div id="ajaxFieldPro" name="ajaxFieldPro" style="display:none"> </div></td>
</tr>

<tr>
<td colspan="1">
<table align="left" border="1">
<tr>
<td colspan="3">


<input type="hidden" name="rem30" id="rem30" value="">
<input type="hidden" name="d_name" id="d_name" value="">
<input type="hidden" name="d_name2" id="d_name2" value="">
<input type="hidden" name="d_add1" id="d_add1" value="">
<input type="hidden" name="d_add2" id="d_add2" value="">
<input type="hidden" name="d_add3" id="d_add3" value="">
<input type="hidden" name="d_add4" id="d_add4" value="">
<input type="hidden" name="d_attn" id="d_attn" value="">
<input type="hidden" name="d_phone" id="d_phone" value="">
<input type="hidden" name="d_fax" id="d_fax" value="">
</td>
</tr>
</table></td>
<td colspan="3">
<table>
<tr>
<td width="30%">&nbsp;</td>
<td align="center">
<cfinput type="button" style="font: medium bolder;background-color:##FFCC00; color:##FFFFFF" name="Submit" id="Submit2" value="Accept and Print" onClick="document.getElementById('acceptprint').value = '1';document.getElementById('Submit2').disabled = true;document.getElementById('Submit').disabled = true;validformfield();" disabled/>
<cfinput type="hidden" name="acceptprint" id="acceptprint" value="">
<div <cfif lcase(hcomid) neq "ltm_i">style="display:none"</cfif>>&nbsp;&nbsp;&nbsp;<cfinput type="button" style="font: medium bolder;background-color:##FFCC00; color:##FFFFFF" name="Submit" id="Submit3" value="On Hold" onClick="document.getElementById('onholdfield').value = 'OH';document.getElementById('Submit').disabled = true;document.getElementById('Submit2').disabled = true;document.getElementById('Submit3').disabled = true;validformfield();" disabled/></div>
<cfinput type="hidden" name="onholdfield" id="onholdfield" value="A">
<!---
<input name="pay_btn" style="font: medium bolder;background-color:##FFCC00; color:##FFFFFF" id="btn_add" type="submit" value="Accept" size="15">--->
<!---
<input name="pay_btn" style="font: medium bolder;background-color:##FFCC00; color:##FFFFFF" id="btn_add" type="button" value="Accept" size="15" onClick="document.getElementById('paytype').value='6';gopay('totalup6');">--->
</td>
</tr>
</table>
</td>
</tr>

</table>
</cfoutput>
</cfform>


<cfif getdealermenu.itemformat eq '2'>
<cfwindow center="true" width="700" height="500" name="searchitem" refreshOnShow="true" closable="true" modal="false" title="Search Item" initshow="false"
        source="/default/transaction/vehicletranedit/searchitem2.cfm?reftype={tran}" />
<cfelse>
<cfwindow center="true" width="700" height="500" name="searchitem" refreshOnShow="true" closable="true" modal="false" title="Search Item" initshow="false"
        source="/default/transaction/vehicletranedit/searchitem.cfm?reftype={tran}" />
</cfif>

<cfwindow center="true" width="700" height="500" name="addpackage" refreshOnShow="true" closable="true" modal="false" title="Package" initshow="false"
        source="/default/transaction/vehicletranedit/addpackage.cfm?reftype={tran}" />
       
        
<cfwindow center="true" width="600" height="400" name="changedaddr" refreshOnShow="true" closable="true" modal="false" title="Search Address" initshow="false"
        source="/default/transaction/vehicletranedit/searchaddress.cfm" /> 
        
<cfwindow center="true" width="600" height="400" name="changeadd" refreshOnShow="true" closable="true" modal="false" title="Search Address" initshow="false"
        source="/default/transaction/vehicletranedit/searchaddress.cfm" /> 
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


<cfwindow center="true" width="600" height="600" name="neweu" refreshOnShow="true" closable="true" modal="true" title="Create New Member" initshow="false" source="neweu.cfm" />  
<cfwindow center="true" width="250" height="150" name="changeprice" refreshOnShow="true" closable="true" modal="true" title="Edit Price" initshow="false" source="changeprice.cfm?refno=#refno#&tran=#tran#&trancode={hidtrancode}" />  
<cfwindow center="true" width="700" height="550" name="searchmember" refreshOnShow="true" closable="true" modal="true" title="Search Member" initshow="false" source="searchmember.cfm?main={checkmain}" />  
<cfwindow center="true" width="700" height="550" name="remarks" refreshOnShow="true" closable="true" modal="true" title="Search Member" initshow="false" source="remarks.cfm?custno={custno}" />  
<cfwindow center="true" width="700" height="550" name="itemdesp" refreshOnShow="true" closable="true" modal="true" title="Change Item Description" initshow="false" source="itemdesp.cfm?refno=#refno#&tran=#tran#&trancode={itemdesptrancode}" /> 
<cfwindow center="true" width="550" height="400" name="findCustomer" refreshOnShow="true"
        title="Find Customer or Supplier" initshow="false"
        source="findCustomer.cfm?type={tran}&custno={custno}" />
<cfwindow center="true" width="550" height="400" name="findvehicle" refreshOnShow="true"
        title="Find Vehicle" initshow="false"
        source="findvehicle.cfm?type={tran}&vehino={rem5}" />
<cfwindow x="10" y="10" modal="true"  width="1100" height="600" name="createCustomer" refreshOnShow="true"
        title="Add New Customer" initshow="false"
        source="/default/maintenance/shellvehicles/createCustomerAjax.cfm" />
<cfwindow x="10" y="10" modal="true"  width="1100" height="600" name="createSupplier" refreshOnShow="true"
        title="Add New Supplier" initshow="false"
        source="/default/maintenance/shellvehicles/createSupplierAjax.cfm" />
 <cfoutput>
 <script type="text/javascript">
 <cfif isdefined('url.refno')>
 setTimeout('findVehicle(0)','1000');
  
 setTimeout("selectOptionByValue(document.getElementById('custno'),'#getcustremark.custno#');",2000);
 setTimeout("selectOptionByValue(document.getElementById('permitno'),'#getcustremark.permitno#');",3500)
 
 setTimeout('getcustomer()','2000');

 setTimeout("selectOptionByValue(document.getElementById('agent'),'#agenno#');",3500);
 setTimeout("selectOptionByValue(document.getElementById('multiagent1'),'#zmultiagent1#');",3500);
 
 
 recalculateamt();
 setTimeout('caltax()','1000');
 </cfif>
 setTimeout("selectOptionByValue(document.getElementById('term'),'#zterm#');",3500);
 </script>
 </cfoutput>
