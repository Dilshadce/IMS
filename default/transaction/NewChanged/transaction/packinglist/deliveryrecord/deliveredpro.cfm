<cfif isdefined('form.delrefno')>
<cfloop list="#form.delrefno#" index="a">
<cfquery name="updatedlist" datasource="#dts#">
UPDATE packlistbill
SET
delivered_on = "#dateformat(createdate(right(form.deliverydate,4),mid(form.deliverydate,4,2),left(form.deliverydate,2)),'YYYY-MM-DD')#",
delivered_by = "#huserid#"
WHERE packlistbillid = "#a#"
</cfquery>
</cfloop>
</cfif>

<cfif isdefined('form.unrefno')>
<cfloop list="#form.unrefno#" index="a">
<cfquery name="getbillrefno" datasource="#dts#">
SELECT * FROM packlistbill WHERE packlistbillid = "#a#"
</cfquery>

<cfquery name="updatedlist" datasource="#dts#">
UPDATE artran
SET
packed = "N" 
WHERE refno =  "#getbillrefno.billrefno#"
and type = "#getbillrefno.reftype#"
</cfquery>

<cfquery name="deleterecord" datasource="#dts#">
DELETE FROM packlistbill WHERE packlistbillid = "#a#"
</cfquery>
</cfloop>
</cfif>

<cfquery name="checkavail" datasource="#dts#">
SELECT delivered_on,delivered_by
FROM packlistbill
WHERE packid = "#form.packid#"
and (delivered_on = "0000-00-00" or delivered_on is null)
and (delivered_by = "" or delivered_by is null)
</cfquery>

<cfif checkavail.recordcount eq 0>
<cfquery name="getDeliveredOn" datasource="#dts#">
SELECT delivered_on,delivered_by
FROM packlistbill
WHERE packid = "#form.packid#" order by delivered_on desc
</cfquery>
<cfif getDeliveredOn.recordcount neq 0>
<cfquery name="updatedate" datasource="#dts#">
Update packlist SET 
delivered_on = "#dateformat(getDeliveredOn.delivered_on,'YYYY-MM-DD')#"
,delivered_by = "#getDeliveredOn.delivered_by#"
WHERE packid = "#form.packid#"
</cfquery>
<cfelse>
<cfquery name="updatedate" datasource="#dts#">
Update packlist SET 
driver = "",
delivery_on = "0000-00-00",
assigned_by = "",
assigned_on = "0000-00-00"
WHERE packid = "#form.packid#"
</cfquery>
</cfif>
</cfif>
<div align="center">
<h1>Save Complete</h1>
<input type="button" name="close" value="CLOSE" onClick="closewindow();" />
</div>