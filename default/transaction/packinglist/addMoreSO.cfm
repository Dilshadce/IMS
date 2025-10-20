<cfset packid = url.packid>
<cfquery name="getPackId" datasource="#dts#">
SELECT * from packlist where packid = "#packid#"
</cfquery>
<cfoutput>
<cfquery name="getSO" datasource="#dts#">
SELECT refno from artran where type = "#getPackId.reftype#" and PACKED <> "Y" order by refno ASC
</cfquery>

<h1>Add More #getPackId.reftype#</h1>
</cfoutput>
<cfoutput>
<table width="200px">
<th width="30px"> #getPackId.reftype# :</th>
<td width="100px">
<select name="addSO" id="addSO">
<option value="">SELECT a #reftype#</option>
<cfloop query="getSO">
<option value = "#getSO.refno#">#getSO.refno#</option>
</cfloop>
</select></td>
<td width="70px"><input type="button" name="addSOBtn" id="addSOBtn" value="ADD" onClick="addSo();" ></td>
</table>
</cfoutput>