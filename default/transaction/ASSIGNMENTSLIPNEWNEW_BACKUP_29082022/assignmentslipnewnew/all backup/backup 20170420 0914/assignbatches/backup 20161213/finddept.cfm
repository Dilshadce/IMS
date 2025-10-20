<cfoutput>
Department : <input type="text" name="department" id="department" value="" onkeyup="ajaxFunction(document.getElementById('ajaxfield2'),'finddeptAjax.cfm?fromto=#url.fromto#&searchval='+this.value)" />
<div id="ajaxfield2">
 <cfquery name="getdept" datasource="#dts#">
 SELECT department FROM placement WHERE department <> "" GROUP by department Order By department
 </cfquery>
<table width="90%">
<tr>
<th>Department</th>
<th>Action</th>
</tr>
<cfloop query="getdept">
<tr>
<td>#getdept.department#</td>
<td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="selectlist('#getdept.department#','dept#url.fromto#');<cfif url.fromto eq "from">selectlist('#getdept.department#','deptto');</cfif>ColdFusion.Window.hide('finddept');"><u>SELECT</u></a></td>
</tr>
</cfloop>
</table>
</div>
</cfoutput>