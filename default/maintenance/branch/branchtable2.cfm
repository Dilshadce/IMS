<html>
<head>
	<title>Maintenance branch</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>
<cfoutput>
	<cfswitch expression="#url.type#">
		<cfcase value="Edit,Delete" delimiters=",">
			<cfquery name="getbranch" datasource="#dts#">
				select * from icbranch where branch = '#url.Branch#'
			</cfquery>
		</cfcase>
	</cfswitch>

	<cfswitch expression="#url.type#">
		<cfcase value="Edit">
			<cfset mode="Edit">
			<cfset title="Edit Branch">
			<cfset button="Edit">
		</cfcase>
		<cfcase value="Delete">
			<cfset mode="Delete">
			<cfset title="Delete Branch">
			<cfset button="Delete">
		</cfcase>
		<cfcase value="Create">
			<cfset mode="Create">
			<cfset title="Create Branch">
			<cfset button="Create">
		</cfcase>
	</cfswitch>

	<h1>#title#</h1>
	<h4>
	<cfif getpin2.h1F10 eq 'T'><a href="branchtable2.cfm?type=Create">Creating A Branch Area</a> </cfif>
	<cfif getpin2.h1F20 eq 'T'>|| <a href="branchtable.cfm">List All Branch</a> </cfif>
	<cfif getpin2.h1F30 eq 'T'>|| <a href="s_branchtable.cfm?type=icbranch">Search For Branch</a></cfif>
    
    
    <cfif getpin2.h1630 eq 'T'>|| <a href="p_branch.cfm">Branch Listing</a></cfif></h4>

	<cfform name="branchform" action="branchtableprocess.cfm" method="post">
    	<input type="hidden" name="mode" value="#mode#">

		<h1 align="center">Branch File Maintenance</h1>

		<table align="center" class="data" width="500">
      		<tr>
        		<td width="100">Branch :</td>
        		<td>
				<cfif mode eq "Delete" or mode eq "Edit">
            		<cfinput type="text" size="12" name="branch" value="#getbranch.branch#" readonly>
            	<cfelse>
            		<cfinput type="text" size="12" name="branch" required="yes" maxlength="12">
          		</cfif>
				</td>
      		</tr>
      		<tr>
        		<td>Description:</td>
        		<td><cfif mode eq "Delete" or mode eq "Edit">
						<cfinput type="text" size="40" name="desp" required="no" value="#getbranch.desp#" maxlength="40">
					<cfelse>
						<cfinput type="text" size="40" name="desp" required="no" maxlength="40">
					</cfif>
				</td>
      		</tr>
            
            <tr>
        		<td>Startwith: (First 2 Alpheb)</td>
        		<td><cfif mode eq "Delete" or mode eq "Edit">
						<cfinput type="text" size="40" name="startwith" required="no" value="#getbranch.startwith#" maxlength="40">
					<cfelse>
						<cfinput type="text" size="40" name="startwith" required="no" maxlength="40">
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