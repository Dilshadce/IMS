<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "703, 1361, 1362, 1535, 1541, 1542, 1543, 1537, 1538, 1539, 1540">
<cfinclude template="/latest/words.cfm">

<cfset consignment=''>
<cfif url.target EQ "type1">
	<cfset pageTitle = "#words[1541]#">
    <cfset formAction = "report1.cfm?type=opening">
    
<cfelseif url.target EQ "type2">
	<cfset pageTitle = "#words[1542]#">
    <cfset formAction = "report1.cfm?type=sales">
    
<cfelseif url.target EQ "type3">
	<cfset pageTitle = "#words[1543]#">
    <cfset formAction = "report1.cfm?type=purchase">

<cfelseif url.target EQ "type4">
	<cfset pageTitle = "#words[1535]#">
    <cfset formAction = "report1.cfm?type=stockbalance">
                 
</cfif>

<cfquery name="getgsetup" datasource="#dts#">
	SELECT * 
    FROM gsetup;
</cfquery>
<cfset c_Period = getgsetup.Period>

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


	<cfinclude template="/latest/filter/filterMatrix.cfm">
    <cfinclude template="/CFC/LastDayOfMonth.cfm">

</head>

<body class="container">
<cfoutput>
	<cfform class="formContainer form3Button" name="matrixItemForm" id="matrixItemForm" action="#formAction#" method="post" target="_blank">
        <div>#pageTitle#</div>
        <div>
        <table> 
        
        	<input type="hidden" NAME="tf_fperiodfromDesp" id="tf_fperiodfromDesp" readonly="readonly" />
			<input type="hidden" NAME="tf_fperiodtoDesp" id="tf_fperiodtoDesp" readonly="readonly" />
			<input type="hidden" name="rptdate" id="rptdate" value="" >
			<input type="hidden" name="tf_fperiod" id="tf_fperiod" value="" >

   
            <tr> 
                <th><label for="matrixItem">#words[1537]#</label></th>			
                <td>
                    <input type="hidden" id="matrixItemFrom" name="matrixItemFrom" class="matrixFilter" data-placeholder="#words[1538]#" />
                    <input type="hidden" id="matrixItemTo" name="matrixItemTo" class="matrixFilter" data-placeholder="#words[1539]#" />
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
            	<th></th>
                <td>
                	<div><input type="checkbox" name="inserthyphen" checked>#words[1540]#</div>
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