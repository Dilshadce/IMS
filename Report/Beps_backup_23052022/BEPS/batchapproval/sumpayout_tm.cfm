<cfoutput>
<cfquery name="getcurrentassign" datasource="#dts#">
SELECT emppaymenttype,custtotalgross FROM assignmentslip
WHERE empno="#getassignment.empno#"
AND payrollperiod = "#gqry.mmonth#"
AND created_on > #createdate(gqry.myear,1,7)#
AND batches in (SELECT batchno FROM argiro WHERE appstatus="Approved")
</cfquery>
    
<cfset ftDW =0>
<cfset ftBASICPAY =0>
<cfset fttotalNPL=0>
<cfset ftOT1=0> 
<cfset ftOT2=0>
<cfset ftOT3=0>
<cfset ftOT4=0>
<cfset ftOT5=0>
<cfset ftOT6=0>
<cfset ftOTtotal=0>
<cfset ftTAW=0>
<cfset ftgrosspay=0>
<cfset ftEPFEE=0>
<cfset ftEPFER=0>
<cfset ftSOCSOEE=0>
<cfset ftSOCSOER=0>
<cfset ftEISEE=0>
<cfset ftEISER=0>
<cfset ftepf_pay =0>
<cfset ftTDED =0>
<cfset ftTDEDU=0>
<cfset ftNETPAY=0>
<cfset ftepf_pay_a=0> 
<cfset ftcpf_amt=0>
<cfset ftadditionalwages=0>
<cfset fttotal_late_h=0>
<cfset fttotal_earlyD_h=0>
<cfset fttotal_noP_h=0>
<cfset fttotal_work_h=0>
<cfset fthourrate=0>
<cfset ftpayyes ='Y'>
<cfset ftpaydate =''>
<cfset ftnsded =0>
<cfset ftotherded=0>
<cfset ftitaxpcb =0>
<cfset ftded115=0>
<cfset ftded114 =0>
<cfset ftded113 =0>
<cfset ftded109 =0>
  
