<!--- <cfset dd = dateformat('#servicedate#', "DD")>
<cfif dd greater than '12'>
	<cfset nDateNow=dateformat('#servicedate#',"YYYYMMDD")>
<cfelse>
	<cfset nDateNow=dateformat('#servicedate#',"YYYYDDMM")>
</cfif> --->
<cfinvoke component="cfc.date" method="getDbDate" inputDate="#form.servicedate#" returnvariable="nDateNow"/>

<cfquery datasource="#dts#" name="insertservice">
	Insert into service_tran 
	(`refno`,`csoid`,`servicedate`,`servicetype`,`assby`,`instruction`,`apptime`,`comments`) 
	values ("#form.refno#", "#form.csoid#", "#nDateNow#" ,"#form.servicetype#", 
	"#form.assby#", <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.instruction#">, "#form.apptime#", "")	
</cfquery>

<cfset status="The Job for #refno# had been successfully created. ">

<cfoutput>
	<form name="done" action="viewjob.cfm" method="post">
		<input name="status" value="#status#" type="hidden">
	</form>
</cfoutput>

<script>
	done.submit();
</script>