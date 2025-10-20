<cfset sessionTracker = createObject("java","coldfusion.runtime.SessionTracker")>
<cfdump var="#sessionTracker#">

<cfset sessionCount = sessionTracker.getSessionCount()>
<p>
There are currently <cfoutput>#sessionCount#</cfoutput> sessions in existence on your server instance.
</p>

<cfset sessionCollection = sessionTracker.getSessionCollection(application.applicationName)>
<cfdump var="#sessionCollection#">