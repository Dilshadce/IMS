<cfquery name="getAdminPass" datasource="main">
SELECT userID from users Where userGrpId in ("admin","super") and userDept = "#dts#" and userPwd = "#hash(form.passwordString)#"
</cfquery>

<cfquery name="check" datasource="#dts#">
			select password 
			from dealer_menu
			where password = '#form.passwordString#'
</cfquery>

<cfif getAdminPass.recordcount neq 0 or check.recordcount neq 0>
<script type="text/javascript">
document.getElementById('minimumsellingpassword').value='N';
ColdFusion.Window.hide('minimumprice');
</script>
<cfelse>
<h4>Wrong Password</h4>
<cfform action="minimumprice.cfm" method="post" name="wrongpass" id="wrongpass">
<input type="submit" name="submit_btn" value="Retry"  />
</cfform>
</cfif>