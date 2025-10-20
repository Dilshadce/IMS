<cfif url.type eq "create">

<cfinvoke component="cfc.dateformat" method="dbDateFormat" inputDate="#form.dbirth#" returnvariable="cfc_dbirth" />

<cfinvoke component="cfc.dateformat" method="dbDateFormat" inputDate="#form.dcomm#" returnvariable="cfc_dcomm" />
<cfinvoke component="cfc.dateformat" method="dbDateFormat" inputDate="#form.dconfirm#" returnvariable="cfc_dconfirm" />
<cfinvoke component="cfc.dateformat" method="dbDateFormat" inputDate="#form.dpromote#" returnvariable="cfc_dpromote" />
<cfinvoke component="cfc.dateformat" method="dbDateFormat" inputDate="#form.dresign#" returnvariable="cfc_dresign" />
<cfinvoke component="cfc.dateformat" method="dbDateFormat" inputDate="#form.inc_date#" returnvariable="cfc_inc_date" />
<cfinvoke component="cfc.dateformat" method="dbDateFormat" inputDate="#form.m_inc_date#" returnvariable="cfc_m_inc_date" />
<cfinvoke component="cfc.dateformat" method="dbDateFormat" inputDate="#form.contract_f#" returnvariable="cfc_contract_f" />
<cfinvoke component="cfc.dateformat" method="dbDateFormat" inputDate="#form.contract_t#" returnvariable="cfc_contract_t" />

<cfinvoke component="cfc.dateformat" method="dbDateFormat" inputDate="#form.pr_from#" returnvariable="cfc_pr_from" />
<cfinvoke component="cfc.dateformat" method="dbDateFormat" inputDate="#form.wp_from#" returnvariable="cfc_wp_from" />
<cfinvoke component="cfc.dateformat" method="dbDateFormat" inputDate="#form.wp_to#" returnvariable="cfc_wp_to" />

<cfquery name="employeeInsert" datasource="#dts#">
INSERT INTO pmast (
				empno, name, iname, emp_code, add1, add2, postcode, town, state, national,
				phone, edu, exp, dbirth, nric, nricn, iccolor, passport, sex, race,
				relcode, mstatus, sname, snric, numchild, num_child, econtact,
				eadd1, eadd2, eadd3, etelno,
			
				jtitle,plineno,brcode,deptcode,category,source,dcomm,dconfirm,dpromote,dresign,payrtype,
				paymeth,paystatus,weekpay,confid,brate,inc_amt,inc_date,m_inc_amt,
				m_inc_date,contract,contract_f,contract_t,emp_status,cp8dgrp,emp_type,
			
				bankcode,brancode,bankaccno,bankcat,bankpmode,bankic,epfno,epftbl,
				epfcat,cpf_ceili,epf_fyee,epf_fyer,itaxbran,itaxno,itaxcat,
			
				r_statu,pr_num,pr_from,wpermit,wp_from,wp_to,emppass,fwlevytbl,fwlevymtd,fwlevyadj,
			
				whtbl,shifttbl,ottbl,almctbl,epf1hd,nppm,epfbrinsbp,epfbyer,otraterc,ot_maxpay,pbonus_mth,
			
				dbaw101,dbaw102,dbaw103,dbaw104,dbaw105,dbaw106,dbaw107,dbaw108,dbaw109,dbaw110,
				dbaw111,dbaw112,dbaw113,dbaw114,dbaw115,dbaw116,dbaw117,
			
				dbded101,dbded102,dbded103,dbded104,dbded105,dbded106,dbded107,dbded108,dbded109,dbded110,
				dbded111,dbded112,dbded113,dbded114,dbded115,
			
				dedmem111,dedmem112,dedmem113,dedmem114,dedmem115,
				created_on)
