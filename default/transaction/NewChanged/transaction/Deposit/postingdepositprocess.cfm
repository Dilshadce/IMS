<cfif form.sort eq 'wos_date'>
<cfset ndatefrom=createdate(right(form.datefrom,4),mid(form.datefrom,4,2),left(form.datefrom,2))>
<cfset ndateto=createdate(right(form.dateto,4),mid(form.dateto,4,2),left(form.dateto,2))>
</cfif>
<cfquery name="getgsetup" datasource="#dts#">
select * from gsetup
</cfquery>

<cfif getgsetup.depositaccount eq '' or getgsetup.depositaccount eq '0000/000' ><!---or getgsetup.bankaccount eq '' or getgsetup.bankaccount eq '0000/000'--->
<h3>Please Select Deposit Account and Bank Account at AMS account setup. Click <a href="/default/admin/Accountno.cfm" target="main" >here</a></h3>
<cfabort>
</cfif>

<cfquery name="getdeposit" datasource="#dts#">
select * from deposit where (posted='' or posted is null)
<cfif form.sort eq 'wos_date'>
and wos_date between '#dateformat(ndatefrom,'yyyy-mm-dd')#' and '#dateformat(ndateto,'yyyy-mm-dd')#'
<cfelseif form.sort eq 'fperiod'>
and fperiod='#form.fperiod#'
</cfif>
</cfquery>

