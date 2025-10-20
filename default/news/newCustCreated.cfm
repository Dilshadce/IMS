<cfsetting showdebugoutput="no">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="news.css" rel="stylesheet" type="text/css" />
<title>New Customer</title>
</head>

<body>
<table class="tcontent">
<tr>
<td class="tabletitle1">Customer No.</td>
<td class="tabletitle1">Customer Name</td>
<td class="tabletitle1">Created On</td>
</tr>

<cfoutput>
    <cfquery name="getnewitem" datasource="#dts#">
    select custno,name, created_on
    from #target_arcust#
    order by created_on desc
    limit 10
    </cfquery>
    <cfloop query="getnewitem">
    	<tr class="tablecontentrow1">
        <td class="tablecontent1" nowarp>#custno#</td>
        <td class="tablecontent1" nowarp>#name#</td>
        <td class="tablecontent1" nowarp>#dateformat(created_on,"dd/mm/yyyy")#</td>
        </tr>
    </cfloop>
    
</cfoutput>

</table>

</body>
</html>
