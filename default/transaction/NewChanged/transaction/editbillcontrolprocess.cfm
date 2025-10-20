<cfquery name="getAdminPass" datasource="main">
SELECT userID from users Where userGrpId in ("admin","super") and userDept = "#dts#" and userPwd = "#hash(form.passwordString)#"
</cfquery>

<cfquery name="getAdminPass2" datasource="#dts#">
select password 
			from dealer_menu
			where password = '#form.passwordString#'
</cfquery>

<cfif getAdminPass.recordcount neq 0 or getAdminPass2.recordcount neq 0>
<cfquery datasource='#dts#' name="getartran">
	select * from artran where refno='#refno#' and type = "#tran#"
</cfquery>

<cfquery datasource="#dts#" name="getGeneralInfo">
	Select generateQuoRevision,revStyle,generateQuoRevision1
	from GSetup
</cfquery>


<cfoutput>
<script type="text/javascript">
<cfif getgeneralinfo.generateQuoRevision eq "1" and tran neq 'INV' and (getgeneralinfo.generateQuoRevision1 eq "" or ListFindNoCase(getgeneralinfo.generateQuoRevision1,tran))>
window.location.href='tran_edit2a.cfm?tran=#tran#&refno=#refno#&parentpage=no';

<cfelse>
window.opener.location.href=("tran_edit2.cfm?tran=#tran#&ttype=Edit&refno=#refno#&custno=#URLEncodedFormat(getartran.custno)#&first=0");
window.close();
</cfif>
</script>
</cfoutput>
<cfelse>
<h4>Wrong Password</h4>
<cfform action="editbillcontrol.cfm?tran=#tran#&refno=#refno#" method="post" name="wrongpass" id="wrongpass">
<input type="submit" name="submit_btn" value="Retry"  />
</cfform>
</cfif>