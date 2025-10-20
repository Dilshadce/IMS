<cfoutput>
<tr>
	<td>#getartran.type#</td>
	<td>#getartran.refno#</td>
	<td>#dateformat(getartran.wos_date,"dd/mm/yyyy")#</td>
	<cfset acctype = "D">	
	<cfset xaccno = getaccno.nbt>
	<td><div align="right">#numberformat(getartran.taxnbt,".__")#</div></td>
	<td></td>
	<td><div align="center">NBT</div></td>
	<td>#ceiling(getartran.fperiod)#</td>
	<td>#xaccno#</td>				
	<td>#acctype#</td>		
	<td nowrap>#getartran.name#</td>
</tr>
</cfoutput>