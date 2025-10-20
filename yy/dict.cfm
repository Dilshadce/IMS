<cfscript>
	data = {
	 originalStartTimeZone : "originalStartTimeZone-value",
	 isReminderOn : true,
	 responseStatus : {
	 	response : "",
	 	time : "datetime-value"
	 }
	};

WriteOutput(serializeJson(data));
</cfscript>

<cfset data2 = {
	a : 'asdf'
}>

<cfdump var="#data2#">