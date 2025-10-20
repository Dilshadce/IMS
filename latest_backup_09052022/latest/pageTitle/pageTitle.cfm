<cfif IsDefined('url.menuID')>
    <cfset URLmenuID = trim(urldecode(url.menuID))>
</cfif>

<cfset pageTitle = "">
<cfset targetTitle = "">

<cfquery name="getUserDefinedMenu" datasource="#dts#">
   SELECT menu_id,new_menu_name 
   FROM userdefinedmenu
   WHERE menu_id = '#URLmenuID#'
   ORDER BY menu_id;   
</cfquery>

<cfloop query="getUserDefinedMenu">
	<cfset pageTitle = getUserDefinedMenu.new_menu_name>
    <cfset targetTitle = replaceNoCase(pageTitle,"Profile","","ALL")>
</cfloop>
