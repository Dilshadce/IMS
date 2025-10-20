<cfquery datasource="#dts#" name="getgeneral">
	Select lJOB as layer from gsetup
</cfquery>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<cfparam name="status" default="">

<cfif form.mode eq "Create">
	<cfquery datasource='#dts#' name="checkitemExist">
		Select * from identifier where identifierno = '#form.identifierno#' 
	</cfquery>
  
	<cfif checkitemExist.recordcount GT 0 >
		<cfoutput>
	      <h3><font color="##FF0000">Error, This Identifier ("#form.identifierno#") has been created already.</font></h3>
		</cfoutput> 
	    <cfabort>
	</cfif>
	<cfquery datasource="#dts#" name="insertartran">
			Insert into identifier 
			(identifierno,desp)
			values 
			('#form.identifierno#', <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#">)
		</cfquery>
	
  	<cfset status="The Identifier, #form.identifierno# had been successfully created. ">
<cfelse>
  	<cfquery datasource='#dts#' name="checkitemExist">
		Select * from identifier where identifierno='#form.identifierno#'
  	</cfquery>
		
  	<cfif checkitemExist.recordcount GT 0 >
		<cfif form.mode eq "Delete">
      		<cfquery datasource='#dts#' name="deleteitem">
	    		Delete from identifier where identifierno='#form.identifierno#'
	  		</cfquery>
	  		<cfset status="The Identifier, #form.identifierno# had been successfully deleted. ">	
		</cfif>
		<cfif form.mode eq "Edit">
	  		                
		  		<cfquery datasource='#dts#' name="updateproject">
					Update identifier 
					set desp =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#">where identifierno ='#form.identifierno#'
		  		</cfquery>
				</cfif>	
	  		<cfset status="The Identifier, #form.identifierno# had been successfully edited. ">
		
  	<cfelse>		
		<cfset status="Sorry, the Identifier, #form.identifierno# was ALREADY removed from the system. Process unsuccessful.">
  	</cfif>
</cfif>
<cfoutput>

<form name="done" action="s_identifiertable.cfm?type=desp&process=done" method="post">
  <input name="status" value="#status#" type="hidden">
</form>
</cfoutput>

<script>
	done.submit();
</script>