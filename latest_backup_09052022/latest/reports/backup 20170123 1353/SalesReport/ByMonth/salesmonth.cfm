<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "29, 1387, 1388, 517, 1483, 1484, 86, 1485, 1486, 122, 1373, 1374, 123, 495, 496, 146, 497, 498, 1302, 1417, 1418, 5, 1352, 1353, 1358, 1359, 1360, 703, 1361, 1362, 688, 1558, 1406, 1927, 1928, 1929, 1930, 1931, 1932, 1933, 1934, 1935, 1406, 1924, 1936">
<cfinclude template="/latest/words.cfm">
<cfquery name="getgsetup" datasource="#dts#">
	SELECT * 
    FROM gsetup
</cfquery>
<cfset c_Period = getgsetup.Period>

<cfif isdefined("form.lastaccdaterange") and form.lastaccdaterange neq "">
	<cfquery name="getdate" datasource="#dts#">
		SELECT LastAccDate,ThisAccDate 
        FROM icitem_last_year
		WHERE LastAccDate = #form.lastaccdaterange#
		LIMIT 1
	</cfquery>
	<cfset clsyear = year(form.lastaccdaterange)>
	<cfset clsmonth = month(form.lastaccdaterange)>
	<cfset thislastaccdate = form.lastaccdaterange>
	<cfset diffmth= DateDiff("m",getdate.LastAccDate,getdate.ThisAccDate)>
<cfelse>
	<cfset clsyear = year(getgsetup.lastaccyear)>
	<cfset clsmonth = month(getgsetup.lastaccyear)>
	<cfset thislastaccdate = "">
</cfif>

<cfparam name="alown" default="0">

<cfif getpin2.h4700 eq 'T'>
	<cfset alown = 1>
</cfif>

<cfif type eq "activecustomer">
	<cfset pageTitle = "#words[1927]#">
    <cfset actionForm = "salesmonth1.cfm?alown=#alown#">
<cfelseif type eq "productmonth">
	<cfset trantype = "PRODUCTS">
	<cfset pageTitle = "#words[1928]#">
    <cfset actionForm = "salesmonth2.cfm?trantype=#trantype#&alown=#alown#">
<cfelseif type eq "customermonth">
	<cfset trantype = "CUSTOMERS">
	<cfset pageTitle = "#words[1929]#">
    <cfset actionForm = "salesmonth3.cfm?trantype=#trantype#&alown=#alown#">
<cfelseif type eq "Agentmonth">
	<cfset trantype = "AGENT">	
	<cfset pageTitle = "#words[1930]#">
    <cfset actionForm = "salesmonth4.cfm?trantype=#trantype#&alown=#alown#">
<cfelseif type eq "groupmonth">
	<cfset trantype = "GROUP">
	<cfset pageTitle = "#words[1931]#">
    <cfset actionForm = "salesmonth5.cfm?trantype=#trantype#&alown=#alown#">		
<cfelseif type eq "endusermonth">
	<cfset trantype = "END USER">
	<cfset pageTitle = "#words[1932]#">
    <cfset actionForm = "salesmonth6.cfm?trantype=#trantype#">    
<cfelseif type eq "brandmonth">
	<cfset trantype = "BRAND"> 
	<cfset pageTitle = "#words[1933]#">  
    <cfset actionForm = "salesmonth7.cfm?trantype=#trantype#&alown=#alown#">
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

	<cfinclude template="/latest/filter/filterAgent.cfm">
    <cfinclude template="/latest/filter/filterTeam.cfm">
	<cfinclude template="/latest/filter/filterArea.cfm">
    <cfinclude template="/latest/filter/filterBrand.cfm">
    <cfinclude template="/latest/filter/filterCustomer.cfm">
	<cfinclude template="/latest/filter/filterCategory.cfm">
    <cfinclude template="/latest/filter/filterGroup.cfm">
	<cfinclude template="/latest/filter/filterProduct.cfm">
    <cfinclude template="/latest/filter/filterEndUser.cfm">

</head>

