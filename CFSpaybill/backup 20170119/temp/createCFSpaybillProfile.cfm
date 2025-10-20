<cfquery name="getarcust" datasource="#dts#">
SELECT custno,name FROM arcust
</cfquery>

<h1>Create CFS Pay & Bill profile</h1>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function selectlist(custno){
	for (var idx=0;idx<document.getElementById('custno').options.length;idx++) {
        if (custno==document.getElementById('custno').options[idx].value) {
            document.getElementById('custno').options[idx].selected=true;
			updateDetails(custno);
        }
    }
}
</script>
<cfoutput>
<cfform name="form" action="/CFSpaybill/CFSpaybillProfileprocess.cfm?type=create">
    <table>
    	<tr>
        	<td>
        		<label>Profile Name</label>
            </td>
            <td>
            	<cfinput type="text" id="profilename" name="profilename" value="">
            </td>
        </tr>
    	<tr>
        	<td>
        		<label>Choose Client</label>
            </td>
            <td>
            	<cfselect name="custprofile" id="custprofile">
                	<option value="">Please Select a Customer Profile</option>
                    <cfloop query="getarcust">
                        <option value="#getarcust.custno#">#getarcust.name#</option>
                    </cfloop>                 
                </cfselect>
            </td>
        </tr>
         <tr>
        	<td>
        		<label>Rate for Pay</label>
            </td>
            <td>
                <input type="text" id="payrate" name="payrate" value="0.00">
            </td>
        </tr>
        <tr>
        	<td>
        		<label>Rate for Bill</label>
            </td>
            <td>
                <input type="text" id="billrate" name="billrate" value="0.00">
            </td>
        </tr>
        <tr>
        	<td>
        		<label>Rate Type</label>
            </td>
            <td>
                <select name="ratettype" id="ratettype">
                	<option value="">Please choose a rate type</option>
                	<option value="mth"selected>Mth</option>
                    <option value="daily">Day</option>
                    <option value="hr">Hr</option>
                </select>
            </td>
        </tr>
        <tr>
        	<td>
        		<label>Administration fee (%)</label>
            </td>
            <td>
                <cfinput type="text" id="adminfee" name="adminfee" value="0.00">
            </td>
        </tr>
        <tr>
        	<td>
            </td>
            <td>
            	<br>
            	<cfinput type="submit" name="Submit" value="Create" validate="submitonce"/>
            </td>
        </tr>
    </table>
</cfform>
</cfoutput>