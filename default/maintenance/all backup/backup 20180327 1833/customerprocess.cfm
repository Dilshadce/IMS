<cfoutput>
	<cfinvoke component="cfc.create_update_delete_customer_supplier" method="amend_customer_supplier" returnvariable="status1">
		<cfinvokeargument name="dts" value="#dts#">
		<cfinvokeargument name="dts1" value="#dts#">
		<cfinvokeargument name="hlinkams" value="#hlinkams#">
		<cfinvokeargument name="huserid" value="#huserid#">
		<cfinvokeargument name="form" value="#form#">
	</cfinvoke>
    <cfquery name='getgsetup' datasource='#dts#'>
  Select capall from gsetup
</cfquery>
<cfif isdefined('form.nexcustno')>
    <cfif form.nexcustno eq 1>
    <cfset lastusedno = right(form.custno,3) >
	<cfelse>
    <cfset lastusedno = form.custno >
	</cfif>
    <cfquery name="updatelastusedno" datasource="#dts#">
    Update refnoset SET lastUsedNo = "#lastusedno#" WHERE type = "CUST"
    </cfquery>
	</cfif>
	<form name="done" action="vPersonnel.cfm?type=Customer&process=done" method="post">
		<input name="status" value="#status1#" type="hidden">
	</form>
</cfoutput>

<cfif lcase(HcomID) eq "taftc_i">

  <cfif form.year eq "" or form.month eq "" or form.day eq "">
  <cfset newdate ="19300101">
  <cfelse>
<cfset newdate = createdate(form.year,form.month,form.day) >
</cfif>
<cfquery name="updateremark" datasource="#dts#">
 UPDATE #target_arcust#
 SET
 ARREM5 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.arrem5#">,
 ARREM6 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.arrem6#">,
 ARREM7 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.arrem7#">,
 ARREM8 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.arrem8#">,
 ARREM9 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.arrem9#">,
 ARREM10 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.arrem10#">,
 ARREM11 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.arrem11#">,
 ARREM12 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.arrem12#">,
 ARREM13 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.arrem13#">,
 ARREM14 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.arrem14#">,
 ARREM15 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.arrem15#">,
 ARREM16 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.arrem16#">,
  ARREM17 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.arrem17#">,
  <cfif form.year eq "" or form.month eq "" or form.day eq "">
 ARREM18 = <cfqueryparam cfsqltype="cf_sql_varchar" value="1930-01-01">
 <cfelse>
 ARREM18 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(newdate,'yyyy-mm-dd')#">
 </cfif>
 WHERE
 custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custno#">
</cfquery>
</cfif>


<cfif (lcase(hcomid) eq "accord_i" or lcase(hcomid) eq "demoinsurance_i")>
<cfset newdate = createdate('#form.year1#','#form.month1#','#form.day1#') >
<cfset newdate2 = createdate('#form.year2#','#form.month2#','#form.day2#') >
<cfquery name="updateremark2" datasource="#dts#">
 UPDATE #target_arcust#
 SET
 ARREM4 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#newdate2#">,
 ARREM5 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#newdate#">,
 ARREM6 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.arrem6#">
 WHERE
 custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custno#">
</cfquery>
<cfquery name="updateremark2" datasource="#dts#">
 UPDATE vehicles
 SET
 licdate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(newdate2,'yyyy-mm-dd')#">,
 dob = <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(newdate,'yyyy-mm-dd')#">,
 custic = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.arrem1#">,
 gender = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.arrem2#">,
 marstatus = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.arrem3#">,
 custrefer = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.arrem6#">,
 contract = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.contact#">
 WHERE
 custcode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custno#">
</cfquery>
</cfif>

<cfquery name="updateremark3" datasource="#dts#">
 UPDATE #target_arcust#
 SET
 normal_rate  = '#val(form.normal_rate)#',
 offer_rate  = '#val(form.offer_rate)#',
 others_rate  = '#val(form.others_rate)#',
 headquaters = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.headquaters#">,
 taxcode= <cfif isdefined('form.taxcode')><cfqueryparam cfsqltype="cf_sql_varchar" value="#form.taxcode#"><cfelse>''</cfif>
 WHERE
 custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custno#">
 
</cfquery>

<cfquery name="updateremark4" datasource="#dts#">
 UPDATE #target_arcust#
 SET
 SALEC  = '#form.SALEC#',
 SALECNC  = '#form.SALECNC#'
 WHERE
 custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custno#">
 
</cfquery>

<cfif getgsetup.capall eq 'Y'>
<cfquery name="updateallitemtocap" datasource="#dts#">
UPDATE #target_arcust# set custno=ucase(custno),name=ucase(name),name2=ucase(name2),add1=ucase(add1),add2=ucase(add2),add3=ucase(add3),add4=ucase(add4),attn=ucase(attn),daddr1=ucase(daddr1),daddr2=ucase(daddr2),daddr3=ucase(daddr3),daddr4=ucase(daddr4),dattn=ucase(dattn),contact=ucase(contact),arrem1=ucase(arrem1),arrem2=ucase(arrem2),arrem3=ucase(arrem3),arrem4=ucase(arrem4) where custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custno#">
</cfquery>
</cfif>
<script>
	done.submit();
</script>