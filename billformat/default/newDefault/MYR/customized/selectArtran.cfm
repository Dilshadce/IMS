<cfquery name="getHeaderInfo" datasource='#dts#' >
	SELECT 	a.type,a.custno,a.refno,a.refno2,a.wos_date,a.desp,a.despa,a.term,a.pono,a.dono,a.sono,a.quono,a.depositno,
            a.cs_pm_cash,a.cs_pm_cheq,a.cs_pm_crcd,a.cs_pm_crc2,a.cs_pm_tt,a.cs_pm_dbcd,a.cs_pm_vouc,a.cs_pm_cash,a.deposit,a.cs_pm_debt,
            a.taxincl,a.termscondition,
            a.rem0,a.rem1,a.rem2,a.rem3,a.rem4,a.rem5,a.rem6,a.rem7,a.rem8,a.rem9,a.rem10,a.rem11,a.rem12,a.rem13,a.rem14,
            a.rem30,a.rem31,a.rem32,a.rem33,a.rem34,a.rem35,a.rem36,a.rem37,a.rem38,a.rem39,
			a.rem40,a.rem41,a.rem42,a.rem43,a.rem44,a.rem45,a.rem46,a.rem47,a.rem48,a.rem49,
            a.frem0,a.frem1,a.frem2,a.frem3,a.frem4,a.frem5,a.frem6,a.country,a.postalcode,a.b_gstno,
            a.frem7,a.frem8,a.comm0,a.comm1,a.comm2,a.comm3,a.comm4,a.d_country,a.d_postalcode,a.d_gstno,
            a.mc1_bil,a.mc2_bil,a.mc3_bil,a.mc4_bil,a.mc5_bil,a.mc6_bil,a.mc7_bil,
            a.disp1,a.disp2,a.disp3,a.disc_bil,a.disc1_bil,a.disc2_bil,a.disc3_bil, 
            a.note,a.taxp1,a.tax,a.tax_bil,a.tax1_bil,a.tax2_bil,a.tax3_bil,a.discount,
            a.invgross,a.gross_bil,a.net,a.net_bil,a.grand,a.grand_bil,a.roundadj,a.currrate,a.checkno,
            a.phonea,a.d_phone2,a.e_mail,a.d_email,   
            a.name,a.userid,a.username,a.created_by, a.returnbillno, a.returndate, a.returnreason,
                    
            ag.agent AS agentNo, ag.desp AS agentDesp, ag.hp AS agentHP, ag.photo AS agentSignature,
            curr.currency AS currencySymbol,a.currcode AS currencyCode, 
            tr.term AS termCode,tr.desp AS termDesp,
            proj.source AS project, proj.project AS projectDesp,
            job.source AS job, job.project AS jobDesp,
            dr.driverno AS driverNo,dr.name AS driverName
	
	FROM artran a 
	LEFT JOIN #target_icagent# ag ON a.agenno = ag.agent
	LEFT JOIN #target_currency# curr ON a.currcode = curr.currcode
	LEFT JOIN #target_icterm# tr ON a.term = tr.term
    LEFT JOIN #target_project# proj ON a.source = proj.source
    LEFT JOIN #target_project# job ON a.job = proj.source
    LEFT JOIN driver dr ON a.van = dr.driverno
	
	WHERE a.type = '#tran#' 
    <cfif IsDefined('url.printBill')> 	
    	<!---Function: Print Bill filters --->
		<cfinclude template="/billformat/default/newDefault/MYR/customized/printAllBillsFilter.cfm">	
    	ORDER BY a.refno ; 
	<cfelseif IsDefined('url.nexttranno')> 
        AND a.refno = '#url.nexttranno#' 
    <cfelse> 
        AND a.refno IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sono#" list="yes">)
    </cfif>
</cfquery>