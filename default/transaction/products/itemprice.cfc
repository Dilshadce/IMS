<cfcomponent output="false">

	<!--- Lookup used for auto suggest --->
	<cffunction name="itemprice" access="remote">
		<cfargument name="itemno" type="any" required="false" default="">
		<cfargument name="dts" type="any" required="false" default="">
		<cfargument name="custno" type="any" required="false" default="">
        <cfargument name="targettbl" type="any" required="false" default="">
        <cfargument name="targettbl2" type="any" required="false" default="">
        
        <cfquery name="getitembal1" datasource="#dts#">
        SELECT price,price2,price3,price4,ucost,fcurrcode,fprice,fucost<cfloop from="2" to="10" index="i">,fcurrcode#i#,fprice#i#,fucost#i#</cfloop> FROM icitem where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(itemno)#">
        </cfquery>
        
        <cfquery name="getitemprior" datasource="#dts#">
        SELECT itempriceprior FROM gsetup
        </cfquery>
        
        <cfif getitemprior.itempriceprior eq "2">
        <cfquery name="getcustomerprice" datasource="#dts#">
        select * from icl3p<cfif targettbl2 eq 'apvend'><cfelse>2</cfif> where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(itemno)#"> and custno='#custno#'
        </cfquery>
        <cfif getcustomerprice.recordcount neq 0>
        <cfset getitembal1.price=getcustomerprice.price>
        <cfset getitembal1.ucost=getcustomerprice.price>
        <cfset price = getitembal1.price>
        </cfif>
        </cfif>
        
        <cfquery name="getbustype" datasource="#dts#">
        SELECT business,currcode FROM #targettbl#
            where custno='#custno#'
        </cfquery> 
        
        <cfif getbustype.business neq "">
        <cfquery name="getpricelvl" datasource="#dts#">
        SELECT pricelvl FROM business where business = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbustype.business#">
        </cfquery>
        <cfif getpricelvl.pricelvl eq 2>
        <cfset price = getitembal1.price2>
        <cfelseif getpricelvl.pricelvl eq 3>
        <cfset price = getitembal1.price3>
		<cfelseif getpricelvl.pricelvl eq 4>
		<cfset price = getitembal1.price4>
        <cfelse>
        <cfset price = getitembal1.price>
        </cfif>
        <cfelse>
        <cfset price = getitembal1.price>
        </cfif>
        
        <cfif getitemprior.itempriceprior eq "1">
        <cfquery name="getcustomerprice" datasource="#dts#">
        select * from icl3p<cfif targettbl2 eq 'apvend'><cfelse>2</cfif> where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(itemno)#"> and custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(custno)#">
        </cfquery>
		<cfset price = getitembal1.price>
        <cfif getcustomerprice.recordcount neq 0>
        <cfset getitembal1.price=getcustomerprice.price>
        <cfset getitembal1.ucost=getcustomerprice.price>
        <cfset price = getitembal1.price>
        </cfif>
        </cfif>
        
        
        <cfif targettbl2 eq 'apvend'>
        <cfset price = numberformat(getitembal1.ucost,'.__')>
        <cfelse>
        <cfset price = numberformat(price,'.__')>
        </cfif>
        
        
        <cftry>

		<cfif getbustype.currcode eq getitembal1.fcurrcode>
        <cfif targettbl2 eq 'apvend'>
        <cfset price=getitembal1.fucost>
        <cfelse>
        <cfset price=getitembal1.fprice>
        </cfif>
        
        </cfif>
        
        <cfloop from="2" to="10" index="i">
        <cfif getbustype.currcode eq evaluate('getitembal1.fcurrcode#i#')>
        <cfif targettbl2 eq 'apvend'>
        <cfset price= evaluate('getitembal1.fucost#i#')>
        <cfelse>
        <cfset price= evaluate('getitembal1.fprice#i#')>
        </cfif>
        </cfif>
        
        </cfloop>
        <cfcatch></cfcatch></cftry>
        
        
        
        

        <cfreturn price>
	</cffunction>
    
   

</cfcomponent>