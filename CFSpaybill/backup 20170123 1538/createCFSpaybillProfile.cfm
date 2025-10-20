<cfquery name="getarcust" datasource="#dts#">
SELECT custno,name FROM arcust
</cfquery>

<h1>Create CFS Pay & Bill profile</h1>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
<cfinclude template="/CFSpaybill/filter/filterCustomer.cfm">
<script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>
<link rel="stylesheet" href="/latest/css/select2/select2.css" />
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
        <td><label>Profile Name</label></td>
        <td><input type="text" id="profilename" name="profilename" value="" required></td>
      </tr>
      <tr>
        <td><label>Choose Client</label></td>
        <td><input type="hidden" class="custprofile" name="custprofile">
         </td>
      </tr>
      <tr>
        <td><label>Rate for Pay</label></td>
        <td><input type="text" id="payrate" name="payrate" value="0.00"></td>
      </tr>
      <tr>
        <td><label>Rate for Bill</label></td>
        <td><input type="text" id="billrate" name="billrate" value="0.00"></td>
      </tr>
      <tr>
        <td><label>Rate Type</label></td>
        <td><select name="ratetype" id="ratetype">
            <option value="">Please choose a rate type</option>
            <option value="day">Day</option>
            <option value="hour">Hr</option>
          </select></td>
      </tr>
      <tr>
        <td><label>Administration fee</label></td>
        <td><input type="text" id="adminfee" name="adminfee" placeholder="Type in Admin Fee here" value="0.00"></td>
      </tr>
      <tr>
        <td><label>Admin Fee Cap (Max 2500) </label></td>
        <td><input type="checkbox" id="adminfeecap" name="adminfeecap" value="2500"></td>
      </tr>
      <tr>
        <td></td>
        <td><br>
          <cfinput type="submit" name="Submit" value="Create" validate="submitonce"/></td>
      </tr>
    </table>
  </cfform>
</cfoutput>