VALUES (
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.name#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.iname#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.emp_code#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.add1#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.add2#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.postcode#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.town#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.state#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.national#" >,
				
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.phone#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.edu#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.exp#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#cfc_dbirth#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.nric#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.nricn#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.iccolor#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.passport#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sex#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.race#" >,
				
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.relcode#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.mstatus#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sname#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.snric#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.numchild#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.num_child#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.econtact#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.eadd1#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.eadd2#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.eadd3#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.etelno#" >,
			
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.jtitle#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.plineno#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.brcode#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.deptcode#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.category#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.source#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#cfc_dcomm#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#cfc_dconfirm#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#cfc_dpromote#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#cfc_dresign#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.payrtype#" >,
			
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.paymeth#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.paystatus#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.weekpay#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.confid#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.brate#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.inc_amt#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#cfc_inc_date#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.m_inc_amt#" >,
				
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#cfc_m_inc_date#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.contract#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#cfc_contract_f#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#cfc_contract_t#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.emp_status#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cp8dgrp#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.emp_type#" >,
				
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.bankcode#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.brancode#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.bankaccno#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.bankcat#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.bankpmode#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.bankic#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.epfno#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.epftbl#" >,
				
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.epfcat#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cpf_ceili#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.epf_fyee#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.epf_fyer#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itaxbran#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itaxno#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itaxcat#" >,
				
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.r_statu#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.pr_num#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#cfc_pr_from#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.wpermit#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#cfc_wp_from#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#cfc_wp_to#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.emppass#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fwlevytbl#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fwlevymtd#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fwlevyadj#" >,
				
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.whtbl#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.shifttbl#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ottbl#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.almctbl#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.epf1hd#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.nppm#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.epfbrinsbp#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.epfbyer#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.otraterc#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ot_maxpay#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.pbonus_mth#" >,
			
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbaw101#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbaw102#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbaw103#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbaw104#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbaw105#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbaw106#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbaw107#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbaw108#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbaw109#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbaw110#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbaw111#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbaw112#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbaw113#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbaw114#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbaw115#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbaw116#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbaw117#" >,
				
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbded101#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbded102#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbded103#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbded104#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbded105#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbded106#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbded107#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbded108#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbded109#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbded110#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbded111#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbded112#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbded113#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbded114#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbded115#" >,
				
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dedmem111#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dedmem112#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dedmem113#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dedmem114#" >,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dedmem115#" >,
				<cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#" >
		)
</cfquery>

<cfquery name="payweek1" datasource="#dts#">
INSERT INTO payweek1 (empno)
VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#" >)
</cfquery>
<cfquery name="payweek2" datasource="#dts#">
INSERT INTO payweek2 (empno)
VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#" >)
</cfquery>
<cfquery name="payweek3" datasource="#dts#">
INSERT INTO payweek3 (empno)
VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#" >)
</cfquery>
<cfquery name="payweek4" datasource="#dts#">
INSERT INTO payweek4 (empno)
VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#" >)
</cfquery>
<cfquery name="payweek5" datasource="#dts#">
INSERT INTO payweek5 (empno)
VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#" >)
</cfquery>
<cfquery name="payweek6" datasource="#dts#">
INSERT INTO payweek6 (empno)
VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#" >)
</cfquery>

<cfquery name="paytra1" datasource="#dts#">
INSERT INTO paytra1 (empno)
VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#" >)
</cfquery>

<cfquery name="paytra1" datasource="#dts#">
INSERT INTO paytra1 (empno)
VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#" >)
</cfquery>


<cfloop from=1 to=10 index="i">
<cfquery name="adv_h1" datasource="#dts#">
INSERT INTO adv_h1 (empno)
VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#" >)
</cfquery>

</cfloop>


<cfloop from=1 to=10 index="j">
<cfquery name="adv_h2" datasource="#dts#">
INSERT INTO adv_h2 (empno)
VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#" >)
</cfquery>
</cfloop>

<cfquery name="bonus" datasource="#dts#">
INSERT INTO bonus (empno)
VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#" >)
</cfquery>

<cfquery name="comm" datasource="#dts#">
INSERT INTO comm (empno)
VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#" >)
</cfquery>

<cfquery name="extra" datasource="#dts#">
INSERT INTO extra (empno)
VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#" >)
</cfquery>

