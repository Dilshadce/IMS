<cfajaximport tags="cfform">
<cfajaximport tags="cfwindow,cflayout-tab"> 

<cfquery name="GetSetting" datasource="#dts#">
SELECT EDControl,refno2#tran# as refno2valid,ASACTP FROM gsetup 
</cfquery>

<cfif getSetting.EDControl eq "Y" and url.ttype eq "Delete">
<cfajaximport tags="cfform">
<cfwindow center="true" width="350" height="300" name="exampass" refreshOnShow="true" closable="false" modal="true" title="Enter Password" initshow="true"
        source="/default/transaction/exampass/exampass.cfm?type=delete" />
</cfif>
<cfset session.hcredit_limit_exceed = "">
<cfset session.bcredit_limit_exceed = "">
<cfset session.customercode = "">
<cfset session.tran_refno = "">

<cfparam name="xrelated" default="0">
<cfparam name="alcreate" default="0">
<cfparam name="Submit" default="">
<cfparam name="ChgBillToAddr" default="">
<cfparam name="ChgDeliveryAddr" default="">
<cfparam name="ChgCollectFromAddr" default="">
<cfparam name="Scust" default="">

<cfif tran eq "RC">
  	<cfset tran = "RC">
  	<cfset tranname = "Purchase Receive">
  	<cfset trancode = "rcno">
  	<cfset tranarun = "rcarun">

  	<cfif getpin2.h2102 eq 'T'>
  		<cfset alcreate = 1>
  	</cfif>
<cfelseif tran eq "PR">
  	<cfset tran = "PR">
  	<cfset tranname = "Purchase Return">
  	<cfset trancode = "prno">
  	<cfset tranarun = "prarun">

  	<cfif getpin2.h2201 eq 'T'>
 		<cfset alcreate = 1>
  	</cfif>
<cfelseif tran eq "DO">
	<cfset tran = "DO">
	<cfset tranname = "Delivery Order">
	<cfset trancode = "dono">
    <cfset tranarun = "doarun">

	<cfif getpin2.h2301 eq 'T'>
  		<cfset alcreate = 1>
  	</cfif>
<cfelseif tran eq "INV">
  	<cfset tran = "INV">
  	<cfset tranname = "Invoice">
  	<cfset trancode = "invno">
  	<cfset tranarun = "invarun">

	<cfif getpin2.h2401 eq 'T'>
  		<cfset alcreate = 1>
  	</cfif>
<cfelseif tran eq "CS">
  	<cfset tran = "CS">
  	<cfset tranname = "Cash Sales">
  	<cfset trancode = "csno">
  	<cfset tranarun = "csarun">

	<cfif getpin2.h2501 eq 'T'>
  		<cfset alcreate = 1>
  	</cfif>
<cfelseif tran eq "CN">
  	<cfset tran = "CN">
  	<cfset tranname = "Credit Note">
  	<cfset trancode = "cnno">
  	<cfset tranarun = "cnarun">

	<cfif getpin2.h2601 eq 'T'>
  		<cfset alcreate = 1>
  	</cfif>
<cfelseif tran eq "DN">
  	<cfset tran = "DN">
  	<cfset tranname = "Debit Note">
  	<cfset trancode = "dnno">
  	<cfset tranarun = "dnarun">

	<cfif getpin2.h2701 eq 'T'>
  		<cfset alcreate = 1>
  	</cfif>
<cfelseif tran eq "PO">
  	<cfset tran = "PO">
  	<cfset tranname = "Purchase Order">
  	<cfset trancode = "pono">
  	<cfset tranarun = "poarun">

	<cfif getpin2.h2861 eq 'T'>
  		<cfset alcreate = 1>
  	</cfif>
<cfelseif tran eq "QUO">
  	<cfset tran = "QUO">
  	<cfset tranname = "Quotation">
  	<cfset trancode = "quono">
  	<cfset tranarun = "quoarun">

	<cfif getpin2.h2871 eq 'T'>
  		<cfset alcreate = 1>
  	</cfif>
<cfelseif tran eq "SO">
  	<cfset tran = "SO">
  	<cfset tranname = "Sales Order">
  	<cfset trancode = "sono">
  	<cfset tranarun = "soarun">

	<cfif getpin2.h2881 eq 'T'>
 		<cfset alcreate = 1>
  	</cfif>
<cfelseif tran eq "SAM">
	<cfset tran = "SAM">
	<cfset tranname = "Sample">
	<cfset trancode = "samno">
	<cfset tranarun = "samarun">

	<cfif getpin2.h2851 eq 'T'>
  		<cfset alcreate = 1>
  	</cfif>
</cfif>

<cfquery datasource="#dts#" name="getGsetup">
	Select invoneset,rc_oneset,pr_oneset,do_oneset,cs_oneset,cn_oneset,dn_oneset,iss_oneset,
	po_oneset,so_oneset, quo_oneset, assm_oneset, tr_oneset, oai_oneset, oar_oneset, sam_oneset,
	filterall,suppcustdropdown,debtorfr,debtorto,creditorfr,creditorto,keepDeletedBills 
	from GSetup
</cfquery>

<!--- Add On 11-01-2010 --->
<cfquery name="getdealer_menu" datasource="#dts#">
	select custSuppSortBy,productSortBy,transactionSortBy from dealer_menu limit 1
</cfquery>

<cfquery name="showall" datasource="#dts#">
	select 
	* 
	from #target_currency#;
</cfquery>

<html>
<head>
	<title><cfoutput>#tranname#</cfoutput></title>
	<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
	<link href="../../scripts/CalendarControl.css" rel="stylesheet" type="text/css">
	<script language="javascript" type="text/javascript" src="../../scripts/CalendarControl.js"></script>
    <script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
	
	<script type='text/javascript' src='../../ajax/core/engine.js'></script>
	<script type='text/javascript' src='../../ajax/core/util.js'></script>
	<script type='text/javascript' src='../../ajax/core/settings.js'></script>
	<script src="../../SpryAssets/SpryValidationTextField.js" type="text/javascript"></script>
	<script src="../../SpryAssets/SpryValidationSelect.js" type="text/javascript"></script>
	
	<script type="text/javascript">
		function displayrate()
	{
		if(document.getElementById('currcode').value !=""){
			<cfoutput query ="showall">
			if(document.getElementById('currcode').value == "#showall.currcode#")
			{
				document.getElementById('currency').value = "#showall.currency#";
				document.getElementById('currency1').value = "#showall.currency1#";
			}		
			</cfoutput>	
		}else{
			document.getElementById('currency').value = "";
			document.getElementById('currency1').value = "";
		}
	}
		function getCustSupp(option){
			var inputtext = document.invoicesheet.searchcustsupp.value;
			DWREngine._execute(_tranflocation, null, 'supplierlookup', inputtext, option, getCustSuppResult);
		}

		function getCustSuppResult(custsuppArray){
			DWRUtil.removeAllOptions("custno");
			DWRUtil.addOptions("custno", custsuppArray,"KEY", "VALUE");
			updateDetails(document.invoicesheet.custno[0].value);
		}
		
		function updateDetails(columnvalue){
			var tran = document.invoicesheet.tran.value;
			var tablename = document.invoicesheet.ptype.value;
			DWREngine._execute(_tranflocation, null, 'getCustSuppDetails', tablename, columnvalue, tran, showCustSuppDetails);
		}
		
		function showCustSuppDetails(CustSuppObject){
			DWRUtil.setValue("name", CustSuppObject.B_NAME);
			DWRUtil.setValue("name2", CustSuppObject.B_NAME2);
			DWRUtil.setValue("b_name", CustSuppObject.B_NAME);
			DWRUtil.setValue("b_name2", CustSuppObject.B_NAME2);
			DWRUtil.setValue("b_add1", CustSuppObject.B_ADD1);
			DWRUtil.setValue("b_add2", CustSuppObject.B_ADD2);
			DWRUtil.setValue("b_add3", CustSuppObject.B_ADD3);
			DWRUtil.setValue("b_add4", CustSuppObject.B_ADD4);
			DWRUtil.setValue("b_add5", CustSuppObject.B_ADD5);
			DWRUtil.setValue("b_attn", CustSuppObject.B_ATTN);
			DWRUtil.setValue("b_phone", CustSuppObject.B_PHONE);
			DWRUtil.setValue("b_fax", CustSuppObject.B_FAX);
			DWRUtil.setValue("b_phone2", CustSuppObject.B_PHONE2);
			<cfif GetSetting.ASACTP eq "N">
			DWRUtil.setValue("BCode", "");
			</cfif>
			if(CustSuppObject.TRAN == 'PO' || CustSuppObject.TRAN == 'SO' || CustSuppObject.TRAN == 'INV' || CustSuppObject.TRAN == 'DO'){

			<cfif  url.tran eq "PO" and lcase(HcomID) eq "topsteel_i" >
			<cfelse>
			<cfif GetSetting.ASACTP neq "N">
				DWRUtil.setValue("DCode", CustSuppObject.DCODE);
			</cfif>
				DWRUtil.setValue("d_name", CustSuppObject.D_NAME);
				
				DWRUtil.setValue("d_name2", CustSuppObject.D_NAME2);
				</cfif>
				DWRUtil.setValue("d_add1", CustSuppObject.D_ADD1);
				DWRUtil.setValue("d_add2", CustSuppObject.D_ADD2);
				DWRUtil.setValue("d_add3", CustSuppObject.D_ADD3);
				DWRUtil.setValue("d_add4", CustSuppObject.D_ADD4);
				DWRUtil.setValue("d_add5", CustSuppObject.D_ADD5);
				DWRUtil.setValue("d_attn", CustSuppObject.D_ATTN);
				DWRUtil.setValue("d_phone", CustSuppObject.D_PHONE);
				DWRUtil.setValue("d_fax", CustSuppObject.D_FAX);
			}
		}
		
		function getCustSupp2(custno,custname){
			<cfif getGsetup.suppcustdropdown eq "1">	
				myoption = document.createElement("OPTION");
				myoption.text = custno + " - " + custname;
				myoption.value = custno;
				document.invoicesheet.custno.options.add(myoption);
				var indexvalue = document.getElementById("custno").length-1;
				document.getElementById("custno").selectedIndex=indexvalue;
				updateDetails(document.invoicesheet.custno[indexvalue].value);
			<cfelse>
				document.getElementById("custno").value=custno;
				updateDetails(custno);
			</cfif>
		}
		function selectlist(custno){
			<cfif getGsetup.suppcustdropdown eq "1">	
			for (var idx=0;idx<document.getElementById('custno').options.length;idx++) {
        if (custno==document.getElementById('custno').options[idx].value) {
            document.getElementById('custno').options[idx].selected=true;
			updateDetails(custno);
        }
    } 
			<cfelse>
				document.getElementById("custno").value=custno;
				updateDetails(custno);
			</cfif>
		}

		function assignCust(type){
			checkboxObj=document.getElementById("internalrc");
			//document.getElementById("custno").value='ASSM/999';
			
			if(document.getElementById("custno").value != 'ASSM/999'){
				if(type=='dropdown'){
					DWRUtil.removeAllOptions("custno");
					myoption = document.createElement("OPTION");
					myoption.text = 'ASSM/999';
					myoption.value = 'ASSM/999';
					document.getElementById("custno").options.add(myoption);
				}else{
					document.getElementById("custno").value='ASSM/999';
				}
				updateDetails('ASSM/999');
			}
			else{
				if(type=='dropdown'){
					var inputtext = '';
					DWREngine._execute(_tranflocation, null, 'supplierlookup', inputtext, 'Supplier', getCustSuppResult);
				}else{
					document.getElementById("custno").value='';
					updateDetails('');
				}
			}
			checkboxObj.checked =false;
		}
		
		function showsa(){
	
			if(document.getElementById('collectadd').style.display=='block'){
				document.getElementById('collectadd').style.display = 'none';
			}else{
				document.getElementById('collectadd').style.display = 'block';
			}
		}
		
		function showsd(){
	
			if(document.getElementById('deliveryadd').style.display=='block'){
				document.getElementById('deliveryadd').style.display = 'none';
			}else{
				document.getElementById('deliveryadd').style.display = 'block';
			}
		}

		function setCollectAddress(codenum)
		{
			var codename = codenum + "CCode";
			var colname = codenum + "CName";
			var col_add1 = codenum + "c_add1";
			var col_add2 = codenum + "c_add2";
			var col_add3 = codenum + "c_add3";
			var col_add4 = codenum + "c_add4";
			var col_attn = codenum + "c_attn";
			var col_phone = codenum + "c_phone";
			var col_fax = codenum + "c_fax";
			
			document.getElementById('CCode').value = document.getElementById(codename).value;
			document.getElementById('c_name').value = document.getElementById(colname).value;
			document.getElementById('c_add1').value = document.getElementById(col_add1).value;
			document.getElementById('c_add2').value = document.getElementById(col_add2).value;
			document.getElementById('c_add3').value = document.getElementById(col_add3).value;
			document.getElementById('c_add4').value = document.getElementById(col_add4).value;
			document.getElementById('c_attn').value = document.getElementById(col_attn).value;
			document.getElementById('c_phone').value = document.getElementById(col_phone).value;
			document.getElementById('c_fax').value = document.getElementById(col_fax).value;
			document.getElementById('collectadd').style.display = 'none';
		}

		function setDeliveryAddress(codenum)
		{
			var codename = codenum + "DCode";
			var colname = codenum + "DName";
			var col_add1 = codenum + "d_add1";
			var col_add2 = codenum + "d_add2";
			var col_add3 = codenum + "d_add3";
			var col_add4 = codenum + "d_add4";
			var col_attn = codenum + "d_attn";
			var col_phone = codenum + "d_phone";
			var col_fax = codenum + "d_fax";
			
			document.getElementById('DCode').value = document.getElementById(codename).value;
			document.getElementById('d_name').value = document.getElementById(colname).value;
			document.getElementById('d_add1').value = document.getElementById(col_add1).value;
			document.getElementById('d_add2').value = document.getElementById(col_add2).value;
			document.getElementById('d_add3').value = document.getElementById(col_add3).value;
			document.getElementById('d_add4').value = document.getElementById(col_add4).value;
			document.getElementById('d_attn').value = document.getElementById(col_attn).value;
			document.getElementById('d_phone').value = document.getElementById(col_phone).value;
			document.getElementById('d_fax').value = document.getElementById(col_fax).value;
			document.getElementById('deliveryadd').style.display = 'none';
		}

		function setCollectField(codenum,colname,col_add1,col_add2,col_add3,col_add4,col_attn,col_phone,col_fax)
		{
			document.getElementById('CCode').value = codenum;
			document.getElementById('c_name').value = colname;
			document.getElementById('c_add1').value = col_add1;
			document.getElementById('c_add2').value = col_add2;
			document.getElementById('c_add3').value = col_add3;
			document.getElementById('c_add4').value = col_add4;
			document.getElementById('c_attn').value = col_attn;
			document.getElementById('c_phone').value = col_phone;
			document.getElementById('c_fax').value = col_fax;
		}

		function setDeliveryField(codenum,colname,col_add1,col_add2,col_add3,col_add4,col_attn,col_phone,col_fax)
		{
			document.getElementById('DCode').value = codenum;
			document.getElementById('d_name').value = colname;
			document.getElementById('d_add1').value = col_add1;
			document.getElementById('d_add2').value = col_add2;
			document.getElementById('d_add3').value = col_add3;
			document.getElementById('d_add4').value = col_add4;
			document.getElementById('d_attn').value = col_attn;
			document.getElementById('d_phone').value = col_phone;
			document.getElementById('d_fax').value = col_fax;
		}

		function MM_openBrWindow(theURL,winName,features) { //v2.0
		  	window.open(theURL,winName,features);
		}
		
		function checkcustno()
{
var custnoStatus = document.getElementById('cust_noApproval').value;

if (custnoStatus == 1)
{
document.CreateCustomer.SubmitButton.disabled = false;
}
else
{
document.CreateCustomer.SubmitButton.disabled = true;
}
}
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


