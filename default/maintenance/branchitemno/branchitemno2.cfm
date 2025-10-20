<html>
<head>
	<title>Maintenance Branch Item No</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>
<cfoutput>
	<cfswitch expression="#url.type#">
		<cfcase value="Edit,Delete" delimiters=",">
			<cfquery name="getbranchitemno" datasource="#dts#">
				select * from icbranchitemno where branchitemno = '#url.branchitemno#'
			</cfquery>
		</cfcase>
	</cfswitch>

	<cfswitch expression="#url.type#">
		<cfcase value="Edit">
			<cfset mode="Edit">
			<cfset title="Edit Branchitemno">
			<cfset button="Edit">
		</cfcase>
		<cfcase value="Delete">
			<cfset mode="Delete">
			<cfset title="Delete Branchitemno">
			<cfset button="Delete">
		</cfcase>
		<cfcase value="Create">
			<cfset mode="Create">
			<cfset title="Create Branchitemno">
			<cfset button="Create">
		</cfcase>
	</cfswitch>

	<h1>#title#</h1>
	<h4>
	<cfif getpin2.h1F10 eq 'T'><a href="branchitemno2.cfm?type=Create">Creating A Branch Item No</a> </cfif>
	<cfif getpin2.h1F20 eq 'T'>|| <a href="branchitemno.cfm">List All Branch Item No</a> </cfif>
	<cfif getpin2.h1F30 eq 'T'>|| <a href="s_branchitemno.cfm?type=icbranchitemno">Search For Branch Item No</a></cfif>
    <cfquery name="geticitem" datasource="#dts#">
    select itemno,desp from icitem
    </cfquery>
    <cfquery name="geticbranch" datasource="#dts#">
    select branch,desp from icbranch
    </cfquery>
    
    
    <cfif getpin2.h1630 eq 'T'>|| <a href="p_branchiteno.cfm">Branch Item No Listing</a></cfif></h4>

	<cfform name="branchitemnoform" action="branchitemnoprocess.cfm" method="post">
    	<input type="hidden" name="mode" value="#mode#">

		<h1 align="center">Branch Item No File Maintenance</h1>

		<table align="center" class="data" width="500">
      		<tr>
        		<td width="100">Branch Item No:</td>
        		<td>
				<cfif mode eq "Delete" or mode eq "Edit">
            		<cfinput type="text" size="12" name="branchitemno" value="#getbranchitemno.branchitemno#" readonly>
            	<cfelse>
            		<cfinput type="text" size="12" name="branchitemno" required="yes" maxlength="12">
          		</cfif>
				</td>
      		</tr>
      		<tr>
        		<td>Description:</td>
        		<td><cfif mode eq "Delete" or mode eq "Edit">
						<cfinput type="text" size="40" name="desp" required="no" value="#getbranchitemno.desp#" maxlength="40">
					<cfelse>
						<cfinput type="text" size="40" name="desp" required="no" maxlength="40">
					</cfif>
				</td>
      		</tr>
            
            <tr>
        		<td>Itemno</td>
        		<td><cfif mode eq "Delete" or mode eq "Edit">
						<select name="itemno">
                        <option value="">Choose a itemno</option>
                        <cfloop query="geticitem">
                        <option value="#itemno#" <cfif getbranchitemno.itemno eq geticitem.itemno>selected</cfif>>#itemno# - #desp#</option>
                        </cfloop>
                        </select>
					<cfelse>
						<select name="itemno">
                        <option value="">Choose a itemno</option>
                        <cfloop query="geticitem">
                        <option value="#itemno#">#itemno# - #desp#</option>
                        </cfloop>
                        </select>
					</cfif>
				</td>
      		</tr>
            
            <tr>
        		<td>Branch</td>
        		<td><cfif mode eq "Delete" or mode eq "Edit">
						<select name="branch">
                        <option value="">Choose a Branch table</option>
                        <cfloop query="geticbranch">
                        <option value="#branch#" <cfif getbranchitemno.branch eq geticbranch.branch>selected</cfif>>#branch# - #desp#</option>
                        </cfloop>
                        </select>
					<cfelse>
						<select name="branch">
                        <option value="">Choose a Branchtable</option>
                        <cfloop query="geticbranch">
                        <option value="#branch#">#branch# - #desp#</option>
                        </cfloop>
                        </select>
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