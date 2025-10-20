<cfoutput>
<tr>
	<td>#getartran.type#</td>
	<td>#getartran.refno#</td>
	<td>#dateformat(getartran.wos_date,"dd/mm/yyyy")#</td>

	<cfif getartran.type eq "RC" or getartran.type eq "CN" or getartran.type eq "PR">
		<cfset acctype = "D">			
		
		<cfif getartran.type eq "RC" or getartran.type eq "PR">
			<cfset xaccno = getaccno.gstpurchase>				
		<cfelse>
			<cfset xaccno = getaccno.gstsales>
		</cfif>
		<td><div align="right">#numberformat(variables.gst_item_value,".__")#</div></td>
		<td></td>
	<cfelse>
		<cfset acctype = "Cr">
		<cfset xaccno = getaccno.gstsales>
		<td></td>
		<td><div align="right">#numberformat(variables.gst_item_value,".__")#</div></td>
	</cfif>
	
	<td><div align="center">GST</div></td>
	<td>#ceiling(getartran.fperiod)#</td>
	<td>#xaccno#</td>
	<td>#acctype#</td>
	<td nowrap>#getartran.name#</td>
</tr>
</cfoutput>