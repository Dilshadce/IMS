<cfsetting showdebugoutput="no">
<cfset itemno=urldecode(itemno)>

<cfquery name="getbomno" datasource="#dts#">
	SELECT * FROM billmat where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#"> GROUP BY bomno
</cfquery>

<cfoutput>
<select name="bomno" id="bomno">
	<cfif getbomno.recordcount eq 0>
    <option value="">Choose a Bom No.</option>
    </cfif>
    <cfloop query="getbomno">
    <option value="#getbomno.bomno#">#getbomno.bomno#</option>
    </cfloop>
</select>
</cfoutput>