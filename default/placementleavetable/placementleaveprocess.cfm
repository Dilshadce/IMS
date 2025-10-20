<cfif form.mode eq "Create">
	    <cfquery datasource="#dts#" name="insertartran">
    	Insert into placementleave(
        						placementno,
                                created_by,
                                created_on
                                )
                                
        value(
        		<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.placementno#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#getAuthUser()#">,
                <cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#">
                )  
    	</cfquery>
        
          <cfquery name="getlastid" datasource="#dts#">
            SELECT LAST_INSERT_ID() as lastid
          </cfquery>
		
        <cfquery name="insertleavelist" datasource="#dts#">
         INSERT INTO leavelist
                    (
                    placementno,
                    leavetype,
                    days,
                    claimamount,
                    remarks,
                    startdate,
                    startampm,
                    enddate,
                    endampm,
                    leavebalance,
                    contractenddate,
                    claimed,
                    submitted,
                    submited_on,
                    submit_date,
                    claimremark,
                    placementleaveid
                    )
                    SELECT 
                    placementno,
                    leavetype,
                    days,
                    claimamount,
                    remarks,
                    startdate,
                    startampm,
                    enddate,
                    endampm,
                    leavebalance,
                    contractenddate,
                    claimed,
                    submitted,
                    submited_on,
                    submit_date,
                    claimremark,
                    "#getlastid.lastid#"
                    FROM leavelisttemp 
                    WHERE 
                    uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.newuuid#">
        </cfquery>
    
    <cfset status="The Placement, #form.placementno# had been successfully created. ">
    
    <cfelseif form.mode eq "Edit">
    	<cfquery datasource="#dts#" name="updatePlacement">
        Update placementleave
        set
		Updated_on = now(),
        updated_by = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getauthuser()#">
        WHERE id = '#form.id#'
        </cfquery>
        
        <cfquery name="deleteold" datasource="#dts#">
        DELETE FROM leavelist WHERE placementleaveid = '#form.id#'
        </cfquery>
        
         <cfquery name="insertleavelist" datasource="#dts#">
         INSERT INTO leavelist
                    (
                    placementno,
                    leavetype,
                    days,
                    claimamount,
                    remarks,
                    startdate,
                    startampm,
                    enddate,
                    endampm,
                    leavebalance,
                    contractenddate,
                    claimed,
                    submitted,
                    submited_on,
                    submit_date,
                    claimremark,
                    placementleaveid
                    )
                    SELECT 
                    placementno,
                    leavetype,
                    days,
                    claimamount,
                    remarks,
                    startdate,
                    startampm,
                    enddate,
                    endampm,
                    leavebalance,
                    contractenddate,
                    claimed,
                    submitted,
                    submited_on,
                    submit_date,
                    claimremark,
                    "#form.id#"
                    FROM leavelisttemp 
                    WHERE 
                    uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.newuuid#">
        </cfquery>
        
    	<cfset status="The Placement, #form.placementno# had been successfully created. ">
 
    
    <cfelseif form.mode eq "Delete">
    	<cfquery datasource="#dts#" name="deleteitem">
        Delete from placementleave where id="#form.id#"
        </cfquery>
        
        <cfquery name="deleteleave" datasource="#dts#">
        DELETE FROM leavelist WHERE placementleaveid = '#form.id#'
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

