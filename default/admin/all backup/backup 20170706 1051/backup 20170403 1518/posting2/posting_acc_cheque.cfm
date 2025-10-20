<cfquery name="get_cheque_code" datasource="#dts#">
	select 
	chequeaccount
	from gsetup;
</cfquery>

<cfoutput>
<cfif val(getartran.cs_pm_cheq) neq 0 and (get_cheque_code.chequeaccount neq "" and get_cheque_code.chequeaccount neq "0000/000")>
	<!---<tr>
		<td>#getartran.type#</td>
		<td>#getartran.refno#</td>
        <cfif lcase(hcomid) eq "leadbuilders_i"><td>#getartran.refno2#</td></cfif>
		<td>#dateformat(getartran.wos_date,"dd/mm/yyyy")#</td>
		--->
		<cfif getartran.type eq "RC" or getartran.type eq "CN">
			<cfset acctype = "D">
			<cfset mtype = "supp">
			<!---<td></td>
			<td><div align="right">#numberformat(val(getartran.cs_pm_cheq),".__")#</div><cfset totcredit = totcredit + numberformat(val(getartran.cs_pm_cheq),".__")></td>
			--->
		<cfelse>
			<cfset acctype = "Cr">
			<cfset mtype = "cust">
			<!---<td><div align="right">#numberformat(val(getartran.cs_pm_cheq),".__")#</div><cfset totdebit = totdebit + numberformat(val(getartran.cs_pm_cheq),".__")></td>
			<td></td>--->
		</cfif>
		<!---
		<td><div align="center">Cheque</div></td>
		<td>#ceiling(getartran.fperiod)#</td>
		<td>#get_cheque_code.chequeaccount#</td>
		<td>#acctype#</td>
		<td nowrap>#getartran.name#</td>
        <td nowrap>#getartran.agenno#</td>
	</tr>--->
    
    <cfif getaccno.PPWKOF eq "Y">
    <!---
    <tr>
		<td>#getartran.type#</td>
		<td>#getartran.custno#</td>
        <cfif lcase(hcomid) eq "leadbuilders_i"><td>#getartran.refno2#</td></cfif>
		<td>#dateformat(getartran.wos_date,"dd/mm/yyyy")#</td>
		--->
		<cfif getartran.type eq "RC" or getartran.type eq "CN">
			<cfset acctype = "D">
			<cfset mtype = "supp">
			<!---<td><div align="right">#numberformat(val(getartran.cs_pm_cheq),".__")#</div><cfset totdebit = totdebit + numberformat(val(getartran.cs_pm_cheq),".__")></td>
			<td></td>--->
		<cfelse>
			<cfset acctype = "Cr">
			<cfset mtype = "cust">
			<!---<td></td>
			<td><div align="right">#numberformat(val(getartran.cs_pm_cheq),".__")#</div><cfset totcredit = totcredit + numberformat(val(getartran.cs_pm_cheq),".__")></td>
			--->
		</cfif>
		<!---
		<td><div align="center">Cheque</div></td>
		<td>#ceiling(getartran.fperiod)#</td>
		<td>#getartran.custno#</td>
		<td>#acctype#</td>
		<td nowrap>#getartran.name#</td>
        <td nowrap>#getartran.agenno#</td>
	</tr>--->
    
	</cfif>
				

		<cfset billno = code&refno>
		
		<cfif type eq "RC" or type eq "CN"<!---  or type eq "PR" --->>
			<cfquery name="insertpost1" datasource="#dts#">
				insert into glposttemp (acc_code,accno,fperiod,date,reference,refno,desp,despa,<cfif getartran.cs_pm_cheq lt 0>debitamt<cfelse>creditamt</cfif>,fcamt,exc_rate,despb,rem4,rem5,bdate,userid,agent,uuid)			
				values('#type#','#get_cheque_code.chequeaccount#','#ceiling(fperiod)#',#getartran.wos_date#,'#billno#','#refno2#',
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
				'#numberformat(abs(val(getartran.cs_pm_cheq)),".__")#','-#numberformat(abs(val(getartran.cs_pm_cheq_bil)),".__")#','#currrate#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.checkno#" >,'<!--- #note# --->','#getartran.rem6#',#getartran.wos_date#,'#HUserID#','#getartran.agenno#','#uuid#')
			</cfquery>
					
			
		<cfelse>
			<cfquery name="insertpost1" datasource="#dts#">
				insert into glposttemp (acc_code,accno,fperiod,date,reference,refno,desp,despa,<cfif getartran.cs_pm_cheq lt 0>creditamt<cfelse>debitamt</cfif>,fcamt,exc_rate,despb,rem4,rem5,bdate,userid,agent,uuid)			
				values('#type#','#get_cheque_code.chequeaccount#','#ceiling(fperiod)#',#getartran.wos_date#,'#billno#','#refno2#',
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
				'#numberformat(abs(val(getartran.cs_pm_cheq)),".__")#','#numberformat(abs(val(getartran.cs_pm_cheq_bil)),".__")#','#currrate#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.checkno#" >,'<!--- #note# --->','#getartran.rem6#',#getartran.wos_date#,'#HUserID#','#getartran.agenno#','#uuid#')
			</cfquery>
			
			
		</cfif>
        
        <cfif getaccno.PPWKOF eq "Y">
        
        <cfif type eq "RC" or type eq "CN"<!---  or type eq "PR" --->>
			<cfquery name="insertpost1" datasource="#dts#">
				insert into glposttemp (acc_code,accno,fperiod,date,reference,refno,desp,despa,<cfif getartran.cs_pm_cheq lt 0>creditamt<cfelse>debitamt</cfif>,fcamt,exc_rate,despb,rem4,rem5,bdate,userid,agent,payment,knockoff,uuid)			
				values('#type#','#getartran.custno#','#ceiling(fperiod)#',#getartran.wos_date#,'#billno#','#refno2#',
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
				'#numberformat(abs(val(getartran.cs_pm_cheq)),".__")#','#numberformat(abs(val(getartran.cs_pm_cheq_bil)),".__")#','#currrate#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.checkno#" >,'<!--- #note# --->','#getartran.rem6#',#getartran.wos_date#,'#HUserID#','#getartran.agenno#','P','Y','#uuid#')
			</cfquery>
					
			
		<cfelse>
			<cfquery name="insertpost1" datasource="#dts#">
				insert into glposttemp (acc_code,accno,fperiod,date,reference,refno,desp,despa,<cfif getartran.cs_pm_cheq lt 0>debitamt<cfelse>creditamt</cfif>,fcamt,exc_rate,despb,rem4,rem5,bdate,userid,agent,payment,knockoff,uuid)			
				values('#type#','#getartran.custno#','#ceiling(fperiod)#',#getartran.wos_date#,'#billno#','#refno2#',
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
				'#numberformat(abs(val(getartran.cs_pm_cheq)),".__")#','-#numberformat(abs(val(getartran.cs_pm_cheq_bil)),".__")#','#currrate#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.checkno#" >,'<!--- #note# --->','#getartran.rem6#',#getartran.wos_date#,'#HUserID#','#getartran.agenno#','P','Y','#uuid#')
			</cfquery>
			
		</cfif>
        
	</cfif>
</cfif>
</cfoutput>