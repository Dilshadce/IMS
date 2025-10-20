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
                SELECT * FROM awtable WHERE aw_cou between "4" and "10"
                </cfquery>
                <cfset additionalcpf = 0>
                <cfloop query="getawtable">
                <cfif getawtable.aw_epf gt 0>
                <cfset additionalcpf = additionalcpf +evaluate('url.awer#getawtable.aw_cou#')>
                </cfif>
                </cfloop>
                <cfset url.custallowance = additionalcpf>
				<CFSET PAYIN = val(url.custbasicpay)+val(url.custphnlsalary) + val(url.custexception) + val(url.custallowance)+val(url.custpayback)+val(url.pber) + val(awser)>
                <cfset epfpayin = PAYIN>
                
                
				
                <cfset choosepayin = val(PAYIN)>
				
		        <cfquery name="get_epf_fml" datasource="#db#">
		        	SELECT entryno FROM rngtable WHERE EPFPAYF <= #replace(choosepayin,'-','')# AND EPFPAYT >= #replace(choosepayin,'-','')# 
		        </cfquery>
		        
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
                

				<cfset oldpayin1 = PAYIN>
                <cfset PAYIN = PAYIN + val(bonus_qry.basicpay) + val(comm_qry.basicpay)>
                <cfif val(additionalwages) neq 0>
                <cfset PAYIN = PAYIN + val(additionalwages)>
				</cfif>
                
		        <cfset epf_yee = #get_epf['epfyee#epf_selected#'][1]#>
		        <cfset epf_yer = #get_epf['epfyer#epf_selected#'][1]#>
		        
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
                 
                 <cfif get_now_month.balanceepf eq "1" and (val(bonus_qry.epfww) neq 0 or val(bonus_qry.epfcc) neq 0)>
                <cfset EPFW = EPFW - int(val(bonus_qry.epfww))>
                <cfset EPFY = EPFY - round(val(bonus_qry.EPFCC)+val(bonus_qry.EPFWW)-int(val(bonus_qry.EPFWW)))>
                <cfset EPFW_nt_round = EPFW_nt_round - int(val(bonus_qry.epfww))>
                <cfset epf_yer_nt_round = epf_yer_nt_round - round(val(bonus_qry.EPFCC)+val(bonus_qry.EPFWW)-int(val(bonus_qry.EPFWW)))>
                 
				 <cfelse>				 
                <cfset EPFW = EPFW * val(oldpayin1) / val(PAYIN)>
                <cfset EPFY = EPFY * val(oldpayin1) / val(PAYIN)>
                <cfset EPFW_nt_round = EPFW_nt_round * val(oldpayin1) / val(PAYIN)>
                <cfset epf_yer_nt_round = epf_yer_nt_round * val(oldpayin1) / val(PAYIN)>
                </cfif>
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
                <cfset additionalsocso = additionalsocso +evaluate('url.awer#getawtable.aw_cou#')>
                </cfif> 
				<cfoutput>
                #getawtable.aw_hrd# - #evaluate('url.awer#getawtable.aw_cou#')#
                </cfoutput>
                </cfloop>
               
				<CFSET SOCSOPAYIN = val(url.custbasicpay)+val(url.custphnlsalary) + val(url.custexception) + val(additionalsocso)+val(url.custpayback)+val(url.pber) + val(awser)+ val(url.custotpay)>
            	<cfinvoke component="cfc.socsoprocess" method="calsocso" empno="#empno#" db="#db#" returnvariable="socso_array" payrate="#replace(SOCSOPAYIN,'-','')#"/>
	        	<cfif left(SOCSOPAYIN,1) eq '-'>
                	<cfset socso_yer = '-'&socso_array[2]>
                <cfelse>
	        		<cfset socso_yer = socso_array[2]>
                </cfif>
                <cfif getsocsopercenet.billableamt neq "">
                <cfif findnocase('%', getsocsopercenet.billableamt)>
                <cfset socso_yer = numberformat(val(SOCSOPAYIN) *  replacenocase( getsocsopercenet.billableamt,'%','')/100,'.__')>
				<cfelse>
                <cfset socso_yer = val( getsocsopercenet.billableamt)>
                </cfif>
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