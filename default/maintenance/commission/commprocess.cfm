<cfquery name="checkexist" datasource="#dts#">
SELECT commname FROM commission WHERE commname = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.commname#">
</cfquery>
<cfif checkexist.recordcount neq 0>
</cfif>
<cfquery name="insertcomm" datasource="#dts#">
INSERT INTO commission (`commname`,`commdesp`,`wos_group`,`cate`,`brand`,`created_on`,`created_by`)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.commname#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.commdesp#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.group#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cate#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.brand#">,
now(),
<cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">
)
</cfquery>


<cfquery name="normalcomm" datasource="#dts#">
INSERT INTO commRate (commname,rangefrom,rangeto,rate,type)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.commname#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rangefrom#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rangeto#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rate#">,
"A"
)
</cfquery>

<cfloop list="group,cate,brand" index="a">
<cfset typedefined = evaluate("form.#a#")>
<cfif typedefined neq "">
<cfquery name="normalcomm" datasource="#dts#">
INSERT INTO commRate (commname,rangefrom,rangeto,rate,type,typeid)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.commname#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rangefrom#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rangeto#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rate#">,
<cfif a eq "brand">
"B"
<cfelseif a eq "group">
"C"
<cfelse>
"D"
</cfif>
,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#typedefined#">
)
</cfquery>
</cfif>
</cfloop>

<cfoutput>
<h1>Create Success!</h1>
<cfform action="createcomm.cfm" method="post" name="recreate">
<input type="submit" value="Create another commission" />&nbsp;&nbsp;&nbsp;<input type="button" value="close"  onclick="closenref();">
</cfform>
</cfoutput>
