<cfquery name="getartran" datasource="#dts#">
	select 
	(round(invgross+0.000001,5)-round(discount+0.000001,4)+round(tax+0.000001,4)+round((roundadj*currrate)+0.000001,4)) as amtt,
	(round(gross_bil+0.000001,5)-round(disc_bil+0.000001,4)+round(tax_bil+0.000001,4)+round(roundadj+0.000001,4)) as amtt2,
	(round(invgross+0.000001,5)-round(discount+0.000001,4)+round(tax+0.000001,4)+round((roundadj*currrate)+0.000001,4)) as incltax_amtt,
	(round(gross_bil+0.000001,5)-round(disc_bil+0.000001,4)+round(tax_bil+0.000001,4)+round(roundadj+0.000001,4)) as incltax_amtt2,
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
    currcode,
	invgross,
	discount,
	net,
	tax,
        grand,
	taxp1,
	gross_bil,
	disc_bil,
	net_bil,
	tax_bil,
	name,
    frem2,
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
    depositno,
	mc1_bil,
	mc2_bil,
	mc3_bil,
	mc4_bil,
	mc5_bil,
	mc6_bil,
	mc7_bil,
    source,
    job,
    roundadj as roundadj_bil,
	(roundadj*currrate) as roundadj,
	cs_pm_cash as cs_pm_cash_bil,
	(cs_pm_cash*currrate) as cs_pm_cash,
	cs_pm_cheq as cs_pm_cheq_bil,
	(cs_pm_cheq*currrate) as cs_pm_cheq,
	cs_pm_crcd as cs_pm_crcd_bil,
	(cs_pm_crcd*currrate) as cs_pm_crcd,
    cs_pm_dbcd as cs_pm_dbcd_bil,
	(cs_pm_dbcd*currrate) as cs_pm_dbcd,
	cs_pm_crc2 as cs_pm_crc2_bil,
	(cs_pm_crc2*currrate) as cs_pm_crc2,
	cs_pm_vouc as cs_pm_vouc_bil,
	(cs_pm_vouc*currrate) as cs_pm_vouc,
	deposit as deposit_bil,
	(deposit*currrate) as deposit,
	ifnull((cs_pm_cash+cs_pm_cheq+cs_pm_dbcd+cs_pm_crcd+cs_pm_crc2+cs_pm_vouc+deposit),0) as total_multiple_payments_bil,
	ifnull(((cs_pm_cash+cs_pm_cheq+cs_pm_dbcd+cs_pm_crcd+cs_pm_crc2+cs_pm_vouc+deposit)*currrate),0) as total_multiple_payments,
    agenno,
	taxincl,
    postingtaxexcl,
    checkno
    <cfif lcase(hcomid) eq "mhsl_i">,taxnbt,taxnbt_bil</cfif>
	from artran 
	where type='#gettran.type#' and refno='#gettran.refno#' and fperiod <> '99'
	group by refno
    <cfif lcase(hcomid) eq "leadbuilders_i">order by refno2</cfif>
</cfquery>
<cfif getartran.type eq "inv" or getartran.type eq "DN" or getartran.type eq "CS">
<cfquery name="getcustnonew" datasource="#dts#">
SELECT salec FROM #target_arcust# WHERE custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.custno#">
</cfquery>
<cfif getcustnonew.salec neq "" and getcustnonew.salec neq "0000/000">
<cfset getaccno.creditsales = getcustnonew.salec>
<cfset getaccno.cashsales = getcustnonew.salec>
<cfelse>
<cfquery name="getaccno" datasource="#dts#">
SELECT * FROM GSETUP
</cfquery>
</cfif>
</cfif>

<cfif getartran.type eq "CN">
<cfquery name="getcustnonew" datasource="#dts#">
SELECT salecnc FROM #target_arcust# WHERE custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.custno#">
</cfquery>
<cfif getcustnonew.salecnc neq "" and getcustnonew.salecnc neq "0000/000">
<cfset getaccno.salesreturn = getcustnonew.salecnc>
<cfelse>
<cfquery name="getaccno" datasource="#dts#">
SELECT * FROM GSETUP
</cfquery>
</cfif>
</cfif>

<cfif getartran.type eq "RC">
<cfquery name="getcustnonew" datasource="#dts#">
SELECT salec FROM #target_apvend# WHERE custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.custno#">
</cfquery>
<cfif getcustnonew.salec neq "" and getcustnonew.salec neq "0000/000">
<cfset getaccno.purchasereceive = getcustnonew.salec>
<cfelse>
<cfquery name="getaccno" datasource="#dts#">
SELECT * FROM GSETUP
</cfquery>
</cfif>
</cfif>

