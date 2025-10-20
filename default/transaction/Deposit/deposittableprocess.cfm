<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<cfparam name="status" default="">
<cfif form.wos_date neq ''>
<cfset form.wos_date=createdate(right(form.wos_date,4),mid(wos_date,4,2),left(wos_date,2))>
<cfinvoke component="cfc.Period" method="getCurrentPeriod" dts="#dts#" inputDate="#dateformat(form.wos_date,'yyyy-mm-dd')#" returnvariable="form.fperiod"/>
<cfset form.wos_date=dateformat(form.wos_date,'YYYY-MM-DD')>
<cfelse>
<cfset form.fperiod=''>
<cfset form.wos_date='0000-00-00'>
</cfif>

<cfif form.mode eq "Create">
	<cftry>
		<cfinsert datasource='#dts#' tablename="Deposit" formfields="Depositno,desp,CS_PM_CASH,CS_PM_CHEQ,CS_PM_CRCD,CS_PM_CRC2,CS_PM_DBCD,CS_PM_VOUC,chequeno,cctype1,cctype2,sono,wos_date,taxcode,ptax,fperiod,custno,add1,add2,add3,add4">
		
        <cfif lcase(huserloc) neq "all_loc">
        <cfquery name="update" datasource="#dts#">
        			update refnoset_location set 
                    lastUsedNo=UPPER('#Depositno#')
                    where type = 'DEP'
                    and location = '#huserloc#'
        </cfquery>
        </cfif>
        
		<cfcatch type="database">
			<h3 align="center">Error. This Deposit Has Been Created Already !</h3>
			<p align="center"><input type="button" name="Back" value="Back" onClick="javascrip:history.back()"></p>
			<cfabort>
		</cfcatch>
	</cftry>
	
	<cfset status="The Deposit, #form.Depositno# Has Been Created successfully !">

<cfelse>
	<cfswitch expression="#form.mode#">
		<cfcase value="Delete">
			<cftry>
				<cfquery datasource='#dts#' name="deleteDeposit">
					Delete from Deposit where depositno='#form.depositno#'
				</cfquery>
				<cfcatch type="database">
					<cfset status="Sorry, The Deposit, #form.Depositno# was Removed From The System !">
					<p align="center"><input type="button" name="Back" value="Back" onClick="javascrip:history.back()"></p>
					<cfabort>
				</cfcatch>
			</cftry>
			
			<cfset status="The Deposit, #form.Depositno# Has Been Deleted Successfully!">
		</cfcase>
		<cfcase value="Edit">
			<cfquery name="update" datasource="#dts#">
            	UPDATE deposit SET
                desp=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#">,
                CS_PM_CASH="#val(form.CS_PM_CASH)#",
                CS_PM_CHEQ="#val(form.CS_PM_CHEQ)#",
                CS_PM_CRCD="#val(form.CS_PM_CRCD)#",
                CS_PM_CRC2="#val(form.CS_PM_CRC2)#",
                CS_PM_DBCD="#val(form.CS_PM_DBCD)#",
                CS_PM_VOUC="#val(form.CS_PM_VOUC)#",
                chequeno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.chequeno#">,
                cctype1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cctype1#">,
                cctype2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cctype2#">,
                sono=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sono#">,
                taxcode=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.taxcode#">,
                ptax="#val(form.ptax)#",
                custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custno#">,
                add1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.add1#">,
                add2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.add2#">,
                add3=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.add3#">,
                add4=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.add4#">
                
                WHERE depositno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.depositno#">
            </cfquery>
			<cfset status="The Deposit, #form.Depositno# Has Been Edited Successfully!">
		</cfcase>
	</cfswitch>
</cfif>

<cfif isdefined('expresscreate')>
<cfoutput>
<script>
	myoption = window.opener.document.createElement("OPTION");
	myoption.text = "#form.Depositno#";
	myoption.value = "#form.Depositno#";
	myoption.title = "#(((val(form.CS_PM_CASH)+val(form.CS_PM_CHEQ)+val(form.CS_PM_CRCD)+val(form.CS_PM_CRC2)+val(form.CS_PM_DBCD)+val(form.CS_PM_VOUC))))#"
	window.opener.document.invoicesheet.depositno.options.add(myoption);
	var indexvalue = window.opener.document.getElementById("depositno").length-1;
	window.opener.document.getElementById("depositno").selectedIndex=indexvalue;
	window.opener.getDiscountControl();
	window.close();
</script>
</cfoutput>

<cfelseif isdefined('transactioncreate')>
<cfoutput>
<script>
	<!---window.opener.addnewdeposit('#form.Depositno#');--->
	window.close();
	window.open('printdeposit.cfm?depositno=#form.Depositno#','_blank');
</script>
</cfoutput>

<cfelse>
<cfoutput>
	<form name="done" action="s_Deposittable.cfm?type=Deposit&process=done" method="post">
		<input name="status" value="#status#" type="hidden">
	</form>
</cfoutput>
<cfoutput>
<script>
<cfif form.mode eq "Create">
	window.open('printdeposit.cfm?depositno=#form.Depositno#','_blank');
</cfif>
	done.submit();
</script>
</cfoutput>
</cfif>