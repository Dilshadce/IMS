<cfquery name="get_cash_code" datasource="#dts#">
	select 
	cashaccount
	from gsetup;
</cfquery>

<cfoutput>
<cfif val(getartran.cs_pm_cash) neq 0 and (get_cash_code.cashaccount neq "" and get_cash_code.cashaccount neq "0000/000")>
	<tr>
		<td>#getartran.type#</td>
		<td>#getartran.refno#</td>
		<td>#dateformat(getartran.wos_date,"dd/mm/yyyy")#</td>
				
		<cfif getartran.type eq "RC" or getartran.type eq "CN">
			<cfset acctype = "D">
			<cfset mtype = "supp">
			<td></td>
			<td><div align="right">#numberformat(val(getartran.cs_pm_cash),".__")#</div></td>
		<cfelse>
			<cfset acctype = "Cr">
			<cfset mtype = "cust">
			<td><div align="right">#numberformat(val(getartran.cs_pm_cash),".__")#</div></td>
			<td></td>
		</cfif>
				
		<td><div align="center">Cash</div></td>
		<td>#ceiling(getartran.fperiod)#</td>
		<td>#get_cash_code.cashaccount#</td>
		<td>#acctype#</td>
		<td nowrap>#getartran.name#</td>
	</tr>
</cfif>
</cfoutput>