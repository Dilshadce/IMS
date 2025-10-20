<cffunction name="FillHrMgr" access="remote" returnFormat="json">
    <cfargument name="id" type="string" required="yes" >
    <cfquery name="testFunc" datasource="payroll_main">
		SELECT * FROM hmusers WHERE entryid = #id#
	</cfquery>
    <cfset var userInfo = {} >
    <cfset userInfo.email = testFunc.userid >
    <cfreturn userinfo >
</cffunction>
