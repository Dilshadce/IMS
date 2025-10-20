<cfif epfno neq "" and epfcat neq "X" and fix_cpf eq 0 and epf_selected neq 0>
<cfif val(url.pber) neq 0 or val(awser) neq 0>
<cfset additionalwages = val(url.pber) + val(awser)>
<cfelse>
<cfset additionalwages = 0>
</cfif>

 <cfquery name="getepfpercenet" datasource="#dts#">
            SELECT * FROM manpowerpricematrixdetail WHERE priceid = "#getplacement.pm#" and itemid = 'EPFYER'
  </cfquery>
  
   <cfquery name="getsocsopercenet" datasource="#dts#">
            SELECT * FROM manpowerpricematrixdetail WHERE priceid = "#getplacement.pm#" and itemid = 'SOCSOYER'
  </cfquery>
            
				<cfset payin_2nd = val(PAYIN)>
                <cfquery name="getawtable" datasource="#db#">
                SELECT * FROM awtable WHERE aw_cou between "4" and "17"
                </cfquery>
                <cfset additionalcpf = 0>
                <cfloop query="getawtable">
                <cfif getawtable.aw_epf gt 0>
                <cfset additionalcpf = additionalcpf +val(evaluate('url.awer#getawtable.aw_cou#'))>
                </cfif>
                </cfloop>
                <cfset url.custallowance = additionalcpf>
				<cfif left(dts,12) eq 'manpowertest'>
				
				<cfoutput>
                <input type="text" id="nieotest" value="#url.custbasicpay#"><br>
				
                </cfoutput>
				</cfif>
				<CFSET PAYIN = #val(basicpay)# + #val(dirfee)# + #additional_CPF# - #ded_cpf# + val(nspay)>
                <cfset epfpayin = PAYIN>
				
				<cfset url.custallowance = additionalcpf>
				
				<cfif left(dts,12) eq 'manpowertest'>
				
				<cfoutput>
                <input type="text" id="nieotest11" value="#payin#"><br>
				
                </cfoutput>
				</cfif>
                
                <!---EPF of Multiple Assignments--->

           		<cfloop query="getcurrentassign">

					<cfif right('#getcurrentassign.emppaymenttype#',1) lt right(weekpay,1) and getcurrentassign.custtotalgross neq 0>

                        <cfquery name="getepfwageother" datasource="#db#">

                        SELECT epf_pay_a FROM #getcurrentassign.emppaymenttype#

                        WHERE empno = "#empno#"

                        </cfquery>

                        

                        <cfif getepfwageother.epf_pay_a neq ''>

                            <cfset PAYIN += val(getepfwageother.epf_pay_a)>

                        </cfif>

                    </cfif>

                </cfloop>				
				<!---EPF of Multiple Assignments--->
				
				<cfif left(dts,12) eq 'manpowertest'>
				
				<cfoutput>
                <input type="text" id="nieotest2" value="#payin#"><br>
				
                </cfoutput>
				</cfif>
                
				<!---Updated by Nieo 20171116 1358--->
                <!---<cfset choosepayin = val(PAYIN)>--->
                <!---Updated by Nieo 20171116 1358--->
				
		        <cfquery name="get_epf_fml" datasource="#db#">
		        	SELECT entryno FROM rngtable WHERE EPFPAYF <= #replace(choosepayin,'-','')# AND EPFPAYT >= #replace(choosepayin,'-','')# 
		        </cfquery>
		        
                <cfif left(HUserID,5) eq 'ultra'>
				
				<cfoutput>
                <input type="text" id="checkchoosepayin" value="#choosepayin#"><br>
				
                </cfoutput>
				</cfif>
                    
		        <cfset epf_entryno = get_epf_fml.entryno>    
		        <cfquery name="get_epf" datasource="#db#">
		        	SELECT * FROM rngtable WHERE entryno = "#epf_entryno#"
		        </cfquery>
		        
		        <cfquery name="get_epf1" datasource="#db#">
		        	SELECT cpf_ceili FROM rngtable where entryno="1"
		        </cfquery>
		       
                <cfset oldpayin = PAYIN>

                    <cfif val(additionalwages) neq 0>
                    <cfset newpayin = payin - val(additionalwages)>
                    
                        <cfif newpayin lte #get_epf1.cpf_ceili#>
                        <cfset PAYIN = newpayin>
                        <cfelse>
                        <cfset PAYIN = #get_epf1.cpf_ceili#>
                        </cfif>
                    <cfelse>
                   	<cfset newpayin = payin>
                    
                        <cfif newpayin lte #get_epf1.cpf_ceili#>
                        <cfset PAYIN = newpayin>
                        <cfelse>
                        <cfset PAYIN = #get_epf1.cpf_ceili#>
                        </cfif>
                    </cfif>
                
				<cfset PAYIN -= bonuspay>
				
				<!---<cfset oldpayin1 = PAYIN>--->
                <cfset PAYIN = PAYIN + val(bonus_qry.basicpay) + val(comm_qry.basicpay)>
                <cfif val(additionalwages) neq 0>
                <cfset PAYIN = PAYIN + val(additionalwages)>
				</cfif>
				
				<!---<cfif payin gt 5000>
					<cfquery name="get_epf_fml" datasource="#db#">
						SELECT entryno FROM rngtable WHERE EPFPAYF <= #replace(PAYIN,'-','')# AND EPFPAYT >= #replace(PAYIN,'-','')# 
					</cfquery>
					
					<cfset epf_entryno = get_epf_fml.entryno>    
					<cfquery name="get_epf" datasource="#db#">
						SELECT * FROM rngtable WHERE entryno = "#epf_entryno#"
					</cfquery>
                </cfif>--->
				
                
		        <cfset epf_yee = #get_epf['epfyee#epf_selected#'][1]#>
		        <cfset epf_yer = #get_epf['epfyer#epf_selected#'][1]#>
				
                <!---Updated by Nieo 20171116 1358--->
				<cfif fixwage lte 5000>
					<cfset epf_yer = replace(replace(epf_yer,'0.12','0.13'),'0.06','0.065')>
				</cfif>
                    
                <cfif left(HUserID,5) eq 'ultra'>
				
				<cfoutput>
                <input type="text" id="checkfixwage" value="#fixwage#"><br>
                <input type="text" id="checkepfyer" value="#epf_yer#"><br>
				
                </cfoutput>
				</cfif>
                <!---Updated by Nieo 20171116 1358--->
		        
		        <cfset EPFW = #val(evaluate(#epf_yee#))#>

		        <cfset result= #Replace(epf_yer,"ROUND","NumberFormat")#>
		        <cfset EPFY = #val(evaluate(#result#))#>
		        
		      <!---   cpf amount not round --->
		        
		        <cfset result1= #REReplace(epf_yee,"INT"," ", "all")#>
				<cfset EPFW_nt_round = #val(evaluate(#result1#))#>
				
		        <cfset result=#Replace(epf_yer,"ROUND"," ","all")#>
		        <cfset epf_yer_result=#Replace(result,",0"," ","all")#>
		        <cfif val(payin) eq 0>
                <cfset payin = 1>
				</cfif>
		        <cfset epf_yer_nt_round=#val(evaluate(#epf_yer_result#))#>
                <cfset EPFWORI = EPFW>
			     <cfset EPFYORI = EPFY>
                 <cfset EPFW_nt_roundORI = EPFW_nt_round>
                 <cfset epf_yer_nt_roundORI =epf_yer_nt_round>
                 
                <!--- <cfif get_now_month.balanceepf eq "1" and (val(bonus_qry.epfww) neq 0 or val(bonus_qry.epfcc) neq 0)>
                <cfset EPFW = EPFW - int(val(bonus_qry.epfww))>
                <cfset EPFY = EPFY - round(val(bonus_qry.EPFCC)+val(bonus_qry.EPFWW)-int(val(bonus_qry.EPFWW)))>
                <cfset EPFW_nt_round = EPFW_nt_round - int(val(bonus_qry.epfww))>
                <cfset epf_yer_nt_round = epf_yer_nt_round - round(val(bonus_qry.EPFCC)+val(bonus_qry.EPFWW)-int(val(bonus_qry.EPFWW)))>
                 
				 <cfelse>				 
                <cfset EPFW = EPFW * val(oldpayin1) / val(PAYIN)>
                <cfset EPFY = EPFY * val(oldpayin1) / val(PAYIN)>
                <cfset EPFW_nt_round = EPFW_nt_round * val(oldpayin1) / val(PAYIN)>
                <cfset epf_yer_nt_round = epf_yer_nt_round * val(oldpayin1) / val(PAYIN)>
                </cfif>--->
		        <cfset ORIEPFW = round(EPFW)>
                <cfset ORIEPFY = round(EPFY)>
				 <cfif val(additionalwages) neq 0 >
                    <cfset EPFW1 = EPFWORI * val(additionalwages) / val(PAYIN)>
					<cfset EPFY1 = EPFYORI * val(additionalwages) / val(PAYIN)>
                    <cfset EPFW_nt_round1 = EPFW_nt_roundORI * val(additionalwages) / val(PAYIN)>
                    <cfset epf_yer_nt_round1 = epf_yer_nt_roundORI * val(additionalwages) / val(PAYIN)>
                    <cfset EPFW = EPFW + EPFW1>
       			    <cfset EPFY = EPFY + EPFY1>
                    <cfset EPFW_nt_round = EPFW_nt_round + EPFW_nt_round1>
                    <cfset epf_yer_nt_round= epf_yer_nt_round + epf_yer_nt_round1>
                 <!--- <cfelse>
                 <cfset additionalwages = 0> --->
				  </cfif>
                <cfset EPFW = round(EPFW)>
                <cfset EPFY = round(EPFY)>
		     
		       <cfif isdefined('EPFW1') and val(additionalwages) neq 0>
               <cfset EPFW1 = EPFW - ORIEPFW>
               <cfset EPFY1 = EPFY - ORIEPFY>
               <cfset EPFW = ORIEPFW>
               <cfset EPFY = ORIEPFY>
               <CFSET EPFPB = ROUND((val(url.pber)/(val(url.pber)+VAL(url.awser))) * EPFY1)>
               <cfset EPFAWS = EPFY1 - EPFPB>
			   </cfif>
                   
                <!---Added by Nieo 20170912 1558, voluntary EPF calculation for EPF EE and ER--->
                <cfset epf_fyee = trim(epf_fyee)>
                <cfset epf_fyer = trim(epf_fyer)>
                
                <cfif epf_fyee neq '' and epf_fyee neq '0'>
                    <cfif findnocase('%',epf_fyee)>
                        <cfif findnocase('0.08',epf_yee)>
                            <cfset volpercee= (val(replace(epf_fyee,'%',''))/100)-0.08>
                        <cfelseif findnocase('0.11',epf_yee)>
                            <cfset volpercee= (val(replace(epf_fyee,'%',''))/100)-0.11>
                        <cfelseif findnocase('0.04',epf_yee)>
                            <cfset volpercee= (val(replace(epf_fyee,'%',''))/100)-0.04>
                        <cfelseif findnocase('0.055',epf_yee)>
                            <cfset volpercee= (val(replace(epf_fyee,'%',''))/100)-0.055>
                        </cfif>
                            
						<cfset epf_yee = replace(replace(replace(replace(epf_yee,'0.08','#volpercee#'),'0.11','#volpercee#'),'0.04','#volpercee#'),'0.055','#volpercee#')>
                    <cfelse>
                    	<cfset epf_yee = val(epf_fyee)>
                    </cfif>
				</cfif>
                
                <cfif epf_fyer neq '' and epf_fyer neq '0'>
                    <cfif findnocase('%',epf_fyer)>
                        <cfif findnocase('0.12',epf_yer)>
                            <cfset volpercer= (val(replace(epf_fyer,'%',''))/100)-0.12>
                        <cfelseif findnocase('0.13',epf_yer)>
                            <cfset volpercer= (val(replace(epf_fyer,'%',''))/100)-0.13>
                        <cfelseif findnocase('0.06',epf_yer)>
                            <cfset volpercer= (val(replace(epf_fyer,'%',''))/100)-0.06>
                        <cfelseif findnocase('0.065',epf_yer)>
                            <cfset volpercer= (val(replace(epf_fyer,'%',''))/100)-0.065>
                        </cfif>
                            
						<cfset epf_yer = replace(replace(replace(replace(epf_yer,'0.12','#volpercer#'),'0.13','#volpercer#'),'0.06','#volpercer#'),'0.065','#volpercer#')>
                    <cfelse>
                    	<cfset epf_yer = val(epf_fyer)>
                    </cfif>
				</cfif>  
                            
                <cfset EPFW_vol = #val(evaluate(#epf_yee#))#>
                            
                <cfset result= #Replace(epf_yer,"ROUND","NumberFormat")#>
		        <cfset EPFY_vol = #val(evaluate(#result#))#>
		        
		      <!---   cpf amount not round --->
		        
		        <cfset result1= #REReplace(epf_yee,"INT"," ", "all")#>
				<cfset EPFW_nt_round = #val(evaluate(#result1#))#>
				
		        <cfset result=#Replace(epf_yer,"ROUND"," ","all")#>
		        <cfset epf_yer_result=#Replace(result,",0"," ","all")#>
                
                <cfif epf_fyee neq '' and epf_fyee neq '0'>
                    <cfset EPFW_vol = round(EPFW_vol)>
                    <cfset EPFW = val(EPFW_vol)+val(EPFW)>
                </cfif>
                <cfif epf_fyer neq '' and epf_fyer neq '0'>
                    <cfset EPFY_vol = round(EPFY_vol)>
                    <cfset EPFY = val(EPFY_vol)+val(EPFY)>
                </cfif>
                <!---Added by Nieo 20170912 1558, voluntary EPF calculation for EPF EE and ER--->
                        
                <cfif left(HUserID,5) eq 'ultra'>
				
				<cfoutput>
                <input type="text" id="checkepf" value="#epfy#"><br>
                </cfoutput>
				</cfif>
				
				<cfif left(HUserID,5) eq 'ultra'>
				<cfoutput>
                    <br>
				    Final + Voluntary<br>
                    <cfif isdefined('volpercee')>
                    volpercee: #volpercee#<br>
                    </cfif>
                    <cfif isdefined('volpercer')>
                    volpercer: #volpercer#<br>
                    </cfif>
					epf_yer:#epf_yer#<br>
					<br>
					epf_yee:#epf_yee#<br>
				<br>
                2. PAYIN:#PAYIN#<br>
                <br>
                EPFY:#EPFY#<br>
				<br>
                EPFW:#EPFW#<br>
                </cfoutput>
				</cfif>
               
			   <!---EPF of Multiple Assignments--->
				
				<cfquery name="gettotalEPF" datasource="#dts#">
                SELECT sum(selfcpf) as selfcpf,sum(custcpf) as custcpf 
                FROM assignmentslip
                WHERE empno="#empno#"
                AND payrollperiod = "#gqry.mmonth#"
                AND year(Assignmentslipdate) = "#gqry.myear#"
				and right(emppaymenttype,1) < right("#weekpay#",1)
                </cfquery>
			

                <cfif gettotalEPF.custcpf neq 0>
                	<cfset EPFY -= val(gettotalEPF.custcpf)>                
                </cfif>
                    
                <cfif left(HUserID,5) eq 'ultra'>
				
				<cfoutput>
                <input type="text" id="checkepf2" value="#epfy#"><br>
                </cfoutput>
				</cfif>

                <!---End EPF of Multiple Assignments--->
		     
				<cfset pay_by = select_empdata.epfbyer>
		        <cfif pay_by eq "Y">
		        	 <cfset EPFY=#val(EPFY)# + #val(EPFW)#>
		        	 <cfset EPFW = 0>
				</cfif>
				
				<cfset pay_by_yee = select_empdata.epfbyee>
				<cfif pay_by_yee eq "Y">
		        	<cfset EPFW = #val(EPFY)# + #val(EPFW)#>
		        	<cfset EPFY = 0 >
		        </cfif>	
				
				<cfif getepfpercenet.billableamt neq "">
                <cfif findnocase('%',getepfpercenet.billableamt)>
                	<cfset EPFY = numberformat(val(PAYIN) *  replacenocase(getepfpercenet.billableamt,'%','')/100,'.__')>
				<cfelse>
                	<cfset EPFY = val(getepfpercenet.billableamt)>
                </cfif>
				</cfif>
				
				<cfif epfpayin eq 0>
                	<cfset EPFY = 0>
                </cfif>
				
		    <cfelseif fix_cpf gte 1>
		    		<cfset EPFW = select_data.EPFWW >
		        	<cfset EPFY = select_data.EPFCC >
		    		
				<cfif get_now_month.comp_id neq "zoenissi">
					
					<cfset payin_2nd = 0>
                    <cfset additionalwages= 0>
					
				<cfelse>
					
					<cfset pay_to = select_empdata.epfbrinsbp>
					<cfset nspay = 0>
					<cfif val(ns) neq 0>
               		 <cfif val(wDay) neq 0>
              			  <cfset nspay = val(ns)/ val(wDay) * brate >
             	  	 </cfif>
              	 	</cfif>
					 <cfif aw2_qry.abcdrepf eq "Y">
						<cfset PAYIN = #brate# + #val(dirfee)# + #additional_CPF# - #ded_cpf# >
		       		 <cfelseif pay_to eq "Y">
		        		<cfset PAYIN = #brate# + #val(dirfee)# + #additional_CPF# - #ded_cpf#>
		       		 <cfelse>
		        		<cfset PAYIN = #val(basicpay)# + #val(dirfee)# + #additional_CPF# - #ded_cpf# + val(nspay) >
					</cfif> 
					<cfset payin_2nd = val(PAYIN)>	
					
				</cfif>	
                
                <cfif getepfpercenet.billableamt neq "">
                <cfif findnocase('%',getepfpercenet.billableamt)>
                <cfset EPFY = numberformat(val(PAYIN) *  replacenocase(getepfpercenet.billableamt,'%','')/100,'.__')>
				<cfelse>
                <cfset EPFY = val(getepfpercenet.billableamt)>
                </cfif>
				</cfif>

				
		    <cfelse>
			        <cfset EPFY = 0>
			        <cfset EPFW = 0>
			        <cfset payin_2nd = 0>
                    <cfset additionalwages= 0>
	        </cfif>
