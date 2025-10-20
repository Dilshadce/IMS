<cfinclude template="/object/dateobject.cfm">
<html>
<head>
<title>Overdue Delivery Order(Over 21 Days Not Updated)</title>
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
<style type="text/css" media="print">
	.noprint { display: none; }
</style>
</head>


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

<cfif Hlinkams neq "Y">

<script type="application/javascript">
window.close();
</script>
<cfabort>
</cfif>

<cfset variables.newUUID=createUUID()>
<cfset dts2=replace(dts,'_i','_a','all')>

<cfquery name="getDOfromglpost" datasource="#dts2#">
	select reference from glpost where acc_code="DO" and fperiod<>"99"
</cfquery>

<cfset refnolist=valuelist(getDOfromglpost.reference)>

<cfset duedate=dateadd('d',-21,now())>


<cfquery name="gettran" datasource="#dts#">
	select * from artran where wos_date < #duedate# and fperiod<>"99" 
    and type="DO"
    and (void="" or void is null) 
    and (toinv="" or toinv is null)
</cfquery>


<cfquery name="getalloverdueDO" datasource="#dts#">
	select * from artran where wos_date < #duedate# and fperiod<>"99" 
    and type="DO"
    and (void="" or void is null) 
    and (toinv="" or toinv is null)
    and refno not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#refnolist#">) and note="SR"
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

	<cfquery datasource="#dts2#" name="getglbatchlast">
        SELECT count(batchno) AS lasttran FROM glpost WHERE batchno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbatch.batchno#"> AND fperiod <> '99' GROUP BY batchno
    </cfquery>
    <cfset tranno = 1>
    <cfif getglbatchlast.recordcount neq 0>
        <cfset tranno = val(getglbatchlast.lasttran)>
    </cfif>   


<cfquery name="gettargettaxaccno" datasource="#dts#">
	select corr_accno from #target_taxtable# where code="#getalloverdueDO.note#" and corr_accno<>"" and corr_accno<>"0000/000"
</cfquery>

<cfset xaccno=getgsetup.gstsales>

<cfif gettargettaxaccno.recordcount neq 0>
<cfset xaccno=gettargettaxaccno.corr_accno>
</cfif>

<cfif getbatch.batchno eq "">
<h2>Please Create Batch For this Period In AMS.</h2>
<cfabort>
</cfif>

