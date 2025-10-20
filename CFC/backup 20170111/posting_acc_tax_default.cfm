<cfoutput>
<!---
<tr>
	<td><cfif hcomid eq "kingston_i">123123</cfif>#getartran.type#</td>
	<td>#getartran.refno#</td>
	<td>#dateformat(getartran.wos_date,"dd/mm/yyyy")#</td>--->
<!--- 	<cfif getartran.currrate neq 1>
    <cfset netamt = numberformat(getartran.net,'.__')>
    <cfset grandamt = numberformat(getartran.grand,'.__')>
    <cfset getartran.tax = grandamt - netamt >
	</cfif> --->
	<!--- <cfif getartran.type eq "RC" or getartran.type eq "CN" or getartran.type eq "PR"> --->
	<cfif getartran.type eq "RC" or getartran.type eq "CN">
    	<cfif val(getartran.tax) lt 0>
			<cfset acctype = "Cr">			
            
            <!--- <cfif getartran.type eq "RC" or getartran.type eq "PR"> --->
            <cfif getartran.type eq "RC">
                <cfset xaccno = getaccno.gstpurchase>				
            <cfelse>
                <cfset xaccno = getaccno.gstsales>
            </cfif>
            <!---
            <td></td>
            <td><div align="right">#numberformat(abs(getartran.tax),".__")#</div><cfset totcredit = totcredit + numberformat(abs(getartran.tax),".__")></td>		
        	--->
		<cfelse>
			<cfset acctype = "D">			
            
            <!--- <cfif getartran.type eq "RC" or getartran.type eq "PR"> --->
            <cfif getartran.type eq "RC">
                <cfset xaccno = getaccno.gstpurchase>				
            <cfelse>
                <cfset xaccno = getaccno.gstsales>
            </cfif>
            <!---
            <td><div align="right">#numberformat(getartran.tax,".__")#</div><cfset totdebit = totdebit + numberformat(getartran.tax,".__")></td>
            <td></td>
			--->
        </cfif>
	<cfelse>
		<cfif val(getartran.tax) lt 0>
         <cfset acctype = "D">
            <cfif getartran.type eq "PR">
                <cfset xaccno = getaccno.gstpurchase>	
            <cfelse>
                <cfset xaccno = getaccno.gstsales>
            </cfif>
            <!---
            <td><div align="right">#numberformat(abs(getartran.tax),".__")#</div><cfset totdebit = totdebit + numberformat(abs(getartran.tax),".__")></td>
            <td></td>--->
        <cfelse>
            <cfset acctype = "Cr">
            <cfif getartran.type eq "PR">
                <cfset xaccno = getaccno.gstpurchase>	
            <cfelse>
                <cfset xaccno = getaccno.gstsales>
            </cfif>
            <!---<td></td>
            <td><div align="right">#numberformat(getartran.tax,".__")#</div><cfset totcredit = totcredit + numberformat(getartran.tax,".__")></td>
        	--->
		</cfif>
	</cfif>
	
	<!--- ADD ON 09-10-2009 --->
	<cfif getartran.note neq "">
		<cfquery name="gettaxcode" datasource="#dts#">
			SELECT corr_accno FROM #target_taxtable# 
			WHERE code=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.note#"> LIMIT 1
		</cfquery>
		<cfif gettaxcode.recordcount neq 0 and gettaxcode.corr_accno neq "" and gettaxcode.corr_accno neq "0000/000">
			<cfset xaccno = gettaxcode.corr_accno>	
		</cfif>
	</cfif>
    <!---
	<td><div align="left">#getartran.note# <cfif val(getartran.taxp1) neq 0>#val(getartran.taxp1)# %</cfif></div></td>
	<td>#ceiling(getartran.fperiod)#</td>
	<td>#xaccno#</td>				
	<td>#acctype#</td>		
	<td nowrap>#getartran.name#</td>
    <td nowrap>#getartran.agenno#</td>
</tr>--->
<cfif xaccno eq "" or xaccno eq "0000/000">
	<cfset noaccno="Y">
