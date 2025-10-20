<cfoutput>
<tr>
	<td>#getartran.type#</td>
	<td>#getartran.refno#</td>
	<td>#dateformat(getartran.wos_date,"dd/mm/yyyy")#</td>
	
	<!--- <cfif getartran.type eq "RC" or getartran.type eq "CN" or getartran.type eq "PR"> --->
	<cfif getartran.type eq "RC" or getartran.type eq "CN">
		<cfset acctype = "D">			
		
		<!--- <cfif getartran.type eq "RC" or getartran.type eq "PR"> --->
		<cfif getartran.type eq "RC">
			<cfset xaccno = getaccno.gstpurchase>				
		<cfelse>
			<cfset xaccno = getaccno.gstsales>
		</cfif>
		<td><div align="right">#numberformat(getartran.tax,".__")#</div></td>
		<td></td>
	<cfelse>
		<cfset acctype = "Cr">
		<cfif getartran.type eq "PR">
			<cfset xaccno = getaccno.gstpurchase>
		<cfelse>
			<cfset xaccno = getaccno.gstsales>
		</cfif>
		<td></td>
		<td><div align="right">#numberformat(getartran.tax,".__")#</div></td>
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
	
	<td><div align="left">#getartran.note# <cfif val(getartran.taxp1) neq 0>#val(getartran.taxp1)# %</cfif></div></td>
	<td>#ceiling(getartran.fperiod)#</td>
	<td>#xaccno#</td>				
	<td>#acctype#</td>		
	<td nowrap>#getartran.name#</td>
    <td nowrap>#getartran.source#</td>
    <td nowrap>#getartran.job#</td>
</tr>
</cfoutput>