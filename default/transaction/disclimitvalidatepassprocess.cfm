<cfif isdefined('form.pass_word')>
<cfoutput>
<cfquery name="getAdminPass" datasource="main">
SELECT userID from users Where userGrpId in ("admin","super") and userDept = "#dts#" and userPwd = "#hash(form.pass_word)#"
</cfquery>
<cfif getAdminPass.recordcount neq 0>
<script type="text/javascript">
document.getElementById('discountlimitcontrol').value=1;
ColdFusion.Window.hide('discvalidatepass');
</script>
<cfelse>
<cfform name="returnform2" id="returnform2" action="/default/transaction/disclimitvalidatepass.cfm" method="post">
<div align="center">
<h2>Password is Incorrect</h2>
<input type="submit" name="sub_return" id="sub_return" value="Go Back">
</div>
</cfform>
</cfif>
</cfoutput>
</cfif>