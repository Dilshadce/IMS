<cfcomponent>
<cfsetting showdebugoutput="no">
<cffunction name="addFavorite" access="remote" returntype="struct">
	<!--- <cfset dts=form.dts> --->
    <cfquery name="getdts" datasource="main">
     SELECT userbranch AS dts FROM users WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#GetAuthUser()#">
    </cfquery>
    <cfset dts = trim(getdts.dts)>
	<cfset menu_id=form.menu_id>
	<cfset menuname=form.menuname>
	<cfquery name="getSelectedMenu" datasource="main">
		SELECT menu_id,#menuname# AS menu_name,menu_url
		FROM menunew2
		WHERE menu_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#menu_id#">;
	</cfquery>
	<cfquery name="addFavorite" datasource="#dts#">
		INSERT INTO myfavorite
		(menu_id,menu_name,menu_url)
		VALUES
		(
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getSelectedMenu.menu_id#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getSelectedMenu.menu_name#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getSelectedMenu.menu_url#">
		)
	</cfquery>
	<cfquery name="getInsertedFavoriteId" datasource="#dts#">
		SELECT LAST_INSERT_ID() AS favorite_id;
	</cfquery>
	<cfset newFavorite=StructNew()>
	<cfset newFavorite["favorite_id"]=getInsertedFavoriteId.favorite_id>
	<cfset newFavorite["menu_name"]=getSelectedMenu.menu_name>
	<cfset newFavorite["menu_url"]=getSelectedMenu.menu_url>
	<cfreturn newFavorite>
</cffunction>
<cffunction name="removeFavorite" access="remote">
	<!--- <cfset dts=form.dts> --->
    <cfquery name="getdts" datasource="main">
     SELECT userbranch AS dts FROM users WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#GetAuthUser()#">
    </cfquery>
    <cfset dts = trim(getdts.dts)>
	<cfset favorite_id=form.favorite_id>
	<cfquery name="removeFavorite" datasource="#dts#">
		DELETE FROM myfavorite
		WHERE favorite_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#favorite_id#">
	</cfquery>
	<cfreturn true>
</cffunction>
</cfcomponent>