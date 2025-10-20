<cfquery name="getgsetup" datasource="#dts#">
  select * from gsetup
</cfquery>

<cfform name="CreateCustomer" id="CreateCustomer" method="post" action="/default/transaction/createProjectAjaxProcess.cfm"> 
<table width="1000px" style="font-size:-2">
<tr>
<th width="200px" align="left"><cfoutput>#getgsetup.lproject#</cfoutput> No.</th>
<td>
<cfoutput>
<input type="text" size="20" name="Projectno" value="" maxlength="20">
</cfoutput>
</td>
</tr>
            <tr>
            <th align="left">Description</th>
            <td><cfinput type="text" name="desp" id="web_site" size="50" ></td>
            <td>&nbsp;</td>
</tr>
</table>
<cfinput name="SubmitButton" id="SubmitButton" type="submit" value="Submit"/>
</cfform>	
