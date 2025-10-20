<cfform name="showexpire" action="" method="">
<cfoutput>
<cfset edate=dateformat(dateadd('yyyy',1,now()),'YYYY/MM/DD')>

<cfquery name="getexpire2" datasource="#dts#">
select * from serviceagree where validend < '#edate#'
</cfquery>
<table border="1">
<tr>
<td colspan="6" align="center">Service Agreement that are going to expire in 1 month
</td>
</tr>
<tr>
<td width="16%">Service Code</td>
<td width="20%">Description</td>
<td width="16%">Validity Start</td>
<td width="16%">Validity End</td>
<td width="16%">Group</td>
<td width="16%">Created By</td>
</tr>
<cfloop query="getexpire2">
<tr>
<td>#servicecode#</td>
<td>#desp#</td>
<td>#dateformat(validstart,'dd/mm/yyyy')#</td>
<td>#dateformat(validend,'dd/mm/yyyy')#</td>
<td>#modebill#</td>
<td>#created_by#</td>
</tr>
</cfloop>
<tr>
<td colspan="6" align="center"><cfinput type="button" name="button" id="button" value="Close" onClick="closeexp();"></td>
</tr>
</table>
</cfoutput>
</cfform>