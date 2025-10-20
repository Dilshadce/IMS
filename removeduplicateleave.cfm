<cfsetting showdebugoutput="true" requesttimeout="0">
<cfoutput>

    <cfquery name="getduplicate" datasource="manpower_i">
        SELECT placementno, COUNT(startdate) AS startlimit, startdate 
        FROM leavelist
        WHERE status = "APPROVED"
        GROUP BY placementno, startdate, enddate, days, status, startampm, endampm
        HAVING COUNT(startdate) > 1
    </cfquery>
    
    <cfloop query="getduplicate">
        <cfquery name="updateleave" datasource="manpower_i">
            UPDATE leavelist SET status = "EXPIRED"
            WHERE placementno = "#getduplicate.placementno#"
            AND status = "APPROVED"
            AND startdate = "#DateFormat(getduplicate.startdate, 'yyyy-mm-dd')#"
            ORDER BY updated_on ASC
            LIMIT #getduplicate.startlimit-1#
        </cfquery>
    </cfloop>
    
</cfoutput>