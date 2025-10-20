<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "119,272,273,274,275,276,277,284,278,285,279,286,280,287,281,288,282,289,283,290,352,96">
<cfinclude template="/latest/words.cfm">
<cfset pageTitle="#words[119]#">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><cfoutput>#pageTitle#</cfoutput></title>
    <link rel="stylesheet" href="/latest/css/form.css" />
    <script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <!--[if (gte IE 6)&(lte IE 8)]>
        <script type="text/javascript" src="/latest/js/selectivizr/selectivizr-min.js"></script>
        <noscript><link rel="stylesheet" href="" /></noscript>
    <![endif]-->
    <cfinclude template="/latest/maintenance/filter/filterItem.cfm">
    <cfinclude template="/latest/maintenance/filter/filterPurchaseReceive.cfm">
	<link rel="stylesheet" href="/latest/css/select2/select2.css" />
    <script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>
</head>

<body class="container">
<cfoutput>
    <form class="formContainer form2Button" action="printBarCodeResult.cfm" method="post" >
        <div>#pageTitle#</div>
        <div>
            <table>
                <tr>
                    <th><label for="purchaseReceive">#words[272]#</label></th>
                    <td>
                    	<input type="hidden" id="purchaseReceive" name="purchaseReceive" class="purchaseReceiveFilter" data-placeholder="#words[273]#" />
                    </td>
                </tr>
                <tr> 
                    <th><label for="item">#words[274]#</label></th>			
                    <td>
                        <input type="hidden" id="itemFrom" name="itemFrom" class="itemFilter" data-placeholder="#words[275]#" />
                        <input type="hidden" id="itemTo" name="itemTo" class="itemFilter" data-placeholder="#words[276]#" />
                    </td>
                </tr> 
                <tr>
                    <th><label for="noOfCopy">#words[277]#</label></th>
                    <td>
                        <input type="number" step="any" min="0" id="noOfCopy" name="noOfCopy" />  
                    </td>
                    <div style="margin-left: 10px;">
                        <th><label for="format2">#words[284]#</label></th>
                        <td>
                            <input type="checkbox" name="format2" id="format2" />  
                        </td>
                    </div>
                </tr>
                <tr>
                    <th><label for="spacing">#words[278]#</label></th>
                    <td>
                        <input type="number" step="any" min="0" id="spacing" name="spacing" />
                    </td>
                    <th><label for="format3">#words[285]#</label></th>
                    <td>
                        <input type="checkbox" name="format3" id="format3" />  
                    </td>
                </tr>
                <tr>
                    <th><label for="topSpacing">#words[279]#</label></th>
                    <td>
                        <input type="number" step="any" min="0" id="topSpacing" name="topSpacing" />
                    </td>
                    <th><label for="format4">#words[286]#</label></th>
                    <td>
                        <input type="checkbox" name="format4" id="format4" />  
                    </td>
                </tr>
                <tr>
                    <th><label for="leftSpacing">#words[280]#</label></th>
                    <td>
                        <input type="number" step="any" min="0" id="leftSpacing" name="leftSpacing" />
                    </td>
                    <th><label for="format5">#words[287]#</label></th>
                    <td>
                        <input type="checkbox" name="format5" id="format5" />  
                    </td>
                </tr>
                <tr>
                    <th><label for="fontSize">#words[281]#</label></th>
                    <td>
                        <input type="number" step="any" min="0" id="fontSize" name="fontSize" />
                    </td>
                    <th><label for="format6">#words[288]#</label></th>
                    <td>
                        <input type="checkbox" name="format6" id="format6" />  
                    </td>
                </tr>
                <tr>
                    <th><label for="barCodeWidth">#words[282]#</label></th>
                    <td>
                        <input type="number" step="any" min="0" id="barCodeWidth" name="barCodeWidth" />	
                    </td>
                    <th style="padding-left: 20px;"><label for="format7">#words[289]#</label></th>
                    <td>
                        <input type="checkbox" name="format7" id="format7" />  
                    </td>
                </tr>
				<tr>
                    <th><label for="hdVersio">#words[283]#</label></th>
                    <td>
                        <input type="checkbox" name="hdwide" id="hdwide" value="1" />
                    </td>
                    <th><label for="CSS">#words[290]#</label></th>
                    <td>
                        <input type="checkbox" name="CSS" id="CSS" value="1" />  
                    </td>
                </tr>
            </table>
        </div>
        <div>
            <input type="submit" value="#words[352]#" />
            <input type="button" value="#words[96]#" onclick="window.location='/latest/maintenance/productProfile.cfm'" />
        </div>
    </form>
</cfoutput>
</body>
</html>