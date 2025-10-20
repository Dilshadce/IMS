<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "678,95,679,98,676,65,96">
<cfinclude template="/latest/words.cfm">
<cfif IsDefined('url.titleID')>
	<cfset URLtitle = trim(urldecode(url.titleID))>
</cfif>

<cfif IsDefined("url.action")>
	<cfif url.action EQ "create">
		<cfset pageTitle="#words[678]#">
		<cfset pageAction="#words[95]#">
		<cfset title = "">
        <cfset desp = "">
        
	<cfelseif url.action EQ "update">
		<cfset pageTitle="#words[679]#">
		<cfset pageAction="#words[98]#">
		<cfquery name="getTitle" datasource='#dts#'>
            SELECT * 
            FROM title 
            WHERE title_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLtitle#">;
		</cfquery>
		
		<cfset title = getTitle.title_id>
        <cfset desp = getTitle.desp>
                        
    <cfelseif url.action EQ "delete">
    	<cfset pageTitle="Delete Title Profile">
		<cfset pageAction="Delete">   
        
        <cfquery name="getTitle" datasource='#dts#'>
            SELECT * 
            FROM title 
            WHERE title_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLtitle#">;
		</cfquery>
		
		<cfset title = getTitle.title_id>
        <cfset desp = getTitle.desp>     
	</cfif>
    
</cfif>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><cfoutput>#pageTitle#</cfoutput></title>
    <link rel="stylesheet" href="/latest/css/form.css" />
    <script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <!--[if (gte IE 6)&(lte IE 8)]>
        <script type="text/javascript" src="/latest/js/selectivizr/selectivizr-min.js"></script>
        <noscript><link rel="stylesheet" href="" /></noscript>
    <![endif]-->
</head>

<body class="container">
<cfoutput>
<form class="formContainer form2Button" action="/latest/maintenance/titleProcess.cfm?action=#url.action#" method="post" onsubmit="document.getElementById('title').disabled=false";>
	<div>#pageTitle#</div>
	<div>
		<table>
			<tr>
				<th><label for="title">#words[676]#</label></th>
				<td>
                	<input type="text" id="title" name="title" required="required" maxlength="25"
                    	<cfif IsDefined("url.action") AND url.action NEQ "create">  value="#URLtitle#"  disabled="true"</cfif>/>
                </td>
			</tr>
			<tr>
				<th><label for="desp">#words[65]#</label></th>
				<td>
                	<input type="text" id="desp" name="desp" value="#desp#" />                   
                </td>
			</tr> 
		</table>
	</div>
	<div>
		<input type="submit" value="#pageAction#" />
		<input type="button" value="#words[96]#" onclick="window.location='/latest/maintenance/titleProfile.cfm'" />
	</div>
</form>
</cfoutput>
</body>
</html>