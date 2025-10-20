
<cfif url.action eq "send">
<cfquery name="sendbill" datasource="#dts#">
	UPDATE ictran SET void="" where type="TROU" and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#">
</cfquery>

<cfquery name="sendbill2" datasource="#dts#">
	UPDATE artran SET rem14="In transit" where type="TR" and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#">
</cfquery>

<cfset status="Transfer Sent">

<cfelseif url.action eq "receive">
<cfquery name="sendbill" datasource="#dts#">
	UPDATE ictran SET void="" where type="TRIN" and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#">
</cfquery>

<cfquery name="sendbill2" datasource="#dts#">
	UPDATE artran SET rem14="Received",rem13="#huserid#" where type="TR" and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#">
</cfquery>

<cfset status="Transfer Received">

</cfif>

<cfoutput>
<script type="text/javascript">
    alert('#status# Completed');
	window.opener.location.href="siss.cfm?tran=TR";
	window.close();
</script>
</cfoutput>