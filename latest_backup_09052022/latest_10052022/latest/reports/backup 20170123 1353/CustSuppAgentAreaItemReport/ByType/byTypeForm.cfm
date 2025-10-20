<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "123, 495, 496, 146, 497, 498, 86, 1485, 1486, 1302, 1417, 1418, 29, 1387, 1388, 5, 1352, 1353, 6, 703, 1361, 1362, 702, 1300, 1301, 1997, 2011, 2012, 2013, 1999, 2000, 2017">
<cfinclude template="/latest/words.cfm">

<cfquery name="getgsetup" datasource="#dts#">
	SELECT * from gsetup
</cfquery>

<cfset c_Period = getgsetup.Period>

<cfparam name="alown" default="0">

<cfif getpin2.h4700 eq 'T'>
	<cfset alown = 1>
</cfif>

<cfif type EQ "customerproducttype">
	<cfset trantype = "CUSTOMER - PRODUCT SALES">
	<cfset pageTitle="#words[1997]#">
	<cfset formAction="typeReport1.cfm?trantype=#trantype#&alown=#alown#">
    
<cfelseif type EQ "productcustomertype">
	<cfset trantype = "PRODUCT - CUSTOMER SALES">
	<cfset pageTitle="#words[2011]#">
	<cfset formAction="typeReport2.cfm?trantype=#trantype#&alown=#alown#">
    
<cfelseif type EQ "agentproducttype">
	<cfset trantype = "AGENT - PRODUCT SALES">
	<cfset pageTitle="#words[2012]#">
	<cfset formAction="typeReport3.cfm?trantype=#trantype#&alown=#alown#"> 

<cfelseif type EQ "areacategorytype">
	<cfset trantype = "AREA - CATEGORY SALES">
	<cfset pageTitle="#words[2013]#">
	<cfset formAction="typeReport4.cfm?trantype=#trantype#&alown=#alown#">
                             
<cfelseif type EQ "addressproducttype">
	<cfset trantype = "ADDRESS - PRODUCT SALES">
	<cfset pageTitle="Address - Product Sale">
	<cfset formAction="typeReport5.cfm?trantype=#trantype#&alown=#alown#"> 
</cfif>

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

    <cfinclude template="/latest/filter/filterCategory.cfm">
    <cfinclude template="/latest/filter/filterGroup.cfm">
    <cfinclude template="/latest/filter/filterArea.cfm">
    <cfinclude template="/latest/filter/filterProduct.cfm">
    <cfinclude template="/latest/filter/filterAgent.cfm">
	<cfinclude template="/latest/filter/filterCustomer.cfm">
    <cfinclude template="/latest/filter/filterAddress.cfm">
    <cfinclude template="/latest/date/datePickerFunction.cfm"> 
    <cfinclude template="/CFC/LastDayOfMonth.cfm">


</head>

<body class="container">
<cfoutput>
	<cfform class="formContainer form4Button" name="byTypeForm" id="byTypeForm" action="#formAction#" method="post" target="_blank">
        <div>#pageTitle#</div>
      <div>
        <table> 
        
        	<input type="hidden" NAME="tf_fperiodfromDesp" id="tf_fperiodfromDesp" readonly="readonly" />
			<input type="hidden" NAME="tf_fperiodtoDesp" id="tf_fperiodtoDesp" readonly="readonly" />
			<input type="hidden" name="rptdate" id="rptdate" value="" >
			<input type="hidden" name="tf_fperiod" id="tf_fperiod" value="" >
            
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
            <tr> 
                <th><label for="area">#words[86]#</label></th>			
                <td>
                    <input type="hidden" id="areaFrom" name="areaFrom" class="areaFilter" data-placeholder="#words[1485]#" />
                    <input type="hidden" id="areaTo" name="areaTo" class="areaFilter" data-placeholder="#words[1486]#" />
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
                <th><label for="agent">#words[29]#</label></th>			
                <td>
                    <input type="hidden" id="agentFrom" name="agentFrom" class="agentFilter" data-placeholder="#words[1387]#" />
                    <input type="hidden" id="agentTo" name="agentTo" class="agentFilter" data-placeholder="#words[1388]#" />
                </td>
            </tr>
        	<tr> 
                <th><label for="customer">#words[5]#</label></th>			
                <td>
                    <input type="hidden" id="customerFrom" name="customerFrom" class="customerFilter" data-placeholder="#words[1352]#" />
                    <input type="hidden" id="customerTo" name="customerTo" class="customerFilter" data-placeholder="#words[1353]#" />
                </td>
            </tr>
            <cfif type EQ "addressproducttype">
                <tr> 
                    <th><label for="address">#words[6]#</label></th>			
                    <td>
                        <input type="hidden" id="addressFrom" name="addressFrom" class="addressFilter" data-placeholder="#words[1999]#" />
                        <input type="hidden" id="addressTo" name="addressTo" class="addressFilter" data-placeholder="#words[2000]#" />
                    </td>
                </tr>
            </cfif>
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
				<th><label>#words[2017]#</label></th>
                <td>
                    <div><input type="checkbox" name="foc" id="foc" value="foc"> #words[2017]#</div>
                </td>
			</tr>
           
                  </table>
        </div>
        <div>
            <input type="Submit" name="result" id="result" value="HTML"  />
            <input type="Submit" name="result" id="result" value="EXCEL"  />
            <input type="button" name="Back" value="BACK" onclick="history.go(-1);">
        </div>
    </cfform>
</cfoutput>
</body>
</html>