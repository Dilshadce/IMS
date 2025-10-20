<cfquery datasource='#dts#' name='updateartranaddonremark'>
Update artran set 
rem30 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark30#">, 
rem31 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark31#">,
rem32 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark32#">, 
rem33 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark33#">, 
rem34 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark34#">, 
rem35 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark35#">,
rem36 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark36#">, 
rem37 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark37#">, 
rem38 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark38#">,
rem39 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark39#">,
rem40 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark40#">, 
rem41 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark41#">,
rem42 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark42#">, 
rem43 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark43#">, 
rem44 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark44#">, 
rem45 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark45#">,
rem46 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark46#">, 
rem47 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark47#">,
rem48 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark48#">,
rem49 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark49#">
            where refno = '#form.currefno#' and type = '#tran#'
		</cfquery>