<cfquery name="getcreditcarddetail" datasource="#dts#">
update artran set 
rem46=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cardissue2#">,
rem47=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cardname2#">,
rem48=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cardno2#">,
rem49=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.expirydate2#">
where
refno='#form.ccbillrefno#' and type='#form.ccbilltype#'
</cfquery>


<cfoutput>
<input type="button" name="close" id="close" value="Close" onclick="ColdFusion.Window.hide('addccdetail');" />
</cfoutput>