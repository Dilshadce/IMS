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
            <cfset BASIC = val(getpaydata.basicpay)>
            <cfset BASICPAY = val(getpaydata.basicpay)>
            <cfset EPFYEE = val(getpaydata.epfww)>
            <cfset EPFYER = val(getpaydata.epfcc)>
            <cfset SOCSOYEE = val(getpaydata.socsoww)>
            <cfset SOCSOYER = val(getpaydata.socsocc)>
            <cfset EPF_TOTAL = val(EPFYEE + EPFYER)>
            <cfset SOCSO_TOTAL = val(SOCSOYEE + SOCSOYER)>
            <cfset OT1 = val(getpaydata.ot1)>
            <cfset OT15 = val(getpaydata.ot2)>
            <cfset OT2 = val(getpaydata.ot3)>
            <cfset OT3 = val(getpaydata.ot4)>
            <cfset AW_TOTAL = val(getpaydata.taw)>
            <cfset OT_TOTAL = val(getpaydata.otpay)>
            <cfset GROSSPAY = val(getpaydata.grosspay)>
            <cfset NETPAY = val(getpaydata.netpay)>
			<cfif grosspay neq 0>
			<cfset EPF_OT = numberformat(EPFYER*OT_TOTAL/grosspay,'.__')>
            <cfelse>
            <cfset EPF_OT = 0>
            </cfif>
            <cfif basicpay lte 4000 and grosspay neq 0>
            <cfset SOCSO_OT = numberformat(SOCSOYER*OT_TOTAL/grosspay,'.__')>
			<cfelse>
            <cfset SOCSO_OT = 0>
            </cfif>
            <cfset totalfixaw = 0>
            <cfset totalvaraw = 0>
			<cfif getplacement.pm neq "">
            <cfquery name="getpm" datasource="#dts#">
            SELECT * FROM manpowerpricematrixdetail WHERE priceid = "#getplacement.pm#" ORDER BY Trancode
            </cfquery>
            <cfquery name="getitemlist" datasource="#dts#">
            SELECT itemno FROM icitem WHERE itemno <> "adminfee"
            </cfquery>
            <cfloop query="getpm">
            
            	<cfif listfindnocase(valuelist(getitemlist.itemno),getpm.itemid)>
                	<cfloop list="pay,bill" index="a">
                	<cfif evaluate('getpm.#a#able') eq "Y" and evaluate('getpm.#a#adminfee') neq "">
						<cfif findnocase('%',evaluate('getpm.#a#adminfee'))>
                        <cfset calculateadminfee = calculateadminfee + numberformat((val(evaluate('#getpm.itemid#')) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100),'.__')>
                        <cfelseif left(evaluate('getpm.#a#adminfee'),1) eq "=">
                        <cfset con = evaluate('getpm.#a#adminfee')>
                        <cfset con = right(con,len(con)-1)>
						<cfset con = Replace(con,"<="," lte ","all") >
				        <cfset con = Replace(con,">="," gte ","all") >
				        <cfset con = Replace(con,">"," gt ","all") >
				        <cfset con = Replace(con,"<"," lt ","all") >
						<cfset con = Replace(con,"!="," neq ","all") >
				        <cfset con = Replace(con,"="," eq ","all") >
                      
                        <cfset calculateadminfee = calculateadminfee + numberformat(evaluate(con),'.__')>
                        <cfelse>
                        <cfset calculateadminfee = calculateadminfee + val(evaluate('getpm.#a#adminfee'))>
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
                        <cfset calculateadminfee = calculateadminfee + numberformat((val(evaluate('B#replace(getpm.itemid,'B-','')#')) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100),'.__')>
                        <cfelseif left(evaluate('getpm.#a#adminfee'),1) eq "=">
                        <cfset con = evaluate('getpm.#a#adminfee')>
                        <cfset con = right(con,len(con)-1)>
						<cfset con = Replace(con,"<="," lte ","all") >
				        <cfset con = Replace(con,">="," gte ","all") >
				        <cfset con = Replace(con,">"," gt ","all") >
				        <cfset con = Replace(con,"<"," lt ","all") >
						<cfset con = Replace(con,"!="," neq ","all") >
				        <cfset con = Replace(con,"="," eq ","all") >
                        
                        <cfset calculateadminfee = calculateadminfee + numberformat(evaluate(con),'.__')>
                        <cfelse>
                        <cfset calculateadminfee = calculateadminfee + val(evaluate('getpm.#a#adminfee'))>
                        </cfif>
                    </cfif>
                    </cfloop>
                        
                        
					</cfif>
                  </cfloop>
                 <cfelseif left(getpm.itemid,2) eq "A-" or getpm.itemid eq "ALLAWEXC">
                
                
                 
                 <cfif getpm.itemid eq "ALLAWEXC">
                 
                  <cfset excludeaw = "0,">
                 <cfquery name="getpmdetails" datasource="#dts#">
            SELECT * FROM manpowerpricematrixdetail WHERE priceid = "#getplacement.pm#" ORDER BY Trancode
            </cfquery>
                 <cfloop query="getpmdetails">
                 <cfif left(getpmdetails.itemid,2) eq "A-" and (getpmdetails.billadminfee eq "0%" or getpmdetails.billadminfee eq "0")>
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
						<cfif findnocase('%',evaluate('getpm.#a#adminfee'))>
                        <cfset calculateadminfee = calculateadminfee + numberformat((val(awexc) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100),'.__')>
                        <cfelseif left(evaluate('getpm.#a#adminfee'),1) eq "=">
                        <cfset con = evaluate('getpm.#a#adminfee')>
                        <cfset con = right(con,len(con)-1)>
						<cfset con = Replace(con,"<="," lte ","all") >
				        <cfset con = Replace(con,">="," gte ","all") >
				        <cfset con = Replace(con,">"," gt ","all") >
				        <cfset con = Replace(con,"<"," lt ","all") >
						<cfset con = Replace(con,"!="," neq ","all") >
				        <cfset con = Replace(con,"="," eq ","all") >
                   
                        <cfset calculateadminfee = calculateadminfee + numberformat(evaluate(con),'.__')>
                        <cfelse>
                        <cfset calculateadminfee = calculateadminfee + val(evaluate('getpm.#a#adminfee'))>
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
						<cfif findnocase('%',evaluate('getpm.#a#adminfee'))>
                        <cfset calculateadminfee = calculateadminfee + numberformat((val(awexc) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100),'.__')>
                        <cfelseif left(evaluate('getpm.#a#adminfee'),1) eq "=">
                        <cfset con = evaluate('getpm.#a#adminfee')>
                        <cfset con = right(con,len(con)-1)>
						<cfset con = Replace(con,"<="," lte ","all") >
				        <cfset con = Replace(con,">="," gte ","all") >
				        <cfset con = Replace(con,">"," gt ","all") >
				        <cfset con = Replace(con,"<"," lt ","all") >
						<cfset con = Replace(con,"!="," neq ","all") >
				        <cfset con = Replace(con,"="," eq ","all") >
                   
                        <cfset calculateadminfee = calculateadminfee + numberformat(evaluate(con),'.__')>
                        <cfelse>
                        <cfset calculateadminfee = calculateadminfee + val(evaluate('getpm.#a#adminfee'))>
                        </cfif>
                    </cfif>
                    </cfloop>
                        
                        
					</cfif>
                  </cfloop>
                  
                 
                 <cfelse>
                 <cfset "A#replacenocase(getpm.itemid,'A-','')#" = 0>
                 	<cfloop from="1" to="6" index="aa">
                  	<cfif evaluate('url.fixawcode#aa#') eq replace(getpm.itemid,'A-','') and (val(evaluate('url.fixawer#aa#')) neq 0 or val(evaluate('url.fixawee#aa#')) neq 0)>
                    	
                        <cfloop list="pay,bill" index="a">
                        <cfif a eq "pay">
						<cfset "A#replacenocase(getpm.itemid,'A-','')#" = val(evaluate('url.fixawee#aa#'))>
                        <cfelse>
                        <cfset "A#replacenocase(getpm.itemid,'A-','')#" = val(evaluate('url.fixawer#aa#'))>
                        <cfset totalfixaw =  totalfixaw + val(evaluate('url.fixawer#aa#'))>
                        </cfif>
                	<cfif evaluate('getpm.#a#able') eq "Y" and evaluate('getpm.#a#adminfee') neq "">
						<cfif findnocase('%',evaluate('getpm.#a#adminfee'))>
                        <cfset calculateadminfee = calculateadminfee + numberformat((val(evaluate('A#replace(getpm.itemid,'A-','')#')) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100),'.__')>
                        <cfelseif left(evaluate('getpm.#a#adminfee'),1) eq "=">
                        <cfset con = evaluate('getpm.#a#adminfee')>
                        <cfset con = right(con,len(con)-1)>
						<cfset con = Replace(con,"<="," lte ","all") >
				        <cfset con = Replace(con,">="," gte ","all") >
				        <cfset con = Replace(con,">"," gt ","all") >
				        <cfset con = Replace(con,"<"," lt ","all") >
						<cfset con = Replace(con,"!="," neq ","all") >
				        <cfset con = Replace(con,"="," eq ","all") >
                   
                        <cfset calculateadminfee = calculateadminfee + numberformat(evaluate(con),'.__')>
                        <cfelse>
                        <cfset calculateadminfee = calculateadminfee + val(evaluate('getpm.#a#adminfee'))>
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
                        <cfset totalvaraw =  totalvaraw + val(evaluate('url.awer#aa#'))>
                        </cfif>
                	<cfif evaluate('getpm.#a#able') eq "Y" and evaluate('getpm.#a#adminfee') neq "">
						<cfif findnocase('%',evaluate('getpm.#a#adminfee'))>
                        <cfset calculateadminfee = calculateadminfee + numberformat((val(evaluate('A#replace(getpm.itemid,'A-','')#')) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100),'.__')>
                        <cfelseif left(evaluate('getpm.#a#adminfee'),1) eq "=">
                        <cfset con = evaluate('getpm.#a#adminfee')>
                        <cfset con = right(con,len(con)-1)>
						<cfset con = Replace(con,"<="," lte ","all") >
				        <cfset con = Replace(con,">="," gte ","all") >
				        <cfset con = Replace(con,">"," gt ","all") >
				        <cfset con = Replace(con,"<"," lt ","all") >
						<cfset con = Replace(con,"!="," neq ","all") >
				        <cfset con = Replace(con,"="," eq ","all") >
                   
                        <cfset calculateadminfee = calculateadminfee + numberformat(evaluate(con),'.__')>
                        <cfelse>
                        <cfset calculateadminfee = calculateadminfee + val(evaluate('getpm.#a#adminfee'))>
                        </cfif>
                    </cfif>
                    </cfloop>
                        
                        
					</cfif>
                  </cfloop>
                  </cfif>
                   <cfelseif getpm.itemid eq "ADMINFEE">
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
                    <cfoutput>
                    EPF_FIXAW = #EPF_FIXAW#<br>
                    SOCSO_FIXAW = #SOCSO_FIXAW#<br>
                    <br>
