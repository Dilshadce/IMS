<cfcomponent>
	<cffunction name="getitem" access="remote" returntype="query">
		<cfargument name="filtercolumn" type="string">
        <cfargument name="filter" type="string">
        <cfargument name="dts" type="string" required="yes">
        
  
      		<cfquery name="getitem" datasource="#dts#">
        		Select itemno as itemdesp,itemno from icitem 
                <cfif filtercolumn neq "" and filter neq "">
                WHERE 
                #filtercolumn# like <cfqueryparam cfsqltype="cf_sql_varchar" value="#filter#%">  
                </cfif>
                order by itemno
      		</cfquery>

		<cfreturn getitem>
	</cffunction>
    
    <cffunction name="getgroup" access="remote" returntype="query">
        <cfargument name="dts" type="string" required="yes">
      		<cfquery name="getgroup" datasource="#dts#">
        		SELECT concat(wos_group,' - ',desp) as groupdesp,wos_group
                FROM
                icgroup
                order by wos_group
      		</cfquery>

		<cfreturn getgroup>
	</cffunction>
    
    <cffunction name="getbrand" access="remote" returntype="query">
        <cfargument name="dts" type="string" required="yes">
      		<cfquery name="getbrand" datasource="#dts#">
        		SELECT concat(brand,' - ',desp) as branddesp,brand
                FROM
                brand
                order by brand
      		</cfquery>

		<cfreturn getbrand>
	</cffunction>
    
    <cffunction name="getcate" access="remote" returntype="query">
        <cfargument name="dts" type="string" required="yes">
      		<cfquery name="getcate" datasource="#dts#">
        		SELECT concat(cate,' - ',desp) as catedesp,cate
                FROM
                iccate
                order by cate
      		</cfquery>

		<cfreturn getcate>
	</cffunction>
</cfcomponent>