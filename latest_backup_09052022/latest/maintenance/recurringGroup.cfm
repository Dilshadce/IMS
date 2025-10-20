<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "635,95,636,98,637,634,638,639,96">
<cfinclude template="/latest/words.cfm">
<cfif IsDefined('url.groupID')>
	<cfset URLrecurringID = trim(urldecode(url.groupID))>
</cfif>

<cfif IsDefined("url.action")>
	<cfif url.action EQ "create">
		<cfset pageTitle="#words[635]#">
		<cfset pageAction="#words[95]#">
        
        <cfset reccuringID = "">
        <cfset desp = "">
        <cfset recurringType = "">
        <cfset nextDate = "">
        
	<cfelseif url.action EQ "update">
		<cfset pageTitle="#words[636]#">
		<cfset pageAction="#words[98]#">
		<cfquery name="getRecurringGroup" datasource='#dts#'>
            SELECT * 
            FROM recurrgroup 
            WHERE groupID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLrecurringID#">;
		</cfquery>
		
        <cfset reccuringID = getRecurringGroup.groupID>
        <cfset desp = getRecurringGroup.desp>
        <cfset recurringType = getRecurringGroup.recurrtype>
        <cfset nextDate = getRecurringGroup.nextdate>
                        
    <cfelseif url.action EQ "delete">
    	<cfset pageTitle="Delete Recurring Group Profile">
		<cfset pageAction="Delete">   
        
        <cfquery name="getRecurringGroup" datasource='#dts#'>
            SELECT * 
            FROM recurrgroup 
            WHERE groupID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLrecurringID#">;
		</cfquery>
		
        <cfset reccuringID = getRecurringGroup.groupID>
        <cfset desp = getRecurringGroup.desp>
        <cfset recurringType = getRecurringGroup.recurrtype>
        <cfset nextDate = getRecurringGroup.nextdate>
        
	</cfif>	
    
</cfif>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
     <title><cfoutput>#pageTitle#</cfoutput></title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
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
  	<cfinclude template="/latest/date/datePickerFunction4.cfm"> 
    <cfinclude template="/CFC/LastDayOfMonth.cfm">
    <cfset thismonth = month(now())>
	<cfset thisyear = year(now())>
</head>

<body class="container">
<cfoutput>
<form class="formContainer form2Button" action="/latest/maintenance/recurringGroupProcess.cfm?action=#url.action#" method="post">
	<div>#pageTitle#</div>
	<div>
	  <table>
			<tr>
            	<input type="hidden" id="reccuringID" name="reccuringID" value="#reccuringID#"/>
                
				<th><label for="desp">#words[637]#</label></th>
				<td>
                	<input type="text" id="desp" name="desp" value="#desp#" required="required" maxlength="25"/>
                </td>
			</tr>
			<tr>
				<th><label for="recurringType">#words[634]#</label></th>
				<td>
                	<select name="recurringType" id="recurringType">
                    	<cfloop index="i" from="1" to="12">
                    		<option value="#i#" <cfif recurringType eq i>selected</cfif>>#i# Month</option>
                        </cfloop>
                    </select>
                </td>
			</tr>
			<tr>
				<th><label for="nextDate">#words[638]#</label></th>
				<td>
                	<input type="text" name="date" id="date" maxlength="10" size="10" value="#DateFormat(nextDate,'DD/MM/YYYY')#" placeholder="#words[639]#" readonly="readonly" />
                </td>
			</tr> 
		</table>
	</div>
	<div>
		<input type="submit" value="#pageAction#" />
		<input type="button" value="#words[96]#" onclick="window.location='/latest/maintenance/recurringGroupProfile.cfm'" />
	</div>
</form>
</cfoutput>
</body>
</html>