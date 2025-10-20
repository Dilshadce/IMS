<!---brand --->
<cfquery name="movebrand" datasource="importfromdbf">
SELECT * FROM brand
</cfquery>

<cfloop query="movebrand">

<cfquery name="insertbrand" datasource="#dts#">
INSERT IGNORE INTO brand
(
brand,
desp
)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(movebrand.brand)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(movebrand.desp)#">

)
</cfquery>

</cfloop>

