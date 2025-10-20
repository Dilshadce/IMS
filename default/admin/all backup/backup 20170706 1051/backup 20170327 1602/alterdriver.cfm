<html>
<head></head>
<body>
<cfquery name="getcompany" datasource="main">
	SELECT userDept,linktoams FROM users where 
	userDept not in ('cyt_i','hom_i','mj_i','oilestates_a','pwd_i','steel05_i','steel_i','marujyu_i') 
	and userDept not like '%_a' group by userDept
</cfquery>

 <cfloop query="getcompany">
 	<cfoutput>
    #getcompany.userDept#
    </cfoutput>
	<cfset dts=getcompany.userDept>
	
	<cftry>
    
       <cfquery name="alter1" datasource="#dts#">
		ALTER TABLE `gsetup` ADD COLUMN `PPTS` VARCHAR(45) DEFAULT 'N' AFTER `custsupp_limit_display`;
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