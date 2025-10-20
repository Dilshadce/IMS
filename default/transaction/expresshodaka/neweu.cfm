<cfoutput>
<h1>Create New Member</h1>
<cfform action="neweuprocess.cfm" method="post" id="euform" name="euform">
<table>
<tr>
<th>Member Id</th>
<td>:</td>
<td>
<cfinput type="text" name="memberid" id="memberid" required="yes" message="Member Id is Required" maxlength="20" size="35">
</td>
</tr>
<tr>
<th>Name</th>
<td>:</td>
<td>
<cfinput type="text" name="membername" id="membername" required="yes" message="Name is Required"  maxlength="40" size="35">
</td>
</tr>
<tr>
<th>Tel:</th>
<td>:</td>
<td>
<cfinput type="text" name="membertel" id="membertel" required="yes" message="Telephone is Required" maxlength="40" size="35">
</td>
</tr>
<tr>
<th>HP:</th>
<td>:</td>
<td>
<cfinput type="text" name="memberhp" id="memberhp" size="35" maxlength="40">
</td>
</tr>
<tr>
<th>Email:</th>
<td>:</td>
<td>
<cfinput type="text" name="memberemail" id="memberemail" size="35" maxlength="40">
</td>
</tr>
<tr>
<th>Address</th>
<td>:</td>
<td>
<cfinput type="text" name="memberadd1" id="memberadd1" size="45" maxlength="40">
</td>
</tr>
<tr>
<td></td>
<td></td>
<td>
<cfinput type="text" name="memberadd2" id="memberadd2" size="45" maxlength="40">
</td>
</tr>
<tr>
<td></td>
<td></td>
<td>
<cfinput type="text" name="memberadd3" id="memberadd3" size="45" maxlength="40">
</td>
</tr>
<tr>
<td colspan="3" align="center"><input type="submit" name="sub_btn" id="sub_btn" value="Create"></td>
</tr>
</table>
</cfform>
</cfoutput>