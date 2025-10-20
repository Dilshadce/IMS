<cfoutput>

    <cfif findnocase('IMS',cgi.SERVER_NAME)>
    <cfset module = 'IMS'>
    <cfelse>
    <cfset module = 'AMS'>
    </cfif>


<cfquery name="getTrialId" datasource="Net_c">
select * from netiquette_c.trialaccount t left join net_c.usersystemaccount u on t.id = u.trialid where u.companyid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#replacenocase(replacenocase(replacenocase(replacenocase(dts,'_c','','all'),'_i','','all'),'_a','','all'),'_p','','all')#">
 and system = '#module#'
</cfquery>
<cfif gettrialid.paymentid eq ''>
<a href="/signupforfree/paymentHeader.cfm?id=#gettrialid.trialid#">#words[1801]#</a>
</cfif>
</cfoutput>