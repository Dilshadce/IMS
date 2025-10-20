<cfquery name="getartran" datasource="#dts#">
	select 
	(round(invgross+0.000001,2)-round(discount+0.000001,2)+round(tax+0.000001,2)) as amtt,
	(round(gross_bil+0.000001,2)-round(disc_bil+0.000001,2)+round(tax_bil+0.000001,2)) as amtt2,
	(round(invgross+0.000001,2)-round(discount+0.000001,2)) as incltax_amtt,
	(round(gross_bil+0.000001,2)-round(disc_bil+0.000001,2)) as incltax_amtt2,
    <cfif lcase(hcomid) eq "mhsl_i">
		(round(invgross+0.000001,2)-round(discount+0.000001,2)+round(tax+0.000001,2)+round(taxnbt+0.000001,2)) as amttnbt,
        (round(gross_bil+0.000001,2)-round(disc_bil+0.000001,2)+round(tax_bil+0.000001,2)+round(taxnbt_bil+0.000001,2)) as amttnbt2,
	</cfif>
	type,
	refno,
	refno2,
	fperiod,
	custno,
	wos_date,
	if(currrate=0 or currrate is null,1,currrate) as currrate,
	invgross,
	discount,
	net,
	tax,
	taxp1,
	gross_bil,
	disc_bil,
	net_bil,
	tax_bil,
	name,
	tax,
	tax1_bil,
	disc1_bil,
	discount,
	note,
	pono,
	desp,
	despa,
	rem6,
	rem9,
	m_charge1,
	m_charge2,
	m_charge3,
	m_charge4,
	m_charge5,
	m_charge6,
	m_charge7,
	mc1_bil,
	mc2_bil,
	mc3_bil,
	mc4_bil,
	mc5_bil,
	mc6_bil,
	mc7_bil,
	cs_pm_cash as cs_pm_cash_bil,
	(cs_pm_cash*currrate) as cs_pm_cash,
	cs_pm_cheq as cs_pm_cheq_bil,
	(cs_pm_cheq*currrate) as cs_pm_cheq,
	cs_pm_crcd as cs_pm_crcd_bil,
	(cs_pm_crcd*currrate) as cs_pm_crcd,
	cs_pm_crc2 as cs_pm_crc2_bil,
	(cs_pm_crc2*currrate) as cs_pm_crc2,
	cs_pm_vouc as cs_pm_vouc_bil,
	(cs_pm_vouc*currrate) as cs_pm_vouc,
	deposit as deposit_bil,
	(deposit*currrate) as deposit,
	ifnull((cs_pm_cash+cs_pm_cheq+cs_pm_crcd+cs_pm_crc2+cs_pm_vouc+deposit),0) as total_multiple_payments_bil,
	ifnull(((cs_pm_cash+cs_pm_cheq+cs_pm_crcd+cs_pm_crc2+cs_pm_vouc+deposit)*currrate),0) as total_multiple_payments,
	taxincl
    <cfif lcase(hcomid) eq "mhsl_i">,taxnbt,taxnbt_bil</cfif>
	from artran 
	where type='#gettran.type#' and refno='#gettran.refno#' and fperiod <> '99'
	group by refno
</cfquery>

