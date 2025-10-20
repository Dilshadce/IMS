<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "664,188,665,666,689,667,185,690,668,673,674,1067,1068,1069,1350,1073,1072,5,1352,1353,104,1354,1355,29,1387,1388,1302,1417,1418,482,499,500,506,1389,1390,475,1391,1392,1375,1376,1377,146,497,498,88,1419,1420,1421,1422,1423,703,1361,1362,1300,1301,688,1424,1425,1426,1427,1428,1429,1430,1431,1432,1433,1434,501,1399,1435,702,8001,8004">
<cfinclude template="/latest/words.cfm">
<cfset consignment=''>
	<cfset pageTitle = "Employee Details Report">
	<cfset trantype = "Placement Order">
	<cfset trancode = "RC">

<cfset target = trancode>


<cfparam name="alown" default="0">

<cfif getpin2.h4700 eq 'T'>
	<cfset alown = 1>
</cfif>
    
<cfquery name="getpayrollgsetup" datasource="payroll_main">
	SELECT *
    FROM gsetup
    WHERE comp_id="#replace(dts,'_i','')#"
</cfquery>

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

	<cfinclude template="/latest/filter/filterPlacementOrder.cfm">
    <cfinclude template="/latest/date/datePickerFunction.cfm">
    <cfinclude template="/CFC/LastDayOfMonth.cfm">
    <cfinclude template="/latest/filter/filterCustomer.cfm">

</head>

<body class="container">
<cfoutput>
	<cfform class="formContainer form3Button" name="EmployeeDetailsForm" id="EmployeeDetailsForm" action="LorealEmployeeDetailsReport.cfm" method="post" target="_blank">
        <div>#pageTitle#</div>
        <div>
        <table>

        	<input type="hidden" NAME="tf_fperiodfromDesp" id="tf_fperiodfromDesp" readonly="readonly" />
			<input type="hidden" NAME="tf_fperiodtoDesp" id="tf_fperiodtoDesp" readonly="readonly" />
			<input type="hidden" name="rptdate" id="rptdate" value="" >
			<input type="hidden" name="tf_fperiod" id="tf_fperiod" value="" >

                <cfset title = "PlacementOrder">

            <tr>
                <th><label for="period">#words[703]#</label></th>
                <td>
                    <select name="period" id="periodFrom">
                        <option value="">Select period</option>
                          <cfloop index="i" from="1" to="12">
                              <option value="#i#"  <cfif i eq getpayrollgsetup.mmonth>selected</cfif>>#i#</option>
							</cfloop>
                    </select>
                    <!---<select name="periodTo" style="display:none;" id="periodTo" Onchange="tf_fperiodtoDesp.value = this.options[this.selectedIndex].title;">
                        <option value="">#words[1362]#</option>

                    </select>--->
                </td>
            </tr>

        </table>
        </div>
        <input type="hidden" name="title" id="title" value="#title#" />
        <div>

            <input type="Submit" name="result" id="result" value="#words[1399]#"  />
        </div>
    </cfform>
</cfoutput>
</body>
</html>