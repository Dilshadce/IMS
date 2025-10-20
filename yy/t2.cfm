<cfscript>
		missing = [];
</cfscript>

<cfhttp method="get" url="https://operation.mp4u.com.my/yy/a.csv" name="csvData">

	<cfdump var="#csvData#">
	<cfexit>
<cfloop query="csvdata" >
	<cfscript>
	ArrayAppend(missing,{
		empno : csvdata['Job Order'][currentRow],
	});
</cfscript>
	<cfdump var="#missing#">
</cfloop>
