<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1382,665,668,690,1383,673,1384,1385,1386,5,1352,1353,104,1354,1355,29,1387,1388,274,275,276,123,495,496,146,497,498,506,1389,1390,475,1391,1392,1375,1376,1377,703,1361,1362,702,1300,1301,1393,1394,1395,1396,1378,1397,1398,501,1399,688">
<cfinclude template="/latest/words.cfm">
<cfif url.target EQ "type1">
	<cfset pageTitle="#words[1382]#">
	<cfset formAction="report1.cfm">
    
<cfelseif url.target EQ "type2">
	<cfset pageTitle="#words[665]#">
	<cfset formAction="report2.cfm?type=DO">
    <cfset target="DO">
<cfelseif url.target EQ "type3">
	<cfset pageTitle="#words[668]#">
	<cfset formAction="report2.cfm?type=QUO">
    <cfset target="QUO">
<cfelseif url.target EQ "type4">
	<cfset pageTitle="#words[690]#">
	<cfset formAction="report2.cfm?type=3">
    <cfset target="PO">
<cfelseif url.target EQ "type5">
	<cfset pageTitle="#words[1383]#">
	<cfset formAction="report2.cfm?type=4">
    <cfset target="PO">
<cfelseif url.target EQ "type6">
	<cfset pageTitle="#words[673]#">
	<cfset formAction="report2.cfm?type=5">
    <cfset target="SO">
<cfelseif url.target EQ "type7">
	<cfset pageTitle="#words[1384]#">
	<cfset formAction="report2.cfm?type=6">    
    <cfset target="SO">
<cfelseif url.target EQ "type8">
	<cfset pageTitle="#words[1385]#">
	<cfset formAction="report2.cfm?type=7">  
	<cfset target="SO">
<cfelseif url.target EQ "type9">
	<cfset pageTitle="#words[1386]#">
	<cfset formAction="report2.cfm?type=8"> 
    <cfset target="SO">                                
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
	<cfinclude template="/latest/filter/filterCustomer.cfm">
    <cfinclude template="/latest/filter/filterSupplier.cfm">
    <cfinclude template="/latest/filter/filterAgent.cfm">
	<cfinclude template="/latest/filter/filterItem.cfm">
    <cfinclude template="/latest/filter/filterCategory.cfm">
    <cfinclude template="/latest/filter/filterGroup.cfm">
    <cfinclude template="/latest/filter/filterProject.cfm">
    <cfinclude template="/latest/filter/filterJob.cfm">
    <cfinclude template="/latest/filter/filterLocation.cfm">
    <cfinclude template="/latest/filter/filterReferenceNo.cfm">
    <cfinclude template="/latest/date/datePickerFunction.cfm"> 
    <cfinclude template="/latest/date/datePickerFunction2.cfm">
    <cfinclude template="/latest/date/datePickerFunction3.cfm"> 
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
                <cfif url.target NEQ "type1">
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
                </cfif>
                <tr> 
                    <th><label for="item">#words[274]#</label></th>			
                    <td>
                        <input type="hidden" id="itemFrom" name="itemFrom" class="itemFilter" data-placeholder="#words[275]#" />
                        <input type="hidden" id="itemTo" name="itemTo" class="itemFilter" data-placeholder="#words[276]#" />
                    </td>
                </tr>
                <cfif url.target EQ "type1">
                    <tr> 
                        <th><label for="category">#words[123]#</label></th>			
                        <td>
                            <input type="hidden" id="categoryFrom" name="categoryFrom" class="categoryFilter" data-placeholder="#words[495]#" />
                            <input type="hidden" id="categoryTo" name="categoryTo" class="categoryFilter" data-placeholder="#words[496]#" />
                        </td>
                    </tr>
                    <tr> 
                        <th><label for="group">#words[146]#</label></th>			
                        <td>
                            <input type="hidden" id="groupFrom" name="groupFrom" class="groupFilter" data-placeholder="#words[497]#" />
                            <input type="hidden" id="groupTo" name="groupTo" class="groupFilter" data-placeholder="#words[498]#" />
                        </td>
                    </tr>
                </cfif>
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
                <cfif url.target NEQ "type1">
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
                            <input type="text" name="dateFrom" id="dateFrom" maxlength="10" size="10" placeholder="#words[1300]#" readonly="readonly" />
                            <input type="text" name="dateTo" id="dateTo" maxlength="10" size="10" placeholder="#words[1301]#" readonly="readonly" />
                        </td>
                    </tr>
                </cfif>    
                <cfif url.target NEQ "type1" AND url.target NEQ "type2" AND url.target NEQ "type3">
                    <tr> 
                        <th><label for="planningDeliveryDate">#words[1393]#</label></th>			
                        <td>
                            <input type="text" name="deldatefrom" id="deldatefrom" maxlength="10" size="10" placeholder="#words[1300]#" readonly="readonly" />
                            <input type="text" name="deldateto" id="deldateto" maxlength="10" size="10" placeholder="#words[1301]#" readonly="readonly" />
                        </td>
                    </tr>
                </cfif>
                <cfif url.target EQ "type1">
                    <tr> 
                        <th><label for="releaseDate">#words[1394]#</label></th>			
                        <td>
                            <input type="text" name="releasedatefrom" id="releasedatefrom" maxlength="10" size="10" placeholder="#words[1300]#" readonly="readonly" />
                            <input type="text" name="releasedateto" id="releasedateto" maxlength="10" size="10" placeholder="#words[1301]#" readonly="readonly" />
                            <div><input type="checkbox" name="itemtba" id="itemtba" value="1"> #words[1395]#</div>
                        </td>
                    </tr>
                <cfelse>               
                    <tr>
                        <th><label>#words[688]#</label></th>
                        <td>
                            <div><input type="radio" name="sortbydelivery" value="checkbox"> #words[1396]#</div>
                            <div><input type="radio" name="sortbydelivery" value="checkbox"> #words[1378]#</div>
                        </td>
                    </tr>
                    <tr>
                        <th></th>
                        <td>
                            <div><input type="checkbox" name="checkbox1" value="checkbox1">#words[1397]#</div>
                            <div><input type="checkbox" name="cbpriceamt" value="cbpriceamt">#words[1398]#</div>
                        </td>
                    </tr>
                </cfif>    
            </table>
        </div>
        <div>
            <input type="Submit" name="result" value="#words[501]#">
            <cfif url.target NEQ "type1" AND url.target NEQ "type2" AND url.target NEQ "type3">
				<input type="Submit" name="result" value="#words[1399]#">
            </cfif>
        </div>
    </cfform>
</cfoutput>
</body>
</html>