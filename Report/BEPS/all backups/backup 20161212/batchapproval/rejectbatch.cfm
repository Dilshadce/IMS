<cfif isdefined('url.id')>
<cfoutput>
<cfquery name="getbatchdetail" datasource="#dts#">
SELECT * FROM argiro WHERE id = "#url.id#"
</cfquery>
<h3>Reject Batch #getbatchdetail.batchno#</h3>
<cfform name="rejectbatchform" id="rejectbatchform" action=" rejectprocess.cfm" method="post">
<input type="hidden" name="batchid" id="batchid" value="#url.id#">
<table align="center">
<tr>
<th align="center"><div align="center">Reject Reason</div></th>
</tr>
<tr>
<td align="center"><cfinput type="text" name="rejectbacthfield" id="rejectbatchfield" value="" size="80" required="yes" message="Reject Reason is Required!"></td>
</tr>
<tr>
<td align="center">
<input type="submit" name="sub_btn" id="sub_btn" value="REJECT">
</td>
</tr>
</table>
</cfform>
</cfoutput>
</cfif>