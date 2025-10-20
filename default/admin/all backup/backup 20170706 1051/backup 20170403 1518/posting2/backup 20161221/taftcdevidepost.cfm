<cfoutput>
<!--- Unearn revenue --->
<cfif (getcourse.wtsgrantacc neq "" and getcourse.wtsgrantacc neq "0000/000") or (getcourse.wdaincomeacc neq "" and getcourse.wdaincomeacc neq "0000/000")>
<cfset gettemp.amtt = oriunearn>
</cfif>
<cfset totalunearn = (val(abs(gettemp.amtt))-val(gst_item_value)+val(check_misc.sum_without_misc)) * (val(getjob.postingtimes)-1)>
<cfif getcourse.urevenueacc neq "">
<cfset unearnaccno = getcourse.urevenueacc>
<cfelse>
<cfset unearnaccno = "0000/000">
</cfif>

<cfset unearnaccno = "4205/000"><!---New added---->

<!---
<tr <cfif gettemp.accno eq "0000/000">style="background:##FF0000" </cfif> >
<td>#gettemp.trxbtype#</td>
<td>#gettemp.trxbillno#</td>
<td>#dateformat(gettemp.trxdate,"dd/mm/yyyy")#</td>		--->
		<cfif getartran.type eq "RC" or getartran.type eq "PR">
			<cfset xaccno = getaccno.gstpurchase>
		<cfelse>
			<cfset xaccno = getaccno.gstsales>
		</cfif>
		
		<cfif getartran.taxincl eq "T" <!--- and val(getaccno.gst) neq 0 ---> and (xaccno neq "" and xaccno neq "0000/000")>
			 <cfif wpitemtax eq "Y">
				<cfset gst_item_value = val(gettemp.GSTAMT)>
			<cfelse>
				<cfset gst_item_value = val(gettemp.amtt) - (val(gettemp.amtt) / ((val(getartran.taxp1)/100) + 1))>
			</cfif>
		<!---<cfset gst_item_value = val(gettemp.GSTAMT)> --->
		<cfelse>
			<cfset gst_item_value = 0>
		</cfif>
		<cfif validmisc eq "">
        <cfset validmisc = check_misc.sum_without_misc&gettemp.trxbillno>
        <cfelse>
		<cfif validmisc eq check_misc.sum_without_misc&gettemp.trxbillno>
        <cfset check_misc.sum_without_misc = 0>
		</cfif>
		</cfif>		
		<cfif gettemp.trxbtype eq "RC" or gettemp.trxbtype eq "CN">
			<cfif numberformat(gettemp.amtt-gst_item_value+check_misc.sum_without_misc,".__") lt 0>
            
            <cfset acctype = "Cr">
                <!---<td></td>
                <td><div align="right">#numberformat(totalunearn,".__")#</div><cfset totcredit = totcredit + numberformat(totalunearn,".__")></td>
                --->
            <cfelse>
                <cfset acctype = "D">
                <!---<td><div align="right">#numberformat(totalunearn,".__")#</div><cfset totdebit = totdebit + numberformat(totalunearn,".__")></td>
                <td></td>--->
            </cfif>
		<cfelse>
			<cfif numberformat(val(gettemp.amtt)-val(gst_item_value)+val(check_misc.sum_without_misc),".__") lt 0>

            <cfset acctype = "D">
                		
                <!---<td><div align="right">#numberformat(totalunearn,".__")#</div><cfset totdebit = totdebit + numberformat(totalunearn,".__")></td>
                <td></td>--->
			<cfelse>
                <cfset acctype = "Cr">
                <!---<td></td>		
                <td><div align="right">#numberformat(totalunearn,".__")#</div><cfset totcredit = totcredit + numberformat(totalunearn,".__")></td>
            --->
			</cfif>
		</cfif>

		<!---<td><div align="left">
			<cfif wpitemtax eq "Y">
				#gettemp.GSTTYPE# <cfif val(gettemp.gst) neq 0>#val(gettemp.gst)# %</cfif>
			<cfelse>
				#getartran.note# <cfif val(getartran.taxp1) neq 0>#val(getartran.taxp1)# %</cfif>
			</cfif>
		</div></td>
		<td>#val(gettemp.period)#</td>
		<td>#unearnaccno#</td>
		<td>#acctype#</td>
		<td nowrap>#getartran.name#</td>
        <td nowrap>#getartran.agenno#</td>
		<!--- <cfif lcase(HcomID) eq "probulk_i"> --->
			<td nowrap>#gettemp.source#</td>
			<td nowrap>#gettemp.job#</td>
		<!--- </cfif> --->
	</tr>
