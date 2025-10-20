<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1408,1409,1410,5,1352,1353,104,1354,1355,29,1387,1388,274,275,276,482,499,500,506,1389,1390,1375,1376,1377,703,1361,1362,702,1300,1301,1411,664,188,666,185,667,689,665,673,690,668,1068,1069,1067,501">
<cfinclude template="/latest/words.cfm">
<cfif url.target EQ "type1">
	<cfset pageTitle="#words[1408]#">
	<cfset formAction="report1.cfm">
    
<cfelseif url.target EQ "type2">
	<cfset pageTitle="#words[1409]#">
	<cfset formAction="report2.cfm">
    
<cfelseif url.target EQ "type3">
	<cfset pageTitle="#words[1410]#">
	<cfset formAction="report3.cfm">                          
</cfif>

<cfquery name="getgsetup" datasource="#dts#">
	SELECT * 
    FROM gsetup
</cfquery>
<cfset c_Period = getgsetup.Period>

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
			if(	document.exceptionReport.purchasereceive.checked== false && document.exceptionReport.purchasereturn.checked== false
            	&& document.exceptionReport.invoice.checked== false && document.exceptionReport.cashsales.checked== false
            	&& document.exceptionReport.debitnote.checked== false && document.exceptionReport.creditnote.checked== false
            	&& document.exceptionReport.deliveryorder.checked== false && document.exceptionReport.salesorder.checked== false
            	&& document.exceptionReport.purchaseorder.checked== false && document.exceptionReport.quotation.checked== false
            	&& document.exceptionReport.adjustmentincrease.checked== false && document.exceptionReport.adjustmentreduce.checked== false
            	&& document.exceptionReport.issue.checked== false){
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
	<cfinclude template="/latest/filter/filterItem.cfm">
    <cfinclude template="/latest/filter/filterBrand.cfm">
    <cfinclude template="/latest/filter/filterCategory.cfm">
    <cfinclude template="/latest/filter/filterGroup.cfm">
    <cfinclude template="/latest/filter/filterLocation.cfm">
    <cfinclude template="/latest/filter/filterProject.cfm">
    <cfinclude template="/latest/filter/filterReferenceNo.cfm">
    <cfinclude template="/latest/date/datePickerFunction.cfm"> 
    <cfinclude template="/CFC/LastDayOfMonth.cfm">

</head>

<body class="container">
<cfoutput>
	<cfform class="formContainer form3Button" name="exceptionReport" id="exceptionReport" action="#formAction#" method="post" target="_blank" onsubmit="return checking()">
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
                <cfif url.target NEQ "type2">
                    <tr> 
                        <th><label for="agent">#words[29]#</label></th>			
                        <td>
                            <input type="hidden" id="agentFrom" name="agentFrom" class="agentFilter" data-placeholder="#words[1387]#" />
                            <input type="hidden" id="agentTo" name="agentTo" class="agentFilter" data-placeholder="#words[1388]#" />
                        </td>
                    </tr>
                </cfif>
                <tr> 
                    <th><label for="item">#words[274]#</label></th>			
                    <td>
                        <input type="hidden" id="itemFrom" name="itemFrom" class="itemFilter" data-placeholder="#words[275]#" />
                        <input type="hidden" id="itemTo" name="itemTo" class="itemFilter" data-placeholder="#words[276]#" />
                    </td>
                </tr>
                <tr> 
                    <th><label for="location">#words[482]#</label></th>			
                    <td>
                        <input type="hidden" id="locationFrom" name="locationFrom" class="locationFilter" data-placeholder="#words[499]#" />
                        <input type="hidden" id="locationTo" name="locationTo" class="locationFilter" data-placeholder="#words[500]#" />
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
            <input type="Submit" name="Submit" value="#words[501]#">
        </div>
    </cfform>
</cfoutput>
</body>
</html>