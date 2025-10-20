<cfsetting showdebugoutput="no">
<cfquery name="getdriverdetail" datasource="#dts#">
select * from driver where driverno='#url.member#'
</cfquery>

<cfoutput>
<cfif url.detail eq '1'>
<table align="center">
<tr>
<th>Member Name</th>
<td><input type="text" name="membername" id="membername" value="#getdriverdetail.name#" maxlength="35" size="40"/></td>
</tr>
<tr>
<th>Tel</th>
<td>
<input type="text" name="membertel" id="membertel" value="#getdriverdetail.contact#" maxlength="35" size="40"></td>
</tr>
<tr>
<th>Address</th>
<td>
<input type="text" name="memberadd1" id="memberadd1" value="#getdriverdetail.add1#" maxlength="35" size="40"></td>
</tr>
<tr>
<th></th>
<td>
<input type="text" name="memberadd2" id="memberadd2" value="#getdriverdetail.add2#" maxlength="35" size="40"></td>
</tr>
<tr>
<th></th>
<td>
<input type="text" name="memberadd3" id="memberadd3" value="#getdriverdetail.add3#" maxlength="35" size="40"></td>
</tr>
</table>
<cfelse>
<table>
<tr>
<td></td>
<td>
<input type="hidden" name="membername" id="memebername" value="" maxlength="35">
</td>
</tr>
<tr>
<td></td>
<td>
<input type="hidden" name="membertel" id="membertel" value="" maxlength="35">

</td>
</tr>
<tr>
<td></td>
<td>
<input type="hidden" name="memberadd1" id="memberadd1" value="" maxlength="35">
</td>
</tr>
<tr>
<td></td>
<td>
<input type="hidden" name="memberadd2" id="memberadd2" value="" maxlength="35">
</td>
</tr>
<tr>
<td></td>
<td>
<input type="hidden" name="memberadd3" id="memberadd3" value="" maxlength="35">
</td>
</tr>
</table>
</cfif>
</cfoutput>
