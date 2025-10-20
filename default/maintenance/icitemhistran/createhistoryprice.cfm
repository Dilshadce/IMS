
<cfoutput>
<cfform action="createhistorypriceprocess.cfm" method="post" name="createvouchersform">
<table width="500px">
<tr>
  <th>Price</th>
  <td colspan="2"><cfinput type="text" name="price" id="price" value="0.00" required="yes" /> <cfinput type="hidden" name="itemno" id="itemno" value="#url.itemno#"></td>
</tr>
<tr>
  <th>End Date</th>
  <td colspan="2"><cfinput type="text" name="enddate" id="enddate"  required="yes" validate="eurodate" message="End Date Format is wrong"/>&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(enddate);"> (DD/MM/YYYY)</td>
</tr>
<tr>
  <td>&nbsp;</td>
  <td><input type="submit" name="submit" value="Create" /></td>
  <td>&nbsp;</td>
</tr>
</table>
</cfform>
</cfoutput>