<cfif isdefined('url.type')>
<cfsetting showdebugoutput="no">
<cfinclude template="/object/dateobject.cfm">
<cfquery name="update" datasource="#dts#">
UPDATE leavelist SET claimed = "<cfif url.type eq "marked">Y<cfelse>N</cfif>",submitted = "#getauthuser()#", submited_on = now()<cfif url.submitdate neq "">,submit_date = "#dateformatnew(url.submitdate,'yyyy-mm-dd')#"</cfif>,claimremark = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.leaveremark)#"> WHERE id = "#url.id#"
</cfquery>
</cfif>