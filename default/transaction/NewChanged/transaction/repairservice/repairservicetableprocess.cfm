<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<cfparam name="status" default="">

<cfset ndate = createdate(right(form.wos_date,4),mid(form.wos_date,4,2),left(form.wos_date,2))>
<cfset ncompletedate = createdate(right(form.completedate,4),mid(form.completedate,4,2),left(form.completedate,2))>



			<cfquery name="updaterepairno" datasource="#dts#">
            update repairtran set 
            desp=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#">,
            wos_date='#dateformat(ndate,'YYYY-MM-DD')#',
            custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custno#">,
            name=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.name#">,
            completedate='#dateformat(ncompletedate,'YYYY-MM-DD')#',
            repairitem=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.repairitem#">,
            grossamt='#val(grossamt)#',
            agent=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.agent#">,
            rem5=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rem5#">,
            rem6=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rem6#">,
            rem7=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rem7#">,
            rem8=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rem8#">,
            rem9=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rem9#">,
            rem10=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rem10#">,
            rem11=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rem11#">,
            status='Delivery',
            add1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.b_add1#">,
            add2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.b_add2#">,
            add3=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.b_add3#">,
            add4=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.b_add4#">,
            phone=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.b_phone#">,
            phonea=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.b_phone2#">,
            fax=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.b_fax#">
            
            where repairno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.repairno#">
            </cfquery>
			<cfset status="The Repair, #form.repairno# Has Been Edited Successfully!">
		

<cfoutput>

	<form name="done" action="s_repairservicetable.cfm?type=Package&process=done" method="post">
		<input name="status" value="#status#" type="hidden">
	</form>
</cfoutput>

<script>
	done.submit();
</script>