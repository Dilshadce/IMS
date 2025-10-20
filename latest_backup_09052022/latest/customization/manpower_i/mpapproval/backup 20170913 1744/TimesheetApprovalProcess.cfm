<cfset inform="">
<cfoutput>


<cfif isdefined("url.type") and isdefined("url.id")>
	<cfif url.type eq "app">

        <cfquery name="approve_leave" datasource="#replace(dts,'_i','_p')#">
        UPDATE timesheet SET
        validated_on = now(),
        status = <cfqueryparam cfsqltype="cf_sql_varchar" value="Validated">
        WHERE tmonth = '#url.id#' AND placementno = '#url.pno#'
        </cfquery>
	<cfelseif url.type eq "dec">
    
     <cfquery name="approve_leave" datasource="#replace(dts,'_i','_p')#">
        UPDATE timesheet SET
        canceled_on = now(),
        canceled_by = "#getauthuser()#",
        status = <cfqueryparam cfsqltype="cf_sql_varchar" value="Rejected">
        ,mpremarks = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.remarks#">
        ,editable = ''
        WHERE tmonth = '#url.id#' AND placementno = '#url.pno#'
        </cfquery>
    
	</cfif>
</cfif>
</cfoutput>

<cfoutput>
<script type="text/javascript">	
alert('Cancel Success!');
window.location.href="timesheetapprovalmainT.cfm";
</script>
</cfoutput>

