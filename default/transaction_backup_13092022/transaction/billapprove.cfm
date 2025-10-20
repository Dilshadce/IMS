<cfcontent reset="yes" type="text/html">
<cfif isdefined('url.comid')>
<cfset dts=url.comid>
<cfquery name="getbillverify" datasource="#dts#">
SELECT type,refno,printstatus,created_on,name,grand,created_by FROM artran WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.refno)#"> and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.billtype)#">
</cfquery>

<cfif getbillverify.recordcount neq 0>
<cfset newunlockcode  = getbillverify.printstatus&getbillverify.type&getbillverify.refno&dateformat(getbillverify.created_on,'yyyymmdd')&timeformat(getbillverify.created_on,'HHMMSS')&dts>
<cfset newunlockcode = hash(newunlockcode)>

<cfif newunlockcode eq url.code>

<cfif getbillverify.printstatus eq "a1">

<cfquery name="getgsetup" datasource="#dts#">
select printapproveamt from gsetup;
</cfquery>

<cfif getgsetup.printapproveamt neq 0 and getbillverify.grand lte getgsetup.printapproveamt>
<cfquery name="updatestatus" datasource="#dts#">
update artran set printstatus='a3' where type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.billtype)#"> and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.refno)#">
</cfquery>
<cfoutput>
<script type="text/javascript">
alert('Transaction Printing has been allowed');
window.location.href="http://ims.netiquette.com.sg";
</script>
</cfoutput>
<cfabort />
</cfif>

<cfquery name="getadminmail" datasource="main">
select useremail from users where userDept = "#dts#" and userGrpId="admin" and useremail <> ""
</cfquery>
<cfset email1=''>
<cfloop query="getadminmail">
<cfset email1=email1&getadminmail.useremail>
<cfif getadminmail.recordcount neq getadminmail.currentrow>
<cfset email1=email1&",">
</cfif>
</cfloop>

<cfif email1 neq ''>
<cfoutput>
<cfset unlockcode  = "a2"&getbillverify.type&getbillverify.refno&dateformat(getbillverify.created_on,'yyyymmdd')&timeformat(getbillverify.created_on,'HHMMSS')&dts>
<cftry>
<cfmail 
			from="noreply@mynetiquette.com"
			to="#email1#" 
			subject="#getbillverify.type#-#getbillverify.refno#"
		> <cfmailparam file = "C:\Inetpub\wwwroot\IMS\billformat\#dts#\#url.refno#.pdf" >
This message was sent by an automatic mailer built with cfmail:
= = = = = = = = = = = = = = = = = = = = = = = = = = =

Kindly Approve The Below Bill For Printing.
PO No : #getbillverify.refno#
Supplier Name:#getbillverify.name#
Total Amount:#getbillverify.grand#

To Approve Click click on link below.

http://crm.netiquette.com.sg/billapprove.cfm?comid=#URLENCODEDFORMAT(dts)#&billtype=#URLENCODEDFORMAT(getbillverify.type)#&refno=#URLENCODEDFORMAT(getbillverify.refno)#&code=#hash(unlockcode)#


In Case Above Link Does Not Work Click On Link Below


http://crm.mynetiquette.com/billapprove.cfm?comid=#URLENCODEDFORMAT(dts)#&billtype=#URLENCODEDFORMAT(getbillverify.type)#&refno=#URLENCODEDFORMAT(getbillverify.refno)#&code=#hash(unlockcode)#

</cfmail>
<cfcatch>
</cfcatch>
</cftry>
</cfoutput>
</cfif>

<cfquery name="updatestatus" datasource="#dts#">
update artran set printstatus='a2' where type='#getbillverify.type#'and refno='#getbillverify.refno#'
</cfquery>
<cfoutput>
<script type="text/javascript">
alert('Email has been send For Admin Approval.');
window.location.href="http://ims.netiquette.com.sg";
</script>
</cfoutput>
<cfabort/>
</cfif>

<cfif getbillverify.printstatus eq "a2">
<cfquery name="updatestatus" datasource="#dts#">
update artran set printstatus='a3' where type='#getbillverify.type#'and refno='#getbillverify.refno#'
</cfquery>

<cfquery name="getlimitedmail" datasource="main">
select useremail from users where userDept = "#dts#" and userGrpId="luser" and useremail <> "" and userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbillverify.created_by#">
</cfquery>
<cfset email1=''>
<cfloop query="getlimitedmail">
<cfset email1=email1&getlimitedmail.useremail>
<cfif getlimitedmail.recordcount neq getlimitedmail.currentrow>
<cfset email1=email1&",">
</cfif>
</cfloop>

<cfif email1 neq ''>

<cfoutput>
<cftry>
<cfmail 
			server="mail.mynetiquette.com" 
			from="noreply@mynetiquette.com"
			to="#email1#" 
			subject="#getbillverify.type#-#getbillverify.refno#"
		> <cfmailparam file = "C:\Inetpub\wwwroot\IMS\billformat\#dts#\#url.refno#.pdf" >

Bill has been approved.
PO No : #getbillverify.refno#
Supplier Name:#getbillverify.name#
Total Amount:#getbillverify.grand#

http://ims.netiquette.com.sg/

</cfmail>
<cfcatch>
</cfcatch>
</cftry>
</cfoutput>

</cfif>
<cfoutput>
<script type="text/javascript">
alert('Transaction has been allowed');
window.location.href="http://ims.netiquette.com.sg";

</script>
</cfoutput>
<cfabort/>
</cfif>

<cfelse>
<cfset lateapprove = 0>
<cfif getbillverify.printstatus eq "a3">
<cfset newunlockcode  = "a2"&getbillverify.type&getbillverify.refno&dateformat(getbillverify.created_on,'yyyymmdd')&timeformat(getbillverify.created_on,'HHMMSS')&dts>
<cfset newunlockcode = hash(newunlockcode)>

	<cfif newunlockcode eq url.code>
    	<cfset lateapprove = 1>
    <cfelse>
		<cfset newunlockcode  = "a1"&getbillverify.type&getbillverify.refno&dateformat(getbillverify.created_on,'yyyymmdd')&timeformat(getbillverify.created_on,'HHMMSS')&dts>
        <cfset newunlockcode = hash(newunlockcode)>
        <cfif newunlockcode eq url.code>
        <cfset lateapprove = 1>
		</cfif>
    </cfif>

</cfif>

<cfif getbillverify.printstatus eq "a2">
<cfset newunlockcode  = "a1"&getbillverify.type&getbillverify.refno&dateformat(getbillverify.created_on,'yyyymmdd')&timeformat(getbillverify.created_on,'HHMMSS')&dts>
<cfset newunlockcode = hash(newunlockcode)>

	<cfif newunlockcode eq url.code>
    	<cfset lateapprove = 1>
    </cfif>

</cfif>


<cfoutput>
<script type="text/javascript">
<cfif lateapprove eq 1>alert('Bill has been approved!');<cfelse>alert('Bill Code verification fail. Please login into system to approve the bill.');</cfif>
window.location.href="http://ims.netiquette.com.sg";

</script>
</cfoutput><cfabort/>
</cfif>

<cfelse>
<cfoutput>
<script type="text/javascript">
alert('No Bill Data Found');
window.location.href="http://ims.netiquette.com.sg";
</script>
</cfoutput>
<cfabort/>
</cfif>

</cfif>