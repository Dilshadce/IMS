<cfquery name="getdetails" datasource="#dts#">
	select 
	* 
	from ictran 
	where type='#gettran.type#' 
	and refno='#gettran.refno#' 
	<cfif lcase(Hcomid) eq "chemline_i">
		and ((linecode ='SV' and amt <> 0) or linecode='')
	</cfif>
</cfquery>

<cfloop query="getdetails">
	<cfif getdetails.linecode eq "SV">
		<cfquery name="getservi" datasource="#dts#">
			select 
			#getacc# as result 
			from icservi 
			where servi='#getdetails.itemno#';
		</cfquery>
		
		<cfif getservi.recordcount eq 0>
			<cfif lcase(Hcomid) eq "chemline_i">
				<cfset getservi.result ="0000/000">
				<cfif getdetails.gltradac neq "" and getdetails.gltradac neq "0000/000">
					<cfset accno = getdetails.gltradac>
				<cfelse>
					<cfif getdetails.type eq "INV">
						<cfset accno = getaccno.creditsales>
					<cfelseif getdetails.type eq "DN">
						<cfset accno = getaccno.creditsales>
					<cfelseif getdetails.type eq "CN">
						<cfset accno = getaccno.salesreturn>
					<cfelseif getdetails.type eq "PR">
						<cfset accno = getaccno.purchasereturn>
					<cfelseif getdetails.type eq "RC">
						<cfset accno = getaccno.purchasereceive>
					<cfelseif getdetails.type eq "CS">
						<cfset accno = getaccno.cashsales>
					</cfif>
					
					<cfif accno eq "">
						<cfset accno = "0000/000">		
					</cfif>
				</cfif>	
			<cfelse>
				<h3>Error. This Service is not existing in the Service Profile. Please key in now in order to continue.</h3>
				<cfabort>
			</cfif>					
		<cfelse>
			<cfif getservi.result neq "" and getservi.result neq "0000/000">
				<cfset accno = getservi.result>
			<cfelse>
				<cfif getdetails.gltradac neq "" and getdetails.gltradac neq "0000/000">
					<cfset accno = getdetails.gltradac>
				<cfelse>
					<cfif getdetails.type eq "INV">
						<cfset accno = getaccno.creditsales>
					<cfelseif getdetails.type eq "DN">
						<cfset accno = getaccno.creditsales>
					<cfelseif getdetails.type eq "CN">
						<cfset accno = getaccno.salesreturn>
					<cfelseif getdetails.type eq "PR">
						<cfset accno = getaccno.purchasereturn>
					<cfelseif getdetails.type eq "RC">
						<cfset accno = getaccno.purchasereceive>
					<cfelseif getdetails.type eq "CS">
						<cfset accno = getaccno.cashsales>
					</cfif>
					
					<cfif accno eq "">
						<cfset accno = "0000/000">		
					</cfif>
				</cfif>					
			</cfif>
		</cfif>
	<cfelse> <!--- for item --->
		<!--- <cfquery name="getitem" datasource="#dts#">
			select 
			wos_group,
			<cfif getdetails.type eq "PR">
				purprec 
			<cfelse>
				#getacc# 
			</cfif>as result 
			from icitem 
			where itemno='#getdetails.itemno#';
		</cfquery>
		
		<cfif getitem.wos_group neq "">
			<cfquery name="getgroup" datasource="#dts#">
				select 
				#getacc# as result 
				from icgroup 
				where wos_group='#getitem.wos_group#';
			</cfquery>
			
			<cfif getgroup.result neq "" and getgroup.result neq "0000/000">
				<cfset accno = getgroup.result>
			<cfelse>						
				<cfif getitem.result neq "" and getitem.result neq "0000/000">
					<cfset accno = getitem.result>
				<cfelse>
					<cfif getdetails.gltradac neq "" and getdetails.gltradac neq "0000/000">
						<cfset accno = getdetails.gltradac>
					<cfelse>
						<cfif getdetails.type eq "INV">
							<cfset accno = getaccno.creditsales>
						<cfelseif getdetails.type eq "DN">
							<cfset accno = getaccno.creditsales>
						<cfelseif getdetails.type eq "CN">
							<cfset accno = getaccno.salesreturn>
						<cfelseif getdetails.type eq "PR">
							<cfset accno = getaccno.purchasereturn>
						<cfelseif getdetails.type eq "RC">
							<cfset accno = getaccno.purchasereceive>
						<cfelseif getdetails.type eq "CS">
							<cfset accno = getaccno.cashsales>
						</cfif>
						
						<cfif accno eq "">
							<cfset accno = "0000/000">
						</cfif>
					</cfif>
				</cfif>			
			</cfif>
		<cfelse>
			<cfif getitem.result neq "" and getitem.result neq "0000/000">
				<cfset accno = getitem.result>
			<cfelse>
				<cfif getdetails.gltradac neq "" and getdetails.gltradac neq "0000/000">
					<cfset accno = getdetails.gltradac>
				<cfelse>
					<cfif getdetails.type eq "INV">
						<cfset accno = getaccno.creditsales>
					<cfelseif getdetails.type eq "DN">
						<cfset accno = getaccno.creditsales>
					<cfelseif getdetails.type eq "CN">
						<cfset accno = getaccno.salesreturn>
					<cfelseif getdetails.type eq "PR">
						<cfset accno = getaccno.purchasereturn>
					<cfelseif getdetails.type eq "RC">
						<cfset accno = getaccno.purchasereceive>
					<cfelseif getdetails.type eq "CS">
						<cfset accno = getaccno.cashsales>
					</cfif>
					
					<cfif accno eq "">
						<cfset accno = "0000/000">								
					</cfif>
				</cfif>
			</cfif>
		</cfif> --->
		<cfif getdetails.type eq "INV">
			<cfset accno = getaccno.creditsales>
		<cfelseif getdetails.type eq "DN">
			<cfset accno = getaccno.creditsales>
		<cfelseif getdetails.type eq "CN">
			<cfset accno = getaccno.salesreturn>
		<cfelseif getdetails.type eq "PR">
			<cfset accno = getaccno.purchasereturn>
		<cfelseif getdetails.type eq "RC">
			<cfset accno = getaccno.purchasereceive>
		<cfelseif getdetails.type eq "CS">
			<cfset accno = getaccno.cashsales>
		</cfif>
		
		<cfquery name="getitem" datasource="#dts#">
			select 
			wos_group,
			<cfif getdetails.type eq "PR">
				purprec 
			<cfelse>
				#getacc# 
			</cfif>as result 
			from icitem 
			where itemno='#getdetails.itemno#'
		</cfquery>
		
		<cfif getitem.result neq "" and getitem.result neq "0000/000">
			<cfset accno = getitem.result>
		</cfif>
		
		<cfif getitem.wos_group neq "">
			<cfquery name="getgroup" datasource="#dts#">
				select 
				#getacc# as result 
				from icgroup 
				where wos_group='#getitem.wos_group#';
			</cfquery>
			
			<cfif getgroup.result neq "" and getgroup.result neq "0000/000">
				<cfset accno = getgroup.result>
			</cfif>
		</cfif>
		
		<cfif gettran.special_account_code neq "" and gettran.special_account_code neq "0000/000">
			<cfset accno = gettran.special_account_code>
		</cfif>
		
		<cfif getdetails.gltradac neq "" and getdetails.gltradac neq "0000/000">
			<cfset accno = getdetails.gltradac>
		</cfif>
		
		<cfif accno eq "">
			<cfset accno = "0000/000">								
		</cfif>
	</cfif>			
	
	<cfquery name="inserttemp" datasource="#dts#">
		insert into temptrx 
		(
			trxbillno,
			accno,
			itemno,
			trxbtype,
			trxdate,
			period,
			currrate,
			custno,
			amount,
			amount2,
			gst,
			GSTAMT,
			GSTTYPE
		)
		values 
		(
			'#refno#',
			'#accno#',
			'#itemno#',
			'#type#',
			#wos_date#,
			'#ceiling(fperiod)#',
			'#currrate#',
			'#custno#',
			'#numberformat(amt_bil,"._____")#',
			'#numberformat(amt_bil*currrate,"._____")#',
			'#val(TAXPEC1)#',
			'#val(taxamt)#',
			'#note_a#'
		);
	</cfquery>
