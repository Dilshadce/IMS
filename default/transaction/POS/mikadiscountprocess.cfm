<cfquery name="getAdminPass" datasource="main">
SELECT userID from users Where userGrpId in ("admin","super") and userDept = "#dts#" and userPwd = "#hash(form.passwordString)#"
</cfquery>
<cfif getAdminPass.recordcount neq 0>
<script type="text/javascript">
<cfoutput>
document.getElementById("getpassdiscount").value="#form.mikadiscountvalue#"
<cfif url.type eq "1">
getDiscount();
ColdFusion.Window.hide('mikadiscountpassword');
<cfelse>
updatebodydisclistcontrol();
ColdFusion.Window.hide('mikadiscountpassword2');
</cfif>
</cfoutput>
</script>
<cfelse>
<h4>Wrong Password</h4>
<cfform action="negativestock.cfm" method="post" name="wrongpass" id="wrongpass">
<input type="submit" name="submit_btn" value="Retry"  />
</cfform>
</cfif>