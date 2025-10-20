<cfsetting showdebugoutput="false"><cfsilent>
<cfset value = "">
<cfset tabchr = Chr(13) & Chr(10)> 
<cfset text = URLDECODE(url.text)>
<cfif text neq "">

<cfquery name="getvehicle" datasource="#dts#">
		select entryno
		from vehicles
		where 0=0
		<cfif text neq "">
				and upper(entryno) like '%#ucase(text)#%'
		</cfif>
		order by entryno
	</cfquery>

	<cfif getvehicle.recordcount neq 0>
		<cfset vehiclelist = valuelist(getvehicle.entryno,";;")>
		<cfset vehicledesclist = valuelist(getvehicle.entryno,";;")>
	<cfelse>
		<cfset vehiclelist = "">
		<cfset vehicledesclist = "No Record Found">
	</cfif>
<cfelse>
	<cfset vehiclelist = "">
	<cfset vehicledesclist = "Please Filter The Vehicle No">
</cfif>

<cfset header = "count|error|msg|vehiclelist|vehicledesclist">
<cfset value = "1|0|0|#URLEncodedFormat(vehiclelist)#|#URLEncodedFormat(vehicledesclist)##tabchr#">	
</cfsilent><cfif isdefined('url.new') eq false><cfoutput>#header##tabchr##value#</cfoutput><cfelse><cfsetting showdebugoutput="no"><cfoutput>
<select id="rem5" name='rem5'>
<cfif vehiclelist eq "">
<option value="">#vehiclelist#</option>
<cfelse>
<cfloop query="getvehicle">
<option value="#getvehicle.entryno#">#getvehicle.entryno#</option>
</cfloop>
</cfif>
</select>
</cfoutput></cfif>