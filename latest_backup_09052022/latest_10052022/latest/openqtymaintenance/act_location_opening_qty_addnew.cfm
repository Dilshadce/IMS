<cfquery name="checkexist" datasource="#dts#">
	select * from locqdbf
	where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.items#">
	and location = <cfqueryparam cfsqltype="cf_sql_char" value="#form.location#">
</cfquery>

<cfif checkexist.recordcount eq 0>
	<cfquery name="getdesp" datasource="#dts#">
    SELECT desp FROM iclocation where location = <cfqueryparam cfsqltype="cf_sql_char" value="#form.location#">
    </cfquery>
	<cfquery name="insert_location_item_record" datasource="#dts#">
		insert into locqdbf 
		(
			location,itemno,locqfield,
			locqactual,locqtran,lminimum,lreorder,
			qty_bal,val_bal,price,
			wos_group,category,shelf,supp,desp
		)
		values
		(
			<cfqueryparam cfsqltype="cf_sql_char" value="#form.location#">,
			<cfqueryparam cfsqltype="cf_sql_char" value="#form.items#">,
			'#val(form.qtybf)#',
			<cfqueryparam cfsqltype="cf_sql_char" value="0">,
			<cfqueryparam cfsqltype="cf_sql_char" value="0">,
			'#val(form.minimum)#','#val(form.reorder)#',
			<cfqueryparam cfsqltype="cf_sql_char" value="0">,
			<cfqueryparam cfsqltype="cf_sql_char" value="0">,
			<cfqueryparam cfsqltype="cf_sql_char" value="0">,
			<cfqueryparam cfsqltype="cf_sql_char" value="">,
			<cfqueryparam cfsqltype="cf_sql_char" value="">,
			<cfqueryparam cfsqltype="cf_sql_char" value="">,
			<cfqueryparam cfsqltype="cf_sql_char" value="">,
            <cfqueryparam cfsqltype="cf_sql_char" value="#getdesp.desp#">
				
		)
	</cfquery>
	<script>
		alert("New Record Added Successfully !");
		window.close();
		if (window.opener && !window.opener.closed) {
			window.opener.location.reload();
		} 
	</script>
<cfelse>
	<script>
		//window.moveTo(0,0);
		//window.resizeTo(0,0);
		alert("The Location - Item Exist !");
		window.close();
	</script>
</cfif>