<cfcomponent>
<cffunction name="listAccount" access="remote" returntype="struct">
	<!---<cfset dts=form.dts>--->
    <cfquery name="getdts" datasource="main">
     SELECT userbranch AS dts FROM users WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#GetAuthUser()#">
    </cfquery>
    <cfset dts = trim(getdts.dts)>
	<cfset menu_level=form.menu_level>
	
	<cfset criteria="">
	<cfif menu_level NEQ "">
		<cfset criteria=" AND(">
		<cfloop index="i" list="#menu_level#" delimiters=",">
				<cfset criteria=criteria&"menu_level="""&i&""" OR )">
		</cfloop>
        <cfset criteria=Left(criteria,Len(criteria)-4)>
		<cfset criteria=criteria&")">
	</cfif>
		
	<cfset sLimit="">
	<cfif IsDefined("form.iDisplayStart") AND form.iDisplayLength NEQ "-1">
		<cfset sLimit="LIMIT "&form.iDisplayStart&","&form.iDisplayLength>
	</cfif>		
	
	<cfset sOrder="">
	<cfif IsDefined("form.iSortCol_0")>
		<cfset sOrder="ORDER BY ">
		<cfloop from="0" to="#form.iSortingCols-1#" index="i" step="1">
			<cfif Evaluate('form.bSortable_'&Evaluate('form.iSortCol_'&i)) EQ "true">
				<cfset sOrder=sOrder&Evaluate('form.mDataProp_'&Evaluate('form.iSortCol_'&i))>
				<cfif Evaluate('form.sSortDir_'&i) EQ "asc">
					<cfset sOrder=sOrder&" ASC,">
				<cfelse>
					<cfset sOrder=sOrder&" DESC,">
				</cfif>
			</cfif>
		</cfloop>
		<cfset sOrder=Left(sOrder,Len(sOrder)-1)>
		<cfif sOrder EQ "ORDER BY">
			<cfset sOrder="">
		</cfif>		
	</cfif>
	
	<cfset sWhere="">
	<cfif IsDefined("form.sSearch") AND form.sSearch NEQ "">
		<cfset sWhere=" AND (">
		<cfloop from="0" to="#form.iColumns-1#" index="i" step="1">	
			<cfif Evaluate('form.bSearchable_'&i) EQ "true">
				<cfset sWhere=sWhere&Evaluate('form.mDataProp_'&i)&" LIKE ""%"&trim(form.sSearch)&"%"" OR ">
			</cfif>
		</cfloop>
        <cfset sWhere=Left(sWhere,Len(sWhere)-4)>
		<cfset sWhere=sWhere&")">
	</cfif>
    
    <cfquery name="getGsetup" datasource="#dts#">
        SELECT dflanguage 
        FROM gsetup;
    </cfquery>
    
    <cfif getGsetup.dflanguage NEQ "english">
        <cfset menuName=getGsetup.dflanguage>
    <cfelse>
        <cfset menuName="menu_name">
    </cfif>
        
	<cfquery name="getFilteredDataSet" datasource="#dts#">
    	SELECT SQL_CALC_FOUND_ROWS * 
        FROM(
			SELECT a.menu_id,a.#menuName# AS menu_name,a.menu_level,b.new_menu_name 
			FROM main.menunew2 a
        	LEFT JOIN userdefinedmenu b ON a.menu_id = b.menu_id ) as aa
		WHERE menu_name != ''
        AND menu_id < '70000'
		#criteria#
		#sWhere#
		#sOrder#
		#sLimit#
	</cfquery>
	<cfquery name="getFilteredDataSetLength" datasource="#dts#">
		SELECT FOUND_ROWS() AS iFilteredTotal
	</cfquery>
	<cfquery name="getTotalDataSetLength" datasource="#dts#">
		SELECT COUNT(menu_level) AS iTotal
		FROM (
        	SELECT a.menu_level 
            FROM main.menunew2 a
            LEFT JOIN userdefinedmenu b ON a.menu_id = b.menu_id) as bb
		WHERE 0=0
		#criteria#
	</cfquery>
	
	<cfset aaData=ArrayNew(1)>
	<cfloop query="getFilteredDataSet">	
		<cfset data=StructNew()>
		<cfset data["menu_id"]=getFilteredDataSet.menu_id>
		<cfset data["menu_name"]=getFilteredDataSet.menu_name>
        <cfset data["new_menu_name"]=getFilteredDataSet.new_menu_name>
		<cfset data["menu_level"]=getFilteredDataSet.menu_level>
		<cfset ArrayAppend(aaData,data)>
	</cfloop>
	<cfset output=StructNew()>
	<cfset output["sEcho"]=form.sEcho>
	<cfset output["iTotalRecords"]=getTotalDataSetLength.iTotal>
	<cfset output["iTotalDisplayRecords"]=getFilteredDataSetLength.iFilteredTotal>
	<cfset output["aaData"]=aaData>
	<cfreturn output>
</cffunction>

<cffunction name="updateMenuName" access="remote" returntype="string">
	<!---<cfset dts=form.dts>--->
    <cfquery name="getdts" datasource="main">
     SELECT userbranch AS dts FROM users WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#GetAuthUser()#">
    </cfquery>
    <cfset dts = trim(getdts.dts)>
    <cfset authUser=form.authUser>
    <cfset menuID=form.resultTable>
	<cfset newName=form.new_menu_name>
	<cftry>
        <cfquery name="updateMenuName" datasource="#dts#">
            UPDATE userdefinedMenu
            SET 
            	new_menu_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(newName)#">,
                updated_by = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(authUser)#">,
                updated_on = NOW(),
                changed = '1' 
            WHERE menu_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#menuID#">;
        </cfquery>
		<cfcatch type="any">
			<cfreturn "<b style='color:red;'>Failed to update!</b>">
		</cfcatch>
	</cftry>	
	<cfreturn new_menu_name>
</cffunction>
</cfcomponent>