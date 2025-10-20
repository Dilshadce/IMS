<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "5, 1352, 1353, 482, 499, 500, 1302, 1417, 1418, 877, 1089, 185, 689, 667, 665, 666, 664, 188, 12, 702, 1300, 1301, 1587, 1588, 1589, 1590, 159, 1591, 1592, 1593, 1594 ,1595">
<cfinclude template="/latest/words.cfm">

<cfif url.target EQ "type1">
	<cfset pageTitle="#words[1587]#">
    <cfset pageType="ref">

<cfelseif url.target EQ "type2">
	<cfset pageTitle="#words[1588]#">
	<cfset pageType="item">
    
<cfelseif url.target EQ "type3">
	<cfset pageTitle="#words[1589]#">
    <cfset pageType="status">  

<cfelseif url.target EQ "type4">
	<cfset pageTitle="#words[1590]#">
    <cfset pageType="sale">                            
</cfif>
<cfoutput>
	<cfset formAction="report1.cfm?type=#pageType#">
</cfoutput>    

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

	<cfinclude template="/latest/filter/filterCustomer.cfm">
    <cfinclude template="/latest/filter/filterLocation.cfm">
    <cfinclude template="/latest/filter/filterProduct.cfm">
    <cfinclude template="/latest/filter/filterSerialNo.cfm">
    <cfinclude template="/latest/date/datePickerFunction.cfm"> 

</head>

<body class="container">
<cfoutput>
	<cfform class="formContainer form3Button" name="serialNoReportForm" id="serialNoReportForm" action="#formAction#" method="post" target="_blank">
        <div>#pageTitle#</div>
        <div>
            <table> 
                <cfif url.target EQ "type4">
                    <tr> 
                        <th><label for="customer">#words[5]#</label></th>			
                        <td>
                            <input type="hidden" id="customerFrom" name="customerFrom" class="customerFilter" data-placeholder="#words[1352]#" /> 
                                <input type="hidden" id="customerTo" name="customerTo" class="customerFilter" data-placeholder="#words[1353]#" /> 
                        </td>
                    </tr>
                </cfif>
                <tr> 
                    <th><label for="location">#words[482]#</label></th>			
                    <td>
                        <input type="hidden" id="locationFrom" name="locationFrom" class="locationFilter" data-placeholder="#words[499]#" /> 
                        <input type="hidden" id="locationTo" name="locationTo" class="locationFilter" data-placeholder="#words[500]#" /> 
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
                    <th><label for="serial">#words[159]#</label></th>			
                    <td>
                        <input type="hidden" id="serialFrom" name="serialFrom" class="serialNoFilter" data-placeholder="#words[1591]#" /> 
                        <input type="hidden" id="serialTo" name="serialTo" class="serialNoFilter" data-placeholder="#words[1592]#" /> 
                    </td>
                </tr>
                <tr>
                    <th><label for="billType">#words[877]#</label></th>			
                    <td>
                    	<select id="billType" name="billType">
                            <option value="">#words[1089]#</option>	 	  
                            <option value="CS">#words[185]#</option>
                            <option value="CN">#words[689]#</option>
                            <option value="DN">#words[667]#</option>
                            <option value="DO">#words[665]#</option>
                            <option value="INV">#words[666]#</option>
                            <option value="RC">#words[664]#</option>
                            <option value="PR">#words[188]#</option>	  	  
                        </select>
                    </td>
                </tr>
                <cfif url.target EQ "type2">
                    <tr>
                        <th><label for="show">#words[12]#</label></th>			
                        <td>
                            <select id="serialStatus" name="serialStatus">
                                <option value="All" selected>#words[1593]#</option>
                                <option value="Unused">#words[1594]#</option>
                                <option value="Used">#words[1595]#</option>
                            </select>
                        </td>
                    </tr>
                </cfif>
                <tr> 
                	<th><label for="date">#words[702]#</label></th>			
                	<td>
					<input type="Text" id="dateFrom" name="dateFrom" maxlength="10" size="10" placeholder="#words[1300]#" readonly="readonly" />
					<input type="Text" id="dateTo" name="dateTo" maxlength="10" size="10" placeholder="#words[1301]#" readonly="readonly" />
                	</td>
				</tr>
                <tr>
				<th><label>Exclude 0 Quantity</label></th>
                <td>
                    <div><input type="checkbox" name="exclude0" id="exclude0" value="exclude0"></div>
                </td>
			</tr>
            </table>
        </div>
        <div>
            <input type="Submit" name="result" id="result" value="HTML"/>
            <input type="Submit" name="result" id="result" value="EXCEL"  />           
            <input type="Submit" id="back" name="back" value="BACK" onclick="history.go(-1);"> 
     	</div>
    </cfform>
</cfoutput>
</body>
</html>