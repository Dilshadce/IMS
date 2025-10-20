<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "664,188,665,666,689,667,185,690,668,673,674,1067,1068,1069,1350,1073,1072,5,1352,1353,104,1354,1355,29,1387,1388,1302,1417,1418,482,499,500,506,1389,1390,475,1391,1392,1375,1376,1377,146,497,498,88,1419,1420,1421,1422,1423,703,1361,1362,1300,1301,688,1424,1425,1426,1427,1428,1429,1430,1431,1432,1433,1434,501,1399,1435,702,8001">
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

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title><cfoutput>Payroll Summary</cfoutput></title>
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

</head>

<body class="container">
<cfoutput>
	<cfform class="formContainer form3Button" name="payrollSummaryForm" id="payrollSummaryForm" action="payrollSummary.cfm?" method="post" target="_blank">
        <div>Payroll Summary</div>
        <div>
        <table>
            	<tr>
                    <th><label for="customerLabel">Customer</label></th>
                    <td>
						<input type="hidden" id="customerFrom" name="customer" class="customerFilter" data-placeholder=" -- Choose a Customer" />

                    </td>
                </tr>

            <tr>
                <th><label for="period">#words[703]#</label></th>
                <td>
                    <select name="period" id="periodFrom" Onchange="tf_fperiodfromDesp.value = this.options[this.selectedIndex].title;">
                        <option value="">Payroll Period</option>
                          <cfloop index="i" from="1" to="12">

                              <option value="#i#">#i#</option>
                          </cfloop>
                    </select>


                </td>
            </tr>

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
            <input type="Submit" name="type" id="result" value="Normal"  />
			<input type="Submit" name="type" id="result" value="Exception"  />
        </div>
    </cfform>
</cfoutput>
</body>
</html>