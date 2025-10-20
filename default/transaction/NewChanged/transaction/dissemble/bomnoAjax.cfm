<cfsetting showdebugoutput="no">
<cfset url.itemno = URLDECODE(URLDECODE(url.itemno))>

<cfquery name="getbomno" datasource="#dts#">
select bomno from billmat where itemno='#url.itemno#' group by bomno
</cfquery>

<cfoutput>  
<select name="bomno" id="bomno">
			<option value="">Choose an bomno</option>
			<cfloop query="getbomno"><option value="#getbomno.bomno#">#getbomno.bomno#</option></cfloop>
      		</select>
</cfoutput>
