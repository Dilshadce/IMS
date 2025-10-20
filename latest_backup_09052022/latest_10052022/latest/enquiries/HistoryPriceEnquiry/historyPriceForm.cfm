<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1367,1368,1369,1370,1371,1372,5,1352,1353,104,1354,1355,274,275,276,122,1373,1374,123,495,496,482,499,500,1375,1376,1377,703,1361,1362,702,1300,1301,688,1378,1379,1380,1381,501">
<cfinclude template="/latest/words.cfm">
<cfif url.target EQ "type1">
	<cfset pageTitle="#words[1367]#">
	<cfset formAction="historyprice1.cfm">
    
<cfelseif url.target EQ "type2">
	<cfset pageTitle="#words[1368]#">
	<cfset formAction="historyprice2.cfm">
    
<cfelseif url.target EQ "type3">
	<cfset pageTitle="#words[1369]#">
	<cfset formAction="historyprice3.cfm">
    
<cfelseif url.target EQ "type4">
	<cfset pageTitle="#words[1370]#">
	<cfset formAction="historyprice4.cfm">
    
<cfelseif url.target EQ "type5">
	<cfset pageTitle="#words[1371]#">
	<cfset formAction="historyprice5.cfm">
    
<cfelseif url.target EQ "type6">
	<cfset pageTitle="#words[1368]#">
	<cfset formAction="historyprice6.cfm">
    
<cfelseif url.target EQ "type7">
	<cfset pageTitle="#words[1372]#">
	<cfset formAction="historyprice7.cfm">                           
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
    <cfinclude template="/latest/filter/filterSupplier.cfm">
	<cfinclude template="/latest/filter/filterCustomer.cfm">
	<cfinclude template="/latest/filter/filterAgent.cfm">
	<cfinclude template="/latest/filter/filterItem.cfm">
    <cfinclude template="/latest/filter/filterBrand.cfm">
    <cfinclude template="/latest/filter/filterCategory.cfm">
    <cfinclude template="/latest/filter/filterGroup.cfm">
    <cfinclude template="/latest/filter/filterLocation.cfm">
    <cfinclude template="/latest/filter/filterReferenceNo.cfm">
    <cfinclude template="/latest/date/datePickerFunction.cfm"> 
    <cfinclude template="/CFC/LastDayOfMonth.cfm">
</head>

<body class="container">
<cfoutput>
	<cfform class="formContainer form3Button" name="historyPriceEnquiry" id="historyPriceEnquiry" action="#formAction#" method="post" target="_blank">
        <div>#pageTitle#</div>
        <div>
        <table> 
        
        	<input type="hidden" NAME="tf_fperiodfromDesp" id="tf_fperiodfromDesp" readonly="readonly" />
			<input type="hidden" NAME="tf_fperiodtoDesp" id="tf_fperiodtoDesp" readonly="readonly" />
			<input type="hidden" name="rptdate" id="rptdate" value="" >
			<input type="hidden" name="tf_fperiod" id="tf_fperiod" value="" >
            
            <cfif url.target EQ "type1" OR url.target EQ "type2" OR url.target EQ "type3" >
        	<tr> 
                <th><label for="customer">#words[5]#</label></th>			
                <td>
                    <input type="hidden" id="customerFrom" name="customerFrom" class="customerFilter" data-placeholder="#words[1352]#" />
                    <input type="hidden" id="customerTo" name="customerTo" class="customerFilter" data-placeholder="#words[1353]#" />
                </td>
            </tr>
            </cfif>
            
            <cfif url.target EQ "type4" OR url.target EQ "type5" OR url.target EQ "type6" OR url.target EQ "type7">
                <tr> 
                    <th><label for="supplier">#words[104]#</label></th>			
                    <td>
                        <input type="hidden" id="supplierFrom" name="supplierFrom" class="supplierFilter" data-placeholder="#words[1354]#" />
                        <input type="hidden" id="supplierTo" name="supplierTo" class="supplierFilter" data-placeholder="#words[1355]#" />
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
            
			<cfif url.target EQ "type3" OR url.target EQ "type4" OR url.target EQ "type5">
                <tr> 
                    <th><label for="brand">#words[122]#</label></th>			
                    <td>
                        <input type="hidden" id="brandFrom" name="brandFrom" class="brandFilter" data-placeholder="#words[1373]#" />
                        <input type="hidden" id="brandTo" name="brandTo" class="brandFilter" data-placeholder="#words[1374]#" />
                    </td>
                </tr>
                <tr> 
                    <th><label for="category">#words[123]#</label></th>			
                    <td>
                        <input type="hidden" id="categoryFrom" name="categoryFrom" class="categoryFilter" data-placeholder="#words[495]#" />
                        <input type="hidden" id="categoryTo" name="categoryTo" class="categoryFilter" data-placeholder="#words[496]#" />
                    </td>
                </tr>
            </cfif>
            <tr> 
                <th><label for="location">#words[482]#</label></th>			
                <td>
                    <input type="hidden" id="locationFrom" name="locationFrom" class="locationFilter" data-placeholder="#words[499]#" />
                    <input type="hidden" id="locationTo" name="locationTo" class="locationFilter" data-placeholder="#words[500]#" />
                </td>
            </tr>
            
            <cfif url.target EQ "type7">
                <tr> 
                    <th><label for="refNo">#words[1375]#</label></th>			
                    <td>
                        <input type="hidden" id="refNoFrom" name="refNoFrom" class="referenceNoFilter" data-placeholder="#words[1376]#" />
                        <input type="hidden" id="refNoTo" name="refNoTo" class="referenceNoFilter" data-placeholder="#words[1377]#" />
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
				<th><label>#words[688]#</label></th>
                <td>
                    <div><input type="radio" name="sort" id="1" value="itemno" checked>#words[1378]#</div>
					<div><input type="radio" name="sort" id="1" value="desp">#words[1380]#</div>
                </td>
			</tr>
            <tr>
            	<th></th>
                <td>
					<cfif url.target EQ "type3">
                    	<div><input type="checkbox" name="service" id="service" value="1">#words[1379]#<br/></div>
                    </cfif>
                    <div><input type="checkbox" name="includelastyear" id="1" value="yes">#words[1381]#</div> 
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