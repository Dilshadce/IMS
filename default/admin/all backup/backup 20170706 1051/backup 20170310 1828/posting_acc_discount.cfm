<cfoutput>
<tr>
	<td>#getartran.type#</td>
	<td>#getartran.refno#</td>
	<td>#dateformat(getartran.wos_date,"dd/mm/yyyy")#</td>
			
	<cfif getartran.type eq "RC" or getartran.type eq "CN" or getartran.type eq "PR">
		<cfset acctype = "Cr">			
		
		<cfif getartran.type eq "RC" or getartran.type eq "PR">
			<cfset xaccno = getaccno.discpur>
		<cfelse>
			<cfset xaccno = getaccno.discsales>
		</cfif>
		<td></td>
		<td><div align="right">#numberformat(getartran.discount,".__")#</div></td>
	<cfelse>
		<cfset acctype = "D">
		<cfset xaccno = getaccno.discsales>
		<td><div align="right">#numberformat(getartran.discount,".__")#</div></td>
		<td></td>
	</cfif>
			
	<td><div align="center">Disc</div></td>
	<td>#ceiling(getartran.fperiod)#</td>	
	<td>#xaccno#</td>				
	<td>#acctype#</td>
	<td nowrap>#getartran.name#</td>
</tr>
</cfoutput>

<cfif post eq "post">
	<cfif getartran.type eq "RC" or getartran.type eq "CN"<!---  or getartran.type eq "PR" --->>			
		<cfquery name="insertpost4" datasource="#dts#">
			insert into glpost9 
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
				bdate
			)
			values 
			(
				'#getartran.type#',
				'#xaccno#',
				'#ceiling(getartran.fperiod)#',
				'#dateformat(getartran.wos_date,"dd/mm/yy")#',
				'#billno#','#getartran.name#',
				'#numberformat(getartran.discount,".__")#',
				'-#numberformat(getartran.disc1_bil,".__")#',
				'#getartran.currrate#',
				'',
				'#getartran.rem6#',
				'#dateformat(getartran.wos_date,"dd/mm/yy")#'
			)
		</cfquery>
		
		<cfquery name="insertpost4" datasource="#dts#">
			insert into glpost91 
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
				bdate
			)
			values 
			(
				'#getartran.type#',
				'#xaccno#',
				'#ceiling(getartran.fperiod)#',
				'#dateformat(getartran.wos_date,"dd/mm/yy")#',
				'#billno#',
				'#getartran.name#',
				'#numberformat(getartran.discount,".__")#',
				'-#numberformat(getartran.disc1_bil,".__")#',
				'#getartran.currrate#',
				'',
				'#getartran.rem6#',
				'#dateformat(getartran.wos_date,"dd/mm/yy")#'
			)
		</cfquery>
	<cfelse>
		<cfquery name="insertpost4" datasource="#dts#">
			insert into glpost9 
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
				bdate
			)
			values 
			(
				'#getartran.type#',
				'#xaccno#',
				'#ceiling(getartran.fperiod)#',
				'#dateformat(getartran.wos_date,"dd/mm/yy")#',
				'#billno#',
				'#getartran.name#',
				'#numberformat(getartran.discount,".__")#',
				'#numberformat(getartran.disc1_bil,".__")#',
				'#getartran.currrate#',
				'',
				'#getartran.rem6#',
				'#dateformat(getartran.wos_date,"dd/mm/yy")#'
			)
		</cfquery>
		
		<cfquery name="insertpost4" datasource="#dts#">
			insert into glpost91 
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
				bdate
			)
			values 
			(
				'#getartran.type#',
				'#xaccno#',
				'#ceiling(getartran.fperiod)#',
				'#dateformat(getartran.wos_date,"dd/mm/yy")#',
				'#billno#',
				'#getartran.name#',
				'#numberformat(getartran.discount,".__")#',
				'#numberformat(getartran.disc1_bil,".__")#',
				'#getartran.currrate#',
				'',
				'#getartran.rem6#',
				'#dateformat(getartran.wos_date,"dd/mm/yy")#'
			)
		</cfquery>
	</cfif>		
</cfif>