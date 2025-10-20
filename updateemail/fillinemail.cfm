<cfoutput>
<h3>Dear Valued Customers,</h3>
<h4>Please update your email address into our system to have notification email send to your email address for any notice of update and maintenance in future.</h4>

<cfform name="updateemailform" id="updateemailform" action="/updateemail/updateemailprocess.cfm" method="post">
<table align="center">
<tr>
<th>Email Address : </th>
<td><cfinput type="text" name="updateemailladdress" id="updateemailaddress" validate="email" validateat="onsubmit" size="40" message="Email Address is Invalid"> </td>
</tr>
<tr>
<td colspan="2" align="center"><input type="submit" name="submitbutton" id="submitbutton" value="Save">&nbsp;&nbsp;&nbsp;<input type="button" name="skipbutton" id="skipbutton" value="Skip" onClick="ColdFusion.Window.hide('updateemail');"></td>
</tr>
</table>
</cfform>
<h4>Thank you and have a nice day!</h4>

<h3>Best Regards,<br>

Netiquette</h3>
</cfoutput>