--->
    
		<cfif gettemp.trxbtype eq "RC" or gettemp.trxbtype eq "CN"<!---  or gettemp.trxbtype eq "PR" --->>
			<cfquery name="insertpost21111" datasource="#dts#">
				insert into glposttemp
				(
					acc_code,
					accno,
					fperiod,
					date,
					reference,
                    refno,
					desp,
					<cfif numberformat(gettemp.amtt-gst_item_value+check_misc.sum_without_misc,".__") lt 0>
                    creditamt,
					<cfelse>
                    debitamt,
					</cfif>
					fcamt,
					exc_rate,
					rem4,
					rem5,
					bdate,
					taxpur,userid,TAXPEC
					<!--- <cfif lcase(HcomID) eq "probulk_i"> --->,SOURCE,JOB,agent<!--- </cfif> --->
                    ,uuid
				)
				values 
				(
					'#gettemp.trxbtype#',
					'#unearnaccno#',
					'#val(period)#',
					#trxdate#,
					'#billno#',
                    '#getartran.refno2#',
					'#getartran.name#',
					<!---'#numberformat(abs(gettemp.amtt)-gst_item_value+check_misc.sum_without_misc,".__")#',--->
                    '#numberformat(totalunearn,".__")#',
					'#numberformat(abs(amtt_fc)-(gst_item_value/getartran.currrate)+check_misc.sum_without_misc_bil,".__")#',
					'#currrate#',
					<cfif wpitemtax eq "Y">'#gettemp.GSTTYPE#'<cfelse>'#getartran.note#'</cfif>,
					'0',
					#trxdate#,
					<cfif wpitemtax eq "Y">'#val(abs(gettemp.amtt))#'<cfelse>'#numberformat(totalunearn,".__")#'</cfif>
                    ,'#HUserID#',
					<cfif wpitemtax eq "Y">'#val(abs(gettemp.gst))#'<cfelse>'#val(getartran.taxp1)#'</cfif>
					
                    ,'#gettemp.source#'
                    ,'#gettemp.job#'
                    ,'#getartran.agenno#'
                    ,'#uuid#'
				)
			</cfquery>
			
		<cfelse>
			<cfquery name="insertpost211" datasource="#dts#">
				insert into glposttemp
				(
					acc_code,
					accno,
					fperiod,
					date,
					reference,
                    refno,
					desp,
                    <cfif numberformat(val(gettemp.amtt)-val(gst_item_value)+val(check_misc.sum_without_misc),".__") lt 0>
                    debitamt,
                    <cfelse>
					creditamt,
                    </cfif>
					fcamt,
					exc_rate,
					rem4,
					rem5,
					bdate,
					taxpur,userid,TAXPEC
					<!--- <cfif lcase(HcomID) eq "probulk_i"> --->,SOURCE,JOB,agent<!--- </cfif> --->
                    ,uuid
				)
				values 
				(
					'#gettemp.trxbtype#',
					'#unearnaccno#',
					'#val(period)#',
					#trxdate#,
					'#billno#',
                    '#getartran.refno2#',
					'#getartran.name#',
				'#numberformat(totalunearn,".__")#',
					'#numberformat(-(abs(amtt_fc)-(gst_item_value/getartran.currrate)+check_misc.sum_without_misc_bil),".__")#',
					'#currrate#',
					<cfif wpitemtax eq "Y">'#gettemp.GSTTYPE#'<cfelse>'#getartran.note#'</cfif>,
					'0',
					#trxdate#,
					<cfif wpitemtax eq "Y">'#val(abs(gettemp.amtt))#'<cfelse>'#numberformat(val(abs(gettemp.amtt))-val(gst_item_value)+val(check_misc.sum_without_misc),".__")#'</cfif>,'#HUserID#',
					<cfif wpitemtax eq "Y">'#val(abs(gettemp.gst))#'<cfelse>'#val(getartran.taxp1)#'</cfif>
					<!--- <cfif lcase(HcomID) eq "probulk_i"> --->,'#gettemp.source#','#gettemp.job#','#getartran.agenno#'<!--- </cfif> --->
                    ,'#uuid#'
				)
			</cfquery>
			
			
		</cfif>
        
        
        <cfif (getcourse.wtsgrantacc neq "" and getcourse.wtsgrantacc neq "0000/000") or (getcourse.wdaincomeacc neq "" and getcourse.wdaincomeacc neq "0000/000")>
        
        <cfif getcourse.wtsgrantacc neq "" and getcourse.wtsgrantacc neq "0000/000">
        <cfif gettemp.trxbtype eq "RC" or gettemp.trxbtype eq "CN"<!---  or gettemp.trxbtype eq "PR" --->>
			<cfquery name="insertwts" datasource="#dts#">
				insert into glposttemp
				(
					acc_code,
					accno,
					fperiod,
					date,
					reference,
                    refno,
					desp,
					<cfif numberformat(gettemp.amtt-gst_item_value+check_misc.sum_without_misc,".__") lt 0>
                    creditamt,
					<cfelse>
                    debitamt,
					</cfif>
					fcamt,
					exc_rate,
					rem4,
					rem5,
					bdate,
					taxpur,userid,TAXPEC
					<!--- <cfif lcase(HcomID) eq "probulk_i"> --->,SOURCE,JOB,agent<!--- </cfif> --->
                    ,uuid
				)
				values 
				(
					'#gettemp.trxbtype#',
					'#getcourse.wtsincomeacc#',
					'#val(period)#',
					#trxdate#,
					'#billno#',
                    '#getartran.refno2#',
					'#getartran.name#',
					<!---'#numberformat(abs(gettemp.amtt)-gst_item_value+check_misc.sum_without_misc,".__")#',--->
                    '#numberformat(wtsincome,".__")#',
					'#numberformat(wtsincome*val(currrate),".__")#',
					'#currrate#',
					<cfif wpitemtax eq "Y">'#gettemp.GSTTYPE#'<cfelse>'#getartran.note#'</cfif>,
					'0',
					#trxdate#,
					<cfif wpitemtax eq "Y">'#val(wtsincome)#'<cfelse>'#numberformat(wtsincome,".__")#'</cfif>
                    ,'#HUserID#',
					<cfif wpitemtax eq "Y">'#val(abs(gettemp.gst))#'<cfelse>'#val(getartran.taxp1)#'</cfif>
					
                    ,'#gettemp.source#'
                    ,'#gettemp.job#'
                    ,'#getartran.agenno#'
                    ,'#uuid#'
				)
			</cfquery>
			
		<cfelse>
			<cfquery name="insertpost211" datasource="#dts#">
				insert into glposttemp
				(
					acc_code,
					accno,
					fperiod,
					date,
					reference,
                    refno,
					desp,
                    <cfif numberformat(val(gettemp.amtt)-val(gst_item_value)+val(check_misc.sum_without_misc),".__") lt 0>
                    debitamt,
                    <cfelse>
					creditamt,
                    </cfif>
					fcamt,
					exc_rate,
					rem4,
					rem5,
					bdate,
					taxpur,userid,TAXPEC
					<!--- <cfif lcase(HcomID) eq "probulk_i"> --->,SOURCE,JOB,agent<!--- </cfif> --->
                    ,uuid
				)
				values 
				(
					'#gettemp.trxbtype#',
					'#getcourse.wtsincomeacc#',
					'#val(period)#',
					#trxdate#,
					'#billno#',
                    '#getartran.refno2#',
					'#getartran.name#',
				'#numberformat(wtsincome,".__")#',
					'#numberformat(-(val(wtsincome)*val(currrate)),".__")#',
					'#currrate#',
					<cfif wpitemtax eq "Y">'#gettemp.GSTTYPE#'<cfelse>'#getartran.note#'</cfif>,
					'0',
					#trxdate#,
					<cfif wpitemtax eq "Y">'#val(wtsincome)#'<cfelse>'#numberformat(wtsincome,".__")#'</cfif>,'#HUserID#',
					<cfif wpitemtax eq "Y">'#val(abs(gettemp.gst))#'<cfelse>'#val(getartran.taxp1)#'</cfif>
					<!--- <cfif lcase(HcomID) eq "probulk_i"> --->,'#gettemp.source#','#gettemp.job#','#getartran.agenno#'<!--- </cfif> --->
                    ,'#uuid#'
				)
			</cfquery>
			
			
		</cfif>
        </cfif>

        <cfif gettemp.trxbtype eq "RC" or gettemp.trxbtype eq "CN"<!---  or gettemp.trxbtype eq "PR" --->>
			<cfquery name="insertwda" datasource="#dts#">
				insert into glposttemp
				(
					acc_code,
					accno,
					fperiod,
					date,
					reference,
                    refno,
					desp,
					<cfif numberformat(gettemp.amtt-gst_item_value+check_misc.sum_without_misc,".__") lt 0>
                    creditamt,
					<cfelse>
                    debitamt,
					</cfif>
					fcamt,
					exc_rate,
					rem4,
					rem5,
					bdate,
					taxpur,userid,TAXPEC
					<!--- <cfif lcase(HcomID) eq "probulk_i"> --->,SOURCE,JOB,agent<!--- </cfif> --->
                    ,uuid
				)
				values 
				(
					'#gettemp.trxbtype#',
					'#getcourse.wdaincomeacc#',
					'#val(period)#',
					#trxdate#,
					'#billno#',
                    '#getartran.refno2#',
					'#getartran.name#',
					<!---'#numberformat(abs(gettemp.amtt)-gst_item_value+check_misc.sum_without_misc,".__")#',--->
                    '#numberformat(wdaincome,".__")#',
					'#numberformat(wdaincome*val(currrate),".__")#',
					'#currrate#',
					<cfif wpitemtax eq "Y">'#gettemp.GSTTYPE#'<cfelse>'#getartran.note#'</cfif>,
					'0',
					#trxdate#,
					<cfif wpitemtax eq "Y">'#val(wdaincome)#'<cfelse>'#numberformat(wdaincome,".__")#'</cfif>
                    ,'#HUserID#',
					<cfif wpitemtax eq "Y">'#val(abs(gettemp.gst))#'<cfelse>'#val(getartran.taxp1)#'</cfif>
					
                    ,'#gettemp.source#'
                    ,'#gettemp.job#'
                    ,'#getartran.agenno#'
                    ,'#uuid#'
				)
			</cfquery>
			
		<cfelse>
			<cfquery name="insertpost211" datasource="#dts#">
				insert into glposttemp
				(
					acc_code,
					accno,
					fperiod,
					date,
					reference,
                    refno,
					desp,
                    <cfif numberformat(val(gettemp.amtt)-val(gst_item_value)+val(check_misc.sum_without_misc),".__") lt 0>
                    debitamt,
                    <cfelse>
					creditamt,
                    </cfif>
					fcamt,
					exc_rate,
					rem4,
					rem5,
					bdate,
					taxpur,userid,TAXPEC
					<!--- <cfif lcase(HcomID) eq "probulk_i"> --->,SOURCE,JOB,agent<!--- </cfif> --->
                    ,uuid
				)
				values 
				(
					'#gettemp.trxbtype#',
					'#getcourse.wdaincomeacc#',
					'#val(period)#',
					#trxdate#,
					'#billno#',
                    '#getartran.refno2#',
					'#getartran.name#',
				'#numberformat(wdaincome,".__")#',
					'#numberformat(-(val(wdaincome)*val(currrate)),".__")#',
					'#currrate#',
					<cfif wpitemtax eq "Y">'#gettemp.GSTTYPE#'<cfelse>'#getartran.note#'</cfif>,
					'0',
					#trxdate#,
					<cfif wpitemtax eq "Y">'#val(wdaincome)#'<cfelse>'#numberformat(wdaincome,".__")#'</cfif>,'#HUserID#',
					<cfif wpitemtax eq "Y">'#val(abs(gettemp.gst))#'<cfelse>'#val(getartran.taxp1)#'</cfif>
					<!--- <cfif lcase(HcomID) eq "probulk_i"> --->,'#gettemp.source#','#gettemp.job#','#getartran.agenno#'<!--- </cfif> --->
                    ,'#uuid#'
				)
			</cfquery>

        </cfif>
        		</cfif>	

