<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "29, 1387, 1388, 1302, 1417, 1418, 482, 499, 500, 705, 1359, 1360, 585, 1348, 703, 1361, 1362, 702, 1300, 1301, 688, 1508, 1509, 1510, 1511, 1512, 1513, 1514, 1515, 1516, 1517, 1518, 1506, 1507">
<cfinclude template="/latest/words.cfm">

<cfquery name="getgsetup" datasource="#dts#">
	SELECT * 
    FROM gsetup
</cfquery>
<cfset c_Period = getgsetup.Period>

<cfparam name="alown" default="0">

<cfif getpin2.h4700 eq 'T'>
	<cfset alown = 1>
</cfif>

<cfif url.target EQ "type1">
	<cfset pageTitle = "#words[1508]#">
	<cfset formAction = "report1.cfm?alown=#alown#">
    
<cfelseif url.target EQ "type2">
	<cfset pageTitle = "#words[1509]#">
	<cfset formAction = "report2.cfm?alown=#alown#">
    
<cfelseif url.target EQ "type3">
	<cfset pageTitle = "#words[1510]#">
	<cfset formAction = "report3.cfm?alown=#alown#">  

<cfelseif url.target EQ "type4">
	<cfset pageTitle = "#words[1511]#">
	<cfset formAction = "report4.cfm?alown=#alown#"> 
       
<cfelseif url.target EQ "type5">
	<cfset pageTitle = "#words[1512]#">
	<cfset formAction = "report5.cfm?alown=#alown#">      

<cfelseif url.target EQ "type6">
	<cfset pageTitle = "#words[1513]#">
    <cfset formAction = "report6.cfm?alown=#alown#">
 
<cfelseif url.target EQ "type7">
	<cfset pageTitle = "#words[1514]#">
    <cfset formAction = "report7.cfm?alown=#alown#">
    
<cfelseif url.target EQ "type8">
	<cfset pageTitle = "#words[1515]#">
    <cfset formAction = "report8.cfm?alown=#alown#">
    
<cfelseif url.target EQ "type9">
	<cfset pageTitle = "#words[1516]#">
    <cfset formAction = "report9.cfm?alown=#alown#">
    
<cfelseif url.target EQ "type10">
	<cfset pageTitle = "#words[1517]#">
    <cfset formAction = "report10.cfm?alown=#alown#">
    	
<cfelseif url.target EQ "type11">
	<cfset pageTitle = "#words[1518]#">
    <cfset formAction = "report11.cfm">
                 
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

    <cfinclude template="/latest/filter/filterAgent.cfm">
	<cfinclude template="/latest/filter/filterProduct.cfm">
    <cfinclude template="/latest/filter/filterLocation.cfm">
    <cfinclude template="/latest/filter/filterUser.cfm">
    <cfinclude template="/latest/filter/filterCounter.cfm">
	<cfinclude template="/latest/filter/filtercashier.cfm">
    <cfinclude template="/latest/date/datePickerFunction.cfm"> 
    <cfinclude template="/CFC/LastDayOfMonth.cfm">

</head>

<body class="container">
<cfoutput>
	<cfform class="formContainer form2Button" name="cashSalesForm" id="cashSalesForm" action="#formAction#" method="post" target="_blank">
        <div>#pageTitle#</div>
        <div>
        <table> 
        
        	<input type="hidden" NAME="tf_fperiodfromDesp" id="tf_fperiodfromDesp" readonly="readonly" />
			<input type="hidden" NAME="tf_fperiodtoDesp" id="tf_fperiodtoDesp" readonly="readonly" />
			<input type="hidden" name="rptdate" id="rptdate" value="" >
			<input type="hidden" name="tf_fperiod" id="tf_fperiod" value="" >
  
            <tr> 
                <th><label for="agent">#words[29]#</label></th>			
                <td>
                    <input type="hidden" id="agentFrom" name="agentFrom" class="agentFilter" data-placeholder="#words[1387]#" />
                    <input type="hidden" id="agentTo" name="agentTo" class="agentFilter" data-placeholder="#words[1388]#" />
                </td>
            </tr>
            <tr> 
                <th><label for="product">#words[1302]#</label></th>			
                <td>
                    <input type="hidden" id="productFrom" name="productFrom" class="productFilter" data-placeholder="#words[1417]#" />
                    <input type="hidden" id="productTo" name="productTo" class="productFilter" data-placeholder="#words[1418]#" />
                </td>
            </tr>
            <tr> 
                <th><label for="location">#words[482]#</label></th>			
                <td>
                    <input type="hidden" id="locationFrom" name="locationFrom" class="locationFilter" data-placeholder="#words[499]#" />
                    <input type="hidden" id="locationTo" name="locationTo" class="locationFilter" data-placeholder="#words[500]#" />
                </td>
            </tr>
            <tr> 
                <th><label for="user">#words[705]#</label></th>			
                <td>
                    <input type="hidden" id="userFrom" name="userFrom" class="userFilter" data-placeholder="#words[1359]#" />
                    <input type="hidden" id="userTo" name="userTo" class="userFilter" data-placeholder="#words[1360]#" />
                </td>
            </tr>
            <cfif url.target EQ 'type6' OR url.target EQ 'type7'>
                <tr>
                    <th><label for="counter">#words[585]#</label></th>			
                    <td>
                        <input type="hidden" id="counter" name="counter" class="counterFilter" data-placeholder="#words[1348]#" />
                    </td>
                </tr>
            </cfif>    
            <cfif url.target EQ 'type6' >
                <tr>
                    <th><label for="cashier">Cashier</label></th>			
                    <td>
                        <input type="hidden" id="cashier" name="cashier" class="cashierFilter" data-placeholder="Choose a Cashier" />
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
					<input type="Text" name="dateFrom" id="dateFrom" maxlength="10" size="10" placeholder="#words[1300]#" readonly="readonly" value="#dateformat(now(),'dd/mm/yyyy')#" />
					<input type="Text" name="dateTo" id="dateTo" maxlength="10" size="10" placeholder="#words[1301]#" readonly="readonly" value="#dateformat(now(),'dd/mm/yyyy')#"  />
                </td>
			</tr>
            <cfif url.target EQ 'type1' OR url.target EQ 'type9'>
                <tr>
                    <th><label>#words[688]#</label></th>
                    <td>
                        <cfif url.target EQ 'type1'>
                            <div><input type="checkbox" name="" value=""> #words[1506]#</div>
                        </cfif>
                        <cfif url.target EQ 'type9'>
                            <div><input type="checkbox" name="" value=""> #words[1507]#</div>
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