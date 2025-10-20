<cfquery name="get_credit_card2_code" datasource="#dts#">
	select 
	creditcardaccount2
	from gsetup;
</cfquery>

<cfoutput>
<cfif val(getartran.cs_pm_crc2) neq 0 and (get_credit_card2_code.creditcardaccount2 neq "" and get_credit_card2_code.creditcardaccount2 neq "0000/000")>
	<tr>
		<td>#getartran.type#</td>
		<td>#getartran.refno#</td>
		<td>#dateformat(getartran.wos_date,"dd/mm/yyyy")#</td>
				
		<cfif getartran.type eq "RC" or getartran.type eq "CN">
			<cfset acctype = "D">
			<cfset mtype = "supp">
			<td></td>
			<td><div align="right">#numberformat(val(getartran.cs_pm_crc2),".__")#</div></td>
		<cfelse>
			<cfset acctype = "Cr">
			<cfset mtype = "cust">
			<td><div align="right">#numberformat(val(getartran.cs_pm_crc2),".__")#</div></td>
			<td></td>
		</cfif>

		<td><div align="center">Credit Card 2</div></td>
		<td>#ceiling(getartran.fperiod)#</td>
		<td>#get_credit_card2_code.creditcardaccount2#</td>
		<td>#acctype#</td>
		<td nowrap>#getartran.name#</td>
	</tr>
</cfif>
</cfoutput>