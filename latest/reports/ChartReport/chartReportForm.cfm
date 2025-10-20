<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "5, 681, 29, 30, 1387, 1388, 1302, 1417, 1418, 452, 122, 1373, 1374, 88, 1419, 1420, 517, 703, 1361, 1362, 702, 1300, 1301, 688, 1579, 1580, 1581, 1582, 1583, 1584, 1585, 1586, 1576, 1577, 1578, 1483, 1484">
<cfinclude template="/latest/words.cfm">

<cfparam name="alown" default="0">
<cfif getpin2.h4700 eq 'T'>
  <cfset alown = 1>
</cfif>

<cfquery name="getgsetup" datasource="#dts#">
	SELECT * 
    FROM gsetup;
</cfquery>
<cfset c_Period = getgsetup.Period> 

<cfif url.target EQ "type1">
	<cfset pageTitle="#words[1579]#">
	<cfset formAction="report1.cfm">
    
<cfelseif url.target EQ "type2">
	<cfset pageTitle="#words[1580]#">
	<cfset formAction="report2.cfm?alown=#alown#">
    
<cfelseif url.target EQ "type3">
	<cfset pageTitle="#words[1581]#">
	<cfset formAction="report3.cfm?alown=#alown#"> 

<cfelseif url.target EQ "type4">
	<cfset pageTitle="#words[1582]#">
	<cfset formAction="report4.cfm?alown=#alown#"> 
                             
<cfelseif url.target EQ "type5">
	<cfset pageTitle="#words[1583]#">
	<cfset formAction="report5.cfm?alown=#alown#"> 
                             
<cfelseif url.target EQ "type6">
	<cfset pageTitle="#words[1584]#">
	<cfset formAction="report6.cfm?alown=#alown#"> 
                             
<cfelseif url.target EQ "type7">
	<cfset pageTitle="#words[1585]#">
	<cfset formAction="report7.cfm?alown=#alown#"> 
                             
<cfelseif url.target EQ "type8">
	<cfset pageTitle="#words[1586]#">
	<cfset formAction="report8.cfm?alown=#alown#"> 
                             
                  
</cfif>

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
    <cfinclude template="/latest/filter/filterAgent.cfm">
    <cfinclude template="/latest/filter/filterBrand.cfm">
	<cfinclude template="/latest/filter/filterProduct.cfm">
    <cfinclude template="/latest/filter/filterBusiness.cfm">
    <cfinclude template="/latest/filter/filterProject.cfm">
    <cfinclude template="/latest/filter/filterDriver.cfm">
    <cfinclude template="/latest/filter/filterTeam.cfm">
    <cfinclude template="/latest/date/datePickerFunction.cfm"> 

</head>

<body class="container">
<cfoutput>
	<cfform class="formContainer form3Button" name="auditTrailForm" id="auditTrailForm" action="#formAction#" method="post" target="_blank">
        <div>#pageTitle#</div>
        <div>
            <table> 
            
                <input type="hidden" NAME="tf_fperiodfromDesp" id="tf_fperiodfromDesp" readonly="readonly" />
                <input type="hidden" NAME="tf_fperiodtoDesp" id="tf_fperiodtoDesp" readonly="readonly" />
                <input type="hidden" name="rptdate" id="rptdate" value="" >
                <input type="hidden" name="tf_fperiod" id="tf_fperiod" value="" >
                
                <cfif url.target EQ "type1">
                    <tr> 
                        <th><label for="customer">#words[5]#</label></th>			
                        <td>
                            <input type="hidden" id="customer" name="customer" class="customerFilter" data-placeholder="#words[681]#" />
                        </td>
                    </tr>
                </cfif>
                <cfif url.target EQ "type2">
                    <tr> 
 						<th><label for="agent">#words[29]#</label></th>			
                    <td>
                        <input type="hidden" id="agentFrom" name="agentFrom" class="agentFilter" data-placeholder="#words[30]#" />
                    </td>
                    </tr>
                </cfif>
                <cfif url.target EQ "type3" OR url.target EQ "type4" OR url.target EQ "type5" OR url.target EQ "type6">
                    <tr> 
                        <th><label for="agent">#words[29]#</label></th>			
                        <td>
                            <input type="hidden" id="agentFrom" name="agentFrom" class="agentFilter" data-placeholder="#words[1387]#" />
                            <input type="hidden" id="agentTo" name="agentTo" class="agentFilter" data-placeholder="#words[1388]#" />
                        </td>
                    </tr>
                </cfif>
                <cfif url.target EQ "type8">
                    <tr> 
                        <th><label for="product">#words[1302]#</label></th>			
                        <td>
                            <input type="hidden" id="productFrom" name="productFrom" class="productFilter" data-placeholder="#words[1417]#" />
                            <input type="hidden" id="productTo" name="productTo" class="productFilter" data-placeholder="#words[1418]#" /> 
                        </td>
                    </tr>
                </cfif>
                <cfif url.target EQ "type2">
                    <tr> 
                        <th><label for="business">#words[452]#</label></th>			
                        <td>
                            <input type="hidden" id="businessFrom" name="businessFrom" class="businessFilter" data-placeholder="#words[1576]#" /> 
                            <input type="hidden" id="businessTo" name="businessTo" class="businessFilter" data-placeholder="#words[1577]#" /> 
                        </td>
                    </tr>
                </cfif>
                <cfif url.target EQ "type3" OR url.target EQ "type4" >
                    <tr> 
                        <th><label for="brand">#words[122]#</label></th>			
                        <td>
                            <input type="hidden" id="brandFrom" name="brandFrom" class="brandFilter" data-placeholder="#words[1373]#" />
                            <input type="hidden" id="brandTo" name="brandTo" class="brandFilter" data-placeholder="#words[1374]#" />
                        </td>
                    </tr>
                    <tr> 
                        <th><label for="driver">#words[88]#</label></th>			
                        <td>
                            <input type="hidden" id="driverFrom" name="driverFrom" class="driverFilter" data-placeholder="#words[1419]#" />
                            <input type="hidden" id="driverTo" name="driverTo" class="driverFilter" data-placeholder="#words[1420]#" />
                        </td>
                    </tr>
                    <tr> 
                        <th><label for="team">#words[517]#</label></th>			
                        <td>
                            <input type="hidden" id="teamFrom" name="teamFrom" class="teamFilter" data-placeholder="#words[1483]#" />
                            <input type="hidden" id="teamTo" name="teamTo" class="teamFilter" data-placeholder="#words[1484]#" />
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
      			<cfif url.target NEQ "type1" AND url.target NEQ "type7">
                    <tr> 
                        <th><label for="date">#words[702]#</label></th>			
                        <td>
                            <input type="Text" name="dateFrom" id="dateFrom" maxlength="10" size="10" placeholder="#words[1300]#" readonly="readonly" />
                            <input type="Text" name="dateTo" id="dateTo" maxlength="10" size="10" placeholder="#words[1301]#" readonly="readonly" />
                        </td>
                    </tr>
                </cfif>
                <cfif url.target EQ "type5">
                    <tr>
                        <th><label>#words[688]#</label></th>
                        <td>
                            <div><input type="checkbox" name="" value=""> #words[1578]#</div>
                        </td>
                    </tr>
                </cfif>
            </table>
        </div>
        <div>
            <input type="submit" name="submit" id="submit" value="SUBMIT">
        </div>
    </cfform>
</cfoutput>
</body>
</html>