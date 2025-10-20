<!--- <cfset dd = dateformat('#servicedate#', "DD")>
<cfif dd greater than '12'>
	<cfset nDateNow=dateformat('#servicedate#',"YYYYMMDD")>
<cfelse>
	<cfset nDateNow=dateformat('#servicedate#',"YYYYDDMM")>
</cfif> --->
<cfinvoke component="cfc.date" method="getDbDate" inputDate="#servicedate#" returnvariable="nDateNow"/>

<cfquery datasource="#dts#" name="insertservice">
	Insert into service_tran 
	(`custno`,`csoid`,`servicedate`,`servicetype`,`assby`,`s_status`,`instruction`,`apptime`,`collect`,`comments`,`qty`) 
	values ("#custno1#", "#csoid#", "#nDateNow#" ,"#servicetype#", 
	"#assby#", "#s_status#", <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#instruction#">, "#apptime#", "#collect#", "","#val(qty)#")	
</cfquery>

<cfset status="The Job for #custno1# had been successfully created. ">

<cfoutput>
	<form name="done" action="viewjob.cfm" method="post">
		<input name="status" value="#status#" type="hidden">
	</form>
</cfoutput>

<script>
	done.submit();
</script>