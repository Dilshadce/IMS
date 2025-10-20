<cfcomponent>
	<cffunction name="getlist" access="remote" returntype="query" securejson="false">
		<cfargument name="tran" type="string" required="yes">
        <cfargument name="dts" type="string">
        
  
      		<cfquery name="getcust" datasource="#dts#">
            	Select "Please Select a bill" as billdesp,"" as refno
                union all
        		Select concat(refno,'--',name) as billdes,concat('a',refno) as refno from artran WHERE type = "#tran#"  order by refno
      		</cfquery>

		<cfreturn getcust>
	</cffunction>
</cfcomponent>