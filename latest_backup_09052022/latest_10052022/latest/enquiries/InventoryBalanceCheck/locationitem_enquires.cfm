<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1302,1417,1418,482,499,500,1411,1407, 1532, 1531">
<cfinclude template="/latest/words.cfm">

<cfquery name="getgsetup" datasource="#dts#">
	SELECT * 
    FROM gsetup
</cfquery>
<cfset c_Period = getgsetup.Period>

<cfset pageTitle="#words[1532]#">

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
    
	<cfinclude template="/latest/filter/filterProduct.cfm">
    <cfinclude template="/latest/filter/filterLocation.cfm">

</head>

<body class="container">
<cfoutput>
	<cfform class="formContainer form3Button" name="locationItemEnquiryReport" id="locationItemEnquiryReport" action="locationitem_enquiresreport.cfm" method="post" target="_blank">
        <div>#pageTitle#</div>
        <div>
            <table>                 
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
                    <th><label>#words[1411]#</label></th>
                    <td>
                        <div><input type="checkbox" name="dodate" id="dodate" value="yes" checked="checked"> #words[1407]#</div>
                        <div><input type="checkbox" name="negative" id="negative" value="yes"> #words[1531]#</div>
                    </td>
                </tr>
            </table>
        </div>
        <div>
            <input type="Submit" name="result" id="result" value="HTML">
        </div>
    </cfform>
</cfoutput>
</body>
</html>