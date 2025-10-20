
<html>
<head>
<title>Express Location Quantity Adjustment</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<body>
<cfif form.mode eq 'Create'>
<cfquery name="insertlocadjtran" datasource="#dts#">
insert into locadjtran select * from locadjtran_temp where uuid='#form.uuid#'
</cfquery>

<cfquery name="insertlocadjtran" datasource="#dts#">
update locadjtran_temp set onhold="" where uuid='#form.uuid#'
</cfquery>
</cfif>
<cfset date = createdate(right(form.wos_date,4),mid(form.wos_date,4,2),left(form.wos_date,2))>

<cfquery name="updatedate" datasource="#dts#">
update locadjtran set date='#dateformat(date,'yyyy-mm-dd')#',period='#form.period#' where refno='#form.refno#' and uuid='#form.uuid#'
</cfquery>

<cfinvoke component="cfc.expressadjustment_ physical_adjustment_increase_reduce" method="update_icitem_qtyactual">
	<cfinvokeargument name="dts" value="#dts#">
	<cfinvokeargument name="form" value="#form#">
    <cfinvokeargument name="huserid" value="#huserid#">
</cfinvoke>

<script language="javascript" type="text/javascript">
	alert("Express Adjustment Process Done !");
	window.location='index.cfm'
</script>
</body>
</html>