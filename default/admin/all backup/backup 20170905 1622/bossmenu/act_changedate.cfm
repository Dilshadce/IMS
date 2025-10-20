<cfparam name="status" default="">
<cfquery name="checkoldrefno" datasource="#dts#">
	select refno,wos_date from artran
	where refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.oldrefno#">
	and type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.reftype#">
</cfquery>
<cfset olddate=dateformat(checkoldrefno.wos_date,'yyyy-mm-dd')>

        
<cfif checkoldrefno.recordcount eq 0>
	This Reference No. Not Exist! <cfabort>
</cfif>
<cfif form.year1 neq "" and form.month1 neq "" and form.day1 neq "">
	
        <cfset newdate = createdate('#form.year1#','#form.month1#','#form.day1#') >
		<cfset oldcode = form.oldrefno>
		
        <cfquery name="get_gsetup" datasource="#dts#">
			select lastaccyear,period from gsetup
		</cfquery>
		
		<cfset lastaccyear = dateformat(get_gsetup.lastaccyear, 'YYYY-MM-DD')>
		<cfset period = get_gsetup.period>
		<cfset currentdate = dateformat(newdate,'YYYY-MM-DD')>
		
		<cfset tmpYear = year(currentdate)>
		<cfset clsyear = year(lastaccyear)>

		<cfset tmpmonth = month(currentdate)>
		<cfset clsmonth = month(lastaccyear)>

		<cfset intperiod = (tmpyear-clsyear)*12+tmpmonth-clsmonth>

		<cfif intperiod gt 18 or intperiod lte 0>
			<cfset intperiod=99>
		<cfelse>
			<cfset readperiod = numberformat(intperiod,"00")>
		</cfif>
        
        
        
		<cfquery name="update" datasource="#dts#">
			update artran
			set wos_date = <cfqueryparam cfsqltype="cf_sql_char" value="#dateformat(newdate,'yyyy-mm-dd')#">,
            fperiod = <cfqueryparam cfsqltype="cf_sql_char" value="#numberformat(intperiod,"00")#">
			where refno = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
			and type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.reftype#">
		</cfquery>
		
				
		<cfquery name="update" datasource="#dts#">
			update artranat
			set wos_date = <cfqueryparam cfsqltype="cf_sql_char" value="#dateformat(newdate,'yyyy-mm-dd')#">,
            fperiod = <cfqueryparam cfsqltype="cf_sql_char" value="#numberformat(intperiod,"00")#">
			where refno = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
			and type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.reftype#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update iclink
			set wos_date = <cfqueryparam cfsqltype="cf_sql_char" value="#dateformat(newdate,'yyyy-mm-dd')#">
			where refno = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
			and type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.reftype#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update iclink
			set frdate = <cfqueryparam cfsqltype="cf_sql_char" value="#dateformat(newdate,'yyyy-mm-dd')#">
			where frrefno = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
			and frtype=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.reftype#">
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update ictran
			set wos_date = <cfqueryparam cfsqltype="cf_sql_char" value="#dateformat(newdate,'yyyy-mm-dd')#">,
            fperiod = <cfqueryparam cfsqltype="cf_sql_char" value="#numberformat(intperiod,"00")#">
			where refno = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
			<cfif form.reftype eq "TR">
				and type in ('TRIN','TROU')
			<cfelse>
				and type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.reftype#">
			</cfif>
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update igrade
			set wos_date = <cfqueryparam cfsqltype="cf_sql_char" value="#dateformat(newdate,'yyyy-mm-dd')#">,
            fperiod = <cfqueryparam cfsqltype="cf_sql_char" value="#numberformat(intperiod,"00")#">
			where refno = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
			<cfif form.reftype eq "TR">
				and type in ('TRIN','TROU')
			<cfelse>
				and type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.reftype#">
			</cfif>
		</cfquery>
		
		<cfquery name="update" datasource="#dts#">
			update iserial
			set wos_date = <cfqueryparam cfsqltype="cf_sql_char" value="#dateformat(newdate,'yyyy-mm-dd')#">,
            fperiod = <cfqueryparam cfsqltype="cf_sql_char" value="#numberformat(intperiod,"00")#">
			where refno = <cfqueryparam cfsqltype="cf_sql_char" value="#oldcode#">
			<cfif form.reftype eq "TR">
				and type in ('TRIN','TROU')
			<cfelse>
				and type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.reftype#">
			</cfif>
		</cfquery>
		
        <cfquery name="inserteditbossmenu" datasource="#dts#">
        insert into edited_bossmenu (edittype,editrefno,beforeedit,afteredit,edited_by,edited_on) values ('changedate',<cfqueryparam cfsqltype="cf_sql_char" value="#form.reftype#-#oldcode#">,<cfqueryparam cfsqltype="cf_sql_char" value="#olddate#">,<cfqueryparam cfsqltype="cf_sql_char" value="#dateformat(newdate,'yyyy-mm-dd')#">,'#huserid#',now())
        </cfquery>
        
        <cfif intperiod neq 99>
		<cfset status="The Reference No. #oldcode# Date Has Been Changed to #dateformat(newdate,'DD-MM-YYYY')# and Period Has Been Changed to #intperiod# !">
        <cfelse>
        <cfset status="The Reference No. #oldcode# Date Has Been Changed to #dateformat(newdate,'DD-MM-YYYY')#. WARNING! Period Has Been Changed to #intperiod# ! It Will Affect The Opening Quantity">
        </cfif>
	
<cfelse>
	<cfset status="The New Date. cannot be empty!">
</cfif>
<cfoutput>
	<form name="done" action="changedate.cfm?process=done" method="post">
		<input name="status" value="#status#" type="hidden">
	</form>
</cfoutput>

<script>
	done.submit();
</script>