<cfloop from="1" to="#val(getjob.postingtimes)-1#" index="i"><cfif (getcourse.wtsgrantacc neq "" and getcourse.wtsgrantacc neq "0000/000") or (getcourse.wdaincomeacc neq "" and getcourse.wdaincomeacc neq "0000/000")>
<cfset gettemp.amtt = oriunearn>
</cfif>
<!---debit unearn--->
<cfset totalunearn = (val(abs(gettemp.amtt))-val(gst_item_value)+val(check_misc.sum_without_misc)) * (val(getjob.postingtimes)-1)>
<cfif getcourse.urevenueacc neq "">
<cfset unearnaccno = getcourse.urevenueacc>
<cfelse>
<cfset unearnaccno = "0000/000">
</cfif>
<cfset unearnaccno = "4201/000"><!---New added---->

<cfset reverseaccno = gettemp.accno>
<cfset gettemp.accno = unearnaccno>

<!---
<tr <cfif gettemp.accno eq "0000/000">style="background:##FF0000" </cfif> >
<td>#gettemp.trxbtype#</td>
<td>#gettemp.trxbillno#</td>
<td>#dateformat(dateadd('m',i,gettemp.trxdate),"dd/mm/yyyy")#</td>	--->	
		<cfif getartran.type eq "RC" or getartran.type eq "PR">
			<cfset xaccno = getaccno.gstpurchase>
		<cfelse>
			<cfset xaccno = getaccno.gstsales>
		</cfif>
		
		<cfif getartran.taxincl eq "T" <!--- and val(getaccno.gst) neq 0 ---> and (xaccno neq "" and xaccno neq "0000/000")>
			 <cfif wpitemtax eq "Y">
				<cfset gst_item_value = val(gettemp.GSTAMT)>
			<cfelse>
				<cfset gst_item_value = val(gettemp.amtt) - (val(gettemp.amtt) / ((val(getartran.taxp1)/100) + 1))>
			</cfif>
		<!---<cfset gst_item_value = val(gettemp.GSTAMT)> --->
		<cfelse>
			<cfset gst_item_value = 0>
		</cfif>
		<cfif validmisc eq "">
        <cfset validmisc = check_misc.sum_without_misc&gettemp.trxbillno>
        <cfelse>
		<cfif validmisc eq check_misc.sum_without_misc&gettemp.trxbillno>
        <cfset check_misc.sum_without_misc = 0>
		</cfif>
		</cfif>		
		<cfif gettemp.trxbtype eq "RC" <!--- or gettemp.trxbtype eq "CN" ---> or gettemp.trxbtype eq "INV">
			<cfif numberformat(gettemp.amtt-gst_item_value+check_misc.sum_without_misc,".__") lt 0>
            
            <cfset acctype = "Cr">
            <!---    <td></td>
                <td><div align="right">#numberformat(abs(gettemp.amtt)-gst_item_value+check_misc.sum_without_misc,".__")#</div><cfset totcredit = totcredit + numberformat(abs(gettemp.amtt)-gst_item_value+check_misc.sum_without_misc,".__")></td>
                --->
            <cfelse>
                <cfset acctype = "D">
            <!---    <td><div align="right">#numberformat(gettemp.amtt-gst_item_value+check_misc.sum_without_misc,".__")#</div><cfset totdebit = totdebit + numberformat(gettemp.amtt-gst_item_value+check_misc.sum_without_misc,".__")></td>
                <td></td>--->
            </cfif>
		<cfelse>
			<cfif numberformat(val(gettemp.amtt)-val(gst_item_value)+val(check_misc.sum_without_misc),".__") lt 0>

            <cfset acctype = "D">
                		
               <!--- <td><div align="right">#numberformat(val(abs(gettemp.amtt))-val(gst_item_value)+val(check_misc.sum_without_misc),".__")#</div><cfset totdebit = totdebit + numberformat(val(abs(gettemp.amtt))-val(gst_item_value)+val(check_misc.sum_without_misc),".__")></td>
                <td></td>--->
			<cfelse>
                <cfset acctype = "Cr">
                <!---<td></td>		
                <td><div align="right">#numberformat(val(gettemp.amtt)-val(gst_item_value)+val(check_misc.sum_without_misc),".__")#</div><cfset totcredit = totcredit + numberformat(val(gettemp.amtt)-val(gst_item_value)+val(check_misc.sum_without_misc),".__")></td>
            	--->
			</cfif>
		</cfif>

		<!---<td><div align="left">
			<cfif wpitemtax eq "Y">
				#gettemp.GSTTYPE# <cfif val(gettemp.gst) neq 0>#val(gettemp.gst)# %</cfif>
			<cfelse>
				#getartran.note# <cfif val(getartran.taxp1) neq 0>#val(getartran.taxp1)# %</cfif>
			</cfif>
		</div></td>
		<td>#val(gettemp.period)+i#</td>
		<td>#gettemp.accno#</td>
		<td>#acctype#</td>
		<td nowrap>#getartran.name#</td>
        <td nowrap>#getartran.agenno#</td>
		<!--- <cfif lcase(HcomID) eq "probulk_i"> --->
			<td nowrap>#gettemp.source#</td>
			<td nowrap>#gettemp.job#</td>
		<!--- </cfif> --->
	</tr>
