<cfsetting showdebugoutput="no">

<cfif trim(url.firm) neq "">
<cfquery name="getdriver" datasource="#dts#">
	select * from firmbody where firm=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(url.firm)#">
</cfquery>
<cfelse>
<cfquery name="getdriver" datasource="#dts#">
	select * from driver
</cfquery>

</cfif>
<cfquery name="getgsetup" datasource="#dts#">
	select lDRIVER from gsetup
</cfquery>

<cfoutput>
				<select name="driver" id="driver">
					<option value="">Choose a #getGsetup.lDRIVER#</option>
          		<cfloop query="getdriver">
            		<option value="#getdriver.driverno#">#getdriver.driverno#</option>
          		</cfloop>
				</select>		
</cfoutput>