<cfloop from=1 to="#listlen(form.empno)#" index="i">
<cfquery name="update" datasource="#dts#">
UPDATE paytra1
set zakat_bf = <cfqueryparam value="#numberformat(evaluate('form.zakat_bf_#i#'),'.__')#" cfsqltype="cf_sql_varchar"> 

WHERE empno= "#listgetat(form.empno,i)#"
</cfquery>
</cfloop>
<cflocation url="/payments/1stHalf/addUpdate/addModifyZakatMain.cfm">