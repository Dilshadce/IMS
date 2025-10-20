<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1527, 1528, 104, 1354, 1355, 29, 1387, 1388, 86, 1485, 1486, 1302, 1417, 1418, 146, 497, 498, 123, 495, 496, 703, 1361, 1362, 702, 1300, 1301">
<cfinclude template="/latest/words.cfm">

<cfquery name="getGsetup" datasource="#dts#">
	SELECT cost,lastaccyear,cost,includemisc,period
	FROm gsetup;
</cfquery>

<cfif NOT IsDefined('form.dateRange')>
	<cfset dateRange = getgsetup.LastAccYear>
<cfelse>
	<cfset dateRange = form.dateRange>
</cfif>

<cfif type eq "productquantity">
    <cfset pageAction = "productPurchaseReport.cfm?trantype=PRODUCTS PURCHASE">
    <cfset pageTitle = "#words[1527]#">
<cfelseif type eq "vendorquantity">
    <cfset pageAction = "vendorSupplyReport.cfm?trantype=VENDOR SUPPLY">
    <cfset pageTitle = "#words[1528]#">
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

    <cfinclude template="/latest/filter/filterSupplier.cfm">
    <cfinclude template="/latest/filter/filterAgent.cfm">
    <cfinclude template="/latest/filter/filterArea.cfm">
	<cfinclude template="/latest/filter/filterProduct.cfm">
    <cfinclude template="/latest/filter/filterGroup.cfm">
    <cfinclude template="/latest/filter/filterCategory.cfm">
    <cfinclude template="/latest/date/datePickerFunction.cfm">
</head>

<body class="container">
<cfoutput>
	<cfform class="formContainer form2Button" name="byQuantityForm" id="byQuantityForm" action="#pageAction#" method="post" target="_blank">
        <div>#pageTitle#</div>
        <div>
        <table> 
        
        	<input type="hidden" NAME="tf_fperiodfromDesp" id="tf_fperiodfromDesp" readonly="readonly" />
			<input type="hidden" NAME="tf_fperiodtoDesp" id="tf_fperiodtoDesp" readonly="readonly" />
			<input type="hidden" name="rptdate" id="rptdate" value="">
			<input type="hidden" name="tf_fperiod" id="tf_fperiod" value=""> 
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
                <th><label for="group">#words[146]#</label></th>			
                <td>
                    <input type="hidden" id="groupFrom" name="groupFrom" class="groupFilter" data-placeholder="#words[497]#" />
                    <input type="hidden" id="groupTo" name="groupTo" class="groupFilter" data-placeholder="#words[498]#" />
                </td>
            </tr>
            <tr> 
                <th><label for="category">#words[123]#</label></th>			
                <td>
                    <input type="hidden" id="categoryFrom" name="categoryFrom" class="categoryFilter" data-placeholder="#words[495]#" />
                    <input type="hidden" id="categoryTo" name="categoryTo" class="categoryFilter" data-placeholder="#words[496]#" />
                </td>
            </tr>
            <tr> 
                <th><label for="period">#words[703]#</label></th>			
                <td>
                    <select name="periodFrom" id="periodFrom" Onchange="tf_fperiodfromDesp.value = this.options[this.selectedIndex].title;">
                        <option value="">#words[1361]#</option>
                          <cfloop index="fCurrMonth" from="1" to="#getGsetup.Period#">
                              <cfset fccurr = DateAdd('m', fCurrMonth, "#dateRange#")>
                              <cfset fdmont = dateformat(fccurr,"mm")>
                              <cfset fdmont2 = dateformat(fccurr,"mmmm ''yyyy")>
                              <option title="#fdmont2#" value="#numberFormat(fCurrMonth,'00')#"<cfif fcurrmonth EQ 1>selected</cfif>>#fCurrMonth# - #dateformat(fccurr,"mmm'yyyy")#</option>
                          </cfloop>
                    </select>
                    <select name="periodTo" id="periodTo" Onchange="tf_fperiodtoDesp.value = this.options[this.selectedIndex].title;">
                        <option value="">#words[1362]#</option>
                        <cfloop index="fCurrMonth" from="1" to="#getGsetup.Period#">
                            <cfset fccurr = DateAdd('m', fCurrMonth, "#dateRange#")>
                            <cfset fdmont = dateformat(fccurr,"mm")>
                            <cfset fdmont2 = dateformat(fccurr,"mmmm ''yyyy")>
                            <cfset fnow = dateformat(now(),"mmmm ''yyyy")>
                            <option title="#fdmont2#" value="#numberFormat(fCurrMonth,'00')#"<cfif fnow EQ fdmont2>selected</cfif>>#fCurrMonth# - #dateformat(fccurr,"mmm'yyyy")#</option>
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
        </table>
        </div>
        <div>
            <input type="Submit" name="result" id="result" value="HTML"  />
            <input type="Submit" name="result" id="result" value="EXCEL"  />
        </div>
    </cfform>
</cfoutput>
</body>
</html>