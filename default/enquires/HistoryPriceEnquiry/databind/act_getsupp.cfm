<cfsetting showdebugoutput="false"><cfsilent>
<cfset value = "">
<cfset tabchr = Chr(13) & Chr(10)> 

<cfif text neq "">
	<cfquery name="getsupp" datasource="#dts#">
		select custno, name 
		from #target_apvend# 
        where 
        <cfif searchtype neq "" and text neq "">
			<cfif searchtype eq "custno">
				upper(custno) like '#ucase(text)#%'
			<cfelseif searchtype eq "name">
				upper(name) like '#ucase(text)#%'
                </cfif>
                </cfif>
		order by custno
	</cfquery>
	<cfif getsupp.recordcount neq 0>
		<cfset suppnolist = valuelist(getsupp.custno,";;")>
		<cfset suppnamelist = valuelist(getsupp.name,";;")>
	<cfelse>
		<cfset suppnolist = "-1">
		<cfset suppnamelist = "No Record Found">
	</cfif>
<cfelse>
	<cfset suppnolist = "-1">
	<cfset suppnamelist = "Please Filter The Item">
</cfif>

<cfset header = "count|error|msg|suppnolist|suppnamelist">
<cfset value = "1|0|0|#URLEncodedFormat(suppnolist)#|#URLEncodedFormat(suppnamelist)##tabchr#">	
</cfsilent><cfoutput>#header##tabchr##value#</cfoutput>