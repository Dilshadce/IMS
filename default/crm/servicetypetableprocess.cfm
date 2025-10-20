<cfparam name="status" default="">

<cfif form.mode eq "Create">
	<cfquery datasource='#dts#' name="checkitemExist">
	 	 Select * from service_type 
	 	 where servicetypeid = '#form.servicetypeid#'
 	</cfquery>
  	
	<cfif checkitemExist.recordcount gt 0 >
		<cfoutput>
      		<h3><font color="##FF0000">Error, This record ("#form.servicetypeid#") Already Exist.</font></h3>
			<script language="javascript" type="text/javascript">
				alert("Error, This record #form.servicetypeid# Already Exist.");
				javascript:history.back();
				javascript:history.back();
			</script>
	    </cfoutput> 
    	<cfabort>
	</cfif>
	
	<cfquery name="insert" datasource="#dts#">
		insert into service_type
		(servicetypeid,desp,servi)
		values
		('#form.servicetypeid#','#form.desp#','#form.servi#')
	</cfquery>
	
	<cfset status="The #form.servicetypeid# had been successfully created. ">

<cfelse>
	<cfquery datasource='#dts#' name="checkitemExist">
	 	 Select * from service_type 
	 	 where servicetypeid = '#form.servicetypeid#'
 	</cfquery>
		
	<cfif checkitemExist.recordcount GT 0>
		<cfif form.mode eq "Delete">
			<cfquery datasource='#dts#' name="deleteitem">
				Delete from service_type
				where servicetypeid = '#form.servicetypeid#'
			</cfquery>
				
			<cfset status="The #form.servicetypeid# had been successfully deleted. ">	
		</cfif>
			
		<cfif form.mode eq "Edit">
			<cfquery name="update" datasource="#dts#">
				update service_type
				set desp = '#form.desp#',
				servi='#form.servi#'
				where servicetypeid = '#form.servicetypeid#' 
			</cfquery>
			
			<cfset status="The #form.servicetypeid# had been successfully edited. ">
		</cfif>
				
	<cfelse>		
		<cfset status="Sorry, the #form.servicetypeid# was ALREADY removed from the system. Process unsuccessful.">
	</cfif>
</cfif>

<cfoutput>
	<form name="done" action="s_servicetype.cfm?process=done" method="post">
		<input name="status" value="#status#" type="hidden">
	</form>
</cfoutput>

<script>
	done.submit();
</script>