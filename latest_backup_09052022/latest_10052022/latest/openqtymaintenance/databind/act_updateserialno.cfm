<cfsilent>
<cfset value = "">
<cfset tabchr = Chr(13) & Chr(10)> 

<cfset error = 0>
<cfset msg = "">

<cfquery name="getinfo" datasource="#dts#">
	select * from iserial
    where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#itemno#">
	and serialno='#serialno#'
	and serialno != '#oriserialno#'
	limit 1
</cfquery>

<cfif getinfo.recordcount neq 0>
	<cfset error = 1>
	<cfset msg = "Serial No: " & "#serialno#" & " already exist!">
<cfelse>
	<cfif wos_date neq "">
		<cfset date1 = createDate(ListGetAt(wos_date,3,"/"),ListGetAt(wos_date,2,"/"),ListGetAt(wos_date,1,"/"))>
	<cfelse>
		<cfset date1 = "">
	</cfif>
	<cfquery name="update" datasource="#dts#">
		update iserial
		set serialno = '#serialno#',
		location = '#location#'
		<cfif wos_date neq "">,wos_date = #date1#</cfif>
		where type = 'ADD'
		and refno = '000000'
		and location = '#orilocation#'
		and serialno = '#oriserialno#'
		and itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#itemno#">
	</cfquery>
</cfif>

<cfset header = "count|error|msg">
<cfset value = "1|#error#|#msg##tabchr#">	
</cfsilent><cfoutput>#header##tabchr##value#</cfoutput>