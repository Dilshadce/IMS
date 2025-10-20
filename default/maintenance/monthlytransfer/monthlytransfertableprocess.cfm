<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<cfparam name="status" default="">
<cfif form.datefrom neq ''>
<cfset form.datefrom=dateformat(createdate(right(form.datefrom,4),mid(form.datefrom,4,2),left(form.datefrom,2)),'yyyy-mm-dd')>
<cfelse>
<cfset form.datefrom='0000-00-00'>
</cfif>

<cfif form.dateto neq ''>
<cfset form.dateto=dateformat(createdate(right(form.dateto,4),mid(form.dateto,4,2),left(form.dateto,2)),'yyyy-mm-dd')>
<cfelse>
<cfset form.dateto='0000-00-00'>
</cfif>

<cfif form.mode eq "Create">
	<cftry>
		<cfquery name="insert" datasource="#dts#">
        insert into monthlytransfer 
        (itemno,fperiod,qty,qty2,qty3,qty4,qty5,datefrom,dateto,monthly) 
        values
        (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemno#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fperiod#">,'#val(form.qty)#','#val(form.qty2)#','#val(form.qty3)#','#val(form.qty4)#','#val(form.qty5)#','#form.datefrom#','#form.dateto#',<cfif isdefined('form.monthly')>'Y'<cfelse>''</cfif>)
		</cfquery>
		<cfcatch type="database">
			<h3 align="center">Error. This Transfer Limit Has Been Created Already !</h3>
			<p align="center"><input type="button" name="Back" value="Back" onClick="javascrip:history.back()"></p>
			<cfabort>
		</cfcatch>
	</cftry>
	
	<cfset status="The Transfer Limit for #form.itemno# for period #form.fperiod# Has Been Created successfully !">

<cfelse>
	<cfswitch expression="#form.mode#">
		<cfcase value="Delete">
			<cftry>
				<cfquery datasource='#dts#' name="deletebranch">
					Delete from monthlytransfer where id='#form.id#'
				</cfquery>
				<cfcatch type="database">
					<cfset status="Sorry, The Transfer Limit for #form.itemno# for period #form.fperiod# was Removed From The System !">
					<p align="center"><input type="button" name="Back" value="Back" onClick="javascrip:history.back()"></p>
					<cfabort>
				</cfcatch>
			</cftry>
			
			<cfset status="The Transfer Limit for #form.itemno# for #form.fperiod# Has Been Deleted Successfully!">
		</cfcase>
		<cfcase value="Edit">
            <cfquery name="update" datasource="#dts#">
            update monthlytransfer
            set
            itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemno#">,
            fperiod=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fperiod#">,
            qty='#val(form.qty)#',
         	qty2='#val(form.qty2)#',
        	qty3='#val(form.qty3)#',
         	qty4='#val(form.qty4)#',
         	qty5='#val(form.qty5)#',
        	datefrom='#form.datefrom#',
         	dateto='#form.dateto#',
            monthly=<cfif isdefined('form.monthly')>'Y'<cfelse>''</cfif>
            where id='#form.id#'
		</cfquery>
            
			<cfset status="The Transfer Limit for #form.itemno# for  #form.fperiod# Has Been Edited Successfully!">
		</cfcase>
	</cfswitch>
</cfif>

<cfoutput>
	<form name="done" action="s_monthlytransfer.cfm?type=monthlytransfer&process=done" method="post">
		<input name="status" value="#status#" type="hidden">
	</form>
</cfoutput>

<script>
	done.submit();
</script>