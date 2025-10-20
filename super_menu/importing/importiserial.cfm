<!---iserial --->
<cfquery name="moveiserial" datasource="importfromdbf">
SELECT * FROM iserial
</cfquery>

<cfloop query="moveiserial">

<cfquery name="insertiserial" datasource="#dts#">
INSERT IGNORE INTO iserial
(
TYPE,
REFNO,
REFNO2,
TRANCODE,
CUSTNO,
FPERIOD,
WOS_DATE,
DEL_BY,
ITEMNO,
DESP,
DESPA,
SERIALNO,
SEQ,
AGENNO,
LOCATION,
SOURCE,
JOB,
SIGN,
VOID,
PRICE,
OPERIOD

)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveiserial.TYPE)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveiserial.REFNO)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveiserial.REFNO2)#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#val(moveiserial.TRANCODE)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveiserial.CUSTNO)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveiserial.FPERIOD)#">,
"#dateformat(DATE,'YYYY-MM-DD')#",
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveiserial.DEL_BY)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveiserial.ITEMNO)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveiserial.DESP)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveiserial.DESPA)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveiserial.SERIALNO)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveiserial.SEQ)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveiserial.AGENNO)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveiserial.LOCATION)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveiserial.SOURCE)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveiserial.JOB)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveiserial.SIGN)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveiserial.VOID)#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#val(moveiserial.PRICE)#">,
''

)
</cfquery>

</cfloop>

