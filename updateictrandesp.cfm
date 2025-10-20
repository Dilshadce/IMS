<cfform name="changedesp" action="updatepro.cfm" method="post">
<table>
<tr>
<th>ITEMNO</th><td><cfinput type="text" name="itemno" id="itemno" /></td>
</tr>
<tr>
<th>DESP</th>
<td>
<cfinput type="text" name="desp" id="desp" />
</td>
</tr>
<tr>
<td colspan="2">
<input type="submit" name="update" value="Update" />
</td>
</tr>
</table>
</cfform>