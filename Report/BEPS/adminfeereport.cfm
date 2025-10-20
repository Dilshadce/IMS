		<cfoutput>
            
        <cfquery name="getpayroll" datasource="payroll_main">
        SELECT mmonth,myear FROM gsetup 
        WHERE comp_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#replace(dts,'_i','')#">
        </cfquery>
            
        <cfquery name="getgsetup2" datasource='#dts#'>
        select * from gsetup2
        </cfquery>
            
        <cfquery name="getassignmentslip" datasource="#dts#">
        SELECT a.*,pm.pricename FROM assignmentslip a
        LEFT JOIN placement p
        ON a.placementno=p.placementno
        LEFT JOIN manpowerpricematrix pm
        ON pm.priceid=p.pm
        WHERE 1=1
        AND a.created_on > #createdate(getpayroll.myear,1,7)#
        AND a.adminfee >0
        <cfif form.month neq '' and form.monthto neq ''>
        AND a.payrollperiod between #form.month# and #form.monthto#
        </cfif>
        <cfif form.getempfrom neq '' and form.getempto neq ''>
        AND a.empno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.getempfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.getempto#">
        </cfif>
        <cfif form.getfrom neq '' and form.getto neq ''>
        AND a.custno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.getfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.getto#">
        </cfif>
        <cfif form.billfrom neq '' and form.billto neq ''>
        AND a.refno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billto#">
        </cfif>
        <cfif form.createdfrm neq "" and form.createdto neq "">
        and (a.created_by BETWEEN <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.createdfrm#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.createdto#">)
        </cfif>
        <cfif isdefined('form.batches')>
        and a.batches in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.batches#" separator="," list="yes">)
        </cfif>
            
        </cfquery> 
            
        <cfset iDecl_UPrice=getgsetup2.Decl_UPrice>
        <cfset stDecl_UPrice="">
        <cfset stDecl_UPrice2 = ",.">
        <cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
            <cfset stDecl_UPrice=stDecl_UPrice&"0">
            <cfset stDecl_UPrice2 = stDecl_UPrice2 & "_">
        </cfloop>
                
        <!--- ============ SETTING table headers for excel file ==================== --->
		<cfset headerFields = [
			"Customer No","Customer Name", "Employee No", "Emplyee Name", "Placement No ", "Price Structure ", "Refno", "Invoice No", "Item", "Amount", "Admin Fee"
			] />
		<!--- ============CREATING THE TABLE FOR THE EXCEL FILE==================== --->
		<cfxml variable="data">
			<cfinclude template='/excel_template/excel_header.cfm'>
			<Worksheet ss:Name="Admin Fee Details Report">
			<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
				<Column ss:Width="64.5"/>
				<Column ss:Width="60.25"/>
				<Column ss:Width="183.75"/>
				<Column ss:AutoFitWidth="0" ss:Width="60"/>
				<Column ss:Width="47.25"/>
				<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
				<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
				<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
				<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
				<Row ss:AutoFitHeight="0" ss:Height="23.0625">
					<cfloop array="#headerFields#" index="field" >
						<Cell ss:StyleID="s27">
							<Data ss:Type="String">
								<cfoutput>
									#field#
								</cfoutput>
							</Data>
						</Cell>
					</cfloop>
				</Row>
                <cfset paydts=replace(dts,'_i','_p','all')>
                    
                <cfset calculateadminfee = 0>
                    
                <cfset socsopayin = 0>
                <cfset epfpayin = 0>

                <cfset RATEYER = 0>
                <cfset RATEYEE = 0>
                <cfset BASIC = 0>
                <cfset BASICPAY = 0>
                <cfset BASIC = 0>
                <cfset BASICPAY = 0>
                <cfset EPFYEE = 0>
                <cfset EPFYER = 0>
                <cfset SOCSOYEE = 0>  
                <cfset SOCSOYER = 0>
                <cfset EISYEE = 0>  
                <cfset EISYER = 0>
                <cfset EPF_TOTAL = 0>
                <cfset SOCSO_TOTAL = 0>
                <cfset OT1 = 0>
                <cfset OT15 = 0>
                <cfset OT2 = 0>
                <cfset OT3 = 0>
                <cfset OT5 = 0>
                <cfset OT6 = 0>
                <cfset OT7 = 0>
                <cfset OT8 = 0>

                <cfset AW_TOTAL = 0>
                <cfset OT_TOTAL = 0>
                <cfset GROSSPAY = 0>
                <cfset NETPAY = 0>
                <cfset NPL = 0>
                    
                <cfset totalfixaw = 0>
                <cfset totalvaraw = 0>
                    
                <cfset totalepf = 0>
                    
                <cfquery name="socaw" datasource="#paydts#">
                SELECT * FROM awtable where AW_HRD = 1 AND AW_COU<18 ORDER BY AW_cou 
                </cfquery>

                <cfquery name="socded" datasource="#paydts#">
                SELECT * FROM dedtable where DED_HRD = 1  ORDER BY ded_cou 
                </cfquery>	
                    
            <cfloop query="getassignmentslip">
            
            <cfquery name="checkadminfeitem" datasource="#dts#">
            SELECT itemno FROM icitem WHERE itemno <> "adminfee"
            </cfquery>
                
            <cfset weekpay = getassignmentslip.emppaymenttype>
                
            <cfif getpayroll.mmonth neq form.month and getpayroll.mmonth neq form.monthto>
                <cfset weekpay = "pay_12m">
            </cfif>
            
            <cfquery name="getpaydata" datasource="#paydts#">
            SELECT * FROM #weekpay# WHERE empno = "#getassignmentslip.empno#"
            <cfif getpayroll.mmonth neq form.month and getpayroll.mmonth neq form.monthto> 
                and tmonth = #form.month#
            </cfif>
            </cfquery>
                
            
            
            <cfquery name="getplacement" datasource="#dts#">
            SELECT * FROM placement WHERE placementno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignmentslip.placementno#"/>
            </cfquery>
                
            <cfif getplacement.pm eq ''>
                <cfcontinue>    
            </cfif>
                
            
                
            <cfquery name="totalsocsowage" datasource="#paydts#">
                SELECT (coalesce(basicpay,0)+coalesce(otpay,0)
                <cfloop query="socaw">
                +coalesce(aw#100+socaw.aw_cou#,0)
                </cfloop>
                <cfloop query="socded">
                -coalesce(ded#100+socded.ded_cou#,0)
                </cfloop>) as socsowage
                FROM #weekpay#
                WHERE empno = "#getassignmentslip.empno#"
                <cfif getpayroll.mmonth neq form.month and getpayroll.mmonth neq form.monthto> 
                and tmonth = #form.month#
                </cfif>
            </cfquery>
            
            <cfset socsopayin = val(totalsocsowage.socsowage)>
            <cfset epfpayin = val(getpaydata.epf_pay_a)>

            <cfset calculateadminfee = 0>
            <cfset RATEYER = val(getplacement.employer_rate_1)>
            <cfset RATEYEE = val(getplacement.employee_rate_1)>
            <cfset BASIC = val(getassignmentslip.custsalary)>
            <cfset BASICPAY = val(getassignmentslip.custsalary)>
            <cfset BASIC = val(BASIC) + val(getassignmentslip.lvltotaler1)>
            <cfset BASICPAY = val(BASICPAY) + val(getassignmentslip.lvltotaler1)>
            <cfset EPFYEE = val(getpaydata.epfww)>
            <cfset EPFYER = val(getassignmentslip.custcpf)>
            <cfset SOCSOYEE = val(getpaydata.socsoww)>   
            <cfset SOCSOYER = val(getassignmentslip.custsdf)>
            <cfset EISYEE = val(getpaydata.eisww)>   
            <cfset EISYER = val(getassignmentslip.custeis)>
            <cfset EPF_TOTAL = val(EPFYEE) + val(getassignmentslip.custcpf)>
            <cfset SOCSO_TOTAL = val(SOCSOYEE) + val(getassignmentslip.custsdf)>
            <cfset OT1 = val(getassignmentslip.custot1)>
            <cfset OT15 = val(getassignmentslip.custot2)>
            <cfset OT2 = val(getassignmentslip.custot3)>
            <cfset OT3 = val(getassignmentslip.custot4)>
            <cfset OT5 = val(getassignmentslip.custot5)>
            <cfset OT6 = val(getassignmentslip.custot6)>
            <cfset OT7 = val(getassignmentslip.custot7)>
            <cfset OT8 = val(getassignmentslip.custot8)>
            
            <cfset AW_TOTAL = val(getpaydata.taw)>
            <cfset OT_TOTAL = val(getpaydata.otpay)>
            <cfset GROSSPAY = val(getpaydata.grosspay)>
            <cfset NETPAY = val(getpaydata.netpay)>
<!--- 			<cfif grosspay neq 0>
			<cfset EPF_OT = numberformat(EPFYER*OT_TOTAL/grosspay,'.__')>
            <cfelse>
            <cfset EPF_OT = 0>
            </cfif> --->
                
            <cfscript>
                fieldValues = [
				getassignmentslip.custno,
                getassignmentslip.custname,
                getassignmentslip.empno,
                getassignmentslip.empname,
                getassignmentslip.placementno,
                getassignmentslip.pricename,
                getassignmentslip.refno,
                getassignmentslip.invoiceno
                ];
            </cfscript>
                
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
                	<cfloop list="bill" index="a">
                	<cfif evaluate('getpm.#a#able') eq "Y" and evaluate('getpm.#a#adminfee') neq "" and val(evaluate('#getpm.itemid#')) neq 0>
						<cfif findnocase('%',evaluate('getpm.#a#adminfee'))>
                            
                        <cfif checkadminfeitem.recordcount eq 0>
                            <cfset calculateadminfee = calculateadminfee + val((val(evaluate('#getpm.itemid#')) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))>
                            <Row>
                                <cfloop from="1" to="#ArrayLen(fieldValues)#" index="i">
                                    <cfwddx action = "cfml2wddx" input = "#fieldValues[i]#" output = "wddxText#i#">
                                    <Cell><Data ss:Type="String">#evaluate('wddxText#i#')#</Data></Cell>
                                </cfloop>
                                <cfwddx action = "cfml2wddx" input = "#getpm.itemname#" output = "wddxText100">
                                <Cell><Data ss:Type="String">#wddxText100#</Data></Cell><!---item Name--->
                                <cfif val(evaluate('#getpm.itemid#')) neq 0>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(evaluate('#getpm.itemid#'))#</Data></Cell>
                                <cfelse>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                                </cfif>
                                <cfif numberformat((val(evaluate('#getpm.itemid#')) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100),'.__') neq 0>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">#val((val(evaluate('#getpm.itemid#')) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))#</Data></Cell>
                                <cfelse>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                                </cfif>
                            </Row>
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
                        <Row>
                            <cfloop from="1" to="#ArrayLen(fieldValues)#" index="i">
                                <cfwddx action = "cfml2wddx" input = "#fieldValues[i]#" output = "wddxText#i#">
                                <Cell><Data ss:Type="String">#evaluate('wddxText#i#')#</Data></Cell>
                            </cfloop>
                            <cfwddx action = "cfml2wddx" input = "#getpm.itemname#" output = "wddxText#i#">
                            <Cell><Data ss:Type="String">#evaluate('wddxText#i#')#</Data></Cell><!---item Name--->
                            <cfif val(evaluate('#getpm.itemid#')) neq 0>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(evaluate('#getpm.itemid#'))#</Data></Cell>
                            <cfelse>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                            </cfif>
                            <cfif numberformat(evaluate(con),'.__') neq 0>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(evaluate(con))#</Data></Cell>
                            <cfelse>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                            </cfif>                            
                        </Row>
                        </cfif>
                            
                        <cfelse>
                            
                        <cfif checkadminfeitem.recordcount eq 0>
                        <cfset calculateadminfee = calculateadminfee + val(evaluate('getpm.#a#adminfee'))>
                        <Row>
                            <cfloop from="1" to="#ArrayLen(fieldValues)#" index="i">
                                <cfwddx action = "cfml2wddx" input = "#fieldValues[i]#" output = "wddxText#i#">
                                <Cell><Data ss:Type="String">#evaluate('wddxText#i#')#</Data></Cell>
                            </cfloop>
                            <cfwddx action = "cfml2wddx" input = "#getpm.itemname#" output = "wddxText100">
                            <Cell><Data ss:Type="String">#wddxText100#</Data></Cell><!---item Name--->
                            <cfif val(evaluate('#getpm.itemid#')) neq 0>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(evaluate('#getpm.itemid#'))#</Data></Cell>
                            <cfelse>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                            </cfif>
                            <cfif val(evaluate('getpm.#a#adminfee')) neq 0>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(evaluate('getpm.#a#adminfee'))#</Data></Cell>
                            <cfelse>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                            </cfif>
                            
                        </Row>
                        </cfif>
                        </cfif>
                    </cfif>
                    </cfloop>
                    
                 <cfelseif left(getpm.itemid,2) eq "B-">
			<cfset "B#replace(getpm.itemid,'B-','')#" = 0>
                  <cfloop from="1" to="6" index="bb">
                  	<cfif evaluate('getassignmentslip.billitem#bb#') eq replace(getpm.itemid,'B-','')>
                    	<cfset "B#replace(getpm.itemid,'B-','')#" = val(evaluate('getassignmentslip.billitemamt#bb#'))>
                        <cfloop list="bill" index="a">
                	<cfif evaluate('getpm.#a#able') eq "Y" and evaluate('getpm.#a#adminfee') neq "" and val(evaluate('B#replace(getpm.itemid,'B-','')#')) neq 0  and evaluate('getpm.#a#adminfee') neq 0>
						<cfif findnocase('%',evaluate('getpm.#a#adminfee'))>
                        
                        <cfif checkadminfeitem.recordcount eq 0>
                        <cfset calculateadminfee = calculateadminfee + val((val(evaluate('B#replace(getpm.itemid,'B-','')#')) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))>
                        <Row>
                            <cfloop from="1" to="#ArrayLen(fieldValues)#" index="i">
                                <cfwddx action = "cfml2wddx" input = "#fieldValues[i]#" output = "wddxText#i#">
                                <Cell><Data ss:Type="String">#evaluate('wddxText#i#')#</Data></Cell>
                            </cfloop>
                            <cfwddx action = "cfml2wddx" input = "#getpm.itemname#" output = "wddxText100">
                            <Cell><Data ss:Type="String">#wddxText100#</Data></Cell><!---item Name--->
                            <cfif val(evaluate('B#replace(getpm.itemid,'B-','')#')) neq 0>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(evaluate('B#replace(getpm.itemid,'B-','')#'))#</Data></Cell>
                            <cfelse>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                            </cfif>
                            <cfif numberformat((val(evaluate('B#replace(getpm.itemid,'B-','')#')) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100),'.__') neq 0>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(val(val(evaluate('B#replace(getpm.itemid,'B-','')#')) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))#</Data></Cell>
                            <cfelse>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                            </cfif>
                            
                        </Row>
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
                        <Row>
                            <cfloop from="1" to="#ArrayLen(fieldValues)#" index="i">
                                <cfwddx action = "cfml2wddx" input = "#fieldValues[i]#" output = "wddxText#i#">
                                <Cell><Data ss:Type="String">#evaluate('wddxText#i#')#</Data></Cell>
                            </cfloop>
                            <cfwddx action = "cfml2wddx" input = "#getpm.itemname#" output = "wddxText#i#">
                            <Cell><Data ss:Type="String">#evaluate('wddxText#i#')#</Data></Cell><!---item Name--->
                            <cfif val(evaluate('B#replace(getpm.itemid,'B-','')#')) neq 0>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(evaluate('B#replace(getpm.itemid,'B-','')#'))#</Data></Cell>
                            <cfelse>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                            </cfif>
                            <cfif numberformat(evaluate(con),'.__') neq 0>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(val(evaluate(con)))#</Data></Cell>
                            <cfelse>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                            </cfif>                            
                        </Row>
                        </cfif>
                                
                        <cfelse>
                            
                        <cfif checkadminfeitem.recordcount eq 0>
                        <cfset calculateadminfee = calculateadminfee + val(evaluate('getpm.#a#adminfee'))>
                        <Row>
                            <cfloop from="1" to="#ArrayLen(fieldValues)#" index="i">
                                <cfwddx action = "cfml2wddx" input = "#fieldValues[i]#" output = "wddxText#i#">
                                <Cell><Data ss:Type="String">#evaluate('wddxText#i#')#</Data></Cell>
                            </cfloop>
                            <cfwddx action = "cfml2wddx" input = "#getpm.itemname#" output = "wddxText100">
                            <Cell><Data ss:Type="String">#wddxText100#</Data></Cell><!---item Name--->
                            <cfif val(evaluate('B#replace(getpm.itemid,'B-','')#')) neq 0>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(evaluate('B#replace(getpm.itemid,'B-','')#'))#</Data></Cell>
                            <cfelse>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                            </cfif>
                            <cfif val(evaluate('getpm.#a#adminfee')) neq 0>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(evaluate('getpm.#a#adminfee'))#</Data></Cell>
                            <cfelse>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                            </cfif>
                        </Row>
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
                  	<cfif listfindnocase(excludeaw,evaluate('getassignmentslip.fixawcode#aa#')) eq false and evaluate('getassignmentslip.fixawcode#aa#') neq 0>
                    	
                        <cfloop list="bill" index="a">
                        <cfif a eq "pay">
						<cfset awexc = val(evaluate('getassignmentslip.fixawee#aa#'))>
                        <cfelse>
                        <cfset awexc = val(evaluate('getassignmentslip.fixawer#aa#'))>
                        <cfset totalfixaw =  totalfixaw + val(evaluate('getassignmentslip.fixawer#aa#'))>
                        </cfif>
                	<cfif evaluate('getpm.#a#able') eq "Y" and evaluate('getpm.#a#adminfee') neq "" and val(awexc) neq 0>
                    <cfquery name="getname" datasource="#dts#">
                        select * from icshelf where shelf = "#evaluate('getassignmentslip.fixawcode#aa#')#"
                        </cfquery>
                        
						<cfif findnocase('%',evaluate('getpm.#a#adminfee'))>
                            
                        <cfif checkadminfeitem.recordcount eq 0>
                            <cfset calculateadminfee = calculateadminfee + val((val(awexc) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))>

                            <cfif numberformat((val(awexc) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100),'.__') gt 0>
                                <Row>
                                    <cfloop from="1" to="#ArrayLen(fieldValues)#" index="i">
                                        <cfwddx action = "cfml2wddx" input = "#fieldValues[i]#" output = "wddxText#i#">
                                        <Cell><Data ss:Type="String">#evaluate('wddxText#i#')#</Data></Cell>
                                    </cfloop>
                                    <cfwddx action = "cfml2wddx" input = "#getname.desp#" output = "wddxText100">
                                    <Cell><Data ss:Type="String">#wddxText100#</Data></Cell><!---item Name--->
                                    <cfif val(awexc) neq 0>
                                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(awexc)#</Data></Cell>
                                    <cfelse>
                                        <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                                    </cfif>
                                    <cfif numberformat((val(awexc) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100),'.__') neq 0>
                                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(val(val(awexc) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))#</Data></Cell>
                                    <cfelse>
                                        <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                                    </cfif>
                                </Row>
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
                                <Row>
                                    <cfloop from="1" to="#ArrayLen(fieldValues)#" index="i">
                                        <cfwddx action = "cfml2wddx" input = "#fieldValues[i]#" output = "wddxText#i#">
                                        <Cell><Data ss:Type="String">#evaluate('wddxText#i#')#</Data></Cell>
                                    </cfloop>
                                    <cfwddx action = "cfml2wddx" input = "#getname.desp#" output = "wddxText100">
                                    <Cell><Data ss:Type="String">#wddxText100#</Data></Cell><!---item Name--->
                                    <cfif val(awexc) neq 0>
                                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(awexc)#</Data></Cell>
                                    <cfelse>
                                        <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                                    </cfif>
                                    <cfif numberformat(evaluate(con),'.__') neq 0>
                                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(val(evaluate(con)))#</Data></Cell>
                                    <cfelse>
                                        <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                                    </cfif>

                                </Row>
                            </cfif>
                        </cfif>
                        <cfelse>
                            
                        <cfif checkadminfeitem.recordcount eq 0>
                            <cfset calculateadminfee = calculateadminfee + val(evaluate('getpm.#a#adminfee'))>

                            <cfif val(evaluate('getpm.#a#adminfee')) gt 0>
                                <Row>
                                    <cfloop from="1" to="#ArrayLen(fieldValues)#" index="i">
                                        <cfwddx action = "cfml2wddx" input = "#fieldValues[i]#" output = "wddxText#i#">
                                        <Cell><Data ss:Type="String">#evaluate('wddxText#i#')#</Data></Cell>
                                    </cfloop>
                                    <cfwddx action = "cfml2wddx" input = "#getname.desp#" output = "wddxText100">
                                    <Cell><Data ss:Type="String">#wddxText100#</Data></Cell><!---item Name--->
                                    <cfif val(awexc) neq 0>
                                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(awexc)#</Data></Cell>
                                    <cfelse>
                                        <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                                    </cfif>
                                    <cfif val(evaluate('getpm.#a#adminfee')) neq 0>
                                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(evaluate('getpm.#a#adminfee'))#</Data></Cell>
                                    <cfelse>
                                        <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                                    </cfif>
                                </Row>
                            </cfif>
                        </cfif>
                        </cfif>
                    </cfif>
                    </cfloop>
                        
                        
					</cfif>
                  </cfloop>
                  
                  <cfset awexc = 0>
                  <cfloop from="1" to="18" index="aa">
                  	<cfif listfindnocase(excludeaw,evaluate('getassignmentslip.allowance#aa#')) eq false and evaluate('getassignmentslip.allowance#aa#') neq 0>
                    	
                        <cfloop list="bill" index="a">
                        <cfif a eq "pay">
						<cfset awexc = val(evaluate('getassignmentslip.awee#aa#'))>
                        <cfelse>
                        <cfset awexc = val(evaluate('getassignmentslip.awer#aa#'))>
                        <cfset totalvaraw =  totalvaraw + val(evaluate('getassignmentslip.awer#aa#'))>
                        </cfif>
                	<cfif evaluate('getpm.#a#able') eq "Y" and evaluate('getpm.#a#adminfee') neq "" and val(awexc) neq 0>
                     <cfquery name="getname" datasource="#dts#">
                        select * from icshelf where shelf = "#evaluate('getassignmentslip.allowance#aa#')#"
                        </cfquery>
						<cfif findnocase('%',evaluate('getpm.#a#adminfee'))>
                            
                        <cfif checkadminfeitem.recordcount eq 0>
                            <cfset calculateadminfee = calculateadminfee + val((val(awexc) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))>
                            
                            <cfif numberformat((val(awexc) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100),'.__') gt 0>
                                <Row>
                                    <cfloop from="1" to="#ArrayLen(fieldValues)#" index="i">
                                        <cfwddx action = "cfml2wddx" input = "#fieldValues[i]#" output = "wddxText#i#">
                                        <Cell><Data ss:Type="String">#evaluate('wddxText#i#')#</Data></Cell>
                                    </cfloop>
                                    <cfwddx action = "cfml2wddx" input = "#getname.desp#" output = "wddxText100">
                                    <Cell><Data ss:Type="String">#wddxText100#</Data></Cell><!---item Name--->
                                    <cfif val(awexc) neq 0>
                                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(awexc)#</Data></Cell>
                                    <cfelse>
                                        <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                                    </cfif>
                                    <cfif numberformat((val(awexc) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100),'.__') neq 0>
                                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(val(val(awexc) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))#</Data></Cell>
                                    <cfelse>
                                        <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                                    </cfif>

                                </Row>
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
                                <Row>
                                    <cfloop from="1" to="#ArrayLen(fieldValues)#" index="i">
                                        <cfwddx action = "cfml2wddx" input = "#fieldValues[i]#" output = "wddxText#i#">
                                        <Cell><Data ss:Type="String">#evaluate('wddxText#i#')#</Data></Cell>
                                    </cfloop>
                                    <cfwddx action = "cfml2wddx" input = "#getname.desp#" output = "wddxText100">
                                    <Cell><Data ss:Type="String">#wddxText100#</Data></Cell><!---item Name--->
                                    <cfif val(awexc) neq 0>
                                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(awexc)#</Data></Cell>
                                    <cfelse>
                                        <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                                    </cfif>
                                    <cfif numberformat(evaluate(con),'.__') neq 0>
                                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(val(evaluate(con)))#</Data></Cell>
                                    <cfelse>
                                        <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                                    </cfif>

                                </Row>
                            </cfif>   
                        </cfif>   
                            
                        <cfelse>
                            
                        <cfif checkadminfeitem.recordcount eq 0>
                            <cfset calculateadminfee = calculateadminfee + val(evaluate('getpm.#a#adminfee'))>

                            <cfif numberformat((val(awexc) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100),'.__') gt 0>
                                <Row>
                                    <cfloop from="1" to="#ArrayLen(fieldValues)#" index="i">
                                        <cfwddx action = "cfml2wddx" input = "#fieldValues[i]#" output = "wddxText#i#">
                                        <Cell><Data ss:Type="String">#evaluate('wddxText#i#')#</Data></Cell>
                                    </cfloop>
                                    <cfwddx action = "cfml2wddx" input = "#getname.desp#" output = "wddxText100">
                                    <Cell><Data ss:Type="String">#wddxText100#</Data></Cell><!---item Name--->
                                    <cfif val(awexc) neq 0>
                                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(awexc)#</Data></Cell>
                                    <cfelse>
                                        <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                                    </cfif>
                                    <cfif numberformat((val(awexc) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100),'.__') neq 0>
                                        <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(val(val(awexc) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))#</Data></Cell>
                                    <cfelse>
                                        <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                                    </cfif>

                                </Row>
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
                  	<cfif evaluate('getassignmentslip.fixawcode#aa#') eq replace(getpm.itemid,'A-','') and val(evaluate('getassignmentslip.fixawer#aa#')) neq 0>
                    	
                        <cfloop list="bill" index="a">
                        <cfif a eq "pay">
						<cfset "A#replacenocase(getpm.itemid,'A-','')#" = val(evaluate('getassignmentslip.fixawee#aa#'))>
                        <cfelse>
                        <cfset "A#replacenocase(getpm.itemid,'A-','')#" = val(evaluate('getassignmentslip.fixawer#aa#'))>
                        <cfset "totalA#replacenocase(getpm.itemid,'A-','')#" = evaluate("totalA#replacenocase(getpm.itemid,'A-','')#")+val(evaluate('getassignmentslip.fixawer#aa#'))>
                        <cfset totalfixaw =  totalfixaw + val(evaluate('getassignmentslip.fixawer#aa#'))>
                        </cfif>
                	<cfif evaluate('getpm.#a#able') eq "Y" and evaluate('getpm.#a#adminfee') neq "" and val(evaluate('A#replace(getpm.itemid,'A-','')#')) neq 0> 
						<cfif findnocase('%',evaluate('getpm.#a#adminfee'))>
                            
                        <cfif checkadminfeitem.recordcount eq 0>
                            <cfset calculateadminfee = calculateadminfee + val((val(evaluate('A#replace(getpm.itemid,'A-','')#')) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))>
                            <Row>
                                <cfloop from="1" to="#ArrayLen(fieldValues)#" index="i">
                                    <cfwddx action = "cfml2wddx" input = "#fieldValues[i]#" output = "wddxText#i#">
                                    <Cell><Data ss:Type="String">#evaluate('wddxText#i#')#</Data></Cell>
                                </cfloop>
                                <cfwddx action = "cfml2wddx" input = "#getpm.itemname#" output = "wddxText100">
                                <Cell><Data ss:Type="String">#wddxText100#</Data></Cell><!---item Name--->
                                <cfif val(evaluate('A#replace(getpm.itemid,'A-','')#')) neq 0>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(evaluate('A#replace(getpm.itemid,'A-','')#'))#</Data></Cell>
                                <cfelse>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                                </cfif>
                                <cfif numberformat((val(evaluate('A#replace(getpm.itemid,'A-','')#')) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100),'.__') neq 0>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(val(val(evaluate('A#replace(getpm.itemid,'A-','')#')) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))#</Data></Cell>
                                <cfelse>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                                </cfif>

                            </Row>
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
                            <Row>
                                <cfloop from="1" to="#ArrayLen(fieldValues)#" index="i">
                                    <cfwddx action = "cfml2wddx" input = "#fieldValues[i]#" output = "wddxText#i#">
                                    <Cell><Data ss:Type="String">#evaluate('wddxText#i#')#</Data></Cell>
                                </cfloop>
                                <cfwddx action = "cfml2wddx" input = "#getpm.itemname#" output = "wddxText100">
                                <Cell><Data ss:Type="String">#wddxText100#</Data></Cell><!---item Name--->
                                <cfif val(evaluate('A#replace(getpm.itemid,'A-','')#')) neq 0>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(evaluate('A#replace(getpm.itemid,'A-','')#'))#</Data></Cell>
                                <cfelse>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                                </cfif>
                                <cfif numberformat(evaluate(con),'.__') neq 0>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(val(evaluate(con)))#</Data></Cell>
                                <cfelse>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                                </cfif>

                            </Row>
                        </cfif>
                                
                        <cfelse>
                            
                        <cfif checkadminfeitem.recordcount eq 0>
                            <cfset calculateadminfee = calculateadminfee + val(evaluate('getpm.#a#adminfee'))>
                            <Row>
                                <cfloop from="1" to="#ArrayLen(fieldValues)#" index="i">
                                    <cfwddx action = "cfml2wddx" input = "#fieldValues[i]#" output = "wddxText#i#">
                                    <Cell><Data ss:Type="String">#evaluate('wddxText#i#')#</Data></Cell>
                                </cfloop>
                                <cfwddx action = "cfml2wddx" input = "#getpm.itemname#" output = "wddxText100">
                                <Cell><Data ss:Type="String">#wddxText100#</Data></Cell><!---item Name--->
                                <cfif val(evaluate('A#replace(getpm.itemid,'A-','')#')) neq 0>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(evaluate('A#replace(getpm.itemid,'A-','')#'))#</Data></Cell>
                                <cfelse>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                                </cfif>
                                <cfif val(evaluate('getpm.#a#adminfee')) neq 0>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(evaluate('getpm.#a#adminfee'))#</Data></Cell>
                                <cfelse>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                                </cfif>

                            </Row>
                        </cfif>
                        </cfif>
                    </cfif>
                    </cfloop>
                        
                        
					</cfif>
                  </cfloop>
                  
                  <cfloop from="1" to="18" index="aa">
                  	<cfif evaluate('getassignmentslip.allowance#aa#') eq replace(getpm.itemid,'A-','') and val(evaluate('getassignmentslip.awer#aa#')) neq 0>
                    	
                        <cfloop list="bill" index="a">
                        <cfif a eq "pay">
						<cfset "A#replacenocase(getpm.itemid,'A-','')#" = val(evaluate('getassignmentslip.awee#aa#'))>
                        <cfelse>
                        <cfset "A#replacenocase(getpm.itemid,'A-','')#" = val(evaluate('getassignmentslip.awer#aa#'))>
                         <cfset "totalA#replacenocase(getpm.itemid,'A-','')#" = evaluate("totalA#replacenocase(getpm.itemid,'A-','')#")+val(evaluate('getassignmentslip.awer#aa#'))>
                        <cfset totalvaraw =  totalvaraw + val(evaluate('getassignmentslip.awer#aa#'))>
                        </cfif>
                	<cfif evaluate('getpm.#a#able') eq "Y" and evaluate('getpm.#a#adminfee') neq "" and val(evaluate('A#replace(getpm.itemid,'A-','')#')) neq 0>
						<cfif findnocase('%',evaluate('getpm.#a#adminfee'))>
                            
                        <cfif checkadminfeitem.recordcount eq 0>
                            <cfset calculateadminfee = calculateadminfee + val((val(evaluate('A#replace(getpm.itemid,'A-','')#')) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))>
                            <Row>
                                <cfloop from="1" to="#ArrayLen(fieldValues)#" index="i">
                                    <cfwddx action = "cfml2wddx" input = "#fieldValues[i]#" output = "wddxText#i#">
                                    <Cell><Data ss:Type="String">#evaluate('wddxText#i#')#</Data></Cell>
                                </cfloop>
                                <cfwddx action = "cfml2wddx" input = "#getpm.itemname#" output = "wddxText100">
                                <Cell><Data ss:Type="String">#wddxText100#</Data></Cell><!---item Name--->
                                <cfif val(evaluate('A#replace(getpm.itemid,'A-','')#')) neq 0>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(evaluate('A#replace(getpm.itemid,'A-','')#'))#</Data></Cell>
                                <cfelse>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                                </cfif>
                                <cfif numberformat((val(evaluate('A#replace(getpm.itemid,'A-','')#')) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100),'.__') neq 0>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(val(val(evaluate('A#replace(getpm.itemid,'A-','')#')) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))#</Data></Cell>
                                <cfelse>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                                </cfif>
                            </Row>
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
                            <Row>
                                <cfloop from="1" to="#ArrayLen(fieldValues)#" index="i">
                                    <cfwddx action = "cfml2wddx" input = "#fieldValues[i]#" output = "wddxText#i#">
                                    <Cell><Data ss:Type="String">#evaluate('wddxText#i#')#</Data></Cell>
                                </cfloop>
                                <cfwddx action = "cfml2wddx" input = "#getpm.itemname#" output = "wddxText100">
                                <Cell><Data ss:Type="String">#wddxText100#</Data></Cell><!---item Name--->
                                <cfif val(evaluate('A#replace(getpm.itemid,'A-','')#')) neq 0>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(evaluate('A#replace(getpm.itemid,'A-','')#'))#</Data></Cell>
                                <cfelse>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                                </cfif>
                                <cfif numberformat(evaluate(con),'.__') neq 0>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(val(evaluate(con)))#</Data></Cell>
                                <cfelse>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                                </cfif>
                            </Row>
                        </cfif>        
                        
                        <cfelse>
                            
                        <cfif checkadminfeitem.recordcount eq 0>
                            <cfset calculateadminfee = calculateadminfee + val(evaluate('getpm.#a#adminfee'))>
                            <Row>
                                <cfloop from="1" to="#ArrayLen(fieldValues)#" index="i">
                                    <cfwddx action = "cfml2wddx" input = "#fieldValues[i]#" output = "wddxText#i#">
                                    <Cell><Data ss:Type="String">#evaluate('wddxText#i#')#</Data></Cell>
                                </cfloop>
                                <cfwddx action = "cfml2wddx" input = "#getpm.itemname#" output = "wddxText100">
                                <Cell><Data ss:Type="String">#wddxText100#</Data></Cell><!---item Name--->
                                <cfif val(evaluate('A#replace(getpm.itemid,'A-','')#')) neq 0>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(evaluate('A#replace(getpm.itemid,'A-','')#'))#</Data></Cell>
                                <cfelse>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                                </cfif>
                                <cfif val(evaluate('getpm.#a#adminfee')) neq 0>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(evaluate('getpm.#a#adminfee'))#</Data></Cell>
                                <cfelse>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                                </cfif>
                            </Row>
                        </cfif>
                        </cfif>
                    </cfif>
                    </cfloop>   
					</cfif>
                     
                  </cfloop>
                  </cfif>
                   <cfelseif getpm.itemid eq "ADMINFEE">
				   
				   <cfloop index="a" from="1" to="6">
                   <cfset totalfixaw =  totalfixaw + val(evaluate('getassignmentslip.fixawer#a#'))>
                   </cfloop>               

                   <cfloop index="aa" from="1" to="18">
                   <cfset totalvaraw =  totalvaraw + val(evaluate('getassignmentslip.awer#aa#'))>
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
                    <cfset EIS_FIXAW = numberformat(EISYER*TOTALFIXAW/grosspay,'.__')>
    				<cfset EIS_VARAW = numberformat(EISYER*TOTALVARAW/grosspay,'.__')>
                    <cfelse>
                    <cfset SOCSO_FIXAW = 0>
                    <cfset SOCSO_VARAW = 0>
                    <cfset EIS_FIXAW = 0>
                    <cfset EIS_VARAW = 0>
                    </cfif>
 
            <cfloop list="bill" index="a">
                	<cfif evaluate('getpm.#a#able') eq "Y" and evaluate('getpm.#a#adminfee') neq "">
						<cfif findnocase('%',evaluate('getpm.#a#adminfee'))>
                        <cfset calculateadminfee =  val((val(BASIC) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))>
                        <Row>
                            <cfloop from="1" to="#ArrayLen(fieldValues)#" index="i">
                                <cfwddx action = "cfml2wddx" input = "#fieldValues[i]#" output = "wddxText#i#">
                                <Cell><Data ss:Type="String">#evaluate('wddxText#i#')#</Data></Cell>
                            </cfloop>
                            <cfwddx action = "cfml2wddx" input = "#getpm.itemname#" output = "wddxText100">
                            <Cell><Data ss:Type="String">#wddxText100#</Data></Cell><!---item Name--->
                            <cfif val(BASIC) neq 0>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(BASIC)#</Data></Cell>
                            <cfelse>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                            </cfif>    
                            <cfif numberformat((val(BASIC) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100),'.__') neq 0>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(val(val(BASIC) * replacenocase(evaluate('getpm.#a#adminfee'),'%','')/100))#</Data></Cell>
                            <cfelse>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                            </cfif>
                        </Row>
                                
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
                        <Row>
                            <cfloop from="1" to="#ArrayLen(fieldValues)#" index="i">
                                <cfwddx action = "cfml2wddx" input = "#fieldValues[i]#" output = "wddxText#i#">
                                <Cell><Data ss:Type="String">#evaluate('wddxText#i#')#</Data></Cell>
                            </cfloop>
                            <cfwddx action = "cfml2wddx" input = "#getpm.itemname#" output = "wddxText100">
                            <Cell><Data ss:Type="String">#wddxText100#</Data></Cell><!---item Name--->
                            <cfif val(BASIC) neq 0>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(BASIC)#</Data></Cell>
                            <cfelse>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                            </cfif>
                            <cfif numberformat(evaluate(con),'.__') neq 0>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(val(evaluate(con)))#</Data></Cell>
                            <cfelse>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                            </cfif>
                        </Row>
                                
                        <cfelse>
                            
                        <cfset calculateadminfee =  val(evaluate('getpm.#a#adminfee'))>
                        <Row>
                            <cfloop from="1" to="#ArrayLen(fieldValues)#" index="i">
                                <cfwddx action = "cfml2wddx" input = "#fieldValues[i]#" output = "wddxText#i#">
                                <Cell><Data ss:Type="String">#evaluate('wddxText#i#')#</Data></Cell>
                            </cfloop>
                            <cfwddx action = "cfml2wddx" input = "#getpm.itemname#" output = "wddxText100">
                            <Cell><Data ss:Type="String">#wddxText100#</Data></Cell><!---item Name--->
                            <cfif val(BASIC) neq 0>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(BASIC)#</Data></Cell>
                            <cfelse>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                            </cfif>
                            <cfif val(evaluate('getpm.#a#adminfee')) neq 0>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(evaluate('getpm.#a#adminfee'))#</Data></Cell>
                            <cfelse>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                            </cfif>
                        </Row>
                        </cfif>
                    </cfif>
                    </cfloop>
                 
				</cfif>
            </cfloop>
                            
            <cfif isdefined('epfrecalculate') and (val(epfpayin) neq 0 or val(socsopayin) neq 0) and checkadminfeitem.recordcount eq 0>
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
                <cfif checkdetails.aw_epf eq 1 and isdefined('totalA#replace(getpmsafaw.itemid,'A-','')#') and val(epfpayin) neq 0 and val(epfyer) neq 0>
                	<cfset awamt = val(evaluate('totalA#replace(getpmsafaw.itemid,'A-','')#'))>
                    <cfset calculateadminfee = calculateadminfee + val(numberformat(((awamt/val(epfpayin)) * EPFYER),'.__') * (replacenocase(getpmsafaw.billadminfee,'%','')/100))>
                    <Row>
                        <cfloop from="1" to="#ArrayLen(fieldValues)#" index="i">
                            <cfwddx action = "cfml2wddx" input = "#fieldValues[i]#" output = "wddxText#i#">
                            <Cell><Data ss:Type="String">#evaluate('wddxText#i#')#</Data></Cell>
                        </cfloop>
                        <cfwddx action = "cfml2wddx" input = "#getpmsafaw.itemname# EPF" output = "wddxText100">
                        <Cell><Data ss:Type="String">#wddxText100#</Data></Cell><!---item Name--->
                        <cfif numberformat(((awamt/val(epfpayin)) * EPFYER),'.__') neq 0>
                            <Cell ss:StyleID="s33"><Data ss:Type="Number">#numberformat(val((awamt/val(epfpayin)) * EPFYER),'.__')#</Data></Cell>
                        <cfelse>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                        </cfif>
                        <cfif numberformat(numberformat(((awamt/val(epfpayin)) * EPFYER),'.__') * (replacenocase(getpmsafaw.billadminfee,'%','')/100),'.__') neq 0>
                            <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(val(numberformat(((awamt/val(epfpayin)) * EPFYER),'.__') * (replacenocase(getpmsafaw.billadminfee,'%','')/100)))#</Data></Cell>
                        <cfelse>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                        </cfif>
                    </Row>
                 
                    <cfset totalepf = totalepf - numberformat(((awamt/val(epfpayin)) * EPFYER),'.__')> 
				</cfif>
                 <cfif checkdetails.aw_hrd eq 1 and isdefined('totalA#replace(getpmsafaw.itemid,'A-','')#') and val(socsopayin) neq 0 and socsoremain gt 0>
                	<cfset awamt = val(evaluate('totalA#replace(getpmsafaw.itemid,'A-','')#'))>
                    <cfif socsoremain lt awamt>
                    <cfset awamt = socsoremain>
					</cfif>
                    <cfset socsoremain = SOCSOREMAIN - awamt>
                    <cfset calculateadminfee = calculateadminfee + val(numberformat(((awamt/val(socsopayin)) * SOCSOYER),'.__') * (replacenocase(getpmsafaw.billadminfee,'%','')/100))>
                    <Row>
                        <cfloop from="1" to="#ArrayLen(fieldValues)#" index="i">
                            <cfwddx action = "cfml2wddx" input = "#fieldValues[i]#" output = "wddxText#i#">
                            <Cell><Data ss:Type="String">#evaluate('wddxText#i#')#</Data></Cell>
                        </cfloop>
                        <cfwddx action = "cfml2wddx" input = "#getpmsafaw.itemname# SOCSO" output = "wddxText100">
                        <Cell><Data ss:Type="String">#wddxText100#</Data></Cell><!---item Name--->
                        <cfif numberformat(((awamt/val(socsopayin)) * SOCSOYER),'.__') neq 0>
                            <Cell ss:StyleID="s33"><Data ss:Type="Number">#numberformat(val((awamt/val(socsopayin)) * SOCSOYER),'.__')#</Data></Cell>
                        <cfelse>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                        </cfif>
                        <cfif numberformat(numberformat(((awamt/val(socsopayin)) * SOCSOYER),'.__') * (replacenocase(getpmsafaw.billadminfee,'%','')/100),'.__') neq 0>
                            <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(val(numberformat(((awamt/val(socsopayin)) * SOCSOYER),'.__') * (replacenocase(getpmsafaw.billadminfee,'%','')/100)))#</Data></Cell>
                        <cfelse>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                        </cfif>
                    </Row>
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
                    <Row>
                        <cfloop from="1" to="#ArrayLen(fieldValues)#" index="i">
                            <cfwddx action = "cfml2wddx" input = "#fieldValues[i]#" output = "wddxText#i#">
                            <Cell><Data ss:Type="String">#evaluate('wddxText#i#')#</Data></Cell>
                        </cfloop>
                        <cfwddx action = "cfml2wddx" input = "#getpmsafaw.itemname# EIS" output = "wddxText100">
                        <Cell><Data ss:Type="String">#wddxText100#</Data></Cell><!---item Name--->
                        <cfif numberformat(((awamt/val(socsopayin)) * EISYER),'.__') neq 0>
                            <Cell ss:StyleID="s33"><Data ss:Type="Number">#numberformat(val((awamt/val(socsopayin)) * EISYER),'.__')#</Data></Cell>
                        <cfelse>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                        </cfif>
                        <cfif numberformat(numberformat(((awamt/val(socsopayin)) * EISYER),'.__') * (replacenocase(getpmsafaw.billadminfee,'%','')/100),'.__') neq 0>
                            <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(val(numberformat(((awamt/val(socsopayin)) * EISYER),'.__') * (replacenocase(getpmsafaw.billadminfee,'%','')/100)))#</Data></Cell>
                        <cfelse>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                        </cfif>
                    </Row>
                    <cfset totaleis = val(totaleis) - numberformat(((awamt/val(socsopayin)) * EISYER),'.__')>
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
                  	<cfif listfindnocase(excludeaw,evaluate('getassignmentslip.fixawcode#aa#')) eq false and evaluate('getassignmentslip.fixawcode#aa#') neq 0>
                       <cfset awexc = val(evaluate('getassignmentslip.fixawer#aa#'))>
                        <cfquery name="checkable" datasource="#dts#">
                        SELECT desp,allowance FROM icshelf 
                        WHERE 
                        shelf = "#evaluate('getassignmentslip.fixawcode#aa#')#"
                        </cfquery>
                        <cfif checkable.recordcount neq 0 and val(checkable.allowance) neq 0>
                        <cfquery name="checkdetails" datasource="#replace(dts,'_i','_p')#">
                        SELECT aw_epf,aw_hrd FROM awtable WHERE aw_cou = "#val(checkable.allowance)#"
                        </cfquery>
                        <cfif checkdetails.aw_epf eq 1 and awexc neq 0 and val(epfpayin) neq 0 and val(epfyer) neq 0>
                            <cfset awamt = awexc>
                            <cfset calculateadminfee = calculateadminfee + val(numberformat(((awamt/val(epfpayin)) * EPFYER),'.__') * (replacenocase(getpmsafexc.billadminfee,'%','')/100))>
                            <Row>
                                <cfloop from="1" to="#ArrayLen(fieldValues)#" index="i">
                                    <cfwddx action = "cfml2wddx" input = "#fieldValues[i]#" output = "wddxText#i#">
                                    <Cell><Data ss:Type="String">#evaluate('wddxText#i#')#</Data></Cell>
                                </cfloop>
                                <cfwddx action = "cfml2wddx" input = "#checkable.desp# EPF" output = "wddxText100">
                                <Cell><Data ss:Type="String">#wddxText100#</Data></Cell><!---item Name--->
                                <cfif numberformat(((awamt/val(epfpayin)) * EPFYER),'.__') neq 0>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">#numberformat(val((awamt/val(epfpayin)) * EPFYER),'.__')#</Data></Cell>
                                <cfelse>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                                </cfif>
                                <cfif numberformat(numberformat(((awamt/val(epfpayin)) * EPFYER),'.__') * (replacenocase(getpmsafexc.billadminfee,'%','')/100),'.__') neq 0>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(val(numberformat(((awamt/val(epfpayin)) * EPFYER),'.__') * (replacenocase(getpmsafexc.billadminfee,'%','')/100)))#</Data></Cell>
                                <cfelse>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                                </cfif>
                            </Row>
                            <cfset totalepf = totalepf - numberformat(((awamt/val(epfpayin)) * EPFYER),'.__')>
                        </cfif>
                         <cfif checkdetails.aw_hrd eq 1 and awexc neq 0 and val(socsopayin) neq 0 and socsoremain gt 0>
                            <cfset awamt = awexc>
                            <cfif socsoremain lt awamt>
							<cfset awamt = socsoremain>
                            </cfif>
                            <cfset socsoremain = SOCSOREMAIN - awamt>
                            <cfset calculateadminfee = calculateadminfee + val(numberformat(((awamt/val(socsopayin)) * SOCSOYER),'.__') * (replacenocase(getpmsafexc.billadminfee,'%','')/100))>
                            <Row>
                                <cfloop from="1" to="#ArrayLen(fieldValues)#" index="i">
                                    <cfwddx action = "cfml2wddx" input = "#fieldValues[i]#" output = "wddxText#i#">
                                    <Cell><Data ss:Type="String">#evaluate('wddxText#i#')#</Data></Cell>
                                </cfloop>
                                <cfwddx action = "cfml2wddx" input = "#checkable.desp# SOCSO" output = "wddxText100">
                                <Cell><Data ss:Type="String">#wddxText100#</Data></Cell><!---item Name--->
                                <cfif numberformat(((awamt/val(socsopayin)) * SOCSOYER),'.__') neq 0>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">#numberformat(val((awamt/val(socsopayin)) * SOCSOYER),'.__')#</Data></Cell>
                                <cfelse>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                                </cfif>
                                <cfif numberformat(numberformat(((awamt/val(socsopayin)) * SOCSOYER),'.__') * (replacenocase(getpmsafexc.billadminfee,'%','')/100),'.__') neq 0>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(val(numberformat(((awamt/val(socsopayin)) * SOCSOYER),'.__') * (replacenocase(getpmsafexc.billadminfee,'%','')/100)))#</Data></Cell>
                                <cfelse>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                                </cfif>
                            </Row>
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
                            <Row>
                                <cfloop from="1" to="#ArrayLen(fieldValues)#" index="i">
                                    <cfwddx action = "cfml2wddx" input = "#fieldValues[i]#" output = "wddxText#i#">
                                    <Cell><Data ss:Type="String">#evaluate('wddxText#i#')#</Data></Cell>
                                </cfloop>
                                <cfwddx action = "cfml2wddx" input = "#checkable.desp# EIS" output = "wddxText100">
                                <Cell><Data ss:Type="String">#wddxText100#</Data></Cell><!---item Name--->
                                <cfif numberformat(((awamt/val(socsopayin)) * EISYER),'.__') neq 0>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">#numberformat(val((awamt/val(socsopayin)) * EISYER),'.__')#</Data></Cell>
                                <cfelse>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                                </cfif>
                                <cfif numberformat(numberformat(((awamt/val(socsopayin)) * EISYER),'.__') * (replacenocase(getpmsafexc.billadminfee,'%','')/100),'.__') neq 0>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(val(numberformat(((awamt/val(socsopayin)) * EISYER),'.__') * (replacenocase(getpmsafexc.billadminfee,'%','')/100)))#</Data></Cell>
                                <cfelse>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                                </cfif>
                            </Row>
                            <cfset totaleis = val(totaleis) - numberformat(((awamt/val(socsopayin)) * EISYER),'.__')>
                        </cfif>
                        <!---Added by Nieo 20180119 1017, EIS added--->
                        
                        </cfif>
                        </cfif>
                    </cfloop>
                    
                    <cfloop from="1" to="18" index="aa">
                  	<cfif listfindnocase(excludeaw,evaluate('getassignmentslip.allowance#aa#')) eq false and
                          evaluate('getassignmentslip.allowance#aa#') neq 0>
                    	<cfset awexc = val(evaluate('getassignmentslip.awer#aa#'))>
                        <cfquery name="checkable" datasource="#dts#">
                        SELECT desp,allowance FROM icshelf 
                        WHERE 
                        shelf = "#evaluate('getassignmentslip.fixawcode#aa#')#"
                        </cfquery>
                        <cfif checkable.recordcount neq 0 and val(checkable.allowance) neq 0>
                        <cfquery name="checkdetails" datasource="#replace(dts,'_i','_p')#">
                        SELECT aw_epf,aw_hrd FROM awtable WHERE aw_cou = "#val(checkable.allowance)#"
                        </cfquery>
                        <cfif checkdetails.aw_epf eq 1 and awexc neq 0 and val(epfpayin) neq 0>
                            <cfset awamt = awexc>
                            <cfset calculateadminfee = calculateadminfee + val(numberformat(((awamt/val(epfpayin)) * EPFYER),'.__') * (replacenocase(getpmsafexc.billadminfee,'%','')/100))>
                            <Row>
                                <cfloop from="1" to="#ArrayLen(fieldValues)#" index="i">
                                    <cfwddx action = "cfml2wddx" input = "#fieldValues[i]#" output = "wddxText#i#">
                                    <Cell><Data ss:Type="String">#evaluate('wddxText#i#')#</Data></Cell>
                                </cfloop>
                                <cfwddx action = "cfml2wddx" input = "#checkable.desp# EPF" output = "wddxText100">
                                <Cell><Data ss:Type="String">#wddxText100#</Data></Cell><!---item Name--->
                                <cfif numberformat(((awamt/val(epfpayin)) * EPFYER),'.__') neq 0>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">#numberformat(val((awamt/val(epfpayin)) * EPFYER),'.__')#</Data></Cell>
                                <cfelse>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                                </cfif>
                                <cfif numberformat(numberformat(((awamt/val(epfpayin)) * EPFYER),'.__') * (replacenocase(getpmsafexc.billadminfee,'%','')/100),'.__') neq 0>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(val(numberformat(((awamt/val(epfpayin)) * EPFYER),'.__') * (replacenocase(getpmsafexc.billadminfee,'%','')/100)))#</Data></Cell>
                                <cfelse>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                                </cfif>
                            </Row>
                            <cfset totalepf = totalepf - numberformat(((awamt/val(epfpayin)) * EPFYER),'.__')>
                        </cfif>
                         <cfif checkdetails.aw_hrd eq 1 and awexc neq 0 and val(socsopayin) neq 0 and socsoremain gt 0>
                            <cfset awamt = awexc>
                            <cfif socsoremain lt awamt>
							<cfset awamt = socsoremain>
                            </cfif>
                            <cfset socsoremain = SOCSOREMAIN - awamt>
                            <cfset calculateadminfee = calculateadminfee + val(numberformat(((awamt/val(socsopayin)) * SOCSOYER),'.__') * (replacenocase(getpmsafexc.billadminfee,'%','')/100))>
                            <Row>
                                <cfloop from="1" to="#ArrayLen(fieldValues)#" index="i">
                                    <cfwddx action = "cfml2wddx" input = "#fieldValues[i]#" output = "wddxText#i#">
                                    <Cell><Data ss:Type="String">#evaluate('wddxText#i#')#</Data></Cell>
                                </cfloop>
                                <cfwddx action = "cfml2wddx" input = "#checkable.desp# SOCSO" output = "wddxText100">
                                <Cell><Data ss:Type="String">#wddxText100#</Data></Cell><!---item Name--->
                                <cfif numberformat(((awamt/val(socsopayin)) * SOCSOYER),'.__') neq 0>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">#numberformat(val((awamt/val(socsopayin)) * SOCSOYER),'.__')#</Data></Cell>
                                <cfelse>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                                </cfif>
                                <cfif numberformat(numberformat(((awamt/val(socsopayin)) * SOCSOYER),'.__') * (replacenocase(getpmsafexc.billadminfee,'%','')/100),'.__') neq 0>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(val(numberformat(((awamt/val(socsopayin)) * SOCSOYER),'.__') * (replacenocase(getpmsafexc.billadminfee,'%','')/100)))#</Data></Cell>
                                <cfelse>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                                </cfif>
                            </Row>
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
                            <Row>
                                <cfloop from="1" to="#ArrayLen(fieldValues)#" index="i">
                                    <cfwddx action = "cfml2wddx" input = "#fieldValues[i]#" output = "wddxText#i#">
                                    <Cell><Data ss:Type="String">#evaluate('wddxText#i#')#</Data></Cell>
                                </cfloop>
                                <cfwddx action = "cfml2wddx" input = "#checkable.desp# EIS" output = "wddxText100">
                                <Cell><Data ss:Type="String">#wddxText100#</Data></Cell><!---item Name--->
                                <cfif numberformat(((awamt/val(socsopayin)) * EISYER),'.__') neq 0>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">#numberformat(val((awamt/val(socsopayin)) * EISYER),'.__')#</Data></Cell>
                                <cfelse>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                                </cfif>
                                <cfif numberformat(numberformat(((awamt/val(socsopayin)) * EISYER),'.__') * (replacenocase(getpmsafexc.billadminfee,'%','')/100),'.__') neq 0>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(val(numberformat(((awamt/val(socsopayin)) * EISYER),'.__') * (replacenocase(getpmsafexc.billadminfee,'%','')/100)))#</Data></Cell>
                                <cfelse>
                                    <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                                </cfif>
                            </Row>
                            <cfset totaleis = val(totaleis) - numberformat(((awamt/val(socsopayin)) * EISYER),'.__')>
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

                 <cfif val(evaluate('#getpmsafOT.itemid#')) neq 0 and val(socsopayin) neq 0 and socsoremain gt 0>
                 <cfset otamt = val(evaluate('#getpmsafOT.itemid#'))>
                <cfif socsoremain lt otamt>
				<cfset otamt = socsoremain>
                </cfif>
                 <cfset socsoremain = SOCSOREMAIN - otamt>
                 
                    <cfset calculateadminfee = calculateadminfee + val(numberformat((val(otamt/val(socsopayin))* SOCSOYER),'.__') * (replacenocase(getpmsafOT.billadminfee,'%','')/100))>
                    <Row>
                        <cfloop from="1" to="#ArrayLen(fieldValues)#" index="i">
                            <cfwddx action = "cfml2wddx" input = "#fieldValues[i]#" output = "wddxText#i#">
                            <Cell><Data ss:Type="String">#evaluate('wddxText#i#')#</Data></Cell>
                        </cfloop>
                        <cfwddx action = "cfml2wddx" input = "#getpmsafOT.itemname# SOCSO" output = "wddxText100">
                        <Cell><Data ss:Type="String">#wddxText100#</Data></Cell><!---item Name--->
                        <cfif numberformat((val(otamt/val(socsopayin))* SOCSOYER),'.__') neq 0>
                            <Cell ss:StyleID="s33"><Data ss:Type="Number">#numberformat(val(val(otamt/val(socsopayin))* SOCSOYER),'.__')#</Data></Cell>
                        <cfelse>
                            <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                        </cfif>
                        <cfif numberformat(numberformat((val(otamt/val(socsopayin))* SOCSOYER),'.__') * (replacenocase(getpmsafOT.billadminfee,'%','')/100),'.__') neq 0>
                            <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(val(numberformat((val(otamt/val(socsopayin))* SOCSOYER),'.__') * (replacenocase(getpmsafOT.billadminfee,'%','')/100)))#</Data></Cell>
                        <cfelse>
                            <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                        </cfif>
                    </Row>
                    <cfset totalsocso = totalsocso - numberformat(val((otamt/val(socsopayin)) * SOCSOYER),'.__')>
				</cfif>
                      
                <!---Added by Nieo 20180119 1017, EIS added--->
                <cfif val(evaluate('#getpmsafOT.itemid#')) neq 0 and val(socsopayin) neq 0 and eisremain gt 0>
                 <cfset otamt = val(evaluate('#getpmsafOT.itemid#'))>
                <cfif eisremain lt otamt>
				<cfset otamt = socsoremain>
                </cfif>
                 <cfset eisremain = eisremain - otamt>
                 
                    <cfset calculateadminfee = calculateadminfee + val(numberformat((val(otamt/val(socsopayin))* EISYER),'.__') * (replacenocase(getpmsafOT.billadminfee,'%','')/100))>
                    <Row>
                        <cfloop from="1" to="#ArrayLen(fieldValues)#" index="i">
                            <cfwddx action = "cfml2wddx" input = "#fieldValues[i]#" output = "wddxText#i#">
                            <Cell><Data ss:Type="String">#evaluate('wddxText#i#')#</Data></Cell>
                        </cfloop>
                        <cfwddx action = "cfml2wddx" input = "#getpmsafOT.itemname# EIS" output = "wddxText100">
                        <Cell><Data ss:Type="String">#wddxText100#</Data></Cell><!---item Name--->
                        <cfif numberformat((val(otamt/val(socsopayin))* EISYER),'.__') neq 0>
                            <Cell ss:StyleID="s33"><Data ss:Type="Number">#numberformat(val(val(otamt/val(socsopayin))* EISYER),'.__')#</Data></Cell>
                        <cfelse>
                            <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                        </cfif>
                        <cfif numberformat(numberformat((val(otamt/val(socsopayin))* EISYER),'.__') * (replacenocase(getpmsafOT.billadminfee,'%','')/100),'.__') neq 0>
                            <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(val(numberformat((val(otamt/val(socsopayin))* EISYER),'.__') * (replacenocase(getpmsafOT.billadminfee,'%','')/100)))#</Data></Cell>
                        <cfelse>
                            <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                        </cfif>
                    </Row>
                    <cfset totaleis = val(totaleis) - numberformat(val((otamt/val(socsopayin)) * EISYER),'.__')>
				</cfif>
                <!---Added by Nieo 20180119 1017, EIS added--->
                            
            </cfloop>
			</cfif>   
            
            
            <cfquery name="getpmepf" datasource="#dts#">
            SELECT * FROM manpowerpricematrixdetail WHERE priceid = "#getplacement.pm#"  and itemid = 'EPFYER' ORDER BY billadminfee
            </cfquery>
            
            <cfif getpmepf.recordcount neq 0>
                <cfset epfyer = totalepf>
                
            <cfloop list="bill" index="a">
                	<cfif evaluate('getpmepf.#a#able') eq "Y" and evaluate('getpmepf.#a#adminfee') neq "" and val(epfyer) neq 0>
						<cfif findnocase('%',evaluate('getpmepf.#a#adminfee'))>
                        <cfset calculateadminfee = calculateadminfee + val((val(evaluate('#getpmepf.itemid#')) * replacenocase(evaluate('getpmepf.#a#adminfee'),'%','')/100))>
                        <Row>
                            <cfloop from="1" to="#ArrayLen(fieldValues)#" index="i">
                                <cfwddx action = "cfml2wddx" input = "#fieldValues[i]#" output = "wddxText#i#">
                                <Cell><Data ss:Type="String">#evaluate('wddxText#i#')#</Data></Cell>
                            </cfloop>
                            <cfwddx action = "cfml2wddx" input = "#getpmepf.itemname#" output = "wddxText100">
                            <Cell><Data ss:Type="String">#wddxText100#</Data></Cell><!---item Name--->
                            <cfif val(evaluate('#getpmepf.itemid#')) neq 0>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(evaluate('#getpmepf.itemid#'))#</Data></Cell>
                            <cfelse>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                            </cfif>
                            <cfif numberformat((val(evaluate('#getpmepf.itemid#')) * replacenocase(evaluate('getpmepf.#a#adminfee'),'%','')/100),'.__') neq 0>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(val(val(evaluate('#getpmepf.itemid#')) * replacenocase(evaluate('getpmepf.#a#adminfee'),'%','')/100))#</Data></Cell>
                            <cfelse>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                            </cfif>
                        </Row>
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
                        <Row>
                            <cfloop from="1" to="#ArrayLen(fieldValues)#" index="i">
                                <cfwddx action = "cfml2wddx" input = "#fieldValues[i]#" output = "wddxText#i#">
                                <Cell><Data ss:Type="String">#evaluate('wddxText#i#')#</Data></Cell>
                            </cfloop>
                            <cfwddx action = "cfml2wddx" input = "#getpmepf.itemname#" output = "wddxText100">
                            <Cell><Data ss:Type="String">#wddxText100#</Data></Cell><!---item Name--->
                            <cfif val(evaluate('#getpmepf.itemid#')) neq 0>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(evaluate('#getpmepf.itemid#'))#</Data></Cell>
                            <cfelse>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                            </cfif>
                            <cfif evaluate(con) neq 0>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(val(evaluate(con)))#</Data></Cell>
                            <cfelse>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                            </cfif>
                        </Row>
                        <cfelse>
                        <cfset calculateadminfee = calculateadminfee + val(evaluate('getpmepf.#a#adminfee'))>
                        <Row>
                            <cfloop from="1" to="#ArrayLen(fieldValues)#" index="i">
                                <cfwddx action = "cfml2wddx" input = "#fieldValues[i]#" output = "wddxText#i#">
                                <Cell><Data ss:Type="String">#evaluate('wddxText#i#')#</Data></Cell>
                            </cfloop>
                            <cfwddx action = "cfml2wddx" input = "#getpmepf.itemname#" output = "wddxText100">
                            <Cell><Data ss:Type="String">#wddxText100#</Data></Cell><!---item Name--->
                            <cfif val(evaluate('#getpmepf.itemid#')) neq 0>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(evaluate('#getpmepf.itemid#'))#</Data></Cell>
                            <cfelse>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                            </cfif>
                            <cfif val(evaluate('getpmepf.#a#adminfee')) neq 0>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(evaluate('getpmepf.#a#adminfee'))#</Data></Cell>
                            <cfelse>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                            </cfif>
                        </Row>
                        </cfif>
                    </cfif>
              </cfloop>
              </cfif>
            
            <cfquery name="getpmsocso" datasource="#dts#">
            SELECT * FROM manpowerpricematrixdetail WHERE priceid = "#getplacement.pm#"  and itemid = 'SOCSOYER' ORDER BY billadminfee
            </cfquery>
            
            <cfif getpmepf.recordcount neq 0>
            <cfset socsoyer = totalsocso>
            <cfloop list="bill" index="a">
                	<cfif evaluate('getpmsocso.#a#able') eq "Y" and evaluate('getpmsocso.#a#adminfee') neq "" and val(socsoyer) neq 0>
						<cfif findnocase('%',evaluate('getpmsocso.#a#adminfee'))>
						<cfif numberformat((val(evaluate('#getpmsocso.itemid#')) * replacenocase(evaluate('getpmsocso.#a#adminfee'),'%','')/100),'.__') gte 0.00>
                        <cfset calculateadminfee = calculateadminfee + val((val(evaluate('#getpmsocso.itemid#')) * replacenocase(evaluate('getpmsocso.#a#adminfee'),'%','')/100))>
						</cfif>
                        <Row>
                            <cfloop from="1" to="#ArrayLen(fieldValues)#" index="i">
                                <cfwddx action = "cfml2wddx" input = "#fieldValues[i]#" output = "wddxText#i#">
                                <Cell><Data ss:Type="String">#evaluate('wddxText#i#')#</Data></Cell>
                            </cfloop>
                            <cfwddx action = "cfml2wddx" input = "#getpmsocso.itemname#" output = "wddxText100">
                            <Cell><Data ss:Type="String">#wddxText100#</Data></Cell><!---item Name--->
                            <cfif val(evaluate('#getpmsocso.itemid#')) gte 0.00>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(evaluate('#getpmsocso.itemid#'))#</Data></Cell>
                            <cfelse>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                            </cfif>
                            <cfif numberformat((val(evaluate('#getpmsocso.itemid#')) * replacenocase(evaluate('getpmsocso.#a#adminfee'),'%','')/100),'.__') gte 0.00>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(val(val(evaluate('#getpmsocso.itemid#')) * replacenocase(evaluate('getpmsocso.#a#adminfee'),'%','')/100))#</Data></Cell>
                            <cfelse>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                            </cfif>
                        </Row>
						
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
						<Row>
                            <cfloop from="1" to="#ArrayLen(fieldValues)#" index="i">
                                <cfwddx action = "cfml2wddx" input = "#fieldValues[i]#" output = "wddxText#i#">
                                <Cell><Data ss:Type="String">#evaluate('wddxText#i#')#</Data></Cell>
                            </cfloop>
                            <cfwddx action = "cfml2wddx" input = "#getpmsocso.itemname#" output = "wddxText100">
                            <Cell><Data ss:Type="String">#wddxText100#</Data></Cell><!---item Name--->
                            <cfif val(evaluate('#getpmsocso.itemid#')) neq 0>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(evaluate('#getpmsocso.itemid#'))#</Data></Cell>
                            <cfelse>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                            </cfif>
                            <cfif numberformat(evaluate(con),'.__') neq 0>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(val(evaluate(con)))#</Data></Cell>
                            <cfelse>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                            </cfif>
                        </Row>
                        <cfelse>
                        <cfset calculateadminfee = calculateadminfee + val(evaluate('getpmsocso.#a#adminfee'))>
                        <Row>
                            <cfloop from="1" to="#ArrayLen(fieldValues)#" index="i">
                                <cfwddx action = "cfml2wddx" input = "#fieldValues[i]#" output = "wddxText#i#">
                                <Cell><Data ss:Type="String">#evaluate('wddxText#i#')#</Data></Cell>
                            </cfloop>
                            <cfwddx action = "cfml2wddx" input = "#getpmsocso.itemname#" output = "wddxText100">
                            <Cell><Data ss:Type="String">#wddxText100#</Data></Cell><!---item Name--->
                            <cfif val(evaluate('#getpmsocso.itemid#')) neq 0>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(evaluate('#getpmsocso.itemid#'))#</Data></Cell>
                            <cfelse>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                            </cfif>
                            <cfif val(evaluate('getpmsocso.#a#adminfee')) neq 0>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(evaluate('getpmsocso.#a#adminfee'))#</Data></Cell>
                            <cfelse>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                            </cfif>
                        </Row>
                        </cfif>
                    </cfif>
              </cfloop>
              </cfif>
                            
            <cfquery name="getpmeis" datasource="#dts#">
            SELECT * FROM manpowerpricematrixdetail WHERE priceid = "#getplacement.pm#"  and itemid = 'EISYER' ORDER BY billadminfee
            </cfquery>
            
            <cfif getpmeis.recordcount neq 0>
            <cfset eisyer = totaleis>
            <cfloop list="bill" index="a">
                	<cfif evaluate('getpmeis.#a#able') eq "Y" and evaluate('getpmeis.#a#adminfee') neq "">
						<cfif findnocase('%',evaluate('getpmeis.#a#adminfee'))>
						<cfif numberformat((val(evaluate('#getpmeis.itemid#')) * replacenocase(evaluate('getpmeis.#a#adminfee'),'%','')/100),'.__') gte 0.00>
                        <cfset calculateadminfee = calculateadminfee + val((val(evaluate('#getpmeis.itemid#')) * replacenocase(evaluate('getpmeis.#a#adminfee'),'%','')/100))>
						</cfif>
                        <Row>
                            <cfloop from="1" to="#ArrayLen(fieldValues)#" index="i">
                                <cfwddx action = "cfml2wddx" input = "#fieldValues[i]#" output = "wddxText#i#">
                                <Cell><Data ss:Type="String">#evaluate('wddxText#i#')#</Data></Cell>
                            </cfloop>
                            <cfwddx action = "cfml2wddx" input = "#getpmeis.itemname#" output = "wddxText100">
                            <Cell><Data ss:Type="String">#wddxText100#</Data></Cell><!---item Name--->
                            <cfif val(evaluate('#getpmeis.itemid#')) gte 0.00>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(evaluate('#getpmeis.itemid#'))#</Data></Cell>
                            <cfelse>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                            </cfif>
                            <cfif numberformat((val(evaluate('#getpmeis.itemid#')) * replacenocase(evaluate('getpmeis.#a#adminfee'),'%','')/100),'.__') gte 0.00>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(val(val(evaluate('#getpmeis.itemid#')) * replacenocase(evaluate('getpmeis.#a#adminfee'),'%','')/100))#</Data></Cell>
                            <cfelse>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                            </cfif>
                        </Row>
						
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
						<Row>
                            <cfloop from="1" to="#ArrayLen(fieldValues)#" index="i">
                                <cfwddx action = "cfml2wddx" input = "#fieldValues[i]#" output = "wddxText#i#">
                                <Cell><Data ss:Type="String">#evaluate('wddxText#i#')#</Data></Cell>
                            </cfloop>
                            <cfwddx action = "cfml2wddx" input = "#getpmeis.itemname#" output = "wddxText100">
                            <Cell><Data ss:Type="String">#wddxText100#</Data></Cell><!---item Name--->
                            <cfif val(evaluate('#getpmeis.itemid#')) neq 0>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(evaluate('#getpmeis.itemid#'))#</Data></Cell>
                            <cfelse>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                            </cfif>
                            <cfif numberformat(evaluate(con),'.__') neq 0>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(val(evaluate(con)))#</Data></Cell>
                            <cfelse>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                            </cfif>
                        </Row>
                        <cfelse>
                        <cfset calculateadminfee = calculateadminfee + val(evaluate('getpmeis.#a#adminfee'))>
                        <Row>
                            <cfloop from="1" to="#ArrayLen(fieldValues)#" index="i">
                                <cfwddx action = "cfml2wddx" input = "#fieldValues[i]#" output = "wddxText#i#">
                                <Cell><Data ss:Type="String">#evaluate('wddxText#i#')#</Data></Cell>
                            </cfloop>
                            <cfwddx action = "cfml2wddx" input = "#getpmeis.itemname#" output = "wddxText100">
                            <Cell><Data ss:Type="String">#wddxText100#</Data></Cell><!---item Name--->
                            <cfif val(evaluate('#getpmeis.itemid#')) neq 0>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(evaluate('#getpmeis.itemid#'))#</Data></Cell>
                            <cfelse>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                            </cfif>
                            <cfif val(evaluate('getpmeis.#a#adminfee')) neq 0>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">#val(evaluate('getpmeis.#a#adminfee'))#</Data></Cell>
                            <cfelse>
                                <Cell ss:StyleID="s33"><Data ss:Type="Number">0.00</Data></Cell>
                            </cfif>
                        </Row>
                        </cfif>
                    </cfif>
              </cfloop>
              </cfif>
            
            <cfset epfadminfee = 0 >
            <cfset socsoadminfee = 0>
            
            
            
			</cfif>
            
           <cfif getassignmentslip.refno[getassignmentslip.currentrow]  neq getassignmentslip.refno[getassignmentslip.currentrow+1] and calculateadminfee gt 0> 
                <Row>
                    <cfloop from="1" to="#ArrayLen(fieldValues)#" index="i">
                        <cfwddx action = "cfml2wddx" input = "#fieldValues[i]#" output = "wddxText#i#">
                        <Cell><Data ss:Type="String">#evaluate('wddxText#i#')#</Data></Cell>
                    </cfloop>
                    <Cell><Data ss:Type="String"></Data></Cell>
                    <Cell><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s33"><Data ss:Type="Number">#numberformat(val(calculateadminfee),'.__')#</Data></Cell>
                </Row>
            </cfif>
            
			</cfif>                                
            
            </cfloop>
                <Row ss:AutoFitHeight="0" ss:Height="12">
                    </Row>
                </Table>
                <cfinclude template='/excel_template/excel_footer.cfm'>
            </cfxml>
            <cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\AdminFee_Report.xls" output="#tostring(data)#" charset="utf-8">
            <cfheader name="Content-Disposition" value="inline; filename=AdminFee_Report_#huserid#.xls">
            <cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\AdminFee_Report.xls">
            </cfoutput>