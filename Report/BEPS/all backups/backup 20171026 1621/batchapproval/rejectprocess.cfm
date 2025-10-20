<cfif isdefined('form.batchid')>
<cfquery name="getbatchno" datasource="#dts#">
SELECT batchno,submited_by FROM argiro WHERE id = "#form.batchid#"
</cfquery>

<cfquery name="updaterow" datasource="#dts#">
UPDATE argiro SET 
appstatus = "Rejected",
approved_by = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getauthuser()#">,
approved_on = now(),
reason = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rejectbacthfield#">
WHERE id = "#form.batchid#"
</cfquery>

<cfquery name="unlockbatch" datasource="#dts#">
UPDATE assignmentslip SET 
locked = "",
posted=""
WHERE batches = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbatchno.batchno#">
</cfquery>

<cfquery name="unlockinvoice" datasource="#dts#">
UPDATE artran SET 
posted=""
WHERE refno IN 
(
SELECT invoiceno FROM assignmentslip 
WHERE batches = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbatchno.batchno#">
)
</cfquery>

<cfquery name="lockbatch" datasource="#dts#">
UPDATE assignbatches SET locked = "" WHERE batches = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbatchno.batchno#">
</cfquery>

 <cfquery name="getemail" datasource="main">
    SELECT userEmail FROM users WHERE 
    userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbatchno.submited_by#">
    and userbranch = "#dts#"
</cfquery>

<cfquery name="getgsetup" datasource="#dts#">
SELECT compro,mailserver,mailport,mailuser,mailpassword,dfemail FROM gsetup
</cfquery>

<cfset bccmail = "noreply@mynetiquette.com">
<cfif trim(getgsetup.dfemail) neq "">
<cfset bccmail = trim(getgsetup.dfemail)>
</cfif>

<cfif trim(getemail.useremail) neq "">
<cfif isvalid('email',trim(getemail.userEmail))>
<!---<cfmail to="#trim(getemail.useremail)#" server="#getgsetup.mailserver#" username="#getgsetup.mailuser#" password="#getgsetup.mailpassword#" port="#getgsetup.mailport#" bcc="#bccmail#" type="html" from="#getgsetup.mailuser#" subject="Batch #getbatchno.batchno# has been rejected">
Dear #getbatchno.submited_by#<br>
<br>
The batch report #getbatchno.batchno# has been rejected.<br>
<br>
Reason of the rejection as below:<br>
#form.rejectbacthfield#<br>
<br>
Please kindly proceed to do checking and resubmission.<br>
<br><br>
Regards,<br>
<br>
#getgsetup.compro#
</cfmail>--->
</cfif> 
</cfif>

<cfoutput>
<script type="text/javascript">
document.getElementById('approvediv#form.batchid#').innerHTML="Rejected - #form.rejectbacthfield#";
ColdFusion.Window.hide('rejectbatch');
</script>

</cfoutput>
</cfif>