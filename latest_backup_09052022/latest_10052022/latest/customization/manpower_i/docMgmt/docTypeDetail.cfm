<cfif IsDefined("url.action")>
	<cfif url.action EQ "create">
		<cfset pageTitle="New Document Type">
		<cfset pageAction="Create">		
        <cfset id = "">   
		<cfset docType = "">   
        
	<cfelseif url.action EQ "update">
		<cfset pageTitle="Update Document Type">
		<cfset pageAction="Update">
		
        <cfquery name="getDocType" datasource='#dts#'>
            SELECT * 
            FROM docType 
            WHERE id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.id#">;
		</cfquery>
		
		<cfset id = getDocType.id>   
		<cfset docType = getDocType.docType>   
                        
    <cfelseif url.action EQ "delete">
    	<cfset pageTitle="Delete Document Type">
		<cfset pageAction="Delete">   
        
       <cfquery name="getDocType" datasource='#dts#'>
            SELECT * 
            FROM docType 
            WHERE id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.id#">;
		</cfquery>
		
        <cfset id = getDocType.id>   
		<cfset docType = getDocType.docType>   
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
    <form class="formContainer form2Button" action="/latest/customization/manpower_i/docMgmt/docTypeProcess.cfm?action=#url.action#" method="post">
        <div>#pageTitle#</div>
        <div>
            <table>
                <tr>
                    <th><label for="docType">Doc Type</label></th>
                    <td>
                        <input type="text" id="docType" name="docType" value="#docType#" />                   
                    </td>
                </tr>      
            </table>
        </div>
        <div>
        	<input type="hidden" id="id" name="id" value="#id#" />
            <input type="submit" value="#pageAction#" />
            <input type="button" value="Cancel" onclick="window.location='/latest/customization/manpower_i/docMgmt/docType.cfm'" />
        </div>
    </form>
</cfoutput>
</body>
</html>