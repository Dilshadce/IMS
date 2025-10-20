<cfsetting showDebugOutput = "Yes">
<cfoutput>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="/latest/css/jqueryui/smoothness/jquery-ui-1.10.3.custom.min.css" />
<link rel="stylesheet" href="/latest/css/select2/select2.css" />
<script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="/latest/js/jqueryui/jquery-ui-1.10.3.custom.min.js"></script>
<script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>

<cfset words_id_list = "29, 1387, 1388,1375, 1376, 1377, 517, 1483, 1484, 86, 1485, 1486, 5, 1352, 1353, 123, 495, 496, 146, 497, 498, 1302, 1417, 1418, 703, 1361, 1362, 702, 1300, 1301, 688, 1967, 1968, 1969, 1970, 1924, 1925">
<cfinclude template="/latest/words.cfm">
<cfinclude template="/latest/filter/filterCustomer.cfm">
<cfinclude template="/latest/filter/filterEmployee.cfm">

<script type="text/javascript">

	function disableType(type)
	{
		if(type == 'Leave Report')
		{
			document.getElementById('Claim_Report').disabled = True;
		}
		else
		{
			document.getElementById('Leave_Report').disabled = True;			
		}
	}

</script>

<h1 align="center">
	<a>Leave & Claim Report</a>
</h1>

<form name="form1" id="form1"  action="eleavereport.cfm" method="post" target="_blank">
    <table align="center" class="data">
       
        <tr>
            <th>Client</th>
            <td>
                <input type="hidden" id="customerFrom" name="customerFrom" class="customerFilter" data-placeholder="#words[1352]#" />
                <input type="hidden" id="customerTo" name="customerTo" class="customerFilter" data-placeholder="#words[1353]#" />     
           </td>
        </tr>
        
        <tr>
            <td colspan="5"><hr></td>
        </tr>
        
        <tr>
            <th>Employee</th>
            <td>
                <input type="hidden" id="empFrom" name="empFrom" class="employeeFilter"/>
                <input type="hidden" id="empTo" name="empTo" class="employeeFilter"/>     
           </td>
        <tr>
        
        <tr>
            <td colspan="5"><hr></td>
        </tr>
        
        <tr>
            <td colspan="100%" align="center">
                <input type="submit" name="Leave_Report" id="Leave_Report" value="Leave Report" onClick="disableType(this.value)">&nbsp;&nbsp;
                <input type="submit" name="Claim_Report" id="Claim_Report" value="Claim Report" onClick="disableType(this.value)">
            </td>
        </tr>
    </table>
</form>
</cfoutput>