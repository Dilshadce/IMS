<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<cfparam name="status" default="">
<!--- ADD ON 15-07-2009 --->
<cfquery name="getGsetup" datasource="#dts#">
  Select lDRIVER from GSetup
</cfquery>

<cfif form.mode eq "Create">
	<cfquery datasource='#dts#' name="checkdriverExist">
 		Select * from drivercommission where driverno='#form.driverno#' and category='#form.category#' 
 	</cfquery>
	 
  	<cfif checkdriverExist.recordcount GT 0 >
    	<h3><font color="#FF0000">Error, This <cfoutput>#getGsetup.lDRIVER# Comission</cfoutput> has been created already.</font></h3>
		<cfabort>
	</cfif>
	
    	<cfinsert datasource='#dts#' tablename="drivercommission" formfields="driverno,category,commission">
	
	<cfset status="The #getGsetup.lDRIVER#, #form.driverno# #form.category# commission had been successfully created. ">

<cfelse>
	<cfquery datasource='#dts#' name="checkitemExist">
		Select * from drivercommission where driverno ='#form.driverno#' and category='#form.category#' 
	</cfquery>
		
	<cfif checkitemExist.recordcount GT 0 >
		<cfif form.mode eq "Delete">
			<cfquery datasource='#dts#' name="deleteitem">
				Delete from drivercommission where driverno='#form.driverno#' and category='#form.category#' 
			</cfquery>
			<cfset status="The #getGsetup.lDRIVER#, #form.driverno# #form.category# commission had been successfully deleted. ">						
		</cfif>
				
		<cfif form.mode eq "Edit">
        	<!--- <cfif lcase(hcomid) eq "ovas_i"> --->
            	<cfquery name="update" datasource="#dts#">
                	update drivercommission
                    set commission=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.commission#">
                    where driverno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.driverno#">
                    and category='#form.category#' 
                </cfquery>
            <!--- <cfelse>
				<cfupdate datasource='#dts#' tablename="driver" formfields="driverno,name,name2,attn,customerno,add1,add2,add3,dept,contact,fax">
            </cfif> --->
			<cfset status="The #getGsetup.lDRIVER#, #form.Driverno# #form.category# commission had been successfully edited. ">
		</cfif>
	<cfelse>		
		<cfset status="Sorry, the #getGsetup.lDRIVER#, #form.Driverno# #form.category# commission was ALREADY removed from the system. Process unsuccessful.">
	</cfif>
</cfif>
<!---Get the messaged to be passed into the view user page. (vUser.cfm) --->

<cfoutput>
	<form name="done" action="sDrivercommission.cfm?process=done&driverno=#form.driverno#" method="post">
		<input name="status" value="#status#" type="hidden">
	</form>
</cfoutput>
<script>
	done.submit();
</script>