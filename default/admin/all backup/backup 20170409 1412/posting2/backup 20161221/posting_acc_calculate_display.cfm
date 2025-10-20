<!---recalculate --->
<cfquery name="gettemptableglpost" datasource="#dts#">
	select sum(debitamt) as debitamt,sum(creditamt) as creditamt,uuid,acc_code,reference from glposttemp where uuid='#uuid#' group by acc_code,reference
</cfquery>


<cfloop query="gettemptableglpost">

<cfif lcase(hcomid) neq "taftc_i">
<cfif debitamt neq creditamt and abs(creditamt-debitamt) lt 0.04>

<cfquery name="getentry" datasource="#dts#">
	select entry from glposttemp 
    where uuid='#gettemptableglpost.uuid#' and acc_code='#gettemptableglpost.acc_code#' and reference='#gettemptableglpost.reference#' and taxpur<>'0'
    order by entry desc
</cfquery>

<cfif creditamt gt debitamt>

<cfquery name="updatetemptable" datasource="#dts#">
	update glposttemp set <cfif gettemptableglpost.acc_code eq "RC" or gettemptableglpost.acc_code eq "CN">debitamt=debitamt+#creditamt-debitamt#,taxpur=debitamt<cfelse>creditamt=creditamt-#creditamt-debitamt#,taxpur=creditamt</cfif> where entry='#getentry.entry#'
</cfquery>

<cfelse>

<cfquery name="updatetemptable" datasource="#dts#">
	update glposttemp set <cfif gettemptableglpost.acc_code eq "RC" or gettemptableglpost.acc_code eq "CN">debitamt=debitamt-#debitamt-creditamt#,taxpur=debitamt<cfelse>creditamt=creditamt+#debitamt-creditamt#,taxpur=creditamt</cfif> where entry='#getentry.entry#'
</cfquery>

</cfif>

</cfif>
</cfif>

</cfloop>
<!---end recalculate --->

<cfquery name="getglposttemp" datasource="#dts#">
	select * from glposttemp where uuid='#uuid#' and (creditamt <> 0 or debitamt <> 0)
</cfquery>
<cfoutput>
<cfloop query="getglposttemp">
<cfset totdebit=totdebit+getglposttemp.debitamt>
<cfset totcredit=totcredit+getglposttemp.creditamt>
                <tr>
                    <td>#getglposttemp.acc_code#</td>
                    <td>#getglposttemp.reference#</td>
                    <td>#dateformat(getglposttemp.date,'dd/mm/yyyy')#</td>
                    <td align="right">#getglposttemp.debitamt#</td>
                    <td align="right">#getglposttemp.creditamt#</td>
                    <td align="right">#getglposttemp.rem4# #getglposttemp.taxpec#</td>
                    <td align="right">#getglposttemp.fperiod#</td>
                    <td align="right">#getglposttemp.accno#</td>

                    <td align="right"><cfif getglposttemp.debitamt neq 0>D<cfelse>Cr</cfif></td>
                    <td align="right">#getglposttemp.desp#</td>
                    <td align="right">#getglposttemp.agent#</td>
                    <td align="right">#getglposttemp.source#</td>
                    <td align="right">#getglposttemp.job#</td>
                </tr>
