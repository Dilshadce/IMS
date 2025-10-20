<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "2044, 2045, 2046, 2047, 123, 495, 496, 146, 497, 498, 1302, 1417, 1418, 482, 499, 500, 5, 1352, 1353, 703, 1183, 702, 1300, 1301, 1852, 2027, 2028, 2029, 2030, 2033, 2034, 2035, 2036, 2037, 688, 1406, 2048, 2049, 2050">
<cfinclude template="/latest/words.cfm">
<cfquery name="getgsetup" datasource="#dts#">
	SELECT * 
    FROM gsetup
</cfquery>
<cfquery name="checkcustom" datasource="#dts#">
    SELECT customcompany 
    FROM dealer_menu
</cfquery>
<cfset c_Period = getgsetup.Period>

<cfif isdefined("form.lastaccdaterange") and form.lastaccdaterange neq "">
	<cfquery name="getdate" datasource="#dts#">
		SELECT LastAccDate,ThisAccDate 
        FROM icitem_last_year
		WHERE LastAccDate = #form.lastaccdaterange#
		LIMIT 1
	</cfquery>
	<cfset clsyear = year(form.lastaccdaterange)>
	<cfset clsmonth = month(form.lastaccdaterange)>
	<cfset thislastaccdate = form.lastaccdaterange>
	<cfset diffmth= DateDiff("m",getdate.LastAccDate,getdate.ThisAccDate)>
<cfelse>
	<cfset clsyear = year(getgsetup.lastaccyear)>
	<cfset clsmonth = month(getgsetup.lastaccyear)>
	<cfset thislastaccdate = "">
</cfif>

<cfparam name="alown" default="0">

<cfif getpin2.h4700 eq 'T'>
	<cfset alown = 1>
</cfif>


<cfif type EQ "batchlisting">
	<cfif checkcustom.customcompany eq "Y">
        <cfset trantype = "LOT NUMBER - PRODUCT LISTING">
    <cfelse>
        <cfset trantype = "BATCH PRODUCT LISTING">
    </cfif>
	<cfset pageTitle = "#words[2044]#">
    <cfset actionForm = "batchitemlisting.cfm">
<cfelseif type eq "monthly">
		<cfset trantype = "LOT NUMBER MONTHLY">	
	<cfset pageTitle = "#words[2045]#">
    <cfset actionForm = "itembatchmonth.cfm">
<cfelseif type eq "bydate_tran">
		<cfset trantype = "LOT NUMBER - STOCK MOVEMENT">
	<cfset pageTitle = "#words[2046]#">
    <cfset actionForm = "itembatchtrans.cfm">
<cfelseif type eq "salesreport">
		<cfset trantype = "LOT NUMBER - OUTSTANDING SALES ORDER">
	<cfset pageTitle = "#words[2047]#">
    <cfset actionForm = "itembatchso.cfm">
</cfif>

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
	// only for thaipore_i
	function getPermitno(type,inputtext){
		DWREngine._execute(_reportflocation, null, 'permitnolookup', type,inputtext, getPermitnoResult);
	}
	
	function getPermitnoResult(permitArray){
		DWRUtil.removeAllOptions("permitno");
		DWRUtil.addOptions("permitno", permitArray,"KEY", "VALUE");
	}
	</script>

	<cfinclude template="/latest/filter/filterCategory.cfm">
    <cfinclude template="/latest/filter/filterGroup.cfm">
	<cfinclude template="/latest/filter/filterProduct.cfm">
	<cfinclude template="/latest/filter/filterLocation.cfm">
	<cfinclude template="/latest/filter/filterCustomer.cfm">
    <cfinclude template="/latest/date/datePickerFunction.cfm"> 
    <cfinclude template="/CFC/LastDayOfMonth.cfm">

</head>

