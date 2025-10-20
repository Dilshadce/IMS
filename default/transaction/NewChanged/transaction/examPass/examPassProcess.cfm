<cfquery name="getAdminPass" datasource="main">
SELECT userID from users Where userGrpId in ("admin","super") and userDept = "#dts#" and userPwd = "#hash(form.passwordString)#"
</cfquery>
<cfif getAdminPass.recordcount neq 0>
<script type="text/javascript">
ColdFusion.Window.hide('exampass');
</script>
<cfelse>
<h4>Wrong Password</h4>
<cfform action="/default/transaction/exampass/exampass.cfm?type=#url.type#" method="post" name="wrongpass" id="wrongpass">
<input type="submit" name="submit_btn" value="Retry"  />
</cfform>
</cfif>