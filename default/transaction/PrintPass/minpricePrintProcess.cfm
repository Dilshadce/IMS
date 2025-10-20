<cfquery name="getgeneralsetup" datasource="#dts#">
select printapproveamt,compro,printapprovelevel1,printapprovelevel2 from gsetup;
</cfquery>

<cfquery name="getbillstatus" datasource="#dts#">
select printstatus,created_by,grand,custno,name,CREATED_ON from artran where type='#url.type#' and refno='#url.refno#'
</cfquery>

<cfquery name="checkpassword" datasource="main">
SELECT userID from users Where 
userid='#huserid#' 
and userDept = "#dts#" 
and userPwd = "#hash(form.passwordString)#"
and (userGrpId = 'admin' or userGrpId = 'super')
</cfquery>


<cfif checkpassword.recordcount neq 0>

<cfquery name="updatestatus" datasource="#dts#">
update artran set printstatus='a3' where type='#url.type#'and refno='#url.refno#'
</cfquery>

<h4>Transaction Printing has been allowed</h4>

<input type="submit" name="submit_btn" value="Close" onclick="ColdFusion.Window.hide('printpass');javascript:location.reload(true);"  />

<cfelse>
<h4>Wrong Password</h4>
<cfform action="/default/transaction/printpass/minpriceprint.cfm?type=#url.type#&refno=#url.refno#" method="post" name="wrongpass" id="wrongpass">
<input type="submit" name="submit_btn" value="Retry"  />
</cfform>
</cfif>