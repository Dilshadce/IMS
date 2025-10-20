<cfquery name='getgsetup' datasource='#dts#'>
  Select lsize from gsetup
</cfquery>
<cfoutput>
<table width="450">
<tr>
<th>Search</th>
<td><input type="text" id="sizesearch" name="sizesearch" value="" size="50" onBlur="ajaxFunction(document.getElementById('sizesearchfield'),'findsizeajax.cfm?searchtype='+escape(encodeURI(this.value)));" />&nbsp;&nbsp;<input type="button" name="searchbtn" id="searchbtn" value="Go" onClick="ajaxFunction(document.getElementById('sizesearchfield'),'findsizeajax.cfm?searchtype='+escape(encodeURI(document.getElementById('sizesearch').value)));"></td>
</tr>
<tr>
<td colspan="2">
<div id="sizesearchfield">
<table width="100%">
<tr>
<th>#getgsetup.lsize#</th>
<th>Desp</th>
<th>Action</th>
</tr>
<cfquery name="getsize" datasource="#dts#">
SELECT * FROM icsizeid order by sizeid limit 100
</cfquery>
<cfloop query="getsize">
<tr>
<td>#getsize.sizeid#</td>
<td>#getsize.desp#</td>
<td><a style="cursor:pointer" onClick="document.getElementById('SIZEID').value='#getsize.sizeid#';document.getElementById('Remark5').value='#getsize.size1#';ColdFusion.Window.hide('findsizewindow');">SELECT</a></td>
</tr>
</cfloop>
</table>
</div>
</td>
</tr>
</table>
</cfoutput>