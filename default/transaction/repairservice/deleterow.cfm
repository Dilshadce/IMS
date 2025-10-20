<cfsetting showdebugoutput="no">
<cfif isdefined('url.repairno') and isdefined('url.trancode')>
<cfset url.repairno = URLDECODE(url.repairno)>
<cfquery name="updaterow" datasource="#dts#">
DELETE FROM repairdet 
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#">
and repairno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.repairno#">
</cfquery>

<cfquery name="checkitemExist" datasource="#dts#">
select 
trancode 
from repairdet 
where repairno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.repairno#">
</cfquery>

<cfif checkitemExist.recordcount gt 0>
<cfset itemcountlist = valuelist(checkitemExist.trancode)>

<cfloop index="i" from="1" to="#listlen(itemcountlist)#">
<cfif listgetat(itemcountlist,i) neq i>
<cfquery name="updateIctran" datasource="#dts#">
	update repairdet set 
	trancode='#i#'
	where 
	repairno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.repairno#">
	and trancode='#listgetat(itemcountlist,i)#';
</cfquery>
</cfif>
</cfloop>
</cfif>


<cfquery name="getsum" datasource="#dts#">
SELECT SUM(amt_bil) as sumsubtotal,count(trancode) as notran FROM repairdet where repairno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.repairno#" />
</cfquery>

<cfquery name="addpackage" datasource="#dts#">
update repairtran set grossamt="#numberformat(val(getsum.sumsubtotal),'.__')#" where repairno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#repairno#" />
</cfquery>

<cfoutput>
<input type="hidden" name="hidsubtotal" id="hidsubtotal" value="#numberformat(getsum.sumsubtotal,'.__')#" />
<input type="hidden" name="hiditemcount" id="hiditemcount" value="#getsum.notran#" />
</cfoutput>


</cfif>