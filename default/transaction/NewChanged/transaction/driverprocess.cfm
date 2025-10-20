<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<cfparam name="status" default="">

<cfquery name="getGsetup" datasource="#dts#">
  Select * from GSetup
</cfquery>

<cfif form.mode eq "Create">
	<cfquery datasource='#dts#' name="checkdriverExist">
 		Select * from driver where driverno='#form.driverno#' 
 	</cfquery>
	 
  	<cfif checkdriverExist.recordcount GT 0 >
    	<cfoutput><h3><font color="##FF0000">Error, This #getGsetup.lDRIVER# has been created already.</font></h3></cfoutput>
		<cfabort>
	</cfif>
	<cfif lcase(hcomid) eq "ovas_i">
    	<cfinsert datasource='#dts#' tablename="driver" formfields="driverno,name,name2,attn,customerno,add1,add2,add3,dept,contact,phone,phonea,fax">
	<cfelse>
    	<cfinsert datasource='#dts#' tablename="driver" formfields="driverno,name,name2,attn,customerno,add1,add2,add3,dept,contact,fax">
	</cfif>
	
	<cfset status="The End User, #form.driverno# had been successfully created. ">
<cfelse>
	<cfquery datasource='#dts#' name="checkitemExist">
		Select * from driver where driverno ='#form.driverno#'
	</cfquery>
		
	<cfif checkitemExist.recordcount GT 0 >
		<cfif form.mode eq "Delete">
			<cfquery datasource='#dts#' name="deleteitem">
				Delete from driver where driverno='#form.driverno#'
			</cfquery>
			<cfset status="The End User, #form.driverno# had been successfully deleted. ">
		</cfif>
				
		<cfif form.mode eq "Edit">
        	<cfif lcase(hcomid) eq "ovas_i">
            	<cfquery name="update" datasource="#dts#">
                	update driver
                    set name=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.name#">,
                    name2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.name2#">,
                    attn=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.attn#">,
                    customerno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.customerno#">,
                    add1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.add1#">,
                    add2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.add2#">,
                    add3=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.add3#">,
                    dept=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dept#">,
                    contact=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.contact#">,
                    phone=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.phone#">,
                    phonea=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.phonea#">,
                    fax=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fax#">
                    where driverno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.driverno#">
                </cfquery>
            <cfelse>
				<cfupdate datasource='#dts#' tablename="driver" formfields="driverno,name,name2,attn,customerno,add1,add2,add3,dept,contact,fax">
            </cfif>
			
			<cfset status="The End User, #form.Driverno# had been successfully edited. ">
		</cfif>
	<cfelse>		
		<cfset status="Sorry, the End User, #form.Driverno# was ALREADY removed from the system. Process unsuccessful.">
	</cfif>
</cfif>
<script type="text/javascript">
<!---
	<cfif getGsetup.filterall eq "1">
		<cfoutput>
			opener.document.getElementById("searchdriver").value="#form.DriverNo# - #form.name#";
			opener.document.getElementById("driver").value="#form.DriverNo#";
		</cfoutput>
	<cfelse>--->
		<cfoutput>window.opener.updateDriver('#form.DriverNo#','#form.name#');</cfoutput>
	<!---</cfif>--->
	self.close();	
</script>