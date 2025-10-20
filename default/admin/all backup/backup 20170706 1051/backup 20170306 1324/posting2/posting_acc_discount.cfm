<cfoutput>
<!---<tr>
	<td>#getartran.type#</td>
	<td>#getartran.refno#</td>
	<td>#dateformat(getartran.wos_date,"dd/mm/yyyy")#</td>--->
			
	<cfif getartran.type eq "RC" or getartran.type eq "CN" >
		<cfset acctype = "Cr">			
		
		<cfif getartran.type eq "RC" or getartran.type eq "PR">
			<cfset xaccno = getaccno.discpur>
		<cfelse>
			<cfset xaccno = getaccno.discsales>
		</cfif>
        <!---
		<td></td>
		<td><div align="right">#numberformat(getartran.discount,".__")#</div><cfset totcredit = totcredit + numberformat(getartran.discount,".__")></td>
		--->
	<cfelse>
		<cfset acctype = "D">
		<cfset xaccno = getaccno.discsales>
		<!---<td><div align="right">#numberformat(getartran.discount,".__")#</div><cfset totdebit = totdebit + numberformat(getartran.discount,".__")></td>
		<td></td>--->
	</cfif>
	<cfif xaccno eq "" or xaccno eq "0000/000">
		<cfset noaccno="Y">
	</cfif>	
	<!---<td><div align="center">Disc</div></td>
	<td>#ceiling(getartran.fperiod)#</td>	
	<td>#xaccno#</td>				
	<td>#acctype#</td>
	<td nowrap>#getartran.name#</td>
    <td nowrap>#getartran.agenno#</td>
</tr>--->
</cfoutput>


	<cfif getartran.type eq "RC" or getartran.type eq "CN"<!---  or getartran.type eq "PR" --->>			
		<cfquery name="insertpost4" datasource="#dts#">
			insert into glposttemp
			(
				acc_code,
				accno,
				fperiod,
				date,
				reference,
				desp,
				creditamt,
				fcamt,
				exc_rate,
				rem4,
				rem5,
				bdate,userid,agent,uuid
			)
			values 
			(
				'#getartran.type#',
				'#xaccno#',
				'#ceiling(getartran.fperiod)#',
				#getartran.wos_date#,
				'#billno#','#getartran.name#',
				'#numberformat(getartran.discount,".__")#',
				'-#numberformat(getartran.disc1_bil,".__")#',
				'#getartran.currrate#',
				'#getartran.note#',
				'#getartran.rem6#',
				#getartran.wos_date#,'#HUserID#','#getartran.agenno#','#uuid#'
			)
		</cfquery>
		
		
	<cfelse>
		<cfquery name="insertpost4" datasource="#dts#">
			insert into glposttemp
			(
				acc_code,
				accno,
				fperiod,
				date,
				reference,
				desp,
				debitamt,
				fcamt,
				exc_rate,
				rem4,
				rem5,
				bdate,userid,agent,uuid
			)
			values 
			(
				'#getartran.type#',
				'#xaccno#',
				'#ceiling(getartran.fperiod)#',
				#getartran.wos_date#,
				'#billno#',
				'#getartran.name#',
				'#numberformat(getartran.discount,".__")#',
				'#numberformat(getartran.disc1_bil,".__")#',
				'#getartran.currrate#',
				'#getartran.note#',
				'#getartran.rem6#',
				#getartran.wos_date#,'#HUserID#','#getartran.agenno#','#uuid#'
			)
		</cfquery>
		
		
	</cfif>		