<cfif post eq "post">
				<cfquery name="insertpost1" datasource="#dts#">
					insert into glpost9<cfif isdefined('url.ubs')>ubs</cfif>
					(
						ENTRY,
                        ACC_CODE,
                        ACCNO,
                        FPERIOD,
                        DATE,
                        BATCHNO,
                        TRANNO,
                        VOUC_SEQ,
                        VOUC_SEQ2,
                        TTYPE,
                        REFERENCE,
                        REFNO,
                        DESP,
                        DESPA,
                        DESPB,
                        DESPC,
                        DESPD,
                        DESPE,
                        TAXPEC,
                        DEBITAMT,
                        CREDITAMT,
                        FCAMT,
                        DEBIT_FC,
                        CREDIT_FC,
                        EXC_RATE,
                        ARAPTYPE,
                        AGE,
                        SOURCE,
                        JOB,
                        SUBJOB,
                        POSTED,
                        EXPORTED,
                        EXPORTED1,
                        EXPORTED2,
                        EXPORTED3,
                        REM1,
                        REM2,
                        REM3,
                        REM4,
                        REM5,
                        RPT_ROW,
                        AGENT,
                        STRAN,
                        TAXPUR,
                        PAYMODE,
                        TRDATETIME,
                        CORR_ACC,
                        ACCNO2,
                        ACCNO3,
                        DATE2,
                        USERID,
                        TCURRCODE,
                        TCURRAMT,
                        BPERIOD,
                        BDATE,
                        VPERIOD,
                        payment,
                        knockoff
                        
					)
					values 
					(
						'#getglposttemp.ENTRY#',
                        '#getglposttemp.ACC_CODE#',
                        '#getglposttemp.ACCNO#',
                        '#getglposttemp.FPERIOD#',
                        #getglposttemp.DATE#,
                        '#getglposttemp.BATCHNO#',
                        '#getglposttemp.TRANNO#',
                        '#getglposttemp.VOUC_SEQ#',
                        '#getglposttemp.VOUC_SEQ2#',
                        '#getglposttemp.TTYPE#',
                        '#getglposttemp.REFERENCE#',
                        '#getglposttemp.REFNO#',
                        '#getglposttemp.DESP#',
                        '#getglposttemp.DESPA#',
                        '#getglposttemp.DESPB#',
                        '#getglposttemp.DESPC#',
                        '#getglposttemp.DESPD#',
                        '#getglposttemp.DESPE#',
                        '#getglposttemp.TAXPEC#',
                        '#getglposttemp.DEBITAMT#',
                        '#getglposttemp.CREDITAMT#',
                        '#getglposttemp.FCAMT#',
                        '#getglposttemp.DEBIT_FC#',
                        '#getglposttemp.CREDIT_FC#',
                        '#getglposttemp.EXC_RATE#',
                        '#getglposttemp.ARAPTYPE#',
                        '#getglposttemp.AGE#',
                        '#getglposttemp.SOURCE#',
                        '#getglposttemp.JOB#',
                        '#getglposttemp.SUBJOB#',
                        '#getglposttemp.POSTED#',
                        '#getglposttemp.EXPORTED#',
                        '#getglposttemp.EXPORTED1#',
                        '#getglposttemp.EXPORTED2#',
                        '#getglposttemp.EXPORTED3#',
                        '#getglposttemp.REM1#',
                        '#getglposttemp.REM2#',
                        '#getglposttemp.REM3#',
                        '#getglposttemp.REM4#',
                        '#getglposttemp.REM5#',
                        '#getglposttemp.RPT_ROW#',
                        '#getglposttemp.AGENT#',
                        '#getglposttemp.STRAN#',
                        '#getglposttemp.TAXPUR#',
                        '#getglposttemp.PAYMODE#',
                        <cfif getglposttemp.TRDATETIME eq '' or getglposttemp.TRDATETIME eq '0000-00-00'>'0000-00-00'<cfelse>#getglposttemp.TRDATETIME#</cfif>,
                        '#getglposttemp.CORR_ACC#',
                        '#getglposttemp.ACCNO2#',
                        '#getglposttemp.ACCNO3#',
                        <cfif getglposttemp.DATE2 eq '' or getglposttemp.DATE2 eq '0000-00-00'>'0000-00-00'<cfelse>#getglposttemp.DATE2#</cfif>,
                        '#getglposttemp.USERID#',
                        '#getglposttemp.TCURRCODE#',
                        '#getglposttemp.TCURRAMT#',
                        '#getglposttemp.BPERIOD#',
                        <cfif getglposttemp.BDATE eq '' or getglposttemp.BDATE eq '0000-00-00'>'0000-00-00'<cfelse>#getglposttemp.BDATE#</cfif>,
                        '#getglposttemp.VPERIOD#',
                        '#getglposttemp.payment#',
                        '#getglposttemp.knockoff#'
						
					)
				</cfquery>
                
                
                
                <cfquery name="insertpost2" datasource="#dts#">
					insert into glpost91<cfif isdefined('url.ubs')>ubs</cfif>
					(
						ENTRY,
                        ACC_CODE,
                        ACCNO,
                        FPERIOD,
                        DATE,
                        BATCHNO,
                        TRANNO,
                        VOUC_SEQ,
                        VOUC_SEQ2,
                        TTYPE,
                        REFERENCE,
                        REFNO,
                        DESP,
                        DESPA,
                        DESPB,
                        DESPC,
                        DESPD,
                        DESPE,
                        TAXPEC,
                        DEBITAMT,
                        CREDITAMT,
                        FCAMT,
                        DEBIT_FC,
                        CREDIT_FC,
                        EXC_RATE,
                        ARAPTYPE,
                        AGE,
                        SOURCE,
                        JOB,
                        SUBJOB,
                        POSTED,
                        EXPORTED,
                        EXPORTED1,
                        EXPORTED2,
                        EXPORTED3,
                        REM1,
                        REM2,
                        REM3,
                        REM4,
                        REM5,
                        RPT_ROW,
                        AGENT,
                        STRAN,
                        TAXPUR,
                        PAYMODE,
                        TRDATETIME,
                        CORR_ACC,
                        ACCNO2,
                        ACCNO3,
                        DATE2,
                        USERID,
                        TCURRCODE,
                        TCURRAMT,
                        BPERIOD,
                        BDATE,
                        VPERIOD,
                        payment,
                        knockoff
                        
					)
					values 
					(
						'#getglposttemp.ENTRY#',
                        '#getglposttemp.ACC_CODE#',
                        '#getglposttemp.ACCNO#',
                        '#getglposttemp.FPERIOD#',
                        #getglposttemp.DATE#,
                        '#getglposttemp.BATCHNO#',
                        '#getglposttemp.TRANNO#',
                        '#getglposttemp.VOUC_SEQ#',
                        '#getglposttemp.VOUC_SEQ2#',
                        '#getglposttemp.TTYPE#',
                        '#getglposttemp.REFERENCE#',
                        '#getglposttemp.REFNO#',
                        '#getglposttemp.DESP#',
                        '#getglposttemp.DESPA#',
                        '#getglposttemp.DESPB#',
                        '#getglposttemp.DESPC#',
                        '#getglposttemp.DESPD#',
                        '#getglposttemp.DESPE#',
                        '#getglposttemp.TAXPEC#',
                        '#getglposttemp.DEBITAMT#',
                        '#getglposttemp.CREDITAMT#',
                        '#getglposttemp.FCAMT#',
                        '#getglposttemp.DEBIT_FC#',
                        '#getglposttemp.CREDIT_FC#',
                        '#getglposttemp.EXC_RATE#',
                        '#getglposttemp.ARAPTYPE#',
                        '#getglposttemp.AGE#',
                        '#getglposttemp.SOURCE#',
                        '#getglposttemp.JOB#',
                        '#getglposttemp.SUBJOB#',
                        '#getglposttemp.POSTED#',
                        '#getglposttemp.EXPORTED#',
                        '#getglposttemp.EXPORTED1#',
                        '#getglposttemp.EXPORTED2#',
                        '#getglposttemp.EXPORTED3#',
                        '#getglposttemp.REM1#',
                        '#getglposttemp.REM2#',
                        '#getglposttemp.REM3#',
                        '#getglposttemp.REM4#',
                        '#getglposttemp.REM5#',
                        '#getglposttemp.RPT_ROW#',
                        '#getglposttemp.AGENT#',
                        '#getglposttemp.STRAN#',
                        '#getglposttemp.TAXPUR#',
                        '#getglposttemp.PAYMODE#',
                        <cfif getglposttemp.TRDATETIME eq '' or getglposttemp.TRDATETIME eq '0000-00-00'>'0000-00-00'<cfelse>#getglposttemp.TRDATETIME#</cfif>,
                        '#getglposttemp.CORR_ACC#',
                        '#getglposttemp.ACCNO2#',
                        '#getglposttemp.ACCNO3#',
                        <cfif getglposttemp.DATE2 eq '' or getglposttemp.DATE2 eq '0000-00-00'>'0000-00-00'<cfelse>#getglposttemp.DATE2#</cfif>,
                        '#getglposttemp.USERID#',
                        '#getglposttemp.TCURRCODE#',
                        '#getglposttemp.TCURRAMT#',
                        '#getglposttemp.BPERIOD#',
                        <cfif getglposttemp.BDATE eq '' or getglposttemp.BDATE eq '0000-00-00'>'0000-00-00'<cfelse>#getglposttemp.BDATE#</cfif>,
                        '#getglposttemp.VPERIOD#',
                        '#getglposttemp.payment#',
                        '#getglposttemp.knockoff#'
						
					)
				</cfquery>
</cfif>
</cfloop>
</cfoutput>
<!---<cfif huserid neq 'ultralung'>--->
<cfquery name="gettemptableglpost" datasource="#dts#">
	delete from glposttemp where uuid='#uuid#'
</cfquery>
<!---</cfif>--->