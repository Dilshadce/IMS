

<cfparam name = "form.special_account_code" default = "">
<cfparam name = "form.taxincl" default = "F">
<cfif (lcase(HcomID) eq "net_i" or lcase(hcomid) eq "netm_i") and tran eq "INV">
	<cfparam name = "form.contract" default = "F">
</cfif>
<cfparam name = "form.selecttax" default = "">
<cfparam name = "form.wpitemtax" default = "">

<cfset xtotaldisc1 = val(form.totaldisc1)>
<cfset xtotaldisc2 = val(form.totaldisc2)>
<cfset xtotaldisc3 = val(form.totaldisc3)>
<cfset xtotalamtdisc = val(form.totalamtdisc)>
<cfset xsubtotal = val(form.subtotal)>
<cfset xptax = val(form.pTax)>
<cfset xtotalamttax = val(form.totalamttax)>

<!---Rebate--->
<cfif isdefined('form.activaterebate')>
<cfif isdefined('form.rebateaftertax')>
<cfset xrebateaftertax='T'>
<cfset xrebateper=val(form.rebateaftertaxper)>
<cfset xrebateamt=val(form.rebateaftertaxamt)>
<cfelse>
<cfset xrebateaftertax='F'>
<cfset xrebateper=val(form.rebateafterdiscper)>
<cfset xrebateamt=val(form.rebateafterdiscamt)>
</cfif>
<cfelse>
<cfset xrebateaftertax='F'>
<cfset xrebateper=0>
<cfset xrebateamt=0>
</cfif>
<!--- --->

<cfif (xtotaldisc1 neq 0 or xtotaldisc2 neq 0 or xtotaldisc3 neq 0) and xtotalamtdisc neq 0>
	<cfset disc1_bil = xsubtotal * xtotaldisc1 / 100>
	<cfset disc1_bil = numberformat(disc1_bil,discformat)>
  	<cfset xnet_bil = xsubtotal - val(disc1_bil)>
	<cfset disc2_bil = xnet_bil * xtotaldisc2 / 100>
	<cfset disc2_bil = numberformat(disc2_bil,discformat)>
  	<cfset xnet_bil = xnet_bil - val(disc2_bil)>
	<cfset disc3_bil = xnet_bil * xtotaldisc3 / 100>
	<cfset disc3_bil = numberformat(disc3_bil,discformat)>
  	<cfset xnet_bil = xnet_bil - val(disc3_bil)>
	<cfset disc_bil = val(disc1_bil) + val(disc2_bil) + val(disc3_bil)>
<cfelseif (xtotaldisc1 eq 0 and xtotaldisc2 eq 0 and xtotaldisc3 eq 0) and xtotalamtdisc neq 0>	
  	<cfset disc1_bil = 0>
  	<cfset disc2_bil = 0>
  	<cfset disc3_bil = 0>
  	<cfset disc_bil = xtotalamtdisc>
  	<cfset xnet_bil = xsubtotal - disc_bil>
<cfelse>
  	<cfset disc1_bil = xsubtotal * xtotaldisc1 / 100>	
  	<cfset xnet_bil = xsubtotal - disc1_bil>
	<cfset disc2_bil = xnet_bil * xtotaldisc2 / 100>
  	<cfset xnet_bil = xnet_bil - disc2_bil>
	<cfset disc3_bil = xnet_bil * xtotaldisc3 / 100>
  	<cfset xnet_bil = xnet_bil - disc3_bil>
  	<cfset disc_bil = disc1_bil + disc2_bil + disc3_bil>
</cfif>

<!--- Add on 030708 --->
<cfset disc_bil = numberformat(disc_bil,discformat)>
	<cfset tax1_bil = xtotalamttax>		<!-- GET TAX AMOUNT FROM FORM --->
	<cfset tax_bil = tax1_bil>
<cfif form.taxincl eq "T">
	<cfset xgrand_bil = #form.viewgrand#>
<cfelse>
	<cfset xgrand_bil = #form.viewgrand#>
</cfif>

<cfquery name="getgeneral" datasource="#dts#">
	select printoption,voucher,voucherbal,voucherb4disc,crcdtype,voucherasdisc from gsetup;
