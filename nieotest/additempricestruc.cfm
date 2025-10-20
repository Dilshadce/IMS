<cfoutput>
<cfquery name="getlist" datasource="#dts#">
    SELECT priceid FROM manpowerpricematrixdetail 
    WHERE itemid='A-17'
    GROUP BY priceid
</cfquery>
    
<cfloop query='getlist'>
    <cfquery name="gettrancode" datasource="#dts#">
        SELECT trancode FROM manpowerpricematrixdetail 
        WHERE priceid='#getlist.priceid#'
        ORDER BY trancode desc
        limit 1
    </cfquery>
    
    <cfquery name="getA17" datasource="#dts#">
        SELECT * FROM manpowerpricematrixdetail 
        WHERE itemid='A-17' and priceid='#getlist.priceid#'
    </cfquery>
    
    <cfquery name="chckexistB17" datasource="#dts#">
        SELECT * FROM manpowerpricematrixdetail 
        WHERE itemid='B-17' and priceid='#getlist.priceid#'
    </cfquery>
    
    <cfif chckexistB17.recordcount eq 0>
        <cfquery name="insertitem" datasource="#dts#">
            INSERT INTO manpowerpricematrixdetail 
            (
            priceid, 
            itemname, 
            trancode, 
            payable, 
            billable,
            payadminfee, 
            billadminfee, 
            created_by, 
            created_on, 
            itemid, 
            payableamt, 
            billableamt, 
            linkto, 
            saf
            )
            values
            (
            "#getlist.priceid#", 
            "#getA17.itemname#", 
            "#gettrancode.trancode+1#", 
            "#getA17.payable#", 
            "#getA17.billable#", 
            "#getA17.payadminfee#", 
            "#getA17.billadminfee#", 
            "ultranieo", 
            now(), 
            "B-17", 
            "#getA17.payableamt#", 
            "#getA17.billableamt#", 
            "#getA17.linkto#", 
            "#getA17.saf#"
            )
        </cfquery>
    </cfif>
</cfloop>

</cfoutput>