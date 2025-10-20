<!---lobthob --->
<cfquery name="movelobthob" datasource="importfromdbf">
SELECT * FROM lobthob
</cfquery>

<cfloop query="movelobthob">

<cfquery name="insertlobthob" datasource="#dts#">
INSERT IGNORE INTO lobthob
(
Location,
Batchcode,
Itemno,
Type,
Refno,
Bth_qob,
Bth_qin,
Bth_qut,
Rpt_qob,
Rpt_qin,
Rpt_qut,
Expdate,
manudate,
Rc_type,
Rc_refno,
Rc_expdate,
milcert

)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(movelobthob.Location)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(movelobthob.Batchcode)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(movelobthob.Itemno)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(movelobthob.Type)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(movelobthob.Refno)#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#val(movelobthob.Bth_qob)#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#val(movelobthob.Bth_qin)#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#val(movelobthob.Bth_qut)#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#val(movelobthob.Rpt_qob)#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#val(movelobthob.Rpt_qin)#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#val(movelobthob.Rpt_qut)#">,
"#dateformat(Expdate,'YYYY-MM-DD')#",
'0000-00-00',
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(movelobthob.Rc_type)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(movelobthob.Rc_refno)#">,
"#dateformat(Rc_expdate,'YYYY-MM-DD')#",
''

)
</cfquery>

</cfloop>

