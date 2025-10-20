<cfoutput>
<!---this cfm is used to update cn brem6 manually--->
	<cfquery name="groupcn" datasource="manpower_i">
    	select * from ictran where refno between '#url.refno#' and '#url.refno2#'
        group by refno
    </cfquery>
    
    <cfloop query="groupcn">
        <cfquery name="getcn" datasource="manpower_i">
            select  * from ictran where refno = '#groupcn.refno#'
	    order by trancode
        </cfquery>
        
        <cfquery name="getinvoice" datasource="manpower_i">
            select brem6, desp, amt1_bil, refno2, refno, itemno, trancode from manpower_i.ictran
            where refno = '#getcn.refno2#'
            and itemno in ('epf', 'name', 'socso yer') order by itemcount, trancode;
        </cfquery>
        
        <cfset counter = 1>
        <cfloop query="getcn">
        
        <cfquery name="updatecn" datasource="manpower_i">
            update ictran set brem6 = "#getinvoice.brem6[counter]#" where refno = '#getcn.refno#'
            and trancode = #getcn.trancode#
        </cfquery>
        
        <cfset counter += 1>
        
        </cfloop>
	</cfloop>

</cfoutput>