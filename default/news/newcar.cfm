<cfsetting showdebugoutput="no">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="news.css" rel="stylesheet" type="text/css" />
<title>Untitled Document</title>
</head>

<body>
<table class="tcontent">
<tr>
<td class="tabletitle1" >Vehicle No.</td>
<td class="tabletitle1" >Customer</td>
<td class="tabletitle1" >Created On</td>
</tr>

<cfoutput>
    <cfquery name="getnewcar" datasource="#dts#">
    select entryno, custcode,custname, created_on
    from vehicles
    order by created_on desc
    limit 20
    </cfquery>
    <cfloop query="getnewcar">
    	<tr class="tablecontentrow1">
        <td class="tablecontent1" nowarp>#entryno#</td>
        <td class="tablecontent1" nowarp>#custcode# - #custname#</td>
        <td class="tablecontent1" nowarp>#dateformat(created_on,"dd/mm/yyyy")# #timeformat(created_on,'HH:MM')#</td>
        </tr>
    </cfloop>
    
</cfoutput>

</table>

</body>
</html>
