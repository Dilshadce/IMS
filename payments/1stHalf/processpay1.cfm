<cfif isdefined('url.empno')>
<cfset dts=replace(dts,'_i','_p','all')>
<cfset HcomID=replace(HcomID,'_i','','all')>
<cfset DTS_MAIN = "payroll_main">
<cfquery name="gsetup_qry" datasource="payroll_main">
		SELECT * from gsetup where comp_id = '#HcomID#'
</cfquery>
<cfset HuserCcode = gsetup_qry.ccode>

<cfinvoke component="cfc.processPay1" method="updatePay" empno="#url.empno#" db="#dts#" 
db1="#dts_main#" compid= "#HcomID#" returnvariable="name" compccode="#HuserCcode#"/>

<cfinvoke component="cfc.sum_pay_tm" method="sum_pay" empno="#url.empno#" db="#dts#"  
db1="#dts_main#" compid= "#HcomID#" returnvariable="update" />

<cfquery name="selectlist" datasource="#dts#">
SELECT * FROM pmast WHERE empno = "#url.empno#"
</cfquery>



<!--- <cfif HuserCcode eq "SG">
	<cfif gsetup_qry.nosdl eq "Y" and selectList.epfcat eq "X">
    <cfquery name="update_sdl" datasource="#dts#">
       		UPDATE comm SET levy_sd = 0  
			where empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#selectList.empno#">
   </cfquery>
   <cfset sdl_cfc="success">
	<cfelse>
		<cfinvoke component="cfc.sdl" method="cal_HRD_SDL" returnvariable="sdl_cfc" empno="#selectList.empno#"
					db="#dts#"/>
    </cfif>	
	<cfelse>
    <cfquery name="update_sdl" datasource="#dts#">
       		UPDATE comm SET levy_sd = 0  
			where empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#selectList.empno#">
       </cfquery>
		<cfset sdl_cfc="success">
	</cfif>	 --->
				
<cfinvoke component="cfc.project_job_costing" method="cal_project" empno="#url.empno#" db="#dts#" 
CPFCC_ADD_PRJ ="#gsetup_qry.CPFCC_ADD_PRJ#" CPFWW_ADD_PRJ ="#gsetup_qry.CPFWW_ADD_PRJ#"
qry_tbl_pay="paytra1" proj_pay_qry="proj_rcd_1" compid="#HcomID#" db_main="#dts_main#"
returnvariable="update_proj" />

<cfquery name="getpaytra1" datasource="#dts#">
    SELECT * FROM paytra1 WHERE empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.empno#">
