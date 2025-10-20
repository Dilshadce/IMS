<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "5, 1352, 1353, 104, 1354, 1355, 29, 1387, 1388, 506, 1389, 1390, 475, 1391, 1392, 294, 1419, 1420, 321, 1088, 1089, 689, 185, 665, 666, 667, 1067, 1068, 1069, 690, 188, 668, 664, 674, 673, 1070, 703, 1361, 1362, 702, 1300, 1301, 1120, 688, 1553, 1554, 1559, 1560, 1561, 1562, 1563 ,1564, 1565, 1566 ,1567 ,1568, 1556, 1558, 1557">
<cfinclude template="/latest/words.cfm">

<cfif url.target EQ "type1">
	<cfset pageTitle="#words[1559]#">
	<cfset formAction="report1.cfm">
    
<cfelseif url.target EQ "type2">
	<cfset pageTitle="#words[1560]#">
	<cfset formAction="report2.cfm">
    
<cfelseif url.target EQ "type3">
	<cfset pageTitle="#words[1561]#">
	<cfset formAction="report3.cfm"> 

<cfelseif url.target EQ "type4">
	<cfset pageTitle="#words[1562]#">
	<cfset formAction="report4.cfm"> 
                             
<cfelseif url.target EQ "type5">
	<cfset pageTitle="#words[1563]#">
	<cfset formAction="report5.cfm"> 
                             
<cfelseif url.target EQ "type6">
	<cfset pageTitle="#words[1564]#">
	<cfset formAction="report6.cfm"> 
                             
<cfelseif url.target EQ "type7">
	<cfset pageTitle="#words[1565]#">
	<cfset formAction="report7.cfm"> 
                             
<cfelseif url.target EQ "type8">
	<cfset pageTitle="#words[1566]#">
	<cfset formAction="report8.cfm"> 

<cfelseif url.target EQ "type9">
	<cfset pageTitle="#words[1567]#">
	<cfset formAction="report9.cfm"> 

<cfelseif url.target EQ "type10">
	<cfset pageTitle="#words[1568]#">
	<cfset formAction="report10.cfm"> 
                             
                             
</cfif>

<cfquery name="getgsetup" datasource="#dts#">
	SELECT * 
    FROM gsetup;
</cfquery>
<cfset c_Period = getgsetup.Period> 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<cfoutput>
    <title>#pageTitle#</title>
    </cfoutput>
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
    <cfinclude template="/latest/filter/filterProject.cfm">
    <cfinclude template="/latest/filter/filterJob.cfm">
    <cfinclude template="/latest/filter/filterServiceItem.cfm">
    <cfinclude template="/latest/filter/filterService.cfm">
    <cfinclude template="/latest/date/datePickerFunction.cfm"> 
</head>

