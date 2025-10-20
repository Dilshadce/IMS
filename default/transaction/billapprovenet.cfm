<cfcontent reset="yes" type="text/html">
<cfif isdefined('url.comid')>
<cfset dts=url.comid>
<cfquery name="getbillverify" datasource="#dts#">
SELECT type,refno,printstatus,created_on,name,grand,created_by FROM artran WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.refno)#"> and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.billtype)#">
</cfquery>

<cfif getbillverify.recordcount neq 0>
<cfset newunlockcode  = getbillverify.printstatus&getbillverify.type&getbillverify.refno&dateformat(getbillverify.created_on,'yyyymmdd')&timeformat(getbillverify.created_on,'HHMMSS')&dts>
<cfset newunlockcode = hash(newunlockcode)>

<cfif getbillverify.printstatus eq "a1">

<cfquery name="getgsetup" datasource="#dts#">
select printapproveamt from gsetup;
</cfquery>

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