</cfquery>
<cfquery name="updatepayrecord" datasource="#dts#">
	Update payrecord SET
    BRATE = "#getpaytra1.BRATE#",
    BRATE2 = "#val(getpaytra1.BRATE2)#",
    BACKPAY = "#val(getpaytra1.BACKPAY)#",
    OOB = "#getpaytra1.OOB#",
    WDAY = "#getpaytra1.WDAY#",
    WDAY2 = "#val(getpaytra1.WDAY2)#",
    DW = "#getpaytra1.DW#",
    DW2 = "#val(getpaytra1.DW2)#",
    PH = "#getpaytra1.PH#",
    AL = "#getpaytra1.AL#",
    ALHR = "#val(getpaytra1.ALHR)#",
    MC = "#getpaytra1.MC#",
    MT = "#getpaytra1.MT#",
    CC = "#getpaytra1.CC#",
    MR = "#getpaytra1.MR#",
    PT = "#getpaytra1.PT#",
    CL = "#getpaytra1.CL#",
    HL = "#getpaytra1.HL#",
    AD = "#getpaytra1.AD#",
    EX = "#getpaytra1.EX#",
    LS = "#getpaytra1.LS#",
    OPLD = "#getpaytra1.OPLD#",
    OPL = "#getpaytra1.OPL#",
    NPL = "#getpaytra1.NPL#",
    NS = "#getpaytra1.NS#",
    NPL2 = "#val(getpaytra1.NPL2)#",
    AB = "#getpaytra1.AB#",
    ONPLD = "#getpaytra1.ONPLD#",
    ONPL = "#getpaytra1.ONPL#",
    ALTAWDAY = "#val(getpaytra1.ALTAWDAY)#",
    ALTAWRATE = "#val(getpaytra1.ALTAWRATE)#",
    ALTAWAMT = "#val(getpaytra1.ALTAWAMT)#",
    DWAWADJ = "#getpaytra1.DWAWADJ#",
    ALBFTMP = "#val(getpaytra1.ALBFTMP)#",
    MCBFTMP = "#val(getpaytra1.MCBFTMP)#",
    WORKHR = "#getpaytra1.WORKHR#",
    LATEHR = "#getpaytra1.LATEHR#",
    EARLYHR = "#getpaytra1.EARLYHR#",
    NOPAYHR = "#getpaytra1.NOPAYHR#",
    RATE1 = "#val(getpaytra1.RATE1)#",
    RATE2 = "#val(getpaytra1.RATE2)#",
    RATE3 = "#val(getpaytra1.RATE3)#",
    RATE4 = "#val(getpaytra1.RATE4)#",
    RATE5 = "#val(getpaytra1.RATE5)#",
    RATE6 = "#val(getpaytra1.RATE6)#",
    HR1 = "#getpaytra1.HR1#",
    HR2 = "#getpaytra1.HR2#",
    HR3 = "#getpaytra1.HR3#",
    HR4 = "#getpaytra1.HR4#",
    HR5 = "#getpaytra1.HR5#",
    HR6 = "#getpaytra1.HR6#",
    DIRFEE = "#getpaytra1.DIRFEE#",
    AW101 = "#getpaytra1.AW101#",
    AW102 = "#getpaytra1.AW102#",
    AW103 = "#getpaytra1.AW103#",
    AW104 = "#getpaytra1.AW104#",
    AW105 = "#getpaytra1.AW105#",
    AW106 = "#getpaytra1.AW106#",
    AW107 = "#getpaytra1.AW107#",
    AW108 = "#getpaytra1.AW108#",
    AW109 = "#getpaytra1.AW109#",
    AW110 = "#getpaytra1.AW110#",
    AW111 = "#getpaytra1.AW111#",
    AW112 = "#getpaytra1.AW112#",
    AW113 = "#getpaytra1.AW113#",
    AW114 = "#getpaytra1.AW114#",
    AW115 = "#getpaytra1.AW115#",
    AW116 = "#getpaytra1.AW116#",
    AW117 = "#getpaytra1.AW117#",
    DED101 = "#getpaytra1.DED101#",
    DED102 = "#getpaytra1.DED102#",
    DED103 = "#getpaytra1.DED103#",
    DED104 = "#getpaytra1.DED104#",
    DED105 = "#getpaytra1.DED105#",
    DED106 = "#getpaytra1.DED106#",
    DED107 = "#getpaytra1.DED107#",
    DED108 = "#getpaytra1.DED108#",
    DED109 = "#getpaytra1.DED109#",
    DED110 = "#getpaytra1.DED110#",
    DED111 = "#getpaytra1.DED111#",
    DED112 = "#getpaytra1.DED112#",
    DED113 = "#getpaytra1.DED113#",
    DED114 = "#getpaytra1.DED114#",
    DED115 = "#getpaytra1.DED115#",
    MESS = "#getpaytra1.MESS#",
    MESS1 = "#getpaytra1.MESS1#",
    FIXOESP = "#getpaytra1.FIXOESP#",
    SHIFTA = "#getpaytra1.SHIFTA#",
    SHIFTB = "#getpaytra1.SHIFTB#",
    SHIFTC = "#getpaytra1.SHIFTC#",
    SHIFTD = "#getpaytra1.SHIFTD#",
    SHIFTE = "#getpaytra1.SHIFTE#",
    SHIFTF = "#getpaytra1.SHIFTF#",
    SHIFTG = "#getpaytra1.SHIFTG#",
    SHIFTH = "#getpaytra1.SHIFTH#",
    SHIFTI = "#getpaytra1.SHIFTI#",
    SHIFTJ = "#getpaytra1.SHIFTJ#",
    SHIFTK = "#getpaytra1.SHIFTK#",
    SHIFTL = "#getpaytra1.SHIFTL#",
    SHIFTM = "#getpaytra1.SHIFTM#",
    SHIFTN = "#getpaytra1.SHIFTN#",
    SHIFTO = "#getpaytra1.SHIFTO#",
    SHIFTP = "#getpaytra1.SHIFTP#",
    SHIFTQ = "#getpaytra1.SHIFTQ#",
    SHIFTR = "#getpaytra1.SHIFTR#",
    SHIFTS = "#getpaytra1.SHIFTS#",
    SHIFTT = "#getpaytra1.SHIFTT#",
    TIPPOINT = "#getpaytra1.TIPPOINT#",
    CLTIPOINT = "#val(getpaytra1.CLTIPOINT)#",
    TIPRATE = "#getpaytra1.TIPRATE#",
    MFUND = "#getpaytra1.MFUND#",
    DFUND = "#getpaytra1.DFUND#",
    ZAKAT_BF = "#val(getpaytra1.ZAKAT_BF)#",
    ZAKAT_BFN = "#val(getpaytra1.ZAKAT_BFN)#",
    PIECEPAY = "#val(getpaytra1.PIECEPAY)#",
    BASICPAY = "#val(getpaytra1.BASICPAY)#",
    FULLPAY = "#val(getpaytra1.FULLPAY)#",
    NPLPAY = "#val(getpaytra1.NPLPAY)#",
    OT1 = "#val(getpaytra1.OT1)#",
    OT2 = "#val(getpaytra1.OT2)#",
    OT3 = "#val(getpaytra1.OT3)#",
    OT4 = "#val(getpaytra1.OT4)#",
    OT5 = "#val(getpaytra1.OT5)#",
    OT6 = "#val(getpaytra1.OT6)#",
    OTPAY = "#val(getpaytra1.OTPAY)#",
    EPFWW = "#val(getpaytra1.EPFWW)#",
    EPFCC = "#val(getpaytra1.EPFCC)#",
    EPFWWEXT = "#val(getpaytra1.EPFWWEXT)#",
    EPFCCEXT = "#val(getpaytra1.EPFCCEXT)#",
    EPGWW = "#val(getpaytra1.EPGWW)#",
    EPGCC = "#val(getpaytra1.EPGCC)#",
    SOASOWW = "#val(getpaytra1.SOASOWW)#",
    SOASOCC = "#val(getpaytra1.SOASOCC)#",
    SOBSOWW = "#val(getpaytra1.SOBSOWW)#",
    SOBSOCC = "#val(getpaytra1.SOBSOCC)#",
    SOCSOWW = "#val(getpaytra1.SOCSOWW)#",
    SOCSOCC = "#val(getpaytra1.SOCSOCC)#",
    SODSOWW = "#val(getpaytra1.SODSOWW)#",
    SODSOCC = "#val(getpaytra1.SODSOCC)#",
    SOESOWW = "#val(getpaytra1.SOESOWW)#",
    SOESOCC = "#val(getpaytra1.SOESOCC)#",
    UNIONWW = "#val(getpaytra1.UNIONWW)#",
    UNIONCC = "#val(getpaytra1.UNIONCC)#",
    ADVANCE = "#val(getpaytra1.ADVANCE)#",
    ADVPAY = "#val(getpaytra1.ADVPAY)#",
    TIPAMT = "#val(getpaytra1.TIPAMT)#",
    ITAXPCB = "#val(getpaytra1.ITAXPCB)#",
    ITAXPCBADJ = "#val(getpaytra1.ITAXPCBADJ)#",
    TAW = "#val(getpaytra1.TAW)#",
    TXOTPAY = "#val(getpaytra1.TXOTPAY)#",
    TXAW = "#val(getpaytra1.TXAW)#",
    TXDED = "#val(getpaytra1.TXDED)#",
    TDED = "#val(getpaytra1.TDED)#",
    TDEDU = "#val(getpaytra1.TDEDU)#",
    GROSSPAY = "#val(getpaytra1.GROSSPAY)#",
    NETPAY = "#val(getpaytra1.NETPAY)#",
    EPF_PAY = "#val(getpaytra1.EPF_PAY)#",
    EPF_PAY_A = "#val(getpaytra1.EPF_PAY_A)#",
    CCSTAT1 = "#val(getpaytra1.CCSTAT1)#",
    CCSTAT2 = "#val(getpaytra1.CCSTAT2)#",
    CCSTAT3 = "#val(getpaytra1.CCSTAT3)#",
    PENCEN = "#val(getpaytra1.PENCEN)#",
    PROJECT = "#val(getpaytra1.PROJECT)#",
    CHEQUE_NO = "#getpaytra1.CHEQUE_NO#",
    BANKCHARGE = "#val(getpaytra1.BANKCHARGE)#",
    ADVDAY = "#val(getpaytra1.ADVDAY)#",
    PM_CODE = "#getpaytra1.PM_CODE#",
    TMONTH = "#val(getpaytra1.TMONTH)#",
    UDRATE1 = "#getpaytra1.UDRATE1#",
    UDRATE2 = "#getpaytra1.UDRATE2#",
    UDRATE3 = "#getpaytra1.UDRATE3#",
    UDRATE4 = "#getpaytra1.UDRATE4#",
    UDRATE5 = "#getpaytra1.UDRATE5#",
    UDRATE6 = "#getpaytra1.UDRATE6#",
    UDRATE7 = "#getpaytra1.UDRATE7#",
    UDRATE8 = "#getpaytra1.UDRATE8#",
    UDRATE9 = "#getpaytra1.UDRATE9#",
    UDRATE10 = "#getpaytra1.UDRATE10#",
    UDRATE11 = "#getpaytra1.UDRATE11#",
    UDRATE12 = "#getpaytra1.UDRATE12#",
    UDRATE13 = "#getpaytra1.UDRATE13#",
    UDRATE14 = "#getpaytra1.UDRATE14#",
    UDRATE15 = "#getpaytra1.UDRATE15#",
    UDRATE16 = "#getpaytra1.UDRATE16#",
    UDRATE17 = "#getpaytra1.UDRATE17#",
    UDRATE18 = "#getpaytra1.UDRATE18#",
    UDRATE19 = "#getpaytra1.UDRATE19#",
    UDRATE20 = "#getpaytra1.UDRATE20#",
    UDRATE21 = "#getpaytra1.UDRATE21#",
    UDRATE22 = "#getpaytra1.UDRATE22#",
    UDRATE23 = "#getpaytra1.UDRATE23#",
    UDRATE24 = "#getpaytra1.UDRATE24#",
    UDRATE25 = "#getpaytra1.UDRATE25#",
    UDRATE26 = "#getpaytra1.UDRATE26#",
    UDRATE27 = "#getpaytra1.UDRATE27#",
    UDRATE28 = "#getpaytra1.UDRATE28#",
    UDRATE29 = "#getpaytra1.UDRATE29#",
    UDRATE30 = "#getpaytra1.UDRATE30#",
    PAYYES = "#getpaytra1.PAYYES#",
    cpf_amt = "#getpaytra1.cpf_amt#",
    hourrate = "#val(getpaytra1.hourrate)#",
    total_late_h = "#val(getpaytra1.total_late_h)#",
    total_earlyD_h = "#val(getpaytra1.total_earlyD_h)#",
    total_noP_h = "#val(getpaytra1.total_noP_h)#",
    total_work_h = "#val(getpaytra1.total_work_h)#",
    additionalwages = "#val(getpaytra1.additionalwages)#"
	WHERE id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.payrecordid#">
    </cfquery> 
</cfif>
<script type="text/javascript">
window.opener.getemployeeded();
window.opener.getemployeecpf();
window.close();
</script>
