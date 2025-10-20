<cfdirectory action="list" directory="#HRootPath#\download\#dts#" name="file_list" filter="*.zip" >
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<cfoutput>
<table>
<tr >
<th width="320px">File Name</th>
<th width="60px">Size</th>
<th width="150px">Date Modified</th>
</tr>
<cfloop query="file_list">
<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
<td><a href="downloadfile.cfm?filename=#URLENCODEDFORMAT(file_list.name)#" target="_blank">#file_list.name#</a></td>
<td>#numberformat(file_list.size/1000,'0')# KB</td>
<td>#dateformat(file_list.dateLastModified,'YYYY-MM-DD')# #timeformat(file_list.dateLastModified,'HH:MM:SS')#</td>
</tr>
</cfloop>
</table>
</cfoutput>