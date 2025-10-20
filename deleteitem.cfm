<cfquery name="getitem" datasource="#dts#">
SELECT itemno,desp FROM ICITEM
</cfquery>
<cfoutput>
<form action="deleteitemprocess.cfm" method="post">
<table>
<cfloop query="getitem">
<tr>
<td><input type="checkbox" name="itemno" value="#getitem.itemno#" checked /></td>
<td>#getitem.itemno#</td>
<td>#getitem.desp#</td>
</tr>
</cfloop>
</table>
<input type="submit" name="submit" value="SUBMIT"  />
</form>
</cfoutput>