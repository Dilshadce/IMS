<cfsilent>
<cfset value = "">
<cfset tabchr = Chr(13) & Chr(10)> 

<cfset error = 0>
<cfset msg = "">
<cfset itemno = URLDecode(itemno)>
<cfquery name="getinfo" datasource="#dts#">
	select * from iserial
    where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#itemno#">
	and serialno='#serialno#'
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
	<cfquery name="insert" datasource="#dts#">
		insert into iserial
		(type,refno,trancode,itemno,<cfif wos_date neq "">wos_date,</cfif>serialno,location,sign)
		values
		('ADD','000000',1,<cfqueryparam cfsqltype="cf_sql_char" value="#itemno#">,<cfif wos_date neq "">#date1#,</cfif>'#serialno#','#location#','1')
	</cfquery>
</cfif>

<cfset header = "count|error|msg|counter">
<cfset value = "1|#error#|#msg#|#counter##tabchr#">	
</cfsilent><cfoutput>#header##tabchr##value#</cfoutput>