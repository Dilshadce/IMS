<cfif (HUserGrpID eq "SUPER" and left(huserid,5) eq "ultra")>
	<cfparam name="status" default="">
    <cfset currentdatetime = '#lsdateformat(now(), "YYYY-MM-DD")# #timeformat(now(), "HH:MM:SS")#'>
    
    <cfquery datasource='main' name="checkUserExist">
		SELECT * from multicomusers 
        WHERE userId='#form.userId#'
	</cfquery>
    
    <cfif checkUserExist.recordcount GT 0>
		<cfif #form.sub_btn# eq "Create">
                <h2>This User ID has been used. Please kindly create another one. Thanks.</h2>
                <cfabort> 
		<cfelseif #form.sub_btn# eq "Delete">
            <cfquery datasource="main" name="insert">
                delete from multicomusers
                WHERE userid="#form.userId#" 
            </cfquery>
			<cfset status="The user, #form.userid# had been successfully deleted. ">                
		<cfelseif #form.sub_btn# eq "Edit">
        	 <cfquery datasource="main" name="insert">
                UPDATE multicomusers
                SET comlist='#form.multicom#'
                WHERE userid="#form.userId#"
            </cfquery> 
            <cfset status="The user, #form.userid# had been successfully edited. ">          
		</cfif>                   
    <cfelse>
    	<cfif #form.sub_btn# eq "Create">
        	<cfquery datasource='main' name="addmulticom">
                INSERT INTO multicomusers (userID,comlist)
                VALUES ("#form.userid#","#form.multicom#")
			</cfquery>
            <cfset status="The user, #form.userid# had been successfully created. ">
        </cfif>
    </cfif>

    <cfoutput>
<script type="text/javascript">
alert('Record #form.sub_btn# Success!');
window.location.href='/super_menu/multicom.cfm';
</script>
</cfoutput>
    
</cfif>