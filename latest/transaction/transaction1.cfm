<cfinclude template = "../../CFC/convert_single_double_quote_script.cfm">

<cfquery name="getGsetup" datasource="#dts#">
	SELECT *,refno2#tran# as refno2valid
	FROM gsetup;
</cfquery>

<cfquery name="getmodule" datasource="#dts#">
    select * from modulecontrol
</cfquery>

<cfquery datasource="#dts#" name="getdisplaysetup2">
	Select * from displaysetup2
</cfquery>

<cfquery name="listCurrency" datasource="#dts#">
	SELECT currcode,currency,currency1 
	FROM #target_currency#
	ORDER BY currcode;
</cfquery>

<cfquery name="listAttention" datasource="#dts#">
	SELECT attentionno,name 
	FROM attention;
</cfquery>

<cfquery name="getdealer_menu" datasource="#dts#">
	select custSuppSortBy,productSortBy,transactionSortBy,tran_edit_name from dealer_menu limit 1
</cfquery>

<cfquery name="showall" datasource="#dts#">
	select 
	* 
	from #target_currency#;
</cfquery>


<cfif getGsetup.EDControl eq "Y" and url.ttype eq "Delete">
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
<cfparam name="alsimple" default="0">
<cfparam name="Submit" default="">
<cfparam name="ChgBillToAddr" default="">
<cfparam name="ChgDeliveryAddr" default="">
<cfparam name="ChgCollectFromAddr" default="">
<cfparam name="Scust" default="">

<!--- --->
<cfloop list="RC,PR,DO,INV,CS,CN,DN,PO,RQ,QUO,SO,SAM" index="i">

<cfif tran eq i>
  	<cfset tran = i>
  	<cfset tranname = evaluate('getGsetup.l#i#')>
  	<cfset trancode = i&"no">
  	<cfset tranarun = i&"arun">
</cfif>
</cfloop>

<cfif tran eq "rc" or tran eq "pr" or tran eq "po" or tran eq "rq">
	<cfset ptype = target_apvend>
	<cfset ptype1 = "Supplier">
<cfelse>
	<cfset ptype = target_arcust>
	<cfset ptype1 = "Customer">
</cfif>

	<cfif url.action EQ "create">
    	<cfif tran eq 'CS' and getGsetup.df_cs_cust neq ''>
        <cfset custno=getGsetup.df_cs_cust>
        <cfelse>
        <cfset custno="">
        </cfif>
     <cfset agent= "">
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
        <cfset b_email = "">
        <cfset b_phone2 = "">
        <cfset d_name = "">
        <cfset d_name2 = "">
        <cfset d_add1 = "">
        <cfset d_add2 = "">
        <cfset d_add3 = "">
        <cfset d_add4 = "">
        <cfset d_add5 = "">
        <cfset postalcode = "">
        <cfset d_postalcode = "">
        <cfset d_attn = "">
        <cfset d_phone = "">
        <cfset d_fax = "">
        <cfset d_email = "">
        <cfset d_phone2 = "">
        <cfset frem9 = "">
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
        <cfset via = "">
        <cfset T_BCode="">
        <cfset T_DCode="">
        
        <cfset mode=url.action>
        
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

            <cfquery datasource="#dts#" name="getGeneralInfo">
                select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse 
                from refnoset
                where type = '#tran#'
                and counter = 1
            </cfquery>
            <cfset invset = 1>
            <cfset counter = 1>
		</cfif>
        
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
		<cfelseif lcase(HcomID) eq "topsteel_i" or lcase(HcomID) eq "topsteelhol_i" or lcase(HcomID) eq "chemline_i" or lcase(HcomID) eq "kingston_i" or lcase(HcomID) eq "probulk_i">
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
        
	<cfelse>
    <!---edit--->
    	<cfset custno="">
         <cfset agent= "">
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
        <cfset b_email = "">
        <cfset b_phone2 = "">
        <cfset d_name = "">
        <cfset d_name2 = "">
        <cfset d_add1 = "">
        <cfset d_add2 = "">
        <cfset d_add3 = "">
        <cfset d_add4 = "">
        <cfset d_add5 = "">
        <cfset postalcode = "">
        <cfset d_postalcode = "">
        <cfset d_attn = "">
        <cfset d_phone = "">
        <cfset d_fax = "">
        <cfset d_email = "">
        <cfset d_phone2 = "">
        <cfset frem9 = "">
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
        <cfset via = "">
        <cfset T_BCode="">
        <cfset T_DCode="">
        <cfset mode=url.action>
    </cfif>
