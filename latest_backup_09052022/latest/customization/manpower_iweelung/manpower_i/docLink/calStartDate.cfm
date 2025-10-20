<cfoutput>
	<cfset startDate = DateAdd('m', -url.monthsBefore, url.expiryDate)>
    <input type="hidden" id="hidStartDate" name="hidStartDate" value="#DateFormat(startDate, 'dd/mm/yyyy')#" />
</cfoutput>