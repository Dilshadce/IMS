<cfquery name="getformat" datasource="#dts#">
select * from customized_format where type='#url.tran#'
</cfquery>

<cfoutput>

<form name="emailformat" action="/billformat/#dts#/preprintedformatemail.cfm?tran=#url.tran#&nexttranno=#url.nexttranno#" method="post">
<table align="center">
<tr><th>Format</th><td>
<select name="billname" id="billname">
<cfloop query="getformat">
<option value="#getformat.FILE_NAME#">#getformat.display_name#</option>
</cfloop>
</select>
</td></tr>
<tr><td align="center" colspan="2"><input type="submit" name="submit" id="submit" value="Submit" /></td></tr>


</table>
</form>

</cfoutput>