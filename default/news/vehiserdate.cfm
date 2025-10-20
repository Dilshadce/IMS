<cfsetting showdebugoutput="no">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="news.css" rel="stylesheet" type="text/css" />
<title>Untitled Document</title>
</head>

<script type='text/javascript' src='/ajax/core/engine.js'></script>
<script type='text/javascript' src='/ajax/core/util.js'></script>
<script type='text/javascript' src='/ajax/core/settings.js'></script>
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="/scripts/CalendarControl.js"></script>
<script type="text/javascript" src="/scripts/prototypenew.js" ></script>
<cfoutput>
<body>

<cfquery name="getnewitem" datasource="#dts#">
    select *
    from vehicles
    order by nextserdate
    limit 10
    </cfquery>

<font style="text-transform:uppercase">Next Service Date From</font>&nbsp;<input type="text" name="serdatefrom" size="8" id="serdatefrom" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'/default/news/vehiserdateajax.cfm?serdatefrom='+escape(document.getElementById('serdatefrom').value)+'&serdateto='+escape(document.getElementById('serdateto').value));"/>
&nbsp;TO:&nbsp;<input type="text" name="serdateto" id="serdateto" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'/default/news/vehiserdateajax.cfm?serdatefrom='+escape(document.getElementById('serdatefrom').value)+'&serdateto='+escape(document.getElementById('serdateto').value));" size="12" /> <input type="button" name="Searchbtn" value="Go" >
Kindly key in DD/MM/YYYY for Date
    <div id="loading" style="visibility:hidden">
    <div class="loading-indicator">
    Loading....
    </div>
    </div>
    <div id="ajaxField" name="ajaxField">
<table class="tcontent" width="600">
<tr>
<td class="tabletitle1">Next Vehicle Service Date</td>
<td class="tabletitle1" >Vehicle No</td>
<td class="tabletitle1" >Contact</td>
<td class="tabletitle1" >Phone No 1</td>
<td class="tabletitle1" >Phone No 2</td>
<td class="tabletitle1" >Next Service Mil</td>
<td class="tabletitle1" >Last Service Date</td>
<td class="tabletitle1" >Next Service Date</td>
</tr>

    
    <cfloop query="getnewitem">
    	<tr class="tablecontentrow1">
        <td class="tablecontent1" nowarp><cfif isdate(nextserdate)>#dateformat(nextserdate,'DD/MM/YYYY')#</cfif></td>
        <td class="tablecontent1" nowarp>#entryno#</td>
        <td class="tablecontent1" nowarp>#contactperson#</td>
        <td class="tablecontent1" nowarp>#phone#</td>
        <td class="tablecontent1" nowarp>#hp#</td>
        <td class="tablecontent1" nowarp>#nextmileage#</td>
        <td class="tablecontent1" nowarp><cfif isdate(lastserdate)>#dateformat(lastserdate,"dd/mm/yyyy")#</cfif></td>
        <td class="tablecontent1" nowarp><cfif isdate(nextserdate)>#dateformat(nextserdate,"dd/mm/yyyy")#</cfif></td>
        </tr>
    </cfloop>
    
</table>
</div>

</body>
</cfoutput>
</html>