<cfquery name="itaxea" datasource="#dts#">
INSERT INTO itaxea (empno)
VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#" >)
</cfquery>

<cfquery name="moretr1" datasource="#dts#">
INSERT INTO moretr1 (empno)
VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#" >)
</cfquery>
<cfquery name="moretra" datasource="#dts#">
INSERT INTO moretra (empno)
VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#" >)
</cfquery>

<cfloop from=1 to=12 index="k">
<cfquery name="pay_12m" datasource="#dts#">
INSERT INTO pay_12m (empno, tmonth)
VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#">,
		#k#)
</cfquery>
</cfloop>

<cfquery name="pay_tm" datasource="#dts#">
INSERT INTO pay_tm (empno)
VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#" >)
</cfquery>

<cfquery name="pay_ytd" datasource="#dts#">
INSERT INTO pay_ytd (empno)
VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#" >)
</cfquery>

<cfquery name="paynot1" datasource="#dts#">
INSERT INTO paynot1 (empno)
VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#" >)
</cfquery>

<cfquery name="paynote" datasource="#dts#">
INSERT INTO paynote (empno)
VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#" >)
</cfquery>

<cflocation url="/personnel/employee/employeeMain.cfm">

<cfelseif url.type eq "update">

<cfinvoke component="cfc.dateformat" method="dbDateFormat" inputDate="#form.dbirth#" returnvariable="cfc_dbirth" />

<cfinvoke component="cfc.dateformat" method="dbDateFormat" inputDate="#form.dcomm#" returnvariable="cfc_dcomm" />
<cfinvoke component="cfc.dateformat" method="dbDateFormat" inputDate="#form.dconfirm#" returnvariable="cfc_dconfirm" />
<cfinvoke component="cfc.dateformat" method="dbDateFormat" inputDate="#form.dpromote#" returnvariable="cfc_dpromote" />
<cfinvoke component="cfc.dateformat" method="dbDateFormat" inputDate="#form.dresign#" returnvariable="cfc_dresign" />
<cfinvoke component="cfc.dateformat" method="dbDateFormat" inputDate="#form.inc_date#" returnvariable="cfc_inc_date" />
<cfinvoke component="cfc.dateformat" method="dbDateFormat" inputDate="#form.m_inc_date#" returnvariable="cfc_m_inc_date" />
<cfinvoke component="cfc.dateformat" method="dbDateFormat" inputDate="#form.contract_f#" returnvariable="cfc_contract_f" />
<cfinvoke component="cfc.dateformat" method="dbDateFormat" inputDate="#form.contract_t#" returnvariable="cfc_contract_t" />

<cfinvoke component="cfc.dateformat" method="dbDateFormat" inputDate="#form.pr_from#" returnvariable="cfc_pr_from" />
<cfinvoke component="cfc.dateformat" method="dbDateFormat" inputDate="#form.wp_from#" returnvariable="cfc_wp_from" />
<cfinvoke component="cfc.dateformat" method="dbDateFormat" inputDate="#form.wp_to#" returnvariable="cfc_wp_to" />


