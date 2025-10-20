<cfset packid = URLDECODE('#url.packid#')>
<cfset datepacked = URLDECODE('#url.datepacked#')>
<cfset driver = URLDECODE('#URL.driver#')>
<cfset datepacked = REPLACE(datepacked,'/','-','ALL') >
<cfset dateyear = right(datepacked,4)>
<cfset datemonth = mid(datepacked,4,2)>
<cfset datedate = left(datepacked,2)>

<cfquery name="getPackList" datasource="#dts#">
SELECT * from packlist 
WHERE 
<cfif packid neq "">
PACKID like "%#packid#%" and 
</cfif>
<cfif datepacked neq "">
created_on like "%#dateyear#-#datemonth#-#datedate#%" and
</cfif>
<cfif driver neq "">
driver like "%#driver#%" and
</cfif>
1=1
order by created_on desc,updated_on desc limit 20
</cfquery>
<cfoutput>
<table class="data" align="center">
<cfloop query="getPackList">

<tr onMouseOver="javascript:this.style.backgroundColor='99FF00';setID('#getPackList.packID#');" onMouseOut="javascript:this.style.backgroundColor='';">
<td align="left" width="100px">#getPackList.packID#</td>
<cfif getPackList.Created_on lt getPackList.updated_on >
<cfset datepacked = getPackList.updated_on>
<cfelse>
<cfset datepacked = getPackList.Created_on>
</cfif>
<td align="left" width="150px">#dateformat(datepacked,'yyyy-mm-dd')#-#timeformat(datepacked,'HH:MM')#</td>
<cfif getPackList.updated_by neq "">
<cfset packedby = getPackList.updated_by>
<cfelse>
<cfset packedby = getPackList.created_by>
</cfif>
<td align="left" width="100px">#packedby#</td>
<cfif getPackList.driver eq "">
<cfset driverlist = "Not Yet Assign">
<cfelse>
<cfset driverlist = getPackList.driver>
</cfif>
<td align="left" width="100px">#driverlist#</td>
<td align="left" width="100px">#dateformat(getPackList.delivery_on,'yyyy-mm-dd')#</td>
<td align="left" width="200px">
<table>
<tr>
<td align="center" width="30px"><cfif driverlist eq "Not Yet Assign"><a onMouseOver="style.cursor='hand'" onclick="javascript:ColdFusion.Window.show('assigndriver');"><img src="/images/wheel.gif" width="20px" height="20px" /><br/>DRIVER</a></cfif></td>
<td align="center" width="30px"><cfif driverlist eq "Not Yet Assign"><a onMouseOver="style.cursor='hand'" onclick="javascript:ColdFusion.Window.show('editPackList');"><img src="/images/edit.ico" width="20px" height="20px"  /><br />EDIT</a></cfif></td>
<td align="center" width="30px"><a href="/default/transaction/packinglist/printpackinglist.cfm?packno=#URLEncodedFormat(getPackList.packID)#" target="_blank"><img src="/images/printRpt.gif" width="20px" height="20px" /><br/>Print</a></td>
<td align="center" width="30px"><a onMouseOver="style.cursor='hand'" onClick="deletePackList('#getPackList.packID#')" /><img src="/images/delete.ico" width="20px" height="20px" /><br/>DELETE</a></td>
</tr>
</table>
</td></tr>
</cfloop>
</table>
</cfoutput>
