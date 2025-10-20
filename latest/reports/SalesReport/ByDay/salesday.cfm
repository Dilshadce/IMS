<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "29, 1387, 1388, 1358, 1359, 1360, 703, 1183, 688, 1558, 1946, 1947">
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

<cfif type eq "agentday">
	<cfset trantype = "AGENT">	
	<cfset pageTitle = "#words[1946]#">
    <cfset actionForm = "salesday1.cfm?trantype=#trantype#&alown=#alown#">		
<cfelseif type eq "enduserday">
	<cfset trantype = "END USER">
	<cfset pageTitle = "#words[1947]#">
    <cfset actionForm = "salesday2.cfm?trantype=#trantype#">
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
                <cfif type eq "agentday">
                    <tr> 
                        <th><label for="agent">#words[29]#</label></th>			
                        <td>
                            <input type="hidden" id="agentFrom" name="agentFrom" class="agentFilter" data-placeholder="#words[1387]#" />
                            <input type="hidden" id="agentTo" name="agentTo" class="agentFilter" placeholder="#words[1388]#" />
                        </td>
                    </tr>
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
                            <option value="">#words[1183]#</option>
                              <cfloop index="fCurrMonth" from="1" to="#c_Period#">
                                  <cfset fccurr = DateAdd('m', fCurrMonth, "#getgsetup.LastAccYear#")>
                                  <cfset fdmont = dateformat(fccurr,"mm")>
                                  <cfset fdmont2 = dateformat(fccurr,"mmmm ''yyyy")>
                                  <option title="#fdmont2#" value="#numberFormat(fCurrMonth,'00')#"<cfif fcurrmonth eq 1>selected</cfif>>#fCurrMonth# - #dateformat(fccurr,"mmm'yyyy")#</option>
                              </cfloop>
                        </select>
                    </td>
                </tr>
                <cfif type eq "agentday">
					<tr>
						<th><label for="other">#words[688]#</label></th>
						<td>
							<div><input type="checkbox" name="include" id="include" value="yes"> #words[1558]#</div>
						</td>
                </tr>
                </cfif>
            </table>
		</div>
        <div>
            <input type="Submit" name="result" id="result" value="HTML"  />
            <cfif type eq "enduserday">
                <input type="Submit" name="result" id="result" value="PDF"  />
            </cfif>
        </div>
        
    </cfform>
</cfoutput>
</body>
</html>