function chgtx() {
document.getElementById('GSTNO').disabled = document.getElementById('ngst_cust').checked;
} 

	</script>
    <link href="../../SpryAssets/SpryValidationTextField.css" rel="stylesheet" type="text/css">
    <link href="../../SpryAssets/SpryValidationSelect.css" rel="stylesheet" type="text/css">
</head>

<cfif tran eq "rc" or tran eq "pr" or tran eq "po">
	<cfset ptype = target_apvend>
	<cfset ptype1 = "Supplier">
<cfelse>
	<cfset ptype = target_arcust>
	<cfset ptype1 = "Customer">
</cfif>

<!--- REMARK ON 09-12-2009, MOVE TO UPPER --->
<!--- <cfquery datasource="#dts#" name="getGsetup">
	Select invoneset,rc_oneset,pr_oneset,do_oneset,cs_oneset,cn_oneset,dn_oneset,iss_oneset,
	po_oneset,so_oneset, quo_oneset, assm_oneset, tr_oneset, oai_oneset, oar_oneset, sam_oneset,filterall,suppcustdropdown 
	from GSetup
</cfquery> --->

<!--- REMARK ON 16-06-2009 and REPLACE WITH THE BELOW ONE --->
<!--- <cfif lcase(hcomid) eq "ecraft_i" or lcase(hcomid) eq "ovas_i">
	<cfquery name="getcustsupp" datasource="#dts#">
   		select custno as xcustno,name from #ptype# order by custno
	</cfquery>
</cfif> --->
<cfif getGsetup.suppcustdropdown eq "1">
	<!--- <cfquery name="getcustsupp" datasource="#dts#">
   		select custno as xcustno,name from #ptype# order by <cfif lcase(HcomID) eq "iel_i" or lcase(HcomID) eq "ielm_i">custno,name<cfelse>name,custno</cfif>
	</cfquery> --->
	<cfquery name="getcustsupp" datasource="#dts#">
   		select custno as xcustno,name from #ptype# order by <cfif getdealer_menu.custSuppSortBy neq "">#getdealer_menu.custSuppSortBy#<cfelse>name,custno</cfif>
	</cfquery>
</cfif>

<cfif isdefined("form.invset") or isdefined("invset") and invset neq 0>
	<cfquery datasource="#dts#" name="getGeneralInfo">
		select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse
        from refnoset
		where type = '#tran#'
		and counter = '#invset#'
	</cfquery>
	<cfset counter = invset>
<cfif isdefined("form.invset2") and GetSetting.refno2valid eq "1">
	<cfquery datasource="#dts#" name="getrefno2set">
		select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse
        from refnoset
		where type = '#tran#'
		and counter = '#form.invset2#'
	</cfquery>
    <cfif getrefno2set.arun eq "1">
    <cfinvoke component="cfc.refno" method="processNum" oldNum="#getrefno2set.tranno#" returnvariable="newnextrefno2" />
    <cfif getrefno2set.presuffixuse eq "1">
    <cfset newnextrefno2 = getrefno2set.refnocode&newnextrefno2&getrefno2set.refnocode2>
	</cfif>
    <cfelse>
    <cfset newnextrefno2 = "">	
    </cfif>
</cfif>
<cfelse>
	<cfif HcomID eq "pnp_i">
		<cfinclude template="../../pnp/get_target_refno.cfm">
		<cfset invset = 0>
		<cfset counter = 1>
	<cfelse>
		<!---cfquery datasource="#dts#" name="getGeneralInfo">
			select #trancode# as tranno, #tranarun# as arun,invoneset from GSetup
		</cfquery--->
		<!--- <cfquery datasource="main" name="getGeneralInfo">
			select lastUsedNo as tranno, refnoused as arun from refnoset
			where userDept = '#dts#'
			and type = '#tran#'
			and counter = 1
		</cfquery> --->
		<cfquery datasource="#dts#" name="getGeneralInfo">
			select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse 
            from refnoset
			where type = '#tran#'
			and counter = 1
		</cfquery>
		<cfset invset = 1>
		<cfset counter = 1>
	</cfif>
	
</cfif>

<!--- REMARK ON 16-06-2009 --->
<!--- <cfquery datasource="#dts#" name="getGsetup">
	Select invoneset,rc_oneset,pr_oneset,do_oneset,cs_oneset,cn_oneset,dn_oneset,iss_oneset,
	po_oneset,so_oneset, quo_oneset, assm_oneset, tr_oneset, oai_oneset, oar_oneset, sam_oneset,filterall
	from GSetup
</cfquery> --->

<cfoutput>
<cfif (Submit eq "  Create  " or Submit eq "  Edit  " or Submit eq "  Delete  " or Submit eq "Update Address")>
<cfquery name="validar" datasource="#dts#">
    Select custno from #target_arcust# where custno = "#form.custno#"
    </cfquery>
    <cfquery name="validap" datasource="#dts#">
    Select custno from #target_apvend# where custno = "#form.custno#"
    </cfquery>
    <cfif validar.recordcount neq 1 and validap.recordcount neq 1 and form.custno neq "ASSM/999">
    <script type="text/javascript">
	alert('The debtor or creditor number is not existed.');
	history.go(-1);
    </script>
	</cfif>
<!---     <cfif isdefined("form.invset") eq false> --->
    <cfif (Submit eq "  Create  " or Submit eq "Update Address") and trim(form.nexttranno) neq "">
    <cfquery name="validaterefno" datasource="#dts#">
    SELECT refno FROM artran WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.nexttranno)#"> and type = "#tran#"
    </cfquery>
    <cfif validaterefno.recordcount neq 0>
    <cfabort>
    <script type="text/javascript">
	alert('The Reference No Existed.');
	history.go(-1);
    </script>
