<cfif type eq "add">
	<!-- add data into table1 -->
	<cfif form.function neq "">
		<cfquery name="insert" datasource="net_crm">
			INSERT INTO customized_function 
			(comid, function, desp)
			values
        	('#form.comid#', '#form.function#', '#form.desp#')
		</cfquery>
	</cfif>
<cflocation url="customized_function.cfm?comid=#form.comid#">

<cfelseif type eq "edit">
	<!-- update table1 data -->
	<cfquery name="update" datasource="net_crm">
		UPDATE customized_function 
		SET function='#form.function#', 
		desp='#form.desp#'
		WHERE cfid='#form.cfid#'
	</cfquery>
	
	<!---<script type="text/javascript">
		window.close();
		parent.opener.location.reload();
	</script> --->
<cflocation url="customized_function.cfm?comid=#form.comid#">

<cfelse>
	<!-- delete data from table1 -->
	<cfquery name="delete" datasource="net_crm">
		DELETE FROM customized_function  
		WHERE cfid='#cfid#'
	</cfquery>
	
	<cflocation url="customized_function.cfm?comid=#comid#">

</cfif>
