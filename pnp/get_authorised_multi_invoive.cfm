<cfoutput>
	<cfif tran eq "INV">
		<cfquery name="get_invoice_set" datasource="#dts#">
			select 
			invoice_set
			from user_id_location 
			where userid='#jsstringformat(preservesinglequotes(HUserID))#';
		</cfquery>
		
		<cfif get_invoice_set.recordcount neq 0>
			<cfif get_invoice_set.invoice_set eq 0>
				<a href="transaction0.cfm?tran=#tran#">Create New #tranname#</a> || 
			<cfelse>
				<a href="transaction1.cfm?ttype=create&tran=#tran#&nexttranno=&first=0">Create New #tranname#</a> || 
			</cfif>
		<cfelse>
			<a href="transaction0.cfm?tran=#tran#">Create New #tranname#</a> || 
		</cfif>
	<cfelse>
		<a href="transaction1.cfm?ttype=create&tran=#tran#&nexttranno=&first=0">Create New #tranname#</a> || 
	</cfif>
</cfoutput>