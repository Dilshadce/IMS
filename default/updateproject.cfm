<cfquery name="getProject" datasource="#dts#">
SELECT * FROM PROJECT
</cfquery>

<cfloop query="getProject">
<cfquery name="getprojectvalid" datasource="#replacenocase(dts,"_i","_a","all")#">
SELECT * FROM PROJECT WHERE source = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getProject.source#">
</cfquery>

<cfif getprojectvalid.recordcount eq 0>
<cfquery name="insert" datasource="#replacenocase(dts,"_i","_a","all")#">
INSERT INTO project (SOURCE, PROJECT, PORJ, COMPLETED, CONTRSUM, DETAIL1, DETAIL2, DETAIL3)
VALUES (
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getProject.SOURCE#">, 
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getProject.PROJECT#">, 
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getProject.PORJ#">, 
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getProject.COMPLETED#">, 
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getProject.CONTRSUM#">, 
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getProject.DETAIL1#">, 
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getProject.DETAIL2#">, 
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getProject.DETAIL3#">
)
</cfquery>
</cfif>

</cfloop>