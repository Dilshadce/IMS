<cfsetting showdebugoutput="true" requesttimeout="0">
<cfoutput>
    
    <cfquery name="gettimesheet" datasource="#dts#">
        SELECT * FROM #Replace(dts, '_i', '_p')#.timesheet a
        LEFT JOIN placement b ON a.placementno = b.placementno
        LEFT JOIN icsizeid c on b.ottable = c.sizeid
        WHERE 1=1 and b.custno = '300029218'
        and a.updated_on = '0000-00-00 00:00:00'
	    <!---AND a.empno = '100082317'--->
        AND tmonth = 3 AND tyear = "2018"
    </cfquery>

    <cfloop query="gettimesheet">
    
        <cfset othourpoint = "0">
        <cfset minothourpoint = "0">
        <cfset maxothourpoint = "0">
        <cfset roundothourpoint = "0">
        <cfset worknow = "0.00">
        <cfset otnow = "0.00">
        <cfset hournow = "0.00">
        <cfset stcollist = "WD,OD,RD,PH">
        <cfif "#Val(Left(gettimesheet.endtime, 2))#" LT "#Val(Left(gettimesheet.starttime, 2))#" 
              AND ('#gettimesheet.endtime#' NEQ '00:00:00' AND '#gettimesheet.starttime#' NEQ '00:00:00') >
            <cfset hourtime = "#Abs(datediff('h', '2018-01-02 #gettimesheet.endtime#', '2018-01-01 #gettimesheet.starttime#'))#">
            <cfset mintime = NumberFormat((#Val(datediff('n', '2018-01-02 #gettimesheet.endtime#', '2018-01-01 #gettimesheet.starttime#'))#-#val(hourtime*60)#)/60, '.__')>
        <cfelse>
            <cfset hourtime = "#Abs(datediff('h', gettimesheet.starttime, gettimesheet.endtime))#">
            <cfset mintime = NumberFormat((#Val(datediff('n', gettimesheet.starttime, gettimesheet.endtime))#-#val(hourtime*60)#)/60, '.__')>
        </cfif>
        
        <cfset timebreak = "#gettimesheet.breaktime#">
        <cfset worknow = #Abs(NumberFormat(#Val(hourtime)#+#Val(mintime)#, '.__'))#-#Val(timebreak)#>
        <cfset daytype = "WD">
        <cfif gettimesheet.stcol eq "RD" or gettimesheet.stcol eq "OD" or gettimesheet.stcol eq "PH">
            <cfset daytype = gettimesheet.stcol>
        </cfif>

        <cfif "#ListFind(stcollist, '#daytype#', ',')#" NEQ 0>
            <cfloop from="1" to="8" index="ee">
                <cfif val(evaluate('gettimesheet.#daytype#OT#ee#')) neq 0>
                    <cfset othourpoint = "#val(evaluate('gettimesheet.#daytype#OT#ee#'))#">
                    <cfbreak>
                </cfif>
            </cfloop>
            <cfset minothourpoint = "#val(evaluate('gettimesheet.#daytype#MINOT'))#">
            <cfset maxothourpoint = "#val(evaluate('gettimesheet.#daytype#MAXOT'))#">
            <cfset roundothourpoint = "#val(evaluate('gettimesheet.#daytype#ROUNDUP'))#">
        </cfif>

        <cfif "#othourpoint#" EQ "-1">

            <cfset otnow = #Abs(NumberFormat(#Val(hourtime)#+#Val(mintime)#, '.__'))#-#Val(timebreak)#>

            <cfif "#minothourpoint#" NEQ 0 OR "#maxothourpoint#" NEQ 0 OR "#roundothourpoint#" NEQ 0>
                <cfif "#roundothourpoint#" NEQ 0 AND otnow GTE #val(roundothourpoint)#>
                    <cfset otnow = #Round(val(otnow))#>
                </cfif>

                <cfif "#minothourpoint#" NEQ 0 AND otnow LT minothourpoint>
                    <cfset otnow = 0.00>    
                </cfif>

                <cfif "#maxothourpoint#" NEQ 0 AND otnow GTE maxothourpoint>
                    <cfset otnow = "#NumberFormat(val(maxothourpoint), '.__')#">
                </cfif>
            </cfif>

            <!---<cfset othour = "#Val(otnow)#">--->
            <cfset worknow = "0.00">
        <cfelse>
            <cfif "#othourpoint#" NEQ 0>
                <cfset hournow = #Abs(NumberFormat(#Val(hourtime)#+#Val(mintime)#, '.__'))#-#Val(timebreak)#>

                <cfif #val(hournow)# GT #val(othourpoint)#>  
                    <cfset otnow = #NumberFormat(Val(hournow)-Val(othourpoint), '.__')#>
 
                    <cfif "#minothourpoint#" NEQ 0 OR "#maxothourpoint#" NEQ 0 OR "#roundothourpoint#" NEQ 0>
                        <cfif "#roundothourpoint#" NEQ 0 AND otnow GTE #val(roundothourpoint)#>
                            <cfset otnow = #Round(val(otnow))#>
                        </cfif>

                        <cfif "#minothourpoint#" NEQ 0 AND otnow LT minothourpoint>
                            <cfset otnow = 0.00>    
                        </cfif>

                        <cfif "#maxothourpoint#" NEQ 0 AND otnow GTE maxothourpoint>
                            <cfset otnow = "#NumberFormat(val(maxothourpoint), '.__')#">
                        </cfif>
                    </cfif>

                    <!---<cfset othour = "#Val(otnow)#">--->
                    <cfset worknow = "#val(othourpoint)#">
                <cfelse>
                    <cfset otnow = "0.00">
                </cfif>
            <cfelse>
                <cfset otnow = "0.00">
            </cfif>
        </cfif>
    


        <cfif val(otnow) neq 0>

            <cfloop from="1" to="8" index="a">
                <cfset "ot#a#val" = 0>
            </cfloop>

            <cfset totalothour = val(otnow)>

            <cfloop from="1" to="8" index="a">
                <cfif totalothour gte 0>
                    <cfif evaluate('gettimesheet.#daytype#OT#a#') neq 0>
                        <cfset currentothour = totalothour>

                        <cfif a neq 8>
                            <cfloop from="#a+1#" to="8" index="i">
                                <cfif evaluate('gettimesheet.#daytype#OT#i#') neq 0>
                                    <cfset rate1 = evaluate('gettimesheet.#daytype#OT#i#')>
                                    <cfset rate2 = evaluate('gettimesheet.#daytype#OT#a#')>

                                    <cfif rate1 lt 0>
                                        <cfset rate1 = 0>
                                    </cfif>
                                    <cfif rate2 lt 0>
                                        <cfset rate2 = 0>
                                    </cfif>

                                    <cfset otallowhour = NUMBERFORMAT(ROUND((rate1 - rate2)*100)/100,'.__')>

                                    <cfif otallowhour gt 0 and otallowhour gte  NUMBERFORMAT(totalothour,'.__')>
                                        <cfset currentothour = totalothour>
                                        <cfset totalothour = 0>
                                    <cfelseif otallowhour gt 0>
                                        <cfset currentothour = otallowhour>
                                        <cfset totalothour = totalothour - otallowhour> 
                                    </cfif>

                                    <cfbreak>  
                                </cfif>
                            </cfloop>
                        </cfif>

                        <cfset "ot#a#val" = numberformat(ROUND(currentothour*100)/100,'.__')>
                    </cfif>
                </cfif>
            </cfloop>

            <cfquery name="updateot" datasource="#Replace(dts, '_i', '_p')#">
                UPDATE timesheet 
                SET
                <cfloop from="1" to="8" index="c">
                    ot#c# = "#numberformat(evaluate('ot#c#val'),'.__')#"<cfif c neq 8>,</cfif>
                </cfloop>
                , workhours = "#NumberFormat(worknow, '.__')#"
                , othour = "#NumberFormat(otnow, '.__')#"
                WHERE id = "#gettimesheet.id#" 
            </cfquery>  
        <cfelse>
            <cfquery name="updateot" datasource="#Replace(dts, '_i', '_p')#">
                UPDATE timesheet 
                SET
                <cfloop from="1" to="8" index="c">
                    ot#c# = "0.00"<cfif c neq 8>,</cfif>
                </cfloop>
                , workhours = "#NumberFormat(worknow, '.__')#"
                , othour = "#NumberFormat(otnow, '.__')#"
                WHERE id = "#gettimesheet.id#" 
            </cfquery>  
        </cfif>

    </cfloop>
</cfoutput>