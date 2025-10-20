<cfset dts=replace(dts,'_i','_p','all')>

<cfquery name="userpin_qry" datasource="#dts#">
		SELECT pin from userpin where usergroup = "#getHQstatus.userGrpID#"
	</cfquery>
	<cfset Hpin = userpin_qry.pin >
	<cfif getHQstatus.userGrpID eq "super">
		<cfset Hpin = 0>
	</cfif>
<cfset HcomID=replace(HcomID,'_i','','all')>
<cfset DTS_MAIN = "payroll_main">
<cfquery name="gsetup_qry" datasource="payroll_main">
		SELECT ccode from gsetup where comp_id = '#HcomID#'
	</cfquery>
	<cfset HuserCcode = gsetup_qry.ccode>
<cfoutput>
<cfif #url.type# eq "more">
<cfquery name="more_qry" datasource="#dts#">
UPDATE paytran
SET backpay = "#val(form.backpay)#",
	brate2 = "#val(form.brate2)#",
	wday2 = "#val(form.wday2)#",
	dw2 = "#val(form.dw2)#",
	npl2 = "#val(form.npl2)#"
WHERE empno = "#URLDecode(url.empno)#"
</cfquery>
<script type="text/javascript">
	window.close();
</script>

<cfelseif #url.type# eq "moreAW">

<cfquery name="mAW_qry" datasource="#dts#">
UPDATE moretra
SET <cfloop from="101" to="117" index="j">
MAW#j# = "#val(evaluate('form.MAW#j#'))#"
<cfif j neq 117>,</cfif>
</cfloop>
WHERE empno = "#URLDecode(url.empno)#"
</cfquery>

<cflocation url="/payments/2ndHalf/AddUpdate/normalPay_moreAW.cfm?empno=#URLEncodedFormat(url.empno)#">

<cfelseif #url.type# eq "moreDED">

<cfquery name="mDED_qry" datasource="#dts#">
UPDATE moretra
SET <cfloop from=101 to=117 index="j">MDED#j# = "#val(evaluate('form.MDED#j#'))#"<cfif j neq 117>,</cfif></cfloop>
WHERE empno = "#URLDecode(url.empno)#"
</cfquery>

<cflocation url="/payments/2ndHalf/AddUpdate/normalPay_moreDED.cfm?empno=#URLEncodedFormat(url.empno)#">

