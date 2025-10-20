<!--- <script type="text/javascript" src="/scripts/jquery-1.9.1.js"></script>
<script type="text/javascript" src="/scripts/jquery_form.js"></script>
<script type="text/javascript"> 
$(document).ready(function() {  
	$('#photoimg').on('change', function(e){
		$('#upload_picture').ajaxForm({
			target: '#preview',
			success: function() { 
				$('#loading').css("display", "none");
			} 
		}).submit();
	});
});
</script> --->
<cfsetting enablecfoutputonly="no" showdebugoutput="no" >
<cfif isdefined('form.formatlogo')>
	<cfset folder ="/billformat/#dts#">
	<cfif not DirectoryExists(ExpandPath(folder))>
		<cfdirectory action="create" directory="#ExpandPath(folder)#" />
	</cfif>	
	<cftry>
		<cffile action="upload" filefield="formatlogo" destination="#ExpandPath(folder)#\logo.jpg" nameconflict="overwrite" accept="image/*">
		<cfcatch type="any">
			<script language="javascript" type="text/javascript">
				alert('File is not in image format');
			</script>
			<cfabort>
		</cfcatch>
	</cftry>	
	<cfoutput>
		<img src="/billformat/#dts#/#file.ServerFile#" style="max-height:100px; max-width:100px" >
	</cfoutput>
<cfelse>
<div id="preview">
<cfoutput>
<cfif fileexists(expandpath("/billformat/#dts#/logo.jpg"))>
<img src="/billformat/#dts#/logo.jpg" style="max-height:100px; max-width:100px">
</cfif>
</cfoutput>
</div>
<form id="upload_picture" name="upload_picture" method="post" enctype="multipart/form-data" action='/setupwizard/companylogo.cfm'>
	<input type="file" size="85" onchange="" name="formatlogo" id="photoimg" accept="image/gif,image/jpeg,image/tiff,image/x-ms-bmp,image/x-photo-cd,image/x-png,image/x-portable-greymap,image/x-portable-pixmap,image/x-portablebitmap" />
</form>
</cfif>