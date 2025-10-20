<cfif isdefined('form.packID')>
<cfloop list="#form.packID#" index="a">
<cfquery name="updatedlist" datasource="#dts#">
UPDATE packlistbill
SET
delivered_on = "#dateformat(createdate(right(form.deliverydate,4),mid(form.deliverydate,4,2),left(form.deliverydate,2)),'YYYY-MM-DD')#",
delivered_by = "#huserid#"
WHERE packid = "#a#"
and (delivered_on = "0000-00-00" or delivered_on is null)
and (delivered_by = "" or delivered_by is null)
</cfquery>

<cfquery name="updatedlist" datasource="#dts#">
UPDATE packlist
SET
delivered_on = "#dateformat(createdate(right(form.deliverydate,4),mid(form.deliverydate,4,2),left(form.deliverydate,2)),'YYYY-MM-DD')#",
delivered_by = "#huserid#"
WHERE packid = "#a#"
</cfquery>
</cfloop>
</cfif>
<script type="text/javascript">
alert('Bill Delivered Success!');
window.location.href="checkdelivered.cfm";
</script>
