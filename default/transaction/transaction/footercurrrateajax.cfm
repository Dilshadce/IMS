		<cfsetting showdebugoutput="no">
        <cfquery name="getGsetup" datasource="#dts#">
        select * from gsetup
        </cfquery>
        
        <cfquery name="currency" datasource="#dts#">
  			select * 
			from #target_currency# 
            where currcode='#url.footercurrcode#'
		</cfquery>
        <cfset rates2=1>
  			<cfset lastaccyear = dateformat(getGsetup.lastaccyear, "dd/mm/yyyy")>
			<cfset period = getGsetup.period>
			<cfset currentdate = dateformat(url.date,"dd/mm/yyyy")>
			<cfset tmpYear = year(currentdate)>
			<cfset clsyear = year(lastaccyear)>
			<cfset tmpmonth = month(currentdate)>
			<cfset clsmonth = month(lastaccyear)>
			<cfset intperiod = (tmpyear - clsyear) * 12 + tmpmonth - clsmonth>

			<cfif intperiod gt 18 or intperiod lte 0>
				<cfset readperiod = 99>
			<cfelse>
				<cfset readperiod = numberformat(intperiod,"00")>
			</cfif>

			<cfif readperiod eq '01'>
				<cfset rates2 = currency.CurrP1>
			</cfif>

			<cfif readperiod eq '02'>
				<cfset rates2 = currency.CurrP2>
			</cfif>

	<cfif readperiod eq '03'>
		<cfset rates2 = currency.CurrP3>
	</cfif>

	<cfif readperiod eq '04'>
		<cfset rates2 = currency.CurrP4>
	</cfif>

	<cfif readperiod eq '05'>
		<cfset rates2 = currency.CurrP5>
	</cfif>

	<cfif readperiod eq '06'>
		<cfset rates2 = currency.CurrP6>
	</cfif>

	<cfif readperiod eq '07'>
		<cfset rates2 = currency.CurrP7>
	</cfif>

	<cfif readperiod eq '08'>
		<cfset rates2 = currency.CurrP8>
	</cfif>

	<cfif readperiod eq '09'>
		<cfset rates2 = currency.CurrP9>
	</cfif>

	<cfif readperiod eq '10'>
		<cfset rates2 = currency.CurrP10>
	</cfif>

	<cfif readperiod eq '11'>
		<cfset rates2 = currency.CurrP11>
	</cfif>

	<cfif readperiod eq '12'>
		<cfset rates2 = currency.CurrP12>
	</cfif>

	<cfif readperiod eq '13'>
		<cfset rates2 = currency.CurrP13>
	</cfif>

	<cfif readperiod eq '14'>
		<cfset rates2 = currency.CurrP14>
	</cfif>

	<cfif readperiod eq '15'>
		<cfset rates2 = currency.CurrP15>
	</cfif>

	<cfif readperiod eq '16'>
		<cfset rates2 = currency.CurrP16>
	</cfif>

	<cfif readperiod eq '17'>
		<cfset rates2 = currency.CurrP17>
	</cfif>

	<cfif readperiod eq '18'>
		<cfset rates2 = currency.CurrP18>
	</cfif>
    
    <cfif readperiod eq '99' and getgsetup.allowedityearend eq "Y" >
    	<cfset rates2 = currency.CurrP1>
	</cfif>

	<cfif readperiod eq '00'>
		<cfset rates2 = 1>
	</cfif>
<cfoutput>
<input name="footercurrrate" id="footercurrrate" type="text" size="10" value="#Numberformat(rates2, '._____')#">
</cfoutput>