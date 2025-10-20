<cfif isdefined('url.id')>
<cfsetting showdebugoutput="no">
<cfquery name="updaterow" datasource="#dts#">
UPDATE argiro SET 
appstatus = "Approved",
approved_by = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getauthuser()#">,
approved_on = now()
WHERE id = "#url.id#"
</cfquery>

<cfquery name="getbatchno" datasource="#dts#">
SELECT batchno,submited_by FROM argiro WHERE id = "#url.id#"
</cfquery>

<cfquery name="getassignment" datasource="#dts#">
SELECT empno,paydate,invoiceno,refno FROM assignmentslip WHERE batches = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbatchno.batchno#">
</cfquery>

<cfloop query="getassignment">
<cfquery name="lockartran" datasource="#dts#">
UPDATE artran SET posted = 'P' 
WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.invoiceno#">
</cfquery>
<cfquery name="lockassign" datasource="#dts#">
UPDATE assignmentslip SET posted = 'P' 
WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.refno#">
</cfquery>
</cfloop>

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
<!--- <cfmail from="#getgsetup.mailuser#" to="#trim(getemail.useremail)#" server="#getgsetup.mailserver#" username="#getgsetup.mailuser#" password="#getgsetup.mailpassword#" port="#getgsetup.mailport#" bcc="#bccmail#" type="html" subject="Batch #getbatchno.batchno# has been approved">
Dear #getbatchno.submited_by#<br>
<br>
The batch report #getbatchno.batchno# has been approved.<br>
<br>
Please proceed to make payment.<br>
<br><br>
Regards,<br>
<br>
#getgsetup.compro#
</cfmail> --->
</cfif> 
</cfif>
           

<cfoutput>
Approved
</cfoutput>
</cfif>