<cfquery name="getall" datasource="main">
select userbranch 
			from users 
			where userDept not like '%_a'
            and userDept not in ('cyt_i','hom_i','mj_i','oilestates_a','pwd_i','steel05_i','steel_i','marujyu_i')
			group by userbranch order by userbranch;
</cfquery>

<cfloop query="getall">

<cfset dts = getall.userbranch>
<cfquery name="getcominfo" datasource="main">
    select compro,LastAccYear,period from #dts#.gsetup
</cfquery>

<cfquery name="updateaccount" datasource="main">
UPDATE useraccountlimit SET
compro = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getcominfo.compro#">,
period = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getcominfo.period#">,
lastaccyear = "#dateformat(getcominfo.LastAccYear,'YYYY-MM-DD')#"
WHERE companyid = "#dts#"
</cfquery>
            
</cfloop>

