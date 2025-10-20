<!---iclink --->
<cfquery name="moveiclink" datasource="importfromdbf">
SELECT * FROM iclink
</cfquery>

<cfloop query="moveiclink">

<cfquery name="inserticlink" datasource="#dts#">
INSERT IGNORE INTO iclink
(
TYPE,
REFNO,
TRANCODE,
WOS_DATE,
FRTYPE,
FRREFNO,
FRTRANCODE,
FRDATE,
ITEMNO,
QTY

)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveiclink.TYPE)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveiclink.REFNO)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveiclink.TRANCODE)#">,
"#dateformat(date,'YYYY-MM-DD')#",
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveiclink.FRTYPE)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveiclink.FRREFNO)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveiclink.FRTRANCODE)#">,
"#dateformat(FRDATE,'YYYY-MM-DD')#",
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveiclink.itemno)#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#val(moveiclink.QTY)#">

)
</cfquery>

</cfloop>

