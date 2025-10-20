<cfif #IsDefined('url.empno')# AND #IsDefined('url.ottable')#>
    <cfloop list="#url.empno#" index="listempno">
        <cfquery name="gettimesheet" datasource="manpower_p">
            SELECT * FROM 
            (
                SELECT * FROM timesheet 
                WHERE empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#listempno#"> 
                AND tyear = "2018"
                AND tmonth = "3"
                ORDER BY pdate
            ) AS sort
            GROUP by pdate	
        </cfquery>

        <cfquery name="getottable" datasource="manpower_i">
            SELECT * FROM icsizeid WHERE sizeid = "#url.ottable#"
        </cfquery>

        <Cfif getottable.recordcount neq 0>
            <cfloop query="gettimesheet">

                <cfif val(gettimesheet.othour) neq 0>

                    <cfloop from="1" to="8" index="a">
                        <cfset "ot#a#val" = 0>
                    </cfloop>

                    <cfset totalothour = val(gettimesheet.othour)>
                    <cfset daytype = "WD">
                    <cfif gettimesheet.stcol eq "RD" or gettimesheet.stcol eq "OD" or gettimesheet.stcol eq "PH">
                        <cfset daytype = gettimesheet.stcol>
                    </cfif>

                    <cfloop from="1" to="8" index="a">
                        <cfif totalothour gte 0>
                            <cfif evaluate('getottable.#daytype#OT#a#') neq 0>
                                <cfset currentothour = totalothour>

                                <cfif a neq 8>
                                    <cfloop from="#a+1#" to="8" index="i">
                                        <cfif evaluate('getottable.#daytype#OT#i#') neq 0>
                                            <cfset rate1 = evaluate('getottable.#daytype#OT#i#')>
                                            <cfset rate2 = evaluate('getottable.#daytype#OT#a#')>

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


                    <cfquery name="updateot" datasource="manpower_p">
                        UPDATE timesheet 
                        SET
                        <cfloop from="1" to="8" index="c">
                            ot#c# = "#numberformat(evaluate('ot#c#val'),'.__')#"<cfif c neq 8>,</cfif>
                        </cfloop>
                        <cfif "#IsDefined('url.minuswh')#" AND "#url.minuswh#" EQ 'Y'>
                            , workhours = workhours - othour
                        </cfif>
                        <cfif "#IsDefined('url.statusc')#" AND "#url.statusc#" EQ 'Y'>
                            , status = 'Submitted For Approval'
                        </cfif>
                        WHERE id = "#gettimesheet.id#" 
                    </cfquery>  
                <cfelse>
                    <cfquery name="updateot" datasource="manpower_p">
                        UPDATE timesheet 
                        SET
                        <cfloop from="1" to="8" index="c">
                            ot#c# = "0.00"<cfif c neq 8>,</cfif>
                        </cfloop>
                        <cfif "#IsDefined('url.minuswh')#" AND "#url.minuswh#" EQ 'Y'>
                            , workhours = workhours - othour
                        </cfif>
                        <cfif "#IsDefined('url.statusc')#" AND "#url.statusc#" EQ 'Y'>
                            , status = 'Submitted For Approval'
                        </cfif>
                        WHERE id = "#gettimesheet.id#" 
                    </cfquery>  
                </cfif>

            </cfloop>
        </Cfif>
    </cfloop>
</cfif>