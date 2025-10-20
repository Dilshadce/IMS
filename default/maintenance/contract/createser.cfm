<cfform name="createsev" action="createserprocess.cfm" method="post">
<table>
<tr>
<th>Service Agreement Code</th>
<td>:</td>
<td><cfinput type="text" name="sercode" id="sercode" required="yes" /></td>
</tr>
<tr>
<th>Agreement Description</th>
<td>:</td>
<td>
<cftextarea name="serdesp" id="serdesp" cols="40" rows="3" >
</cftextarea>
</td>
</tr>
<tr>
<th>
Validity Start
</th>
<td>:</td>
<td><cfinput type="text" name="validstart" id="validstart" />&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(validstart);"> (DD/MM/YYYY)</td>
</tr>
<tr>
<th>
Validity End
</th>
<td>:</td>
<td><cfinput type="text" name="validend" id="validend" />&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(validend);"> (DD/MM/YYYY)</td>
</tr>

<tr>
<th>Group Type</th>
<td>:</td>
<td>
<cfoutput><cfselect id="modebill" name="modebill">
<cfquery name="getgroup" datasource="#dts#">
select groupID,desp,recurrtype from recurrgroup
</cfquery>
<option value="">Please choose a group</option>
<cfloop query="getgroup">
<option value="#desp#">#desp# - #recurrtype# Month</option>
</cfloop>
</cfselect></cfoutput></td>
</tr>
<tr>
<td colspan="3" align="center"><cfinput type="submit" name="submitbtn" value="Create" /></td>
</tr>
</table>
</cfform>