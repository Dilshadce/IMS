<cfif tran eq "INV">
	<cfquery name="get_default_invoice_custno" datasource="#dts#">
		select 
		inv_custno
		from pnp_special_setting 
		where company_id='IMS';
	</cfquery>
	
	<cfset T_CustNo = get_default_invoice_custno.inv_custno>
</cfif>