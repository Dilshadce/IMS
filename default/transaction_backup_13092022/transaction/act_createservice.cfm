<cfquery datasource='#dts#' name="checkitemExist">
	Select * from icservi where servi = '#form.servi#' 
</cfquery>
  	
<cfif checkitemExist.recordcount GT 0 >
	<cfset form.servi = checkitemExist.servi>
	<cfset form.desp = checkitemExist.desp>
<cfelse>
	<cfinsert datasource='#dts#' tablename="icservi" formfields="servi,desp,despa,salec,salecsc,salecnc,purc,purprc">
</cfif>
	
<script type="text/javascript">
	<cfoutput>window.opener.getService('#form.servi#','#form.desp#');</cfoutput>
	self.close();	
</script>