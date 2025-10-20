<cfoutput>
<cfset words_id_list = "29, 1387, 1388,1375, 1376, 1377, 517, 1483, 1484, 86, 1485, 1486, 5, 1352, 1353, 123, 495, 496, 146, 497, 498, 1302, 1417, 1418, 703, 1361, 1362, 702, 1300, 1301, 688, 1967, 1968, 1969, 1970, 1924, 1925">
<cfinclude template="/latest/words.cfm">

<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="/latest/css/jqueryui/smoothness/jquery-ui-1.10.3.custom.min.css" />
<link rel="stylesheet" href="/latest/css/select2/select2.css" />
<link rel="stylesheet" href="/latest/css/form.css" />

<script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="/latest/js/jqueryui/jquery-ui-1.10.3.custom.min.js"></script>
<script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>

<cfinclude template="/latest/filter/filterCustomer.cfm">
<h3>
	<a><font size="2">Eform Report</font></a>
</h3>

<form name="form1" id="form1"  action="eformreportEmployee.cfm" method="post" target="_blank"><!---action="eformreportprocess.cfm"--->
<table class="data">
	<tr>
		<th width="16%">Client/Customer</th>
		<td width="5%"> </td>
		<td colspan="2">
			<input type="hidden" id="customerFrom" name="customerFrom" class="customerFilter" data-placeholder="#words[1352]#" />
			<input type="hidden" id="customerTo" name="customerTo" class="customerFilter" data-placeholder="#words[1353]#" />     
		</td>
	</tr>
	
	<tr>
      	<td colspan="5"><hr></td>
    </tr>
	
	<tr>
		<td colspan="100%" align="center">
			<input type="submit" name="sub_btn" id="sub_btn" value="Submit">
			<!---
			&nbsp;&nbsp;&nbsp; 
			<input type="submit" name="subbtn" id="subbtn" value="Get All Client Excel" onClick="document.form1.action = 'eformexcel.cfm';">
			--->
			&nbsp;&nbsp;&nbsp; 
			<input type="submit" name="subbtn" id="subbtn" value="E-form Excel Report" onClick="document.form1.action = 'eform_excel.cfm';">
		</td>
	</tr>
</table>
</form>
</cfoutput>