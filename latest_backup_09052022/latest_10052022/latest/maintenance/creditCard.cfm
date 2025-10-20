<cfif IsDefined('url.cardName')>
	<cfset URLcardName = trim(urldecode(url.cardName))>
</cfif>
<cfif IsDefined("url.action")>
	<cfif url.action EQ "create">
		<cfset pageTitle="Credit Card Profile">
		<cfset pageAction="Create">
		<cfset cardName = "">
        <cfset cardDesp = "">
        
	<cfelseif url.action EQ "update">
		<cfset pageTitle="Credit Card Profile">
		<cfset pageAction="Update">
		<cfquery name="getBrand" datasource='#dts#'>
            SELECT * 
            FROM creditCard 
            WHERE cardName=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLcardName#">;
		</cfquery>
		
		<cfset cardName = getBrand.cardName>
        <cfset cardDesp = getBrand.cardDesp>
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
<form class="formContainer form2Button" action="/latest/maintenance/creditCardProcess.cfm?action=#url.action#&menuID=#url.menuID#" method="post" onsubmit="document.getElementById('cardName').disabled=false";>
	<div>#pageTitle#</div>
	<div>
		<table>
			<tr>
				<th><label for="cardNameLabel">Credit Card Name</label></th>
				<td>
                	<input type="text" id="cardName" name="cardName" required="required" maxlength="100"
                    	<cfif IsDefined("url.action") AND url.action NEQ "create">  value="#URLcardName#"  disabled="true"</cfif>/>
                </td>
			</tr>
			<tr>
				<th><label for="cardDespLabel">Credit Card Description</label></th>
				<td>
                	<textarea rows="4" cols="50" id="cardDesp" name="cardDesp">#cardDesp#</textarea>                
                </td>
			</tr> 
            
		</table>
	</div>
	<div>
		<input type="submit" value="#pageAction#" />
		<input type="button" value="Cancel" onclick="window.location='/latest/maintenance/creditCardProfile.cfm?menuID=#menuID#'" />
	</div>
</form>
</cfoutput>
</body>
</html>