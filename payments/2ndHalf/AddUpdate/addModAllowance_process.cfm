<cfloop list="#form.empno#" index="i">
<cfquery name="update_qry" datasource="#dts#">
UPDATE paytran
SET aw101 = <cfqueryparam value="#evaluate('form.aw101__r#i#')#" cfsqltype="cf_sql_varchar">,
	aw102 = <cfqueryparam value="#evaluate('form.aw102__r#i#')#" cfsqltype="cf_sql_varchar">,
	aw103 = <cfqueryparam value="#evaluate('form.aw103__r#i#')#" cfsqltype="cf_sql_varchar">,
	aw104 = <cfqueryparam value="#evaluate('form.aw104__r#i#')#" cfsqltype="cf_sql_varchar">,
	aw105 = <cfqueryparam value="#evaluate('form.aw105__r#i#')#" cfsqltype="cf_sql_varchar">,
	aw106 = <cfqueryparam value="#evaluate('form.aw106__r#i#')#" cfsqltype="cf_sql_varchar">,
	aw107 = <cfqueryparam value="#evaluate('form.aw107__r#i#')#" cfsqltype="cf_sql_varchar">,
	aw108 = <cfqueryparam value="#evaluate('form.aw108__r#i#')#" cfsqltype="cf_sql_varchar">,
	aw109 = <cfqueryparam value="#evaluate('form.aw109__r#i#')#" cfsqltype="cf_sql_varchar">,
	aw110 = <cfqueryparam value="#evaluate('form.aw110__r#i#')#" cfsqltype="cf_sql_varchar">,
	aw111 = <cfqueryparam value="#evaluate('form.aw110__r#i#')#" cfsqltype="cf_sql_varchar">,
	aw112 = <cfqueryparam value="#evaluate('form.aw110__r#i#')#" cfsqltype="cf_sql_varchar">,
	aw113 = <cfqueryparam value="#evaluate('form.aw110__r#i#')#" cfsqltype="cf_sql_varchar">,
	aw114 = <cfqueryparam value="#evaluate('form.aw110__r#i#')#" cfsqltype="cf_sql_varchar">,
	aw115 = <cfqueryparam value="#evaluate('form.aw110__r#i#')#" cfsqltype="cf_sql_varchar">,
	aw116 = <cfqueryparam value="#evaluate('form.aw110__r#i#')#" cfsqltype="cf_sql_varchar">,
	aw117 = <cfqueryparam value="#evaluate('form.aw110__r#i#')#" cfsqltype="cf_sql_varchar">
WHERE empno= '#i#'
</cfquery>

</cfloop>
<cfabort>
<cflocation url ="addModAllowance.cfm">