<!---obbatch --->
<cfquery name="moveobbatch" datasource="importfromdbf">
SELECT * FROM obbatch
</cfquery>

<cfloop query="moveobbatch">

<cfquery name="insertobbatch" datasource="#dts#">
INSERT IGNORE INTO obbatch
(
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
Exp_date,
manu_date,
Rc_type,
Rc_refno,
Rc_expdate,
milcert

)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveobbatch.Batchcode)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveobbatch.Itemno)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveobbatch.Type)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveobbatch.Refno)#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#val(moveobbatch.Bth_qob)#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#val(moveobbatch.Bth_qin)#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#val(moveobbatch.Bth_qut)#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#val(moveobbatch.Rpt_qob)#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#val(moveobbatch.Rpt_qin)#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#val(moveobbatch.Rpt_qut)#">,
"#dateformat(Expdate,'YYYY-MM-DD')#",
'0000-00-00',
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveobbatch.Rc_type)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveobbatch.Rc_refno)#">,
"#dateformat(Rc_expdate,'YYYY-MM-DD')#",
''
)
</cfquery>

</cfloop>

