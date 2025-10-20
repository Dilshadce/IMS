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
				
	<cfif post eq "post">
		<cfset billno = code&refno>
		
		<cfif type eq "RC" or type eq "CN"<!---  or type eq "PR" --->>
			<cfquery name="insertpost1" datasource="#dts#">
				insert into glpost9(acc_code,accno,fperiod,date,reference,refno,desp,despa,creditamt,fcamt,exc_rate,rem4,rem5,bdate)			
				values('#type#','#get_cheque_code.chequeaccount#','#ceiling(fperiod)#','#dateformat(wos_date,"dd/mm/yy")#','#billno#','#refno2#',
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
				'#numberformat(val(getartran.cs_pm_cheq),".__")#','-#numberformat(val(getartran.cs_pm_cheq_bil),".__")#','#currrate#','<!--- #note# --->','#getartran.rem6#','#dateformat(wos_date,"dd/mm/yy")#')
			</cfquery>
					
			<cfquery name="insertpost1" datasource="#dts#">
				insert into glpost91(acc_code,accno,fperiod,date,reference,refno,desp,despa,creditamt,fcamt,exc_rate,rem4,rem5,bdate)			
				values('#type#','#get_cheque_code.chequeaccount#','#ceiling(fperiod)#','#dateformat(wos_date,"dd/mm/yy")#','#billno#','#refno2#',
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
				'#numberformat(val(getartran.cs_pm_cheq),".__")#','-#numberformat(val(getartran.cs_pm_cheq_bil),".__")#','#currrate#','<!--- #note# --->','#getartran.rem6#','#dateformat(wos_date,"dd/mm/yy")#')
			</cfquery>
		<cfelse>
			<cfquery name="insertpost1" datasource="#dts#">
				insert into glpost9(acc_code,accno,fperiod,date,reference,refno,desp,despa,debitamt,fcamt,exc_rate,rem4,rem5,bdate)			
				values('#type#','#get_cheque_code.chequeaccount#','#ceiling(fperiod)#','#dateformat(wos_date,"dd/mm/yy")#','#billno#','#refno2#',
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
				'#numberformat(val(getartran.cs_pm_cheq),".__")#','#numberformat(val(getartran.cs_pm_cheq_bil),".__")#','#currrate#','<!--- #note# --->','#getartran.rem6#','#dateformat(wos_date,"dd/mm/yy")#')
			</cfquery>
			
			<cfquery name="insertpost1" datasource="#dts#">
				insert into glpost91(acc_code,accno,fperiod,date,reference,refno,desp,despa,debitamt,fcamt,exc_rate,rem4,rem5,bdate)			
				values('#type#','#get_cheque_code.chequeaccount#','#ceiling(fperiod)#','#dateformat(wos_date,"dd/mm/yy")#','#billno#','#refno2#',
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
				'#numberformat(val(getartran.cs_pm_cheq),".__")#','#numberformat(val(getartran.cs_pm_cheq_bil),".__")#','#currrate#','<!--- #note# --->','#getartran.rem6#','#dateformat(wos_date,"dd/mm/yy")#')
			</cfquery>
		</cfif>
	</cfif>
</cfif>
</cfoutput>