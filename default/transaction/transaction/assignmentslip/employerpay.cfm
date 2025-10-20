<cfif epfno neq "" and epfcat neq "X" and fix_cpf eq 0 and epf_selected neq 0>
				<cfset payin_2nd = val(PAYIN)>
                
				<CFSET PAYIN = val(url.custbasicpay) + val(url.custexception) + val(url.custotpay) + val(url.custallowance)+val(url.custpayback)>
				
                <cfset choosepayin = val(PAYIN)>
				
		        <cfquery name="get_epf_fml" datasource="#db#">
		        	SELECT entryno FROM rngtable WHERE EPFPAYF <= #choosepayin# AND EPFPAYT >= #choosepayin# 
		        </cfquery>
		        
		        <cfset epf_entryno = get_epf_fml.entryno>    
		        <cfquery name="get_epf" datasource="#db#">
		        	SELECT * FROM rngtable WHERE entryno = "#epf_entryno#"
		        </cfquery>
		        
		        <cfquery name="get_epf1" datasource="#db#">
		        	SELECT cpf_ceili FROM rngtable where entryno="1"
		        </cfquery>
		       
                <cfset oldpayin = PAYIN>
                <cfif PAYIN lte #get_epf1.cpf_ceili#>
				<cfelse>
                    <cfif val(additionalwages) neq 0>
                    <cfset newpayin = payin - val(additionalwages)>
                    
                        <cfif newpayin lte #get_epf1.cpf_ceili#>
                        <cfset PAYIN = newpayin>
                        <cfelse>
                        <cfset PAYIN = #get_epf1.cpf_ceili#>
                        </cfif>
                    
                    <cfelse>
                    <cfset PAYIN = #get_epf1.cpf_ceili#>
                    </cfif>
                
                </cfif>
				<cfset oldpayin1 = PAYIN>
                <cfset PAYIN = PAYIN + val(bonus_qry.basicpay) + val(comm_qry.basicpay)>
                <cfif oldpayin gt #get_epf1.cpf_ceili# and val(additionalwages) neq 0>
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
		         
				 <cfif val(additionalwages) neq 0 and oldpayin gt #get_epf1.cpf_ceili#>
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
				
		    <cfelse>
			        <cfset EPFY = 0>
			        <cfset EPFW = 0>
			        <cfset payin_2nd = 0>
                    <cfset additionalwages= 0>
	        </cfif>
<cfset newgross = val(url.custbasicpay) + val(url.custexception) + val(url.custotpay) + val(url.custallowance)+val(url.custpayback)>

<cfif compccode eq "SG">
			<cfif get_now_month.nosdl eq "Y" and select_empdata.epfcat eq "X">
            <cfquery name="update_sdl" datasource="#paydts#">
                    UPDATE #weekpay# SET levy_sd = 0  
                    where empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#selectList.empno#">
           </cfquery>
           <cfset sdl_cfc="success">
            <cfelse>
                <cfinvoke component="cfc.weeksdl" method="cal_HRD_SDL" returnvariable="sdl_cfc" empno="#empno#"
                            db="#db#" weekpay="#weekpay#" totalsdlgross ="#val(newgross)#" />
            </cfif>	
            <cfelse>
            <cfquery name="update_sdl" datasource="#paydts#">
                    UPDATE #weekpay# SET levy_sd = 0  
                    where empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#selectList.empno#">
               </cfquery>
                <cfset sdl_cfc="success">
            </cfif>