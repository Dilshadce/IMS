<cfquery name="get_cash_code" datasource="#dts#">
	select 
	cashaccount
	from gsetup;
</cfquery>

<cfoutput>
<cfif val(getartran.cs_pm_cash) neq 0 and (get_cash_code.cashaccount neq "" and get_cash_code.cashaccount neq "0000/000")>
	<!---<tr>
		<td>#getartran.type#</td>
		<td>#getartran.refno#</td>
        <cfif lcase(hcomid) eq "leadbuilders_i"><td>#getartran.refno2#</td></cfif>
		<td>#dateformat(getartran.wos_date,"dd/mm/yyyy")#</td>
		--->
		<cfif getartran.type eq "RC" or getartran.type eq "CN">
			<cfset acctype = "D">
			<cfset mtype = "supp">
            <cfif numberformat(val(getartran.cs_pm_cash),".__") lt 0>
            <cfset acctype = "Cr">
			<!---<td><div align="right">#numberformat(abs(val(getartran.cs_pm_cash)),".__")#</div><cfset totdebit = totdebit + numberformat(abs(val(getartran.cs_pm_cash)),".__")></td>
            <td></td>--->
            <cfelse>
            <!---
			<td></td>
			<td><div align="right">#numberformat(val(getartran.cs_pm_cash),".__")#</div><cfset totcredit = totcredit + numberformat(val(getartran.cs_pm_cash),".__")></td>
            --->
            </cfif>
		<cfelse>
			<cfset acctype = "Cr">
			<cfset mtype = "cust">
            <cfif numberformat(val(getartran.cs_pm_cash),".__") lt 0>
            <!---<td></td>
            <td><div align="right">#numberformat(abs(val(getartran.cs_pm_cash)),".__")#</div><cfset totcredit = totcredit + numberformat(abs(val(getartran.cs_pm_cash)),".__")></td>			
			--->
			<cfelse>
            <!---
			<td><div align="right">#numberformat(val(getartran.cs_pm_cash),".__")#</div><cfset totdebit = totdebit + numberformat(val(getartran.cs_pm_cash),".__")></td>
			<td></td>--->
            </cfif>
		</cfif>
		<!---		
		<td><div align="center">Cash</div></td>
		<td>#ceiling(getartran.fperiod)#</td>
		<td>#get_cash_code.cashaccount#</td>
		<td>#acctype#</td>
		<td nowrap>#getartran.name#</td>
        <td nowrap>#getartran.agenno#</td>
	</tr>--->
    
    <cfif getaccno.PPWKOF eq "Y">
    <!---
    	<tr>
		<td>#getartran.type#</td>
		<td>#getartran.refno#</td>
        <cfif lcase(hcomid) eq "leadbuilders_i"><td>#getartran.refno2#</td></cfif>
		<td>#dateformat(getartran.wos_date,"dd/mm/yyyy")#</td>
		--->		
		<cfif getartran.type eq "RC" or getartran.type eq "CN">
			<cfset acctype = "D">
			<cfset mtype = "supp">
            <cfif numberformat(val(getartran.cs_pm_cash),".__") lt 0>
            <cfset acctype = "Cr">
			<!---<td></td>
            <td><div align="right">#numberformat(abs(val(getartran.cs_pm_cash)),".__")#</div><cfset totcredit = totcredit + numberformat(val(getartran.cs_pm_cash),".__")>
            --->
			<cfelse>
			<!---
			<td><div align="right">#numberformat(val(getartran.cs_pm_cash),".__")#</div><cfset totdebit = totdebit + numberformat(abs(val(getartran.cs_pm_cash)),".__")></td></td><td></td>
            --->
            </cfif>
		<cfelse>
			<cfset acctype = "Cr">
			<cfset mtype = "cust">
            <cfif numberformat(val(getartran.cs_pm_cash),".__") lt 0>           
            <!---<td><div align="right">#numberformat(abs(val(getartran.cs_pm_cash)),".__")#</div></td>	 <cfset totdebit = totdebit + numberformat(val(getartran.cs_pm_cash),".__")>
            <td></td>--->		
			<cfelse>
            <!---<td></td>
			<td><div align="right">#numberformat(val(getartran.cs_pm_cash),".__")#</div><cfset totcredit = totcredit + numberformat(abs(val(getartran.cs_pm_cash)),".__")></td>			
            --->
			</cfif>
		</cfif>
		<!---		
		<td><div align="center">Cash</div></td>
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
				insert into glposttemp (acc_code,accno,fperiod,date,reference,refno,desp,despa,<cfif numberformat(val(getartran.cs_pm_cash),".__") lt 0>debitamt,<cfelse>creditamt,</cfif>fcamt,exc_rate,rem4,rem5,bdate,userid,agent,uuid)			
				values
				('#type#','#get_cash_code.cashaccount#','#ceiling(fperiod)#',#getartran.wos_date#,'#billno#','#refno2#',
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
				'#numberformat(abs(val(getartran.cs_pm_cash)),".__")#',<cfif numberformat(val(getartran.cs_pm_cash),".__") lt 0>'#numberformat(abs(val(getartran.cs_pm_cash_bil)),".__")#',<cfelse>'-#numberformat(val(getartran.cs_pm_cash_bil),".__")#',</cfif>'#currrate#','<!--- #note# --->','#getartran.rem6#',#getartran.wos_date#,'#HUserID#','#getartran.agenno#','#uuid#')
			</cfquery>
            
            <cfif getaccno.PPWKOF eq "Y">
            
            <cfquery name="insertpost1" datasource="#dts#">
				insert into glposttemp (acc_code,accno,fperiod,date,reference,refno,desp,despa,<cfif numberformat(val(getartran.cs_pm_cash),".__") gt 0>debitamt,<cfelse>creditamt,</cfif>fcamt,exc_rate,rem4,rem5,bdate,userid,agent,payment,knockoff,uuid)			
				values
				('#type#','#getartran.custno#','#ceiling(fperiod)#',#getartran.wos_date#,'#billno#','#refno2#',
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
				'#numberformat(abs(val(getartran.cs_pm_cash)),".__")#',<cfif numberformat(val(getartran.cs_pm_cash),".__") gt 0>'#numberformat(abs(val(getartran.cs_pm_cash_bil)),".__")#',<cfelse>'-#numberformat(val(getartran.cs_pm_cash_bil),".__")#',</cfif>'#currrate#','<!--- #note# --->','#getartran.rem6#',#getartran.wos_date#,'#HUserID#','#getartran.agenno#','P','Y','#uuid#')
			</cfquery>
            
			</cfif>
            
		<cfelse>
			<cfquery name="insertpost1" datasource="#dts#">
				insert into glposttemp (acc_code,accno,fperiod,date,reference,refno,desp,despa,<cfif numberformat(val(getartran.cs_pm_cash),".__") lt 0>creditamt,<cfelse>debitamt,</cfif>fcamt,exc_rate,rem4,rem5,bdate,userid,agent,uuid)			
				values('#type#','#get_cash_code.cashaccount#','#ceiling(fperiod)#',#getartran.wos_date#,'#billno#','#refno2#',
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
				'#numberformat(abs(val(getartran.cs_pm_cash)),".__")#',<cfif numberformat(val(getartran.cs_pm_cash),".__") lt 0>'#numberformat(-(abs(val(getartran.cs_pm_cash_bil))),".__")#',<cfelse>'#numberformat(val(getartran.cs_pm_cash_bil),".__")#',</cfif>'#currrate#','<!--- #note# --->','#getartran.rem6#',#getartran.wos_date#,'#HUserID#','#getartran.agenno#','#uuid#')
			</cfquery>
            
            <cfif getaccno.PPWKOF eq "Y">
            
            <cfquery name="insertpost1" datasource="#dts#">
				insert into glposttemp (acc_code,accno,fperiod,date,reference,refno,desp,despa,<cfif numberformat(val(getartran.cs_pm_cash),".__") gt 0>creditamt,<cfelse>debitamt,</cfif>fcamt,exc_rate,rem4,rem5,bdate,userid,agent,payment,knockoff,uuid)			
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
				'#numberformat(abs(val(getartran.cs_pm_cash)),".__")#',<cfif numberformat(val(getartran.cs_pm_cash),".__") gt 0>'#numberformat(-(abs(val(getartran.cs_pm_cash_bil))),".__")#',<cfelse>'#numberformat(val(getartran.cs_pm_cash_bil),".__")#',</cfif>'#currrate#','<!--- #note# --->','#getartran.rem6#',#getartran.wos_date#,'#HUserID#','#getartran.agenno#','P','Y','#uuid#')
			</cfquery>
            
			</cfif>
            
	</cfif>
</cfif>
</cfoutput>