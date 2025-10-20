<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "600,95,601,98,598,599,96">
<cfinclude template="/latest/words.cfm">
<cfif IsDefined('url.langno')>
	<cfset URLlanguageNo = trim(urldecode(url.langno))>
</cfif>
 

<cfif IsDefined("url.action")>
	<cfif url.action EQ "create">
		<cfset pageTitle="#words[600]#">
		<cfset pageAction="#words[95]#">
        
		<cfset languageNo = "">
        <cfset english = "">
        <cfset chinese = "">
        
	<cfelseif url.action EQ "update">
		<cfset pageTitle="#words[601]#">
		<cfset pageAction="#words[98]#">
		<cfquery name="getLanguage" datasource='#dts#'>
            SELECT * 
            FROM iclanguage 
            WHERE langno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLlanguageNo#">;
		</cfquery>
		
		<cfset languageNo = getLanguage.langno>
        <cfset english = getLanguage.english>
        <cfset chinese = getLanguage.chinese>
                        
    <cfelseif url.action EQ "delete">
    	<cfset pageTitle="Delete Language Profile">
		<cfset pageAction="Delete">   
        
        <cfquery name="getLanguage" datasource='#dts#'>
            SELECT * 
            FROM iclanguage 
            WHERE langno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLlanguageNo#">;
		</cfquery>
		
		<cfset languageNo = getLanguage.langno>
        <cfset english = getLanguage.english>
        <cfset chinese = getLanguage.chinese>   
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
<form class="formContainer form2Button" action="/latest/maintenance/languageProcess.cfm?action=#url.action#" method="post" onsubmit="document.getElementById('language').disabled=false";>
	<div>#pageTitle#</div>
	<div>
		<table>
			<tr>
            	<input type="hidden" id="languageNo" name="languageNo" value="#languageNo#"/>
                
				<th><label for="english">#words[598]#</label></th>
				<td>
                	<input type="text" id="english" name="english" value="#english#" required="required" maxlength="25" />
                </td>
			</tr>
			<tr>
				<th><label for="chinese">#words[599]#</label></th>
				<td>
                	<input type="text" id="chinese" name="chinese" value="#chinese#" />                   
                </td>
			</tr> 
		</table>
	</div>
	<div>
		<input type="submit" value="#pageAction#" />
        <input type="button" value="#words[96]#" onclick="window.location='/latest/maintenance/languageProfile.cfm'" class="btn btn-default" />        
	</div>
</form>
</cfoutput>
</body>
</html>