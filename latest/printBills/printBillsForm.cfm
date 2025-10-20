<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "690,664,188,668,673,665,666,185,689,1068,1069,1072,1073,1067,1350,1351,5,1352,1353,104,1354,1355,1270,1356,1357,1358,1359,1360,703,1361,1362,702,1363,1364,1365,1366,352,1111,688,667">
<cfinclude template="/latest/words.cfm">
<cfoutput>
<cfset pageTitle = name>
<cfif name EQ 'debit note'>
	<cfset pageTitle = "#words[667]#">
</cfif>
<cfif url.target eq 'PO'>
	<cfset pageTitle = "#words[690]#">
<cfelseif url.target eq 'RC'>
	<cfset pageTitle = '#words[664]#'>
<cfelseif url.target eq 'PR'>
	<cfset pageTitle = "#words[188]#">
<cfelseif url.target eq 'QUO'>
	<cfset pageTitle = "#words[668]#">
<cfelseif url.target eq 'SO'>
	<cfset pageTitle = "#words[673]#">
<cfelseif url.target eq 'DO'>
	<cfset pageTitle = "#words[665]#">
<cfelseif url.target eq 'INV'>
	<cfset pageTitle = "#words[666]#">
<cfelseif url.target eq 'CS'>
	<cfset pageTitle = "#words[185]#">
<cfelseif url.target eq 'CN'>
	<cfset pageTitle = "#words[689]#">
<cfelseif url.target eq 'OAI'>
	<cfset pageTitle = "#words[1068]#">
<cfelseif url.target eq 'OAR'>
	<cfset pageTitle = "#words[1069]#">
<cfelseif url.target eq 'TR' and url.menuID eq '30313'>
	<cfset pageTitle = "#words[1072]#">
<cfelseif url.target eq 'TR' and url.menuID eq '30314'>
	<cfset pageTitle = "#words[1073]#">
<cfelseif url.target eq 'ISS'>
	<cfset pageTitle = "#words[1067]#">
<cfelseif url.target eq 'TR' and url.menuID eq '30316'>
	<cfset pageTitle = "#words[1350]#">
<cfelseif url.target eq 'TR' and url.menuID eq '30317'>
	<cfset pageTitle = "#words[1351]#">
</cfif>
<cfquery name="getgsetup" datasource="#dts#">
	SELECT * 
    FROM gsetup;
</cfquery>

<cfquery name="getBillNo" datasource="#dts#">
    SELECT refno 
    FROM artran 
    WHERE type = '#target#' 
    AND fperiod != '99' 
    ORDER BY refno ASC;
</cfquery>

<cfquery name="getCustomizedFormat" datasource="#dts#">
    SELECT * 
    FROM customized_format
    WHERE type='#target#'
    AND file_name <>"receipt_non_editable"
    ORDER BY counter;
</cfquery>

<cfset c_Period = getgsetup.Period>

<cfif getGsetup.wpitemtax EQ ''> 
	<cfset taxCounter = '1'>
<cfelse>
	<cfset taxCounter = '2'>	
</cfif>    
            
<cfset formAction = "/latest/printBills/print_bills_result.cfm?tran=#target#&tranname=#name#&tax=#taxCounter#&GST=Y">

<cfif getCustomizedFormat.recordCount EQ 0>
	<cfif getgsetup.bcurr EQ 'MYR' >
    	<cfif getgsetup.gstno eq "">
        <cfset billFormatLocation = "/billformat/default/newDefault/MYR/preprintedformat.cfm?tran=#target#&tranname=#target#&tax=#taxCounter#&printBill=All&GST=N">	
        <cfelse>
		<cfset billFormatLocation = "/billformat/default/newDefault/MYR/preprintedformat.cfm?tran=#target#&tranname=#target#&tax=#taxCounter#&printBill=All&GST=Y">	
        </cfif>
    <cfelse>
    	<cfset billFormatLocation = "/billformat/default/newDefault/preprintedformat.cfm?tran=#target#&tranname=#target#&tax=#taxCounter#&printBill=All&GST=Y">	
    </cfif>
<cfelse>
	<cfset billFormatLocation = "/billformat/#dts#/preprintedformat.cfm?tran=#target#&tranname=#target#&printBill=All&billName=#getCustomizedFormat.file_name#">
</cfif>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>#pageTitle#</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <link rel="stylesheet" href="/latest/css/jqueryui/smoothness/jquery-ui-1.10.3.custom.min.css" />
    <link rel="stylesheet" href="/latest/css/select2/select2.css" />
    <link rel="stylesheet" href="/latest/css/form.css" />
    <script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <!--[if (gte IE 6)&(lte IE 8)]>
        <script type="text/javascript" src="/latest/js/selectivizr/selectivizr-min.js"></script>
        <noscript><link rel="stylesheet" href="" /></noscript>
    <![endif]-->
    <script type="text/javascript" src="/latest/js/jqueryui/jquery-ui-1.10.3.custom.min.js"></script>
    <script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>
	<cfinclude template="/latest/filter/filterCustomer.cfm">
    <cfinclude template="/latest/filter/filterSupplier.cfm">
    <cfinclude template="/latest/filter/filterDriver.cfm">
    <cfinclude template="/latest/filter/filterReferenceNo.cfm">
    <cfinclude template="/latest/date/datePickerFunction.cfm"> 
    <cfinclude template="/latest/date/datePickerFunction.cfm"> 
    <cfinclude template="/CFC/LastDayOfMonth.cfm">
    <script>
		function checkbilltype(){
			if (document.getElementById('VABT').checked) {
				document.billform.action = "#billFormatLocation#";	
			}
			else{
				document.billform.action = "#formAction#";		
			}
		}
		var Hlinkams='#Hlinkams#'
		var dts='#dts#';
    </script>