<cftry>
<cfif xaccno neq "0000/000" and xaccno neq "">

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
						#getalloverdueDO.wos_date#,'#getbatch.batchno#','#val(tranno)+1#',
						'RD',
						'#getalloverdueDO.refno#','#getalloverdueDO.refno2#','#getalloverdueDO.desp#','#getalloverdueDO.despa#',
						'','','',
						'','#val(getalloverdueDO.tax)#','0',
						'#getalloverdueDO.tax#','#getalloverdueDO.tax_bil#','0',
						'#getalloverdueDO.tax_bil#','#getalloverdueDO.currrate#','I',
						'#getalloverdueDO.source#','#getalloverdueDO.job#','',
						'','0','0',
						'',
						'','','',
						'0','#getalloverdueDO.agenno#',
						'#getalloverdueDO.taxp1#',
						#now()#,
						'#getalloverdueDO.userid#',
						'#getalloverdueDO.fperiod#',
						'#getalloverdueDO.userid#',#now()#,'#variables.newUUID#','#getalloverdueDO.permitno#')
			</cfquery>
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
						('#getalloverdueDO.type#','#trim(getalloverdueDO.custno)#','#getalloverdueDO.fperiod#',
						#getalloverdueDO.wos_date#,'#getbatch.batchno#','#val(tranno)+2#',
						'RD',
						'#getalloverdueDO.refno#','#getalloverdueDO.refno2#','#getalloverdueDO.desp#','#getalloverdueDO.despa#',
						'','','',
						'','#val(getalloverdueDO.tax)#','#getalloverdueDO.tax#',
						'0','#getalloverdueDO.tax_bil#','#getalloverdueDO.tax_bil#',
						'0','#getalloverdueDO.currrate#','I',
						'#getalloverdueDO.source#','#getalloverdueDO.job#','',
						'','0','0',
						'',
						'','','',
						'0','#getalloverdueDO.agenno#',
						'#getalloverdueDO.taxp1#',
						#now()#,
						'#getalloverdueDO.userid#',
						'#getalloverdueDO.fperiod#',
						'#getalloverdueDO.userid#',#now()#,'#variables.newUUID#','#getalloverdueDO.permitno#')
			</cfquery>
            
            
           
            
            <cfquery datasource="#dts2#" name="getentry2">
							SELECT entry 
							FROM glpost where uuid='#variables.newUUID#' 
							and accno = '#getalloverdueDO.custno#' 
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
							('#getentry2.entry#','#trim(getalloverdueDO.custno)#',#getalloverdueDO.wos_date#,'I',
							'#getalloverdueDO.refno#','#getalloverdueDO.refno2#','#getalloverdueDO.tax#',
							'0',
							'#getalloverdueDO.desp#','#getalloverdueDO.despa#',
							'','','',
							'#getalloverdueDO.tax_bil#','#getalloverdueDO.tax#','0',
							'#getalloverdueDO.currrate#','P',
							'','','',
							'#getalloverdueDO.source#','#getalloverdueDO.job#','#getalloverdueDO.agenno#',
							'#getalloverdueDO.fperiod#',
							'#getbatch.batchno#','#val(tranno)+2#','#getalloverdueDO.tax#',
							'#getalloverdueDO.userid#',#now()#,
							'','0.00','','F')
			</cfquery>
</cfif>     
                    
<cfcatch></cfcatch></cftry>

</cfloop>

</cfoutput>

<cfset totalnet= 0>
<cfset totaltax = 0>
<cfset totalgrand = 0>

<body>
<cfoutput>
<table width="100%" border="0" cellspacing="0" cellpadding="2" class="data">
	<tr>
		<td colspan="100%"><div align="center"><font size="3" face="Times New Roman,Times,serif"><strong>Overdue Delivery Order(Over 21 Days Not Updated)</strong></font></div></td>
	</tr>
    <!---<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
        <tr> 
          	<td colspan="100%"><div align="center"><font size="2" face="Times New Roman,Times,serif">CUST: #form.custfrom# - #form.custto#</font></div></td>
        </tr>
    </cfif>--->
    <tr> 
      	<td colspan="4"><font size="2" face="Times New Roman,Times,serif">#getgsetup.compro#</font></td>
      	<td colspan="8"><div align="right"><font size="2" face="Times New Roman,Times,serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
    </tr>
    <tr> 
      	<td colspan="100%"><hr></td>
    </tr>
    <tr>
	  	<td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>Ref No</strong></font></div></td>
      	<td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>Date</strong></font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>Period</strong></font></div></td>
		
      	<td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>Customer</strong></font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman,Times,serif"><strong>Net Amount</strong></font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman,Times,serif"><strong>Tax Amount</strong></font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman,Times,serif"><strong>Grand Amount</strong></font></div></td>
    </tr>
    <tr> 
      	<td colspan="100%"><hr></td>
    </tr>
	
	<cfloop query="gettran">
	
    <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
    <td><div align="left"><font  face="Times New Roman,Times,serif">#gettran.refno#</font></div></td>
    <td><div align="left"><font  face="Times New Roman,Times,serif">#dateformat(gettran.wos_date,'DD/MM/YYYY')#</font></div></td>
    <td><div align="left"><font  face="Times New Roman,Times,serif">#gettran.fperiod#</font></div></td>
    <td><div align="left"><font  face="Times New Roman,Times,serif">#gettran.custno# #gettran.name#</font></div></td>
    <td><div align="right"><font  face="Times New Roman,Times,serif">#numberformat(gettran.net,'_.__')#</font></div></td>
    <td><div align="right"><font  face="Times New Roman,Times,serif">#numberformat(gettran.tax,'_.__')#</font></div></td>
    <td><div align="right"><font  face="Times New Roman,Times,serif">#numberformat(gettran.grand,'_.__')#</font></div></td>
    </tr>
    <cfset totalnet= totalnet+gettran.net>
	<cfset totaltax = totaltax+gettran.tax>
    <cfset totalgrand = totalgrand+gettran.grand>
		<tr><td><br></td></tr>
	</cfloop>
	<tr> 
		<td colspan="100%"><hr></td>
	</tr>
    <tr>
    <td><div align="left"><font  face="Times New Roman,Times,serif"></font></div></td>
    <td><div align="left"><font  face="Times New Roman,Times,serif"></font></div></td>
    <td><div align="left"><font  face="Times New Roman,Times,serif"></font></div></td>
    <td><div align="left"><font  face="Times New Roman,Times,serif"></font></div></td>
    <td><div align="right"><font  face="Times New Roman,Times,serif">#numberformat(totalnet,'_.__')#</font></div></td>
    <td><div align="right"><font  face="Times New Roman,Times,serif">#numberformat(totaltax,'_.__')#</font></div></td>
    <td><div align="right"><font  face="Times New Roman,Times,serif">#numberformat(totalgrand,'_.__')#</font></div></td>
    </tr>
	<tr><td colspan="100%"><br></td></tr> 
<tr><td colspan="100%"><hr></td></tr>    
    
    <cfquery name="getvalidatesupp" datasource="#dts#">
	select * from #target_apvend#
	</cfquery>
    <tr>
		<td colspan="100%"><div align="center"><font size="3" face="Times New Roman,Times,serif"><strong>Supplier that require validation</strong></font></div></td>
	</tr>
    <tr> 
      	<td colspan="100%"><hr></td>
    </tr>
    <tr>
	  	<td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>Supplier No</strong></font></div></td>
      	<td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>Name</strong></font></div></td>
        <td><div align="center"><font size="2" face="Times New Roman,Times,serif"><strong>Activation Date</strong></font></div></td>
		
      	<td><div align="center"><font size="2" face="Times New Roman,Times,serif"><strong>Validate Period</strong></font></div></td>
		<td><div align="center"><font size="2" face="Times New Roman,Times,serif"><strong>Validate Date</strong></font></div></td>
    </tr>
    <tr> 
      	<td colspan="100%"><hr></td>
    </tr>
	
	<cfloop query="getvalidatesupp">
    <cfif getvalidatesupp.gst_act_date eq "" or getvalidatesupp.gst_act_date eq "0000-00-00">
    <cfset getvalidatesupp.gst_act_date="2013-12-31">
    <cfelse>
    </cfif>
    <cfif val(getvalidatesupp.gst_valid_period) eq 0>
    <cfset getvalidatesupp.gst_valid_period=999>
    </cfif>
    
	<cfif dateformat(dateadd('m',val(getvalidatesupp.gst_valid_period),getvalidatesupp.gst_act_date),'yyyy-mm-dd') lte dateformat(now(),'yyyy-mm-dd')>
    <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
    <td><div align="left"><font  face="Times New Roman,Times,serif">#getvalidatesupp.custno#</font></div></td>
    <td><div align="left"><font  face="Times New Roman,Times,serif">#getvalidatesupp.name#</font></div></td>
    <td><div align="center"><font  face="Times New Roman,Times,serif">#dateformat(getvalidatesupp.gst_act_date,'DD/MM/YYYY')#</font></div></td>
    <td><div align="center"><font  face="Times New Roman,Times,serif">#getvalidatesupp.gst_valid_period#</font></div></td>
	<td><div align="center"><font  face="Times New Roman,Times,serif">#dateformat(dateadd('m',val(getvalidatesupp.gst_valid_period),getvalidatesupp.gst_act_date),'dd/mm/yyyy')#</font></div></td>
    </tr>
    </cfif>
	</cfloop>
    <tr><td><br></td></tr>
    
</table>

</cfoutput>


<br><br>




<div align="right">
	<font  face="Arial,Helvetica,sans-serif">
		<a href="javascript:print()" class="noprint"><u>Print</u></a>
	</font>
</div>


</body>
</html>