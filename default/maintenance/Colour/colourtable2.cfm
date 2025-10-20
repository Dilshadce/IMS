<html>
<head>
	<title>Maintenance Colour</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>
<cfoutput>
	<cfswitch expression="#url.type#">
		<cfcase value="Edit,Delete" delimiters=",">
			<cfquery name="getColour" datasource="#dts#">
				select * from vehicolour where Colour = '#url.Colour#'
			</cfquery>
		</cfcase>
	</cfswitch>

	<cfswitch expression="#url.type#">
		<cfcase value="Edit">
			<cfset mode="Edit">
			<cfset title="Edit Colour">
			<cfset button="Edit">
		</cfcase>
		<cfcase value="Delete">
			<cfset mode="Delete">
			<cfset title="Delete Colour">
			<cfset button="Delete">
		</cfcase>
		<cfcase value="Create">
			<cfset mode="Create">
			<cfset title="Create Colour">
			<cfset button="Create">
		</cfcase>
	</cfswitch>

	<h1>#title#</h1>
	<h4>
	<cfif getpin2.h1F10 eq 'T'><a href="Colourtable2.cfm?type=Create">Creating A Colour Area</a> </cfif>
	<cfif getpin2.h1F20 eq 'T'>|| <a href="Colourtable.cfm">List All Colour</a> </cfif>
	<cfif getpin2.h1F30 eq 'T'>|| <a href="s_Colourtable.cfm?type=vehicolour">Search For Colour</a></cfif>
    
    
    <cfif getpin2.h1630 eq 'T'>|| <a href="p_Colour.cfm">Colour Listing</a></cfif></h4>

	<cfform name="Colourform" action="Colourtableprocess.cfm" method="post">
    	<input type="hidden" name="mode" value="#mode#">

		<h1 align="center">Colour File Maintenance</h1>

		<table align="center" class="data" width="500">
      		<tr>
        		<td width="100">Colour :</td>
        		<td>
				<cfif mode eq "Delete" or mode eq "Edit">
            		<cfinput type="text" size="12" name="Colour" value="#getColour.Colour#" readonly>
            	<cfelse>
            		<cfinput type="text" size="12" name="Colour" required="yes" maxlength="12">
          		</cfif>
				</td>
      		</tr>
      		<tr>
        		<td>Description:</td>
        		<td><cfif mode eq "Delete" or mode eq "Edit">
						<cfinput type="text" size="40" name="desp" required="no" value="#getColour.desp#" maxlength="40">
					<cfelse>
						<cfinput type="text" size="40" name="desp" required="no" maxlength="40">
					</cfif>
				</td>
      		</tr>
            
      		<tr>
        		<td></td>
        		<td align="right"><cfinput name="submit" type="submit" value="  #button#  "></td>
      		</tr>
		</table>
	</cfform>
</body>
</cfoutput>
</html>