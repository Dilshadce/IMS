<cfquery name="get_deposit_code" datasource="#dts#">
	select 
	depositaccount
	from gsetup;
</cfquery>

<cfoutput>
<cfif val(getartran.deposit) neq 0 and (get_deposit_code.depositaccount neq "" and get_deposit_code.depositaccount neq "0000/000")>
	<tr>
		<td>#getartran.type#</td>
		<td>#getartran.refno#</td>
		<td>#dateformat(getartran.wos_date,"dd/mm/yyyy")#</td>
				
		<cfif getartran.type eq "RC" or getartran.type eq "CN">
			<cfset acctype = "D">
			<cfset mtype = "supp">
			<td></td>
			<td><div align="right">#numberformat(val(getartran.deposit),".__")#</div></td>
		<cfelse>
			<cfset acctype = "Cr">
			<cfset mtype = "cust">
			<td><div align="right">#numberformat(val(getartran.deposit),".__")#</div></td>
			<td></td>
		</cfif>
				
		<td><div align="center">Deposit</div></td>
		<td>#ceiling(getartran.fperiod)#</td>
		<td>#get_deposit_code.depositaccount#</td>
		<td>#acctype#</td>
		<td nowrap>#getartran.name#</td>
	</tr>
</cfif>
</cfoutput>