<!---   
    </cfif> --->
    </cfif>
    </cfif>
	<form name="invoicesheet" id="invoicesheet" action="transaction2.cfm" method="post" onSubmit="return test()">
		<input type="hidden" name="nexttranno" value="#trim(form.nexttranno)#">
		<input type="hidden" name="invoicedate" value="#form.invoicedate#">
		<input type="hidden" name="custno" value="#form.custno#">
		<input type="hidden" name="name" value="#name#">
		<input type="hidden" name="name2" value="#name2#">
		<input type="hidden" name="bcode" value="#form.bcode#">
		<input type="hidden" name="dcode" value="#form.dcode#">
		<input type="hidden" name="b_name" value="#b_name#">
		<input type="hidden" name="b_name2" value="#b_name2#">
		<input type="hidden" name="b_add1" value="#b_add1#">
		<input type="hidden" name="b_add2" value="#b_add2#">
		<input type="hidden" name="b_add3" value="#b_add3#">
		<input type="hidden" name="b_add4" value="#b_add4#">
		<input type="hidden" name="b_add5" value="#b_add5#">
		<input type="hidden" name="b_attn" value="#b_attn#">
		<input type="hidden" name="b_phone" value="#b_phone#">
		<input type="hidden" name="b_fax" value="#b_fax#">
		<input type="hidden" name="frem9" value="#frem9#">
		<input type="hidden" name="counter" value="#counter#">
		<input type="hidden" name="b_phone2" value="#b_phone2#">
        <cfif isdefined("form.refno2set")>
        <input name="refno2set" type="hidden" value="#form.refno2set#" />
        </cfif>
        <cfif isdefined("form.invset2")>
        <input name="invset2" type="hidden" value="#form.invset2#" />
        </cfif>

		<cfif isdefined("form.d_name")>
			<input type="hidden" name="d_name" value="#d_name#">
			<input type="hidden" name="d_name2" value="#d_name2#">
			<input type="hidden" name="d_add1" value="#d_add1#">
			<input type="hidden" name="d_add2" value="#d_add2#">
			<input type="hidden" name="d_add3" value="#d_add3#">
			<input type="hidden" name="d_add4" value="#d_add4#">
			<input type="hidden" name="d_add5" value="#d_add5#">
			<input type="hidden" name="d_attn" value="#d_attn#">
			<input type="hidden" name="d_phone" value="#d_phone#">
			<input type="hidden" name="d_fax" value="#d_fax#">
		</cfif>

		<cfif isdefined("form.c_name")>
        	<input type="hidden" name="ccode" value="#form.ccode#">
			<input type="hidden" name="c_name" value="#c_name#">
			<input type="hidden" name="c_name2" value="#c_name2#">
			<input type="hidden" name="c_add1" value="#c_add1#">
			<input type="hidden" name="c_add2" value="#c_add2#">
			<input type="hidden" name="c_add3" value="#c_add3#">
			<input type="hidden" name="c_add4" value="#c_add4#">
			<input type="hidden" name="c_add5" value="#c_add5#">
			<input type="hidden" name="c_attn" value="#c_attn#">
			<input type="hidden" name="c_phone" value="#c_phone#">
			<input type="hidden" name="c_fax" value="#c_fax#">
		</cfif>
        
        <cfif isdefined('form.via')>
        	<input type="hidden" name="via" value="#form.via#" >
		</cfif>

		<cfif isdefined("form.related")>
			<input type="hidden" name="related" id="related" value="#related#">
		</cfif>

		<cfif isdefined("form.recover")>
			<input type="hidden" name="recover" id="recover" value="#recover#">
		</cfif>
		
		<cfif isdefined("form.keepDeleted")>
			<input type="hidden" name="keepDeleted" id="keepDeleted" value="#keepDeleted#">
		</cfif>

		<input type="hidden" name="type" id="type" value="#type#">
		<input type="hidden" name="tran" id="tran" value="#tran#">

		<cfif type eq "Delete" or type eq "Edit">
			<input type="hidden" name="currefno" id="currefno" value="#currefno#">
		</cfif>

		<cfif isdefined("form.invset")>
			<input type="hidden" name="invset" id="invset" value="#invset#">
			<input type="hidden" name="tranarun" id="tranarun" value="#tranarun#">
		</cfif>
        
        <cfif Submit eq "  Create  ">
		<input type="hidden" name="checkfast" value="fast" >
		</cfif>

		
	</form>
	<script type="text/javascript">
		
		function trim(str)
		{    
			if(!str || typeof str != 'string')        
				return null;    
			return str.replace(/^[\s]+/,'').replace(/[\s]+$/,'').replace(/[\s]{2,}/,' ');
		}
		
		function test()
		{
			var nexttranno = trim(document.invoicesheet.nexttranno.value);
	
  			if(nexttranno=='')
			{
    			alert("Your Transaction's No. cannot be blank.");
    			return false;
  			}
			if(document.invoicesheet.custno.value=='')
			{
				alert("Your Customer's No. cannot be blank.");
				return false;
  			}
  			return true;
		}

		var testresult = test();
		if (testresult != false)
		{
			invoicesheet.submit()
		}
	</script>
<cfelseif ChgBillToAddr neq "">
	<cfif ttype eq 'Create'>
		<form name="invoicesheet" id="invoicesheet" action="tranaddrsearch.cfm?invset=#invset#&tran=#tran#&stype=#tranname#&ttype=#ttype#&nexttranno=#form.nexttranno#&custno=#URLEncodedFormat(form.custno)#&bcode=#form.bcode#&dcode=#form.dcode#&addrtype=Bill&invoicedate=#form.invoicedate#&ccode=#form.ccode#" method="post">
	<cfelse>
		<form name="invoicesheet" id="invoicesheet" action="tranaddrsearch.cfm?invset=#invset#&tran=#tran#&stype=#tranname#&ttype=#ttype#&refno=#refno#&nexttranno=#form.nexttranno#&custno=#URLEncodedFormat(form.custno)#&bcode=#form.bcode#&dcode=#form.dcode#&addrtype=Bill&invoicedate=#form.invoicedate#&ccode=#form.ccode#" method="post">
	</cfif>

	
	</form>
<script>invoicesheet.submit()</script>
<cfelseif ChgDeliveryAddr neq "">
	<cfif ttype eq 'Create'>
		<form name="invoicesheet" id="invoicesheet" action="tranaddrsearch.cfm?invset=#invset#&tran=#tran#&stype=#tranname#&ttype=#ttype#&nexttranno=#form.nexttranno#&custno=#URLEncodedFormat(form.custno)#&bcode=#form.bcode#&dcode=#form.dcode#&addrtype=Delivery&invoicedate=#form.invoicedate#&ccode=#form.ccode#" method="post">
	<cfelse>
		<form name="invoicesheet" id="invoicesheet" action="tranaddrsearch.cfm?invset=#invset#&tran=#tran#&stype=#tranname#&ttype=#ttype#&refno=#refno#&nexttranno=#form.nexttranno#&custno=#URLEncodedFormat(form.custno)#&bcode=#form.bcode#&dcode=#form.dcode#&addrtype=Delivery&invoicedate=#form.invoicedate#&ccode=#form.ccode#" method="post">
	</cfif>

	
	</form>
<script>invoicesheet.submit()</script>
<cfelseif scust neq "">
	<cfif (tran eq 'PO' or tran eq 'PR' or tran eq 'RC') and ttype eq "Create">
		<form name="invoicesheet" id="invoicesheet" action="transuppsearch.cfm?invset=#invset#&tran=#tran#&stype=#tranname#&ttype=#ttype#&nexttranno=#form.nexttranno#&custno=#URLEncodedFormat(form.custno)#&bcode=#form.bcode#&dcode=#form.dcode#&invoicedate=#form.invoicedate#&ccode=#form.ccode#" method="post">
		
		</form>
	  <script>
			invoicesheet.submit()
		</script>
	<cfelseif (tran eq 'PO' or tran eq 'PR' or tran eq 'RC') and ttype neq "Create">
		<form name="invoicesheet" id="invoicesheet" action="transuppsearch.cfm?invset=#invset#&tran=#tran#&stype=#tranname#&ttype=#ttype#&refno=#refno#&nexttranno=#form.nexttranno#&custno=#URLEncodedFormat(form.custno)#&bcode=#form.bcode#&dcode=#form.dcode#&invoicedate=#form.invoicedate#&ccode=#form.ccode#" method="post">
		
    	</form>
	  <script>invoicesheet.submit()</script>
	<cfelseif ttype eq "Create">
		<form name="invoicesheet" id="invoicesheet" action="trancustsearch.cfm?invset=#invset#&tran=#tran#&stype=#tranname#&ttype=#ttype#&nexttranno=#form.nexttranno#&custno=#URLEncodedFormat(form.custno)#&bcode=#form.bcode#&dcode=#form.dcode#&invoicedate=#form.invoicedate#&ccode=#form.ccode#" method="post">
		
    	</form>
	  <script>invoicesheet.submit()</script>
	<cfelse>
		<form name="invoicesheet" id="invoicesheet" action="trancustsearch.cfm?tran=#tran#&stype=#tranname#&ttype=#ttype#&refno=#refno#&nexttranno=#form.nexttranno#&custno=#URLEncodedFormat(form.custno)#&bcode=#form.bcode#&dcode=#form.dcode#&invoicedate=#form.invoicedate#&ccode=#form.ccode#" method="post">
		
    	</form>
	  <script>invoicesheet.submit()</script>
	</cfif>
<cfelseif ChgCollectFromAddr neq "">
	<cfif ttype eq 'Create'>
		<form name="invoicesheet" id="invoicesheet" action="trancollectaddrsearch.cfm?invset=#invset#&tran=#tran#&stype=#tranname#&ttype=#ttype#&nexttranno=#form.nexttranno#&custno=#URLEncodedFormat(form.custno)#&bcode=#form.bcode#&dcode=#form.dcode#&addrtype=Collect&invoicedate=#form.invoicedate#&ccode=#form.ccode#" method="post">
	<cfelse>
		<form name="invoicesheet" id="invoicesheet" action="trancollectaddrsearch.cfm?invset=#invset#&tran=#tran#&stype=#tranname#&ttype=#ttype#&refno=#refno#&nexttranno=#form.nexttranno#&custno=#URLEncodedFormat(form.custno)#&bcode=#form.bcode#&dcode=#form.dcode#&addrtype=Collect&invoicedate=#form.invoicedate#&ccode=#form.ccode#" method="post">
	</cfif>

	
	</form>
  <script>invoicesheet.submit()</script>
</cfif>

