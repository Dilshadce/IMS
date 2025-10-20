<cfoutput>
<cfform name="changeserialform" id="changeserialform" method="post" action="changeserialprocess.cfm?tran=#url.tran#&nexttranno=#url.nexttranno#&trancode=#url.trancode#">
<table>
<tr>
<th>Old Serial No</th>
<td>#url.serialno#
<cfinput type="hidden" name="oldserialno" id="oldserialno" value="#url.serialno#" required="yes" message="Serialno is Required" />
</td>
</tr>
<tr>
<th>New Serial No</th>
<td><cfinput type="text" name="changeserialno1" id="changeserialno1" value="#url.serialno#" required="yes" message="Serialno is Required" /></td>
</tr>
<tr>
<td colspan="2">
<input type="submit" name="sub_btn" id="sub_btn" value="Update" />
</td>
</tr>
</table>

</cfform>
</cfoutput>
