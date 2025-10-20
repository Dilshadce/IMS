<cfquery name="get_misc_code" datasource="#dts#">
	select 
	#mtype#misc1 as m1, 
	#mtype#misc2 as m2,
	#mtype#misc3 as m3,
	#mtype#misc4 as m4,
	#mtype#misc5 as m5,
	#mtype#misc6 as m6,
	#mtype#misc7 as m7
	from gsetup;
</cfquery>

<cfoutput>
<cfloop index="a" from="1" to="7">
	<cfif val(evaluate("getartran.m_charge#a#")) neq 0 and (evaluate("get_misc_code.m#a#") neq "" and evaluate("get_misc_code.m#a#") neq "0000/000")>
		<tr>
			<td>#getartran.type#</td>
			<td>#getartran.refno#</td>
			<td>#dateformat(getartran.wos_date,"dd/mm/yyyy")#</td>
					
			<cfif getartran.type eq "RC" or getartran.type eq "CN">
				<cfset acctype = "D">
				<cfset mtype = "supp">
				<td><div align="right">#numberformat(evaluate("getartran.m_charge#a#"),".__")#</div></td>
				<td></td>
			<cfelse>
				<cfset acctype = "Cr">
				<cfset mtype = "cust">
				<td></td>
				<td><div align="right">#numberformat(evaluate("getartran.m_charge#a#"),".__")#</div></td>
			</cfif>

			<td>&nbsp;</td>
			<td>#ceiling(getartran.fperiod)#</td>
			<td>#evaluate("get_misc_code.m#a#")#</td>
			<td>#acctype#</td>
			<td nowrap>#getartran.name#</td>
		</tr>
	</cfif>
</cfloop>
</cfoutput>