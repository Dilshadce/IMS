<cftry>

<cfset packlist = form.packID>

<cfloop list="#packlist#" index="i">

<cfquery name="getPackData" datasource="#dts#">
SELECT * FROM packlist where packID = "#i#" and (driver is null or driver = "")
</cfquery>

<cfif getPackData.recordcount neq 0>
<cfset ndate = createdate(right(form.deliverydate,4),mid(form.deliverydate,4,2),left(form.deliverydate,2))>
<cfinvoke component="cfc.Period" method="getCurrentPeriod" dts="#dts#" inputDate="#dateformat(ndate,'yyyy-mm-dd')#" returnvariable="readperiod"/>
<cfset deliverydatenew = dateformat(ndate,'yyyy-mm-dd')>

<cfquery name="updatepacklist" datasource="#dts#">
UPDATE packlist SET 
driver = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.driver#" >,
delivery_on = "#deliverydatenew#",
assigned_by = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Husername#">,
assigned_on = now(),
trip = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.trip#"> 
WHERE packid = "#i#"
</cfquery>

<cfquery name="getbilllist" datasource="#dts#">
SELECT billrefno,reftype FROM packlistbill WHERE packid = "#i#"
</cfquery>

<cfloop query="getbilllist">
<cfquery name="updateartran" datasource="#dts#">
UPDATE artran 
SET 
wos_date = "#deliverydatenew#",
van = "#form.driver#",
fperiod = "#readperiod#"
where 
refno = "#getbilllist.billrefno#" 
and type ="#getbilllist.reftype#" 
</cfquery>
<cfquery name="updateartran" datasource="#dts#">
UPDATE ictran 
SET 
wos_date = "#deliverydatenew#",
van = "#form.driver#",
fperiod = "#readperiod#"
where 
refno = "#getbilllist.billrefno#" 
and type ="#getbilllist.reftype#" 
</cfquery>
</cfloop>
</cfif>

</cfloop>
<script type="text/javascript">
alert('SUCCESS ASSIGN DRIVER');
ColdFusion.Window.hide('assigndriver');
ajaxFunction1(document.getElementById('ajaxField'),'listpackingmainAjax.cfm?packID='+escape(document.getElementById('packidsearch').value)+'&datepacked='+escape(document.getElementById('datepacksearch').value)+'&driver='+escape(document.getElementById('driversearch').value));
</script>

 <cfcatch type="any">
<script type="text/javascript">
alert('FAIL ASSIGN DRIVER');
ColdFusion.Window.hide('assigndriver');
ajaxFunction1(document.getElementById('ajaxField'),'listpackingmainAjax.cfm?packID='+escape(document.getElementById('packidsearch').value)+'&datepacked='+escape(document.getElementById('datepacksearch').value)+'&driver='+escape(document.getElementById('driversearch').value));
</script>
</cfcatch>
</cftry> 