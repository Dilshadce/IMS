<cfquery name="checkpassword" datasource="main">
SELECT userID from users Where 1=1
and userDept = "#dts#" 
and userPwd = "#hash(form.passwordString)#"
and (userGrpId = 'admin' or userGrpId = 'super' or userid = '#huserid#')
</cfquery>

<cfif checkpassword.recordcount eq 0>
<h4>Wrong Password</h4>
<cfform action="/default/transaction/backdatepassword.cfm?tran=#tran#&nexttranno=#nexttranno#" method="post" name="wrongpass" id="wrongpass">
<input type="submit" name="submit_btn" value="Retry"  />
</cfform>

<cfelse>

<cfquery name="insertbackdate" datasource="#dts#">
	INSERT INTO backdatetran (type,refno,remark,created_by,created_on)
    VALUES (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.tran#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.nexttranno#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.backdateremark#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#huserid#">,
    now()
    )
</cfquery>

<script type="application/javascript">
ColdFusion.Window.hide('backdatepass');
document.getElementById('allowbackdate').value="Y";
</script>
</cfif>
