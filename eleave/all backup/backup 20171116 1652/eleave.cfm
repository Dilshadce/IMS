<cfoutput>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
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
            <th>Client ID</th>
            <td>
                <input type="text" name="custno" id="custno" value="">
            </td>
        </tr>
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