<cfoutput>
<cfloop query="getartran">
	<cfset type = getartran.type>
	<cfset refno = getartran.refno>
	
	<tr>
		<td>#getartran.type#</td>
		<td>#getartran.refno#</td>
		<td>#dateformat(getartran.wos_date,"dd/mm/yyyy")#</td>
		
		<cfif getartran.type eq "RC" or getartran.type eq "CN">
			<cfset acctype = "Cr">
			<cfset mtype = "supp">
		<cfelse>
			<cfset acctype = "D">
			<cfset mtype = "cust">
		</cfif>
		
		
		<cfquery name="check_misc" datasource="#dts#">
			select 
			(
				ifnull(b.m_charge1,0)+
				ifnull(b.m_charge2,0)+
				ifnull(b.m_charge3,0)+
				ifnull(b.m_charge4,0)+
				ifnull(b.m_charge5,0)+
				ifnull(b.m_charge6,0)+
				ifnull(b.m_charge7,0)
			) as summisc,
			(
				ifnull(b.mc1_bil,0)+
				ifnull(b.mc2_bil,0)+
				ifnull(b.mc3_bil,0)+
				ifnull(b.mc4_bil,0)+
				ifnull(b.mc5_bil,0)+
				ifnull(b.mc6_bil,0)+
				ifnull(b.mc7_bil,0)
			) as summisc_bil,
			(
				if((a.#mtype#misc1='' or a.#mtype#misc1='0000/000'),b.m_charge1,0)+
				if((a.#mtype#misc2='' or a.#mtype#misc2='0000/000'),b.m_charge2,0)+
				if((a.#mtype#misc3='' or a.#mtype#misc3='0000/000'),b.m_charge3,0)+
				if((a.#mtype#misc4='' or a.#mtype#misc4='0000/000'),b.m_charge4,0)+
				if((a.#mtype#misc5='' or a.#mtype#misc5='0000/000'),b.m_charge5,0)+
				if((a.#mtype#misc6='' or a.#mtype#misc6='0000/000'),b.m_charge6,0)+
				if((a.#mtype#misc7='' or a.#mtype#misc7='0000/000'),b.m_charge7,0)
			) as sum_without_misc,
			(
				if((a.#mtype#misc1='' or a.#mtype#misc1='0000/000'),b.mc1_bil,0)+
				if((a.#mtype#misc2='' or a.#mtype#misc2='0000/000'),b.mc2_bil,0)+
				if((a.#mtype#misc3='' or a.#mtype#misc3='0000/000'),b.mc3_bil,0)+
				if((a.#mtype#misc4='' or a.#mtype#misc4='0000/000'),b.mc4_bil,0)+
				if((a.#mtype#misc5='' or a.#mtype#misc5='0000/000'),b.mc5_bil,0)+
				if((a.#mtype#misc6='' or a.#mtype#misc6='0000/000'),b.mc6_bil,0)+
				if((a.#mtype#misc7='' or a.#mtype#misc7='0000/000'),b.mc7_bil,0)
			) as sum_without_misc_bil,
			(
				if((a.#mtype#misc1<>'' and a.#mtype#misc1<>'0000/000'),1,0)+
				if((a.#mtype#misc2<>'' and a.#mtype#misc2<>'0000/000'),1,0)+
				if((a.#mtype#misc3<>'' and a.#mtype#misc3<>'0000/000'),1,0)+
				if((a.#mtype#misc4<>'' and a.#mtype#misc4<>'0000/000'),1,0)+
				if((a.#mtype#misc5<>'' and a.#mtype#misc5<>'0000/000'),1,0)+
				if((a.#mtype#misc6<>'' and a.#mtype#misc6<>'0000/000'),1,0)+
				if((a.#mtype#misc7<>'' and a.#mtype#misc7<>'0000/000'),1,0)
			) as misccount 
			from gsetup as a,artran as b
			where b.type='#type#' 
			and b.refno='#refno#';
		</cfquery>
		
		<cfquery name="get_multiple_payments" datasource="#dts#">
			select 
			(
				if((a.cashaccount='' or a.cashaccount='0000/000'),b.cs_pm_cash,0)+
				if((a.chequeaccount='' or a.chequeaccount='0000/000'),b.cs_pm_cheq,0)+
				if((a.creditcardaccount1=''	or a.creditcardaccount1='0000/000'),b.cs_pm_crcd,0)+
				if((a.creditcardaccount2='' or a.creditcardaccount2='0000/000'),b.cs_pm_crc2,0)+
				if((a.cashvoucheraccount='' or a.cashvoucheraccount='0000/000'),b.cs_pm_vouc,0)+
				if((a.depositaccount='' or a.depositaccount='0000/000'),b.deposit,0)
			) as sum_without_payments_bil,
			(
				(
					if((a.cashaccount='' or a.cashaccount='0000/000'),b.cs_pm_cash,0)+
					if((a.chequeaccount='' or a.chequeaccount='0000/000'),b.cs_pm_cheq,0)+
					if((a.creditcardaccount1=''	or a.creditcardaccount1='0000/000'),b.cs_pm_crcd,0)+
					if((a.creditcardaccount2='' or a.creditcardaccount2='0000/000'),b.cs_pm_crc2,0)+
					if((a.cashvoucheraccount='' or a.cashvoucheraccount='0000/000'),b.cs_pm_vouc,0)+
					if((a.depositaccount='' or a.depositaccount='0000/000'),b.deposit,0)
				)*b.currrate
			) as sum_without_payments,
			(
				if((a.cashaccount<>'' and a.cashaccount<>'0000/000'),b.cs_pm_cash,0)+
				if((a.chequeaccount<>'' and a.chequeaccount<>'0000/000'),b.cs_pm_cheq,0)+
				if((a.creditcardaccount1<>'' and a.creditcardaccount1<>'0000/000'),b.cs_pm_crcd,0)+
				if((a.creditcardaccount2<>'' and a.creditcardaccount2<>'0000/000'),b.cs_pm_crc2,0)+
				if((a.cashvoucheraccount<>'' and a.cashvoucheraccount<>'0000/000'),b.cs_pm_vouc,0)+
				if((a.depositaccount<>'' and a.depositaccount<>'0000/000'),b.deposit,0)
			) as sum_payments_bil,
			(	
				(
					if((a.cashaccount<>'' and a.cashaccount<>'0000/000'),b.cs_pm_cash,0)+
					if((a.chequeaccount<>'' and a.chequeaccount<>'0000/000'),b.cs_pm_cheq,0)+
					if((a.creditcardaccount1<>'' and a.creditcardaccount1<>'0000/000'),b.cs_pm_crcd,0)+
					if((a.creditcardaccount2<>'' and a.creditcardaccount2<>'0000/000'),b.cs_pm_crc2,0)+
					if((a.cashvoucheraccount<>'' and a.cashvoucheraccount<>'0000/000'),b.cs_pm_vouc,0)+
					if((a.depositaccount<>'' and a.depositaccount<>'0000/000'),b.deposit,0)
				)*b.currrate
			) as sum_payments
			
			from gsetup as a,artran as b 
			where b.type='#type#' 
			and b.refno='#refno#';
		</cfquery>
		
		<td>
			<cfif acctype eq "D">
				<cfif getartran.taxincl eq "T"<!---  and val(getaccno.gst) neq 0 --->>
					<cfset getartran.amtt=getartran.incltax_amtt>
				</cfif>
            	<div align="right">#numberformat(getartran.amtt+check_misc.summisc-get_multiple_payments.sum_payments,".__")#</div>
			</cfif>
        </td>
		<td>
			<cfif acctype eq "Cr">
            	<cfif lcase(hcomid) eq "mhsl_i" and getartran.type eq "RC">
            		<div align="right">#numberformat(getartran.amttnbt+check_misc.summisc-get_multiple_payments.sum_payments,".__")#</div>
				<cfelse>
            		<div align="right">#numberformat(getartran.amtt+check_misc.summisc-get_multiple_payments.sum_payments,".__")#</div>
				</cfif>
			</cfif>
        </td>
		<td>&nbsp;</td>
		<td>#ceiling(getartran.fperiod)#</td>
		<td>#getartran.custno#</td>
		<td>#acctype#</td>
		<td nowrap>#getartran.name#</td>
	</tr>

	<cfif post eq "post">
		<cfset billno = code&refno>
		
		<cfif type eq "RC" or type eq "CN"<!---  or type eq "PR" --->>
			<cfquery name="insertpost1" datasource="#dts#">
				insert into glpost9 
				(
					acc_code,
					accno,
					fperiod,
					date,
					reference,
					refno,
					desp,
					despa,
					creditamt,
					fcamt,
					exc_rate,
					rem4,
					rem5,
					bdate,
					userid
				)
				values 
				(
					'#type#',
					'#custno#',
					'#ceiling(fperiod)#',
					#getartran.wos_date#,
					'#billno#',
					'#refno2#',
					<cfif getaccno.postvalue eq "pono" and type eq "RC">
						'#pono#',
					<cfelseif getaccno.postvalue eq "pono" and type eq "PR">
						'#pono#',
					<cfelseif getaccno.postvalue eq "pono" and type eq "CN">
						'#getartran.rem9#',
					<cfelseif getaccno.postvalue eq "desp">
						'#desp#',
					<cfelse>
						'#billtype#',
					</cfif>
				
					<cfif getaccno.postvalue eq "pono" and type eq "CN">
						'#pono#',
					<cfelse>
						'#getartran.despa#',
					</cfif>
                    <cfif lcase(hcomid) eq "mhsl_i" and type eq "RC">
                        '#numberformat(amttnbt+check_misc.summisc-get_multiple_payments.sum_payments,".__")#',
                        '-#numberformat(amttnbt2+check_misc.summisc_bil-get_multiple_payments.sum_payments_bil,".__")#',
					<cfelse>
                        '#numberformat(amtt+check_misc.summisc-get_multiple_payments.sum_payments,".__")#',
                        '-#numberformat(amtt2+check_misc.summisc_bil-get_multiple_payments.sum_payments_bil,".__")#',
					</cfif>
					'#currrate#',
					'',
					'#getartran.rem6#',
					#getartran.wos_date#,'#HUserID#'
				)
			</cfquery>
			
			<cfquery name="insertpost1" datasource="#dts#">
				insert into glpost91 
				(
					acc_code,
					accno,
					fperiod,
					date,
					reference,
					refno,
					desp,
					despa,
					creditamt,
					fcamt,
					exc_rate,
					rem4,
					rem5,
					bdate,
					userid
				)
				values 
				(
					'#type#',
					'#custno#',
					'#ceiling(fperiod)#',
					#getartran.wos_date#,
					'#billno#',
					'#refno2#',
					<cfif getaccno.postvalue eq "pono" and type eq "RC">
						'#pono#',
					<cfelseif getaccno.postvalue eq "pono" and type eq "PR">
						'#pono#',
					<cfelseif getaccno.postvalue eq "pono" and type eq "CN">
						'#getartran.rem9#',
					<cfelseif getaccno.postvalue eq "desp">
						'#desp#',
					<cfelse>
						'#billtype#',
					</cfif>
					<cfif getaccno.postvalue eq "pono" and type eq "CN">
						'#pono#',
					<cfelse>
						'#getartran.despa#',
					</cfif>
                    <cfif lcase(hcomid) eq "mhsl_i" and type eq "RC">
                        '#numberformat(amttnbt+check_misc.summisc-get_multiple_payments.sum_payments,".__")#',
                        '-#numberformat(amttnbt2+check_misc.summisc_bil-get_multiple_payments.sum_payments_bil,".__")#',
					<cfelse>
                        '#numberformat(amtt+check_misc.summisc-get_multiple_payments.sum_payments,".__")#',
                        '-#numberformat(amtt2+check_misc.summisc_bil-get_multiple_payments.sum_payments_bil,".__")#',
					</cfif>
					'#currrate#',
					'',
					'#getartran.rem6#',
					#getartran.wos_date#,'#HUserID#'
				)
			</cfquery>
		<cfelse>
			<cfquery name="insertpost1" datasource="#dts#">
				insert into glpost9 
				(
					acc_code,
					accno,
					fperiod,
					date,
					reference,
					refno,
					desp,
					despa,
					debitamt,
					fcamt,
					exc_rate,
					rem4,
					rem5,
					bdate,
					userid
				)
				values 
				(
					'#type#',
					<!--- <cfif type neq "CS">
						'#custno#',
					<cfelse>
						'#getaccno.cashaccount#',
					</cfif> --->
					<cfif type eq "CS" and lcase(Hcomid) neq "topsteel_i">
						'#getaccno.cashaccount#',
					<cfelse>
						'#custno#',
					</cfif>
					'#ceiling(fperiod)#',
					#getartran.wos_date#,
					'#billno#',
					'#refno2#',
					<cfif getaccno.postvalue eq "pono">
						'#getartran.rem9#',					
					<cfelseif getaccno.postvalue eq "desp">
						'#desp#',
					<cfelse>
						'#billtype#',
					</cfif>
					<cfif getaccno.postvalue eq "pono">
						'#pono#',
					<cfelse>
						'#getartran.despa#',
					</cfif>
					'#numberformat(amtt+check_misc.summisc-get_multiple_payments.sum_payments,".__")#',
					'#numberformat(amtt2+check_misc.summisc_bil-get_multiple_payments.sum_payments_bil,".__")#',
					'#currrate#',
					'',
					'#getartran.rem6#',
					#getartran.wos_date#,'#HUserID#'
				)
			</cfquery>
			
			<cfquery name="insertpost1" datasource="#dts#">
				insert into glpost91 
				(
					acc_code,
					accno,
					fperiod,
					date,
					reference,
					refno,
					desp,
					despa,
					debitamt,
					fcamt,
					exc_rate,
					rem4,
					rem5,
					bdate,
					userid
				)
				values 
				(
					'#type#',
					<!--- <cfif type neq "CS">
						'#custno#',
					<cfelse>
						'#getaccno.cashaccount#',
					</cfif> --->
					<cfif type eq "CS" and lcase(Hcomid) neq "topsteel_i">
						'#getaccno.cashaccount#',
					<cfelse>
						'#custno#',
					</cfif>
					'#ceiling(fperiod)#',
					#getartran.wos_date#,
					'#billno#',
					'#refno2#',
					<cfif getaccno.postvalue eq "pono">
						'#getartran.rem9#',					
					<cfelseif getaccno.postvalue eq "desp">
						'#desp#',
					<cfelse>
						'#billtype#',
					</cfif>					
					<cfif getaccno.postvalue eq "pono">
						'#pono#',
					<cfelse>
						'#getartran.despa#',
					</cfif>
					'#numberformat(amtt+check_misc.summisc-get_multiple_payments.sum_payments,".__")#',
					'#numberformat(amtt2+check_misc.summisc_bil-get_multiple_payments.sum_payments_bil,".__")#',
					'#currrate#',
					'',
					'#getartran.rem6#',
					#getartran.wos_date#,'#HUserID#'
				)
			</cfquery>		
		</cfif>
	</cfif>		
</cfloop>
</cfoutput>