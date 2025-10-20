<cfloop list="#form.empno#" index="i">
<cfquery name="addTip_qry" datasource="#dts#">
UPDATE paytra1 
SET 
tippoint = <cfqueryparam value="#numberformat(evaluate('form.tippoint__r#i#'),'.__')#" cfsqltype="cf_sql_varchar"> 
WHERE empno = "#i#"
</cfquery>
</cfloop>

<cflocation url = "assignMain.cfm">