<cfif ttype eq "Create">
	<cfset nexttranno = nexttranno>
	
	<cfif isdefined("custno")>
		<cfset custno = custno>

		<cfquery name="getcustomere" datasource="#dts#">
			Select name, name2, custno, currcode,daddr1 from #ptype# where custno = "#custno#"
	  	</cfquery>

		<cfset name = getcustomere.name>
		<cfset name2 = getcustomere.name2>
  	<cfelse>
		<cfset custno = "">
		<cfset name = "">
		<cfset name2 = "">
  	</cfif>

  	<cfset mode = "Create">

	<cfif getGeneralInfo.arun eq "1">
		<cfset refnocnt = len(getGeneralInfo.tranno)>
		<cfset cnt = 0>
		<cfset yes = 0>

		<cfloop condition = "cnt lte refnocnt and yes eq 0">
			<cfset cnt = cnt + 1>
			<cfif isnumeric(mid(getGeneralInfo.tranno,cnt,1))>
				<cfset yes = 1>
			</cfif>
		</cfloop>

		<cfset nolen = refnocnt - cnt + 1>

		<cftry>
			<cfset nextno = right(getGeneralInfo.tranno,nolen) + 1>
			<cfcatch type="any">
				<cftry>
					<cfset c = len(listlast(getGeneralInfo.tranno,"/"))>
					<cfset v = "0">
					<cfloop from="2" to="#c#" index="a">
						<cfset v = v&"0">
					</cfloop>
					<cfset a = numberformat(right(getGeneralInfo.tranno,4) + 1,v)>
					<cfset nextno = listfirst(getGeneralInfo.tranno,"/")&"/"&a>
				<cfcatch type="any">
					<cfset nextno=0>
				</cfcatch>
				</cftry>
			</cfcatch>
		</cftry>

		<cfset nocnt = 1>
		<cfset zero = "">

		<cfloop condition = "nocnt lte nolen">
			<cfset zero = zero & "0">
			<cfset nocnt = nocnt + 1>
		</cfloop>

		<cfif tran eq 'SO' or tran eq 'PO' or tran eq 'QUO'>
			<cfset limit = 24>
		<cfelse>
			<cfset limit = 20>
		</cfif>
		
		<cftry>
			<cfif cnt gt 1>
				<cfset nexttranno = left(getGeneralInfo.tranno,cnt-1)&numberformat(nextno,zero)>
	
				<cfif len(nexttranno) gt limit>
					<cfset nexttranno = '99999999'>
				</cfif>
			<cfelse>
				<cftry>
					<cfset nexttranno = numberformat(nextno,zero)>
					<cfcatch type="any">
					<cfset nexttranno = nextno>
					</cfcatch>
				</cftry>
	
				<cfif len(nexttranno) gt limit>
					<cfset nexttranno = '99999999'>
				</cfif>
			</cfif>
		<cfcatch type="any">
			<cfinvoke component="cfc.refno" method="processNum" oldNum="#getGeneralInfo.tranno#" returnvariable="newnextNum" />
			<cfset nexttranno = newnextNum>
		</cfcatch>
		</cftry>
		
		<!--- ADD ON 18-12-2008 --->
		<!--- <cfif (lcase(HcomID) eq "mhsl_i" and tran eq "INV") or (lcase(HcomID) eq "ideal_i" and (tran eq "INV" or tran eq "DO" or tran eq "QUO" or tran eq "SO"))> --->
		<cfif (lcase(HcomID) eq "mhsl_i" and tran eq "INV") or (lcase(HcomID) eq "ideal_i")>
			<cfset actual_nexttranno = nexttranno>
			<cfif getGeneralInfo.refnocode2 neq "">
				<cfif dateformat(now(),"yy") neq getGeneralInfo.refnocode2>
					<cfquery name="update" datasource="#dts#">
						update refnoset
						set refnocode2 = '#dateformat(now(),"yy")#'
						where type='#tran#'
						and counter = #counter#
					</cfquery>
					<cfset getGeneralInfo.refnocode2 = dateformat(now(),"yy")>
					<cfset pattern = "/"&getGeneralInfo.refnocode2>
					<cfquery name="checkPattern" datasource="#dts#">
						select refno from artran
						where type='#tran#'
						and refno like '%#pattern#'
						limit 1
					</cfquery>
					<cfif checkPattern.recordcount eq 0>
						<cfinvoke component="cfc.refno" method="resetRefno" oldNum="#getGeneralInfo.tranno#" returnvariable="newNum" />
						<cfquery name="update" datasource="#dts#">
							update refnoset
							set lastUsedNo = '#newNum#'
							where type='#tran#'
							and counter = #counter#
						</cfquery>
						<cfinvoke component="cfc.refno" method="processNum" oldNum="#newNum#" returnvariable="newnextNum" />
						<cfset nexttranno = newnextNum>
					</cfif>
				</cfif>
				<cfset nexttranno = actual_nexttranno&"/"&getGeneralInfo.refnocode2>
			</cfif>		
		<cfelseif lcase(HcomID) eq "zeadine_i" or lcase(HcomID) eq "zeadine09_i">	
			<cfset actual_nexttranno = nexttranno>
			<cfif getGeneralInfo.refnocode2 neq "">
				<cfset nexttranno = actual_nexttranno&"-"&getGeneralInfo.refnocode2>
			</cfif>
		<cfelseif lcase(HcomID) eq "topsteel_i" or lcase(HcomID) eq "chemline_i" or lcase(HcomID) eq "kingston_i" or lcase(HcomID) eq "probulk_i">
			<cfinvoke component="cfc.refno" method="processNum" oldNum="#getGeneralInfo.tranno#" returnvariable="newnextNum" />
			<cfset nexttranno = newnextNum>
        <cfelse>
        	<cfinvoke component="cfc.refno" method="processNum" oldNum="#getGeneralInfo.tranno#" returnvariable="newnextNum" />
        	<cfset actual_nexttranno = newnextNum>
            <cfif (getGeneralInfo.refnocode2 neq "" or getGeneralInfo.refnocode neq "") and getGeneralInfo.presuffixuse eq "1">
				<cfset nexttranno = getGeneralInfo.refnocode&actual_nexttranno&getGeneralInfo.refnocode2>
            <cfelse>
            	<cfset nexttranno = actual_nexttranno>
			</cfif>
		</cfif>
		<cfset tranarun_1 = getGeneralInfo.arun>
    <cfelse>
	  	<cfset nexttranno = "">
	  	<cfset tranarun_1 = "0">
	</cfif>
	
  	<cfset nDateCreate = "">
	
<cfelseif ttype eq "Edit">
  	<cfquery datasource='#dts#' name="getitem">
		select * from artran where refno='#refno#' and type = '#tran#'
  	</cfquery>

	<cfif getitem.posted eq 'P'>
  		<h3>Transaction already posted.</h3>
		<cfabort>
  	</cfif>

  	<cfif isdefined("custno")>
		<cfset custno = custno>

	  	<cfquery name="getcustomere" datasource="#dts#">
			Select name, name2, custno, currcode,daddr1 from #ptype# where custno = "#custno#"
	  	</cfquery>

		<cfset name = getcustomere.name>
		<cfset name2 = getcustomere.name2>
  	<cfelse>
		<cfset custno = getitem.custno>

	  	<cfquery name="getcustomere" datasource="#dts#">
			Select name, name2, custno,daddr1 from #ptype# where custno = "#getitem.custno#"
	  	</cfquery>

		<cfset name = getcustomere.name>
		<cfset name2 = getcustomere.name2>
  	</cfif>

  	<cfset mode = "Edit">
  	<cfset nexttranno =  refno>
  	<cfset nDateCreate = getitem.wos_date>

<cfelseif ttype eq "Delete">
	<cfquery datasource='#dts#' name="getitem">
		select * from artran where refno='#refno#' and type = '#tran#'
	</cfquery>

	<cfif getitem.posted eq 'P'>
		<h3>Transaction already posted.</h3>
		<cfabort>
	</cfif>

	<cfif tran eq 'DO' and getitem.toinv neq ''>
		<h3>Not Allowed to Delete.</h3>
		<cfabort>
	</cfif>

	<cfquery name="getcustomere" datasource="#dts#">
	  	Select name, name2,custno, currcode,daddr1 from #ptype# where custno = "#custno#"
	</cfquery>

	<cfset custno = getitem.custno>
	<cfset name = getcustomere.name>
	<cfset name2 = getcustomere.name2>
	<cfset nDateCreate = getitem.wos_date>
	<cfset mode = "Delete">
	<cfset nexttranno = refno>

  	<cfquery name="getrel" datasource="#dts#">
		select frrefno,frtype,frdate from iclink where refno = '#refno#' and type = '#tran#'
  	</cfquery>

  	<cfif getrel.recordcount gt 0>
		<cfset xrelated = 1>
		<cfset xtype = getrel.frtype>
	</cfif>
</cfif>

<body>
  	<h4>
	<cfif alcreate eq 1>
		<cfif HcomID eq "pnp_i">
			<cfinclude template="../../pnp/get_authorised_multi_invoive.cfm">
		<cfelse>
			<cfif getGsetup.invoneset neq '1' and tran eq 'INV'>
				<a href="transaction0.cfm?tran=#tran#">Create New #tranname#</a>
			<cfelseif getGsetup.rc_oneset neq '1' and tran eq 'RC'>
				<a href="transaction0.cfm?tran=#tran#">Create New #tranname#</a>
			<cfelseif getGsetup.pr_oneset neq '1' and tran eq 'PR'>
				<a href="transaction0.cfm?tran=#tran#">Create New #tranname#</a>
			<cfelseif getGsetup.do_oneset neq '1' and tran eq 'DO'>
				<a href="transaction0.cfm?tran=#tran#">Create New #tranname#</a>
			<cfelseif getGsetup.cs_oneset neq '1' and tran eq 'CS'>
				<a href="transaction0.cfm?tran=#tran#">Create New #tranname#</a>
			<cfelseif getGsetup.cn_oneset neq '1' and tran eq 'CN'>
				<a href="transaction0.cfm?tran=#tran#">Create New #tranname#</a>
			<cfelseif getGsetup.dn_oneset neq '1' and tran eq 'DN'>
				<a href="transaction0.cfm?tran=#tran#">Create New #tranname#</a>
			<cfelseif getGsetup.iss_oneset neq '1' and tran eq 'ISS'>
				<a href="transaction0.cfm?tran=#tran#">Create New #tranname#</a>
			<cfelseif getGsetup.po_oneset neq '1' and tran eq 'PO'>
				<a href="transaction0.cfm?tran=#tran#">Create New #tranname#</a>
			<cfelseif getGsetup.so_oneset neq '1' and tran eq 'SO'>
				<a href="transaction0.cfm?tran=#tran#">Create New #tranname#</a>
			<cfelseif getGsetup.quo_oneset neq '1' and tran eq 'QUO'>
				<a href="transaction0.cfm?tran=#tran#">Create New #tranname#</a>
			<cfelseif getGsetup.assm_oneset neq '1' and tran eq 'ASSM'>
				<a href="transaction0.cfm?tran=#tran#">Create New #tranname#</a>
			<cfelseif getGsetup.tr_oneset neq '1' and tran eq 'TR'>
				<a href="transaction0.cfm?tran=#tran#">Create New #tranname#</a>
			<cfelseif getGsetup.oai_oneset neq '1' and tran eq 'OAI'>
				<a href="transaction0.cfm?tran=#tran#">Create New #tranname#</a>
			<cfelseif getGsetup.oar_oneset neq '1' and tran eq 'OAR'>
				<a href="transaction0.cfm?tran=#tran#">Create New #tranname#</a>
			<cfelseif getGsetup.sam_oneset neq '1' and tran eq 'SAM'>
				<a href="transaction0.cfm?tran=#tran#">Create New #tranname#</a>
			<cfelse>
				<a href="transaction1.cfm?ttype=create&tran=#tran#&nexttranno=&first=0">Create New #tranname#</a>
			</cfif> || 
		</cfif>
	</cfif>
	<a href="transaction.cfm?tran=#tran#">List all #tranname#</a> ||
	<a href="stransaction.cfm?tran=#tran#&searchtype=&searchstr=">Search For #tranname#</a>
	<!---<cfif tran eq "SO" and hcomid eq "MSD">
	  || <a href="transaction_report.cfm?type=10">#tranname# Reports</a>
	</cfif>--->
  	</h4>

