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
UPDATE payrecord
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
	<cfset qString="select * FROM payrecord WHERE empno ='#URLDecode(form.empno)#'">
	<cfinvoke component="cfc.auditTrail" method="toArray" dts="#dts#" qStr="#variables.qString#" returnvariable="array_ov">
	
	<!-- auto divide basic rate -->
	<cfquery name="cal_basicrate" datasource="#dts#">
		select BRATE,nppm,PAYRTYPE from pmast WHERE empno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#">
	</cfquery>
	<cfquery name="gsetup_qry" datasource="#dts_main#">
		select bp_h1pcm,bp_payment from gsetup WHERE comp_id = "#HcomID#"
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
	UPDATE payrecord
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
	UPDATE payrecord
	SET DIRFEE = "#val(form.DIRFEE)#",
    <cfloop from=101 to=117 index="i">
		AW#i# = "#val(evaluate('form.AW#i#'))#",
    </cfloop>
		DWAWADJ = "#val(form.DWAWADJ)#"
	WHERE empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#">
	</cfquery>
	

	
	<cfquery name="DED_qry" datasource="#dts#">
	UPDATE payrecord
	SET <cfloop from=101 to=115 index="i">DED#i# = "#val(evaluate('form.DED#i#'))#",</cfloop>
		MESS = "#val(form.MESS)#",
		MESS1 = "#val(form.MESS1)#"
	WHERE empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#">
	</cfquery>
	

	<cfquery name="OTH_qry" datasource="#dts#">
	UPDATE payrecord
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
	UPDATE payrecord
	SET DIRFEE = "#val(form.DIRFEE)#",
    <cfloop from=1 to=30 index="i">
		UDRATE#i# = "#val(evaluate('form.UDRATE#i#'))#",
    </cfloop>
		DWAWADJ = "#val(form.DWAWADJ)#"
	WHERE empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#">
	</cfquery>
	

	<cfinvoke component="cfc.auditTrail" method="createAuditFrmUpdate" dts="#dts#" act="update" 
			user="#Huserid#" module="PYM" pointer="payrecord[empno = '#URLDecode(form.empno)#']" oldArray="#array_ov#" 
			qStr="#qString#"  comment="2nd half normal pay 1/2">
	
	<cfquery name="more_qry" datasource="#dts#">
	UPDATE moretra
	SET PAYYES = "Y"
	WHERE empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#">
	</cfquery>
<cfif isdefined('url.page')>
    <cfquery name="nex_list" datasource="#dts#">
    SELECT * FROM pmast WHERE empno > <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#">
	and paystatus = "A" and confid >= #hpin# ORDER BY empno ASC
    </cfquery>
    <cflocation url="/payments/2ndHalf/AddUpdate/normalPayEditForm.cfm?empno=#URLEncodedFormat(nex_list.empno)#">
<cfelse>
	<cflocation url="/payments/2ndHalf/AddUpdate/normalPayEditForm.cfm?empno=#URLEncodedFormat(form.empno)#">
</cfif>
<cfelseif url.type eq "all_add">
		<cfquery name="select_emp_list" datasource="#dts#">
			select empno from payrecord
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
    <cflocation url="/payments/2ndHalf/AddUpdate/normalPayEditForm.cfm?empno=#URLEncodedFormat(nex_list.empno)#">
<cfelse>
	<cflocation url="/payments/2ndHalf/AddUpdate/normalPayEditForm.cfm?empno=#URLEncodedFormat(form.empno)#">
</cfif>	
			
</cfif>
</cfoutput>