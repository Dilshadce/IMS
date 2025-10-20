<cfquery name="getgsetup" datasource="#dts#">
  select * from gsetup
</cfquery>

<cfform name="CreateCustomer" id="CreateCustomer" method="post" action="/default/maintenance/createSizeAjaxProcess.cfm"> 
<table width="500px" style="font-size:-2">
<cfoutput>
<tr>
<th width="200px" align="left">#getgsetup.lsize# No.</th>
<td>

<cfinput type="text" size="40" name="Sizeno" value="" maxlength="40" required="yes" message="#getgsetup.lsize# Required">

</td>
</tr>
</cfoutput>
            <tr>
            <th align="left">Description</th>
            <td><cfinput type="text" name="desp" id="web_site" size="50" ></td>
            <td>&nbsp;</td>
</tr>
<cfif left(dts,4) eq "tcds">
<tr>
<th align="left">Keywords</th>
<td>
<input type="text" name="size1" id="size1" value="" />
</td>
</tr>
</cfif>

</table>
<cfinput name="SubmitButton" id="SubmitButton" type="submit" value="Submit"/>
</cfform>	