<cfelseif #url.type# eq "normal">
	<cfset qString="select * FROM paytran WHERE empno ='#URLDecode(form.empno)#'">
	<cfinvoke component="cfc.auditTrail" method="toArray" dts="#dts#" qStr="#variables.qString#" returnvariable="array_ov">
	
	<!-- auto divide basic rate -->
	<cfquery name="cal_basicrate" datasource="#dts#">
		select BRATE,nppm,PAYRTYPE from pmast WHERE empno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#">
	</cfquery>
	<cfquery name="gsetup_qry" datasource="#dts_main#">
		select bp_h1pcm,bp_payment,mmonth,myear from gsetup WHERE comp_id = "#HcomID#"
	</cfquery>
	<cfif val(form.BRATE) eq 0>
		<cfif cal_basicrate.nppm eq 0 and cal_basicrate.PAYRTYPE eq "M">
			<cfset auto_brate = val(cal_basicrate.BRATE) / gsetup_qry.bp_payment>
		<cfelseif cal_basicrate.nppm neq 0 and cal_basicrate.PAYRTYPE eq "M">
			<cfset auto_brate = val(cal_basicrate.BRATE) / cal_basicrate.nppm>
		</cfif>
	<cfelse>
		<cfset auto_brate = val(form.BRATE)>
	</cfif>
		
	
	<cfquery name="BPO_qry" datasource="#dts#">
	UPDATE paytran
	SET BRATE = "#val(auto_brate)#",
		WDAY = "#val(form.WDAY)#",
		<cfif val(form.dw) eq 0>
		<cfset realDW = val(form.WDAY)-val(form.PH)-val(form.MC)-val(form.MT)-val(form.CC)-val(form.MR)-val(form.CL)-val(form.HL)-val(form.EX)-val(form.PT)-val(form.AD)-val(form.OPLD)-val(form.OPL)-val(form.LS)-val(form.NPL)-val(form.AB)-val(form.NS)-val(form.ONPL)>
        DW = "#val(realDW)#",
        <cfelse>
        DW = "#val(form.DW)#",
        </cfif>
		PH = "#val(form.PH)#",
		AL = "#val(form.AL)#",
		MC = "#val(form.MC)#",
		MT = "#val(form.MT)#",
	    CC = "#val(form.CC)#",
		MR = "#val(form.MR)#",
		CL = "#val(form.CL)#",
		HL = "#val(form.HL)#",
		EX = "#val(form.EX)#",
		PT = "#val(form.PT)#",
		AD = "#val(form.AD)#",
		OPLD = "#form.OPLD#",
		OPL = "#val(form.OPL)#",
		LS = "#val(form.LS)#",
		NPL = "#val(form.NPL)#",
		AB = "#val(form.AB)#",
        NS = "#val(form.NS)#",
		ONPLD = "#val(form.ONPLD)#",
		ONPL = "#val(form.ONPL)#",
		OOB = "#val(form.OOB)#",
        <cfloop from=1 to=6 index="i">
		HR#i# = "#val(evaluate('form.HR#i#'))#",
        </cfloop>
		WORKHR = "#val(form.WORKHR)#",
		LATEHR = "#val(form.LATEHR)#",
		EARLYHR = "#val(form.EARLYHR)#",
		NOPAYHR = "#val(form.NOPAYHR)#",
		<cfif HuserCcode eq 'MY'>
		TP1zakat = "#val(form.TP1zakat)#",
		TP1levy = "#val(form.TP1levy)#",</cfif>
		PAYYES = "Y"
	WHERE empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#">
	</cfquery>
	

	
	<cfquery name="AW_qry" datasource="#dts#">
	UPDATE paytran
	SET DIRFEE = "#val(form.DIRFEE)#",
    <cfloop from=101 to=117 index="i">
		AW#i# = "#val(evaluate('form.AW#i#'))#",
    </cfloop>
		DWAWADJ = "#val(form.DWAWADJ)#"
	WHERE empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#">
	</cfquery>
	

	
	<cfquery name="DED_qry" datasource="#dts#">
	UPDATE paytran
	SET <cfloop from=101 to=115 index="i">DED#i# = "#val(evaluate('form.DED#i#'))#",</cfloop>
		MESS = "#val(form.MESS)#",
		MESS1 = "#val(form.MESS1)#"
	WHERE empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#">
	</cfquery>
	

	<cfquery name="OTH_qry" datasource="#dts#">
	UPDATE paytran
	SET SHIFTA = "#val(form.SHIFTA)#",
		SHIFTB = "#val(form.SHIFTB)#",
		SHIFTC = "#val(form.SHIFTC)#",
		SHIFTD = "#val(form.SHIFTD)#",
		SHIFTE = "#val(form.SHIFTE)#",
		SHIFTF = "#val(form.SHIFTF)#",
		SHIFTG = "#val(form.SHIFTG)#",
		SHIFTH = "#val(form.SHIFTH)#",
		SHIFTI = "#val(form.SHIFTI)#",
		SHIFTJ = "#val(form.SHIFTJ)#",
		SHIFTK = "#val(form.SHIFTK)#",
		SHIFTL = "#val(form.SHIFTL)#",
		SHIFTM = "#val(form.SHIFTM)#",
		SHIFTN = "#val(form.SHIFTN)#",
		SHIFTO = "#val(form.SHIFTO)#",
		SHIFTP = "#val(form.SHIFTP)#",
		SHIFTQ = "#val(form.SHIFTQ)#",
		SHIFTR = "#val(form.SHIFTR)#",
		SHIFTS = "#val(form.SHIFTS)#",
		SHIFTT = "#val(form.SHIFTT)#",
		TIPPOINT = "#val(form.TIPPOINT)#",
		TIPRATE = "#val(form.TIPRATE)#",
		MFUND = "#val(form.MFUND)#",
		DFUND = "#val(form.DFUND)#",
		PROJECT = "#form.project#"
	WHERE empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#">
	</cfquery>

	
	<cfquery name="UDRate_qry" datasource="#dts#">
	UPDATE paytran
	SET DIRFEE = "#val(form.DIRFEE)#",
    <cfloop from=1 to=30 index="i">
		UDRATE#i# = "#val(evaluate('form.UDRATE#i#'))#",
    </cfloop>
		DWAWADJ = "#val(form.DWAWADJ)#"
	WHERE empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#">
	</cfquery>
	

	<cfinvoke component="cfc.auditTrail" method="createAuditFrmUpdate" dts="#dts#" act="update" 
			user="#Huserid#" module="PYM" pointer="paytran[empno = '#URLDecode(form.empno)#']" oldArray="#array_ov#" 
			qStr="#qString#"  comment="2nd half normal pay 1/2">
	
	<cfquery name="more_qry" datasource="#dts#">
	UPDATE moretra
	SET PAYYES = "Y"
	WHERE empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#">
	</cfquery>
    
    
    <cfquery name="getpaytra1" datasource="#dts#">
    SELECT * FROM paytran WHERE empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#">
    </cfquery>
    <cfquery name="clearrecord" datasource="#dts#">
    Delete FROM payrecord WHERE realempno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#"> and placement = "#url.placement#" and month = "#gsetup_qry.mmonth#" and year = "#gsetup_qry.myear#" and paytimes = "1" and invoiceno = "#url.invoiceno#"
    </cfquery>
    <cfquery name="checkexist" datasource="#dts#">
    SELECT id FROM payrecord WHERE realempno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#"> and placement = "#url.placement#" and month = "#gsetup_qry.mmonth#" and year = "#gsetup_qry.myear#" and paytimes = "2" and invoiceno = "#url.invoiceno#"
    </cfquery>
    
    <cfquery name="updatepayrecord" datasource="#dts#">
    <cfif checkexist.recordcount neq 0>Update<cfelse>Insert Into</cfif> payrecord SET
    <cfif checkexist.recordcount eq 0>
    empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno##url.placement#">,
    Month = "#gsetup_qry.mmonth#",
    year = "#gsetup_qry.myear#",
    paytimes = "2",
    realempno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#">,
    placement = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.placement#">,
    invoiceno = "#url.invoiceno#",
	</cfif>
    BRATE = "#val(getpaytra1.BRATE)#",
    BRATE2 = "#val(getpaytra1.BRATE2)#",
    BACKPAY = "#val(getpaytra1.BACKPAY)#",
    OOB = "#val(getpaytra1.OOB)#",
    WDAY = "#val(getpaytra1.WDAY)#",
    WDAY2 = "#val(getpaytra1.WDAY2)#",
    DW = "#val(getpaytra1.DW)#",
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
    <cfif checkexist.recordcount neq 0>
	WHERE id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#checkexist.id#">
    </cfif>
    </cfquery>
    
    <cfset payrecordid = "">
    <cfif checkexist.recordcount neq 0>
    <cfset payrecordid = checkexist.id>
    <cfelse>
    <cfquery name="getlastid" datasource="#dts#">
    SELECT LAST_INSERT_ID() as lastid
    </cfquery>
    <cfset payrecordid = getlastid.lastid>
	</cfif>
    