<cfloop query="getdeposit">
			
            <cfif getdeposit.cs_pm_cash neq 0>
            <cfquery name="insertpost1" datasource="#dts#">
				insert into glpost9
                (acc_code,accno,fperiod,date,reference,refno,desp,despa,debitamt,fcamt,exc_rate,rem4,rem5,bdate,userid,agent)			
				values('Dep','#getgsetup.cashaccount#','#getdeposit.fperiod#',#getdeposit.wos_date#,'#getdeposit.depositno#','#getdeposit.sono#',
				'Deposit','',
				'#numberformat(getdeposit.cs_pm_cash,".__")#',
                '#numberformat(getdeposit.cs_pm_cash,".__")#',
                '1',
                '','',#getdeposit.wos_date#,'#HUserID#','')
			</cfquery>
			
			<cfquery name="insertpost2" datasource="#dts#">
				insert into glpost91
                (acc_code,accno,fperiod,date,reference,refno,desp,despa,debitamt,fcamt,exc_rate,rem4,rem5,bdate,userid,agent)			
				values('Dep','#getgsetup.cashaccount#','#getdeposit.fperiod#',#getdeposit.wos_date#,'#getdeposit.depositno#','#getdeposit.sono#',
				'Deposit','',
				'#numberformat(getdeposit.cs_pm_cash,".__")#',
                '#numberformat(getdeposit.cs_pm_cash,".__")#',
                '1','','',#getdeposit.wos_date#,'#HUserID#','')
			</cfquery>
            </cfif>
            
            <cfif getdeposit.cs_pm_crcd neq 0>
            
            <cfquery name="insertpost1" datasource="#dts#">
				insert into glpost9
                (acc_code,accno,fperiod,date,reference,refno,desp,despa,debitamt,fcamt,exc_rate,rem4,rem5,bdate,userid,agent)			
				values('Dep','#getgsetup.creditcardaccount1#','#getdeposit.fperiod#',#getdeposit.wos_date#,'#getdeposit.depositno#','#getdeposit.sono#',
				'Deposit','',
				'#numberformat(getdeposit.cs_pm_crcd,".__")#',
                '#numberformat(getdeposit.cs_pm_crcd,".__")#',
                '1',
                '','',#getdeposit.wos_date#,'#HUserID#','')
			</cfquery>
			
			<cfquery name="insertpost2" datasource="#dts#">
				insert into glpost91
                (acc_code,accno,fperiod,date,reference,refno,desp,despa,debitamt,fcamt,exc_rate,rem4,rem5,bdate,userid,agent)			
				values('Dep','#getgsetup.creditcardaccount1#','#getdeposit.fperiod#',#getdeposit.wos_date#,'#getdeposit.depositno#','#getdeposit.sono#',
				'Deposit','',
				'#numberformat(getdeposit.cs_pm_crcd,".__")#',
                '#numberformat(getdeposit.cs_pm_crcd,".__")#',
                '1','','',#getdeposit.wos_date#,'#HUserID#','')
			</cfquery>
            
            </cfif>
            
            <cfif getdeposit.cs_pm_crc2 neq 0>
            
            <cfquery name="insertpost1" datasource="#dts#">
				insert into glpost9
                (acc_code,accno,fperiod,date,reference,refno,desp,despa,debitamt,fcamt,exc_rate,rem4,rem5,bdate,userid,agent)			
				values('Dep','#getgsetup.creditcardaccount2#','#getdeposit.fperiod#',#getdeposit.wos_date#,'#getdeposit.depositno#','#getdeposit.sono#',
				'Deposit','',
				'#numberformat(getdeposit.cs_pm_crc2,".__")#',
                '#numberformat(getdeposit.cs_pm_crc2,".__")#',
                '1',
                '','',#getdeposit.wos_date#,'#HUserID#','')
			</cfquery>
			
			<cfquery name="insertpost2" datasource="#dts#">
				insert into glpost91
                (acc_code,accno,fperiod,date,reference,refno,desp,despa,debitamt,fcamt,exc_rate,rem4,rem5,bdate,userid,agent)			
				values('Dep','#getgsetup.creditcardaccount2#','#getdeposit.fperiod#',#getdeposit.wos_date#,'#getdeposit.depositno#','#getdeposit.sono#',
				'Deposit','',
				'#numberformat(getdeposit.cs_pm_crc2,".__")#',
                '#numberformat(getdeposit.cs_pm_crc2,".__")#',
                '1','','',#getdeposit.wos_date#,'#HUserID#','')
			</cfquery>
            
            </cfif>
            
            <cfif getdeposit.cs_pm_cheq neq 0>
            
            <cfquery name="insertpost1" datasource="#dts#">
				insert into glpost9
                (acc_code,accno,fperiod,date,reference,refno,desp,despa,debitamt,fcamt,exc_rate,rem4,rem5,bdate,userid,agent)			
				values('Dep','#getgsetup.chequeaccount#','#getdeposit.fperiod#',#getdeposit.wos_date#,'#getdeposit.depositno#','#getdeposit.sono#',
				'Deposit','',
				'#numberformat(getdeposit.cs_pm_cheq,".__")#',
                '#numberformat(getdeposit.cs_pm_cheq,".__")#',
                '1',
                '','',#getdeposit.wos_date#,'#HUserID#','')
			</cfquery>
			
			<cfquery name="insertpost2" datasource="#dts#">
				insert into glpost91
                (acc_code,accno,fperiod,date,reference,refno,desp,despa,debitamt,fcamt,exc_rate,rem4,rem5,bdate,userid,agent)			
				values('Dep','#getgsetup.chequeaccount#','#getdeposit.fperiod#',#getdeposit.wos_date#,'#getdeposit.depositno#','#getdeposit.sono#',
				'Deposit','',
				'#numberformat(getdeposit.cs_pm_cheq,".__")#',
                '#numberformat(getdeposit.cs_pm_cheq,".__")#',
                '1','','',#getdeposit.wos_date#,'#HUserID#','')
			</cfquery>
            
            </cfif>
            
            <cfif getdeposit.cs_pm_dbcd neq 0>
            
            <cfquery name="insertpost1" datasource="#dts#">
				insert into glpost9
                (acc_code,accno,fperiod,date,reference,refno,desp,despa,debitamt,fcamt,exc_rate,rem4,rem5,bdate,userid,agent)			
				values('Dep','#getgsetup.debitcardaccount#','#getdeposit.fperiod#',#getdeposit.wos_date#,'#getdeposit.depositno#','#getdeposit.sono#',
				'Deposit','',
				'#numberformat(getdeposit.cs_pm_dbcd,".__")#',
                '#numberformat(getdeposit.cs_pm_dbcd,".__")#',
                '1',
                '','',#getdeposit.wos_date#,'#HUserID#','')
			</cfquery>
			
			<cfquery name="insertpost2" datasource="#dts#">
				insert into glpost91
                (acc_code,accno,fperiod,date,reference,refno,desp,despa,debitamt,fcamt,exc_rate,rem4,rem5,bdate,userid,agent)			
				values('Dep','#getgsetup.debitcardaccount#','#getdeposit.fperiod#',#getdeposit.wos_date#,'#getdeposit.depositno#','#getdeposit.sono#',
				'Deposit','',
				'#numberformat(getdeposit.cs_pm_dbcd,".__")#',
                '#numberformat(getdeposit.cs_pm_dbcd,".__")#',
                '1','','',#getdeposit.wos_date#,'#HUserID#','')
			</cfquery>
            
            </cfif>
            
            <cfif getdeposit.cs_pm_vouc neq 0>
            
            <cfquery name="insertpost1" datasource="#dts#">
				insert into glpost9
                (acc_code,accno,fperiod,date,reference,refno,desp,despa,debitamt,fcamt,exc_rate,rem4,rem5,bdate,userid,agent)			
				values('Dep','#getgsetup.cashvoucheraccount#','#getdeposit.fperiod#',#getdeposit.wos_date#,'#getdeposit.depositno#','#getdeposit.sono#',
				'Deposit','',
				'#numberformat(getdeposit.cs_pm_vouc,".__")#',
                '#numberformat(getdeposit.cs_pm_vouc,".__")#',
                '1',
                '','',#getdeposit.wos_date#,'#HUserID#','')
			</cfquery>
			
			<cfquery name="insertpost2" datasource="#dts#">
				insert into glpost91
                (acc_code,accno,fperiod,date,reference,refno,desp,despa,debitamt,fcamt,exc_rate,rem4,rem5,bdate,userid,agent)			
				values('Dep','#getgsetup.cashvoucheraccount#','#getdeposit.fperiod#',#getdeposit.wos_date#,'#getdeposit.depositno#','#getdeposit.sono#',
				'Deposit','',
				'#numberformat(getdeposit.cs_pm_vouc,".__")#',
                '#numberformat(getdeposit.cs_pm_vouc,".__")#',
                '1','','',#getdeposit.wos_date#,'#HUserID#','')
			</cfquery>
            
            </cfif>
            
            <!---
			<cfquery name="insertpost1" datasource="#dts#">
				insert into glpost9
                (acc_code,accno,fperiod,date,reference,refno,desp,despa,debitamt,fcamt,exc_rate,rem4,rem5,bdate,userid,agent)			
				values('Dep','#getgsetup.bankaccount#','#getdeposit.fperiod#',#getdeposit.wos_date#,'#getdeposit.depositno#','#getdeposit.sono#',
				'Deposit','',
				'#numberformat(getdeposit.cs_pm_cash+getdeposit.cs_pm_cheq+getdeposit.cs_pm_crcd+getdeposit.cs_pm_crc2+getdeposit.cs_pm_dbcd+getdeposit.cs_pm_vouc+getdeposit.cs_pm_cashcd,".__")#',
                '#numberformat(getdeposit.cs_pm_cash+getdeposit.cs_pm_cheq+getdeposit.cs_pm_crcd+getdeposit.cs_pm_crc2+getdeposit.cs_pm_dbcd+getdeposit.cs_pm_vouc+getdeposit.cs_pm_cashcd,".__")#',
                '1',
                '','',#getdeposit.wos_date#,'#HUserID#','')
			</cfquery>
			
			<cfquery name="insertpost2" datasource="#dts#">
				insert into glpost91
                (acc_code,accno,fperiod,date,reference,refno,desp,despa,debitamt,fcamt,exc_rate,rem4,rem5,bdate,userid,agent)			
				values('Dep','#getgsetup.bankaccount#','#getdeposit.fperiod#',#getdeposit.wos_date#,'#getdeposit.depositno#','#getdeposit.sono#',
				'Deposit','',
				'#numberformat(getdeposit.cs_pm_cash+getdeposit.cs_pm_cheq+getdeposit.cs_pm_crcd+getdeposit.cs_pm_crc2+getdeposit.cs_pm_dbcd+getdeposit.cs_pm_vouc+getdeposit.cs_pm_cashcd,".__")#',
                '#numberformat(getdeposit.cs_pm_cash+getdeposit.cs_pm_cheq+getdeposit.cs_pm_crcd+getdeposit.cs_pm_crc2+getdeposit.cs_pm_dbcd+getdeposit.cs_pm_vouc+getdeposit.cs_pm_cashcd,".__")#',
                '1','','',#getdeposit.wos_date#,'#HUserID#','')
			</cfquery>--->
            
            
            <cfquery name="insertpost3" datasource="#dts#">
				insert into glpost9
                (acc_code,accno,fperiod,date,reference,refno,desp,despa,creditamt,fcamt,exc_rate,rem4,rem5,bdate,userid,agent)			
				values('Dep','#getgsetup.depositaccount#','#getdeposit.fperiod#',#getdeposit.wos_date#,'#getdeposit.depositno#','#getdeposit.sono#',
				'Deposit','',
				'#numberformat(getdeposit.cs_pm_cash+getdeposit.cs_pm_cheq+getdeposit.cs_pm_crcd+getdeposit.cs_pm_crc2+getdeposit.cs_pm_dbcd+getdeposit.cs_pm_vouc,".__")#',
                '#numberformat(getdeposit.cs_pm_cash+getdeposit.cs_pm_cheq+getdeposit.cs_pm_crcd+getdeposit.cs_pm_crc2+getdeposit.cs_pm_dbcd+getdeposit.cs_pm_vouc,".__")#',
                '1',
                '','',#getdeposit.wos_date#,'#HUserID#','')
			</cfquery>
			
			<cfquery name="insertpost4" datasource="#dts#">
				insert into glpost91
                (acc_code,accno,fperiod,date,reference,refno,desp,despa,creditamt,fcamt,exc_rate,rem4,rem5,bdate,userid,agent)			
				values('Dep','#getgsetup.depositaccount#','#getdeposit.fperiod#',#getdeposit.wos_date#,'#getdeposit.depositno#','#getdeposit.sono#',
				'Deposit','',
				'#numberformat(getdeposit.cs_pm_cash+getdeposit.cs_pm_cheq+getdeposit.cs_pm_crcd+getdeposit.cs_pm_crc2+getdeposit.cs_pm_dbcd+getdeposit.cs_pm_vouc,".__")#',
                '-#numberformat(getdeposit.cs_pm_cash+getdeposit.cs_pm_cheq+getdeposit.cs_pm_crcd+getdeposit.cs_pm_crc2+getdeposit.cs_pm_dbcd+getdeposit.cs_pm_vouc,".__")#',
                '1','','',#getdeposit.wos_date#,'#HUserID#','')
			</cfquery>
            
            <cfquery name="update" datasource="#dts#">
				update deposit set posted='P' where depositno='#getdeposit.depositno#'
			</cfquery>

</cfloop>



<cfset status='Bill has been posted'>

<cfoutput>
	<form name="done" action="s_Deposittable.cfm?type=Deposit&process=done" method="post">
		<input name="status" value="#status#" type="hidden">
	</form>
</cfoutput>
<cfoutput>
<script>
	done.submit();
</script>
</cfoutput>