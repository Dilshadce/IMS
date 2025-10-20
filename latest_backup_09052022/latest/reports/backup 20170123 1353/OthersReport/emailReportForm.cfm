<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "877, 1089, 666, 664, 188, 665, 668, 689, 667, 185, 690, 673, 674, 1375, 703, 1361, 1362, 702, 1300, 1301, 1376, 1377, 1596, 1597, 1598">
<cfinclude template="/latest/words.cfm">

<cfquery name="getFormat" datasource="#dts#">
    SELECT display_name, file_name 
    FROM customized_format
    WHERE type =''
    ORDER BY display_name, file_name;
</cfquery>

<cfquery name="getRefNo" datasource="#dts#">
    SELECT refno from artran
    WHERE type =''
    AND fperiod <> '99'
    AND (void = '' OR void IS NULL);
</cfquery>

<cfquery name="getgsetup" datasource="#dts#">
	SELECT * 
    FROM gsetup;
</cfquery>

<cfif getpin2.h4700 eq 'T'>
	<cfset alown = 1>
</cfif>

<cfparam name="alown" default="0">
<cfset c_Period = getgsetup.Period>    
<cfset pageTitle = "#words[1596]#">
<cfset formAction = "report1.cfm?alown=#alown#">

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
    <script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
    <cfinclude template="/latest/filter/filterReferenceNo.cfm">
    <cfinclude template="/latest/date/datePickerFunction.cfm"> 

</head>

<body class="container">
<cfoutput>
	<form class="formContainer form2Button" name="emailReportForm" id="emailReportForm" action="#formAction#" method="post" target="_blank">
        <div>#pageTitle#</div>
        <div>
        <table> 
        
        	<input type="hidden" NAME="tf_fperiodfromDesp" id="tf_fperiodfromDesp" readonly="readonly" />
			<input type="hidden" NAME="tf_fperiodtoDesp" id="tf_fperiodtoDesp" readonly="readonly" />
			<input type="hidden" name="rptdate" id="rptdate" value="" >
			<input type="hidden" name="tf_fperiod" id="tf_fperiod" value="" >

            <tr>
                <th><label for="billType">#words[877]#</label></th>			
                <td>
                    <select id="billType" name="billType" required onChange="ajaxFunction(document.getElementById('ajaxField'),'getFormat.cfm?billType='+this.value);ajaxFunction(document.getElementById('ajaxField1'),'getRefNoFrom.cfm?billType='+this.value);ajaxFunction(document.getElementById('ajaxField2'),'getRefNoTo.cfm?billType='+this.value);">
                    	<option value="" >#words[1089]#</option>
                        <option value="INV" >#words[666]#</option>
                        <option value="RC" >#words[664]#</option>
                        <option value="PR" >#words[188]#</option>
                        <option value="DO" >#words[665]#</option>
                        <option value="QUO" >#words[668]#</option>
                        <option value="CN" >#words[689]#</option>
                        <option value="DN" >#words[667]#</option>
                        <option value="CS" >#words[185]#</option>
                        <option value="PO" >#words[690]#</option>
                        <option value="SO" >#words[673]#</option>
                        <option value="SAM" >#words[674]#</option>
                    </select>
                </td>
            </tr>
            <tr>        
            	<th><label for="format">#words[1597]#</label></th>			
                <td> 
                    <div id="ajaxField" name="ajaxField">
                        <select id="format" name="format">
                        	<cfif getFormat.recordcount eq 0>
                                <option value="">#words[1598]#</option>         
                            </cfif>
                            <cfloop query="getFormat">
                                <option value="#file_name#">#display_name#</option>
                            </cfloop>
                        </select>
                    </div>	
                </td>
            </tr>
            <tr>        
            	<th><label for="refNoFrom">#words[1375]#</label></th>			
                <td> 
                    <div id="ajaxField1" name="ajaxField1">
                        <select id="refNoFrom" name="refNoFrom" >
                            <cfif getRefNo.recordcount eq 0>
                                <option value="">#words[1376]#</option>         
                            </cfif>
                            <cfloop query="getRefNo">
                                <option value="#refno#">#refno#</option>
                            </cfloop>
                        </select>
                    </div>
                    <div id="ajaxField2" name="ajaxField2">
                        <select id="refNoTo" name="refNoTo" >
                            <cfif getRefNo.recordcount eq 0>
                                <option value="">#words[1377]#</option>         
                            </cfif>
                            <cfloop query="getRefNo">
                                <option value="#refno#">#refno#</option>
                            </cfloop>
                        </select>
                    </div>	
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
					<input type="text" name="dateFrom" id="dateFrom" maxlength="10" size="10" placeholder="#words[1300]#" readonly="readonly" />
					<input type="text" name="dateTo" id="dateTo" maxlength="10" size="10" placeholder="#words[1301]#" readonly="readonly" />
                </td>
			</tr>
             </table>
        </div>
        <div>
            <input type="submit" name="submit" id="submit" value="SUBMIT">
            <input type="button" name="back" id="back" value="BACK" onclick="window.history.back()">
        </div>
    </form>
</cfoutput>
</body>
</html>