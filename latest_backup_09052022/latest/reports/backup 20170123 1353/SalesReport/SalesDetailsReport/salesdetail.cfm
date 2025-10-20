<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1980, 1981, 1982, 1983, 1984, 1985, 1986, 1087, 1376, 1377, 585, 1348, 705, 1823, 1824, 29, 1387, 1388, 122, 1373, 1374, 123, 495, 496, 146, 497, 498, 1302, 1417, 1418, 5, 1352, 1353, 1358, 1359, 1360, 482, 499, 500, 506, 1389, 1390, 475, 1391, 1392, 703, 1361, 1362, 702, 1300, 1301, 688, 1558, 1925, 1924">
<cfinclude template="/latest/words.cfm">
<cfquery name="getgsetup" datasource="#dts#">
	SELECT * 
    FROM gsetup
</cfquery>

<cfquery datasource="#dts#" name="getbill">
	select refno,desp from artran where (type = 'INV' or type = 'CS') and fperiod <> '99' order by refno
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
	<cfset pageTitle = "#words[1980]#">
    <cfset actionForm = "salesdetail1.cfm">
<cfelseif type eq "suppliertype">
	<cfset pageTitle = "#words[1981]#">
    <cfset actionForm = "salesdetail2.cfm">
<cfelseif type eq "agenttype">
	<cfset pageTitle = "#words[1982]#">
    <cfset actionForm = "salesdetail3.cfm">
<cfelseif type eq "refno1type">
	<cfset pageTitle = "#words[1983]#">
    <cfset actionForm = "salesdetail4.cfm">	
<cfelseif type eq "refno2type">
	<cfset pageTitle = "#words[1984]#">
    <cfset actionForm = "salesdetail5.cfm">
<cfelseif type eq "cashsalestype">
	<cfset pageTitle = "#words[1985]#">
    <cfset actionForm = "salesdetail6.cfm?alown=#alown#">
