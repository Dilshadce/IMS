<cfsetting showdebugoutput="no">
<cfif isdefined('url.packcode') and isdefined('url.trancode')>
<cfset url.packcode = URLDECODE(url.packcode)>
<cfquery name="updaterow" datasource="#dts#">
DELETE FROM packdet 
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#">
and packcode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.packcode#">
</cfquery>

<cfquery name="checkitemExist" datasource="#dts#">
select 
trancode 
from packdet 
where packcode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.packcode#">
</cfquery>

<cfif checkitemExist.recordcount gt 0>
<cfset itemcountlist = valuelist(checkitemExist.trancode)>

<cfloop index="i" from="1" to="#listlen(itemcountlist)#">
<cfif listgetat(itemcountlist,i) neq i>
<cfquery name="updateIctran" datasource="#dts#">
	update packdet set 
	trancode='#i#'
	where 
	packcode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.packcode#">
	and trancode='#listgetat(itemcountlist,i)#';
</cfquery>
</cfif>
</cfloop>
</cfif>


<cfquery name="getsum" datasource="#dts#">
SELECT SUM(amt_bil) as sumsubtotal,count(trancode) as notran FROM packdet where packcode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.packcode#" />
</cfquery>

<cfquery name="addpackage" datasource="#dts#">
update package set grossamt="#numberformat(val(getsum.sumsubtotal),'.__')#" where packcode=<cfqueryparam cfsqltype="cf_sql_varchar" value="#packcode#" />
</cfquery>

<cfoutput>
<input type="hidden" name="hidsubtotal" id="hidsubtotal" value="#numberformat(getsum.sumsubtotal,'.__')#" />
<input type="hidden" name="hiditemcount" id="hiditemcount" value="#getsum.notran#" />
</cfoutput>


</cfif>