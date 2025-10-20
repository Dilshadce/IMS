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
					
		<cfif post eq "post">
			<cfset billno = code&refno>
			
			<cfif type eq "RC" or type eq "CN"<!---  or type eq "PR" --->>
				<cfquery name="insertpost1" datasource="#dts#">
					insert into glpost9(acc_code,accno,fperiod,date,reference,refno,desp,despa,debitamt,fcamt,exc_rate,rem4,rem5,bdate)			
					values('#type#','#evaluate("get_misc_code.m#a#")#','#ceiling(fperiod)#','#dateformat(wos_date,"dd/mm/yy")#','#billno#','#refno2#',
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
					'#numberformat(evaluate("getartran.m_charge#a#"),".__")#','#numberformat(evaluate("getartran.mc#a#_bil"),".__")#','#currrate#','<!--- #note# --->','#getartran.rem6#','#dateformat(wos_date,"dd/mm/yy")#')
				</cfquery>
				
				<cfquery name="insertpost1" datasource="#dts#">
					insert into glpost91(acc_code,accno,fperiod,date,reference,refno,desp,despa,debitamt,fcamt,exc_rate,rem4,rem5,bdate)			
					values('#type#','#evaluate("get_misc_code.m#a#")#','#ceiling(fperiod)#','#dateformat(wos_date,"dd/mm/yy")#','#billno#','#refno2#',
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
					'#numberformat(evaluate("getartran.m_charge#a#"),".__")#','#numberformat(evaluate("getartran.mc#a#_bil"),".__")#','#currrate#','<!--- #note# --->','#getartran.rem6#','#dateformat(wos_date,"dd/mm/yy")#')
				</cfquery>
			<cfelse>
				<cfquery name="insertpost1" datasource="#dts#">
					insert into glpost9(acc_code,accno,fperiod,date,reference,refno,desp,despa,creditamt,fcamt,exc_rate,rem4,rem5,bdate)			
					values('#type#','#evaluate("get_misc_code.m#a#")#','#ceiling(fperiod)#','#dateformat(wos_date,"dd/mm/yy")#','#billno#','#refno2#',
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
					'#numberformat(evaluate("getartran.m_charge#a#"),".__")#','-#numberformat(evaluate("getartran.mc#a#_bil"),".__")#','#currrate#','<!--- #note# --->','#getartran.rem6#','#dateformat(wos_date,"dd/mm/yy")#')
				</cfquery>
						
				<cfquery name="insertpost1" datasource="#dts#">
					insert into glpost91(acc_code,accno,fperiod,date,reference,refno,desp,despa,creditamt,fcamt,exc_rate,rem4,rem5,bdate)			
					values('#type#','#evaluate("get_misc_code.m#a#")#','#ceiling(fperiod)#','#dateformat(wos_date,"dd/mm/yy")#','#billno#','#refno2#',
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
					'#numberformat(evaluate("getartran.m_charge#a#"),".__")#','-#numberformat(evaluate("getartran.mc#a#_bil"),".__")#','#currrate#','<!--- #note# --->','#getartran.rem6#','#dateformat(wos_date,"dd/mm/yy")#')
				</cfquery>
			</cfif>
		</cfif>
	</cfif>
</cfloop>
</cfoutput>