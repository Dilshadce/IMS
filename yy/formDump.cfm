<cfscript>
for(field in form.fieldNames){
		form[field] = trim(form[field]);
		WriteOutput(field & " : " & form[field] & "");
	}
</cfscript>
<cfsetting showDebugOutput="No">
<cfexit>