<html>
<head>
	<title>Maintenance Capacity</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>
<cfoutput>
	<cfswitch expression="#url.type#">
		<cfcase value="Edit,Delete" delimiters=",">
			<cfquery name="getCapacity" datasource="#dts#">
				select * from vehicapacity where Capacity = '#url.Capacity#'
			</cfquery>
		</cfcase>
	</cfswitch>

	<cfswitch expression="#url.type#">
		<cfcase value="Edit">
			<cfset mode="Edit">
			<cfset title="Edit Capacity">
			<cfset button="Edit">
		</cfcase>
		<cfcase value="Delete">
			<cfset mode="Delete">
			<cfset title="Delete Capacity">
			<cfset button="Delete">
		</cfcase>
		<cfcase value="Create">
			<cfset mode="Create">
			<cfset title="Create Capacity">
			<cfset button="Create">
		</cfcase>
	</cfswitch>

	<h1>#title#</h1>
	<h4>
	<cfif getpin2.h1F10 eq 'T'><a href="Capacitytable2.cfm?type=Create">Creating A Capacity Area</a> </cfif>
	<cfif getpin2.h1F20 eq 'T'>|| <a href="Capacitytable.cfm">List All Capacity</a> </cfif>
	<cfif getpin2.h1F30 eq 'T'>|| <a href="s_Capacitytable.cfm?type=vehicapacity">Search For Capacity</a></cfif>
    
    
    <cfif getpin2.h1630 eq 'T'>|| <a href="p_Capacity.cfm">Capacity Listing</a></cfif></h4>

	<cfform name="Capacityform" action="Capacitytableprocess.cfm" method="post">
    	<input type="hidden" name="mode" value="#mode#">

		<h1 align="center">Capacity File Maintenance</h1>

		<table align="center" class="data" width="500">
      		<tr>
        		<td width="100">Capacity :</td>
        		<td>
				<cfif mode eq "Delete" or mode eq "Edit">
            		<cfinput type="text" size="12" name="Capacity" value="#getCapacity.Capacity#" readonly>
            	<cfelse>
            		<cfinput type="text" size="12" name="Capacity" required="yes" maxlength="12">
          		</cfif>
				</td>
      		</tr>
      		<tr>
        		<td>Description:</td>
        		<td><cfif mode eq "Delete" or mode eq "Edit">
						<cfinput type="text" size="40" name="desp" required="no" value="#getCapacity.desp#" maxlength="40">
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