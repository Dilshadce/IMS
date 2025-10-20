<h2>Last 10 Transaction Entry</h2>
<cfquery name="getlast" datasource="#dts#">
SELECT uuid,trdatetime,type from ictrantemp group by uuid order by trdatetime desc limit 10 
</cfquery>
<cfoutput>
<table>
<tr>
<td>
<select name="oldlist" id="oldlist">
<cfloop query="getlast">
<option value="#getlast.uuid#">#getlast.type#-#dateformat(getlast.trdatetime,'YYYY-MM-DD')# #timeformat(getlast.trdatetime,'HH:MM:SS')#</option>
</cfloop>
</select>
</td>
</tr>
<tr>
<td>
<input type="button" name="btngo" value="Revert Back" onclick="revertback()" />
</td>
</tr>
</table>
</cfoutput>