		<cfoutput>
        <table>
        <tr>
        <th>Item</th>
        <th>Amount</th>
        <th>Admin Fee</th>
            
        </tr>
        
        	<cfset paydts=replace(dts,'_i','_p','all')>
            <cfset weekpay = url.emppaymenttype>
            
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
            
            <cfset AW_TOTAL = val(getpaydata.taw)>
            <cfset OT_TOTAL = val(getpaydata.otpay)>
            <cfset GROSSPAY = val(getpaydata.grosspay)>
            <cfset NETPAY = val(getpaydata.netpay)>
<!--- 			<cfif grosspay neq 0>
			<cfset EPF_OT = numberformat(EPFYER*OT_TOTAL/grosspay,'.__')>
            <cfelse>
            <cfset EPF_OT = 0>
            </cfif> --->
            <cfif basicpay lte 4000 and grosspay neq 0>
            <cfset SOCSO_OT = numberformat(SOCSOYER*OT_TOTAL/grosspay,'.__')>
			<cfelse>
            <cfset SOCSO_OT = 0>
            </cfif>
            <cfset totalfixaw = 0>
            <cfset totalvaraw = 0>
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
                            <cfif checkadminfeitem.recordcount eq 0>
                                <cfset calculateadminfee = calculateadminfee + val((val(evaluate('#getpm.itemid#')) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))>
                                <tr>
                                <td>#getpm.itemname#</td>
                                <td>#val(evaluate('#getpm.itemid#'))#</td>
                                <td>#val((val(evaluate('#getpm.itemid#')) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))#</td>
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
                      
                        <cfif checkadminfeitem.recordcount eq 0>
                            <cfset calculateadminfee = calculateadminfee + val(evaluate(con))>
                            
                            <tr>
                            <td>#getpm.itemname#</td>
                            <td>#val(evaluate('#getpm.itemid#'))#</td>
                            <td>#numberformat(evaluate(con))#</td>
                            </tr>
                        </cfif>
                            
                        <cfelse>
                            
                        <cfif checkadminfeitem.recordcount eq 0>
                            <cfset calculateadminfee = calculateadminfee + val(evaluate('getpm.#a#adminfee'))>
                                
                            <tr>
                            <td>#getpm.itemname#</td>
                            <td>#val(evaluate('#getpm.itemid#'))#</td>
                            <td>#val(evaluate('getpm.#a#adminfee'))#</td>
                            </tr>
                        </cfif>
                            
                        </cfif>
                    </cfif>
                    </cfloop>
                    
                 <cfelseif left(getpm.itemid,2) eq "B-">
			<cfset "B#replace(getpm.itemid,'B-','')#" = 0>
                  <cfloop from="1" to="6" index="bb">
                  	<cfif evaluate('url.billitem#bb#') eq replace(getpm.itemid,'B-','') and val(evaluate('url.billitemamt#bb#')) neq 0>
                    	<cfset "B#replace(getpm.itemid,'B-','')#" = val(evaluate('url.billitemamt#bb#'))>
                        <cfloop list="bill" index="a">
                	<cfif evaluate('getpm.#a#able') eq "Y" and evaluate('getpm.#a#adminfee') neq "">
						<cfif findnocase('%',evaluate('getpm.#a#adminfee'))>
                            
                        <cfif checkadminfeitem.recordcount eq 0>
                            <cfset calculateadminfee = calculateadminfee + val((val(evaluate('B#replace(getpm.itemid,'B-','')#')) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))>

                            <tr>
                            <td>#getpm.itemname#</td>
                            <td>#val(evaluate('B#replace(getpm.itemid,'B-','')#'))#</td>
                            <td>#val((val(evaluate('B#replace(getpm.itemid,'B-','')#')) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))#</td>
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
                        
                        <cfif checkadminfeitem.recordcount eq 0>
                            <cfset calculateadminfee = calculateadminfee + val(evaluate(con))>  
                        
                            <tr>
                            <td>#getpm.itemname#</td>
                            <td>#val(evaluate('B#replace(getpm.itemid,'B-','')#'))#</td>
                            <td>#val(evaluate(con))#</td>
                            </tr>
                        </cfif>
                            
                        <cfelse>
                            
                        <cfif checkadminfeitem.recordcount eq 0>
                            <cfset calculateadminfee = calculateadminfee + val(evaluate('getpm.#a#adminfee'))>
                        
                            <tr>
                            <td>#getpm.itemname#</td>
                            <td>#val(evaluate('B#replace(getpm.itemid,'B-','')#'))#</td>
                            <td>#val(evaluate('getpm.#a#adminfee'))#</td>
                            </tr>
                        </cfif>
                            
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
                            
                        <cfif checkadminfeitem.recordcount eq 0>
                            <cfset calculateadminfee = calculateadminfee + val((val(awexc) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))>

                            <cfif numberformat((val(awexc) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100),'.__') gt 0>
                            
                             <tr>
                            <td>#getname.desp#</td>
                            <td>#val(awexc)#</td>
                            <td>#val((val(awexc) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))#</td>
                            </tr>
                            </cfif>
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
                   
                        <cfif checkadminfeitem.recordcount eq 0>
                            <cfset calculateadminfee = calculateadminfee + val(evaluate(con))>

                            <cfif numberformat(evaluate(con),'.__') gt 0>
                            
                             <tr>
                            <td>#getname.desp#</td>
                            <td>#val(awexc)#</td>
                            <td>#val(evaluate(con))#</td>
                            </tr>
                            </cfif>
                        </cfif>
                        <cfelse>
                            
                        <cfif checkadminfeitem.recordcount eq 0>
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
                            
                        <cfif checkadminfeitem.recordcount eq 0>
                            <cfset calculateadminfee = calculateadminfee + val((val(awexc) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))>

                            <cfif numberformat((val(awexc) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100),'.__') gt 0>
                            
                             <tr>
                            <td>#getname.desp#</td>
                            <td>#val(awexc)#</td>
                            <td>#val((val(awexc) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))#</td>
                            </tr>
                            </cfif>
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
                   
                        <cfif checkadminfeitem.recordcount eq 0>
                            <cfset calculateadminfee = calculateadminfee + val(evaluate(con))>

                            <cfif numberformat(evaluate(con),'.__') gt 0>
                            
                             <tr>
                            <td>#getname.desp#</td>
                            <td>#val(awexc)#</td>
                            <td>#numberformat(evaluate(con),'.__')#</td>
                            </tr>
                            </cfif>
                        </cfif>   
                            
                        <cfelse>
                            <cfif checkadminfeitem.recordcount eq 0>
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
                            
                        <cfif checkadminfeitem.recordcount eq 0>
                            <cfset calculateadminfee = calculateadminfee + val((val(evaluate('A#replace(getpm.itemid,'A-','')#')) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))>
                        
                             <tr>
                            <td>#getpm.itemname#</td>
                            <td>#val(evaluate('A#replace(getpm.itemid,'A-','')#'))#</td>
                            <td>#val((val(evaluate('A#replace(getpm.itemid,'A-','')#')) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))#</td>
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
                   
                        <cfif checkadminfeitem.recordcount eq 0>
                            <cfset calculateadminfee = calculateadminfee + val(evaluate(con))>

                             <tr>
                            <td>#getpm.itemname#</td>
                            <td>#val(evaluate('A#replace(getpm.itemid,'A-','')#'))#</td>
                            <td>#val(evaluate(con))#</td>
                            </tr>
                        </cfif>
                            
                        <cfelse>
                            
                        <cfif checkadminfeitem.recordcount eq 0>
                            <cfset calculateadminfee = calculateadminfee + val(evaluate('getpm.#a#adminfee'))>

                            <tr>
                            <td>#getpm.itemname#</td>
                            <td>#val(evaluate('A#replace(getpm.itemid,'A-','')#'))#</td>
                            <td>#val(evaluate('getpm.#a#adminfee'))#</td>
                            </tr>
                        </cfif>
                            
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
                        
                        <cfif checkadminfeitem.recordcount eq 0>
                            <cfset calculateadminfee = calculateadminfee + val((val(evaluate('A#replace(getpm.itemid,'A-','')#')) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))>

                            <tr>
                            <td>#getpm.itemname#</td>
                            <td>#val(evaluate('A#replace(getpm.itemid,'A-','')#'))#</td>
                            <td>#val((val(evaluate('A#replace(getpm.itemid,'A-','')#')) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))#</td>
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
                   
                        <cfif checkadminfeitem.recordcount eq 0>
                            <cfset calculateadminfee = calculateadminfee + val(evaluate(con))>

                            <tr>
                            <td>#getpm.itemname#</td>
                            <td>#val(evaluate('A#replace(getpm.itemid,'A-','')#'))#</td>
                            <td>#val(evaluate(con))#</td>
                            </tr>
                        </cfif>
                            
                        <cfelse>
                            
                        <cfif checkadminfeitem.recordcount eq 0>
                            <cfset calculateadminfee = calculateadminfee + val(evaluate('getpm.#a#adminfee'))>


                             <tr>
                            <td>#getpm.itemname#</td>
                            <td>#val(evaluate('A#replace(getpm.itemid,'A-','')#'))#</td>
                            <td>#val(evaluate('getpm.#a#adminfee'))#</td>
                            </tr>
                        </cfif>
                            
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
 
            <cfloop list="bill" index="a">
                	<cfif evaluate('getpm.#a#able') eq "Y" and evaluate('getpm.#a#adminfee') neq "">
						<cfif findnocase('%',evaluate('getpm.#a#adminfee'))>
                        <cfset calculateadminfee =  val((val(BASIC) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))>
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
                        
                       
                        <cfset calculateadminfee =  val(evaluate(con))>
                          <tr>
                        <td>#getpm.itemname#**</td>
                        <td>#val(BASIC)#</td>
                        <td>#val(evaluate(con))#</td>
                        </tr>
                            
                        <cfelse>
                        <cfset calculateadminfee =  val(evaluate('getpm.#a#adminfee'))>
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
            <cfset socsoremain = 3900.01>
            <cfset socsopayin = 3900.01>
			</cfif>
            <cfset socsoremain = socsoremain - BASIC>
            <cfif eisremain gt 3900>
            <cfset eisremain = 3900.01>
			</cfif>
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
                        <td>#numberformat(((awamt/val(url.epfpayin)) * EPFYER),'.__')#</td>                        <td>#val(numberformat(((awamt/val(url.epfpayin)) * EPFYER),'.__') * (replacenocase(getpmsafaw.billadminfee,'%','')/100))#</td>
                        </tr>
                 
                    <cfset totalepf = totalepf - numberformat(((awamt/val(url.epfpayin)) * EPFYER))> 
				</cfif>
                 <cfif checkdetails.aw_hrd eq 1 and isdefined('totalA#replace(getpmsafaw.itemid,'A-','')#') and val(url.socsopayin) neq 0 and socsoremain gt 0>
                	<cfset awamt = val(evaluate('totalA#replace(getpmsafaw.itemid,'A-','')#'))>
                    <cfif socsoremain lt awamt>
                    <cfset awamt = socsoremain>
					</cfif>
                    <cfset socsoremain = SOCSOREMAIN - awamt>
                    <cfset calculateadminfee = calculateadminfee + val(numberformat(((awamt/val(url.socsopayin)) * SOCSOYER),'.__') * (replacenocase(getpmsafaw.billadminfee,'%','')/100))>
                     <tr>
                        <td>#getpmsafaw.itemname# SOCSO</td>
                        <td>#numberformat(((awamt/val(url.socsopayin)) * SOCSOYER),'.__')#</td>
                        <td>#val(numberformat(((awamt/val(url.socsopayin)) * SOCSOYER),'.__') * (replacenocase(getpmsafaw.billadminfee,'%','')/100))#</td>
                        </tr>                     
                    
                    <cfset totalsocso = totalsocso - numberformat(((awamt/val(url.socsopayin)) * SOCSOYER),'.__')>
				</cfif>
                        
                <!---Added by Nieo 20180119 1017, EIS added--->
                <cfif checkdetails.aw_hrd eq 1 and isdefined('totalA#replace(getpmsafaw.itemid,'A-','')#') and val(url.socsopayin) neq 0 and eisremain gt 0>
                	<cfset awamt = val(evaluate('totalA#replace(getpmsafaw.itemid,'A-','')#'))>
                    <cfif eisremain lt awamt>
                    <cfset awamt = eisremain>
					</cfif>
                    <cfset eisremain = eisremain - awamt>
                    <cfset calculateadminfee = calculateadminfee + val(numberformat(((awamt/val(url.socsopayin)) * EISYER),'.__') * (replacenocase(getpmsafaw.billadminfee,'%','')/100))>
                     <tr>
                        <td>#getpmsafaw.itemname# EIS</td>
                        <td>#numberformat(((awamt/val(url.socsopayin)) * EISYER),'.__')#</td>
                        <td>#val(numberformat(((awamt/val(url.socsopayin)) * EISYER),'.__') * (replacenocase(getpmsafaw.billadminfee,'%','')/100))#</td>
                        </tr>
                        
                    <cfset totaleis = val(totaleis) - numberformat(((awamt/val(url.socsopayin)) * totaleis),'.__')>
				</cfif>
                <!---Added by Nieo 20180119 1017, EIS added--->
                
				</cfif>
                
            </cfloop>
			</cfif>
 
            <cfquery name="getpmsafexc" datasource="#dts#">
            SELECT * FROM manpowerpricematrixdetail WHERE priceid = "#getplacement.pm#" AND saf = "Y" and left(itemid,2) = "ALLAWEXC" AND billadminfee LIKE '%\%%'  and billable = "Y"  ORDER BY billadminfee
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
                            <td>#numberformat(((awamt/val(url.epfpayin)) * EPFYER),'.__')#</td>
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
                            <td>#numberformat(((awamt/val(url.socsopayin)) * SOCSOYER),'.__')#</td>
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
                            <td>#numberformat(((awamt/val(url.socsopayin)) * EISYER),'.__')#</td>
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
                            <td>#numberformat(((awamt/val(url.epfpayin)) * EPFYER),'.__')#</td>
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
                            <td>#numberformat(((awamt/val(url.socsopayin)) * SOCSOYER),'.__')#</td>
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
                            <td>#numberformat(((awamt/val(url.socsopayin)) * EISYER),'.__')#</td>
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
                        <td>#numberformat((val(otamt/val(url.socsopayin))* SOCSOYER),'.__')#</td>
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
                        <td>#numberformat((val(otamt/val(url.socsopayin))* EISYER),'.__')#</td>
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
                        <cfset calculateadminfee = calculateadminfee + val((val(evaluate('#getpmepf.itemid#')) * replacenocase(evaluate('getpmepf.#a#adminfee'),'%','')/100))>
                        <tr>
                        <td>#getpmepf.itemname#</td>
                        <td>#val(evaluate('#getpmepf.itemid#'))#</td>
                        <td>#val((val(evaluate('#getpmepf.itemid#')) * replacenocase(evaluate('getpmepf.#a#adminfee'),'%','')/100))#</td>
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
                        <cfset calculateadminfee = calculateadminfee + val((val(evaluate('#getpmsocso.itemid#')) * replacenocase(evaluate('getpmsocso.#a#adminfee'),'%','')/100))>
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
						#val((val(evaluate('#getpmsocso.itemid#')) * replacenocase(evaluate('getpmsocso.#a#adminfee'),'%','')/100))#
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
                        <cfset calculateadminfee = calculateadminfee + val((val(evaluate('#getpmeis.itemid#')) * replacenocase(evaluate('getpmeis.#a#adminfee'),'%','')/100))>
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
						#val((val(evaluate('#getpmeis.itemid#')) * replacenocase(evaluate('getpmeis.#a#adminfee'),'%','')/100))#
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
            
           
            
			</cfif>
            </table>
            </cfoutput>
            <cfoutput>
			<input type="hidden" name="totaladminfee" id="totaladminfee" value="#numberformat(calculateadminfee,'.__')#" >
            </cfoutput>