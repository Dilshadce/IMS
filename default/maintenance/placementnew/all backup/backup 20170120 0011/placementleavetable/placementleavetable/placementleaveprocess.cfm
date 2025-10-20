<cfif form.claimdate neq ''>
<cfset ndate = createdate(right(form.claimdate,4),mid(form.claimdate,4,2),left(form.claimdate,2))>
<cfset claimdate = dateformat(ndate,'yyyy-mm-dd')>
<cfelse>
<cfset claimdate = '0000-00-00'>
</cfif>


<cfif form.mode eq "Create">
	    <cfquery datasource="#dts#" name="insertartran">
    	Insert into placementleave(
        						placementno,
                                leavetype,
                                claimdate,
                                days,
                                created_by,
                                created_on
                                )
                                
        value(
        		<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.placementno#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.leavetype#">,
                <cfif form.claimdate eq ''>'0000-00-00'<cfelse>'#claimdate#'</cfif>,
                <cfqueryparam cfsqltype="cf_sql_decimal" value="#form.days#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#getAuthUser()#">,
                <cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#">
                )
                
    	</cfquery>
        <cfquery datasource="#dts#" name="trackplacementleave">
        Insert into placementleavetrack(
        									placementno,
                                            leavetype,
                                            claimdate,
                                            days,
                                            created_by,
                                            created_on,
                                            trackmode
                                            
                                            )
        value(
        		<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.placementno#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.leavetype#">,
                <cfif form.claimdate eq ''>0000-00-00<cfelse>'#claimdate#'</cfif>,
                <cfqueryparam cfsqltype="cf_sql_decimal" value="#form.days#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#getAuthUser()#">,
                <cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.mode#">
              
                )
        </cfquery>
    
    <cfset status="The Placement, #form.placementno# had been successfully created. ">
    
    <cfelseif form.mode eq "Edit">
    	<cfquery datasource="#dts#" name="updatePlacement">
        Update placementleave
        set
        leavetype=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.leavetype#">,
        claimdate=<cfif claimdate eq ''>0000-00-00<cfelse>'#claimdate#'</cfif>,
        days=<cfqueryparam cfsqltype="cf_sql_decimal" value="#form.days#">
        WHERE id = '#form.id#'
        </cfquery>
        <cfquery datasource="#dts#" name="trackplacementleave">
        Insert into placementleavetrack(
        									placementno,
                                            leavetype,
                                            claimdate,
                                            days,
                                            created_by,
                                            created_on,
                                            trackmode
                                            
                                            )
        value(
        		<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.placementno#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.leavetype#">,
                <cfif form.claimdate eq ''>0000-00-00<cfelse>'#claimdate#'</cfif>,
                <cfqueryparam cfsqltype="cf_sql_decimal" value="#form.days#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#getAuthUser()#">,
                <cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.mode#">
              
                )
        </cfquery>
        
    	<cfset status="The Placement, #form.placementno# had been successfully created. ">
 
    
    <cfelseif form.mode eq "Delete">
    	<cfquery datasource="#dts#" name="deleteitem">
        Delete from placementleave where id="#form.id#"
        </cfquery>
        <cfquery datasource="#dts#" name="trackplacementleave">
        Insert into placementleavetrack(
        									placementno,
                                            leavetype,
                                            claimdate,
                                            days,
                                            created_by,
                                            created_on,
                                            trackmode
                                            
                                            )
        value(
        		<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.placementno#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.leavetype#">,
                <cfif form.claimdate eq ''>0000-00-00<cfelse>'#claimdate#'</cfif>,
                <cfqueryparam cfsqltype="cf_sql_decimal" value="#form.days#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#getAuthUser()#">,
                <cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.mode#">
              
                )
        </cfquery>
        
        <cfset status="The Placement, #form.placementno# had been successfully deleted. ">
        
  
</cfif>

<cfoutput>

<form name="done" action="s_placementleave.cfm?type=Placement&process=done" method="post">
  <input name="status" value="#status#" type="hidden">
</form>
</cfoutput>
<script>
	done.submit();
</script>

