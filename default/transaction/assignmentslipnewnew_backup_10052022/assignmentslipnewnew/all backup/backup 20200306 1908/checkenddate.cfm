<cfoutput>

<cfset ended = 0>
    
<cfquery name="getplacement" datasource="#dts#">
    SELECT completedate FROM placement 
    WHERE placementno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.pno#">
</cfquery>
    
<cfset newenddate = createdate(listlast(UrlDecode(url.enddate),'/'),listgetat(urlDecode(url.enddate),2,'/'),listfirst(urlDecode(url.enddate),'/'))>
    
<cfif getplacement.completedate lt newenddate>
    <cfset ended = 1>
</cfif>
    
<input type="hidden" name="checkenddate" id="checkenddate" value="#ended#">
    
</cfoutput>