<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<cfparam name="status" default="">

<cfif form.mode eq "Create">
	<cfquery datasource='#dts#' name="checkitemExist">
		Select * from voucherprefix where voucherprefixno = '#form.voucherprefixno#' 
	</cfquery>
  
	<cfif checkitemExist.recordcount GT 0 >
		<cfoutput>
	      <h3><font color="##FF0000">Error, This voucherprefix ("#form.voucherprefixno#") has been created already.</font></h3>
		</cfoutput> 
	    <cfabort>
	</cfif>
	
		<cfquery datasource="#dts#" name="insertartran">
			Insert into voucherprefix 
			(voucherprefixno)
			values 
			('#form.voucherprefixno#')
		</cfquery>
        	
  	<cfset status="The Voucherprefix No, #form.voucherprefixno# had been successfully created. ">
    
<cfelse>
  	<cfquery datasource='#dts#' name="checkitemExist">
		Select * from voucherprefix where voucherprefixno='#form.voucherprefixno#'
  	</cfquery>
		
  	<cfif checkitemExist.recordcount GT 0 >
		<cfif form.mode eq "Delete">
      		<cfquery datasource='#dts#' name="deleteitem">
	    		Delete from voucherprefix where voucherprefixno='#form.voucherprefixno#'
	  		</cfquery>
	  		<cfset status="The Voucher Prefix No, #form.voucherprefixno# had been successfully deleted. ">	
		</cfif>
		<cfif form.mode eq "Edit">		
	  		<cfset status="The Voucher Prefix No, #form.voucherprefixno# had been successfully edited. ">
		</cfif>
  	<cfelse>		
		<cfset status="Sorry, the #getgeneral.layer#, #form.voucherprefixno# was ALREADY removed from the system. Process unsuccessful.">
  	</cfif>
</cfif>
<cfoutput>

<form name="done" action="voucherprefix.cfm?type=voucher&process=done" method="post">
  <input name="status" value="#status#" type="hidden">
</form>
</cfoutput>

<script>
	done.submit();
</script>