<cfquery name="notexist" datasource="main">
SELECT * FROM useraccountlimit
</cfquery>

<cfquery name="backupdb" datasource="main">
SELECT schema_name FROm information_schema.SCHEMATA 
where schema_name <> "information_schema" 
and schema_name <> "mysql" 
and right(schema_name,2) = "_i"
and schema_name not in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(notexist.companyid)#" separator="," list="yes">)
</cfquery>



<cfloop query="backupdb">
<cfset dts = backupdb.schema_name>
<cftry>
<cfquery name="getdata" datasource="#dts#">
SELECT * FROM gsetup
</cfquery>

<cfquery name="insert_userlimit" datasource="main">
INSERT INTO 
useraccountlimit 
(
companyid,
usercount,
remark,
compro,
period,
lastaccyear

) 
VALUES 
(
"#dts#",
"3",
"",
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getdata.compro#">,
"#getdata.period#",
"#dateformat(getdata.lastaccyear,'yyyy-mm-dd')#"
)
</cfquery>
<cfcatch type="any">
<cfoutput>
#dts# - #cfcatch.Detail#<br>
</cfoutput>
</cfcatch>
</cftry>
</cfloop>