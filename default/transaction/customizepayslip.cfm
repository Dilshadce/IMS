<cfquery name="Clear_temp_cuz_payslip" datasource="#dts#">
  DELETE FROM temp_cuz_payslip WHERE username="#HUserName#"	
</cfquery>
<cfquery name="company_details" datasource="#dts_main#">
SELECT * FROM gsetup WHERE comp_id = "#HcomID#"
</cfquery>
<cfquery name="getotdesp" datasource="#dts#">
   SELECT ot_desp FROM ottable
 </cfquery>
<cfset OTDESP1 = getotdesp['ot_desp'][1]>
<cfset OTDESP2 = getotdesp['ot_desp'][2]>
<cfset OTDESP3 = getotdesp['ot_desp'][3]>
<cfset OTDESP4 = getotdesp['ot_desp'][4]>
<cfset OTDESP5 = getotdesp['ot_desp'][5]>
<cfset OTDESP6 = getotdesp['ot_desp'][6]>     
<cfset mon = company_details.mmonth>
<cfset yrs = company_details.myear>
<cfset date= createdate(yrs,mon,1)>
<cfset month1= dateformat(date,'mmmm')>
<cfset year1= dateformat(date,'yyyy')>
<cfif type eq "pay12m">
<cfset paytable = form.paytype>
<cfset monthpay = form.month>
<cfelse>
<cfset paytable = url.type>
</cfif>
<cfquery name="selectList" datasource="#dts#">
SELECT py.netpay as pnetpay, py.grosspay as pgrosspay, py.epfcc as pepfcc, py.epfww as pepfww, py.basicpay as pbasicpay, pc.empno,
 pc.name, pc.category, pc.deptcode, pc.basicpay, pc.epfww,
