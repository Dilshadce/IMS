<cfcomponent>
	<cffunction name="getlist" access="remote" returntype="query" securejson="false">
		<cfargument name="tran" type="string" required="yes">
        <cfargument name="dts" type="string">
      		<cfquery name="getcust" datasource="#dts#">
            	SELECT "Choose a Bill No." as billdesp,"" as refno
                UNION ALL
        		SELECT concat(refno,'--',name) AS billdes,concat('a',refno) AS refno 
                FROM artran 
                WHERE type = "#tran#" AND (Posted = "" or posted is null) AND (toinv = "" or toinv is null) 
                ORDER BY refno
      		</cfquery>
		<cfreturn getcust>
	</cffunction>
</cfcomponent>