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
<td class="tabletitle1" width="100px">Ref No.</td>
<td class="tabletitle1" width="200px">Customer No.</td>
<td class="tabletitle1" width="200px">Vehicle No.</td>
<td class="tabletitle1" width="200px"><div align="right">Amount</div></td>
</tr>

<cfoutput>
    <cfquery name="gettodaysale" datasource="#dts#">
    select refno, custno,grand,rem5, created_on
    from artran
    where wos_date='#dateformat(now(),'yyyy-mm-dd')#' and type='INV'
    order by refno
    </cfquery>
    <cfloop query="gettodaysale">
    	<tr class="tablecontentrow1">
        <td class="tablecontent1" width="100px">#refno#</td>
        <td class="tablecontent1" width="200px">#custno#</td>
        <td class="tablecontent1" width="200px">#rem5#</td>
        <td class="tablecontent1" width="200px"><div align="right">#numberformat(grand,',_.__')#</div></td>
        </tr>
    </cfloop>
    
</cfoutput>

</table>

</body>
</html>
