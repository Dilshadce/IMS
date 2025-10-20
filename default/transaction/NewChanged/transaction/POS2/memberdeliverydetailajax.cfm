<cfsetting showdebugoutput="no">
<cfquery name="getdriverdetail" datasource="#dts#">
select * from driver where driverno='#url.member#'
</cfquery>

<cfoutput>
<cfif url.detail eq '1'>
<table align="center">
<tr>
<th>Delivery Tel</th>
<td>
<input type="text" name="Dmembertel" id="Dmembertel" value="#getdriverdetail.Dcontact#" maxlength="35" size="40"></td>
</tr>
<tr>
<th>Address</th>
<td>
<input type="text" name="Dmemberadd1" id="Dmemberadd1" value="#getdriverdetail.Dadd1#" maxlength="35" size="40"></td>
</tr>
<tr>
<th></th>
<td>
<input type="text" name="Dmemberadd2" id="Dmemberadd2" value="#getdriverdetail.Dadd2#" maxlength="35" size="40"></td>
</tr>
<tr>
<th></th>
<td>
<input type="text" name="Dmemberadd3" id="Dmemberadd3" value="#getdriverdetail.Dadd3#" maxlength="35" size="40"></td>
</tr>
</table>
<cfelse>
<table>
<tr>
<td></td>
<td>
</td>
</tr>
<tr>
<td></td>
<td>
<input type="hidden" name="Dmembertel" id="Dmembertel" value="" maxlength="35">

</td>
</tr>
<tr>
<td></td>
<td>
<input type="hidden" name="Dmemberadd1" id="Dmemberadd1" value="" maxlength="35">
</td>
</tr>
<tr>
<td></td>
<td>
<input type="hidden" name="Dmemberadd2" id="Dmemberadd2" value="" maxlength="35">
</td>
</tr>
<tr>
<td></td>
<td>
<input type="hidden" name="Dmemberadd3" id="Dmemberadd3" value="" maxlength="35">
</td>
</tr>
</table>
</cfif>
</cfoutput>