<cfif isdefined('url.page')>
    <cfquery name="nex_list" datasource="#dts#">
    SELECT * FROM pmast WHERE empno > <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#">
	and paystatus = "A" and confid >= #hpin# ORDER BY empno ASC
    </cfquery>
    <cflocation url="/payments/2ndHalf/processpay2.cfm?empno=#URLEncodedFormat(nex_list.empno)#&payrecordid=#payrecordid#">
<cfelse>
	<cflocation url="/payments/2ndHalf/processpay2.cfm?empno=#URLEncodedFormat(form.empno)#&payrecordid=#payrecordid#">
</cfif>
<cfelseif url.type eq "all_add">
		<cfquery name="select_emp_list" datasource="#dts#">
			select empno from paytran
		</cfquery>
	
		<cfloop query="select_emp_list" >
			<cfset date_all = createdate(right(form.date_all,4),mid(form.date_all,4,2),left(form.date_all,2))>
			<cfquery name="add_pj_qry" datasource="#dts#">
				Insert into proj_rcd
				(empno,project_code,date_p,dw_p,mc_p,npl_p,ot1_p,ot2_p,ot3_p,ot4_p,ot5_p,ot6_p)
				values
				(<cfqueryparam cfsqltype="cf_sql_varchar" value="#select_emp_list.empno#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projecttype#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(date_all,'yyyymmdd')#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.all_dw#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.all_mc#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.all_npl#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.all_ot1#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.all_ot2#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.all_ot3#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.all_ot4#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.all_ot5#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.all_ot6#">)
			</cfquery>
		</cfloop>	
	
	<cfif isdefined('url.page')>
    <cfquery name="nex_list" datasource="#dts#">
    SELECT * FROM pmast WHERE empno > <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#">
	and paystatus = "A" and confid >= #hpin# ORDER BY empno ASC
    </cfquery>
    <cflocation url="/payments/2ndHalf/AddUpdate/normalPayEditForm.cfm?empno=#URLEncodedFormat(nex_list.empno)#&placement=#url.placement#&invoiceno=#url.invoiceno#">
<cfelse>
	<cflocation url="/payments/2ndHalf/AddUpdate/normalPayEditForm.cfm?empno=#URLEncodedFormat(form.empno)#&placement=#url.placement#&invoiceno=#url.invoiceno#">
</cfif>	
			
</cfif>
</cfoutput>