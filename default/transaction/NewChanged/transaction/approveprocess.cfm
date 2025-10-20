<cfquery name="getAdminPass" datasource="main">
SELECT userID from users Where userGrpId in ("admin","super") and userDept = "#dts#" and userPwd = "#hash(form.passwordString)#"
</cfquery>
<cfif getAdminPass.recordcount neq 0>
<cfquery name="updatebill" datasource="#dts#">
UPDATE artran SET printstatus = "a3" WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.refno#"> and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billtype#">
</cfquery>
<script type="text/javascript">
location.reload(true);
ColdFusion.Window.hide('approvesample');
</script>
<cfelse>
<cfoutput>
<h4>Wrong Password</h4>
<cfform action="/default/transaction/approvesample.cfm?tran=#form.billtype#&refno=#form.refno#" method="post" name="wrongpass" id="wrongpass">
<input type="submit" name="submit_btn" value="Retry"  />
</cfform>
</cfoutput>
</cfif>