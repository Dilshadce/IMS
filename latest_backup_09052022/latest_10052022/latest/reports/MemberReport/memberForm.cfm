<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1303, 702, 1300, 1301, 1523, 1524, 1525, 1526, 688, 1521, 1522, 1520">
<cfinclude template="/latest/words.cfm">

<cfset consignment=''>
<cfif url.target EQ "type1">
	<cfset pageTitle = "#words[1523]#">
	<cfset formAction = "report1.cfm">
    
<cfelseif url.target EQ "type2">
	<cfset pageTitle = "#words[1524]#">
	<cfset formAction = "report2.cfm">
    
<cfelseif url.target EQ "type3">
	<cfset pageTitle = "#words[1525]#">
	<cfset formAction = "report3.cfm">   

<cfelseif url.target EQ "type4">
	<cfset pageTitle = "#words[1526]#">
	<cfset formAction = "report4.cfm"> 
           
</cfif>

<cfquery name="getgsetup" datasource="#dts#">
	SELECT *
    FROM gsetup
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

	<cfinclude template="/latest/filter/filterDriver.cfm">
    <cfinclude template="/latest/date/datePickerFunction.cfm"> 
    <cfinclude template="/CFC/LastDayOfMonth.cfm">

</head>

<body class="container">
<cfoutput>
	<cfform class="formContainer form3Button" name="memberReportForm" id="memberReportForm" action="#formAction#" method="post" target="_blank">
        <div>#pageTitle#</div>
        <div>
        <table> 
        	<cfif url.target EQ "type1" OR url.target EQ "type2">
                <tr> 
                    <th><label for="member">#words[1303]#</label></th>			
                    <td>
                          <input type="hidden" id="member" name="member" class="driverFilter" data-placeholder="#words[1520]#" />
                    </td>
                </tr>
            </cfif>
            <cfif url.target EQ "type3" OR url.target EQ "type4">
                <tr> 
                    <th><label for="date">#words[702]#</label></th>			
                    <td>
                        <input type="Text" name="dateFrom" id="dateFrom" maxlength="10" size="10" placeholder="#words[1300]#" readonly="readonly" />
                        <input type="Text" name="dateTo" id="dateTo" maxlength="10" size="10" placeholder="#words[1301]#" readonly="readonly" />
                    </td>
                </tr>
            </cfif>
            <cfif url.target EQ "type2">
                <tr>
                    <th><label>#words[688]#</label></th>
                    <td>
                        <div><input type="checkbox" name="Negpoint" id="Negpoint" value="1"> #words[1521]#</div>
                        <div><input type="checkbox" name="point30" id="point30" value="1"> #words[1522]#</div>
                       
                    </td>
                </tr>
			</cfif>
        </table>
        </div>
        <div>
            <input type="submit" name="submit" id="submit" value="Submit" />
            <input type="button" name="Back" id="Back" value="Back" onclick="history.go(-1);"> 
        </div>
    </cfform>
</cfoutput>
</body>
</html>