pc.aw101,pc.aw102,pc.aw103,pc.aw104,pc.aw105,pc.aw106,pc.aw107,pc.aw108,pc.aw109,pc.aw110,pc.aw111,pc.aw112
,pc.aw113,pc.aw114,pc.aw115,pc.aw116,pc.aw117,pc.ded101,pc.ded102,pc.ded103,pc.ded104,pc.ded105,pc.ded106,
pc.ded107,pc.ded108,pc.ded109,pc.ded110,pc.ded111,pc.ded112,pc.ded113,pc.ded114,pc.ded115,pc.bankcode,
pc.brancode,pc.bankaccno,tnetpay, tgrosspay,tepfww, tepfcc,AL,MC,CC,pc.ptmc,pc.ptal,pc.pmalbf,pc.pmalall,pc.pmmcall,pc.ptcpfamt,py.cpf_amt,pc.nplpay,pc.latehr,pc.earlyhr,pc.nopayhr,pc.total_late_h,pc.total_earlyD_h,pc.total_nop_h,pc.hourrate,pc.brate,pc.ot1,pc.ot2,pc.ot3,pc.ot4,pc.ot5,pc.ot6,pc.hr1,pc.hr2,pc.hr3,pc.hr4,pc.hr5,pc.hr6,pc.rate1,pc.rate2,pc.rate3,pc.rate4,pc.rate5,pc.rate6,pc.otpay,pc.ptcc,pc.pmccall,pc.npl,pc.ls,pc.ab
FROM pay_ytd AS py LEFT JOIN
(SELECT pt.empno, pm.name, pm.category, pm.deptcode, pt.brate as basicpay, pt.epfww,
pt.aw101,pt.aw102,pt.aw103,pt.aw104,pt.aw105,pt.aw106,pt.aw107,pt.aw108,pt.aw109,pt.aw110,pt.aw111,pt.aw112
,pt.aw113,pt.aw114,pt.aw115,pt.aw116,pt.aw117,pt.ded101,pt.ded102,pt.ded103,pt.ded104,pt.ded105,pt.ded106,pt.ded107,pt.ded108
,pt.ded109,pt.ded110,pt.ded111,pt.ded112,pt.ded113,pt.ded114,pt.ded115,pm.bankcode,pm.brancode,pm.bankaccno,pt.netpay as tnetpay,pt.grosspay as tgrosspay,
pt.epfww as tepfww, pt.epfcc as tepfcc,pt.AL as ptal,pt.MC as ptmc,pm.albf as pmalbf, pm.alall as pmalall ,pm.mcall as pmmcall,<cfif type neq "pay12m">pt.cpf_amt<cfelse>pt.grosspay</cfif> as ptcpfamt,pt.nplpay,pt.latehr,pt.earlyhr,pt.nopayhr,pt.npl,pt.ls,pt.ab,
<cfif type neq "pay12m">
pt.total_late_h,pt.total_earlyD_h,pt.total_nop_h,pt.hourrate
<cfelse>
"0" as total_late_h,"0" as total_earlyD_h,"0" as total_nop_h, "0" as hourrate
</cfif>,pt.brate,pt.ot1,pt.ot2,pt.ot3,pt.ot4,pt.ot5,pt.ot6,pt.hr1,pt.hr2,pt.hr3,pt.hr4,pt.hr5,pt.hr6,pt.rate1,pt.rate2,pt.rate3,pt.rate4,pt.rate5,pt.rate6,pt.otpay,pt.cc as ptcc,pm.ccall as pmccall
FROM #paytable#
 AS pt 
LEFT JOIN 
pmast AS pm 
ON pt.empno=pm.empno
where 
<cfif type neq "pay12m">
payyes="Y" 
AND
<cfelse>
tmonth = "#monthpay#" AND
</cfif>
 pm.paystatus ="A" 
and confid >= #hpin#)AS pc
On 
pc.empno= py.empno 
where 
pc.empno is not null 
order by pc.empno;

</cfquery>

<cfset dedname = "">
<cfset dedamount = 0>
<cfset awname = "">	
<cfset awamount = 0>
<cfloop query="selectList">
<cfset albal = val(selectList.pmalall) + val(selectList.pmalbf) - val(selectList.al) - val(selectList.ptal)>
<cfset mcbal = val(selectList.pmmcall)-val(selectList.mc)-val(selectList.ptmc)>
<cfset ccbal = val(selectList.pmccall)-val(selectList.cc)-val(selectList.ptcc)>

		<cfloop from="1" to="17" index="i">
			<cfset awvar = 100 + i>
			<cfset awvar2 = "AW"&awvar>
			<cfset awname1 = selectList[awvar2]>
			
			<cfif val(awname1) neq 0>
            <cfset awno = 100 + i>
            <cfquery name="getawdesp" datasource="#dts#">
            SELECT AW#awno# as aw_desp FROM paynote WHERE empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#selectList.empno#">
            </cfquery>
            <cfif getawdesp.aw_desp eq "">
            <cfquery name="getawdesp" datasource="#dts#">
			SELECT aw_desp from awtable where aw_cou = "#i#"
			</cfquery>
            </cfif>
				
					
				<cfset awname = awname&getawdesp.aw_desp&"<br />">
				
				<cfif awamount eq "0">
					<cfset awamount = awname1&"<br />">
				<cfelse>
					<cfset awamount = awamount&awname1&"<br />">
				</cfif>
				 
			</cfif>
		</cfloop>
		
		
		<cfloop from="1" to="15" index="i">
			<cfset dedvar = 100 + i>
			<cfset dedvar2 = "DED"&dedvar>
			<cfset dedname1 = selectList[dedvar2]>
			<cfif val(dedname1) neq 0>
            <cfquery name="getdeddesp" datasource="#dts#">
            SELECT DED#dedvar# as ded_desp FROM paynote WHERE empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#selectList.empno#">
            </cfquery>
            <cfif getdeddesp.ded_desp eq "">
            <cfquery name="getdeddesp" datasource="#dts#">
            SELECT ded_desp from dedtable where ded_cou = "#i#"
            </cfquery>
            </cfif>
					<cfset dedname = dedname&getdeddesp.ded_desp&"<br />">
				<cfif dedamount eq "0">
					<cfset dedamount = "-"&dedname1&"<br />">
				<cfelse>
					<cfset dedamount = dedamount&"-"&dedname1&"<br />">
				</cfif>
			</cfif>
		</cfloop>
        
        <cfset nplist = "">
        <cfset nphramount = 0>
        
        <cfif val(selectList.latehr) gt 0>
        <cfset nphramount = nphramount + val(selectlist.total_late_h)>
		<cfset latehourate = val(selectList.hourrate) * #company_details.bp_dedratio#>
        <cfset nplist = nplist&"Lateness -"&numberformat(val(selectList.latehr),'.__')&"@   "&numberformat(val(latehourate),'.__')&" = "&numberformat(val(selectList.total_late_h),'.__')&chr(13)>
        </cfif>
        
        <cfif val(selectList.earlyhr) gt 0>
        <cfset nphramount = nphramount + val(selectlist.total_earlyD_h)>
        <cfset nplist = nplist&"Early Depart -"&numberformat(val(selectList.earlyhr),'.__')&"@   "&numberformat(val(selectList.hourrate),'.__')&" = "&numberformat(val(selectList.total_earlyD_h),'.__')&chr(13)>
        </cfif>
        
         <cfif val(selectList.nopayhr) gt 0>
        <cfset nphramount = nphramount + val(selectlist.total_nop_h)>
        <cfset nplist = nplist&"No Pay -"&numberformat(val(selectList.nopayhr),'.__')&"@   "&numberformat(val(selectList.hourrate),'.__')&" = "&numberformat(val(selectList.total_nop_h),'.__')&chr(13)>
        </cfif>
        
        <cfif val(selectList.ls) gt 0>
        <cfset nplist = nplist&"Line Shut Down -"&numberformat(val(selectList.ls),'.__')&" days @   "&numberformat(val(selectlist.nplpay)/(val(selectList.npl)+val(selectList.ls)+val(selectList.ab))*val(selectList.ls),'.__')&chr(13)>
        </cfif>
        
        <cfif val(selectList.npl) gt 0>
        <cfset nplist = nplist&"NPL -"&numberformat(val(selectList.npl),'.__')&" days @   "&numberformat(val(selectlist.nplpay)/(val(selectList.npl)+val(selectList.ls)+val(selectList.ab))*val(selectList.npl),'.__')&chr(13)>
        </cfif>  
        
        
        
        <cfif val(selectList.ab) gt 0>
        <cfset nplist = nplist&"Absent -"&numberformat(val(selectList.ab),'.__')&" days @   "&numberformat(val(selectlist.nplpay)/(val(selectList.npl)+val(selectList.ls)+val(selectList.ab))*val(selectList.ab),'.__')&chr(13)>
        </cfif>  

        
        <cfset othr = "">
        <cfset otpay = 0>
        <cfif val(selectList.otpay) gt 0>
		<cfloop from="1" to="6" index="i">
        
        <cfif val(evaluate('selectlist.hr#i#')) neq 0>
        <cfset othr = othr&evaluate('OTDESP#i#')&" -  "&val(evaluate('selectlist.hr#i#'))&"@   "&numberformat(val(evaluate('selectlist.rate#i#')),'.__')&" = "&numberformat(val(evaluate('selectlist.OT#i#')),'.__')&chr(13)>
        </cfif>
        </cfloop>
		</cfif>
        
		<cfquery name="insertTempTable" datasource="#dts#">
		INSERT INTO temp_cuz_payslip(  `name` ,  `empl` ,  `cate` ,  `dept` ,  `basicPay` ,  `emp_cpf` ,  `aw_name1` ,  `aw_amt1` ,
		  `ded_name1` ,  `ded_amt1` ,   `tnetpay` ,
		  `pgrosspay` ,  `pbasicpay` ,  `pepfcc` ,  `pepfww` ,  `username`  , `bankcode` ,  `brancode` ,  `bankaccno` ,
		  `pnetpay` ,  `tgrosspay` ,  `tepfww` ,  `tepfcc`,ytd_al,ytd_mc,bal_ytd_al,bal_ytd_mc,AL,MC,cpf_amt,ytd_cpf_amt,nplpay,nplhr,npllist,basicrate,othr,otpay,CC,ytd_cc,bal_ytd_cc )
		values 
		(<cfqueryparam cfsqltype="cf_sql_varchar" value="#selectList.name#">, 
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#selectList.empno#">,
		<cfqueryparam cfsqltype="cf_sql_char" value="#selectList.category#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#selectList.deptcode#">,
		"#val(selectList.basicpay)#",
		"#val(selectList.epfww)#",
		<cfqueryparam cfsqltype="cf_sql_varchar" value='#awname#'>,
		<cfqueryparam cfsqltype="cf_sql_varchar" value='#awamount#'>,
		<cfqueryparam cfsqltype="cf_sql_varchar" value='#dedname#'>,
		<cfqueryparam cfsqltype="cf_sql_varchar" value='#dedamount#'>,
		"#val(selectList.tnetpay)#","#val(selectList.pgrosspay)#",
		"#val(selectList.pbasicpay)#","#val(selectList.pepfcc)#",
		"#val(selectList.pepfww)#", <cfqueryparam cfsqltype="cf_sql_varchar" value="#HUserName#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#selectList.bankcode#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#selectList.brancode#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#selectList.bankaccno#">,
		"#val(selectList.pnetpay)#","#val(selectList.tgrosspay)#",
		"#val(selectList.tepfww)#","#val(selectList.tepfcc)#",
        <cfqueryparam cfsqltype="cf_sql_double" value="#val(selectList.AL)#">,
        <cfqueryparam cfsqltype="cf_sql_double" value="#val(selectList.MC)#">,
        <cfqueryparam cfsqltype="cf_sql_double" value="#val(albal)#">,
        <cfqueryparam cfsqltype="cf_sql_double" value="#val(mcbal)#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(selectList.PTAL)#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(selectList.PTMC)#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(selectList.ptcpfamt)#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(selectList.cpf_amt)#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(selectList.nplpay)#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(nphramount)#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#nplist#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(selectList.brate)#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#othr#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(selectList.otpay)#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(selectList.PTCC)#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(selectList.CC)#">,
        <cfqueryparam cfsqltype="cf_sql_double" value="#val(ccbal)#">
		)
		</cfquery>
		
		<cfset dedname = "">
		<cfset dedamount = 0>
		<cfset awname = "">	
		<cfset awamount = 0>
</cfloop>

<cfif isdefined('form.order')>
<cfset order_keyword="pm."&#form.order#>
<cfelse>
<cfset order_keyword="pm.empno">
</cfif>
<cfquery name="select_temp_data" datasource="#dts#" >
	select * FROM (SELECT t.*,pm.brate,pm.payrtype as payrtype1 FROM temp_cuz_payslip as t left join pmast as pm on t.empl=pm.empno where username="#HUserName#"
	
<cfif #form.empno# neq "">
	AND pm.empno >= "#form.empno#"
</cfif>
<cfif #form.empno1# neq "">
	AND pm.empno <= "#form.empno1#"
</cfif>
<cfif #form.lineno# neq "">
	AND pm.plineno >= "#form.lineno#"
</cfif>
<cfif #form.lineno1# neq "">
	AND pm.plineno <= "#form.lineno1#"
</cfif>
<cfif #form.brcode# neq "">
	AND pm.brcode >= "#form.brcode#"
</cfif>
<cfif #form.brcode1# neq "">
	AND pm.brcode <= "#form.brcode1#"
</cfif>
<cfif #form.deptcode# neq "">
	AND pm.deptcode >= "#form.deptcode#"
</cfif>
<cfif #form.deptcode1# neq "">
	AND pm.deptcode <= "#form.deptcode1#"
</cfif>
<cfif #form.category# neq "">
	AND pm.category >= "#form.category#"
</cfif>
<cfif #form.category1# neq "">
	AND pm.category <= "#form.category1#"
</cfif>
<cfif #form.emp_code# neq "">
	AND pm.emp_code >= "#form.emp_code#"
</cfif>
<cfif #form.emp_code1# neq "">
	AND pm.emp_code <= "#form.emp_code1#"
</cfif>
<cfif isdefined('form.confid')>
<cfif #form.confid# neq "">
	AND pm.confid = "#form.confid#"
</cfif>
<cfelse>
	AND pm.confid >= #hpin#
</cfif>
<cfif isdefined('form.payrtype')>
<cfif #form.payrtype# neq "">
	AND pm.payrtype = "#form.payrtype#"
</cfif>
</cfif>
<cfif isdefined('form.paymeth')>
<cfif #form.paymeth# neq "">
	AND pm.paymeth <= "#form.paymeth#"
</cfif>
</cfif>
<cfif isdefined('form.exclude0')>
	AND basicpay > 0
</cfif>


<cfif isdefined('form.order')>
<cfif #form.order# neq "">
	ORDER BY #order_keyword# asc
<cfelse>
	ORDER BY pm.empno
</cfif> 
<cfelse>
	ORDER BY pm.empno
</cfif>
) as aa left join (select empno as empno1,WORKHR,basicpay as basicpay1 FROM #paytable#) as bb
  on aa.empl = bb.empno1
</cfquery>
<cfif isdefined('form.remark')>
<cfset remark = form.remark>
<cfelse>
<cfset remark = "">
</cfif>

<cfreport template="customizepayslip.cfr" format="PDF" query="select_temp_data">
 	<cfreportparam name="compname" value="#company_details.COMP_NAME#">
	<cfreportparam name="month1" value="#month1#">
	<cfreportparam name="year1" value="#year1#">
	<cfreportparam name="remark" value="#remark#">
    <cfreportparam name="paytype" value="#url.type#">
</cfreport>