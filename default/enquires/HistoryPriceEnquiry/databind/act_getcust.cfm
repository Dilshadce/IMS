<cfsetting showdebugoutput="false"><cfsilent>
<cfset value = "">
<cfset tabchr = Chr(13) & Chr(10)> 

<cfif text neq "">
	<cfquery name="getcust" datasource="#dts#">
		select custno, name 
		from #target_arcust# 
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
	<cfif getcust.recordcount neq 0>
		<cfset custnolist = valuelist(getcust.custno,";;")>
		<cfset custnamelist = valuelist(getcust.name,";;")>
	<cfelse>
		<cfset custnolist = "-1">
		<cfset custnamelist = "No Record Found">
	</cfif>
<cfelse>
	<cfset custnolist = "-1">
	<cfset custnamelist = "Please Filter The Item">
</cfif>

<cfset header = "count|error|msg|custnolist|custnamelist">
<cfset value = "1|0|0|#URLEncodedFormat(custnolist)#|#URLEncodedFormat(custnamelist)##tabchr#">	
</cfsilent><cfoutput>#header##tabchr##value#</cfoutput>