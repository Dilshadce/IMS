<cfoutput>
<tr>
	<td>#getartran.type#</td>
	<td>#getartran.refno#</td>
	<td>#dateformat(getartran.wos_date,"dd/mm/yyyy")#</td>

	<cfif getartran.type eq "RC" or getartran.type eq "CN" or getartran.type eq "PR">
		<cfset acctype = "D">			
		
		<cfif getartran.type eq "RC" or getartran.type eq "PR">
			<cfset xaccno = getaccno.gstpurchase>				
		<cfelse>
			<cfset xaccno = getaccno.gstsales>
		</cfif>
		<td><div align="right">#numberformat(variables.gst_item_value,".__")#</div></td>
		<td></td>
	<cfelse>
		<cfset acctype = "Cr">
		<cfset xaccno = getaccno.gstsales>
		<td></td>
		<td><div align="right">#numberformat(variables.gst_item_value,".__")#</div></td>
	</cfif>
	
	<td><div align="center">GST</div></td>
	<td>#ceiling(getartran.fperiod)#</td>
	<td>#xaccno#</td>
	<td>#acctype#</td>
	<td nowrap>#getartran.name#</td>
</tr>
</cfoutput>
		
<cfif post eq "post">
	<cfif getartran.type eq "RC" or getartran.type eq "CN"<!---  or getartran.type eq "PR" --->>
		<cfquery name="insertpost3" datasource="#dts#">
			insert into glpost9 
			(
				acc_code,
				accno,
				fperiod,date,
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
				'#numberformat(variables.gst_item_value,".__")#',
				'#numberformat(variables.gst_item_value/getartran.currrate,".__")#',
				'#getartran.currrate#',
				'#getartran.note#',
				'#getartran.rem6#',
				'#dateformat(getartran.wos_date,"dd/mm/yy")#'
			)
		</cfquery>
		
		<cfquery name="insertpost3" datasource="#dts#">
			insert into glpost91 
			(
				acc_code,
				accno,
				fperiod,date,
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
				'#numberformat(variables.gst_item_value,".__")#',
				'#numberformat(variables.gst_item_value/getartran.currrate,".__")#',
				'#getartran.currrate#',
				'#getartran.note#',
				'#getartran.rem6#',
				'#dateformat(getartran.wos_date,"dd/mm/yy")#'
			)
		</cfquery>
	<cfelse>
		<cfquery name="insertpost3" datasource="#dts#">
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
				'#billno#',
				'#getartran.name#',
				'#numberformat(variables.gst_item_value,".__")#',
				'#numberformat(variables.gst_item_value/getartran.currrate,".__")#',
				'#getartran.currrate#',
				'#getartran.note#',
				'#getartran.rem6#',
				'#dateformat(getartran.wos_date,"dd/mm/yy")#'
			)
		</cfquery>
		
		<cfquery name="insertpost3" datasource="#dts#">
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
				'#numberformat(variables.gst_item_value,".__")#',
				'#numberformat(variables.gst_item_value/getartran.currrate,".__")#',
				'#getartran.currrate#',
				'#getartran.note#',
				'#getartran.rem6#',
				'#dateformat(getartran.wos_date,"dd/mm/yy")#'
			)
		</cfquery>
	</cfif>
</cfif>
		