<cfif getartran.type eq "PR">
<cfquery name="getcustnonew" datasource="#dts#">
SELECT salecnc FROM #target_apvend# WHERE custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.custno#">
</cfquery>
<cfif getcustnonew.salecnc neq "" and getcustnonew.salecnc neq "0000/000">
<cfset getaccno.purchasereturn = getcustnonew.salecnc>
<cfelse>
<cfquery name="getaccno" datasource="#dts#">
SELECT * FROM GSETUP
</cfquery>
</cfif>
</cfif>

<cfif getartran.currcode eq getaccno.bcurr or getartran.currcode eq "">
<cfset getartran.amtt2 = 0>
<cfset getartran.incltax_amtt2 = 0>
<cfset getartran.cs_pm_cash_bil = 0>
<cfset getartran.cs_pm_cheq_bil = 0>
<cfset getartran.cs_pm_crcd_bil = 0>
<cfset getartran.cs_pm_dbcd_bil = 0>
<cfset getartran.cs_pm_crc2_bil = 0>
<cfset getartran.cs_pm_vouc_bil = 0>
<cfset getartran.deposit_bil = 0>
<cfset getartran.total_multiple_payments_bil = 0>
<cfset getartran.disc_bil = 0>
<cfset getartran.mc1_bil = 0>
<cfset getartran.mc2_bil = 0>
<cfset getartran.mc3_bil = 0>
<cfset getartran.mc4_bil = 0>
<cfset getartran.mc5_bil = 0>
<cfset getartran.mc6_bil = 0>
<cfset getartran.mc7_bil = 0>
<cfset getartran.tax_bil = 0>
<cfset getartran.tax1_bil = 0>
<cfset getartran.disc1_bil = 0>
</cfif>
<cfoutput>
<cfloop query="getartran">

	<cfset type = getartran.type>
	<cfset refno = getartran.refno>
	
	<cfif lcase(HcomID) eq "probulk_i">
		<cfquery name="getictran" datasource="#dts#">
			select 
			ifnull(brem1,0) as brem1,source,job 
			from ictran 
			where type='#getartran.type#' 
			and refno='#getartran.refno#' 
			<cfif lcase(Hcomid) eq "chemline_i">
				and ((linecode ='SV' and amt <> 0) or linecode='')
			</cfif>
		</cfquery>
		<cfloop query="getictran">
        <!---
			<tr>
				<td>#getartran.type#</td>
				<td>#getartran.refno#</td>
                <cfif lcase(hcomid) eq "leadbuilders_i"><td>#getartran.refno2#</td></cfif>
				<td>#dateformat(getartran.wos_date,"dd/mm/yyyy")#</td>--->
				
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
				<cfif dts eq "hodaka_i"  or dts eq "hodakamy_i">
                <Cfset check_misc.summisc = 0>
                <Cfset check_misc.summisc_bil = 0>
                <Cfset check_misc.sum_without_misc = 0>
                <Cfset check_misc.sum_without_misc_bil = 0>
                <Cfset check_misc.misccount = 0>
				</cfif>
				<cfquery name="get_multiple_payments" datasource="#dts#">
					select 
					(
						if((a.cashaccount='' or a.cashaccount='0000/000'),b.cs_pm_cash,0)+
						if((a.chequeaccount='' or a.chequeaccount='0000/000'),b.cs_pm_cheq,0)+
                        if((a.debitcardaccount=''	or a.debitcardaccount='0000/000'),b.cs_pm_dbcd,0)+
						if((a.creditcardaccount1=''	or a.creditcardaccount1='0000/000'),b.cs_pm_crcd,0)+
						if((a.creditcardaccount2='' or a.creditcardaccount2='0000/000'),b.cs_pm_crc2,0)+
						if((a.cashvoucheraccount='' or a.cashvoucheraccount='0000/000'),b.cs_pm_vouc,0)+
						if((a.depositaccount='' or a.depositaccount='0000/000'),b.deposit,0)
					) as sum_without_payments_bil,
					(
						(
							if((a.cashaccount='' or a.cashaccount='0000/000'),b.cs_pm_cash,0)+
							if((a.chequeaccount='' or a.chequeaccount='0000/000'),b.cs_pm_cheq,0)+
                            if((a.debitcardaccount=''	or a.debitcardaccount='0000/000'),b.cs_pm_dbcd,0)+
							if((a.creditcardaccount1=''	or a.creditcardaccount1='0000/000'),b.cs_pm_crcd,0)+
							if((a.creditcardaccount2='' or a.creditcardaccount2='0000/000'),b.cs_pm_crc2,0)+
							if((a.cashvoucheraccount='' or a.cashvoucheraccount='0000/000'),b.cs_pm_vouc,0)+
							if((a.depositaccount='' or a.depositaccount='0000/000'),b.deposit,0)
						)*b.currrate
					) as sum_without_payments,
					(
						if((a.cashaccount<>'' and a.cashaccount<>'0000/000'),b.cs_pm_cash,0)+
						if((a.chequeaccount<>'' and a.chequeaccount<>'0000/000'),b.cs_pm_cheq,0)+
                        if((a.debitcardaccount<>''	and a.debitcardaccount<>'0000/000'),b.cs_pm_dbcd,0)+
						if((a.creditcardaccount1<>'' and a.creditcardaccount1<>'0000/000'),b.cs_pm_crcd,0)+
						if((a.creditcardaccount2<>'' and a.creditcardaccount2<>'0000/000'),b.cs_pm_crc2,0)+
						if((a.cashvoucheraccount<>'' and a.cashvoucheraccount<>'0000/000'),b.cs_pm_vouc,0)+
						if((a.depositaccount<>'' and a.depositaccount<>'0000/000'),b.deposit,0)
						<!---+round((roundadj)+0.000001,4)---><!---weelung--->
                    ) as sum_payments_bil,
					(	
						(
							if((a.cashaccount<>'' and a.cashaccount<>'0000/000'),b.cs_pm_cash,0)+
							if((a.chequeaccount<>'' and a.chequeaccount<>'0000/000'),b.cs_pm_cheq,0)+
                            if((a.debitcardaccount<>''	and a.debitcardaccount<>'0000/000'),b.cs_pm_dbcd,0)+
							if((a.creditcardaccount1<>'' and a.creditcardaccount1<>'0000/000'),b.cs_pm_crcd,0)+
							if((a.creditcardaccount2<>'' and a.creditcardaccount2<>'0000/000'),b.cs_pm_crc2,0)+
							if((a.cashvoucheraccount<>'' and a.cashvoucheraccount<>'0000/000'),b.cs_pm_vouc,0)+
							if((a.depositaccount<>'' and a.depositaccount<>'0000/000'),b.deposit,0)
							<!---+round((roundadj)+0.000001,4)---><!---weelung--->
                        )*b.currrate
					) as sum_payments
					
					from gsetup as a,artran as b 
					where b.type='#type#' 
					and b.refno='#refno#';
				</cfquery>
				
				<cfif getaccno.PPWKOF eq "Y">
                <cfset get_multiple_payments.sum_without_payments_bil = 0>
                <cfset get_multiple_payments.sum_without_payments = 0>
                <cfset get_multiple_payments.sum_payments_bil = 0>
                <cfset get_multiple_payments.sum_payments = 0>
				</cfif>
                <!---
				<td>--->
					<cfif acctype eq "D">
						<cfif getartran.taxincl eq "T"<!---  and val(getaccno.gst) neq 0 --->>
							<cfset getartran.amtt=getartran.incltax_amtt>
						</cfif>
						<cfset thisamt=val(getictran.brem1)/100*(getartran.amtt+check_misc.summisc-get_multiple_payments.sum_payments)>
		            	<!---<div align="right">#numberformat(thisamt,".__")#</div>
                        <cfset totdebit = totdebit + numberformat(thisamt,".__")>--->
					</cfif>
		        <!---</td>
				<td>--->
					<cfif acctype eq "Cr">
		            	<cfif lcase(hcomid) eq "mhsl_i" and getartran.type eq "RC">
			            	<cfset thisamt=val(getictran.brem1)/100*(getartran.amttnbt+check_misc.summisc-get_multiple_payments.sum_payments)>
		            		<!---<div align="right">#numberformat(thisamt,".__")#</div>--->
						<cfelse>
							<cfset thisamt=val(getictran.brem1)/100*(getartran.amtt+check_misc.summisc-get_multiple_payments.sum_payments)>
		            		<!---<div align="right">#numberformat(thisamt,".__")#</div>--->
						</cfif>
                        <!---<cfset totcredit = totcredit + numberformat(thisamt,".__")>--->
					</cfif>
		        <!---</td>
				<td>&nbsp;</td>
				<td>#ceiling(getartran.fperiod)#</td>
                <cfif getartran.type eq "CS" and getaccno.postcsdebtor neq "Y">
                <td>#getaccno.cashaccount#</td>
                <cfelse>
				<td>#getartran.custno#</td>
                </cfif>
				<td>#acctype#</td>
				<td nowrap>#getartran.name#</td>
                <td nowrap>#getartran.agenno#</td>
				<td nowrap>#getictran.source#</td>
				<td nowrap>#getictran.job#</td>
			</tr>--->
			

				<cfset billno = code&refno>
				
				<cfif type eq "RC" or type eq "CN"<!---  or type eq "PR" --->>
                
                <cfif lcase(hcomid) eq "mhsl_i" and type eq "RC">
					<cfset tt1=val(getictran.brem1)/100*(getartran.amttnbt+check_misc.summisc-get_multiple_payments.sum_payments)>
                    <cfset tt2=val(getictran.brem1)/100*(getartran.amttnbt2+check_misc.summisc_bil-get_multiple_payments.sum_payments_bil)>
                <cfelse>
                	
                    <cfset tt1=val(getictran.brem1)/100*(getartran.amtt+check_misc.summisc-get_multiple_payments.sum_payments)>
                    <cfset tt2=val(getictran.brem1)/100*(getartran.amtt2+check_misc.summisc_bil-get_multiple_payments.sum_payments_bil)>
                </cfif>
                
					<cfquery name="insertpost1" datasource="#dts#">
						insert into glposttemp
						(
							acc_code,
							accno,
							fperiod,
							date,
							reference,
							refno,
							desp,
							despa,
                            <cfif tt1 lt 0>
                            <!--- negative--->
                            debitamt,
                            <cfelse>
							creditamt,
                            </cfif>
							fcamt,
							exc_rate,
							rem4,
							rem5,
							bdate,
							userid,
							source,job,agent,uuid
						)
						values 
						(
							'#getartran.type#',
							'#getartran.custno#',
							'#ceiling(getartran.fperiod)#',
							#getartran.wos_date#,
							'#billno#',
							'#getartran.refno2#',
							<cfif getaccno.postvalue eq "pono" and type eq "RC">
								'#pono#',
							<cfelseif getaccno.postvalue eq "pono" and type eq "PR">
								'#pono#',
							<cfelseif getaccno.postvalue eq "pono" and type eq "CN">
								'#getartran.rem9#',
							<cfelseif getaccno.postvalue eq "desp">
								'#getartran.desp#',
							<cfelse>
								'#billtype#',
							</cfif>
						
							<cfif getaccno.postvalue eq "pono" and type eq "CN">
								'#pono#',
							<cfelse>
								'#getartran.despa#',
							</cfif>
		                    <cfif lcase(hcomid) eq "mhsl_i" and type eq "RC">
			                    '#numberformat(abs(tt1),".__")#',
		                        '-#numberformat(tt2,".__")#',
							<cfelse>
								'#numberformat(abs(tt1),".__")#',
		                        '-#numberformat(tt2,".__")#',
							</cfif>
							'#getartran.currrate#',
							'',
							'#getartran.rem6#',
							#getartran.wos_date#,'#HUserID#','#getictran.source#','#getictran.job#','#getartran.agenno#','#uuid#'
						)
					</cfquery>
					
					
				<cfelse>
                	<cfif getartran.postingtaxexcl eq "T">
                    <cfset tt1=val(getictran.brem1)/100*((getartran.amtt-getartran.tax)+check_misc.summisc-get_multiple_payments.sum_payments)>
			        <cfset tt2=val(getictran.brem1)/100*((getartran.amtt2-getartran.tax_bil)+check_misc.summisc_bil-get_multiple_payments.sum_payments_bil)>
                    <cfelse>
                	<cfset tt1=val(getictran.brem1)/100*(getartran.amtt+check_misc.summisc-get_multiple_payments.sum_payments)>
			        <cfset tt2=val(getictran.brem1)/100*(getartran.amtt2+check_misc.summisc_bil-get_multiple_payments.sum_payments_bil)>
					</cfif>		
					<cfquery name="insertpost1" datasource="#dts#">
						insert into glposttemp
						(
							acc_code,
							accno,
							fperiod,
							date,
							reference,
							refno,
							desp,
							despa,
                            <cfif tt1 lt 0>
                            creditamt,
                            <cfelse>
							debitamt,
                            </cfif>
							fcamt,
							exc_rate,
							rem4,
							rem5,
							bdate,
							userid,
							source,job,agent,uuid
						)
						values 
						(
							'#getartran.type#',
							<!--- <cfif type neq "CS">
								'#custno#',
							<cfelse>
								'#getaccno.cashaccount#',
							</cfif> --->
							<cfif type eq "CS" and getaccno.postcsdebtor neq "Y">
								'#getaccno.cashaccount#',
							<cfelse>
								'#getartran.custno#',
							</cfif>
							'#ceiling(getartran.fperiod)#',
							#getartran.wos_date#,
							'#billno#',
							'#getartran.refno2#',
							<cfif getaccno.postvalue eq "pono">
								'#getartran.rem9#',					
							<cfelseif getaccno.postvalue eq "desp">
								'#getartran.desp#',
							<cfelse>
								'#billtype#',
							</cfif>
							<cfif getaccno.postvalue eq "pono">
								'#pono#',
							<cfelse>
								'#getartran.despa#',
							</cfif>
							'#numberformat(abs(tt1),".__")#',
							'#numberformat(abs(tt2),".__")#',
							'#getartran.currrate#',
							'',
							'#getartran.rem6#',
							#getartran.wos_date#,'#HUserID#','#getictran.source#','#getictran.job#','#getartran.agenno#','#uuid#'
						)
					</cfquery>
					
				</cfif>
		</cfloop>
	<cfelse>
		<!---<tr>
			<td>#getartran.type#</td>
			<td>#getartran.refno#</td>
            <cfif lcase(hcomid) eq "leadbuilders_i"><td>#getartran.refno2#</td></cfif>
			<td>#dateformat(getartran.wos_date,"dd/mm/yyyy")#</td>--->
			
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
            <cfif dts eq "hodaka_i" or dts eq "hodakamy_i">
                <Cfset check_misc.summisc = 0>
                <Cfset check_misc.summisc_bil = 0>
                <Cfset check_misc.sum_without_misc = 0>
                <Cfset check_misc.sum_without_misc_bil = 0>
                <Cfset check_misc.misccount = 0>
				</cfif>
			
			<cfquery name="get_multiple_payments" datasource="#dts#">
				select 
				(
					if((a.cashaccount='' or a.cashaccount='0000/000'),b.cs_pm_cash,0)+
					if((a.chequeaccount='' or a.chequeaccount='0000/000'),b.cs_pm_cheq,0)+
                    if((a.debitcardaccount=''	or a.debitcardaccount='0000/000'),b.cs_pm_dbcd,0)+
					if((a.creditcardaccount1=''	or a.creditcardaccount1='0000/000'),b.cs_pm_crcd,0)+
					if((a.creditcardaccount2='' or a.creditcardaccount2='0000/000'),b.cs_pm_crc2,0)+
					if((a.cashvoucheraccount='' or a.cashvoucheraccount='0000/000'),b.cs_pm_vouc,0)+
					if((a.depositaccount='' or a.depositaccount='0000/000'),b.deposit,0)
				) as sum_without_payments_bil,
				(
					(
						if((a.cashaccount='' or a.cashaccount='0000/000'),b.cs_pm_cash,0)+
						if((a.chequeaccount='' or a.chequeaccount='0000/000'),b.cs_pm_cheq,0)+
                        if((a.debitcardaccount=''	or a.debitcardaccount='0000/000'),b.cs_pm_dbcd,0)+
						if((a.creditcardaccount1=''	or a.creditcardaccount1='0000/000'),b.cs_pm_crcd,0)+
						if((a.creditcardaccount2='' or a.creditcardaccount2='0000/000'),b.cs_pm_crc2,0)+
						if((a.cashvoucheraccount='' or a.cashvoucheraccount='0000/000'),b.cs_pm_vouc,0)+
						if((a.depositaccount='' or a.depositaccount='0000/000'),b.deposit,0)
					)*b.currrate
				) as sum_without_payments,
				(
					if((a.cashaccount<>'' and a.cashaccount<>'0000/000'),b.cs_pm_cash,0)+
					if((a.chequeaccount<>'' and a.chequeaccount<>'0000/000'),b.cs_pm_cheq,0)+
                    if((a.debitcardaccount<>''	and a.debitcardaccount<>'0000/000'),b.cs_pm_dbcd,0)+
					if((a.creditcardaccount1<>'' and a.creditcardaccount1<>'0000/000'),b.cs_pm_crcd,0)+
					if((a.creditcardaccount2<>'' and a.creditcardaccount2<>'0000/000'),b.cs_pm_crc2,0)+
					if((a.cashvoucheraccount<>'' and a.cashvoucheraccount<>'0000/000'),b.cs_pm_vouc,0)+
					if((a.depositaccount<>'' and a.depositaccount<>'0000/000'),b.deposit,0)
					<!---+round((roundadj)+0.000001,4)---><!---weelung--->
                ) as sum_payments_bil,
				(	
					(
						if((a.cashaccount<>'' and a.cashaccount<>'0000/000'),b.cs_pm_cash,0)+
						if((a.chequeaccount<>'' and a.chequeaccount<>'0000/000'),b.cs_pm_cheq,0)+
                        if((a.debitcardaccount<>''	and a.debitcardaccount<>'0000/000'),b.cs_pm_dbcd,0)+
						if((a.creditcardaccount1<>'' and a.creditcardaccount1<>'0000/000'),b.cs_pm_crcd,0)+
						if((a.creditcardaccount2<>'' and a.creditcardaccount2<>'0000/000'),b.cs_pm_crc2,0)+
						if((a.cashvoucheraccount<>'' and a.cashvoucheraccount<>'0000/000'),b.cs_pm_vouc,0)+
						if((a.depositaccount<>'' and a.depositaccount<>'0000/000'),b.deposit,0)
						<!---+round((roundadj)+0.000001,4)---><!---weelung--->
                    )*b.currrate
				) as sum_payments
				
				from gsetup as a,artran as b 
				where b.type='#type#' 
				and b.refno='#refno#';
			</cfquery>
            
            <cfif getaccno.PPWKOF eq "Y">
                <cfset get_multiple_payments.sum_without_payments_bil = 0>
                <cfset get_multiple_payments.sum_without_payments = 0>
                <cfset get_multiple_payments.sum_payments_bil = 0>
                <cfset get_multiple_payments.sum_payments = 0>
				</cfif>
            
            <cfif numberformat(getartran.amtt+check_misc.summisc-get_multiple_payments.sum_payments,".__") lt 0>
            <cfif acctype eq "D">
            <cfset acctype = "Cr">
            <cfelse>
            <cfset acctype = "D">
            </cfif>
            </cfif>
			<!---
			<td>--->
				<cfif acctype eq "D">
					<cfif getartran.taxincl eq "T"<!---  and val(getaccno.gst) neq 0 --->>
						<cfset getartran.amtt=getartran.incltax_amtt>
					</cfif>
	            	<!---<div align="right">#numberformat(abs(getartran.amtt+check_misc.summisc-get_multiple_payments.sum_payments),".__")#</div>
                    <cfset totdebit = totdebit + numberformat(abs(getartran.amtt+check_misc.summisc-get_multiple_payments.sum_payments),".__")>--->
				</cfif>
	        <!---</td>
			<td>--->
				<cfif acctype eq "Cr">
	            	<cfif lcase(hcomid) eq "mhsl_i" and getartran.type eq "RC">
	            		<!---<div align="right">#numberformat(getartran.amttnbt+check_misc.summisc-get_multiple_payments.sum_payments,".__")#</div>
						<cfset totcredit = totcredit + numberformat(getartran.amttnbt+check_misc.summisc-get_multiple_payments.sum_payments,".__")>--->
					<cfelse>
	            		<!---<div align="right">#numberformat(abs(getartran.amtt+check_misc.summisc-get_multiple_payments.sum_payments),".__")#</div>
                        <cfset totcredit = totcredit + numberformat(abs(getartran.amtt+check_misc.summisc-get_multiple_payments.sum_payments),".__")>--->
					</cfif>
                    
				</cfif>
	        <!---</td>
			<td>&nbsp;</td>
			<td>#ceiling(getartran.fperiod)#</td>
			<cfif getartran.type eq "CS" and getaccno.postcsdebtor neq "Y">
                <td>#getaccno.cashaccount#</td>
                <cfelse>
				<td>#getartran.custno#</td>
                </cfif>
			<td>#acctype#</td>
			<td nowrap>#getartran.name#</td>
            <td nowrap>#getartran.agenno#</td>
             <cfif lcase(hcomid) eq "taftc_i">
			<td>#getartran.source#</td>
            <td>#getartran.job#</td>
			</cfif>
		</tr>--->
        
        <cfif lcase(hcomid) eq "taftc_i" and (type eq "INV" or type eq "CN")>
        <cfquery name="getcourse" datasource="#dts#">
        SELECT cdispec,grantacc,urevenueacc FROM #target_project# WHERE source = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.source#">
        </cfquery>
        <cfquery name="getjob" datasource="#dts#">
        SELECT postingtimes FROM #target_project# WHERE source = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.job#"> and porj = "j"
        </cfquery>
        <cfquery name="checknoofstudent" datasource="#dts#">
        SELECT brem1 FROM ictran where 
        type='#type#' 
		and refno='#refno#'
        and (brem1 = "" or brem1 is null)
        and (linecode = "" or linecode is null)
        </cfquery>
        <cfif val(getcourse.cdispec) neq 0 and getcourse.grantacc neq "" and checknoofstudent.recordcount neq 0>
        <cfset getcourse.cdispec = getcourse.cdispec * checknoofstudent.recordcount>
        <!---<tr>
			<td>#getartran.type#</td>
			<td>#getartran.refno#</td>
            <cfif lcase(hcomid) eq "leadbuilders_i"><td>#getartran.refno2#</td></cfif>
			<td>#dateformat(getartran.wos_date,"dd/mm/yyyy")#</td>
            <td>
				<cfif acctype eq "D">

	            	<div align="right">#numberformat(val(getcourse.cdispec),".__")#</div>
                    <cfset totdebit = totdebit + numberformat(val(getcourse.cdispec),".__")>
				</cfif>
	        </td>
			<td>
				<cfif acctype eq "Cr">
	            		<div align="right">#numberformat(val(getcourse.cdispec),".__")#</div>
                        <cfset totcredit = totcredit + numberformat(val(getcourse.cdispec),".__")>                    
				</cfif>
	        </td>
			<td>&nbsp;</td>
			<td>#ceiling(getartran.fperiod)#</td>
