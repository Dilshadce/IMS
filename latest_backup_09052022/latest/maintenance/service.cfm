<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "295,95,298,98,294,65,183,185,186,187,188,296,297,96">
<cfinclude template="/latest/words.cfm">
<cfif IsDefined('url.servi')>
	<cfset URLservi = trim(urldecode(url.servi))>
</cfif>

<cfif HlinkAMS EQ 'Y'>
	<cfset dts2=replace(dts,'_i','_a','all')>
    <cfquery name="getglacc" datasource="#dts2#">
        select accno,desp,desp2 ,acc_code
        from gldata 
        where accno not in (select custno from arcust order by custno) 
        and accno not in (select custno from apvend order by custno)
        order by accno
    </cfquery>
</cfif>

<cfif IsDefined("url.action")>
	<cfif url.action EQ "create">
		<cfset pageTitle="#words[295]#">
		<cfset pageAction="#words[95]#">
		<cfset servi = "">
        <cfset desp = "">
        <cfset despa = "">
        <cfset SALEC = "">
        <cfset SALECSC = "">
        <cfset SALECNC = "">
        <cfset PURC = "">
        <cfset PURPRC = "">
       
        
        <cfset SERCOST = "0.00">
        <cfset serprice = "0.00">
        
	<cfelseif url.action EQ "update">
		<cfset pageTitle="#words[298]#">
		<cfset pageAction="#words[98]#">
		<cfquery name="getService" datasource='#dts#'>
            SELECT * 
            FROM icservi 
            WHERE servi=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLservi#">;
		</cfquery>
		
		<cfset servi = getService.servi>
        <cfset desp = getService.desp>
        <cfset despa = getService.despa>
        <cfset salec = getService.SALEC>
        <cfset SALECSC = getService.SALECSC>
        <cfset SALECNC = getService.SALECNC>
        <cfset PURC = getService.PURC>
        <cfset PURPRC = getService.PURPRC>
       
        <cfset SERCOST = getService.SERCOST>
        <cfset serprice = getService.serprice>
                
    <cfelseif url.action EQ "delete">
    	<cfset pageTitle="Delete Service Profile">
		<cfset pageAction="Delete">   
        
        <cfquery name="getService" datasource='#dts#'>
            SELECT * 
            FROM icservi 
            WHERE servi=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLservi#">;
		</cfquery>
		
		<cfset servi = getService.servi>
        <cfset desp = getService.desp>
        <cfset despa = getService.despa>
        <cfset SALEC = getService.SALEC>
        <cfset SALECSC = getService.SALECSC>
        <cfset SALECNC = getService.SALECNC>
        <cfset PURC = getService.PURC>
        <cfset PURPRC = getService.PURPRC>
       
        <cfset SERCOST = getService.SERCOST>
        <cfset serprice = getService.serprice>     
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
<form class="formContainer form2Button" action="/latest/maintenance/serviceProcess.cfm?action=#url.action#&menuID=#url.menuID#" method="post"  onsubmit="document.getElementById('service').disabled=false";>
	<div>#pageTitle#</div>
	<div>
		<table>
			<tr>
				<th><label for="service">#words[294]#</label></th>
				<td>
                	<input type="text" id="service" name="service" required="required" maxlength="8"  
						<cfif IsDefined("url.action") AND url.action NEQ "create"> value="#servi#" disabled="true"</cfif> />
                </td>
			</tr>
			<tr>
				<th><label for="desp">#words[65]#</label></th>
				<td>
                	<input type="text" id="desp" name="desp" value="#desp#" maxlength="100"/>                   
                </td>
			</tr>
            <tr>
            	<td></td>
                <td>
                	<input type="text" id="despa" name="despa" value="#despa#" maxlength="100"/>
                </td>
			</tr>
            <tr>
				<th><label for="creditSales">#words[183]#</label></th>
				<td>
                <cfif Hlinkams eq "Y">
                <select name="creditSales" id="creditSales">
                <option value="">Choose a #words[183]#</option>
                <cfloop query="getglacc">
                <option value="#getglacc.accno#" <cfif salec eq getglacc.accno>selected</cfif>>#getglacc.accno# - #getglacc.desp#</option>
                </cfloop>
                </select>
                <cfelse>
                <input type="text" id="creditSales" name="creditSales" value="#salec#" placeholder="#words[183]#" />
                </cfif>
					
                </td>
			</tr>
            <tr>
				<th><label for="cashSales">#words[185]#</label></th>
				<td>
                    <cfif Hlinkams eq "Y">
                    <select name="cashSales" id="cashSales">
                    <option value="">Choose a #words[185]#</option>
                    <cfloop query="getglacc">
                    <option value="#getglacc.accno#" <cfif SALECSC eq getglacc.accno>selected</cfif>>#getglacc.accno# - #getglacc.desp#</option>
                    </cfloop>
                    </select>
                    <cfelse>
                    <input type="text" id="cashSales" name="cashSales" value="#SALECSC#" placeholder="#words[185]#" />
                    </cfif>
                </td>
			</tr>
            <tr>
				<th><label for="salesReturn">#words[186]#</label></th>
				<td>
                    <cfif Hlinkams eq "Y">
                    <select name="salesReturn" id="salesReturn">
                    <option value="">Choose a #words[186]#</option>
                    <cfloop query="getglacc">
                    <option value="#getglacc.accno#" <cfif SALECNC eq getglacc.accno>selected</cfif>>#getglacc.accno# - #getglacc.desp#</option>
                    </cfloop>
                    </select>
                    <cfelse>
                    <input type="text" id="salesReturn" name="salesReturn" value="#SALECNC#" placeholder="#words[186]#" />
                    </cfif>
                </td>
			</tr>
            <tr>
				<th><label for="purchase">#words[187]#</label></th>
				<td>
                    <cfif Hlinkams eq "Y">
                    <select name="purchase" id="purchase">
                    <option value="">Choose a #words[187]#</option>
                    <cfloop query="getglacc">
                    <option value="#getglacc.accno#" <cfif PURC eq getglacc.accno>selected</cfif>>#getglacc.accno# - #getglacc.desp#</option>
                    </cfloop>
                    </select>
                    <cfelse>
                    <input type="text" id="purchase" name="purchase" value="#PURC#" placeholder="#words[187]#" />
                    </cfif>
                </td>
			</tr>
            <tr>
				<th><label for="purchaseReturn">#words[188]#</label></th>
				<td>
                    <cfif Hlinkams eq "Y">
                    <select name="purchaseReturn" id="purchaseReturn">
                    <option value="">Choose a #words[188]#</option>
                    <cfloop query="getglacc">
                    <option value="#getglacc.accno#" <cfif PURPRC eq getglacc.accno>selected</cfif>>#getglacc.accno# - #getglacc.desp#</option>
                    </cfloop>
                    </select>
                    <cfelse>
                    <input type="text" id="purchaseReturn" name="purchaseReturn" value="#PURPRC#" placeholder="#words[188]#" />
                    </cfif>
                </td>
			</tr>
            <tr>
				<th><label for="serviceCost">#words[296]#</label></th>
				<td>
                	<input type="text" id="serviceCost" name="serviceCost" value="#SERCOST#" maxlength="8"/>
                </td>
			</tr>
            <tr>
				<th><label for="servicePrice">#words[297]#</label></th>
				<td>
                	<input type="text" id="servicePrice" name="servicePrice" value="#serprice#" maxlength="8"/>
                </td>
			</tr>
		</table>
	</div>
	<div>
		<input type="submit" value="#pageAction#" />
		<input type="button" value="#words[96]#" onClick="window.location='/latest/maintenance/serviceProfile.cfm?menuID=#url.menuID#'"/>
        
	</div>
</form>
</cfoutput>
</body>
</html>