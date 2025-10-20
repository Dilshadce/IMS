<cfdirectory action="list" directory="#ExpandPath('Report')#" recurse="true" listinfo="name" name="qFile" sort="name DESC"/>
<cfloop query="qFile">
	<cffile action="delete" file="#ExpandPath('Report/')##qFile.name#">
</cfloop>