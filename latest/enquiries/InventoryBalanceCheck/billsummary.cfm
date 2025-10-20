<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "5,1352,1353,104,1354,1355,29,1387,1388,1302,1417,1418,506,1389,1390,475,1391,1392,1375,1376,1377,703,1361,1362,702,1300,1301,1411,664,188,666,185,667,689,665,673,690,668,1068,1069,1067, 1529">
<cfinclude template="/latest/words.cfm">

<cfquery name="getgsetup" datasource="#dts#">
	SELECT * 
    FROM gsetup
</cfquery>
<cfset c_Period = getgsetup.Period>

<cfset pageTitle="#words[1529]#">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title><cfoutput>#pageTitle#</cfoutput></title>
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
    
    <script type="text/javascript">
    	function checking(){
			if(	document.billSummaryEnquiryReport.purchasereceive.checked== false && document.billSummaryEnquiryReport.purchasereturn.checked== false
            	&& document.billSummaryEnquiryReport.invoice.checked== false && document.billSummaryEnquiryReport.cashsales.checked== false
            	&& document.billSummaryEnquiryReport.debitnote.checked== false && document.billSummaryEnquiryReport.creditnote.checked== false
            	&& document.billSummaryEnquiryReport.deliveryorder.checked== false && document.billSummaryEnquiryReport.salesorder.checked== false
            	&& document.billSummaryEnquiryReport.purchaseorder.checked== false && document.billSummaryEnquiryReport.quotation.checked== false
            	&& document.billSummaryEnquiryReport.adjustmentincrease.checked== false && document.billSummaryEnquiryReport.adjustmentreduce.checked== false
            	&& document.billSummaryEnquiryReport.issue.checked== false){
                	alert("Please select at least one type of transaction !");
					return false;
                }
            else{
            	return true;
            }
            return false;
        }
	</script>
    
	<cfinclude template="/latest/filter/filterCustomer.cfm">
    <cfinclude template="/latest/filter/filterSupplier.cfm">
    <cfinclude template="/latest/filter/filterAgent.cfm">
	<cfinclude template="/latest/filter/filterProduct.cfm">
    <cfinclude template="/latest/filter/filterProject.cfm">
    <cfinclude template="/latest/filter/filterJob.cfm">
    <cfinclude template="/latest/filter/filterReferenceNo.cfm">
    <cfinclude template="/latest/date/datePickerFunction.cfm"> 
    <cfinclude template="/CFC/LastDayOfMonth.cfm">

</head>

