<cfcomponent>
	<cffunction name="getitemlist" access="remote" returntype="query">
        <cfargument name="dts" type="string">
        <cfargument name="project" type="string">        
        <cfquery name="getgeneral" datasource="#dts#">
			select filterall,displayaitemno from gsetup
		</cfquery>
        <cfif getgeneral.displayaitemno eq 'Y'>
        	
            <cfquery name="getitemqry" datasource="#dts#">
            select "" as itemno,"Choose an Item" as desp
            UNION ALL
            select a.itemno,concat(b.aitemno,' - ',b.desp) as desp 
            from billmat as a 
            left join (select itemno as itemnoa,aitemno,desp from icitem) as b 
            on a.itemno = b.itemnoa 
           where a.project= <cfqueryparam cfsqltype="cf_sql_varchar" value="#project#">
            group by a.itemno 
            order by itemno
            </cfquery>
        <cfelse>
        	<cfquery name="getitemqry" datasource="#dts#">
            select "" as itemno,"Choose an Item" as desp
            UNION ALL
            select a.itemno,concat(a.itemno,' - ',b.desp) as desp 
            from billmat as a 
            left join (select itemno as itemnoa,desp from icitem) as b 
            on a.itemno = b.itemnoa 
           where a.project= <cfqueryparam cfsqltype="cf_sql_varchar" value="#project#">
            group by a.itemno 
            order by itemno
            </cfquery>
        </cfif>
            <cfreturn getitemqry>
	</cffunction>
</cfcomponent>