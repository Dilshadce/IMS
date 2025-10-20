<!---locqdbf--->
<cfquery name="movelocqdbf" datasource="importfromdbf">
SELECT * FROM locqdbf
</cfquery>

<cfloop query="movelocqdbf">

<cfquery name="insertlocqdbf" datasource="#dts#">
INSERT IGNORE INTO locqdbf
(
ITEMNO,
LOCATION,
LOCQFIELD,
LOCQACTUAL,
LOCQTRAN,
LMINIMUM,
LREORDER,
QTY_BAL,
VAL_BAL,
PRICE,
WOS_GROUP,
CATEGORY,
SHELF,
SUPP

)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(movelocqdbf.ITEMNO)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(movelocqdbf.LOCATION)#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#val(movelocqdbf.LOCQFIELD)#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#val(movelocqdbf.LOCQACTUAL)#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#val(movelocqdbf.LOCQTRAN)#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#val(movelocqdbf.LMINIMUM)#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#val(movelocqdbf.LREORDER)#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#val(movelocqdbf.QTY_BAL)#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#val(movelocqdbf.VAL_BAL)#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#val(movelocqdbf.PRICE)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(movelocqdbf.GROUP)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(movelocqdbf.CATEGORY)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(movelocqdbf.SHELF)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(movelocqdbf.SUPP)#">

)
</cfquery>

</cfloop>

