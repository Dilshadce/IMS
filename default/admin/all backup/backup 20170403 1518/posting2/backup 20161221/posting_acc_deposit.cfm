<cfquery name="get_deposit_code" datasource="#dts#">
	select 
	depositaccount,postdepdebtor
	from gsetup;
</cfquery>

<cfoutput>
<cfif val(getartran.deposit) neq 0 and (get_deposit_code.depositaccount neq "" and get_deposit_code.depositaccount neq "0000/000")>
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
			<td><div align="right">#numberformat(val(getartran.deposit),".__")#</div><cfset totcredit = totcredit + numberformat(val(getartran.deposit),".__")></td>
			--->
		<cfelse>
			<cfset acctype = "Cr">
			<cfset mtype = "cust">
			<!---<td><div align="right">#numberformat(val(getartran.deposit),".__")#</div><cfset totdebit = totdebit + numberformat(val(getartran.deposit),".__")></td>
			<td></td>
			--->
		</cfif>
				
		<!---<td><div align="center">Deposit</div></td>
		<td>#ceiling(getartran.fperiod)#</td>--->
        <cfif get_deposit_code.postdepdebtor eq "Y">
        <cfset get_deposit_code.depositaccount = getartran.custno>
		</cfif>
        <!---
		<td>#get_deposit_code.depositaccount#</td>
		<td>#acctype#</td>
		<td nowrap>#getartran.name#</td>
        <td nowrap>#getartran.agenno#</td>
	</tr>---->
    
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
			<!---<td><div align="right">#numberformat(val(getartran.deposit),".__")#</div><cfset totdebit = totdebit + numberformat(val(getartran.deposit),".__")></td>
			<td></td
		>---><cfelse>
			<cfset acctype = "Cr">
			<cfset mtype = "cust">
			<!---<td></td>
			<td><div align="right">#numberformat(val(getartran.deposit),".__")#</div><cfset totcredit = totcredit + numberformat(val(getartran.deposit),".__")></td>
		--->
		</cfif>
				
		<!---<td><div align="center">Deposit</div></td>
		<td>#ceiling(getartran.fperiod)#</td>
		<td>#getartran.custno#</td>
		<td>#acctype#</td>
		<td nowrap>#getartran.name#</td>
        <td nowrap>#getartran.agenno#</td>
	</tr>--->
    
	</cfif>
				

		<cfset billno = code&refno>
		
        
    <!---Retrieve Deposit from Deposit Profile--->
    <cfquery name="checkdepositexistglpost" datasource="#dts#">
    	SELECT reference FROM #replacenocase(LCASE(dts),"_i","_a","all")#.glpost WHERE acc_code="DEP" AND reference="#getartran.depositno#"
    </cfquery>
    <cfquery name="getdeposit" datasource="#dts#">
    	SELECT * FROM deposit WHERE depositno="#getartran.depositno#"
    </cfquery>
    
	<cfif type eq "INV" and checkdepositexistglpost.recordcount neq 0 and getdeposit.ptax neq 0 and currrate eq 1>

    	<cfset secondcredit = numberformat((((getdeposit.cs_pm_cash+getdeposit.cs_pm_cheq+getdeposit.cs_pm_crcd+getdeposit.cs_pm_crc2+getdeposit.cs_pm_dbcd+getdeposit.cs_pm_vouc)*getdeposit.ptax)/(100+val(getdeposit.ptax))),".__")>
            <cfset firstcredit = numberformat((((getdeposit.cs_pm_cash+getdeposit.cs_pm_cheq+getdeposit.cs_pm_crcd+getdeposit.cs_pm_crc2+getdeposit.cs_pm_dbcd+getdeposit.cs_pm_vouc)*100)/(100+val(getdeposit.ptax))),".__")>
        <!---deposit--->
        <cfquery name="insertpost1" datasource="#dts#">
				insert into glposttemp (acc_code,accno,fperiod,date,reference,refno,desp,despa,debitamt,fcamt,exc_rate,rem4,rem5,bdate,userid,agent,uuid,taxpec)			
				values('#type#','#get_deposit_code.depositaccount#','#ceiling(fperiod)#',#getartran.wos_date#,'#billno#','#getdeposit.depositno#',
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
				'#numberformat(abs(val(firstcredit)),".__")#','#numberformat(abs(val(firstcredit)),".__")#','1','#getdeposit.taxcode#','#getartran.rem6#',#getartran.wos_date#,'#HUserID#','#getartran.agenno#','#uuid#','#getdeposit.ptax#')
			</cfquery>

        <!---tax--->
    	<cfquery name="insertpost133445" datasource="#dts#">
				insert into glposttemp (acc_code,accno,fperiod,date,reference,refno,desp,despa,debitamt,fcamt,exc_rate,rem4,rem5,bdate,userid,agent,payment,knockoff,uuid,taxpec)			
				values('#type#','#getaccno.gstsales#','#ceiling(fperiod)#',#getartran.wos_date#,'#billno#','#getdeposit.depositno#',
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
				'#numberformat(abs(val(secondcredit)),".__")#','-#numberformat(abs(val(secondcredit)),".__")#','1','#getdeposit.taxcode#','#getartran.rem6#',#getartran.wos_date#,'#HUserID#','#getartran.agenno#','P','Y','#uuid#','#getdeposit.ptax#')
		</cfquery>
        
    <!---End Retrieve Deposit from Deposit Profile--->
	<cfelse>
        <!---normal no tax deposit--->
        
        
        
		<cfif type eq "RC" or type eq "CN"<!---  or type eq "PR" --->>
			<cfquery name="insertpost1" datasource="#dts#">
				insert into glposttemp (acc_code,accno,fperiod,date,reference,refno,desp,despa,<cfif getartran.deposit lt 0>debitamt<cfelse>creditamt</cfif>,fcamt,exc_rate,rem4,rem5,bdate,userid,agent,uuid)			
				values('#type#','#get_deposit_code.depositaccount#','#ceiling(fperiod)#',#getartran.wos_date#,'#billno#','#refno2#',
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
				'#numberformat(abs(val(getartran.deposit)),".__")#','-#numberformat(abs(val(getartran.deposit_bil)),".__")#','#currrate#','<!--- #note# --->','#getartran.rem6#',#getartran.wos_date#,'#HUserID#','#getartran.agenno#','#uuid#')
			</cfquery>
					
		<cfelse>
			<cfquery name="insertpost1" datasource="#dts#">
				insert into glposttemp (acc_code,accno,fperiod,date,reference,refno,desp,despa,<cfif getartran.deposit lt 0>creditamt<cfelse>debitamt</cfif>,fcamt,exc_rate,rem4,rem5,bdate,userid,agent,uuid)			
				values('#type#','#get_deposit_code.depositaccount#','#ceiling(fperiod)#',#getartran.wos_date#,'#billno#','#refno2#',
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
				'#numberformat(abs(val(getartran.deposit)),".__")#','#numberformat(abs(val(getartran.deposit_bil)),".__")#','#currrate#','<!--- #note# --->','#getartran.rem6#',#getartran.wos_date#,'#HUserID#','#getartran.agenno#','#uuid#')
			</cfquery>
			
		</cfif>
        
        
        </cfif>
        
        <cfif getaccno.PPWKOF eq "Y">
        
        <cfif type eq "RC" or type eq "CN"<!---  or type eq "PR" --->>
			<cfquery name="insertpost1" datasource="#dts#">
				insert into glposttemp (acc_code,accno,fperiod,date,reference,refno,desp,despa,<cfif getartran.deposit lt 0>creditamt<cfelse>debitamt</cfif>,fcamt,exc_rate,rem4,rem5,bdate,userid,agent,payment,knockoff,uuid)			
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
				'#numberformat(abs(val(getartran.deposit)),".__")#','#numberformat(abs(val(getartran.deposit_bil)),".__")#','#currrate#','<!--- #note# --->','#getartran.rem6#',#getartran.wos_date#,'#HUserID#','#getartran.agenno#','P','Y','#uuid#')
			</cfquery>
					
		<cfelse>
			<cfquery name="insertpost1" datasource="#dts#">
				insert into glposttemp (acc_code,accno,fperiod,date,reference,refno,desp,despa,<cfif getartran.deposit lt 0>debitamt<cfelse>creditamt</cfif>,fcamt,exc_rate,rem4,rem5,bdate,userid,agent,payment,knockoff,uuid)			
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
				'#numberformat(abs(val(getartran.deposit)),".__")#','-#numberformat(abs(val(getartran.deposit_bil)),".__")#','#currrate#','<!--- #note# --->','#getartran.rem6#',#getartran.wos_date#,'#HUserID#','#getartran.agenno#','P','Y','#uuid#')
			</cfquery>
			
		</cfif>
	</cfif>
    
    </cfif>
</cfoutput>