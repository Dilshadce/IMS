<cfquery name="checklevel" datasource="#dts#">
SELECT printstatus FROM artran WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.refno#"> and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billtype#">
</cfquery>

<cfif hcomid eq "asaiki_i"> <!---For asaiki--->

<cfquery name="getAdminPass" datasource="main">
SELECT userID from users Where userGrpId in ("admin","super") and userDept = "#dts#" and usergrpid = "#HUserGrpID#" and userPwd = "#hash(form.passwordString)#"
</cfquery>
<cfif getAdminPass.recordcount neq 0>
<cfset applevel = "a3">

<cfif form.submit eq "reject">
<cfset applevel = "reject">
</cfif>

<cfquery name="updatebill" datasource="#dts#">
UPDATE artran SET printstatus = "#applevel#" WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.refno#"> and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billtype#">
</cfquery>

<script type="text/javascript">
location.reload(true);
ColdFusion.Window.hide('approveso');
</script>
<cfelse>
<cfoutput>
<h4>Wrong Password</h4>
<cfform action="/default/transaction/approveso.cfm?tran=#form.billtype#&refno=#form.refno#" method="post" name="wrongpass" id="wrongpass">
<input type="submit" name="submit_btn" value="Retry"  />
</cfform>
</cfoutput>
</cfif>



<cfelse><!--- For asiasoft --->


<cfquery name="getAdminPass" datasource="main">
SELECT userID from users Where userGrpId in ("admin","super"<cfif checklevel.printstatus eq "">,"general"</cfif>) and userDept = "#dts#"<!---  and userPwd = "#hash(form.passwordString)#" ---> and usergrpid = "#HUserGrpID#"
</cfquery>
<cfif getAdminPass.recordcount neq 0>

<cfif checklevel.printstatus eq "">
<cfset applevel = "a2">
<cfelseif checklevel.printstatus eq "a2">
<cfset applevel = "a3">
<cfelse>
<cfset applevel = "a3">
</cfif> 
<cfif form.submit eq "reject">
<cfset applevel = "reject">
<cfquery name="getuser" datasource="#dts#">
SELECT created_by FROM artran where refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.refno#"> and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billtype#">
</cfquery>

<cfquery name="getid" datasource="#replace(dts,'_i','_c')#">
select memberid from security where username = "#getuser.created_by#"
</cfquery>

<cfquery name="getemail" datasource="#replace(dts,'_i','_c')#">
select email from member where id = "#getid.memberid#"
</cfquery>

<cfif getemail.email eq "">
<cfset emailname = "noreply@mynetiquette.com">
<cfelse>
<cfset emailname = getemail.email>
</cfif>

<cfmail from="noreply@mynetiquette.com" to="#emailname#" subject="Sales Order Has Been Rejected - #form.refno#" type="html">
Sales Order #form.refno# has been reviewed and rejected.<br/>
<br/>       
From: Netiquette IMS
</cfmail>
</cfif>
<cfquery name="updatebill" datasource="#dts#">
UPDATE artran SET printstatus = "#applevel#" WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.refno#"> and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billtype#">
</cfquery>
<cfif applevel eq "a2">
        <cfquery name="getuser" datasource="#dts#">
        select useremail from main.users where userbranch = "#dts#" and usergrpid = "admin" and useremail <> ""
        </cfquery>
        <cfset defaultemail = "noreply@mynetiquette.com">
        <cfif getuser.recordcount neq 0>
        <cfset defaultemail = "">
        <cfloop query="getuser">
        <cfset defaultemail = defaultemail&getuser.useremail>
        <cfif getuser.recordcount neq getuser.currentrow>
        <cfset defaultemail = defaultemail&",">
		</cfif>
        </cfloop> 
		</cfif>
		<cfmail from="noreply@mynetiquette.com" to="#defaultemail#" subject="Require Final Approval For Sales Order - #form.refno#" type="html">
        Dear Management,<br/>
       	<br/> 
        Sales Order #form.refno# require review and final approval.<br/>
 <br/>       
        From: Netiquette IMS
        </cfmail>
</cfif>
<script type="text/javascript">
location.reload(true);
ColdFusion.Window.hide('approveso');
</script>
<cfelse>
<cfoutput>
<h4>Wrong User Level</h4>
<cfform action="/default/transaction/approveso.cfm?tran=#form.billtype#&refno=#form.refno#" method="post" name="wrongpass" id="wrongpass">
<input type="submit" name="submit_btn" value="Retry"  />
</cfform>
</cfoutput>
</cfif>
</cfif>