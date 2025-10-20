<html>
<head>
	<title>Maintenance Model</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>
<cfoutput>
	<cfswitch expression="#url.type#">
		<cfcase value="Edit,Delete" delimiters=",">
			<cfquery name="getModel" datasource="#dts#">
				select * from vehiModel where Model = '#url.Model#'
			</cfquery>
		</cfcase>
	</cfswitch>

	<cfswitch expression="#url.type#">
		<cfcase value="Edit">
			<cfset mode="Edit">
			<cfset title="Edit Model">
			<cfset button="Edit">
		</cfcase>
		<cfcase value="Delete">
			<cfset mode="Delete">
			<cfset title="Delete Model">
			<cfset button="Delete">
		</cfcase>
		<cfcase value="Create">
			<cfset mode="Create">
			<cfset title="Create Model">
			<cfset button="Create">
		</cfcase>
	</cfswitch>

	<h1>#title#</h1>
	<h4>
	<cfif getpin2.h1F10 eq 'T'><a href="Modeltable2.cfm?type=Create">Creating A Model Area</a> </cfif>
	<cfif getpin2.h1F20 eq 'T'>|| <a href="Modeltable.cfm">List All Model</a> </cfif>
	<cfif getpin2.h1F30 eq 'T'>|| <a href="s_Modeltable.cfm?type=vehiModel">Search For Model</a></cfif>
    
    
    <cfif getpin2.h1630 eq 'T'>|| <a href="p_Model.cfm">Model Listing</a></cfif></h4>

	<cfform name="Modelform" action="Modeltableprocess.cfm" method="post">
    	<input type="hidden" name="mode" value="#mode#">

		<h1 align="center">Model File Maintenance</h1>

		<table align="center" class="data" width="500">
      		<tr>
        		<td width="100">Model :</td>
        		<td>
				<cfif mode eq "Delete" or mode eq "Edit">
            		<cfinput type="text" size="12" name="Model" value="#getModel.Model#" readonly>
            	<cfelse>
            		<cfinput type="text" size="12" name="Model" required="yes" maxlength="12">
          		</cfif>
				</td>
      		</tr>
      		<tr>
        		<td>Description:</td>
        		<td><cfif mode eq "Delete" or mode eq "Edit">
						<cfinput type="text" size="40" name="desp" required="no" value="#getModel.desp#" maxlength="40">
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