<cfquery name="deletedb" datasource="#dts#">
select concat(b.newname,"_a") as accnouse from(select a.newname,count(newname) as countnewname from
(
SELECT left(schema_name,length(schema_name)-2) as newname FROm information_schema.SCHEMATA
where schema_name <> "information_schema" and schema_name <> "mysql" and (right(schema_name,2) = "_a" or right(schema_name,2) = "_i")
) as a
group by a.newname) as b where b.countnewname = 1 and concat(newname,"_a") in (select schema_name from information_schema.SCHEMATA)
</cfquery>
<cfloop query="deletedb">
<cftry>
<cfquery name="dropdb" datasource="main">
DROP database #deletedb.accnouse#
</cfquery>
<cfcatch type="any">
<cfoutput>
#cfcatch.Detail#
</cfoutput>
</cfcatch>
</cftry>
</cfloop>