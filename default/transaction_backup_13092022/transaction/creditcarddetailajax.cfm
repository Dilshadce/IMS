<cfquery name="getcreditcarddetail" datasource="#dts#">
select rem46,rem47,rem48,rem49 from artran where refno='#url.refno#' and type='#url.type#'
</cfquery>
<cfoutput>
<cfform action="creditcarddetailajaxprocess.cfm" method="post" name="ccform"  id="ccform">
<table width="570px" >
<input type="hidden" name="ccbillrefno" id="ccbillrefno" value="#url.refno#">
<input type="hidden" name="ccbilltype" id="ccbilltype" value="#url.type#">
<tr>
<td>
Card Name
</td>
<td>:</td>
<td><cfinput type="text" name="cardname2" id="cardname2" value="#getcreditcarddetail.rem47#" size="50" /></td>
</tr>
<tr>
<td>
Card No
</td>
<td>:</td>
<td><cfinput type="text" name="cardno2" id="cardno2" value="#getcreditcarddetail.rem48#" size="50" mask="9999-9999-9999-9999"  maxlength="19"/></td>
</tr>
<tr>
<td>
Card Issuer(Bank Name)
</td>
<td>:</td>
<td><cfinput type="text" name="cardissue2" id="cardissue2" value="#getcreditcarddetail.rem46#" size="50" /></td>
</tr>

<tr>
<td>
Expiry Date
</td>
<td>:</td><td><cfinput type="text" name="expirydate2" id="expirydate2" value="#getcreditcarddetail.rem49#" mask="99/99" size="10" onBlur="checkdate('expirydate2');"/></td>
</tr>
<tr>
<td colspan="100%"><input type="submit" name="sub_btn" id="sub_btn" value="Edit" /></td>
</tr>
</tr>

</table>
</cfform>

</cfoutput>