<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1793, 877, 1089, 690, 664, 188, 668, 473, 665, 666, 185, 689, 667, 1067, 1068, 1069, 1794, 1070, 674, 961, 1795, 1795, 1787, 702, 877, 1375, 1796, 703, 1361, 1362, 688, 1798, 1799, 1800, 673, 1797">
<cfinclude template="/latest/words.cfm">

<cfquery name="getgsetup" datasource="#dts#">
	SELECT * 
    FROM gsetup;
</cfquery>
<cfset c_Period = getgsetup.Period>
<cfset pageTitle = "#words[1793]#">

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

</head>

<body class="container">
<cfoutput>
	<cfform class="formContainer form3Button" name="auditTrailForm_1" id="auditTrailForm_1" action="report1.cfm" method="post" target="_blank">
        <div>#pageTitle#</div>
        <div>
            <table> 
                <tr>
                    <th><label for="billType">#words[877]#</label></th>			
                    <td>
                        <select id="billType" name="billType">
                            <option value="">#words[1089]#</option>	 	                             
                            <option value="PO">#words[690]#</option>	
                            <option value="RC">#words[664]#</option>
                            <option value="PR">words[188]</option>	
                            <option value="QUO">#words[668]#</option>
                            <option value="SO">#words[673]#</option>	
                            <option value="DO">#words[665]#</option>		  	  
                            <option value="INV">#words[666]#</option>	
                            <option value="CS">#words[185]#</option>	
                            <option value="CN">#words[689]#</option>
                            <option value="DN">#words[667]#</option>
                            <option value="ISS">#words[1067]#</option>	    
                            <option value="OAI">#words[1068]#</option>
                            <option value="OAR">#words[1069]#</option>	
                            <option value="ASSM">#words[1794]#</option>		
                            <option value="TR">#words[1070]#</option>
                            <option value="SAM">#words[674]#</option>	
                            <option value="PQ">#words[961]#</option>		
                        </select>
                    </td>
                </tr>
                <tr>
                <th><label for="sortBy">#words[1795]#</label></th>			
                    <td>
                        <select id="sortBy" name="sortBy">
                            <option value="">#words[1795]#</option>	 	  
                            <option value="userid">#words[1787]#</option>
                            <option value="wos_date">#words[702]#</option>
                            <option value="type">#words[877]#</option>
                            <option value="refno">#words[1375]#</option>
                            <option value="updated_on">#words[1796]#</option>  	  
                        </select>
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
                        
                        <div><input type="checkbox" name="include99" value="include99"> #words[1797]#</div>
                    </td>
                </tr>
                <tr>
                    <th><label>#words[688]#</label></th>
                    <td>
                        <div><input type="radio" name="result" value="instock" checked> #words[1798]#</div>
                        <div><input type="radio" name="result" value="modified"> #words[1799]#</div>
                        <div><input type="radio" name="result" value="deleted"> #words[1800]#</div>
                    </td>
                </tr>
            </table>
        </div>
        <div>
            <input type="Submit" name="submit" id="submit" value="SUBMIT">
            <input type="Submit" name="submit" id="submit" value="BACK" onclick="history.go(-1);"> 
        </div>
    </cfform>
</cfoutput>
</body>
</html>