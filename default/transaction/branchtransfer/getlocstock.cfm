<cfif isdefined('url.goldcontent')>
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
<cfif URLDECODE(url.category) neq "">
and category = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.category)#">
</cfif>
<cfif URLDECODE(url.brand) neq "">
and brand = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.brand)#">
</cfif>
<cfif URLDECODE(url.group) neq "">
and wos_group = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.group)#">
</cfif>
<cfif URLDECODE(url.weightfrom) neq "">
and round(coalesce(qtybf,0)-coalesce(remark11,0),4) >= <cfqueryparam cfsqltype="cf_sql_varchar" value="#numberformat(URLDECODE(url.weightfrom),'.__')#">
</cfif>
<cfif URLDECODE(url.weightto) neq "">
and round(coalesce(qtybf,0)-coalesce(remark11,0),4) <= <cfqueryparam cfsqltype="cf_sql_varchar" value="#numberformat(URLDECODE(url.weightfrom),'.__')#">
</cfif>
<cfif URLDECODE(url.goldcontent) neq "">
and remark1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.goldcontent)#">
</cfif>
<cfif URLDECODE(url.stonedesc1) neq "">
and remark7 = <cfqueryparam cfsqltype="cf_sql_varchar" value="%#URLDECODE(url.stonedesc1)#%">
</cfif>
<cfif URLDECODE(url.stonedesc2) neq "">
and remark8 = <cfqueryparam cfsqltype="cf_sql_varchar" value="%#URLDECODE(url.stonedesc2)#%">
</cfif>
<cfif URLDECODE(url.stonedesc3) neq "">
and remark9 = <cfqueryparam cfsqltype="cf_sql_varchar" value="%#URLDECODE(url.stonedesc3)#%">
</cfif>
<cfif URLDECODE(url.size) neq "">
and remark10 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.size)#">
</cfif>
<cfif URLDECODE(url.remark) neq "">
and remark3 = <cfqueryparam cfsqltype="cf_sql_varchar" value="%#URLDECODE(url.remark)#%">
</cfif>
<cfif URLDECODE(url.location) neq "">
and remark13 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.location)#">
</cfif>
ORDER BY round(coalesce(qtybf,0)-coalesce(remark11,0),4)
</cfquery>
<input type="hidden" name="itemrecords" id="itemrecords" value="#getitem.recordcount#">
<table align="center">
<tr>
<th><div align="center">Stock Code</div></th>
<th><div align="center">Desp / remark</div></th>
<th><div align="center">Gold Content</div></th>
<th><div align="center">Weight / Size</div></th>
<th><div align="center">Stone Desc</div></th>
<th><div align="center">CAT / BRAN / GRP</div></th>
<th><div align="center">Location</div></th>
<th><div align="center">Transfer</div></th>
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
<td><input type="checkbox" name="transfercode" id="transfercode#getitem.currentrow#" value="#getitem.itemno#"></td>
</tr>
</cfloop>
<cfif getitem.recordcount neq 0>
<tr>
<td colspan="100%" align="center"><input type="submit" name="transferbutton" id="transferbutton" value="Transfer"></td>
</tr>
</cfif>
</table>
</cfoutput>
</cfif>