<body class="container">
<cfoutput>
	<cfform class="formContainer form3Button" name="billSummaryEnquiryReport" id="billSummaryEnquiryReport" action="billsummaryenquiry.cfm" method="post" target="_blank" onsubmit="return checking()">
        <div>#pageTitle#</div>
        <div>
            <table> 
                <input type="hidden" name="tf_fperiodfromDesp" id="tf_fperiodfromDesp" readonly="readonly" />
                <input type="hidden" name="tf_fperiodtoDesp" id="tf_fperiodtoDesp" readonly="readonly" />
                <input type="hidden" name="rptdate" id="rptdate" value="" >
                <input type="hidden" name="tf_fperiod" id="tf_fperiod" value="" >
                
                <tr> 
                    <th><label for="customer">#words[5]#</label></th>			
                    <td>
                        <input type="hidden" id="customerFrom" name="customerFrom" class="customerFilter" data-placeholder="#words[1352]#" />
                        <input type="hidden" id="customerTo" name="customerTo" class="customerFilter" data-placeholder="#words[1353]#" />
                    </td>
                </tr>
                <tr> 
                    <th><label for="supplier">#words[104]#</label></th>			
                    <td>
                        <input type="hidden" id="supplierFrom" name="supplierFrom" class="supplierFilter" data-placeholder="#words[1354]#" />
                        <input type="hidden" id="supplierTo" name="supplierTo" class="supplierFilter" data-placeholder="#words[1355]#" />
                    </td>
                </tr>
                <tr> 
                    <th><label for="agent">#words[29]#</label></th>			
                    <td>
                        <input type="hidden" id="agentFrom" name="agentFrom" class="agentFilter" data-placeholder="#words[1387]#" />
                        <input type="hidden" id="agentTo" name="agentTo" class="agentFilter" data-placeholder="#words[1388]#" />
                    </td>
                </tr>
                <tr> 
                    <th><label for="product">#words[1302]#</label></th>			
                    <td>
                        <input type="hidden" id="productFrom" name="productFrom" class="productFilter" data-placeholder="#words[1417]#" />
                        <input type="hidden" id="productTo" name="productTo" class="productFilter" data-placeholder="#words[1418]#" />
                    </td>
                </tr>
                <tr> 
                    <th><label for="project">#words[506]#</label></th>			
                    <td>
                        <input type="hidden" id="projectFrom" name="projectFrom" class="projectFilter" data-placeholder="#words[1389]#" />
                        <input type="hidden" id="projectTo" name="projectTo" class="projectFilter" data-placeholder="#words[1390]#" />
                    </td>
                </tr>
                <tr> 
                    <th><label for="job">#words[475]#</label></th>			
                    <td>
                        <input type="hidden" id="jobFrom" name="jobFrom" class="jobFilter" data-placeholder="#words[1391]#" />
                        <input type="hidden" id="jobTo" name="jobTo" class="jobFilter" data-placeholder="#words[1392]#" />
                    </td>
                </tr>
                <tr> 
                    <th><label for="refNo">#words[1375]#</label></th>			
                    <td>
                        <input type="hidden" id="refNoFrom" name="refNoFrom" class="referenceNoFilter" data-placeholder="#words[1376]#" />
                        <input type="hidden" id="refNoTo" name="refNoTo" class="referenceNoFilter" data-placeholder="#words[1377]#" />
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
                        <input type="Text" name="dateFrom" id="dateFrom" maxlength="10" size="10" placeholder="#words[1300]#" readonly="readonly" />
                        <input type="Text" name="dateTo" id="dateTo" maxlength="10" size="10" placeholder="#words[1301]#" readonly="readonly" />
                    </td>
                </tr>
                <tr>
                    <th><label>#words[1411]#</label></th>
                    <td>
                        <div><input type="checkbox" name="purchasereceive" value="RC"> #words[664]#</div>
                        <div><input type="checkbox" name="purchasereturn" value="PR"> #words[188]#</div>
                        <div><input type="checkbox" name="invoice" value="INV"> #words[666]#</div>
                    </td>
                </tr>
                <tr>
                    <th></th>
                    <td>
                        <div><input type="checkbox" name="cashsales" value="CS"> #words[185]#</div>
                        <div><input type="checkbox" name="debitnote" value="DN"> #words[667]#</div>
                        <div><input type="checkbox" name="creditnote" value="CN"> #words[689]#</div>
                    </td>
                </tr>
                <tr>
                    <th></th>
                    <td>
                        <div><input type="checkbox" name="deliveryorder" value="DO"> #words[665]#</div>
                        <div><input type="checkbox" name="salesorder" value="SO"> #words[673]#</div>
                        <div><input type="checkbox" name="purchaseorder" value="PO"> #words[690]#</div>
                    </td>
                </tr>
                <tr>
                    <th></th>
                    <td>
                        <div><input type="checkbox" name="quotation" value="QUO"> #words[668]#</div>
                        <div><input type="checkbox" name="adjustmentincrease" value="OAI"> #words[1068]#</div>
                        <div><input type="checkbox" name="adjustmentreduce" value="OAR"> #words[1069]#</div>
                    </td>
                </tr>
                <tr>
                    <th></th>
                    <td>
                        <div><input type="checkbox" name="issue" value="ISS"> #words[1067]#</div>
                    </td>
                </tr>
            </table>
        </div>
        <div>
            <input type="Submit" name="result" id="result" value="HTML">
            <input type="Submit" name="result" id="result" value="EXCEL">
        </div>
    </cfform>
</cfoutput>
</body>
</html>