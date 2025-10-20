<cfparam name="status" default="">

<cfquery name="checkoldrefno" datasource="#dts#">
	select refno from artran
	where refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.oldrefno#">
	and type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.reftype#">
</cfquery>
<cfif checkoldrefno.recordcount eq 0>
	This Reference No. Does Not Exist! <cfabort>
</cfif>
		<cfquery name="update" datasource="#dts#">
			update artran
			set toinv = "C",order_cl="C",exported="C"
			where refno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.oldrefno#">
			and type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.reftype#">
		</cfquery>
        
		<cfset status="The Reference No. #form.oldrefno# Has Been Closed !">

<cfoutput>
	<form name="done" action="closequo.cfm?process=done" method="post">
		<input name="status" value="#status#" type="hidden">
	</form>
</cfoutput>

<script>
	done.submit();
</script>