</cfloop>

<cfquery name="gettemp" datasource="#dts#">
	select 
	trxbillno,
	accno,
	itemno,
	trxbtype,
	trxdate,
	period,
	currrate,
	custno,
	gst,
	GSTTYPE,
	sum(GSTAMT) as gstamt,
	sum(amount) as amtt_fc,
	sum(amount2)as amtt 
	from temptrx
	where trxdate<>'' 
	group by accno<cfif wpitemtax eq "Y">,GSTTYPE</cfif>
	order by trxbillno,accno<cfif wpitemtax eq "Y">,GSTTYPE</cfif>;
</cfquery>

<cfoutput>
<cfloop query="gettemp">
	<tr>
		<td>#gettemp.trxbtype#</td>
		<td>#gettemp.trxbillno#</td>
		<td>#dateformat(gettemp.trxdate,"dd/mm/yyyy")#</td>
		
		<cfif getartran.type eq "RC" or getartran.type eq "PR">
			<cfset xaccno = getaccno.gstpurchase>
		<cfelse>
			<cfset xaccno = getaccno.gstsales>
		</cfif>
		
		<cfif getartran.taxincl eq "T" <!--- and val(getaccno.gst) neq 0 ---> and (xaccno neq "" and xaccno neq "0000/000")>
			<!--- <cfif wpitemtax eq "Y">
				<cfset gst_item_value = val(gettemp.GSTAMT)>
			<cfelse>
				<cfset gst_item_value = val(gettemp.amtt) - (val(gettemp.amtt) / ((val(getartran.taxp1)/100) + 1))>
			</cfif> --->
			<cfset gst_item_value = val(gettemp.GSTAMT)>
		<cfelse>
			<cfset gst_item_value = 0>
		</cfif>
		
		<cfif gettemp.trxbtype eq "RC" or gettemp.trxbtype eq "CN">
			<cfset acctype = "D">
			<td><div align="right">#numberformat(gettemp.amtt-gst_item_value+check_misc.sum_without_misc,".__")#</div></td>
			<td></td>
		<cfelse>
			<cfset acctype = "Cr">
			<td></td>		
			<td><div align="right">#numberformat(gettemp.amtt-gst_item_value+check_misc.sum_without_misc,".__")#</div></td>
		</cfif>

		<td><div align="left">
			<cfif wpitemtax eq "Y">
				#gettemp.GSTTYPE# <cfif val(gettemp.gst) neq 0>#val(gettemp.gst)# %</cfif>
			<cfelse>
				#getartran.note# <cfif val(getartran.taxp1) neq 0>#val(getartran.taxp1)# %</cfif>
			</cfif>
		</div></td>
		<td>#gettemp.period#</td>
		<td>#gettemp.accno#</td>
		<td>#acctype#</td>
		<td nowrap>#getartran.name#</td>
	</tr>		
	<cfif wpitemtax eq "Y" and val(gettemp.GSTAMT) neq 0>
		<tr>
			<td>#gettemp.trxbtype#</td>
			<td>#gettemp.trxbillno#</td>
			<td>#dateformat(gettemp.trxdate,"dd/mm/yyyy")#</td>
			
			<cfif getartran.type eq "RC" or getartran.type eq "CN" or getartran.type eq "PR">
                <cfset acctype1 = "D">			
                
                <cfif getartran.type eq "RC" or getartran.type eq "PR">
                    <cfset xaccno = getaccno.gstpurchase>				
                <cfelse>
                    <cfset xaccno = getaccno.gstsales>
                </cfif>
                <td><div align="right">#numberformat(gettemp.gstamt,".__")#</div></td>
                <td></td>
            <cfelse>
                <cfset acctype1 = "Cr">
                <cfset xaccno = getaccno.gstsales>
                <td></td>
                <td><div align="right">#numberformat(gettemp.gstamt,".__")#</div></td>
            </cfif>
			
			<!--- ADD ON 09-10-2009 --->
			<cfif gettemp.GSTTYPE neq "">
				<cfquery name="gettaxcode" datasource="#dts#">
					SELECT corr_accno FROM #target_taxtable# 
					WHERE code=<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettemp.GSTTYPE#"> LIMIT 1
				</cfquery>
				<cfif gettaxcode.recordcount neq 0 and gettaxcode.corr_accno neq "" and gettaxcode.corr_accno neq "0000/000">
					<cfset xaccno = gettaxcode.corr_accno>	
				</cfif>
			</cfif>
	
			<td><div align="left">#gettemp.GSTTYPE# <cfif val(gettemp.gst) neq 0>#val(gettemp.gst)# %</cfif></div></td>
			<td>#gettemp.period#</td>
			<td>#xaccno#</td>
			<td>#acctype1#</td>
			<td nowrap>#getartran.name#</td>
		</tr>		
	</cfif>
	<cfif post eq "post">
		<cfif gettemp.trxbtype eq "RC" or gettemp.trxbtype eq "CN"<!---  or gettemp.trxbtype eq "PR" --->>
			<cfquery name="insertpost2" datasource="#dts#">
				insert into glpost9 
				(
					acc_code,
					accno,
					fperiod,
					date,
					reference,
					desp,
					debitamt,
					fcamt,
					exc_rate,
					rem4,
					rem5,
					bdate,
					taxpur,userid,TAXPEC
				)
				values 
				(
					'#gettemp.trxbtype#',
					'#accno#',
					'#period#',
					#trxdate#,
					'#billno#',
					'#getartran.name#',
					'#numberformat(gettemp.amtt-gst_item_value+check_misc.sum_without_misc,".__")#',
					'#numberformat(amtt_fc-(gst_item_value/getartran.currrate)+check_misc.sum_without_misc_bil,".__")#',
					'#currrate#',
					<cfif wpitemtax eq "Y">'#gettemp.GSTTYPE#'<cfelse>'#getartran.note#'</cfif>,
					'#getartran.rem6#',
					#trxdate#,
					<cfif wpitemtax eq "Y">'#val(gettemp.amtt)#'<cfelse>'#getartran.net#'</cfif>,'#HUserID#',
					<cfif wpitemtax eq "Y">'#val(gettemp.gst)#'<cfelse>'#val(getartran.taxp1)#'</cfif>
				)
			</cfquery>
			<cfquery name="insertpost2" datasource="#dts#">
				insert into glpost91 
				(
					acc_code,
					accno,
					fperiod,
					date,
					reference,
					desp,
					debitamt,
					fcamt,
					exc_rate,
					rem4,
					rem5,
					bdate,
					taxpur,userid,TAXPEC
				)
				values
				(
					'#gettemp.trxbtype#',
					'#accno#',
					'#period#',
					#trxdate#,
					'#billno#',
					'#getartran.name#',
					'#numberformat(gettemp.amtt-gst_item_value+check_misc.sum_without_misc,".__")#',
					'#numberformat(amtt_fc-(gst_item_value/getartran.currrate)+check_misc.sum_without_misc_bil,".__")#',
					'#currrate#',
					<cfif wpitemtax eq "Y">'#gettemp.GSTTYPE#'<cfelse>'#getartran.note#'</cfif>,
					'#getartran.rem6#',
					#trxdate#,
					<cfif wpitemtax eq "Y">'#val(gettemp.amtt)#'<cfelse>'#getartran.net#'</cfif>,'#HUserID#',
					<cfif wpitemtax eq "Y">'#val(gettemp.gst)#'<cfelse>'#val(getartran.taxp1)#'</cfif>
				)
			</cfquery>
			<cfif wpitemtax eq "Y" and val(gettemp.GSTAMT) neq 0>
				<cfquery name="insertpost3" datasource="#dts#">
                    insert into glpost9 
                    (
                        acc_code,
                        accno,
                        fperiod,date,
                        reference,
                        desp,
                        debitamt,
                        fcamt,
                        exc_rate,
                        rem4,
                        rem5,
                        bdate,userid,TAXPEC
                    )
                    values 
                    (
                        '#gettemp.trxbtype#',
						'#xaccno#',
						'#period#',
						#trxdate#,
						'#billno#',
                        '#getartran.name#',
                        '#numberformat(gettemp.gstamt,".__")#',
                        '#numberformat((gettemp.gstamt/currrate),".__")#',
                        '#currrate#',
                        '#gettemp.GSTTYPE#',
                        '#getartran.rem6#',
                        #getartran.wos_date#,'#HUserID#','#val(gettemp.gst)#'
                    )
                </cfquery>
				
				<cfquery name="insertpost3" datasource="#dts#">
                    insert into glpost91 
                    (
                        acc_code,
                        accno,
                        fperiod,date,
                        reference,
                        desp,
                        debitamt,
                        fcamt,
                        exc_rate,
                        rem4,
                        rem5,
                        bdate,userid,TAXPEC
                    )
                    values 
                    (
                        '#gettemp.trxbtype#',
						'#xaccno#',
						'#period#',
						#trxdate#,
						'#billno#',
                        '#getartran.name#',
                        '#numberformat(gettemp.gstamt,".__")#',
                        '#numberformat((gettemp.gstamt/currrate),".__")#',
                        '#currrate#',
                        '#gettemp.GSTTYPE#',
                        '#getartran.rem6#',
                        #getartran.wos_date#,'#HUserID#','#val(gettemp.gst)#'
                    )
                </cfquery>
			</cfif>
		<cfelse>
			<cfquery name="insertpost2" datasource="#dts#">
				insert into glpost9 
				(
					acc_code,
					accno,
					fperiod,
					date,
					reference,
					desp,
					creditamt,
					fcamt,
					exc_rate,
					rem4,
					rem5,
					bdate,
					taxpur,userid,TAXPEC
				)
				values 
				(
					'#gettemp.trxbtype#',
					'#accno#',
					'#period#',
					#trxdate#,
					'#billno#',
					'#getartran.name#',
					'#numberformat(gettemp.amtt-gst_item_value+check_misc.sum_without_misc,".__")#',
					'-#numberformat(amtt_fc-(gst_item_value/getartran.currrate)+check_misc.sum_without_misc_bil,".__")#',
					'#currrate#',
					<cfif wpitemtax eq "Y">'#gettemp.GSTTYPE#'<cfelse>'#getartran.note#'</cfif>,
					'#getartran.rem6#',
					#trxdate#,
					<cfif wpitemtax eq "Y">'#val(gettemp.amtt)#'<cfelse>'#getartran.net#'</cfif>,'#HUserID#',
					<cfif wpitemtax eq "Y">'#val(gettemp.gst)#'<cfelse>'#val(getartran.taxp1)#'</cfif>
				)
			</cfquery>
			
			<cfquery name="insertpost2" datasource="#dts#">
				insert into glpost91 
				(
					acc_code,
					accno,
					fperiod,
					date,
					reference,
					desp,
					creditamt,
					fcamt,
					exc_rate,
					rem4,
					rem5,
					bdate,
					taxpur,userid,TAXPEC
				)
				values
				(
					'#gettemp.trxbtype#',
					'#accno#',
					'#period#',
					#trxdate#,
					'#billno#',
					'#getartran.name#',
					'#numberformat(gettemp.amtt-gst_item_value+check_misc.sum_without_misc,".__")#',
					'-#numberformat(amtt_fc-(gst_item_value/getartran.currrate)+check_misc.sum_without_misc_bil,".__")#',
					'#currrate#',
					<cfif wpitemtax eq "Y">'#gettemp.GSTTYPE#'<cfelse>'#getartran.note#'</cfif>,
					'#getartran.rem6#',
					#trxdate#,
					<cfif wpitemtax eq "Y">'#val(gettemp.amtt)#'<cfelse>'#getartran.net#'</cfif>,'#HUserID#',
					<cfif wpitemtax eq "Y">'#val(gettemp.gst)#'<cfelse>'#val(getartran.taxp1)#'</cfif>
				)
			</cfquery>
			<cfif wpitemtax eq "Y" and val(gettemp.GSTAMT) neq 0>
				 <cfquery name="insertpost3" datasource="#dts#">
                    insert into glpost9 
                    (
                        acc_code,
                        accno,
                        fperiod,
                        date,
                        reference,
                        desp,
                        creditamt,
                        fcamt,
                        exc_rate,
                        rem4,
                        rem5,
                        bdate,userid,TAXPEC
                    )
                    values 
                    (
                        '#gettemp.trxbtype#',
						'#xaccno#',
						'#period#',
						#trxdate#,
						'#billno#',
                        '#getartran.name#',
                        '#numberformat(gettemp.gstamt,".__")#',
                        '-#numberformat((gettemp.gstamt/currrate),".__")#',
                        '#currrate#',
                        '#gettemp.GSTTYPE#',
                        '#getartran.rem6#',
                        #getartran.wos_date#,'#HUserID#','#val(gettemp.gst)#'
                    )
                </cfquery>
				<cfquery name="insertpost3" datasource="#dts#">
                    insert into glpost91 
                    (
                        acc_code,
                        accno,
                        fperiod,
                        date,
                        reference,
                        desp,
                        creditamt,
                        fcamt,
                        exc_rate,
                        rem4,
                        rem5,
                        bdate,userid,TAXPEC
                    )
                    values 
                    (
                        '#gettemp.trxbtype#',
						'#xaccno#',
						'#period#',
						#trxdate#,
						'#billno#',
                        '#getartran.name#',
                        '#numberformat(gettemp.gstamt,".__")#',
                        '-#numberformat((gettemp.gstamt/currrate),".__")#',
                        '#currrate#',
                        '#gettemp.GSTTYPE#',
                        '#getartran.rem6#',
                        #getartran.wos_date#,'#HUserID#','#val(gettemp.gst)#'
                    )
                </cfquery>
			</cfif>
		</cfif>			
	</cfif>
</cfloop>
</cfoutput>
