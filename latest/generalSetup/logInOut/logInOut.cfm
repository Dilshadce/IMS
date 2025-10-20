<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1821, 1822, 705, 1823, 1824, 702, 1300, 1301">
<cfinclude template="/latest/words.cfm">

<cfif url.target EQ "type1">
	<cfset pageTitle="#words[1821]#">
	<cfset formAction="report1.cfm">
  
<cfelseif url.target EQ "type2">
	<cfset pageTitle="#words[1822]#">
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

	<cfinclude template="/latest/filter/filterUser.cfm">
	<cfinclude template="/latest/date/datePickerFunction.cfm"> 
    <cfinclude template="/CFC/LastDayOfMonth.cfm">

</head>

<body class="container">
<cfoutput>
	<cfform class="formContainer form3Button" name="logInOutForm" id="logInOutForm" action="#formAction#" method="post" target="_blank">
        <div>#pageTitle#</div>
        <div>
        <table> 
        	<cfif url.target EQ 'type2'>
                <tr>
                <th><label for="">#words[705]#</label></th>			
                    <td>
                        <input type="hidden" id="userFrom" name="userFrom" class="userFilter" data-placeholder="#words[1823]#" />
                        <input type="hidden" id="userTo" name="userTo" class="userFilter" data-placeholder="#words[1824]#" />
                    </td>
                </tr>
			</cfif>
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
            <input type="Submit" name="Submit" id="Submit" value="SUBMIT">
        </div>
    </cfform>
</cfoutput>
</body>
</html>