<cfif type eq "add">
	<!-- add data into table1 -->
	<cfif form.custname neq "">
		<cfquery name="getadd" datasource="net_crm">
			INSERT INTO customer 
			(custno,custname, desp, comment)
			values
      	  ('#form.custno#', '#form.custname#', '#form.desp#', '#form.comment#')
		</cfquery>
	</cfif>
<cflocation url="customer.cfm">

<cfelseif type eq "edit">
	<!-- update table1 data -->
	<cfquery name="getupdate" datasource="net_crm">
		UPDATE customer
		SET custno='#form.custno#',
		custname='#form.custname#', 
		desp='#form.desp#', 
		comment='#form.comment#'
		WHERE custid='#form.custid#'
	</cfquery>
	
	<!---<script type="text/javascript">
		window.close();
		parent.opener.location.reload();
	</script> --->
<cflocation url="customer.cfm">

<cfelse>
	<!-- delete data from table1 -->
	<cfquery name="check" datasource="net_crm">
		select * from company
		where custid = '#custid#'
		limit 1
	</cfquery>
	
	<cfif check.recordcount eq 0>
		<cfquery name="delete" datasource="net_crm">
			DELETE 
			FROM customer 
			WHERE custid='#custid#'
		</cfquery>
	</cfif>
	
	<cflocation url="customer.cfm">

</cfif>