--->
    
		<cfif gettemp.trxbtype eq "RC" <!--- or gettemp.trxbtype eq "CN" ---> or gettemp.trxbtype eq "INV"<!---  or gettemp.trxbtype eq "PR" --->>
			<cfquery name="insertpost2" datasource="#dts#">
				insert into glposttemp
				(
					acc_code,
					accno,
					fperiod,
					date,
					reference,
                    refno,
					desp,
					<cfif numberformat(gettemp.amtt-gst_item_value+check_misc.sum_without_misc,".__") lt 0>
                    creditamt,
					<cfelse>
                    debitamt,
					</cfif>
					fcamt,
					exc_rate,
					rem4,
					rem5,
					bdate,
					taxpur,userid,TAXPEC
					<!--- <cfif lcase(HcomID) eq "probulk_i"> --->,SOURCE,JOB,agent<!--- </cfif> --->
                    ,uuid
				)
				values 
				(
					'#gettemp.trxbtype#',
					'#accno#',
					'#val(period)+i#',
					#dateadd('m',i,trxdate)#,
					'#billno#',
                    '#getartran.refno2#',
					'#getartran.name#',
					'#numberformat(abs(gettemp.amtt)-gst_item_value+check_misc.sum_without_misc,".__")#',
					'#numberformat(abs(amtt_fc)-(gst_item_value/getartran.currrate)+check_misc.sum_without_misc_bil,".__")#',
					'#currrate#',
					<cfif wpitemtax eq "Y">'#gettemp.GSTTYPE#'<cfelse>'#getartran.note#'</cfif>,
					'0',
					#dateadd('m',i,trxdate)#,
					<cfif wpitemtax eq "Y">'#val(abs(gettemp.amtt))#'<cfelse>'#numberformat(abs(gettemp.amtt)-gst_item_value+check_misc.sum_without_misc,".__")#'</cfif>
                    ,'#HUserID#',
					<cfif wpitemtax eq "Y">'#val(abs(gettemp.gst))#'<cfelse>'#val(getartran.taxp1)#'</cfif>
					
                    ,'#gettemp.source#'
                    ,'#gettemp.job#'
                    ,'#getartran.agenno#'
                    ,'#uuid#'
				)
			</cfquery>
			
		<cfelse>
			<cfquery name="insertpost2" datasource="#dts#">
				insert into glposttemp
				(
					acc_code,
					accno,
					fperiod,
					date,
					reference,
                    refno,
					desp,
                    <cfif numberformat(val(gettemp.amtt)-val(gst_item_value)+val(check_misc.sum_without_misc),".__") lt 0>
                    debitamt,
                    <cfelse>
					creditamt,
                    </cfif>
					fcamt,
					exc_rate,
					rem4,
					rem5,
					bdate,
					taxpur,userid,TAXPEC
					<!--- <cfif lcase(HcomID) eq "probulk_i"> --->,SOURCE,JOB,agent<!--- </cfif> --->
                    ,uuid
				)
				values 
				(
					'#gettemp.trxbtype#',
					'#accno#',
					'#val(period)+i#',
					#dateadd('m',i,trxdate)#,
					'#billno#',
                    '#getartran.refno2#',
					'#getartran.name#',
				'#numberformat(val(abs(gettemp.amtt))-val(gst_item_value)+val(check_misc.sum_without_misc),".__")#',
					'#numberformat(-(abs(amtt_fc)-(gst_item_value/getartran.currrate)+check_misc.sum_without_misc_bil),".__")#',
					'#currrate#',
					<cfif wpitemtax eq "Y">'#gettemp.GSTTYPE#'<cfelse>'#getartran.note#'</cfif>,
					'0',
					#dateadd('m',i,trxdate)#,
					<cfif wpitemtax eq "Y">'#val(abs(gettemp.amtt))#'<cfelse>'#numberformat(val(abs(gettemp.amtt))-val(gst_item_value)+val(check_misc.sum_without_misc),".__")#'</cfif>,'#HUserID#',
					<cfif wpitemtax eq "Y">'#val(abs(gettemp.gst))#'<cfelse>'#val(getartran.taxp1)#'</cfif>
					<!--- <cfif lcase(HcomID) eq "probulk_i"> --->,'#gettemp.source#','#gettemp.job#','#getartran.agenno#'<!--- </cfif> --->
                    ,'#uuid#'
				)
			</cfquery>
			
		</cfif>			

