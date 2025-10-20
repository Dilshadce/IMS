<h1>Change Tax Code</h1>
<cfquery name="gettax" datasource="#dts#">
SELECT * from #target_taxtable#
</cfquery>
<cfoutput>
<form action="process.cfm" method="post">
<table>
<tr>
<th>Change From</th>
<td>
<select name="frmtax">
<option value="">Please Select a Tax</option>
<cfloop query="gettax">
<option value="#gettax.code#">#gettax.code# - #gettax.desp#</option>
</cfloop>
</select>
</td>
</tr>
<tr>
<th>Change To</th>
<td>
<select name="totax">
<option value="">Please Select a Tax</option>
<cfloop query="gettax">
<option value="#gettax.code#">#gettax.code# - #gettax.desp#</option>
</cfloop>
</select>
</td>
</tr>
<tr>
<td><input type="submit" value="submit" /></td>
</tr>
</table>
</form>
</cfoutput>