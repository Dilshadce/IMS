<h1>Please Enter the Password to Approve the Bill</h1>
<cfform name="approve" action="approvesoprocess.cfm" method="post"> 
<cfoutput>
<input type="hidden" name="billtype" id="billtype" value="#url.tran#">
<input type="hidden" name="refno" id="refno" value="#listfirst(url.refno)#">
<table align="center">
<tr>
<th>Refno : </th>
<td>#listfirst(url.refno)#</td>
</tr>
<!--- <tr><th>Password:</th><td><cfinput type="password" name="passwordString" id="passwordString" required="yes" message="Password is Required"/> </td></tr> --->
<tr><td colspan="2" align="center"><input type="submit" name="Submit" id="Submit" value="Approve" /></td></tr>
</table>
</cfoutput>
</cfform>

<cfform name="approve" action="approvesoprocess.cfm" method="post"> 
<cfoutput>
<input type="hidden" name="billtype" id="billtype" value="#url.tran#">
<input type="hidden" name="refno" id="refno" value="#listfirst(url.refno)#">
<table align="center">
<!--- <tr><th>Password:</th><td><cfinput type="password" name="passwordString" id="passwordString" required="yes" message="Password is Required"/> </td></tr> --->
<tr><td colspan="2" align="center"><input type="submit" name="Submit" id="Submit" value="Reject" /></td></tr>
</table>
</cfoutput>
</cfform>

