<html>
<head>
	<title>Driver Page</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<script type='text/javascript' src='../../ajax/core/engine.js'></script>
<script type='text/javascript' src='../../ajax/core/util.js'></script>
<script type='text/javascript' src='../../ajax/core/settings.js'></script>
<script type="text/javascript" src="/scripts/jscripts/tiny_mce/tiny_mce.js"></script>
<script type="text/javascript" src="/scripts/highslide/highslide.js"></script>
<link rel="stylesheet" type="text/css" href="/scripts/highslide/highslide.css" />

<script type="text/javascript">
//<![CDATA[
hs.registerOverlay({
	html: '<div class="closebutton" onclick="return hs.close(this)" title="Close"></div>',
	position: 'top right',
	fade: 2 // fading the semi-transparent overlay looks bad in IE
});


hs.graphicsDir = '/scripts/highslide/graphics/';
hs.wrapperClassName = 'borderless';
//]]>
</script>

<script language="JavaScript">
	
</script>
<body>	
<!--- ADD ON 15-07-2009 --->
<cfquery name="getGsetup" datasource="#dts#">
  Select lDRIVER from GSetup
</cfquery>

<cfif url.type eq "Edit">
	<cfquery datasource='#dts#' name="getPersonnel">
		Select * from drivercommission where DriverNo='#url.DriverNo#' and category='#url.category#'
	</cfquery>
				
	<cfif getPersonnel.recordcount gt 0>
		<cfset xDriverNo=getPersonnel.DriverNo>
		<cfset xcategory=getPersonnel.category>
        <cfset commission=getPersonnel.commission>	
						
		<cfset mode="Edit">
			<cfset title="Edit #getGsetup.lDRIVER# Commission">
			<cfset button="Edit">
		<cfelse>
			<cfset status="Sorry, the #getGsetup.lDRIVER#, #url.DriverNo# was ALREADY removed from the system. Process unsuccessful.">
			<form name="done" action="vdriver.cfm?process=done" method="post">
				<input name="status" value="#status#" type="hidden">
			</form>
			<script>
				done.submit();
			</script>
		</cfif>
	<cfelseif url.type eq "Create">
		<cfset xDriverNo="#url.driverno#">
        <cfset xcategory="">
        <cfset commission="">	
			
		<cfset mode="Create">
		<cfset title="Create #getGsetup.lDRIVER#">
		<cfset button="Create">
	<cfelseif url.type eq "Delete">
		<cfquery datasource='#dts#' name="getPersonnel">
			Select * from drivercommission where DriverNo='#url.DriverNo#' and category='#url.category#'
		</cfquery>
				
		<cfif getPersonnel.recordcount gt 0>
			<cfset xDriverNo=getPersonnel.DriverNo>
		<cfset xcategory=getPersonnel.category>
        <cfset commission=getPersonnel.commission>	
						
			<cfset mode="Delete">
			<cfset title="Delete #getGsetup.lDRIVER#">
			<cfset button="Delete">
	<cfelse>
		<cfset status="Sorry, the #getGsetup.lDRIVER#, #url.DriverNo# was ALREADY removed from the system. Process unsuccessful. Please refresh your webpage.">
		<form name="done" action="vdrivercommission.cfm?process=done" method="post">
			<input name="status" value="#status#" type="hidden">
		</form>
		<script>
			done.submit();
		</script>
	</cfif>			
</cfif>
<cfoutput>
	<cfif husergrpid eq "Muser"><a href="../home2.cfm"><u>Home</u></a></cfif>
	<h1>#title#</h1>
			
  	<h4>
		<cfif getpin2.h1C10 eq 'T'><a href="Driver.cfm?type=Create"> Creating a #getGsetup.lDRIVER#</a> </cfif>
		<cfif getpin2.h1C20 eq 'T'>|| <a href="vdriver.cfm">List all #getGsetup.lDRIVER#</a> </cfif>
		<cfif getpin2.h1C30 eq 'T'>|| <a href="sdriver.cfm">Search #getGsetup.lDRIVER#</a> </cfif>
		<cfif getpin2.h1C40 eq 'T'>|| <a href="pdriver.cfm" target="_blank">#getGsetup.lDRIVER# Listing</a></cfif>
        
        <cfif getpin2.h1C10 eq 'T'>|| <a href="Driver.cfm?type=Create"> Creating a #getGsetup.lDRIVER# Commission</a> </cfif>
	</h4>

<cfform name="DriverForm" action="DrivercommissionProcess.cfm" method="post">
	<input type="hidden" name="mode" value="#mode#">
	
		<cfquery name="getcate" datasource="#dts#">
			select * from iccate
		</cfquery>

  	<table align="center" class="data" width="550px">
	    <tr> 
	      	<td>#getGsetup.lDRIVER# No :</td>
	      	<td> 
		      	<cfinput type="text" name="driverno" id="driverno" value="#xdriverno#" readonly>
			</td>
	    </tr>
        
        <tr> 
      		<td>Category</td>
      		<td>
            <cfif url.type eq 'Create'>
				<cfselect name="category" id="category" required="yes"	>
	  				<option value="">Choose a Category</option>
					<cfloop query="getcate">
	  					<option value="#getcate.cate#"<cfif xcategory eq getcate.cate>selected</cfif>>#getcate.cate# - #getcate.desp#</option>
					</cfloop>
	  			</cfselect>
            <cfelse>
            <cfinput type="text" name="category" id="category" value="#xcategory#" readonly>
            </cfif>
			</td>
    	</tr>
         <tr>
		        <td>Commission:</td>
		        <td><cfinput type="text" size="10" name="commission" value="#commission#" maxlength="11" validate="integer">%</td>
      		</tr>
        <tr>
    
    <tr> 
			<td></td>
			<td align="right"><input type="submit" value="  #button#  "></td>
 		</tr>
  		
    
  	</table>
</cfform>		
</cfoutput> 
	
</body>
</html>
