<cfset inform="">
<cfoutput>

<cfif isdefined("url.type") and isdefined("url.id")>
	<cfif url.type eq "app">

        <cfquery name="approve_leave" datasource="#replace(dts,'_i','_p')#">
        UPDATE timesheet SET
        validated_on = now(),
        status = <cfqueryparam cfsqltype="cf_sql_varchar" value="PROCESSED">
        WHERE tmonth = '#url.id#' AND placementno = '#url.pno#'
        AND pdate BETWEEN "#DateFormat(url.startdate, 'yyyy-mm-dd')#"
        AND "#DateFormat(url.enddate, 'yyyy-mm-dd')#"
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
        AND pdate BETWEEN "#DateFormat(url.startdate, 'yyyy-mm-dd')#"
        AND "#DateFormat(url.enddate, 'yyyy-mm-dd')#"
        </cfquery>
    
	</cfif>
</cfif>
</cfoutput>

<cfoutput>
<script type="text/javascript">	
alert('Cancel Success!');
window.location.href="ProcessTimesheetMain.cfm";
</script>
</cfoutput>