<!---end debit unearn--->
<cfset gettemp.accno = reverseaccno><cfif (getcourse.wtsgrantacc neq "" and getcourse.wtsgrantacc neq "0000/000") or (getcourse.wdaincomeacc neq "" and getcourse.wdaincomeacc neq "0000/000")>
<cfset gettemp.amtt = orisales>
</cfif>
<!---
<tr <cfif gettemp.accno eq "0000/000">style="background:##FF0000" </cfif> >
<td>#gettemp.trxbtype#</td>
<td>#gettemp.trxbillno#</td>
<td>#dateformat(dateadd('m',i,gettemp.trxdate),"dd/mm/yyyy")#</td>		--->
		<cfif getartran.type eq "RC" or getartran.type eq "PR">
			<cfset xaccno = getaccno.gstpurchase>
		<cfelse>
			<cfset xaccno = getaccno.gstsales>
		</cfif>
		
		<cfif getartran.taxincl eq "T" <!--- and val(getaccno.gst) neq 0 ---> and (xaccno neq "" and xaccno neq "0000/000")>
			 <cfif wpitemtax eq "Y">
				<cfset gst_item_value = val(gettemp.GSTAMT)>
			<cfelse>
				<cfset gst_item_value = val(gettemp.amtt) - (val(gettemp.amtt) / ((val(getartran.taxp1)/100) + 1))>
			</cfif>
		<!---<cfset gst_item_value = val(gettemp.GSTAMT)> --->
		<cfelse>
			<cfset gst_item_value = 0>
		</cfif>
		<cfif validmisc eq "">
        <cfset validmisc = check_misc.sum_without_misc&gettemp.trxbillno>
        <cfelse>
		<cfif validmisc eq check_misc.sum_without_misc&gettemp.trxbillno>
        <cfset check_misc.sum_without_misc = 0>
		</cfif>
		</cfif>		
		<cfif gettemp.trxbtype eq "RC" or gettemp.trxbtype eq "CN">
			<cfif numberformat(gettemp.amtt-gst_item_value+check_misc.sum_without_misc,".__") lt 0>
            
            <cfset acctype = "Cr">
                <!---<td></td>
                <td><div align="right">#numberformat(abs(gettemp.amtt)-gst_item_value+check_misc.sum_without_misc,".__")#</div><cfset totcredit = totcredit + numberformat(abs(gettemp.amtt)-gst_item_value+check_misc.sum_without_misc,".__")></td>
                --->
            <cfelse>
                <cfset acctype = "D">
                <!---
                <td><div align="right">#numberformat(gettemp.amtt-gst_item_value+check_misc.sum_without_misc,".__")#</div><cfset totdebit = totdebit + numberformat(gettemp.amtt-gst_item_value+check_misc.sum_without_misc,".__")></td>
                <td></td>--->
            </cfif>
		<cfelse>
			<cfif numberformat(val(gettemp.amtt)-val(gst_item_value)+val(check_misc.sum_without_misc),".__") lt 0>

            <cfset acctype = "D">
                		
                <!---<td><div align="right">#numberformat(val(abs(gettemp.amtt))-val(gst_item_value)+val(check_misc.sum_without_misc),".__")#</div><cfset totdebit = totdebit + numberformat(val(abs(gettemp.amtt))-val(gst_item_value)+val(check_misc.sum_without_misc),".__")></td>
                <td></td>--->
			<cfelse>
                <cfset acctype = "Cr">
                <!---<td></td>		
                <td><div align="right">#numberformat(val(gettemp.amtt)-val(gst_item_value)+val(check_misc.sum_without_misc),".__")#</div><cfset totcredit = totcredit + numberformat(val(gettemp.amtt)-val(gst_item_value)+val(check_misc.sum_without_misc),".__")></td>
            	--->
			</cfif>
		</cfif>

		<!---<td><div align="left">
			<cfif wpitemtax eq "Y">
				#gettemp.GSTTYPE# <cfif val(gettemp.gst) neq 0>#val(gettemp.gst)# %</cfif>
			<cfelse>
				#getartran.note# <cfif val(getartran.taxp1) neq 0>#val(getartran.taxp1)# %</cfif>
			</cfif>
		</div></td>
		<td>#val(gettemp.period)+i#</td>
		<td>#gettemp.accno#</td>
		<td>#acctype#</td>
		<td nowrap>#getartran.name#</td>
        <td nowrap>#getartran.agenno#</td>
		<!--- <cfif lcase(HcomID) eq "probulk_i"> --->
			<td nowrap>#gettemp.source#</td>
			<td nowrap>#gettemp.job#</td>
		<!--- </cfif> --->
	</tr>--->

    
		<cfif gettemp.trxbtype eq "RC" or gettemp.trxbtype eq "CN"<!---  or gettemp.trxbtype eq "PR" --->>
			<cfquery name="insertpost2" datasource="#dts#">
				insert into glposttemp
				(
					acc_code,
					accno,
					fperiod,
					date,
					reference,
                    refno,
					desp,
					<cfif numberformat(gettemp.amtt-gst_item_value+check_misc.sum_without_misc,".__") lt 0>
                    creditamt,
					<cfelse>
                    debitamt,
					</cfif>
					fcamt,
					exc_rate,
					rem4,
					rem5,
					bdate,
					taxpur,userid,TAXPEC
					<!--- <cfif lcase(HcomID) eq "probulk_i"> --->,SOURCE,JOB,agent<!--- </cfif> --->
                    ,uuid
				)
				values 
				(
					'#gettemp.trxbtype#',
					'#accno#',
					'#val(period)+i#',
					#dateadd('m',i,trxdate)#,
					'#billno#',
                    '#getartran.refno2#',
					'#getartran.name#',
					'#numberformat(abs(gettemp.amtt)-gst_item_value+check_misc.sum_without_misc,".__")#',
					'#numberformat(abs(amtt_fc)-(gst_item_value/getartran.currrate)+check_misc.sum_without_misc_bil,".__")#',
					'#currrate#',
					<cfif wpitemtax eq "Y">'#gettemp.GSTTYPE#'<cfelse>'#getartran.note#'</cfif>,
					'0',
					#dateadd('m',i,trxdate)#,
					<cfif wpitemtax eq "Y">'#val(abs(gettemp.amtt))#'<cfelse>'#numberformat(abs(gettemp.amtt)-gst_item_value+check_misc.sum_without_misc,".__")#'</cfif>
                    ,'#HUserID#',
					<cfif wpitemtax eq "Y">'#val(abs(gettemp.gst))#'<cfelse>'#val(getartran.taxp1)#'</cfif>
					
                    ,'#gettemp.source#'
                    ,'#gettemp.job#'
                    ,'#getartran.agenno#'
                    ,'#uuid#'
				)
			</cfquery>
			
		<cfelse>
			<cfquery name="insertpost2" datasource="#dts#">
				insert into glposttemp
				(
					acc_code,
					accno,
					fperiod,
					date,
					reference,
                    refno,
					desp,
                    <cfif numberformat(val(gettemp.amtt)-val(gst_item_value)+val(check_misc.sum_without_misc),".__") lt 0>
                    debitamt,
                    <cfelse>
					creditamt,
                    </cfif>
					fcamt,
					exc_rate,
					rem4,
					rem5,
					bdate,
					taxpur,userid,TAXPEC
					<!--- <cfif lcase(HcomID) eq "probulk_i"> --->,SOURCE,JOB,agent<!--- </cfif> --->
                    ,uuid
				)
				values 
				(
					'#gettemp.trxbtype#',
					'#accno#',
					'#val(period)+i#',
					#dateadd('m',i,trxdate)#,
					'#billno#',
                    '#getartran.refno2#',
					'#getartran.name#',
				'#numberformat(val(abs(gettemp.amtt))-val(gst_item_value)+val(check_misc.sum_without_misc),".__")#',
					'#numberformat(-(abs(amtt_fc)-(gst_item_value/getartran.currrate)+check_misc.sum_without_misc_bil),".__")#',
					'#currrate#',
					<cfif wpitemtax eq "Y">'#gettemp.GSTTYPE#'<cfelse>'#getartran.note#'</cfif>,
					'0',
					#dateadd('m',i,trxdate)#,
					<cfif wpitemtax eq "Y">'#val(abs(gettemp.amtt))#'<cfelse>'#numberformat(val(abs(gettemp.amtt))-val(gst_item_value)+val(check_misc.sum_without_misc),".__")#'</cfif>,'#HUserID#',
					<cfif wpitemtax eq "Y">'#val(abs(gettemp.gst))#'<cfelse>'#val(getartran.taxp1)#'</cfif>
					<!--- <cfif lcase(HcomID) eq "probulk_i"> --->,'#gettemp.source#','#gettemp.job#','#getartran.agenno#'<!--- </cfif> --->
                    ,'#uuid#'
				)
			</cfquery>
			
			
		</cfif>
		
		<cfif (getcourse.wtsgrantacc neq "" and getcourse.wtsgrantacc neq "0000/000") or (getcourse.wdaincomeacc neq "" and getcourse.wdaincomeacc neq "0000/000")>
        <cfif getcourse.wtsgrantacc neq "" and getcourse.wtsgrantacc neq "0000/000">
        <cfif gettemp.trxbtype eq "RC" or gettemp.trxbtype eq "CN"<!---  or gettemp.trxbtype eq "PR" --->>
			<cfquery name="insertwtsloop" datasource="#dts#">
				insert into glposttemp
				(
					acc_code,
					accno,
					fperiod,
					date,
					reference,
                    refno,
					desp,
					<cfif numberformat(gettemp.amtt-gst_item_value+check_misc.sum_without_misc,".__") lt 0>
                    creditamt,
					<cfelse>
                    debitamt,
					</cfif>
					fcamt,
					exc_rate,
					rem4,
					rem5,
					bdate,
					taxpur,userid,TAXPEC
					<!--- <cfif lcase(HcomID) eq "probulk_i"> --->,SOURCE,JOB,agent<!--- </cfif> --->
                    ,uuid
				)
				values 
				(
					'#gettemp.trxbtype#',
					'#getcourse.wtsincomeacc#',
					'#val(period)+i#',
					#dateadd('m',i,trxdate)#,
					'#billno#',
                    '#getartran.refno2#',
					'#getartran.name#',
					'#numberformat(wtsincome,".__")#',
					'#numberformat(wtsincome,".__")#',
					'#currrate#',
					<cfif wpitemtax eq "Y">'#gettemp.GSTTYPE#'<cfelse>'#getartran.note#'</cfif>,
					'0',
					#dateadd('m',i,trxdate)#,
					<cfif wpitemtax eq "Y">'#val(wtsincome)#'<cfelse>'#numberformat(wtsincome,".__")#'</cfif>
                    ,'#HUserID#',
					<cfif wpitemtax eq "Y">'#val(abs(gettemp.gst))#'<cfelse>'#val(getartran.taxp1)#'</cfif>
					
                    ,'#gettemp.source#'
                    ,'#gettemp.job#'
                    ,'#getartran.agenno#'
                    ,'#uuid#'
				)
			</cfquery>
			
		<cfelse>
			<cfquery name="insertpost2" datasource="#dts#">
				insert into glposttemp
				(
					acc_code,
					accno,
					fperiod,
					date,
					reference,
                    refno,
					desp,
                    <cfif numberformat(val(gettemp.amtt)-val(gst_item_value)+val(check_misc.sum_without_misc),".__") lt 0>
                    debitamt,
                    <cfelse>
					creditamt,
                    </cfif>
					fcamt,
					exc_rate,
					rem4,
					rem5,
					bdate,
					taxpur,userid,TAXPEC
					<!--- <cfif lcase(HcomID) eq "probulk_i"> --->,SOURCE,JOB,agent<!--- </cfif> --->
                    ,uuid
				)
				values 
				(
					'#gettemp.trxbtype#',
					'#getcourse.wtsincomeacc#',
					'#val(period)+i#',
					#dateadd('m',i,trxdate)#,
					'#billno#',
                    '#getartran.refno2#',
					'#getartran.name#',
				'#numberformat(wtsincome,".__")#',
					'#numberformat(-(wtsincome),".__")#',
					'#currrate#',
					<cfif wpitemtax eq "Y">'#gettemp.GSTTYPE#'<cfelse>'#getartran.note#'</cfif>,
					'0',
					#dateadd('m',i,trxdate)#,
					<cfif wpitemtax eq "Y">'#val(wtsincome)#'<cfelse>'#numberformat(val(wtsincome),".__")#'</cfif>,'#HUserID#',
					<cfif wpitemtax eq "Y">'#val(abs(gettemp.gst))#'<cfelse>'#val(getartran.taxp1)#'</cfif>
					<!--- <cfif lcase(HcomID) eq "probulk_i"> --->,'#gettemp.source#','#gettemp.job#','#getartran.agenno#'<!--- </cfif> --->
                    ,'#uuid#'
				)
			</cfquery>
			
			
		</cfif>
        </cfif>
        
        <cfif gettemp.trxbtype eq "RC" or gettemp.trxbtype eq "CN"<!---  or gettemp.trxbtype eq "PR" --->>
			<cfquery name="insertwdaloop" datasource="#dts#">
				insert into glposttemp
				(
					acc_code,
					accno,
					fperiod,
					date,
					reference,
                    refno,
					desp,
					<cfif numberformat(gettemp.amtt-gst_item_value+check_misc.sum_without_misc,".__") lt 0>
                    creditamt,
					<cfelse>
                    debitamt,
					</cfif>
					fcamt,
					exc_rate,
					rem4,
					rem5,
					bdate,
					taxpur,userid,TAXPEC
					<!--- <cfif lcase(HcomID) eq "probulk_i"> --->,SOURCE,JOB,agent<!--- </cfif> --->
                    ,uuid
				)
				values 
				(
					'#gettemp.trxbtype#',
					'#getcourse.wdaincomeacc#',
					'#val(period)+i#',
					#dateadd('m',i,trxdate)#,
					'#billno#',
                    '#getartran.refno2#',
					'#getartran.name#',
					'#numberformat(wdaincome,".__")#',
					'#numberformat(wdaincome,".__")#',
					'#currrate#',
					<cfif wpitemtax eq "Y">'#gettemp.GSTTYPE#'<cfelse>'#getartran.note#'</cfif>,
					'0',
					#dateadd('m',i,trxdate)#,
					<cfif wpitemtax eq "Y">'#val(wdaincome)#'<cfelse>'#numberformat(wdaincome,".__")#'</cfif>
                    ,'#HUserID#',
					<cfif wpitemtax eq "Y">'#val(abs(gettemp.gst))#'<cfelse>'#val(getartran.taxp1)#'</cfif>
					
                    ,'#gettemp.source#'
                    ,'#gettemp.job#'
                    ,'#getartran.agenno#'
                    ,'#uuid#'
				)
			</cfquery>
			
		<cfelse>
			<cfquery name="insertwdaloop" datasource="#dts#">
				insert into glposttemp
				(
					acc_code,
					accno,
					fperiod,
					date,
					reference,
                    refno,
					desp,
                    <cfif numberformat(val(gettemp.amtt)-val(gst_item_value)+val(check_misc.sum_without_misc),".__") lt 0>
                    debitamt,
                    <cfelse>
					creditamt,
                    </cfif>
					fcamt,
					exc_rate,
					rem4,
					rem5,
					bdate,
					taxpur,userid,TAXPEC
					<!--- <cfif lcase(HcomID) eq "probulk_i"> --->,SOURCE,JOB,agent<!--- </cfif> --->
                    ,uuid
				)
				values 
				(
					'#gettemp.trxbtype#',
					'#getcourse.wdaincomeacc#',
					'#val(period)+i#',
					#dateadd('m',i,trxdate)#,
					'#billno#',
                    '#getartran.refno2#',
					'#getartran.name#',
				'#numberformat(wdaincome,".__")#',
					'#numberformat(-(wdaincome),".__")#',
					'#currrate#',
					<cfif wpitemtax eq "Y">'#gettemp.GSTTYPE#'<cfelse>'#getartran.note#'</cfif>,
					'0',
					#dateadd('m',i,trxdate)#,
					<cfif wpitemtax eq "Y">'#val(wdaincome)#'<cfelse>'#numberformat(val(wdaincome),".__")#'</cfif>,'#HUserID#',
					<cfif wpitemtax eq "Y">'#val(abs(gettemp.gst))#'<cfelse>'#val(getartran.taxp1)#'</cfif>
					<!--- <cfif lcase(HcomID) eq "probulk_i"> --->,'#gettemp.source#','#gettemp.job#','#getartran.agenno#'<!--- </cfif> --->
                    ,'#uuid#'
				)
			</cfquery>
			
			
		</cfif>
        
        </cfif>

