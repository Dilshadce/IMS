<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "5, 1352, 1353, 123, 495, 496, 29, 1387, 1388, 517, 1483, 1484, 86, 1485, 1486, 703, 1361, 1362, 688, 2018, 2019, 1975, 1976">
<cfinclude template="/latest/words.cfm">

<cfquery name="getgsetup" datasource="#dts#">
	SELECT * from gsetup
</cfquery>
<cfset c_Period = getgsetup.Period> 

<cfparam name="alown" default="0">

<cfif getpin2.h4700 eq 'T'>
	<cfset alown = 1>
</cfif>

<cfif type eq "top">
	<cfset trantype="Top Category Product Sales">
	<cfset pageTitle="#words[2018]#">
<cfelseif type eq "bottom">
	<cfset trantype="Bottom Category Product Sales">
	<cfset pageTitle="#words[2019]#">
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

	<cfinclude template="/latest/filter/filterCustomer.cfm">
    <cfinclude template="/latest/filter/filterCategory.cfm">
    <cfinclude template="/latest/filter/filterAgent.cfm">
    <cfinclude template="/latest/filter/filterTeam.cfm">
    <cfinclude template="/latest/filter/filterArea.cfm">
    <cfinclude template="/CFC/LastDayOfMonth.cfm">

</head>

<body class="container">
<cfoutput>
	<cfform class="formContainer form3Button" name="topBottomCategoryForm" id="topBottomCategoryForm" action="topbottomcategory.cfm?trantype=#type#&alown=#alown#" method="post" target="_blank">
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
                        <th><label for="category">#words[123]#</label></th>			
                        <td>
                            <input type="hidden" id="categoryFrom" name="categoryFrom" class="categoryFilter" data-placeholder="#words[495]#" />
                            <input type="hidden" id="categoryTo" name="categoryTo" class="categoryFilter" data-placeholder="#words[496]#" />
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
                    <th><label for="team">#words[517]#</label></th>			
                    <td>
                        <input type="hidden" id="teamFrom" name="teamFrom" class="teamFilter" data-placeholder="#words[1483]#" />
                        <input type="hidden" id="teamTo" name="teamTo" class="teamFilter" data-placeholder="#words[1484]#" /> 
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
                    <th><label>#words[688]#</label></th>
                    <td>
                        <div><input type="radio" name="showby" id="showby" value="qty" checked="checked"> #words[1975]#</div>
                        <div><input type="radio" name="showby" id="showby" value="amt"> #words[1976]#</div>
                    </td>
                </tr>
            </table>
        </div>
        <div>
            <input type="Submit" name="submit" id="submit" value="Submit">
            <input type="button" name="Back" value="Back" onclick="history.go(-1);">
        </div>
    </cfform>
</cfoutput>
</body>
</html>