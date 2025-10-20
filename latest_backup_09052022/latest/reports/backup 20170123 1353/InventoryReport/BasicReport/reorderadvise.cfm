<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1465,123,495,496,146,497,498,1302,1417,1418,104,1354,1355,703,1183,501,1399">
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

<cfset pageTitle = "#words[1465]#">

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

	<cfinclude template="/latest/filter/filterCategory.cfm">
    <cfinclude template="/latest/filter/filterGroup.cfm">
	<cfinclude template="/latest/filter/filterProduct.cfm">
    <cfinclude template="/latest/filter/filterSupplier.cfm">

</head>

<body class="container">
<cfoutput>
	<cfform class="formContainer form3Button" name="reorderAdviseForm" id="reorderAdviseForm" action="reorderadvise2.cfm" method="post" target="_blank">
		<div>#pageTitle#</div>
        <div>
            <table> 
                <input type="hidden" NAME="tf_fperiodfromDesp" id="tf_fperiodfromDesp" readonly="readonly" />
                <input type="hidden" NAME="tf_fperiodtoDesp" id="tf_fperiodtoDesp" readonly="readonly" />
                <input type="hidden" name="rptdate" id="rptdate" value="" />
                <input type="hidden" name="tf_fperiod" id="tf_fperiod" value="" />
                <tr> 
                    <th><label for="category">#words[123]#</label></th>			
                    <td>
                        <input type="hidden" id="categoryFrom" name="categoryFrom" class="categoryFilter" data-placeholder="#words[495]#" />
                        <input type="hidden" id="categoryTo" name="categoryTo" class="categoryFilter" placeholder="#words[496]#" />
                    </td>
                </tr>
                <tr> 
                    <th><label for="group">#words[146]#</label></th>			
                    <td>
                        <input type="hidden" id="groupFrom" name="groupFrom" class="groupFilter" data-placeholder="#words[497]#" />
                        <input type="hidden" id="groupTo" name="groupTo" class="groupFilter" placeholder="#words[498]#" />
                    </td>
                </tr>
                <tr> 
                    <th><label for="product">#words[1302]#</label></th>			
                    <td>
                        <input type="hidden" id="productFrom" name="productFrom" class="productFilter" data-placeholder="#words[1417]#"/>
                        <input type="hidden" id="productTo" name="productTo" class="productFilter" placeholder="#words[1418]#" />
                    </td>
                </tr>  
                <tr> 
                    <th><label for="supplier">#words[104]#</label></th>			
                    <td>
                        <input type="hidden" id="supplierFrom" name="supplierFrom" class="supplierFilter" data-placeholder="#words[1354]#" />
                        <input type="hidden" id="supplierTo" name="supplierTo" class="supplierFilter" placeholder="#words[1355]#" />
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
            </table>
		</div>
        <div>
            <input type="Submit" name="result" id="result" value="#words[501]#"  />
            <input type="Submit" name="result" id="result" value="#words[1399]#"  />
        </div>
        
    </cfform>
</cfoutput>
</body>
</html>