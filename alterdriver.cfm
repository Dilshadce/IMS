<html>
<head></head>
<body>
<cfquery name="getcompany" datasource="main">
	SELECT userDept,linktoams FROM users where 
	userDept not in ('cyt_i','hom_i','mj_i','oilestates_a','pwd_i','steel05_i','steel_i','marujyu_i','anglomlw08_i')
	and userDept not like '%_a' group by userDept
</cfquery>

<cfloop query="getcompany">
	<cfset dts=getcompany.userDept>
    <cftry>
        <cfquery name="updategsetup" datasource="#dts#">
	ALTER TABLE `iserial` ADD INDEX `SERIALCHECK`(`ITEMNO`, `SERIALNO`, `LOCATION`, `SIGN`);
        </cfquery>
	<cfcatch type="any">
		<cfoutput>#dts#-#cfcatch.Message#:#cfcatch.Detail#</cfoutput><br>	
	</cfcatch>
	</cftry>
</cfloop>
Finish.
</body>
</html>