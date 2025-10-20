<cfif isdefined('url.id')>
<cfoutput>
<cfquery name="getdate" datasource="#dts#">
SELECT  contractenddate FROM leavelisttemp WHERE uuid = "#url.uuid#" and id = "#url.id#"
</cfquery>

<cfform name="changedate" id="changedate" method="post" action="editdateprocess.cfm?uuid=#url.uuid#">
<input type="hidden" name="oldid" id="oldid" value="#url.id#" />
<table>
<tR>
<th>Current Contract End Date</th>
<td>#dateformat(getdate.contractenddate,'dd/mm/yyyy')#</td>
</tR>
<tr>
<th>New Contract End Date</th>
<td>
<cfinput type="text" name="newcontractenddate" id="newcontractenddate" value="#dateformat(getdate.contractenddate,'dd/mm/yyyy')#" required="yes" message="New Contract End Date is Required" />&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('newcontractenddate'));">
</td>
<tr>
<td colspan="2" align="center">
<cfinput type="submit" name="sub_btn" id="sub_btn" value="Save" />
</td>
</tr>
</tr>
</table>
</cfform>
</cfoutput>
</cfif>