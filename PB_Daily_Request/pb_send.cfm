<cfdirectory action="list" directory="#ExpandPath('Report')#" recurse="true" listinfo="name" name="qFile" sort="name DESC"/>

<cfif #qFile.recordcount# NEQ 0>
	<cfmail from="donotreply@manpower.com.my" to="alvin.hen@manpower.com.my,alvinh.mpg@gmail.com" failto="alvin.hen@manpower.com.my" subject="Daily PB Request" type="HTML">
		<p>Dear All, </p>

		<p>Attached is the PB Requested file for #DateFormat(DateAdd('d', -1, now()), 'YYYY-MM-DD')#.</p>
        
        <cfloop query="qFile">
            <cfmailparam file="#ExpandPath('Report/')##qFile.name#">
        </cfloop>
	</cfmail>

	<!--- <cfloop query="qFile">
		<cffile action="delete" file="#ExpandPath('Report/')##qFile.name#">
	</cfloop> --->
</cfif>