</cfquery>
<!--- ADD ON 27-07-2009 --->
<cfif getgeneral.voucher eq "Y" and (tran eq "INV" or tran eq "DO" or tran eq "CN" or tran eq "SO" or tran eq "CS")>
<cfquery name="reversevoucher" datasource="#dts#">
SELECT Voucher,wos_date From artran where type='#tran#' and refno='#nexttranno#';
</cfquery>
<cfif reversevoucher.voucher neq "">
<cfquery name="updatevoucher" datasource="#dts#">
update voucher set used = "N",updated_by ="#HuserId#",updated_on = now() where voucherno = "#reversevoucher.voucher#"
</cfquery>
<cfif getgeneral.voucherbal eq "Y">
<cfquery name="updatevoucher" datasource="#dts#">
delete from vouchertran WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#nexttranno#"> and type = '#tran#'
</cfquery>
</cfif>
</cfif>
</cfif>

<cfif lcase(hcomid) eq "mhsl_i" and tran eq "RC">
	<cfset xpnbtTax=val(form.pnbtTax)>
    <cfset xnbttax=val(form.xnbttax)>
    
	<cfif val(form.pnbtTax) neq 0>
		<cfset taxnbt_bil=xgrand_bil*xpnbtTax / 100>
    <cfelse>
		<cfset taxnbt_bil=xnbttax>
	</cfif>
    
    <cfset xgrand_bil=xgrand_bil+taxnbt_bil>
    <cfset xtaxnbt=taxnbt_bil*currrate>
</cfif>

<cfset xgrand_bil = val(xgrand_bil)>
<cfset totalmisc = 0>
<cftry>
<cfset totalmisc = val(form.mc1_bil)+val(form.mc2_bil)+val(form.mc3_bil)+val(form.mc4_bil)+val(form.mc5_bil)+val(form.mc6_bil)+val(form.mc7_bil)>
<cfcatch type="any">
</cfcatch>
</cftry>
<cfif isdefined('form.textincludeitem')>
<cfset xsubtotal = xgrand_bil - xtotalamttax + val(disc_bil)-val(totalmisc)>
</cfif>
<cfset xinvgross = xsubtotal*currrate>
<cfset xdiscount1 = disc1_bil*currrate>
<cfset xdiscount2 = disc2_bil*currrate>
<cfset xdiscount3 = disc3_bil*currrate>
<cfset xdiscount = iif(((disc1_bil+disc2_bil+disc3_bil)*currrate) neq 0,((disc1_bil+disc2_bil+disc3_bil)*currrate),(disc_bil*currrate))>

<cfset xnet = xnet_bil*currrate>
<cfset xtax = tax1_bil*currrate>
<cfset xgrand = xgrand_bil*currrate>

<cfif currrate neq 1>
<cfset xnet = numberformat(xnet_bil,'.__')*currrate>
<cfset xtax = numberformat(tax1_bil,'.__')*currrate>
<cfset xgrand = numberformat(xgrand_bil,'.__')*currrate>
<cfif form.wpitemtax neq "Y" and form.taxincl neq "T" and val(totalmisc) eq 0>
<cfset xtax = abs(numberformat(val(xgrand)+0.000000001,'.__')-numberformat(val(xnet)+0.000000001,'.__'))>
<cfelseif form.wpitemtax neq "Y" and val(totalmisc) eq 0><!--- added 20130514--->
<cfset xtax = abs(numberformat(val(xgrand)+0.000000001,'.__')-numberformat(val(xinvgross)+0.000000001,'.__')-numberformat(val(xdiscount)+0.000000001,'.__'))>
</cfif>
</cfif>

<cfset xgrand = val(xgrand)>
      
