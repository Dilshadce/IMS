<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1302, 1417, 1418, 688, 1948, 1949, 1950, 1951, 1952, 1953">
<cfinclude template="/latest/words.cfm">
<cfquery name="getgsetup" datasource="#dts#">
	SELECT * 
    FROM gsetup
</cfquery>
<cfset c_Period = getgsetup.Period>

<cfif isdefined("form.lastaccdaterange") and form.lastaccdaterange neq "">
	<cfquery name="getdate" datasource="#dts#">
		SELECT LastAccDate,ThisAccDate 
        FROM icitem_last_year
		WHERE LastAccDate = #form.lastaccdaterange#
		LIMIT 1
	</cfquery>
	<cfset clsyear = year(form.lastaccdaterange)>
	<cfset clsmonth = month(form.lastaccdaterange)>
	<cfset thislastaccdate = form.lastaccdaterange>
	<cfset diffmth= DateDiff("m",getdate.LastAccDate,getdate.ThisAccDate)>
<cfelse>
	<cfset clsyear = year(getgsetup.lastaccyear)>
	<cfset clsmonth = month(getgsetup.lastaccyear)>
	<cfset thislastaccdate = "">
</cfif>

<cfparam name="alown" default="0">

<cfif getpin2.h4700 eq 'T'>
	<cfset alown = 1>
</cfif>

<cfif type eq "fixed">
	<cfset pageTitle = "#words[1948]#">
<cfelseif type eq "month">
	<cfset pageTitle = "#words[1949]#">
<cfelseif type eq "moving">
	<cfset pageTitle = "#words[1950]#">
<cfelseif type eq "fifo">
	<cfset pageTitle = "#words[1951]#">
<cfelseif type eq "lifo">
	<cfset pageTitle = "#words[1952]#">
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

	<cfinclude template="/latest/filter/filterProduct.cfm">

</head>

<body class="container">
<cfoutput>
	<cfform class="formContainer form3Button" name="salesTypeForm" id="salesTypeForm" action="calculatecost.cfm?type=#url.type#" method="post" target="_blank">
		<div>#pageTitle#</div>
        <div>
            <table>
                <input type="hidden" name="thislastaccdate" value="#thislastaccdate#">
                <tr> 
                    <th><label for="product">#words[1302]#</label></th>			
                    <td>
                        <input type="hidden" id="productFrom" name="productFrom" class="productFilter" data-placeholder="#words[1417]#" />
                        <input type="hidden" id="productTo" name="productTo" class="productFilter" placeholder="#words[1418]#" />
                    </td>
                </tr>
                <cfif type eq "moving">
                	<tr>
                        <th><label for="other">By Location</label></th>
                        <td>
                            <div><input type="checkbox" name="cbbylocation" id="cbbylocation" value="yes" <cfif lcase(hcomid) eq "amgworld_i">checked</cfif>>By Location</div>
                        </td>
                    </tr>
                </cfif>
                <cfif type eq "fifo">
                    <tr>
                        <th><label for="other">#words[688]#</label></th>
                        <td>
                            <div><input type="checkbox" name="cbincludecharge" id="cbincludecharge" value="yes">#words[1953]#</div>
                        </td>
                    </tr>
                </cfif>
            </table>
		</div>
        <div>
            <input type="Submit" name="result" id="result" value="HTML"  />
            <input type="Submit" name="result" id="result" value="EXCEL"  />
        </div>
        
    </cfform>
</cfoutput>
</body>
</html>