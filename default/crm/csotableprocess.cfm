<cfparam name="status" default="">

<cfif form.mode eq "Create">
	<cfquery datasource='#dts#' name="checkExist">
	 	 Select * from cso 
	 	 where csoid = '#form.csoid#'
 	</cfquery>
  	
	<cfif checkExist.recordcount gt 0 >
		<cfoutput>
      		<h3><font color="##FF0000">Error, This record ("#form.csoid#") Already Exist.</font></h3>
			<script language="javascript" type="text/javascript">
				alert("Error, This record #form.csoid# Already Exist.");
				javascript:history.back();
				javascript:history.back();
			</script>
	    </cfoutput> 
    	<cfabort>
	</cfif>
	
	<cfquery name="insert" datasource="#dts#">
		insert into cso
		(csoid,desp)
		values
		('#form.csoid#','#form.desp#')
	</cfquery>
	
	<cfset status="The #form.csoid# had been successfully created. ">

<cfelse>
	<cfquery datasource='#dts#' name="checkExist">
	 	 Select * from cso 
	 	 where csoid = '#form.csoid#'
 	</cfquery>
		
	<cfif checkExist.recordcount GT 0>
		<cfif form.mode eq "Delete">
			<cfquery datasource='#dts#' name="deletecso">
				Delete from cso
				where csoid = '#form.csoid#'
			</cfquery>
				
			<cfset status="The #form.csoid# had been successfully deleted. ">	
		</cfif>
			
		<cfif form.mode eq "Edit">
			<cfquery name="update" datasource="#dts#">
				update cso
				set desp = '#form.desp#'
				where csoid = '#form.csoid#' 
			</cfquery>
			
			<cfset status="The #form.csoid# had been successfully edited. ">
		</cfif>
				
	<cfelse>		
		<cfset status="Sorry, the #form.csoid# was ALREADY removed from the system. Process unsuccessful.">
	</cfif>
</cfif>

<cfoutput>
	<form name="done" action="s_cso.cfm?process=done" method="post">
		<input name="status" value="#status#" type="hidden">
	</form>
</cfoutput>

<script>
	done.submit();
</script>