<cfprocessingdirective pageencoding="UTF-8">
<!--- <cfset words_id_list = "295,95,298,98,294,65,183,185,186,187,188,296,297,96">
<cfinclude template="/latest/words.cfm"> --->
<cfif IsDefined('url.accno')>
	<cfset URLaccno = trim(urldecode(url.accno))>
</cfif>


<cfif IsDefined("url.action")>
	<cfif url.action EQ "create">
		<cfset pageTitle="Create Location Mapping Profile">
		<cfset pageAction="Create">
		<cfset accno = "">
        <cfset newaccno = "">

	<cfelseif url.action EQ "update">
		<cfset pageTitle="Update Location Mapping Profile">
		<cfset pageAction="Update">
		<cfquery name="getaccno" datasource='#dts#'>
            SELECT *
            FROM locationmap
            WHERE accno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLaccno#">;
		</cfquery>

		<cfset accno = getaccno.accno>
        <cfset newaccno = getaccno.newaccno>

    <cfelseif url.action EQ "delete">
    	<cfset pageTitle="Delete Location Mapping Profile">
		<cfset pageAction="Delete">

        <cfquery name="getaccno" datasource='#dts#'>
            SELECT *
            FROM locationmap
            WHERE accno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLaccno#">;
		</cfquery>

		<cfset accno = getaccno.accno>
        <cfset newaccno = getaccno.newaccno>
	</cfif>
</cfif>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><cfoutput>#pageTitle#</cfoutput></title>
    <link rel="stylesheet" href="/latest/css/jqueryui/smoothness/jquery-ui-1.10.3.custom.min.css" />
    <link rel="stylesheet" href="/latest/css/select2/select2.css" />
    <link rel="stylesheet" href="/latest/css/form.css" />
    <script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <!--[if (gte IE 6)&(lte IE 8)]>
        <script type="text/javascript" src="/latest/js/selectivizr/selectivizr-min.js"></script>
        <noscript><link rel="stylesheet" href="" /></noscript>
    <![endif]-->
    <script type="text/javascript" src="/latest/js/jqueryui/jquery-ui-1.10.3.custom.min.js"></script>
    <script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>



    <!--[if (gte IE 6)&(lte IE 8)]>
        <script type="text/javascript" src="/latest/js/selectivizr/selectivizr-min.js"></script>
        <noscript><link rel="stylesheet" href="" /></noscript>
    <![endif]-->
</head>

  <cfinclude template="/latest/filter/filterLocation.cfm">

<body class="container">
<cfoutput>
<form class="formContainer form3Button" action="/default/maintenance/locationmapping/accnoprocess.cfm?action=#url.action#&menuID=#url.menuID#" method="post"  onsubmit="document.getElementById('accno').disabled=false";>
	<div>#pageTitle#</div>
	<div>
		<table>
			<tr>
				<th><label for="accno">Source Location</label></th>
				<td>
                	<input type="text" id="accno" name="accno" required="required" maxlength="12"
						<cfif IsDefined("url.action") AND url.action NEQ "create"> value="#accno#" disabled="true"</cfif> />
                </td>
			</tr>
			<tr>
				<th><label for="newAccno">System Location</label></th>
				<td>
					<input type="hidden" id="newaccno" name="newaccno" class="locationFilter" value="#newaccno#" placeholder="Choose a Location" />
                </td>
			</tr>
		</table>
	</div>
	<div>
		<input type="submit" value="#pageAction#" />
		<input type="button" value="Cancel" onClick="window.location='/default/maintenance/locationmapping/accnoMapProfile.cfm?menuID=#url.menuID#'"/>

	</div>
</form>
</cfoutput>
</body>
</html>