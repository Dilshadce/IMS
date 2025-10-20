
<cfquery name="getgsetup" datasource="#dts#">
	select * from gsetup
</cfquery>

<cfquery name="getgsetup2" datasource='#dts#'>
  Select * from gsetup2
</cfquery>

<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
<cfset stDecl_UPrice = ",.">

<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
  <cfset stDecl_UPrice = stDecl_UPrice & "_">
</cfloop>

<cfset variables.newUUID=createUUID()>
<cfset dts2=replace(dts,'_i','_a','all')>

<cfquery name="getDOfromglpost" datasource="#dts2#">
	select reference from glpost where acc_code="DO" and fperiod<>"99"
</cfquery>

<cfset refnolist=valuelist(getDOfromglpost.reference)>

<cfset duedate=dateadd('yyyy',5,now())>

<cfquery name="getalloverdueDO" datasource="#dts#">
	select * from artran where wos_date < #duedate# and fperiod<>"99" 
    and type="DO"
    and (void="" or void is null) 
    and (toinv="" or toinv is null)
    and refno not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#refnolist#">)
</cfquery>

<cfoutput>
<cfloop query="getalloverdueDO">

<cfquery name="getbatch" datasource="#dts2#">
	select recno as batchno 
	from glbatch 
	where (lokstatus='1' or lokstatus = '' or lokstatus is null)
	and (delstatus='' or delstatus is null) 
	and (poststatus='' or poststatus is null) 
	and (locktran='' or locktran is null)
    and fperiod='#getalloverdueDO.fperiod#'
    and desp like "%sale%"
    order by recno;
</cfquery>


<cfquery name="gettargettaxaccno" datasource="#dts#">
	select corr_accno from #target_taxtable# where code="#getalloverdueDO.note#" and corr_accno<>"" and corr_accno<>"0000/000"
</cfquery>

<cfset xaccno=getgsetup.gstsales>

<cfif gettargettaxaccno.recordcount neq 0>
<cfset xaccno=gettargettaxaccno.corr_accno>
</cfif>
        	<cfquery name="insert" datasource="#dts2#">
						insert into glpost 
						(acc_code,accno,fperiod,date,batchno,tranno,
						ttype,reference,refno,desp,despa,despb,despc,despd,despe,taxpec,
						debitamt,creditamt,fcamt,debit_fc,credit_fc,exc_rate,araptype,
						source,job,job2,subjob,job_value,job2_value,
						rem1,rem2,rem3,rem4,rem5,agent,taxpur,
						trdatetime,userid,
						bperiod,created_by,created_on,uuid,permitno
						)
						values
						('#getalloverdueDO.type#','#trim(xaccno)#','#getalloverdueDO.fperiod#',
						#getalloverdueDO.wos_date#,'#getbatch.batchno#','#getalloverdueDO.trancode#',
						'RD',
						'#getalloverdueDO.refno#','#getalloverdueDO.refno2#','#getalloverdueDO.desp#','#getalloverdueDO.despa#',
						'','','',
						'','#getalloverdueDO.tax#','0',
						'#getalloverdueDO.tax#','#getalloverdueDO.tax_bil#','0',
						'#getalloverdueDO.tax_bil#','#getalloverdueDO.currrate#','I',
						'#getalloverdueDO.source#','#getalloverdueDO.job#','',
						'','0','0',
						'#getalloverdueDO.rem1#',
						'#getalloverdueDO.rem2#','#getalloverdueDO.rem3#','#getalloverdueDO.rem4#',
						'0','#getalloverdueDO.agenno#',
						'#getalloverdueDO.taxp1#',
						#now()#,
						'#getalloverdueDO.userid#',
						'#getalloverdueDO.fperiod#',
						'#getalloverdueDO.userid#',#now()#,'#variables.newUUID#','#getalloverdueDO.permitno#')
			</cfquery>
            
            <cfquery datasource="#dts2#" name="getentry">
							SELECT entry 
							FROM glpost where uuid='#variables.newUUID#' 
							and accno = '#xaccno#' 
							and reference='#getalloverdueDO.refno#'
			</cfquery>
            
            <cfquery name="insert" datasource="#dts2#">
							insert into arpost 
							(
								entry,accno,date,araptype,reference,refno,
								debitamt,creditamt,
								desp,despa,despb,despc,despd,
								fcamt,debit_lc,credit_lc,exc_rate,
								posted,
								rem1,rem2,rem4,
								source,job,agent,
								fperiod,
								batchno,tranno,lastbal,created_by,created_on,
								refext,paidamt,paystatus,fullpay
							)
							values
							('#getentry.entry#','#trim(xaccno)#',#getalloverdueDO.wos_date#,'I',
							'#getalloverdueDO.refno#','#getalloverdueDO.refno2#','0',
							'#getalloverdueDO.tax#',
							'#getalloverdueDO.desp#','#getalloverdueDO.despa#',
							'','','',
							'#getalloverdueDO.tax_bil#','0','#getalloverdueDO.tax_bil#',
							'#getalloverdueDO.currrate#','P',
							'#getalloverdueDO.rem1#','#getalloverdueDO.rem2#','#getalloverdueDO.rem4#',
							'#getalloverdueDO.source#','#getalloverdueDO.job#','#getalloverdueDO.agenno#',
							'#getalloverdueDO.fperiod#',
							'#getbatch.batchno#','#getalloverdueDO.trancode#','#getalloverdueDO.tax#',
							'#getalloverdueDO.userid#',#now()#,
							'','0.00','','F')
			</cfquery>
                    
                    


</cfloop>

</cfoutput>