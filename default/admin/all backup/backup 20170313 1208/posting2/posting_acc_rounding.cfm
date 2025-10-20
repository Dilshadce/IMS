<cfquery name="get_rounding_code" datasource="#dts#">
	select 
	roundingaccount
	from gsetup;
</cfquery>

<cfoutput>
<cfif val(getartran.roundadj) neq 0 and get_rounding_code.roundingaccount neq "" and get_rounding_code.roundingaccount neq "0000/000">

		<cfif getartran.type eq "RC" or getartran.type eq "CN">
			<cfset acctype = "D">
			<cfset mtype = "supp">
		<cfelse>
			<cfset acctype = "Cr">
			<cfset mtype = "cust">
		</cfif>	

		<cfset billno = code&refno>
		
		<cfif type eq "RC" or type eq "CN"<!---  or type eq "PR" --->>
			<cfquery name="insertpost1" datasource="#dts#">
				insert into glposttemp (acc_code,accno,fperiod,date,reference,refno,desp,despa,<cfif getartran.roundadj lt 0>creditamt<cfelse>debitamt</cfif>,fcamt,exc_rate,despb,rem4,rem5,bdate,userid,agent,uuid)			
				values('#type#','#get_rounding_code.roundingaccount#','#ceiling(fperiod)#',#getartran.wos_date#,'#billno#','#refno2#',
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
				'#numberformat(abs(val(getartran.roundadj)),".__")#','-#numberformat(abs(val(getartran.roundadj_bil)),".__")#','#currrate#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.checkno#" >,'<!--- #note# --->','#getartran.rem6#',#getartran.wos_date#,'#HUserID#','#getartran.agenno#','#uuid#')
			</cfquery>
					
			
		<cfelse>
			<cfquery name="insertpost1" datasource="#dts#">
				insert into glposttemp (acc_code,accno,fperiod,date,reference,refno,desp,despa,<cfif getartran.roundadj lt 0>debitamt<cfelse>creditamt</cfif>,fcamt,exc_rate,despb,rem4,rem5,bdate,userid,agent,uuid)			
				values('#type#','#get_rounding_code.roundingaccount#','#ceiling(fperiod)#',#getartran.wos_date#,'#billno#','#refno2#',
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
				'#numberformat(abs(val(getartran.roundadj)),".__")#','#numberformat(abs(val(getartran.roundadj_bil)),".__")#','#currrate#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.checkno#" >,'<!--- #note# --->','#getartran.rem6#',#getartran.wos_date#,'#HUserID#','#getartran.agenno#','#uuid#')
			</cfquery>
			
			
		</cfif>
        
</cfif>
</cfoutput>