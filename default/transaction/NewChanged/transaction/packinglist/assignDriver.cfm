<cfset packid = url.packid>

<cfquery name="getDriver" datasource="#dts#">
SELECT * FROM driver
</cfquery>
<cfoutput>
<h1>ASSIGN DRIVER FOR #packid#</h1>

<cfform action="/default/transaction/packinglist/assignDriverAjaxProcess.cfm" method="post">
<input type="hidden" name="packID" id="packID" value="#packid#">
<table width="400px">
<tr>
<th>DRIVER</th>
<td>:</td>
<td>
<select name="driver" id="driver">
<cfloop query="getDriver">
<option value="#getDriver.DRIVERNO#">#getDriver.DRIVERNO#-#getDriver.NAME#</option>
</cfloop>
</select>
</td>
</tr>
<tr>
<th>DELIVERY DATE</th>
<td>:</td>
<td>
<input type="text" id="deliverydate" name="deliverydate" value="#dateformat(now(),'dd/mm/yyyy')#" >&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(deliverydate);">&nbsp;(DD/MM/YYYY)
</td>
</tr>
<tr>
<th>TRIP</th>
<td>:</td>
<td>
<input type="text" id="trip" name="trip" value="">
</td>
</tr>
<tr>
<td></td>
<td></td>
<td><input type="submit" name="ASSIGN" id="ASSIGN" value="ASSIGN" ></td>
</tr>
</table>
</cfform>
</cfoutput>