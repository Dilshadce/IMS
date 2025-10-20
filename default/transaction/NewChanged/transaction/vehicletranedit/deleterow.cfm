
<cfif isdefined('url.refno') and isdefined('url.trancode')>
<cfset url.refno = URLDECODE(url.refno)>
<cfset url.tran = URLDECODE(url.tran)>
<cfquery name="updaterow" datasource="#dts#">
DELETE FROM ictran 
WHERE 
trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#">
and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.tran#"> and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#">
</cfquery>

<cfquery name="checkitemExist" datasource="#dts#">
select 
itemcount 
from ictran 
where type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.tran#"> and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#">
</cfquery>
<cfif checkitemExist.recordcount gt 0>
<cfset itemcountlist = valuelist(checkitemExist.itemcount)>

<cfloop index="i" from="1" to="#listlen(itemcountlist)#">
<cfif listgetat(itemcountlist,i) neq i>
<cfquery name="updateIctran" datasource="#dts#">
	update ictran set 
	itemcount='#i#',
	trancode='#i#'
	where 
	type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.tran#"> and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#">
	and itemcount='#listgetat(itemcountlist,i)#';
</cfquery>
</cfif>
</cfloop>
</cfif>


<cfquery name="getsum" datasource="#dts#">
SELECT SUM(amt1_bil) as sumsubtotal,count(trancode) as notran FROM ictran where type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.tran#"> and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#">
</cfquery>

<cfoutput>
<input type="hidden" name="hidsubtotal" id="hidsubtotal" value="#numberformat(getsum.sumsubtotal,'.__')#" />
<input type="hidden" name="hiditemcount" id="hiditemcount" value="#getsum.notran#" />
</cfoutput>


</cfif>