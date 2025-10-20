<cfsetting showdebugoutput="no">

<cfinvoke component="cfc.Date" method="getDbDate" inputDate="#url.datepackfrom#" returnvariable="datefromnew" />
<cfinvoke component="cfc.Date" method="getDbDate" inputDate="#url.datepackto#" returnvariable="datetonew" />

<cfquery name="getPackList" datasource="#dts#">
SELECT * FROM packlist where 
<cfif url.packidfrom neq "">
packid >= <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.packidfrom#"> and
</cfif>
<cfif url.packidto neq "">
packid <= <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.packidto#"> and
</cfif>
<cfif url.datepackfrom neq "">
created_on >= "#datefromnew#" and 
</cfif>
<cfif url.datepackfrom neq "">
created_on <= "#datetonew#" and 
</cfif>

  (driver is null or driver = "") order by created_on 
</cfquery>
<cfoutput>
<table width="800px">
<cfloop query="getPackList">
<tr>
<td width="100">#getPackList.packID#</td>
<cfif getPackList.Created_on lt getPackList.updated_on >
<cfset datepacked = getPackList.updated_on>
<cfelse>
<cfset datepacked = getPackList.Created_on>
</cfif>
<td width="150">#datepacked#</td>
<cfif getPackList.updated_by neq "">
<cfset packedby = getPackList.updated_by>
<cfelse>
<cfset packedby = getPackList.created_by>
</cfif>
<td width="150">#packedby#</td>
<td width="100"><input type="checkbox" name="packID" id="packID" value="#getPackList.packID#"  /></td>
</tr>
</cfloop>
<tr><td colspan="4">&nbsp;</td></tr>
<tr><td colspan="4" align="center"><input type="submit" name="SUBMIT" id="SUBMIT" value="ASSIGN"  /></td></tr>
</table>

</cfoutput>