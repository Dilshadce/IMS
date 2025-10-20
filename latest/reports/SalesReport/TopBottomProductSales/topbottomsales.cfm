<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "29, 1387, 1388, 517, 1483, 1484, 86, 1485, 1486, 122, 1373, 1374, 5, 1352, 1353, 148, 703, 1361, 1362, 688, 1971, 1972, 1975, 1976, 154, 702, 1300, 1301">
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


<cfif type eq "top">
	<cfset trantype = "TOP">
	<cfset pageTitle = "#words[1971]#">
<cfelseif type eq "bottom">
	<cfset trantype = "BOTTOM">	
	<cfset pageTitle = "#words[1972]#">
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
    <cfinclude template="/latest/filter/filterSize.cfm">
    <cfinclude template="/latest/filter/filterMaterial.cfm">
    <cfinclude template="/latest/date/datePickerFunction.cfm"> 
    <cfinclude template="/CFC/LastDayOfMonth.cfm">

</head>

<body class="container">
<cfoutput>
	<cfform class="formContainer form3Button" name="salesTypeForm" id="salesTypeForm" action="topbottom.cfm?trantype=#trantype#" method="post" target="_blank">
		<div>#pageTitle#</div>
        <div>
            <table>
                <input type="hidden" name="thislastaccdate" value="#thislastaccdate#">
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
                <tr> 
                    <th><label for="brand">#words[122]#</label></th>			
                    <td>
                        <input type="hidden" id="brandFrom" name="brandFrom" class="brandFilter" data-placeholder="#words[1373]#"/>
                        <input type="hidden" id="brandTo" name="brandTo" class="brandFilter" placeholder="#words[1374]#" />
                    </td>
                </tr>
                <tr> 
                    <th><label for="customer">#words[5]#</label></th>			
                    <td>
                        <input type="hidden" id="customerFrom" name="customerFrom" class="customerFilter" data-placeholder="#words[1352]#" />
                        <input type="hidden" id="customerTo" name="customerTo" class="customerFilter" placeholder="#words[1353]#" />
                    </td>
                </tr>
                <tr> 
                    <th><label for="size">#words[154]#</label></th>			
                    <td>
                        <input type="hidden" id="sizeFrom" name="sizeFrom" class="sizeFilter" data-placeholder="[FROM] -- Choose a Size" />
                        <input type="hidden" id="sizeTo" name="sizeTo" class="sizeFilter" placeholder="[TO] -- Choose a Size" />
                    </td>
                </tr>
                <tr> 
                    <th><label for="material">#words[148]#</label></th>			
                    <td>
                        <input type="hidden" id="materialFrom" name="materialFrom" class="materialFilter" data-placeholder="#words[1373]#" />
                        <input type="hidden" id="materialTo" name="materialTo" class="materialFilter" placeholder="#words[1374]#" />
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
                <tr>
                    <th><label for="other">#words[688]#</label></th>
                    <td>
                        <div><input type="radio" name="showby" id="showby" value="qty" checked="checked"> #words[1975]#</div>
                        <div><input type="radio" name="showby" id="showby" value="amt"> #words[1976]#</div>
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