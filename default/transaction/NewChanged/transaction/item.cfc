<cfcomponent>
	<cffunction name="getitem" access="remote" returntype="query">
		<cfargument name="dts" type="string" required="yes">
        
        <cfquery name='getitem' datasource='#dts#'>
        SELECT "Choose an Item" as itemdesp, "" as itemno
        union all
		select concat(itemno," - ",desp) as itemdesp, itemno from icitem where (nonstkitem<>'T' or nonstkitem is null)
		order by itemno
		</cfquery>
    
		<cfreturn getitem>
	</cffunction>
</cfcomponent>