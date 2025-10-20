<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1447,123,495,496,146,497,498,1302,1417,1418,122,1373,1374,150,1448,1449,482,499,500,703,1183,702,639,1378,1450,1451,1452,1453,1454,1455,1380,501,1399,688">
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

<cfset pageTitle = "#words[1447]#">
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
	<script type="text/javascript">
		function change_link() {
			if(document.locationPhysicalWorksheetForm.update_actual_qty.checked==true) {
				document.locationPhysicalWorksheetForm.action="location_physical_worksheet_adjust.cfm";
			}
			else {
				document.locationPhysicalWorksheetForm.action="location_physical_worksheet_result.cfm";
			}
		}
    </script>

	<cfinclude template="/latest/filter/filterCategory.cfm">
    <cfinclude template="/latest/filter/filterGroup.cfm">
	<cfinclude template="/latest/filter/filterProduct.cfm">
    <cfinclude template="/latest/filter/filterBrand.cfm">
    <cfinclude template="/latest/filter/filterModel.cfm">
    <cfinclude template="/latest/filter/filterLocation.cfm">
    <cfinclude template="/latest/date/datePickerFunction.cfm"> 
    <cfinclude template="/CFC/LastDayOfMonth.cfm">

</head>

<body class="container">
<cfoutput>
	<cfform class="formContainer form3Button" name="locationPhysicalWorksheetForm" id="locationPhysicalWorksheetForm" action="location_physical_worksheet_result.cfm" method="post" target="_blank">
		<div>#pageTitle#</div>
        <div>
            <table> 
<!---        	<input type="hidden" NAME="tf_fperiodfromDesp" id="tf_fperiodfromDesp" readonly="readonly" />
			<input type="hidden" NAME="tf_fperiodtoDesp" id="tf_fperiodtoDesp" readonly="readonly" />
			<input type="hidden" name="rptdate" id="rptdate" value="" />
			<input type="hidden" name="tf_fperiod" id="tf_fperiod" value="" />--->
                <tr> 
                    <th><label for="category">#words[123]#</label></th>			
                    <td>
                        <input type="hidden" id="categoryFrom" name="categoryFrom" class="categoryFilter" placeholder="#words[495]#" />
                        <input type="hidden" id="categoryTo" name="categoryTo" class="categoryFilter" placeholder="#words[496]#" />
                    </td>
                </tr>   
                <tr> 
                    <th><label for="group">#words[146]#</label></th>			
                    <td>
                        <input type="hidden" id="groupFrom" name="groupFrom" class="groupFilter" placeholder="#words[497]#" />
                        <input type="hidden" id="groupTo" name="groupTo" class="groupFilter" placeholder="#words[498]#" />
                    </td>
                </tr>
                <tr> 
                <th><label for="product">#words[1302]#</label></th>			
                <td>
                    <input type="hidden" id="productFrom" name="productFrom" class="productFilter" placeholder="#words[1417]#"/>
                    <input type="hidden" id="productTo" name="productTo" class="productFilter" placeholder="#words[1418]#" />
                </td>
            </tr>  
            <tr> 
                <th><label for="brand">#words[122]#</label></th>			
                <td>
                    <input type="hidden" id="brandFrom" name="brandFrom" class="brandFilter" placeholder="#words[1373]#"/>
                    <input type="hidden" id="brandTo" name="brandTo" class="brandFilter" placeholder="#words[1374]#" />
                </td>
            </tr>
            <tr> 
                <th><label for="model">#words[150]#</label></th>			
                <td>
                    <input type="hidden" id="modelFrom" name="modelFrom" class="modelFilter" placeholder="#words[1448]#"/>
                    <input type="hidden" id="modelTo" name="modelTo" class="modelFilter" placeholder="#words[1449]#" />
                </td>
            </tr>            
            <tr> 
                <th><label for="location">#words[482]#</label></th>			
                <td>
                    <cfif Huserloc neq "All_loc">
                    <input type="text" id="locationFrom" readonly name="locationFrom" value="#Huserloc#" data-placeholder="#words[499]#" />
                    <input type="text" id="locationTo" readonly name="locationTo" value="#Huserloc#" data-placeholder="#words[500]#" />
                    <cfelse>
                    <input type="hidden" id="locationFrom" name="locationFrom" class="locationFilter" data-placeholder="#words[499]#" />
                    <input type="hidden" id="locationTo" name="locationTo" class="locationFilter" data-placeholder="#words[500]#" />
                    </cfif>
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
            <tr> 
                <th><label for="date">#words[702]#</label></th>
                <td>
					<input type="Text" name="dateFrom" id="dateFrom" value="#dateformat(now(),'dd/mm/yyyy')#" maxlength="10" size="10" placeholder="#words[639]#" readonly="readonly" />
					</td>
			</tr>
            <tr>
            <th><label for="other">#words[688]#</label></th>
                <td>
                    <div><input type="checkbox" name="sortitem" id="sortitem" value="yes"> #words[1378]#</div>
                    <div><input type="checkbox" name="with_qty" id="with_qty" value="yes" checked="checked"> #words[1450]#</div>
                    <div><input type="checkbox" name="include_stock" id="include_stock" value="yes"> #words[1451]#</div>
                </td>
			</tr>
            <tr>
            	<th></th>
                <td>
                	<div><input type="checkbox" name="update_actual_qty" id="update_actual_qty" value="yes"  onClick="change_link();"/> #words[1452]#</div>
                    <div><input type="checkbox" name="generate_adjustment_transaction" value="yes"> #words[1454]#</div>
                </td>
            </tr>
            <tr>
            	<th></th>
                <td>
                	<div><input type="checkbox" name="exclude_actual" value="yes"/>#words[1455]#</div>
                    <div><input type="checkbox" name="itemdespsort" value="yes" /> #words[1380]#</div>
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