<form name="invoicesheet" id="invoicesheet" action="" method="post">
    <input type="hidden" name="type" id="type" value="#listfirst(mode)#">
    <input type="hidden" name="tran" id="tran" value="#listfirst(tran)#">

	<cfif ttype eq "Delete" or ttype eq "Edit">
      	<input type="hidden" name="currefno" id="currefno" value="#listfirst(refno)#">
    </cfif>

	<cfif invset neq 0>
      	<input type="hidden" name="invset" id="invset" value="#listfirst(invset)#">
      	<input type="hidden" name="tranarun" id="tranarun" value="#listfirst(tranarun)#">
    </cfif>

	<cfset b_name = "">
  	<cfset b_name2 = "">
  	<cfset b_add1 = "">
  	<cfset b_add2 = "">
  	<cfset b_add3 = "">
 	<cfset b_add4 = "">
  	<cfset b_add5 = "">
  	<cfset b_attn = "">
  	<cfset b_phone = "">
  	<cfset b_fax = "">
  	<cfset b_phone2 = "">
  	<cfset d_name = "">
  	<cfset d_name2 = "">
  	<cfset d_add1 = "">
  	<cfset d_add2 = "">
  	<cfset d_add3 = "">
  	<cfset d_add4 = "">
  	<cfset d_add5 = "">
  	<cfset d_attn = "">
  	<cfset d_phone = "">
  	<cfset d_fax = "">
  	<cfset frem9 = "">
    
    <!--- <cfif lcase(hcomid) eq 'iel_i'> --->
		<cfset c_name="">
        <cfset c_name2="">
        <cfset c_add1 = "">
		<cfset c_add2 = "">
        <cfset c_add3 = "">
        <cfset c_add4 = "">
        <cfset c_add5 = "">
        <cfset c_attn = "">
        <cfset c_phone = "">
        <cfset c_fax = "">
	<!--- </cfif> --->
    <cfset via = "">

	<cfquery datasource='#dts#' name="getitem">
  		select * from artran where refno='#nexttranno#' and type = '#tran#'
  	</cfquery>
  	<!--- First from the menu or first click from Create --->
  	<cfif first eq 0>
    	<cfif ttype eq "Create">
      		<cfset T_BCode = "Profile">
			<cfif isdefined("url.custno") and getcustomere.daddr1 neq "">
				<cfset T_DCode = "Profile">
			<cfelse>
				<cfset T_DCode = "">
</cfif>
      		<!--- <cfset T_DCode = ""> --->
      		<cfset T_CustNo = "">
			
			<cfif HcomID eq "pnp_i">
				<cfinclude template="../../pnp/get_default_inv_custno.cfm">
			</cfif>			
            
            <cfif lcase(hcomid) eq 'iel_i' or lcase(hcomid) eq 'ielm_i'>
				<cfset T_CCode = "Profile">
			<cfelse>
				<cfset T_CCode ="">
		  </cfif>
    	<cfelse>
      		<cfset T_BCode = getitem.rem0>
      		<cfset T_DCode = getitem.rem1>
      		<cfset T_CustNo = custno>
            <cfif lcase(hcomid) eq 'iel_i' or lcase(hcomid) eq 'ielm_i'>
				<cfset T_CCode = getitem.rem15>
			<cfelse>
				<cfset T_CCode ="">
		  </cfif>
    	</cfif>
  	<cfelse>
    	<cfset T_BCode = bcode>
		<!--- REMARK ON 070708 --->
		<!--- <cfif isdefined("url.custno") and getcustomere.daddr1 neq "">
    		<cfset T_DCode = "Profile">
		<cfelse>
			<cfset T_DCode = dcode>
		</cfif> --->
		<cfif isdefined("url.dcode")>
   		  <cfif url.dcode neq "">
				<cfset T_DCode = dcode>
			<cfelse>
				<cfset T_DCode = "Profile">
		  </cfif>
		<cfelse>
			<cfset T_DCode = "Profile">
