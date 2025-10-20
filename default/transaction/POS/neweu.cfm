<cfoutput>
<h1>Create New Member</h1>
<cfform action="neweuprocess.cfm" method="post" id="euform" name="euform">
<table>
<tr>
<th>Member Id</th>
<td>:</td>
<td>
<cfinput type="text" name="memberid" id="memberid" required="yes" message="Member Id is Required" maxlength="8" size="35">
</td>
</tr>
<tr>
<th>Name</th>
<td>:</td>
<td>
<cfinput type="text" name="membername" id="membername" required="yes" message="Name is Required" maxlength="40" size="35">
</td>
</tr>
<tr>
<th>Tel:</th>
<td>:</td>
<td>
<cfinput type="text" name="membertel" id="membertel" required="yes" message="Telephone is Required" maxlength="35" size="35">
</td>
</tr>
<tr>
<th>Handphone:</th>
<td>:</td>
<td>
<cfinput type="text" name="memberhp" id="memberhp" required="yes" message="Handphone is Required" maxlength="35" size="35">
</td>
</tr>
<tr>
<th>Address</th>
<td>:</td>
<td>
<cfinput type="text" name="memberadd1" id="memberadd1" size="45"  maxlength="35">
</td>
</tr>
<tr>
<td></td>
<td></td>
<td>
<cfinput type="text" name="memberadd2" id="memberadd2" size="45"  maxlength="35">
</td>
</tr>
<tr>
<td></td>
<td></td>
<td>
<cfinput type="text" name="memberadd3" id="memberadd3" size="45"  maxlength="35">
</td>
</tr>
<tr>
<th>IC No</th>
<td>:</td>
<td>
<cfinput type="text" name="membericno" id="membericno" size="20"  maxlength="20">
</td>
</tr>
<tr>
<th>Date of Birth</th>
<td>:</td>
<td>
<cfinput type="text" name="memberdob" id="memberdob" size="10"  maxlength="10" validate="eurodate" message="Invalid Date Format">
<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('memberdob'));">&nbsp;(DD/MM/YYYY)
</td>
</tr>
<tr>
<td colspan="3" align="center"><input type="submit" name="sub_btn" id="sub_btn" value="Create"></td>
</tr>
</table>
</cfform>
</cfoutput>