</cfif>
</cfoutput>
	<cfif getartran.type eq "RC" and getmodulecontrol.malaysiagst eq "1" and getartran.tax gt getaccno.malaysiagstmax and (getartran.name eq "" or getartran.frem2 eq "")>

        <cfquery name="insertpost3" datasource="#dts#">
			insert into glposttemp 
			(
				acc_code,
				accno,
				fperiod,date,
				reference,
                refno,
				desp,
                <cfif val(getartran.tax) lt 0>
                creditamt,
                <cfelse>
				debitamt,
                </cfif>
				fcamt,
				exc_rate,
				rem4,
				rem5,
				bdate,userid,TAXPEC,agent,uuid,source,job
			)
			values 
			(
				'#getartran.type#',
				'#xaccno#',
				'#ceiling(getartran.fperiod)#',
				#getartran.wos_date#,
				'#billno#',
                '#getartran.refno2#',
				'#getartran.name#',
				'#numberformat(abs(getaccno.malaysiagstmax),".__")#',
                '#numberformat((abs(getaccno.malaysiagstmax)),".__")#',
				'#getartran.currrate#',
				'#getartran.note#',
				'#getartran.rem6#',
				#getartran.wos_date#,'#HUserID#','#val(getartran.taxp1)#','#getartran.agenno#','#uuid#','#getartran.source#','#getartran.job#'
			)
		</cfquery>
        
        <cfquery name="getexpensesacc" datasource="#dts#">
        	select * from #replacenocase(LCASE(dts),"_i","_a","all")#.gldata where acctype="M";
        </cfquery>
        
        <cfquery name="insertpost3" datasource="#dts#">
			insert into glposttemp 
			(
				acc_code,
				accno,
				fperiod,date,
				reference,
                refno,
				desp,
				debitamt,
				fcamt,
				exc_rate,
				rem4,
				rem5,
				bdate,userid,TAXPEC,agent,uuid,source,job
			)
			values 
			(
				'#getartran.type#',
				'#getexpensesacc.accno#',
				'#ceiling(getartran.fperiod)#',
				#getartran.wos_date#,
				'#billno#',
                '#getartran.refno2#',
				'#getartran.name#',
				'#numberformat(abs(getartran.tax-getaccno.malaysiagstmax),".__")#',
                '#numberformat((abs((getartran.tax1_bil)-(getaccno.malaysiagstmax/getartran.currrate))),".__")#',
				'#getartran.currrate#',
				'#getartran.note#',
				'#getartran.rem6#',
				#getartran.wos_date#,'#HUserID#','#val(getartran.taxp1)#','#getartran.agenno#','#uuid#','#getartran.source#','#getartran.job#'
			)
		</cfquery>
        
        
    
	<cfelseif getartran.type eq "RC" or getartran.type eq "CN"<!---  or getartran.type eq "PR" --->>
		<cfquery name="insertpost3" datasource="#dts#">
			insert into glposttemp 
			(
				acc_code,
				accno,
				fperiod,date,
				reference,
                refno,
				desp,
                <cfif val(getartran.tax) lt 0>
                creditamt,
                <cfelse>
				debitamt,
                </cfif>
				fcamt,
				exc_rate,
				rem4,
				rem5,
				bdate,userid,TAXPEC,agent,uuid,source,job
			)
			values 
			(
				'#getartran.type#',
				'#xaccno#',
				'#ceiling(getartran.fperiod)#',
				#getartran.wos_date#,
				'#billno#',
                '#getartran.refno2#',
				'#getartran.name#',
				'#numberformat(abs(getartran.tax),".__")#',
                <cfif val(getartran.tax) lt 0>
				'#numberformat(-(abs(getartran.tax1_bil)),".__")#',
                <cfelse>
                '#numberformat((abs(getartran.tax1_bil)),".__")#',
                </cfif>
				'#getartran.currrate#',
				'#getartran.note#',
				'#getartran.rem6#',
				#getartran.wos_date#,'#HUserID#','#val(getartran.taxp1)#','#getartran.agenno#','#uuid#','#getartran.source#','#getartran.job#'
			)
		</cfquery>
		<cfelseif (getmodulecontrol.malaysiagst eq "1" and getartran.type eq "CS" and getartran.tax gt getaccno.malaysiagstmax) or (getmodulecontrol.malaysiagst eq "1" and (getartran.name eq "" or getartran.frem2 eq "") and getartran.tax gt getaccno.malaysiagstmax)>
    	<cfquery name="insertpost3" datasource="#dts#">
			insert into glposttemp
			(
				acc_code,
				accno,
				fperiod,
				date,
				reference,
                refno,
				desp,
				creditamt,
				fcamt,
				exc_rate,
				rem4,
				rem5,
				bdate,userid,TAXPEC,agent,uuid,source,job
			)
			values 
			(
				'#getartran.type#',
				'#xaccno#',
				'#ceiling(getartran.fperiod)#',
				#getartran.wos_date#,
				'#billno#',
                '#getartran.refno2#',
				'Tax',
				'#numberformat(abs(getaccno.malaysiagstmax),".__")#',
				'#numberformat(-(abs(getaccno.malaysiagstmax/getartran.currrate)),".__")#',
				'#getartran.currrate#',
				'#getartran.note#',
				'#getartran.rem6#',
				#getartran.wos_date#,'#HUserID#','#val(getartran.taxp1)#','#getartran.agenno#','#uuid#','#getartran.source#','#getartran.job#'
			)
		</cfquery>
        
        <cfquery name="getexpensesacc" datasource="#dts#">
        	select * from #replacenocase(LCASE(dts),"_i","_a","all")#.gldata where acctype="M";
        </cfquery>
        
        <cfquery name="insertpost3" datasource="#dts#">
			insert into glposttemp
			(
				acc_code,
				accno,
				fperiod,
				date,
				reference,
                refno,
				desp,
				creditamt,
				fcamt,
				exc_rate,
				rem4,
				rem5,
				bdate,userid,TAXPEC,agent,uuid,source,job
			)
			values 
			(
				'#getartran.type#',
				'#getexpensesacc.accno#',
				'#ceiling(getartran.fperiod)#',
				#getartran.wos_date#,
				'#billno#',
                '#getartran.refno2#',
				'Expenses',
				'#numberformat(abs(getartran.tax-getaccno.malaysiagstmax),".__")#',
				'#numberformat(-(abs((getartran.tax1_bil)-(getaccno.malaysiagstmax/getartran.currrate))),".__")#',
				'#getartran.currrate#',
				'#getartran.note#',
				'#getartran.rem6#',
				#getartran.wos_date#,'#HUserID#','#val(getartran.taxp1)#','#getartran.agenno#','#uuid#','#getartran.source#','#getartran.job#'
			)
		</cfquery>
        
    	
	<cfelse>
		<cfquery name="insertpost3" datasource="#dts#">
			insert into glposttemp
			(
				acc_code,
				accno,
				fperiod,
				date,
				reference,
                refno,
				desp,
                <cfif val(getartran.tax) lt 0>
                debitamt,
				<cfelse>
				creditamt,
                </cfif>
				fcamt,
				exc_rate,
				rem4,
				rem5,
				bdate,userid,TAXPEC,agent,uuid,source,job
			)
			values 
			(
				'#getartran.type#',
				'#xaccno#',
				'#ceiling(getartran.fperiod)#',
				#getartran.wos_date#,
				'#billno#',
                '#getartran.refno2#',
				'#getartran.name#',
				'#numberformat(abs(getartran.tax),".__")#',
                <cfif val(getartran.tax) lt 0>
                '#numberformat(abs(getartran.tax1_bil),".__")#',
				<cfelse>
				'#numberformat(-(abs(getartran.tax1_bil)),".__")#',
                </cfif>
				'#getartran.currrate#',
				'#getartran.note#',
				'#getartran.rem6#',
				#getartran.wos_date#,'#HUserID#','#val(getartran.taxp1)#','#getartran.agenno#','#uuid#','#getartran.source#','#getartran.job#'
			)
		</cfquery>
		
	
	</cfif>