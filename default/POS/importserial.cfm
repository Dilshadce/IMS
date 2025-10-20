<cfquery name="gettype" datasource="#trim(dts)#">
select * from FTPDETAIL
</cfquery>


<cfquery name="getserial" datasource="#trim(poswsdts)#">
SELECT * FROM iserial9 where type<>'' <cfif gettype.inv eq 1>or type='INV'</cfif> <cfif gettype.do eq 1>or type='DO'</cfif> <cfif gettype.cn eq 1>or type='CN'</cfif> <cfif gettype.dn eq 1>or type='DN'</cfif> <cfif gettype.cs eq 1>or type='CS'</cfif> <cfif gettype.quo eq 1>or type='QUO'</cfif> <cfif gettype.so eq 1>or type='SO'</cfif> <cfif gettype.po eq 1>or type='PO'</cfif> <cfif gettype.rc eq 1>or type='RC'</cfif> <cfif gettype.pr eq 1>or type='PR'</cfif>
</cfquery>

<cfloop query="getserial">
<cftry>
<cfquery name="INSERTserial" datasource="#trim(dts)#">
INSERT IGNORE INTO iserial
(
REFNO,
REFNO2,
TYPE,
TRANCODE,
WOS_DATE,
FPERIOD,
SERIALNO,
ITEMNO,
DESP,
DESPA,
PRICE,
LOCATION,
SIGN,
CUSTNO,
AGENNO,
SOURCE,
JOB,
CURRRATE,
VOID,
EXPORTED,
GENERATED
)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getposdetail.posbill##REPLACE(getserial.REFNO," ","",'all')#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getserial.REFNO2)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getserial.TYPE)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getserial.TRANCODE)#">,
"#trim(dateformat(getserial.DATE,'YYYY-MM-DD'))#",
"#trim(numberformat(getserial.FPERIOD,'00'))#",
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getserial.SERIALNO)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getserial.ITEMNO)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getserial.DESP)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getserial.DESPA)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getserial.PRICE)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getserial.LOCATION)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getserial.SIGN)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getserial.CUSTNO)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getserial.AGENNO)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getserial.SOURCE)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getserial.JOB)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getserial.CURRRATE)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getserial.VOID)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getserial.EXPORTED)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getserial.GENERATED)#">
)
</cfquery>
<cfcatch type="any">
</cfcatch>
</cftry>

</cfloop>