<cfset newgross = val(url.custbasicpay)+val(url.custphnlsalary) + val(url.custexception) + val(url.custotpay) + val(url.custallowance)+val(url.custpayback)>
			<cfif compccode eq "MY">
              <cfquery name="getsocsopercenet" datasource="#dts#">
            SELECT * FROM manpowerpricematrixdetail WHERE priceid = "#getplacement.pm#" and itemid = 'SOCSOYER'
  </cfquery>
            <cfif fix_ss lt 1>
            <cfquery name="getawtable" datasource="#db#">
                SELECT * FROM awtable WHERE aw_cou between "4" and "10"
                </cfquery>
                <cfset additionalsocso = 0>
                <cfloop query="getawtable">
                <cfif getawtable.aw_hrd gt 0>
                <cfset additionalsocso = additionalsocso +val(evaluate('url.awer#getawtable.aw_cou#'))>
                </cfif> 
				<cfoutput>
                #getawtable.aw_hrd# - #evaluate('url.awer#getawtable.aw_cou#')#
                </cfoutput>
                </cfloop>
				
				<CFSET SOCSOPAYIN = val(basicpay) + val(add_hrd_ot) + val(add_hrd)- val(dedt_hrd)>
				
                <cfif left(huserid,5) eq 'ultra'>
                    <cfoutput>
                    <input type="text" id="SOCSOPAYIN_first" value="#SOCSOPAYIN#"><br>

                    </cfoutput>
				</cfif>
				
                <!--- Socso calculation for Multiple Assignments--->
				<cfset totalsocsowage= 0.00>
                <cfif SOCSOPAYIN neq 0>
                    <cfloop query="getcurrentassign">
                        <cfif right('#getcurrentassign.emppaymenttype#',1) lt right(weekpay,1)>
                            <cfquery name="totalsocso" datasource="#db#">
                                SELECT (coalesce(basicpay,0)+coalesce(otpay,0)
                                <cfloop query="socaw">
                                +coalesce(aw#100+socaw.aw_cou#,0)
                                </cfloop>
                                <cfloop query="socded">
                                -coalesce(ded#100+socded.ded_cou#,0)
                                </cfloop>) as socsowage
                                FROM #getcurrentassign.emppaymenttype#
                                WHERE empno = "#empno#"
                            </cfquery>

                            <cfset totalsocsowage+= val(totalsocso.socsowage)>
                        </cfif>
                    </cfloop>
                    <cfset SOCSOPAYIN += val(totalsocsowage)>
                </cfif>
                <!--- Socso calculation for Multiple Assignments--->
               
				
            	<cfinvoke component="cfc.socsoprocess" method="calsocso" empno="#empno#" db="#db#" returnvariable="socso_array" payrate="#replace(SOCSOPAYIN,'-','')#"/>
	        	<cfif left(SOCSOPAYIN,1) eq '-'>
                	<cfset socso_yer = '-'&socso_array[2]>
                <cfelse>
	        		<cfset socso_yer = socso_array[2]>
                </cfif>
				
				<cfif left(huserid,5) eq 'ultra'>
                    <cfoutput>
                    <input type="text" id="SOCSOPAYIN_after_add_wage" value="#SOCSOPAYIN#"><br>
                    <input type="text" id="SOCSOyer_before_deduct_previous" value="#socso_yer#"><br>
                    </cfoutput>
				</cfif>
				
				<!--- Socso calculation for Multiple Assignments--->
                <!--- Updated by Nieo 20171114 1007 with fixed for socso negative amount--->
                <cfloop query="getcurrentassign">
					<cfif right('#getcurrentassign.emppaymenttype#',1) lt right(weekpay,1) and SOCSOPAYIN neq 0>
						<cfquery name="totalsocsoamt" datasource="#db#">
							SELECT socsoww,socsocc
							FROM #getcurrentassign.emppaymenttype#
							WHERE empno = "#empno#"
						</cfquery>
						<cfset socso_yer-= val(totalsocsoamt.socsocc)>
					</cfif>
                </cfloop>
                <!--- Updated by Nieo 20171114 1007 with fixed for socso negative amount--->
                    
                <cfif left(huserid,5) eq 'ultra'>
                    <cfoutput>
                    <input type="text" id="SOCSOyer_after_deduct_previous" value="#socso_yer#"><br>

                    </cfoutput>
				</cfif>
                <!--- Socso calculation for Multiple Assignments--->
				
                <cfif getsocsopercenet.billableamt neq "">
					<cfif findnocase('%', getsocsopercenet.billableamt)>
						<cfset socso_yer = numberformat(val(SOCSOPAYIN) *  replacenocase( getsocsopercenet.billableamt,'%','')/100,'.__')>
					<cfelse>
						<cfset socso_yer = val( getsocsopercenet.billableamt)>
					</cfif>
				</cfif>		
				
				<cfif left(huserid,5) eq 'ultra'>
                    <cfoutput>
                    <input type="text" id="SOCSOyer_after_price_structure" value="#socso_yer#"><br>

                    </cfoutput>
				</cfif>
				
			</cfif>
			</cfif>

			<cfif compccode eq "SG">
			<cfif get_now_month.nosdl eq "Y" and select_empdata.epfcat eq "X">
            <cfquery name="update_sdl" datasource="#paydts#">
                    UPDATE #weekpay# SET levy_sd = 0  
                    where empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#empno#">
           </cfquery>
           <cfset sdl_cfc="success">
            <cfelse>
                <cfinvoke component="cfc.weeksdl" method="cal_HRD_SDL" returnvariable="sdl_cfc" empno="#empno#"
                            db="#db#" weekpay="#weekpay#" totalsdlgross ="#val(newgross)#" />
            </cfif>	
            <cfelse>
            <cfquery name="update_sdl" datasource="#paydts#">
                    UPDATE #weekpay# SET levy_sd = 0  
                    where empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#empno#">
               </cfquery>
                <cfset sdl_cfc="success">
            </cfif>
            
<cfset newgross = val(url.custbasicpay)+val(url.custphnlsalary) + val(url.custexception) + val(url.custotpay) + val(url.custallowance)+val(url.custpayback)+val(url.pber) + val(awser)>
            <cfif compccode eq "SG">
				<cfif get_now_month.nosdl eq "Y" and select_empdata.epfcat eq "X">
                	<cfset sdl_cfc="success">
                <cfelse>
                    <cfquery name="get_sdl_for" datasource="#paydts#">
                    SELECT sdl_con, sdl_for, sdlcal FROM ottable
                    </cfquery>
                    
                    <cfset PAY_TM.HRD_PAY = val(newgross)>
                    <cfset PAY_TM.BONUS = 0>
                    <cfset PAY_TM.COMM = 0>
                    
                    
                    <cfset sdl_condition = #get_sdl_for.sdl_con# >
                    
                    <cfset sdl_formula= #get_sdl_for.sdl_for# >
                    
                    <cfset sdl_new_formula = #Replace(sdl_formula,">="," gte ")# >
                    
                    <cfset check_sdl_con = #evaluate('#sdl_condition#')# >
                    
                    
                    <cfif check_sdl_con is true and #get_sdl_for.sdlcal# eq "1">
                    <cfset sdl_value = #evaluate('#sdl_new_formula#')# >
                    <cfelse>
                    <cfset sdl_value = 0>
                    </cfif>	
                    <cfquery name="getemp" datasource="#db#">
                    select emp_status from pmast where empno ="#empno#"
                    </cfquery>	
                    
                    <cfif #getemp.emp_status# eq "O">
                    <cfset sdl_value = 0>
                    <cfelse>
                     <cfquery name="getpaydata" datasource="#paydts#">
                    SELECT levy_sd FROM #weekpay# WHERE empno = "#empno#"
                    </cfquery>
                    <cfset additionalsdf = numberformat(val(sdl_value),'.__') - numberformat(val(getpaydata.levy_sd),'.__') >
                    <cfif val(additionalsdf) gt 0>
                    <CFSET sdfPB = numberformat((val(url.pber)/(val(url.pber)+VAL(url.awser))) * val(additionalsdf),'.__')>
               <cfset sdfAWS = numberformat(val(additionalsdf) - sdfPB,'.__')>
					</cfif>
                    
                    </cfif>
                </cfif>	
 
            </cfif>