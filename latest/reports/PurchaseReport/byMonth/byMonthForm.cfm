<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1527, 1528, 104, 1354, 1355, 1302, 1417, 1418, 703, 1361, 1362, 688, 1934, 1935">
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

<cfif type eq "productmonth">
    <cfset pageAction = "productPurchaseReport.cfm?trantype=PRODUCTS PURCHASE">
    <cfset pageTitle = "#words[1527]#">
<cfelseif type eq "vendormonth">
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
	<cfinclude template="/latest/filter/filterProduct.cfm">
    <cfinclude template="/latest/filter/filterGroup.cfm">
    <cfinclude template="/latest/filter/filterCategory.cfm">
    <cfinclude template="/latest/date/datePickerFunction.cfm">
</head>

<body class="container">
<cfoutput>
	<cfform class="formContainer form2Button" name="byMonthForm" id="byMonthForm" action="#pageAction#" method="post" target="_blank">
        <div>#pageTitle#</div>
        <div>
        <table> 
        
        	<input type="hidden" NAME="tf_fperiodfromDesp" id="tf_fperiodfromDesp" readonly="readonly" />
			<input type="hidden" NAME="tf_fperiodtoDesp" id="tf_fperiodtoDesp" readonly="readonly" />
			<input type="hidden" name="rptdate" id="rptdate" value="">
			<input type="hidden" name="tf_fperiod" id="tf_fperiod" value="">
            <cfif type eq "vendormonth">
                <tr> 
                    <th><label for="supplier">#words[104]#</label></th>			
                    <td>
                        <input type="hidden" id="supplierFrom" name="supplierFrom" class="supplierFilter" data-placeholder="#words[1354]#" />
                        <input type="hidden" id="supplierTo" name="supplierTo" class="supplierFilter" data-placeholder="#words[1355]#" />
                    </td>
                </tr>
            </cfif>
            <cfif type eq "productmonth">
                <tr> 
                    <th><label for="product">#words[1302]#</label></th>			
                    <td>
                        <input type="hidden" id="productFrom" name="productFrom" class="productFilter" data-placeholder="#words[1417]#" />
                        <input type="hidden" id="productTo" name="productTo" class="productFilter" data-placeholder="#words[1418]#" />
                    </td>
                </tr>
            </cfif>
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
                <th><label for="other">#words[688]#</label></th>
                <td>
                    <div><input type="radio" name="label" id="label" value="salesvalue" checked>#words[1934]#</div>
					<div><input type="radio" name="label" id="label" value="salesqty">#words[1935]#</div>
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