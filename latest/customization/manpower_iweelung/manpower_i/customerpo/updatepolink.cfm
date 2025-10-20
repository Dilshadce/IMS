<cfprocessingdirective pageencoding="UTF-8">

<cfoutput>

<cfquery name="getpolist" datasource="#dts#">
	SELECT * FROM manpowerpolink where pono=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.refno)#">
</cfquery>

<cfset jolist=valuelist(getpolist.jono)>

<cfif form.jono neq "">

<cfloop from="1" to="#listlen(jono)#" index="i">

<cfif listfind(jolist,listgetat(form.jono,i,','),',') gt 0>

<cfelse>

<cfquery name="updatepolink" datasource="#dts#">
	INSERT INTO manpowerpolink (pono,jono,created_by,created_on)
	VALUES 
	(
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.refno)#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#listgetat(form.jono,i,',')#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#huserid#">,
	now()
	)
</cfquery>

</cfif>

</cfloop>
</cfif>

</cfoutput>