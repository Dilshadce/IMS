<cfset ndate = createdate(right(form.nextdate,4),mid(form.nextdate,4,2),left(form.nextdate,2))>
<cfif form.submitbtn eq "Create">
<cfquery name="insertgroup" datasource="#dts#">
INSERT INTO recurrgroup
(desp,recurrtype,nextdate,created_on, created_by)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.recurrtype#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(ndate,'yyyy-mm-dd')#">,
now(),
"#huserid#"
)
</cfquery>
<cfelseif form.submitbtn eq "Edit">
<cfquery name="updategroup" datasource="#dts#">
UPDATE recurrgroup
SET
desp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#">,
recurrtype = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.recurrtype#">,
nextdate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(ndate,'yyyy-mm-dd')#">,
updated_on = now(), 
updated_by = "#huserid#"
WHERE groupid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.groupid#">
</cfquery>
<cfelseif form.submitbtn eq "Delete">
<cfquery name="deletegroup" datasource="#dts#">
delete from recurrgroup
WHERE groupid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.groupid#">
</cfquery>
</cfif>
<cfoutput>
<form name="recurrmain" id="recurrmain" method="post" action="recurrmain.cfm">
<input type="hidden" value="#form.submitbtn# is Success!" name="status">
</form>
</cfoutput>
<script type="text/javascript">
recurrmain.submit();
</script>