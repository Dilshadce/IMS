<cfinclude template="../core/cfajax.cfm">
<!--- Example in  Report/IMK/collectionnote_header.cfm --->
<cffunction name="getRowContent">
	<cfargument name="qString" required="yes" type="string">
	<cfargument name="conditionList" required="no" type="string" default="">
	<cfargument name="delimiter" required="no" type="string" default=",">
	<cfset index=1>
	<cfset object = CreateObject("Component","cfobject")>
	<cfset qStr=Decrypt(arguments.qString,HUserID,"CFMX_COMPAT","Base64")>
	
	<cfloop list="#conditionList#" delimiters="#arguments.delimiter#" index="conValue">
		<cfset qStr=replace(qStr,"||#index#||",conValue)><cfset index=incrementValue(index)>
	</cfloop>
	
	<cfquery name="getResult" datasource="#dts#">#PreserveSingleQuotes(qStr)#</cfquery>
	
	<cfif getResult.recordcount eq 1>
		<cfset object.exist="yes">
		<cfloop list="#getResult.columnList#" index="colfield"><cfset "object.#colfield#"=evaluate("getResult."&colfield)></cfloop>
	<cfelse>
		<cfset object.exist="no.record: "&getResult.recordcount>
	</cfif>
	<cfreturn object>
</cffunction>
<!--- Example in  Report/IMK/collectionnote_header.cfm --->
<cffunction name="getSelectContent" hint="type='keyvalue' jsreturn='array' delimiter='||'">
	<cfargument name="qString" required="yes" type="string">
	<cfargument name="conditionList" required="no" type="string" default="">
	<cfargument name="delimiter" required="no" type="string" default=",">
	<cfset index=1>
	<cfset qStr=Decrypt(arguments.qString,HUserID,"CFMX_COMPAT","Base64")>
	<cfset model = ArrayNew(1)>
	
	<cfloop list="#conditionList#" delimiters="#arguments.delimiter#" index="conValue">
		<cfset qStr=replace(qStr,"||#index#||",conValue)><cfset index=incrementValue(index)>
	</cfloop>
	
	<cfquery datasource="#dts#" name="getRecord">#preserveSingleQuotes(qStr)#</cfquery>
	
	<cfif getRecord.recordcount gt 0>
		<cfset ArrayAppend(model,"-||--- Please select 1 of #getRecord.recordcount# below. ---")>
		<cfloop query="getRecord"><cfset ArrayAppend(model,"#skey#||#svalue#")></cfloop>
	<cfelse>
		<cfset ArrayAppend(model,"-||--- You have Empty Record ---")>
	</cfif>
	<cfreturn model>
</cffunction>