<cfquery name="getAdminPass" datasource="main">
select password from dealer_menu where password="#form.passwordString#"
</cfquery>
<cfif getAdminPass.recordcount neq 0>
<script type="text/javascript">
document.getElementById('atcdatepasswordpasswordcontrol').style.visibility='visible';
document.getElementById('remark5').readOnly=false;
ColdFusion.Window.hide('atcdatepassword');
</script>
<cfelse>
<h4>Wrong Password</h4>
<cfform action="atcdatepasswordcontrol.cfm" method="post" name="wrongpass" id="wrongpass">
<input type="submit" name="submit_btn" value="Retry"  />
</cfform>
</cfif>