<cfquery name = "check_update_unit_cost" datasource = "#dts#">
	select 
	update_unit_cost 
	from gsetup2;
</cfquery>

<cfif check_update_unit_cost.update_unit_cost eq "T">
	<cftry>
		<cfquery name = "updateIcitem" datasource = "#dts#">
			update icitem 
			set ucost=<cfqueryparam cfsqltype="cf_sql_double" value="#newprice#">
			where itemno=<cfqueryparam cfsqltype="cf_sql_char" value="#getbody.itemno#">;
		</cfquery>
		
		<cfif getbody.custno neq "">
			<cfquery name = "update_icl3p2" datasource = "#dts#">
				insert into icl3p2 
				(
					itemno,
					custno,
					price,
					dispec,
					dispec2,
					dispec3
				)
				values 
				(
					<cfqueryparam cfsqltype="cf_sql_char" value="#getbody.itemno#">,
					<cfqueryparam cfsqltype="cf_sql_char" value="#getbody.custno#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#newprice#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#getbody.dispec1#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#getbody.dispec2#">,
					<cfqueryparam cfsqltype="cf_sql_double" value="#getbody.dispec3#">
				) 
				on duplicate key update 
				price=<cfqueryparam cfsqltype="cf_sql_double" value="#newprice#">,
				dispec=<cfqueryparam cfsqltype="cf_sql_double" value="#getbody.dispec1#">,
				dispec2=<cfqueryparam cfsqltype="cf_sql_double" value="#getbody.dispec2#">,
				dispec3=<cfqueryparam cfsqltype="cf_sql_double" value="#getbody.dispec3#">;
			</cfquery>
		</cfif>
		
		<cfcatch type="any">
			<cfdump var="#cfcatch#">
		</cfcatch>
	</cftry>
</cfif>