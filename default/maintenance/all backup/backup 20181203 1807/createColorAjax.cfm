<cfquery name="getgsetup" datasource="#dts#">
  select * from gsetup
</cfquery>

<cfform name="CreateCustomer" id="CreateCustomer" method="post" action="/default/maintenance/createColorAjaxProcess.cfm"> 
<table width="1000px" style="font-size:-2">
<cfoutput>
<tr>
<th width="200px" align="left">#getgsetup.lmaterial# No.</th>
<td>

<input type="text" size="40" name="Colorno" value="" maxlength="40">

</td>
</tr>
</cfoutput>
            <tr>
            <th align="left">Description</th>
            <td><cfinput type="text" name="desp" id="web_site" size="50" ></td>
            <td>&nbsp;</td>
</tr>
</table>
<cfinput name="SubmitButton" id="SubmitButton" type="submit" value="Submit"/>
</cfform>	