<!--- --->

<cfset buttonStatus = "btn btn-primary active" >
<cfset buttonStatus2 = "btn btn-default" >

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!---<meta name="viewport" content="width=device-width, initial-scale=1.0">--->
<title><cfoutput>#action# #tranname#</cfoutput></title>
<link rel="stylesheet" type="text/css" href="/latest/css/bootstrap/bootstrap.css">
<link rel="stylesheet" type="text/css" href="/latest/css/bootstrap-datepicker/datepicker3.css">

<!--[if lt IE 9]>
	<script type="text/javascript" src="/latest/js/html5shiv/html5shiv.js"></script>
	<script type="text/javascript" src="/latest/js/respond/respond.min.js"></script>
<![endif]-->
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="/latest/js/bootstrap/bootstrap.min.js"></script>
<script type="text/javascript" src="/latest/js/bootstrap-datepicker/bootstrap-datepicker.js"></script>

<script>
	var dts='#dts#';
	var target='#url.target#';
	var action='#action#';
</script>


	<script type="text/javascript" src="/latest/js/maintenance/target.js"></script>
    <!---Filter Template--->
    <cfinclude template="/latest/transaction/filter/filterCustomer.cfm">
    <!--- --->
    <link rel="stylesheet" href="/latest/css/select2/select2.css" />
    <script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>

   <!--- --->
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
		
		$("#submit").click(function(e) {
		alert(1);	
		});
		
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
			<cfif url.tran eq "DN" or url.tran eq "CN" or url.tran eq "PR" or url.tran eq "RC" or url.tran eq "CS" or url.tran eq "QUO" >
			var tran = "INV";
			</cfif>
			<cfif url.tran eq "SAM">
			var tran = "SAM";
			</cfif>
			var tablename = document.invoicesheet.ptype.value;
			
			DWREngine._execute(_tranflocation, null, 'getCustSuppDetails', tablename, columnvalue, tran, showCustSuppDetails);
			ajaxFunction(window.document.getElementById('attnajax'),'attentionajax.cfm?custno='+document.getElementById('custno').value);
		
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
			DWRUtil.setValue("b_email", CustSuppObject.B_EMAIL);
			<cfif getGsetup.ASACTP eq "N">
			DWRUtil.setValue("BCode", "");
			</cfif>
			if(CustSuppObject.TRAN == 'PO' || CustSuppObject.TRAN == 'SO' || CustSuppObject.TRAN == 'INV' || CustSuppObject.TRAN == 'DO' || CustSuppObject.TRAN == 'SAM' || CustSuppObject.TRAN == 'DN' || CustSuppObject.TRAN == 'CN' || CustSuppObject.TRAN == 'PR' || CustSuppObject.TRAN == 'RC' || CustSuppObject.TRAN == 'CS' || CustSuppObject.TRAN == 'QUO' || CustSuppObject.TRAN == 'RQ'){

			<cfif  url.tran eq "PO" and (lcase(HcomID) eq "topsteel_i" or lcase(HcomID) eq "topsteelhol_i")>
			<cfelse>
			<cfif getGsetup.ASACTP neq "N">
				DWRUtil.setValue("DCode", CustSuppObject.DCODE);
			</cfif>
			<cfif getGsetup.ASDA neq "N">
				DWRUtil.setValue("d_name", CustSuppObject.D_NAME);
				
				DWRUtil.setValue("d_name2", CustSuppObject.D_NAME2);
				</cfif>
				</cfif>
				<cfif getGsetup.ASDA neq "N">
				DWRUtil.setValue("d_add1", CustSuppObject.D_ADD1);
				DWRUtil.setValue("d_add2", CustSuppObject.D_ADD2);
				DWRUtil.setValue("d_add3", CustSuppObject.D_ADD3);
				DWRUtil.setValue("d_add4", CustSuppObject.D_ADD4);
				DWRUtil.setValue("d_add5", CustSuppObject.D_ADD5);
				DWRUtil.setValue("d_attn", CustSuppObject.D_ATTN);
				DWRUtil.setValue("d_phone", CustSuppObject.D_PHONE);
				DWRUtil.setValue("d_fax", CustSuppObject.D_FAX);
				DWRUtil.setValue("d_phone2", CustSuppObject.CONTACT);
				</cfif>
			}
			
		}
		
		<!---RQ update delivery info--->
		function updateDetailsRQ(columnvalue){
			var tran = "SAM";
			
			var tablename = document.invoicesheet.ptype.value;
			DWREngine._execute(_tranflocation, null, 'getCustSuppDetails', tablename, columnvalue, tran, showCustSuppDetailsRQ);
		}
		
		function showCustSuppDetailsRQ(CustSuppObject){
			DWRUtil.setValue("d_name", CustSuppObject.B_NAME);
			DWRUtil.setValue("d_name2", CustSuppObject.B_NAME2);
			DWRUtil.setValue("d_add1", CustSuppObject.B_ADD1);
			DWRUtil.setValue("d_add2", CustSuppObject.B_ADD2);
			DWRUtil.setValue("d_add3", CustSuppObject.B_ADD3);
			DWRUtil.setValue("d_add4", CustSuppObject.B_ADD4);
			DWRUtil.setValue("d_add5", CustSuppObject.B_ADD5);
			DWRUtil.setValue("d_attn", CustSuppObject.B_ATTN);
			DWRUtil.setValue("d_phone", CustSuppObject.B_PHONE);
			DWRUtil.setValue("d_fax", CustSuppObject.B_FAX);
			DWRUtil.setValue("d_phone2", CustSuppObject.B_PHONE2);
			
		}
		<!--- --->
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
		
		function selectlistRQ(custno){

			for (var idx=0;idx<document.getElementById('remark5').options.length;idx++) {
        if (custno==document.getElementById('remark5').options[idx].value) {
            document.getElementById('remark5').options[idx].selected=true;
			updateDetailsRQ(custno);
        	}
    	} 
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
   <!--- --->

</head>
<body>
<cfoutput>
       
        
        
		<form class="form-horizontal" name="form" role="form" action="transaction2.cfm" method="post" ><!--- onsubmit="document.getElementById('custno').disabled=false";--->
			<input type="hidden" name="mode" value="#mode#">
            <input type="hidden" name="tran" id="tran" value="#listfirst(tran)#">
            <input type="hidden" name="invset" id="invset" value="#listfirst(invset)#">
      		<input type="hidden" name="tranarun" id="tranarun" value="#listfirst(tranarun)#">
            <cfif tran eq "rc" or tran eq "pr" or tran eq "po" or tran eq "rq">
            <input type="hidden" id="targetTable" name="targetTable" value="#target_apvend#" />
            <cfelse>
            <input type="hidden" id="targetTable" name="targetTable" value="#target_arcust#" />
            </cfif>
            <input type="hidden" id="addsearchtype" name="addsearchtype" value="" />
            <table width="100%">
            <tr>
            <td colspan="100%">
            <img src="/images/transaction page header-01.png" width="100%" >
            </td>
            </tr>
            <tr>
            <td rowspan="4" width="30%">
            <table style="margin:5% 5% 5% 5%" border="1" width="80%" height="80">
            <tr>
            <td width="50%" height="100%" style=" background-color:##999; font-size:14px" align="center">Last Sales Order<br><font size="+1">1111</font></td>
			<td width="50%" height="100%" style=" font-size:14px" align="center">New Sales Order<br><font size="+1">
            <cfif tranarun_1 eq "1">
			<input name="nexttranno" type="hidden" value="#nexttranno#">
            #nexttranno#
            <cfelse>
            <input name="nexttranno" id="nexttranno" type="text" value="#nexttranno#" onvalidate="javascript:NextTransNo()" size="10" onKeyUp="this.value=trim(this.value)" <cfif lcase(HcomID) eq "leatat_i">maxlength="30"<cfelse><cfif tran eq 'SO' or tran eq 'PO' or tran eq 'QUO'>maxlength="24"<cfelse><cfif lcase(HcomID) eq "meisei_i" and tran eq "RC">maxlength = "10"<cfelse>maxlength="20"</cfif></cfif></cfif>>
            </cfif>
            </font></td>
            </tr>
            </table>
            </td>
            <th>Sales Order Date</th>
            <th>Choose a #ptype1#</th>
            
            </tr>
            <tr>
 			<td width="30%" nowrap>
            <cfif mode eq "Create">
                <input type="text" name="invoicedate" id="invoicedate" value="<cfif isdefined("url.invoicedate")>#url.invoicedate#<cfelse>#dateformat(now(),"dd/mm/yyyy")#</cfif>" validate="eurodate" size="10" maxlength="10">
                <cfelse>
                <input type="text" name="invoicedate" id="invoicedate" value="#dateformat(nDateCreate,"dd/mm/yyyy")#" validate="eurodate" size="10" maxlength="10">
            </cfif><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(invoicedate);">(DD/MM/YYYY)
            </td>
            <td width="40%">
            <cfif custno neq ''>
				<cfset displayValue = custno>   
            <cfelse>
                <cfset displayValue = "Choose an #ptype1#">
            </cfif>
            <input type="hidden" id="custno" name="custno" class="customerFilter"  placeholder="#displayValue#" />
            <cfif getpin2.h1210 eq 'T'><a onClick="javascript:ColdFusion.Window.show('create#ptype1#');" onMouseOver="this.style.cursor='hand';">Create New #ptype1#</a></cfif>
            </td>
            </tr>
            <tr>
            <th colspan="2">Name</th>
            </tr>
            <tr>
            <td colspan="2">
            <input name="name" id="name" type="text" size="35" maxlength="40" value="#b_name#" <cfif getdealer_menu.tran_edit_name neq 'Y'>readonly</cfif>>&nbsp;&nbsp;&nbsp;&nbsp;<input name="name2" id="name2" type="text" size="35" maxlength="40" value="#b_name2#" <cfif getdealer_menu.tran_edit_name neq 'Y'>readonly</cfif>>
            </td>
            </tr>
            
            </table>
            <hr>
            <table width="100%" style="margin:0 0 0 5%">
            <tr>
            <td width="50%" style="font-size:18px; color:##F00">Billing
            </td>
            <td width="50%" style="font-size:18px; color:##F00">Delivery
            </td>
            </tr>
            
            <!---<cfloop list="code,name,add1,add2,add3,add4,attn,phone,phonea,fax,email">
            </cfloop>
            --->
            <tr>
            <th>Address Code</th>
            <th>Address Code</th>
            </tr>
            <tr>
            <td><input type="text" name="BCode" id="BCode" value="#T_BCode#" size="15"></td>
            <td><input type="text" name="DCode" id="DCode" value="<cfif  url.tran eq "PO" and (lcase(HcomID) eq "topsteel_i" or lcase(HcomID) eq "topsteelhol_i") ><cfelse>#T_DCode#</cfif>"></td>
            </tr>
            
            <tr>
            <th>Name</th>
            <th>Name</th>
            </tr>
            
            <tr>
            <td><input type="text" name="b_name" id="b_name" value="#convertquote(b_name)#" size="45" maxlength="40" <cfif getdealer_menu.tran_edit_name neq 'Y'>readonly</cfif>></td>
            <td><input type="text" name="d_name" id="d_name" <cfif getdealer_menu.tran_edit_name neq 'Y'>readonly</cfif> value="#convertquote(d_name)#" size="45" maxlength="45"></td>
            </tr>
            
            
            <tr>
            <td><input type="text" name="b_name2" id="b_name2" value="#convertquote(b_name2)#" <cfif getdealer_menu.tran_edit_name neq 'Y'>readonly</cfif> size="45" maxlength="35"></td>
            <td><input type="text" name="d_name2" id="d_name2" <cfif getdealer_menu.tran_edit_name neq 'Y'>readonly</cfif> value="#convertquote(d_name2)#" size="45" maxlength="35"></td>
            </tr>
            
            <tr>
            <th>Address</th>
            <th>Address</th>
            </tr>

            <tr>
            <td><input type="text" name="b_add1" id="b_add1" value="#b_add1#" size="45" maxlength="35">
            &nbsp;<span class="glyphicon glyphicon-search btn-link" onMouseOver="JavaScript:this.style.cursor='hand';" onClick="document.getElementById('addsearchtype').value='bill';ColdFusion.Window.show('findaddress');"></td>
            <td><input type="text" name="d_add1" id="d_add1" value="#d_add1#" size="45" maxlength="35">
            &nbsp;<span class="glyphicon glyphicon-search btn-link" onMouseOver="JavaScript:this.style.cursor='hand';" onClick="document.getElementById('addsearchtype').value='delivery';ColdFusion.Window.show('findaddress');">
            </td>
            </tr>
            
            <tr>
            <td><input type="text" name="b_add2" id="b_add2" value="#b_add2#" size="45" maxlength="35"></td>
            <td><input type="text" name="d_add2" id="d_add2" value="#d_add2#" size="45" maxlength="35"></td>
            </tr>
            
            <tr>
            <td><input type="text" name="b_add3" id="b_add3" value="#b_add3#" size="45" maxlength="35"></td>
            <td><input type="text" name="d_add3" id="d_add3" value="#d_add3#" size="45" maxlength="35"></td>
            </tr>
            
            <tr>
            <td><input type="text" name="b_add4" id="b_add4" value="#b_add4#" size="45" maxlength="35"></td>
            <td><input type="text" name="d_add4" id="d_add4" value="#d_add4#" size="45" maxlength="35"></td>
            </tr>
            
            <tr>
            <th>Postal Code</th>
            <th>Postal Code</th>
            </tr>
            
            <tr>
            <td><input type="text" name="postalcode" id="postalcode" value="#postalcode#" size="45" maxlength="35"></td>
            <td><input type="text" name="d_postalcode" id="d_postalcode" value="#d_postalcode#" size="45" maxlength="35"></td>
            </tr>
            
            <tr>
            <th>Attention</th>
            <th>Attention</th>
            </tr>
            
            <tr>
            <td>
            <cfif getgsetup.attnddl eq 'Y'>
            <div id="attnajax">
            <cfquery name="getattentionprofile" datasource="#dts#">
            select * from attention <cfif isdefined('custno')>where customerno='#custno#' or customerno=''</cfif>
            </cfquery>
            <select name="b_attn" id="b_attn">
            <option value="" >Please Choose a Attention</option>
            <cfloop query="getattentionprofile">
            <option value="#getattentionprofile.attentionno#" <cfif getattentionprofile.attentionno eq b_attn>selected</cfif>>#getattentionprofile.attentionno# - #getattentionprofile.name#</option>
            </cfloop>
            </select>
            </div>
            <cfelse>
            <input type="text" name="b_attn" id="b_attn" value="#b_attn#" size="45" maxlength="35">
            </cfif>
            </td>
            <td>
            <cfif getgsetup.attnddl eq 'Y'>
            <div id="dattnajax">
            <cfquery name="getattentionprofile" datasource="#dts#">
            select * from attention <cfif isdefined('custno')>where customerno='#custno#' or customerno=''</cfif>
            </cfquery>
            <select name="d_attn" id="d_attn">
            <option value="" >Please Choose a Attention</option>
            <cfloop query="getattentionprofile">
            <option value="#getattentionprofile.attentionno#" <cfif getattentionprofile.attentionno eq b_attn>selected</cfif>>#getattentionprofile.attentionno# - #getattentionprofile.name#</option>
            </cfloop>
            </select>
            </div>
            <cfelse>
            <input type="text" name="d_attn" id="d_attn" value="#d_attn#" size="45" maxlength="35">
            </cfif>
            </td>
            </tr>
            
            <tr>
            <th>Phone</th>
            <th>Phone</th>
            </tr>
            
            <tr>
            <td><input type="text" name="b_phone" id="b_phone" value="#b_phone#" size="45" maxlength="35"></td>
            <td><input type="text" name="d_phone" id="d_phone" value="#d_phone#" size="45" maxlength="35"></td>
            </tr>
            
            <tr>
            <th>Hp</th>
            <th>Hp</th>
            </tr>
            
            <tr>
            <td><input type="text" name="b_phone2" id="b_phone2" value="#b_phone2#" size="45" maxlength="35"></td>
            <td><input type="text" name="d_phone2" id="d_phone2" value="#d_phone2#" size="45" maxlength="35"></td>
            </tr>
            
            <tr>
            <th>Fax</th>
            <th>Fax</th>
            </tr>
            
            <tr>
            <td><input type="text" name="b_fax" id="b_fax" value="#b_fax#" size="45" maxlength="35"></td>
            <td><input type="text" name="d_fax" id="d_fax" value="#d_fax#" size="45" maxlength="35"></td>
            </tr>
            
            <tr>
            <th>Email</th>
            <th>Email</th>
            </tr>
            
            <tr>
            <td><input type="text" name="b_email" id="b_email" value="#b_email#" size="45" maxlength="45"></td>
            <td><input type="text" name="d_email" id="d_email" value="#d_email#" size="45" maxlength="45"></td>
            </tr>
            
            <cfif lcase(hcomid) eq 'ugateway_i'>
            <tr>
            <td></td>
            <th>Via</th>
            </tr>
            <tr>
            <td></td>
            <td>
            <select name="via" id="via" >
            <option value="">Please Select VIA</option>
            <option value="air">By Air</option>
            <option value="post">By Post</option>
            <option value="mail">By Mail</option>
            <option value="agent">By Sales Agent</option>
            </select>
            </td>
        
       		</tr>
        	</cfif>
            <cfif getGsetup.collectaddress eq 'Y'>
                <tr>
                    <td colspan="100%"></td>
                </tr>
                <tr>
                <th>Address Code</th>
                </tr>
                <tr>
                    <td><input type="text" name="CCode" id="CCode" value="#T_CCode#" size="15">
                    <a onClick="MM_openBrWindow('/customized/iel_i/maintenance/collectionaddresstable2.cfm?type=create&custno='+document.getElementById('custno').<cfif getGsetup.suppcustdropdown eq "1">options[document.getElementById('custno').selectedIndex].value<cfelse>value</cfif>,'CreateNewCollectionAddresss','scrollbars=yes,width=600,height=500')" onMouseMove="JavaScript:this.style.cursor='hand'">Create New Collection</a>                    </td>
                </tr>
                <tr>
                <th>Name</th>
                </tr>
                <tr>
                    <td><input type="text" name="c_name" id="c_name" value="#c_name#" size="45" maxlength="45"><img src="/images/down.png" border="0" onClick="ajaxFunction(window.document.getElementById('collectadd'),'/default/transaction/transaction1Ajax.cfm?custno='+document.getElementById('custno').<cfif getGsetup.suppcustdropdown eq "1">options[document.getElementById('custno').selectedIndex].value<cfelse>value</cfif>);showsa();" width="15" height="15" onMouseMove="JavaScript:this.style.cursor='hand'"/><br />
                    <div style="display : none ; position: absolute;" id="collectadd"> 
                </div>
                </td>
                </tr>
                <tr>
                    <td><input type="text" name="c_name2" id="c_name2" value="#c_name2#" size="45" maxlength="35"></td>
                </tr>
                <tr>
                <th>Collect From :</th>
                </tr>
                <tr>
                    <td><input type="text" name="c_add1" id="c_add1" value="#c_add1#" size="45" maxlength="35"></td>
                		<input type="Button" name="ProfileAddr" id="ProfileAddr" value="Click" onClick="javascript:CopyCollectAddr();">
                </tr>
                <tr>
                    <td><input type="text" name="c_add2" id="c_add2" value="#c_add2#" size="45" maxlength="35"></td>
                </tr>
                <tr>
                    <td><input type="text" name="c_add3" id="c_add3" value="#c_add3#" size="45" maxlength="35"></td>
                </tr>
                <tr>
                    <td><input type="text" name="c_add4" id="c_add4" value="#c_add4#" size="45" maxlength="35"></td>
                </tr>
                <tr>
                	<th>Attn :</th>
                </tr>
                <tr>
                    <td><input type="text" name="c_attn" id="c_attn" value="#c_attn#" size="45" maxlength="35"></td>
                </tr>
                <tr>
                	<th>Telephone :</th>
                </tr>
                <tr>
                    <td><input type="text" name="c_phone" id="c_phone" value="#c_phone#" size="45" maxlength="35"></td>
                </tr>
                <tr>
                	<th>Fax :</th>
                </tr>
                <tr>
                    <td><input type="text" name="c_fax" id="c_fax" value="#c_fax#" size="45" maxlength="35"></td>
                </tr>
            <cfelse>
                <input type="hidden" name="CCode" id="CCode" value="" size="15">
            </cfif>
            <!--- --->
            <tr>
      		<td colspan="100%" align="center">
          	<cfif xrelated eq 1>
            	<h3>
				<input name="recover" id="recover" type="checkbox" value="1" checked>
            	<input name="related" id="related" type="hidden" value="1">
            	Recover related #xtype#
                </h3>
          	</cfif>
            <h3>
            <cfif isdefined('xtype')>
				<cfif dts eq 'thats_i' and xtype eq 'QUO'>
                    <input name="recoverCoC" id="recoverCoC" type="checkbox" value="1" checked>
                    Recover related QA08 CoC
                </cfif>
            </cfif>
                </h3>
			<cfif mode eq "Delete">
				<cfif getGsetup.keepDeletedBills eq "1">
					<h3>
	            	<input name="keepDeleted" id="keepDeleted" type="checkbox" value="1" checked>
	            	Keep Deleted Bills
					</h3>
				</cfif>
			</cfif>
            </td>
            </tr>
            </table>
          
			
			<div align="center">
				<button type="submit" class="btn btn-primary" id="submit">Next</button>
				<button type="button" class="btn btn-default" onclick="window.location='/latest/maintenance/transaction.cfm?type=#tran#'" >Cancel</button>
			</div>
		</form>		
	</div>
</cfoutput>
</body>
</html>

<cfwindow center="true" width="580" height="400" name="findaddress" refreshOnShow="true"
        title="Find Address" initshow="false"
        source="/latest/transaction/findaddress.cfm?addtype={addsearchtype}&custno={custno}" />