<cfquery datasource="#dts#" name="updateartran">
  	Update artran set 
  	gross_bil='#xsubtotal#', 
  	disc1_bil='#disc1_bil#', 
  	disc2_bil='#disc2_bil#', 
  	disc3_bil='#disc3_bil#', 
  	disc_bil='#disc_bil#', 
  	tax1_bil='#tax1_bil#',
  	tax_bil='#tax_bil#',
  	net_bil='#xnet_bil#', 
  	grand_bil='#xgrand_bil#', 
  	invgross='#xinvgross#',
  	disp1='#xtotaldisc1#', 
  	disp2='#xtotaldisc2#', 
  	disp3='#xtotaldisc3#', 
  	discount1='#xdiscount1#', 
  	discount2='#xdiscount2#', 
  	discount3='#xdiscount3#', 
  	discount='#xdiscount#',
  	taxp1='#xptax#', 
  	tax='#xtax#',
  	net='#xnet#',
    <cfif isdefined('form.roundadj')>
    roundadj='#form.roundadj#',
    </cfif>
   <cfif getgeneral.voucher eq "Y" and (tran eq "INV" or tran eq "DO" or tran eq "CN" or tran eq "SO" or tran eq "CS")>
    voucher=<cfif form.gift_voucher neq 0>'#form.vouchernum#'<cfelseif getgeneral.voucherasdisc eq 'Y'>'#form.vouchernum#'<cfelse>''</cfif>,
    </cfif> 
  	grand='#xgrand#',
	<cfswitch expression="#tran#">
		<cfcase value="RC,CN,OAI" delimiters=",">
			creditamt='#xgrand#',
		</cfcase>
		<cfdefaultcase>
			debitamt='#xgrand#',
		</cfdefaultcase>
	</cfswitch>
  	note = '#form.selecttax#',
    <cfif tran eq "RQ">
    <cfif isdefined('form.RQselecttax')>RQnote = '#form.RQselecttax#',</cfif>
    RQtaxp1 = '#val(form.RQpTax)#',
    </cfif>
	mc1_bil = '#form.mc1_bil#',
	mc2_bil = '#form.mc2_bil#',
	mc3_bil = '#form.mc3_bil#',
	mc4_bil = '#form.mc4_bil#',
	mc5_bil = '#form.mc5_bil#',
	mc6_bil = '#form.mc6_bil#',
	mc7_bil = '#form.mc7_bil#',
	m_charge1 = '#form.mc1_bil * currrate#',
	m_charge2 = '#form.mc2_bil * currrate#',
	m_charge3 = '#form.mc3_bil * currrate#',
	m_charge4 = '#form.mc4_bil * currrate#',
	m_charge5 = '#form.mc5_bil * currrate#',
	m_charge6 = '#form.mc6_bil * currrate#',
	m_charge7 = '#form.mc7_bil * currrate#',
    footercurrcode='#form.footercurrcode#',
    footercurrrate='#form.footercurrrate#',
	<!--- tax already included --->
	taxincl='#form.taxincl#'
	<!--- tax already included --->
	<!--- ADD ON 27-07-2009 --->
	<cfif lcase(hcomid) eq "mhsl_i" and tran eq "RC">
		,TAXNBTP='#val(xpnbtTax)#'
        ,TAXNBT_BIL='#val(taxnbt_bil)#'
        ,TAXNBT='#val(xtaxnbt)#'
	</cfif>
    <cfif (lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjctrial_i")>
    ,rem6 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.paymentrefno#" >
    </cfif>
    <cfif isdefined('form.checkno')>
    	,checkno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.checkno#" >
	</cfif>
    <cfif lcase(HcomID) eq "accord_i" and tran eq "INV">
    
    <cfif isdefined('form.paymentrefno')>
    	,refno2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.paymentrefno#" >
	</cfif>
    </cfif>
    <cfif (lcase(hcomid) eq "polypet_i") and (tran eq 'CS')>
    	,checkno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.checkno#" >
        ,cs_pm_cashCD = '#val(cashCD)#'
    </cfif>
    	,termscondition = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.termscondition#" >
        <cfif hcomid eq "clickworkz_i" or hcomid eq "zinnia_i">
        ,picktermscondition = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.picktermscondition#">
		</cfif>
        
        ,rebateaftertax = <cfqueryparam cfsqltype="cf_sql_varchar" value="#xrebateaftertax#" >
        ,rebateper = "#val(xrebateper)#"
        ,rebateamt = "#val(xrebateamt)#"
        <cfif lcase(hcomid) eq "netsource_i">
            ,printstatus=''
            </cfif>
        <cfif lcase(hcomid) eq "guankeat_i" and (tran eq "CS" or tran eq "INV")>
        ,rem49=""
        </cfif>
       
	where type='#tran#' and refno='#nexttranno#';
</cfquery>

<cfif left(hcomid,7) eq "megamax" and tran eq "INV">
<cfset commtype = tran>
<cfset commrefno = nexttranno>
<cfset commsubtotal = xnet>
<cfinclude template="calcomm.cfm">
</cfif>

<!--- fixics by chonghow --->
<cfif dts eq 'fixics_i' and tran eq "INV">
<cfquery datasource="#dts#" name="getFixicsCust">
		select * from artran
		where type='#tran#' and refno='#nexttranno#'
	</cfquery>
	
  			<cfquery name="getFixicsIctran" datasource="#dts#">
            SELECT sum(i.qty2*ic.qty) as length from ictran  ic
            LEFT JOIN icitem i on i.itemno = ic.itemno
            where type='#tran#' and refno='#nexttranno#'
            </cfquery>
            
           <cftry>
           <cfquery name="UPdateCustUnit" datasource="#dts#">
           UPDATE arcust set unit = unit + '#val(getFixicsIctran.length)#'
            WHERE custno = '#getFixicsCust.custno#'
           </cfquery>
            <cfcatch type="any">
            
            </cfcatch>
            </cftry>
 
            
            </cfif>
<!--- fixics by chonghow --->

<cfif form.wpitemtax neq "Y" and val(xinvgross) neq 0>

	<cfif form.taxincl eq "T">
    <cfquery name="updateictrantax" datasource="#dts#">
    	UPDATE ictran 
        set note_a='#form.selecttax#',
        TAXPEC1='#xptax#',
        TAXAMT_BIL=round((AMT_BIL/#val(xnet_bil)+val(disc_bil)#)*#val(tax1_bil)#,5),
        TAXAMT=round((AMT/#val(xnet)+val(xdiscount)#)*#val(xtax)#,5)
        where type='#tran#' and refno='#nexttranno#';
    </cfquery>
    <cfelse>
	<cfquery name="updateictrantax" datasource="#dts#">
    	UPDATE ictran 
        set note_a='#form.selecttax#',
        TAXPEC1='#xptax#',
        TAXAMT_BIL=round((AMT_BIL/#val(xsubtotal)#)*#val(tax1_bil)#,5),
        TAXAMT=round((AMT/#val(xinvgross)#)*#val(xtax)#,5)
        where type='#tran#' and refno='#nexttranno#';
    </cfquery>
    </cfif>
<cfelseif  form.wpitemtax neq "Y" and val(xinvgross) eq 0>
<cfquery name="updateictrantax" datasource="#dts#">
    	UPDATE ictran 
        set note_a='#form.selecttax#',
        TAXPEC1='#xptax#',
        TAXAMT_BIL=0,
        TAXAMT=0
        where type='#tran#' and refno='#nexttranno#';
    </cfquery>
    
</cfif>

<!--- Add on 250808 --->
<cfif tran NEQ "SAM" and mode eq "Edit">
	<cfquery datasource="#dts#" name="getartran">
		select * from artran
		where type='#tran#' and refno='#nexttranno#'
	</cfquery>
	
	<cfif (lcase(HcomID) eq "net_i" or lcase(hcomid) eq "netm_i") and tran eq "INV" and form.contract eq "T" and getartran.rem10 eq "">
		<cfset date1=dateformat(getartran.wos_date,"dd/mm/yyyy")>
		<cfset date2=dateformat(DateAdd("d", 364, getartran.wos_date),"dd/mm/yyyy")>
		
		<cfquery name="update" datasource="#dts#">
			update artran
			set rem10='#date1#',
			rem11='#date2#'
			where type='#tran#' and refno='#nexttranno#'
		</cfquery>
	</cfif>
	
	<cfquery datasource="#dts#" name="insert">
		insert into artranat 
		(TYPE,REFNO,CUSTNO,FPERIOD,WOS_DATE,DESP,DESPA,
		<cfswitch expression="#tran#">
			<cfcase value="RC,CN,OAI" delimiters=",">
				CREDITAMT
			</cfcase>
			<cfdefaultcase>
				DEBITAMT
			</cfdefaultcase>
		</cfswitch>,
		TRDATETIME,USERID,CREATED_BY,UPDATED_BY,CREATED_ON,UPDATED_ON)
		values
		('#tran#','#nexttranno#','#getartran.custno#','#getartran.fperiod#',#getartran.wos_date#,'#getartran.desp#','#getartran.despa#',
		<cfswitch expression="#tran#">
			<cfcase value="RC,CN,OAI" delimiters=",">
				'#xgrand#'
			</cfcase>
			<cfdefaultcase>
				'#xgrand#'
			</cfdefaultcase>
		</cfswitch>,
		<cfif getartran.trdatetime neq "">#createdatetime(year(getartran.trdatetime),month(getartran.trdatetime),day(getartran.trdatetime),hour(getartran.trdatetime),minute(getartran.trdatetime),second(getartran.trdatetime))#<cfelse>'0000-00-00 00:00'</cfif>,'#getartran.userid#','#getartran.created_by#','#getartran.updated_by#',
		<cfif getartran.created_on neq "">#createdatetime(year(getartran.created_on),month(getartran.created_on),day(getartran.created_on),hour(getartran.created_on),minute(getartran.created_on),second(getartran.created_on))#<cfelse>'0000-00-00 00:00'</cfif>,
		#createdatetime(year(getartran.updated_on),month(getartran.updated_on),day(getartran.updated_on),hour(getartran.updated_on),minute(getartran.updated_on),second(getartran.updated_on))#)
	</cfquery>
</cfif>

<!--- UPDATE ICITEM AND ICL3P2 --->
<cfif tran eq "RC">
	<cfinclude template = "transaction3b_update_unit_cost_process.cfm">
</cfif>
