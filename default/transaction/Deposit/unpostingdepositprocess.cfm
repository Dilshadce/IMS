<cfif form.sort eq 'wos_date'>
<cfset ndatefrom=createdate(right(form.datefrom,4),mid(form.datefrom,4,2),left(form.datefrom,2))>
<cfset ndateto=createdate(right(form.dateto,4),mid(form.dateto,4,2),left(form.dateto,2))>
</cfif>
<cfquery name="getgsetup" datasource="#dts#">
select * from gsetup
</cfquery>

<cfquery name="getdeposit" datasource="#dts#">
select * from deposit where posted='P'
<cfif form.sort eq 'wos_date'>
and wos_date between '#dateformat(ndatefrom,'yyyy-mm-dd')#' and '#dateformat(ndateto,'yyyy-mm-dd')#'
<cfelseif form.sort eq 'fperiod'>
and fperiod='#form.fperiod#'
<cfelseif form.sort eq 'sono'>
and sono between '#form.sonofrom#' and '#form.sonoto#'
<cfelseif form.sort eq 'depositno'>
and depositno between '#form.depositfrom#' and '#form.depositto#'
</cfif>
</cfquery>

<cfset dts2=replace(dts,"_i","_a","all")>

<cfloop query="getdeposit">
<cfquery name="checkinvposted" datasource="#dts#">
	SELECT posted,refno from artran where depositno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getdeposit.depositno#"> and type="INV"
</cfquery>
<cfif checkinvposted.posted neq "">
<cfelse>
            
            <cfquery name="deletepost" datasource="#dts#">
			delete from glpost9 
            where acc_code='DEP' 
			and reference=<cfqueryparam cfsqltype="cf_sql_char" value="#getdeposit.depositno#">
			</cfquery>
			
			<cfquery name="deletepost2" datasource="#dts#">
			delete from glpost91
            where acc_code='DEP' 
			and reference=<cfqueryparam cfsqltype="cf_sql_char" value="#getdeposit.depositno#">
			</cfquery>
            
            <cfquery name="deletepost3" datasource="#dts2#">
			delete from glpost
            where acc_code='DEP' 
			and reference=<cfqueryparam cfsqltype="cf_sql_char" value="#getdeposit.depositno#">
			</cfquery>
            
            <cfquery name="update" datasource="#dts#">
				update deposit set posted='' where depositno='#getdeposit.depositno#'
			</cfquery>
</cfif>
</cfloop>



<cfset status='Bill has been unposted'>

<cfoutput>
	<form name="done" action="s_Deposittable.cfm?type=Deposit&process=done" method="post">
		<input name="status" value="#status#" type="hidden">
	</form>
</cfoutput>
<cfoutput>
<script>
	done.submit();
</script>
</cfoutput>