<body class="container">
<cfoutput>
	<cfform class="formContainer form3Button" name="salesTypeForm" id="salesTypeForm" action="#actionForm#" method="post" target="_blank">
		<div>#pageTitle#</div>
        <div>
            <table>
                <input type="hidden" NAME="tf_fperiodfromDesp" id="tf_fperiodfromDesp" readonly="readonly" />
                <input type="hidden" NAME="tf_fperiodtoDesp" id="tf_fperiodtoDesp" readonly="readonly" />
                <input type="hidden" name="rptdate" id="rptdate" value="" />
                <input type="hidden" name="tf_fperiod" id="tf_fperiod" value="" />
                <input type="hidden" name="thislastaccdate" value="#thislastaccdate#">
                <cfif type neq "endusermonth">
                    <tr> 
                        <th><label for="agent">#words[29]#</label></th>			
                        <td>
                            <input type="hidden" id="agentFrom" name="agentFrom" class="agentFilter" data-placeholder="#words[1387]#" />
                            <input type="hidden" id="agentTo" name="agentTo" class="agentFilter" placeholder="#words[1388]#" />
                        </td>
                    </tr>   
                    <tr> 
                        <th><label for="team">#words[517]#</label></th>			
                        <td>
                            <input type="hidden" id="teamFrom" name="teamFrom" class="teamFilter" data-placeholder="#words[1483]#" />
                            <input type="hidden" id="teamTo" name="teamTo" class="teamFilter" placeholder="#words[1484]#" />
                        </td>
                    </tr>
                    <tr> 
                        <th><label for="area">#words[86]#</label></th>			
                        <td>
                            <input type="hidden" id="areaFrom" name="areaFrom" class="areaFilter" data-placeholder="#words[1485]#"/>
                            <input type="hidden" id="areaTo" name="areaTo" class="areaFilter" placeholder="#words[1486]#" />
                        </td>
                    </tr>
                    <cfif type eq "brandmonth" or  type eq "groupmonth">                   
                        <tr> 
                            <th><label for="brand">#words[122]#</label></th>			
                            <td>
                                <input type="hidden" id="brandFrom" name="brandFrom" class="brandFilter" data-placeholder="#words[1373]#"/>
                                <input type="hidden" id="brandTo" name="brandTo" class="brandFilter" placeholder="#words[1374]#" />
                            </td>
                        </tr>
                    </cfif>
                    <cfif type neq "Agentmonth" and type neq "activecustomer">
                        <tr> 
                            <th><label for="category">#words[123]#</label></th>			
                            <td>
                                <input type="hidden" id="categoryFrom" name="categoryFrom" class="categoryFilter" data-placeholder="#words[495]#" />
                                <input type="hidden" id="categoryTo" name="categoryTo" class="categoryFilter" placeholder="#words[496]#" />
                            </td>
                        </tr>
                    </cfif>
                    <cfif type eq "productmonth" or  type eq "groupmonth" or  type eq "brandmonth">
                        <tr> 
                            <th><label for="group">#words[146]#</label></th>			
                            <td>
                                <input type="hidden" id="groupFrom" name="groupFrom" class="groupFilter" data-placeholder="#words[497]#" />
                                <input type="hidden" id="groupTo" name="groupTo" class="groupFilter" placeholder="#words[498]#" />
                            </td>
                        </tr>
                        <tr> 
                            <th><label for="product">#words[1302]#</label></th>			
                            <td>
                                <input type="hidden" id="productFrom" name="productFrom" class="productFilter" data-placeholder="#words[1417]#" />
                                <input type="hidden" id="productTo" name="productTo" class="productFilter" placeholder="#words[1418]#" />
                            </td>
                        </tr>
                    </cfif>
                    <cfif type eq "customermonth">
                        <tr> 
                            <th><label for="customer">#words[5]#</label></th>			
                            <td>
                                <input type="hidden" id="customerFrom" name="customerFrom" class="customerFilter" data-placeholder="#words[1352]#" />
                                <input type="hidden" id="customerTo" name="customerTo" class="customerFilter" placeholder="#words[1353]#" />
                            </td>
                        </tr>
                    </cfif>
                </cfif>
                <cfif type neq "activecustomer">
                    <tr> 
                        <th><label for="endUser">#words[1358]#</label></th>			
                        <td>
                            <input type="hidden" id="endUserFrom" name="endUserFrom" class="endUserFilter" data-placeholder="#words[1359]#" />
                            <input type="hidden" id="endUserTo" name="endUserTo" class="endUserFilter" placeholder="#words[1360]#" />
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
                <cfif type neq "endusermonth" and type neq "activecustomer">
                    <cfif type eq "productmonth" or  type eq "groupmonth" or  type eq "brandmonth">
                        <tr>
                            <th><label for="other">#words[688]#</label></th>
                            <td>
                                <div><input type="radio" name="label" id="label" value="salesvalue" checked> #words[1934]#</div> 
                                <div><input type="radio" name="label" id="label" value="salesqty"> #words[1935]#</div>
                            </td>
                        </tr>
                    </cfif>
                    <tr>
                        <th><cfif type eq "Agentmonth" or type eq "customermonth"><label for="other">#words[688]#</label></cfif></th>
                        <td>
                            <div><input type="checkbox" name="include" id="include" value="yes"> #words[1558]#</div>
                            <div><input type="checkbox" name="include0" id="include0" value="yes"> #words[1406]#</div>
                        </td>
                    </tr>
                    <tr>
                        <th></th>
                        <td>
                            <div><input type="checkbox" name="agentbycust" id="agentbycust" value="yes" <cfif getgsetup.reportagentfromcust eq 'Y'>checked</cfif>>#words[1924]#</div>
                            <cfif type eq "Agentmonth" or type eq "customermonth">
                                <div><input type="checkbox" name="bodyfig" id="bodyfig" value="yes" <cfif lcase(hcomid) eq 'hyray_i' or lcase(hcomid) eq 'freshways_i'>checked</cfif>> #words[1936]#</div>
                            </cfif>
                        </td>
                    </tr>
                </cfif>
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