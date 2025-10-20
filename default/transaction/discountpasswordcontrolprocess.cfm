<cfquery name="getAdminPass" datasource="main">
SELECT userID from users Where userGrpId in ("admin","super","guser","general") and userDept = "#dts#" and userPwd = "#hash(form.passwordString)#"
</cfquery>
<cfif getAdminPass.recordcount neq 0>
<script type="text/javascript">
document.getElementById('discountpasswordcontrol').value=1;
ColdFusion.Window.hide('discountpassword');
</script>
<cfelse>
<h4>Wrong Password</h4>
<cfform action="discountpasswordcontrol.cfm" method="post" name="wrongpass" id="wrongpass">
<input type="submit" name="submit_btn" value="Retry"  />
</cfform>
</cfif>