</cfif>
    	<cfset T_CustNo = custno>
        
        <cfif lcase(hcomid) eq 'iel_i' or lcase(hcomid) eq 'ielm_i'>
       	  <cfif isdefined("url.ccode")>
			<cfif url.ccode neq "">
                    <cfset T_CCode = ccode>
                <cfelse>
                    <cfset T_CCode = "Profile">
            </cfif>
            <cfelse>
                <cfset T_CCode = "Profile">
          </cfif>
		<cfelse>
			<cfset T_CCode ="">
	  </cfif>
  	</cfif>

    <cfquery name="getcust" datasource="#dts#">
    	Select * from #ptype# where custno = "#t_custno#"
    </cfquery>

  	<cfset custno = t_custno>
  	<cfset name = getcust.name>
  	<cfset name2 = getcust.name2>

	<cfif T_BCode neq "">
    	<cfif T_BCode eq "Profile">
      		<cfset BCode = "Profile">
      		<cfset b_name = getcust.name>
      		<cfset b_name2 = getcust.name2>
      		<cfset b_add1 = getcust.add1>
      		<cfset b_add2 = getcust.add2>
      		<cfset b_add3 = getcust.add3>
      		<cfset b_add4 = getcust.add4>
	 	 	<cfset b_add5 = ''>
      		<cfset b_attn = getcust.attn>
      		<cfset b_phone = getcust.phone>
      		<cfset b_fax = getcust.fax>
  			<cfset b_phone2 = getcust.phonea>
			<!--- ADD ON 14-10-2009 --->
			<cfif getcust.country neq "" and getcust.postalcode neq "">
				<cfset add5=getcust.country&" "&getcust.postalcode>
			  <cfif getcust.add1 eq "">
					<cfset b_add1 = add5>
				<cfelseif getcust.add2 eq "">
					<cfset b_add2 = add5>
				<cfelseif getcust.add3 eq "">
					<cfset b_add3 = add5>
				<cfelseif getcust.add4 eq "">
					<cfset b_add4 = add5>
				<cfelse>
					<cfset b_add5 = add5>
			  </cfif>
		  </cfif>
    	<cfelse>
      		<cfquery name="getBillAddr" datasource="#dts#">
      			Select * from address where code = "#T_BCode#"
      		</cfquery>

			<cfset BCode = getBillAddr.code>
      		<cfset b_name = getBillAddr.name>
		  	<cfset b_name2 = "">
		  	<cfset b_add1 = getBillAddr.add1>
		  	<cfset b_add2 = getBillAddr.add2>
		  	<cfset b_add3 = getBillAddr.add3>
		  	<cfset b_add4 = getBillAddr.add4>
		  	<cfset b_add5 = "">
		  	<cfset b_attn = getBillAddr.attn>
		  	<cfset b_phone = getBillAddr.phone>
		  	<cfset b_fax = getBillAddr.fax>
  			<cfset b_phone2 = "">
			<!--- ADD ON 14-10-2009 --->
			<cfif trim(getBillAddr.country) neq "" and trim(getBillAddr.postalcode) neq "">
				<cfset add5=getBillAddr.country&" "&getBillAddr.postalcode>
			  <cfif getBillAddr.add1 eq "">
					<cfset b_add1 = add5>
				<cfelseif getBillAddr.add2 eq "">
					<cfset b_add2 = add5>
				<cfelseif getBillAddr.add3 eq "">
					<cfset b_add3 = add5>
				<cfelseif getBillAddr.add4 eq "">
					<cfset b_add4 = add5>
				<cfelse>
					<cfset b_add5 = add5>
			  </cfif>
		  </cfif>
    	</cfif>
    <cfelse>
    	<cfif ttype eq 'Create'>
			<cfset BCode = "">
			<cfset b_name = "">
			<cfset b_name2 = "">
			<cfset b_add1 = "">
			<cfset b_add2 = "">
			<cfset b_add3 = "">
			<cfset b_add4 = "">
			<cfset b_add5 = "">
			<cfset b_attn = "">
			<cfset b_phone = "">
			<cfset b_fax = "">
  			<cfset b_phone2 = "">
		<cfelse>
			<cfset BCode = "">
			<cfset b_name = getitem.frem0>
		  	<cfset b_name2 = getitem.frem1>
		  	<cfset b_add1 = getitem.frem2>
		  	<cfset b_add2 = getitem.frem3>
		  	<cfset b_add3 = getitem.frem4>
		  	<cfset b_add4 = getitem.frem5>
		  	<cfset b_add5 = getitem.rem13>
		  	<cfset b_attn = getitem.rem2>
		  	<cfset b_phone = getitem.rem4>
		  	<cfset b_fax = getitem.frem6>
  			<cfset b_phone2 = getitem.phonea>
   	  </cfif>
  	</cfif>

	<cfif T_DCode neq "">
    	<cfif T_DCode eq "Profile">
      		<cfset DCode = "Profile">
      		<cfset d_name = getcust.name>
      		<cfset d_name2 = getcust.name2>
      		<cfset d_add1 = getcust.daddr1>
      		<cfset d_add2 = getcust.daddr2>
      		<cfset d_add3 = getcust.daddr3>
      		<cfset d_add4 = getcust.daddr4>
	  		<cfset d_add5 = ''>
      		<cfset d_attn = getcust.dattn>
      		<!--- <cfset d_phone = getcust.phone>
      		<cfset d_fax = getcust.fax> --->
      		<cfset d_phone = getcust.dphone>
      		<cfset d_fax = getcust.dfax>
			<!--- ADD ON 14-10-2009 --->
			<cfif getcust.d_country neq "" and getcust.d_postalcode neq "">
				<cfset dadd5=getcust.d_country&" "&getcust.d_postalcode>
			  <cfif getcust.daddr1 eq "">
					<cfset d_add1 = dadd5>
				<cfelseif getcust.daddr2 eq "">
					<cfset d_add2 = dadd5>
				<cfelseif getcust.daddr3 eq "">
					<cfset d_add3 = dadd5>
				<cfelseif getcust.daddr4 eq "">
					<cfset d_add4 = dadd5>
				<cfelse>
					<cfset d_add5 = dadd5>
			  </cfif>
		  </cfif>
     	<cfelse>
      		<cfquery name="getDeliveryAddr" datasource="#dts#">
      			select * from address where code = "#T_DCode#"
      		</cfquery>

			<cfset DCode = getDeliveryAddr.code>
		  	<cfset d_name = getDeliveryAddr.name>
		  	<cfset d_name2 = "">
		  	<cfset d_add1 = getDeliveryAddr.add1>
		  	<cfset d_add2 = getDeliveryAddr.add2>
		  	<cfset d_add3 = getDeliveryAddr.add3>
		  	<cfset d_add4 = getDeliveryAddr.add4>
		  	<cfset d_add5 = "">
		  	<cfset d_attn = getDeliveryAddr.attn>
		  	<cfset d_phone = getDeliveryAddr.phone>
		  	<cfset d_fax = getDeliveryAddr.fax>
			<!--- ADD ON 14-10-2009 --->
			<cfif getDeliveryAddr.country neq "" and getDeliveryAddr.postalcode neq "">
				<cfset dadd5=getDeliveryAddr.country&" "&getDeliveryAddr.postalcode>
			  <cfif getDeliveryAddr.add1 eq "">
					<cfset d_add1 = dadd5>
				<cfelseif getDeliveryAddr.add2 eq "">
					<cfset d_add2 = dadd5>
				<cfelseif getDeliveryAddr.add3 eq "">
					<cfset d_add3 = dadd5>
				<cfelseif getDeliveryAddr.add4 eq "">
					<cfset d_add4 = dadd5>
				<cfelse>
					<cfset d_add5 = dadd5>
			  </cfif>
		  </cfif>
    	</cfif>
    <cfelse>
		<cfif ttype eq 'Create'>
		  	<cfset DCode = "">
		  	<cfset d_name = "">
		  	<cfset d_name2 = "">
		  	<cfset d_add1 = "">
		  	<cfset d_add2 = "">
		  	<cfset d_add3 = "">
		  	<cfset d_add4 = "">
		  	<cfset d_add5 = "">
		  	<cfset d_attn = "">
		  	<cfset d_phone = "">
		  	<cfset d_fax = "">
			<cfset frem9 = "">
		<cfelse>
		  	<cfset DCode = "">
		  	<cfset d_name = getitem.frem7>
		  	<cfset d_name2 = getitem.frem8>
			<cfset frem9 = getitem.frem9>
		  	<cfset d_add1 = getitem.comm0>
		  	<cfset d_add2 = getitem.comm1>
		  	<cfset d_add3 = getitem.comm2>
		  	<cfset d_add4 = getitem.comm3>
		  	<cfset d_add5 = getitem.rem14>
		  	<cfset d_attn = getitem.rem3>
		  	<cfset d_phone = getitem.rem12>
		  	<cfset d_fax = getitem.comm4>
	  </cfif>
  	</cfif>
    
    <cfif lcase(hcomid) eq 'iel_i' or lcase(hcomid) eq 'ielm_i'>
		<cfif T_CCode neq "">
            <cfif T_CCode eq "Profile">
                <cfset CCode = "Profile">
                <cfset c_name = getcust.name>
                <cfset c_name2 = getcust.name2>
                <cfset c_add1 = getcust.add1>
                <cfset c_add2 = getcust.add2>
                <cfset c_add3 = getcust.add3>
                <cfset c_add4 = getcust.add4>
                <cfset c_add5 = ''>
                <cfset c_attn = getcust.attn>
                <cfset c_phone = getcust.phone>
                <cfset c_fax = getcust.fax>
				<!--- ADD ON 14-10-2009 --->
				<cfif getcust.country neq "" and getcust.postalcode neq "">
					<cfset cadd5=getcust.country&" "&getcust.postalcode>
				  <cfif getcust.add1 eq "">
						<cfset c_add1 = cadd5>
					<cfelseif getcust.add2 eq "">
						<cfset c_add2 = cadd5>
					<cfelseif getcust.add3 eq "">
						<cfset c_add3 = cadd5>
					<cfelseif getcust.add4 eq "">
						<cfset c_add4 = cadd5>
					<cfelse>
						<cfset c_add5 = cadd5>
				  </cfif>
			  </cfif>
            <cfelse>
                <cfquery name="getCollectAddr" datasource="#dts#">
                    select * from collect_address where code = '#T_CCode#'
                </cfquery>
    
                <cfset CCode = getCollectAddr.code>
                <cfset c_name = getCollectAddr.name>
                <cfset c_name2 = "">
                <cfset c_add1 = getCollectAddr.add1>
                <cfset c_add2 = getCollectAddr.add2>
                <cfset c_add3 = getCollectAddr.add3>
                <cfset c_add4 = getCollectAddr.add4>
                <cfset c_add5 = "">
                <cfset c_attn = getCollectAddr.attn>
                <cfset c_phone = getCollectAddr.phone>
                <cfset c_fax = getCollectAddr.fax>
				<!--- ADD ON 14-10-2009 --->
				<cfif getCollectAddr.country neq "" and getCollectAddr.postalcode neq "">
					<cfset cadd5=getCollectAddr.country&" "&getCollectAddr.postalcode>
				  <cfif getCollectAddr.add1 eq "">
						<cfset c_add1 = cadd5>
					<cfelseif getCollectAddr.add2 eq "">
						<cfset c_add2 = cadd5>
					<cfelseif getCollectAddr.add3 eq "">
						<cfset c_add3 = cadd5>
					<cfelseif getCollectAddr.add4 eq "">
						<cfset c_add4 = cadd5>
					<cfelse>
						<cfset c_add5 = cadd5>
				  </cfif>
			  </cfif>
            </cfif>
        <cfelse>
            <cfif ttype eq 'Create'>
                <cfset CCode = "">
                <cfset c_name = "">
                <cfset c_name2 = "">
                <cfset c_add1 = "">
                <cfset c_add2 = "">
                <cfset c_add3 = "">
                <cfset c_add4 = "">
                <cfset c_add5 = "">
                <cfset c_attn = "">
                <cfset c_phone = "">
                <cfset c_fax = "">
            <cfelse>
                <cfset CCode = "">
                <cfset c_name = getitem.rem16>
                <cfset c_name2 = getitem.rem17>
                <cfset c_add1 = getitem.rem18>
                <cfset c_add2 = getitem.rem19>
                <cfset c_add3 = getitem.rem20>
                <cfset c_add4 = getitem.rem21>
                <cfset c_add5 = getitem.rem22>
                <cfset c_attn = getitem.rem23>
                <cfset c_phone = getitem.rem24>
                <cfset c_fax = getitem.rem25>
          </cfif>
        </cfif>
	</cfif>

	<table align="center" class="data" cellspacing="0">
      	<tr>
        	<th width="15%" colspan="3">
				<cfif ttype eq "Create">
            		Next
				</cfif>
				#tranname# No </th>
        	<td width="35%">
			<cfif ttype eq "Create">
            	<cfif tranarun_1 eq "1">
					<input name="nexttranno" type="hidden" value="#url.nexttranno#">
              		<h3>#nexttranno#</h3>
              	<cfelse>
              	<span id="sprytextfield1">
              	<input name="nexttranno" id="nexttranno" type="text" value="#url.nexttranno#" onvalidate="javascript:NextTransNo()" size="10" onKeyUp="this.value=trim(this.value)" <cfif tran eq 'SO' or tran eq 'PO' or tran eq 'QUO'>maxlength="24"<cfelse><cfif lcase(HcomID) eq "meisei_i" and tran eq "RC">maxlength = "10"<cfelse>maxlength="20"</cfif></cfif>>
              	<span class="textfieldRequiredMsg">#tranname# no is required.</span></span>
            	</cfif>
                <cfif isdefined("form.invset2") and GetSetting.refno2valid eq "1">
                <input name="refno2set" type="hidden" value="#newnextrefno2#" />
                <input name="invset2" type="hidden" value="#form.invset2#" />
                </cfif>
            <cfelse>
				<input name="nexttranno" id="nexttranno" type="hidden" value="#nexttranno#">
            	<h3>#nexttranno#</h3>
                <cfif isdefined("form.invset2") and GetSetting.refno2valid eq "1">
                <input name="refno2set" type="hidden" value="#newnextrefno2#" />
                <input name="invset2" type="hidden" value="#form.invset2#" />
                </cfif>
          	</cfif>			</td>
       	  <th width="15%" colspan="3">Type</th>
        	<td width="35%"><h2>
            	<cfif ttype eq "Create">
              		New
            	</cfif>

				<cfif ttype eq "Delete">
              		Delete
            	</cfif>

				<cfif ttype eq "Edit">
              		Edit
            	</cfif>
            	#tranname#</h2>
			</td>
      	</tr>
    	<tr>
      		<th colspan="3">#tranname# Date</th>
      		<td>
				<cfif ttype eq "Create">
					<input type="text" name="invoicedate" id="invoicedate" value="<cfif isdefined("url.invoicedate")>#url.invoicedate#<cfelse>#dateformat(now(),"dd/mm/yyyy")#</cfif>" validate="eurodate" size="10" maxlength="10">
				</cfif>

				<cfif ttype eq "Delete" or ttype eq "Edit">
					<input type="text" name="invoicedate" id="invoicedate" value="#dateformat(nDateCreate,"dd/mm/yyyy")#" validate="eurodate" size="10" maxlength="10">
				</cfif>
				<img src="../../images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(invoicedate);">
				(DD/MM/YYYY)
			</td>
      		<th colspan="3">Last #tranname# No</th>
      		<td>
				<cfif ttype eq "Create">
					<h3>#getgeneralinfo.tranno#</h3>
            	</cfif>
			</td>
    	</tr>
      	<tr>
        	<th colspan="3">#ptype1# No</th>
        	<td>
				<!--- <cfif lcase(hcomid) eq "ecraft_i" or lcase(hcomid) eq "ovas_i"> --->	<!--- EDITED ON 16-06-2009 --->
				<cfif getGsetup.suppcustdropdown eq "1">
                <div id="tf_accno_a" name="tf_accno_a"><span id="spryselect1">
                  <select name="custno" id="custno" onChange="updateDetails(this.value);">
                    <option value="">Choose a #ptype1#</option>
                    <cfloop query="getcustsupp">
                      <option value="#xcustno#" <cfif trim(custno) eq xcustno>selected</cfif>>
                        <cfif lcase(HcomID) eq "glenn_i" or lcase(HcomID) eq "glenndemo_i">
							#name# - #xcustno#
						<cfelse>
							#xcustno# - #name#
						</cfif>
                      </option>
                    </cfloop>
                  </select><a onMouseOver="JavaScript:this.style.cursor='hand';" ><img src="/images/find.jpg" width="20" height="14.5" onClick="javascript:ColdFusion.Window.show('findCustomer');" />
                  <span class="selectRequiredMsg">Please select an item.</span></span></div>
                <!--- <input type="text" name="tf_accno_s" onKeyUp="ajaxFunction(window.document.getElementById('tf_accno_a'),'accountsearch.cfm?type=#ptype1#&c='+this.value);">