</cfloop>
<!--- --->

<cfif val(realtaftcperiod) neq val(period)>

            <cfquery name="update" datasource="#dts#">
            	update glposttemp set accno="4203/000" where accno="#getartran.custno#" and uuid="#uuid#"
            </cfquery>
            
            <cfquery name="update" datasource="#dts#">
            	update glposttemp set accno="4201/000" where accno="#getcourse.grantacc#" and uuid="#uuid#"
            </cfquery>

            <cfquery name="update" datasource="#dts#">
            	update glposttemp set accno="4202/000" where accno="#getcourse.wtsgrantacc#" and uuid="#uuid#"
            </cfquery>

			<cfif type eq "CN"<!---  or type eq "PR" --->>
			
			<cfquery name="insertpost1332" datasource="#dts#">
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
						creditamt,
						fcamt,
						exc_rate,
						rem4,
						rem5,
						bdate,
						userid,
                        agent
                        <cfif lcase(hcomid) eq "taftc_i">
						,SOURCE,JOB
                        </cfif>
                        ,uuid
					)
					values 
					(
						'#type#',
						'#getartran.custno#',
						'#ceiling(realtaftcperiod)#',
						#realtaftcdate#,
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
							'#getartran.pono#',
						<cfelse>
							'#getartran.despa#',
						</cfif>
                        <cfif getcourse.wtsgrantacc neq "" and getcourse.wtsgrantacc neq "0000/000">
						'#numberformat(getcourse.camt-((5/100)*getcourse.cPrice),".__")#',
						'#numberformat(getcourse.camt-((5/100)*getcourse.cPrice),".__")#',
                        <cfelse>
                        '#numberformat(val(getcourse.camt),".__")#',
						'#numberformat(val(getcourse.camt),".__")#',
                        </cfif>
						'#currrate#',
						'',
						'#getartran.rem6#',
						#getartran.wos_date#,'#HUserID#','#getartran.agenno#'
                        <cfif lcase(hcomid) eq "taftc_i">
						,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.source#">
                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.job#">
						</cfif>
                        ,'#uuid#'
					)
				</cfquery>
				
				
				<cfquery name="insertpost1333" datasource="#dts#">
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
						debitamt,
						fcamt,
						exc_rate,
						rem4,
						rem5,
						bdate,
						userid,
                        agent
                        <cfif lcase(hcomid) eq "taftc_i">
						,SOURCE,JOB
                        </cfif>
                        ,uuid
					)
					values 
					(
						'#type#',
						'4203/000',
						'#ceiling(realtaftcperiod)#',
						#realtaftcdate#,
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
							'#getartran.pono#',
						<cfelse>
							'#getartran.despa#',
						</cfif>
                        <cfif getcourse.wtsgrantacc neq "" and getcourse.wtsgrantacc neq "0000/000">
						'#numberformat(getcourse.camt-((5/100)*getcourse.cPrice),".__")#',
						'#numberformat(getcourse.camt-((5/100)*getcourse.cPrice),".__")#',
                        <cfelse>
                        '#numberformat(val(getcourse.camt),".__")#',
						'#numberformat(val(getcourse.camt),".__")#',
                        </cfif>
						'#currrate#',
						'',
						'#getartran.rem6#',
						#getartran.wos_date#,'#HUserID#','#getartran.agenno#'
                        <cfif lcase(hcomid) eq "taftc_i">
						,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.source#">
                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.job#">
						</cfif>
                        ,'#uuid#'
					)
				</cfquery>
            <!---wda--->
			<cfquery name="insertpost1332" datasource="#dts#">
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
						creditamt,
						fcamt,
						exc_rate,
						rem4,
						rem5,
						bdate,
						userid,
                        agent
                        <cfif lcase(hcomid) eq "taftc_i">
						,SOURCE,JOB
                        </cfif>
                        ,uuid
					)
					values 
					(
						'#type#',
						'#getcourse.grantacc#',
						'#ceiling(realtaftcperiod)#',
						#realtaftcdate#,
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
							'#getartran.pono#',
						<cfelse>
							'#getartran.despa#',
						</cfif>
                        '#numberformat(val(getcourse.cdispec),".__")#',
						'#numberformat(val(getcourse.cdispec),".__")#',
						'#currrate#',
						'',
						'#getartran.rem6#',
						#getartran.wos_date#,'#HUserID#','#getartran.agenno#'
                        <cfif lcase(hcomid) eq "taftc_i">
						,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.source#">
                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.job#">
						</cfif>
                        ,'#uuid#'
					)
				</cfquery>
				
				
				<cfquery name="insertpost1333" datasource="#dts#">
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
						debitamt,
						fcamt,
						exc_rate,
						rem4,
						rem5,
						bdate,
						userid,
                        agent
                        <cfif lcase(hcomid) eq "taftc_i">
						,SOURCE,JOB
                        </cfif>
                        ,uuid
					)
					values 
					(
						'#type#',
						'4201/000',
						'#ceiling(realtaftcperiod)#',
						#realtaftcdate#,
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
							'#getartran.pono#',
						<cfelse>
							'#getartran.despa#',
						</cfif>
                        '#numberformat(val(getcourse.cdispec),".__")#',
						'#numberformat(val(getcourse.cdispec),".__")#',
						'#currrate#',
						'',
						'#getartran.rem6#',
						#getartran.wos_date#,'#HUserID#','#getartran.agenno#'
                        <cfif lcase(hcomid) eq "taftc_i">
						,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.source#">
                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.job#">
						</cfif>
                        ,'#uuid#'
					)
				</cfquery>
            <!---wts--->
            <cfif getcourse.wtsgrantacc neq "" and getcourse.wtsgrantacc neq "0000/000">
			<cfquery name="insertpost1332" datasource="#dts#">
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
						creditamt,
						fcamt,
						exc_rate,
						rem4,
						rem5,
						bdate,
						userid,
                        agent
                        <cfif lcase(hcomid) eq "taftc_i">
						,SOURCE,JOB
                        </cfif>
                        ,uuid
					)
					values 
					(
						'#type#',
						'#getcourse.wtsgrantacc#',
						'#ceiling(realtaftcperiod)#',
						#realtaftcdate#,
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
							'#getartran.pono#',
						<cfelse>
							'#getartran.despa#',
						</cfif>
                        '#numberformat(val(((5/100)*getcourse.cPrice)),".__")#',
						'#numberformat(val(((5/100)*getcourse.cPrice)),".__")#',
						'#currrate#',
						'',
						'#getartran.rem6#',
						#getartran.wos_date#,'#HUserID#','#getartran.agenno#'
                        <cfif lcase(hcomid) eq "taftc_i">
						,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.source#">
                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.job#">
						</cfif>
                        ,'#uuid#'
					)
				</cfquery>
				
				
				<cfquery name="insertpost1333" datasource="#dts#">
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
						debitamt,
						fcamt,
						exc_rate,
						rem4,
						rem5,
						bdate,
						userid,
                        agent
                        <cfif lcase(hcomid) eq "taftc_i">
						,SOURCE,JOB
                        </cfif>
                        ,uuid
					)
					values 
					(
						'#type#',
						'4202/000',
						'#ceiling(realtaftcperiod)#',
						#realtaftcdate#,
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
							'#getartran.pono#',
						<cfelse>
							'#getartran.despa#',
						</cfif>
                        '#numberformat(val(((5/100)*getcourse.cPrice)),".__")#',
						'#numberformat(val(((5/100)*getcourse.cPrice)),".__")#',
						'#currrate#',
						'',
						'#getartran.rem6#',
						#getartran.wos_date#,'#HUserID#','#getartran.agenno#'
                        <cfif lcase(hcomid) eq "taftc_i">
						,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.source#">
                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.job#">
						</cfif>
                        ,'#uuid#'
					)
				</cfquery>
			</cfif>
				
			<cfelse>
			<!---sales--->
			<cfquery name="insertpost1332" datasource="#dts#">
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
						debitamt,
						fcamt,
						exc_rate,
						rem4,
						rem5,
						bdate,
						userid,
                        agent
                        <cfif lcase(hcomid) eq "taftc_i">
						,SOURCE,JOB
                        </cfif>
                        ,uuid
					)
					values 
					(
						'#type#',
						'#getartran.custno#',
						'#ceiling(realtaftcperiod)#',
						#realtaftcdate#,
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
							'#getartran.pono#',
						<cfelse>
							'#getartran.despa#',
						</cfif>
                        <cfif getcourse.wtsgrantacc neq "" and getcourse.wtsgrantacc neq "0000/000">
						'#numberformat(getcourse.camt-((5/100)*getcourse.cPrice),".__")#',
						'#numberformat(getcourse.camt-((5/100)*getcourse.cPrice),".__")#',
                        <cfelse>
                        '#numberformat(val(getcourse.camt),".__")#',
						'#numberformat(val(getcourse.camt),".__")#',
                        </cfif>
						'#currrate#',
						'',
						'#getartran.rem6#',
						#getartran.wos_date#,'#HUserID#','#getartran.agenno#'
                        <cfif lcase(hcomid) eq "taftc_i">
						,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.source#">
                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.job#">
						</cfif>
                        ,'#uuid#'
					)
				</cfquery>
				
				
				<cfquery name="insertpost1333" datasource="#dts#">
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
						creditamt,
						fcamt,
						exc_rate,
						rem4,
						rem5,
						bdate,
						userid,
                        agent
                        <cfif lcase(hcomid) eq "taftc_i">
						,SOURCE,JOB
                        </cfif>
                        ,uuid
					)
					values 
					(
						'#type#',
						'4203/000',
						'#ceiling(realtaftcperiod)#',
						#realtaftcdate#,
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
							'#getartran.pono#',
						<cfelse>
							'#getartran.despa#',
						</cfif>
                        <cfif getcourse.wtsgrantacc neq "" and getcourse.wtsgrantacc neq "0000/000">
						'#numberformat(getcourse.camt-((5/100)*getcourse.cPrice),".__")#',
						'#numberformat(getcourse.camt-((5/100)*getcourse.cPrice),".__")#',
                        <cfelse>
                        '#numberformat(val(getcourse.camt),".__")#',
						'#numberformat(val(getcourse.camt),".__")#',
                        </cfif>
						'#currrate#',
						'',
						'#getartran.rem6#',
						#getartran.wos_date#,'#HUserID#','#getartran.agenno#'
                        <cfif lcase(hcomid) eq "taftc_i">
						,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.source#">
                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.job#">
						</cfif>
                        ,'#uuid#'
					)
				</cfquery>
			<!---wda--->
			<cfquery name="insertpost1332" datasource="#dts#">
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
						debitamt,
						fcamt,
						exc_rate,
						rem4,
						rem5,
						bdate,
						userid,
                        agent
                        <cfif lcase(hcomid) eq "taftc_i">
						,SOURCE,JOB
                        </cfif>
                        ,uuid
					)
					values 
					(
						'#type#',
						'#getcourse.grantacc#',
						'#ceiling(realtaftcperiod)#',
						#realtaftcdate#,
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
							'#getartran.pono#',
						<cfelse>
							'#getartran.despa#',
						</cfif>
                        '#numberformat(val(getcourse.cdispec),".__")#',
						'#numberformat(val(getcourse.cdispec),".__")#',
						'#currrate#',
						'',
						'#getartran.rem6#',
						#getartran.wos_date#,'#HUserID#','#getartran.agenno#'
                        <cfif lcase(hcomid) eq "taftc_i">
						,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.source#">
                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.job#">
						</cfif>
                        ,'#uuid#'
					)
				</cfquery>
				
				
				<cfquery name="insertpost1333" datasource="#dts#">
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
						creditamt,
						fcamt,
						exc_rate,
						rem4,
						rem5,
						bdate,
						userid,
                        agent
                        <cfif lcase(hcomid) eq "taftc_i">
						,SOURCE,JOB
                        </cfif>
                        ,uuid
					)
					values 
					(
						'#type#',
						'4201/000',
						'#ceiling(realtaftcperiod)#',
						#realtaftcdate#,
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
							'#getartran.pono#',
						<cfelse>
							'#getartran.despa#',
						</cfif>
                        '#numberformat(val(getcourse.cdispec),".__")#',
						'#numberformat(val(getcourse.cdispec),".__")#',
						'#currrate#',
						'',
						'#getartran.rem6#',
						#getartran.wos_date#,'#HUserID#','#getartran.agenno#'
                        <cfif lcase(hcomid) eq "taftc_i">
						,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.source#">
                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.job#">
						</cfif>
                        ,'#uuid#'
					)
				</cfquery>
            <!---wts--->
            <cfif getcourse.wtsgrantacc neq "" and getcourse.wtsgrantacc neq "0000/000">
			<cfquery name="insertpost1332" datasource="#dts#">
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
						debitamt,
						fcamt,
						exc_rate,
						rem4,
						rem5,
						bdate,
						userid,
                        agent
                        <cfif lcase(hcomid) eq "taftc_i">
						,SOURCE,JOB
                        </cfif>
                        ,uuid
					)
					values 
					(
						'#type#',
						'#getcourse.wtsgrantacc#',
						'#ceiling(realtaftcperiod)#',
						#realtaftcdate#,
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
							'#getartran.pono#',
						<cfelse>
							'#getartran.despa#',
						</cfif>
                        '#numberformat(val(((5/100)*getcourse.cPrice)),".__")#',
						'#numberformat(val(((5/100)*getcourse.cPrice)),".__")#',
						'#currrate#',
						'',
						'#getartran.rem6#',
						#getartran.wos_date#,'#HUserID#','#getartran.agenno#'
                        <cfif lcase(hcomid) eq "taftc_i">
						,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.source#">
                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.job#">
						</cfif>
                        ,'#uuid#'
					)
				</cfquery>
				
				
				<cfquery name="insertpost1333" datasource="#dts#">
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
						creditamt,
						fcamt,
						exc_rate,
						rem4,
						rem5,
						bdate,
						userid,
                        agent
                        <cfif lcase(hcomid) eq "taftc_i">
						,SOURCE,JOB
                        </cfif>
                        ,uuid
					)
					values 
					(
						'#type#',
						'4202/000',
						'#ceiling(realtaftcperiod)#',
						#realtaftcdate#,
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
							'#getartran.pono#',
						<cfelse>
							'#getartran.despa#',
						</cfif>
                        '#numberformat(val(((5/100)*getcourse.cPrice)),".__")#',
						'#numberformat(val(((5/100)*getcourse.cPrice)),".__")#',
						'#currrate#',
						'',
						'#getartran.rem6#',
						#getartran.wos_date#,'#HUserID#','#getartran.agenno#'
                        <cfif lcase(hcomid) eq "taftc_i">
						,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.source#">
                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.job#">
						</cfif>
                        ,'#uuid#'
					)
				</cfquery>
			</cfif>
			</cfif>


</cfif>
<!--- --->
</cfoutput>