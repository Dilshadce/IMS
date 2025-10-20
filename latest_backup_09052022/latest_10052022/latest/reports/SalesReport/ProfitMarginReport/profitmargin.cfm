<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "29, 1387, 1388, 517, 1483, 1484, 86, 1485, 1486, 5, 1352, 1353, 123, 495, 496, 146, 497, 498, 1302, 1417, 1418, 506, 1389, 1390, 703, 1361, 1362, 702, 1300, 1301, 688, 1954, 1955, 1956, 1957, 1958, 1959, 1960, 1961, 1962, 1963, 1924, 1965, 1966, 1964, 499, 500">
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

<cfif type eq "productmargin">
	<cfset trantype = "PROFIT MARGIN BY PRODUCT">
	<cfset pageTitle = "#words[1954]#">
    <cfset actionForm = "profitmargin1.cfm?trantype=#trantype#">
<cfelseif type eq "billmargin">
	<cfset trantype = "PROFIT MARGIN BY BILL">
	<cfset pageTitle = "#words[1955]#">
    <cfset actionForm = "profitmargin2.cfm?trantype=#trantype#">
<cfelseif type eq "agentmargin">
	<cfset trantype = "PROFIT MARGIN BY AGENT">
	<cfset pageTitle = "#words[1956]#">
    <cfset actionForm = "profitmargin3.cfm?trantype=#trantype#">
<cfelseif type eq "projectmargin">
	<cfset trantype = "PROFIT MARGIN BY PROJECT">
	<cfset pageTitle = "#words[1957]#">
    <cfset actionForm = "profitmargin4.cfm?trantype=#trantype#">
<cfelseif type eq "billitemmargin">
	<cfset trantype = "PROFIT MARGIN BY BILL ITEM">
	<cfset pageTitle = "#words[1958]#">
    <cfset actionForm = "profitmargin5.cfm?trantype=#trantype#">
<cfelseif type eq "customermargin">
	<cfset trantype = "PROFIT MARGIN BY CUSTOMER">
	<cfset pageTitle = "#words[1959]#">  
    <cfset actionForm = "profitmargin6.cfm?trantype=#trantype#">
<cfelseif type eq "groupmargin">
	<cfset trantype = "PROFIT MARGIN BY GROUP">
	<cfset pageTitle = "#words[1960]#">  
    <cfset actionForm = "profitmargin7.cfm?trantype=#trantype#">
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
    <cfinclude template="/latest/filter/filterLocation.cfm">
    <cfinclude template="/latest/filter/filterGroup.cfm">
	<cfinclude template="/latest/filter/filterProduct.cfm">
    <cfinclude template="/latest/filter/filterProject.cfm">
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
                <cfif type neq "productmargin" and type neq "projectmargin" and type neq "groupmargin">
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
                </cfif>
                <cfif type neq "projectmargin" and type neq "groupmargin">
                    <tr> 
                        <th><label for="customer">#words[5]#</label></th>			
                        <td>
                            <input type="hidden" id="customerFrom" name="customerFrom" class="customerFilter" data-placeholder="#words[1352]#" />
                            <input type="hidden" id="customerTo" name="customerTo" class="customerFilter" placeholder="#words[1353]#" />
                        </td>
                    </tr>
                </cfif>                
                <cfif type eq "productmargin" or type eq "projectmargin" or type eq "groupmargin">
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
                <cfif type eq "productmargin" or type eq "projectmargin">
                    <tr> 
                        <th><label for="product">#words[1302]#</label></th>			
                        <td>
                            <input type="hidden" id="productFrom" name="productFrom" class="productFilter" data-placeholder="#words[1417]#" />
                            <input type="hidden" id="productTo" name="productTo" class="productFilter" placeholder="#words[1418]#" />
                        </td>
                    </tr>
                </cfif>
                <cfif type eq "billmargin" or type eq "billitemmargin" or type eq "projectmargin">
                    <tr> 
                        <th><label for="project">#words[506]#</label></th>			
                        <td>
                            <input type="hidden" id="projectFrom" name="projectFrom" class="projectFilter" data-placeholder="#words[1389]#" />
                            <input type="hidden" id="projectTo" name="projectTo" class="projectFilter" placeholder="#words[1390]#" />
                        </td>
                    </tr>
                </cfif>   
                
                 <cfif type eq "billmargin" or type eq "billitemmargin" or type eq "productmargin" or type eq "agentmargin" or type eq "customermargin">
                    <tr> 
                        <th><label for="location">Location</label></th>			
                        <td>
                            <cfif Huserloc neq "All_loc">
                            <input type="text" id="locationFrom" readonly name="locationFrom" value="#Huserloc#" data-placeholder="#words[499]#" />
                            <input type="text" id="locationTo" readonly name="locationTo" value="#Huserloc#" data-placeholder="#words[500]#" />
                            <cfelse>
                            <input type="hidden" id="locationFrom" name="locationFrom" class="locationFilter" data-placeholder="#words[499]#" />
                            <input type="hidden" id="locationTo" name="locationTo" class="locationFilter" data-placeholder="#words[500]#" />
                            </cfif>
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
                <cfif type neq "projectmargin" and type neq "groupmargin">
                	<cfif type neq "productmargin">
                        <tr>
                            <th><label for="other">#words[688]#</label></th>
                            <td>
                                <div><input type="radio" name="radio1" id="radio1" value="all" checked>#words[1961]#</div>
                                <div><input type="radio" name="radio1" id="radio1" value="item" />#words[1962]#</div>
                                <div><input type="radio" name="radio1" id="radio1" value="serv" />#words[1963]#</div>
                            </td>
                        </tr>
                    </cfif>
                    <tr>
                        <th><cfif type eq "productmargin"><label for="other">#words[688]#</label></cfif></th>
                        <td>
                        	<cfif type eq "productmargin">
                                <div><input type="checkbox" name="include0" id="include0" value="yes">#words[1964]#</div>
                            </cfif>
                        	<cfif type neq "productmargin">
                                <div><input type="checkbox" name="agentbycust" id="agentbycust" value="yes" <cfif getgsetup.reportagentfromcust eq 'Y'>checked</cfif>>#words[1924]#</div>
                            </cfif>
							<cfif type eq "billmargin" or type eq "billitemmargin">
                                <div><input type="checkbox" name="sort" id="sort" value="yes">  #words[1965]#</div>
                                <div><input type="checkbox" name="cbdiscount" id="cbdiscount" value="yes">#words[1966]#</div>
                            </cfif>
                        </td>
                    </tr>
                </cfif>
            </table>
		</div>
        <div>
            <input type="Submit" name="result" id="result" value="HTML"  />
            <input type="Submit" name="result" id="result" value="EXCEL"  />
            <cfif type eq "productmargin">
                <input type="Submit" name="result" id="result" value="EXCEL BY GROUP"  />
            </cfif>
            <cfif type eq "billmargin">
                <br /><br />
                <input type="Submit" name="result" id="result" value="EXCEL AFTER PROVOSION DISCOUNT" style="width:auto"  />
            </cfif>
			<cfif type eq "productmargin" or type eq "billmargin" or type eq "customermargin">
				<cfif type neq "customermargin" and type neq "billmargin">
                    <br /><br />
                </cfif>
                <input type="Submit" name="result" id="result" value="EXCEL WITH ADDITIONAL COST" style="width:auto" />
                <cfif type eq "productmargin">
                    <input type="Submit" name="result" id="result" value="EXCEL WITHOUT SALES DISCOUNT" style="width:auto" />
                </cfif>
            </cfif>
        </div>
    </cfform>
</cfoutput>
</body>
</html>