<body class="container">
<cfoutput>
	<cfform class="formContainer form3Button" name="salesTypeForm" id="salesTypeForm" action="#actionForm#" method="post" target="_blank">
		<div>#pageTitle#</div>
        <div>
            <table>
                <input type="hidden" NAME="tf_fperiodfromDesp" id="tf_fperiodfromDesp" readonly="readonly" />
                <input type="hidden" NAME="tf_fperiodtoDesp" id="tf_fperiodtoDesp" readonly="readonly" />
                <input type="hidden" name="rptdate" id="rptdate" value="" />
                <input type="hidden" name="tf_fperiod" id="tf_fperiod" value="" />
                <input type="hidden" name="thislastaccdate" value="#thislastaccdate#">
                <cfif type eq "batchlisting">
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
                </cfif>
                <tr> 
                    <th><label for="product">#words[1302]#</label></th>			
                    <td>
                        <input type="hidden" id="productFrom" name="productFrom" class="productFilter" data-placeholder="#words[1417]#" />
                        <input type="hidden" id="productTo" name="productTo" class="productFilter" placeholder="#words[1418]#" />
                    </td>
                </tr>
                <cfif type neq "batchlisting">
                    <tr> 
                        <th><label for="location">#words[482]#</label></th>			
                        <td>
                            <input type="hidden" id="locationFrom" name="locationFrom" class="locationFilter" data-placeholder="#words[499]#" />
                            <input type="hidden" id="locationTo" name="locationTo" class="locationFilter" placeholder="#words[500]#" />
                        </td>
                    </tr>
                </cfif>
                <cfif type eq "salesreport">
                    <tr> 
                        <th><label for="customer">#words[5]#</label></th>			
                        <td>
                            <input type="hidden" id="customerFrom" name="customerFrom" class="customerFilter" data-placeholder="#words[1352]#" />
                            <input type="hidden" id="customerTo" name="customerTo" class="customerFilter" placeholder="#words[1353]#" />
                        </td>
                    </tr>
                </cfif>
                <cfif type eq "monthly">
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
                </cfif>
                <cfif type eq "bydate_tran">
                    <tr> 
                        <th><label for="date">#words[702]#</label></th>			
                        <td>
                            <input type="Text" name="dateFrom" id="dateFrom" maxlength="10" size="10" placeholder="#words[1300]#" readonly="readonly" />
                            <input type="Text" name="dateTo" id="dateTo" maxlength="10" size="10" placeholder="#words[1301]#" readonly="readonly" />
                        </td>
                    </tr>
                </cfif>
                <tr> 
                    <th><label for="batchCode"><cfif checkcustom.customcompany eq "Y">#words[1852]#<cfelse>#words[2027]#</cfif></label></th>
                    <td>
                        <input type="text" name="batchcodefrom" validate="eurodate" message="Invalid Input" maxlength="18" size="18" placeholder="#words[2028]#">
                        <input type="text" name="batchcodeto" validate="eurodate" message="Invalid Input" maxlength="18" size="18" placeholder="#words[2029]#">
                    </td>
                </tr>
                <tr> 
                    <th><label for="milCert"><cfif lcase(hcomid) eq "marquis_i">#words[1852]#<cfelse>#words[2030]#</cfif></label></th>
                    <td><input type="text" name="milcert" size="18" placeholder="#words[2033]#"></td>
                </tr>
                <tr> 
                    <th><label for="importPermit">#words[2034]#</label></th>
                    <td><input type="text" name="importpermit" size="18" placeholder="#words[2035]#"></td>
                </tr>
				<cfif checkcustom.customcompany eq "Y">
                    <cfquery name="getpermit" datasource="#dts#">
                        select brem5 as permit_no from ictran where brem5 <> '' group by brem5
                        union
                        select brem7 as permit_no from ictran where brem7 <> '' group by brem7
                        union
                        select brem8 as permit_no from ictran where brem8 <> '' group by brem8
                        union 
                        select brem9 as permit_no from ictran where brem9 <> '' group by brem9
                        union
                        select brem10 as permit_no from ictran where brem10 <> '' group by brem10
                        union
                        select importpermit as permit_no from ictran where importpermit <> '' group by importpermit
                    </cfquery>	
                    <cfif url.type neq "salesreport">	
                        <tr> 
                            <td colspan="100%"><hr></td>
                        </tr>
                        <tr> 
                            <th>#words[2036]#</th>
                            <td>
                                <select name="permitno">
                                    <option value="">#words[2037]#</option>
                                    <cfloop query="getpermit">
                                        <option value="#getpermit.permit_no#">#getpermit.permit_no#</option>
                                    </cfloop>
                                </select>				
                                <input type="text" name="searchpermitno" onKeyUp="getPermitno('',this.value);">
                            </td>
                        </tr>
                    </cfif>
                </cfif>
                <cfif type eq "monthly">
                    <tr>
                        <th><label for="other">#words[688]#</label></th>
                        <td>
                            <div><input type="checkbox" name="figure" id="figure" value="yes"> #words[1406]#</div>
                            <div><input type="checkbox" name="bylocation" id="bylocation" value="yes"> #words[2048]#</div>
                        </td>
                    </tr>
                    <tr>
                        <th></th>
                        <td>
                            <div><input type="radio" name="locationqty" id="locationqty" value="yes" checked="checked">#words[2049]#</div>
                            <div><input type="radio" name="locationqty" id="locationqty" value="no">#words[2050]#</div>
                        </td>
                    </tr>
                </cfif>
            </table>
		</div>
        <div>
            <input type="Submit" name="result" id="result" value="HTML"  />
			<cfif type eq "monthly" or type eq "batchlisting">
                <input type="Submit" name="result" id="result" value="EXCEL"  />
            </cfif>
        </div>
    </cfform>
</cfoutput>
</body>
</html>