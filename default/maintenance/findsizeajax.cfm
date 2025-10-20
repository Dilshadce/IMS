<cfsetting showdebugoutput="no">
<cfquery name='getgsetup' datasource='#dts#'>
  Select lsize from gsetup
</cfquery>
<cfoutput>
<table width="450px">
<tr>
<th>#getgsetup.lsize#</th>
<th>Desp</th>
<th>Action</th>
</tr>
<cfquery name="getsize" datasource="#dts#">
SELECT * FROM icsizeid <cfif url.searchtype neq ""> WHERE sizeid like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#URLDECODE(url.searchtype)#%"> or desp like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#URLDECODE(url.searchtype)#%"> or size1 like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#URLDECODE(url.searchtype)#%"></cfif> order by sizeid limit 1000
</cfquery>
<cfloop query="getsize">
<tr>
<td>#getsize.sizeid#</td>
<td>#getsize.desp#</td>
<td><a style="cursor:pointer" onClick="document.getElementById('SIZEID').value='#getsize.sizeid#';document.getElementById('Remark5').value='#getsize.size1#';ColdFusion.Window.hide('findsizewindow');">SELECT</a></td>
</tr>
</cfloop>
</table>
</cfoutput>