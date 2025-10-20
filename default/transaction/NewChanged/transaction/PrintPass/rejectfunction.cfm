<html>
<head>
<title>Copy Job Order</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

</script>

</head>

<body width="100%">
<br>
<cfoutput>
<cfform name="form" method="post" action="rejectfunctionprocess.cfm" target="_self">
	<input id="type" type="hidden" name="type" value="#url.type#">
    <input id="refno" type="hidden" name="refno" value="#url.refno#">
    <input type="hidden" id="counter" name="counter" value="1">
    <div align="center"><h3>Comfirm to reject this bill type: #url.type# refno:#url.refno#</h3></div>
    <table class="data" align="center" width="200px">
    	
        <tr>
        	<td colspan="50%">
        		<div align="center"><input type="submit" value="Reject"></div>
                </td>
                <td>
                <div align="center"><input type="button" value="Cancel" onClick="window.close();"></div>
            </div></td>
        </tr>
    </table>
</cfform>
</cfoutput>
</body>
</html>