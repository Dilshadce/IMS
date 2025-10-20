<cfcomponent>
    <cffunction name="listPlacementNo" access="remote" returntype="struct">
        <!---<cfset dts=form.dts>--->
        <cfquery name="getdts" datasource="main">
     		SELECT userbranch AS dts FROM users WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#GetAuthUser()#">
    	</cfquery>
   		<cfset dts = trim(getdts.dts)>       
        <cfset term=form.term>
        <cfset limit=form.limit>
        <cfset page=form.page>
        <cfset start=page*limit>
        <cfset placementNoArray =ArrayNew(1)>
        
        
        <cfquery name="listPlacementNo" datasource="#dts#">
            SELECT placementno
            FROM placement
            WHERE placementno LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#term#%" />
            
            ORDER BY placementno ASC 
            LIMIT #start#,#limit#;
        </cfquery>
        <cfquery name="getPlacementNoLength" datasource="#dts#">
            SELECT FOUND_ROWS() AS placementNoLength
        </cfquery>	
        
        <cfloop query="listPlacementNo">
        	<cfset placement = StructNew() />
            <cfset placement['id'] = listPlacementNo.placementno />
            <cfset placement['desp'] = listPlacementNo.placementNo />
        	<cfset ArrayAppend(placementNoArray,placement) />
        </cfloop>
 
        <cfset output=StructNew()>
        <cfset output["total"]=getPlacementNoLength.placementNoLength>
        <cfset output["result"]=placementNoArray>
        <cfreturn output>
    </cffunction>
    
</cfcomponent>