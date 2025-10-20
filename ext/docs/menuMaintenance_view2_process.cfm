<cfif url.type eq "up">
	<cfoutput>
<cfquery datasource="main" name="update1">
 update help set menu_order=0 where menu_order='#url.order#' and menu_parent_id ='#url.parentid#'
</cfquery>

<cfquery datasource="main" name="update2">
 update help set menu_order='#url.order#' where menu_order='#val(url.order)-1#' and menu_parent_id ='#url.parentid#'
</cfquery>

<cfquery datasource="main" name="update3">
 update help set menu_order='#val(url.order)-1#' where menu_order='0' and menu_parent_id ='#url.parentid#'
</cfquery>
</cfoutput>
</cfif>


<cfif url.type eq "down">
	<cfoutput>
<cfquery datasource="main" name="update1">
 update help set menu_order=0 where menu_order='#url.order#' and menu_parent_id ='#url.parentid#'
</cfquery>

<cfquery datasource="main" name="update2">
 update help set menu_order='#url.order#' where menu_order='#val(url.order)+1#' and menu_parent_id ='#url.parentid#'
</cfquery>

<cfquery datasource="main" name="update3">
 update help set menu_order='#val(url.order)+1#' where menu_order='0' and menu_parent_id ='#url.parentid#'
</cfquery>
</cfoutput>
</cfif>


<cfoutput>
<cflocation url="menuMaintenance_view2.cfm?id=#url.parentid#">
</cfoutput>