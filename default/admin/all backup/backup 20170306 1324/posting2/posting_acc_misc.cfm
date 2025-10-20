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
     <cfif a eq 1>
    <cfset getartran.m_charge1 = numberformat(evaluate("getartran.m_charge#a#"),".___")>
    <cfelseif a eq 2>
    <cfset getartran.m_charge2 = numberformat(evaluate("getartran.m_charge#a#"),".___")>
    <cfelseif a eq 3>
    <cfset getartran.m_charge3 = numberformat(evaluate("getartran.m_charge#a#"),".___")>
    <cfelseif a eq 4>
    <cfset getartran.m_charge4 = numberformat(evaluate("getartran.m_charge#a#"),".___")>
    <cfelseif a eq 5>
    <cfset getartran.m_charge5 = numberformat(evaluate("getartran.m_charge#a#"),".___")>
    <cfelseif a eq 6>
    <cfset getartran.m_charge6 = numberformat(evaluate("getartran.m_charge#a#"),".___")>
    <cfelse>
    <cfset getartran.m_charge7 = numberformat(evaluate("getartran.m_charge#a#"),".___")>
    </cfif>
    <!---
		<tr>
			<td>#getartran.type#</td>
			<td>#getartran.refno#</td>
            <cfif lcase(hcomid) eq "leadbuilders_i"><td>#getartran.refno2#</td></cfif>
			<td>#dateformat(getartran.wos_date,"dd/mm/yyyy")#</td>
					
			<cfif getartran.type eq "RC" or getartran.type eq "CN">
				<cfset acctype = "D">
				<cfset mtype = "supp">
				<td><div align="right">#numberformat(evaluate("getartran.m_charge#a#"),".__")#</div><cfset totdebit = totdebit + numberformat(evaluate("getartran.m_charge#a#"),".__")></td>
				<td></td>
			<cfelse>
				<cfset acctype = "Cr">
				<cfset mtype = "cust">
				<td></td>
				<td><div align="right">#numberformat(evaluate("getartran.m_charge#a#"),".__")#</div><cfset totcredit = totcredit + numberformat(evaluate("getartran.m_charge#a#"),".__")></td>
			</cfif>
					
			<td>&nbsp;</td>
			<td>#ceiling(getartran.fperiod)#</td>
			<td>#evaluate("get_misc_code.m#a#")#</td>
			<td>#acctype#</td>
			<td nowrap>#getartran.name#</td>
            <td nowrap>#getartran.agenno#</td>
		</tr>
		--->

			<cfset billno = code&refno>
			
			<cfif type eq "RC" or type eq "CN"<!---  or type eq "PR" --->>
				<cfquery name="insertpost1" datasource="#dts#">
					insert into glposttemp (acc_code,accno,fperiod,date,reference,refno,desp,despa,<cfif evaluate("getartran.m_charge#a#") gte 0>debitamt<cfelse>creditamt</cfif>,fcamt,exc_rate,rem4,rem5,bdate,userid,agent,uuid)			
					values('#type#','#evaluate("get_misc_code.m#a#")#','#ceiling(fperiod)#',#getartran.wos_date#,'#billno#','#refno2#',
					<cfif getaccno.postvalue eq "pono">
						'#getartran.rem9#',					
					<cfelseif getaccno.postvalue eq "desp">
						'#desp#',
					<cfelse>
						'#billtype#',
					</cfif>
							
					<cfif getaccno.postvalue eq "pono">
						'#pono#',
					<cfelse>
						'#getartran.despa#',
					</cfif>
					'#numberformat(abs(evaluate("getartran.m_charge#a#")),".__")#','#numberformat(abs(evaluate("getartran.mc#a#_bil")),".__")#','#currrate#','<!--- #note# --->','#getartran.rem6#',#getartran.wos_date#,'#HUserID#','#getartran.agenno#','#uuid#')
				</cfquery>
				
				
			<cfelse>
           
				<cfquery name="insertpost1" datasource="#dts#">
					insert into glposttemp (acc_code,accno,fperiod,date,reference,refno,desp,despa,<cfif evaluate("getartran.m_charge#a#") gte 0>creditamt<cfelse>debitamt</cfif>,fcamt,exc_rate,rem4,rem5,bdate,userid,agent,uuid)			
					values('#type#','#evaluate("get_misc_code.m#a#")#','#ceiling(fperiod)#',#getartran.wos_date#,'#billno#','#refno2#',
					<cfif getaccno.postvalue eq "pono" and type eq "RC">
						'#pono#',
					<cfelseif getaccno.postvalue eq "pono" and type eq "PR">
						'#pono#',
					<cfelseif getaccno.postvalue eq "pono" and type eq "CN">
						'#getartran.rem9#',
					<cfelseif getaccno.postvalue eq "desp">
						'#desp#',
					<cfelse>
						'#billtype#',
					</cfif>
							
					<cfif getaccno.postvalue eq "pono" and type eq "CN">
						'#pono#',
					<cfelse>
						'#getartran.despa#',
					</cfif>
					'#numberformat(abs(evaluate("getartran.m_charge#a#")),".__")#','-#numberformat(abs(evaluate("getartran.mc#a#_bil")),".__")#','#currrate#','<!--- #note# --->','#getartran.rem6#',#getartran.wos_date#,'#HUserID#','#getartran.agenno#','#uuid#')
				</cfquery>
						
				
			</cfif>

	</cfif>
</cfloop>
</cfoutput>