<cfloop list="paytra1,paytran" index="a">
    
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
    <cfset tSOCSOEE=0>
    <cfset tSOCSOER=0>
    <cfset tEISEE=0>
    <cfset tEISER=0>
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
    <cfset tded113 =0>
    <cfset tded109 =0>

    <cfloop query="getcurrentassign">
        <cfquery name="selectdw" datasource="#db#">
            SELECT DW ,
            BASICPAY , 
            NPLPAY,
            itaxpcb,
            ded115,
            ded114, 
            ded113,
            ded109,
            OT1 , 
            OT2  , OT3  , OT4 , OT5 , OT6  , 
            OTPay  , TAW  , grosspay, EPFWW, 
            EPFCC, SOCSOWW,SOCSOCC, EISWW,EISCC,
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
            WHERE empno = "#getassignment.empno#"
            and paydate = "#a#"
            and payyes = "Y"
        </cfquery>

        <cfif selectdw.recordcount neq 0>
            <cfif selectdw.grosspay neq 0>

            <cfif selectdw.DW neq ''>
                <cfset tDW +=val(selectdw.DW)>
                <cfset ftDW +=val(selectdw.DW)>
            </cfif>
            <cfif selectdw.BASICPAY neq ''>
                <cfset tBASICPAY +=val(selectdw.BASICPAY)>
                <cfset ftBASICPAY +=val(selectdw.BASICPAY)>
            </cfif>
            <cfif selectdw.NPLPAY neq ''>
                <cfset ttotalNPL+=val(selectdw.NPLPAY)>
                <cfset fttotalNPL+=val(selectdw.NPLPAY)>
            </cfif>
            <cfif selectdw.itaxpcb neq ''>
                <cfset titaxpcb+=val(selectdw.itaxpcb)>
                <cfset ftitaxpcb+=val(selectdw.itaxpcb)>
            </cfif>
            <cfif selectdw.ded115 neq ''>
                <cfset tded115+=val(selectdw.ded115)>
                <cfset ftded115+=val(selectdw.ded115)>
            </cfif>
            <cfif selectdw.ded114 neq ''>
                <cfset tded114+=val(selectdw.ded114)>
                <cfset ftded114+=val(selectdw.ded114)>
            </cfif>
            <cfif selectdw.ded113 neq ''>
                <cfset tded113+=val(selectdw.ded113)>
                <cfset ftded113+=val(selectdw.ded113)>
            </cfif>
            <cfif selectdw.ded109 neq ''>
                <cfset tded109+=val(selectdw.ded109)>
                <cfset ftded109+=val(selectdw.ded109)>
            </cfif>
            <cfif selectdw.OT1 neq ''>
                <cfset tOT1+=val(selectdw.OT1)>
                <cfset ftOT1+=val(selectdw.OT1)>
            </cfif>
            <cfif selectdw.OT2 neq ''>
                <cfset tOT2+=val(selectdw.OT2)>
                <cfset ftOT2+=val(selectdw.OT2)>
            </cfif>
            <cfif selectdw.OT3 neq ''>
                <cfset tOT3+=val(selectdw.OT3)>
                <cfset ftOT3+=val(selectdw.OT3)>
            </cfif>
            <cfif selectdw.OT4 neq ''>
                <cfset tOT4+=val(selectdw.OT4)>
                <cfset ftOT4+=val(selectdw.OT4)>
            </cfif>
            <cfif selectdw.OT5 neq ''>
                <cfset tOT5+=val(selectdw.OT5)>
                <cfset ftOT5+=val(selectdw.OT5)>
            </cfif>
            <cfif selectdw.OT6 neq ''>
                <cfset tOT6+=val(selectdw.OT6)>
                <cfset ftOT6+=val(selectdw.OT6)>
            </cfif>
            <cfif selectdw.OTPay neq ''>
                <cfset tOTtotal+=val(selectdw.OTPay)>
                <cfset ftOTtotal+=val(selectdw.OTPay)>
            </cfif>
            <cfif selectdw.TAW neq ''>
                <cfset tTAW+=val(selectdw.TAW)>
                <cfset ftTAW+=val(selectdw.TAW)>
            </cfif>
            <cfif selectdw.grosspay neq ''>
                <cfset tgrosspay+=val(selectdw.grosspay)>
                <cfset ftgrosspay+=val(selectdw.grosspay)>
            </cfif>
            <cfif selectdw.EPFWW neq ''>
                <cfset tEPFEE+=val(selectdw.EPFWW)>
                <cfset ftEPFEE+=val(selectdw.EPFWW)>
            </cfif>
            <cfif selectdw.EPFCC neq ''>
                <cfset tEPFER+=val(selectdw.EPFCC)>
                <cfset ftEPFER+=val(selectdw.EPFCC)>
            </cfif>
            <cfif selectdw.SOCSOWW neq ''>
                <cfset tSOCSOEE+=val(selectdw.SOCSOWW)>
                <cfset ftSOCSOEE+=val(selectdw.SOCSOWW)>
            </cfif>
            <cfif selectdw.SOCSOCC neq ''>
                <cfset tSOCSOER+=val(selectdw.SOCSOCC)>
                <cfset ftSOCSOER+=val(selectdw.SOCSOCC)>
            </cfif>
            <cfif selectdw.EISWW neq ''>
                <cfset tEISEE+=val(selectdw.EISWW)>
                <cfset ftEISEE+=val(selectdw.EISWW)>
            </cfif>
            <cfif selectdw.EISCC neq ''>
                <cfset tEISER +=val(selectdw.EISCC)>
                <cfset ftEISER +=val(selectdw.EISCC)>
            </cfif>
            <cfif selectdw.epf_pay neq ''>
                <cfset tepf_pay+=val(selectdw.epf_pay)>
                <cfset ftepf_pay+=val(selectdw.epf_pay)>
            </cfif>
            <cfif selectdw.TDED neq ''>
                <cfset tTDED +=val(selectdw.TDED)>
                <cfset ftTDED +=val(selectdw.TDED)>
            </cfif>
            <cfif selectdw.TDEDU neq ''>
                <cfset tTDEDU+=selectdw.TDEDU>
                <cfset ftTDEDU+=selectdw.TDEDU>
            </cfif>
            <cfif selectdw.NETPAY neq ''>
                <cfset tNETPAY+=val(selectdw.NETPAY)>
                <cfset ftNETPAY+=val(selectdw.NETPAY)>
            </cfif>
            <cfif selectdw.epf_pay_a neq ''>
                <cfset tepf_pay_a+=val(selectdw.epf_pay_a)>
                <cfset ftepf_pay_a+=val(selectdw.epf_pay_a)>
            </cfif> 
            <cfif selectdw.cpf_amt neq ''>
                <cfset tcpf_amt+=val(selectdw.cpf_amt)>
                <cfset ftcpf_amt+=val(selectdw.cpf_amt)>
            </cfif>
            <cfif isdefined('additionalwages')>
                <cfif selectdw.additionalwages neq ''>
                    <cfset tadditionalwages+=val(selectdw.additionalwages)>
                    <cfset ftadditionalwages+=val(selectdw.additionalwages)>
                </cfif>
            </cfif>
            <cfif isdefined('hourrate')>
                <cfif selectdw.total_late_h neq ''>
                    <cfset ttotal_late_h+=val(selectdw.total_late_h)>
                    <cfset fttotal_late_h+=val(selectdw.total_late_h)>
                </cfif>
                <cfif selectdw.total_earlyD_h neq ''>
                    <cfset ttotal_earlyD_h+=val(selectdw.total_earlyD_h)>
                    <cfset fttotal_earlyD_h+=val(selectdw.total_earlyD_h)>
                </cfif>
                <cfif selectdw.total_noP_h neq ''>
                    <cfset ttotal_noP_h+=val(selectdw.total_noP_h)>
                    <cfset fttotal_noP_h+=val(selectdw.total_noP_h)>
                </cfif>
                <cfif selectdw.total_work_h neq ''>
                    <cfset ttotal_work_h+=val(selectdw.total_work_h)>
                    <cfset fttotal_work_h+=val(selectdw.total_work_h)>
                </cfif>
                <cfif selectdw.hourrate neq ''>
                    <cfset thourrate+=val(selectdw.hourrate)>
                    <cfset fthourrate+=val(selectdw.hourrate)>
                </cfif>
            </cfif>
            <cfif selectdw.nsded neq ''>
                <cfset tnsded +=val(selectdw.nsded)>
                <cfset ftnsded +=val(selectdw.nsded)>
            </cfif>
            <cfif selectdw.otherded neq ''>
                <cfset totherded+=val(selectdw.otherded)>
                <cfset ftotherded+=val(selectdw.otherded)>
            </cfif>

            </cfif>
        </cfif>
    </cfloop>
        
    <cfquery name="updatedwfinal" datasource="#db#">
        UPDATE #a# SET DW = #val(tdW)# , 
        BASICPAY = #val(tbasicpay)#, 
        NPLPAY = #val(ttotalNPL)#, 
        itaxpcb = #val(titaxpcb)#, 
        ded115 = #val(tded115)#, 
        ded114 = #val(tded114)#, 
        ded113 = #val(tded113)#, 
        ded109 = #val(tded109)#, 
        OT1 = #val(tOT1)#, 
        OT2 = #val(tOT2)# , OT3 = #tOT3# , OT4 = #tOT4# , OT5 = #tOT5# , OT6 = #tOT6# , 
        OTPay = #tOTtotal# , TAW = #ttaw# , grosspay=#val(tgrosspay)#, EPFWW=#val(tEPFEE)#, 
        EPFCC=#val(tEPFER)#, 
        SOCSOWW = IF(#val(tSOCSOEE)# >= 19.75, 19.75, #val(tSOCSOEE)# ),
        SOCSOCC = IF(#val(tSOCSOER)# >= 69.05 or #val(tSOCSOEE)# >= 19.75 , 69.05, #val(tSOCSOER)# ),
        EISWW = IF(#val(tEISEE)# >= 7.90, 7.90, #val(tEISEE)# ),
        EISCC = IF(#val(tEISER)# >= 7.90, 7.90, #val(tEISER)# ),
        epf_pay = #tepf_pay#, TDED=#val(ttded)# , 
        TDEDU = #tTDEDU#, NETPAY = #val(tnetpay)#, 
        epf_pay_a = #val(tepf_pay_a)# 
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
        WHERE empno = "#getassignment.empno#"
    </cfquery>
                
</cfloop>

<cfif ftgrosspay neq 0>

<cfquery name="updatedwfinal" datasource="#db#">
    UPDATE payout_tm SET DW = #val(ftdW)# , 
    BASICPAY = #val(ftbasicpay)#, 
    NPLPAY = #val(fttotalNPL)#, 
    itaxpcb = #val(ftitaxpcb)#, 
    ded115 = #val(ftded115)#, 
    ded114 = #val(ftded114)#, 
    ded113 = #val(ftded113)#, 
    ded109 = #val(ftded109)#, 
    OT1 = #val(ftOT1)#, 
    OT2 = #val(ftOT2)# , OT3 = #ftOT3# , OT4 = #ftOT4# , OT5 = #ftOT5# , OT6 = #ftOT6# , 
    OTPay = #ftOTtotal# , TAW = #fttaw# , grosspay=#val(ftgrosspay)#, EPFWW=#val(ftEPFEE)#, 
    EPFCC=#val(ftEPFER)#, 
    SOCSOWW = IF(#val(ftSOCSOEE)# >= 19.75, 19.75, #val(ftSOCSOEE)# ),
    SOCSOCC = IF(#val(ftSOCSOER)# >= 69.05 or #val(ftSOCSOEE)# >= 19.75 , 69.05, #val(ftSOCSOER)# ),
    EISWW = IF(#val(ftEISEE)# >= 7.90, 7.90, #val(ftEISEE)# ),
    EISCC = IF(#val(ftEISER)# >= 7.90, 7.90, #val(ftEISER)# ),
    epf_pay = #ftepf_pay#, TDED=#val(fttded)# , 
    TDEDU = #ftTDEDU#, NETPAY = #val(ftnetpay)#, 
    epf_pay_a = #val(ftepf_pay_a)# 
    <cfif isdefined('additionalwages')>
    ,additionalwages="#val(ftadditionalwages)#"
    </cfif>
    <cfif isdefined('hourrate')>
    ,total_late_h="#val(fttotal_late_h)#"
    ,total_earlyD_h="#val(fttotal_earlyD_h)#"
    ,total_noP_h="#val(fttotal_noP_h)#"
    ,total_work_h="#val(fttotal_work_h)#"
    ,hourrate="#val(fthourrate)#"
    </cfif>
    ,payyes = "Y"
    WHERE empno = "#getassignment.empno#"
</cfquery>
        
<cfquery name="updatedwfinal" datasource="#db#">
    UPDATE pay_tm SET DW = #val(ftdW)# , 
    BASICPAY = #val(ftbasicpay)#, 
    NPLPAY = #val(fttotalNPL)#, 
    itaxpcb = #val(ftitaxpcb)#, 
    ded115 = #val(ftded115)#, 
    ded114 = #val(ftded114)#, 
    ded113 = #val(ftded113)#, 
    ded109 = #val(ftded109)#, 
    OT1 = #val(ftOT1)#, 
    OT2 = #val(ftOT2)# , OT3 = #ftOT3# , OT4 = #ftOT4# , OT5 = #ftOT5# , OT6 = #ftOT6# , 
    OTPay = #ftOTtotal# , TAW = #fttaw# , grosspay=#val(ftgrosspay)#, EPFWW=#val(ftEPFEE)#, 
    EPFCC=#val(ftEPFER)#, 
    SOCSOWW = IF(#val(ftSOCSOEE)# >= 19.75, 19.75, #val(ftSOCSOEE)# ),
    SOCSOCC = IF(#val(ftSOCSOER)# >= 69.05 or #val(ftSOCSOEE)# >= 19.75 , 69.05, #val(ftSOCSOER)# ),
    EISWW = IF(#val(ftEISEE)# >= 7.90, 7.90, #val(ftEISEE)# ),
    EISCC = IF(#val(ftEISER)# >= 7.90, 7.90, #val(ftEISER)# ),
    epf_pay = #ftepf_pay#, TDED=#val(fttded)# , 
    TDEDU = #ftTDEDU#, NETPAY = #val(ftnetpay)#, 
    epf_pay_a = #val(ftepf_pay_a)# 
    <cfif isdefined('additionalwages')>
    ,additionalwages="#val(ftadditionalwages)#"
    </cfif>
    <cfif isdefined('hourrate')>
    ,total_late_h="#val(fttotal_late_h)#"
    ,total_earlyD_h="#val(fttotal_earlyD_h)#"
    ,total_noP_h="#val(fttotal_noP_h)#"
    ,total_work_h="#val(fttotal_work_h)#"
    ,hourrate="#val(fthourrate)#"
    </cfif>
    ,payyes = "Y"
    WHERE empno = "#getassignment.empno#"
</cfquery>

</cfif>   

        
<cfquery name="getdbded" datasource="#db#">
SELECT <cfloop index="i" from="109" to="115">
dbded#i#<cfif i neq 115>,</cfif>
</cfloop>
FROM pmast
WHERE empno = '#getassignment.empno#'            
</cfquery>
        
<cfquery name="updatededpay_tm" datasource="#db#">
UPDATE payout_tm
SET ded114=<cfqueryparam cfsqltype="cf_sql_double" value="#val(getdbded.dbded114)#">,
ded113=<cfqueryparam cfsqltype="cf_sql_double" value="#val(getdbded.dbded113)#">,
ded109=<cfqueryparam cfsqltype="cf_sql_double" value="#val(getdbded.dbded109)#">,
payyes="Y"
WHERE empno = '#getassignment.empno#'
</cfquery>
    
<cfquery name="updateNetpay" datasource="#db#">
UPDATE payout_tm
SET netpay=grosspay-ifnull(epfww,0.00)-ifnull(socsoww,0.00)-ifnull(eisww,0.00)-ifnull(ded115,0.00)-ifnull(ded114,0.00)-ifnull(ded109,0.00)-ifnull(ded113,0.00)+ifnull(tdedu,0.00),
payyes="Y"
WHERE empno = '#getassignment.empno#'
</cfquery>
    
</cfoutput>