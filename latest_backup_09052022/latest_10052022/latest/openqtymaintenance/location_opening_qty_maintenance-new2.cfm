<html>
<head>
	<title>Opening Qty Maintenance</title></title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>
<cfquery datasource='#dts#' name="getPersonnel">
	select location,itemno,locqfield,lreorder,lminimum 
	from locqdbf 
    where
    #searchType# LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#searchStr#%">
	order by location,itemno;
</cfquery>

<cfparam name="start" default="1">
<cfparam name="page" default="1">
<cfparam name="prevFive" default="0">
<cfparam name="nextFive" default="0">

<h1>Opening Qty Maintenance</h1>


<cfif getPersonnel.recordcount neq 0>
	<cfif isdefined("form.skeypage")>
		<cfset noOfPage=round(getPersonnel.recordcount/10)>

		<cfif getPersonnel.recordcount mod 20 LT 10 and getPersonnel.recordcount mod 20 neq 0>
			<cfset noOfPage=noOfPage+1>
		</cfif>

		<cfif form.skeypage gt noofpage OR form.skeypage lt 1>
			<h3 align="center"><font color="#FF0000">Wrong page number! Please try again.</font></h3>
			<cfabort>
		</cfif>
	</cfif>

	<cfform action="location_opening_qty_maintenance-new2.cfm?searchtype=#urlencodedformat(searchtype)#&searchstr=#urlencodedformat(searchstr)#" method="post">
		<div align="right">Page
		<cfinput name="skeypage" type="text" size="2" validate="integer" message="Wrong value in Page field.">

		<cfset noOfPage=round(getPersonnel.recordcount/20)>

		<cfif getPersonnel.recordcount mod 20 LT 10 and getPersonnel.recordcount mod 20 neq 0>
			<cfset noOfPage=noOfPage+1>
		</cfif>

		<cfif isdefined("url.start")>
			<cfset start=url.start>
		</cfif>

		<cfif isdefined("form.skeypage")>
			<cfset start = form.skeypage * 20 + 1 - 20>
			<cfif form.skeypage eq "1">
				<cfset start = "1">
			</cfif>
		</cfif>

		<cfset prevTwenty = start -20>
		<cfset nextTwenty = start +20>
		<cfset page = round(nextTwenty/20)>


		<cfif start neq 1>
			<cfoutput>|| <a href="location_opening_qty_maintenance-new2.cfm?start=#prevTwenty#&searchtype=#urlencodedformat(searchtype)#&searchstr=#urlencodedformat(searchstr)#" target="_self">Previous</a> ||</cfoutput>
		</cfif>

		<cfif page neq noOfPage>
			<cfoutput> <a href="location_opening_qty_maintenance-new2.cfm?&start=#nextTwenty#&searchtype=#urlencodedformat(searchtype)#&searchstr=#urlencodedformat(searchstr)#" target="_self">Next</a> ||</cfoutput>
		</cfif>

		<cfoutput>Page #page# Of #noOfPage#</cfoutput>
		</div>
		<hr>


			<table align="center" class="data" width="50%">
            <tr><th>Item No</th><th>Location</th><th>qtybf</th></tr>
            <cfoutput query="getPersonnel" startrow="#start#" maxrows="20">
				<tr>
          			<td>#getPersonnel.itemno#</td>
        		
          			<td>#getPersonnel.location#</td>
                    <td>#getPersonnel.locqfield#</td>
        		
        		<cfif getpin2.h1D11 eq 'T'>

          			<td colspan="2"><div align="right">
					<a href="edit_location_item2.cfm?type=edit&modeaction=no&location=#URLEncodedFormat(getPersonnel.location)#&itemno=#URLEncodedFormat(getPersonnel.itemno)#" target="mainFrame">
				<img height="18px" width="18px" src="/images/edit.ICO" alt="Edit" border="0">Edit</a></div></td>

				</cfif>
                </cfoutput>
     	 	</table>
			<br>
			<hr>
		
	</cfform>
	<div align="right">

	<cfif start neq 1>
		<cfoutput>|| <a href="location_opening_qty_maintenance-new2.cfm?&start=#prevTwenty#searchtype=#urlencodedformat(searchtype)#&searchstr=#urlencodedformat(searchstr)#">Previous</a> ||</cfoutput>
	</cfif>

	<cfif page neq noOfPage>
		<cfoutput> <a href="location_opening_qty_maintenance-new2.cfm?&start=#nextTwenty#&searchtype=#urlencodedformat(searchtype)#&searchstr=#urlencodedformat(searchstr)#">Next</a> ||</cfoutput>
	</cfif>

	<cfoutput>Page #page# Of #noOfPage#</cfoutput>
	</div>
	<hr>
<cfelse>
	<h3>Sorry, No records were found.</h3>
</cfif>
</body>
</html>