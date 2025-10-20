<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "104, 1354, 1355, 482, 499, 500, 506, 1389, 1390, 475, 1391, 1392, 1375, 1376, 1377, 703, 1361, 1362, 702, 1300, 1301, 1574, 1575">
<cfinclude template="/latest/words.cfm">

<cfparam name="alown" default="0">
<cfif getpin2.h4700 eq 'T'>
	<cfset alown = 1>
</cfif>

<cfquery name="getRefNo" datasource="#dts#">
	SELECT refno 
    FROM artran 
    WHERE type = 'RC' 
    AND fperiod <> '99'
    ORDER BY refno;
</cfquery>
    
<cfquery name="getgsetup" datasource="#dts#">
	SELECT * 
    FROM gsetup;
</cfquery>
<cfset c_Period = getgsetup.Period>

<cfif url.target EQ "type1">
	<cfset pageTitle="#words[1574]#">
	<cfset formAction="report1.cfm?type=Purchase Receive&trancode=RC&alown=#alown#">
    
<cfelseif url.target EQ "type2">
	<cfset pageTitle="#words[1575]#">
	<cfset formAction="report2.cfm">   
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

    <cfinclude template="/latest/filter/filterLocation.cfm">
    <cfinclude template="/latest/filter/filterSupplier.cfm">
    <cfinclude template="/latest/filter/filterProject.cfm">
    <cfinclude template="/latest/filter/filterReferenceNo.cfm">
    <cfinclude template="/latest/filter/filterJob.cfm">
    <cfinclude template="/latest/date/datePickerFunction.cfm"> 




</head>

<body class="container">
<cfoutput>
	<cfform class="formContainer form3Button" name="manufacturingReportForm" id="manufacturingReportForm" action="#formAction#" method="post" target="_blank">
        <div>#pageTitle#</div>	
        <div>
            <table> 
            
                <input type="hidden" NAME="tf_fperiodfromDesp" id="tf_fperiodfromDesp" readonly="readonly" />
                <input type="hidden" NAME="tf_fperiodtoDesp" id="tf_fperiodtoDesp" readonly="readonly" />
                <input type="hidden" name="rptdate" id="rptdate" value="" >
                <input type="hidden" name="tf_fperiod" id="tf_fperiod" value="" >
                
                <tr> 
                    <th><label for="supplier">#words[104]#</label></th>			
                    <td>
                        <input type="hidden" id="supplierFrom" name="supplierFrom" class="supplierFilter" data-placeholder="#words[1354]#" />
                        <input type="hidden" id="supplierTo" name="supplierTo" class="supplierFilter" data-placeholder="#words[1355]#" />
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
                    <th><label for="project">#words[506]#</label></th>			
                    <td>
                        <input type="hidden" id="projectFrom" name="projectFrom" class="projectFilter" data-placeholder="#words[1389]#" />
                        <input type="hidden" id="projectTo" name="projectTo" class="projectFilter" data-placeholder="#words[1390]#" />
                    </td>
                </tr>
                <tr> 
                    <th><label for="job">#words[475]#</label></th>			
                    <td>
                        <input type="hidden" id="jobFrom" name="jobFrom" class="jobFilter" data-placeholder="#words[1391]#" />
                        <input type="hidden" id="jobTo" name="jobTo" class="jobFilter" data-placeholder="#words[1392]#" />
                    </td>
                </tr>
                <tr> 
                    <th><label for="refNo">#words[1375]#</label></th>			
                    <td>
                    	<cfloop index="i" from="1" to="2">
                        	<cfif i EQ 1>
								<cfset displayMessage = "#words[1376]#">
                                <cfset selectIDValue = "From">
                            <cfelse>    
                            	<cfset displayMessage = "#words[1377]#">
                                <cfset selectIDValue = "To">
                            </cfif>
                            
                           <select name="refNo#selectIDValue#">
                                <option value="">#displayMessage#</option>
                                <cfloop query="getRefNo">
                                    <option value="#refno#">#refno#</option>
                                </cfloop>
                            </select>
                        </cfloop>
                        
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
            </table>
        </div>
        <div>
            <input type="Submit" name="submit" id="submit" value="SUBMIT">
        </div>
    </cfform>
</cfoutput>
</body>
</html>