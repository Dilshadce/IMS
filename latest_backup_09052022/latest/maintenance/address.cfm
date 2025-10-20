<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "442,95,443,98,438,23,16,6,38,39,8,440,300,441,45,96">
<cfinclude template="/latest/words.cfm">
<cfif IsDefined('url.code')>
	<cfset URLaddress = trim(urldecode(url.code))>
</cfif>


<cfif IsDefined("url.action")>
	<cfif url.action EQ "create">
		<cfset pageTitle="#words[442]#">
		<cfset pageAction="#words[95]#">
		<cfset code = "">
        <cfset name = "">
        <cfset name2 = "">
        <cfset customerNo = "">
        <cfset add1 = "">
        <cfset add2 = "">
        <cfset add3 = "">
        <cfset add4 = "">
        <cfset country = "">
        <cfset postalCode = "">
        <cfset attention = "">
        <cfset telephone = "">
        <cfset fax = "">
        <cfset phone2 = "">
        <cfset email = ""> 
        <cfset gstno = "">
        
        
	<cfelseif url.action EQ "update">
		<cfset pageTitle="#words[443]#">
		<cfset pageAction="#words[98]#">
		<cfquery name="getAddress" datasource='#dts#'>
            SELECT * 
            FROM address 
            WHERE code=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLaddress#">;
		</cfquery>
		
		<cfset code = getAddress.code>
        <cfset name = getAddress.name>
        <cfset name2 = getAddress.name2>
        <cfset customerNo = getAddress.custno>
        <cfset add1 = getAddress.add1>
        <cfset add2 = getAddress.add2>
        <cfset add3 = getAddress.add3>
        <cfset add4 = getAddress.add4>
        <cfset country = getAddress.country>
        <cfset postalCode = getAddress.postalcode>
        <cfset attention = getAddress.attn>
        <cfset telephone = getAddress.phone>
        <cfset fax = getAddress.fax>
        <cfset phone2 = getAddress.phonea>
        <cfset email = getAddress.e_mail>
        <cfset gstno = getAddress.gstno>
                        
    <cfelseif url.action EQ "delete">
    	<cfset pageTitle="Delete Address Profile">
		<cfset pageAction="Delete">   
        
        <cfquery name="getAddress" datasource='#dts#'>
            SELECT * 
            FROM address 
            WHERE code=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLaddress#">;
		</cfquery>
		
		<cfset code = getAddress.code>
        <cfset name = getAddress.name>
        <cfset name2 = getAddress.name2>
        <cfset customerNo = getAddress.custno>
        <cfset add1 = getAddress.add1>
        <cfset add2 = getAddress.add2>
        <cfset add3 = getAddress.add3>
        <cfset add4 = getAddress.add4>
        <cfset country = getAddress.country>
        <cfset postalCode = getAddress.postalcode>
        <cfset attention = getAddress.attn>
        <cfset telephone = getAddress.phone>
        <cfset fax = getAddress.fax>
        <cfset phone2 = getAddress.phonea>
        <cfset email = getAddress.e_mail>     
        <cfset gstno = getAddress.gstno>
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
    
	<cfinclude template="filterCustomer.cfm">
    <link rel="stylesheet" href="/latest/css/select2/select2.css" />
    <script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>
</head>

<body class="container">
<cfoutput>
<form class="formContainer form2Button" action="/latest/maintenance/addressProcess.cfm?action=#url.action#" method="post" onsubmit="document.getElementById('code').disabled=false";>
	<div>#pageTitle#</div>
	<div>
		<table>
			<tr>
				<th><label for="code">#words[438]#</label></th>
				<td>
                	<input type="text" id="code" name="code" required="required" maxlength="25"
                    	<cfif IsDefined("url.action") AND url.action NEQ "create">  value="#URLaddress#"  disabled="true"</cfif>/>
                </td>
			</tr>
			<tr>
				<th><label for="name">#words[23]#</label></th>
				<td>
                	<input type="text" id="name" name="name" value="#name#" maxlength="100" />                   
                </td>
			</tr>
            <tr>
				<th><label for="name2"></label></th>
				<td>
                	<input type="text" id="name2" name="name2" value="#name2#"  maxlength="100" />                   
                </td>
			</tr>
            <tr>
				<th><label for="customerNo">#words[16]#</label></th>
				<td>
                	<input type="hidden" id="customerNo" name="customerNo" class="customerNo" data-placeholder="#customerNo#" />	                   
                </td>
			</tr>
            <tr>
				<th><label for="add1">#words[6]#</label></th>
				<td>
                	<input type="text" id="add1" name="add1" value="#add1#" />                   
                </td>
			</tr>
            <tr>
				<th></th>
				<td>
                	<input type="text" id="add2" name="add2" value="#add2#" />                   
                </td>
			</tr>
            <tr>
				<th></th>
				<td>
                	<input type="text" id="add3" name="add3" value="#add3#" />                   
                </td>
			</tr>
            <tr>
				<th></th>
				<td>
                	<input type="text" id="add4" name="add4" value="#add4#" />                   
                </td>
			</tr> 
            <tr>
				<th><label for="country">#words[38]#</label></th>
				<td>
                	<input type="text" id="country" name="country" value="#country#" />                   
                </td>
			</tr>
            <tr>
				<th><label for="postalCode">#words[39]#</label></th>
				<td>
                	<input type="text" id="postalCode" name="postalCode" value="#postalCode#" />                   
                </td>
			</tr>
            <tr>
				<th><label for="attention">#words[8]#</label></th>
				<td>
                	<input type="text" id="attention" name="attention" value="#attention#" />                   
                </td>
			</tr>
            <tr>
				<th><label for="telephone">#words[440]#</label></th>
				<td>
                	<input type="text" id="telephone" name="telephone" value="#telephone#" />                   
                </td>
			</tr>	
            <tr>
				<th><label for="fax">#words[300]#</label></th>
				<td>
                	<input type="text" id="fax" name="fax" value="#fax#" />                   
                </td>
			</tr>	
            <tr>
				<th><label for="phone2">#words[441]#</label></th>
				<td>
                	<input type="text" id="phone2" name="phone2" value="#phone2#" />                   
                </td>
			</tr>
            <tr>
				<th><label for="email">#words[45]#</label></th>
				<td>
                	<input type="text" id="email" name="email" value="#email#" />                   
                </td>
			</tr>
            <tr>
				<th><label for="email">GST No</label></th>
				<td>
                	<input type="text" id="gstno" name="gstno" value="#gstno#" />                   
                </td>
			</tr>
    	</table>
	</div>
	<div>
		<input type="submit" value="#pageAction#" />
		<input type="button" value="#words[96]#" onclick="window.location='/latest/maintenance/addressProfile.cfm'" />
	</div>
</form>
</cfoutput>
</body>
</html>