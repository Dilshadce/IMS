<html>
<head>
<title>Search Results</title>
</head>
<body>

<cfif isDefined ("form.keyword")>
<cfif #form.keyword# eq "">
Please key in a value.
<cfelse>
<cfquery name="getresult" datasource="#dts#">
SELECT *
FROM arpay
WHERE custno LIKE '%#form.keyword#%' limit 20
</cfquery>
<cfoutput>
<p>Your search for #form.keyword# returned #getresult.recordcount# results.</p>
</cfoutput>
<cfoutput query="getresult">#billno#<br></cfoutput>
</cfif>
</cfif>
</body>
</html>