<body class="container">
<cfoutput>
	<cfform class="formContainer form3Button" name="serviceReportForm" id="serviceReportForm" action="#formAction#" method="post" target="_blank">
        <div>#pageTitle#</div>
		<div>
			<table> 
            
                <input type="hidden" NAME="tf_fperiodfromDesp" id="tf_fperiodfromDesp" readonly="readonly" />
                <input type="hidden" NAME="tf_fperiodtoDesp" id="tf_fperiodtoDesp" readonly="readonly" />
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
                    <th><label for="service">#words[294]#</label></th>			
                    <td>
                        <input type="hidden" id="serviceFrom" name="serviceFrom" class="serviceFilter" data-placeholder="#words[1419]#" />
                        <input type="hidden" id="serviceTo" name="serviceTo" class="serviceFilter" data-placeholder="#words[1420]#" />
                    </td>
                </tr>
                <tr> 
                    <th><label for="serviceItem">#words[321]#</label></th>			
                    <td>
                        <input type="hidden" id="serviceItemFrom" name="serviceItemFrom" class="serviceItemFilter" data-placeholder="#words[1553]#" />
                        <input type="hidden" id="serviceItemTo" name="serviceItemTo" class="serviceItemFilter" data-placeholder="#words[1554]#" />
                    </td>
                </tr>
                <cfif url.target EQ "type9"> 
                    <tr>
                        <th><label for="billType">#words[1088]#</label></th>			
                        <td>
                            <select id="billType" name="billType">
                                <option value="">#words[1089]#</option>	 	  
                                <option value="CN">#words[689]#</option>
                                <option value="CS">#words[185]#</option>
                                <option value="DN">#words[667]#</option>
                                <option value="DO">#words[665]#</option>
                                <option value="INV">#words[666]#</option>
                                <option value="ISS">#words[1067]#</option>
                                <option value="OAI">#words[1068]#</option>
                                <option value="OAR">#words[1069]#</option>
                                <option value="PO">#words[690]#</option>
                                <option value="PR">#words[188]#</option>
                                <option value="QUO">#words[668]#</option>
                                <option value="RC">#words[664]#</option>
                                <option value="RQ">Request</option>
                                <option value="SAM">#words[674]#</option>
                                <option value="SO">#words[673]#</option>
                                <option value="TR">#words[1070]#</option>
                            </select>
                        </td>
                    </tr>
                </cfif>    
                <cfif url.target NEQ "type8" AND url.target NEQ "type9"> 
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
                </cfif>
                <cfif url.target EQ "type1">
                    <tr>
                        <th><label>#words[1556]#</label></th>
                        <td>
                            <div><input type="checkbox" name="marktype" value="RC"> #words[1120]#</div>
                            <div><input type="checkbox" name="marktype" value="PR"> #words[188]#</div>
                            <div><input type="checkbox" name="marktype" value="INV"> #words[666]#</div>
                        </td>
                    </tr>
                    <tr>
                        <th><label></label></th>
                        <td>
                            <div><input type="checkbox" name="marktype" value="DO"> #words[665]#</div>
                            <div><input type="checkbox" name="marktype" value="CS"> #words[185]#</div>
                            <div><input type="checkbox" name="marktype" value="DN"> #words[667]#</div>
                        </td>
                    </tr>
                    <tr>
                        <th><label></label></th>
                        <td>
                            <div><input type="checkbox" name="marktype" value="ISS"> #words[1067]#</div>
                            <div><input type="checkbox" name="marktype" value="OAI"> #words[1068]#</div>
                            <div><input type="checkbox" name="marktype" value="OAR"> #words[1069]#</div>
                        </td>
                    </tr>
                    <tr>
                        <th><label></label></th>
                        <td>
                            <div><input type="checkbox" name="marktype" value="TR"> #words[1070]#</div>
                            <div><input type="checkbox" name="marktype" value="CN"> #words[689]#</div>
                        </td>
                    </tr>
                </cfif>  
                <cfif url.target EQ "type8" OR url.target EQ "type9">  
                    <tr>
                        <th><label>#words[688]#</label></th>
                        <td>
                            <div><input type="radio" name="period" id="period" value="1" checked="yes"> #words[703]# (1-6)</div>
                            <div><input type="radio" name="period" id="period" value="2"> #words[703]# (7-12)</div>
                            <div><input type="radio" name="period" id="period" value="3"> #words[703]# (13-18)</div>
                        </td>
                    </tr>
                    <tr>
                        <th><label></label></th>
                        <td>
                            <div><input type="radio" name="period" id="period" value="4"> #words[1557]#</div>
                            <div>#words[703]# 
                                <select id="poption" name="poption">
                                    <cfloop index="i" from="1" to="18">
                                    	<cfif i LTE 9>
                                    		<cfset periodValue = evaluate('0#i#')>
                                        <cfelse>
                                        	<cfset periodValue = evaluate('#i#')>
                                        </cfif>
                                        <option value="#periodValue#">#i#</option>
                                    </cfloop>
                                </select>
                            </div>
                            <div><input type="checkbox" name="include" id="include" value="yes"> #words[1558]#</div>
                        </td>
                    </tr>
            	</cfif>        
            </table>
        </div>
        <div>
        	<cfif url.target NEQ "type3" AND url.target NEQ "type4" AND url.target NEQ "type5">
            	<input type="Submit" name="submit" id="submit" value="SUBMIT">
            <cfelse>
                <input type="Submit" name="result" id="result" value="HTML"  />
                <input type="Submit" name="result" id="result" value="EXCEL"  />
            </cfif>
            <input type="button" name="Back" value="BACK" onclick="history.go(-1);">
        </div>
    </cfform>
</cfoutput>
</body>
</html>