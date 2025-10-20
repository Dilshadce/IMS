<!---added for multiple assignments by Nieo--->
<cfset db =replace(dts,'_i','_p')>
<cfquery name="getcurrentassign" datasource="#dts#">
            SELECT refno,emppaymenttype,custtotalgross FROM assignmentslip
            WHERE empno="#empno#"
            AND refno <>"#form.refno#" 
            AND payrollperiod = "#form.payrollperiod#"
            ORDER BY emppaymenttype DESC
            </cfquery>
			
            <cfif getcurrentassign.recordcount neq 0>
			<cfset tDW =0>
<cfset tBASICPAY =0>
<cfset ttotalNPL=0>
<cfset tOT1=0> 
<cfset tOT2=0>
<cfset tOT3=0>
<cfset tOT4=0>
<cfset tOT5=0>
<cfset tOT6=0>
<cfset tOTtotal=0>
<cfset tTAW=0>
<cfset tgrosspay=0>
<cfset tEPFEE=0>
<cfset tEPFER=0>
<cfset tSOCSOWW=0>
<cfset tSOCSOCC=0>
<cfset tepf_pay =0>
<cfset tTDED =0>
<cfset tTDEDU=0>
<cfset tNETPAY=0>
<cfset tepf_pay_a=0> 
<cfset tcpf_amt=0>
<cfset tadditionalwages=0>
<cfset ttotal_late_h=0>
<cfset ttotal_earlyD_h=0>
<cfset ttotal_noP_h=0>
<cfset ttotal_work_h=0>
<cfset thourrate=0>
<cfset tpayyes ='Y'>
<cfset tpaydate =''>
<cfset tnsded =0>
<cfset totherded=0>
<cfset titaxpcb =0>
<cfset tded115=0>
<cfset tded114 =0>
            
            <cfloop query="getcurrentassign">
            <cfquery name="selectdw" datasource="#db#">
		        SELECT DW ,
				BASICPAY , 
				NPLPAY,
                itaxpcb,
                ded115,
                ded114, 
				OT1 , 
				OT2  , OT3  , OT4 , OT5 , OT6  , 
				OTPay  , TAW  , grosspay, EPFWW, 
				EPFCC, SOCSOWW,SOCSOCC,
				epf_pay , TDED , 
				TDEDU , NETPAY, 
				epf_pay_a , cpf_amt
                ,additionalwages
                ,total_late_h
                ,total_earlyD_h
                ,total_noP_h
                ,total_work_h
                ,hourrate
                ,payyes 
                ,paydate 
                ,nsded 
                ,otherded FROM  #getcurrentassign.emppaymenttype#
				WHERE empno = "#empno#"
                and paydate = "#form.paydate#"
	        </cfquery>
            
            <cfif selectdw.DW neq ''>
            <cfset tDW +=val(selectdw.DW)>
            </cfif>
            <cfif selectdw.BASICPAY neq ''>
			<cfset tBASICPAY +=val(selectdw.BASICPAY)>
            </cfif>
            <cfif selectdw.NPLPAY neq ''>
            <cfset ttotalNPL+=val(selectdw.NPLPAY)>
            </cfif>
            <cfif selectdw.itaxpcb neq ''>
            <cfset titaxpcb+=val(selectdw.itaxpcb)>
            </cfif>
            <cfif selectdw.ded115 neq ''>
            <cfset tded115+=val(selectdw.ded115)>
            </cfif>
            <cfif selectdw.ded114 neq ''>
            <cfset tded114+=val(selectdw.ded114)>
            </cfif>
            <cfif selectdw.OT1 neq ''>
            <cfset tOT1+=val(selectdw.OT1)>
            </cfif>
            <cfif selectdw.OT2 neq ''>
            <cfset tOT2+=val(selectdw.OT2)>
            </cfif>
            <cfif selectdw.OT3 neq ''>
            <cfset tOT3+=val(selectdw.OT3)>
            </cfif>
            <cfif selectdw.OT4 neq ''>
            <cfset tOT4+=val(selectdw.OT4)>
            </cfif>
			<cfif selectdw.OT5 neq ''>
            <cfset tOT5+=val(selectdw.OT5)>
            </cfif>
            <cfif selectdw.OT6 neq ''>
            <cfset tOT6+=val(selectdw.OT6)>
            </cfif>
            <cfif selectdw.OTPay neq ''>
            <cfset tOTtotal+=val(selectdw.OTPay)>
            </cfif>
            <cfif selectdw.TAW neq ''>
            <cfset tTAW+=val(selectdw.TAW)>
            </cfif>
            <cfif selectdw.grosspay neq ''>
            <cfset tgrosspay+=val(selectdw.grosspay)>
            </cfif>
            <cfif selectdw.EPFWW neq ''>
            <cfset tEPFEE+=val(selectdw.EPFWW)>
            </cfif>
            <cfif selectdw.EPFCC neq ''>
            <cfset tEPFER+=val(selectdw.EPFCC)>
            </cfif>
            <cfif selectdw.SOCSOWW neq ''>
            <cfset tSOCSOWW+=val(selectdw.SOCSOWW)>
            </cfif>
            <cfif selectdw.SOCSOCC neq ''>
            <cfset tSOCSOCC+=val(selectdw.SOCSOCC)>
            </cfif>
            <cfif selectdw.epf_pay neq ''>
            <cfset tepf_pay+=val(selectdw.epf_pay)>
            </cfif>
            <cfif selectdw.TDED neq ''>
            <cfset tTDED +=val(selectdw.TDED)>
            </cfif>
            <cfif selectdw.TDEDU neq ''>
            <cfset tTDEDU+=selectdw.TDEDU>
            </cfif>
            <cfif selectdw.NETPAY neq ''>
            <cfset tNETPAY+=val(selectdw.NETPAY)>
            </cfif>
            <cfif selectdw.epf_pay_a neq ''>
            <cfset tepf_pay_a+=val(selectdw.epf_pay_a)>
            </cfif> 
            <cfif selectdw.cpf_amt neq ''>
            <cfset tcpf_amt+=val(selectdw.cpf_amt)>
            </cfif>
            <cfif isdefined('additionalwages')>
				<cfif selectdw.additionalwages neq ''>
					<cfset tadditionalwages+=val(selectdw.additionalwages)>
				</cfif>
            </cfif>
            <cfif isdefined('hourrate')>
				<cfif selectdw.total_late_h neq ''>
					<cfset ttotal_late_h+=val(selectdw.total_late_h)>
				</cfif>
				<cfif selectdw.total_earlyD_h neq ''>
					<cfset ttotal_earlyD_h+=val(selectdw.total_earlyD_h)>
				</cfif>
				<cfif selectdw.total_noP_h neq ''>
					<cfset ttotal_noP_h+=val(selectdw.total_noP_h)>
				</cfif>
				<cfif selectdw.total_work_h neq ''>
					<cfset ttotal_work_h+=val(selectdw.total_work_h)>
				</cfif>
				<cfif selectdw.hourrate neq ''>
				<cfset thourrate+=val(selectdw.hourrate)>
				</cfif>
            </cfif>
            <cfif selectdw.nsded neq ''>
            <cfset tnsded +=val(selectdw.nsded)>
            </cfif>
            <cfif selectdw.otherded neq ''>
            <cfset totherded+=val(selectdw.otherded)>
            </cfif>
            </cfloop>
            </cfif>
            
			<cfif getcurrentassign.recordcount neq 0>
                <cfquery name="updatedw" datasource="#db#">
                    UPDATE #form.paydate# SET DW = #val(tdW)# , 
                    BASICPAY = #val(tbasicpay)#, 
                    NPLPAY = #val(ttotalNPL)#, 
                    itaxpcb = #val(titaxpcb)#, 
                    ded115 = #val(tded115)#, 
                    ded114 = #val(tded114)#, 
                    OT1 = #val(tOT1)#, 
                    OT2 = #val(tOT2)# , OT3 = #tOT3# , OT4 = #tOT4# , OT5 = #tOT5# , OT6 = #tOT6# , 
                    OTPay = #tOTtotal# , TAW = #ttaw# , grosspay=#val(tgrosspay)#, EPFWW=#val(tEPFEE)#, 
                    EPFCC=#val(tEPFER)#, 
                    SOCSOWW=IF(#(val(tSOCSOWW))#>=19.75, 19.75,#(val(tSOCSOWW))#), 
                    SOCSOCC=IF(#(val(tSOCSOCC))#>=69.05, 69.05,#(val(tSOCSOCC))#) ,                 
                    epf_pay = #tepf_pay#, TDED=#val(ttded)# , 
                    TDEDU = #tTDEDU#, NETPAY = #val(tnetpay)#, 
                    epf_pay_a = #val(tepf_pay_a)# , cpf_amt="#tcpf_amt#"
                    <cfif isdefined('additionalwages')>
                    ,additionalwages="#val(tadditionalwages)#"
                    </cfif>
                    <cfif isdefined('hourrate')>
                    ,total_late_h="#val(ttotal_late_h)#"
                    ,total_earlyD_h="#val(ttotal_earlyD_h)#"
                    ,total_noP_h="#val(ttotal_noP_h)#"
                    ,total_work_h="#val(ttotal_work_h)#"
                    ,hourrate="#val(thourrate)#"
                    </cfif>
                    ,payyes = "Y"
                    <!---,nsded = "#numberformat(url.nsded,'.__')#"--->
                   <!--- ,otherded = "#numberformat(numberformat(url.dedpay,'.__')-numberformat(url.nsded,'.__'),'.__')#"--->
                    WHERE empno = "#empno#"
                </cfquery>
            <cfelse>
            	<cfquery name="updatedw" datasource="#db#">
                    UPDATE #form.paydate# SET DW = null , 
                    BASICPAY = null, 
                    NPLPAY = null, 
                    itaxpcb = null, 
                    ded115 = null, 
                    ded114 = null, 
                    OT1 = null, 
                    OT2 = null , OT3 = null , OT4 = null , OT5 = null , OT6 = null , 
                    OTPay = null , TAW = null , grosspay=null, EPFWW=null, 
                    EPFCC=null, 
                    SOCSOWW=null, 
                    SOCSOCC=null ,                 
                    epf_pay = null, TDED=null , 
                    TDEDU = null, NETPAY = null, 
                    epf_pay_a = null , cpf_amt=null
                    <cfif isdefined('additionalwages')>
                    ,additionalwages=null
                    </cfif>
                    <cfif isdefined('hourrate')>
                    ,total_late_h=null
                    ,total_earlyD_h=null
                    ,total_noP_h=null
                    ,total_work_h=null
                    ,hourrate=null
                    </cfif>
                    ,payyes = "N"
                    <!---,nsded = "#numberformat(url.nsded,'.__')#"--->
                   <!--- ,otherded = "#numberformat(numberformat(url.dedpay,'.__')-numberformat(url.nsded,'.__'),'.__')#"--->
                    WHERE empno = "#empno#"
                </cfquery>
            </cfif>

			<!---added for multiple assignments by Nieo--->
			
			<cfset dts_main = "payroll_main">
            <cfinvoke component="cfc.sum_pay_tm" method="sum_pay" empno="#empno#" 
	db="#db#"  db1="#dts_main#" compid= "#HcomID#" returnvariable="update" />
    		
            <cfif getcurrentassign.recordcount eq 0>
                <cfquery name="updatedw" datasource="#db#">
                    UPDATE pay_tm 
                    SET payyes = "N"
                    WHERE empno = "#empno#"
                </cfquery>
            </cfif>