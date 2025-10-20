
<cfquery name="getinfo" datasource="#dts#">
	select #pincode#  as code 
	from userpin2 
	where level = '#groupid#'
</cfquery>

<cfif getinfo.recordcount neq 0>
	<cfif getinfo.code eq "T">
		<cfset nextcode = "F">
	<cfelse>
		<cfset nextcode = "T">
	</cfif>
	<cfquery name="update" datasource="#dts#">
		update userpin2 set #pincode# = '#nextcode#'
		where level = '#groupid#'
	</cfquery>
    
    <cfif pincode eq "H10103_3E">
    <cfquery name="update" datasource="#dts#">
		update userpin2 set h1360 = '#nextcode#'
		where level = '#groupid#'
	</cfquery>
    
    </cfif>
    
    <cfif pincode eq "H10103_3F">
    <cfquery name="update" datasource="#dts#">
		update userpin2 set h1361 = '#nextcode#'
		where level = '#groupid#'
	</cfquery>
    
    </cfif>
    
    
</cfif>