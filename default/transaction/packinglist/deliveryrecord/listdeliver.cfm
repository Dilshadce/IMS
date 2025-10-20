<cfquery name="getpackbill" datasource="#dts#">
SELECT * FROM packlistbill WHERE packid = "#url.packid#" 
and (delivered_on = "0000-00-00" or delivered_on is null)
and (delivered_by = "" or delivered_by is null)
</cfquery>
<cfform action="deliveredpro.cfm" method="post">
<cfoutput>
<input type="hidden" name="packid" value="#url.packid#">
<table>
<tr>
<th>DELIVERED DATE</th>
<td>:</td>
<td><input type="text" id="deliverydate" name="deliverydate" value="#dateformat(now(),'dd/mm/yyyy')#" >&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(deliverydate);">&nbsp;(DD/MM/YYYY)</td>
</tr>
</table>
</cfoutput>
<table>
<tr>
<th width="50px">Bill Type</th>
<th width="100px">Bill Refno</th>
<th width="50px">Delivered</th>
<th width="50px">Unassign</th>
</tr>
<cfoutput query="getpackbill">
<tr>
<td>#getpackbill.reftype#</td>
<td>#getpackbill.billrefno#</td>
<td><input type="checkbox" name="delrefno" id="delrefno#getpackbill.packlistbillid#" value="#getpackbill.packlistbillid#" onclick="vericheck('delrefno','unrefno','#getpackbill.packlistbillid#')" /></td>
<td><input type="checkbox" name="unrefno" id="unrefno#getpackbill.packlistbillid#" value="#getpackbill.packlistbillid#" onclick="vericheck('unrefno','delrefno','#getpackbill.packlistbillid#')" /></td>
</tr>
</cfoutput>
<tr>
<td colspan="4" align="center">
<input type="submit" name="create" value="Save" />
</td>
</tr>
</table>
</cfform>