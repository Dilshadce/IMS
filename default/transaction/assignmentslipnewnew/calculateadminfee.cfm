<cfoutput>
    
<cfset HcomID=replace(HcomID,'_i','','all')>    
<cfset paydts=replace(dts,'_i','_p','all')>
<cfset weekpay = url.emppaymenttype>
    
<cfquery name="gqry" datasource="payroll_main">
SELECT mmonth,myear from gsetup where comp_id = '#HcomID#'
</cfquery>
    
<cfquery name="getpaydata" datasource="#paydts#">
SELECT * FROM #weekpay# WHERE empno = "#url.empno#"
</cfquery>

<cfquery name="getplacement" datasource="#dts#">
SELECT * FROM placement WHERE placementno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.placement#">
</cfquery>

<cfset calculateadminfee = 0>
<cfset RATEYER = val(getplacement.employer_rate_1)>
<cfset RATEYEE = val(getplacement.employee_rate_1)>
<cfset BASIC = val(url.basicsalary)>
<cfset SALARY = val(url.basicsalary)>
<cfset BASICPAY = val(url.basicsalary)>
<cfset BASIC = BASIC + val(url.nplamt)>
<cfset BASICPAY = BASICPAY + val(url.nplamt)>
<cfset EPFYEE = val(getpaydata.epfww)>
<cfset EPFYER = val(url.custepf)>
<cfset SOCSOYEE = val(getpaydata.socsoww)>
<cfset SOCSOYER = val(url.custsocso)>
<cfset EISYEE = val(getpaydata.eisww)>
<cfset EISYER = val(url.custeis)>
<cfset EPF_TOTAL = val(EPFYEE + url.custepf)>
<cfset SOCSO_TOTAL = val(val(SOCSOYEE) + val(url.custsocso))>
<cfset OT1 = val(url.custot1)>
<cfset OT15 = val(url.custot2)>
<cfset OT2 = val(url.custot3)>
<cfset OT3 = val(url.custot4)>
<cfset OT5 = val(url.custot5)>
<cfset OT6 = val(url.custot6)>
<cfset OT7 = val(url.custot7)>
<cfset OT8 = val(url.custot8)>
    
<!---Special for HRDF calculation--->
<cfset SELFSALARY = val(url.basicsalary_yee)>
<!---Special for HRDF calculation--->

<cfset AW_TOTAL = val(getpaydata.taw)>
<cfset OT_TOTAL = val(getpaydata.otpay)>
<cfset GROSSPAY = val(getpaydata.grosspay)>
<cfset NETPAY = val(getpaydata.netpay)>
<cfset NPL = val(url.nplamt)>
<cfset TOTALNPL = val(url.nplyeeamt)>
    
<!---Special for HRDF calculation--->
<cfset customtotalfixaw = val(url.specialfixawamt)>
<cfset totalhrdf = 0>
<!---Special for HRDF calculation--->

<cfif basicpay lte 4000 and grosspay neq 0>
    <cfset SOCSO_OT = numberformat(SOCSOYER*OT_TOTAL/grosspay,'.__')>
<cfelse>
    <cfset SOCSO_OT = 0>
</cfif>

<cfset totalfixaw = 0>
<cfset totalvaraw = 0>
    
