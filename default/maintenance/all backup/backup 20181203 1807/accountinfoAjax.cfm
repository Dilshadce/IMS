<cfsetting showdebugoutput="no">
<cfsetting enablecfoutputonly="no">
<cfquery name="getcust" datasource="#dts#">
SELECT * from #target_arcust# where custno="#url.custno#"
</cfquery>

<cfoutput>
<table align="center" class="data" width="900">
<tr>
<td colspan="4" align="center">Account Information</td>
</tr>
<tr>
    		<th>Address :</th>
    		<td><input type="text" size="40" name="b_Add1" id="b_Add1" value="#getcust.Add1#" maxlength="35"></td>
            <th>Delivery Address :</th>
		    	<td><input type="text" size="40" name="o_Add1" id="o_Add1" value="#getcust.DAddr1#" maxlength="40"></td>
  		</tr>
        
  		<tr>
    		<td></td>
    		<td><input type="text" size="40" name="b_Add2" id="b_Add2"  value="#getcust.Add2#" maxlength="35"></td>
            <td></td>
		      	<td><input type="text" size="40" name="o_Add2" id="o_Add2"  value="#getcust.DAddr2#" maxlength="35"></td>
  		</tr>
  		<tr>
    		<td></td>
    		<td><input type="text" size="40" name="b_Add3" id="b_Add3"  value="#getcust.Add3#" maxlength="35"></td>
            <td></td>
				<td><input type="text" size="40" name="o_Add3" id="o_Add3"  value="#getcust.DAddr3#" maxlength="35"></td>
  		</tr>
  		<tr>
    		<td></td>
    		<td><input type="text" size="40" name="b_Add4" id="b_Add4"  value="#getcust.Add4#" maxlength="35"></td>
            <td></td>
		    	<td><input type="text" size="40" name="o_Add4" id="o_Add4"  value="#getcust.DAddr4#" maxlength="35"></td>
  		</tr>
        <tr>
  <th>Mailing City</th>
  <td><input type="text" name="b_city" id="b_city" value="" size="40" maxlength="100" /></td>
  <th>Other City</th>
 <td><input type="text" name="O_city" id="O_city" value="" size="40" maxlength="100" /></td>
</tr>
<tr>
  <th>Mailing State/Province</th>
   <td><input type="text" name="b_state" id="b_state" value="" size="40" maxlength="100" /></td>
  <th>Other State/Province</th>
   <td><input type="text" name="O_state" id="O_state" value="" size="40" maxlength="100" /></td>
</tr>
<tr>
		    <th>Mailing Zip/Postal Code</th>
		    <td><input type="text" size="40" name="b_postalcode" id="b_postalcode" value="#getcust.postalcode#" maxlength="50"></td>
            <th>Other Zip/Postal Code</th>
			    <td><input type="text" size="40" name="O_postalcode" id="O_postalcode" value="#getcust.D_postalcode#" maxlength="50"></td>
		</tr>
        <tr>
		    <th>Mailing Country</th>
		    <td><input type="text" size="40" name="b_country" id="b_country" value="#getcust.country#" maxlength="50"></td>
            <th>Other Country</th>
			    <td><input type="text" size="40" name="O_country" id="O_country" value="#getcust.D_country#" maxlength="50"></td>
		</tr>

		
        
</table>
</cfoutput>
