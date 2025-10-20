<cfsilent>
<cfset value = "">
<cfset tabchr = Chr(13) & Chr(10)> 

<cfset error = 0>
<cfset msg = "">
<cfset itemno = URLDecode(itemno)>
<cfquery name="getinfo" datasource="#dts#">
	delete from iserial
    where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#itemno#">
	and serialno='#oriserialno#'
	and location = '#location#'
	and sign = '1'
	and type = 'ADD'
</cfquery>

<cfset header = "count|error|msg|counter">
<cfset value = "1|#error#|#msg#|#counter##tabchr#">	
</cfsilent><cfoutput>#header##tabchr##value#</cfoutput>