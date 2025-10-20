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
    Update refnoset SET lastUsedNo = "#lastusedno#" WHERE type = "SUPP"
    </cfquery>
	</cfif>
    
    <cfquery name="updateremark4" datasource="#dts#">
 UPDATE #target_apvend#
 SET
 SALEC  = '#form.SALEC#',
 SALECNC  = '#form.SALECNC#',
 taxcode= <cfif isdefined('form.taxcode')><cfqueryparam cfsqltype="cf_sql_varchar" value="#form.taxcode#"><cfelse>''</cfif>
 WHERE
 custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custno#">
</cfquery>
    	
<cfif getgsetup.capall eq 'Y'>
<cfquery name="updateallitemtocap" datasource="#dts#">
UPDATE #target_apvend# set custno=ucase(custno),name=ucase(name),name2=ucase(name2),add1=ucase(add1),add2=ucase(add2),add3=ucase(add3),add4=ucase(add4),attn=ucase(attn),daddr1=ucase(daddr1),daddr2=ucase(daddr2),daddr3=ucase(daddr3),daddr4=ucase(daddr4),dattn=ucase(dattn),contact=ucase(contact),arrem1=ucase(arrem1),arrem2=ucase(arrem2),arrem3=ucase(arrem3),arrem4=ucase(arrem4) where custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custno#">
</cfquery>
</cfif>
	<form name="done" action="vPersonnel.cfm?type=Supplier&process=done" method="post">
		<input name="status" value="#status1#" type="hidden">
	</form>
</cfoutput>

<script>
	done.submit();
</script>