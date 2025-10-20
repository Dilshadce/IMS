<cfcomponent>
	<cffunction name="getrefno" access="remote" returntype="string">
		<cfargument name="tran" type="string" required="yes">
        <cfargument name="dts" type="string" required="yes">
        
        <cfquery datasource="#dts#" name="getGeneralInfo">
			select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse 
            from refnoset
			where type = '#tran#'
			and counter = 1
		</cfquery>
        
        <cfif getGeneralInfo.arun eq "1">
        <cfinvoke component="cfc.refno" method="processNum" oldNum="#getGeneralInfo.tranno#" returnvariable="newnextNum" />
        	<cfset actual_nexttranno = newnextNum>
            <cfif (getGeneralInfo.refnocode2 neq "" or getGeneralInfo.refnocode neq "") and getGeneralInfo.presuffixuse eq "1">
				<cfset nexttranno = tran&"-"&getGeneralInfo.refnocode&actual_nexttranno&getGeneralInfo.refnocode2>
            <cfelse>
            	<cfset nexttranno = tran&"-"&actual_nexttranno>
			</cfif>
            <cfset tranarun_1 = getGeneralInfo.arun>
		<cfelse>
			<cfset nexttranno = "">
            <cfset tranarun_1 = "0">
		</cfif>
        <cfset nexttranno = tostring(nexttranno)>
		<cfreturn nexttranno>
	</cffunction>
</cfcomponent>