<!--- <cfinclude template="/_dsp/dsp_header.cfm">
<cfif not len(getAuthUser())>
	<cfset request.loginmessage = "<br>You must be authorized to access that area ... Please login.">
	<cfinclude template="#Application.webroot#security/login.cfm">
</cfif> --->
<cfoutput>
<cfquery name="getBal" datasource="netiquette_c">
select * from trackipn where SBCR_ID = '#url.SUBSCR_ID# - #url.trialid#' and status = 'Verified' 
</cfquery>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<cfloop query="getBal">
<table class="data">
<tr> 
<th>Date</th><td colspan="15">
<cfloop list="#tostring(urldecode(ipndata))#" delimiters="&" index="bb">
<cfif findnocase('txn_id',tostring(urldecode(ipndata)))>
<cfif  findnocase('payment_date',bb)>
 #listlast(bb,'=')#
</cfif></cfif>
</cfloop>
</td>
</tr>
<tr><cfloop list="#tostring(urldecode(ipndata))#" delimiters="&" index="bb">
<cfif findnocase('txn_id',tostring(urldecode(ipndata)))>

<th>#listfirst(bb,'=')#</th>

</cfif>
</cfloop></tr>



<tr><cfloop list="#tostring(urldecode(ipndata))#" delimiters="&" index="bb">
<cfif findnocase('txn_id',tostring(urldecode(ipndata)))>
<td> #listlast(bb,'=')#</td>

</cfif>
</cfloop></tr></table>
</cfloop>

</cfoutput>