<br>
					EPF_VARAW = #EPF_VARAW#<br>
                    SOCSO_VARAW = #SOCSO_VARAW#<br>
                    
                    </cfoutput>
            <cfloop list="bill" index="a">
                	<cfif evaluate('getpm.#a#able') eq "Y" and evaluate('getpm.#a#adminfee') neq "">
						<cfif findnocase('%',evaluate('getpm.#a#adminfee'))>
                        <cfset calculateadminfee = calculateadminfee + numberformat((val(BASIC) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100),'.__')>
                        <cfelseif left(evaluate('getpm.#a#adminfee'),1) eq "=">
                        
                        <cfset con = evaluate('getpm.#a#adminfee')>
                        <cfset con = right(con,len(con)-1)>
						<cfset con = Replace(con,"<="," lte ","all") >
				        <cfset con = Replace(con,">="," gte ","all") >
				        <cfset con = Replace(con,">"," gt ","all") >
				        <cfset con = Replace(con,"<"," lt ","all") >
						<cfset con = Replace(con,"!="," neq ","all") >
				        <cfset con = Replace(con,"="," eq ","all") >
                        
                       
                        <cfset calculateadminfee = calculateadminfee + numberformat(evaluate(con),'.__')>
                        <cfelse>
                        <cfset calculateadminfee = calculateadminfee + val(evaluate('getpm.#a#adminfee'))>
                        </cfif>
                    </cfif>
                    </cfloop>
                 
				</cfif>
            </cfloop>
            
           
            
			</cfif>
            <cfoutput>
			<input type="hidden" name="totaladminfee" id="totaladminfee" value="#numberformat(calculateadminfee,'.__')#" >
            </cfoutput>