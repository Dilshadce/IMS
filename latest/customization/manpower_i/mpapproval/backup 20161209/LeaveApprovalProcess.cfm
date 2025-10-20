<cfset dts2 = replace(dts,'_p','_i')>
<cfoutput>
<cfif isdefined('form.leaveid') eq false>
    <script type="text/javascript">
    alert('Please Kindly Select At Least One Leave');
    </script>
    <cfabort>
</cfif>

<cfquery name="getdate" datasource="#dts_main#">
    SELECT * FROM gsetup WHERE comp_id = "#HcomID#"
</cfquery>
    
<cfloop list="#form.leaveid#" index="a">
    <cfset url.remarks = "">
    <cfset url.leaveid = a>
    
    <cfset finalapprove = 0>
    <cfset status = "">
    
    <cfquery name="checkcancellve" datasource="#dts2#">
        SELECT id FROM leavelist WHERE id = '#url.leaveid#'
    </cfquery>
    
    <cfif checkcancellve.recordcount neq 0>
            <cfquery name="approve_leave" datasource="#dts2#">
            UPDATE leavelist SET STATUS = "APPROVED",updated_by = "#HUserName#", mgmtremarks = "#url.remarks#", updated_on = now() WHERE id = #url.leaveid#
            </cfquery>
            <cfset finalapprove = 1>
    </cfif>
   
    <cfif finalapprove eq 1>
   
        <cfset mon = #numberformat(getdate.mmonth,'00')# >
        <cfset yrs = getdate.myear>
        
        <cfquery name="getempno" datasource="#dts2#">
        SELECT empno,leavetype FROM leavelist a 
        LEFT JOIN placement b on a.placementno = b.placementno
        WHERE id = "#url.leaveid#"
        </cfquery>
        
        <cfif getempno.recordcount eq 0>
        <cfoutput>
        <script type="text/javascript">
        alert('Employee Record Not Found!');
        history.go(-1);
        </script>
        </cfoutput>
        <cfabort>
        </cfif>
     </cfif>   
	
</cfloop>
    
<!---<script type="text/javascript">
alert('Approve Success!');
window.location.href = 'LeaveApprovalMain.cfm';
</script>--->

</cfoutput>