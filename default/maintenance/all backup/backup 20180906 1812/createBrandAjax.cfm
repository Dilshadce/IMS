<cfquery name="getgsetup" datasource="#dts#">
  select * from gsetup
</cfquery>

<cfform name="CreateCustomer" id="CreateCustomer" method="post" action="/default/maintenance/createBrandAjaxProcess.cfm"> 
<table width="1000px" style="font-size:-2">
<tr>
<th width="200px" align="left"><cfoutput>#getgsetup.lbrand#</cfoutput> No.</th>
<td>
<cfoutput>
<input type="text" size="40" name="Brandno" value="" maxlength="40">
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
