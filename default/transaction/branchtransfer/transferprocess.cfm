<cfif isdefined('form.transfercode')>

<html>
<head><title>Inter Branck Stock Check / Transfer</title></head>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<body>
<h3>Inter Branch Stock Check / Transfer</h3>
<cfoutput>
<cfquery name="getitem" datasource="#dts#">
SELECT itemno,aitemno,desp,qtybf,unit,category,brand,wos_group,round(coalesce(qtybf,0)-coalesce(remark11,0),4) as weight,unit
<cfloop from="1" to="20" index="a">
,remark#a#
</cfloop> 
FROM icitem 
WHERE
round(coalesce(qtybf,0)-coalesce(remark11,0),4) > 0  
and remark12 <> "Y"
and itemno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.transfercode#" list="yes" separator=",">)
ORDER BY round(coalesce(qtybf,0)-coalesce(remark11,0),4)
</cfquery>
<cfform name="transferconfirm" id="transferconfirm" method="post" action="transferconfirm.cfm" onsubmit="return confirm('Are You Sure You Want To Transfer Below Item To Branch '+document.getElementById('location').value)">
<input type="hidden" name="itemlist" id="itemlist" value="#form.transfercode#">
<table align="center">
<tr>
<th><div align="center">Stock Code</div></th>
<th><div align="center">Desp / remark</div></th>
<th><div align="center">Gold Content</div></th>
<th><div align="center">Weight / Size</div></th>
<th><div align="center">Stone Desc</div></th>
<th><div align="center">CAT / BRAN / GRP</div></th>
<th><div align="center">Location</div></th>
</tr>
<cfloop query="getitem">
<tr>
<td>#getitem.aitemno#</td>
<td>#getitem.desp#<br>#getitem.remark3#</td>
<td>#getitem.remark1#</td>
<td>#getitem.weight# / #getitem.unit#<br>
#getitem.remark10#</td>
<td>#getitem.remark7#<br>#getitem.remark8#<br>#getitem.remark9#</td>
<td>#getitem.category#<br>#getitem.brand#<br>#getitem.wos_group#</td>
<td>#getitem.remark13#</td>
</tr>
</cfloop>
<cfif getitem.recordcount neq 0>
<tr><cfquery name="getlocation" datasource="#dts#">
SELECT location, desp FROM iclocation
</cfquery>
<td colspan="100%" align="center">Transfer To : <select name="location" id="location">
<cfloop query="getlocation">
<option value="#getlocation.location#" <cfif Huserloc eq getlocation.location>selected</cfif>>#getlocation.location# - #getlocation.desp#</option>
</cfloop>
</select><br>
<input type="submit" name="transferbutton" id="transferbutton" value="Confirm Transfer"></td>
</tr>
</cfif>
</table>
</cfform>
</cfoutput>
</body>
</html>
</cfif>