<cfquery name="employeeUpdate" datasource="#dts#" >
UPDATE pmast 
SET	name = 	<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.name#" >,
	iname = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.iname#" >,
	emp_code =	<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.emp_code#" >,
	add1 =	<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.add1#" >,
	add2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.add2#" >,
	postcode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.postcode#" >,
	town = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.town#" >,
	state = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.state#" >,
	national = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.national#" >,
				
	phone = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.phone#" >,
	edu = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.edu#" >,
	exp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.exp#" >,
	dbirth = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cfc_dbirth#" >,
	nric = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.nric#" >,
	nricn = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.nricn#" >,
	iccolor = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.iccolor#" >,
	passport = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.passport#" >,
	sex = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sex#" >,
	race = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.race#" >,
					
	relcode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.relcode#" >,
	mstatus = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.mstatus#" >,
	sname = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sname#" >,
	snric = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.snric#" >,
	numchild = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.numchild#" >,
	num_child = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.num_child#" >,
	econtact = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.econtact#" >,
	eadd1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.eadd1#" >,
	eadd2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.eadd2#" >,
	eadd3 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.eadd3#" >,
	etelno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.etelno#" >,
		
	jtitle = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.jtitle#" >,
	plineno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.plineno#" >,
	brcode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.brcode#" >,
	deptcode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.deptcode#" >,
	category = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.category#" >,
	source = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.source#" >,
	dcomm = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cfc_dcomm#" >,
	dconfirm = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cfc_dconfirm#" >,
	dpromote = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cfc_dpromote#" >,
	dresign = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cfc_dresign#" >,
	payrtype = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.payrtype#" >,
		
	paymeth = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.paymeth#" >,
	paystatus = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.paystatus#" >,
	weekpay = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.weekpay#" >,
	confid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.confid#" >,
	brate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.brate#" >,
	inc_amt = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.inc_amt#" >,
	inc_date = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cfc_inc_date#" >,
	m_inc_amt = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.m_inc_amt#" >,
			
	m_inc_date = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cfc_m_inc_date#" >,
	contract = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.contract#" >,
	contract_f = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cfc_contract_f#" >,
	contract_t = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cfc_contract_t#" >,
	emp_status = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.emp_status#" >,
	cp8dgrp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cp8dgrp#" >,
	emp_type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.emp_type#" >,
			
	bankcode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.bankcode#" >,
	brancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.brancode#" >,
	bankaccno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.bankaccno#" >,
	bankcat = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.bankcat#" >,
	bankpmode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.bankpmode#" >,
	bankic = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.bankic#" >,
	epfno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.epfno#" >,
	epftbl = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.epftbl#" >,
				
	epfcat = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.epfcat#" >,
	cpf_ceili = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cpf_ceili#" >,
	epf_fyee = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.epf_fyee#" >,
	epf_fyer = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.epf_fyer#" >,
	itaxbran = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itaxbran#" >,
	itaxno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itaxno#" >,
	itaxcat = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itaxcat#" >,
			
	r_statu = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.r_statu#" >,
	pr_num = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.pr_num#" >,
	pr_from = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cfc_pr_from#" >,
	wpermit = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.wpermit#" >,
	wp_from = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cfc_wp_from#" >,
	wp_to = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cfc_wp_to#" >,
	emppass = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.emppass#" >,
	fwlevytbl = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fwlevytbl#" >,
	fwlevymtd = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fwlevymtd#" >,
	fwlevyadj = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fwlevyadj#" >,
			
	whtbl = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.whtbl#" >,
	shifttbl = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.shifttbl#" >,
	ottbl = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ottbl#" >,
	almctbl = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.almctbl#" >,
	epf1hd = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.epf1hd#" >,
	nppm = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.nppm#" >,
	epfbrinsbp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.epfbrinsbp#" >,
	epfbyer = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.epfbyer#" >,
	otraterc = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.otraterc#" >,
	ot_maxpay = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ot_maxpay#" >,
	pbonus_mth = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.pbonus_mth#" >,
		
	dbaw101 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbaw101#" >,
	dbaw102 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbaw102#" >,
	dbaw103 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbaw103#" >,
	dbaw104 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbaw104#" >,
	dbaw105 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbaw105#" >,
	dbaw106 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbaw106#" >,
	dbaw107 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbaw107#" >,
	dbaw108 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbaw108#" >,
	dbaw109 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbaw109#" >,
	dbaw110 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbaw110#" >,
	dbaw111 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbaw111#" >,
	dbaw112 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbaw112#" >,
	dbaw113 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbaw113#" >,
	dbaw114 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbaw114#" >,
	dbaw115 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbaw115#" >,
	dbaw116 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbaw116#" >,
	dbaw117 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbaw117#" >,
				
	dbded101 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbded101#" >,
	dbded102 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbded102#" >,
	dbded103 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbded103#" >,
	dbded104 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbded104#" >,
	dbded105 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbded105#" >,
	dbded106 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbded106#" >,
	dbded107 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbded107#" >,
	dbded108 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbded108#" >,
	dbded109 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbded109#" >,
	dbded110 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbded110#" >,
	dbded111 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbded111#" >,
	dbded112 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbded112#" >,
	dbded113 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbded113#" >,
	dbded114 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbded114#" >,
	dbded115 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dbded115#" >,
			
	dedmem111 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dedmem111#" >,
	dedmem112 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dedmem112#" >,
	dedmem113 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dedmem113#" >,
	dedmem114 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dedmem114#" >,
	dedmem115 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dedmem115#" >,
	updated_on = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#" >

