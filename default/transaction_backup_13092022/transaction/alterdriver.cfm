<html>
<head></head>
<body>
<cfquery name="getcompany" datasource="main">
	SELECT userDept FROM users where 
	userDept not in ('cyt_i','hom_i','mj_i','oilestates_a','pwd_i','steel05_i','steel_i','marujyu_i','anglomlw08_i')
	and userDept not like '%_a' group by userDept
</cfquery>

 <cfloop query="getcompany">
 	<cfoutput>
    #getcompany.userDept#
    </cfoutput>
	<cfset dts=getcompany.userDept>
	
	<cftry>
		<cfquery name="updatetable" datasource="#dts#">
     ALTER TABLE `arcust` MODIFY COLUMN `CURRENCY1` VARCHAR(27) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '',
 MODIFY COLUMN `CURRENCY2` VARCHAR(27) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '';
        </cfquery>
        
        <cfquery name="updatetable" datasource="#dts#">
     ALTER TABLE `apvend` MODIFY COLUMN `CURRENCY1` VARCHAR(27) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '',
 MODIFY COLUMN `CURRENCY2` VARCHAR(27) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '';
        </cfquery>
        <cfoutput>
        #dts#<br/>
        </cfoutput>
	<cfcatch type="any">
		<cfoutput>#cfcatch.Message#:#cfcatch.Detail#</cfoutput><br>	
	</cfcatch>
	</cftry>
</cfloop>
Finish.
</body>
</html>