(Search by Accno/Name) ---><br>
					<cfif getGsetup.filterall eq "1">
						<input type="text" name="searchcustsupp" id="searchcustsupp" onKeyUp="getCustSupp('#ptype1#');">
						<br>
					</cfif>
					
					<a onClick="javascript:ColdFusion.Window.show('create#ptype1#');" onMouseOver="this.style.cursor='hand';">Create New #ptype1#</a>
					<cfif ttype eq 'Create' and tran eq 'RC'>
						&nbsp;<input type="checkbox" name="internalrc" id="internalrc" onClick="assignCust('dropdown');"> Internal Receiving
					</cfif>
					<br>
				<cfelse>
					<input name="custno" id="custno" type="text" value="#custno#"  size="20" maxlength="8">
					<input type="button" name="Scust1" value="Ajax Search" onClick="javascript:ColdFusion.Window.show('findCustomer');">&nbsp;&nbsp;<input type="submit" name="Scust" value="Search"><br>
                    <!---Modify on 12-Jan-2010 <a href="#ptype1#.cfm?type=Create" target="_blank">Create New #ptype1#</a> --->
					<a onClick="javascript:ColdFusion.Window.show('create#ptype1#');" onMouseOver="this.style.cursor='hand';" >Create New #ptype1#</a>	
					<cfif ttype eq 'Create' and tran eq 'RC'>
						&nbsp;<input type="checkbox" name="internalrc" id="internalrc" onClick="assignCust('');"> Internal Receiving
					</cfif>
					<br>
				</cfif>
				<input type="hidden" name="ptype" id="ptype" value="#ptype#">		
				<input name="name" id="name" type="text" size="45" maxlength="40" value="#name#"><br>
		  		<input name="name2" id="name2" type="text" size="45" maxlength="40" value="#name2#">
        	</td>
			<cfif ttype neq 'Create' and tran eq 'DO' and getitem.toinv neq ''>
				<th colspan="3">TO INVOICE</th>
				<td><h3>#getitem.toinv#</h3></td>
			<cfelse>
				<td colspan="3"></td>
				<td></td>
			</cfif>
		</tr>
    	<tr>
      		<td colspan="8"><hr></td>
    	</tr>
		<tr>
			<th colspan="3">Address Code</th>
            <cfif isdefined("url.custno") and GetSetting.ASACTP eq "N">
            <cfset T_BCode = "">
            <cfset T_DCode = "">
			</cfif>
            
			<td><input type="text" name="BCode" id="BCode" value="#T_BCode#" size="15"></td>
			<cfif tran eq 'PO' or tran eq 'SO' or tran eq 'DO' or tran eq 'INV' or hcomid eq "kimlee_i" or lcase(HcomID) eq "bakersoven_i">
				<th colspan="3">Address Code</th>
				<td><input type="text" name="DCode" id="DCode" value="<cfif  url.tran eq "PO" and lcase(HcomID) eq "topsteel_i" ><cfelse>#T_DCode#</cfif>"><a onClick="MM_openBrWindow('/default/maintenance/addresstable2.cfm?type=create&custno='+document.getElementById('custno').<cfif getGsetup.suppcustdropdown eq "1">options[document.getElementById('custno').selectedIndex].value<cfelse>value</cfif>,'CreateNewCollectionAddresss','scrollbars=yes,width=600,height=500')" onMouseMove="JavaScript:this.style.cursor='hand'">Create New Delivery</a></td>
			<cfelse>
				<input type="hidden" name="DCode" id="DCode" value="" readonly>
			</cfif>
		</tr>
		<tr>
			<th colspan="3">Name</th>
			<td><input type="text" name="b_name" id="b_name" value="#b_name#" size="45" maxlength="45"></td>
			<cfif tran eq 'PO' or tran eq 'SO' or tran eq 'DO' or tran eq 'INV' or hcomid eq "kimlee_i" or lcase(HcomID) eq "bakersoven_i">
				<th colspan="3">Name</th>
				<td><input type="text" name="d_name" id="d_name" value="<cfif  url.tran eq "PO" and lcase(HcomID) eq "topsteel_i" ><cfelse>#d_name#</cfif>" size="45" maxlength="35"><img src="/images/down.png" border="0" onClick="ajaxFunction(window.document.getElementById('deliveryadd'),'/default/transaction/transaction1DeliveryAjax.cfm?custno='+document.getElementById('custno').<cfif getGsetup.suppcustdropdown eq "1">options[document.getElementById('custno').selectedIndex].value<cfelse>value</cfif>);showsd();" width="15" height="15" onMouseMove="JavaScript:this.style.cursor='hand'"/><br />
                    <div style="display : none ; position: absolute;" id="deliveryadd"> 
                    
        </div></td>
			</cfif>
		</tr>
		<tr>
			<td colspan="3">&nbsp;</td>
			<td><input type="text" name="b_name2" id="b_name2" value="#b_name2#" size="45" maxlength="35"></td>
			<cfif tran eq 'PO' or tran eq 'SO' or tran eq 'DO' or tran eq 'INV' or hcomid eq "kimlee_i" or lcase(HcomID) eq "bakersoven_i">
				<td colspan="3">&nbsp;</td>
				<td><input type="text" name="d_name2" id="d_name2" value="<cfif  url.tran eq "PO" and lcase(HcomID) eq "topsteel_i" ><cfelse>#d_name2#</cfif>" size="45" maxlength="35"></td>
			</cfif>
		</tr>
		<tr>
			<th colspan="3">Bill To :</th>
			<td><input type="text" name="b_add1" id="b_add1" value="#b_add1#" size="45" maxlength="35"></td>
			<cfif tran eq 'PO' or tran eq 'SO' or tran eq 'DO' or tran eq 'INV'or hcomid eq "kimlee_i" or lcase(HcomID) eq "bakersoven_i">
				<th colspan="3">Delivery To :</th>
				<td><input type="text" name="d_add1" id="d_add1" value="#d_add1#" size="45" maxlength="40"></td>
			</cfif>
		</tr>
		<tr>
			<td rowspan="2" align="left" rowrap><input type="Button" name="ProfileAddr" value="Click" onClick="javascript:CopyProfileAddr()"></td>
			<td rowspan="2" align="left" rowrap>Same As Profile Address </td>
			<td rowspan="2" align="left" rowrap>&nbsp;&nbsp;&nbsp;</td>
			<td><input type="text" name="b_add2" id="b_add2" value="#b_add2#" size="45" maxlength="35"></td>
			<cfif tran eq 'PO' or tran eq 'SO' or tran eq 'DO' or tran eq 'INV' or hcomid eq "kimlee_i" or lcase(HcomID) eq "bakersoven_i">
				<td rowspan="2" align="left" rowrap><input type="button" name="BillToAddr" value="Click" onClick="javascript:CopyBillAddr()"></td>
				<td rowspan="2" align="left" rowrap>Same As Profile Delivery Address</td>
				<td rowspan="2" align="left" rowrap>&nbsp;&nbsp;&nbsp;</td>
				<td><input type="text" name="d_add2" id="d_add2" value="#d_add2#" size="45" maxlength="35"></td>
			</cfif>
		</tr>
		<tr>
			<td><input type="text" name="b_add3" id="b_add3" value="#b_add3#" size="45" maxlength="35"></td>
			<cfif tran eq 'PO' or tran eq 'SO' or tran eq 'DO' or tran eq 'INV' or hcomid eq "kimlee_i" or lcase(HcomID) eq "bakersoven_i">
				<td><input type="text" name="d_add3" id="d_add3" value="#d_add3#" size="45" maxlength="35"></td>
			</cfif>
		</tr>
		<tr>
			<td align="left" rowrap rowspan="2"><input type="submit" name="ChgBillToAddr" value="Click"></td>
			<td align="left" rowrap rowspan="2">Change Bill To Address </td>
			<td align="left" rowrap rowspan="2">&nbsp;&nbsp;&nbsp;</td>
			<td><input type="text" name="b_add4" id="b_add4" value="#b_add4#" size="45" maxlength="35"></td>
			<cfif tran eq 'PO' or tran eq 'SO' or tran eq 'DO' or tran eq 'INV' or hcomid eq "kimlee_i" or lcase(HcomID) eq "bakersoven_i">
				<td align="left" rowrap rowspan="2"><input type="submit" name="ChgDeliveryAddr" value="Click"></td>
				<td align="left" rowrap rowspan="2">Change Delivery Address</td>
				<td align="left" rowrap rowspan="2">&nbsp;&nbsp;&nbsp;</td>
				<td><input type="text" name="d_add4" id="d_add4" value="#d_add4#" size="45" maxlength="35"></td>
			</cfif>
		</tr>
		<tr>
			<td><input type="text" name="b_add5" id="b_add5" value="#b_add5#" size="45" maxlength="35"></td>
			<cfif tran eq 'PO' or tran eq 'SO' or tran eq 'DO' or tran eq 'INV' or hcomid eq "kimlee_i" or lcase(HcomID) eq "bakersoven_i">
				<td><input type="text" name="d_add5" id="d_add5" value="#d_add5#" size="45" maxlength="35"></td>
			</cfif>
		</tr>
		<tr>
			<th colspan="3"><cfif lcase(HcomID) eq "ugateway_i" and tran eq "INV" >Order By :<cfelse>Attn :</cfif></th>
			<td><input type="text" name="b_attn" id="b_attn" value="#b_attn#" size="45" maxlength="35"></td>
			<cfif tran eq 'PO' or tran eq 'SO' or tran eq 'DO' or tran eq 'INV'or hcomid eq "kimlee_i" or lcase(HcomID) eq "bakersoven_i">
				<th colspan="3">Attn :</th>
				<td><input type="text" name="d_attn" id="d_attn" value="#d_attn#" size="45" maxlength="35"></td></cfif>
			
		</tr>
		<tr>
			<th colspan="3"><cfif lcase(HcomID) eq "ugateway_i" and tran eq "INV" >Contact :<cfelse>Telephone :</cfif></th>
			<td><input type="text" name="b_phone" id="b_phone" value="#b_phone#" size="45" maxlength="35"></td>
			<cfif tran eq 'PO' or tran eq 'SO' or tran eq 'DO' or tran eq 'INV' or hcomid eq "kimlee_i" or lcase(HcomID) eq "bakersoven_i">
				<th colspan="3"><cfif lcase(hcomid) eq "glenn_i" or lcase(hcomid) eq "glenndemo_i">Heading<cfelseif lcase(hcomid) eq "winbells_i">Phone Number<cfelseif lcase(hcomid) eq "chemline_i">HP<cfelse>Telephone</cfif> :</th>
				<td><input type="text" name="d_phone" id="d_phone" value="#d_phone#" size="45" maxlength="35"></td>
			</cfif>
		</tr>
		<tr>
			<th colspan="3">Tel (2) :</th>
			<td><input type="text" name="b_phone2" id="b_phone2" value="#b_phone2#" size="45" maxlength="35"></td>
			<cfif tran eq 'PO' or tran eq 'SO' or tran eq 'DO' or tran eq 'INV' or hcomid eq "kimlee_i" or lcase(HcomID) eq "bakersoven_i">
				<th colspan="3">Fax :</th>
				<td><input type="text" name="d_fax" id="d_fax" value="#d_fax#" size="45" maxlength="35"></td>
			</cfif>
		</tr>
		<tr>
			<th colspan="3">Fax :</th>
			<td><input type="text" name="b_fax" id="b_fax" value="#b_fax#" size="45" maxlength="35"></td>
			<!--- <cfif tran eq 'PO' or tran eq 'SO' or tran eq 'DO' or tran eq 'INV'>
				<th colspan="3">Fax :</th>
				<td><input type="text" name="d_fax" value="#d_fax#" size="45" maxlength="35"></td>
			</cfif> --->
            <cfif lcase(hcomid) eq 'ugateway_i'>
            <cfif  tran eq 'PO' or tran eq 'SO' or tran eq 'DO' or tran eq 'INV'>
            <th colspan="3">VIA :</th>
            <td>
            <select name="via" id="via" >
            <option value="">Please Select VIA</option>
            <option value="air">By Air</option>
            <option value="post">By Post</option>
            <option value="mail">By Mail</option>
            </select>
            </td>
            </cfif>
             </cfif>
		</tr>
		<!--- Modified On 29-04-2009 --->
		<cfif lcase(hcomid) eq 'iel_i' or lcase(hcomid) eq 'ielm_i'>
        	<cfif  tran eq 'PO' or tran eq 'SO' or tran eq 'DO' or tran eq 'INV'>
                <tr>
                    <td colspan="100%"><hr></td>
                </tr>
                <tr>
                    <th colspan="3">Address Code</th>
                    <td><input type="text" name="CCode" id="CCode" value="#T_CCode#" size="15">
                    <a onClick="MM_openBrWindow('/customized/iel_i/maintenance/collectionaddresstable2.cfm?type=create&custno='+document.getElementById('custno').<cfif getGsetup.suppcustdropdown eq "1">options[document.getElementById('custno').selectedIndex].value<cfelse>value</cfif>,'CreateNewCollectionAddresss','scrollbars=yes,width=600,height=500')" onMouseMove="JavaScript:this.style.cursor='hand'">Create New Collection</a>                    </td>
                </tr>
                <tr>
                    <th colspan="3">Name</th>
                    <td><input type="text" name="c_name" id="c_name" value="#c_name#" size="45" maxlength="45"><img src="/images/down.png" border="0" onClick="ajaxFunction(window.document.getElementById('collectadd'),'/default/transaction/transaction1Ajax.cfm?custno='+document.getElementById('custno').<cfif getGsetup.suppcustdropdown eq "1">options[document.getElementById('custno').selectedIndex].value<cfelse>value</cfif>);showsa();" width="15" height="15" onMouseMove="JavaScript:this.style.cursor='hand'"/><br />
                    <div style="display : none ; position: absolute;" id="collectadd"> 
                    
        </div>
        </td>
                </tr>
                <tr>
                    <td colspan="3">&nbsp;</td>
                    <td><input type="text" name="c_name2" id="c_name2" value="#c_name2#" size="45" maxlength="35"></td>
                </tr>
                <tr>
                    <th colspan="3">Collect From :</th>
                    <td><input type="text" name="c_add1" id="c_add1" value="#c_add1#" size="45" maxlength="35"></td>
                </tr>
                <tr>
                    <td rowspan="2" align="left" rowrap><input type="Button" name="ProfileAddr" id="ProfileAddr" value="Click" onClick="javascript:CopyCollectAddr();"></td>
                    <td rowspan="2" align="left" rowrap>Same As Profile Address </td>
                    <td rowspan="2" align="left" rowrap>&nbsp;&nbsp;&nbsp;</td>
                    <td><input type="text" name="c_add2" id="c_add2" value="#c_add2#" size="45" maxlength="35"></td>
                </tr>
                <tr>
                    <td><input type="text" name="c_add3" id="c_add3" value="#c_add3#" size="45" maxlength="35"></td>
                </tr>
                <tr>
                    <td align="left" rowrap rowspan="2"><input type="submit" name="ChgCollectFromAddr" value="Click"></td>
                    <td align="left" rowrap rowspan="2">Change Collect From Address </td>
                    <td align="left" rowrap rowspan="2">&nbsp;&nbsp;&nbsp;</td>
                    <td><input type="text" name="c_add4" id="c_add4" value="#c_add4#" size="45" maxlength="35"></td>
                </tr>
                <tr>
                    <td><input type="text" name="c_add5" id="c_add5" value="#c_add5#" size="45" maxlength="35"></td>
                </tr>
                <tr>
                    <th colspan="3">Attn :</th>
                    <td><input type="text" name="c_attn" id="c_attn" value="#c_attn#" size="45" maxlength="35"></td>
                </tr>
                <tr>
                    <th colspan="3">Telephone :</th>
                    <td><input type="text" name="c_phone" id="c_phone" value="#c_phone#" size="45" maxlength="35"></td>
                </tr>
                <tr>
                    <th colspan="3">Fax :</th>
                    <td><input type="text" name="c_fax" id="c_fax" value="#c_fax#" size="45" maxlength="35"></td>
                </tr>
            <cfelse>
            	<input type="hidden" name="CCode" id="CCode" value="" size="15">
			</cfif>
		<cfelse>
			<input type="hidden" name="CCode" id="CCode" value="" size="15">
		</cfif>
    	<tr>
      		<td colspan="8" align="center">
          	<cfif xrelated eq 1>
            	<h3>
				<input name="recover" id="recover" type="checkbox" value="1" checked>
            	<input name="related" id="related" type="hidden" value="1">
            	Recover related #xtype#
				</h3>
          	</cfif>
			
			<cfif mode eq "Delete">	<!--- ADD ON 22-12-2009 --->
				<cfif getGsetup.keepDeletedBills eq "1">
					<h3>
	            	<input name="keepDeleted" id="keepDeleted" type="checkbox" value="1" checked>
	            	Keep Deleted Bills
					</h3>
				</cfif>
			</cfif>
			<input name="submit" type="submit" value="  #mode#  ">&nbsp;&nbsp;
            
            <cfif mode eq "Create">
            <input name="submit" type="submit" value="Update Address" >
			</cfif>
            
		  </td>
    	</tr>
  	</table>
	<input type="hidden" name="frem9" id="frem9" value="#frem9#">
