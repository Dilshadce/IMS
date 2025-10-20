<cfif type eq "add">
	<!-- add data into table1 -->
	<cfif form.comid neq "">
		<cfquery name="insert" datasource="net_crm">
			INSERT INTO company 
			(comid, custid, comname, attn, contactNo, supportStaff, programmer, status)
			values
        	('#lcase(form.comid)#','#form.custid#','#form.comname#','#form.attn#','#form.contactNo#','#form.supportStaff#','#form.programmer#','#form.status#')
		</cfquery>
	</cfif>
<cflocation url="company.cfm">

<cfelseif type eq "edit">
	<!-- update table1 data -->
	<cfquery name="update" datasource="net_crm">
		UPDATE company
		SET custid='#form.custid#', 
		comname='#form.comname#', 
		attn='#form.attn#',
        contactNo = '#form.contactNo#',
        supportStaff = '#form.supportStaff#',
        programmer = '#form.programmer#',
        status = '#form.status#'
		WHERE comid='#form.comid#'
	</cfquery>
	
	<!---<script type="text/javascript">
		window.close();
		parent.opener.location.reload();
	</script> --->
<cflocation url="company.cfm">

<cfelse>
	<!-- delete data from table1 -->
	
	<cfquery name="check" datasource="net_crm">
		select * from customized_function
		where comid = '#comid#'
		limit 1
	</cfquery>
	
	<cfif check.recordcount eq 0>
		<cfquery name="delete" datasource="net_crm">
			DELETE 
			FROM company 
			WHERE comid='#comid#'
		</cfquery>
	</cfif>
	
	<cflocation url="company.cfm">

</cfif>
