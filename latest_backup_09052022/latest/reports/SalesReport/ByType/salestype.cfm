<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "29, 1387, 1388, 517, 1483, 1484, 86, 1485, 1486, 122, 1373, 1374, 5, 1352, 1353, 123, 4695, 496, 146, 497, 498, 1302, 1417, 1418, 1358, 1359, 160, 903, 1361, 1362, 702, 1300, 1301, 688, 1406, 1915, 1916, 1917, 1918, 1919, 1920, 1921, 1922, 1923, 1924, 1925, 1926, 1360, 703, 495">
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

<cfif type eq "producttype">
	<cfset trantype = "PRODUCTS">
	<cfset pageTitle = "#words[1915]#">
    <cfset actionForm = "salestype1.cfm?trantype=#trantype#&alown=#alown#">
<cfelseif type eq "customertype">
	<cfset trantype = "CUSTOMERS">
	<cfset pageTitle = "#words[1916]#">
    <cfset actionForm = "salestype2.cfm?trantype=#trantype#&alown=#alown#">
<cfelseif type eq "Agenttype">
	<cfset trantype = "AGENT">	
	<cfset pageTitle = "#words[1917]#">
    <cfset actionForm = "salestype3.cfm?trantype=#trantype#&alown=#alown#">
<cfelseif type eq "grouptype">
	<cfset trantype = "GROUP">
	<cfset pageTitle = "#words[1918]#">
    <cfset actionForm = "salestype4.cfm?trantype=#trantype#&alown=#alown#">		
<cfelseif type eq "endusertype">
	<cfset trantype = "END USER">
	<cfset pageTitle = "#words[1919]#">
    <cfset actionForm = "salestype5.cfm?trantype=#trantype#&alown=#alown#">    
<cfelseif type eq "brandtype">
	<cfset trantype = "BRAND"> 
	<cfset pageTitle = "#words[1920]#">  
    <cfset actionForm = "salestype6.cfm?trantype=#trantype#&alown=#alown#">
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
    <cfinclude template="/latest/date/datePickerFunction.cfm"> 
    <cfinclude template="/CFC/LastDayOfMonth.cfm">

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
                <cfif type neq "endusertype">
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
                    <cfif type eq "grouptype" or type eq "brandtype">
                        <tr> 
                            <th><label for="brand">#words[122]#</label></th>			
                            <td>
                                <input type="hidden" id="brandFrom" name="brandFrom" class="brandFilter" data-placeholder="#words[1373]#"/>
                                <input type="hidden" id="brandTo" name="brandTo" class="brandFilter" placeholder="#words[1374]#" />
                            </td>
                        </tr>
                    </cfif>
                    <cfif type eq "grouptype" or type eq "brandtype" or type eq "producttype">
                        <tr> 
                            <th><label for="category">#words[123]#</label></th>			
                            <td>
                                <input type="hidden" id="categoryFrom" name="categoryFrom" class="categoryFilter" data-placeholder="#words[495]#" />
                                <input type="hidden" id="categoryTo" name="categoryTo" class="categoryFilter" placeholder="#words[496]#" />
                            </td>
                        </tr>
                        <tr> 
                            <th><label for="group">#words[146]#</label></th>			
                            <td>
                                <input type="hidden" id="groupFrom" name="groupFrom" class="groupFilter" data-placeholder="#words[497]#" />
                                <input type="hidden" id="groupTo" name="groupTo" class="groupFilter" placeholder="#words[498]#" />
                            </td>
                        </tr>
                    </cfif>
                    <cfif type eq "producttype">
                        <tr> 
                            <th><label for="product">#words[1302]#</label></th>			
                            <td>
                                <input type="hidden" id="productFrom" name="productFrom" class="productFilter" data-placeholder="#words[1417]#" />
                                <input type="hidden" id="productTo" name="productTo" class="productFilter" placeholder="#words[1418]#" />
                            </td>
                        </tr>
                    </cfif>
                    <cfif type eq "producttype" or type eq "customertype" or type eq "agenttype">
                        <tr> 
                            <th><label for="customer">#words[5]#</label></th>			
                            <td>
                                <input type="hidden" id="customerFrom" name="customerFrom" class="customerFilter" data-placeholder="#words[1352]#" />
                                <input type="hidden" id="customerTo" name="customerTo" class="customerFilter" placeholder="#words[1353]#" />
                            </td>
                        </tr>
                    </cfif>
                </cfif> 
                <tr> 
                    <th><label for="endUser">#words[1358]#</label></th>			
                    <td>
                        <input type="hidden" id="endUserFrom" name="endUserFrom" class="endUserFilter" data-placeholder="#words[1359]#" />
                        <input type="hidden" id="endUserTo" name="endUserTo" class="endUserFilter" placeholder="#words[1360]#" />
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
                <cfif type eq "producttype" or type eq "customertype">
                    <tr>
                        <th><label for="other">#words[688]#</label></th>
                        <td>
                            <div><input type="radio" name="qtysold" id="qtysold" value="yes"> #words[1921]#</div>
                            <div><input type="radio" name="qtysold" id="qtysold" value="no" checked> #words[1922]#</div>
                        </td>
                    </tr>
                    <tr>
                        <th></th>
                        <td>
                            <cfif type eq "producttype">
                                <div><input type="checkbox" name="focqty" id="focqty" value="yes" <cfif lcase(hcomid) eq "almh_i">checked</cfif>> #words[1923]#</div>
                            </cfif>
                            <div><input type="checkbox" name="agentbycust" id="agentbycust" value="yes" <cfif getgsetup.reportagentfromcust eq 'Y'>checked</cfif>>#words[1924]#</div>
                            <div><input type="checkbox" name="include0" id="include0" value="yes">#words[1406]#</div>
                        </td>
                    </tr>
                </cfif>
                <cfif type eq "agenttype" or type eq "grouptype" or type eq "brandtype">
                    <tr>
                        <th><label for="other">#words[688]#</label></th>
                        <td>
                            <cfif type eq "agenttype">
                                <div><input type="checkbox" name="excludetax" id="excludetax" value="yes" <cfif lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i">checked</cfif>/> #words[1925]#</div>
                                <div><input type="checkbox" name="include0" id="1" value="yes"> #words[1926]#</div>
                            </cfif>
                            <div><input type="checkbox" name="agentbycust" value="yes" <cfif getgsetup.reportagentfromcust eq 'Y'>checked</cfif>> #words[1924]#</div>
                        </td>
                    </tr>
                </cfif>
            </table>
		</div>
        <div>
            <input type="Submit" name="result" id="result" value="HTML"  />
            <input type="Submit" name="result" id="result" value="EXCEL"  />
            <cfif type eq "producttype">
                <input type="Submit" name="result" id="result" value="EXCEL BY GROUP"  />
            </cfif>
        </div>
        
    </cfform>
</cfoutput>
</body>
</html>