</form>
</cfoutput>

<script language="JavaScript">
	function test()
	{
	
  		if(document.invoicesheet.nexttranno.value=='')
		{
    		alert("Your Transaction's No. cannot be blank.");
			document.invoicesheet.nexttranno.focus();
    		return false;
  		}
		if(document.invoicesheet.custno.value=='')
		{
			alert("Your Customer's No. cannot be blank.");
			document.invoicesheet.custno.focus();
			return false;
  		}
  		return true;
	}

	function CopyProfileAddr()
	{
  		<cfoutput>
    	<cfif #tran# eq "rc" or #tran# eq "pr" or #tran# eq "po">
      		<cfquery name="getcust" datasource="#dts#">
        		Select * from #target_apvend# where custno = "#custno#"
      		</cfquery>
    	<cfelse>
      		<cfquery name="getcust" datasource="#dts#">
        		Select * from #target_arcust# where custno = "#custno#"
      		</cfquery>
    	</cfif>

		document.invoicesheet.BCode.value = "Profile";
		document.invoicesheet.b_name.value = "#getcust.name#";
		document.invoicesheet.b_name2.value = "#getcust.name2#";
		document.invoicesheet.b_add1.value = "#getcust.add1#";
    	document.invoicesheet.b_add2.value = "#getcust.add2#";
    	document.invoicesheet.b_add3.value = "#getcust.add3#";
    	document.invoicesheet.b_add4.value = "#getcust.add4#";
    	document.invoicesheet.b_attn.value = "#getcust.attn#";
    	document.invoicesheet.b_phone.value = "#getcust.phone#";
    	document.invoicesheet.b_fax.value = "#getcust.fax#";
  		</cfoutput>
  		return true;
	}

	function CopyBillAddr()
	{
    	<cfoutput>
		<cfif #tran# eq "rc" or #tran# eq "pr" or #tran# eq "po">
      		<cfquery name="getcust" datasource="#dts#">
        		Select * from #target_apvend# where custno = "#custno#"
      		</cfquery>
    	<cfelse>
      		<cfquery name="getcust" datasource="#dts#">
        		Select * from #target_arcust# where custno = "#custno#"
      		</cfquery>
    	</cfif>

		document.invoicesheet.DCode.value = "Profile";
		document.invoicesheet.d_name.value = "#getcust.name#";
		document.invoicesheet.d_name2.value = "#getcust.name2#";
		document.invoicesheet.d_add1.value = "#getcust.daddr1#";
    	document.invoicesheet.d_add2.value = "#getcust.daddr2#";
    	document.invoicesheet.d_add3.value = "#getcust.daddr3#";
    	document.invoicesheet.d_add4.value = "#getcust.daddr4#";
    	document.invoicesheet.d_attn.value = "#getcust.dattn#";
    	document.invoicesheet.d_phone.value = "#getcust.dphone#";
    	document.invoicesheet.d_fax.value = "#getcust.dfax#";
  		</cfoutput>
  		return true;
	}
	
	function CopyCollectAddr()
	{
  		<cfoutput>
    	<cfif #tran# eq "rc" or #tran# eq "pr" or #tran# eq "po">
      		<cfquery name="getcust" datasource="#dts#">
        		Select * from #target_apvend# where custno = "#custno#"
      		</cfquery>
    	<cfelse>
      		<cfquery name="getcust" datasource="#dts#">
        		Select * from #target_arcust# where custno = "#custno#"
      		</cfquery>
    	</cfif>

		document.invoicesheet.CCode.value = "Profile";
		document.invoicesheet.c_name.value = "#getcust.name#";
		document.invoicesheet.c_name2.value = "#getcust.name2#";
		document.invoicesheet.c_add1.value = "#getcust.add1#";
    	document.invoicesheet.c_add2.value = "#getcust.add2#";
    	document.invoicesheet.c_add3.value = "#getcust.add3#";
    	document.invoicesheet.c_add4.value = "#getcust.add4#";
    	document.invoicesheet.c_attn.value = "#getcust.attn#";
    	document.invoicesheet.c_phone.value = "#getcust.phone#";
    	document.invoicesheet.c_fax.value = "#getcust.fax#";
  		</cfoutput>
  		return true;
	}
	
	function trim(str)
	{    
		if(!str || typeof str != 'string')        
		return null;    
		return str.replace(/^[\s]+/,'').replace(/[\s]+$/,'').replace(/[\s]{2,}/,' ');
	}
	var sprytextfield1 = new Spry.Widget.ValidationTextField("sprytextfield1", "none", {validateOn:["blur"]});
	var spryselect1 = new Spry.Widget.ValidationSelect("spryselect1", {validateOn:["blur"]});
</script>
<cfwindow x="10" y="10" modal="true"  width="1100" height="600" name="createCustomer" refreshOnShow="true"
        title="Add New Customer" initshow="false"
        source="/default/maintenance/createCustomerAjax.cfm" />
<cfwindow x="10" y="10" modal="true"  width="1100" height="600" name="createSupplier" refreshOnShow="true"
        title="Add New Supplier" initshow="false"
        source="/default/maintenance/createSupplierAjax.cfm" />
<cfwindow center="true" width="520" height="400" name="findCustomer" refreshOnShow="true"
        title="Find #ptype1#" initshow="false"
        source="/default/transaction/findCustomer.cfm?type=#ptype1#&dbtype=#ptype#" />
</body>
</html>