<cfquery name="getAdminPass" datasource="main">
SELECT userID from users Where userGrpId in ("admin","super","guser") and userDept = "#dts#" and userPwd = "#hash(form.passwordString)#"
</cfquery>
<cfif getAdminPass.recordcount neq 0>
<script type="text/javascript">
document.getElementById('allowtransferlimit').value=1;
addItemAdvance();
ColdFusion.Window.hide('transferlimitstock');
</script>
<cfelse>
<h4>Wrong Password</h4>
<cfform action="transferlimitstock.cfm" method="post" name="wrongpass" id="wrongpass">
<input type="submit" name="submit_btn" value="Retry"  />
</cfform>
</cfif>