<cfif findnocase('venture',getplacement.custname)>
    <cfquery name="getassignment" datasource="#dts#">
        SELECT * FROM assignmentslip 
        WHERE empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getplacement.empno#">
        AND payrollperiod = #gqry.mmonth#
        AND emppaymenttype <> <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.emppaymenttype#">
    </cfquery>

    <cfset db = paydts>
        
    <cfquery name="socaw" datasource="#db#">
    SELECT * FROM awtable where AW_HRD = 1 AND AW_COU<18 ORDER BY AW_cou 
    </cfquery>

    <cfquery name="socded" datasource="#db#">
    SELECT * FROM dedtable where DED_HRD = 1  ORDER BY ded_cou 
    </cfquery>

    <!--Prepare EPF and SOCSO Wage for SAF calculation (Added by Nieo 20181005 1041)--->
    <cfloop query="getassignment">
        <cfquery name="getepfwageother" datasource="#db#">
        SELECT epf_pay_a,epfcc,socsocc,eiscc FROM #getassignment.emppaymenttype#
        WHERE empno = "#getassignment.empno#"
        </cfquery>

        <cfset url.epfpayin =val(url.epfpayin) + val(getepfwageother.epf_pay_a)>
            
        <cfset EPFYER = val(EPFYER) + val(getepfwageother.epfcc)>
        <cfset SOCSOYER = val(SOCSOYER) + val(getepfwageother.socsocc)>
        <cfset EISYER = val(EISYER) + val(getepfwageother.eiscc)>

        <!---<cfquery name="totalsocso" datasource="#db#">
            SELECT (coalesce(basicpay,0)+coalesce(otpay,0)
            <cfloop query="socaw">
            +coalesce(aw#100+socaw.aw_cou#,0)
            </cfloop>
            <cfloop query="socded">
            -coalesce(ded#100+socded.ded_cou#,0)
            </cfloop>) as socsowage
            FROM #getassignment.emppaymenttype#
            WHERE empno = "#getassignment.empno#"
        </cfquery>

        <cfset url.socsopayin =val(url.socsopayin) + val(totalsocso.socsowage)>--->
    </cfloop>
    <!--Prepare EPF and SOCSO Wage for SAF calculation (Added by Nieo 20181005 1041)--->
            
    <!---<cfquery name="getTotalStatutoryER" datasource="#db#">
        SELECT epfcc,socsocc,eiscc FROM pay_tm
        WHERE empno = "#getassignment.empno#"
    </cfquery>
            
            
    <cfset EPFYER = val(getTotalStatutoryER.epfcc)>
    <cfset SOCSOYER = val(getTotalStatutoryER.socsocc)>
    <cfset EISYER = val(getTotalStatutoryER.eiscc)>--->
</cfif>
    
<table>
    <tr>

        <th>Item</th>
        <th>Amount</th>
        <th>Admin Fee</th>

    </tr>
    <cfif getplacement.pm neq "">
        <cfquery name="getpm" datasource="#dts#">
        SELECT * FROM manpowerpricematrixdetail WHERE priceid = "#getplacement.pm#" ORDER BY billadminfee
        </cfquery>

        <cfquery name="checkadminfeitem" datasource="#dts#">
        SELECT * FROM manpowerpricematrixdetail WHERE priceid = "#getplacement.pm#" and itemid = "adminfee"
        </cfquery>

        <cfloop query="getpm">
            <cfif getpm.saf eq "Y">
                <cfset epfrecalculate = 1>
                    
                <cfquery name="getpm" datasource="#dts#">
                SELECT * FROM manpowerpricematrixdetail WHERE priceid = "#getplacement.pm#" and itemid not in ('EPFYER','SOCSOYER','EISYER') ORDER BY billadminfee
                </cfquery>
                    
                <cfbreak>
            </cfif>
        </cfloop>

        <cfquery name="getitemlist" datasource="#dts#">
        SELECT itemno FROM icitem WHERE itemno <> "adminfee"
        </cfquery>
            
        <cfloop query="getpm">
            
            <cfif listfindnocase(valuelist(getitemlist.itemno),getpm.itemid)>
                <cfloop list="pay,bill" index="a">
                <cfif evaluate('getpm.#a#able') eq "Y" and evaluate('getpm.#a#adminfee') neq "">
                    <cfif findnocase('%',evaluate('getpm.#a#adminfee'))>
                        <cfset calculateadminfee = calculateadminfee + val((val(evaluate('#getpm.itemid#')) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))>
                        <tr>
                        <td>#getpm.itemname#</td>
                        <td>#val(evaluate('#getpm.itemid#'))#</td>
                        <td>#val((val(evaluate('#getpm.itemid#')) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))#</td>
                        </tr>
                    <cfelseif left(evaluate('getpm.#a#adminfee'),1) eq "=">
                        <cfset con = evaluate('getpm.#a#adminfee')>
                        <cfset con = right(con,len(con)-1)>
                        <cfset con = Replace(con,"<="," lte ","all") >
                        <cfset con = Replace(con,">="," gte ","all") >
                        <cfset con = Replace(con,">"," gt ","all") >
                        <cfset con = Replace(con,"<"," lt ","all") >
                        <cfset con = Replace(con,"!="," neq ","all") >
                        <cfset con = Replace(con,"="," eq ","all") >

                        <cfset calculateadminfee = calculateadminfee + val(evaluate(con))>

                        <tr>
                        <td>#getpm.itemname#</td>
                        <td>#val(evaluate('#getpm.itemid#'))#</td>
                        <td>#val(evaluate(con))#</td>
                        </tr>

                    <cfelse>

                        <cfset calculateadminfee = calculateadminfee + val(evaluate('getpm.#a#adminfee'))>

                        <tr>
                        <td>#getpm.itemname#</td>
                        <td>#val(evaluate('#getpm.itemid#'))#</td>
                        <td>#val(evaluate('getpm.#a#adminfee'))#</td>
                        </tr>

                    </cfif>
                </cfif>
                </cfloop>

             <cfelseif left(getpm.itemid,2) eq "B-">
        <cfset "B#replace(getpm.itemid,'B-','')#" = 0>
              <cfloop from="1" to="6" index="bb">
                <!---Special for HRDF--->
                <cfif evaluate('url.billitem#bb#') eq replace(getpm.itemid,'B-','') and replace(getpm.itemid,'B-','') eq '136' and evaluate('getpm.billable') eq "Y" and evaluate('getpm.billableamt') neq "">
                    <cfset "B#replace(getpm.itemid,'B-','')#" = numberformat(evaluate(replace(getpm.billableamt,'=','')),'.__')>
                    <cfset totalhrdf = numberformat(evaluate(replace(getpm.billableamt,'=','')),'.__')>
                </cfif>
                <!---Special for HRDF--->
                        
                <cfif evaluate('url.billitem#bb#') eq replace(getpm.itemid,'B-','') and val(evaluate('url.billitemamt#bb#')) neq 0>
                    <cfset "B#replace(getpm.itemid,'B-','')#" = val(evaluate('url.billitemamt#bb#'))>
                        
                    <cfloop list="bill" index="a">
                <cfif evaluate('getpm.#a#able') eq "Y" and evaluate('getpm.#a#adminfee') neq "">
                    <cfif findnocase('%',evaluate('getpm.#a#adminfee'))>

                        <cfset calculateadminfee = calculateadminfee + val((val(evaluate('B#replace(getpm.itemid,'B-','')#')) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))>

                        <tr>
                        <td>#getpm.itemname#</td>
                        <td>#val(evaluate('B#replace(getpm.itemid,'B-','')#'))#</td>
                        <td>#val((val(evaluate('B#replace(getpm.itemid,'B-','')#')) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))#</td>
                        </tr>

                    <cfelseif left(evaluate('getpm.#a#adminfee'),1) eq "=">
                        <cfset con = evaluate('getpm.#a#adminfee')>
                        <cfset con = right(con,len(con)-1)>
                        <cfset con = Replace(con,"<="," lte ","all") >
                        <cfset con = Replace(con,">="," gte ","all") >
                        <cfset con = Replace(con,">"," gt ","all") >
                        <cfset con = Replace(con,"<"," lt ","all") >
                        <cfset con = Replace(con,"!="," neq ","all") >
                        <cfset con = Replace(con,"="," eq ","all") >

                        <cfset calculateadminfee = calculateadminfee + val(evaluate(con))>  

                        <tr>
                        <td>#getpm.itemname#</td>
                        <td>#val(evaluate('B#replace(getpm.itemid,'B-','')#'))#</td>
                        <td>#val(evaluate(con))#</td>
                        </tr>

                    <cfelse>

                        <cfset calculateadminfee = calculateadminfee + val(evaluate('getpm.#a#adminfee'))>

                        <tr>
                        <td>#getpm.itemname#</td>
                        <td>#val(evaluate('B#replace(getpm.itemid,'B-','')#'))#</td>
                        <td>#val(evaluate('getpm.#a#adminfee'))#</td>
                        </tr>

                    </cfif>
                </cfif>
                </cfloop>


                </cfif>
              </cfloop>
             <cfelseif left(getpm.itemid,2) eq "A-" or getpm.itemid eq "ALLAWEXC">



             <cfif getpm.itemid eq "ALLAWEXC">

              <cfset excludeaw = "0,">
             <cfquery name="getpmdetails" datasource="#dts#">
        SELECT * FROM manpowerpricematrixdetail WHERE priceid = "#getplacement.pm#" ORDER BY billadminfee
        </cfquery>
             <cfloop query="getpmdetails">
             <!---<cfif left(getpmdetails.itemid,2) eq "A-" and (getpmdetails.billadminfee eq "0%" or getpmdetails.billadminfee eq "0")>--->
            <cfif left(getpmdetails.itemid,2) eq "A-">
             <cfset excludeaw=excludeaw&replace(getpmdetails.itemid,'A-','')&",">
             </cfif>
             </cfloop>

             <cfset awexc = 0>

             <cfloop from="1" to="6" index="aa">
                <cfif listfindnocase(excludeaw,evaluate('url.fixawcode#aa#')) eq false>

                    <cfloop list="pay,bill" index="a">
                    <cfif a eq "pay">
                    <cfset awexc = val(evaluate('url.fixawee#aa#'))>
                    <cfelse>
                    <cfset awexc = val(evaluate('url.fixawer#aa#'))>
                    <cfset totalfixaw =  totalfixaw + val(evaluate('url.fixawer#aa#'))>
                    </cfif>
                <cfif evaluate('getpm.#a#able') eq "Y" and evaluate('getpm.#a#adminfee') neq "">
                    <cfquery name="getname" datasource="#dts#">
                    select * from icshelf where shelf = "#evaluate('url.fixawcode#aa#')#"
                    </cfquery>

                    <cfif findnocase('%',evaluate('getpm.#a#adminfee'))>


                        <cfset calculateadminfee = calculateadminfee + val((val(awexc) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))>

                        <cfif numberformat((val(awexc) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100),'.__') gt 0>

                         <tr>
                        <td>#getname.desp#</td>
                        <td>#val(awexc)#</td>
                        <td>#val((val(awexc) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))#</td>
                        </tr>
                        </cfif>


                    <cfelseif left(evaluate('getpm.#a#adminfee'),1) eq "=">
                        <cfset con = evaluate('getpm.#a#adminfee')>
                        <cfset con = right(con,len(con)-1)>
                        <cfset con = Replace(con,"<="," lte ","all") >
                        <cfset con = Replace(con,">="," gte ","all") >
                        <cfset con = Replace(con,">"," gt ","all") >
                        <cfset con = Replace(con,"<"," lt ","all") >
                        <cfset con = Replace(con,"!="," neq ","all") >
                        <cfset con = Replace(con,"="," eq ","all") >

                        <cfset calculateadminfee = calculateadminfee + val(evaluate(con))>

                        <cfif numberformat(evaluate(con),'.__') gt 0>

                         <tr>
                        <td>#getname.desp#</td>
                        <td>#val(awexc)#</td>
                        <td>#val(evaluate(con))#</td>
                        </tr>
                        </cfif>

                    <cfelse>


                        <cfset calculateadminfee = calculateadminfee + val(evaluate('getpm.#a#adminfee'))>

                        <cfif val(evaluate('getpm.#a#adminfee')) gt 0>

                         <tr>
                        <td>#getname.desp#</td>
                        <td>#val(awexc)#</td>
                        <td>#val(evaluate('getpm.#a#adminfee'))#</td>
                        </tr>
                        </cfif>

                    </cfif>
                </cfif>
                </cfloop>


                </cfif>
              </cfloop>

              <cfset awexc = 0>
              <cfloop from="1" to="18" index="aa">
                <cfif listfindnocase(excludeaw,evaluate('url.allowance#aa#')) eq false>

                    <cfloop list="pay,bill" index="a">
                    <cfif a eq "pay">
                    <cfset awexc = val(evaluate('url.awee#aa#'))>
                    <cfelse>
                    <cfset awexc = val(evaluate('url.awer#aa#'))>
                    <cfset totalvaraw =  totalvaraw + val(evaluate('url.awer#aa#'))>
                    </cfif>
                <cfif evaluate('getpm.#a#able') eq "Y" and evaluate('getpm.#a#adminfee') neq "">
                    <cfquery name="getname" datasource="#dts#">
                    select * from icshelf where shelf = "#evaluate('url.allowance#aa#')#"
                    </cfquery>
                    <cfif findnocase('%',evaluate('getpm.#a#adminfee'))>


                        <cfset calculateadminfee = calculateadminfee + val((val(awexc) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))>

                        <cfif numberformat((val(awexc) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100),'.__') gt 0>

                         <tr>
                        <td>#getname.desp#</td>
                        <td>#val(awexc)#</td>
                        <td>#val((val(awexc) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))#</td>
                        </tr>
                        </cfif>


                    <cfelseif left(evaluate('getpm.#a#adminfee'),1) eq "=">
                        <cfset con = evaluate('getpm.#a#adminfee')>
                        <cfset con = right(con,len(con)-1)>
                        <cfset con = Replace(con,"<="," lte ","all") >
                        <cfset con = Replace(con,">="," gte ","all") >
                        <cfset con = Replace(con,">"," gt ","all") >
                        <cfset con = Replace(con,"<"," lt ","all") >
                        <cfset con = Replace(con,"!="," neq ","all") >
                        <cfset con = Replace(con,"="," eq ","all") >

                        <cfset calculateadminfee = calculateadminfee + val(evaluate(con))>

                        <cfif numberformat(evaluate(con),'.__') gt 0>

                         <tr>
                        <td>#getname.desp#</td>
                        <td>#val(awexc)#</td>
                        <td>#numberformat(evaluate(con),'.__')#</td>
                        </tr>
                        </cfif>


                    <cfelse>

                            <cfset calculateadminfee = calculateadminfee + val(evaluate('getpm.#a#adminfee'))>

                            <cfif val(evaluate('getpm.#a#adminfee')) gt 0>

                             <tr>
                            <td>#getname.desp#</td>
                            <td>#val(awexc)#</td>
                            <td>#val(evaluate('getpm.#a#adminfee'))#</td>
                            </tr>
                            </cfif>

                    </cfif>
                </cfif>
                </cfloop>


                </cfif>
              </cfloop>


             <cfelse>

             <cfset "A#replacenocase(getpm.itemid,'A-','')#" = 0>
             <cfset "totalA#replacenocase(getpm.itemid,'A-','')#" = 0>
                <cfloop from="1" to="6" index="aa">
                <cfif evaluate('url.fixawcode#aa#') eq replace(getpm.itemid,'A-','') and (val(evaluate('url.fixawer#aa#')) neq 0 or val(evaluate('url.fixawee#aa#')) neq 0)>

                    <cfloop list="pay,bill" index="a">
                    <cfif a eq "pay">
                    <cfset "A#replacenocase(getpm.itemid,'A-','')#" = val(evaluate('url.fixawee#aa#'))>
                    <cfelse>
                    <cfset "A#replacenocase(getpm.itemid,'A-','')#" = val(evaluate('url.fixawer#aa#'))>
                    <cfset "totalA#replacenocase(getpm.itemid,'A-','')#" = evaluate("totalA#replacenocase(getpm.itemid,'A-','')#")+val(evaluate('url.fixawer#aa#'))>
                    <cfset totalfixaw =  totalfixaw + val(evaluate('url.fixawer#aa#'))>
                    </cfif>
                <cfif evaluate('getpm.#a#able') eq "Y" and evaluate('getpm.#a#adminfee') neq "">
                    <cfif findnocase('%',evaluate('getpm.#a#adminfee'))>


                        <cfset calculateadminfee = calculateadminfee + val((val(evaluate('A#replace(getpm.itemid,'A-','')#')) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))>

                         <tr>
                        <td>#getpm.itemname#</td>
                        <td>#val(evaluate('A#replace(getpm.itemid,'A-','')#'))#</td>
                        <td>#val((val(evaluate('A#replace(getpm.itemid,'A-','')#')) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))#</td>
                        </tr>


                    <cfelseif left(evaluate('getpm.#a#adminfee'),1) eq "=">
                        <cfset con = evaluate('getpm.#a#adminfee')>
                        <cfset con = right(con,len(con)-1)>
                        <cfset con = Replace(con,"<="," lte ","all") >
                        <cfset con = Replace(con,">="," gte ","all") >
                        <cfset con = Replace(con,">"," gt ","all") >
                        <cfset con = Replace(con,"<"," lt ","all") >
                        <cfset con = Replace(con,"!="," neq ","all") >
                        <cfset con = Replace(con,"="," eq ","all") >


                        <cfset calculateadminfee = calculateadminfee + val(evaluate(con))>

                         <tr>
                        <td>#getpm.itemname#</td>
                        <td>#val(evaluate('A#replace(getpm.itemid,'A-','')#'))#</td>
                        <td>#val(evaluate(con))#</td>
                        </tr>


                    <cfelse>


                        <cfset calculateadminfee = calculateadminfee + val(evaluate('getpm.#a#adminfee'))>

                        <tr>
                        <td>#getpm.itemname#</td>
                        <td>#val(evaluate('A#replace(getpm.itemid,'A-','')#'))#</td>
                        <td>#val(evaluate('getpm.#a#adminfee'))#</td>
                        </tr>


                    </cfif>
                </cfif>
                </cfloop>


                </cfif>
              </cfloop>

              <cfloop from="1" to="18" index="aa">
                <cfif evaluate('url.allowance#aa#') eq replace(getpm.itemid,'A-','') and (val(evaluate('url.awer#aa#')) neq 0 or val(evaluate('url.awee#aa#')) neq 0)>

                    <cfloop list="pay,bill" index="a">
                    <cfif a eq "pay">
                    <cfset "A#replacenocase(getpm.itemid,'A-','')#" = val(evaluate('url.awee#aa#'))>
                    <cfelse>
                    <cfset "A#replacenocase(getpm.itemid,'A-','')#" = val(evaluate('url.awer#aa#'))>
                     <cfset "totalA#replacenocase(getpm.itemid,'A-','')#" = evaluate("totalA#replacenocase(getpm.itemid,'A-','')#")+val(evaluate('url.awer#aa#'))>
                    <cfset totalvaraw =  totalvaraw + val(evaluate('url.awer#aa#'))>
                    </cfif>
                <cfif evaluate('getpm.#a#able') eq "Y" and evaluate('getpm.#a#adminfee') neq "">
                    <cfif findnocase('%',evaluate('getpm.#a#adminfee'))>


                        <cfset calculateadminfee = calculateadminfee + val((val(evaluate('A#replace(getpm.itemid,'A-','')#')) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))>

                        <tr>
                        <td>#getpm.itemname#</td>
                        <td>#val(evaluate('A#replace(getpm.itemid,'A-','')#'))#</td>
                        <td>#val((val(evaluate('A#replace(getpm.itemid,'A-','')#')) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))#</td>
                        </tr>


                    <cfelseif left(evaluate('getpm.#a#adminfee'),1) eq "=">
                        <cfset con = evaluate('getpm.#a#adminfee')>
                        <cfset con = right(con,len(con)-1)>
                        <cfset con = Replace(con,"<="," lte ","all") >
                        <cfset con = Replace(con,">="," gte ","all") >
                        <cfset con = Replace(con,">"," gt ","all") >
                        <cfset con = Replace(con,"<"," lt ","all") >
                        <cfset con = Replace(con,"!="," neq ","all") >
                        <cfset con = Replace(con,"="," eq ","all") >


                        <cfset calculateadminfee = calculateadminfee + val(evaluate(con))>

                        <tr>
                        <td>#getpm.itemname#</td>
                        <td>#val(evaluate('A#replace(getpm.itemid,'A-','')#'))#</td>
                        <td>#val(evaluate(con))#</td>
                        </tr>


                    <cfelse>


                        <cfset calculateadminfee = calculateadminfee + val(evaluate('getpm.#a#adminfee'))>


                         <tr>
                        <td>#getpm.itemname#</td>
                        <td>#val(evaluate('A#replace(getpm.itemid,'A-','')#'))#</td>
                        <td>#val(evaluate('getpm.#a#adminfee'))#</td>
                        </tr>


                    </cfif>
                </cfif>
                </cfloop>   
                </cfif>

              </cfloop>
              </cfif>
               <cfelseif getpm.itemid eq "ADMINFEE">

               <cfloop index="a" from="1" to="6">
               <cfset totalfixaw =  totalfixaw + val(evaluate('url.fixawer#a#'))>
               </cfloop>               

               <cfloop index="aa" from="1" to="18">
               <cfset totalvaraw =  totalvaraw + val(evaluate('url.awer#aa#'))>
               </cfloop>

               <cfif grosspay neq 0>
                <cfset EPF_FIXAW = numberformat(EPFYER*TOTALFIXAW/grosspay,'.__')>
                <cfset EPF_VARAW = numberformat(EPFYER*TOTALVARAW/grosspay,'.__')>
                <cfelse>
                <cfset EPF_FIXAW = 0>
                <cfset EPF_VARAW = 0>
                </cfif>
                <cfif basicpay lte 4000 and grosspay neq 0>
                <cfset SOCSO_FIXAW = numberformat(SOCSOYER*TOTALFIXAW/grosspay,'.__')>
                <cfset SOCSO_VARAW = numberformat(SOCSOYER*TOTALVARAW/grosspay,'.__')>
                <cfelse>
                <cfset SOCSO_FIXAW = 0>
                <cfset SOCSO_VARAW = 0>
                </cfif>
                    
                <cfif basicpay lte 4000 and grosspay neq 0>
                <cfset EIS_FIXAW = numberformat(EISYER*TOTALFIXAW/grosspay,'.__')>
                <cfset EIS_VARAW = numberformat(EISYER*TOTALVARAW/grosspay,'.__')>
                <cfelse>
                <cfset EIS_FIXAW = 0>
                <cfset EIS_VARAW = 0>
                </cfif>

        <cfloop list="bill" index="a">
                <cfif evaluate('getpm.#a#able') eq "Y" and evaluate('getpm.#a#adminfee') neq "">
                    <cfif findnocase('%',evaluate('getpm.#a#adminfee'))>
                    <cfset calculateadminfee = calculateadminfee + val((val(BASIC) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))>
                     <tr>
                    <td>#getpm.itemname#*</td>
                    <td>#val(BASIC)#</td>
                    <td>#val((val(BASIC) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))#</td>
                    </tr>

                    <cfelseif left(evaluate('getpm.#a#adminfee'),1) eq "=">

                    <cfset con = evaluate('getpm.#a#adminfee')>
                    <cfset con = right(con,len(con)-1)>
                    <cfset con = Replace(con,"<="," lte ","all") >
                    <cfset con = Replace(con,">="," gte ","all") >
                    <cfset con = Replace(con,">"," gt ","all") >
                    <cfset con = Replace(con,"<"," lt ","all") >
                    <cfset con = Replace(con,"!="," neq ","all") >
                    <cfset con = Replace(con,"="," eq ","all") >


                    <cfset calculateadminfee = calculateadminfee + val(evaluate(con))>
                      <tr>
                    <td>#getpm.itemname#**</td>
                    <td>#val(BASIC)#</td>
                    <td>#val(evaluate(con))#</td>
                    </tr>

                    <cfelse>
                    <cfset calculateadminfee = calculateadminfee + val(evaluate('getpm.#a#adminfee'))>
                     <tr>
                    <td>#getpm.itemname#***</td>
                    <td>#val(BASIC)#</td>
                    <td>#val(evaluate('getpm.#a#adminfee'))#</td>
                    </tr>

                    </cfif>
                </cfif>
                </cfloop>

            </cfif>
        </cfloop>
            
        <cfif isdefined('epfrecalculate') and (val(url.epfpayin) neq 0 or val(socsopayin) neq 0) and checkadminfeitem.recordcount eq 0>
            <cfset totalepf = EPFYER>
			<cfset totaleis = EISYER>
            <cfset totalsocso = SOCSOYER>
            <cfset socsoremain = socsopayin>
            <cfset eisremain = socsopayin>
            <cfif socsoremain gt 3900>
                <cfset socsopayin = 3900.01>
			</cfif>
            <cfset socsoremain = socsoremain - BASIC>
            <cfset eisremain = eisremain - BASIC>
            
            <cfquery name="getpmsafaw" datasource="#dts#">
            SELECT * FROM manpowerpricematrixdetail WHERE priceid = "#getplacement.pm#" AND saf = "Y" and left(itemid,2) = "A-" AND billadminfee LIKE '%\%%' and billable = "Y"  ORDER BY billadminfee
            </cfquery>
            
            <cfif getpmsafaw.recordcount neq 0>
            <cfloop query="getpmsafaw">
                <cfquery name="checkable" datasource="#dts#">
                SELECT desp,allowance FROM icshelf 
                WHERE 
                shelf = "#replace(getpmsafaw.itemid,'A-','')#"
                </cfquery>
            	<cfif checkable.recordcount neq 0 and val(checkable.allowance) neq 0>
                <cfquery name="checkdetails" datasource="#replace(dts,'_i','_p')#">
                SELECT aw_epf,aw_hrd FROM awtable WHERE aw_cou = "#val(checkable.allowance)#"
                </cfquery>
                <cfif checkdetails.aw_epf eq 1 and isdefined('totalA#replace(getpmsafaw.itemid,'A-','')#') and val(url.epfpayin) neq 0>
                	<cfset awamt = val(evaluate('totalA#replace(getpmsafaw.itemid,'A-','')#'))>
                    <cfset calculateadminfee = calculateadminfee + val(numberformat(((awamt/val(url.epfpayin)) * EPFYER),'.__') * (replacenocase(getpmsafaw.billadminfee,'%','')/100))>
                     <tr>
                         <td>#getpmsafaw.itemname# EPF</td>
                         <td>(#awamt#/#val(url.epfpayin)#)* #EPFYER# = #numberformat(((awamt/val(url.epfpayin)) * EPFYER),'.__')#</td>                        
                         <td>#val(numberformat(((awamt/val(url.epfpayin)) * EPFYER),'.__') * (replacenocase(getpmsafaw.billadminfee,'%','')/100))#</td>
                        </tr>
                 
                    <cfset totalepf = totalepf - numberformat(((awamt/val(url.epfpayin)) * EPFYER),'.__')> 
				</cfif>
                 <cfif checkdetails.aw_hrd eq 1 and isdefined('totalA#replace(getpmsafaw.itemid,'A-','')#') and val(url.socsopayin) neq 0 and socsoremain gt 0>
                	<cfset awamt = val(evaluate('totalA#replace(getpmsafaw.itemid,'A-','')#'))>
                    
                    <cfset calculateadminfee = calculateadminfee + val(numberformat(((awamt/val(url.socsopayin)) * SOCSOYER),'.__') * (replacenocase(getpmsafaw.billadminfee,'%','')/100))>
                     <tr>
                        <td>#getpmsafaw.itemname# SOCSO</td>
                        <td>(#awamt#/#val(url.socsopayin)#)* #SOCSOYER# = #numberformat(((awamt/val(url.socsopayin)) * SOCSOYER),'.__')#</td>
                        <td>#val(numberformat(((awamt/val(url.socsopayin)) * SOCSOYER),'.__') * (replacenocase(getpmsafaw.billadminfee,'%','')/100))#</td>
                        </tr>                     
                    
                    <cfset totalsocso = totalsocso - numberformat(((awamt/val(url.socsopayin)) * SOCSOYER),'.__')>
                    <cfif socsoremain lt awamt>
                    <cfset awamt = socsoremain>
					</cfif>
                    <cfset socsoremain = SOCSOREMAIN - awamt>
				</cfif>
                        
                <!---Added by Nieo 20180119 1017, EIS added--->
                <cfif checkdetails.aw_hrd eq 1 and isdefined('totalA#replace(getpmsafaw.itemid,'A-','')#') and val(url.socsopayin) neq 0 and eisremain gt 0>
                	<cfset awamt = val(evaluate('totalA#replace(getpmsafaw.itemid,'A-','')#'))>
                    
                    <cfset calculateadminfee = calculateadminfee + val(numberformat(((awamt/val(url.socsopayin)) * EISYER),'.__') * (replacenocase(getpmsafaw.billadminfee,'%','')/100))>
                     <tr>
                        <td>#getpmsafaw.itemname# EIS</td>
                         <td>(#awamt#/#val(url.socsopayin)#)* #EISYER# = #numberformat(((awamt/val(url.socsopayin)) * EISYER),'.__')#</td>
                        <td>#val(numberformat(((awamt/val(url.socsopayin)) * EISYER),'.__') * (replacenocase(getpmsafaw.billadminfee,'%','')/100))#</td>
                        </tr>
                        
                    <cfset totaleis = val(totaleis) - numberformat(((awamt/val(url.socsopayin)) * totaleis),'.__')>
                    <cfif eisremain lt awamt>
                    <cfset awamt = eisremain>
					</cfif>
                    <cfset eisremain = eisremain - awamt>
				</cfif>
                <!---Added by Nieo 20180119 1017, EIS added--->
                
				</cfif>
                
            </cfloop>
			</cfif>
 
            <cfquery name="getpmsafexc" datasource="#dts#">
            SELECT * FROM manpowerpricematrixdetail WHERE priceid = "#getplacement.pm#" AND saf = "Y" and itemid = "ALLAWEXC" AND billadminfee LIKE '%\%%'  and billable = "Y"  ORDER BY billadminfee
            </cfquery>
            
            
            <cfif getpmsafexc.recordcount neq 0> 
                 <cfset awexc = 0>
                 
                 <cfloop from="1" to="6" index="aa">
                  	<cfif listfindnocase(excludeaw,evaluate('url.fixawcode#aa#')) eq false>
                       <cfset awexc = val(evaluate('url.fixawer#aa#'))>
                        <cfquery name="checkable" datasource="#dts#">
                        SELECT desp,allowance FROM icshelf 
                        WHERE 
                        shelf = "#evaluate('url.fixawcode#aa#')#"
                        </cfquery>
                        <cfif checkable.recordcount neq 0 and val(checkable.allowance) neq 0>
                        <cfquery name="checkdetails" datasource="#replace(dts,'_i','_p')#">
                        SELECT aw_epf,aw_hrd FROM awtable WHERE aw_cou = "#val(checkable.allowance)#"
                        </cfquery>
                        <cfif checkdetails.aw_epf eq 1 and awexc neq 0 and val(url.epfpayin) neq 0>
                            <cfset awamt = awexc>
                            <cfset calculateadminfee = calculateadminfee + val(numberformat(((awamt/val(url.epfpayin)) * EPFYER),'.__') * (replacenocase(getpmsafexc.billadminfee,'%','')/100))>
                            <tr>
                            <td>#checkable.desp# EPF</td>
                            <td>(#awamt#/#val(url.epfpayin)#)* #EPFYER# = #numberformat(((awamt/val(url.epfpayin)) * EPFYER),'.__')#</td>
                            <td>#val(numberformat(((awamt/val(url.epfpayin)) * EPFYER),'.__') * (replacenocase(getpmsafexc.billadminfee,'%','')/100))#</td>
                            </tr>
                                
                            <cfset totalepf = totalepf - numberformat(((awamt/val(url.epfpayin)) * EPFYER),'.__')>
                        </cfif>
                         <cfif checkdetails.aw_hrd eq 1 and awexc neq 0 and val(url.socsopayin) neq 0 and socsoremain gt 0>
                            <cfset awamt = awexc>
                            <cfif socsoremain lt awamt>
							<cfset awamt = socsoremain>
                            </cfif>
                            <cfset socsoremain = SOCSOREMAIN - awamt>
                            <cfset calculateadminfee = calculateadminfee + val(numberformat(((awamt/val(url.socsopayin)) * SOCSOYER),'.__') * (replacenocase(getpmsafexc.billadminfee,'%','')/100))>
                            <tr>
                            <td>#checkable.desp# SOCSO</td>
                            <td>(#awamt#/#val(url.socsopayin)#)* #SOCSOYER# = #numberformat(((awamt/val(url.socsopayin)) * SOCSOYER),'.__')#</td>
                            <td>#val(numberformat(((awamt/val(url.socsopayin)) * SOCSOYER),'.__') * (replacenocase(getpmsafexc.billadminfee,'%','')/100))#</td>
                            </tr>
                                
                            <cfset totalsocso = totalsocso - numberformat(((awamt/val(url.socsopayin)) * SOCSOYER),'.__')>
                        </cfif>
                                
                        <!---Added by Nieo 20180119 1017, EIS added--->
                        <cfif checkdetails.aw_hrd eq 1 and awexc neq 0 and val(url.socsopayin) neq 0 and eisremain gt 0>
                            <cfset awamt = awexc>
                            <cfif eisremain lt awamt>
							<cfset awamt = eisremain>
                            </cfif>
                            <cfset eisremain = eisremain - awamt>
                            <cfset calculateadminfee = calculateadminfee + val(numberformat(((awamt/val(url.socsopayin)) * EISYER),'.__') * (replacenocase(getpmsafexc.billadminfee,'%','')/100))>
                            <tr>
                            <td>#checkable.desp# EIS</td>
                            <td>(#awamt#/#val(url.socsopayin)#)* #EISYER# = #numberformat(((awamt/val(url.socsopayin)) * EISYER),'.__')#</td>
                            <td>#val(numberformat(((awamt/val(url.socsopayin)) * EISYER),'.__') * (replacenocase(getpmsafexc.billadminfee,'%','')/100))#</td>
                            </tr>
                                
                            <cfset totaleis = val(totaleis) - numberformat(((awamt/val(url.socsopayin)) * EISYER),'.__')>
                        </cfif>
                        <!---Added by Nieo 20180119 1017, EIS added--->
                        
                        </cfif>
                        </cfif>
                    </cfloop>
                    
                    <cfloop from="1" to="18" index="aa">
                  	<cfif listfindnocase(excludeaw,evaluate('url.allowance#aa#')) eq false>
                    	<cfset awexc = val(evaluate('url.awer#aa#'))>
                        <cfquery name="checkable" datasource="#dts#">
                        SELECT desp,allowance FROM icshelf 
                        WHERE 
                        shelf = "#evaluate('url.allowance#aa#')#"
                        </cfquery>
                        <cfif checkable.recordcount neq 0 and val(checkable.allowance) neq 0>
                        <cfquery name="checkdetails" datasource="#replace(dts,'_i','_p')#">
                        SELECT aw_epf,aw_hrd FROM awtable WHERE aw_cou = "#val(checkable.allowance)#"
                        </cfquery>
                        <cfif checkdetails.aw_epf eq 1 and awexc neq 0 and val(url.epfpayin) neq 0>
                            <cfset awamt = awexc>
                            <cfset calculateadminfee = calculateadminfee + val(numberformat(((awamt/val(url.epfpayin)) * EPFYER),'.__') * (replacenocase(getpmsafexc.billadminfee,'%','')/100))>
                              <tr>
                            <td>#checkable.desp# EPF</td>
                            <td>(#awamt#/#val(url.epfpayin)#)* #EPFYER# = #numberformat(((awamt/val(url.epfpayin)) * EPFYER),'.__')#</td>
                            <td>#val(numberformat(((awamt/val(url.epfpayin)) * EPFYER),'.__') * (replacenocase(getpmsafexc.billadminfee,'%','')/100))#</td>
                            </tr>
                                
                            <cfset totalepf = totalepf - numberformat(((awamt/val(url.epfpayin)) * EPFYER),'.__')>
                        </cfif>
                         <cfif checkdetails.aw_hrd eq 1 and awexc neq 0 and val(url.socsopayin) neq 0 and socsoremain gt 0>
                            <cfset awamt = awexc>
                            <cfif socsoremain lt awamt>
							<cfset awamt = socsoremain>
                            </cfif>
                            <cfset socsoremain = SOCSOREMAIN - awamt>
                            <cfset calculateadminfee = calculateadminfee + val(numberformat(((awamt/val(url.socsopayin)) * SOCSOYER),'.__') * (replacenocase(getpmsafexc.billadminfee,'%','')/100))>
                            <tr>
                            <td>#checkable.desp# SOCSO</td>
                            <td>(#awamt#/#val(url.socsopayin)#)* #SOCSOYER# = #numberformat(((awamt/val(url.socsopayin)) * SOCSOYER),'.__')#</td>
                            <td>#val(numberformat(((awamt/val(url.socsopayin)) * SOCSOYER),'.__') * (replacenocase(getpmsafexc.billadminfee,'%','')/100))#</td>
                            </tr>
                                
                            <cfset totalsocso = totalsocso - numberformat(((awamt/val(url.socsopayin)) * SOCSOYER),'.__')>
                        </cfif>
                                
                        <!---Added by Nieo 20180119 1017, EIS added--->
                        <cfif checkdetails.aw_hrd eq 1 and awexc neq 0 and val(url.socsopayin) neq 0 and eisremain gt 0>
                            <cfset awamt = awexc>
                            <cfif eisremain lt awamt>
							<cfset awamt = eisremain>
                            </cfif>
                            <cfset eisremain = eisremain - awamt>
                            <cfset calculateadminfee = calculateadminfee + val(numberformat(((awamt/val(url.socsopayin)) * EISYER),'.__') * (replacenocase(getpmsafexc.billadminfee,'%','')/100))>
                            <tr>
                            <td>#checkable.desp# EIS</td>
                            <td>(#awamt#/#val(url.socsopayin)#)* #EISYER# = #numberformat(((awamt/val(url.socsopayin)) * EISYER),'.__')#</td>
                            <td>#val(numberformat(((awamt/val(url.socsopayin)) * EISYER),'.__') * (replacenocase(getpmsafexc.billadminfee,'%','')/100))#</td>
                            </tr>
                                
                            <cfset totaleis = val(totaleis) - numberformat(((awamt/val(url.socsopayin)) * EISYER),'.__')>
                        </cfif>
                        <!---Added by Nieo 20180119 1017, EIS added--->
                        
                        </cfif>
                        
                       </cfif>
                	</cfloop>
                        
                        
					</cfif>

            <cfquery name="getpmsafOT" datasource="#dts#">
            SELECT * FROM manpowerpricematrixdetail WHERE priceid = "#getplacement.pm#" AND saf = "Y" and left(itemid,2) = "OT" AND billadminfee LIKE '%\%%'  and billable = "Y"  ORDER BY billadminfee
            </cfquery>
            
            <cfif getpmsafOT.recordcount neq 0>
            <cfloop query="getpmsafOT"> 

                 <cfif val(evaluate('#getpmsafOT.itemid#')) neq 0 and val(url.socsopayin) neq 0 and socsoremain gt 0>
                 <cfset otamt = val(evaluate('#getpmsafOT.itemid#'))>
                <cfif socsoremain lt otamt>
				<cfset otamt = socsoremain>
                </cfif>
                 <cfset socsoremain = SOCSOREMAIN - otamt>
                 
                    <cfset calculateadminfee = calculateadminfee + val(numberformat((val(otamt/val(url.socsopayin))* SOCSOYER),'.__') * (replacenocase(getpmsafOT.billadminfee,'%','')/100))>
                    <tr>
                        <td>#getpmsafOT.itemname# SOCSO</td>
                        <td>(#val(otamt)#/#val(url.socsopayin)#)* #SOCSOYER# = #numberformat(((val(otamt)/val(url.socsopayin)) * SOCSOYER),'.__')#</td>
                        <td>#val(numberformat((val(otamt/val(url.socsopayin))* SOCSOYER),'.__') * (replacenocase(getpmsafOT.billadminfee,'%','')/100))#</td>
                        </tr>
                        
                    <cfset totalsocso = totalsocso - numberformat(val((otamt/val(url.socsopayin)) * SOCSOYER),'.__')>
				</cfif>   
                      
                <!---Added by Nieo 20180119 1017, EIS added--->
                <cfif val(evaluate('#getpmsafOT.itemid#')) neq 0 and val(url.socsopayin) neq 0 and eisremain gt 0>
                 <cfset otamt = val(evaluate('#getpmsafOT.itemid#'))>
                <cfif eisremain lt otamt>
				<cfset otamt = eisremain>
                </cfif>
                 <cfset eisremain = eisremain - otamt>
                 
                    <cfset calculateadminfee = calculateadminfee + val(numberformat((val(otamt/val(url.socsopayin))* EISYER),'.__') * (replacenocase(getpmsafOT.billadminfee,'%','')/100))>
                    <tr>
                        <td>#getpmsafOT.itemname# EIS</td>
                        <td>(#val(otamt)#/#val(url.socsopayin)#)* #EISYER# = #numberformat(((val(otamt)/val(url.socsopayin)) * EISYER),'.__')#</td>
                        <td>#val(numberformat((val(otamt/val(url.socsopayin))* EISYER),'.__') * (replacenocase(getpmsafOT.billadminfee,'%','')/100))#</td>
                        </tr>
                        
                    <cfset totaleis = val(totaleis) - numberformat(val((otamt/val(url.socsopayin)) * EISYER),'.__')>
				</cfif>
                <!---Added by Nieo 20180119 1017, EIS added--->
                        
            </cfloop>
			</cfif>   
            
            
            <cfquery name="getpmepf" datasource="#dts#">
            SELECT * FROM manpowerpricematrixdetail WHERE priceid = "#getplacement.pm#"  and itemid = 'EPFYER' ORDER BY billadminfee
            </cfquery>
            
            <cfif getpmepf.recordcount neq 0>
                <!---<cfif getpmepf.saf neq 'Y'>--->
                    <cfset epfyer = totalepf>
                <!---</cfif>--->
            <cfloop list="pay,bill" index="a">
                	<cfif evaluate('getpmepf.#a#able') eq "Y" and evaluate('getpmepf.#a#adminfee') neq "">
						<cfif findnocase('%',evaluate('getpmepf.#a#adminfee'))>
                        <cfset calculateadminfee = calculateadminfee + val((val(trim(evaluate('#getpmepf.itemid#'))) * replacenocase(evaluate('getpmepf.#a#adminfee'),'%','')/100))>
                        <tr>
                        <td>#getpmepf.itemname#</td>
                        <td>#val(evaluate('#getpmepf.itemid#'))#</td>
                        <td>#val((val(evaluate('#getpmepf.itemid#')) * replacenocase(trim(evaluate('getpmepf.#a#adminfee')),'%','')/100))#</td>
                        </tr>
                            
                        <cfelseif left(evaluate('getpmepf.#a#adminfee'),1) eq "=">
                        <cfset con = evaluate('getpmepf.#a#adminfee')>
                        <cfset con = right(con,len(con)-1)>
						<cfset con = Replace(con,"<="," lte ","all") >
				        <cfset con = Replace(con,">="," gte ","all") >
				        <cfset con = Replace(con,">"," gt ","all") >
				        <cfset con = Replace(con,"<"," lt ","all") >
						<cfset con = Replace(con,"!="," neq ","all") >
				        <cfset con = Replace(con,"="," eq ","all") >
                      
                        <cfset calculateadminfee = calculateadminfee + val(evaluate(con))>
                        <tr>
                        <td>#getpmepf.itemname#</td>
                        <td>#val(evaluate('#getpmepf.itemid#'))#</td>
                        <td>#val(evaluate(con))#</td>
                        </tr>
                            
                        <cfelse>
                        <cfset calculateadminfee = calculateadminfee + val(evaluate('getpmepf.#a#adminfee'))>
                        <tr>
                        <td>#getpmepf.itemname#</td>
                        <td>#val(evaluate('#getpmepf.itemid#'))#</td>
                        <td>#val(evaluate('getpmepf.#a#adminfee'))#</td>
                        </tr>
                        
                        </cfif>
                    </cfif>
              </cfloop>
              </cfif>
            
            <cfquery name="getpmsocso" datasource="#dts#">
            SELECT * FROM manpowerpricematrixdetail WHERE priceid = "#getplacement.pm#"  and itemid = 'SOCSOYER' ORDER BY billadminfee
            </cfquery>
            
            <cfif getpmepf.recordcount neq 0>
            <cfset socsoyer = totalsocso>
            <cfloop list="pay,bill" index="a">
                	<cfif evaluate('getpmsocso.#a#able') eq "Y" and evaluate('getpmsocso.#a#adminfee') neq "">
						<cfif findnocase('%',evaluate('getpmsocso.#a#adminfee'))>
						<cfif numberformat((val(evaluate('#getpmsocso.itemid#')) * replacenocase(evaluate('getpmsocso.#a#adminfee'),'%','')/100),'.__') gte 0.00>
                        <cfset calculateadminfee = calculateadminfee + val((val(trim(evaluate('#getpmsocso.itemid#'))) * replacenocase(evaluate('getpmsocso.#a#adminfee'),'%','')/100))>
						</cfif>			
                         <tr>
                        <td>#getpmsocso.itemname#</td>
                        <td>
						<cfif val(evaluate('#getpmsocso.itemid#')) gte 0.00>
						#val(evaluate('#getpmsocso.itemid#'))#
						<cfelse>
						0.00
						</cfif>
						</td>
                        <td>
						<cfif numberformat((val(evaluate('#getpmsocso.itemid#')) * replacenocase(evaluate('getpmsocso.#a#adminfee'),'%','')/100),'.__') gte 0.00>
						#val((val(evaluate('#getpmsocso.itemid#')) * replacenocase(trim(evaluate('getpmsocso.#a#adminfee')),'%','')/100))#
						<cfelse>
						0.00
						</cfif>
						</td>
                        </tr>
                            
                        <cfelseif left(evaluate('getpmsocso.#a#adminfee'),1) eq "=">
                        <cfset con = evaluate('getpmsocso.#a#adminfee')>
                        <cfset con = right(con,len(con)-1)>
						<cfset con = Replace(con,"<="," lte ","all") >
				        <cfset con = Replace(con,">="," gte ","all") >
				        <cfset con = Replace(con,">"," gt ","all") >
				        <cfset con = Replace(con,"<"," lt ","all") >
						<cfset con = Replace(con,"!="," neq ","all") >
				        <cfset con = Replace(con,"="," eq ","all") >
                        
                        <cfset calculateadminfee = calculateadminfee + val(evaluate(con))>
                        <tr>
                        <td>#getpmsocso.itemname#</td>
                        <td>#val(evaluate('#getpmsocso.itemid#'))#</td>
                        <td>#val(evaluate(con))#</td>
                        </tr>
                            
                        <cfelse>
                        <cfset calculateadminfee = calculateadminfee + val(evaluate('getpmsocso.#a#adminfee'))>
                        <tr>
                        <td>#getpmsocso.itemname#</td>
                        <td>#val(evaluate('#getpmsocso.itemid#'))#</td>
                        <td>#val(evaluate('getpmsocso.#a#adminfee'))#</td>
                        </tr>
                        </cfif>
                    </cfif>
              </cfloop>
              </cfif>
                      
            <!---Added by Nieo 20180118, EIS added--->
            <cfquery name="getpmeis" datasource="#dts#">
            SELECT * FROM manpowerpricematrixdetail WHERE priceid = "#getplacement.pm#"  and itemid = 'EISYER' ORDER BY billadminfee
            </cfquery>
            
            <cfif getpmeis.recordcount neq 0>
            <cfset eisyer = totaleis>
            <cfloop list="pay,bill" index="a">
                	<cfif evaluate('getpmeis.#a#able') eq "Y" and evaluate('getpmeis.#a#adminfee') neq "">
						<cfif findnocase('%',evaluate('getpmeis.#a#adminfee'))>
						<cfif numberformat((val(evaluate('#getpmeis.itemid#')) * replacenocase(evaluate('getpmeis.#a#adminfee'),'%','')/100),'.__') gte 0.00>
                        <cfset calculateadminfee = calculateadminfee + val((val(trim(evaluate('#getpmeis.itemid#'))) * replacenocase(evaluate('getpmeis.#a#adminfee'),'%','')/100))>
						</cfif>
                         <tr>
                        <td>#getpmeis.itemname#</td>
                        <td>
						<cfif val(evaluate('#getpmeis.itemid#')) gte 0.00>
						#val(evaluate('#getpmeis.itemid#'))#
						<cfelse>
						0.00
						</cfif>
						</td>
                        <td>
						<cfif numberformat((val(evaluate('#getpmeis.itemid#')) * replacenocase(evaluate('getpmeis.#a#adminfee'),'%','')/100),'.__') gte 0.00>
						#val((val(evaluate('#getpmeis.itemid#')) * replacenocase(trim(evaluate('getpmeis.#a#adminfee')),'%','')/100))#
						<cfelse>
						0.00
						</cfif>
						</td>
                        </tr>
                            
                        <cfelseif left(evaluate('getpmeis.#a#adminfee'),1) eq "=">
                        <cfset con = evaluate('getpmeis.#a#adminfee')>
                        <cfset con = right(con,len(con)-1)>
						<cfset con = Replace(con,"<="," lte ","all") >
				        <cfset con = Replace(con,">="," gte ","all") >
				        <cfset con = Replace(con,">"," gt ","all") >
				        <cfset con = Replace(con,"<"," lt ","all") >
						<cfset con = Replace(con,"!="," neq ","all") >
				        <cfset con = Replace(con,"="," eq ","all") >
                        
                        <cfset calculateadminfee = calculateadminfee + val(evaluate(con))>
                        <tr>
                        <td>#getpmeis.itemname#</td>
                        <td>#val(evaluate('#getpmeis.itemid#'))#</td>
                        <td>#val(evaluate(con))#</td>
                        </tr>
                            
                        <cfelse>
                        <cfset calculateadminfee = calculateadminfee + val(evaluate('getpmeis.#a#adminfee'))>
                            
                        <tr>
                        <td>#getpmeis.itemname#</td>
                        <td>#val(evaluate('#getpmeis.itemid#'))#</td>
                        <td>#val(evaluate('getpmeis.#a#adminfee'))#</td>
                        </tr>
                        </cfif>
                    </cfif>
              </cfloop>
              </cfif>
            <!---Added by Nieo 20180118, EIS added--->
            
            <cfset epfadminfee = 0 >
            <cfset socsoadminfee = 0>
            
			</cfif>
                
                
                
                
        <!---Added by Nieo 20181003 1221, customized for Venture Admin Fee--->
            <cfif getplacement.pm neq "">
            <cfif findnocase('venture',getplacement.custname) and checkadminfeitem.recordcount eq 0>
                
                <cfif isdefined('epfrecalculate')>
                    <cfset StructDelete(Variables,"epfrecalculate")>
                </cfif>
                
                <cfset deductedadminfee = 0 >
                    
                <cfset actualadminfee = 0>
                    
                <!---<cfset socsopayin = 0>
            
                <cfset epfpayin = 0>--->
                
                <cfset thisadminfee = calculateadminfee>
                
                <cfquery name="getassignment" datasource="#dts#">
                    SELECT * FROM assignmentslip 
                    WHERE empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getplacement.empno#">
                    AND payrollperiod = #gqry.mmonth#
                    AND emppaymenttype <> <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.emppaymenttype#">
                </cfquery>
                    
                <cfset db = paydts>
                    
                <!--<cfquery name="socaw" datasource="#db#">
                SELECT * FROM awtable where AW_HRD = 1 AND AW_COU<18 ORDER BY AW_cou 
                </cfquery>

                <cfquery name="socded" datasource="#db#">
                SELECT * FROM dedtable where DED_HRD = 1  ORDER BY ded_cou 
                </cfquery>	
                    
                Prepare EPF and SOCSO Wage for SAF calculation (Added by Nieo 20181005 1041)
                <cfloop query="getassignment">
                    <cfquery name="getepfwageother" datasource="#db#">
                    SELECT epf_pay_a FROM #getassignment.emppaymenttype#
                    WHERE empno = "#getassignment.empno#"
                    </cfquery>
                    
                    <cfset epfpayin =val(epfpayin) + val(getepfwageother.epf_pay_a)>

                    <cfquery name="totalsocso" datasource="#db#">
                        SELECT (coalesce(basicpay,0)+coalesce(otpay,0)
                        <cfloop query="socaw">
                        +coalesce(aw#100+socaw.aw_cou#,0)
                        </cfloop>
                        <cfloop query="socded">
                        -coalesce(ded#100+socded.ded_cou#,0)
                        </cfloop>) as socsowage
                        FROM #getassignment.emppaymenttype#
                        WHERE empno = "#getassignment.empno#"
                    </cfquery>
                        
                    <cfset socsopayin =val(socsopayin) + val(totalsocso.socsowage)>
                </cfloop>
                Prepare EPF and SOCSO Wage for SAF calculation (Added by Nieo 20181005 1041)--->
                    
                <!---<cfquery name="getTotalStatutoryER" datasource="#db#">
                    SELECT epfcc,socsocc,eiscc FROM pay_tm
                    WHERE empno = "#getassignment.empno#"
                </cfquery>

                <cfset EPFYER = val(getTotalStatutoryER.epfcc)>
                <cfset SOCSOYER = val(getTotalStatutoryER.socsocc)>
                <cfset EISYER = val(getTotalStatutoryER.eiscc)>--->
                
                <cfloop query="getassignment">
                    <cfquery name="getplacement2" datasource="#dts#">
                        SELECT * FROM placement WHERE placementno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.placementno#">
                    </cfquery>
                        
                    <cfset calculateadminfee = 0>
                    <cfset RATEYER = val(getplacement2.employer_rate_1)>
                    <cfset RATEYEE = val(getplacement2.employee_rate_1)>
                    <cfset BASIC = val(getassignment.custsalary)>
                    <cfset SALARY = val(getassignment.custsalary)>
                    <cfset BASICPAY = val(getassignment.custsalary)>
                    <cfset BASIC = BASIC + val(getassignment.lvltotaler1) + val(getassignment.lvltotaler2)>
                    <cfset BASICPAY = BASICPAY + val(getassignment.lvltotaler1) + val(getassignment.lvltotaler2)>
                    <cfset EPFYEE = val(getpaydata.epfww)>
                    <cfset SOCSOYEE = val(getpaydata.socsoww)>
                    <cfset totalsocso = SOCSOYER>
                    <cfset EISYEE = val(getpaydata.eisww)>
                    <cfset totaleis = EISYER>
                    <cfset EPF_TOTAL = val(EPFYEE + getassignment.custcpf)>
                    <cfset SOCSO_TOTAL = val(val(SOCSOYEE) + val(getassignment.custsdf))>
                    <cfset OT1 = val(getassignment.custot1)>
                    <cfset OT15 = val(getassignment.custot2)>
                    <cfset OT2 = val(getassignment.custot3)>
                    <cfset OT3 = val(getassignment.custot4)>
                    <cfset OT5 = val(getassignment.custot5)>
                    <cfset OT6 = val(getassignment.custot6)>
                    <cfset OT7 = val(getassignment.custot7)>
                    <cfset OT8 = val(getassignment.custot8)>

                    <cfset AW_TOTAL = val(getpaydata.taw)>
                    <cfset OT_TOTAL = val(getpaydata.otpay)>
                    <cfset GROSSPAY = val(getpaydata.grosspay)>
                    <cfset NETPAY = val(getpaydata.netpay)>
                    <cfset NPL =  val(getassignment.lvltotaler1) + val(getassignment.lvltotaler2)>

                    <cfif basicpay lte 4000 and grosspay neq 0>
                        <cfset SOCSO_OT = numberformat(SOCSOYER*OT_TOTAL/grosspay,'.__')>
                    <cfelse>
                        <cfset SOCSO_OT = 0>
                    </cfif>

                    <cfset totalfixaw = 0>
                    <cfset totalvaraw = 0>
                        
                    <cfquery name="getpaydata" datasource="#paydts#">
                        SELECT * FROM #getassignment.emppaymenttype# WHERE empno = "#getplacement2.empno#"
                    </cfquery>

                    <cfif getplacement2.pm neq "">
                        
                        <tr>
                            <th>Venture Customized Admin Fee (Assignmentslip: #getassignment.refno#)</th>
                            <th></th>
                            <th></th>
                        </tr>
                        
                        <cfquery name="getpm" datasource="#dts#">
                        SELECT * FROM manpowerpricematrixdetail WHERE priceid = "#getplacement2.pm#" ORDER BY billadminfee
                        </cfquery>

                        <cfquery name="checkadminfeitem" datasource="#dts#">
                        SELECT * FROM manpowerpricematrixdetail WHERE priceid = "#getplacement2.pm#" and itemid = "adminfee"
                        </cfquery>

                        <cfloop query="getpm">
                            <cfif getpm.saf eq "Y">
                                <cfset epfrecalculate = 1>

                                <cfquery name="getpm" datasource="#dts#">
                                SELECT * FROM manpowerpricematrixdetail WHERE priceid = "#getplacement2.pm#" and itemid not in ('EPFYER','SOCSOYER','EISYER') ORDER BY billadminfee
                                </cfquery>

                                <cfbreak>
                            </cfif>
                        </cfloop>

                        <cfquery name="getitemlist" datasource="#dts#">
                        SELECT itemno FROM icitem WHERE itemno <> "adminfee"
                        </cfquery>
                            
                        <cfloop query="getpm">
            
                        <cfif listfindnocase(valuelist(getitemlist.itemno),getpm.itemid)>
                            <cfloop list="pay,bill" index="a">
                            <cfif evaluate('getpm.#a#able') eq "Y" and evaluate('getpm.#a#adminfee') neq "">
                                <cfif findnocase('%',evaluate('getpm.#a#adminfee'))>
                                    <cfset calculateadminfee = calculateadminfee + val((val(evaluate('#getpm.itemid#')) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))>
                                    <tr>
                                    <td>#getpm.itemname#</td>
                                    <td>#val(evaluate('#getpm.itemid#'))#</td>
                                    <td>#val((val(evaluate('#getpm.itemid#')) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))#</td>
                                    </tr>
                                <cfelseif left(evaluate('getpm.#a#adminfee'),1) eq "=">
                                    <cfset con = evaluate('getpm.#a#adminfee')>
                                    <cfset con = right(con,len(con)-1)>
                                    <cfset con = Replace(con,"<="," lte ","all") >
                                    <cfset con = Replace(con,">="," gte ","all") >
                                    <cfset con = Replace(con,">"," gt ","all") >
                                    <cfset con = Replace(con,"<"," lt ","all") >
                                    <cfset con = Replace(con,"!="," neq ","all") >
                                    <cfset con = Replace(con,"="," eq ","all") >

                                    <cfset calculateadminfee = calculateadminfee + val(evaluate(con))>

                                    <tr>
                                    <td>#getpm.itemname#</td>
                                    <td>#val(evaluate('#getpm.itemid#'))#</td>
                                    <td>#val(evaluate(con))#</td>
                                    </tr>

                                <cfelse>

                                    <cfset calculateadminfee = calculateadminfee + val(evaluate('getpm.#a#adminfee'))>

                                    <tr>
                                    <td>#getpm.itemname#</td>
                                    <td>#val(evaluate('#getpm.itemid#'))#</td>
                                    <td>#val(evaluate('getpm.#a#adminfee'))#</td>
                                    </tr>

                                </cfif>
                            </cfif>
                            </cfloop>

                         <cfelseif left(getpm.itemid,2) eq "B-">
                    <cfset "B#replace(getpm.itemid,'B-','')#" = 0>
                          <cfloop from="1" to="6" index="bb">
                            <cfif evaluate('getassignment.billitem#bb#') eq replace(getpm.itemid,'B-','') and val(evaluate('getassignment.billitemamt#bb#')) neq 0>
                                <cfset "B#replace(getpm.itemid,'B-','')#" = val(evaluate('getassignment.billitemamt#bb#'))>
                                <cfloop list="bill" index="a">
                            <cfif evaluate('getpm.#a#able') eq "Y" and evaluate('getpm.#a#adminfee') neq "">
                                <cfif findnocase('%',evaluate('getpm.#a#adminfee'))>

                                    <cfset calculateadminfee = calculateadminfee + val((val(evaluate('B#replace(getpm.itemid,'B-','')#')) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))>

                                    <tr>
                                    <td>#getpm.itemname#</td>
                                    <td>#val(evaluate('B#replace(getpm.itemid,'B-','')#'))#</td>
                                    <td>#val((val(evaluate('B#replace(getpm.itemid,'B-','')#')) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))#</td>
                                    </tr>

                                <cfelseif left(evaluate('getpm.#a#adminfee'),1) eq "=">
                                    <cfset con = evaluate('getpm.#a#adminfee')>
                                    <cfset con = right(con,len(con)-1)>
                                    <cfset con = Replace(con,"<="," lte ","all") >
                                    <cfset con = Replace(con,">="," gte ","all") >
                                    <cfset con = Replace(con,">"," gt ","all") >
                                    <cfset con = Replace(con,"<"," lt ","all") >
                                    <cfset con = Replace(con,"!="," neq ","all") >
                                    <cfset con = Replace(con,"="," eq ","all") >

                                    <cfset calculateadminfee = calculateadminfee + val(evaluate(con))>  

                                    <tr>
                                    <td>#getpm.itemname#</td>
                                    <td>#val(evaluate('B#replace(getpm.itemid,'B-','')#'))#</td>
                                    <td>#val(evaluate(con))#</td>
                                    </tr>

                                <cfelse>

                                    <cfset calculateadminfee = calculateadminfee + val(evaluate('getpm.#a#adminfee'))>

                                    <tr>
                                    <td>#getpm.itemname#</td>
                                    <td>#val(evaluate('B#replace(getpm.itemid,'B-','')#'))#</td>
                                    <td>#val(evaluate('getpm.#a#adminfee'))#</td>
                                    </tr>

                                </cfif>
                            </cfif>
                            </cfloop>


                            </cfif>
                          </cfloop>
                         <cfelseif left(getpm.itemid,2) eq "A-" or getpm.itemid eq "ALLAWEXC">



                         <cfif getpm.itemid eq "ALLAWEXC">

                          <cfset excludeaw = "0,">
                         <cfquery name="getpmdetails" datasource="#dts#">
                    SELECT * FROM manpowerpricematrixdetail WHERE priceid = "#getplacement.pm#" ORDER BY billadminfee
                    </cfquery>
                         <cfloop query="getpmdetails">
                         <!---<cfif left(getpmdetails.itemid,2) eq "A-" and (getpmdetails.billadminfee eq "0%" or getpmdetails.billadminfee eq "0")>--->
                        <cfif left(getpmdetails.itemid,2) eq "A-">
                         <cfset excludeaw=excludeaw&replace(getpmdetails.itemid,'A-','')&",">
                         </cfif>
                         </cfloop>

                         <cfset awexc = 0>

                         <cfloop from="1" to="6" index="aa">
                            <cfif listfindnocase(excludeaw,evaluate('getassignment.fixawcode#aa#')) eq false>

                                <cfloop list="pay,bill" index="a">
                                <cfif a eq "pay">
                                <cfset awexc = val(evaluate('getassignment.fixawee#aa#'))>
                                <cfelse>
                                <cfset awexc = val(evaluate('getassignment.fixawer#aa#'))>
                                <cfset totalfixaw =  totalfixaw + val(evaluate('getassignment.fixawer#aa#'))>
                                </cfif>
                            <cfif evaluate('getpm.#a#able') eq "Y" and evaluate('getpm.#a#adminfee') neq "">
                                <cfquery name="getname" datasource="#dts#">
                                select * from icshelf where shelf = "#evaluate('url.fixawcode#aa#')#"
                                </cfquery>

                                <cfif findnocase('%',evaluate('getpm.#a#adminfee'))>


                                    <cfset calculateadminfee = calculateadminfee + val((val(awexc) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))>

                                    <cfif numberformat((val(awexc) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100),'.__') gt 0>

                                     <tr>
                                    <td>#getname.desp#</td>
                                    <td>#val(awexc)#</td>
                                    <td>#val((val(awexc) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))#</td>
                                    </tr>
                                    </cfif>


                                <cfelseif left(evaluate('getpm.#a#adminfee'),1) eq "=">
                                    <cfset con = evaluate('getpm.#a#adminfee')>
                                    <cfset con = right(con,len(con)-1)>
                                    <cfset con = Replace(con,"<="," lte ","all") >
                                    <cfset con = Replace(con,">="," gte ","all") >
                                    <cfset con = Replace(con,">"," gt ","all") >
                                    <cfset con = Replace(con,"<"," lt ","all") >
                                    <cfset con = Replace(con,"!="," neq ","all") >
                                    <cfset con = Replace(con,"="," eq ","all") >

                                    <cfset calculateadminfee = calculateadminfee + val(evaluate(con))>

                                    <cfif numberformat(evaluate(con),'.__') gt 0>

                                     <tr>
                                    <td>#getname.desp#</td>
                                    <td>#val(awexc)#</td>
                                    <td>#val(evaluate(con))#</td>
                                    </tr>
                                    </cfif>

                                <cfelse>


                                    <cfset calculateadminfee = calculateadminfee + val(evaluate('getpm.#a#adminfee'))>

                                    <cfif val(evaluate('getpm.#a#adminfee')) gt 0>

                                     <tr>
                                    <td>#getname.desp#</td>
                                    <td>#val(awexc)#</td>
                                    <td>#val(evaluate('getpm.#a#adminfee'))#</td>
                                    </tr>
                                    </cfif>

                                </cfif>
                            </cfif>
                            </cfloop>


                            </cfif>
                          </cfloop>

                          <cfset awexc = 0>
                          <cfloop from="1" to="18" index="aa">
                            <cfif listfindnocase(excludeaw,evaluate('getassignment.allowance#aa#')) eq false>

                                <cfloop list="pay,bill" index="a">
                                <cfif a eq "pay">
                                <cfset awexc = val(evaluate('getassignment.awee#aa#'))>
                                <cfelse>
                                <cfset awexc = val(evaluate('getassignment.awer#aa#'))>
                                <cfset totalvaraw =  totalvaraw + val(evaluate('getassignment.awer#aa#'))>
                                </cfif>
                            <cfif evaluate('getpm.#a#able') eq "Y" and evaluate('getpm.#a#adminfee') neq "">
                                <cfquery name="getname" datasource="#dts#">
                                select * from icshelf where shelf = "#evaluate('url.allowance#aa#')#"
                                </cfquery>
                                <cfif findnocase('%',evaluate('getpm.#a#adminfee'))>


                                    <cfset calculateadminfee = calculateadminfee + val((val(awexc) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))>

                                    <cfif numberformat((val(awexc) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100),'.__') gt 0>

                                     <tr>
                                    <td>#getname.desp#</td>
                                    <td>#val(awexc)#</td>
                                    <td>#val((val(awexc) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))#</td>
                                    </tr>
                                    </cfif>


                                <cfelseif left(evaluate('getpm.#a#adminfee'),1) eq "=">
                                    <cfset con = evaluate('getpm.#a#adminfee')>
                                    <cfset con = right(con,len(con)-1)>
                                    <cfset con = Replace(con,"<="," lte ","all") >
                                    <cfset con = Replace(con,">="," gte ","all") >
                                    <cfset con = Replace(con,">"," gt ","all") >
                                    <cfset con = Replace(con,"<"," lt ","all") >
                                    <cfset con = Replace(con,"!="," neq ","all") >
                                    <cfset con = Replace(con,"="," eq ","all") >

                                    <cfset calculateadminfee = calculateadminfee + val(evaluate(con))>

                                    <cfif numberformat(evaluate(con),'.__') gt 0>

                                     <tr>
                                    <td>#getname.desp#</td>
                                    <td>#val(awexc)#</td>
                                    <td>#numberformat(evaluate(con),'.__')#</td>
                                    </tr>
                                    </cfif>


                                <cfelse>

                                        <cfset calculateadminfee = calculateadminfee + val(evaluate('getpm.#a#adminfee'))>

                                        <cfif val(evaluate('getpm.#a#adminfee')) gt 0>

                                         <tr>
                                        <td>#getname.desp#</td>
                                        <td>#val(awexc)#</td>
                                        <td>#val(evaluate('getpm.#a#adminfee'))#</td>
                                        </tr>
                                        </cfif>

                                </cfif>
                            </cfif>
                            </cfloop>


                            </cfif>
                          </cfloop>


                         <cfelse>

                         <cfset "A#replacenocase(getpm.itemid,'A-','')#" = 0>
                         <cfset "totalA#replacenocase(getpm.itemid,'A-','')#" = 0>
                            <cfloop from="1" to="6" index="aa">
                            <cfif evaluate('getassignment.fixawcode#aa#') eq replace(getpm.itemid,'A-','') and (val(evaluate('getassignment.fixawer#aa#')) neq 0 or val(evaluate('getassignment.fixawee#aa#')) neq 0)>

                                <cfloop list="pay,bill" index="a">
                                <cfif a eq "pay">
                                <cfset "A#replacenocase(getpm.itemid,'A-','')#" = val(evaluate('getassignment.fixawee#aa#'))>
                                <cfelse>
                                <cfset "A#replacenocase(getpm.itemid,'A-','')#" = val(evaluate('getassignment.fixawer#aa#'))>
                                <cfset "totalA#replacenocase(getpm.itemid,'A-','')#" = evaluate("totalA#replacenocase(getpm.itemid,'A-','')#")+val(evaluate('getassignment.fixawer#aa#'))>
                                <cfset totalfixaw =  totalfixaw + val(evaluate('getassignment.fixawer#aa#'))>
                                </cfif>
                            <cfif evaluate('getpm.#a#able') eq "Y" and evaluate('getpm.#a#adminfee') neq "">
                                <cfif findnocase('%',evaluate('getpm.#a#adminfee'))>


                                    <cfset calculateadminfee = calculateadminfee + val((val(evaluate('A#replace(getpm.itemid,'A-','')#')) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))>

                                     <tr>
                                    <td>#getpm.itemname#</td>
                                    <td>#val(evaluate('A#replace(getpm.itemid,'A-','')#'))#</td>
                                    <td>#val((val(evaluate('A#replace(getpm.itemid,'A-','')#')) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))#</td>
                                    </tr>


                                <cfelseif left(evaluate('getpm.#a#adminfee'),1) eq "=">
                                    <cfset con = evaluate('getpm.#a#adminfee')>
                                    <cfset con = right(con,len(con)-1)>
                                    <cfset con = Replace(con,"<="," lte ","all") >
                                    <cfset con = Replace(con,">="," gte ","all") >
                                    <cfset con = Replace(con,">"," gt ","all") >
                                    <cfset con = Replace(con,"<"," lt ","all") >
                                    <cfset con = Replace(con,"!="," neq ","all") >
                                    <cfset con = Replace(con,"="," eq ","all") >


                                    <cfset calculateadminfee = calculateadminfee + val(evaluate(con))>

                                     <tr>
                                    <td>#getpm.itemname#</td>
                                    <td>#val(evaluate('A#replace(getpm.itemid,'A-','')#'))#</td>
                                    <td>#val(evaluate(con))#</td>
                                    </tr>


                                <cfelse>


                                    <cfset calculateadminfee = calculateadminfee + val(evaluate('getpm.#a#adminfee'))>

                                    <tr>
                                    <td>#getpm.itemname#</td>
                                    <td>#val(evaluate('A#replace(getpm.itemid,'A-','')#'))#</td>
                                    <td>#val(evaluate('getpm.#a#adminfee'))#</td>
                                    </tr>


                                </cfif>
                            </cfif>
                            </cfloop>


                            </cfif>
                          </cfloop>

                          <cfloop from="1" to="18" index="aa">
                            <cfif evaluate('getassignment.allowance#aa#') eq replace(getpm.itemid,'A-','') and (val(evaluate('getassignment.awer#aa#')) neq 0 or val(evaluate('getassignment.awee#aa#')) neq 0)>

                                <cfloop list="pay,bill" index="a">
                                <cfif a eq "pay">
                                <cfset "A#replacenocase(getpm.itemid,'A-','')#" = val(evaluate('getassignment.awee#aa#'))>
                                <cfelse>
                                <cfset "A#replacenocase(getpm.itemid,'A-','')#" = val(evaluate('getassignment.awer#aa#'))>
                                 <cfset "totalA#replacenocase(getpm.itemid,'A-','')#" = evaluate("totalA#replacenocase(getpm.itemid,'A-','')#")+val(evaluate('getassignment.awer#aa#'))>
                                <cfset totalvaraw =  totalvaraw + val(evaluate('getassignment.awer#aa#'))>
                                </cfif>
                            <cfif evaluate('getpm.#a#able') eq "Y" and evaluate('getpm.#a#adminfee') neq "">
                                <cfif findnocase('%',evaluate('getpm.#a#adminfee'))>


                                    <cfset calculateadminfee = calculateadminfee + val((val(evaluate('A#replace(getpm.itemid,'A-','')#')) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))>

                                    <tr>
                                    <td>#getpm.itemname#</td>
                                    <td>#val(evaluate('A#replace(getpm.itemid,'A-','')#'))#</td>
                                    <td>#val((val(evaluate('A#replace(getpm.itemid,'A-','')#')) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))#</td>
                                    </tr>


                                <cfelseif left(evaluate('getpm.#a#adminfee'),1) eq "=">
                                    <cfset con = evaluate('getpm.#a#adminfee')>
                                    <cfset con = right(con,len(con)-1)>
                                    <cfset con = Replace(con,"<="," lte ","all") >
                                    <cfset con = Replace(con,">="," gte ","all") >
                                    <cfset con = Replace(con,">"," gt ","all") >
                                    <cfset con = Replace(con,"<"," lt ","all") >
                                    <cfset con = Replace(con,"!="," neq ","all") >
                                    <cfset con = Replace(con,"="," eq ","all") >


                                    <cfset calculateadminfee = calculateadminfee + val(evaluate(con))>

                                    <tr>
                                    <td>#getpm.itemname#</td>
                                    <td>#val(evaluate('A#replace(getpm.itemid,'A-','')#'))#</td>
                                    <td>#val(evaluate(con))#</td>
                                    </tr>


                                <cfelse>


                                    <cfset calculateadminfee = calculateadminfee + val(evaluate('getpm.#a#adminfee'))>


                                     <tr>
                                    <td>#getpm.itemname#</td>
                                    <td>#val(evaluate('A#replace(getpm.itemid,'A-','')#'))#</td>
                                    <td>#val(evaluate('getpm.#a#adminfee'))#</td>
                                    </tr>


                                </cfif>
                            </cfif>
                            </cfloop>   
                            </cfif>

                          </cfloop>
                          </cfif>
                           <cfelseif getpm.itemid eq "ADMINFEE">

                           <cfloop index="a" from="1" to="6">
                           <cfset totalfixaw =  totalfixaw + val(evaluate('getassignment.fixawer#a#'))>
                           </cfloop>               

                           <cfloop index="aa" from="1" to="18">
                           <cfset totalvaraw =  totalvaraw + val(evaluate('getassignment.awer#aa#'))>
                           </cfloop>

                           <cfif grosspay neq 0>
                            <cfset EPF_FIXAW = numberformat(EPFYER*TOTALFIXAW/grosspay,'.__')>
                            <cfset EPF_VARAW = numberformat(EPFYER*TOTALVARAW/grosspay,'.__')>
                            <cfelse>
                            <cfset EPF_FIXAW = 0>
                            <cfset EPF_VARAW = 0>
                            </cfif>
                            <cfif basicpay lte 4000 and grosspay neq 0>
                            <cfset SOCSO_FIXAW = numberformat(SOCSOYER*TOTALFIXAW/grosspay,'.__')>
                            <cfset SOCSO_VARAW = numberformat(SOCSOYER*TOTALVARAW/grosspay,'.__')>
                            <cfelse>
                            <cfset SOCSO_FIXAW = 0>
                            <cfset SOCSO_VARAW = 0>
                            </cfif>
                                
                            <cfif basicpay lte 4000 and grosspay neq 0>
                            <cfset EIS_FIXAW = numberformat(EISYER*TOTALFIXAW/grosspay,'.__')>
                            <cfset EIS_VARAW = numberformat(EISYER*TOTALVARAW/grosspay,'.__')>
                            <cfelse>
                            <cfset EIS_FIXAW = 0>
                            <cfset EIS_VARAW = 0>
                            </cfif>

                    <cfloop list="bill" index="a">
                            <cfif evaluate('getpm.#a#able') eq "Y" and evaluate('getpm.#a#adminfee') neq "">
                                <cfif findnocase('%',evaluate('getpm.#a#adminfee'))>
                                <cfset calculateadminfee = calculateadminfee + val((val(BASIC) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))>
                                 <tr>
                                <td>#getpm.itemname#*</td>
                                <td>#val(BASIC)#</td>
                                <td>#val((val(BASIC) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))#</td>
                                </tr>

                                <cfelseif left(evaluate('getpm.#a#adminfee'),1) eq "=">

                                <cfset con = evaluate('getpm.#a#adminfee')>
                                <cfset con = right(con,len(con)-1)>
                                <cfset con = Replace(con,"<="," lte ","all") >
                                <cfset con = Replace(con,">="," gte ","all") >
                                <cfset con = Replace(con,">"," gt ","all") >
                                <cfset con = Replace(con,"<"," lt ","all") >
                                <cfset con = Replace(con,"!="," neq ","all") >
                                <cfset con = Replace(con,"="," eq ","all") >


                                <cfset calculateadminfee = calculateadminfee + val(evaluate(con))>
                                  <tr>
                                <td>#getpm.itemname#**</td>
                                <td>#val(BASIC)#</td>
                                <td>#val(evaluate(con))#</td>
                                </tr>

                                <cfelse>
                                <cfset calculateadminfee = calculateadminfee + val(evaluate('getpm.#a#adminfee'))>
                                 <tr>
                                <td>#getpm.itemname#***</td>
                                <td>#val(BASIC)#</td>
                                <td>#val(evaluate('getpm.#a#adminfee'))#</td>
                                </tr>

                                </cfif>
                            </cfif>
                            </cfloop>

                        </cfif>
                    </cfloop>
                                    
                        <cfif isdefined('epfrecalculate') and (val(url.epfpayin) neq 0 or val(socsopayin) neq 0) and checkadminfeitem.recordcount eq 0>
                            <cfset totalepf = EPFYER>
                            1. #totalepf#<br>
                            <cfset totaleis = EISYER>
                            <cfset totalsocso = SOCSOYER>
                            <cfset socsoremain = socsopayin>
                            <cfset eisremain = socsopayin>
                            <cfif socsoremain gt 3900>
                                <cfset socsoremain = 3900.01>
                                <cfset socsopayin = 3900.01>
                            </cfif>
                            <cfset socsoremain = socsoremain - BASIC>
                            <cfif eisremain gt 3900>
                            <cfset eisremain = 3900.01>
                            </cfif>
                            <cfset eisremain = eisremain - BASIC>

                            <cfquery name="getpmsafaw" datasource="#dts#">
                            SELECT * FROM manpowerpricematrixdetail WHERE priceid = "#getplacement2.pm#" AND saf = "Y" and left(itemid,2) = "A-" AND billadminfee LIKE '%\%%' and billable = "Y"  ORDER BY billadminfee
                            </cfquery>

                            <cfif getpmsafaw.recordcount neq 0>
                            <cfloop query="getpmsafaw">
                                <cfquery name="checkable" datasource="#dts#">
                                SELECT desp,allowance FROM icshelf 
                                WHERE 
                                shelf = "#replace(getpmsafaw.itemid,'A-','')#"
                                </cfquery>
                                <cfif checkable.recordcount neq 0 and val(checkable.allowance) neq 0>
                                <cfquery name="checkdetails" datasource="#replace(dts,'_i','_p')#">
                                SELECT aw_epf,aw_hrd FROM awtable WHERE aw_cou = "#val(checkable.allowance)#"
                                </cfquery>
                                <cfif checkdetails.aw_epf eq 1 and isdefined('totalA#replace(getpmsafaw.itemid,'A-','')#') and val(url.epfpayin) neq 0>
                                    <cfset awamt = val(evaluate('totalA#replace(getpmsafaw.itemid,'A-','')#'))>
                                    <cfset calculateadminfee = calculateadminfee + val(numberformat(((awamt/val(url.epfpayin)) * EPFYER),'.__') * (replacenocase(getpmsafaw.billadminfee,'%','')/100))>
                                     <tr>
                                        <td>#getpmsafaw.itemname# EPF</td>
                                        <td>#numberformat(((awamt/val(url.epfpayin)) * EPFYER),'.__')#</td>                        <td>#val(numberformat(((awamt/val(url.epfpayin)) * EPFYER),'.__') * (replacenocase(getpmsafaw.billadminfee,'%','')/100))#</td>
                                        </tr>

                                    <cfset totalepf = totalepf - numberformat(((awamt/val(url.epfpayin)) * EPFYER),'.__')> 
                                    #getpmsafaw.itemname#. #totalepf#<br>
                                </cfif>
                                 <cfif checkdetails.aw_hrd eq 1 and isdefined('totalA#replace(getpmsafaw.itemid,'A-','')#') and val(socsopayin) neq 0 and socsoremain gt 0>
                                    <cfset awamt = val(evaluate('totalA#replace(getpmsafaw.itemid,'A-','')#'))>
                                    <cfif socsoremain lt awamt>
                                    <cfset awamt = socsoremain>
                                    </cfif>
                                    <cfset socsoremain = SOCSOREMAIN - awamt>
                                    <cfset calculateadminfee = calculateadminfee + val(numberformat(((awamt/val(socsopayin)) * SOCSOYER),'.__') * (replacenocase(getpmsafaw.billadminfee,'%','')/100))>
                                     <tr>
                                        <td>#getpmsafaw.itemname# SOCSO</td>
                                        <td>#numberformat(((awamt/val(socsopayin)) * SOCSOYER),'.__')#</td>
                                        <td>#val(numberformat(((awamt/val(socsopayin)) * SOCSOYER),'.__') * (replacenocase(getpmsafaw.billadminfee,'%','')/100))#</td>
                                        </tr>                     

                                    <cfset totalsocso = totalsocso - numberformat(((awamt/val(socsopayin)) * SOCSOYER),'.__')>
                                </cfif>

                                <!---Added by Nieo 20180119 1017, EIS added--->
                                <cfif checkdetails.aw_hrd eq 1 and isdefined('totalA#replace(getpmsafaw.itemid,'A-','')#') and val(socsopayin) neq 0 and eisremain gt 0>
                                    <cfset awamt = val(evaluate('totalA#replace(getpmsafaw.itemid,'A-','')#'))>
                                    <cfif eisremain lt awamt>
                                    <cfset awamt = eisremain>
                                    </cfif>
                                    <cfset eisremain = eisremain - awamt>
                                    <cfset calculateadminfee = calculateadminfee + val(numberformat(((awamt/val(socsopayin)) * EISYER),'.__') * (replacenocase(getpmsafaw.billadminfee,'%','')/100))>
                                     <tr>
                                        <td>#getpmsafaw.itemname# EIS</td>
                                        <td>#numberformat(((awamt/val(socsopayin)) * EISYER),'.__')#</td>
                                        <td>#val(numberformat(((awamt/val(socsopayin)) * EISYER),'.__') * (replacenocase(getpmsafaw.billadminfee,'%','')/100))#</td>
                                        </tr>

                                    <cfset totaleis = val(totaleis) - numberformat(((awamt/val(socsopayin)) * totaleis),'.__')>
                                </cfif>
                                <!---Added by Nieo 20180119 1017, EIS added--->

                                </cfif>

                            </cfloop>
                            </cfif>

                            <cfquery name="getpmsafexc" datasource="#dts#">
                            SELECT * FROM manpowerpricematrixdetail WHERE priceid = "#getplacement2.pm#" AND saf = "Y" and itemid = "ALLAWEXC" AND billadminfee LIKE '%\%%'  and billable = "Y"  ORDER BY billadminfee
                            </cfquery>


                            <cfif getpmsafexc.recordcount neq 0> 
                                 <cfset awexc = 0>

                                 <cfloop from="1" to="6" index="aa">
                                    <cfif listfindnocase(excludeaw,evaluate('getassignment.fixawcode#aa#')) eq false>
                                       <cfset awexc = val(evaluate('getassignment.fixawer#aa#'))>
                                        <cfquery name="checkable" datasource="#dts#">
                                        SELECT desp,allowance FROM icshelf 
                                        WHERE 
                                        shelf = "#evaluate('getassignment.fixawcode#aa#')#"
                                        </cfquery>
                                        <cfif checkable.recordcount neq 0 and val(checkable.allowance) neq 0>
                                        <cfquery name="checkdetails" datasource="#replace(dts,'_i','_p')#">
                                        SELECT aw_epf,aw_hrd FROM awtable WHERE aw_cou = "#val(checkable.allowance)#"
                                        </cfquery>
                                        <cfif checkdetails.aw_epf eq 1 and awexc neq 0 and val(url.epfpayin) neq 0>
                                            <cfset awamt = awexc>
                                            <cfset calculateadminfee = calculateadminfee + val(numberformat(((awamt/val(url.epfpayin)) * EPFYER),'.__') * (replacenocase(getpmsafexc.billadminfee,'%','')/100))>
                                            <tr>
                                            <td>#checkable.desp# EPF</td>
                                            <td>#numberformat(((awamt/val(url.epfpayin)) * EPFYER),'.__')#</td>
                                            <td>#val(numberformat(((awamt/val(url.epfpayin)) * EPFYER),'.__') * (replacenocase(getpmsafexc.billadminfee,'%','')/100))#</td>
                                            </tr>

                                            <cfset totalepf = totalepf - numberformat(((awamt/val(url.epfpayin)) * EPFYER),'.__')>
                                            #aa#. #totalepf#<br>
                                        </cfif>
                                         <cfif checkdetails.aw_hrd eq 1 and awexc neq 0 and val(socsopayin) neq 0 and socsoremain gt 0>
                                            <cfset awamt = awexc>
                                            <cfif socsoremain lt awamt>
                                            <cfset awamt = socsoremain>
                                            </cfif>
                                            <cfset socsoremain = SOCSOREMAIN - awamt>
                                            <cfset calculateadminfee = calculateadminfee + val(numberformat(((awamt/val(socsopayin)) * SOCSOYER),'.__') * (replacenocase(getpmsafexc.billadminfee,'%','')/100))>
                                            <tr>
                                            <td>#checkable.desp# SOCSO</td>
                                            <td>#numberformat(((awamt/val(socsopayin)) * SOCSOYER),'.__')#</td>
                                            <td>#val(numberformat(((awamt/val(socsopayin)) * SOCSOYER),'.__') * (replacenocase(getpmsafexc.billadminfee,'%','')/100))#</td>
                                            </tr>

                                            <cfset totalsocso = totalsocso - numberformat(((awamt/val(socsopayin)) * SOCSOYER),'.__')>
                                        </cfif>

                                        <!---Added by Nieo 20180119 1017, EIS added--->
                                        <cfif checkdetails.aw_hrd eq 1 and awexc neq 0 and val(socsopayin) neq 0 and eisremain gt 0>
                                            <cfset awamt = awexc>
                                            <cfif eisremain lt awamt>
                                            <cfset awamt = eisremain>
                                            </cfif>
                                            <cfset eisremain = eisremain - awamt>
                                            <cfset calculateadminfee = calculateadminfee + val(numberformat(((awamt/val(socsopayin)) * EISYER),'.__') * (replacenocase(getpmsafexc.billadminfee,'%','')/100))>
                                            <tr>
                                            <td>#checkable.desp# EIS</td>
                                            <td>#numberformat(((awamt/val(socsopayin)) * EISYER),'.__')#</td>
                                            <td>#val(numberformat(((awamt/val(socsopayin)) * EISYER),'.__') * (replacenocase(getpmsafexc.billadminfee,'%','')/100))#</td>
                                            </tr>

                                            <cfset totaleis = val(totaleis) - numberformat(((awamt/val(socsopayin)) * EISYER),'.__')>
                                        </cfif>
                                        <!---Added by Nieo 20180119 1017, EIS added--->

                                        </cfif>
                                        </cfif>
                                    </cfloop>

                                    <cfloop from="1" to="18" index="aa">
                                    <cfif listfindnocase(excludeaw,evaluate('getassignment.allowance#aa#')) eq false>
                                        <cfset awexc = val(evaluate('getassignment.awer#aa#'))>
                                        <cfquery name="checkable" datasource="#dts#">
                                        SELECT desp,allowance FROM icshelf 
                                        WHERE 
                                        shelf = "#evaluate('getassignment.allowance#aa#')#"
                                        </cfquery>
                                        <cfif checkable.recordcount neq 0 and val(checkable.allowance) neq 0>
                                        <cfquery name="checkdetails" datasource="#replace(dts,'_i','_p')#">
                                        SELECT aw_epf,aw_hrd FROM awtable WHERE aw_cou = "#val(checkable.allowance)#"
                                        </cfquery>
                                        <cfif checkdetails.aw_epf eq 1 and awexc neq 0 and val(url.epfpayin) neq 0>
                                            <cfset awamt = awexc>
                                            <cfset calculateadminfee = calculateadminfee + val(numberformat(((awamt/val(url.epfpayin)) * EPFYER),'.__') * (replacenocase(getpmsafexc.billadminfee,'%','')/100))>
                                              <tr>
                                            <td>#checkable.desp# EPF</td>
                                            <td>#numberformat(((awamt/val(url.epfpayin)) * EPFYER),'.__')#</td>
                                            <td>#val(numberformat(((awamt/val(url.epfpayin)) * EPFYER),'.__') * (replacenocase(getpmsafexc.billadminfee,'%','')/100))#</td>
                                            </tr>

                                            <cfset totalepf = totalepf - numberformat(((awamt/val(url.epfpayin)) * EPFYER),'.__')>
                                            #aa#. #totalepf#<br>
                                        </cfif>
                                         <cfif checkdetails.aw_hrd eq 1 and awexc neq 0 and val(socsopayin) neq 0 and socsoremain gt 0>
                                            <cfset awamt = awexc>
                                            <cfif socsoremain lt awamt>
                                            <cfset awamt = socsoremain>
                                            </cfif>
                                            <cfset socsoremain = SOCSOREMAIN - awamt>
                                            <cfset calculateadminfee = calculateadminfee + val(numberformat(((awamt/val(socsopayin)) * SOCSOYER),'.__') * (replacenocase(getpmsafexc.billadminfee,'%','')/100))>
                                            <tr>
                                            <td>#checkable.desp# SOCSO</td>
                                            <td>#numberformat(((awamt/val(socsopayin)) * SOCSOYER),'.__')#</td>
                                            <td>#val(numberformat(((awamt/val(socsopayin)) * SOCSOYER),'.__') * (replacenocase(getpmsafexc.billadminfee,'%','')/100))#</td>
                                            </tr>

                                            <cfset totalsocso = totalsocso - numberformat(((awamt/val(socsopayin)) * SOCSOYER),'.__')>
                                        </cfif>

                                        <!---Added by Nieo 20180119 1017, EIS added--->
                                        <cfif checkdetails.aw_hrd eq 1 and awexc neq 0 and val(socsopayin) neq 0 and eisremain gt 0>
                                            <cfset awamt = awexc>
                                            <cfif eisremain lt awamt>
                                            <cfset awamt = eisremain>
                                            </cfif>
                                            <cfset eisremain = eisremain - awamt>
                                            <cfset calculateadminfee = calculateadminfee + val(numberformat(((awamt/val(socsopayin)) * EISYER),'.__') * (replacenocase(getpmsafexc.billadminfee,'%','')/100))>
                                            <tr>
                                            <td>#checkable.desp# EIS</td>
                                            <td>#numberformat(((awamt/val(socsopayin)) * EISYER),'.__')#</td>
                                            <td>#val(numberformat(((awamt/val(socsopayin)) * EISYER),'.__') * (replacenocase(getpmsafexc.billadminfee,'%','')/100))#</td>
                                            </tr>

                                            <cfset totaleis = val(totaleis) - numberformat(((awamt/val(socsopayin)) * EISYER),'.__')>
                                        </cfif>
                                        <!---Added by Nieo 20180119 1017, EIS added--->

                                        </cfif>

                                       </cfif>
                                    </cfloop>


                                    </cfif>

                            <cfquery name="getpmsafOT" datasource="#dts#">
                            SELECT * FROM manpowerpricematrixdetail WHERE priceid = "#getplacement2.pm#" AND saf = "Y" and left(itemid,2) = "OT" AND billadminfee LIKE '%\%%'  and billable = "Y"  ORDER BY billadminfee
                            </cfquery>

                            <cfif getpmsafOT.recordcount neq 0>
                            <cfloop query="getpmsafOT"> 

                                 <cfif val(evaluate('#getpmsafOT.itemid#')) neq 0 and val(socsopayin) neq 0 and socsoremain gt 0>
                                 <cfset otamt = val(evaluate('#getpmsafOT.itemid#'))>
                                <cfif socsoremain lt otamt>
                                <cfset otamt = socsoremain>
                                </cfif>
                                 <cfset socsoremain = SOCSOREMAIN - otamt>

                                    <cfset calculateadminfee = calculateadminfee + val(numberformat((val(otamt/val(socsopayin))* SOCSOYER),'.__') * (replacenocase(getpmsafOT.billadminfee,'%','')/100))>
                                    <tr>
                                        <td>#getpmsafOT.itemname# SOCSO</td>
                                        <td>#numberformat((val(otamt/val(socsopayin))* SOCSOYER),'.__')#</td>
                                        <td>#val(numberformat((val(otamt/val(socsopayin))* SOCSOYER),'.__') * (replacenocase(getpmsafOT.billadminfee,'%','')/100))#</td>
                                        </tr>

                                    <cfset totalsocso = totalsocso - numberformat(val((otamt/val(socsopayin)) * SOCSOYER),'.__')>
                                </cfif>   

                                <!---Added by Nieo 20180119 1017, EIS added--->
                                <cfif val(evaluate('#getpmsafOT.itemid#')) neq 0 and val(socsopayin) neq 0 and eisremain gt 0>
                                 <cfset otamt = val(evaluate('#getpmsafOT.itemid#'))>
                                <cfif eisremain lt otamt>
                                <cfset otamt = eisremain>
                                </cfif>
                                 <cfset eisremain = eisremain - otamt>

                                    <cfset calculateadminfee = calculateadminfee + val(numberformat((val(otamt/val(socsopayin))* EISYER),'.__') * (replacenocase(getpmsafOT.billadminfee,'%','')/100))>
                                    <tr>
                                        <td>#getpmsafOT.itemname# EIS</td>
                                        <td>#numberformat((val(otamt/val(socsopayin))* EISYER),'.__')#</td>
                                        <td>#val(numberformat((val(otamt/val(socsopayin))* EISYER),'.__') * (replacenocase(getpmsafOT.billadminfee,'%','')/100))#</td>
                                        </tr>

                                    <cfset totaleis = val(totaleis) - numberformat(val((otamt/val(socsopayin)) * EISYER),'.__')>
                                </cfif>
                                <!---Added by Nieo 20180119 1017, EIS added--->

                            </cfloop>
                            </cfif>   


                            <!---<cfquery name="getpmepf" datasource="#dts#">
                            SELECT * FROM manpowerpricematrixdetail WHERE priceid = "#getplacement2.pm#"  and itemid = 'EPFYER' ORDER BY billadminfee
                            </cfquery>

                                    #totalepf#<br>
                            <cfif getpmepf.recordcount neq 0>
                                <!---<cfif getpmepf.saf neq 'Y'>--->
                                    <cfset epfyer = totalepf>
                                <!---</cfif>--->
                            <cfloop list="pay,bill" index="a">
                                    <cfif evaluate('getpmepf.#a#able') eq "Y" and evaluate('getpmepf.#a#adminfee') neq "">
                                        <cfif findnocase('%',evaluate('getpmepf.#a#adminfee'))>
                                        <cfset calculateadminfee = calculateadminfee + val((val(trim(evaluate('#getpmepf.itemid#'))) * replacenocase(evaluate('getpmepf.#a#adminfee'),'%','')/100))>
                                        <tr>
                                        <td>#getpmepf.itemname#</td>
                                        <td>#val(evaluate('#getpmepf.itemid#'))#</td>
                                        <td>#val((val(evaluate('#getpmepf.itemid#')) * replacenocase(trim(evaluate('getpmepf.#a#adminfee')),'%','')/100))#</td>
                                        </tr>

                                        <cfelseif left(evaluate('getpmepf.#a#adminfee'),1) eq "=">
                                        <cfset con = evaluate('getpmepf.#a#adminfee')>
                                        <cfset con = right(con,len(con)-1)>
                                        <cfset con = Replace(con,"<="," lte ","all") >
                                        <cfset con = Replace(con,">="," gte ","all") >
                                        <cfset con = Replace(con,">"," gt ","all") >
                                        <cfset con = Replace(con,"<"," lt ","all") >
                                        <cfset con = Replace(con,"!="," neq ","all") >
                                        <cfset con = Replace(con,"="," eq ","all") >

                                        <cfset calculateadminfee = calculateadminfee + val(evaluate(con))>
                                        <tr>
                                        <td>#getpmepf.itemname#</td>
                                        <td>#val(evaluate('#getpmepf.itemid#'))#</td>
                                        <td>#val(evaluate(con))#</td>
                                        </tr>

                                        <cfelse>
                                        <cfset calculateadminfee = calculateadminfee + val(evaluate('getpmepf.#a#adminfee'))>
                                        <tr>
                                        <td>#getpmepf.itemname#</td>
                                        <td>#val(evaluate('#getpmepf.itemid#'))#</td>
                                        <td>#val(evaluate('getpmepf.#a#adminfee'))#</td>
                                        </tr>

                                        </cfif>
                                    </cfif>
                              </cfloop>
                              </cfif>

                            <cfquery name="getpmsocso" datasource="#dts#">
                            SELECT * FROM manpowerpricematrixdetail WHERE priceid = "#getplacement2.pm#"  and itemid = 'SOCSOYER' ORDER BY billadminfee
                            </cfquery>

                            <cfif getpmepf.recordcount neq 0>
                            <cfset socsoyer = totalsocso>
                            <cfloop list="pay,bill" index="a">
                                    <cfif evaluate('getpmsocso.#a#able') eq "Y" and evaluate('getpmsocso.#a#adminfee') neq "">
                                        <cfif findnocase('%',evaluate('getpmsocso.#a#adminfee'))>
                                        <cfif numberformat((val(evaluate('#getpmsocso.itemid#')) * replacenocase(evaluate('getpmsocso.#a#adminfee'),'%','')/100),'.__') gte 0.00>
                                        <cfset calculateadminfee = calculateadminfee + val((val(trim(evaluate('#getpmsocso.itemid#'))) * replacenocase(evaluate('getpmsocso.#a#adminfee'),'%','')/100))>
                                        </cfif>			
                                         <tr>
                                        <td>#getpmsocso.itemname#</td>
                                        <td>
                                        <cfif val(evaluate('#getpmsocso.itemid#')) gte 0.00>
                                        #val(evaluate('#getpmsocso.itemid#'))#
                                        <cfelse>
                                        0.00
                                        </cfif>
                                        </td>
                                        <td>
                                        <cfif numberformat((val(evaluate('#getpmsocso.itemid#')) * replacenocase(evaluate('getpmsocso.#a#adminfee'),'%','')/100),'.__') gte 0.00>
                                        #val((val(evaluate('#getpmsocso.itemid#')) * replacenocase(trim(evaluate('getpmsocso.#a#adminfee')),'%','')/100))#
                                        <cfelse>
                                        0.00
                                        </cfif>
                                        </td>
                                        </tr>

                                        <cfelseif left(evaluate('getpmsocso.#a#adminfee'),1) eq "=">
                                        <cfset con = evaluate('getpmsocso.#a#adminfee')>
                                        <cfset con = right(con,len(con)-1)>
                                        <cfset con = Replace(con,"<="," lte ","all") >
                                        <cfset con = Replace(con,">="," gte ","all") >
                                        <cfset con = Replace(con,">"," gt ","all") >
                                        <cfset con = Replace(con,"<"," lt ","all") >
                                        <cfset con = Replace(con,"!="," neq ","all") >
                                        <cfset con = Replace(con,"="," eq ","all") >

                                        <cfset calculateadminfee = calculateadminfee + val(evaluate(con))>
                                        <tr>
                                        <td>#getpmsocso.itemname#</td>
                                        <td>#val(evaluate('#getpmsocso.itemid#'))#</td>
                                        <td>#val(evaluate(con))#</td>
                                        </tr>

                                        <cfelse>
                                        <cfset calculateadminfee = calculateadminfee + val(evaluate('getpmsocso.#a#adminfee'))>
                                        <tr>
                                        <td>#getpmsocso.itemname#</td>
                                        <td>#val(evaluate('#getpmsocso.itemid#'))#</td>
                                        <td>#val(evaluate('getpmsocso.#a#adminfee'))#</td>
                                        </tr>
                                        </cfif>
                                    </cfif>
                              </cfloop>
                              </cfif>

                            <!---Added by Nieo 20180118, EIS added--->
                            <cfquery name="getpmeis" datasource="#dts#">
                            SELECT * FROM manpowerpricematrixdetail WHERE priceid = "#getplacement2.pm#"  and itemid = 'EISYER' ORDER BY billadminfee
                            </cfquery>

                            <cfif getpmeis.recordcount neq 0>
                            <cfset eisyer = totaleis>
                            <cfloop list="pay,bill" index="a">
                                    <cfif evaluate('getpmeis.#a#able') eq "Y" and evaluate('getpmeis.#a#adminfee') neq "">
                                        <cfif findnocase('%',evaluate('getpmeis.#a#adminfee'))>
                                        <cfif numberformat((val(evaluate('#getpmeis.itemid#')) * replacenocase(evaluate('getpmeis.#a#adminfee'),'%','')/100),'.__') gte 0.00>
                                        <cfset calculateadminfee = calculateadminfee + val((val(trim(evaluate('#getpmeis.itemid#'))) * replacenocase(evaluate('getpmeis.#a#adminfee'),'%','')/100))>
                                        </cfif>
                                         <tr>
                                        <td>#getpmeis.itemname#</td>
                                        <td>
                                        <cfif val(evaluate('#getpmeis.itemid#')) gte 0.00>
                                        #val(evaluate('#getpmeis.itemid#'))#
                                        <cfelse>
                                        0.00
                                        </cfif>
                                        </td>
                                        <td>
                                        <cfif numberformat((val(evaluate('#getpmeis.itemid#')) * replacenocase(evaluate('getpmeis.#a#adminfee'),'%','')/100),'.__') gte 0.00>
                                        #val((val(evaluate('#getpmeis.itemid#')) * replacenocase(trim(evaluate('getpmeis.#a#adminfee')),'%','')/100))#
                                        <cfelse>
                                        0.00
                                        </cfif>
                                        </td>
                                        </tr>

                                        <cfelseif left(evaluate('getpmeis.#a#adminfee'),1) eq "=">
                                        <cfset con = evaluate('getpmeis.#a#adminfee')>
                                        <cfset con = right(con,len(con)-1)>
                                        <cfset con = Replace(con,"<="," lte ","all") >
                                        <cfset con = Replace(con,">="," gte ","all") >
                                        <cfset con = Replace(con,">"," gt ","all") >
                                        <cfset con = Replace(con,"<"," lt ","all") >
                                        <cfset con = Replace(con,"!="," neq ","all") >
                                        <cfset con = Replace(con,"="," eq ","all") >

                                        <cfset calculateadminfee = calculateadminfee + val(evaluate(con))>
                                        <tr>
                                        <td>#getpmeis.itemname#</td>
                                        <td>#val(evaluate('#getpmeis.itemid#'))#</td>
                                        <td>#val(evaluate(con))#</td>
                                        </tr>

                                        <cfelse>
                                        <cfset calculateadminfee = calculateadminfee + val(evaluate('getpmeis.#a#adminfee'))>

                                        <tr>
                                        <td>#getpmeis.itemname#</td>
                                        <td>#val(evaluate('#getpmeis.itemid#'))#</td>
                                        <td>#val(evaluate('getpmeis.#a#adminfee'))#</td>
                                        </tr>
                                        </cfif>
                                    </cfif>
                              </cfloop>
                              </cfif>--->
                            <!---Added by Nieo 20180118, EIS added--->

                            <cfset epfadminfee = 0 >
                            <cfset socsoadminfee = 0>

                            </cfif>
                        
                        <cfset deductedadminfee = val(deductedadminfee) + val(getassignment.adminfee)>
                        
                        <cfset actualadminfee = val(actualadminfee) + val(calculateadminfee)>
                            
                    </cfif>
                </cfloop>
                                            
                <cfset totaladminfee =  val(actualadminfee) + val(thisadminfee)> 
                    
                <cfset calculateadminfee = val(totaladminfee) - val(deductedadminfee)>
                
            </cfif>
            </cfif>
            <!---Added by Nieo 20181003 1221, customized for Venture Admin Fee--->
            
    </cfif>
</table>
</cfoutput>
                            
<cfoutput>
<input type="hidden" name="totaladminfee" id="totaladminfee" value="#numberformat(calculateadminfee,'.__')#" >
<input type="hidden" name="totalhrdf" id="totalhrdf" value="#numberformat(totalhrdf,'.__')#" >
</cfoutput>