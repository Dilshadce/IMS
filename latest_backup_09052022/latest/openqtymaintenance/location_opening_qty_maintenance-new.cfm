<html>
<head>
	<title>Opening Qty Maintenance</title></title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>
<cfif isdefined("url.type") and url.type eq "edit">
	<cfquery name="edit_location_item" datasource="#dts#">
		update locqdbf set 
		locqfield='#val(form.qtybf)#',
		lminimum='#val(form.minimum)#',
		lreorder='#val(form.reorder)#' 
		where location=<cfqueryparam cfsqltype="cf_sql_char" value="#url.location#"> 
		and itemno=<cfqueryparam cfsqltype="cf_sql_char" value="#url.itemno#">;
	</cfquery>

	<h3 align="center">The Location - Item Has Been Edited !</h1>
</cfif>

<h1>Opening Qty Maintenance</h1>

<cfif not isdefined('form.searchType')>
<cfset searchStr=''>
<cfset searchType='itemno'>
</cfif>
<form action="location_opening_qty_maintenance-new.cfm" method="post">
		<h1>Search By :
		<select name="searchType">
                <option value="itemno">itemno</option>	
                <option value="location">Location</option>				
		</select>
		Search for :
		<input type="text" name="searchStr" value="">
        <input type="submit" name="submit" value="Search">
		</h1>
	</form>

<cfoutput>
<iframe allowtransparency="true" align="middle" scrolling="auto" frameborder="0" width="100%" height="650" src="location_opening_qty_maintenance-new2.cfm?searchtype=#urlencodedformat(searchtype)#&searchstr=#urlencodedformat(searchstr)#"></iframe>
</cfoutput>
</body>
</html>