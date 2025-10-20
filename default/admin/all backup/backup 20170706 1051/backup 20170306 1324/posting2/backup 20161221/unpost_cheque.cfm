<cfquery name="get_cheque_code" datasource="#dts#">
	select 
	chequeaccount
	from gsetup;
</cfquery>

<cfoutput>
<cfif val(getartran.cs_pm_cheq) neq 0 and (get_cheque_code.chequeaccount neq "" and get_cheque_code.chequeaccount neq "0000/000")>
	<tr>
		<td>#getartran.type#</td>
		<td>#getartran.refno#</td>
		<td>#dateformat(getartran.wos_date,"dd/mm/yyyy")#</td>
				
		<cfif getartran.type eq "RC" or getartran.type eq "CN">
			<cfset acctype = "D">
			<cfset mtype = "supp">
			<td></td>
			<td><div align="right">#numberformat(val(getartran.cs_pm_cheq),".__")#</div></td>
		<cfelse>
			<cfset acctype = "Cr">
			<cfset mtype = "cust">
			<td><div align="right">#numberformat(val(getartran.cs_pm_cheq),".__")#</div></td>
			<td></td>
		</cfif>

		<td><div align="center">Cheque</div></td>
		<td>#ceiling(getartran.fperiod)#</td>
		<td>#get_cheque_code.chequeaccount#</td>
		<td>#acctype#</td>
		<td nowrap>#getartran.name#</td>
	</tr>
</cfif>
</cfoutput>