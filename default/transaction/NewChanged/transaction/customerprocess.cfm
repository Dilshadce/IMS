<cfoutput>
	<cfinvoke component="cfc.create_update_delete_customer_supplier" method="amend_customer_supplier" returnvariable="status1">
		<cfinvokeargument name="dts" value="#dts#">
		<cfinvokeargument name="dts1" value="#dts#">
		<cfinvokeargument name="hlinkams" value="#hlinkams#">
		<cfinvokeargument name="huserid" value="#huserid#">
		<cfinvokeargument name="form" value="#form#">
	</cfinvoke>
</cfoutput>

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

<script type="text/javascript">
	<cfoutput>window.opener.getCustSupp2('#form.custno#','#URLEncodedFormat(form.name)#');</cfoutput>
	self.close();	
</script>