<cfelseif type eq "paydetailtype">
	<cfset pageTitle = "#words[1986]#">
    <cfset actionForm = "salesdetail7.cfm?alown=#alown#">
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

	<cfinclude template="/latest/filter/filterCounter.cfm">
	<cfinclude template="/latest/filter/filterUser.cfm">
	<cfinclude template="/latest/filter/filterAgent.cfm">
    <cfinclude template="/latest/filter/filterBrand.cfm">
	<cfinclude template="/latest/filter/filterCategory.cfm">
    <cfinclude template="/latest/filter/filterGroup.cfm">
	<cfinclude template="/latest/filter/filterProduct.cfm">
    <cfinclude template="/latest/filter/filterCustomer.cfm">
    <cfinclude template="/latest/filter/filterEndUser.cfm">
    <cfinclude template="/latest/filter/filterLocation.cfm">
    <cfinclude template="/latest/filter/filterProject.cfm">
    <cfinclude template="/latest/filter/filterJob.cfm">
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
                <cfif type eq "refno1type" or type eq "refno2type">
                    <tr> 
                        <th><label for="refNo">#words[1087]#</label></th>			
                        <td>
                            <select name="refNoFrom" id="refNoFrom">
                                <option value="">#words[1376]#</option>
                                <cfloop query="getbill">
                                    <option value="#refno#">#refno# - #desp#</option>
                                </cfloop>
                            </select>
                            <select name="refNoTo" id="refNoTo">
                                <option value="">#words[1377]#</option>
                                <cfloop query="getbill">
                                    <option value="#refno#">#refno# - #desp#</option>
                                </cfloop>
                            </select>
                        </td>
                    </tr>
                </cfif>
                <cfif type eq "cashsalestype">
                    <tr> 
                        <th><label for="counter">#words[585]#</label></th>			
                        <td>
                            <input type="hidden" id="counterFrom" name="counterFrom" class="counterFilter" data-placeholder="#words[1348]#" />
                        </td>
                    </tr>
                    <tr> 
                        <th><label for="user">#words[705]#</label></th>			
                        <td>
                            <input type="hidden" id="userFrom" name="userFrom" class="userFilter" data-placeholder="#words[1823]#" />
                            <input type="hidden" id="userTo" name="userTo" class="userFilter" placeholder="#words[1824]#" />
                        </td>
                    </tr>
                </cfif>
                <cfif type eq "agenttype" or type eq "paydetailtype" or type eq "cashsalestype">
                    <tr> 
                        <th><label for="agent">#words[29]#</label></th>			
                        <td>
                            <input type="hidden" id="agentFrom" name="agentFrom" class="agentFilter" data-placeholder="#words[1387]#" />
                            <input type="hidden" id="agentTo" name="agentTo" class="agentFilter" placeholder="#words[1388]#" />
                        </td>
                    </tr>
                </cfif>
                <cfif type eq "agenttype" or type eq "producttype">
                        <tr> 
                            <th><label for="brand">#words[122]#</label></th>			
                            <td>
                                <input type="hidden" id="brandFrom" name="brandFrom" class="brandFilter" data-placeholder="#words[1373]#"/>
                                <input type="hidden" id="brandTo" name="brandTo" class="brandFilter" placeholder="#words[1374]#" />
                            </td>
                        </tr>
                </cfif>
				<cfif type neq "paydetailtype" and type neq "cashsalestype">
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
                    <tr> 
                        <th><label for="product">#words[1302]#</label></th>			
                        <td>
                            <input type="hidden" id="productFrom" name="productFrom" class="productFilter" data-placeholder="#words[1417]#" />
                            <input type="hidden" id="productTo" name="productTo" class="productFilter" placeholder="#words[1418]#" />
                        </td>
                    </tr>
                    <tr> 
                        <th><label for="customer">#words[5]#</label></th>			
                        <td>
                            <input type="hidden" id="customerFrom" name="customerFrom" class="customerFilter" data-placeholder="#words[1352]#" />
                            <input type="hidden" id="customerTo" name="customerTo" class="customerFilter" placeholder="#words[1353]#" />
                        </td>
                    </tr>
                </cfif>
                <cfif type eq "suppliertype" or type eq "producttype">
                    <tr> 
                        <th><label for="endUser">#words[1358]#</label></th>			
                        <td>
                            <input type="hidden" id="endUserFrom" name="endUserFrom" class="endUserFilter" data-placeholder="#words[1359]#" />
                            <input type="hidden" id="endUserTo" name="endUserTo" class="endUserFilter" placeholder="#words[1360]#" />
                        </td>
                    </tr>
                </cfif>
                <cfif type neq "agenttype" and type neq "suppliertype">
                    <tr> 
                        <th><label for="location">#words[482]#</label></th>			
                        <td>
                            <input type="hidden" id="locationFrom" name="locationFrom" class="locationFilter" data-placeholder="#words[499]#" />
                            <input type="hidden" id="locationTo" name="locationTo" class="locationFilter" placeholder="#words[500]#" />
                        </td>
                    </tr>
                </cfif>
                <cfif type eq "agenttype" or type eq "refno1type" or type eq "refno2type">
                    <tr> 
                        <th><label for="project">#words[506]#</label></th>			
                        <td>
                            <input type="hidden" id="projectFrom" name="projectFrom" class="projectFilter" data-placeholder="#words[1389]#" />
                            <input type="hidden" id="projectTo" name="projectTo" class="projectFilter" placeholder="#words[1390]#" />
                        </td>
                    </tr>
                    <tr> 
                        <th><label for="job">#words[475]#</label></th>			
                        <td>
                            <input type="hidden" id="jobFrom" name="jobFrom" class="jobFilter" data-placeholder="#words[1391]#" />
                            <input type="hidden" id="jobTo" name="jobTo" class="jobFilter" placeholder="#words[1392]#" />
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
                <cfif type eq "agenttype">
                    <tr>
                        <th><label for="other">#words[688]#</label></th>
                        <td>
                            <div><input type="checkbox" name="include" id="include" value="yes">#words[1558]#</div>
                            <div><input type="checkbox" name="excludetax" id="excludetax" value="yes" />#words[1925]#</div>
                            <div><input type="checkbox" name="agentbycust" value="yes" <cfif getgsetup.reportagentfromcust eq 'Y'>checked</cfif>>#words[1924]#</div>
                        </td>
                    </tr>
                </cfif>
            </table>
		</div>
        <div>
            <input type="Submit" name="result" id="result" value="HTML"  />
            <cfif type neq "cashsalestype">
            	<input type="Submit" name="result" id="result" value="EXCEL"  />
            </cfif>
        </div>
    </cfform>
</cfoutput>
</body>
</html>