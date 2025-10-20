<cfif isdefined('form.updateemailladdress')>
<cfquery name="updateemail" datasource="main">
UPDATE users SET useremail = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.updateemailladdress)#"> WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getauthuser()#">
</cfquery>
<cfoutput>
<cfquery name="get_gsetup" datasource="#dts#">
	select lastaccyear,period from gsetup
</cfquery>
<cfform name="yearendform2" id="yearendform2" action="/checkyearend/confirmperiod.cfm" method="post" onsubmit="return confirm('Are you sure you would like to close for '+document.getElementById('periodmonth').value+' months? An email of checking result will be send to #form.updateemailladdress#. Please kindly double confirm your email address!')">
<input type="hidden" name="emailadd" id="emailadd" value="#form.updateemailladdress#">
<br>
<br>
<br>
<h4>Please kindly confirm how many months you would like to close?</h4>
<br>
<br>

<table align="center">
<tr>
<th>Email Address : </th>
<td>#form.updateemailladdress#</td>
</tr>
<tr>
<th>Current Financial Start Date : </th>
<td>#dateformat(dateadd('d',1,get_gsetup.lastaccyear),'YYYY-MMMM-DD')#</td>
</tr>
<tr>
<th>Closing Months : </th>
<td><select name="periodmonth" id="periodmonth" onChange="ajaxFunction(document.getElementById('ajfield'),'/checkyearend/changedate.cfm?period='+this.value);">
<cfloop from="1" to="18" index="i">
<option value="#i#" <cfif i eq "12">selected</cfif>>#i#</option>
</cfloop>
</select></td>
</tr>
<tr>
<th>New Financial Start Date : </th>
<td><div id="ajfield">#dateformat(dateadd('m',12,dateadd('d',1,get_gsetup.lastaccyear)),'YYYY-MMMM-DD')#</div></td>
</tr>
<tr>
<td colspan="2" align="center"><input type="submit" name="submitbutton" id="submitbutton" value="Click Here Proceed To Year End Checking">
</tr>
</table>
</cfform>
</cfoutput>
</cfif>