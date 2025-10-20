<cfprocessingdirective pageencoding="UTF-8">
<cfif IsDefined('url.code')>
	<cfset URLaddress = trim(urldecode(url.code))>
</cfif>


<cfif IsDefined("url.action")>
		<cfset pageTitle="Update Invoice Address">
		<cfset pageAction="Save">
		<cfquery name="getAddress" datasource='#dts#'>
            SELECT * 
            FROM invaddress 
            WHERE invnogroup=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLaddress#">;
		</cfquery>
		
		<cfset invnogroup = getAddress.invnogroup>
        <cfset name = getAddress.name>
        <cfset name2 = getAddress.name2>
        <cfset add1 = getAddress.add1>
        <cfset add2 = getAddress.add2>
        <cfset add3 = getAddress.add3>
        <cfset add4 = getAddress.add4>
		<cfset add5 = getAddress.add5>
        <cfset phone = getAddress.phone>
        <cfset fax = getAddress.fax>
        <cfset website = getAddress.website>
        <cfset gstno = getAddress.gstno>
        <cfset comuen = getAddress.comuen>
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
    

    <link rel="stylesheet" href="/latest/css/select2/select2.css" />
    <script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>
</head>

<body class="container">
<cfoutput>
<form class="formContainer form2Button" action="/latest/maintenance/invaddressProcess.cfm?action=#url.action#" method="post" onsubmit="document.getElementById('code').disabled=false";>
	<div>#pageTitle#</div>
	<div>
		<table>
			<tr>
				<th><label for="code">Invoice Group Code</label></th>
				<td>
                	<input type="text" id="code" name="code" required="required" maxlength="25"
                    	<cfif IsDefined("url.action") AND url.action NEQ "create">  value="#URLaddress#"  disabled="true"</cfif>/>
                </td>
			</tr>
			<tr>
				<th><label for="name">Name</label></th>
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
				<th><label for="add1">Address</label></th>
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
				<th></th>
				<td>
                	<input type="text" id="add5" name="add5" value="#add5#" />                   
                </td>
			</tr>
            <tr>
				<th><label for="phone">Phone</label></th>
				<td>
                	<input type="text" id="phone" name="phone" value="#phone#" />                   
                </td>
			</tr>
            <tr>
				<th><label for="fax">Fax</label></th>
				<td>
                	<input type="text" id="fax" name="fax" value="#fax#" />                   
                </td>
			</tr>
            <tr>
				<th><label for="website">Website</label></th>
				<td>
                	<input type="text" id="website" name="website" value="#website#" />                   
                </td>
			</tr>
            <tr>
				<th><label for="gstno">GST No</label></th>
				<td>
                	<input type="text" id="gstno" name="gstno" value="#gstno#" />                   
                </td>
			</tr>
			<tr>
				<th><label for="comuen">Comuen</label></th>
				<td>
                	<input type="text" id="comuen" name="comuen" value="#comuen#" />                   
                </td>
			</tr>
    	</table>
	</div>
	<div>
		<input type="submit" value="#pageAction#" />
		<input type="button" value="Back" onclick="window.location='/latest/maintenance/invaddressProfile.cfm'" />
	</div>
</form>
</cfoutput>
</body>
</html>