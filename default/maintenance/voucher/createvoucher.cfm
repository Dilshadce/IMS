
<cfoutput>
<cfform action="createvoucherprocess.cfm" method="post" name="createvouchersform" onsubmit=" return validateform()" >
<table width="500px">
<tr>
<th rowspan="4" width="100px">Voucher No</th>
<th width="150px">Prefix :</th>
<td><input type="text" name="prefix" id="prefix" value="" size="5" /></td>
</tr>
<tr>
<th>Running Number From :</th>
<td><cfinput type="text" name="runningnumfr" id="runningnumfr" value="" size="10" /></td>
</tr>
<tr>
<th>Running Number To :</th>
<td><cfinput type="text" name="runningnumto" id="runningnumto" value="" size="10"/></td>
</tr>
<tr>
<th>End Fix :</th>
<td><input type="text" name="endfix" id="endfix" size="5" /></td>
</tr>
<tr>
  <th>Voucher Type</th>
  <td>
  <select name="type" id="type" >
  <option value="Value">Value</option>
  <option value="Percent">Percent</option>
  </select>  </td>
  <td>&nbsp;</td>
</tr>
<tr>
  <th>Description</th>
  <td colspan="2"><input type="text" name="desp" id="desp" size="30" /> </td>
</tr>
<tr>
  <th>Amount</th>
  <td colspan="2"><cfinput type="text" name="value" id="value" /></td>
</tr>
<tr>
<th>Customer</th>
<td colspan="2">
<cfquery name="getcust" datasource="#dts#">
SELECT "" as custno, "Choose a Customer" as name
UNION ALL
SELECT custno, concat(custno,' - ',name) as name
FROM #target_arcust# order by custno
</cfquery>
<cfselect query="getcust" name="custno" id="custno" value="custno" display="name"></cfselect>
</td>
</tr>
<tr>
  <td>&nbsp;</td>
  <td><input type="submit" name="submit" value="Create" /></td>
  <td>&nbsp;</td>
</tr>
</table>
</cfform>
</cfoutput>