</head>
<body class="container">
	<cfform class="formContainer form3Button" name="billform" id="billform" action="#formAction#" method="post" target="_blank" onSubmit="checkbilltype()">
        <div>#pageTitle#</div>
        <div>
        <table> 
        	<input type="hidden" NAME="tf_fperiodfromDesp" id="tf_fperiodfromDesp" readonly="readonly" />
			<input type="hidden" NAME="tf_fperiodtoDesp" id="tf_fperiodtoDesp" readonly="readonly" />
			<input type="hidden" name="rptdate" id="rptdate" value="" >
			<input type="hidden" name="tf_fperiod" id="tf_fperiod" value="" >
			
            <cfif url.target NEQ 'PO' AND url.target NEQ 'PR' AND url.target NEQ 'RC'>
                <tr> 
                    <th><label for="customerLabel">#words[5]#</label></th>			
                    <td>
                        <input type="hidden" id="customerFrom" name="customerFrom" class="customerFilter" data-placeholder="#words[1352]#" />
                        <input type="hidden" id="customerTo" name="customerTo" class="customerFilter" data-placeholder="#words[1353]#" />
                    </td>
                </tr>
            <cfelse>
                <tr> 
                    <th><label for="supplierLable">#words[104]#</label></th>			
                    <td>
                        <input type="hidden" id="customerFrom" name="customerFrom" class="supplierFilter" data-placeholder="#words[1354]#" />
                        <input type="hidden" id="customerTo" name="customerTo" class="supplierFilter" data-placeholder="#words[1355]#" />
                    </td>
                </tr>
            </cfif>
            <tr> 
                <th><label for="billNoLabel">#words[1270]#</label></th>			
                <td>
                    <select name="billFrom" id="billFrom">
                        <option value="">#words[1356]#</option>
                        <cfloop query="getBillNo">
                            <option value="#getBillNo.refno#">#getBillNo.refno#</option>
                        </cfloop>
                    </select>
                    <select name="billTo" id="billTo">
                        <option value="">#words[1357]#</option>
                        <cfloop query="getBillNo">
                            <option value="#getBillNo.refno#">#getBillNo.refno#</option>
                        </cfloop>
                    </select>
                </td>
            </tr>
            <tr> 
                <th><label for="endUser">#words[1358]#</label></th>			
                <td>
                    <input type="hidden" id="driverFrom" name="driverFrom" class="driverFilter" data-placeholder="#words[1359]#" />
                    <input type="hidden" id="driverTo" name="driverTo" class="driverFilter" data-placeholder="#words[1360]#" />
                </td>
            </tr>
            <tr> 
                <th><label for="period">#words[703]#</label></th>			
                <td>
					<select name="periodFrom" id="periodFrom" Onchange="tf_fperiodfromDesp.value = this.options[this.selectedIndex].title;">
                        <option value="">#words[1361]#</option>
                          <cfloop index="fCurrMonth" from="1" to="#c_Period#">
                              <cfset fccurr = DateAdd('m', fCurrMonth, "#getgsetup.LastAccYear#")>
                              <cfset fdmont = dateformat(fccurr,"mm")>
                              <cfset fdmont2 = dateformat(fccurr,"mmmm ''yyyy")>
                              <option title="#fdmont2#" value="#numberFormat(fCurrMonth,'00')#"<cfif fcurrmonth eq 1>selected</cfif>>#fCurrMonth# - #dateformat(fccurr,"mmm'yyyy")#</option>
                          </cfloop>
                    </select>
                    <select name="periodTo" id="periodTo" Onchange="tf_fperiodtoDesp.value = this.options[this.selectedIndex].title;">
                        <option value="">#words[1362]#</option>
                        <cfloop index="fCurrMonth" from="1" to="#c_Period#">
                            <cfset fccurr = DateAdd('m', fCurrMonth, "#getgsetup.LastAccYear#")>
                            <cfset fdmont = dateformat(fccurr,"mm")>
                            <cfset fdmont2 = dateformat(fccurr,"mmmm ''yyyy")>
                            <cfset fnow = dateformat(now(),"mmmm ''yyyy")>
                            <option title="#fdmont2#" value="#numberFormat(fCurrMonth,'00')#"<cfif fnow eq fdmont2>selected</cfif>>#fCurrMonth# - #dateformat(fccurr,"mmm'yyyy")#</option>
                        </cfloop>
                    </select>
                </td>
            </tr>
            <tr> 
                <th><label for="date">#words[702]#</label></th>			
                <td>
					<input type="Text" name="dateFrom" id="dateFrom" maxlength="10" size="10" placeholder="#words[1363]#" readonly="readonly" />
					<input type="Text" name="dateTo" id="dateTo" maxlength="10" size="10" placeholder="#words[1364]#" readonly="readonly" />
                </td>
			</tr>
            <tr>
                <th><label>#words[688]#</label></th>
                <td>
                    <div><input type="radio" name="result" id="VBPB" value="VBPB" checked>#words[1365]#</div>
                    <div><input type="radio" name="result" id="VABT" value="VABT">#words[1366]#</div>
                </td>
            </tr>
        </table>
        </div>
        <div>
            <input type="Submit" name="Submit" value="#words[352]#">
            <input type="button" name="Back" value="#words[1111]#" onclick="history.go(-1);">
        </div>
    </cfform>
</body>
</html>
</cfoutput>