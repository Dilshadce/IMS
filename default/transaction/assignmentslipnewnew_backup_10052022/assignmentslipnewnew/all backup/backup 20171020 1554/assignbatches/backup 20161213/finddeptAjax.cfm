<cfoutput> <cfquery name="getdept" datasource="#dts#">
 SELECT department FROM placement WHERE department <> "" and department like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.searchval#%"> GROUP by department Order By department
 </cfquery>
<table width="90%">
<tr>
<th>Department</th>
<th>Action</th>
</tr>
<cfloop query="getdept">
<tr>
<td>#getdept.department#</td>
<td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="selectlist('#getdept.department#','dept#url.fromto#');ColdFusion.Window.hide('finddept');"><u>SELECT</u></a></td>
</tr>
</cfloop>
</table>
</cfoutput>