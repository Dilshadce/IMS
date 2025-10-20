<cfsilent>
<cfset value = "">
<cfset tabchr = Chr(13) & Chr(10)> 

<cfset error = 0>
<cfset msg = "">


<cfquery name="getinfo" datasource="#dts#">
	DELETE FROM iserial
    WHERE itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#itemno#">
	AND serialno='#oriserialno#'
	AND location = '#location#'
	AND sign = '1'
	AND type = 'ADD'
</cfquery>

<cfset header = "count|error|msg|counter">
<cfset value = "1|#error#|#msg#|#counter##tabchr#">	
</cfsilent><cfoutput>#header##tabchr##value#</cfoutput>