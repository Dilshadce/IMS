<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "29, 1387, 1388, 482, 499, 500, 5, 681, 104, 156, 703, 1361, 1362, 702, 1300, 1301, 1987, 1989, 1988">
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

<cfif type eq "customertype">
	<cfset pageTitle = "#words[1987]#">
    <cfset actionForm = "outstandingpayment1.cfm">
<cfelseif type eq "invoicetype">
	<cfset pageTitle = "#words[1988]#">
    <cfset actionForm = "outstandingpayment2.cfm?alown=#alown#">
<cfelseif type eq "suppliertype">
	<cfset pageTitle = "#words[1989]#">
    <cfset actionForm = "outstandingpayment3.cfm">
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
    <cfinclude template="/latest/filter/filterLocation.cfm">
    <cfinclude template="/latest/filter/filterCustomer.cfm">
	<cfinclude template="/latest/filter/filterSupplier.cfm">
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
                <cfif type eq "invoicetype">
                <tr> 
                    <th><label for="agent">#words[29]#</label></th>			
                    <td>
                        <input type="hidden" id="agentFrom" name="agentFrom" class="agentFilter" data-placeholder="#words[1387]#" />
                        <input type="hidden" id="agentTo" name="agentTo" class="agentFilter" placeholder="#words[1388]#" />
                    </td>
                </tr>
                <tr> 
                    <th><label for="location">#words[482]#</label></th>			
                    <td>
                        <input type="hidden" id="locationFrom" name="locationFrom" class="locationFilter" data-placeholder="#words[499]#" />
                        <input type="hidden" id="locationTo" name="locationTo" class="locationFilter" placeholder="#words[500]#" />
                    </td>
                </tr>
                </cfif>
                <cfif type eq "customertype">
                <tr> 
                    <th><label for="customer">#words[5]#</label></th>			
                    <td>
                        <input type="hidden" id="customerFrom" name="customerFrom" class="customerFilter" data-placeholder="#words[681]#" />
                    </td>
                </tr>
                </cfif>
                <cfif type eq "suppliertype">
                <tr> 
                    <th><label for="supplier">#words[104]#</label></th>			
                    <td>
                        <input type="hidden" id="supplierFrom" name="supplierFrom" class="supplierFilter" data-placeholder="#words[156]#" />
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