WHERE  empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#" >
</cfquery>
<cflocation url="/personnel/employee/employeeMain.cfm">

<cfelseif url.type eq "del">
<cfquery name="employeeDelete" datasource="#dts#" >
DELETE FROM pmast
WHERE	empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.empno#" >
</cfquery>

<cfquery name="del_payweek1" datasource="#dts#" >
DELETE FROM payweek1
WHERE	empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.empno#" >
</cfquery>
<cfquery name="del_payweek2" datasource="#dts#" >
DELETE FROM payweek2
WHERE	empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.empno#" >
</cfquery>
<cfquery name="del_payweek3" datasource="#dts#" >
DELETE FROM payweek3
WHERE	empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.empno#" >
</cfquery>
<cfquery name="del_payweek4" datasource="#dts#" >
DELETE FROM payweek4
WHERE	empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.empno#" >
</cfquery>
<cfquery name="del_payweek5" datasource="#dts#" >
DELETE FROM payweek5
WHERE	empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.empno#" >
</cfquery>
<cfquery name="del_payweek6" datasource="#dts#" >
DELETE FROM payweek6
WHERE	empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.empno#" >
</cfquery>

<cfquery name="del_paytra1" datasource="#dts#" >
DELETE FROM paytra1
WHERE	empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.empno#" >
</cfquery>

<cfquery name="del_paytra1" datasource="#dts#" >
DELETE FROM paytra1
WHERE	empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.empno#" >
</cfquery>

<cfquery name="del_adv_h1" datasource="#dts#" >
DELETE FROM adv_h1
WHERE	empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.empno#" >
</cfquery>

<cfquery name="del_adv_h2" datasource="#dts#" >
DELETE FROM adv_h2
WHERE	empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.empno#" >
</cfquery>

<cfquery name="del_bonus" datasource="#dts#" >
DELETE FROM bonus
WHERE	empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.empno#" >
</cfquery>

<cfquery name="del_comm" datasource="#dts#" >
DELETE FROM comm
WHERE	empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.empno#" >
</cfquery>

<cfquery name="del_extra" datasource="#dts#" >
DELETE FROM extra
WHERE	empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.empno#" >
</cfquery>

<cfquery name="del_itaxea" datasource="#dts#" >
DELETE FROM itaxea
WHERE	empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.empno#" >
</cfquery>

<cfquery name="del_moretr1" datasource="#dts#" >
DELETE FROM moretr1
WHERE	empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.empno#" >
</cfquery>

<cfquery name="del_moretra" datasource="#dts#" >
DELETE FROM moretra
WHERE	empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.empno#" >
</cfquery>

<cfquery name="del_pay_12m" datasource="#dts#" >
DELETE FROM pay_12m
WHERE	empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.empno#" >
</cfquery>

<cfquery name="del_pay_tm" datasource="#dts#" >
DELETE FROM pay_tm
WHERE	empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.empno#" >
</cfquery>

<cfquery name="del_pay_ytd" datasource="#dts#" >
DELETE FROM pay_ytd
WHERE	empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.empno#" >
</cfquery>

<cfquery name="del_paynot1" datasource="#dts#" >
DELETE FROM paynot1
WHERE	empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.empno#" >
</cfquery>

<cfquery name="del_paynote" datasource="#dts#" >
DELETE FROM paynote
WHERE	empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.empno#" >
</cfquery>
<cflocation url="/personnel/employee/employeeMain.cfm">

</cfif>