<td>#getcourse.grantacc#</td>
			<td>#acctype#</td>
			<td nowrap>#getartran.name#</td>
            <td nowrap>#getartran.agenno#</td>
            <cfif lcase(hcomid) eq "taftc_i">
			<td>#getartran.source#</td>
            <td>#getartran.job#</td>
			</cfif>
		</tr>--->
        </cfif>
		</cfif>
		
			<cfset billno = code&refno>
			
            <cfif getartran.postingtaxexcl eq "T">
            <cfset getartran.amtt=getartran.amtt-getartran.tax>
            <cfset getartran.amtt2=getartran.amtt2-getartran.tax_bil>
            </cfif>
            
            <!---Indonesia PPH--->
            <cfif getaccno.bcurr eq "IDR">
            
            <cfquery name="getindopph" datasource="#dts#">
            	SELECT ifnull(sum(pph_amt),0) as pph_amt,ifnull(sum(pph_amt_bil),0) as pph_amt_bil FROM ictran where refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.refno#"> and type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.type#">
            </cfquery>
            
            <cfif getartran.type eq "RC">
                <cfset xindoaccno = getaccno.gstpurchase>				
            <cfelse>
                <cfset xindoaccno = getaccno.gstsales>
            </cfif>
            
            <cfif getindopph.pph_amt neq 0>
            <cfset getartran.amtt=getartran.amtt-getindopph.pph_amt>
            <cfset getartran.amtt2=getartran.amtt2-getartran.pph_amt_bil>
            
            <cfif type eq "RC" or type eq "CN">
				<cfquery name="insertpost1" datasource="#dts#">
					insert into glposttemp
					(
						acc_code,
						accno,
						fperiod,
						date,
						reference,
						refno,
						desp,
						despa,
                        <cfif numberformat(getindopph.pph_amt,".__") lt 0>
                        debitamt,
                        <cfelse>
						creditamt,
                        </cfif>
						fcamt,
						exc_rate,
						rem4,
						rem5,
						bdate,
						userid,
                        agent
						,SOURCE,JOB
                        ,uuid
					)
					values 
					(
						'#type#',
						'#xindoaccno#',
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

	                    '#numberformat(abs(getindopph.pph_amt),".__")#',
                        '#numberformat(abs(getindopph.pph_amt_bil),".__") * -1#',                 
						'#currrate#',
						'',
						'#getartran.rem6#',
						#getartran.wos_date#,'#HUserID#','#getartran.agenno#'

						,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.source#">
                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.job#">
                        ,'#uuid#'
					)
				</cfquery>
				
				
			<cfelse>
				<cfquery name="insertpost1" datasource="#dts#">
					insert into glposttemp
					(
						acc_code,
						accno,
						fperiod,
						date,
						reference,
						refno,
						desp,
						despa,
                        <cfif numberformat(getindopph.pph_amt,".__") lt 0>
                        creditamt,
                        <cfelse>
						debitamt,
                        </cfif>
						fcamt,
						exc_rate,
						rem4,
						rem5,
						bdate,
						userid,
                        agent
						,SOURCE,JOB

                        ,uuid
					)
					values 
					(
						'#type#',
						'#xindoaccno#',
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
						'#numberformat(abs(getindopph.pph_amt),".__")#',
                        '#numberformat(-(abs(getindopph.pph_amt_bil)),".__")#',
						'#currrate#',
						'',
						'#getartran.rem6#',
						#getartran.wos_date#,'#HUserID#','#getartran.agenno#'

						,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.source#">
                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.job#">

                        ,'#uuid#'
					)
				</cfquery>
				</cfif>
				
			</cfif>
            
            
            
            </cfif>
            <!---End Indonesia PPH--->
            
			<cfif type eq "RC" or type eq "CN"<!---  or type eq "PR" --->>
				<cfquery name="insertpost1" datasource="#dts#">
					insert into glposttemp
					(
						acc_code,
						accno,
						fperiod,
						date,
						reference,
						refno,
						desp,
						despa,
                        <cfif numberformat(amtt+check_misc.summisc-get_multiple_payments.sum_payments,".__") lt 0>
                        debitamt,
                        <cfelse>
						creditamt,
                        </cfif>
						fcamt,
						exc_rate,
						rem4,
						rem5,
						bdate,
						userid,
                        agent
 
						,SOURCE,JOB

                        ,uuid
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
	                        '#numberformat(abs(amtt+check_misc.summisc-get_multiple_payments.sum_payments),".__")#',
                             <cfif numberformat(amtt+check_misc.summisc-get_multiple_payments.sum_payments,".__") lt 0>
							<cfif getartran.currcode eq getaccno.bcurr or getartran.currcode eq "">
                            '#numberformat(abs(amtt2+check_misc.summisc_bil),".__")#',
                            <cfelse>
                            '#numberformat(abs(amtt2+check_misc.summisc_bil-get_multiple_payments.sum_payments_bil),".__")#',
                            </cfif>                         <!---'#numberformat(abs(amtt2+check_misc.summisc_bil-get_multiple_payments.sum_payments_bil),".__")#',--->
                             <cfelse>
							<cfif getartran.currcode eq getaccno.bcurr or getartran.currcode eq "">
                            '#numberformat(amtt2+check_misc.summisc_bil,".__") * -1#',
                            <cfelse>
                            '#numberformat(amtt2+check_misc.summisc_bil-get_multiple_payments.sum_payments_bil,".__") * -1#',
                            </cfif>                    
                            </cfif>
						</cfif>
						'#currrate#',
						'',
						'#getartran.rem6#',
						#getartran.wos_date#,'#HUserID#','#getartran.agenno#'

						,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.source#">
                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.job#">
                        ,'#uuid#'
					)
				</cfquery>
				
				
			<cfelse>

				<cfquery name="insertpost1" datasource="#dts#">
					insert into glposttemp
					(
						acc_code,
						accno,
						fperiod,
						date,
						reference,
						refno,
						desp,
						despa,
                        <cfif numberformat(amtt+check_misc.summisc-get_multiple_payments.sum_payments,".__") lt 0>
                        creditamt,
                        <cfelse>
						debitamt,
                        </cfif>
						fcamt,
						exc_rate,
						rem4,
						rem5,
						bdate,
						userid,
                        agent
						,SOURCE,JOB

                        ,uuid
					)
					values 
					(
						'#type#',
						<!--- <cfif type neq "CS">
							'#custno#',
						<cfelse>
							'#getaccno.cashaccount#',
						</cfif> --->
						<cfif type eq "CS" and getaccno.postcsdebtor neq "Y">
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
						'#numberformat(abs(amtt+check_misc.summisc-get_multiple_payments.sum_payments),".__")#',
                        <cfif numberformat(amtt+check_misc.summisc-get_multiple_payments.sum_payments,".__") lt 0>
<cfif getartran.currcode eq getaccno.bcurr or getartran.currcode eq "">
'#numberformat(-(abs(amtt2+check_misc.summisc_bil)),".__")#',
<cfelse>                        '#numberformat(-(abs(amtt2+check_misc.summisc_bil-get_multiple_payments.sum_payments_bil)),".__")#',
</cfif>
                        <cfelse>
                        <cfif getartran.currcode eq getaccno.bcurr or getartran.currcode eq "">
						'#numberformat(amtt2+check_misc.summisc_bil,".__")#',
                        <cfelse>
                        '#numberformat(amtt2+check_misc.summisc_bil-get_multiple_payments.sum_payments_bil,".__")#',
                        </cfif>
                        </cfif>
						'#currrate#',
						'',
						'#getartran.rem6#',
						#getartran.wos_date#,'#HUserID#','#getartran.agenno#'

						,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.source#">
                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.job#">

                        ,'#uuid#'
					)
				</cfquery>
				
				
			</cfif>
            <cfif lcase(hcomid) eq "taftc_i" and (type eq "INV" or type eq "CN")>
            <cfif val(getcourse.cdispec) neq 0 and getcourse.grantacc neq "" and checknoofstudent.recordcount neq 0>
            <cfinclude template="taftcpost.cfm">
			</cfif>
			</cfif>
	</cfif>
	
</cfloop>
</cfoutput>