<cfcomponent output="false">

	<!--- Lookup used for auto suggest --->
	<cffunction name="itemprice" access="remote">
		<cfargument name="itemno" type="any" required="false" default="">
		<cfargument name="dts" type="any" required="false" default="">
		<cfargument name="custno" type="any" required="false" default="">
        <cfargument name="targettbl" type="any" required="false" default="">
        <cfargument name="tran" type="any" required="false" default="">
        
        <cfquery name="getbustype" datasource="#dts#">
        SELECT business FROM #targettbl#
            where custno='#custno#'
        </cfquery> 
        <cfquery name="getitembal1" datasource="#dts#">
        SELECT price,price2,price3,ucost FROM icitem where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(itemno)#">
        </cfquery>
        <cfif tran eq 'ISS'>
        <cfset price = getitembal1.ucost>
        <cfelse>
        <cfif getbustype.business neq "">
        <cfquery name="getpricelvl" datasource="#dts#">
        SELECT pricelvl FROM business where business = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbustype.business#">
        </cfquery>
        <cfif getpricelvl.pricelvl eq 2>
        <cfset price = getitembal1.price2>
        <cfelseif getpricelvl.pricelvl eq 3>
        <cfset price = getitembal1.price3>
        <cfelse>
        <cfset price = getitembal1.price>
        </cfif>
        <cfelse>
        <cfset price = getitembal1.price>
        </cfif>
      	</cfif>
        <cfset price = numberformat(price,'.___')>
        <cfreturn price>
	</cffunction>
    
   

</cfcomponent>